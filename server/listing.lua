local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local MAIN_COLOR = Color3.fromRGB(176, 27, 16)
local BACKGROUND_COLOR = Color3.fromRGB(21, 22, 23)
local TEXT_COLOR = Color3.fromRGB(255, 255, 255)

do
	local MainPart = game:GetService("CoreGui"):FindFirstChild("MainPart")
	if MainPart then MainPart:Destroy() end
end

local MainPart = Instance.new("ScreenGui", CoreGui)
MainPart.Name = "MainPart"

local Window = Instance.new("ImageLabel", MainPart)
Window.Name = "Window"
Window.Position = UDim2.new(0, 1112, 0, 40)
Window.Size = UDim2.new(0, 300, 0, 550)
Window.Image = "rbxassetid://2851926732"
Window.ImageColor3 = Color3.fromRGB(16, 16, 16)
Window.ImageTransparency = 0.04
Window.ScaleType = Enum.ScaleType.Slice
Window.SliceCenter = Rect.new(12, 12, 12, 12)
Window.Active = true
Window.Draggable = true
Window.BackgroundTransparency = 1
Window.ZIndex = 11

local Bar = Instance.new("Frame", Window)
Bar.Name = "Bar"
Bar.Size = UDim2.new(1, 0, 0, 15)
Bar.Position = UDim2.new(0, 0, 0, 5)
Bar.BackgroundColor3 = Color3.fromRGB(176, 27, 16)
Bar.BorderSizePixel = 0
Bar.ZIndex = 11

local Toggle = Instance.new("ImageButton", Bar)
Toggle.Name = "Toggle"
Toggle.Size = UDim2.new(0, 20, 0, 20)
Toggle.Position = UDim2.new(0, 5, 0, -2)
Toggle.Image = "https://www.roblox.com/Thumbs/Asset.ashx?width=420&height=420&assetId=4731371541"
Toggle.BackgroundTransparency = 1
Toggle.ZIndex = 12
Toggle.Rotation = 90

local Base = Instance.new("ImageLabel", Bar)
Base.Name = "Base"
Base.Size = UDim2.new(1, 0, 0, 10)
Base.Position = UDim2.new(0, 0, 0.8, 0)
Base.Image = "rbxassetid://2851926732"
Base.ImageColor3 = Color3.fromRGB(176, 27, 16)
Base.ScaleType = Enum.ScaleType.Slice
Base.SliceCenter = Rect.new(12, 12, 12, 12)
Base.BackgroundTransparency = 1
Base.ZIndex = 11

local Top = Instance.new("ImageLabel", Bar)
Top.Name = "Top"
Top.Size = UDim2.new(1, 0, 0, 10)
Top.Position = UDim2.new(0, 0, 0, -5)
Top.Image = "rbxassetid://2851926732"
Top.ImageColor3 = Color3.fromRGB(176, 27, 16)
Top.ScaleType = Enum.ScaleType.Slice
Top.SliceCenter = Rect.new(12, 12, 12, 12)
Top.BackgroundTransparency = 1
Top.ZIndex = 11

local Title = Instance.new("TextLabel", Window)
Title.Name = "Title"
Title.Position = UDim2.new(0, 30, 0, 3)
Title.Size = UDim2.new(0, 200, 0, 20)
Title.BackgroundTransparency = 1
Title.Text = "Block Listing"
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = TEXT_COLOR
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 11

local Tabs = Instance.new("Frame", Window)
Tabs.Name = "Tabs"
Tabs.Position = UDim2.new(0, 0, 0, 28)
Tabs.Size = UDim2.new(1, 0, 1, -30)
Tabs.BackgroundTransparency = 1
Tabs.ZIndex = 11

local ScrollingFrame = Instance.new("ScrollingFrame", Tabs)
ScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.BorderColor3 = MAIN_COLOR
ScrollingFrame.ScrollBarThickness = 4
ScrollingFrame.Active = true

local UIListLayout = Instance.new("UIListLayout", ScrollingFrame)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

local ClearButton = Instance.new("TextButton", Bar)
ClearButton.Name = "Clear"
ClearButton.Size = UDim2.new(0, 60, 0, 20)
ClearButton.Position = UDim2.new(1, -64, 0, -1)
ClearButton.BackgroundColor3 = Color3.fromRGB(122, 37, 37)
ClearButton.Font = Enum.Font.GothamBold
ClearButton.Text = "Clear"
ClearButton.TextColor3 = TEXT_COLOR
ClearButton.TextSize = 13
ClearButton.ZIndex = 99

local UICorner = Instance.new("UICorner", ClearButton)
UICorner.CornerRadius = UDim.new(0, 3)

local ExampleBlock = Instance.new("Frame")
ExampleBlock.Name = "Block"
ExampleBlock.Size = UDim2.new(1, 0, 0, 40)
ExampleBlock.BackgroundTransparency = 1

local BlockBG = Instance.new("ImageLabel", ExampleBlock)
BlockBG.Name = "TextButton"
BlockBG.Size = UDim2.new(1, -15, 1, -5)
BlockBG.Position = UDim2.new(0, 5, 0, 5)
BlockBG.Image = "rbxassetid://2851926732"
BlockBG.ImageColor3 = BACKGROUND_COLOR
BlockBG.ImageTransparency = 0.3
BlockBG.ScaleType = Enum.ScaleType.Slice
BlockBG.SliceCenter = Rect.new(12, 12, 12, 12)
BlockBG.BackgroundTransparency = 1
BlockBG.ZIndex = 11

local Icon = Instance.new("ImageLabel", BlockBG)
Icon.Size = UDim2.new(0, 40, 1, 0)
Icon.Image = "rbxassetid://845567732"
Icon.BackgroundTransparency = 1
Icon.ZIndex = 12

local BlockText = Instance.new("TextLabel", BlockBG)
BlockText.Size = UDim2.new(1, -50, 1, 0)
BlockText.Position = UDim2.new(0, 50, 0, 0)
BlockText.Text = "Needed: 1\nMissing: 0"
BlockText.Font = Enum.Font.GothamBold
BlockText.TextColor3 = TEXT_COLOR
BlockText.TextSize = 14
BlockText.TextXAlignment = Enum.TextXAlignment.Left
BlockText.BackgroundTransparency = 1
BlockText.RichText = true
BlockText.ZIndex = 13

local images = loadstring(game:HttpGet("https://raw.githubusercontent.com/suntisalts/WeshkyAutoBuildV2/refs/heads/main/Server/blocklist.lua"))()

local function Resize(part, newProps, speed)
    local tween = TweenInfo.new(speed or 0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    TweenService:Create(part, tween, newProps):Play()
end

UserInputService.InputBegan:Connect(function(input, gpe)
    if input.KeyCode == Enum.KeyCode.RightShift then
        Window.Visible = not Window.Visible
    end
end)

do
    local open_close = Toggle
    local open, canopen = true, true
    local oldData = {}
    local oldY = Window.AbsoluteSize.Y

    open_close.MouseButton1Click:Connect(function()
        if not canopen then return end
        canopen = false

        if open then
            for _, v in ipairs(ScrollingFrame:GetChildren()) do
                if not v:IsA("UIListLayout") then
                    oldData[v] = v.Visible
                    v.Visible = false
                end
            end
            oldY = Window.AbsoluteSize.Y
        else
            for v, vis in pairs(oldData) do
                v.Visible = vis
            end
        end

        Resize(open_close, {Rotation = open and 0 or 90}, 0.1)
        Resize(Window, {Size = UDim2.new(0, 240, 0, open and 26 or oldY)}, 0.1)
        Base.Transparency = open and 0 or 1

        task.wait(0.1)
        open = not open
        canopen = true
    end)
end

local Functions = {}

local COLORS = {
    RED = Color3.fromRGB(100, 30, 30),
    YELLOW = Color3.fromRGB(120, 90, 20),
    GREEN = Color3.fromRGB(30, 90, 30),
    NEUTRAL = Color3.fromRGB(80, 80, 80),
}

function Functions:Clear()
    for _, child in pairs(ScrollingFrame:GetChildren()) do
        if not child:IsA("UIListLayout") then
            child:Destroy()
        end
    end
end

function Functions:Add(name, needed, missing)
    local block = ExampleBlock:Clone()
    block.Parent = ScrollingFrame
    local btn = block.TextButton

    btn.ImageLabel.Image = images[name] or ""
    btn.TextLabel.Text = "Needed:  " .. (needed or 0) .. "\nMissing: " .. (missing or 0)

    local color = COLORS.GREEN
    if needed and needed > 0 then
        local perc = (missing or 0) / needed
        if perc == 0 then color = COLORS.GREEN
        elseif perc <= 0.5 then color = COLORS.YELLOW
        else color = COLORS.RED end
    end

    btn.ImageColor3 = color
    btn.ImageTransparency = 0.3

    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, #ScrollingFrame:GetChildren() * 40 - 35)
end

ClearButton.MouseButton1Click:Connect(function()
    Functions:Clear()
end)

return Functions
