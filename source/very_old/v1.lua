local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local localPlayer = Players.LocalPlayer

local goldBlockVal = localPlayer:WaitForChild("Data"):WaitForChild("GoldBlock")
local goldVal = localPlayer.Data:WaitForChild("Gold")

local claimRiverResultsGoldEvent = workspace:WaitForChild("ClaimRiverResultsGold")
local stagePositions = {}
local chestTrigger, chestTriggerOriginCFrame

for _, stage in workspace:WaitForChild("BoatStages"):WaitForChild("NormalStages"):GetChildren() do
	local index = tonumber(stage.Name:match("%d+"))
	if index then
		stagePositions[index] = stage.DarknessPart.CFrame
	end
	if stage.Name == "TheEnd" then
		chestTrigger = stage.GoldenChest.Trigger
		chestTriggerOriginCFrame = chestTrigger.CFrame
	end
end

local stagesData = {}
for _, data in localPlayer.OtherData:GetChildren() do
	if data.Name:match("Stage%d+") then
		stagesData[tonumber(data.Name:match("%d+"))] = data
	end
end

local rng = Random.new()

local UILib = getgenv().UILibCache or loadstring(game:HttpGet("https://gitee.com/xiaoxuxu233/mirror/raw/master/wizard.lua"))
getgenv().UILibCache = UILib

local UI = UILib()
local window = UI:NewWindow("Unnamed")
local main = window:NewSection("主要功能")

main:CreateToggle("自动刷金条&块", function(enabled)
	goldFarming = enabled
	if not goldFarming then return end

	local status = {
	    -- ["最慢关卡用时"] = "2.5秒",
	    -- ["最快总用时"] = "22秒",
	    -- ["每分钟最高"] = "647金条",
	    -- ["每小时最高"] = "38820金条",
	    -- ["每天最高"] = "931680金条",
	}

	local text = Drawing.new("Text")
	text.Outline = true
	text.OutlineColor = Color3.new(0, 0, 0)
	text.Color = Color3.new(1, 1, 1)
	text.Center = false
	text.Position = Vector2.new(64, 64)
	text.Text = ""
	text.Size = 14
	text.Visible = true

	local text2 = Drawing.new("Text")
	text2.Outline = true
	text2.OutlineColor = Color3.new(0, 0, 0)
	text2.Color = Color3.new(1, 1, 1)
	text2.Center = false
	text2.Position = Vector2.new(404, 64)
	text2.Text = ""
	text2.Size = 14
	text2.Visible = true

	local oldGoldBlock, goldBlock = goldBlockVal.Value, goldBlockVal.Value
	local startTime = time()
	local root = localPlayer.Character.HumanoidRootPart
	local unlockChest, characterAdded
	local connections = {}
	local lockPosition = stagePositions[1]
	local chestCloseTime, chestOpenTime = 0, 0
	
	local count = 0
	local earns = table.create(100, 0)
	
	for _, stage in stagesData do
		stage:SetAttribute("TriggerStart", 0)
		stage:SetAttribute("TriggerDuration", 0)
		table.insert(connections, stage.Changed:Connect(function(str)
			if str ~= "" then
				stage:SetAttribute("TriggerDuration", time() - stage:GetAttribute("TriggerStart"))
			else
				stage:SetAttribute("TriggerDuration", 0)
			end
		end))
	end

	table.insert(connections, RunService.Heartbeat:Connect(function()
		if unlockChest then
		    if cframeMethod then
		        chestTrigger.CFrame = root.CFrame
		    else
		        pcall(firetouchinterest, chestTrigger, root, 0)
		    end
		else
			chestTrigger.CFrame = chestTriggerOriginCFrame
		end
		
		root.CFrame = lockPosition
		root.Velocity = Vector3.zero
		
		local info = ""
		for i = 1, #stagesData do
			local triggerDuration = stagesData[i]:GetAttribute("TriggerDuration")
			info = info .. "关卡".. i ..": " .. (triggerDuration > 0 and string.format("用时 %.2f 秒", triggerDuration) or "") .. "\n"
		end
		for stat, value in status do
			info = info .. string.format("%s: %s\n", stat, value)
		end
		text.Text = info
		
		local start = "["
		local info = ""
		for i, earn in earns do
			info = info .. (type(earn) == "string" and string.format("%s,", earn) or string.format("%.3d,", earn))
			if i % 10 == 0 then
			    info = info .. "\n "
			end
		end
		text2.Text = start .. info:sub(0, #info - 2) .. "]"
	end))
	
	table.insert(connections, localPlayer.CharacterAdded:Connect(function(newChar)
		startTime = time()
		root = newChar:WaitForChild("HumanoidRootPart")
	end))
	
	table.insert(connections, localPlayer.CharacterRemoving:Connect(function()
		chestCloseTime = time()
		status["宝箱用时"] = string.format("%.2f秒", chestCloseTime - chestOpenTime)
		unlockChest = nil
		claimRiverResultsGoldEvent:FireServer()
		
		local spentTime = time() - startTime
		status["总用时"] = string.format("%.2f秒", spentTime)
		
		local oldGold = goldVal.Value
		local gold = goldVal.Changed:Wait()
		local earned = gold - oldGold
		local earnedPreMinute = math.ceil(earned / spentTime * 60)
		local earnedPreHour = earnedPreMinute * 60
		local earnedPreDay = earnedPreHour * 24
		
		local bEarned = goldBlock - oldGoldBlock
		local bEarnedPreMinute = math.ceil(bEarned / spentTime * 60)
		local bEarnedPreHour = bEarnedPreMinute * 60
		local bEarnedPreDay = bEarnedPreHour * 24
		
		status["每分钟"] = string.format("%d条、%d块", earnedPreMinute, bEarnedPreMinute)
		status["每小时"] = string.format("%d条、%d块", earnedPreHour, bEarnedPreHour)
		status["每天"] = string.format("%d条、%d块", earnedPreDay, bEarnedPreDay)
		status["收入"] = earned
		
		if count % 100 == 0 then
		    for i, v in earns do
		        earns[i] = 0
		    end
		end
		
		earns[1 + (count % 100)] = earned
		count += 1
	end))

	table.insert(connections, localPlayer.PlayerGui.ChildAdded:Connect(function(newGui)
		if newGui.Name == "RiverResultsGui" then
			newGui:WaitForChild("LocalScript").Enabled = false
		end
	end))

	table.insert(connections, game.Lighting.Changed:Connect(function()
		if game.Lighting.FogEnd < 100000 then
			
		end
	end))
	
	table.insert(connections, goldBlockVal.Changed:Connect(function(new)
		oldGoldBlock = goldBlock
		goldBlock = new
	end))
	
	while goldFarming do
		-- 平均13.5秒宝箱时间
		-- 关卡用时超过2.5秒则错过或延后
		-- 第一关用时6.80秒则后面2.50秒
		
	    lockPosition = stagePositions[1]
		stagesData[1]:SetAttribute("TriggerStart", time())
		task.wait(4.52 + 2)
		task.delay(2.48, function()
		    unlockChest = true
			chestOpenTime = time()
		end)
		
		for i = 2, 9 do
			if not goldFarming then break end
			lockPosition = stagePositions[i]
			stagesData[i]:SetAttribute("TriggerStart", time())
			task.wait(2)
		end
		
		while unlockChest and goldFarming do
			task.wait()
		end
	end

	for _, connection in connections do
		connection:Disconnect()
	end
	text:Destroy()
	text2:Destroy()
	chestTrigger.CFrame = chestTriggerOriginCFrame
end)

main:CreateToggle("自动刷金块", function(enabled)
	goldBlockFarming = enabled
	if not goldBlockFarming then return end

	local status = {}

	local text = Drawing.new("Text")
	text.Outline = true
	text.OutlineColor = Color3.new(0, 0, 0)
	text.Color = Color3.new(1, 1, 1)
	text.Center = false
	text.Position = Vector2.new(64, 64)
	text.Text = ""
	text.Visible = true
	
	local startTime = time()
	local oldGoldBlock, goldBlock = goldBlockVal.Value, goldBlockVal.Value
	local root = localPlayer.Character.HumanoidRootPart
	local characterAdded
	local connections = {}
	local lockPosition = stagePositions[1]
	local chestCloseTime, chestOpenTime = 0, 0

	table.insert(connections, localPlayer.CharacterAdded:Connect(function(newChar)
		startTime = time()
		oldGoldBlock = goldBlockVal.Value
		
		root = newChar:WaitForChild("HumanoidRootPart")
	end))
	
	table.insert(connections, localPlayer.CharacterRemoving:Connect(function()
		chestCloseTime = time()
		status["宝箱用时"] = string.format("%.2f秒", chestCloseTime - chestOpenTime)
		
		local spentTime = time() - startTime
		status["总用时"] = string.format("%.2f秒", spentTime)
		
		local earned = goldBlockVal.Value - oldGoldBlock
		local earnedPreMinute = earned / spentTime * 60
		local earnedPreHour = earnedPreMinute * 60
		local earnedPreDay = earnedPreHour * 24
		
		status["总用时"] = string.format("%.2f秒", spentTime)
		status["每分钟金块"] = string.format("%.2f", earnedPreMinute)
		status["每小时金块"] = string.format("%.2f", earnedPreHour)
		status["每天金块"] = string.format("%.2f", earnedPreDay)
	end))

	table.insert(connections, localPlayer.PlayerGui.ChildAdded:Connect(function(newGui)
		if newGui.Name == "RiverResultsGui" then
			newGui:WaitForChild("LocalScript").Enabled = false
		end
	end))
	
	table.insert(connections, game.Lighting.Changed:Connect(function()
		if game.Lighting.FogEnd < 100000 then
			chestOpenTime = time()
		end
	end))
	
	table.insert(connections, goldBlockVal.Changed:Connect(function(new)
		oldGoldBlock = goldBlock
		goldBlock = new
	end))
	
	root.CFrame = lockPosition
	task.wait(2)

	table.insert(connections, RunService.Heartbeat:Connect(function()
		if cframeMethod then
	        chestTrigger.CFrame = root.CFrame
	    else
	        pcall(firetouchinterest, chestTrigger, root, 0)
	    end
		
		root.CFrame = lockPosition
		root.Velocity = Vector3.zero
		
		local info = ""
		for stat, value in status do
			info = info .. string.format("%s: %s\n", stat, value)
		end
		text.Text = info
	end))
	
	while goldBlockFarming do
		task.wait()
	end
	
	for _, connection in connections do
		connection:Disconnect()
	end
	text:Destroy()
	chestTrigger.CFrame = chestTriggerOriginCFrame
end)

main:CreateToggle("自动刷糖果", function(enabled)
    candyFarming = enabled
    
    if not enabled then return end
    
    while candyFarming do
        task.wait()
        local root = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
        
        if root then
            for _, house in workspace.Houses:GetChildren() do
                if house:FindFirstChild("Door") and house.Door:FindFirstChild("DoorInnerTouch") then
                    pcall(firetouchinterest, root, house.Door.DoorInnerTouch, 0)
                end
            end
        end
    end
end)

game:GetService("StarterGui"):SetCore("SendNotification", {
	Title = "脚本",
	Text = "已成功加载",
	Duration = 3,
})