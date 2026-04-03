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
    local toolName = "重复"
    if LocalPlayer.Backpack:FindFirstChild(toolName) then LocalPlayer.Backpack[toolName]:Destroy() end
    if LocalPlayer.PlayerGui:FindFirstChild("RepeatToolDisplayGui") then LocalPlayer.PlayerGui.RepeatToolDisplayGui:Destroy() end
    
    local selectionBox = Instance.new("SelectionBox")
    local boxHandle = Instance.new("Part")
    boxHandle.Anchored = true
    boxHandle.CanCollide = false
    boxHandle.CanTouch = false
    boxHandle.CanQuery = false
    boxHandle.Transparency = 1
    selectionBox.LineThickness = 0.025
    selectionBox.Adornee = boxHandle
    selectionBox.Parent = boxHandle
    
    local selection, faceSelection
    local move = 0
    local amount = 10
    local angleX, angleY, angleZ = 0, 0, 0
    local mode = 0
    
    local gui = LocalPlayer.PlayerGui.TrowelToolDisplayGui:Clone()
    gui.Name = "RepeatToolDisplayGui"
    local modeImage = gui.ModeImage
    modeImage.Style = "Custom"
    modeImage.BackgroundTransparency = 1
    modeImage:ClearAllChildren()
    
    do
        local more = LocalPlayer.PlayerGui.TrowelToolDisplayGui.ModeImage.More:Clone()
        local scale = more.Scale
        local moveBox = scale:Clone()
        moveBox.Scale.Text = "移动:"
        local textBox = moveBox.TextBox:Clone()
        moveBox.TextBox.Visible = false
        textBox.Name = "TextBox2"
        textBox.FocusLost:Connect(function()
            move = tonumber(textBox.Text) or 2
            textBox.Text = move
        end)
        textBox.Text = move
        textBox.Parent = moveBox
        moveBox.ArrowNext.Visible = false
        moveBox.Parent = more
        
        local amountBox = scale:Clone()
        amountBox.Scale.Text = "次数:"
        amountBox.TextBox.FocusLost:Connect(function()
            amount = tonumber(amountBox.TextBox.Text) or 1
            amountBox.TextBox.Text = amount
        end)
        amountBox.TextBox.Text = amount
        amountBox.ArrowNext.Visible = false
        amountBox.Position = UDim2.new(0, 0, 2, 8)
        amountBox.Size = UDim2.fromScale(1, 1)
        amountBox.Visible = true
        amountBox.Parent = moveBox
        
        local angleXBox = scale:Clone()
        angleXBox.Scale.Text = "X:"
        angleXBox.TextBox.FocusLost:Connect(function()
            angleX = tonumber(angleXBox.TextBox.Text) or 0
            angleXBox.TextBox.Text = angleX
        end)
        angleXBox.TextBox.Text = angleX
        angleXBox.ArrowNext.Visible = false
        angleXBox.Position = UDim2.new(0, 0, 3, 16)
        angleXBox.Size = UDim2.fromScale(1, 1)
        angleXBox.Visible = true
        angleXBox.Parent = moveBox
        
        local angleYBox = scale:Clone()
        angleYBox.Scale.Text = "Y:"
        angleYBox.TextBox.FocusLost:Connect(function()
            angleY = tonumber(angleYBox.TextBox.Text) or 0
            angleYBox.TextBox.Text = angleY
        end)
        angleYBox.TextBox.Text = angleY
        angleYBox.ArrowNext.Visible = false
        angleYBox.Position = UDim2.new(0, 0, 4, 24)
        angleYBox.Size = UDim2.fromScale(1, 1)
        angleYBox.Visible = true
        angleYBox.Parent = moveBox
        
        local angleZBox = scale:Clone()
        angleZBox.Scale.Text = "Z:"
        angleZBox.TextBox.FocusLost:Connect(function()
            angleZ = tonumber(angleZBox.TextBox.Text) or 0
            angleZBox.TextBox.Text = angleZ
        end)
        angleZBox.TextBox.Text = angleZ
        angleZBox.ArrowNext.Visible = false
        angleZBox.Position = UDim2.new(0, 0, 5, 32)
        angleZBox.Size = UDim2.fromScale(1, 1)
        angleZBox.Visible = true
        angleZBox.Parent = moveBox
        
        local modeBox = scale:Clone()
        modeBox.Scale.Text = "模式:"
        modeBox.TextBox.FocusLost:Connect(function()
            mode = math.clamp(tonumber(modeBox.TextBox.Text) or 0, 0, 1)
            modeBox.TextBox.Text = mode
        end)
        modeBox.TextBox.Text = mode
        modeBox.ArrowNext.Visible = false
        modeBox.Position = UDim2.new(0, 0, 6, 40)
        modeBox.Size = UDim2.fromScale(1, 1)
        modeBox.Visible = true
        modeBox.Parent = moveBox
        
        scale:Destroy()
        more.Parent = modeImage
    end
    
    modeImage.Visible = false
    modeImage.Parent = gui
    gui.Parent = LocalPlayer.PlayerGui
        
    local tool = Instance.new("Tool")
    tool.Name = toolName
    tool.RequiresHandle = false
    tool.Activated:Connect(function()
        if not updateRemotes() then return end
        local primaryBlock = Mouse.Target and Mouse.Target:FindFirstAncestorOfClass("Model")
        if not primaryBlock or not primaryBlock:IsDescendantOf(workspace.Blocks) then
            boxHandle.Parent = nil
            selection = nil
            return
        end
        
        if primaryBlock == selection and Mouse.TargetSurface == faceSelection then
            local startCFrame = selection.PPart.CFrame
            local blocks = {}
            local controlling = {}
            for _, part in workspace:GetPartBoundsInBox(selection.PPart.CFrame, selection.PPart.Size) do
                if part.Name ~= "PPart" then continue end
                table.insert(blocks, part.Parent)
                if part.Parent:FindFirstChild("ControllerRef") then
                    table.insert(controlling, part)
                end
            end
            local numParts = #blocks
            OperationRF.Parent.Parent = LocalPlayer.Character
            for _, preview in boxHandle:GetChildren() do
                local controllers = {}
                for _, part in controlling do
                    if not controllers[part.Parent.ControllerRef.Value] then
                        controllers[part.Parent.ControllerRef.Value] = {}
                    end
                    controllers[part.Parent.ControllerRef.Value][preview.CFrame * preview.CFrame:ToObjectSpace(part.CFrame)] = part.Parent.Name
                end
                coroutine.wrap(function()
                    OperationRF:InvokeServer(blocks, startCFrame, preview.CFrame, "Clone")
                    for controller, controlling in controllers do
                        local objects = {}
                        for cframe, name in controlling do
                            table.insert(objects, getPartFromPosition(cframe, name).Parent.BindFire)
                        end
                        bindRemote:InvokeServer(objects, controller, -1, false)
                    end
                end)()
                task.wait(numParts * 0.06)
            end
            task.wait(1)
            OperationRF.Parent.Parent = LocalPlayer.Backpack
            selection = nil
            return
        end
        
        selection, faceSelection = primaryBlock, Mouse.TargetSurface
        boxHandle.CFrame = primaryBlock.PPart.CFrame
        boxHandle.Size = primaryBlock.PPart.Size
        boxHandle:ClearAllChildren()
        
        print(faceSelection)
        
        local last = boxHandle.CFrame
        local angles = CFrame.Angles(math.rad(angleX), math.rad(angleY), math.rad(angleZ))
        
        local pointA = CFrame.new(((boxHandle.Size.X / 2) + move), 0, -((boxHandle.Size.Z / 2) + move))
        local pointB = CFrame.new(((boxHandle.Size.X / 2) + move), 0, ((boxHandle.Size.Z / 2) + move))
        if mode == 0 then
            if faceSelection == Enum.NormalId.Back then
                pointA = CFrame.new(-((boxHandle.Size.X / 2) + move), 0, ((boxHandle.Size.Z / 2) + move))
                pointB = CFrame.new(-((boxHandle.Size.X / 2) + move), 0, -((boxHandle.Size.Z / 2) + move))
            elseif faceSelection == Enum.NormalId.Top then
                pointA = CFrame.new(0, ((boxHandle.Size.Y / 2) + move), -((boxHandle.Size.Z / 2) + move))
                pointB = CFrame.new(0, -((boxHandle.Size.Y / 2) + move), -((boxHandle.Size.Z / 2) + move))
            elseif faceSelection == Enum.NormalId.Bottom then
                pointA = CFrame.new(0, -((boxHandle.Size.Y / 2) + move), -((boxHandle.Size.Z / 2) + move))
                pointB = CFrame.new(0, ((boxHandle.Size.Y / 2) + move), -((boxHandle.Size.Z / 2) + move))
            elseif faceSelection == Enum.NormalId.Right then
                pointA = CFrame.new(((boxHandle.Size.X / 2) + move), 0, ((boxHandle.Size.Z / 2) + move))
                pointB = CFrame.new(-((boxHandle.Size.X / 2) + move), 0, ((boxHandle.Size.Z / 2) + move))
            elseif faceSelection == Enum.NormalId.Left then
                pointA = CFrame.new(-((boxHandle.Size.X / 2) + move), 0, -((boxHandle.Size.Z / 2) + move))
                pointB = CFrame.new(((boxHandle.Size.X / 2) + move), 0, -((boxHandle.Size.Z / 2) + move))
            end
        else
            pointA = CFrame.new(-((boxHandle.Size.X / 2) + move), 0, -((boxHandle.Size.Z / 2) + move))
            pointB = CFrame.new(-((boxHandle.Size.X / 2) + move), 0, ((boxHandle.Size.Z / 2) + move))
            
            if faceSelection == Enum.NormalId.Back then
                pointA = CFrame.new(((boxHandle.Size.X / 2) + move), 0, ((boxHandle.Size.Z / 2) + move))
                pointB = CFrame.new(((boxHandle.Size.X / 2) + move), 0, -((boxHandle.Size.Z / 2) + move))
            elseif faceSelection == Enum.NormalId.Top then
                pointA = CFrame.new(0, ((boxHandle.Size.Y / 2) + move), -((boxHandle.Size.Z / 2) + move))
                pointB = CFrame.new(0, -((boxHandle.Size.Y / 2) + move), -((boxHandle.Size.Z / 2) + move))
            elseif faceSelection == Enum.NormalId.Bottom then
                pointA = CFrame.new(0, -((boxHandle.Size.Y / 2) + move), ((boxHandle.Size.Z / 2) + move))
                pointB = CFrame.new(0, ((boxHandle.Size.Y / 2) + move), ((boxHandle.Size.Z / 2) + move))
            elseif faceSelection == Enum.NormalId.Right then
                pointA = CFrame.new(((boxHandle.Size.X / 2) + move), 0, -((boxHandle.Size.Z / 2) + move))
                pointB = CFrame.new(-((boxHandle.Size.X / 2) + move), 0, -((boxHandle.Size.Z / 2) + move))
            elseif faceSelection == Enum.NormalId.Left then
                pointA = CFrame.new(-((boxHandle.Size.X / 2) + move), 0, ((boxHandle.Size.Z / 2) + move))
                pointB = CFrame.new(((boxHandle.Size.X / 2) + move), 0, ((boxHandle.Size.Z / 2) + move))
            end
        end
        local preview = boxHandle:Clone()
        preview:Destroy()
        for _ = 1, amount do
            local newPreview = preview:Clone()
            newPreview.Transparency = 0.5
            newPreview.CFrame = last * pointA * angles * pointB:Inverse()
            newPreview.Parent = boxHandle
            last = newPreview.CFrame
        end
        
        boxHandle.Parent = workspace.TempStuff
    end)
    tool.Equipped:Connect(function()
        LocalPlayer.PlayerGui.LaunchBoatGui.Enabled = false
        modeImage.Visible = true
    end)
    tool.Unequipped:Connect(function()
        boxHandle.Parent = nil
        selection = nil
        modeImage.Visible = false
        LocalPlayer.PlayerGui.LaunchBoatGui.Enabled = true
    end)
    tool.Parent = LocalPlayer.Backpack
end

game:GetService("StarterGui"):SetCore("SendNotification", {
	Title = "脚本",
	Text = "已成功加载",
	Duration = 3,
})