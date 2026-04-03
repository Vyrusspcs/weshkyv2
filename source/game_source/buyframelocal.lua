-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-04 14:11:11
-- Luau version 6, Types version 3
-- Time taken: 0.009658 seconds

local MarketplaceService_upvr = game:GetService("MarketplaceService")
local LocalPlayer_upvr = game.Players.LocalPlayer
local var3_upvw = false
local Parent_upvr = script.Parent
local QuantityFrame_upvr = Parent_upvr.QuantityFrame
local Parent_upvr_2 = Parent_upvr.Parent.Parent
function active() -- Line 13
	--[[ Upvalues[3]:
		[1]: var3_upvw (read and write)
		[2]: Parent_upvr_2 (readonly)
		[3]: Parent_upvr (readonly)
	]]
	if var3_upvw or Parent_upvr_2.FocusImage.ImageColor3 == Color3.fromRGB(0, 0, 0) or Parent_upvr.Roundify1.TextLabel.Text == "Owned" then
	else
		var3_upvw = true
		spawn(coolDown)
		ShopBuy(Parent_upvr_2.FocusImage.Title.Text)
	end
end
function coolDown() -- Line 22
	--[[ Upvalues[1]:
		[1]: var3_upvw (read and write)
	]]
	wait(1)
	var3_upvw = false
end
local UserOwnsGamePassAsync_upvr = MarketplaceService_upvr.UserOwnsGamePassAsync
function playerOwns(arg1) -- Line 27
	--[[ Upvalues[3]:
		[1]: UserOwnsGamePassAsync_upvr (readonly)
		[2]: MarketplaceService_upvr (readonly)
		[3]: LocalPlayer_upvr (readonly)
	]]
	local pcall_result1, pcall_result2 = pcall(UserOwnsGamePassAsync_upvr, MarketplaceService_upvr, LocalPlayer_upvr.UserId, arg1)
	if not pcall_result1 then
		return false
	end
	return pcall_result2
end
function ShopBuy(arg1) -- Line 36
	--[[ Upvalues[3]:
		[1]: QuantityFrame_upvr (readonly)
		[2]: Parent_upvr_2 (readonly)
		[3]: LocalPlayer_upvr (readonly)
	]]
	-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [2] 2. Error Block 2 start (CF ANALYSIS FAILED)
	workspace.PromptRobuxEvent:InvokeServer(55535084, "Product")
	do
		return
	end
	-- KONSTANTERROR: [2] 2. Error Block 2 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [12] 9. Error Block 3 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [12] 9. Error Block 3 end (CF ANALYSIS FAILED)
end
function checkForRedPrice() -- Line 120
	--[[ Upvalues[3]:
		[1]: Parent_upvr_2 (readonly)
		[2]: LocalPlayer_upvr (readonly)
		[3]: Parent_upvr (readonly)
	]]
	local Text = Parent_upvr_2.Cost.Text
	if LocalPlayer_upvr.Data.Gold.Value < tonumber(string.sub(Text, 1, string.find(Text, ' ') - 1)) then
		Parent_upvr_2.Cost.TextColor3 = Color3.fromRGB(255, 75, 75)
		Parent_upvr.Roundify1.ImageColor3 = Color3.fromRGB(110, 108, 140)
		Parent_upvr.Roundify2.ImageColor3 = Color3.fromRGB(51, 50, 65)
	else
		Parent_upvr_2.Cost.TextColor3 = Color3.fromRGB(255, 217, 0)
		Parent_upvr.Roundify1.ImageColor3 = Color3.fromRGB(122, 227, 65)
		Parent_upvr.Roundify2.ImageColor3 = Color3.fromRGB(43, 94, 19)
	end
end
Parent_upvr.MouseButton1Click:connect(active)
Parent_upvr.MouseButton1Down:Connect(function() -- Line 136
	--[[ Upvalues[1]:
		[1]: Parent_upvr (readonly)
	]]
	Parent_upvr.Roundify1.Position = UDim2.new(0, -3, 0, -3)
end)
Parent_upvr.MouseButton1Up:Connect(function() -- Line 139
	--[[ Upvalues[1]:
		[1]: Parent_upvr (readonly)
	]]
	Parent_upvr.Roundify1.Position = UDim2.new(0, 0, 0, 0)
end)
local ToggleGiftButton_upvr = Parent_upvr.Parent:WaitForChild("ToggleGiftButton")
ToggleGiftButton_upvr.MouseButton1Click:connect(function() -- Line 143
	--[[ Upvalues[2]:
		[1]: Parent_upvr_2 (readonly)
		[2]: ToggleGiftButton_upvr (readonly)
	]]
	if Parent_upvr_2.FocusImage.ImageColor3 == Color3.fromRGB(0, 0, 0) then
	else
		ToggleGiftButton_upvr.Parent.Visible = false
		local GiftFrame = ToggleGiftButton_upvr.Parent.Parent.GiftFrame
		GiftFrame.ToName.Text = ""
		GiftFrame.ToName.Size = UDim2.new(0.8, 0, 0.065, 0)
		GiftFrame.ToPlayerImage.Visible = false
		GiftFrame.ToPlayerImage.Image = ""
		GiftFrame.Parent.TextBox.Text = "Purchase 2 of these products! 1 for yourself and 1 for a friend."
		GiftFrame.Parent.Cost.Text = tostring(math.ceil(tonumber(string.match(GiftFrame.Parent.Cost.Text, "%d+")) * 1.5)).." robux"
		GiftFrame.Visible = true
	end
end)
ToggleGiftButton_upvr.MouseButton1Down:Connect(function() -- Line 158
	--[[ Upvalues[1]:
		[1]: ToggleGiftButton_upvr (readonly)
	]]
	ToggleGiftButton_upvr.Roundify1.Position = UDim2.new(0, -3, 0, -3)
end)
ToggleGiftButton_upvr.MouseButton1Up:Connect(function() -- Line 161
	--[[ Upvalues[1]:
		[1]: ToggleGiftButton_upvr (readonly)
	]]
	ToggleGiftButton_upvr.Roundify1.Position = UDim2.new(0, 0, 0, 0)
end)
local var19_upvw = false
QuantityFrame_upvr.OpenTab.MouseButton1Click:Connect(function() -- Line 166
	--[[ Upvalues[2]:
		[1]: var19_upvw (read and write)
		[2]: QuantityFrame_upvr (readonly)
	]]
	if var19_upvw then
		QuantityFrame_upvr:TweenPosition(UDim2.new(0.45, 0, 0.2, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Linear, 0.2, true)
	else
		QuantityFrame_upvr:TweenPosition(UDim2.new(1, 0, 0.2, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Linear, 0.2, true)
	end
	var19_upvw = not var19_upvw
end)
local Parent_upvr_3 = Parent_upvr_2.Parent
function getSelectedScrollIcon() -- Line 175
	--[[ Upvalues[2]:
		[1]: Parent_upvr_2 (readonly)
		[2]: Parent_upvr_3 (readonly)
	]]
	return Parent_upvr_3.ScrollingFrameChests:FindFirstChild(Parent_upvr_2.FocusImage.Title.Text, true)
end
function setAmountText(arg1, arg2) -- Line 181
	--[[ Upvalues[2]:
		[1]: QuantityFrame_upvr (readonly)
		[2]: Parent_upvr_2 (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local tonumber_result1 = tonumber(arg1)
	if not tonumber_result1 or tostring(tonumber_result1) == "nan" then
	end
	local floored = math.floor(math.max(math.min(1 + (arg2 or 0), 1000), 1))
	QuantityFrame_upvr.Amount.Text = tostring(floored)
	local getSelectedScrollIcon_result1 = getSelectedScrollIcon()
	if not getSelectedScrollIcon_result1:FindFirstChild("Quantity") or not getSelectedScrollIcon_result1.Quantity.Text then
	end
	Parent_upvr_2.Cost.Text = tostring(tonumber(getSelectedScrollIcon_result1.TextLabel.Text) * floored).." Gold"
	Parent_upvr_2.FocusImage.Quantity.Text = 'x'..tostring(tonumber(string.sub("x1", 2)) * floored)
	Parent_upvr_2.TextBox.Text = getSelectedScrollIcon_result1.Desc.Value
	Parent_upvr_2.TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
	checkForRedPrice()
end
QuantityFrame_upvr.Amount.FocusLost:Connect(function() -- Line 206
	--[[ Upvalues[1]:
		[1]: QuantityFrame_upvr (readonly)
	]]
	setAmountText(QuantityFrame_upvr.Amount.Text)
end)
QuantityFrame_upvr.ArrowNext.MouseButton1Click:Connect(function() -- Line 211
	--[[ Upvalues[1]:
		[1]: QuantityFrame_upvr (readonly)
	]]
	setAmountText(QuantityFrame_upvr.Amount.Text, 1)
end)
QuantityFrame_upvr.ArrowBack.MouseButton1Click:Connect(function() -- Line 216
	--[[ Upvalues[1]:
		[1]: QuantityFrame_upvr (readonly)
	]]
	setAmountText(QuantityFrame_upvr.Amount.Text, -1)
end)
