-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-03 13:21:08
-- Luau version 6, Types version 3
-- Time taken: 0.025389 seconds

local RunService_upvr = game:GetService("RunService")
local GetBlockInfo_upvr = require(game.ReplicatedStorage.Scripts.GetBlockInfo)
local CurrentCamera_upvr = workspace.CurrentCamera
local LocalPlayer_upvr = game.Players.LocalPlayer
local var5_upvw
local var6_upvw
local var7_upvw
local var8_upvw
local var9_upvw
local var10_upvw
local var11_upvw
local var12_upvw
local var13_upvw
local var14_upvw
local var15_upvw = false
local var16_upvw = false
function canSelect(arg1) -- Line 29
	--[[ Upvalues[3]:
		[1]: var15_upvw (read and write)
		[2]: GetBlockInfo_upvr (readonly)
		[3]: LocalPlayer_upvr (readonly)
	]]
	if var15_upvw then
		return false, arg1
	end
	local var2_result1, _, var2_result3 = GetBlockInfo_upvr(arg1, LocalPlayer_upvr)
	if var2_result3 and string.find(var2_result1.Name, "Block") then
		return true, var2_result1
	end
	return false
end
function updateBlocks() -- Line 44
	local SOME = game.Players:FindFirstChild(LocalPlayer_upvr.Team.TeamLeader.Value)
	local blockOwner
	if SOME and LocalPlayer_upvr.Settings.ShareBlocks.Value then
		blockOwner = SOME
	else
		blockOwner = LocalPlayer_upvr
	end
	local Name = var7_upvw.Adornee.Parent.Name
	var12_upvw = game.Players:FindFirstChild(blockOwner.Name).Data:FindFirstChild(Name).Value
	local children = workspace.Blocks:GetChildren()
	var13_upvw = 0
	for i = 1, #children do
		local children_2 = children[i]:GetChildren()
		for i_2 = 1, #children_2 do
			local var33 = children_2[i_2]
			local _, _, var2_result3_2 = GetBlockInfo_upvr(var33, LocalPlayer_upvr)
			if var2_result3_2 and var33.Name == Name and var33.PrimaryPart and isPartInZone(var33.PrimaryPart, workspace:FindFirstChild(tostring(LocalPlayer_upvr.TeamColor).."Zone")) then
				var13_upvw = var13_upvw + math.max(var33.PrimaryPart.Size.X * var33.PrimaryPart.Size.Y * var33.PrimaryPart.Size.Z / var14_upvw, 1)
			end
		end
	end
	var11_upvw.BlockImage.AmountText.Text = tostring(math.floor(var12_upvw - var13_upvw))
	var11_upvw.BlockImage.Image = LocalPlayer_upvr.PlayerGui.BuildGui.InventoryFrame.ScrollingFrame.BlocksFrame:FindFirstChild(Name).Image
	var11_upvw.Parent = LocalPlayer_upvr.PlayerGui
end
function updateBlocksSoft(arg1, arg2) -- Line 81
	--[[ Upvalues[6]:
		[1]: LocalPlayer_upvr (readonly)
		[2]: var7_upvw (read and write)
		[3]: var12_upvw (read and write)
		[4]: var14_upvw (read and write)
		[5]: var13_upvw (read and write)
		[6]: var11_upvw (read and write)
	]]
	local SOME_2 = game.Players:FindFirstChild(LocalPlayer_upvr.Team.TeamLeader.Value)
	local var38
	if SOME_2 and LocalPlayer_upvr.Settings.ShareBlocks.Value then
		var38 = SOME_2
	end
	var12_upvw = game.Players:FindFirstChild(var38.Name).Data:FindFirstChild(var7_upvw.Adornee.Parent.Name).Value
	var13_upvw += arg2.X * arg2.Y * arg2.Z / var14_upvw - arg1.X * arg1.Y * arg1.Z / var14_upvw
	local floored = math.floor(var12_upvw - var13_upvw)
	var11_upvw.BlockImage.AmountText.Text = tostring(floored)
	return floored
end
function roundToNearestThousands(arg1) -- Line 104
	return math.floor(arg1 * 100 + 0.5) / 100
end
local var40_upvw
local var41_upvw
local QuestConditions_upvr = require(game.ReplicatedStorage.Scripts.QuestConditions)
local ChallengeConditions_upvr = require(game.ReplicatedStorage.Scripts.ChallengeConditions)
local var44_upvw
local var45_upvw
function active(arg1) -- Line 108
	--[[ Upvalues[12]:
		[1]: var5_upvw (read and write)
		[2]: var14_upvw (read and write)
		[3]: var7_upvw (read and write)
		[4]: LocalPlayer_upvr (readonly)
		[5]: var40_upvw (read and write)
		[6]: var15_upvw (read and write)
		[7]: var11_upvw (read and write)
		[8]: var41_upvw (read and write)
		[9]: QuestConditions_upvr (readonly)
		[10]: ChallengeConditions_upvr (readonly)
		[11]: var44_upvw (read and write)
		[12]: var45_upvw (read and write)
	]]
	if not var5_upvw then
	else
		local Adornee = var5_upvw.Adornee
		if Adornee == nil then return end
		local canSelect_result1_2, canSelect_result2_upvr = canSelect(Adornee)
		if canSelect_result1_2 then
			local Size_upvw = canSelect_result2_upvr.PrimaryPart.Size
			local Size_2 = game.ReplicatedStorage.BuildingParts:FindFirstChild(canSelect_result2_upvr.Name).PrimaryPart.Size
			var14_upvw = Size_2.X * Size_2.Y * Size_2.Z
			if not var7_upvw then
				var7_upvw = Instance.new("Handles")
				var7_upvw.Adornee = canSelect_result2_upvr.PrimaryPart
				var7_upvw.Style = Enum.HandlesStyle.Resize
				var7_upvw.Color3 = Color3.fromRGB(172, 78, 1)
				var7_upvw.Parent = LocalPlayer_upvr.PlayerGui
			else
				var7_upvw.Adornee = canSelect_result2_upvr.PrimaryPart
			end
			local var51_upvw
			local var52_upvw
			if var40_upvw then
				var40_upvw:Disconnect()
				var40_upvw = nil
			end
			var40_upvw = var7_upvw.MouseButton1Down:Connect(function() -- Line 140
				--[[ Upvalues[5]:
					[1]: var15_upvw (copied, read and write)
					[2]: var51_upvw (read and write)
					[3]: var7_upvw (copied, read and write)
					[4]: var52_upvw (read and write)
					[5]: arg1 (readonly)
				]]
				var15_upvw = true
				var51_upvw = var7_upvw.Adornee.CFrame
				var52_upvw = var7_upvw.Adornee.Size
				var7_upvw.Adornee:BreakJoints()
				var7_upvw.Adornee.Anchored = true
				if arg1 then
					checkToLockCameraRotation()
				end
			end)
			var11_upvw.BlockImage.SizeDisplay.Text = tostring(roundToNearestThousands(var7_upvw.Adornee.Size.X))..','..tostring(roundToNearestThousands(var7_upvw.Adornee.Size.Y))..','..tostring(roundToNearestThousands(var7_upvw.Adornee.Size.Z))
			if var41_upvw then
				var41_upvw:Disconnect()
				var41_upvw = nil
			end
			local var55_upvw
			local var56_upvw
			var41_upvw = var7_upvw.MouseDrag:Connect(function(arg1_2, arg2) -- Line 155
				--[[ Upvalues[11]:
					[1]: var11_upvw (copied, read and write)
					[2]: var52_upvw (read and write)
					[3]: var55_upvw (read and write)
					[4]: var56_upvw (read and write)
					[5]: var51_upvw (read and write)
					[6]: Size_upvw (read and write)
					[7]: var14_upvw (copied, read and write)
					[8]: LocalPlayer_upvr (copied, readonly)
					[9]: QuestConditions_upvr (copied, readonly)
					[10]: var7_upvw (copied, read and write)
					[11]: ChallengeConditions_upvr (copied, readonly)
				]]
				-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
				-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
				-- KONSTANTERROR: [17] 11. Error Block 2 start (CF ANALYSIS FAILED)
				-- KONSTANTERROR: [17] 11. Error Block 2 end (CF ANALYSIS FAILED)
				-- KONSTANTERROR: [19] 13. Error Block 3 start (CF ANALYSIS FAILED)
				-- KONSTANTERROR: [19] 13. Error Block 3 end (CF ANALYSIS FAILED)
			end)
			if var44_upvw then
				var44_upvw:Disconnect()
				var44_upvw = nil
			end
			var44_upvw = var7_upvw.MouseButton1Up:Connect(function() -- Line 338
				--[[ Upvalues[7]:
					[1]: var51_upvw (read and write)
					[2]: var7_upvw (copied, read and write)
					[3]: var52_upvw (read and write)
					[4]: Size_upvw (read and write)
					[5]: canSelect_result2_upvr (readonly)
					[6]: var15_upvw (copied, read and write)
					[7]: arg1 (readonly)
				]]
				var51_upvw = var7_upvw.Adornee.CFrame
				var52_upvw = var7_upvw.Adornee.Size
				local any_InvokeServer_result1_2, any_InvokeServer_result2_2 = script.Parent.RF:InvokeServer(var7_upvw.Adornee.Parent, var52_upvw, var51_upvw)
				Size_upvw = var52_upvw
				if any_InvokeServer_result1_2 then
					canSelect_result2_upvr.PrimaryPart.Size = any_InvokeServer_result1_2
					canSelect_result2_upvr.PrimaryPart.CFrame = any_InvokeServer_result2_2
					updateBlocks()
				end
				var15_upvw = false
				if arg1 then
					checkToUnlockCameraRotation()
				end
			end)
			if var45_upvw then
				var45_upvw:Disconnect()
				var45_upvw = nil
			end
			var45_upvw = script.Parent.Unequipped:Connect(function() -- Line 357
				--[[ Upvalues[7]:
					[1]: var51_upvw (read and write)
					[2]: var7_upvw (copied, read and write)
					[3]: var52_upvw (read and write)
					[4]: Size_upvw (read and write)
					[5]: canSelect_result2_upvr (readonly)
					[6]: var15_upvw (copied, read and write)
					[7]: var45_upvw (copied, read and write)
				]]
				var51_upvw = var7_upvw.Adornee.CFrame
				var52_upvw = var7_upvw.Adornee.Size
				local any_InvokeServer_result1, any_InvokeServer_result2 = script.Parent.RF:InvokeServer(var7_upvw.Adornee.Parent, var52_upvw, var51_upvw)
				Size_upvw = var52_upvw
				if any_InvokeServer_result1 then
					canSelect_result2_upvr.PrimaryPart.Size = any_InvokeServer_result1
					canSelect_result2_upvr.PrimaryPart.CFrame = any_InvokeServer_result2
				end
				var15_upvw = false
				var45_upvw:Disconnect()
				var45_upvw = nil
			end)
			updateBlocks()
		end
		mouseMove()
	end
end
function uneq() -- Line 379
	--[[ Upvalues[8]:
		[1]: var5_upvw (read and write)
		[2]: var6_upvw (read and write)
		[3]: var10_upvw (read and write)
		[4]: var8_upvw (read and write)
		[5]: var9_upvw (read and write)
		[6]: LocalPlayer_upvr (readonly)
		[7]: var7_upvw (read and write)
		[8]: var11_upvw (read and write)
	]]
	var5_upvw:Destroy()
	var5_upvw = nil
	var6_upvw:Disconnect()
	var6_upvw = nil
	var10_upvw:Disconnect()
	var10_upvw = nil
	var8_upvw:Disconnect()
	var8_upvw = nil
	var9_upvw:Disconnect()
	var9_upvw = nil
	LocalPlayer_upvr.PlayerGui.TabletToolGui.Frame.Visible = false
	LocalPlayer_upvr.PlayerGui.TabletToolGui.Frame.Turn.Visible = true
	LocalPlayer_upvr.PlayerGui.TabletToolGui.Frame.Rotate.Visible = true
	LocalPlayer_upvr.PlayerGui.TabletToolGui.Frame.SpeedBuildToggle.Visible = true
	if var7_upvw then
		var7_upvw:Destroy()
		var7_upvw = nil
	end
	var11_upvw.BlockImage.Visible = false
	checkToUnlockCameraRotation()
end
local UserInputService_upvr = game:GetService("UserInputService")
function eq() -- Line 406
	--[[ Upvalues[8]:
		[1]: var11_upvw (read and write)
		[2]: LocalPlayer_upvr (readonly)
		[3]: var6_upvw (read and write)
		[4]: var8_upvw (read and write)
		[5]: UserInputService_upvr (readonly)
		[6]: var9_upvw (read and write)
		[7]: var10_upvw (read and write)
		[8]: var5_upvw (read and write)
	]]
	var11_upvw = LocalPlayer_upvr:WaitForChild("PlayerGui"):WaitForChild("ScaleToolDisplayGui")
	var11_upvw.BlockImage.SizeDisplay.Text = ""
	var6_upvw = game.Players.LocalPlayer.Character.Humanoid.Died:Connect(died)
	var8_upvw = UserInputService_upvr.InputChanged:Connect(inputChanged)
	var9_upvw = UserInputService_upvr.InputBegan:Connect(inputBegan)
	var10_upvw = LocalPlayer_upvr.PlayerGui:WaitForChild("TabletToolGui"):WaitForChild("Frame"):WaitForChild("Place").MouseButton1Down:Connect(function() -- Line 414
		--[[ Upvalues[1]:
			[1]: LocalPlayer_upvr (copied, readonly)
		]]
		LocalPlayer_upvr.PlayerGui.TabletToolGui.Frame.Visible = false
		active(true)
	end)
	var5_upvw = Instance.new("SelectionBox", workspace)
	var5_upvw.Color3 = Color3.fromRGB(172, 109, 0)
	var5_upvw.SurfaceColor3 = Color3.fromRGB(172, 172, 0)
	var5_upvw.SurfaceTransparency = 0.5
	var11_upvw.BlockImage.Visible = true
end
local mouse_upvr = LocalPlayer_upvr:GetMouse()
function mouseMove(arg1) -- Line 428
	--[[ Upvalues[3]:
		[1]: mouse_upvr (readonly)
		[2]: var5_upvw (read and write)
		[3]: LocalPlayer_upvr (readonly)
	]]
	-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
	local Target = mouse_upvr.Target
	-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [5] 4. Error Block 2 start (CF ANALYSIS FAILED)
	do
		return
	end
	-- KONSTANTERROR: [5] 4. Error Block 2 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [6] 5. Error Block 3 start (CF ANALYSIS FAILED)
	local canSelect_result1, canSelect_result2 = canSelect(Target)
	-- KONSTANTERROR: [6] 5. Error Block 3 end (CF ANALYSIS FAILED)
end
function inputBegan(arg1, arg2) -- Line 450
	if not arg2 then
		if arg1.UserInputType == Enum.UserInputType.MouseButton1 then
			active()
			return
		end
		if arg1.UserInputType == Enum.UserInputType.Touch then
			mouseMove(true)
			return
		end
		if arg1.UserInputType == Enum.UserInputType.Gamepad1 and arg1.KeyCode == Enum.KeyCode.ButtonR2 then
			active()
		end
	end
end
function inputChanged(arg1, arg2) -- Line 464
	if arg1.UserInputType == Enum.UserInputType.MouseMovement then
		mouseMove(false)
	elseif arg1.KeyCode == Enum.KeyCode.Thumbstick1 or arg1.KeyCode == Enum.KeyCode.Thumbstick2 then
		mouseMove(false)
	end
end
function checkToLockCameraRotation() -- Line 472
	--[[ Upvalues[1]:
		[1]: var16_upvw (read and write)
	]]
	if not var16_upvw then
		lockCameraRotation()
	end
end
function lockCameraRotation() -- Line 478
	--[[ Upvalues[3]:
		[1]: var16_upvw (read and write)
		[2]: CurrentCamera_upvr (readonly)
		[3]: RunService_upvr (readonly)
	]]
	var16_upvw = true
	CurrentCamera_upvr.CameraType = Enum.CameraType.Scriptable
	local CameraSubject_upvw = CurrentCamera_upvr.CameraSubject
	if CameraSubject_upvw:IsA("Humanoid") then
		CameraSubject_upvw = CameraSubject_upvw.RootPart
	end
	local var72_upvr = CurrentCamera_upvr.CFrame - CurrentCamera_upvr.CFrame.p
	local var73_upvr = CameraSubject_upvw.CFrame.p - CurrentCamera_upvr.CFrame.p
	RunService_upvr:BindToRenderStep("cameraRotationLock", Enum.RenderPriority.Camera.Value, function() -- Line 491
		--[[ Upvalues[4]:
			[1]: CurrentCamera_upvr (copied, readonly)
			[2]: var72_upvr (readonly)
			[3]: CameraSubject_upvw (read and write)
			[4]: var73_upvr (readonly)
		]]
		CurrentCamera_upvr.CFrame = var72_upvr + CameraSubject_upvw.CFrame.p - var73_upvr
	end)
end
function checkToUnlockCameraRotation() -- Line 497
	--[[ Upvalues[1]:
		[1]: var16_upvw (read and write)
	]]
	if var16_upvw then
		unlockCameraRotation()
	end
end
function unlockCameraRotation() -- Line 503
	--[[ Upvalues[3]:
		[1]: RunService_upvr (readonly)
		[2]: CurrentCamera_upvr (readonly)
		[3]: var16_upvw (read and write)
	]]
	RunService_upvr:UnbindFromRenderStep("cameraRotationLock")
	CurrentCamera_upvr.CameraType = Enum.CameraType.Custom
	var16_upvw = false
end
function died() -- Line 509
	uneq()
	script.Parent:Destroy()
end
function isPartInZone(arg1, arg2) -- Line 514
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local var74
	if typeof(arg1) == "CFrame" then
		var74 = arg1.Position
	else
		var74 = arg1.Position
	end
	local Position = arg2.Position
	local Size = arg2.Size
	if 89 < arg2.Rotation.Y and arg2.Rotation.Y < 91 or arg2.Rotation.Y < -89 and -91 < arg2.Rotation.Y then
		local Z = Size.Z
		local X = Size.X
	end
	if Position.X - Z / 2 < var74.X and var74.X < Position.X + Z / 2 and Position.Z - X / 2 < var74.Z and var74.Z < Position.Z + X / 2 then
		return true
	end
	return false
end
script.Parent.Equipped:connect(eq)
script.Parent.Unequipped:connect(uneq)