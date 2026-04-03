-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-03 13:22:36
-- Luau version 6, Types version 3
-- Time taken: 0.146621 seconds

local LocalPlayer_upvr = game.Players.LocalPlayer
local CurrentCamera_upvr = workspace.CurrentCamera
local UserInputService_upvr = game:GetService("UserInputService")
local RunService_upvr = game:GetService("RunService")
function isMobilePlayer() -- Line 14
	--[[ Upvalues[1]:
		[1]: UserInputService_upvr (readonly)
	]]
	local var5
	if UserInputService_upvr:GetLastInputType() ~= Enum.UserInputType.Touch then
		var5 = false
	else
		var5 = true
	end
	return var5
end
local var6_upvw
function active(arg1, arg2, arg3) -- Line 19
	--[[ Upvalues[2]:
		[1]: LocalPlayer_upvr (readonly)
		[2]: var6_upvw (read and write)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local var23
	if LocalPlayer_upvr.PlayerGui:FindFirstChild("Chat") then
		var23 = LocalPlayer_upvr.PlayerGui.Chat.Frame.ChatBarParentFrame.Frame.BoxFrame
		if var23.Frame.ChatBar:IsFocused() then return end
	end
	var23 = nil
	if not arg2 and (not LocalPlayer_upvr.Character or not LocalPlayer_upvr.Character:FindFirstChildOfClass("Tool")) or arg1.UserInputType == Enum.UserInputType.MouseButton1 or arg1.UserInputType == Enum.UserInputType.Touch or arg1.KeyCode == Enum.KeyCode.ButtonR2 then
		if arg3 == "start" then
			local Target_3 = LocalPlayer_upvr:GetMouse().Target
			if Target_3 then
				local var25
				if var25 then
					var25 = Target_3.Parent:FindFirstChild("ControllerId")
					if not var25 then
						var25 = Target_3.Parent.Parent:FindFirstChild("ControllerId")
					end
					if var25 then
						local var26
						if var25.Parent:FindFirstChildOfClass("ClickDetector") then
							local Parent_4 = var25.Parent
							var26 = true
							if Parent_4.Name ~= "Lever" then
								var26 = true
								if Parent_4.Name ~= "Switch" then
									if Parent_4.Name ~= "SwitchBig" then
										var26 = false
									else
										var26 = true
									end
								end
							end
							local var28
							if Parent_4.Name ~= "Button" then
								var28 = false
							else
								var28 = true
							end
							if LocalPlayer_upvr.Character and LocalPlayer_upvr.Character:FindFirstChild("HumanoidRootPart") and (LocalPlayer_upvr.Character.HumanoidRootPart.Position - Parent_4.PrimaryPart.Position).Magnitude <= Parent_4:FindFirstChildOfClass("ClickDetector").MaxActivationDistance + 0.5 then
								if var26 then
									if Parent_4.On.Value then
									else
									end
									var23 = Parent_4.PrimaryPart
								elseif var28 then
									var6_upvw = Parent_4
									var23 = Parent_4.PrimaryPart
									-- KONSTANTWARNING: GOTO [256] #173
								end
								-- KONSTANTWARNING: GOTO [256] #173
							end
							-- KONSTANTWARNING: GOTO [256] #173
						end
					end
					local function INLINED_7() -- Internal function, doesn't exist in bytecode
						local Parent_3 = Target_3.Parent
						return (LocalPlayer_upvr.Character.HumanoidRootPart.Position - Parent_3.PrimaryPart.Position).Magnitude <= Parent_3:FindFirstChildOfClass("ClickDetector").MaxActivationDistance + 0.5
					end
					if Target_3.Parent:FindFirstChildOfClass("ClickDetector") and (Target_3.Parent.Name == "Camera" or Target_3.Parent.Name == "CameraDome") or INLINED_7() then
						checkIfCamera(Target_3.Parent, arg1, "start", nil, var23, false, true)
						-- KONSTANTWARNING: GOTO [256] #173
					end
					-- KONSTANTWARNING: GOTO [256] #173
				end
				-- KONSTANTWARNING: GOTO [256] #173
			end
		else
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect
			if "start" == "stop" and var6_upvw then
				var23 = var6_upvw.PrimaryPart
				var6_upvw = nil
			end
		end
	end
	if not var23 then
		var23 = script.Parent.Humanoid.SeatPart
		local var30
	end
	if not var30 and var23 then
		if var23.Parent and var23:IsA("VehicleSeat") then
			var30 = var23.Parent:GetChildren()
		end
	end
	if var30 then
		-- KONSTANTERROR: Expression was reused, decompilation is incorrect
		runBeams(var30, arg1, "start", nil, var23, nil, true)
	end
end
local tbl_7_upvr = {}
local var32_upvw = false
function runBeams(arg1, arg2, arg3, arg4, arg5, arg6, arg7) -- Line 110
	--[[ Upvalues[2]:
		[1]: tbl_7_upvr (readonly)
		[2]: var32_upvw (read and write)
	]]
	-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
	local _ = 1
	-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [101] 66. Error Block 18 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [101] 66. Error Block 18 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [4] 5. Error Block 31 start (CF ANALYSIS FAILED)
	-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [101.11]
	if nil then
		-- KONSTANTERROR: Expression was reused, decompilation is incorrect (x4)
		if nil and nil and nil and nil then
			if arg4 == nil then
			end
			-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [101.13]
			-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [101.67579]
			-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [101.14]
			if nil < nil then
				-- KONSTANTWARNING: GOTO [101] #66
			end
		else
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect (x4)
			if nil == nil or nil == nil or nil == nil or nil == nil then
			end
		end
	end
	-- KONSTANTERROR: [4] 5. Error Block 31 end (CF ANALYSIS FAILED)
end
function gamepadActive(arg1, arg2) -- Line 159
	if arg1.KeyCode == Enum.KeyCode.Thumbstick1 then
		active(arg1, arg2, "start")
	end
end
local tbl_6_upvw = {}
local var35_upvw = false
function sendRequestToOtherClients(arg1, arg2, arg3, arg4, arg5, arg6, arg7) -- Line 169
	--[[ Upvalues[3]:
		[1]: LocalPlayer_upvr (readonly)
		[2]: tbl_6_upvw (read and write)
		[3]: var35_upvw (read and write)
	]]
	if arg6 then
	else
		local tbl_3 = {}
		tbl_3[1] = arg1
		tbl_3[2] = arg2.KeyCode
		tbl_3[3] = arg2.UserInputType
		tbl_3[4] = arg3
		tbl_3[5] = arg5
		tbl_3[6] = arg4
		tbl_3[7] = arg7
		tbl_3[8] = LocalPlayer_upvr
		table.insert(tbl_6_upvw, 1, tbl_3)
		table.remove(tbl_6_upvw, 51)
		if var35_upvw then return end
		var35_upvw = true
		spawn(function() -- Line 192
			--[[ Upvalues[2]:
				[1]: tbl_6_upvw (copied, read and write)
				[2]: var35_upvw (copied, read and write)
			]]
			while 0 < #tbl_6_upvw do
				script.ControlOtherClientsRE:FireServer(tbl_6_upvw)
				tbl_6_upvw = {}
				wait()
			end
			var35_upvw = false
		end)
	end
end
function requestedControl(arg1) -- Line 205
	for i = #arg1, 1, -1 do
		local var39 = arg1[i]
		trigger(var39[1], {
			KeyCode = var39[2];
			UserInputType = var39[3];
		}, var39[4], var39[6], var39[5], var39[8], var39[7])
	end
end
function trigger(arg1, arg2, arg3, arg4, arg5, arg6, arg7) -- Line 227
	local checkIfWheelOld_result1, checkIfWheelOld_result2 = checkIfWheelOld(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
	if checkIfWheelOld_result1 then
		return checkIfWheelOld_result2
	end
	local checkIfPilotSeat_result1, checkIfPilotSeat_result2 = checkIfPilotSeat(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
	if checkIfPilotSeat_result1 then
		return checkIfPilotSeat_result2
	end
	local checkIfServo_result1, checkIfServo_result2 = checkIfServo(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
	if checkIfServo_result1 then
		return checkIfServo_result2
	end
	local checkIfPiston_result1, checkIfPiston_result2 = checkIfPiston(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
	if checkIfPiston_result1 then
		return checkIfPiston_result2
	end
	local checkIfBoatMotor_result1, checkIfBoatMotor_result2 = checkIfBoatMotor(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
	if checkIfBoatMotor_result1 then
		return checkIfBoatMotor_result2
	end
	local checkIfWheel_result1, checkIfWheel_result2 = checkIfWheel(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
	if checkIfWheel_result1 then
		return checkIfWheel_result2
	end
	local checkIfCamera_result1, checkIfCamera_result2 = checkIfCamera(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
	if checkIfCamera_result1 then
		return checkIfCamera_result2
	end
	local checkIfLeverOrSwitch_result1, checkIfLeverOrSwitch_result2 = checkIfLeverOrSwitch(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
	if checkIfLeverOrSwitch_result1 then
		return checkIfLeverOrSwitch_result2
	end
	local checkIfButton_result1, checkIfButton_result2 = checkIfButton(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
	if checkIfButton_result1 then
		return checkIfButton_result2
	end
	local checkIfDelay_result1, checkIfDelay_result2 = checkIfDelay(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
	if checkIfDelay_result1 then
		return checkIfDelay_result2
	end
	local checkIfNote_result1, checkIfNote_result2 = checkIfNote(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
	if checkIfNote_result1 then
		return checkIfNote_result2
	end
	local checkIfBasicActivatedServerSidedItem_result1, checkIfBasicActivatedServerSidedItem_result2 = checkIfBasicActivatedServerSidedItem(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
	if checkIfBasicActivatedServerSidedItem_result1 then
		return checkIfBasicActivatedServerSidedItem_result2
	end
end
function checkIfWheelOld(arg1, arg2, arg3, arg4, arg5, arg6, arg7) -- Line 308
	-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
	local var67
	-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [5] 4. Error Block 2 start (CF ANALYSIS FAILED)
	var67 = arg1.Name
	-- KONSTANTERROR: [5] 4. Error Block 2 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [9] 6. Error Block 128 start (CF ANALYSIS FAILED)
	var67 = findSpinFactor(arg1.PrimaryPart, arg5)
	if not arg1:FindFirstChild("SpinFactor") then
		local IntValue_3 = Instance.new("IntValue")
		IntValue_3.Name = "SpinFactor"
		IntValue_3.Value = var67
		IntValue_3.Parent = arg1
	else
		var67 = arg1.SpinFactor.Value
	end
	if arg1.ReverseSpin.Value then
		var67 = -var67
	end
	if not arg4 then
		if arg2.KeyCode.Value == arg1.BindUp.Value and arg2.KeyCode.Value ~= 0 or arg1.BindUp.Value == 0 and arg2.UserInputType == Enum.UserInputType.MouseButton1 then
			if arg3 == "start" then
				arg1.PrimaryPart.HingeConstraint.AngularVelocity = arg1.MaxSpeed.Value * var67
				sendRequestToOtherClients(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
			else
				-- KONSTANTERROR: Expression was reused, decompilation is incorrect
				if arg1.PrimaryPart.HingeConstraint.AngularVelocity == arg1.MaxSpeed.Value * var67 then
					arg1.PrimaryPart.HingeConstraint.AngularVelocity = 0
					sendRequestToOtherClients(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
					if not arg6 then
						checkAllKeysDown(arg1, arg4, arg5)
						-- KONSTANTWARNING: GOTO [342] #229
					end
					-- KONSTANTWARNING: GOTO [342] #229
				end
			end
			-- KONSTANTWARNING: GOTO [342] #229
		end
	end
	if not arg4 and arg1.BindUp.Value == -1 and (arg2.KeyCode == Enum.KeyCode.W or arg2.KeyCode == Enum.KeyCode.Up) then
		if arg3 == "start" then
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect
			arg1.PrimaryPart.HingeConstraint.AngularVelocity = arg1.MaxSpeed.Value * var67
			sendRequestToOtherClients(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
		else
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect
			if arg1.PrimaryPart.HingeConstraint.AngularVelocity == arg1.MaxSpeed.Value * var67 then
				arg1.PrimaryPart.HingeConstraint.AngularVelocity = 0
				sendRequestToOtherClients(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
				if not arg6 then
					checkAllKeysDown(arg1, arg4, arg5)
					-- KONSTANTWARNING: GOTO [342] #229
				end
				-- KONSTANTWARNING: GOTO [342] #229
			end
		end
		-- KONSTANTWARNING: GOTO [342] #229
	end
	if not arg4 and arg1.BindUp.Value == -1 and arg2.KeyCode == Enum.KeyCode.ButtonR2 and 0 < arg2.Delta.Z then
		-- KONSTANTERROR: Expression was reused, decompilation is incorrect
		arg1.PrimaryPart.HingeConstraint.AngularVelocity = arg1.MaxSpeed.Value * var67
		sendRequestToOtherClients(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
		-- KONSTANTWARNING: GOTO [342] #229
	end
	-- KONSTANTERROR: [9] 6. Error Block 128 end (CF ANALYSIS FAILED)
end
function checkIfServo(arg1, arg2, arg3, arg4, arg5, arg6, arg7) -- Line 486
	--[[ Upvalues[1]:
		[1]: UserInputService_upvr (readonly)
	]]
	-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [5] 4. Error Block 137 start (CF ANALYSIS FAILED)
	local var71 = 1
	if arg1.ReverseRotation.Value then
		var71 = -1
	end
	if not arg4 then
		if arg2.KeyCode.Value == arg1.BindLeft.Value and arg2.KeyCode.Value ~= 0 or arg1.BindLeft.Value == 0 and arg2.UserInputType == Enum.UserInputType.MouseButton1 then
			if arg3 == "start" then
				arg1.PrimaryPart.HingeConstraint.TargetAngle = arg1.TargetAngle.Value * var71
				sendRequestToOtherClients(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
			else
				-- KONSTANTERROR: Expression was reused, decompilation is incorrect
				if arg1.PrimaryPart.HingeConstraint.TargetAngle == arg1.TargetAngle.Value * var71 then
					arg1.PrimaryPart.HingeConstraint.TargetAngle = 0
					sendRequestToOtherClients(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
					if not arg6 then
						checkAllKeysDown(arg1, arg4, arg5)
						-- KONSTANTWARNING: GOTO [326] #220
					end
					-- KONSTANTWARNING: GOTO [326] #220
				end
			end
			-- KONSTANTWARNING: GOTO [326] #220
		end
	end
	if not arg4 and arg1.BindLeft.Value == -1 and (arg2.KeyCode == Enum.KeyCode.A or arg2.KeyCode == Enum.KeyCode.Left) then
		if arg3 == "start" then
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect
			arg1.PrimaryPart.HingeConstraint.TargetAngle = arg1.TargetAngle.Value * var71
			sendRequestToOtherClients(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
		else
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect
			if arg1.PrimaryPart.HingeConstraint.TargetAngle == arg1.TargetAngle.Value * var71 then
				arg1.PrimaryPart.HingeConstraint.TargetAngle = 0
				sendRequestToOtherClients(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
				if not arg6 then
					checkAllKeysDown(arg1, arg4, arg5)
					-- KONSTANTWARNING: GOTO [326] #220
				end
				-- KONSTANTWARNING: GOTO [326] #220
			end
		end
		-- KONSTANTWARNING: GOTO [326] #220
	end
	-- KONSTANTERROR: [5] 4. Error Block 137 end (CF ANALYSIS FAILED)
end
local var72_upvw
function checkIfPilotSeat(arg1, arg2, arg3, arg4, arg5, arg6, arg7) -- Line 659
	--[[ Upvalues[3]:
		[1]: var72_upvw (read and write)
		[2]: RunService_upvr (readonly)
		[3]: UserInputService_upvr (readonly)
	]]
	-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [5] 4. Error Block 396 start (CF ANALYSIS FAILED)
	if not arg4 then
		if arg2.KeyCode.Value == arg1.BindUp.Value and arg2.KeyCode.Value ~= 0 or arg1.BindUp.Value == 0 and arg2.UserInputType == Enum.UserInputType.MouseButton1 then
			if arg3 == "start" then
				if var72_upvw then
					var72_upvw:Disconnect()
				end
				arg1.VehicleSeat.BAV.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
				var72_upvw = RunService_upvr.Heartbeat:Connect(function() -- Line 673
					--[[ Upvalues[1]:
						[1]: arg1 (readonly)
					]]
					if arg1.Parent then
						arg1.VehicleSeat.BAV.AngularVelocity = arg1.VehicleSeat.CFrame.RightVector * 2
					end
				end)
				sendRequestToOtherClients(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
			else
				if var72_upvw then
					var72_upvw:Disconnect()
				end
				arg1.VehicleSeat.BAV.MaxTorque = Vector3.new(0, 0, 0)
				RunService_upvr.Heartbeat:Wait()
				arg1.VehicleSeat.RotVelocity = Vector3.new(0, 0, 0)
				sendRequestToOtherClients(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
				if not arg6 then
					checkAllKeysDown(arg1, arg4, arg5)
					-- KONSTANTWARNING: GOTO [491] #350
				end
			end
			-- KONSTANTWARNING: GOTO [491] #350
		end
	end
	if not arg4 and arg1.BindUp.Value == -1 and (arg2.KeyCode == Enum.KeyCode.W or arg2.KeyCode == Enum.KeyCode.Up) then
		if arg3 == "start" then
			if var72_upvw then
				var72_upvw:Disconnect()
			end
			arg1.VehicleSeat.BAV.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
			var72_upvw = RunService_upvr.Heartbeat:Connect(function() -- Line 702
				--[[ Upvalues[1]:
					[1]: arg1 (readonly)
				]]
				if arg1.Parent then
					arg1.VehicleSeat.BAV.AngularVelocity = arg1.VehicleSeat.CFrame.RightVector * 2
				end
			end)
			sendRequestToOtherClients(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
		else
			if var72_upvw then
				var72_upvw:Disconnect()
			end
			arg1.VehicleSeat.BAV.MaxTorque = Vector3.new(0, 0, 0)
			RunService_upvr.Heartbeat:Wait()
			arg1.VehicleSeat.RotVelocity = Vector3.new(0, 0, 0)
			sendRequestToOtherClients(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
			if not arg6 then
				checkAllKeysDown(arg1, arg4, arg5)
				-- KONSTANTWARNING: GOTO [491] #350
			end
		end
	elseif not arg4 and arg1.BindUp.Value == -1 and arg2.KeyCode == Enum.KeyCode.Thumbstick1 and 0.9 < arg2.Position.Y then
		if var72_upvw then
			var72_upvw:Disconnect()
		end
		arg1.VehicleSeat.BAV.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
		var72_upvw = RunService_upvr.Heartbeat:Connect(function() -- Line 730
			--[[ Upvalues[1]:
				[1]: arg1 (readonly)
			]]
			if arg1.Parent then
				arg1.VehicleSeat.BAV.AngularVelocity = arg1.VehicleSeat.CFrame.RightVector * 2
			end
		end)
		sendRequestToOtherClients(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
	elseif not arg4 and arg1.BindUp.Value == -1 and not UserInputService_upvr:IsKeyDown(Enum.KeyCode.W) and not UserInputService_upvr:IsKeyDown(Enum.KeyCode.Up) and not UserInputService_upvr:IsKeyDown(Enum.KeyCode.S) and not UserInputService_upvr:IsKeyDown(Enum.KeyCode.Down) and not UserInputService_upvr:IsKeyDown(Enum.KeyCode.A) and not UserInputService_upvr:IsKeyDown(Enum.KeyCode.Left) and not UserInputService_upvr:IsKeyDown(Enum.KeyCode.D) and not UserInputService_upvr:IsKeyDown(Enum.KeyCode.Right) and arg2.KeyCode == Enum.KeyCode.Thumbstick1 and arg2.Position.Y <= 0.9 and -0.9 <= arg2.Position.Y and arg2.Position.X <= 0.9 and -0.9 <= arg2.Position.X then
		if var72_upvw then
			var72_upvw:Disconnect()
		end
		arg1.VehicleSeat.BAV.MaxTorque = Vector3.new(0, 0, 0)
		RunService_upvr.Heartbeat:Wait()
		arg1.VehicleSeat.RotVelocity = Vector3.new(0, 0, 0)
		sendRequestToOtherClients(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
		if not arg6 then
			checkAllKeysDown(arg1, arg4, arg5)
			-- KONSTANTWARNING: GOTO [491] #350
		end
	elseif arg4 and arg2.KeyCode == "TabletForward" then
		if var72_upvw then
			var72_upvw:Disconnect()
		end
		arg1.VehicleSeat.BAV.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
		var72_upvw = RunService_upvr.Heartbeat:Connect(function() -- Line 757
			--[[ Upvalues[1]:
				[1]: arg1 (readonly)
			]]
			if arg1.Parent then
				arg1.VehicleSeat.BAV.AngularVelocity = arg1.VehicleSeat.CFrame.RightVector * 2
			end
		end)
		sendRequestToOtherClients(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
	elseif arg4 and arg2.KeyCode == "TabletForwardEnd" then
		if var72_upvw then
			var72_upvw:Disconnect()
		end
		arg1.VehicleSeat.BAV.MaxTorque = Vector3.new(0, 0, 0)
		RunService_upvr.Heartbeat:Wait()
		arg1.VehicleSeat.RotVelocity = Vector3.new(0, 0, 0)
		sendRequestToOtherClients(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
		if not arg6 then
			checkAllKeysDown(arg1, arg4, arg5)
		end
	end
	if not arg4 then
		if arg2.KeyCode.Value == arg1.BindDown.Value and arg2.KeyCode.Value ~= 0 or arg1.BindDown.Value == 0 and arg2.UserInputType == Enum.UserInputType.MouseButton1 then
			if arg3 == "start" then
				if var72_upvw then
					var72_upvw:Disconnect()
				end
				arg1.VehicleSeat.BAV.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
				var72_upvw = RunService_upvr.Heartbeat:Connect(function() -- Line 790
					--[[ Upvalues[1]:
						[1]: arg1 (readonly)
					]]
					if arg1.Parent then
						arg1.VehicleSeat.BAV.AngularVelocity = arg1.VehicleSeat.CFrame.RightVector * -2
					end
				end)
				sendRequestToOtherClients(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
			else
				if var72_upvw then
					var72_upvw:Disconnect()
				end
				arg1.VehicleSeat.BAV.MaxTorque = Vector3.new(0, 0, 0)
				RunService_upvr.Heartbeat:Wait()
				arg1.VehicleSeat.RotVelocity = Vector3.new(0, 0, 0)
				sendRequestToOtherClients(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
				if not arg6 then
					checkAllKeysDown(arg1, arg4, arg5)
					-- KONSTANTWARNING: GOTO [983] #699
				end
			end
			-- KONSTANTWARNING: GOTO [983] #699
		end
	end
	if not arg4 and arg1.BindDown.Value == -1 and (arg2.KeyCode == Enum.KeyCode.S or arg2.KeyCode == Enum.KeyCode.Down or arg2.KeyCode == Enum.KeyCode.ButtonR1) then
		if arg3 == "start" then
			if var72_upvw then
				var72_upvw:Disconnect()
			end
			arg1.VehicleSeat.BAV.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
			var72_upvw = RunService_upvr.Heartbeat:Connect(function() -- Line 819
				--[[ Upvalues[1]:
					[1]: arg1 (readonly)
				]]
				if arg1.Parent then
					arg1.VehicleSeat.BAV.AngularVelocity = arg1.VehicleSeat.CFrame.RightVector * -2
				end
			end)
			sendRequestToOtherClients(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
		else
			if var72_upvw then
				var72_upvw:Disconnect()
			end
			arg1.VehicleSeat.BAV.MaxTorque = Vector3.new(0, 0, 0)
			RunService_upvr.Heartbeat:Wait()
			arg1.VehicleSeat.RotVelocity = Vector3.new(0, 0, 0)
			sendRequestToOtherClients(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
			if not arg6 then
				checkAllKeysDown(arg1, arg4, arg5)
				-- KONSTANTWARNING: GOTO [983] #699
			end
		end
	elseif not arg4 and arg1.BindUp.Value == -1 and arg2.KeyCode == Enum.KeyCode.Thumbstick1 and arg2.Position.Y < -0.9 then
		if var72_upvw then
			var72_upvw:Disconnect()
		end
		arg1.VehicleSeat.BAV.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
		var72_upvw = RunService_upvr.Heartbeat:Connect(function() -- Line 847
			--[[ Upvalues[1]:
				[1]: arg1 (readonly)
			]]
			if arg1.Parent then
				arg1.VehicleSeat.BAV.AngularVelocity = arg1.VehicleSeat.CFrame.RightVector * -2
			end
		end)
		sendRequestToOtherClients(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
	elseif not arg4 and arg1.BindUp.Value == -1 and not UserInputService_upvr:IsKeyDown(Enum.KeyCode.W) and not UserInputService_upvr:IsKeyDown(Enum.KeyCode.Up) and not UserInputService_upvr:IsKeyDown(Enum.KeyCode.S) and not UserInputService_upvr:IsKeyDown(Enum.KeyCode.Down) and not UserInputService_upvr:IsKeyDown(Enum.KeyCode.A) and not UserInputService_upvr:IsKeyDown(Enum.KeyCode.Left) and not UserInputService_upvr:IsKeyDown(Enum.KeyCode.D) and not UserInputService_upvr:IsKeyDown(Enum.KeyCode.Right) and arg2.KeyCode == Enum.KeyCode.Thumbstick1 and arg2.Position.Y <= 0.9 and -0.9 <= arg2.Position.Y and arg2.Position.X <= 0.9 and -0.9 <= arg2.Position.X then
		if var72_upvw then
			var72_upvw:Disconnect()
		end
		arg1.VehicleSeat.BAV.MaxTorque = Vector3.new(0, 0, 0)
		RunService_upvr.Heartbeat:Wait()
		arg1.VehicleSeat.RotVelocity = Vector3.new(0, 0, 0)
		sendRequestToOtherClients(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
		if not arg6 then
			checkAllKeysDown(arg1, arg4, arg5)
			-- KONSTANTWARNING: GOTO [983] #699
		end
	elseif arg4 and arg2.KeyCode == "TabletBackward" then
		if var72_upvw then
			var72_upvw:Disconnect()
		end
		arg1.VehicleSeat.BAV.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
		var72_upvw = RunService_upvr.Heartbeat:Connect(function() -- Line 874
			--[[ Upvalues[1]:
				[1]: arg1 (readonly)
			]]
			if arg1.Parent then
				arg1.VehicleSeat.BAV.AngularVelocity = arg1.VehicleSeat.CFrame.RightVector * -2
			end
		end)
		sendRequestToOtherClients(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
	elseif arg4 and arg2.KeyCode == "TabletBackwardEnd" then
		if var72_upvw then
			var72_upvw:Disconnect()
		end
		arg1.VehicleSeat.BAV.MaxTorque = Vector3.new(0, 0, 0)
		RunService_upvr.Heartbeat:Wait()
		arg1.VehicleSeat.RotVelocity = Vector3.new(0, 0, 0)
		sendRequestToOtherClients(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
		if not arg6 then
			checkAllKeysDown(arg1, arg4, arg5)
		end
	end
	if not arg4 then
		if arg2.KeyCode.Value == arg1.BindLeft.Value and arg2.KeyCode.Value ~= 0 or arg1.BindLeft.Value == 0 and arg2.UserInputType == Enum.UserInputType.MouseButton1 then
			if arg3 == "start" then
				if var72_upvw then
					var72_upvw:Disconnect()
				end
				arg1.VehicleSeat.BAV.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
				var72_upvw = RunService_upvr.Heartbeat:Connect(function() -- Line 907
					--[[ Upvalues[1]:
						[1]: arg1 (readonly)
					]]
					if arg1.Parent then
						arg1.VehicleSeat.BAV.AngularVelocity = arg1.VehicleSeat.CFrame.UpVector * 2
					end
				end)
				sendRequestToOtherClients(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
			else
				if var72_upvw then
					var72_upvw:Disconnect()
				end
				arg1.VehicleSeat.BAV.MaxTorque = Vector3.new(0, 0, 0)
				RunService_upvr.Heartbeat:Wait()
				arg1.VehicleSeat.RotVelocity = Vector3.new(0, 0, 0)
				sendRequestToOtherClients(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
				if not arg6 then
					checkAllKeysDown(arg1, arg4, arg5)
					-- KONSTANTWARNING: GOTO [1469] #1045
				end
			end
			-- KONSTANTWARNING: GOTO [1469] #1045
		end
	end
	if not arg4 and arg1.BindLeft.Value == -1 and (arg2.KeyCode == Enum.KeyCode.A or arg2.KeyCode == Enum.KeyCode.Left) then
		if arg3 == "start" then
			if var72_upvw then
				var72_upvw:Disconnect()
			end
			arg1.VehicleSeat.BAV.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
			var72_upvw = RunService_upvr.Heartbeat:Connect(function() -- Line 936
				--[[ Upvalues[1]:
					[1]: arg1 (readonly)
				]]
				if arg1.Parent then
					arg1.VehicleSeat.BAV.AngularVelocity = arg1.VehicleSeat.CFrame.UpVector * 2
				end
			end)
			sendRequestToOtherClients(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
		else
			if var72_upvw then
				var72_upvw:Disconnect()
			end
			arg1.VehicleSeat.BAV.MaxTorque = Vector3.new(0, 0, 0)
			RunService_upvr.Heartbeat:Wait()
			arg1.VehicleSeat.RotVelocity = Vector3.new(0, 0, 0)
			sendRequestToOtherClients(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
			if not arg6 then
				checkAllKeysDown(arg1, arg4, arg5)
				-- KONSTANTWARNING: GOTO [1469] #1045
			end
		end
	elseif not arg4 and arg1.BindLeft.Value == -1 and arg2.KeyCode == Enum.KeyCode.Thumbstick1 and arg2.Position.X < -0.9 then
		if var72_upvw then
			var72_upvw:Disconnect()
		end
		arg1.VehicleSeat.BAV.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
		var72_upvw = RunService_upvr.Heartbeat:Connect(function() -- Line 964
			--[[ Upvalues[1]:
				[1]: arg1 (readonly)
			]]
			if arg1.Parent then
				arg1.VehicleSeat.BAV.AngularVelocity = arg1.VehicleSeat.CFrame.UpVector * 2
			end
		end)
		sendRequestToOtherClients(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
	elseif not arg4 and arg1.BindUp.Value == -1 and not UserInputService_upvr:IsKeyDown(Enum.KeyCode.W) and not UserInputService_upvr:IsKeyDown(Enum.KeyCode.Up) and not UserInputService_upvr:IsKeyDown(Enum.KeyCode.S) and not UserInputService_upvr:IsKeyDown(Enum.KeyCode.Down) and not UserInputService_upvr:IsKeyDown(Enum.KeyCode.A) and not UserInputService_upvr:IsKeyDown(Enum.KeyCode.Left) and not UserInputService_upvr:IsKeyDown(Enum.KeyCode.D) and not UserInputService_upvr:IsKeyDown(Enum.KeyCode.Right) and arg2.KeyCode == Enum.KeyCode.Thumbstick1 and arg2.Position.Y <= 0.9 and -0.9 <= arg2.Position.Y and arg2.Position.X <= 0.9 and -0.9 <= arg2.Position.X then
		if var72_upvw then
			var72_upvw:Disconnect()
		end
		arg1.VehicleSeat.BAV.MaxTorque = Vector3.new(0, 0, 0)
		RunService_upvr.Heartbeat:Wait()
		arg1.VehicleSeat.RotVelocity = Vector3.new(0, 0, 0)
		sendRequestToOtherClients(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
		if not arg6 then
			checkAllKeysDown(arg1, arg4, arg5)
			-- KONSTANTWARNING: GOTO [1469] #1045
		end
	elseif arg4 and arg2.KeyCode == "TabletLeft" then
		if var72_upvw then
			var72_upvw:Disconnect()
		end
		arg1.VehicleSeat.BAV.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
		var72_upvw = RunService_upvr.Heartbeat:Connect(function() -- Line 991
			--[[ Upvalues[1]:
				[1]: arg1 (readonly)
			]]
			if arg1.Parent then
				arg1.VehicleSeat.BAV.AngularVelocity = arg1.VehicleSeat.CFrame.UpVector * 2
			end
		end)
		sendRequestToOtherClients(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
	elseif arg4 and arg2.KeyCode == "TabletLeftEnd" then
		if var72_upvw then
			var72_upvw:Disconnect()
		end
		arg1.VehicleSeat.BAV.MaxTorque = Vector3.new(0, 0, 0)
		RunService_upvr.Heartbeat:Wait()
		arg1.VehicleSeat.RotVelocity = Vector3.new(0, 0, 0)
		sendRequestToOtherClients(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
		if not arg6 then
			checkAllKeysDown(arg1, arg4, arg5)
		end
	end
	if not arg4 then
		if arg2.KeyCode.Value == arg1.BindRight.Value and arg2.KeyCode.Value ~= 0 or arg1.BindRight.Value == 0 and arg2.UserInputType == Enum.UserInputType.MouseButton1 then
			if arg3 == "start" then
				if var72_upvw then
					var72_upvw:Disconnect()
				end
				arg1.VehicleSeat.BAV.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
				var72_upvw = RunService_upvr.Heartbeat:Connect(function() -- Line 1026
					--[[ Upvalues[1]:
						[1]: arg1 (readonly)
					]]
					if arg1.Parent then
						arg1.VehicleSeat.BAV.AngularVelocity = arg1.VehicleSeat.CFrame.UpVector * -2
					end
				end)
				sendRequestToOtherClients(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
			else
				if var72_upvw then
					var72_upvw:Disconnect()
				end
				arg1.VehicleSeat.BAV.MaxTorque = Vector3.new(0, 0, 0)
				RunService_upvr.Heartbeat:Wait()
				arg1.VehicleSeat.RotVelocity = Vector3.new(0, 0, 0)
				sendRequestToOtherClients(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
				if not arg6 then
					checkAllKeysDown(arg1, arg4, arg5)
					-- KONSTANTWARNING: GOTO [1955] #1391
				end
			end
			-- KONSTANTWARNING: GOTO [1955] #1391
		end
	end
	if not arg4 and arg1.BindRight.Value == -1 and (arg2.KeyCode == Enum.KeyCode.D or arg2.KeyCode == Enum.KeyCode.Right) then
		if arg3 == "start" then
			if var72_upvw then
				var72_upvw:Disconnect()
			end
			arg1.VehicleSeat.BAV.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
			var72_upvw = RunService_upvr.Heartbeat:Connect(function() -- Line 1055
				--[[ Upvalues[1]:
					[1]: arg1 (readonly)
				]]
				if arg1.Parent then
					arg1.VehicleSeat.BAV.AngularVelocity = arg1.VehicleSeat.CFrame.UpVector * -2
				end
			end)
			sendRequestToOtherClients(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
		else
			if var72_upvw then
				var72_upvw:Disconnect()
			end
			arg1.VehicleSeat.BAV.MaxTorque = Vector3.new(0, 0, 0)
			RunService_upvr.Heartbeat:Wait()
			arg1.VehicleSeat.RotVelocity = Vector3.new(0, 0, 0)
			sendRequestToOtherClients(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
			if not arg6 then
				checkAllKeysDown(arg1, arg4, arg5)
				-- KONSTANTWARNING: GOTO [1955] #1391
			end
		end
	elseif not arg4 and arg1.BindRight.Value == -1 and arg2.KeyCode == Enum.KeyCode.Thumbstick1 and 0.9 < arg2.Position.X then
		if var72_upvw then
			var72_upvw:Disconnect()
		end
		arg1.VehicleSeat.BAV.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
		var72_upvw = RunService_upvr.Heartbeat:Connect(function() -- Line 1083
			--[[ Upvalues[1]:
				[1]: arg1 (readonly)
			]]
			if arg1.Parent then
				arg1.VehicleSeat.BAV.AngularVelocity = arg1.VehicleSeat.CFrame.UpVector * -2
			end
		end)
		sendRequestToOtherClients(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
	elseif not arg4 and arg1.BindUp.Value == -1 and not UserInputService_upvr:IsKeyDown(Enum.KeyCode.W) and not UserInputService_upvr:IsKeyDown(Enum.KeyCode.Up) and not UserInputService_upvr:IsKeyDown(Enum.KeyCode.S) and not UserInputService_upvr:IsKeyDown(Enum.KeyCode.Down) and not UserInputService_upvr:IsKeyDown(Enum.KeyCode.A) and not UserInputService_upvr:IsKeyDown(Enum.KeyCode.Left) and not UserInputService_upvr:IsKeyDown(Enum.KeyCode.D) and not UserInputService_upvr:IsKeyDown(Enum.KeyCode.Right) and arg2.KeyCode == Enum.KeyCode.Thumbstick1 and arg2.Position.Y <= 0.9 and -0.9 <= arg2.Position.Y and arg2.Position.X <= 0.9 and -0.9 <= arg2.Position.X then
		if var72_upvw then
			var72_upvw:Disconnect()
		end
		arg1.VehicleSeat.BAV.MaxTorque = Vector3.new(0, 0, 0)
		RunService_upvr.Heartbeat:Wait()
		arg1.VehicleSeat.RotVelocity = Vector3.new(0, 0, 0)
		sendRequestToOtherClients(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
		if not arg6 then
			checkAllKeysDown(arg1, arg4, arg5)
			-- KONSTANTWARNING: GOTO [1955] #1391
		end
	elseif arg4 and arg2.KeyCode == "TabletRight" then
		if var72_upvw then
			var72_upvw:Disconnect()
		end
		arg1.VehicleSeat.BAV.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
		var72_upvw = RunService_upvr.Heartbeat:Connect(function() -- Line 1110
			--[[ Upvalues[1]:
				[1]: arg1 (readonly)
			]]
			if arg1.Parent then
				arg1.VehicleSeat.BAV.AngularVelocity = arg1.VehicleSeat.CFrame.UpVector * -2
			end
		end)
		sendRequestToOtherClients(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
	elseif arg4 and arg2.KeyCode == "TabletRightEnd" then
		if var72_upvw then
			var72_upvw:Disconnect()
		end
		arg1.VehicleSeat.BAV.MaxTorque = Vector3.new(0, 0, 0)
		RunService_upvr.Heartbeat:Wait()
		arg1.VehicleSeat.RotVelocity = Vector3.new(0, 0, 0)
		sendRequestToOtherClients(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
		if not arg6 then
			checkAllKeysDown(arg1, arg4, arg5)
		end
	end
	-- KONSTANTERROR: [5] 4. Error Block 396 end (CF ANALYSIS FAILED)
end
function checkIfPiston(arg1, arg2, arg3, arg4, arg5, arg6, arg7) -- Line 1138
	-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [5] 4. Error Block 115 start (CF ANALYSIS FAILED)
	if not arg4 then
		if arg2.KeyCode.Value == arg1.BindUp.Value and arg2.KeyCode.Value ~= 0 or arg1.BindUp.Value == 0 and arg2.UserInputType == Enum.UserInputType.MouseButton1 then
			if arg3 == "start" then
				arg1.PPart.ActivateRemote:FireServer("Push")
			elseif arg1.LastDirrection.Value == 1 then
				arg1.PPart.ActivateRemote:FireServer("Stop")
				if not arg6 then
					checkAllKeysDown(arg1, arg4, arg5)
					-- KONSTANTWARNING: GOTO [224] #138
				end
				-- KONSTANTWARNING: GOTO [224] #138
			end
			-- KONSTANTWARNING: GOTO [224] #138
		end
	end
	if not arg4 and arg1.BindUp.Value == -1 and (arg2.KeyCode == Enum.KeyCode.W or arg2.KeyCode == Enum.KeyCode.Up) then
		if arg3 == "start" then
			arg1.PPart.ActivateRemote:FireServer("Push")
		elseif arg1.LastDirrection.Value == 1 then
			arg1.PPart.ActivateRemote:FireServer("Stop")
			if not arg6 then
				checkAllKeysDown(arg1, arg4, arg5)
				-- KONSTANTWARNING: GOTO [224] #138
			end
			-- KONSTANTWARNING: GOTO [224] #138
		end
		-- KONSTANTWARNING: GOTO [224] #138
	end
	-- KONSTANTERROR: [5] 4. Error Block 115 end (CF ANALYSIS FAILED)
end
function checkIfBoatMotor(arg1, arg2, arg3, arg4, arg5, arg6, arg7) -- Line 1272
	--[[ Upvalues[1]:
		[1]: UserInputService_upvr (readonly)
	]]
	-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [5] 4. Error Block 2 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [5] 4. Error Block 2 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [9] 6. Error Block 3 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [9] 6. Error Block 3 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [13] 8. Error Block 316 start (CF ANALYSIS FAILED)
	if not arg4 then
		if arg2.KeyCode.Value == arg1.BindLeft.Value and arg2.KeyCode.Value ~= 0 or arg1.BindLeft.Value == 0 and arg2.UserInputType == Enum.UserInputType.MouseButton1 then
			if arg3 == "start" then
				arg1.Direction.Value = -1
				sendRequestToOtherClients(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
			elseif arg1.Direction.Value == -1 then
				arg1.Direction.Value = 0
				sendRequestToOtherClients(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
				if not arg6 then
					checkAllKeysDown(arg1, arg4, arg5)
					-- KONSTANTWARNING: GOTO [302] #208
				end
				-- KONSTANTWARNING: GOTO [302] #208
			end
			-- KONSTANTWARNING: GOTO [302] #208
		end
	end
	if not arg4 and arg1.BindLeft.Value == -1 then
		if arg2.KeyCode == Enum.KeyCode.A or arg2.KeyCode == Enum.KeyCode.Left then
			if arg3 == "start" then
				arg1.Direction.Value = -1
				sendRequestToOtherClients(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
			elseif arg1.Direction.Value == -1 then
				arg1.Direction.Value = 0
				sendRequestToOtherClients(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
				if not arg6 then
					checkAllKeysDown(arg1, arg4, arg5)
					-- KONSTANTWARNING: GOTO [302] #208
				end
				-- KONSTANTWARNING: GOTO [302] #208
			end
			-- KONSTANTWARNING: GOTO [302] #208
		end
	end
	if not arg4 and arg1.BindLeft.Value == -1 and arg2.KeyCode == Enum.KeyCode.Thumbstick1 and arg2.Position.X < -0.8 then
		arg1.Direction.Value = -1
		sendRequestToOtherClients(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
		-- KONSTANTWARNING: GOTO [302] #208
	end
	-- KONSTANTERROR: [13] 8. Error Block 316 end (CF ANALYSIS FAILED)
end
function updateForceLoop(arg1) -- Line 1683
	local tick_result1 = tick()
	arg1.ForceLoopTick.Value = tick_result1
	while arg1.ForceLoopTick.Value == tick_result1 and arg1.DirectionThrust.Value ~= 0 do
		local LookVector = arg1.PrimaryPart.CFrame.LookVector
		arg1.PrimaryPart.BV.Velocity = Vector3.new(LookVector.X, 0, LookVector.Z).Unit * arg1.MaxSpeed.Value * arg1.DirectionThrust.Value
		arg1.PrimaryPart.BV.MaxForce = Vector3.new(arg1.MaxThrustForce.Value, 0, arg1.MaxThrustForce.Value)
		local children = arg1.Motor.Bottom:GetChildren()
		for i_2 = 1, #children do
			if children[i_2].Name == "WeldBlade" then
				local var93 = children[i_2]
				var93.C1 = var93.Part1.CFrame * CFrame.Angles(0, 0, math.rad(-30 * arg1.DirectionThrust.Value)):toObjectSpace(var93.Part0.CFrame)
			end
		end
		wait()
	end
	arg1.PrimaryPart.BV.MaxForce = Vector3.new(0, 0, 0)
end
function checkIfWheel(arg1, arg2, arg3, arg4, arg5, arg6, arg7) -- Line 1709
	-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [8] 7. Error Block 200 start (CF ANALYSIS FAILED)
	if not arg1:FindFirstChild("SpinFactor") then
		local IntValue = Instance.new("IntValue")
		IntValue.Name = "SpinFactor"
		IntValue.Value = findSpinFactor(arg1.PrimaryPart, arg5)
		IntValue.Parent = arg1
	else
	end
	-- KONSTANTERROR: [8] 7. Error Block 200 end (CF ANALYSIS FAILED)
end
function checkIfCamera(arg1, arg2, arg3, arg4, arg5, arg6, arg7) -- Line 2036
	-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [5] 4. Error Block 2 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [5] 4. Error Block 2 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [9] 6. Error Block 38 start (CF ANALYSIS FAILED)
	if arg3 ~= "start" then
		if not arg7 then return end
	end
	if not arg4 then
		if arg2.KeyCode.Value == arg1.BindFire.Value and arg2.KeyCode.Value ~= 0 or arg1.BindFire.Value == 0 and arg2.UserInputType == Enum.UserInputType.MouseButton1 then
			toggleCamera(arg1)
			-- KONSTANTWARNING: GOTO [90] #57
		end
	end
	if not arg4 then
		if arg1.BindFire.Value == -1 and (arg2.KeyCode == Enum.KeyCode.F or arg2.KeyCode == Enum.KeyCode.ButtonL2) then
			toggleCamera(arg1)
			-- KONSTANTWARNING: GOTO [90] #57
		end
	end
	if arg4 and arg2.KeyCode == "TabletFire" then
		toggleCamera(arg1)
	elseif arg7 then
		toggleCamera(arg1)
	end
	-- KONSTANTERROR: [9] 6. Error Block 38 end (CF ANALYSIS FAILED)
end
local var95_upvw
local var96_upvw
local var97_upvw
local var98_upvw
local Custom_upvw = Enum.CameraType.Custom
local Character_upvw = LocalPlayer_upvr.Character
if Character_upvw then
	Character_upvw = LocalPlayer_upvr.Character:FindFirstChild("Humanoid")
end
function toggleCamera(arg1) -- Line 2077
	--[[ Upvalues[1]:
		[1]: var95_upvw (read and write)
	]]
	if var95_upvw then
		if var95_upvw == arg1 then
			deactivateCam()
			return
		end
		deactivateCam()
	end
	activateCam(arg1)
end
function activateCam(arg1) -- Line 2095
	--[[ Upvalues[9]:
		[1]: var95_upvw (read and write)
		[2]: LocalPlayer_upvr (readonly)
		[3]: Custom_upvw (read and write)
		[4]: CurrentCamera_upvr (readonly)
		[5]: Character_upvw (read and write)
		[6]: RunService_upvr (readonly)
		[7]: var96_upvw (read and write)
		[8]: var97_upvw (read and write)
		[9]: var98_upvw (read and write)
	]]
	var95_upvw = arg1
	local var101_upvr
	if arg1.Name ~= "CameraDome" then
		var101_upvr = false
	else
		var101_upvr = true
	end
	local PrimaryPart_upvr = arg1.PrimaryPart
	local clone_upvr = arg1.CameraScreenGui:Clone()
	clone_upvr.Parent = LocalPlayer_upvr.PlayerGui
	clone_upvr.Sound:Play()
	Custom_upvw = CurrentCamera_upvr.CameraType
	Character_upvw = CurrentCamera_upvr.CameraSubject
	if not var101_upvr then
		CurrentCamera_upvr.CameraType = Enum.CameraType.Scriptable
	else
		CurrentCamera_upvr.CameraSubject = PrimaryPart_upvr
	end
	RunService_upvr:BindToRenderStep("CameraBlock", 1, function() -- Line 2113
		--[[ Upvalues[4]:
			[1]: var101_upvr (readonly)
			[2]: CurrentCamera_upvr (copied, readonly)
			[3]: PrimaryPart_upvr (readonly)
			[4]: clone_upvr (readonly)
		]]
		if not var101_upvr then
			CurrentCamera_upvr.CFrame = PrimaryPart_upvr.CFrame * CFrame.new(0, 0, 1.1) * CFrame.Angles(0, math.pi, 0)
		end
		if os.time() % 2 == 1 then
			clone_upvr.Frame.Crosshairs.RecCircle.Visible = false
		else
			clone_upvr.Frame.Crosshairs.RecCircle.Visible = true
		end
	end)
	var96_upvw = PrimaryPart_upvr.AncestryChanged:Connect(function() -- Line 2124
		--[[ Upvalues[1]:
			[1]: PrimaryPart_upvr (readonly)
		]]
		if not PrimaryPart_upvr:IsDescendantOf(game) then
			deactivateCam()
		end
	end)
	var97_upvw = clone_upvr:WaitForChild("Frame"):WaitForChild("ExitLabel"):WaitForChild("ExitButton").MouseButton1Click:Connect(function() -- Line 2130
		--[[ Upvalues[1]:
			[1]: var97_upvw (copied, read and write)
		]]
		var97_upvw:Disconnect()
		var97_upvw = nil
		deactivateCam()
	end)
	var98_upvw = LocalPlayer_upvr.Character.Humanoid:GetPropertyChangedSignal("SeatPart"):Connect(function() -- Line 2136
		--[[ Upvalues[1]:
			[1]: LocalPlayer_upvr (copied, readonly)
		]]
		local SeatPart = LocalPlayer_upvr.Character.Humanoid.SeatPart
		if not SeatPart or SeatPart:IsA("VehicleSeat") then
			deactivateCam()
		end
	end)
end
function deactivateCam() -- Line 2144
	--[[ Upvalues[9]:
		[1]: var95_upvw (read and write)
		[2]: var96_upvw (read and write)
		[3]: var97_upvw (read and write)
		[4]: var98_upvw (read and write)
		[5]: RunService_upvr (readonly)
		[6]: CurrentCamera_upvr (readonly)
		[7]: Custom_upvw (read and write)
		[8]: Character_upvw (read and write)
		[9]: LocalPlayer_upvr (readonly)
	]]
	var95_upvw = nil
	if var96_upvw then
		var96_upvw:Disconnect()
		var96_upvw = nil
	end
	if var97_upvw then
		var97_upvw:Disconnect()
		var97_upvw = nil
	end
	if var98_upvw then
		var98_upvw:Disconnect()
		var98_upvw = nil
	end
	pcall(function() -- Line 2158
		--[[ Upvalues[1]:
			[1]: RunService_upvr (copied, readonly)
		]]
		RunService_upvr:UnbindFromRenderStep("CameraBlock")
	end)
	CurrentCamera_upvr.CameraType = Custom_upvw
	CurrentCamera_upvr.CameraSubject = Character_upvw
	local CameraScreenGui = LocalPlayer_upvr.PlayerGui:FindFirstChild("CameraScreenGui")
	if CameraScreenGui then
		CameraScreenGui:Destroy()
	end
end
if LocalPlayer_upvr.PlayerGui:FindFirstChild("CameraScreenGui") then
	deactivateCam()
end
function checkIfLeverOrSwitch(arg1, arg2, arg3, arg4, arg5, arg6, arg7) -- Line 2171
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	if arg1.Name == "Lever" then
		local Lever = arg1.Lever
		local Animator = Lever.AnimationController.Animator
		local any_GetPlayingAnimationTracks_result1_3 = Animator:GetPlayingAnimationTracks()
		if 0 < #any_GetPlayingAnimationTracks_result1_3 then
			for i_3 = 1, #any_GetPlayingAnimationTracks_result1_3 do
				any_GetPlayingAnimationTracks_result1_3[i_3]:Stop()
				local _
			end
		else
			i_3 = Lever.Down
			Animator:LoadAnimation(i_3):Play()
		end
		arg1.PrimaryPart.Sound:Play()
		if arg3 == "start" then
			arg1.On.Value = true
		else
			arg1.On.Value = false
		end
		sendRequestToOtherClients(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
		return true, false
	end
	if arg1.Name == "Switch" then
		local Switch = arg1.Switch
		local Animator_3 = Switch.AnimationController.Animator
		local any_GetPlayingAnimationTracks_result1 = Animator_3:GetPlayingAnimationTracks()
		if 0 < #any_GetPlayingAnimationTracks_result1 then
			for i_4 = 1, #any_GetPlayingAnimationTracks_result1 do
				any_GetPlayingAnimationTracks_result1[i_4]:Stop()
				local _
			end
			arg1.PrimaryPart.SoundOff:Play()
		else
			i_4 = Switch.Down
			Animator_3:LoadAnimation(i_4):Play()
			i_4 = arg1.PrimaryPart
			i_4.SoundOn:Play()
		end
		if arg3 == "start" then
			arg1.On.Value = true
		else
			arg1.On.Value = false
		end
		sendRequestToOtherClients(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
		return true, false
	end
	if arg1.Name == "SwitchBig" then
		local Switch_2 = arg1.Switch
		local Animator_2 = Switch_2.AnimationController.Animator
		local any_GetPlayingAnimationTracks_result1_2 = Animator_2:GetPlayingAnimationTracks()
		if 0 < #any_GetPlayingAnimationTracks_result1_2 then
			for i_5 = 1, #any_GetPlayingAnimationTracks_result1_2 do
				any_GetPlayingAnimationTracks_result1_2[i_5]:Stop()
				local _
			end
			arg1.PrimaryPart.SoundOff:Play()
		else
			i_5 = Switch_2.Down
			Animator_2:LoadAnimation(i_5):Play()
			i_5 = arg1.PrimaryPart
			i_5.SoundOn:Play()
		end
		if arg3 == "start" then
			arg1.On.Value = true
		else
			arg1.On.Value = false
		end
		sendRequestToOtherClients(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
		return true, false
	end
end
function checkIfButton(arg1, arg2, arg3, arg4, arg5, arg6, arg7) -- Line 2256
	if arg1.Name == "Button" then
		if arg3 == "start" then
			arg1.PrimaryPart.Sound:Play()
			goButtonDown(arg1.Button)
		else
			goButtonUp(arg1.Button)
		end
		sendRequestToOtherClients(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
		return true, false
	end
end
function goButtonDown(arg1) -- Line 2275
	arg1.CanCollide = false
	arg1:BreakJoints()
	arg1.Size = game.ReplicatedStorage.BuildingParts[arg1.Parent.Name].Button.Size - Vector3.new(0.20000, 0, 0)
	WeldTogether(arg1.Parent.PrimaryPart, arg1)
end
function goButtonUp(arg1) -- Line 2284
	arg1:BreakJoints()
	arg1.Size = game.ReplicatedStorage.BuildingParts[arg1.Parent.Name].Button.Size
	WeldTogether(arg1.Parent.PrimaryPart, arg1)
end
function checkIfDelay(arg1, arg2, arg3, arg4, arg5, arg6, arg7) -- Line 2291
	if arg1.Name == "Delay" and arg1.Glass.BrickColor ~= BrickColor.Red() then
		arg1.Glass.BrickColor = BrickColor.Red()
		arg1.Part.BrickColor = BrickColor.Red()
		delay(arg1.WaitDuration.Value, function() -- Line 2299
			--[[ Upvalues[7]:
				[1]: arg1 (readonly)
				[2]: arg6 (readonly)
				[3]: arg2 (readonly)
				[4]: arg3 (readonly)
				[5]: arg4 (readonly)
				[6]: arg5 (readonly)
				[7]: arg7 (readonly)
			]]
			if not arg1.Parent then
			else
				arg1.Glass.Color = game.ReplicatedStorage.BuildingParts[arg1.Name].Glass.Color
				arg1.Part.Color = game.ReplicatedStorage.BuildingParts[arg1.Name].Part.Color
				if not arg6 then
					runBeams(arg1:GetChildren(), arg2, arg3, arg4, arg5, arg6, arg7)
				end
			end
		end)
		sendRequestToOtherClients(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
		return true, false
	end
end
local const_number_upvw = 0
local tbl_8_upvr = {}
function checkIfNote(arg1, arg2, arg3, arg4, arg5, arg6, arg7) -- Line 2323
	--[[ Upvalues[4]:
		[1]: LocalPlayer_upvr (readonly)
		[2]: CurrentCamera_upvr (readonly)
		[3]: const_number_upvw (read and write)
		[4]: tbl_8_upvr (readonly)
	]]
	-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [388] 271. Error Block 76 start (CF ANALYSIS FAILED)
	local Color_upvr = arg1.Base.Color
	if Color_upvr ~= Color3.fromRGB(196, 40, 28) then
		local children_upvr = arg1:GetChildren()
		for i_6 = 1, #children_upvr do
			local var141 = children_upvr[i_6]
			if var141:IsA("BasePart") then
				var141.BrickColor = BrickColor.Red()
			end
		end
		delay(0.3, function() -- Line 2439
			--[[ Upvalues[2]:
				[1]: children_upvr (readonly)
				[2]: Color_upvr (readonly)
			]]
			for i_7 = 1, #children_upvr do
				local var144 = children_upvr[i_7]
				if var144:IsA("BasePart") then
					var144.Color = Color_upvr
				end
			end
		end)
	end
	children_upvr = true
	do
		return children_upvr, false
	end
	-- KONSTANTERROR: [388] 271. Error Block 76 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [429] 303. Error Block 61 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [429] 303. Error Block 61 end (CF ANALYSIS FAILED)
end
function checkIfBasicActivatedServerSidedItem(arg1, arg2, arg3, arg4, arg5, arg6, arg7) -- Line 2455
	-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [6] 6. Error Block 2 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [6] 6. Error Block 2 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [9] 8. Error Block 3 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [9] 8. Error Block 3 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [109] 68. Error Block 26 start (CF ANALYSIS FAILED)
	do
		return true, false
	end
	-- KONSTANTERROR: [109] 68. Error Block 26 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [112] 71. Error Block 27 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [112] 71. Error Block 27 end (CF ANALYSIS FAILED)
end
function checkAllKeysDown(arg1, arg2, arg3) -- Line 2489
	--[[ Upvalues[1]:
		[1]: UserInputService_upvr (readonly)
	]]
	for _, v in pairs(UserInputService_upvr:GetKeysPressed()) do
		trigger(arg1, v, "start", arg2, arg3, false, false)
	end
end
function findSpinFactor(arg1, arg2) -- Line 2497
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local Y = arg2.Orientation.Y
	local var151
	if Y < var151 then
		var151 = 360
	end
	var151 = arg1.Orientation.Y
	if var151 < 0 then
		var151 = 360 + var151
	end
	local var152 = ((var151) - (var151 + Y)) % 360
	if 45 < var152 and var152 < 225 then
		return -1
	end
	return 1
end
function WeldTogether(arg1, arg2) -- Line 2518
	if arg1:FindFirstChild("NoWelds") or arg2:FindFirstChild("NoWelds") then return end
	local Weld = Instance.new("Weld")
	Weld.Part0 = arg1
	Weld.Part1 = arg2
	Weld.C0 = CFrame.new()
	Weld.C1 = arg2.CFrame:toObjectSpace(arg1.CFrame)
	Weld.Parent = arg1
	return Weld
end
UserInputService_upvr.InputBegan:Connect(function(arg1, arg2) -- Line 2533
	active(arg1, arg2, "start")
end)
UserInputService_upvr.InputEnded:Connect(function(arg1, arg2) -- Line 2536
	active(arg1, arg2, "stop")
end)
UserInputService_upvr.InputChanged:Connect(gamepadActive)
local ControlFrame_upvr = LocalPlayer_upvr:WaitForChild("PlayerGui"):WaitForChild("CarControlsInfoAndMobileButtons"):WaitForChild("ControlFrame")
ControlFrame_upvr:WaitForChild("PowerFrame"):WaitForChild("Forward").MouseButton1Down:Connect(function() -- Line 2543
	--[[ Upvalues[1]:
		[1]: ControlFrame_upvr (readonly)
	]]
	local tbl_5 = {
		KeyCode = "TabletForward";
	}
	active(tbl_5, nil, "start")
	ControlFrame_upvr.PowerFrame.Forward.MouseButton1Up:Wait()
	tbl_5.KeyCode = "TabletForwardEnd"
	active(tbl_5, nil, "start")
end)
ControlFrame_upvr.PowerFrame:WaitForChild("Backward").MouseButton1Down:Connect(function() -- Line 2551
	--[[ Upvalues[1]:
		[1]: ControlFrame_upvr (readonly)
	]]
	local tbl_2 = {
		KeyCode = "TabletBackward";
	}
	active(tbl_2, nil, "start")
	ControlFrame_upvr.PowerFrame.Backward.MouseButton1Up:Wait()
	tbl_2.KeyCode = "TabletBackwardEnd"
	active(tbl_2, nil, "start")
end)
ControlFrame_upvr:WaitForChild("TurningFrame"):WaitForChild("Left").MouseButton1Down:Connect(function() -- Line 2559
	--[[ Upvalues[1]:
		[1]: ControlFrame_upvr (readonly)
	]]
	local tbl = {
		KeyCode = "TabletLeft";
	}
	active(tbl, nil, "start")
	ControlFrame_upvr.TurningFrame.Left.MouseButton1Up:Wait()
	tbl.KeyCode = "TabletLeftEnd"
	active(tbl, nil, "start")
end)
ControlFrame_upvr.TurningFrame:WaitForChild("Right").MouseButton1Down:Connect(function() -- Line 2567
	--[[ Upvalues[1]:
		[1]: ControlFrame_upvr (readonly)
	]]
	local tbl_4 = {
		KeyCode = "TabletRight";
	}
	active(tbl_4, nil, "start")
	ControlFrame_upvr.TurningFrame.Right.MouseButton1Up:Wait()
	tbl_4.KeyCode = "TabletRightEnd"
	active(tbl_4, nil, "start")
end)
ControlFrame_upvr.TurningFrame:WaitForChild("Exit").MouseButton1Down:Connect(function() -- Line 2575
	--[[ Upvalues[1]:
		[1]: LocalPlayer_upvr (readonly)
	]]
	LocalPlayer_upvr.Character.JumpRE:FireServer()
end)
ControlFrame_upvr.TurningFrame:WaitForChild("Fire").MouseButton1Down:Connect(function() -- Line 2580
	active({
		KeyCode = "TabletFire";
	}, nil, "start")
end)
script:WaitForChild("ControlBlockRequestRE").OnClientEvent:Connect(requestedControl)