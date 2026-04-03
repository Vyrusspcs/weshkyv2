-- Decompiled with Velocity Script Decompiler
local v_u_1 = game:GetService("GroupService")
local v_u_2 = game.Players.LocalPlayer
local v_u_3 = script.Parent:WaitForChild("Frame"):WaitForChild("SideFrame")
local v_u_4 = script.Parent.Frame
local v_u_5 = v_u_4:WaitForChild("JoinButton")
local v6 = v_u_2:WaitForChild("OtherData")
local v7 = v6:WaitForChild("Stage0")
local v8 = v6:WaitForChild("Stage1")
local v9 = v6:WaitForChild("Stage2")
local v10 = v6:WaitForChild("Stage3")
local v11 = v6:WaitForChild("Stage4")
local v12 = v6:WaitForChild("Stage5")
local v13 = v6:WaitForChild("Stage6")
local v14 = v6:WaitForChild("Stage7")
local v15 = v6:WaitForChild("Stage8")
local v16 = v6:WaitForChild("Stage9")
local v17 = v6:WaitForChild("End")
function isCompeting()
    -- upvalues: (copy) v_u_2
    local v18 = workspace.Challenge.Teams:GetChildren()
    for v19 = 1, #v18 do
        if v18[v19].Value == v_u_2.Team then
            return true
        end
    end
end
function doJustDiscoveredEffect(p20, p21)
    for _ = 1, 10 do
        makeStar(p20, p21)
        wait(0.1)
    end
end
function makeStar(p22, p23)
    local v24 = { Color3.fromRGB(255, 149, 28), Color3.fromRGB(255, 221, 23), Color3.fromRGB(241, 255, 206) }
    local v25 = Instance.new("ImageLabel")
    v25.BackgroundTransparency = 1
    v25.Name = "Star"
    v25.AnchorPoint = Vector2.new(0, 0.5)
    v25.Position = p22.Position
    v25.Size = UDim2.new(1, 0, 0.06, 0)
    v25.ImageColor3 = v24[math.random(1, #v24)]
    v25.ScaleType = Enum.ScaleType.Fit
    v25.ZIndex = 1
    v25.Image = "http://www.roblox.com/asset/?id=5625171018"
    game.Debris:AddItem(v25, 0.5)
    v25.Parent = p23
    local v26 = math.random(0, 100) / 100
    local v27 = 1 - v26
    local v28 = math.random(0, 1)
    local v29 = v28 == 0 and -1 or v28
    local v30 = math.random(0, 1)
    local v31 = v30 == 0 and -1 or v30
    local v32 = v26 * v29
    local v33 = v27 * v31
    v25:TweenPosition(v25.Position + UDim2.new(v32 * 0.5, 0, v33 * 0.1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Linear, 0.5)
end
local v34 = false
while isCompeting() do
    wait(2)
    v34 = true
end
while v_u_2.PlayerGui:FindFirstChild("ChallengeResults") do
    wait(1.2)
    v34 = true
end
if v34 then
    wait(3.2)
end
local v_u_35 = false
if v7.Value ~= "" or (v8.Value ~= "" or (v9.Value ~= "" or (v10.Value ~= "" or (v11.Value ~= "" or (v12.Value ~= "" or (v13.Value ~= "" or (v14.Value ~= "" or (v15.Value ~= "" or (v16.Value ~= "" or v17.Value ~= ""))))))))) then
    v_u_4.BuyButton.MouseButton1Down:Connect(function()
        -- upvalues: (copy) v_u_4
        v_u_4.BuyButton.Roundify1.Position = UDim2.new(0, -3, 0, -3)
    end)
    v_u_4.BuyButton.MouseButton1Up:Connect(function()
        -- upvalues: (copy) v_u_4
        v_u_4.BuyButton.Roundify1.Position = UDim2.new(0, 0, 0, 0)
    end)
    v_u_5.MouseButton1Click:Connect(function()
        -- upvalues: (copy) v_u_4, (copy) v_u_1
        if v_u_4.GroupIcon.Visible then
            local v36 = v_u_1:PromptJoinAsync(2782840)
            workspace.UpdateGroupMembershipStatus:FireServer(v36)
        elseif v_u_4.DoubleGoldIcon.Visible then
            workspace.PromptRobuxEvent:InvokeServer(851864421, "Asset")
        end
    end)
    function claim()
        -- upvalues: (ref) v_u_35, (copy) v_u_4
        if not v_u_35 then
            v_u_35 = true
            workspace.ClaimRiverResultsGold:FireServer()
            v_u_4:TweenPosition(v_u_4.Position + UDim2.new(1, 0, 0, 0), Enum.EasingDirection.In, Enum.EasingStyle.Linear, 0.2)
            wait(0.2)
            v_u_4.Visible = false
            game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
        end
    end
    v_u_4.BuyButton.MouseButton1Click:Connect(claim)
    v_u_4.ExitButton.MouseButton1Click:Connect(claim)
    local v_u_37 = v_u_2:WaitForChild("Data"):WaitForChild("Gold"):WaitForChild("Multiplier")
    local v_u_38 = v_u_37.Value
    v_u_37:GetPropertyChangedSignal("Value"):Connect(function()
        -- upvalues: (ref) v_u_38, (copy) v_u_37
        v_u_38 = v_u_37.Value
    end)
    local v39 = UDim2.new(0.3, 0, 0.95, 0)
    local v40 = 1
    local v_u_41 = 0
    local v42 = 0
    for v43 = 1, 9 do
        v_u_3.RiverStages["StageIcon" .. tostring(v43)].Image = workspace.BoatStages.StageInfo["Stage" .. tostring(v43)].StageIcon.Value
        local v44 = workspace.BoatStages.StageInfo["Stage" .. tostring(v43)].StageName.Value
        if v_u_2.OtherData:FindFirstChild(v44) then
            v_u_3.RiverStages["StageIcon" .. tostring(v43)].ImageColor3 = Color3.fromRGB(255, 255, 255)
        end
    end
    v_u_3.StartIcon.SpawnPart.ImageColor3 = v_u_2.TeamColor.Color
    v_u_3.StartIcon.TipBallPart.ImageColor3 = v_u_2.TeamColor.Color
    v_u_3.PlayerArrow.ImageColor3 = v_u_2.TeamColor.Color
    function hintGamepass()
        -- upvalues: (copy) v_u_4, (copy) v_u_5
        v_u_4.Tip.Text = "Tip: Purchase the double gold gamepass for extra gold per run! (x2)"
        v_u_4.Tip.Visible = true
        v_u_4.GroupIcon.Visible = false
        v_u_4.DoubleGoldIcon.Visible = true
        v_u_5.Text = "Buy"
        v_u_5.Visible = true
    end
    function hintGroup()
        -- upvalues: (copy) v_u_4, (copy) v_u_5
        v_u_4.Tip.Text = "Tip: Join the Chillz Studios group for extra gold per run! (x1.25)"
        v_u_4.Tip.Visible = true
        v_u_4.GroupIcon.Visible = true
        v_u_4.DoubleGoldIcon.Visible = false
        v_u_5.Text = "Join"
        v_u_5.Visible = true
    end
    function hintNothing()
        -- upvalues: (copy) v_u_4, (copy) v_u_5
        v_u_4.Tip.Visible = false
        v_u_4.GroupIcon.Visible = false
        v_u_4.DoubleGoldIcon.Visible = false
        v_u_5.Visible = false
    end
    local v45 = v_u_2:FindFirstChild("GroupRoll")
    if v45 then
        v45 = v_u_2.GroupRoll:FindFirstChild("RankNumber")
    end
    if not v45 then
        for _ = 1, 25 do
            task.wait(0.1)
            local v46 = v_u_2:FindFirstChild("GroupRoll")
            if v46 then
                v46 = v_u_2.GroupRoll:FindFirstChild("RankNumber")
            end
            if v46 then
                break
            end
        end
    end
    if v_u_38 == 2 then
        hintGroup()
    elseif v_u_38 == 1.25 then
        hintGamepass()
    elseif v_u_38 == 2.25 then
        hintNothing()
    elseif math.random(0, 1) == 1 then
        hintGroup()
    else
        hintGamepass()
    end
    function getStageName(p47)
        local v48 = game.ReplicatedStorage.StageIcons:GetChildren()
        for v49 = 1, #v48 do
            if string.upper(v48[v49].Name) == string.upper(p47) then
                return v48[v49].Name
            end
        end
        return "FlowerStage"
    end
    if v8.Value ~= "" then
        local v50 = v8.Value == string.upper(v8.Value)
        v_u_41 = 1
        v40 = v40 + 1
        v39 = UDim2.new(0.3, 0, 0.85, 0)
        local v51 = getStageName(v8.Value)
        v_u_3.RiverStages.StageIcon1.Image = game.ReplicatedStorage.StageIcons[v51].Value
        if v_u_2.OtherData:FindFirstChild(v51) and not v50 then
            v_u_3.RiverStages.StageIcon1.ImageColor3 = Color3.fromRGB(255, 255, 255)
        else
            v_u_3.RiverStages.StageIcon1.ImageColor3 = Color3.fromRGB(0, 0, 0)
        end
    end
    if v9.Value ~= "" then
        local v52 = v9.Value == string.upper(v9.Value)
        v_u_41 = 2
        v40 = v40 + 1
        v39 = UDim2.new(0.3, 0, 0.75, 0)
        local v53 = getStageName(v9.Value)
        v_u_3.RiverStages.StageIcon2.Image = game.ReplicatedStorage.StageIcons[v53].Value
        if v_u_2.OtherData:FindFirstChild(v53) and not v52 then
            v_u_3.RiverStages.StageIcon2.ImageColor3 = Color3.fromRGB(255, 255, 255)
        else
            v_u_3.RiverStages.StageIcon2.ImageColor3 = Color3.fromRGB(0, 0, 0)
        end
    end
    if v10.Value ~= "" then
        local v54 = v10.Value == string.upper(v10.Value)
        v_u_41 = 3
        v40 = v40 + 1
        v39 = UDim2.new(0.3, 0, 0.65, 0)
        local v55 = getStageName(v10.Value)
        v_u_3.RiverStages.StageIcon3.Image = game.ReplicatedStorage.StageIcons[v55].Value
        if v_u_2.OtherData:FindFirstChild(v55) and not v54 then
            v_u_3.RiverStages.StageIcon3.ImageColor3 = Color3.fromRGB(255, 255, 255)
        else
            v_u_3.RiverStages.StageIcon3.ImageColor3 = Color3.fromRGB(0, 0, 0)
        end
    end
    if v11.Value ~= "" then
        local v56 = v11.Value == string.upper(v11.Value)
        v_u_41 = 4
        v40 = v40 + 1
        v39 = UDim2.new(0.3, 0, 0.55, 0)
        local v57 = getStageName(v11.Value)
        v_u_3.RiverStages.StageIcon4.Image = game.ReplicatedStorage.StageIcons[v57].Value
        if v_u_2.OtherData:FindFirstChild(v57) and not v56 then
            v_u_3.RiverStages.StageIcon4.ImageColor3 = Color3.fromRGB(255, 255, 255)
        else
            v_u_3.RiverStages.StageIcon4.ImageColor3 = Color3.fromRGB(0, 0, 0)
        end
    end
    if v12.Value ~= "" then
        local v58 = v12.Value == string.upper(v12.Value)
        v_u_41 = 5
        v40 = v40 + 1
        v39 = UDim2.new(0.3, 0, 0.45, 0)
        local v59 = getStageName(v12.Value)
        v_u_3.RiverStages.StageIcon5.Image = game.ReplicatedStorage.StageIcons[v59].Value
        if v_u_2.OtherData:FindFirstChild(v59) and not v58 then
            v_u_3.RiverStages.StageIcon5.ImageColor3 = Color3.fromRGB(255, 255, 255)
        else
            v_u_3.RiverStages.StageIcon5.ImageColor3 = Color3.fromRGB(0, 0, 0)
        end
    end
    if v13.Value ~= "" then
        local v60 = v13.Value == string.upper(v13.Value)
        v_u_41 = 6
        v40 = v40 + 1
        v39 = UDim2.new(0.3, 0, 0.35, 0)
        local v61 = getStageName(v13.Value)
        v_u_3.RiverStages.StageIcon6.Image = game.ReplicatedStorage.StageIcons[v61].Value
        if v_u_2.OtherData:FindFirstChild(v61) and not v60 then
            v_u_3.RiverStages.StageIcon6.ImageColor3 = Color3.fromRGB(255, 255, 255)
        else
            v_u_3.RiverStages.StageIcon6.ImageColor3 = Color3.fromRGB(0, 0, 0)
        end
    end
    if v14.Value ~= "" then
        local v62 = v14.Value == string.upper(v14.Value)
        v_u_41 = 7
        v40 = v40 + 1
        v39 = UDim2.new(0.3, 0, 0.25, 0)
        local v63 = getStageName(v14.Value)
        v_u_3.RiverStages.StageIcon7.Image = game.ReplicatedStorage.StageIcons[v63].Value
        if v_u_2.OtherData:FindFirstChild(v63) and not v62 then
            v_u_3.RiverStages.StageIcon7.ImageColor3 = Color3.fromRGB(255, 255, 255)
        else
            v_u_3.RiverStages.StageIcon7.ImageColor3 = Color3.fromRGB(0, 0, 0)
        end
    end
    if v15.Value ~= "" then
        local v64 = v15.Value == string.upper(v15.Value)
        v_u_41 = 8
        v40 = v40 + 1
        v39 = UDim2.new(0.3, 0, 0.15, 0)
        local v65 = getStageName(v15.Value)
        v_u_3.RiverStages.StageIcon8.Image = game.ReplicatedStorage.StageIcons[v65].Value
        if v_u_2.OtherData:FindFirstChild(v65) and not v64 then
            v_u_3.RiverStages.StageIcon8.ImageColor3 = Color3.fromRGB(255, 255, 255)
        else
            v_u_3.RiverStages.StageIcon8.ImageColor3 = Color3.fromRGB(0, 0, 0)
        end
    end
    if v16.Value ~= "" then
        local v66 = v16.Value == string.upper(v16.Value)
        v_u_41 = 9
        local _ = v40 + 1
        v39 = UDim2.new(0.3, 0, 0.05, 0)
        local v67 = getStageName(v16.Value)
        v_u_3.RiverStages.StageIcon9.Image = game.ReplicatedStorage.StageIcons[v67].Value
        if v_u_2.OtherData:FindFirstChild(v67) and not v66 then
            v_u_3.RiverStages.StageIcon9.ImageColor3 = Color3.fromRGB(255, 255, 255)
        else
            v_u_3.RiverStages.StageIcon9.ImageColor3 = Color3.fromRGB(0, 0, 0)
        end
    end
    if v17.Value ~= "" then
        local v68 = v17.Value == string.upper(v17.Value)
        v_u_41 = 10
        local _ = v42 + 1
        v39 = UDim2.new(0.3, 0, -0.05, 0)
        if v68 then
            v_u_3.EndIcon.ImageColor3 = Color3.fromRGB(0, 0, 0)
        else
            v_u_3.EndIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
        end
    end
    local v69 = workspace
    local v70 = v_u_2.TeamColor
    local _ = v69[tostring(v70) .. "Zone"]
    local v71 = v_u_4.Position
    v_u_4.Position = v_u_4.Position + UDim2.new(1, 0, 0, 0)
    v_u_4.Visible = true
    game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
    v_u_4:TweenPosition(v71, Enum.EasingDirection.In, Enum.EasingStyle.Linear, 0.2)
    wait(1.6)
    if v_u_2:FindFirstChild("PlayerThumbnailHistory") then
        v_u_3.PlayerArrow.PlayerImage.Image = v_u_2.PlayerThumbnailHistory.Value
    else
        local v72, v73 = game.Players:GetUserThumbnailAsync(v_u_2.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
        v_u_3.PlayerArrow.PlayerImage.Image = not v73 and "" or v72
    end
    local v74 = v_u_3.PlayerArrow
    local v75 = Enum.EasingDirection.In
    local v76 = Enum.EasingStyle.Linear
    local v77 = v_u_41 * 0.06
    v74:TweenPosition(v39, v75, v76, (math.max(v77, 0.06)))
    v_u_4.GoldGained.Text = tostring(8)
    script.Parent.Sound:Play()
    spawn(function()
        -- upvalues: (ref) v_u_41
        local v78 = wait
        local v79 = v_u_41 * 0.06
        v78((math.max(v79, 0.06)))
        script.Parent.Sound:Stop()
    end)
    local v_u_80 = 0
    local v81 = v_u_4.GoldGained:Clone()
    local v82 = v_u_4.Plus1:Clone()
    v81.Visible = true
    v82.Visible = true
    v81.Position = UDim2.new(0.66, 0, 0.42, 0)
    v82.Position = UDim2.new(0.73, 0, 0.42, 0)
    v81.Parent = v_u_4
    v82.Parent = v_u_4
    function updateNumbers()
        -- upvalues: (copy) v_u_4, (ref) v_u_80, (ref) v_u_38
        local v83 = v_u_4.TotalGoldGained
        local v84 = v_u_80 * v_u_38
        local v85 = math.ceil(v84)
        v83.Text = tostring(v85)
        local v86 = v_u_80
        local v87 = tostring(v86)
        local v88 = v_u_38
        v_u_4.Formula.Text = v87 .. " x " .. tostring(v88) .. " ="
    end
    v_u_80 = v_u_80 + 8
    updateNumbers()
    if v_u_38 ~= 1 then
        v_u_4.Formula.Visible = true
    end
    wait(0.03)
    local v89
    if v8.Value == "" then
        v89 = v_u_80
    else
        local v90 = v_u_4.GoldGained:Clone()
        local v91 = v_u_4.Plus1:Clone()
        v90.Visible = true
        v91.Visible = true
        v90.Position = UDim2.new(0.66, 0, 0.36, 0)
        v91.Position = UDim2.new(0.73, 0, 0.36, 0)
        v90.Parent = v_u_4
        v91.Parent = v_u_4
        v_u_80 = v_u_80 + 8
        updateNumbers()
        if v8.Value == string.upper(v8.Value) then
            local v92 = v_u_4.TreasureGained:Clone()
            local v93 = v_u_4.Plus2:Clone()
            v92.Visible = true
            v93.Visible = true
            v92.Position = UDim2.new(0.88, 0, 0.36, 0)
            v93.Position = UDim2.new(0.98, 0, 0.36, 0)
            v92.GoldImage.Image = "http://www.roblox.com/asset/?id=5176251125"
            v92.Parent = v_u_4
            v93.Parent = v_u_4
            v_u_3.RiverStages.StageIcon1.ImageColor3 = Color3.fromRGB(255, 255, 255)
            spawn(function()
                -- upvalues: (copy) v_u_3
                doJustDiscoveredEffect(v_u_3.RiverStages.StageIcon1, v_u_3.RiverStages)
            end)
            v89 = v_u_80
        else
            v89 = v_u_80
        end
    end
    wait(0.06)
    if v9.Value ~= "" then
        local v94 = v_u_4.GoldGained:Clone()
        local v95 = v_u_4.Plus1:Clone()
        v94.Visible = true
        v95.Visible = true
        v94.Position = UDim2.new(0.66, 0, 0.3, 0)
        v95.Position = UDim2.new(0.73, 0, 0.3, 0)
        v94.Parent = v_u_4
        v95.Parent = v_u_4
        v_u_80 = v89 + 8
        updateNumbers()
        if v9.Value == string.upper(v9.Value) then
            local v96 = v_u_4.TreasureGained:Clone()
            local v97 = v_u_4.Plus2:Clone()
            v96.Visible = true
            v97.Visible = true
            v96.Position = UDim2.new(0.88, 0, 0.3, 0)
            v97.Position = UDim2.new(0.98, 0, 0.3, 0)
            v96.GoldImage.Image = "http://www.roblox.com/asset/?id=5176251125"
            v96.Parent = v_u_4
            v97.Parent = v_u_4
            v_u_3.RiverStages.StageIcon2.ImageColor3 = Color3.fromRGB(255, 255, 255)
            spawn(function()
                -- upvalues: (copy) v_u_3
                doJustDiscoveredEffect(v_u_3.RiverStages.StageIcon2, v_u_3.RiverStages)
            end)
            v89 = v_u_80
        else
            v89 = v_u_80
        end
    end
    wait(0.06)
    if v10.Value ~= "" then
        local v98 = v_u_4.GoldGained:Clone()
        local v99 = v_u_4.Plus1:Clone()
        v98.Visible = true
        v99.Visible = true
        v98.Position = UDim2.new(0.66, 0, 0.24, 0)
        v99.Position = UDim2.new(0.73, 0, 0.24, 0)
        v98.Parent = v_u_4
        v99.Parent = v_u_4
        v_u_80 = v89 + 8
        updateNumbers()
        if v10.Value == string.upper(v10.Value) then
            local v100 = v_u_4.TreasureGained:Clone()
            local v101 = v_u_4.Plus2:Clone()
            v100.Visible = true
            v101.Visible = true
            v100.Position = UDim2.new(0.88, 0, 0.24, 0)
            v101.Position = UDim2.new(0.98, 0, 0.24, 0)
            v100.GoldImage.Image = "http://www.roblox.com/asset/?id=5176250512"
            v100.Parent = v_u_4
            v101.Parent = v_u_4
            v_u_3.RiverStages.StageIcon3.ImageColor3 = Color3.fromRGB(255, 255, 255)
            spawn(function()
                -- upvalues: (copy) v_u_3
                doJustDiscoveredEffect(v_u_3.RiverStages.StageIcon3, v_u_3.RiverStages)
            end)
            v89 = v_u_80
        else
            v89 = v_u_80
        end
    end
    wait(0.06)
    if v11.Value ~= "" then
        local v102 = v_u_4.GoldGained:Clone()
        local v103 = v_u_4.Plus1:Clone()
        v102.Visible = true
        v103.Visible = true
        v102.Position = UDim2.new(0.66, 0, 0.18, 0)
        v103.Position = UDim2.new(0.73, 0, 0.18, 0)
        v102.Parent = v_u_4
        v103.Parent = v_u_4
        v_u_80 = v89 + 8
        updateNumbers()
        if v11.Value == string.upper(v11.Value) then
            local v104 = v_u_4.TreasureGained:Clone()
            local v105 = v_u_4.Plus2:Clone()
            v104.Visible = true
            v105.Visible = true
            v104.Position = UDim2.new(0.88, 0, 0.18, 0)
            v105.Position = UDim2.new(0.98, 0, 0.18, 0)
            v104.GoldImage.Image = "http://www.roblox.com/asset/?id=5176250512"
            v104.Parent = v_u_4
            v105.Parent = v_u_4
            v_u_3.RiverStages.StageIcon4.ImageColor3 = Color3.fromRGB(255, 255, 255)
            spawn(function()
                -- upvalues: (copy) v_u_3
                doJustDiscoveredEffect(v_u_3.RiverStages.StageIcon4, v_u_3.RiverStages)
            end)
            v89 = v_u_80
        else
            v89 = v_u_80
        end
    end
    wait(0.06)
    if v12.Value ~= "" then
        local v106 = v_u_4.GoldGained:Clone()
        local v107 = v_u_4.Plus1:Clone()
        v106.Visible = true
        v107.Visible = true
        v106.Position = UDim2.new(0.66, 0, 0.12, 0)
        v107.Position = UDim2.new(0.73, 0, 0.12, 0)
        v106.Parent = v_u_4
        v107.Parent = v_u_4
        v_u_80 = v89 + 8
        updateNumbers()
        if v12.Value == string.upper(v12.Value) then
            local v108 = v_u_4.TreasureGained:Clone()
            local v109 = v_u_4.Plus2:Clone()
            v108.Visible = true
            v109.Visible = true
            v108.Position = UDim2.new(0.88, 0, 0.12, 0)
            v109.Position = UDim2.new(0.98, 0, 0.12, 0)
            v108.GoldImage.Image = "http://www.roblox.com/asset/?id=5176250512"
            v108.Parent = v_u_4
            v109.Parent = v_u_4
            v_u_3.RiverStages.StageIcon5.ImageColor3 = Color3.fromRGB(255, 255, 255)
            spawn(function()
                -- upvalues: (copy) v_u_3
                doJustDiscoveredEffect(v_u_3.RiverStages.StageIcon5, v_u_3.RiverStages)
            end)
            v89 = v_u_80
        else
            v89 = v_u_80
        end
    end
    wait(0.06)
    if v13.Value ~= "" then
        local v110 = v_u_4.GoldGained:Clone()
        local v111 = v_u_4.Plus1:Clone()
        v110.Visible = true
        v111.Visible = true
        v110.Position = UDim2.new(0.66, 0, 0.06, 0)
        v111.Position = UDim2.new(0.73, 0, 0.06, 0)
        v110.Parent = v_u_4
        v111.Parent = v_u_4
        v_u_80 = v89 + 8
        updateNumbers()
        if v13.Value == string.upper(v13.Value) then
            local v112 = v_u_4.TreasureGained:Clone()
            local v113 = v_u_4.Plus2:Clone()
            v112.Visible = true
            v113.Visible = true
            v112.Position = UDim2.new(0.88, 0, 0.06, 0)
            v113.Position = UDim2.new(0.98, 0, 0.06, 0)
            v112.GoldImage.Image = "http://www.roblox.com/asset/?id=5176249676"
            v112.Parent = v_u_4
            v113.Parent = v_u_4
            v_u_3.RiverStages.StageIcon6.ImageColor3 = Color3.fromRGB(255, 255, 255)
            spawn(function()
                -- upvalues: (copy) v_u_3
                doJustDiscoveredEffect(v_u_3.RiverStages.StageIcon6, v_u_3.RiverStages)
            end)
            v89 = v_u_80
        else
            v89 = v_u_80
        end
    end
    wait(0.06)
    if v14.Value ~= "" then
        local v114 = v_u_4.GoldGained:Clone()
        local v115 = v_u_4.Plus1:Clone()
        v114.Visible = true
        v115.Visible = true
        v114.Position = UDim2.new(0.66, 0, 0, 0)
        v115.Position = UDim2.new(0.73, 0, 0, 0)
        v114.Parent = v_u_4
        v115.Parent = v_u_4
        v_u_80 = v89 + 8
        updateNumbers()
        if v14.Value == string.upper(v14.Value) then
            local v116 = v_u_4.TreasureGained:Clone()
            local v117 = v_u_4.Plus2:Clone()
            v116.Visible = true
            v117.Visible = true
            v116.Position = UDim2.new(0.88, 0, 0, 0)
            v117.Position = UDim2.new(0.98, 0, 0, 0)
            v116.GoldImage.Image = "http://www.roblox.com/asset/?id=5176249676"
            v116.Parent = v_u_4
            v117.Parent = v_u_4
            v_u_3.RiverStages.StageIcon7.ImageColor3 = Color3.fromRGB(255, 255, 255)
            spawn(function()
                -- upvalues: (copy) v_u_3
                doJustDiscoveredEffect(v_u_3.RiverStages.StageIcon7, v_u_3.RiverStages)
            end)
            v89 = v_u_80
        else
            v89 = v_u_80
        end
    end
    wait(0.06)
    if v15.Value ~= "" then
        local v118 = v_u_4.GoldGained:Clone()
        local v119 = v_u_4.Plus1:Clone()
        v118.Visible = true
        v119.Visible = true
        v118.Position = UDim2.new(0.66, 0, -0.06, 0)
        v119.Position = UDim2.new(0.73, 0, -0.06, 0)
        v118.Parent = v_u_4
        v119.Parent = v_u_4
        v_u_80 = v89 + 8
        updateNumbers()
        if v15.Value == string.upper(v15.Value) then
            local v120 = v_u_4.TreasureGained:Clone()
            local v121 = v_u_4.Plus2:Clone()
            v120.Visible = true
            v121.Visible = true
            v120.Position = UDim2.new(0.88, 0, -0.06, 0)
            v121.Position = UDim2.new(0.98, 0, -0.06, 0)
            v120.GoldImage.Image = "http://www.roblox.com/asset/?id=5176249676"
            v120.Parent = v_u_4
            v121.Parent = v_u_4
            v_u_3.RiverStages.StageIcon8.ImageColor3 = Color3.fromRGB(255, 255, 255)
            spawn(function()
                -- upvalues: (copy) v_u_3
                doJustDiscoveredEffect(v_u_3.RiverStages.StageIcon8, v_u_3.RiverStages)
            end)
            v89 = v_u_80
        else
            v89 = v_u_80
        end
    end
    wait(0.06)
    if v16.Value ~= "" then
        local v122 = v_u_4.GoldGained:Clone()
        local v123 = v_u_4.Plus1:Clone()
        v122.Visible = true
        v123.Visible = true
        v122.Position = UDim2.new(0.66, 0, -0.12, 0)
        v123.Position = UDim2.new(0.73, 0, -0.12, 0)
        v122.Parent = v_u_4
        v123.Parent = v_u_4
        v_u_80 = v89 + 8
        updateNumbers()
        if v16.Value == string.upper(v16.Value) then
            local v124 = v_u_4.TreasureGained:Clone()
            local v125 = v_u_4.Plus2:Clone()
            v124.Visible = true
            v125.Visible = true
            v124.Position = UDim2.new(0.88, 0, -0.12, 0)
            v125.Position = UDim2.new(0.98, 0, -0.12, 0)
            v124.GoldImage.Image = "http://www.roblox.com/asset/?id=5176249676"
            v124.Parent = v_u_4
            v125.Parent = v_u_4
            v_u_3.RiverStages.StageIcon9.ImageColor3 = Color3.fromRGB(255, 255, 255)
            spawn(function()
                -- upvalues: (copy) v_u_3
                doJustDiscoveredEffect(v_u_3.RiverStages.StageIcon9, v_u_3.RiverStages)
            end)
            v89 = v_u_80
        else
            v89 = v_u_80
        end
    end
    wait(0.06)
    if v17.Value ~= "" then
        local v126 = v_u_4.GoldGained:Clone()
        local v127 = v_u_4.Plus1:Clone()
        v126.Text = tostring(25)
        v126.Visible = true
        v127.Visible = true
        v126.Parent = v_u_4
        v127.Parent = v_u_4
        v_u_80 = v89 + 25
        updateNumbers()
        v_u_3.EndIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
        if v17.Value == string.upper(v17.Value) then
            spawn(function()
                -- upvalues: (copy) v_u_3
                doJustDiscoveredEffect(v_u_3.EndIcon, v_u_3.RiverStages)
            end)
        end
    end
    local v128 = v_u_2.Character.HumanoidRootPart.Position
    while v_u_4.Visible do
        task.wait(2)
        if (v128 - v_u_2.Character.HumanoidRootPart.Position).Magnitude > 16 then
            claim()
            return
        end
    end
end
