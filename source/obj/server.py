from flask import Flask, request, jsonify
import requests
from PIL import Image, UnidentifiedImageError
from io import BytesIO
import traceback
import urllib.parse
import os
import re
import qrcode
import math  # This is correctly imported
import base64
import numpy as np
from functools import wraps
from collections import defaultdict, deque
from time import time

app = Flask(__name__)

# ==================== SECURITY CONFIGURATION ====================
MAX_PIXELS = 5000000  # Maximum allowed pixels in an image (5MP)
MAX_REQUEST_SIZE = 50 * 1024 * 1024  # 50MB max request size
REQUESTS_PER_MINUTE = 12
CRASH_PROTECTION_ENABLED = False

# IP Blacklist - Add IPs here to block them
IP_BLACKLIST = set([
    # "192.168.1.1",  # Example: Uncomment and add malicious IPs
])

# Rate limiting - tracks requests per IP
request_history = defaultdict(list)

def get_client_ip():
    """Get client IP address, accounting for proxies"""
    if request.environ.get('HTTP_X_FORWARDED_FOR'):
        return request.environ.get('HTTP_X_FORWARDED_FOR').split(',')[0].strip()
    return request.remote_addr

def is_ip_blocked(ip):
    """Check if IP is blacklisted"""
    return ip in IP_BLACKLIST

def check_rate_limit(ip):
    """Check if IP has exceeded rate limit"""
    current_time = time()
    minute_ago = current_time - 60

    # Clean old requests
    request_history[ip] = [req_time for req_time in request_history[ip] if req_time > minute_ago]

    if len(request_history[ip]) >= REQUESTS_PER_MINUTE:
        return False

    request_history[ip].append(current_time)
    return True


def rgba_to_int(r, g, b, a):
    return (r << 24) | (g << 16) | (b << 8) | a

API_KEY = 'i-know-the-key-is-visible-please-be-kind'

# ==================== MIDDLEWARE ====================
@app.before_request
def check_security():
    """Check IP blacklist and rate limiting before processing request"""
    try:
        client_ip = get_client_ip()

        # Check if IP is blocked
        if is_ip_blocked(client_ip):
            return jsonify({"error": "Access denied - IP blocked"}), 403

        # Check rate limit
        if not check_rate_limit(client_ip):
            return jsonify({
                "error": "Rate limit exceeded - Maximum 10 requests per minute",
                "retry_after": 60
            }), 429

        # Check request size
        if request.content_length and request.content_length > MAX_REQUEST_SIZE:
            return jsonify({
                "error": f"Request too large - Maximum {MAX_REQUEST_SIZE / (1024*1024):.0f}MB allowed"
            }), 413

    except Exception as e:
        if CRASH_PROTECTION_ENABLED:
            print(f"Security check error: {e}")
            return jsonify({"error": "Security check failed"}), 500
        raise

def rgba_to_int(r, g, b, a):
    return (r << 24) | (g << 16) | (b << 8) | a

def require_api_key(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        try:
            # Check header first
            key = request.headers.get('X-API-Key')
            # Fallback to query param
            if not key:
                key = request.args.get('api_key')
            # Fallback to JSON body
            if not key:
                try:
                    body = request.get_json(silent=True)
                    if isinstance(body, dict):
                        key = body.get('api_key')
                except Exception:
                    key = None

            if not key or key != API_KEY:
                return jsonify({"error": "Unauthorized - invalid API key"}), 401
            return f(*args, **kwargs)
        except Exception as e:
            if CRASH_PROTECTION_ENABLED:
                print(f"API key check error: {e}")
                return jsonify({"error": "Authentication check failed"}), 500
            raise
    return decorated


@app.route('/image', methods=['POST'])
@require_api_key
def process_image():
    if not request.is_json:
        return "invalid", 400, {'Content-Type': 'text/plain; charset=utf-8'}

    try:
        data = request.get_json()
        image_url = data.get('url')

        if not image_url:
            return "invalid", 400, {'Content-Type': 'text/plain; charset=utf-8'}

        response = requests.get(image_url, timeout=10, stream=True)
        response.raise_for_status()

        img_bytes = BytesIO(response.content)
        img = Image.open(img_bytes)
        img = img.convert("RGBA")

        width, height = img.size
        total_pixels = width * height

        # Validate pixel count
        if total_pixels > MAX_PIXELS:
            return jsonify({
                "error": f"Image too large - Maximum {MAX_PIXELS:,} pixels allowed",
                "provided_pixels": total_pixels,
                "max_pixels": MAX_PIXELS
            }), 413

        pixels_data = list(img.getdata())

        processed_pixels = []
        for r, g, b, a in pixels_data:
            processed_pixels.append(rgba_to_int(r, g, b, a))

        return jsonify({
            "dimensions": [width, height],
            "pixels": processed_pixels,
            "total_pixels": total_pixels
        })

    except requests.exceptions.Timeout:
        return jsonify({"error": "Image request timeout"}), 408
    except (requests.exceptions.RequestException, UnidentifiedImageError, IOError) as e:
        if CRASH_PROTECTION_ENABLED:
            print(f"Image processing error: {e}")
            return "invalid", 400, {'Content-Type': 'text/plain; charset=utf-8'}
        raise
    except Exception as e:
        if CRASH_PROTECTION_ENABLED:
            print(f"Image processing unexpected error: {e}")
            traceback.print_exc()
            return jsonify({"error": "Image processing failed"}), 500
        raise




# ==================== OBJ VOXELIZATION HELPERS ====================

def parse_obj(content, scale=1.0):
    vertices = []
    faces = []
    for line in content.split('\n'):
        line = line.strip()
        if not line or line.startswith('#'):
            continue
        parts = line.split()
        if not parts:
            continue
        if parts[0] == 'v' and len(parts) >= 4:
            try:
                vertices.append((
                    float(parts[1]) * scale,
                    float(parts[2]) * scale,
                    float(parts[3]) * scale
                ))
            except ValueError:
                continue
        elif parts[0] == 'f':
            face_indices = []
            for p in parts[1:]:
                try:
                    vid = int(p.split('/')[0])
                    if vid < 0:
                        vid = len(vertices) + vid
                    else:
                        vid -= 1
                    if 0 <= vid < len(vertices):
                        face_indices.append(vid)
                except (ValueError, IndexError):
                    continue
            for i in range(1, len(face_indices) - 1):
                faces.append((face_indices[0], face_indices[i], face_indices[i + 1]))
    return vertices, faces


def _vec_sub(a, b):
    return (a[0]-b[0], a[1]-b[1], a[2]-b[2])

def _vec_cross(a, b):
    return (a[1]*b[2]-a[2]*b[1], a[2]*b[0]-a[0]*b[2], a[0]*b[1]-a[1]*b[0])

def _vec_dot(a, b):
    return a[0]*b[0] + a[1]*b[1] + a[2]*b[2]

def _vec_len(v):
    return math.sqrt(v[0]**2 + v[1]**2 + v[2]**2)

def _vec_normalize(v):
    ln = _vec_len(v)
    if ln < 1e-10:
        return (0.0, 0.0, 1.0)
    return (v[0]/ln, v[1]/ln, v[2]/ln)


def _rotation_from_frame(tangent, normal, bitangent):
    """Convert local frame (tangent=X, normal=Y, bitangent=Z) to XYZ Euler angles in degrees.
    Matches Roblox CFrame.Angles(rx, ry, rz) = Rx * Ry * Rz convention.

    Rotation matrix columns [tangent | normal | bitangent]:
        M = | tx nx bx |
            | ty ny by |
            | tz nz bz |

    Extraction:
        ry = asin(bx)
        rx = atan2(-by, bz)
        rz = atan2(-nx, tx)
    """
    bx = max(-1.0, min(1.0, bitangent[0]))
    ry = math.asin(bx)
    cos_ry = math.cos(ry)
    if abs(cos_ry) > 1e-6:
        rx = math.atan2(-bitangent[1], bitangent[2])
        rz = math.atan2(-normal[0], tangent[0])
    else:
        rx = math.atan2(normal[2], normal[1])
        rz = 0.0
    return (math.degrees(rx), math.degrees(ry), math.degrees(rz))


def surface_tile_triangle(v0, v1, v2, block_size, thickness):
    """Tile a triangle surface with thin rotated blocks that follow the geometry.
    Returns list of dicts with position, size, rotation."""
    e1 = _vec_sub(v1, v0)
    e2 = _vec_sub(v2, v0)
    raw_normal = _vec_cross(e1, e2)
    area2 = _vec_len(raw_normal)
    if area2 < 1e-10:
        return []

    normal = _vec_normalize(raw_normal)
    tangent = _vec_normalize(e1)
    bitangent = _vec_cross(normal, tangent)
    bitangent = _vec_normalize(bitangent)

    # Project triangle vertices onto tangent-bitangent 2D plane (origin at v0)
    u1 = _vec_dot(e1, tangent)
    w1 = _vec_dot(e1, bitangent)
    u2 = _vec_dot(e2, tangent)
    w2 = _vec_dot(e2, bitangent)
    # v0 projects to (0, 0)

    min_u = min(0.0, u1, u2)
    max_u = max(0.0, u1, u2)
    min_w = min(0.0, w1, w2)
    max_w = max(0.0, w1, w2)

    # Calculate rotation from surface normal only - more consistent
    rotation = list(_rotation_from_frame(tangent, normal, bitangent))

    # Barycentric denominator for triangle (0,0), (u1,w1), (u2,w2)
    denom = u1 * w2 - u2 * w1
    if abs(denom) < 1e-10:
        return []
    inv_denom = 1.0 / denom

    blocks = []
    half_bs = block_size * 0.5

    u = min_u + half_bs
    while u <= max_u + 0.001:
        w = min_w + half_bs
        while w <= max_w + 0.001:
            # Barycentric coords for point (u, w) in triangle (0,0),(u1,w1),(u2,w2)
            alpha = (u * w2 - u2 * w) * inv_denom    # weight for v1
            beta  = (u1 * w - u * w1) * inv_denom     # weight for v2
            gamma = 1.0 - alpha - beta                 # weight for v0

            if alpha >= -0.02 and beta >= -0.02 and gamma >= -0.02:
                # Inside triangle -- compute 3D world position
                px = v0[0] + u * tangent[0] + w * bitangent[0]
                py = v0[1] + u * tangent[1] + w * bitangent[1]
                pz = v0[2] + u * tangent[2] + w * bitangent[2]
                blocks.append({
                    "position": [round(px, 4), round(py, 4), round(pz, 4)],
                    "size": [round(block_size, 4), round(thickness, 4), round(block_size, 4)],
                    "rotation": [round(rotation[0], 3), round(rotation[1], 3), round(rotation[2], 3)]
                })
            w += block_size
        u += block_size

    # If triangle is smaller than one grid cell, place a single block at centroid
    if not blocks:
        cx = (v0[0] + v1[0] + v2[0]) / 3.0
        cy = (v0[1] + v1[1] + v2[1]) / 3.0
        cz = (v0[2] + v1[2] + v2[2]) / 3.0
        tri_w = max(max_u - min_u, block_size * 0.3)
        tri_d = max(max_w - min_w, block_size * 0.3)
        blocks.append({
            "position": [round(cx, 4), round(cy, 4), round(cz, 4)],
            "size": [round(min(tri_w, block_size * 2), 4), round(thickness, 4), round(min(tri_d, block_size * 2), 4)],
            "rotation": [round(rotation[0], 3), round(rotation[1], 3), round(rotation[2], 3)]
        })

    return blocks


def voxelize_interior(vertices, faces, voxel_size):
    """Axis-aligned voxelization + flood fill for solid interior (optional).
    Returns list of block dicts with rotation=[0,0,0]."""
    inv_vs = 1.0 / voxel_size
    filled = set()

    for face in faces:
        v0, v1, v2 = vertices[face[0]], vertices[face[1]], vertices[face[2]]
        e1 = _vec_sub(v1, v0)
        e2 = _vec_sub(v2, v0)
        len_e1 = _vec_len(e1)
        len_e2 = _vec_len(e2)
        step = 0.4 * voxel_size
        n1 = max(1, int(math.ceil(len_e1 / step)))
        n2 = max(1, int(math.ceil(len_e2 / step)))
        for i in range(n1 + 1):
            u = i / n1
            bx = v0[0] + u * e1[0]
            by = v0[1] + u * e1[1]
            bz = v0[2] + u * e1[2]
            for j in range(int((1.0 - u) * n2) + 2):
                v = j / n2
                if u + v > 1.0001:
                    break
                filled.add((
                    int(math.floor((bx + v * e2[0]) * inv_vs)),
                    int(math.floor((by + v * e2[1]) * inv_vs)),
                    int(math.floor((bz + v * e2[2]) * inv_vs))
                ))

    if not filled:
        return []

    # Flood fill exterior to find interior
    coords = list(filled)
    gmin = (min(c[0] for c in coords), min(c[1] for c in coords), min(c[2] for c in coords))
    gmax = (max(c[0] for c in coords), max(c[1] for c in coords), max(c[2] for c in coords))

    mn_x, mn_y, mn_z = gmin[0] - 1, gmin[1] - 1, gmin[2] - 1
    mx_x, mx_y, mx_z = gmax[0] + 1, gmax[1] + 1, gmax[2] + 1
    total = (mx_x - mn_x + 1) * (mx_y - mn_y + 1) * (mx_z - mn_z + 1)
    if total > 4_000_000:
        print(f"Grid too large for interior fill ({total} cells), skipping")
        return []

    exterior = set()
    queue = deque([(mn_x, mn_y, mn_z)])
    exterior.add((mn_x, mn_y, mn_z))
    while queue:
        x, y, z = queue.popleft()
        for dx, dy, dz in ((1,0,0),(-1,0,0),(0,1,0),(0,-1,0),(0,0,1),(0,0,-1)):
            nx, ny, nz = x + dx, y + dy, z + dz
            if mn_x <= nx <= mx_x and mn_y <= ny <= mx_y and mn_z <= nz <= mx_z:
                key = (nx, ny, nz)
                if key not in exterior and key not in filled:
                    exterior.add(key)
                    queue.append(key)

    # Interior = all grid cells that are not exterior and not surface
    interior = set()
    for x in range(gmin[0], gmax[0] + 1):
        for y in range(gmin[1], gmax[1] + 1):
            for z in range(gmin[2], gmax[2] + 1):
                key = (x, y, z)
                if key not in exterior and key not in filled:
                    interior.add(key)

    if not interior:
        return []

    # Greedy mesh the interior voxels
    remaining = set(interior)
    blocks = []
    for voxel in sorted(remaining):
        if voxel not in remaining:
            continue
        x, y, z = voxel
        x_len = 0
        while (x + x_len, y, z) in remaining:
            x_len += 1
        z_len = 0
        ok = True
        while ok:
            for xi in range(x, x + x_len):
                if (xi, y, z + z_len) not in remaining:
                    ok = False
                    break
            if ok:
                z_len += 1
        y_len = 0
        ok = True
        while ok:
            for xi in range(x, x + x_len):
                for zi in range(z, z + z_len):
                    if (xi, y + y_len, zi) not in remaining:
                        ok = False
                        break
                if not ok:
                    break
            if ok:
                y_len += 1
        for xi in range(x, x + x_len):
            for yi in range(y, y + y_len):
                for zi in range(z, z + z_len):
                    remaining.discard((xi, yi, zi))
        cx = (x + x_len / 2.0) * voxel_size
        cy = (y + y_len / 2.0) * voxel_size
        cz = (z + z_len / 2.0) * voxel_size
        blocks.append({
            "position": [round(cx, 4), round(cy, 4), round(cz, 4)],
            "size": [round(x_len * voxel_size, 4), round(y_len * voxel_size, 4), round(z_len * voxel_size, 4)],
            "rotation": [0, 0, 0]
        })
    return blocks


@app.route('/obj-to-voxels-optimized', methods=['POST'])
@require_api_key
def obj_to_voxels_optimized():
    try:
        data = request.get_json()
        obj_content = data.get('obj_content')
        scale = float(data.get('scale', 1.0))
        voxel_size = float(data.get('voxel_size', 1.0))
        fill_interior = data.get('fill_interior', False)

        if not obj_content:
            return jsonify({"error": "No OBJ content"}), 400

        voxel_size = max(0.25, min(4.0, voxel_size))

        vertices, faces = parse_obj(obj_content, scale)
        if not vertices:
            return jsonify({"error": "No vertices found in OBJ"}), 400
        if not faces:
            return jsonify({"error": "No faces found in OBJ"}), 400

        print(f"Parsed {len(vertices)} vertices, {len(faces)} triangles")

        # Compute model bounds and center
        xs = [v[0] for v in vertices]
        ys = [v[1] for v in vertices]
        zs = [v[2] for v in vertices]
        min_x, max_x = min(xs), max(xs)
        min_y, max_y = min(ys), max(ys)
        min_z, max_z = min(zs), max(zs)
        center_x = (min_x + max_x) / 2
        center_y = (min_y + max_y) / 2
        center_z = (min_z + max_z) / 2

        print(f"Bounds: ({min_x:.2f},{min_y:.2f},{min_z:.2f}) to ({max_x:.2f},{max_y:.2f},{max_z:.2f})")
        print(f"Block size: {voxel_size}, Fill interior: {fill_interior}")

        # Surface tiling -- thin rotated blocks that follow each triangle face
        # Thickness should be small enough to not overlap but large enough for gaps
        thickness = max(0.2, voxel_size * 0.4)
        blocks = []
        MAX_BLOCKS = 200000

        for face in faces:
            if len(blocks) >= MAX_BLOCKS:
                print(f"Block limit reached ({MAX_BLOCKS})")
                break
            v0 = vertices[face[0]]
            v1 = vertices[face[1]]
            v2 = vertices[face[2]]
            tri_blocks = surface_tile_triangle(v0, v1, v2, voxel_size, thickness)
            blocks.extend(tri_blocks)

        surface_count = len(blocks)
        print(f"Surface blocks: {surface_count}")

        # Optional: fill interior with axis-aligned voxels (greedy meshed)
        interior_count = 0
        if fill_interior:
            interior_blocks = voxelize_interior(vertices, faces, voxel_size)
            interior_count = len(interior_blocks)
            # Center interior blocks too (they use raw coordinates)
            for b in interior_blocks:
                b["position"][0] = round(b["position"][0] - center_x, 4)
                b["position"][1] = round(b["position"][1] - center_y, 4)
                b["position"][2] = round(b["position"][2] - center_z, 4)
            blocks.extend(interior_blocks)
            print(f"Interior blocks: {interior_count}")

        # Center all surface block positions
        for b in blocks[:surface_count]:
            b["position"][0] = round(b["position"][0] - center_x, 4)
            b["position"][1] = round(b["position"][1] - center_y, 4)
            b["position"][2] = round(b["position"][2] - center_z, 4)

        print(f"Total blocks: {len(blocks)} (surface: {surface_count}, interior: {interior_count})")

        return jsonify({
            "success": True,
            "voxel_count": len(blocks),
            "raw_voxel_count": len(faces),
            "surface_count": surface_count,
            "interior_count": interior_count,
            "voxels": blocks,
            "bounds": {
                "min": [min_x - center_x, min_y - center_y, min_z - center_z],
                "max": [max_x - center_x, max_y - center_y, max_z - center_z],
                "size": [max_x - min_x, max_y - min_y, max_z - min_z]
            },
            "center": [center_x, center_y, center_z],
            "voxel_size": voxel_size
        })

    except Exception as e:
        print(f"OBJ conversion error: {e}")
        traceback.print_exc()
        return jsonify({"error": str(e)}), 500



@app.route('/qr-code', methods=['POST'])
@require_api_key
def generate_qr_code():
    try:
        data = request.get_json()
        text_content = data.get('text')  # Changed from 'url' to 'text'
        block_size = float(data.get('block_size', 1.0))
        scale = float(data.get('scale', 1.0))
        error_correction = data.get('error_correction', 'M').upper()

        if not text_content:
            return jsonify({"error": "No text content provided"}), 400

        # Map error correction levels
        error_correction_map = {
            'L': qrcode.constants.ERROR_CORRECT_L,
            'M': qrcode.constants.ERROR_CORRECT_M,
            'Q': qrcode.constants.ERROR_CORRECT_Q,
            'H': qrcode.constants.ERROR_CORRECT_H
        }

        ec_level = error_correction_map.get(error_correction, qrcode.constants.ERROR_CORRECT_M)

        # Generate QR code
        qr = qrcode.QRCode(
            version=1,
            error_correction=ec_level,
            box_size=1,
            border=4,
        )

        qr.add_data(text_content)
        qr.make(fit=True)

        # Create QR code matrix
        qr_matrix = qr.get_matrix()

        # Convert to list format
        matrix_list = []
        for row in qr_matrix:
            matrix_list.append([1 if cell else 0 for cell in row])

        size = len(qr_matrix)

        return jsonify({
            "success": True,
            "data": text_content,
            "size": size,
            "matrix": matrix_list,
            "block_count": sum(sum(row) for row in matrix_list),
            "dimensions": [size, size]
        })

    except ValueError as e:
        if CRASH_PROTECTION_ENABLED:
            print(f"QR code value error: {e}")
            return jsonify({"error": "Invalid parameter values"}), 400
        raise
    except Exception as e:
        if CRASH_PROTECTION_ENABLED:
            print(f"QR code generation error: {e}")
            traceback.print_exc()
            return jsonify({"error": "QR code generation failed"}), 500
        raise 

# ==================== ERROR HANDLERS ====================
@app.errorhandler(429)
def handle_rate_limit(e):
    """Handle rate limit errors"""
    return jsonify({
        "error": "Rate limit exceeded - Maximum 10 requests per minute",
        "retry_after": 60
    }), 429

@app.errorhandler(413)
def handle_large_request(e):
    """Handle request too large errors"""
    return jsonify({
        "error": f"Request too large - Maximum {MAX_REQUEST_SIZE / (1024*1024):.0f}MB allowed"
    }), 413

@app.errorhandler(500)
def handle_server_error(e):
    """Handle server errors gracefully"""
    if CRASH_PROTECTION_ENABLED:
        print(f"Server error: {e}")
        return jsonify({"error": "Internal server error"}), 500
    raise

if __name__ == '__main__':
    print("=" * 60)
    print("Server Security Configuration:")
    print("=" * 60)
    print(f"Max pixels per image: {MAX_PIXELS:,}")
    print(f"Max request size: {MAX_REQUEST_SIZE / (1024*1024):.0f}MB")
    print(f"Rate limit: {REQUESTS_PER_MINUTE} requests/minute per IP")
    print(f"Crash protection: {'ENABLED' if CRASH_PROTECTION_ENABLED else 'DISABLED'}")
    print(f"Blacklisted IPs: {len(IP_BLACKLIST)}")
    print("=" * 60)
    app.run(debug=True, host='0.0.0.0', port=5000)