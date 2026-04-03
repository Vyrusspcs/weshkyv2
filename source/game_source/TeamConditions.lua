TeamConditions-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-03 13:21:00
-- Luau version 6, Types version 3
-- Time taken: 0.007363 seconds

local module = {}
local tbl_upvr = {}
function removeTools(arg1, arg2) -- Line 5
	--[[ Upvalues[1]:
		[1]: tbl_upvr (readonly)
	]]
	if not tbl_upvr["noTools"..tostring(arg2.TeamColor)..arg1.Name] then
		tbl_upvr["noTools"..tostring(arg2.TeamColor)..arg1.Name] = arg1.CharacterAdded:Connect(function() -- Line 7
			--[[ Upvalues[1]:
				[1]: arg1 (readonly)
			]]
			removingTools(arg1)
		end)
		if arg1.Character and arg1.Character:FindFirstChild("Humanoid") then
			arg1.Character.Humanoid:UnequipTools()
		end
		removingTools(arg1)
	end
end
function removingTools(arg1) -- Line 17
	local children_2 = arg1.Backpack:GetChildren()
	for i = 1, #children_2 do
		local var6 = children_2[i]
		if game.StarterPack:FindFirstChild(var6.Name) or arg1.StarterGear:FindFirstChild(var6.Name) then
			var6:Destroy()
		end
	end
end
function module.preventBuildingTools(arg1) -- Line 27
	--[[ Upvalues[1]:
		[1]: tbl_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	if not tbl_upvr["noTools"..tostring(arg1.TeamColor).."PlayerJoined"] then
		tbl_upvr["noTools"..tostring(arg1.TeamColor).."PlayerJoined"] = arg1.PlayerAdded:Connect(function(arg1_2) -- Line 29
			--[[ Upvalues[1]:
				[1]: arg1 (readonly)
			]]
			removeTools(arg1_2, arg1)
		end)
	end
	if not tbl_upvr["noTools"..tostring(arg1.TeamColor).."PlayerLeft"] then
		tbl_upvr["noTools"..tostring(arg1.TeamColor).."PlayerLeft"] = arg1.PlayerRemoved:Connect(function(arg1_3) -- Line 34
			--[[ Upvalues[2]:
				[1]: tbl_upvr (copied, readonly)
				[2]: arg1 (readonly)
			]]
			if tbl_upvr["noTools"..tostring(arg1.TeamColor)..arg1_3.Name] then
				tbl_upvr["noTools"..tostring(arg1.TeamColor)..arg1_3.Name]:Disconnect()
				tbl_upvr["noTools"..tostring(arg1.TeamColor)..arg1_3.Name] = nil
			end
		end)
	end
	local players_2 = arg1:GetPlayers()
	for i_2 = 1, #players_2 do
		removeTools(players_2[i_2], arg1)
		local _
	end
end
function module.allowBuildingTools(arg1) -- Line 49
	--[[ Upvalues[1]:
		[1]: tbl_upvr (readonly)
	]]
	if tbl_upvr["noTools"..tostring(arg1.TeamColor).."PlayerJoined"] then
		tbl_upvr["noTools"..tostring(arg1.TeamColor).."PlayerJoined"]:Disconnect()
		tbl_upvr["noTools"..tostring(arg1.TeamColor).."PlayerJoined"] = nil
	end
	if tbl_upvr["noTools"..tostring(arg1.TeamColor).."PlayerLeft"] then
		tbl_upvr["noTools"..tostring(arg1.TeamColor).."PlayerLeft"]:Disconnect()
		tbl_upvr["noTools"..tostring(arg1.TeamColor).."PlayerLeft"] = nil
	end
	local players = arg1:GetPlayers()
	for i_3 = 1, #players do
		local var21 = players[i_3]
		if tbl_upvr["noTools"..tostring(arg1.TeamColor)..var21.Name] then
			tbl_upvr["noTools"..tostring(arg1.TeamColor)..var21.Name]:Disconnect()
			tbl_upvr["noTools"..tostring(arg1.TeamColor)..var21.Name] = nil
		end
		local children = game.StarterPack:GetChildren()
		for i_4 = 1, #children do
			if not var21.Backpack:FindFirstChild(children[i_4].Name) and (not var21.Character or not var21.Character:FindFirstChild(children[i_4].Name)) then
				children[i_4]:Clone().Parent = var21.Backpack
			end
		end
		local children_3 = var21.StarterGear:GetChildren()
		for i_5 = 1, #children_3 do
			if not var21.Backpack:FindFirstChild(children_3[i_5].Name) and (not var21.Character or not var21.Character:FindFirstChild(children_3[i_5].Name)) then
				children_3[i_5]:Clone().Parent = var21.Backpack
			end
		end
	end
end
function module.preventLoadingBuilds(arg1) -- Line 83
	arg1.CanLoadBuilds.Value = false
end
function module.allowLoadingBuilds(arg1) -- Line 87
	arg1.CanLoadBuilds.Value = true
end
function module.preventLaunching(arg1) -- Line 91
	arg1.CanLaunch.Value = false
end
function module.allowLaunching(arg1) -- Line 95
	arg1.CanLaunch.Value = true
end
return module