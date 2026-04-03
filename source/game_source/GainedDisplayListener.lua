-- Decompiled with Velocity Script Decompiler
local v_u_1 = game.Players.LocalPlayer
local v2 = v_u_1:WaitForChild("Data")
function newItem(p_u_3)
    -- upvalues: (copy) v_u_1
    local v_u_4 = p_u_3.Value
    p_u_3:GetPropertyChangedSignal("Value"):Connect(function()
        -- upvalues: (copy) p_u_3, (ref) v_u_4, (ref) v_u_1
        local v5 = p_u_3.Value - v_u_4
        v_u_4 = p_u_3.Value
        v_u_1:WaitForChild("PlayerGui"):WaitForChild("ItemGained"):WaitForChild("DisplayGainedItem"):Fire(p_u_3.Name, v5)
    end)
end
repeat
    wait(1)
until v_u_1.Save.Value
local v6 = v2:GetChildren()
v2.ChildAdded:Connect(newItem)
for v7 = 1, #v6 do
    newItem(v6[v7])
end

