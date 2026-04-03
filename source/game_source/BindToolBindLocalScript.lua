-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-03 13:21:07
-- Luau version 6, Types version 3
-- Time taken: 0.022480 seconds

local UserInputService_upvr = game:GetService("UserInputService")
local LocalPlayer_upvr = game.Players.LocalPlayer
local Parent_upvr = script.Parent
local var4_upvw
local var5_upvw
local tbl_3_upvw = {}
local var7_upvw = false
local var8_upvw
local var9_upvw
local var10_upvw
local GetBlockInfo_upvr = require(game.ReplicatedStorage.Scripts.GetBlockInfo)
function canSelect(arg1) -- Line 18
	--[[ Upvalues[3]:
		[1]: GetBlockInfo_upvr (readonly)
		[2]: LocalPlayer_upvr (readonly)
		[3]: var7_upvw (read and write)
	]]
	local GetBlockInfo_upvr_result1, _, GetBlockInfo_upvr_result3 = GetBlockInfo_upvr(arg1, LocalPlayer_upvr)
	if GetBlockInfo_upvr_result1 and (GetBlockInfo_upvr_result1:FindFirstChild("ControllerId") or GetBlockInfo_upvr_result1:FindFirstChild("ControllerRefTemplate")) then
		if not var7_upvw then
			return GetBlockInfo_upvr_result3, GetBlockInfo_upvr_result1
		end
	end
	return false
end
function getSelectedModels() -- Line 29
	--[[ Upvalues[1]:
		[1]: tbl_3_upvw (read and write)
	]]
	for i = 1, #tbl_3_upvw do
		local var16 = tbl_3_upvw[i]
		local Adornee_3 = var16.Adornee
		if Adornee_3 and var16.Parent and Adornee_3.Parent then
			table.insert({}, Adornee_3)
		end
	end
	-- KONSTANTERROR: Expression was reused, decompilation is incorrect
	return {}
end
function clearSelected() -- Line 42
	--[[ Upvalues[1]:
		[1]: tbl_3_upvw (read and write)
	]]
	for i_2 = 1, #tbl_3_upvw do
		tbl_3_upvw[i_2]:Destroy()
	end
	tbl_3_upvw = {}
end
function active(arg1) -- Line 49
	--[[ Upvalues[5]:
		[1]: var4_upvw (read and write)
		[2]: var7_upvw (read and write)
		[3]: tbl_3_upvw (read and write)
		[4]: LocalPlayer_upvr (readonly)
		[5]: UserInputService_upvr (readonly)
	]]
	-- KONSTANTERROR: [0] 1. Error Block 68 start (CF ANALYSIS FAILED)
	if not var4_upvw or var7_upvw then return end
	local Adornee_4 = var4_upvw.Adornee
	unhighlightOptions()
	highlightOptions()
	-- KONSTANTERROR: [0] 1. Error Block 68 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [15] 13. Error Block 6 start (CF ANALYSIS FAILED)
	do
		return
	end
	-- KONSTANTERROR: [15] 13. Error Block 6 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [16] 14. Error Block 7 start (CF ANALYSIS FAILED)
	local canSelect_result1_3, _ = canSelect(Adornee_4)
	-- KONSTANTERROR: [16] 14. Error Block 7 end (CF ANALYSIS FAILED)
end
function unbindingAll(arg1, arg2) -- Line 149
	for _, v in pairs(arg1) do
		for i_4 = 1, #v do
			local children_6 = arg2:GetChildren()
			local var58
			for i_5 = 1, #children_6 do
				local var59 = children_6[i_5]
				if var59:IsA("Beam") and var59.Attachment1 and var59.Attachment1.Parent and var59.Attachment1.Parent.Parent and var59.Attachment1.Parent.Parent == v[i_4].Parent then
				end
			end
			if not nil then
				return false
			end
		end
	end
	return true
end
local TextService_upvr = game:GetService("TextService")
function getScaledTextSize(arg1) -- Line 171
	--[[ Upvalues[1]:
		[1]: TextService_upvr (readonly)
	]]
	arg1.TextScaled = false
	for i_6 = 1, 100 do
		if 0 <= TextService_upvr:GetTextSize(arg1.Text, i_6, arg1.Font, arg1.AbsoluteSize).Y - arg1.TextBounds.Y or i_6 == 100 then
			arg1.TextScaled = true
			return i_6
		end
	end
end
function toggleSelected(arg1) -- Line 184
	--[[ Upvalues[2]:
		[1]: var4_upvw (read and write)
		[2]: tbl_3_upvw (read and write)
	]]
	-- KONSTANTERROR: [0] 1. Error Block 13 start (CF ANALYSIS FAILED)
	if not arg1:FindFirstChild("BindingSB") then
		local clone = var4_upvw:Clone()
		clone.Name = "BindingSB"
		clone.SurfaceTransparency = 0.5
		clone.LineThickness = 0.05
		clone.Parent = arg1
		clone.Adornee = arg1
		table.insert(tbl_3_upvw, clone)
		return
	end
	local _ = 1
	-- KONSTANTERROR: [0] 1. Error Block 13 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [54] 42. Error Block 7 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [54] 42. Error Block 7 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [36] 28. Error Block 4 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: Expression was reused, decompilation is incorrect
	-- KONSTANTERROR: [36] 28. Error Block 4 end (CF ANALYSIS FAILED)
end
function getControllerItem() -- Line 207
	--[[ Upvalues[1]:
		[1]: tbl_3_upvw (read and write)
	]]
	for i_7 = 1, #tbl_3_upvw do
		local var66 = tbl_3_upvw[i_7]
		local Adornee_2 = var66.Adornee
		if Adornee_2 and var66.Parent and Adornee_2.Parent and (Adornee_2:FindFirstChild("VehicleSeat") or Adornee_2.Name == "Lever" or Adornee_2.Name == "Switch" or Adornee_2.Name == "SwitchBig" or Adornee_2.Name == "Button") then
			return Adornee_2
		end
	end
	for i_8 = 1, #tbl_3_upvw do
		local var68 = tbl_3_upvw[i_8]
		local Adornee_5 = var68.Adornee
		if Adornee_5 and var68.Parent and Adornee_5.Parent and Adornee_5.Name == "Delay" then
			return Adornee_5
		end
	end
end
function uneq() -- Line 225
	--[[ Upvalues[6]:
		[1]: var4_upvw (read and write)
		[2]: var8_upvw (read and write)
		[3]: var9_upvw (read and write)
		[4]: var10_upvw (read and write)
		[5]: var5_upvw (read and write)
		[6]: LocalPlayer_upvr (readonly)
	]]
	var4_upvw:Destroy()
	var4_upvw = nil
	var8_upvw:Disconnect()
	var8_upvw = nil
	var9_upvw:Disconnect()
	var9_upvw = nil
	var10_upvw:Disconnect()
	var10_upvw = nil
	var5_upvw:Disconnect()
	var5_upvw = nil
	unhighlightOptions()
	clearSelected()
	if LocalPlayer_upvr.PlayerGui:FindFirstChild("BindGui") then
		LocalPlayer_upvr.PlayerGui.BindGui:Destroy()
	end
end
function eq(arg1) -- Line 243
	--[[ Upvalues[7]:
		[1]: var8_upvw (read and write)
		[2]: UserInputService_upvr (readonly)
		[3]: var9_upvw (read and write)
		[4]: var10_upvw (read and write)
		[5]: var7_upvw (read and write)
		[6]: var5_upvw (read and write)
		[7]: var4_upvw (read and write)
	]]
	var8_upvw = UserInputService_upvr.InputChanged:Connect(inputChanged)
	var9_upvw = UserInputService_upvr.InputBegan:Connect(inputBegan)
	var10_upvw = UserInputService_upvr.InputEnded:Connect(inputEnded)
	var7_upvw = false
	var5_upvw = game.Players.LocalPlayer.Character.Humanoid.Died:Connect(died)
	var4_upvw = Instance.new("SelectionBox")
	var4_upvw.Color3 = Color3.fromRGB(49, 155, 176)
	var4_upvw.SurfaceColor3 = Color3.fromRGB(49, 155, 176)
	var4_upvw.SurfaceTransparency = 1
	var4_upvw.LineThickness = 0.1
	var4_upvw.Parent = workspace
	highlightOptions()
end
local tbl_2_upvw = {}
function highlightOptions() -- Line 265
	--[[ Upvalues[1]:
		[1]: tbl_2_upvw (read and write)
	]]
	local children_7 = workspace.Blocks:GetChildren()
	for i_9 = 1, #children_7 do
		local children_8 = children_7[i_9]:GetChildren()
		for i_10 = 1, #children_8 do
			local var76 = children_8[i_10]
			makeOptionSB(var76)
			if var76:FindFirstChild("ControllerId") then
				local children_2_upvr = var76:GetChildren()
				for i_11_upvr = 1, #children_2_upvr do
					if children_2_upvr[i_11_upvr]:IsA("Beam") then
						children_2_upvr[i_11_upvr].Enabled = true
						table.insert(tbl_2_upvw, children_2_upvr[i_11_upvr]:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line 281
							--[[ Upvalues[2]:
								[1]: children_2_upvr (readonly)
								[2]: i_11_upvr (readonly)
							]]
							children_2_upvr[i_11_upvr].Enabled = true
						end))
					end
				end
			end
		end
	end
end
function unhighlightOptions() -- Line 297
	--[[ Upvalues[2]:
		[1]: tbl_2_upvw (read and write)
		[2]: Parent_upvr (readonly)
	]]
	for i_12 = 1, #tbl_2_upvw do
		tbl_2_upvw[i_12]:Disconnect()
		tbl_2_upvw[i_12] = nil
	end
	tbl_2_upvw = {}
	Parent_upvr.BItemOptionSBs:ClearAllChildren()
	local children_4 = workspace.Blocks:GetChildren()
	for i_13 = 1, #children_4 do
		local children_3 = children_4[i_13]:GetChildren()
		for i_14 = 1, #children_3 do
			local var85 = children_3[i_14]
			if var85:FindFirstChild("ControllerId") then
				local children = var85:GetChildren()
				for i_15 = 1, #children do
					if children[i_15]:IsA("Beam") then
						children[i_15].Enabled = false
					end
				end
			end
		end
	end
end
function makeOptionSB(arg1) -- Line 330
	--[[ Upvalues[1]:
		[1]: Parent_upvr (readonly)
	]]
	local canSelect_result1_4, canSelect_result2_2 = canSelect(arg1)
	if canSelect_result1_4 then
		local Color3_fromRGB_result1 = Color3.fromRGB(163, 172, 62)
		if canSelect_result2_2:FindFirstChild("VehicleSeat") or canSelect_result2_2.Name == "Lever" or canSelect_result2_2.Name == "Switch" or canSelect_result2_2.Name == "SwitchBig" or canSelect_result2_2.Name == "Button" then
			Color3_fromRGB_result1 = Color3.fromRGB(155, 60, 172)
		elseif canSelect_result2_2.Name == "Delay" then
			Color3_fromRGB_result1 = Color3.fromRGB(173, 113, 53)
		end
		local SelectionBox = Instance.new("SelectionBox")
		SelectionBox.Color3 = Color3_fromRGB_result1
		SelectionBox.SurfaceColor3 = Color3_fromRGB_result1
		SelectionBox.SurfaceTransparency = 0.75
		SelectionBox.LineThickness = 0
		SelectionBox.Parent = Parent_upvr.BItemOptionSBs
		SelectionBox.Adornee = canSelect_result2_2
	end
end
local mouse_upvr = LocalPlayer_upvr:GetMouse()
function mouseMove(arg1) -- Line 350
	--[[ Upvalues[2]:
		[1]: mouse_upvr (readonly)
		[2]: var4_upvw (read and write)
	]]
	local Target = mouse_upvr.Target
	if not Target or not Target.Parent or arg1 then
		var4_upvw.Adornee = nil
	else
		local canSelect_result1, canSelect_result2 = canSelect(Target)
		if canSelect_result1 then
			var4_upvw.Adornee = canSelect_result2
			return
		end
		var4_upvw.Adornee = nil
	end
end
function xboxMove(arg1, arg2) -- Line 365
	if arg1.UserInputType == Enum.UserInputType.Gamepad1 and (arg1.KeyCode == Enum.KeyCode.Thumbstick1 or arg1.KeyCode == Enum.KeyCode.Thumbstick2) then
		mouseMove()
	end
end
function died() -- Line 373
	uneq()
	script.Parent:Destroy()
end
function inputChanged(arg1, arg2) -- Line 378
	if arg1.UserInputType == Enum.UserInputType.MouseMovement then
		mouseMove()
	elseif arg1.KeyCode == Enum.KeyCode.Thumbstick1 or arg1.KeyCode == Enum.KeyCode.Thumbstick2 then
		mouseMove()
	end
end
function inputBegan(arg1, arg2) -- Line 386
	if not arg2 then
		if arg1.UserInputType == Enum.UserInputType.MouseButton1 then
			active()
			return
		end
		if arg1.UserInputType == Enum.UserInputType.Touch then
			mouseMove()
			active(true)
			return
		end
		if arg1.UserInputType == Enum.UserInputType.Gamepad1 and arg1.KeyCode == Enum.KeyCode.ButtonR2 then
			active()
		end
	end
end
function inputEnded(arg1, arg2) -- Line 401
	if not arg2 and arg1.UserInputType == Enum.UserInputType.Touch then
		mouseMove(true)
	end
end
script.Parent.Equipped:connect(eq)
script.Parent.Unequipped:connect(uneq)

----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------  SAME SCRIPT BELOW  ----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------  OTHER BETTER DECOMPILER
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-04 14:01:26
-- Luau version 6, Types version 3
-- Time taken: 0.034038 seconds

local UserInputService_upvr = game:GetService("UserInputService")
local LocalPlayer_upvr = game.Players.LocalPlayer
local Parent_upvr = script.Parent
local var4_upvw
local var5_upvw
local tbl_3_upvw = {}
local var7_upvw = false
local var8_upvw
local var9_upvw
local var10_upvw
local var11_upvw
local PlayerGui_upvr = LocalPlayer_upvr:WaitForChild("PlayerGui")
local GetBlockInfo_upvr = require(game.ReplicatedStorage.Scripts.GetBlockInfo)
function canSelect(arg1) -- Line 21
	--[[ Upvalues[3]:
		[1]: GetBlockInfo_upvr (readonly)
		[2]: LocalPlayer_upvr (readonly)
		[3]: var7_upvw (read and write)
	]]
	local GetBlockInfo_upvr_result1, _, var13_result3 = GetBlockInfo_upvr(arg1, LocalPlayer_upvr)
	if GetBlockInfo_upvr_result1 and (GetBlockInfo_upvr_result1:FindFirstChild("ControllerId") or GetBlockInfo_upvr_result1:FindFirstChild("ControllerRefTemplate")) then
		if not var7_upvw then
			return var13_result3, GetBlockInfo_upvr_result1
		end
	end
	return false
end
function getSelectedModels() -- Line 32
	--[[ Upvalues[1]:
		[1]: tbl_3_upvw (read and write)
	]]
	for i = 1, #tbl_3_upvw do
		local var18 = tbl_3_upvw[i]
		local Adornee = var18.Adornee
		if Adornee and var18.Parent and Adornee.Parent then
			table.insert({}, Adornee)
		end
	end
	-- KONSTANTERROR: Expression was reused, decompilation is incorrect
	return {}
end
function clearSelected() -- Line 45
	--[[ Upvalues[2]:
		[1]: tbl_3_upvw (read and write)
		[2]: PlayerGui_upvr (readonly)
	]]
	for i_2 = 1, #tbl_3_upvw do
		tbl_3_upvw[i_2]:Destroy()
	end
	tbl_3_upvw = {}
	PlayerGui_upvr:WaitForChild("BindToolDisplayGui"):WaitForChild("UnbindAll").Visible = false
end
local CollectionService_upvr = game:GetService("CollectionService")
function active(arg1) -- Line 54
	--[[ Upvalues[7]:
		[1]: var4_upvw (read and write)
		[2]: var7_upvw (read and write)
		[3]: tbl_3_upvw (read and write)
		[4]: CollectionService_upvr (readonly)
		[5]: Parent_upvr (readonly)
		[6]: LocalPlayer_upvr (readonly)
		[7]: UserInputService_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local var73
	if not var4_upvw or var7_upvw then
	else
		local Adornee_4 = var4_upvw.Adornee
		if not Adornee_4 then return end
		local canSelect_result1_4, canSelect_result2_3 = canSelect(Adornee_4)
		if not canSelect_result1_4 then return end
		local getControllerItem_result1 = getControllerItem()
		var73 = getControllerItem_result1
		if var73 then
			var73 = true
			if getControllerItem_result1.Name ~= "Delay" then
				if getControllerItem_result1.Name ~= "Gate" then
					var73 = false
				else
					var73 = true
				end
			end
		end
		if canSelect_result2_3.Name ~= "Delay" then
			if canSelect_result2_3.Name ~= "Gate" then
			else
			end
		end
		if canSelect_result2_3:FindFirstChild("ControllerId") and getControllerItem_result1 and canSelect_result2_3 ~= getControllerItem_result1 and not (var73 or true) then
			toggleSelected(getControllerItem_result1)
		end
		local var78 = canSelect_result2_3
		toggleSelected(var78)
		unhighlightOptions()
		if 0 >= #tbl_3_upvw then
			var78 = false
		else
			var78 = true
		end
		highlightOptions(var78)
		local getControllerItem_result1_2 = getControllerItem()
		if getControllerItem_result1_2 and 2 <= #tbl_3_upvw then
			var7_upvw = true
			local tbl = {}
			for i_14 = 1, #tbl_3_upvw do
				local Adornee_7 = tbl_3_upvw[i_14].Adornee
				if Adornee_7 and Adornee_7 ~= getControllerItem_result1_2 then
					local children = Adornee_7:GetChildren()
					for i_15 = 1, #children do
						local var83 = children[i_15]
						if string.sub(var83.Name, 1, 4) == "Bind" and var83.Name ~= "BindingSB" then
							if not tbl[var83.ActionName.Value] then
								tbl[var83.ActionName.Value] = {}
							end
							table.insert(tbl[var83.ActionName.Value], var83)
						end
					end
				end
			end
			local allBlocksConnectedToController_result1_2 = allBlocksConnectedToController(tbl, getControllerItem_result1_2)
			if not allBlocksConnectedToController_result1_2 and not (CollectionService_upvr:HasTag(getControllerItem_result1_2, "SwitchInput") or arg1) then
				for i_16, _ in pairs(tbl) do
					local clone_3 = Parent_upvr.BindGui:Clone()
					clone_3.Parent = LocalPlayer_upvr.PlayerGui
					local TextLabel_2 = clone_3.Frame.TextLabel
					TextLabel_2.Text = i_16.." : <font color='#ffce50'><i>next input</i></font>"
					local var90
					if UserInputService_upvr.InputBegan:Wait().UserInputType == Enum.UserInputType.MouseButton1 or var90.KeyCode == Enum.KeyCode.ButtonR2 then
						var90 = UserInputService_upvr.InputBegan:Wait()
					end
					while var90.KeyCode == Enum.KeyCode.Unknown and var90.UserInputType ~= Enum.UserInputType.MouseButton1 do
						var90 = UserInputService_upvr.InputBegan:Wait()
					end
					if not LocalPlayer_upvr.PlayerGui:FindFirstChild("BindGui") then return end
					if var90.UserInputType == Enum.UserInputType.MouseButton1 then
						var90 = {}
						var90.KeyCode = Enum.KeyCode.MouseLeftButton
						var90.UserInputState = Enum.UserInputState.Begin
						var90.UserInputType = Enum.UserInputType.MouseButton1
					end
					;({})[i_16] = var90.KeyCode.Value
					local any_GetStringForKeyCode_result1 = UserInputService_upvr:GetStringForKeyCode(var90.KeyCode)
					if var90.UserInputType == Enum.UserInputType.MouseButton1 then
						any_GetStringForKeyCode_result1 = "Left click"
					elseif any_GetStringForKeyCode_result1 == "" then
						any_GetStringForKeyCode_result1 = var90.KeyCode.Name
					end
					TextLabel_2.Size = UDim2.new(0, TextLabel_2.TextBounds.X, 0, TextLabel_2.TextBounds.Y)
					TextLabel_2.TextSize = getScaledTextSize(TextLabel_2)
					TextLabel_2.TextScaled = false
					TextLabel_2.TextXAlignment = Enum.TextXAlignment.Left
					TextLabel_2.Text = i_16.." : <font color='#ffce50'><b>"..any_GetStringForKeyCode_result1.."</b></font>"
					task.wait(2)
					clone_3:Destroy()
				end
			end
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect (x2)
			Parent_upvr.RF:InvokeServer(tbl, getControllerItem_result1_2, {}, allBlocksConnectedToController_result1_2, CollectionService_upvr:HasTag(getControllerItem_result1_2, "SwitchInput") or arg1)
			clearSelected()
			var7_upvw = false
			unhighlightOptions()
			highlightOptions()
			mouseMove(arg1)
		end
	end
end
function allBlocksConnectedToController(arg1, arg2) -- Line 164
	for _, v in pairs(arg1) do
		for i_4 = 1, #v do
			local children_4 = arg2:GetChildren()
			local var104
			for i_5 = 1, #children_4 do
				local var105 = children_4[i_5]
				if var105:IsA("Beam") and var105.Attachment1 and var105.Attachment1.Parent and var105.Attachment1.Parent.Parent and var105.Attachment1.Parent.Parent == v[i_4].Parent then
				end
			end
			if not nil then
				return false
			end
		end
	end
	return true
end
local TextService_upvr = game:GetService("TextService")
function getScaledTextSize(arg1) -- Line 186
	--[[ Upvalues[1]:
		[1]: TextService_upvr (readonly)
	]]
	arg1.TextScaled = false
	for i_6 = 1, 100 do
		if 0 <= TextService_upvr:GetTextSize(arg1.Text, i_6, arg1.Font, arg1.AbsoluteSize).Y - arg1.TextBounds.Y or i_6 == 100 then
			arg1.TextScaled = true
			return i_6
		end
	end
end
function toggleSelected(arg1) -- Line 199
	--[[ Upvalues[3]:
		[1]: var4_upvw (read and write)
		[2]: tbl_3_upvw (read and write)
		[3]: PlayerGui_upvr (readonly)
	]]
	-- KONSTANTERROR: [0] 1. Error Block 36 start (CF ANALYSIS FAILED)
	if not arg1:FindFirstChild("BindingSB") then
		local clone = var4_upvw:Clone()
		clone.Name = "BindingSB"
		clone.SurfaceTransparency = 0.5
		clone.LineThickness = 0.05
		clone.Parent = arg1
		clone.Adornee = arg1
		table.insert(tbl_3_upvw, clone)
		-- KONSTANTWARNING: GOTO [59] #46
	end
	-- KONSTANTERROR: [0] 1. Error Block 36 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [30] 22. Error Block 34 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [30] 22. Error Block 34 end (CF ANALYSIS FAILED)
end
function getControllerItem() -- Line 241
	--[[ Upvalues[1]:
		[1]: tbl_3_upvw (read and write)
	]]
	local var111
	for i_7 = 1, #tbl_3_upvw do
		local var112 = tbl_3_upvw[i_7]
		local Adornee_3 = var112.Adornee
		local var114 = true
		if Adornee_3.Name ~= "Delay" then
			if Adornee_3.Name ~= "Gate" then
				var114 = false
			else
				var114 = true
			end
		end
		if Adornee_3 and var112.Parent and Adornee_3.Parent and (not var114 or not var111) or Adornee_3:HasTag("SeatInput") or Adornee_3:HasTag("SwitchInput") then
			var111 = Adornee_3
			if not var114 then
				return var111
			end
		end
	end
	return var111
end
function uneq() -- Line 259
	--[[ Upvalues[8]:
		[1]: var4_upvw (read and write)
		[2]: var8_upvw (read and write)
		[3]: var9_upvw (read and write)
		[4]: var10_upvw (read and write)
		[5]: var5_upvw (read and write)
		[6]: LocalPlayer_upvr (readonly)
		[7]: PlayerGui_upvr (readonly)
		[8]: var11_upvw (read and write)
	]]
	var4_upvw:Destroy()
	var4_upvw = nil
	var8_upvw:Disconnect()
	var8_upvw = nil
	var9_upvw:Disconnect()
	var9_upvw = nil
	var10_upvw:Disconnect()
	var10_upvw = nil
	var5_upvw:Disconnect()
	var5_upvw = nil
	unhighlightOptions()
	clearSelected()
	if LocalPlayer_upvr.PlayerGui:FindFirstChild("BindGui") then
		LocalPlayer_upvr.PlayerGui.BindGui:Destroy()
	end
	PlayerGui_upvr:WaitForChild("BindToolDisplayGui"):WaitForChild("UnbindAll").Visible = false
	if var11_upvw then
		var11_upvw:Disconnect()
		var11_upvw = nil
	end
end
function eq(arg1) -- Line 283
	--[[ Upvalues[11]:
		[1]: var8_upvw (read and write)
		[2]: UserInputService_upvr (readonly)
		[3]: var9_upvw (read and write)
		[4]: var10_upvw (read and write)
		[5]: var7_upvw (read and write)
		[6]: var5_upvw (read and write)
		[7]: var4_upvw (read and write)
		[8]: PlayerGui_upvr (readonly)
		[9]: var11_upvw (read and write)
		[10]: tbl_3_upvw (read and write)
		[11]: Parent_upvr (readonly)
	]]
	var8_upvw = UserInputService_upvr.InputChanged:Connect(inputChanged)
	var9_upvw = UserInputService_upvr.InputBegan:Connect(inputBegan)
	var10_upvw = UserInputService_upvr.InputEnded:Connect(inputEnded)
	var7_upvw = false
	var5_upvw = game.Players.LocalPlayer.Character.Humanoid.Died:Connect(died)
	var4_upvw = Instance.new("SelectionBox")
	var4_upvw.Color3 = Color3.fromRGB(49, 155, 176)
	var4_upvw.SurfaceColor3 = Color3.fromRGB(49, 155, 176)
	var4_upvw.SurfaceTransparency = 1
	var4_upvw.LineThickness = 0.1
	var4_upvw.Parent = workspace
	highlightOptions()
	var11_upvw = PlayerGui_upvr:WaitForChild("BindToolDisplayGui"):WaitForChild("UnbindAll").mouseButton1Click:connect(function() -- Line 304
		--[[ Upvalues[3]:
			[1]: var7_upvw (copied, read and write)
			[2]: tbl_3_upvw (copied, read and write)
			[3]: Parent_upvr (copied, readonly)
		]]
		var7_upvw = true
		for i_8 = 1, #tbl_3_upvw do
			local Adornee_6 = tbl_3_upvw[i_8].Adornee
			if Adornee_6 and Adornee_6.Parent then
				table.insert({}, Adornee_6)
			end
		end
		-- KONSTANTERROR: Expression was reused, decompilation is incorrect
		Parent_upvr.UnbindRF:InvokeServer({})
		clearSelected()
		var7_upvw = false
		unhighlightOptions()
		highlightOptions()
	end)
end
local tbl_4_upvw = {}
function highlightOptions(arg1) -- Line 325
	--[[ Upvalues[1]:
		[1]: tbl_4_upvw (read and write)
	]]
	-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
	local _ = 1
	-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [141] 106. Error Block 34 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [141] 106. Error Block 34 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [11] 9. Error Block 2 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [11] 9. Error Block 2 end (CF ANALYSIS FAILED)
end
local tbl_5_upvw = {}
function unhighlightOptions() -- Line 383
	--[[ Upvalues[2]:
		[1]: tbl_4_upvw (read and write)
		[2]: tbl_5_upvw (read and write)
	]]
	for i_9 = 1, #tbl_4_upvw do
		tbl_4_upvw[i_9]:Disconnect()
		tbl_4_upvw[i_9] = nil
	end
	tbl_4_upvw = {}
	for i_10 = 1, #tbl_5_upvw do
		local var127 = tbl_5_upvw[i_10]
		var127.Adornee = nil
		var127:Destroy()
	end
	tbl_5_upvw = {}
	local children_6 = workspace.Blocks:GetChildren()
	for i_11 = 1, #children_6 do
		local children_5 = children_6[i_11]:GetChildren()
		for i_12 = 1, #children_5 do
			local var130 = children_5[i_12]
			if var130:FindFirstChild("ControllerId") then
				local children_3 = var130:GetChildren()
				for i_13 = 1, #children_3 do
					if children_3[i_13]:IsA("Beam") then
						children_3[i_13].Enabled = false
					end
				end
			end
		end
	end
end
function makeOptionSB(arg1, arg2) -- Line 418
	--[[ Upvalues[1]:
		[1]: tbl_5_upvw (read and write)
	]]
	-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
	local canSelect_result1_2, canSelect_result2 = canSelect(arg1)
	local var134
	-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [32] 22. Error Block 28 start (CF ANALYSIS FAILED)
	if canSelect_result2.Name == "RemoteController" then
		-- KONSTANTERROR: [36] 24. Error Block 24 start (CF ANALYSIS FAILED)
		var134 = Color3.fromRGB(155, 60, 172)
		-- KONSTANTERROR: [36] 24. Error Block 24 end (CF ANALYSIS FAILED)
	elseif canSelect_result2.Name == "Delay" or canSelect_result2.Name == "Gate" then
		var134 = Color3.fromRGB(173, 113, 53)
	end
	local SelectionBox = Instance.new("SelectionBox")
	SelectionBox.Name = "OptionSB"
	SelectionBox.Color3 = var134
	SelectionBox.SurfaceColor3 = var134
	if arg2 then
		SelectionBox.SurfaceTransparency = 0.25
	else
		SelectionBox.SurfaceTransparency = 1
	end
	SelectionBox.LineThickness = 0
	SelectionBox.Parent = canSelect_result2
	SelectionBox.Adornee = canSelect_result2
	table.insert(tbl_5_upvw, SelectionBox)
	-- KONSTANTERROR: [32] 22. Error Block 28 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [92] 63. Error Block 20 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [92] 63. Error Block 20 end (CF ANALYSIS FAILED)
end
local mouse_upvr = LocalPlayer_upvr:GetMouse()
function mouseMove(arg1) -- Line 444
	--[[ Upvalues[2]:
		[1]: mouse_upvr (readonly)
		[2]: var4_upvw (read and write)
	]]
	local Target = mouse_upvr.Target
	if not Target or not Target.Parent or arg1 then
		var4_upvw.Adornee = nil
	else
		local canSelect_result1, canSelect_result2_2 = canSelect(Target)
		if canSelect_result1 then
			var4_upvw.Adornee = canSelect_result2_2
			return
		end
		var4_upvw.Adornee = nil
	end
end
function xboxMove(arg1, arg2) -- Line 459
	if arg1.UserInputType == Enum.UserInputType.Gamepad1 and (arg1.KeyCode == Enum.KeyCode.Thumbstick1 or arg1.KeyCode == Enum.KeyCode.Thumbstick2) then
		mouseMove()
	end
end
function died() -- Line 467
	--[[ Upvalues[1]:
		[1]: Parent_upvr (readonly)
	]]
	uneq()
	Parent_upvr:Destroy()
end
function inputChanged(arg1, arg2) -- Line 472
	if arg1.UserInputType == Enum.UserInputType.MouseMovement then
		mouseMove()
	elseif arg1.KeyCode == Enum.KeyCode.Thumbstick1 or arg1.KeyCode == Enum.KeyCode.Thumbstick2 then
		mouseMove()
	end
end
function inputBegan(arg1, arg2) -- Line 480
	if not arg2 then
		if arg1.UserInputType == Enum.UserInputType.MouseButton1 then
			active()
			return
		end
		if arg1.UserInputType == Enum.UserInputType.Touch then
			mouseMove()
			active(true)
			return
		end
		if arg1.UserInputType == Enum.UserInputType.Gamepad1 and arg1.KeyCode == Enum.KeyCode.ButtonR2 then
			active()
		end
	end
end
function inputEnded(arg1, arg2) -- Line 495
	if not arg2 and arg1.UserInputType == Enum.UserInputType.Touch then
		mouseMove(true)
	end
end
Parent_upvr.Equipped:connect(eq)
Parent_upvr.Unequipped:connect(uneq)
