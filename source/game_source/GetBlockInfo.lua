-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-03 13:21:05
-- Luau version 6, Types version 3
-- Time taken: 0.002790 seconds

function getBlockInfo(arg1, arg2) -- Line 8
	if not arg1 or not arg1.Parent or typeof(arg1) ~= "Instance" then
	else
		local Blocks = workspace.Blocks
		local var2 = arg1
		local Parent_2 = var2.Parent
		while Parent_2 and Parent_2.Parent and Parent_2 ~= workspace and Parent_2.Parent ~= Blocks do
			local Parent = var2.Parent
			local Parent_3 = Parent_2.Parent
		end
		local var6
		if Parent_3.Parent == Blocks then
			var6 = game
			local SOME_2 = var6.Players:FindFirstChild(Parent_3.Name)
			if not arg2 then
				var6 = Parent
				return var6, SOME_2, false
			end
			var6 = false
			local SOME = game.Players:FindFirstChild(arg2.Team.TeamLeader.Value)
			if not arg2.Settings.ShareBlocks.Value and SOME_2 == arg2 or arg2.Settings.ShareBlocks.Value and SOME and SOME_2 == SOME then
				var6 = true
				if not Parent:IsA("Model") then
					var6 = false
				end
			end
			return Parent, SOME_2, var6
		end
	end
end
return getBlockInfo