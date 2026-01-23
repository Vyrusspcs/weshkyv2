local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local MAIN_COLOR = Color3.fromRGB(41, 74, 122)
local BACKGROUND_COLOR = Color3.fromRGB(21, 22, 23)
local TEXT_COLOR = Color3.fromRGB(255, 255, 255)

do
    local MainPart = game:GetService("CoreGui"):FindFirstChild("BlockListing")
    if MainPart then MainPart:Destroy() end
end

local tzu = Enum.Font.GothamBold
local tzu2 = Enum.Font.GothamBold
local tzu3 = Enum.Font.GothamBold

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "BlockListing"

local Main = Instance.new("ImageLabel")
Main.Name = "Main"
Main.Parent = ScreenGui
Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Main.BackgroundTransparency = 1.000
Main.Position = UDim2.new(0, 1112, 0, 40)
Main.Size = UDim2.new(0, 300, 0, 22)
Main.ZIndex = 4
Main.Image = "rbxassetid://3570695787"
Main.ImageColor3 = Color3.fromRGB(29, 73, 118)
Main.ScaleType = Enum.ScaleType.Slice
Main.SliceCenter = Rect.new(100, 100, 100, 100)
Main.SliceScale = 0.050
Main.Active = true

local Frame = Instance.new("Frame")
Frame.Parent = Main
Frame.BackgroundColor3 = Color3.fromRGB(29, 73, 118)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0, 0, 1, -10)
Frame.Size = UDim2.new(1, 0, 0, 10)
Frame.ZIndex = 4

local Frame_2 = Instance.new("Frame")
Frame_2.Parent = Frame
Frame_2.BackgroundColor3 = Color3.fromRGB(59, 59, 68)
Frame_2.BorderSizePixel = 0
Frame_2.Position = UDim2.new(0, 0, 1, 0)
Frame_2.Size = UDim2.new(1, 0, 0, 2)
Frame_2.ZIndex = 2

local Content = Instance.new("ImageLabel")
Content.Name = "Content"
Content.Parent = Main
Content.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Content.BackgroundTransparency = 1.000
Content.ClipsDescendants = true
Content.Position = UDim2.new(0, 0, 1, 0)
Content.Size = UDim2.new(1, 0, 0, 550)
Content.Image = "rbxassetid://3570695787"
Content.ImageColor3 = Color3.fromRGB(21, 22, 23)
Content.ScaleType = Enum.ScaleType.Slice
Content.SliceCenter = Rect.new(100, 100, 100, 100)
Content.SliceScale = 0.050

local Frame_3 = Instance.new("Frame")
Frame_3.Parent = Content
Frame_3.BackgroundColor3 = Color3.fromRGB(21, 22, 23)
Frame_3.BorderSizePixel = 0
Frame_3.Size = UDim2.new(1, 0, 0, 10)

local Expand = Instance.new("ImageButton")
Expand.Name = "Expand"
Expand.Parent = Main
Expand.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Expand.BackgroundTransparency = 1.000
Expand.Position = UDim2.new(0, 6, 0, 2)
Expand.Rotation = 90.000
Expand.Size = UDim2.new(0, 18, 0, 18)
Expand.ZIndex = 4
Expand.Image = "rbxassetid://7671465363"

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = Main
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1.000
Title.Position = UDim2.new(0, 30, 0, 0)
Title.Size = UDim2.new(1, -30, 1, 0)
Title.ZIndex = 4
Title.Font = tzu2
Title.Text = "Block Listing"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 15
Title.TextWrapped = true
Title.TextXAlignment = Enum.TextXAlignment.Left

local Layer = Instance.new("ImageLabel")
Layer.Name = "Layer"
Layer.Parent = Main
Layer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Layer.BackgroundTransparency = 1.000
Layer.Position = UDim2.new(0, 2, 0, 2)
Layer.Size = UDim2.new(1, 0, 10.090909, 0)
Layer.ZIndex = 0
Layer.Image = "rbxassetid://3570695787"
Layer.ImageColor3 = Color3.fromRGB(10, 10, 11)
Layer.ScaleType = Enum.ScaleType.Slice
Layer.SliceCenter = Rect.new(100, 100, 100, 100)
Layer.SliceScale = 0.050

local Items = Instance.new("ScrollingFrame")
Items.Name = "Items"
Items.Parent = Content
Items.Active = true
Items.BackgroundColor3 = Color3.fromRGB(21, 22, 23)
Items.BorderSizePixel = 0
Items.Position = UDim2.new(0, 10, 0, 0)
Items.Size = UDim2.new(1, -20, 1, 0)
Items.CanvasSize = UDim2.new(0, 0, 0, 0)
Items.ScrollBarThickness = 6
Items.ScrollBarImageColor3 = Color3.new()

local UIListLayout = Instance.new("UIListLayout", Items)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

local Padding = Instance.new("Frame", Items)
Padding.Name = "Padding"
Padding.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Padding.BackgroundTransparency = 1.000

local ClearButton = Instance.new("TextButton")
ClearButton.Name = "Clear"
ClearButton.Parent = Main
ClearButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ClearButton.BackgroundTransparency = 1.000
ClearButton.BorderSizePixel = 0
ClearButton.Position = UDim2.new(1, -70, 0, 2)
ClearButton.Size = UDim2.new(0, 65, 0, 18)
ClearButton.ZIndex = 5
ClearButton.Font = tzu
ClearButton.Text = "Clear"
ClearButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ClearButton.TextSize = 13.000

local ClearImageLabel = Instance.new("ImageLabel")
ClearImageLabel.Parent = ClearButton
ClearImageLabel.Active = true
ClearImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
ClearImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ClearImageLabel.BackgroundTransparency = 1.000
ClearImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
ClearImageLabel.Selectable = true
ClearImageLabel.Size = UDim2.new(1, 0, 1, 0)
ClearImageLabel.ZIndex = 4
ClearImageLabel.Image = "rbxassetid://3570695787"
ClearImageLabel.ImageColor3 = Color3.fromRGB(122, 41, 41)
ClearImageLabel.ScaleType = Enum.ScaleType.Slice
ClearImageLabel.SliceCenter = Rect.new(100, 100, 100, 100)
ClearImageLabel.SliceScale = 0.050

local ClearLayer = Instance.new("ImageLabel")
ClearLayer.Name = "Layer"
ClearLayer.Parent = ClearButton
ClearLayer.Active = true
ClearLayer.AnchorPoint = Vector2.new(0.5, 0.5)
ClearLayer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ClearLayer.BackgroundTransparency = 1.000
ClearLayer.Position = UDim2.new(0.5, 2, 0.5, 2)
ClearLayer.Selectable = true
ClearLayer.Size = UDim2.new(1, 0, 1, 0)
ClearLayer.Image = "rbxassetid://3570695787"
ClearLayer.ImageColor3 = Color3.fromRGB(61, 21, 21)
ClearLayer.ScaleType = Enum.ScaleType.Slice
ClearLayer.SliceCenter = Rect.new(100, 100, 100, 100)
ClearLayer.SliceScale = 0.050

local ExampleBlock = Instance.new("Frame")
ExampleBlock.Name = "Block"
ExampleBlock.Size = UDim2.new(1, 0, 0, 40)
ExampleBlock.BackgroundTransparency = 1

local BlockOuter = Instance.new("ImageLabel", ExampleBlock)
BlockOuter.Name = "Outer"
BlockOuter.Size = UDim2.new(1, 0, 1, 0)
BlockOuter.Image = "rbxassetid://3570695787"
BlockOuter.ImageColor3 = Color3.fromRGB(59, 59, 68)
BlockOuter.ScaleType = Enum.ScaleType.Slice
BlockOuter.SliceCenter = Rect.new(100, 100, 100, 100)
BlockOuter.SliceScale = 0.050
BlockOuter.BackgroundTransparency = 1
BlockOuter.ZIndex = 11

local BlockInner = Instance.new("ImageLabel", BlockOuter)
BlockInner.Name = "Inner"
BlockInner.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
BlockInner.BackgroundTransparency = 1.000
BlockInner.Position = UDim2.new(0, 2, 0, 2)
BlockInner.Size = UDim2.new(1, -4, 1, -4)
BlockInner.Image = "rbxassetid://3570695787"
BlockInner.ImageColor3 = Color3.fromRGB(41, 74, 122)
BlockInner.ScaleType = Enum.ScaleType.Slice
BlockInner.SliceCenter = Rect.new(100, 100, 100, 100)
BlockInner.SliceScale = 0.050
BlockInner.ZIndex = 12

local Icon = Instance.new("ImageLabel", BlockInner)
Icon.Size = UDim2.new(0, 30, 0, 30)
Icon.Position = UDim2.new(0, 5, 0.5, -15)
Icon.Image = "rbxassetid://845567732"
Icon.BackgroundTransparency = 1
Icon.ZIndex = 13

local BlockText = Instance.new("TextLabel", BlockInner)
BlockText.Size = UDim2.new(1, -40, 1, 0)
BlockText.Position = UDim2.new(0, 35, 0, 0)
BlockText.Text = "Needed: 1\nMissing: 0"
BlockText.Font = tzu
BlockText.TextColor3 = TEXT_COLOR
BlockText.TextSize = 12
BlockText.TextXAlignment = Enum.TextXAlignment.Left
BlockText.BackgroundTransparency = 1
BlockText.RichText = true
BlockText.ZIndex = 14

local images = loadstring(game:HttpGet("https://raw.githubusercontent.com/Vyrusspcs/weshkyv2/refs/heads/main/server/blocklist.lua"))()

local function Resize(part, newProps, speed)
    local tween = TweenInfo.new(speed or 0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    TweenService:Create(part, tween, newProps):Play()
end

local originalContentSize = Content.Size
local originalMainSize = Main.Size
local isOpen = true

UserInputService.InputBegan:Connect(function(input, gpe)
    if input.KeyCode == Enum.KeyCode.RightShift then
        Main.Visible = not Main.Visible
    end
end)

Expand.MouseButton1Click:Connect(function()
    if isOpen then
        Resize(Expand, {Rotation = 0}, 0.1)
        Resize(Content, {Size = UDim2.new(1, 0, 0, 0)}, 0.1)
        Resize(Main, {Size = originalMainSize}, 0.1)
        isOpen = false
    else
        Resize(Expand, {Rotation = 90}, 0.1)
        Resize(Content, {Size = originalContentSize}, 0.1)
        Resize(Main, {Size = originalMainSize}, 0.1)
        isOpen = true
    end
end)

local function updateLayers()
    local y = Main.AbsoluteSize.Y + Content.AbsoluteSize.Y
    Layer.Size = UDim2.new(1, 0, 0, y)
    Layer.SliceScale = 0.050
end

Content:GetPropertyChangedSignal("Size"):Connect(updateLayers)
Main:GetPropertyChangedSignal("Size"):Connect(updateLayers)

local draggable = true
Main.Active = true

Main.MouseEnter:Connect(function()
    draggable = true
end)

Main.MouseLeave:Connect(function()
    draggable = false
end)

UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and draggable then
        local objectPosition = Vector2.new(UserInputService:GetMouseLocation().X - Main.AbsolutePosition.X, UserInputService:GetMouseLocation().Y - Main.AbsolutePosition.Y)
        while UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
            Resize(Main, {
                Position = UDim2.new(
                    0, 
                    UserInputService:GetMouseLocation().X - objectPosition.X + (Main.Size.X.Offset * Main.AnchorPoint.X), 
                    0, 
                    UserInputService:GetMouseLocation().Y - objectPosition.Y + (Main.Size.Y.Offset * Main.AnchorPoint.Y)
                )
            }, 0.1)
            game:GetService("RunService").Heartbeat:Wait()
        end
    end
end)

local Functions = {}

local COLORS = {
    RED = Color3.fromRGB(122, 41, 41),
    YELLOW = Color3.fromRGB(145, 103, 25), 
    GREEN = Color3.fromRGB(41, 122, 56),
    NEUTRAL = Color3.fromRGB(59, 59, 68),
}

function Functions:Clear()
    for _, child in pairs(Items:GetChildren()) do
        if not child:IsA("UIListLayout") and child.Name ~= "Padding" then
            child:Destroy()
        end
    end
    Items.CanvasSize = UDim2.new(0, 0, 0, 0)
end

function Functions:Add(name, needed, missing)
    local block = ExampleBlock:Clone()
    block.Parent = Items
    local inner = block:FindFirstChild("Inner")
    
    if images[name] then
        block:FindFirstChild("Icon").Image = images[name]
    else
        block:FindFirstChild("Icon").Visible = false
    end
    
    local textLabel = block:FindFirstChild("BlockText")
    textLabel.Text = string.format("Needed: %d\nMissing: %d", needed or 0, missing or 0)
    
    local color = COLORS.GREEN
    if needed and needed > 0 then
        local perc = (missing or 0) / needed
        if perc == 0 then 
            color = COLORS.GREEN
        elseif perc <= 0.5 then 
            color = COLORS.YELLOW
        else 
            color = COLORS.RED 
        end
    end
    
    inner.ImageColor3 = color
    
    local totalHeight = 0
    for _, child in pairs(Items:GetChildren()) do
        if not child:IsA("UIListLayout") and child.Name ~= "Padding" then
            totalHeight = totalHeight + child.AbsoluteSize.Y + 5
        end
    end
    Items.CanvasSize = UDim2.new(0, 0, 0, totalHeight)
end

ClearButton.MouseButton1Click:Connect(function()
    Functions:Clear()
end)

updateLayers()

return Functions
