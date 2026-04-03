local plr = game:GetService("Players").LocalPlayer
local char = plr.Character

local BindGui = Instance.new("ScreenGui")
local UnbindAll = Instance.new("TextButton")
local UISizeConstraint = Instance.new("UISizeConstraint")

BindGui.Name = "BindGui"
if syn and not gethui then 
	syn.protect_gui(BindGui)
end
if not gethui then
    BindGui.Parent = game.CoreGui
else 
    BindGui.Parent = gethui()
end
BindGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
BindGui.DisplayOrder = 6

UnbindAll.Name = "UnbindAll"
UnbindAll.Parent = BindGui
UnbindAll.BackgroundColor3 = Color3.fromRGB(231, 0, 0)
UnbindAll.BorderSizePixel = 0
UnbindAll.Position = UDim2.new(0, 0, 0.100000001, 0)
UnbindAll.Size = UDim2.new(0.150000006, 0, 0.0799999982, 0)
UnbindAll.Style = Enum.ButtonStyle.RobloxRoundButton
UnbindAll.Font = Enum.Font.SourceSansBold
UnbindAll.Text = "Unbind all"
UnbindAll.TextColor3 = Color3.fromRGB(255, 69, 69)
UnbindAll.TextScaled = true
UnbindAll.TextSize = 30.000
UnbindAll.TextStrokeTransparency = 0.000
UnbindAll.TextWrapped = true
UnbindAll.Visible = false
UnbindAll.MouseButton1Click:Connect(function()
	s,e = pcall(function()
	local tool = char:FindFirstChild("BindTool")
	local targets = {}
	local obj
	for i,v in pairs(tool.BItemOptionSBs:GetChildren()) do 
		if v.Color3 ~= Color3.fromRGB(155, 60, 172) then 
			table.insert(targets, v.Adornee)
		end
	end
	for i,v in pairs(game.Workspace:GetChildren()) do 
		if v:FindFirstChild("BindingSB") and v.Tag.Value == plr.Name then 
			obj = v
		end
	end
	for i,target in pairs(targets) do 
		spawn(function()
			for i,v in pairs(target:GetChildren()) do 
				if v:IsA("IntValue") and string.find(v.Name, "Bind") then 
					tool.RF:InvokeServer({v}, obj, v.Value, true)
				end
			end
		end)
	end
	end)
        if not s then 
	print(e)
        end
end)

UISizeConstraint.Parent = UnbindAll
UISizeConstraint.MinSize = Vector2.new(110, 0)

local BindGui

function ActivateGui()
	plr.PlayerGui.LaunchBoatGui.Enabled = false
	UnbindAll.Visible = true
end
function DeactivateGui()
	plr.PlayerGui.LaunchBoatGui.Enabled = true
	UnbindAll.Visible = false
end
char.ChildAdded:Connect(function(child)
		if child.Name == "BindTool" then 
			ActivateGui()
		end
end)
char.ChildRemoved:Connect(function(child)
		if child.Name == "BindTool" then 
			DeactivateGui()
		end
end)

plr.CharacterAdded:Connect(function(c)
	char = c
	c.ChildAdded:Connect(function(child)
		if child.Name == "BindTool" then 
			ActivateGui()
		end
	end)
	c.ChildRemoved:Connect(function(child)
		if child.Name == "BindTool" then 
			DeactivateGui()
		end
	end)
end)
