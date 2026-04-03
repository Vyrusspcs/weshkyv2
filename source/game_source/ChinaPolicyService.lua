-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-27 07:46:35
-- Luau version 6, Types version 3
-- Time taken: 0.009571 seconds

-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
local module = {}
local Players_upvr = game:GetService("Players")
local var11_upvw
local var12_upvw = false
local var13_upvw = false
local BindableEvent_upvr = Instance.new("BindableEvent")
local BindableEvent_upvr_2 = Instance.new("BindableEvent")
local var19_upvw
for _, v in pairs(script:GetChildren()) do
	if v:IsA("BoolValue") then
		if v.Name == "Forced" then
			var19_upvw = v.Value
		elseif v.Name == "DisableGroupCheck" then
		end
	end
end
local function retry_upvr(arg1, arg2) -- Line 71, Named "retry"
	for i_2 = 1, arg1 do
		local pcall_result1, pcall_result2 = pcall(arg2)
		if pcall_result1 then
			return pcall_result2
		end
		wait(i_2 / 2)
	end
end
local tbl_upvr = {}
local tbl_upvr_2 = {}
local PolicyService_upvr = game:GetService("PolicyService")
local var26_upvw = not v.Value
local function getPolicyActive_upvr(arg1) -- Line 85, Named "getPolicyActive"
	--[[ Upvalues[7]:
		[1]: tbl_upvr (readonly)
		[2]: var19_upvw (read and write)
		[3]: retry_upvr (readonly)
		[4]: PolicyService_upvr (readonly)
		[5]: var26_upvw (read and write)
		[6]: Players_upvr (readonly)
		[7]: tbl_upvr_2 (readonly)
	]]
	local var31
	if var31 == nil then
		var31 = nil
		if var19_upvw then
			var31 = true
		else
			var31 = retry_upvr(3, function() -- Line 95
				--[[ Upvalues[2]:
					[1]: PolicyService_upvr (copied, readonly)
					[2]: arg1 (readonly)
				]]
				return PolicyService_upvr:GetPolicyInfoForPlayerAsync(arg1).IsSubjectToChinaPolicies
			end)
			if var26_upvw and not var31 and 0 < arg1.UserId then
				if retry_upvr(3, function() -- Line 101
					--[[ Upvalues[1]:
						[1]: arg1 (readonly)
					]]
					return arg1:IsInGroup(9170755)
				end) then
					var31 = true
				end
			end
		end
		local var34 = Players_upvr
		if arg1.Parent == var34 then
			if var31 == nil then
				var34 = false
				tbl_upvr[arg1] = var34
			else
				tbl_upvr[arg1] = var31
			end
			if var31 ~= nil then
				var34 = false
			else
				var34 = true
			end
			tbl_upvr_2[arg1] = var34
		end
	end
	return tbl_upvr[arg1], tbl_upvr_2[arg1]
end
Players_upvr.PlayerRemoving:Connect(function(arg1) -- Line 135
	--[[ Upvalues[2]:
		[1]: tbl_upvr (readonly)
		[2]: tbl_upvr_2 (readonly)
	]]
	tbl_upvr[arg1] = nil
	tbl_upvr_2[arg1] = nil
end)
if game:GetService("RunService"):IsServer() then
	var11_upvw = var19_upvw
	if not var11_upvw then
		local var36_upvw
		var36_upvw = Players_upvr.PlayerAdded:Connect(function(arg1) -- Line 150, Named "onPlayerAdded"
			--[[ Upvalues[7]:
				[1]: var36_upvw (read and write)
				[2]: var11_upvw (read and write)
				[3]: var13_upvw (read and write)
				[4]: getPolicyActive_upvr (readonly)
				[5]: var12_upvw (read and write)
				[6]: BindableEvent_upvr (readonly)
				[7]: BindableEvent_upvr_2 (readonly)
			]]
			if not var36_upvw then
			else
				var36_upvw:Disconnect()
				var36_upvw = nil
				local getPolicyActive_result1_2, getPolicyActive_result2_3 = getPolicyActive_upvr(arg1)
				var11_upvw = getPolicyActive_result1_2
				var13_upvw = getPolicyActive_result2_3
				var12_upvw = true
				if var11_upvw then
					BindableEvent_upvr:Fire(var11_upvw, var13_upvw)
				end
				BindableEvent_upvr_2:Fire(var11_upvw, var13_upvw)
			end
		end)
		local var39 = var36_upvw
		if 0 < #Players_upvr:GetPlayers() then
			if not var39 then
			else
				var39:Disconnect()
				var39 = nil
				local getPolicyActive_result1_3, getPolicyActive_result2_2 = getPolicyActive_upvr(Players_upvr:GetPlayers()[1])
				var11_upvw = getPolicyActive_result1_3
				var13_upvw = getPolicyActive_result2_2
				var12_upvw = true
				if var11_upvw then
					BindableEvent_upvr:Fire(var11_upvw, var13_upvw)
				end
				BindableEvent_upvr_2:Fire(var11_upvw, var13_upvw)
			end
		end
	else
		var12_upvw = true
	end
else
	local getPolicyActive_result1, getPolicyActive_result2 = getPolicyActive_upvr(Players_upvr.LocalPlayer)
	var11_upvw = getPolicyActive_result1
	var13_upvw = getPolicyActive_result2
	var12_upvw = true
end
function module.IsActive(arg1) -- Line 193
	--[[ Upvalues[2]:
		[1]: var11_upvw (read and write)
		[2]: var13_upvw (read and write)
	]]
	return var11_upvw, var13_upvw
end
function module.IsReady(arg1) -- Line 198
	--[[ Upvalues[1]:
		[1]: var12_upvw (read and write)
	]]
	return var12_upvw
end
function module.WaitForReady(arg1) -- Line 203
	--[[ Upvalues[4]:
		[1]: var12_upvw (read and write)
		[2]: var11_upvw (read and write)
		[3]: var13_upvw (read and write)
		[4]: BindableEvent_upvr_2 (readonly)
	]]
	if var12_upvw then
		return var11_upvw, var13_upvw
	end
	return BindableEvent_upvr_2.Event:Wait()
end
module.Changed = BindableEvent_upvr.Event
function module.IsActiveForPlayer(arg1, arg2) -- Line 217
	--[[ Upvalues[1]:
		[1]: getPolicyActive_upvr (readonly)
	]]
	if typeof(arg2) ~= "Instance" or not arg2:IsA("Player") then
		error("bad argument #1 to 'IsActiveForPlayer' (Player expected, got "..typeof(arg2)..')', 2)
	end
	return getPolicyActive_upvr(arg2)
end
return module
