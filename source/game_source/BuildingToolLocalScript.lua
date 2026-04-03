-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-03 13:22:34
-- Luau version 6, Types version 3
-- Time taken: 0.042773 seconds

local LocalPlayer_upvr = game.Players.LocalPlayer
local mouse_upvr = LocalPlayer_upvr:GetMouse()
local Parent_upvr = script.Parent
local var4_upvw
local var5_upvw
local var6_upvw
local zero_cframe_upvw = CFrame.new()
local var8_upvw
local var9_upvw
local var10_upvw
local var11_upvw
local var12_upvw
local var13_upvw
local var14_upvw
local var15_upvw
local var16_upvw
local var17_upvw
local var18_upvw
local var19_upvw
local var20_upvw
local var21_upvw
local UserInputService_upvr = game:GetService("UserInputService")
local var23_upvw
function eq() -- Line 35
	--[[ Upvalues[18]:
		[1]: LocalPlayer_upvr (readonly)
		[2]: var4_upvw (read and write)
		[3]: var5_upvw (read and write)
		[4]: var9_upvw (read and write)
		[5]: UserInputService_upvr (readonly)
		[6]: var10_upvw (read and write)
		[7]: var11_upvw (read and write)
		[8]: var13_upvw (read and write)
		[9]: var14_upvw (read and write)
		[10]: var12_upvw (read and write)
		[11]: var23_upvw (read and write)
		[12]: var15_upvw (read and write)
		[13]: var16_upvw (read and write)
		[14]: var17_upvw (read and write)
		[15]: var18_upvw (read and write)
		[16]: var19_upvw (read and write)
		[17]: var20_upvw (read and write)
		[18]: var21_upvw (read and write)
	]]
	if LocalPlayer_upvr.Character.Humanoid.Health <= 0 then
	else
		var4_upvw = game.ReplicatedStorage.BuildingParts.WoodBlock:Clone()
		var4_upvw:SetPrimaryPartCFrame(CFrame.new(-50, -12, -720))
		itemChanged(var5_upvw or "WoodBlock")
		var9_upvw = UserInputService_upvr.InputChanged:Connect(inputChanged)
		var10_upvw = UserInputService_upvr.InputBegan:Connect(inputBegan)
		var11_upvw = UserInputService_upvr.InputEnded:Connect(inputEnded)
		var13_upvw = LocalPlayer_upvr.PlayerGui.TabletToolGui.Frame.Rotate.MouseButton1Click:Connect(rotateY)
		var14_upvw = LocalPlayer_upvr.PlayerGui.TabletToolGui.Frame.Turn.MouseButton1Click:Connect(rotateX)
		var12_upvw = LocalPlayer_upvr.PlayerGui.TabletToolGui.Frame.Place.MouseButton1Click:Connect(function() -- Line 52
			--[[ Upvalues[2]:
				[1]: var4_upvw (copied, read and write)
				[2]: var23_upvw (copied, read and write)
			]]
			local var26 = true
			if var4_upvw.Name ~= "Spring" then
				var26 = true
				if var4_upvw.Name ~= "Bar" then
					if var4_upvw.Name ~= "Rope" then
						var26 = false
					else
						var26 = true
					end
				end
			end
			if var23_upvw ~= var4_upvw.PrimaryPart.CFrame or var26 then
				var23_upvw = var4_upvw.PrimaryPart.CFrame
				placeBlock(true)
			end
		end)
		var15_upvw = LocalPlayer_upvr.PlayerGui.TabletToolGui.Frame.SpeedBuildToggle.MouseButton1Click:Connect(toggleSpeedBuild)
		var16_upvw = LocalPlayer_upvr.PlayerGui.BuildGui.InventoryFrame.ScrollingFrame.BlocksFrame.Selected:GetPropertyChangedSignal("Value"):Connect(itemChanged)
		var17_upvw = LocalPlayer_upvr.PlayerGui.BuildGui.SearchFrame.OnlyBlocks:GetPropertyChangedSignal("Value"):Connect(function() -- Line 61
			--[[ Upvalues[1]:
				[1]: LocalPlayer_upvr (copied, readonly)
			]]
			updateBuildGui()
			LocalPlayer_upvr.PlayerGui.BuildGui.InventoryFrame.ScrollingFrame.CanvasPosition = Vector2.new(0, 0)
		end)
		var18_upvw = LocalPlayer_upvr.PlayerGui.BuildGui.SearchFrame.OnlyDecorations:GetPropertyChangedSignal("Value"):Connect(function() -- Line 65
			--[[ Upvalues[1]:
				[1]: LocalPlayer_upvr (copied, readonly)
			]]
			updateBuildGui()
			LocalPlayer_upvr.PlayerGui.BuildGui.InventoryFrame.ScrollingFrame.CanvasPosition = Vector2.new(0, 0)
		end)
		var19_upvw = LocalPlayer_upvr.PlayerGui.BuildGui.SearchFrame.OnlySpecial:GetPropertyChangedSignal("Value"):Connect(function() -- Line 69
			--[[ Upvalues[1]:
				[1]: LocalPlayer_upvr (copied, readonly)
			]]
			updateBuildGui()
			LocalPlayer_upvr.PlayerGui.BuildGui.InventoryFrame.ScrollingFrame.CanvasPosition = Vector2.new(0, 0)
		end)
		var20_upvw = LocalPlayer_upvr.PlayerGui.BuildGui.SearchFrame.OnlySearch:GetPropertyChangedSignal("Value"):Connect(function() -- Line 73
			--[[ Upvalues[1]:
				[1]: LocalPlayer_upvr (copied, readonly)
			]]
			updateBuildGui()
			LocalPlayer_upvr.PlayerGui.BuildGui.InventoryFrame.ScrollingFrame.CanvasPosition = Vector2.new(0, 0)
		end)
		var21_upvw = LocalPlayer_upvr.Character.Humanoid.Died:Connect(uneq)
		updateBuildGui()
		local BuildGui = LocalPlayer_upvr.PlayerGui.BuildGui
		BuildGui.InventoryFrame.Visible = true
		BuildGui.ScaleButton.Visible = true
		BuildGui.SearchFrame.Visible = true
		if workspace.Challenge.Teams:FindFirstChild(LocalPlayer_upvr.Team.Name) then
			BuildGui.InventoryFrame.MoreFrame.AnchorBlock.toggle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			return
		end
		BuildGui.InventoryFrame.MoreFrame.AnchorBlock.toggle.BackgroundColor3 = Color3.fromRGB(132, 132, 132)
	end
end
function uneq() -- Line 95
	--[[ Upvalues[16]:
		[1]: var5_upvw (read and write)
		[2]: var4_upvw (read and write)
		[3]: var9_upvw (read and write)
		[4]: var10_upvw (read and write)
		[5]: var11_upvw (read and write)
		[6]: var12_upvw (read and write)
		[7]: var13_upvw (read and write)
		[8]: var14_upvw (read and write)
		[9]: var15_upvw (read and write)
		[10]: var16_upvw (read and write)
		[11]: var17_upvw (read and write)
		[12]: var18_upvw (read and write)
		[13]: var19_upvw (read and write)
		[14]: var20_upvw (read and write)
		[15]: var21_upvw (read and write)
		[16]: LocalPlayer_upvr (readonly)
	]]
	var5_upvw = var4_upvw.Name
	var4_upvw:Destroy()
	var9_upvw:Disconnect()
	var9_upvw = nil
	var10_upvw:Disconnect()
	var10_upvw = nil
	var11_upvw:Disconnect()
	var11_upvw = nil
	var12_upvw:Disconnect()
	var12_upvw = nil
	var13_upvw:Disconnect()
	var13_upvw = nil
	var14_upvw:Disconnect()
	var14_upvw = nil
	var15_upvw:Disconnect()
	var15_upvw = nil
	var16_upvw:Disconnect()
	var16_upvw = nil
	var17_upvw:Disconnect()
	var17_upvw = nil
	var18_upvw:Disconnect()
	var18_upvw = nil
	var19_upvw:Disconnect()
	var19_upvw = nil
	var20_upvw:Disconnect()
	var20_upvw = nil
	var21_upvw:Disconnect()
	var21_upvw = nil
	LocalPlayer_upvr.PlayerGui.TabletToolGui.Frame.Visible = false
	local BuildGui_2 = LocalPlayer_upvr.PlayerGui.BuildGui
	BuildGui_2.InventoryFrame.Visible = false
	BuildGui_2.Clear.Visible = false
	BuildGui_2.ScaleButton.Visible = false
	BuildGui_2.SearchFrame.Visible = false
end
local var33_upvw
function placeBlock(arg1) -- Line 134
	--[[ Upvalues[6]:
		[1]: var33_upvw (read and write)
		[2]: var4_upvw (read and write)
		[3]: LocalPlayer_upvr (readonly)
		[4]: var6_upvw (read and write)
		[5]: mouse_upvr (readonly)
		[6]: Parent_upvr (readonly)
	]]
	local var53
	local function INLINED_3() -- Internal function, doesn't exist in bytecode
		var53 = var4_upvw
		return var53
	end
	if var53 or not INLINED_3() then
	else
		var53 = var4_upvw:FindFirstChild("OutOfBoundsBG")
		if var53 then
			var53 = var4_upvw.OutOfBoundsBG:Destroy
			var53()
		end
		local function INLINED_4() -- Internal function, doesn't exist in bytecode
			var53 = var4_upvw.SecondaryPart
			return var53
		end
		if not var4_upvw:FindFirstChild("2ndPlacement") or not INLINED_4() then
			var53 = var4_upvw
		end
		local canPlace_result1, canPlace_result2_2 = canPlace(var53)
		if not canPlace_result1 then
			local BillboardGui_2 = Instance.new("BillboardGui")
			BillboardGui_2.Name = "OutOfBoundsBG"
			BillboardGui_2.AlwaysOnTop = true
			BillboardGui_2.Adornee = var4_upvw
			BillboardGui_2.MaxDistance = 1000
			BillboardGui_2.Size = UDim2.new(8, 0, 2, 0)
			BillboardGui_2.StudsOffset = Vector3.new(0, 3, 0)
			BillboardGui_2.ClipsDescendants = false
			BillboardGui_2.ZIndexBehavior = Enum.ZIndexBehavior.Global
			BillboardGui_2.LightInfluence = 0
			local TextLabel_3 = Instance.new("TextLabel")
			TextLabel_3.BackgroundTransparency = 1
			TextLabel_3.Size = UDim2.new(1, 0, 1, 0)
			TextLabel_3.Font = Enum.Font.Arcade
			TextLabel_3.Text = canPlace_result2_2
			TextLabel_3.TextColor3 = Color3.fromRGB(255, 106, 106)
			TextLabel_3.TextScaled = true
			TextLabel_3.TextWrapped = true
			TextLabel_3.TextStrokeTransparency = 0
			TextLabel_3.TextStrokeColor3 = Color3.fromRGB(91, 32, 32)
			TextLabel_3.Parent = BillboardGui_2
			BillboardGui_2.Parent = var4_upvw
			game.Debris:AddItem(BillboardGui_2, 1.5)
			return
		end
		var33_upvw = true
		spawn(function() -- Line 171
			--[[ Upvalues[1]:
				[1]: var33_upvw (copied, read and write)
			]]
			wait()
			var33_upvw = false
		end)
		local var59 = LocalPlayer_upvr.PlayerGui.BuildGui.InventoryFrame.ScrollingFrame.BlocksFrame[var4_upvw.Name]
		local AmountText = var59.AmountText
		local MaxText_2 = var59.MaxText
		if (tonumber(AmountText.Text) or 0) <= 0 then
			local clone = script.ClickSound:Clone()
			clone.Parent = var4_upvw.PrimaryPart
			game.Debris:AddItem(clone, 0.3)
			clone.PlaybackSpeed = 5
			clone:Play()
			LocalPlayer_upvr.PlayerGui.BuildGui.SearchFrame.ClearFilter:Invoke()
			local ScrollingFrame_2 = LocalPlayer_upvr.PlayerGui.BuildGui.InventoryFrame.ScrollingFrame
			ScrollingFrame_2.CanvasPosition += Vector2.new(0, (var59.AbsolutePosition.Y - 252) + (251 - LocalPlayer_upvr.PlayerGui.BuildGui.InventoryFrame.AbsolutePosition.Y))
			if MaxText_2.Visible then
			else
				AmountText.Visible = false
				MaxText_2.Visible = true
				wait(0.5)
				AmountText.Visible = true
				MaxText_2.Visible = false
			end
		end
		clone = true
		local var64 = clone
		if var4_upvw.Name ~= "Spring" then
			var64 = true
			if var4_upvw.Name ~= "Bar" then
				if var4_upvw.Name ~= "Rope" then
					var64 = false
				else
					var64 = true
				end
			end
		end
		if var64 then
			if not var4_upvw:FindFirstChild("2ndPlacement") then
				local BoolValue = Instance.new("BoolValue")
				BoolValue.Name = "2ndPlacement"
				BoolValue.Parent = var4_upvw
				updateBlockCF()
				return
			end
			BoolValue:Destroy()
		end
		BoolValue = var64
		local var66 = BoolValue
		if var66 then
			var66 = var4_upvw.SecondaryPart.PrimaryPart.CFrame
		end
		changeTransparency(var4_upvw, 0)
		game.Debris:AddItem(var4_upvw, 10)
		local var67
		if var6_upvw then
			var67 = var6_upvw.CFrame:toObjectSpace(var4_upvw.PrimaryPart.CFrame)
		end
		local clone_5 = script.ClickSound:Clone()
		clone_5.Parent = var4_upvw.PrimaryPart
		game.Debris:AddItem(clone_5, 1)
		clone_5.PlaybackSpeed = 1
		clone_5:Play()
		if LocalPlayer_upvr.PlayerGui.BuildGui.InventoryFrame.MoreFrame.RelativeRotation.RelativeRotation.Value then
			resetRotation()
		end
		local var69 = var4_upvw
		var4_upvw = var4_upvw:Clone()
		changeTransparency(var4_upvw, 0.5)
		var4_upvw.Parent = workspace
		mouse_upvr.TargetFilter = var4_upvw
		updateBlockCF(arg1)
		updateBuildGui()
		if var64 then
			local var70 = game.ReplicatedStorage.BuildingParts[var4_upvw.Name]
			var4_upvw.SecondaryPart.PrimaryPart.CFrame = var4_upvw.PrimaryPart.CFrame * var70.PrimaryPart.CFrame:ToObjectSpace(var70.SecondaryPart.PrimaryPart.CFrame)
		end
		Parent_upvr.RF:InvokeServer(var69.Name, LocalPlayer_upvr.Data:FindFirstChild(var69.Name).Value, var6_upvw, var67, LocalPlayer_upvr.PlayerGui.BuildGui.InventoryFrame.MoreFrame.AnchorBlock.Anchor.Value, var69.PrimaryPart.CFrame, var66)
		var69:Destroy()
	end
end
local var71_upvw
local var72_upvw
local var73_upvw
function updateBlockCF(arg1) -- Line 266
	--[[ Upvalues[8]:
		[1]: mouse_upvr (readonly)
		[2]: var4_upvw (read and write)
		[3]: var6_upvw (read and write)
		[4]: var71_upvw (read and write)
		[5]: var72_upvw (read and write)
		[6]: zero_cframe_upvw (read and write)
		[7]: LocalPlayer_upvr (readonly)
		[8]: var73_upvw (read and write)
	]]
	-- KONSTANTERROR: [0] 1. Error Block 60 start (CF ANALYSIS FAILED)
	local var74
	if not var74 then return end
	local function INLINED_5() -- Internal function, doesn't exist in bytecode
		var74 = var4_upvw.SecondaryPart
		return var74
	end
	if not var4_upvw:FindFirstChild("2ndPlacement") or not INLINED_5() then
		var74 = var4_upvw
	end
	if not arg1 then
		var6_upvw = mouse_upvr.Target
		var71_upvw = mouse_upvr.Hit
		var72_upvw = mouse_upvr.TargetSurface
	end
	local var75 = zero_cframe_upvw
	local any_Inverse_result1 = var6_upvw.CFrame - var6_upvw.Position:Inverse()
	if LocalPlayer_upvr.PlayerGui.BuildGui.InventoryFrame.MoreFrame.RelativeRotation.RelativeRotation.Value then
		any_Inverse_result1 = CFrame.new(0, 0, 0)
	end
	local normalIdToNormalVector_result1, normalIdToNormalVector_result2 = normalIdToNormalVector(var72_upvw, var6_upvw)
	local var79 = var6_upvw.CFrame * CFrame.new((normalIdToNormalVector_result1) * (normalIdToNormalVector_result2 / 2))
	var74:SetPrimaryPartCFrame(var79 * any_Inverse_result1 * var75)
	local any_PointToWorldSpace_result1 = var6_upvw.CFrame - var6_upvw.Position:PointToWorldSpace(normalIdToNormalVector_result1)
	var74:SetPrimaryPartCFrame(var79 * any_Inverse_result1:Inverse() * var75:Inverse())
	local any_PointToObjectSpace_result1 = var6_upvw.CFrame:PointToObjectSpace(var71_upvw.p)
	if var72_upvw == Enum.NormalId.Top or var72_upvw == Enum.NormalId.Bottom then
		any_PointToObjectSpace_result1 -= Vector3.new(0, any_PointToObjectSpace_result1.Y, 0)
	elseif var72_upvw == Enum.NormalId.Front or var72_upvw == Enum.NormalId.Back then
		any_PointToObjectSpace_result1 -= Vector3.new(0, 0, any_PointToObjectSpace_result1.Z)
	else
		any_PointToObjectSpace_result1 -= Vector3.new(any_PointToObjectSpace_result1.X, 0, 0)
	end
	local var82 = tonumber(LocalPlayer_upvr.PlayerGui.BuildGui.InventoryFrame.MoreFrame.Move.TextLabel.Text) or 1
	-- KONSTANTERROR: [0] 1. Error Block 60 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [264] 187. Error Block 22 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [264] 187. Error Block 22 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [270] 192. Error Block 23 start (CF ANALYSIS FAILED)
	var74:SetPrimaryPartCFrame(var79 * CFrame.new(normalIdToNormalVector_result1 * ((math.abs(var74.PrimaryPart.CFrame.RightVector:Dot(any_PointToWorldSpace_result1))) * (var74.PrimaryPart.Size.X / 2) + (math.abs(var74.PrimaryPart.CFrame.UpVector:Dot(any_PointToWorldSpace_result1))) * (var74.PrimaryPart.Size.Y / 2) + (math.abs(var74.PrimaryPart.CFrame.LookVector:Dot(any_PointToWorldSpace_result1))) * (var74.PrimaryPart.Size.Z / 2))) * CFrame.new(roundVectorToBase(any_PointToObjectSpace_result1, var82)) * any_Inverse_result1 * var75)
	-- KONSTANTERROR: [270] 192. Error Block 23 end (CF ANALYSIS FAILED)
end
local CollectionService_upvr = game:GetService("CollectionService")
function changeTransparency(arg1, arg2) -- Line 360
	--[[ Upvalues[1]:
		[1]: CollectionService_upvr (readonly)
	]]
	local descendants_2 = arg1:GetDescendants()
	for i = 1, #descendants_2 do
		if descendants_2[i]:IsA("BasePart") then
			if CollectionService_upvr:HasTag(descendants_2[i], "NoTransparency") then
				descendants_2[i].Transparency = 0
			elseif CollectionService_upvr:HasTag(descendants_2[i], "FullTransparency") then
				descendants_2[i].Transparency = 1
			else
				descendants_2[i].Transparency = arg2
			end
		end
	end
end
local QuestConditions_upvr = require(game.ReplicatedStorage.Scripts.QuestConditions)
local ChallengeConditions_upvr = require(game.ReplicatedStorage.Scripts.ChallengeConditions)
function canPlace(arg1) -- Line 375
	--[[ Upvalues[4]:
		[1]: LocalPlayer_upvr (readonly)
		[2]: QuestConditions_upvr (readonly)
		[3]: var4_upvw (read and write)
		[4]: ChallengeConditions_upvr (readonly)
	]]
	local SOME_4 = workspace:FindFirstChild(tostring(LocalPlayer_upvr.TeamColor).."Zone")
	local var110
	local isPartInZone_result1_2 = isPartInZone(arg1.PrimaryPart, SOME_4)
	if not isPartInZone_result1_2 then
		var110 = "Out of bounds"
	end
	local var86_result1, var86_result2 = QuestConditions_upvr(SOME_4, arg1.PrimaryPart.CFrame, var4_upvw.Name, 1, LocalPlayer_upvr)
	local any_blockLimitChallengeReached_result1, any_blockLimitChallengeReached_result2 = ChallengeConditions_upvr.blockLimitChallengeReached(LocalPlayer_upvr, 1)
	local any_itemRestriction_result1, any_itemRestriction_result2_3 = ChallengeConditions_upvr.itemRestriction(LocalPlayer_upvr, var4_upvw.Name)
	local var118 = isPartInZone_result1_2
	if var118 then
		var118 = var86_result1
		if var118 then
			var118 = not any_blockLimitChallengeReached_result1
			if var118 then
				var118 = not any_itemRestriction_result1
			end
		end
	end
	local var119 = var110
	if not var119 then
		var119 = var86_result2
		if not var119 then
			var119 = any_blockLimitChallengeReached_result2
			if not var119 then
				var119 = any_itemRestriction_result2_3
			end
		end
	end
	return var118, var119
end
function isPartInZone(arg1, arg2) -- Line 392
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local Position = arg1.Position
	local Position_2 = arg2.Position
	local Size = arg2.Size
	local var123
	if 89 < arg2.Rotation.Y and arg2.Rotation.Y < 91 or arg2.Rotation.Y < -89 and -91 < arg2.Rotation.Y then
		var123 = Size.Z
		local X = Size.X
	end
	if Position_2.X - var123 / 2 < Position.X and Position.X < Position_2.X + var123 / 2 and Position_2.Z - X / 2 < Position.Z and Position.Z < Position_2.Z + X / 2 then
		return true
	end
	return false
end
function roundVectorToBase(arg1, arg2) -- Line 412
	local var125 = 1 / arg2
	local var126 = arg1 * var125 + Vector3.new(0.5, 0.5, 0.5)
	return Vector3.new(math.floor(var126.X), math.floor(var126.Y), math.floor(var126.Z)) / var125
end
function normalIdToNormalVector(arg1, arg2) -- Line 421
	if arg1 == Enum.NormalId.Top then
		return Vector3.new(0, 1, 0), arg2.Size.Y
	end
	if arg1 == Enum.NormalId.Bottom then
		return Vector3.new(0, -1, 0), arg2.Size.Y
	end
	if arg1 == Enum.NormalId.Front then
		return Vector3.new(0, 0, -1), arg2.Size.Z
	end
	if arg1 == Enum.NormalId.Back then
		return Vector3.new(0, 0, 1), arg2.Size.Z
	end
	if arg1 == Enum.NormalId.Right then
		return Vector3.new(1, 0, 0), arg2.Size.X
	end
	return Vector3.new(-1, 0, 0), arg2.Size.X
end
function prepareItem() -- Line 438
	--[[ Upvalues[2]:
		[1]: mouse_upvr (readonly)
		[2]: var4_upvw (read and write)
	]]
	mouse_upvr.TargetFilter = var4_upvw
	changeTransparency(var4_upvw, 0.5)
	local descendants_3 = var4_upvw:GetDescendants()
	for i_2 = 1, #descendants_3 do
		if descendants_3[i_2]:IsA("BasePart") then
			descendants_3[i_2].Anchored = true
			descendants_3[i_2].CanCollide = false
			if descendants_3[i_2] ~= var4_upvw.PrimaryPart then
				WeldTogether(var4_upvw.PrimaryPart, descendants_3[i_2])
			end
		end
	end
end
function WeldTogether(arg1, arg2, arg3, arg4) -- Line 453
	-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [5] 5. Error Block 7 start (CF ANALYSIS FAILED)
	if arg2:FindFirstChild("NoWelds") then
		-- KONSTANTERROR: [10] 9. Error Block 3 start (CF ANALYSIS FAILED)
		do
			return
		end
		-- KONSTANTERROR: [10] 9. Error Block 3 end (CF ANALYSIS FAILED)
	end
	local any = Instance.new(arg3 or "Weld")
	any.Part0 = arg1
	any.Part1 = arg2
	any.C0 = CFrame.new()
	any.C1 = arg2.CFrame:toObjectSpace(arg1.CFrame)
	any.Parent = arg4 or arg1
	do
		return any
	end
	-- KONSTANTERROR: [5] 5. Error Block 7 end (CF ANALYSIS FAILED)
end
function itemChanged() -- Line 467
	--[[ Upvalues[2]:
		[1]: LocalPlayer_upvr (readonly)
		[2]: var4_upvw (read and write)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local Value = LocalPlayer_upvr.PlayerGui.BuildGui.InventoryFrame.ScrollingFrame.BlocksFrame.Selected.Value
	local SOME_2 = game.ReplicatedStorage.BuildingParts:FindFirstChild(Value)
	updateBuildGui()
	var4_upvw:Destroy()
	var4_upvw = SOME_2:Clone()
	var4_upvw:SetPrimaryPartCFrame(CFrame.new(var4_upvw.PrimaryPart.CFrame.p) * SOME_2.PrimaryPart.CFrame.Rotation)
	resetRotation()
	prepareItem()
	updateBlockCF()
	var4_upvw.Parent = workspace
	local TagsFrame = LocalPlayer_upvr.PlayerGui.BuildGui.InventoryFrame.MoreFrame.TagsFrame
	local string_split_result1 = string.split(LocalPlayer_upvr.PlayerGui.BuildGui.InventoryFrame.ScrollingFrame.BlocksFrame[Value].Tags.Value, ' ')
	local children_2 = TagsFrame:GetChildren()
	local TextLabel = TagsFrame.TextLabel
	for i_3 = 1, #string_split_result1 do
		local clone_2 = TextLabel:Clone()
		clone_2.Text = string.lower(string_split_result1[i_3])
		clone_2.Parent = TextLabel.Parent
	end
	for i_4 = 1, #children_2 do
		children_2[i_4]:Destroy()
	end
	TagsFrame.Parent.BlockName.Text = LocalPlayer_upvr.PlayerGui.BuildGui.InventoryFrame.ScrollingFrame.BlocksFrame[Value].BlockName.Value
	TagsFrame.Parent.StrengthFrame.TextLabel.Text = tostring(game.ReplicatedStorage.BuildingParts[Value].Health.Value)
end
function resetRotation() -- Line 502
	--[[ Upvalues[3]:
		[1]: LocalPlayer_upvr (readonly)
		[2]: var4_upvw (read and write)
		[3]: zero_cframe_upvw (read and write)
	]]
	if not LocalPlayer_upvr.PlayerGui.BuildGui.InventoryFrame.MoreFrame.RelativeRotation.RelativeRotation.Value then
		local var147 = workspace[tostring(LocalPlayer_upvr.TeamColor).."Zone"]
		zero_cframe_upvw = (var147.CFrame - var147.Position) * (var4_upvw.PrimaryPart.CFrame - var4_upvw.PrimaryPart.Position)
	else
		zero_cframe_upvw = CFrame.new()
	end
end
local LocalizationService_upvr = game:GetService("LocalizationService")
function updateBuildGui() -- Line 513
	--[[ Upvalues[2]:
		[1]: LocalPlayer_upvr (readonly)
		[2]: LocalizationService_upvr (readonly)
	]]
	-- KONSTANTERROR: [0] 1. Error Block 37 start (CF ANALYSIS FAILED)
	local SOME = game.Players:FindFirstChild(LocalPlayer_upvr.Team.TeamLeader.Value)
	local var150
	if SOME and LocalPlayer_upvr.Settings.ShareBlocks.Value then
		var150 = SOME
	end
	local _ = 1
	-- KONSTANTERROR: [0] 1. Error Block 37 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [206] 140. Error Block 34 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [206] 140. Error Block 34 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [61] 39. Error Block 5 start (CF ANALYSIS FAILED)
	-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [206.13]
	-- KONSTANTERROR: [61] 39. Error Block 5 end (CF ANALYSIS FAILED)
end
function fitBuildScroll() -- Line 577
	--[[ Upvalues[1]:
		[1]: LocalPlayer_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local ScrollingFrame_3 = LocalPlayer_upvr.PlayerGui.BuildGui.InventoryFrame.ScrollingFrame
	local children = ScrollingFrame_3.BlocksFrame:GetChildren()
	local var160
	local var161
	for i_5 = 1, #children do
		if children[i_5]:IsA("GuiObject") then
			if children[i_5].Visible then
				if not var160 or var160 < children[i_5].AbsolutePosition.Y then
					local Y = children[i_5].AbsolutePosition.Y
				end
				if not var161 or children[i_5].AbsolutePosition.Y < var161 then
					var161 = children[i_5].AbsolutePosition.Y
				end
			end
		end
	end
	if var161 then
		if Y then
			i_5 = 0
			ScrollingFrame_3.CanvasSize = UDim2.new(i_5, 0, 0, Y - var161 + 100)
			return
		end
	end
	ScrollingFrame_3.CanvasSize = UDim2.new(0, 0, 0, 0)
end
function getType(arg1) -- Line 600
	local string_match_result1 = string.match(arg1.TypeIcon.Image, "%d+")
	if string_match_result1 == "4597411234" then
		return "Block"
	end
	if string_match_result1 == "4597402658" then
		return "Decoration"
	end
	return "Special"
end
function isSpeedBuild() -- Line 611
	--[[ Upvalues[1]:
		[1]: LocalPlayer_upvr (readonly)
	]]
	local SpeedBuild = LocalPlayer_upvr.OtherData:FindFirstChild("SpeedBuild")
	if SpeedBuild and SpeedBuild.Value then
		return true
	end
	return nil
end
local var165_upvw
function toggleSpeedBuild() -- Line 619
	--[[ Upvalues[2]:
		[1]: var165_upvw (read and write)
		[2]: LocalPlayer_upvr (readonly)
	]]
	if var165_upvw then
	else
		var165_upvw = true
		spawn(function() -- Line 624
			--[[ Upvalues[1]:
				[1]: var165_upvw (copied, read and write)
			]]
			wait(0.2)
			var165_upvw = false
		end)
		local SpeedBuildToggle_2 = LocalPlayer_upvr.PlayerGui.TabletToolGui.Frame.SpeedBuildToggle
		if string.match(SpeedBuildToggle_2.Image, "%d+") == "4603565059" then
			SpeedBuildToggle_2.Image = "http://www.roblox.com/asset/?id=4603565249"
			workspace.UpdateSpeedBuildStats:FireServer(true)
			return
		end
		SpeedBuildToggle_2.Image = "http://www.roblox.com/asset/?id=4603565059"
		workspace.UpdateSpeedBuildStats:FireServer(false)
	end
end
function setSpeedBuildGuiLook() -- Line 640
	--[[ Upvalues[1]:
		[1]: LocalPlayer_upvr (readonly)
	]]
	local SpeedBuildToggle = LocalPlayer_upvr.PlayerGui.TabletToolGui.Frame.SpeedBuildToggle
	if isSpeedBuild() then
		SpeedBuildToggle.Image = "http://www.roblox.com/asset/?id=4603565249"
	else
		SpeedBuildToggle.Image = "http://www.roblox.com/asset/?id=4603565059"
	end
end
function rotateY() -- Line 649
	--[[ Upvalues[2]:
		[1]: LocalPlayer_upvr (readonly)
		[2]: zero_cframe_upvw (read and write)
	]]
	zero_cframe_upvw *= CFrame.Angles(0, math.rad(tonumber(LocalPlayer_upvr.PlayerGui.BuildGui.InventoryFrame.MoreFrame.Rotate.TextLabel.Text) or 90), 0)
	updateBlockCF(true)
end
function rotateX() -- Line 657
	--[[ Upvalues[2]:
		[1]: LocalPlayer_upvr (readonly)
		[2]: zero_cframe_upvw (read and write)
	]]
	zero_cframe_upvw *= CFrame.Angles(math.rad(tonumber(LocalPlayer_upvr.PlayerGui.BuildGui.InventoryFrame.MoreFrame.Rotate.TextLabel.Text) or 90), 0, 0)
	updateBlockCF(true)
end
function inputChanged(arg1, arg2) -- Line 665
	if arg1.UserInputType == Enum.UserInputType.MouseMovement then
		updateBlockCF()
	elseif arg1.KeyCode == Enum.KeyCode.Thumbstick1 or arg1.KeyCode == Enum.KeyCode.Thumbstick2 then
		updateBlockCF()
	end
end
function inputBegan(arg1, arg2) -- Line 673
	--[[ Upvalues[3]:
		[1]: LocalPlayer_upvr (readonly)
		[2]: var8_upvw (read and write)
		[3]: mouse_upvr (readonly)
	]]
	-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [17] 11. Error Block 5 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [17] 11. Error Block 5 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [27] 17. Error Block 30 start (CF ANALYSIS FAILED)
	if arg1.UserInputType == Enum.UserInputType.MouseButton1 then
		placeBlock()
	else
		if arg1.UserInputType == Enum.UserInputType.Touch then
			LocalPlayer_upvr.PlayerGui.TabletToolGui.Frame.Visible = true
			if isSpeedBuild() then
				var8_upvw = mouse_upvr.Hit
			else
				updateBlockCF()
			end
		end
		if arg1.UserInputType == Enum.UserInputType.Gamepad1 then
			if arg1.KeyCode == Enum.KeyCode.ButtonR2 then
				placeBlock()
				return
			end
			if arg1.KeyCode == Enum.KeyCode.ButtonX then
				rotateY()
				return
			end
			if arg1.KeyCode == Enum.KeyCode.ButtonY then
				rotateX()
			end
		end
		-- KONSTANTERROR: [27] 17. Error Block 30 end (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [101] 62. Error Block 20 start (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [101] 62. Error Block 20 end (CF ANALYSIS FAILED)
	end
end
function inputEnded(arg1, arg2) -- Line 706
	--[[ Upvalues[2]:
		[1]: mouse_upvr (readonly)
		[2]: var8_upvw (read and write)
	]]
	if not arg2 and arg1.UserInputType == Enum.UserInputType.Touch then
		if isSpeedBuild() and (mouse_upvr.Hit.p - var8_upvw.p).Magnitude < 1 then
			updateBlockCF()
			placeBlock(true)
		end
	end
end
Parent_upvr.Equipped:Connect(eq)
Parent_upvr.Unequipped:Connect(uneq)