do
	local DiscordUi = game:GetService("CoreGui"):FindFirstChild("DiscordUi")
	if DiscordUi then DiscordUi:Destroy() end
end

local DiscordUi = Instance.new("ScreenGui")
local Background = Instance.new("Frame")
local Frame = Instance.new("Frame")
local Frame_2 = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Frame_3 = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local UICorner_2 = Instance.new("UICorner")
local Holder = Instance.new("Frame")
local Exit = Instance.new("TextButton")
local UICorner_3 = Instance.new("UICorner")
local Discord = Instance.new("TextButton")
local UICorner_4 = Instance.new("UICorner")

DiscordUi.Parent = game.CoreGui
DiscordUi.ZIndexBehavior = Enum.ZIndexBehavior.Global
DiscordUi.DisplayOrder = 9

Background.Name = "Background"
Background.Parent = DiscordUi
Background.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
Background.BackgroundTransparency = 0.400
Background.Position = UDim2.new(-0.506535947, 0, -0.446384043, 0)
Background.Size = UDim2.new(2, 0, 2, 0)

Frame.Parent = DiscordUi
Frame.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.5, -130, 0.5, -40)
Frame.Size = UDim2.new(0, 260, 0, 75)

Frame_2.Parent = Frame
Frame_2.BackgroundColor3 = Color3.fromRGB(176, 27, 16)
Frame_2.Position = UDim2.new(0, 0, -0.129999995, 0)
Frame_2.Size = UDim2.new(1, 0, 0, 24)

UICorner.CornerRadius = UDim.new(0, 6)
UICorner.Parent = Frame_2

Frame_3.Parent = Frame_2
Frame_3.BackgroundColor3 = Color3.fromRGB(176, 27, 16)
Frame_3.BorderSizePixel = 0
Frame_3.Position = UDim2.new(0, 0, 0.5, 0)
Frame_3.Size = UDim2.new(1, 0, 0.5, 0)

TextLabel.Parent = Frame_2
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.Size = UDim2.new(1, 0, 1, 0)
TextLabel.Font = Enum.Font.GothamBold
TextLabel.Text = "Need files? Join the server!"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextSize = 14.000

UICorner_2.CornerRadius = UDim.new(0, 6)
UICorner_2.Parent = Frame

Holder.Name = "Holder"
Holder.Parent = Frame
Holder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Holder.BackgroundTransparency = 1.000
Holder.Position = UDim2.new(0, 0, 0, 12)
Holder.Size = UDim2.new(1, 0, 1, -12)

Exit.Name = "Exit"
Exit.Parent = Holder
Exit.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
Exit.Position = UDim2.new(0, 3, 1, -28)
Exit.Size = UDim2.new(1, -6, 0, 24)
Exit.Font = Enum.Font.GothamBold
Exit.Text = "Continue"
Exit.TextColor3 = Color3.fromRGB(255, 255, 255)
Exit.TextSize = 14.000

UICorner_3.CornerRadius = UDim.new(0, 3)
UICorner_3.Parent = Exit

Discord.Name = "Discord"
Discord.Parent = Holder
Discord.BackgroundColor3 = Color3.fromRGB(23, 172, 13)
Discord.Position = UDim2.new(0, 3, 0.109999999, 0)
Discord.Size = UDim2.new(1, -6, 0, 24)
Discord.Font = Enum.Font.GothamBold
Discord.Text = "Discord\b"
Discord.TextColor3 = Color3.fromRGB(255, 255, 255)
Discord.TextSize = 14.000

UICorner_4.CornerRadius = UDim.new(0, 3)
UICorner_4.Parent = Discord

local discord = "https://discord.gg/WHSTrRvG"

local function Reset()
    task.wait(4)
    Discord.Text = "Discord\b"
end

Discord.MouseButton1Click:Connect(function()
    Discord.Text = "Invite Link Copied"
    setclipboard(discord)
    Reset()
    makefolder("Test123")
end)

Exit.MouseButton1Click:Connect(function()
    DiscordUi:Destroy()
end)
