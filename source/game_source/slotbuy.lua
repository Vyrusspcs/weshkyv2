local v_u_1 = game.Players.LocalPlayer
local v_u_2 = {
	0,
	0,
	0,
	100,
	200,
	300,
	400,
	500,
	600,
	700,
	800,
	900,
	1000,
	1100,
	1200,
	1300,
	1400,
	1500,
	1600,
	1700,
	1800,
	1900,
	2000,
	2100,
	2200,
	2300,
	2400,
	2500,
	2600,
	2700,
	2800,
	2900,
	3000,
	3100,
	3200,
	3300,
	3400,
	3500,
	3600,
	3700,
	3800,
	3900,
	4000,
	4100,
	4200,
	4300,
	4400,
	4500,
	4600,
	4700,
	4800,
	4900,
	5000,
	5100,
	5200,
	5300,
	5400,
	5500,
	5600,
	5700,
	5800,
	5900,
	6000,
	6100,
	6200,
	6300,
	6400,
	6500,
	6600,
	6700,
	6800,
	6900,
	7000,
	7100,
	7200,
	7300,
	7400,
	7500,
	7600,
	7700,
	7800,
	7900,
	8000,
	8100,
	8200,
	8300,
	8400,
	8500,
	8600,
	8700,
	8800,
	8900,
	9000,
	9100,
	9200,
	9300,
	9400,
	9500,
	9600,
	9700,
	9800,
	9900,
	10000
}
function active()
	-- upvalues: (copy) v_u_1, (copy) v_u_2
	local v3 = v_u_2[getNumOfSlotsOwned(v_u_1) + 1]
	if v3 then
		script.Parent.Parent.Parent.PromptBuySlot.Buy2.PriceLable.Text = tostring(v3)
		script.Parent.Parent.Parent.PromptBuySlot.Buy2.BackgroundColor3 = Color3.fromRGB(0, 132, 255)
		script.Parent.Parent.Parent.PromptBuySlot.Buy2.GoldImage.ImageColor3 = Color3.fromRGB(255, 255, 255)
	else
		script.Parent.Parent.Parent.PromptBuySlot.Buy2.PriceLable.Text = ""
		script.Parent.Parent.Parent.PromptBuySlot.Buy2.BackgroundColor3 = Color3.fromRGB(91, 91, 91)
		script.Parent.Parent.Parent.PromptBuySlot.Buy2.GoldImage.ImageColor3 = Color3.fromRGB(91, 91, 91)
	end
	script.Parent.Parent.Parent.PromptBuySlot.Visible = true
end
function getNumOfSlotsOwned(p4)
	local v5 = true
	local v6 = 3
	while v5 do
		local v7 = p4.OtherData
		local v8 = v6 + 1
		if v7:FindFirstChild("Slot" .. tostring(v8)) then
			v6 = v6 + 1
			v5 = true
		else
			v5 = false
		end
	end
	return v6
end
script.Parent.MouseButton1Click:Connect(active)

-- // Function Dumper made by King.Kevin
-- // Script Path: Players.julia_NakamuraMY.PlayerGui.ShopGui.MainFrame.TabFrame.SlotsFrame.ScrollingFrameSlots.BoatSlot999+.LocalScript

--[[
Function Dump: getNumOfSlotsOwned

Function Upvalues: getNumOfSlotsOwned

Function Constants: getNumOfSlotsOwned
    1 [string] = OtherData
    2 [string] = Slot
    3 [number] = 1
    4 [string] = tostring
    6 [string] = FindFirstChild

====================================================================================================

Function Dump: active

Function Upvalues: active
    1 [Instance] = julia_NakamuraMY
    2 [table]:
    2 [table] table: 0x4513bc40073a5991
        1 [number] = 0
        2 [number] = 0
        3 [number] = 0
        4 [number] = 100
        5 [number] = 200
        6 [number] = 300
        7 [number] = 400
        8 [number] = 500
        9 [number] = 600
        10 [number] = 700
        11 [number] = 800
        12 [number] = 900
        13 [number] = 1000
        14 [number] = 1100
        15 [number] = 1200
        16 [number] = 1300
        17 [number] = 1400
        18 [number] = 1500
        19 [number] = 1600
        20 [number] = 1700
        21 [number] = 1800
        22 [number] = 1900
        23 [number] = 2000
        24 [number] = 2100
        25 [number] = 2200
        26 [number] = 2300
        27 [number] = 2400
        28 [number] = 2500
        29 [number] = 2600
        30 [number] = 2700
        31 [number] = 2800
        32 [number] = 2900
        33 [number] = 3000
        34 [number] = 3100
        35 [number] = 3200
        36 [number] = 3300
        37 [number] = 3400
        38 [number] = 3500
        39 [number] = 3600
        40 [number] = 3700
        41 [number] = 3800
        42 [number] = 3900
        43 [number] = 4000
        44 [number] = 4100
        45 [number] = 4200
        46 [number] = 4300
        47 [number] = 4400
        48 [number] = 4500
        49 [number] = 4600
        50 [number] = 4700
        51 [number] = 4800
        52 [number] = 4900
        53 [number] = 5000
        54 [number] = 5100
        55 [number] = 5200
        56 [number] = 5300
        57 [number] = 5400
        58 [number] = 5500
        59 [number] = 5600
        60 [number] = 5700
        61 [number] = 5800
        62 [number] = 5900
        63 [number] = 6000
        64 [number] = 6100
        65 [number] = 6200
        66 [number] = 6300
        67 [number] = 6400
        68 [number] = 6500
        69 [number] = 6600
        70 [number] = 6700
        71 [number] = 6800
        72 [number] = 6900
        73 [number] = 7000
        74 [number] = 7100
        75 [number] = 7200
        76 [number] = 7300
        77 [number] = 7400
        78 [number] = 7500
        79 [number] = 7600
        80 [number] = 7700
        81 [number] = 7800
        82 [number] = 7900
        83 [number] = 8000
        84 [number] = 8100
        85 [number] = 8200
        86 [number] = 8300
        87 [number] = 8400
        88 [number] = 8500
        89 [number] = 8600
        90 [number] = 8700
        91 [number] = 8800
        92 [number] = 8900
        93 [number] = 9000
        94 [number] = 9100
        95 [number] = 9200
        96 [number] = 9300
        97 [number] = 9400
        98 [number] = 9500
        99 [number] = 9600
        100 [number] = 9700
        101 [number] = 9800
        102 [number] = 9900
        103 [number] = 10000

Function Constants: active
    1 [string] = getNumOfSlotsOwned
    2 [number] = 1
    3 [string] = script
    5 [string] = Parent
    6 [string] = PromptBuySlot
    7 [string] = Buy2
    8 [string] = PriceLable
    9 [string] = tostring
    11 [string] = Text
    12 [string] = Color3
    13 [string] = fromRGB
    15 [string] = BackgroundColor3
    16 [string] = GoldImage
    17 [string] = ImageColor3
    18 [string] = 
    19 [string] = Visible

====================================================================================================
]]
