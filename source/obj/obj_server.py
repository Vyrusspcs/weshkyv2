from flask import Flask, request, jsonify
from functools import wraps
from collections import deque
from time import time
import math
import gc
import traceback
import numpy as np

app = Flask(__name__)

# ==================== CONFIG ====================
API_KEY = "i-know-the-key-is-visible-please-be-kind"
MAX_REQUEST_SIZE = 50 * 1024 * 1024  # 50MB (reduced for 1GB RAM)
MAX_GRID_CELLS = 4_000_000  # reduced for 1GB RAM
MAX_OUTPUT_BLOCKS = 250_000
MAX_TRIANGLES = 500_000  # reject models that are too complex for this server
MAX_VOXELS_BEFORE_MESH = 2_000_000  # abort if too many voxels generated
RATE_LIMIT = 10  # per minute per IP

_rate_history = {}
_processing = False  # prevent concurrent voxelizations on low-RAM server


def get_client_ip():
    if request.environ.get("HTTP_X_FORWARDED_FOR"):
        return request.environ["HTTP_X_FORWARDED_FOR"].split(",")[0].strip()
    return request.remote_addr


def require_api_key(f):
    @wraps(f)
    def wrapper(*args, **kwargs):
        key = request.headers.get("X-API-Key") or request.args.get("api_key")
        if not key:
            body = request.get_json(silent=True)
            if isinstance(body, dict):
                key = body.get("api_key")
        if key != API_KEY:
            return jsonify({"error": "Unauthorized"}), 401
        return f(*args, **kwargs)
    return wrapper


@app.before_request
def rate_limit_check():
    global _rate_history
    ip = get_client_ip()
    now = time()
    history = _rate_history.get(ip, [])
    history = [t for t in history if t > now - 60]
    if len(history) >= RATE_LIMIT:
        return jsonify({"error": "Rate limit exceeded", "retry_after": 60}), 429
    history.append(now)
    _rate_history[ip] = history
    # Periodically clean up stale IPs to prevent unbounded memory growth
    if len(_rate_history) > 100:
        stale_ips = [k for k, v in _rate_history.items() if not v or v[-1] < now - 120]
        for k in stale_ips:
            del _rate_history[k]
    if request.content_length and request.content_length > MAX_REQUEST_SIZE:
        return jsonify({"error": "Request too large"}), 413


# ==================== OBJ PARSER ====================

def parse_obj(content, scale=1.0):
    """Parse OBJ file, return numpy arrays of vertices and face indices."""
    vertices = []
    faces = []
    for line in content.split("\n"):
        line = line.strip()
        if not line or line[0] == "#":
            continue
        parts = line.split()
        if not parts:
            continue
        if parts[0] == "v" and len(parts) >= 4:
            try:
                x = float(parts[1]) * scale
                y = float(parts[2]) * scale
                z = float(parts[3]) * scale
                # Reject NaN/Inf vertices
                if math.isfinite(x) and math.isfinite(y) and math.isfinite(z):
                    vertices.append((x, y, z))
            except ValueError:
                continue
        elif parts[0] == "f":
            idxs = []
            for p in parts[1:]:
                try:
                    vid = int(p.split("/")[0])
                    vid = vid - 1 if vid > 0 else len(vertices) + vid
                    if 0 <= vid < len(vertices):
                        idxs.append(vid)
                except (ValueError, IndexError):
                    continue
            # Triangulate fans
            for i in range(1, len(idxs) - 1):
                faces.append((idxs[0], idxs[i], idxs[i + 1]))

    verts = np.array(vertices, dtype=np.float64) if vertices else np.zeros((0, 3))
    tris = np.array(faces, dtype=np.int32) if faces else np.zeros((0, 3), dtype=np.int32)
    return verts, tris


# ==================== TRIANGLE-BOX INTERSECTION ====================
# Separating Axis Theorem (SAT) based test
# This is THE correct way to voxelize — no gaps, no missed thin features.

def _cross(a, b):
    return np.array([
        a[1]*b[2] - a[2]*b[1],
        a[2]*b[0] - a[0]*b[2],
        a[0]*b[1] - a[1]*b[0],
    ])


def _project_triangle(axis, v0, v1, v2):
    p0 = np.dot(axis, v0)
    p1 = np.dot(axis, v1)
    p2 = np.dot(axis, v2)
    return min(p0, p1, p2), max(p0, p1, p2)


def _project_box(axis, half):
    """Project box centered at origin with half-extents onto axis."""
    r = abs(axis[0]) * half[0] + abs(axis[1]) * half[1] + abs(axis[2]) * half[2]
    return -r, r


def triangle_box_intersect(box_center, box_half, v0, v1, v2):
    """SAT test: does triangle (v0,v1,v2) intersect axis-aligned box?"""
    # Translate triangle so box is at origin
    t0 = v0 - box_center
    t1 = v1 - box_center
    t2 = v2 - box_center

    # Edges of triangle
    e0 = t1 - t0
    e1 = t2 - t1
    e2 = t0 - t2

    h = box_half

    # Test 9 cross-product axes (3 edges x 3 box normals)
    box_normals = [np.array([1,0,0]), np.array([0,1,0]), np.array([0,0,1])]
    for edge in (e0, e1, e2):
        for bn in box_normals:
            axis = _cross(edge, bn)
            alen = np.dot(axis, axis)
            if alen < 1e-12:
                continue
            tmin, tmax = _project_triangle(axis, t0, t1, t2)
            bmin, bmax = _project_box(axis, h)
            if tmin > bmax or tmax < bmin:
                return False

    # Test 3 box face normals
    for i in range(3):
        coords = [t0[i], t1[i], t2[i]]
        if min(coords) > h[i] or max(coords) < -h[i]:
            return False

    # Test triangle normal
    normal = _cross(e0, e1)
    nlen = np.dot(normal, normal)
    if nlen > 1e-12:
        tmin, tmax = _project_triangle(normal, t0, t1, t2)
        bmin, bmax = _project_box(normal, h)
        if tmin > bmax or tmax < bmin:
            return False

    return True


# ==================== VOXELIZER ====================

def voxelize_triangles(verts, tris, voxel_size):
    """
    Voxelize mesh surface using proper triangle-box intersection.
    Returns set of (gx, gy, gz) grid coordinates.
    """
    inv_vs = 1.0 / voxel_size
    half = np.array([voxel_size / 2.0] * 3)
    filled = set()

    for tri_idx in range(len(tris)):
        i0, i1, i2 = tris[tri_idx]
        v0, v1, v2 = verts[i0], verts[i1], verts[i2]

        # Bounding box of triangle in grid space
        tri_min = np.minimum(np.minimum(v0, v1), v2)
        tri_max = np.maximum(np.maximum(v0, v1), v2)

        gx_min = int(math.floor(tri_min[0] * inv_vs)) - 1
        gy_min = int(math.floor(tri_min[1] * inv_vs)) - 1
        gz_min = int(math.floor(tri_min[2] * inv_vs)) - 1
        gx_max = int(math.floor(tri_max[0] * inv_vs)) + 1
        gy_max = int(math.floor(tri_max[1] * inv_vs)) + 1
        gz_max = int(math.floor(tri_max[2] * inv_vs)) + 1

        for gx in range(gx_min, gx_max + 1):
            for gy in range(gy_min, gy_max + 1):
                for gz in range(gz_min, gz_max + 1):
                    center = np.array([
                        (gx + 0.5) * voxel_size,
                        (gy + 0.5) * voxel_size,
                        (gz + 0.5) * voxel_size,
                    ])
                    if triangle_box_intersect(center, half, v0, v1, v2):
                        filled.add((gx, gy, gz))

        # Safety: abort if too many voxels (prevents OOM on low-RAM server)
        if len(filled) > MAX_VOXELS_BEFORE_MESH:
            print(f"WARNING: Voxel count exceeded {MAX_VOXELS_BEFORE_MESH} at triangle {tri_idx}/{len(tris)}, stopping early")
            break

    return filled


def voxelize_triangles_with_normals(verts, tris, voxel_size):
    """
    Voxelize mesh surface AND compute per-voxel normals from actual triangle geometry.
    Each voxel gets the averaged normal of all triangles that intersect it.
    Returns (filled_set, normals_dict) where normals_dict maps (gx,gy,gz) -> [nx,ny,nz].
    """
    inv_vs = 1.0 / voxel_size
    half = np.array([voxel_size / 2.0] * 3)
    # Map each voxel to a list of triangle normals that contributed to it
    voxel_normal_accum = {}
    overflow = False

    for tri_idx in range(len(tris)):
        i0, i1, i2 = tris[tri_idx]
        v0, v1, v2 = verts[i0], verts[i1], verts[i2]

        # Compute triangle face normal
        edge0 = v1 - v0
        edge1 = v2 - v0
        tri_normal = np.cross(edge0, edge1)
        tri_normal_len = np.linalg.norm(tri_normal)
        if tri_normal_len < 1e-10:
            continue  # degenerate triangle
        tri_normal = tri_normal / tri_normal_len

        # Also compute triangle area for area-weighted normals
        # (larger triangles contribute more to the voxel's normal)
        tri_area = tri_normal_len * 0.5

        # Bounding box of triangle in grid space
        tri_min = np.minimum(np.minimum(v0, v1), v2)
        tri_max = np.maximum(np.maximum(v0, v1), v2)

        gx_min = int(math.floor(tri_min[0] * inv_vs)) - 1
        gy_min = int(math.floor(tri_min[1] * inv_vs)) - 1
        gz_min = int(math.floor(tri_min[2] * inv_vs)) - 1
        gx_max = int(math.floor(tri_max[0] * inv_vs)) + 1
        gy_max = int(math.floor(tri_max[1] * inv_vs)) + 1
        gz_max = int(math.floor(tri_max[2] * inv_vs)) + 1

        for gx in range(gx_min, gx_max + 1):
            for gy in range(gy_min, gy_max + 1):
                for gz in range(gz_min, gz_max + 1):
                    center = np.array([
                        (gx + 0.5) * voxel_size,
                        (gy + 0.5) * voxel_size,
                        (gz + 0.5) * voxel_size,
                    ])
                    if triangle_box_intersect(center, half, v0, v1, v2):
                        key = (gx, gy, gz)
                        if key not in voxel_normal_accum:
                            voxel_normal_accum[key] = np.zeros(3)
                        # Area-weighted normal accumulation
                        voxel_normal_accum[key] += tri_normal * tri_area

        # Safety: abort if too many voxels (prevents OOM on low-RAM server)
        if len(voxel_normal_accum) > MAX_VOXELS_BEFORE_MESH:
            print(f"WARNING: Voxel count exceeded {MAX_VOXELS_BEFORE_MESH} at triangle {tri_idx}/{len(tris)}, stopping early")
            overflow = True
            break

    # Normalize accumulated normals
    filled = set(voxel_normal_accum.keys())
    normals = {}
    for key, accum in voxel_normal_accum.items():
        norm = np.linalg.norm(accum)
        if norm > 1e-10:
            normals[key] = accum / norm
        else:
            normals[key] = np.array([0.0, 1.0, 0.0])

    # Free the accumulator dict early to reduce peak memory
    del voxel_normal_accum

    return filled, normals


# ==================== SURFACE / INTERIOR CLASSIFICATION ====================

NEIGHBORS_6 = [(1,0,0),(-1,0,0),(0,1,0),(0,-1,0),(0,0,1),(0,0,-1)]


def classify_surface_interior(all_voxels):
    """
    Split voxels into surface (has at least one empty 6-neighbor)
    and interior (fully surrounded).
    """
    surface = set()
    interior = set()
    for v in all_voxels:
        is_surface = False
        for dx, dy, dz in NEIGHBORS_6:
            if (v[0] + dx, v[1] + dy, v[2] + dz) not in all_voxels:
                is_surface = True
                break
        if is_surface:
            surface.add(v)
        else:
            interior.add(v)
    return surface, interior


def snap_axis_normal(n, threshold=0.96):
    """
    If a normal is nearly axis-aligned (within ~16°), snap it to the exact axis.
    This prevents jittery rotation on flat surfaces (car roof, floor, walls).
    Returns snapped normal or original if not close to any axis.
    """
    axes = [
        np.array([1.0, 0.0, 0.0]), np.array([-1.0, 0.0, 0.0]),
        np.array([0.0, 1.0, 0.0]), np.array([0.0, -1.0, 0.0]),
        np.array([0.0, 0.0, 1.0]), np.array([0.0, 0.0, -1.0]),
    ]
    for axis in axes:
        if np.dot(n, axis) >= threshold:
            return axis.copy()
    return n


def smooth_voxel_normals(surface_voxels, normals, iterations=3):
    """
    Smooth normals across neighboring surface voxels to reduce hard edges.
    Uses 3 iterations with weighted averaging for gradual transitions.
    After smoothing, snaps near-axis normals to prevent jitter on flat surfaces.
    """
    current = dict(normals)
    for iteration in range(iterations):
        new_normals = {}
        for v in surface_voxels:
            own = current.get(v, np.array([0.0, 1.0, 0.0]))
            # Own normal weighted more heavily (3x) to preserve detail
            accum = own * 3.0
            weight = 3.0
            # Average with 6-neighbors that are also surface voxels
            for dx, dy, dz in NEIGHBORS_6:
                nb = (v[0] + dx, v[1] + dy, v[2] + dz)
                if nb in current:
                    nb_normal = current[nb]
                    # Only blend with neighbors whose normal is somewhat similar
                    # This prevents averaging across sharp edges (like box corners)
                    dot = np.dot(own, nb_normal)
                    if dot > 0.3:
                        # Weight by similarity: more similar neighbors have more influence
                        w = 0.5 + dot * 0.5
                        accum += nb_normal * w
                        weight += w
            avg = accum / weight
            norm_len = np.linalg.norm(avg)
            if norm_len > 1e-10:
                new_normals[v] = avg / norm_len
            else:
                new_normals[v] = own
        current = new_normals

    # Final pass: snap near-axis normals so flat surfaces get zero rotation
    for v in list(current.keys()):
        current[v] = snap_axis_normal(current[v])

    return current


# ==================== NORMAL-AWARE GREEDY MESHER ====================

def is_axis_aligned(n, threshold=0.96):
    """Check if a normal is nearly axis-aligned."""
    return (abs(n[0]) >= threshold or abs(n[1]) >= threshold or abs(n[2]) >= threshold)


def greedy_mesh_with_normals(surface_voxels, normals, normal_threshold=0.97):
    """
    Greedy mesh surface voxels, but only merge blocks whose normals are similar.

    Key rules:
    - Axis-aligned blocks (flat surfaces) merge aggressively (threshold=0.99)
      since they'll have no rotation and tile perfectly.
    - Off-axis blocks (curved surfaces) merge conservatively (threshold=0.97 ≈ 14°)
      to preserve smooth rotation transitions.
    - Never merge axis-aligned blocks with off-axis blocks.

    Returns list of (x, y, z, sx, sy, sz, nx, ny, nz) tuples.
    """
    remaining = set(surface_voxels)
    blocks = []
    sorted_voxels = sorted(remaining)

    default_normal = np.array([0.0, 1.0, 0.0])

    for voxel in sorted_voxels:
        if voxel not in remaining:
            continue

        x, y, z = voxel
        ref_normal = normals.get(voxel, default_normal)
        ref_is_axis = is_axis_aligned(ref_normal)

        # Axis-aligned blocks can merge more freely since they won't be rotated
        threshold = 0.995 if ref_is_axis else normal_threshold

        def can_merge(key):
            if key not in remaining:
                return False
            n = normals.get(key, default_normal)
            # Never merge axis-aligned with non-axis-aligned
            if is_axis_aligned(n) != ref_is_axis:
                return False
            return np.dot(ref_normal, n) >= threshold

        # Extend in X direction
        x_len = 0
        while can_merge((x + x_len, y, z)):
            x_len += 1

        # Extend in Y direction
        y_len = 0
        expanding = True
        while expanding:
            for xi in range(x, x + x_len):
                if not can_merge((xi, y + y_len, z)):
                    expanding = False
                    break
            if expanding:
                y_len += 1

        # Extend in Z direction
        z_len = 0
        expanding = True
        while expanding:
            for xi in range(x, x + x_len):
                for yi in range(y, y + y_len):
                    if not can_merge((xi, yi, z + z_len)):
                        expanding = False
                        break
                if not expanding:
                    break
            if expanding:
                z_len += 1

        # Compute average normal of all consumed voxels
        avg_normal = np.zeros(3)
        count = 0
        for xi in range(x, x + x_len):
            for yi in range(y, y + y_len):
                for zi in range(z, z + z_len):
                    remaining.discard((xi, yi, zi))
                    avg_normal += normals.get((xi, yi, zi), default_normal)
                    count += 1

        if count > 0:
            avg_normal /= count
            norm_len = np.linalg.norm(avg_normal)
            if norm_len > 1e-10:
                avg_normal /= norm_len
            else:
                avg_normal = default_normal
            # Final snap: if the average ended up near an axis, snap it
            avg_normal = snap_axis_normal(avg_normal)

        blocks.append((x, y, z, x_len, y_len, z_len,
                        float(avg_normal[0]), float(avg_normal[1]), float(avg_normal[2])))

    return blocks


def morphological_close(voxels, iterations=1):
    """
    Dilate then erode to close small gaps.
    This connects thin features like car mirrors to the body.
    """
    neighbors_6 = [(1,0,0),(-1,0,0),(0,1,0),(0,-1,0),(0,0,1),(0,0,-1)]

    current = set(voxels)
    # Dilate
    for _ in range(iterations):
        new_voxels = set()
        for (x, y, z) in current:
            for dx, dy, dz in neighbors_6:
                nb = (x+dx, y+dy, z+dz)
                if nb not in current:
                    new_voxels.add(nb)
        current |= new_voxels

    # Erode - but never remove original surface voxels
    for _ in range(iterations):
        to_remove = set()
        for (x, y, z) in current:
            if (x, y, z) in voxels:
                continue  # protect original surface
            # Remove if any neighbor is empty
            for dx, dy, dz in neighbors_6:
                if (x+dx, y+dy, z+dz) not in current:
                    to_remove.add((x, y, z))
                    break
        current -= to_remove

    return current


def flood_fill_interior(surface_voxels):
    """
    Flood fill from outside to find interior voxels.
    Returns set of interior grid coordinates.
    """
    coords = list(surface_voxels)
    if not coords:
        return set()

    xs = [c[0] for c in coords]
    ys = [c[1] for c in coords]
    zs = [c[2] for c in coords]
    mn = (min(xs) - 2, min(ys) - 2, min(zs) - 2)
    mx = (max(xs) + 2, max(ys) + 2, max(zs) + 2)

    total = (mx[0]-mn[0]+1) * (mx[1]-mn[1]+1) * (mx[2]-mn[2]+1)
    if total > MAX_GRID_CELLS:
        print(f"Grid too large for interior fill ({total} cells), skipping")
        return set()

    # BFS from corner - everything reachable is exterior
    exterior = set()
    start = (mn[0], mn[1], mn[2])
    queue = deque([start])
    exterior.add(start)

    neighbors_6 = [(1,0,0),(-1,0,0),(0,1,0),(0,-1,0),(0,0,1),(0,0,-1)]

    while queue:
        x, y, z = queue.popleft()
        for dx, dy, dz in neighbors_6:
            nx, ny, nz = x+dx, y+dy, z+dz
            if mn[0] <= nx <= mx[0] and mn[1] <= ny <= mx[1] and mn[2] <= nz <= mx[2]:
                key = (nx, ny, nz)
                if key not in exterior and key not in surface_voxels:
                    exterior.add(key)
                    queue.append(key)
        # Safety: if exterior set is getting huge, the model is probably not watertight
        if len(exterior) > MAX_VOXELS_BEFORE_MESH:
            print(f"Exterior flood fill exceeded {MAX_VOXELS_BEFORE_MESH}, model may not be watertight, skipping interior")
            return set()

    # Interior = inside bounds, not exterior, not surface
    interior = set()
    for x in range(mn[0]+1, mx[0]):
        for y in range(mn[1]+1, mx[1]):
            for z in range(mn[2]+1, mx[2]):
                key = (x, y, z)
                if key not in exterior and key not in surface_voxels:
                    interior.add(key)

    # Free exterior set early
    del exterior

    return interior


# ==================== GREEDY MESHER ====================

def greedy_mesh_3d(voxels):
    """
    3D greedy meshing: merge adjacent voxels into larger rectangular blocks.
    Reduces block count by 5-20x typically.
    Returns list of (x, y, z, sx, sy, sz) tuples.
    """
    remaining = set(voxels)
    blocks = []

    # Sort for deterministic, cache-friendly traversal
    sorted_voxels = sorted(remaining)

    for voxel in sorted_voxels:
        if voxel not in remaining:
            continue

        x, y, z = voxel

        # Extend in X direction
        x_len = 0
        while (x + x_len, y, z) in remaining:
            x_len += 1

        # Extend in Y direction (must fit entire X span)
        y_len = 0
        expanding = True
        while expanding:
            for xi in range(x, x + x_len):
                if (xi, y + y_len, z) not in remaining:
                    expanding = False
                    break
            if expanding:
                y_len += 1

        # Extend in Z direction (must fit entire X*Y span)
        z_len = 0
        expanding = True
        while expanding:
            for xi in range(x, x + x_len):
                for yi in range(y, y + y_len):
                    if (xi, yi, z + z_len) not in remaining:
                        expanding = False
                        break
                if not expanding:
                    break
            if expanding:
                z_len += 1

        # Remove all consumed voxels
        for xi in range(x, x + x_len):
            for yi in range(y, y + y_len):
                for zi in range(z, z + z_len):
                    remaining.discard((xi, yi, zi))

        blocks.append((x, y, z, x_len, y_len, z_len))

    return blocks


# ==================== MAIN ENDPOINT ====================

def _run_voxelize_pipeline(obj_content, scale, voxel_size, fill_interior, close_gaps, smooth_rotation, count_only=False):
    """
    Core voxelization pipeline shared by /voxelize and /count endpoints.
    If count_only=True, skips building the full voxel list and returns just counts.
    """
    voxel_size = max(0.1, min(5.0, voxel_size))
    close_gaps = max(0, min(3, close_gaps))

    # Parse
    verts, tris = parse_obj(obj_content, scale)
    if len(verts) == 0:
        return {"error": "No vertices found in OBJ"}, 400
    if len(tris) == 0:
        return {"error": "No faces found in OBJ"}, 400
    if len(tris) > MAX_TRIANGLES:
        return {"error": f"Model has {len(tris):,} triangles (max {MAX_TRIANGLES:,}). Simplify the model or increase voxel size."}, 400

    print(f"Parsed {len(verts)} vertices, {len(tris)} triangles")
    print(f"Smooth rotation: {smooth_rotation}, Count only: {count_only}")

    # Model bounds
    mins = verts.min(axis=0)
    maxs = verts.max(axis=0)
    center = (mins + maxs) / 2.0
    size = maxs - mins

    print(f"Model size: {size[0]:.2f} x {size[1]:.2f} x {size[2]:.2f}")
    print(f"Voxel size: {voxel_size}, Close gaps: {close_gaps}")

    # Estimate grid size
    grid_dims = np.ceil(size / voxel_size).astype(int) + 4
    grid_total = int(grid_dims[0]) * int(grid_dims[1]) * int(grid_dims[2])
    if grid_total > MAX_GRID_CELLS:
        return {
            "error": f"Grid too large ({grid_total:,} cells). Increase voxel_size or reduce scale.",
            "grid_size": grid_dims.tolist(),
        }, 400

    # Free parsed content string early (can be huge)
    del obj_content

    # Phase 1: Voxelize surface
    voxel_normals = {}
    if smooth_rotation:
        print("Phase 1: Voxelizing surface with normals...")
        surface, voxel_normals = voxelize_triangles_with_normals(verts, tris, voxel_size)
    else:
        print("Phase 1: Voxelizing surface...")
        surface = voxelize_triangles(verts, tris, voxel_size)

    # Free vertex/triangle data after voxelization
    del verts, tris
    gc.collect()

    print(f"  Surface voxels: {len(surface)}")

    if not surface:
        return {"error": "No voxels generated - model may be too small for this voxel size"}, 400

    # Phase 2: Morphological closing
    all_voxels = set(surface)
    if close_gaps > 0:
        print(f"Phase 2: Closing gaps ({close_gaps} iterations)...")
        all_voxels = morphological_close(surface, iterations=close_gaps)
        print(f"  After closing: {len(all_voxels)} voxels")

    # Phase 3: Fill interior if requested
    interior_count = 0
    if fill_interior:
        print("Phase 3: Filling interior...")
        interior = flood_fill_interior(all_voxels)
        interior_count = len(interior)
        all_voxels |= interior
        del interior
        print(f"  Interior voxels: {interior_count}")
        print(f"  Total: {len(all_voxels)}")

    # Phase 4: Meshing
    vs = voxel_size
    cx, cy, cz = float(center[0]), float(center[1]), float(center[2])
    blocks = []

    if smooth_rotation:
        print("Phase 4: Surface/interior classification...")
        surface_set, interior_set = classify_surface_interior(all_voxels)
        print(f"  Surface: {len(surface_set)}, Interior: {len(interior_set)}")

        # Propagate normals to voxels added by morphological closing
        for v in surface_set:
            if v not in voxel_normals:
                accum = np.zeros(3)
                count = 0
                for dx, dy, dz in NEIGHBORS_6:
                    nb = (v[0] + dx, v[1] + dy, v[2] + dz)
                    if nb in voxel_normals:
                        accum += voxel_normals[nb]
                        count += 1
                if count > 0:
                    accum /= count
                    norm = np.linalg.norm(accum)
                    if norm > 1e-10:
                        voxel_normals[v] = accum / norm
                    else:
                        voxel_normals[v] = np.array([0.0, 1.0, 0.0])
                else:
                    voxel_normals[v] = np.array([0.0, 1.0, 0.0])

        print("Phase 4b: Smoothing surface normals...")
        smoothed_normals = smooth_voxel_normals(surface_set, voxel_normals, iterations=3)

        # Free raw normals now that we have smoothed ones
        del voxel_normals
        gc.collect()

        print("Phase 4c: Normal-aware surface meshing...")
        surface_merged = greedy_mesh_with_normals(surface_set, smoothed_normals, normal_threshold=0.92)
        print(f"  Surface: {len(surface_set)} voxels -> {len(surface_merged)} blocks")

        # Free smoothed normals and surface set
        del smoothed_normals, surface_set

        interior_merged = []
        if interior_set:
            print("Phase 4d: Interior greedy meshing...")
            interior_merged = greedy_mesh_3d(interior_set)
            print(f"  Interior: {len(interior_set)} voxels -> {len(interior_merged)} blocks")
        del interior_set

        total_merged = len(surface_merged) + len(interior_merged)

        # For count_only, skip building the full block list
        if count_only:
            block_count = min(total_merged, MAX_OUTPUT_BLOCKS)
            result = {
                "success": True,
                "voxel_count": block_count,
                "raw_voxels": len(all_voxels),
                "surface_voxels": len(surface),
                "interior_voxels": interior_count,
                "merge_ratio": f"{len(all_voxels) / max(1, total_merged):.1f}x",
                "smooth_rotation": smooth_rotation,
                "bounds": {
                    "size": [round(float(size[0]), 4), round(float(size[1]), 4), round(float(size[2]), 4)],
                },
                "voxel_size": voxel_size,
            }
            del surface_merged, interior_merged, all_voxels, surface
            gc.collect()
            return result, 200

        # Build full block list
        for (gx, gy, gz, sx, sy, sz, nx, ny, nz) in surface_merged:
            px = (gx + sx / 2.0) * vs - cx
            py = (gy + sy / 2.0) * vs - cy
            pz = (gz + sz / 2.0) * vs - cz
            blocks.append({
                "position": [round(px, 4), round(py, 4), round(pz, 4)],
                "size": [round(sx * vs, 4), round(sy * vs, 4), round(sz * vs, 4)],
                "normal": [round(nx, 4), round(ny, 4), round(nz, 4)],
            })
        del surface_merged

        for (gx, gy, gz, sx, sy, sz) in interior_merged:
            px = (gx + sx / 2.0) * vs - cx
            py = (gy + sy / 2.0) * vs - cy
            pz = (gz + sz / 2.0) * vs - cz
            blocks.append({
                "position": [round(px, 4), round(py, 4), round(pz, 4)],
                "size": [round(sx * vs, 4), round(sy * vs, 4), round(sz * vs, 4)],
            })
        del interior_merged

        print(f"  Total: {total_merged} blocks (from {len(all_voxels)} voxels)")
    else:
        # Free normals if any
        del voxel_normals

        print("Phase 4: Greedy meshing...")
        merged = greedy_mesh_3d(all_voxels)
        print(f"  Merged into {len(merged)} blocks (from {len(all_voxels)} voxels)")

        if count_only:
            block_count = min(len(merged), MAX_OUTPUT_BLOCKS)
            result = {
                "success": True,
                "voxel_count": block_count,
                "raw_voxels": len(all_voxels),
                "surface_voxels": len(surface),
                "interior_voxels": interior_count,
                "merge_ratio": f"{len(all_voxels) / max(1, len(merged)):.1f}x",
                "smooth_rotation": smooth_rotation,
                "bounds": {
                    "size": [round(float(size[0]), 4), round(float(size[1]), 4), round(float(size[2]), 4)],
                },
                "voxel_size": voxel_size,
            }
            del merged, all_voxels, surface
            gc.collect()
            return result, 200

        for (gx, gy, gz, sx, sy, sz) in merged:
            px = (gx + sx / 2.0) * vs - cx
            py = (gy + sy / 2.0) * vs - cy
            pz = (gz + sz / 2.0) * vs - cz
            blocks.append({
                "position": [round(px, 4), round(py, 4), round(pz, 4)],
                "size": [round(sx * vs, 4), round(sy * vs, 4), round(sz * vs, 4)],
            })
        del merged

    # Enforce limit
    if len(blocks) > MAX_OUTPUT_BLOCKS:
        print(f"Truncating {len(blocks)} blocks to {MAX_OUTPUT_BLOCKS}")
        blocks.sort(key=lambda b: b["size"][0] * b["size"][1] * b["size"][2], reverse=True)
        blocks = blocks[:MAX_OUTPUT_BLOCKS]

    print(f"Output: {len(blocks)} blocks")

    raw_voxel_count = len(all_voxels)
    surface_count = len(surface)
    del all_voxels, surface
    gc.collect()

    return {
        "success": True,
        "voxel_count": len(blocks),
        "raw_voxels": raw_voxel_count,
        "surface_voxels": surface_count,
        "interior_voxels": interior_count,
        "merge_ratio": f"{raw_voxel_count / max(1, len(blocks)):.1f}x",
        "smooth_rotation": smooth_rotation,
        "voxels": blocks,
        "bounds": {
            "min": [round(float(mins[0] - cx), 4), round(float(mins[1] - cy), 4), round(float(mins[2] - cz), 4)],
            "max": [round(float(maxs[0] - cx), 4), round(float(maxs[1] - cy), 4), round(float(maxs[2] - cz), 4)],
            "size": [round(float(size[0]), 4), round(float(size[1]), 4), round(float(size[2]), 4)],
        },
        "center": [round(cx, 4), round(cy, 4), round(cz, 4)],
        "voxel_size": voxel_size,
        "close_gaps": close_gaps,
    }, 200


@app.route("/voxelize", methods=["POST"])
@require_api_key
def voxelize():
    global _processing
    if _processing:
        return jsonify({"error": "Server is busy processing another model. Please wait and try again."}), 503
    _processing = True
    try:
        data = request.get_json()
        if not data:
            return jsonify({"error": "Invalid JSON body"}), 400
        obj_content = data.get("obj_content")
        if not obj_content:
            return jsonify({"error": "No OBJ content provided"}), 400

        result, status = _run_voxelize_pipeline(
            obj_content=obj_content,
            scale=float(data.get("scale", 1.0)),
            voxel_size=float(data.get("voxel_size", 1.0)),
            fill_interior=bool(data.get("fill_interior", False)),
            close_gaps=int(data.get("close_gaps", 1)),
            smooth_rotation=bool(data.get("smooth_rotation", False)),
            count_only=False,
        )
        return jsonify(result), status

    except MemoryError:
        gc.collect()
        print("MEMORY ERROR during voxelization")
        return jsonify({"error": "Server ran out of memory. Try a larger voxel size or smaller model."}), 503
    except Exception as e:
        print(f"Voxelization error: {e}")
        traceback.print_exc()
        return jsonify({"error": str(e)}), 500
    finally:
        _processing = False
        gc.collect()


@app.route("/count", methods=["POST"])
@require_api_key
def count_blocks():
    """Lightweight endpoint that returns block count without the full voxel list.
    Much faster response and less memory for the 'List Blocks' feature."""
    global _processing
    if _processing:
        return jsonify({"error": "Server is busy processing another model. Please wait and try again."}), 503
    _processing = True
    try:
        data = request.get_json()
        if not data:
            return jsonify({"error": "Invalid JSON body"}), 400
        obj_content = data.get("obj_content")
        if not obj_content:
            return jsonify({"error": "No OBJ content provided"}), 400

        result, status = _run_voxelize_pipeline(
            obj_content=obj_content,
            scale=float(data.get("scale", 1.0)),
            voxel_size=float(data.get("voxel_size", 1.0)),
            fill_interior=bool(data.get("fill_interior", False)),
            close_gaps=int(data.get("close_gaps", 1)),
            smooth_rotation=bool(data.get("smooth_rotation", False)),
            count_only=True,
        )
        return jsonify(result), status

    except MemoryError:
        gc.collect()
        print("MEMORY ERROR during count")
        return jsonify({"error": "Server ran out of memory. Try a larger voxel size or smaller model."}), 503
    except Exception as e:
        print(f"Count error: {e}")
        traceback.print_exc()
        return jsonify({"error": str(e)}), 500
    finally:
        _processing = False
        gc.collect()


@app.route("/health", methods=["GET"])
def health():
    import os
    try:
        import psutil
        mem = psutil.virtual_memory()
        mem_info = {"total_mb": round(mem.total / 1024 / 1024), "available_mb": round(mem.available / 1024 / 1024), "percent": mem.percent}
    except ImportError:
        mem_info = "psutil not installed"
    return jsonify({"status": "ok", "service": "obj-voxelizer", "busy": _processing, "memory": mem_info})


if __name__ == "__main__":
    print("=" * 50)
    print("OBJ Voxelizer Server (Low-RAM Edition)")
    print("=" * 50)
    print(f"Max grid cells: {MAX_GRID_CELLS:,}")
    print(f"Max triangles: {MAX_TRIANGLES:,}")
    print(f"Max voxels before mesh: {MAX_VOXELS_BEFORE_MESH:,}")
    print(f"Max output blocks: {MAX_OUTPUT_BLOCKS:,}")
    print(f"Rate limit: {RATE_LIMIT}/min per IP")
    print("=" * 50)
    app.run(debug=False, host="0.0.0.0", port=5001)