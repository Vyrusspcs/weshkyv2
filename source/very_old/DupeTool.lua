local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Data = LocalPlayer.Data

local BuildingParts = game:GetService("ReplicatedStorage").BuildingParts
local TypeProperties = require(LocalPlayer.StarterGear.PropertiesTool.TypeProperties)

local function getPartFromPosition(position, name)
    for _, part in workspace:GetPartBoundsInBox(position, Vector3.one) do
        if part.Parent.Name == name then
            return part
        end
    end
    return nil
end

function updateRemotes()
    local success = pcall(function()
        OperationRF = LocalPlayer.Backpack.TrowelTool.OperationRF
        buildRemote = LocalPlayer.Backpack.BuildingTool.RF
        scaleRemote = LocalPlayer.Backpack.ScalingTool.RF
        deleteRemote = LocalPlayer.Backpack.DeleteTool.RF
        propertiesRemote = LocalPlayer.Backpack.PropertiesTool.SetPropertieRF
        paintRemote = LocalPlayer.Backpack.PaintingTool.RF
        bindRemote = LocalPlayer.Backpack.BindTool.RF
    end)
    
    return success
end

do
    local toolName = "复制"
    if LocalPlayer.Backpack:FindFirstChild(toolName) then LocalPlayer.Backpack[toolName]:Destroy() end
    if LocalPlayer.PlayerGui:FindFirstChild("DupeToolDisplayGui") then LocalPlayer.PlayerGui.DupeToolDisplayGui:Destroy() end
    
    local selectionBox = Instance.new("SelectionBox")
    local handles = Instance.new("Handles")
    local boxHandle = Instance.new("Part")
    boxHandle.Anchored = true
    boxHandle.CanCollide = false
    boxHandle.CanTouch = false
    boxHandle.CanQuery = false
    boxHandle.Transparency = 1
    selectionBox.LineThickness = 0.025
    selectionBox.Adornee = boxHandle
    selectionBox.Parent = boxHandle
    handles.Style = Enum.HandlesStyle.Movement
    handles.Adornee = boxHandle
    
    local selection
    local move = 0.05
    
    local gui = LocalPlayer.PlayerGui.TrowelToolDisplayGui:Clone()
    gui.Name = "DupeToolDisplayGui"
    local modeImage = gui.ModeImage
    modeImage.Style = "Custom"
    modeImage.BackgroundTransparency = 1
    modeImage:ClearAllChildren()
    local more = LocalPlayer.PlayerGui.TrowelToolDisplayGui.ModeImage.More:Clone()
    more.Scale.Scale.Text = "间隔:"
    more.Scale.TextBox.FocusLost:Connect(function()
        move = tonumber(more.Scale.TextBox.Text) or 2
        more.Scale.TextBox.Text = move
    end)
    more.Scale.ArrowNext.Visible = false
    more.Parent = modeImage
    modeImage.Visible = false
    modeImage.Parent = gui
    gui.Parent = LocalPlayer.PlayerGui
    
    handles.MouseDrag:Connect(function(face, distance)
        boxHandle.CFrame = selection.PPart.CFrame * CFrame.new(Vector3.FromNormalId(face) * (math.round(distance / move) * move))
    end)
    
    handles.MouseButton1Down:Connect(function()
        workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
    end)
    handles.MouseButton1Up:Connect(function()
        workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
        local startCFrame = selection.PPart.CFrame
        local position = startCFrame * CFrame.new(0, 0, (selection.PPart.Size.Z / 2 + 0.4)) * CFrame.Angles(math.rad(-90), 0, 0)
        buildRemote:InvokeServer(Data.Piston.Name, Data.Piston.Value, nil, nil, true, position, false)
        local piston = getPartFromPosition(position, Data.Piston.Name).Parent
        propertiesRemote.Parent.Parent = LocalPlayer.Character
        local unanchorBlocks = {}
        local blocks = {}
        local controllers = {}
        for _, part in selection.PPart:GetConnectedParts() do
            if part.Name ~= "PPart" then continue end
            if part.Parent ~= piston then
                if part.Anchored then
                    table.insert(unanchorBlocks, part.Parent)
                end
                table.insert(blocks, part.Parent)
                if part.Parent:FindFirstChild("ControllerRef") then
                    if not controllers[part.Parent.ControllerRef.Value] then
                        controllers[part.Parent.ControllerRef.Value] = {}
                    end
                    controllers[part.Parent.ControllerRef.Value][startCFrame * CFrame.new(0, selection.PPart.Size.Y, 0) * startCFrame:ToObjectSpace(part.CFrame)] = part.Parent.Name
                end
            end
        end
        propertiesRemote:InvokeServer("Anchored", unanchorBlocks)
        propertiesRemote:InvokeServer("Piston speed", {piston}, 9e9)
        propertiesRemote:InvokeServer("Piston length", {piston}, 600)
        fireclickdetector(piston.ClickDetector)
        task.wait(1)
        buildRemote.Parent.Parent = LocalPlayer.Character
        propertiesRemote:InvokeServer("Anchored", unanchorBlocks)
        OperationRF.Parent.Parent = LocalPlayer.Character
        OperationRF:InvokeServer(blocks, selection.PPart.CFrame, boxHandle.CFrame, "Clone")
        for controller, controlling in controllers do
            local objects = {}
            for cframe, name in controlling do
                table.insert(objects, getPartFromPosition(cframe, name).Parent.BindFire)
            end
            bindRemote:InvokeServer(objects, controller, -1, false)
        end
        OperationRF.Parent.Parent = LocalPlayer.Backpack
        buildRemote.Parent.Parent = LocalPlayer.Backpack
        propertiesRemote:InvokeServer("Anchored", unanchorBlocks)
        fireclickdetector(piston.ClickDetector)
        task.wait(1)
        propertiesRemote:InvokeServer("Anchored", unanchorBlocks)
        propertiesRemote.Parent.Parent = LocalPlayer.Backpack
        deleteRemote:InvokeServer(piston)
        
        selection = getPartFromPosition(boxHandle.CFrame, selection.Name).Parent
    end)
    
    local tool = Instance.new("Tool")
    tool.Name = toolName
    tool.RequiresHandle = false
    tool.Activated:Connect(function()
        if not updateRemotes() then return end
        local primaryBlock = Mouse.Target and Mouse.Target:FindFirstAncestorOfClass("Model")
        if not primaryBlock then
            boxHandle.Parent = nil
            handles.Parent = nil
            return
        end
        selection = primaryBlock
        boxHandle.CFrame = primaryBlock.PPart.CFrame
        boxHandle.Size = primaryBlock.PPart.Size
        boxHandle.Parent = workspace.TempStuff
        handles.Parent = LocalPlayer.PlayerGui
    end)
    tool.Equipped:Connect(function()
        LocalPlayer.PlayerGui.LaunchBoatGui.Enabled = false
        modeImage.Visible = true
    end)
    tool.Unequipped:Connect(function()
        boxHandle.Parent = nil
        handles.Parent = nil
        modeImage.Visible = false
        LocalPlayer.PlayerGui.LaunchBoatGui.Enabled = true
    end)
    tool.Parent = LocalPlayer.Backpack
end


do
    local toolName = "移动"
    if LocalPlayer.Backpack:FindFirstChild(toolName) then LocalPlayer.Backpack[toolName]:Destroy() end
    local tool = Instance.new("Tool")
    tool.Name = toolName
    tool.RequiresHandle = false
    tool.Activated:Connect(function()
        if not updateRemotes() then return end
        local primaryBlock = Mouse.Target and Mouse.Target:FindFirstAncestorOfClass("Model")
        if not primaryBlock then return end
        local startCFrame = primaryBlock.PPart.CFrame
        local position = startCFrame * CFrame.new(0, 0, (primaryBlock.PPart.Size.Z / 2 + 0.4)) * CFrame.Angles(math.rad(-90), 0, 0)
        buildRemote:InvokeServer(Data.Piston.Name, Data.Piston.Value, nil, nil, true, position, false)
        local piston = getPartFromPosition(position, Data.Piston.Name).Parent
        propertiesRemote.Parent.Parent = LocalPlayer.Character
        local unanchorBlocks = {}
        for _, part in primaryBlock.PPart:GetConnectedParts() do
            if part.Name ~= "PPart" then continue end
            if part.Parent ~= piston then
                if part.Anchored then
                    table.insert(unanchorBlocks, part.Parent)
                end
            end
        end
        propertiesRemote:InvokeServer("Anchored", unanchorBlocks)
        propertiesRemote:InvokeServer("Piston speed", {piston}, 9e9)
        propertiesRemote:InvokeServer("Piston length", {piston}, 600)
        propertiesRemote.Parent.Parent = LocalPlayer.Backpack
        fireclickdetector(piston.ClickDetector)
    end)
    tool.Parent = LocalPlayer.Backpack
end

game:GetService("StarterGui"):SetCore("SendNotification", {
	Title = "脚本",
	Text = "已成功加载",
	Duration = 3,
})