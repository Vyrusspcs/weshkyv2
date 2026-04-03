-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-03 13:21:04
-- Luau version 6, Types version 3
-- Time taken: 0.004678 seconds

local module_upvr = {
	getSeason = function(arg1) -- Line 5
		local os_date_result1 = os.date("!*t")
		local os_time_result1 = os.time()
		local var5
		if arg1 then
			var5 = 1
		end
		local os_time_result1_3 = os.time({
			year = os_date_result1.year;
			month = 7;
			day = 1;
			hour = 7;
			min = 0;
			sec = 0;
		})
		local os_time_result1_4 = os.time({
			year = os_date_result1.year;
			month = 7;
			day = var5 + 11;
			hour = 7;
			min = 0;
			sec = 0;
		})
		local os_difftime_result1_2 = os.difftime(os_time_result1_3, os_time_result1)
		if os_difftime_result1_2 < 1 and 0 < os_difftime_result1_2 + os.difftime(os_time_result1_4, os_time_result1_3) then
			return "July", os.difftime(os_time_result1_4, os_time_result1)
		end
		local os_time_result1_7 = os.time({
			year = os_date_result1.year;
			month = 10;
			day = 22;
			hour = 7;
			min = 0;
			sec = 0;
		})
		local os_time_result1_5 = os.time({
			year = os_date_result1.year;
			month = 11;
			day = var5 + 2;
			hour = 7;
			min = 0;
			sec = 0;
		})
		local os_difftime_result1 = os.difftime(os_time_result1_7, os_time_result1)
		if os_difftime_result1 < 1 and 0 < os_difftime_result1 + os.difftime(os_time_result1_5, os_time_result1_7) then
			return "Halloween", os.difftime(os_time_result1_5, os_time_result1)
		end
		local os_time_result1_6 = os.time({
			year = os_date_result1.year;
			month = 12;
			day = 16;
			hour = 7;
			min = 0;
			sec = 0;
		})
		local os_time_result1_2 = os.time({
			year = os_date_result1.year;
			month = 12;
			day = var5 + 30;
			hour = 7;
			min = 0;
			sec = 0;
		})
		local os_difftime_result1_3 = os.difftime(os_time_result1_6, os_time_result1)
		if os_difftime_result1_3 < 1 and 0 < os_difftime_result1_3 + os.difftime(os_time_result1_2, os_time_result1_6) then
			return "Christmas", os.difftime(os_time_result1_2, os_time_result1)
		end
	end;
}
function module_upvr.getSeasonOffSaleString() -- Line 111
	--[[ Upvalues[1]:
		[1]: module_upvr (readonly)
	]]
	local any_getSeason_result1, any_getSeason_result2 = module_upvr.getSeason()
	local var24
	if not any_getSeason_result1 then
		var24 = "Goes off sale soon."
		return var24
	end
	var24 = math.floor(any_getSeason_result2 / 86400)
	local var25 = any_getSeason_result2 % 86400
	local floored_2 = math.floor(var25 / 3600)
	local floored = math.floor(var25 % 3600 / 60)
	if var24 == 1 then
		var24 = 0
		floored_2 += 24
	elseif floored_2 == 1 then
		floored_2 = 0
		floored += 60
	end
	if 0 < var24 then
		return "Goes off sale ".."in "..tostring(var24).." days."
	end
	if 0 < floored_2 then
		return "Goes off sale ".."in "..tostring(floored_2).." hours."
	end
	if 1 < floored then
		return "Goes off sale ".."in "..tostring(floored).." minutes."
	end
	return "Goes off sale soon."
end
return module_upvr