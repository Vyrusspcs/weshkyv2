-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-03 13:20:53
-- Luau version 6, Types version 3
-- Time taken: 0.004980 seconds

function conditions(arg1, arg2, arg3, arg4, arg5) -- Line 1
	local Value = arg1.QuestNum.Value
	local any_toObjectSpace_result1 = arg1.CFrame:toObjectSpace(arg2)
	if Value == 1 then
		if 100 < any_toObjectSpace_result1.Y then
			return false, "Out of bounds"
		end
		if string.find(arg3, "Jet") then
			return false, "Quest restriction met"
		end
		return true
	end
	if Value == 2 then
		if -45 < any_toObjectSpace_result1.Z then
			return false, "Out of bounds"
		end
		if string.find(arg3, "Jet") then
			return false, "Quest restriction met"
		end
		return true
	end
	if Value == 3 then
		if -106 < any_toObjectSpace_result1.Z or any_toObjectSpace_result1.Z < -134 or 16 < any_toObjectSpace_result1.X or any_toObjectSpace_result1.X < -8 or any_toObjectSpace_result1.Y < 184 then
			return false, "Out of bounds"
		end
		if string.find(arg3, "Jet") then
			return false, "Quest restriction met"
		end
		return true
	end
	if Value == 6 then
		if string.find(arg3, "Jet") then
			return false, "Quest restriction met"
		end
		return true
	end
	if Value == 8 then
		if any_toObjectSpace_result1.X < 62.6 then
			return false, "Out of bounds"
		end
		return true
	end
	if Value == 9 then
		if string.find(arg3, "Jet") then
			return false, "Quest restriction met"
		end
		if blockLimitQuestReached(arg5, arg4, 200) then
			return false, "Block limit met"
		end
		return true
	end
	if Value == 100 then
		if -45 < any_toObjectSpace_result1.Z then
			return false, "Out of bounds"
		end
		return true
	end
	if Value == 101 then
		if 0 < any_toObjectSpace_result1.Z then
			return false, "Out of bounds"
		end
		if string.find(arg3, "Jet") then
			return false, "Quest restriction met"
		end
		if 0 < arg1.Quest.NutCrackerBattle.Timer.Value then
			return false, "Out of bounds"
		end
		return true
	end
	return true
end
function blockLimitQuestReached(arg1, arg2, arg3) -- Line 75
	if arg2 and arg2 <= 0 then
	else
		local children = game.Players:GetChildren()
		for i = 1, #children do
			local var8 = children[i]
			if arg1.Team == var8.Team and var8:FindFirstChild("Data") then
				local children_2 = var8.Data:GetChildren()
				for i_2 = 1, #children_2 do
					local var10 = children_2[i_2]
					if var10:FindFirstChild("Used") then
					end
				end
			end
		end
		if arg3 < (arg2 or 0) + var10.Used.Value then
			return true
		end
	end
end
return conditions