local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer

local function onGuiAdded(gui)
    if gui.Name == "PropertiesToolDisplayGui" then
        gui:WaitForChild("ScrollingFrame").ChildAdded:Connect(function(propText)
            if propText:WaitForChild("TextNum", 0.3) and propText.TextNum:IsA("TextBox") then
                propText.TextNum.FocusLost:Connect(function()
                    local selections = {}
                    for _, descendant in workspace.Blocks:GetDescendants() do
                        if descendant.Name == "PropertiesSB" then
                            table.insert(selections, descendant.Adornee)
                        end
                    end
                    local args = {
                        [1] = propText.Name,
                        [2] = selections,
                        [3] = tonumber(propText.TextNum.Text)
                    }
                    
                    LocalPlayer.Character.PropertiesTool.SetPropertieRF:InvokeServer(unpack(args))
                end)
            end
        end)
    end
end

onGuiAdded(LocalPlayer.PlayerGui.PropertiesToolDisplayGui)
LocalPlayer.PlayerGui.ChildAdded:Connect(onGuiAdded)

game:GetService("StarterGui"):SetCore("SendNotification", {
	Title = "脚本",
	Text = "已成功加载",
	Duration = 3,
})