-- Decompiled with Velocity Script Decompiler
local v_u_1 = false
local v_u_2 = require(game.ReplicatedStorage.Scripts.PolicyService)
local v_u_3 = require(game.ReplicatedStorage.Scripts.ItemChancesInShopChest)
local v_u_4 = game.Players.LocalPlayer
function active()
    -- upvalues: (ref) v_u_1, (copy) v_u_2, (copy) v_u_4, (copy) v_u_3
    if not v_u_1 then
        v_u_1 = true
        local v5 = v_u_2:getPolicyForPlayer(v_u_4)
        local v6 = v5.ArePaidRandomItemsRestricted or v5.IsSubjectToChinaPolicies
        local v7 = script.Parent.Parent.Parent.InsideInfoFrame
        local v8 = script.Parent.Parent.FocusImage.Title.Text
        v7.Header.Text = v8
        local v9 = v7.InfoFrame.ScrollingFrameBlocks:GetChildren()
        for v10 = 1, #v9 do
            if v9[v10]:IsA("ImageButton") and v9[v10].Name ~= "ItemChanceTemplate" then
                v9[v10]:Destroy()
            end
        end
        local v11 = v7.InfoFrame.ScrollingFrameDecor:GetChildren()
        for v12 = 1, #v11 do
            if v11[v12]:IsA("ImageButton") and v11[v12].Name ~= "ItemChanceTemplate" then
                v11[v12]:Destroy()
            end
        end
        local v13 = v7.InfoFrame.ScrollingFrameSpecial:GetChildren()
        for v14 = 1, #v13 do
            if v13[v14]:IsA("ImageButton") and v13[v14].Name ~= "ItemChanceTemplate" then
                v13[v14]:Destroy()
            end
        end
        v7.TotalItems.Text = "0 blocks"
        local v15 = nil
        if v8 == "Common Chest" then
            v15 = v_u_3.green
            if v6 then
                v15 = v_u_3.greenPolicy
            end
        elseif v8 == "Uncommon Chest" then
            v15 = v_u_3.yellow
            if v6 then
                v15 = v_u_3.yellowPolicy
            end
        elseif v8 == "Rare Chest" then
            v15 = v_u_3.red
            if v6 then
                v15 = v_u_3.redPolicy
            end
        elseif v8 == "Epic Chest" then
            v15 = v_u_3.blue
            if v6 then
                v15 = v_u_3.bluePolicy
            end
        elseif v8 == "Legendary Chest" then
            v15 = v_u_3.purple
            if v6 then
                v15 = v_u_3.purplePolicy
            end
        elseif v8 == "Winter Chest" then
            v15 = v_u_3.winter
            if v6 then
                v15 = v_u_3.winterPolicy
            end
        end
        local v16 = v15.AmountGiveBlocks
        v7.BlockAmount.Text = tostring(v16)
        local v17 = v15.Blocks
        local v18 = 0
        for v19 = 1, #v17 do
            local v20 = v17[v19][1]
            local v21 = roundTo1DecimalPoint(v17[v19][2])
            local v22 = v_u_4.PlayerGui.BuildGui.InventoryFrame.ScrollingFrame.BlocksFrame[v20].Image
            local v23 = v7.InfoFrame.ScrollingFrameBlocks.ItemChanceTemplate:Clone()
            v23.Image = v22
            v23.Name = "ItemChance"
            v23.AmountText.Text = tostring(v21) .. "%"
            if v6 then
                v23.AmountText.Text = tostring(v21)
            end
            v23.LayoutOrder = v19
            v23.Visible = true
            v23.Parent = v7.InfoFrame.ScrollingFrameBlocks
            v18 = v18 + v23.AbsoluteSize.X + 6
        end
        v7.InfoFrame.ScrollingFrameBlocks.CanvasSize = UDim2.new(0, v18, 0, 0)
        local v24 = v15.AmountGiveDecors
        v7.DecorAmount.Text = tostring(v24)
        local v25 = v15.Decor
        local v26 = 0
        for v27 = 1, #v25 do
            local v28 = v25[v27][1]
            local v29 = roundTo1DecimalPoint(v25[v27][2])
            local v30 = v_u_4.PlayerGui.BuildGui.InventoryFrame.ScrollingFrame.BlocksFrame[v28].Image
            local v31 = v7.InfoFrame.ScrollingFrameDecor.ItemChanceTemplate:Clone()
            v31.Image = v30
            v31.Name = "ItemChance"
            v31.AmountText.Text = tostring(v29) .. "%"
            if v6 then
                v31.AmountText.Text = tostring(v29)
            end
            v31.LayoutOrder = v27
            v31.Visible = true
            v31.Parent = v7.InfoFrame.ScrollingFrameDecor
            v26 = v26 + v31.AbsoluteSize.X + 6
        end
        v7.InfoFrame.ScrollingFrameDecor.CanvasSize = UDim2.new(0, v26, 0, 0)
        local v32 = v15.AmountGiveSpecials
        v7.SpecialAmount.Text = tostring(v32)
        local v33 = v15.Special
        local v34 = 0
        for v35 = 1, #v33 do
            local v36 = v33[v35][1]
            local v37 = roundTo1DecimalPoint(v33[v35][2])
            local v38 = v_u_4.PlayerGui.BuildGui.InventoryFrame.ScrollingFrame.BlocksFrame[v36].Image
            local v39 = v7.InfoFrame.ScrollingFrameSpecial.ItemChanceTemplate:Clone()
            v39.Image = v38
            v39.Name = "ItemChance"
            v39.AmountText.Text = tostring(v37) .. "%"
            if v6 then
                v39.AmountText.Text = tostring(v37)
            end
            v39.LayoutOrder = v35
            v39.Visible = true
            v39.Parent = v7.InfoFrame.ScrollingFrameSpecial
            v34 = v34 + v39.AbsoluteSize.X + 6
        end
        v7.InfoFrame.ScrollingFrameSpecial.CanvasSize = UDim2.new(0, v34, 0, 0)
        local v40 = v7.TotalItems
        local v41 = v16 + v24 + v32
        v40.Text = tostring(v41) .. " blocks"
        if v6 then
            v7.InfoFrame.OddsNote.Text = ""
        end
        v7.Visible = not v7.Visible
        wait(0.1)
        v_u_1 = false
    end
end
function roundTo1DecimalPoint(p42)
    local v43 = p42 * 10 + 0.5
    return math.floor(v43) / 10
end
script.Parent.MouseButton1Click:connect(active)
