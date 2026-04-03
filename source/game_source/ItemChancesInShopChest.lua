-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-03 13:21:01
-- Luau version 6, Types version 3
-- Time taken: 0.030415 seconds

local module_upvr = {
	green = {};
}
module_upvr.green.AmountGiveBlocks = 1
module_upvr.green.Blocks = {}
table.insert(module_upvr.green.Blocks, {"WoodBlock", 25})
table.insert(module_upvr.green.Blocks, {"FabricBlock", 25})
table.insert(module_upvr.green.Blocks, {"StoneBlock", 15})
table.insert(module_upvr.green.Blocks, {"WoodRod", 7})
table.insert(module_upvr.green.Blocks, {"StoneRod", 7})
table.insert(module_upvr.green.Blocks, {"Wedge", 7})
table.insert(module_upvr.green.Blocks, {"Truss", 7})
table.insert(module_upvr.green.Blocks, {"CornerWedge", 7})
module_upvr.green.AmountGiveDecors = 1
module_upvr.green.Decor = {}
table.insert(module_upvr.green.Decor, {"Step", 33})
table.insert(module_upvr.green.Decor, {"Seat", 33})
table.insert(module_upvr.green.Decor, {"Window", 33})
table.insert(module_upvr.green.Decor, {"ChestCommon", 1})
module_upvr.green.AmountGiveSpecials = 0
module_upvr.green.Special = {}
module_upvr.greenPolicy = {}
module_upvr.greenPolicy.AmountGiveBlocks = 2
module_upvr.greenPolicy.Blocks = {}
table.insert(module_upvr.greenPolicy.Blocks, {"WoodBlock", 1})
table.insert(module_upvr.greenPolicy.Blocks, {"WoodRod", 1})
module_upvr.greenPolicy.AmountGiveDecors = 0
module_upvr.greenPolicy.Decor = {}
module_upvr.greenPolicy.AmountGiveSpecials = 0
module_upvr.greenPolicy.Special = {}
module_upvr.yellow = {}
module_upvr.yellow.AmountGiveBlocks = 4
module_upvr.yellow.Blocks = {}
table.insert(module_upvr.yellow.Blocks, {"RustedBlock", 30})
table.insert(module_upvr.yellow.Blocks, {"MetalBlock", 30})
table.insert(module_upvr.yellow.Blocks, {"GlassBlock", 10})
table.insert(module_upvr.yellow.Blocks, {"PlasticBlock", 10})
table.insert(module_upvr.yellow.Blocks, {"GrassBlock", 10})
table.insert(module_upvr.yellow.Blocks, {"Wedge", 1.429})
table.insert(module_upvr.yellow.Blocks, {"Truss", 1.429})
table.insert(module_upvr.yellow.Blocks, {"CornerWedge", 1.429})
table.insert(module_upvr.yellow.Blocks, {"RustedRod", 1.429})
table.insert(module_upvr.yellow.Blocks, {"MetalRod", 1.429})
table.insert(module_upvr.yellow.Blocks, {"WoodRod", 1.429})
table.insert(module_upvr.yellow.Blocks, {"StoneRod", 1.429})
module_upvr.yellow.AmountGiveDecors = 1
module_upvr.yellow.Decor = {}
table.insert(module_upvr.yellow.Decor, {"Step", 9.9})
table.insert(module_upvr.yellow.Decor, {"Seat", 9.9})
table.insert(module_upvr.yellow.Decor, {"Steel I-Beam", 9.9})
table.insert(module_upvr.yellow.Decor, {"Helm", 9.9})
table.insert(module_upvr.yellow.Decor, {"Window", 9.9})
table.insert(module_upvr.yellow.Decor, {"Mast", 9.9})
table.insert(module_upvr.yellow.Decor, {"Chair", 9.9})
table.insert(module_upvr.yellow.Decor, {"Torch", 9.9})
table.insert(module_upvr.yellow.Decor, {"WoodDoor", 9.9})
table.insert(module_upvr.yellow.Decor, {"WoodTrapDoor", 9.9})
table.insert(module_upvr.yellow.Decor, {"ChestUncommon", 1})
module_upvr.yellow.AmountGiveSpecials = 0
module_upvr.yellow.Special = {}
module_upvr.yellowPolicy = {}
module_upvr.yellowPolicy.AmountGiveBlocks = 5
module_upvr.yellowPolicy.Blocks = {}
table.insert(module_upvr.yellowPolicy.Blocks, {"RustedBlock", 2})
table.insert(module_upvr.yellowPolicy.Blocks, {"MetalBlock", 2})
table.insert(module_upvr.yellowPolicy.Blocks, {"Truss", 1})
module_upvr.yellowPolicy.AmountGiveDecors = 1
module_upvr.yellowPolicy.Decor = {}
table.insert(module_upvr.yellowPolicy.Decor, {"Seat", 1})
module_upvr.yellowPolicy.AmountGiveSpecials = 0
module_upvr.yellowPolicy.Special = {}
module_upvr.red = {}
module_upvr.red.AmountGiveBlocks = 12
module_upvr.red.Blocks = {}
table.insert(module_upvr.red.Blocks, {"ConcreteBlock", 30})
table.insert(module_upvr.red.Blocks, {"MarbleBlock", 30})
table.insert(module_upvr.red.Blocks, {"IceBlock", 15})
table.insert(module_upvr.red.Blocks, {"SandBlock", 15})
table.insert(module_upvr.red.Blocks, {"ConcreteRod", 2})
table.insert(module_upvr.red.Blocks, {"MarbleRod", 2})
table.insert(module_upvr.red.Blocks, {"RustedRod", 2})
table.insert(module_upvr.red.Blocks, {"MetalRod", 2})
table.insert(module_upvr.red.Blocks, {"Truss", 2})
module_upvr.red.AmountGiveDecors = 2
module_upvr.red.Decor = {}
table.insert(module_upvr.red.Decor, {"Flag", 12.494})
table.insert(module_upvr.red.Decor, {"WoodDoor", 12.494})
table.insert(module_upvr.red.Decor, {"WoodTrapDoor", 12.494})
table.insert(module_upvr.red.Decor, {"Steel I-Beam", 12.494})
table.insert(module_upvr.red.Decor, {"Helm", 12.494})
table.insert(module_upvr.red.Decor, {"Mast", 12.494})
table.insert(module_upvr.red.Decor, {"Chair", 12.494})
table.insert(module_upvr.red.Decor, {"Torch", 12.494})
table.insert(module_upvr.red.Decor, {"ChestRare", 0.5})
module_upvr.red.AmountGiveSpecials = 1
module_upvr.red.Special = {}
table.insert(module_upvr.red.Special, {"Glue", 16.67})
table.insert(module_upvr.red.Special, {"Cannon", 16.67})
table.insert(module_upvr.red.Special, {"Switch", 16.67})
table.insert(module_upvr.red.Special, {"Piston", 16.67})
table.insert(module_upvr.red.Special, {"BalloonBlock", 16.67})
table.insert(module_upvr.red.Special, {"Hinge", 16.67})
module_upvr.redPolicy = {}
module_upvr.redPolicy.AmountGiveBlocks = 10
module_upvr.redPolicy.Blocks = {}
table.insert(module_upvr.redPolicy.Blocks, {"ConcreteBlock", 5})
table.insert(module_upvr.redPolicy.Blocks, {"MarbleBlock", 5})
module_upvr.redPolicy.AmountGiveDecors = 5
module_upvr.redPolicy.Decor = {}
table.insert(module_upvr.redPolicy.Decor, {"Flag", 1})
table.insert(module_upvr.redPolicy.Decor, {"Mast", 1})
table.insert(module_upvr.redPolicy.Decor, {"Chair", 1})
table.insert(module_upvr.redPolicy.Decor, {"Torch", 2})
module_upvr.redPolicy.AmountGiveSpecials = 0
module_upvr.redPolicy.Special = {}
module_upvr.blue = {}
module_upvr.blue.AmountGiveBlocks = 38
module_upvr.blue.Blocks = {}
table.insert(module_upvr.blue.Blocks, {"TitaniumBlock", 30})
table.insert(module_upvr.blue.Blocks, {"ConcreteBlock", 30})
table.insert(module_upvr.blue.Blocks, {"CoalBlock", 30})
table.insert(module_upvr.blue.Blocks, {"ConcreteRod", 3.333})
table.insert(module_upvr.blue.Blocks, {"MarbleRod", 3.333})
table.insert(module_upvr.blue.Blocks, {"TitaniumRod", 3.333})
module_upvr.blue.AmountGiveDecors = 4
module_upvr.blue.Decor = {}
table.insert(module_upvr.blue.Decor, {"Flag", 16.625})
table.insert(module_upvr.blue.Decor, {"Chair", 16.625})
table.insert(module_upvr.blue.Decor, {"LockedDoor", 16.625})
table.insert(module_upvr.blue.Decor, {"Throne", 16.625})
table.insert(module_upvr.blue.Decor, {"Lamp", 16.625})
table.insert(module_upvr.blue.Decor, {"Sign", 16.625})
table.insert(module_upvr.blue.Decor, {"ChestEpic", 0.25})
module_upvr.blue.AmountGiveSpecials = 2
module_upvr.blue.Special = {}
table.insert(module_upvr.blue.Special, {"Glue", 12.5})
table.insert(module_upvr.blue.Special, {"Cannon", 12.5})
table.insert(module_upvr.blue.Special, {"Button", 12.5})
table.insert(module_upvr.blue.Special, {"Switch", 12.5})
table.insert(module_upvr.blue.Special, {"Piston", 12.5})
table.insert(module_upvr.blue.Special, {"BalloonBlock", 12.5})
table.insert(module_upvr.blue.Special, {"Hinge", 12.5})
table.insert(module_upvr.blue.Special, {"Thruster", 12.5})
module_upvr.bluePolicy = {}
module_upvr.bluePolicy.AmountGiveBlocks = 30
module_upvr.bluePolicy.Blocks = {}
table.insert(module_upvr.bluePolicy.Blocks, {"TitaniumBlock", 15})
table.insert(module_upvr.bluePolicy.Blocks, {"ConcreteBlock", 15})
module_upvr.bluePolicy.AmountGiveDecors = 12
module_upvr.bluePolicy.Decor = {}
table.insert(module_upvr.bluePolicy.Decor, {"Window", 8})
table.insert(module_upvr.bluePolicy.Decor, {"Helm", 1})
table.insert(module_upvr.bluePolicy.Decor, {"Throne", 1})
table.insert(module_upvr.bluePolicy.Decor, {"WoodDoor", 1})
table.insert(module_upvr.bluePolicy.Decor, {"WoodTrapDoor", 1})
module_upvr.bluePolicy.AmountGiveSpecials = 4
module_upvr.bluePolicy.Special = {}
table.insert(module_upvr.bluePolicy.Special, {"Cannon", 3})
table.insert(module_upvr.bluePolicy.Special, {"Switch", 1})
module_upvr.purple = {}
module_upvr.purple.AmountGiveBlocks = 120
module_upvr.purple.Blocks = {}
table.insert(module_upvr.purple.Blocks, {"ObsidianBlock", 33.333})
table.insert(module_upvr.purple.Blocks, {"TitaniumBlock", 33.333})
table.insert(module_upvr.purple.Blocks, {"BrickBlock", 33.333})
module_upvr.purple.AmountGiveDecors = 8
module_upvr.purple.Decor = {}
table.insert(module_upvr.purple.Decor, {"LockedDoor", 24.969})
table.insert(module_upvr.purple.Decor, {"Throne", 24.969})
table.insert(module_upvr.purple.Decor, {"Lamp", 24.969})
table.insert(module_upvr.purple.Decor, {"Sign", 24.969})
table.insert(module_upvr.purple.Decor, {"ChestLegendary", 0.125})
module_upvr.purple.AmountGiveSpecials = 4
module_upvr.purple.Special = {}
table.insert(module_upvr.purple.Special, {"Glue", 11.111})
table.insert(module_upvr.purple.Special, {"Cannon", 11.111})
table.insert(module_upvr.purple.Special, {"Button", 11.111})
table.insert(module_upvr.purple.Special, {"Switch", 11.111})
table.insert(module_upvr.purple.Special, {"Piston", 11.111})
table.insert(module_upvr.purple.Special, {"BalloonBlock", 11.111})
table.insert(module_upvr.purple.Special, {"Hinge", 11.111})
table.insert(module_upvr.purple.Special, {"Thruster", 11.111})
table.insert(module_upvr.purple.Special, {"Harpoon", 11.111})
module_upvr.purplePolicy = {}
module_upvr.purplePolicy.AmountGiveBlocks = 125
module_upvr.purplePolicy.Blocks = {}
table.insert(module_upvr.purplePolicy.Blocks, {"ObsidianBlock", 50})
table.insert(module_upvr.purplePolicy.Blocks, {"TitaniumBlock", 50})
table.insert(module_upvr.purplePolicy.Blocks, {"GlassBlock", 25})
module_upvr.purplePolicy.AmountGiveDecors = 6
module_upvr.purplePolicy.Decor = {}
table.insert(module_upvr.purplePolicy.Decor, {"Lamp", 3})
table.insert(module_upvr.purplePolicy.Decor, {"LockedDoor", 1})
table.insert(module_upvr.purplePolicy.Decor, {"Throne", 1})
table.insert(module_upvr.purplePolicy.Decor, {"Sign", 1})
module_upvr.purplePolicy.AmountGiveSpecials = 22
module_upvr.purplePolicy.Special = {}
table.insert(module_upvr.purplePolicy.Special, {"BalloonBlock", 10})
table.insert(module_upvr.purplePolicy.Special, {"Cannon", 4})
table.insert(module_upvr.purplePolicy.Special, {"Glue", 2})
table.insert(module_upvr.purplePolicy.Special, {"Piston", 2})
table.insert(module_upvr.purplePolicy.Special, {"Button", 1})
table.insert(module_upvr.purplePolicy.Special, {"Switch", 1})
table.insert(module_upvr.purplePolicy.Special, {"Thruster", 1})
table.insert(module_upvr.purplePolicy.Special, {"Harpoon", 1})
module_upvr.winter = {}
module_upvr.winter.AmountGiveBlocks = 12
module_upvr.winter.Blocks = {}
table.insert(module_upvr.winter.Blocks, {"ToyBlock", 69})
table.insert(module_upvr.winter.Blocks, {"SmoothWoodBlock", 15})
table.insert(module_upvr.winter.Blocks, {"CoalBlock", 15})
table.insert(module_upvr.winter.Blocks, {"NeonBlock", 1})
module_upvr.winter.AmountGiveDecors = 2
module_upvr.winter.Decor = {}
table.insert(module_upvr.winter.Decor, {"PineTree", 30})
table.insert(module_upvr.winter.Decor, {"Star", 20})
table.insert(module_upvr.winter.Decor, {"Gift2", 50})
module_upvr.winter.AmountGiveSpecials = 1
module_upvr.winter.Special = {}
table.insert(module_upvr.winter.Special, {"BalloonBlock", 79})
table.insert(module_upvr.winter.Special, {"Harpoon", 20.5})
table.insert(module_upvr.winter.Special, {"DualCaneHarpoon", 0.5})
module_upvr.winterPolicy = {}
module_upvr.winterPolicy.AmountGiveBlocks = 12
module_upvr.winterPolicy.Blocks = {}
table.insert(module_upvr.winterPolicy.Blocks, {"ToyBlock", 6})
table.insert(module_upvr.winterPolicy.Blocks, {"SmoothWoodBlock", 5})
table.insert(module_upvr.winterPolicy.Blocks, {"NeonBlock", 1})
module_upvr.winterPolicy.AmountGiveDecors = 3
module_upvr.winterPolicy.Decor = {}
table.insert(module_upvr.winterPolicy.Decor, {"PineTree", 1})
table.insert(module_upvr.winterPolicy.Decor, {"Star", 1})
table.insert(module_upvr.winterPolicy.Decor, {"Gift2", 1})
module_upvr.winterPolicy.AmountGiveSpecials = 0
module_upvr.winterPolicy.Special = {}
for _, v in pairs(module_upvr) do
	for _, v_2 in pairs({v.Blocks, v.Decor, v.Special}) do
		local var170 = 0
		for _, v_3 in pairs(v_2) do
			var170 += v_3[2] * 10000
			table.insert(v_3, var170)
		end
	end
end
function module_upvr.getRandomRewardsOfColor(arg1, arg2, arg3) -- Line 357
	--[[ Upvalues[1]:
		[1]: module_upvr (readonly)
	]]
	-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [243] 201. Error Block 59 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [243] 201. Error Block 59 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [6] 6. Error Block 2 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [6] 6. Error Block 2 end (CF ANALYSIS FAILED)
end
return module_upvr