-------------------------------------------------------
--   Ability: Blacksmithing
--      Tool: Anvil
--  Job Type: Production
--     Desc.: Make many different types of Tools, Weapons and Armor.
-------------------------------------------------------
-- Script Author: John Crandell
--   Last Edited: 07/26/2017
-------------------------------------------------------
anvil = {
	use = function(player)
		player:freeAsync()
		player.lastClick = player.ID
		anvil.click(player)
	end,
	click = async(
		function(player, npc)
			----------------------------
			-- Local Variable Declare --
			----------------------------
			local ability = "smithing"
			local smithingLevel = player.registry["smithing_level"]
			local anvilObj = getObjFacing(player, player.side)
			local tool = player:getEquippedItem(EQ_WEAP)

			local optsAnvil = {}
			local anvilImage
			local anvilMenuOption
			local mapNum = player.m

			local makeTools = player.registry["smith_tools_knowledge"]
			local makeBodyArmor = player.registry["smith_bodyarmor_knowledge"]
			local makeHelmet = player.registry["smith_helmet_knowledge"]
			local makeGloves = player.registry["smith_gloves_knowledge"]
			local makeBoots = player.registry["smith_boots_knowledge"]
			local makeSwords = player.registry["smith_swords_knowledge"]
			local makeDaggers = player.registry["smith_daggers_knowledge"]
			local makeShields = player.registry["smith_shields_knowledge"]
			local makeBelts = player.registry["smith_belts_knowledge"]
			local makeNails = player.registry["smith_nails_knowledge"]
			local makePlates = player.registry["smith_plates_knowledge"]
			local makePickAxe = player.registry["smith_pickaxe_knowledge"]
			local makeHerbCutter = player.registry["smith_herbcutter_knowledge"]

			local processCount
			local processCount2
			local processCount3
			local processCount4

			local skillEXP
			local addItem

			local failChance
			local rankFailChance
			local itemFailChance

			local baseQualityChance  -- These three numbers need to add up to 100.
			local fineQualityChance
			local superiorQualityChance

			-- Set these for testing purposes.
			if player.gmLevel > 0 then
				makeTools = 1
				makeBodyArmor = 1
				makeHelmet = 1
				makeGloves = 1
				makeBoots = 1
				makeSwords = 1
				makeDaggers = 1
				makeShields = 1
				makeNimble = 1
				makeBelts = 1
				makeNails = 1
				makePlates = 1
				makePickAxe = 1
				makeHerbCutter = 1
				smithingLevel = 15
			end
			--------------------------------------------------------------------
			-- You pressed "O" in front of the Anvil on -----------------
			-- the Alchemist's Hut map (MapID 10 or Crafter's Have (MapID 11) --
			--------------------------------------------------------------------

			-- You are facing a Mortar
			if player:hasDuration("smithing") then
				return
			end

			if player.registry["learned_smithing"] < 1 then
				player:talkSelf(0, "I don't know how to use this!")
				return
			end

			if anvilObj == 693 or anvilObj == 693 then
				-- You need to have tongs
				if tool ~= nil then
					-- The tool Blacksmith Hammer of some sort.
					if tool.id >= 4091 and tool.id < 4095 then
						------------------
						-- End Crafting --
						------------------
						-------------------------------------------------
						-- Increase reward based quality of Pestle     --
						-------------------------------------------------
						if tool.id == 4091 then
							toolFailChance = 7
							baseQualityChance = 85 -- These three numbers need to add up to 100.
							fineQualityChance = 10
							superiorQualityChance = 5
						elseif tool.id == 4092 then
							toolFailChance = 6
							baseQualityChance = 82
							fineQualityChance = 12
							superiorQualityChance = 6
						elseif tool.id == 4093 then
							toolFailChance = 5
							baseQualityChance = 79
							fineQualityChance = 14
							superiorQualityChance = 7
						elseif tool.id == 4094 then
							toolFailChance = 3
							baseQualityChance = 76
							fineQualityChance = 16
							superiorQualityChance = 8
						else
							return
						end
						-- Max Bonuses
						-- baseQualityItemMod = -15
						-- fineQualityItemMod = 10
						-- superiorQualityItemMod = 5
						-------------------------------------------------
						-- Increase reward based on Smithing rank     --
						-------------------------------------------------
						if smithingLevel > 0 and smithingLevel <= 3 then
							rankFailChance = 10
							baseQualityRankMod = 0
							fineQualityRankMod = 0
							superiorQualityRankMod = 0
						elseif smithingLevel > 3 and smithingLevel <= 5 then
							rankFailChance = 7
							baseQualityRankMod = -6
							fineQualityRankMod = 4
							superiorQualityRankMod = 2
						elseif smithingLevel > 5 and smithingLevel <= 8 then
							rankFailChance = 4
							baseQualityRankMod = -6
							fineQualityRankMod = 4
							superiorQualityRankMod = 2
						elseif smithingLevel > 8 and smithingLevel <= 12 then
							rankFailChance = 0
							baseQualityRankMod = -9
							fineQualityRankMod = 6
							superiorQualityRankMod = 3
						elseif smithingLevel > 12 then
							rankFailChance = -5
							baseQualityRankMod = -15
							fineQualityRankMod = 10
							superiorQualityRankMod = 5
						else
							-- Error Handler: Rank is not set.
							player:talkSelf(0, "My smithingLevel seems odd...", smithingLevel)
							return
						end
						-------------------------------------------
						-- What items can be processed by rank --
						-- And then by what in the inventory ------
						-- Build the list -------------------------
						-------------------------------------------

						--Build a listing of what items can be crafted
						--------------------------------------
						-- Smithing Rank 1: Copper Items --
						--------------------------------------
						if smithingLevel >= 1 then -- Beginner
							if makeDaggers == 1 then
								if player:hasItem("copper_ingot", 2) == true then
									table.insert(optsAnvil, "Copper Dagger")
								end
							end
							if makePickAxe == 1 then
								if player:hasItem("copper_ingot", 2) == true then
									table.insert(optsAnvil, "Copper Pickaxe")
								end
							end
							if makeHerbCutter == 1 then
								if player:hasItem("copper_ingot", 2) == true then
									table.insert(optsAnvil, "Copper Herb Cutter")
								end
							end
						end
						--------------------------------------
						-- Smithing Rank 2: Tin Items --
						--------------------------------------
						if smithingLevel >= 2 then -- Novice
							if makeDaggers == 1 then
								if player:hasItem("tin_ingot", 2) == true then
									table.insert(optsAnvil, "Tin Dagger")
								end
							end
							if makeSwords == 1 then
								if player:hasItem("tin_ingot", 4) == true then
									table.insert(optsAnvil, "Tin Sword")
								end
							end
						end
						--------------------------------------
						-- Concocting Rank 3: Bronze Items --
						--------------------------------------
						if smithingLevel >= 3 then -- Trainee
							if makeDaggers == 1 then
								if player:hasItem("bronze_ingot", 2) == true then
									table.insert(optsAnvil, "Tin Dagger")
								end
							end
							if makeSwords == 1 then
								if player:hasItem("bronze_ingot", 4) == true then
									table.insert(optsAnvil, "Tin Sword")
								end
							end
							if makeBodyArmor == 1 then
								if player:hasItem("bronze_ingot", 8) == true then
									table.insert(optsAnvil, "Bronze Body Armor (M)")
								end
								if player:hasItem("bronze_ingot", 8) == true then
									table.insert(optsAnvil, "Bronze Body Armor (F)")
								end
							end
							if makeHelmet == 1 then
								if player:hasItem("bronze_ingot", 6) == true then
									table.insert(optsAnvil, "Bronze Helmet")
								end
							end
							if makeGloves == 1 then
								if player:hasItem("bronze_ingot", 3) == true then
									table.insert(optsAnvil, "Bronze Glove")
								end
							end
							if makeBoots == 1 then
								if player:hasItem("bronze_ingot", 6) == true then
									table.insert(optsAnvil, "Bronze Boots")
								end
							end
						end

						----------------------------------------
						-- Smithing Rank 4: Orichalcum Items --
						----------------------------------------
						if smithingLevel >= 4 then -- Apprentice
							if makeDaggers == 1 then
								if player:hasItem("orichalcum_ingot", 2) == true then
									table.insert(optsAnvil, "Orichalcum Dagger")
								end
							end
							if makeSwords == 1 then
								if player:hasItem("orichalcum_ingot", 4) == true then
									table.insert(optsAnvil, "Orichalcum Sword")
								end
							end
							if makeBodyArmor == 1 then
								if player:hasItem("orichalcum_ingot", 8) == true then
									table.insert(optsAnvil, "Orichalcum Body Armor (M)")
								end
								if player:hasItem("orichalcum_ingot", 8) == true then
									table.insert(optsAnvil, "Orichalcum Body Armor (F)")
								end
							end
							if makeHelmet == 1 then
								if player:hasItem("orichalcum_ingot", 6) == true then
									table.insert(optsAnvil, "Orichalcum Helmet")
								end
							end
							if makeGloves == 1 then
								if player:hasItem("orichalcum_ingot", 3) == true then
									table.insert(optsAnvil, "Orichalcum Glove")
								end
							end
							if makeBoots == 1 then
								if player:hasItem("orichalcum_ingot", 6) == true then
									table.insert(optsAnvil, "Orichalcum Boots")
								end
							end
							if makeBelts == 1 then
								if player:hasItem("orichalcum_ingot", 2) == true and player:hasItem("leather strap", 4) == true then
									table.insert(optsAnvil, "Orichalcum Belt")
								end
							end
						end

						----------------------------------------
						-- Smithing Rank 5: Iron Items --
						----------------------------------------
						if smithingLevel >= 5 then -- Greenhorn
							if makeNails == 1 then
								if player:hasItem("iron_ingot", 1) == true then
									table.insert(optsAnvil, "Iron Nails")
								end
							end
							if makePlates == 1 then
								if player:hasItem("iron_ingot", 4) == true then
									table.insert(optsAnvil, "Iron Plate")
								end
							end
							if makePickAxe == 1 then
								if player:hasItem("iron_ingot", 2) == true then
									table.insert(optsAnvil, "Iron Pickaxe")
								end
							end
							if makeHerbCutter == 1 then
								if player:hasItem("iron_ingot", 2) == true then
									table.insert(optsAnvil, "Iron Herb Cutter")
								end
							end
						end

						----------------------------------------
						-- Smithing Rank 6: Steel Items --
						----------------------------------------
						if smithingLevel >= 6 then -- Aspirant
							if makeDaggers == 1 then
								if player:hasItem("steel_ingot", 2) == true then
									table.insert(optsAnvil, "Steel Dagger")
								end
							end
							if makeSwords == 1 then
								if player:hasItem("steel_ingot", 4) == true then
									table.insert(optsAnvil, "Steel Sword")
								end
							end
							if makeBodyArmor == 1 then
								if player:hasItem("steel_ingot", 8) == true then
									table.insert(optsAnvil, "Steel Body Armor (M)")
								end
								if player:hasItem("steel_ingot", 8) == true then
									table.insert(optsAnvil, "Steel Body Armor (F)")
								end
							end
							if makeHelmet == 1 then
								if player:hasItem("steel_ingot", 6) == true then
									table.insert(optsAnvil, "Steel Helmet")
								end
							end
							if makeGloves == 1 then
								if player:hasItem("steel_ingot", 3) == true then
									table.insert(optsAnvil, "Steel Glove")
								end
							end
							if makeBoots == 1 then
								if player:hasItem("steel_ingot", 6) == true then
									table.insert(optsAnvil, "Steel Boots")
								end
							end
							if makeBelts == 1 then
								if player:hasItem("steel_ingot", 2) == true and player:hasItem("leather strap", 4) == true then
									table.insert(optsAnvil, "Steel Belt")
								end
							end
							if makeShields == 1 then
								if player:hasItem("steel_ingot", 4) == true and player:hasItem("wooden board", 4) == true then
									table.insert(optsAnvil, "Steel Shield")
								end
							end
						end
						----------------------------------------
						-- Smithing Rank 7:  --
						----------------------------------------
						if smithingLevel >= 7 then -- Amateur
						end

						-----------------------------------------------
						-- Smithing Rank 8: Celestial Silver Items --
						-----------------------------------------------
						if smithingLevel >= 8 then -- Journeyman
							if makeDaggers == 1 then
								if player:hasItem("celestial_silver_ingot", 2) == true then
									table.insert(optsAnvil, "Celestial Silver Dagger")
								end
							end
							if makeSwords == 1 then
								if player:hasItem("celestial_silver_ingot", 4) == true then
									table.insert(optsAnvil, "Celestial Silver Sword")
								end
							end
							if makeBodyArmor == 1 then
								if player:hasItem("celestial_silver_ingot", 8) == true then
									table.insert(optsAnvil, "Celestial Silver Body Armor (M)")
								end
								if player:hasItem("celestial_silver_ingot", 8) == true then
									table.insert(optsAnvil, "Celestial Silver Body Armor (F)")
								end
							end
							if makeHelmet == 1 then
								if player:hasItem("celestial_silver_ingot", 6) == true then
									table.insert(optsAnvil, "Celestial Silver Helmet")
								end
							end
							if makeGloves == 1 then
								if player:hasItem("celestial_silver_ingot", 3) == true then
									table.insert(optsAnvil, "Celestial Silver Glove")
								end
							end
							if makeBoots == 1 then
								if player:hasItem("celestial_silver_ingot", 6) == true then
									table.insert(optsAnvil, "Celestial Silver Boots")
								end
							end
							if makeBelts == 1 then
								if player:hasItem("celestial_silver_ingot", 2) == true and player:hasItem("leather strap", 4) == true then
									table.insert(optsAnvil, "Celestial Silver Belt")
								end
							end
							if makeShields == 1 then
								if player:hasItem("celestial_silver_ingot", 4) == true and player:hasItem("wooden board", 4) == true then
									table.insert(optsAnvil, "Celestial Silver Shield")
								end
							end
						end

						----------------------------------------
						-- Smithing Rank 9: N/A --
						----------------------------------------
						if smithingLevel >= 9 then -- Adept
						end

						----------------------------------------
						-- Smithing Rank 10: Moranium Items --
						----------------------------------------
						if smithingLevel >= 10 then -- Skilled
							if makeDaggers == 1 then
								if player:hasItem("moranium_ingot", 2) == true then
									table.insert(optsAnvil, "Moranium Dagger")
								end
							end
							if makeSwords == 1 then
								if player:hasItem("moranium_ingot", 4) == true then
									table.insert(optsAnvil, "Moranium Sword")
								end
							end
							if makeBodyArmor == 1 then
								if player:hasItem("moranium_ingot", 8) == true then
									table.insert(optsAnvil, "Moranium Body Armor (M)")
								end
								if player:hasItem("moranium_ingot", 8) == true then
									table.insert(optsAnvil, "Moranium Body Armor (F)")
								end
							end
							if makeHelmet == 1 then
								if player:hasItem("moranium_ingot", 6) == true then
									table.insert(optsAnvil, "Moranium Helmet")
								end
							end
							if makeGloves == 1 then
								if player:hasItem("moranium_ingot", 3) == true then
									table.insert(optsAnvil, "Moranium Glove")
								end
							end
							if makeBoots == 1 then
								if player:hasItem("moranium_ingot", 6) == true then
									table.insert(optsAnvil, "Moranium Boots")
								end
							end
							if makeBelts == 1 then
								if player:hasItem("moranium_ingot", 2) == true and player:hasItem("leather strap", 4) == true then
									table.insert(optsAnvil, "Moranium Belt")
								end
							end
							if makeShields == 1 then
								if player:hasItem("moranium_ingot", 4) == true and player:hasItem("wooden board", 4) == true then
									table.insert(optsAnvil, "Moranium Shield")
								end
							end
						end

						----------------------------------------
						-- Smithing Rank 11: N/A --
						----------------------------------------
						if smithingLevel >= 11 then -- Expert
						end

						----------------------------------------
						-- Smithing Rank 12: Adamantium Items --
						----------------------------------------
						if smithingLevel >= 12 then -- Artisan
							if makeDaggers == 1 then
								if player:hasItem("admantium_ingot", 2) == true then
									table.insert(optsAnvil, "Admantium Dagger")
								end
							end
							if makeSwords == 1 then
								if player:hasItem("admantium_ingot", 4) == true then
									table.insert(optsAnvil, "Admantium Sword")
								end
							end
							if makeBodyArmor == 1 then
								if player:hasItem("admantium_ingot", 8) == true then
									table.insert(optsAnvil, "Admantium Body Armor (M)")
								end
								if player:hasItem("admantium_ingot", 8) == true then
									table.insert(optsAnvil, "Admantium Body Armor (F)")
								end
							end
							if makeHelmet == 1 then
								if player:hasItem("admantium_ingot", 6) == true then
									table.insert(optsAnvil, "Admantium Helmet")
								end
							end
							if makeGloves == 1 then
								if player:hasItem("admantium_ingot", 3) == true then
									table.insert(optsAnvil, "Admantium Glove")
								end
							end
							if makeBoots == 1 then
								if player:hasItem("admantium_ingot", 6) == true then
									table.insert(optsAnvil, "Admantium Boots")
								end
							end
							if makeBelts == 1 then
								if player:hasItem("admantium_ingot", 2) == true and player:hasItem("leather strap", 4) == true then
									table.insert(optsAnvil, "Admantium Belt")
								end
							end
							if makeShields == 1 then
								if player:hasItem("admantium_ingot", 4) == true and player:hasItem("wooden board", 4) == true then
									table.insert(optsAnvil, "Admantium Shield")
								end
							end
							if makePickAxe == 1 then
								if player:hasItem("admantium_ingot", 2) == true then
									table.insert(optsAnvil, "Admantium Pickaxe")
								end
							end
							if makeHerbCutter == 1 then
								if player:hasItem("admantium_ingot", 2) == true then
									table.insert(optsAnvil, "Admantium Herb Cutter")
								end
							end
						end

						----------------------------------------
						-- Smithing Rank 13: N/A --
						----------------------------------------
						if smithingLevel >= 13 then -- Prodigy
						end

						----------------------------------------
						-- Smithing Rank 14: Sky Iron Items --
						----------------------------------------
						if smithingLevel >= 14 then -- Virtuoso
							if makeDaggers == 1 then
								if player:hasItem("sky_iron_ingot", 2) == true then
									table.insert(optsAnvil, "Sky Iron Dagger")
								end
							end
							if makeSwords == 1 then
								if player:hasItem("sky_iron_ingot", 4) == true then
									table.insert(optsAnvil, "Sky Iron Sword")
								end
							end
							if makeBodyArmor == 1 then
								if player:hasItem("sky_iron_ingot", 8) == true then
									table.insert(optsAnvil, "Sky Iron Body Armor (M)")
								end
								if player:hasItem("sky_iron_ingot", 8) == true then
									table.insert(optsAnvil, "Sky Iron Body Armor (F)")
								end
							end
							if makeHelmet == 1 then
								if player:hasItem("sky_iron_ingot", 6) == true then
									table.insert(optsAnvil, "Sky Iron Helmet")
								end
							end
							if makeGloves == 1 then
								if player:hasItem("sky_iron_ingot", 3) == true then
									table.insert(optsAnvil, "Sky Iron Glove")
								end
							end
							if makeBoots == 1 then
								if player:hasItem("sky_iron_ingot", 6) == true then
									table.insert(optsAnvil, "Sky Iron Boots")
								end
							end
							if makeBelts == 1 then
								if player:hasItem("sky_iron_ingot", 2) == true and player:hasItem("leather strap", 4) == true then
									table.insert(optsAnvil, "Sky Iron Belt")
								end
							end
							if makeShields == 1 then
								if player:hasItem("sky_iron_ingot", 4) == true and player:hasItem("wooden board", 4) == true then
									table.insert(optsAnvil, "Sky Iron Shield")
								end
							end
						end

						----------------------------------------
						-- Smithing Rank 15: N/A --
						----------------------------------------
						if smithingLevel >= 15 then -- Master
						end

						----------------------------------------
						-- Smithing Rank 16: Irbynite Items --
						----------------------------------------
						if smithingLevel >= 16 then -- GrandMaster
							if makeDaggers == 1 then
								if player:hasItem("irbynite_ingot", 2) == true then
									table.insert(optsAnvil, "Irbynite Dagger")
								end
							end
							if makeSwords == 1 then
								if player:hasItem("irbynite_ingot", 4) == true then
									table.insert(optsAnvil, "Irbynite Sword")
								end
							end
							if makeBodyArmor == 1 then
								if player:hasItem("irbynite_ingot", 8) == true then
									table.insert(optsAnvil, "Irbynite Body Armor (M)")
								end
								if player:hasItem("irbynite_ingot", 8) == true then
									table.insert(optsAnvil, "Irbynite Body Armor (F)")
								end
							end
							if makeHelmet == 1 then
								if player:hasItem("irbynite_ingot", 6) == true then
									table.insert(optsAnvil, "Irbynite Helmet")
								end
							end
							if makeGloves == 1 then
								if player:hasItem("irbynite_ingot", 3) == true then
									table.insert(optsAnvil, "Irbynite Glove")
								end
							end
							if makeBoots == 1 then
								if player:hasItem("irbynite_ingot", 6) == true then
									table.insert(optsAnvil, "Irbynite Boots")
								end
							end
							if makeBelts == 1 then
								if player:hasItem("irbynite_ingot", 2) == true and player:hasItem("leather strap", 4) == true then
									table.insert(optsAnvil, "Irbynite Belt")
								end
							end
							if makeShields == 1 then
								if player:hasItem("irbynite_ingot", 4) == true and player:hasItem("wooden board", 4) == true then
									table.insert(optsAnvil, "Irbynite Shield")
								end
							end
						end

						table.insert(optsAnvil, "Leave")
						------------------------------------
						-- Display items to craft --
						------------------------------------
						anvilMenuOption = player:menuString("What item to smith?", optsAnvil)

						----------------------------------------
						-- Items listed by rank crafted  -------
						----------------------------------------
						--------------------------------------
						-- Smithing Rank 1: Copper Items --
						--------------------------------------
						if anvilMenuOption == "Copper Dagger" then
							skillEXP = 18
							craftingTime = 3000
							craftingItem01 = "copper_ingot"
							processCount = 2
							craftingItem02 = ""
							processCount2 = ""
							craftingItem03 = ""
							processCount3 = ""
							craftingItem04 = ""
							processCount4 = ""
							craftedItem = ""
							craftedItemName = "Copper Dagger"
							itemFailChance = 3
							baseQualityItemMod = 0
							fineQualityItemMod = 0
							superiorQualityItemMod = 0
						elseif anvilMenuOption == "Copper Pickaxe" then
							skillEXP = 18
							craftingTime = 3000
							craftingItem01 = "copper_ingot"
							processCount = 2
							craftingItem02 = ""
							processCount2 = ""
							craftingItem03 = ""
							processCount3 = ""
							craftingItem04 = ""
							processCount4 = ""
							craftedItem = "copper_pickaxe"
							craftedItemName = "Copper Pickaxe"
							itemFailChance = 3
							baseQualityItemMod = 0
							fineQualityItemMod = 0
							superiorQualityItemMod = 0
						elseif anvilMenuOption == "Copper Herb Cutter" then
							--------------------------------------
							-- Smithing Rank 2: Tin Items --
							--------------------------------------
							skillEXP = 18
							craftingTime = 3000
							craftingItem01 = "copper_ingot"
							processCount = 2
							craftingItem02 = ""
							processCount2 = ""
							craftingItem03 = ""
							processCount3 = ""
							craftingItem04 = ""
							processCount4 = ""
							craftedItem = "copper_herb_cutter"
							craftedItemName = "Copper Herb Cutter"
							itemFailChance = 3
							baseQualityItemMod = 0
							fineQualityItemMod = 0
							superiorQualityItemMod = 0
						elseif anvilMenuOption == "Tin Dagger" then
							skillEXP = 36
							craftingTime = 3000
							craftingItem01 = "tin_ingot"
							processCount = 2
							craftingItem02 = ""
							processCount2 = ""
							craftingItem03 = ""
							processCount3 = ""
							craftingItem04 = ""
							processCount4 = ""
							craftedItem = ""
							craftedItemName = "Tin Dagger"
							itemFailChance = 4
							baseQualityItemMod = 0
							fineQualityItemMod = 0
							superiorQualityItemMod = 0
						elseif anvilMenuOption == "Tin Sword" then
							--------------------------------------
							-- Smithing Rank 3: Bronze Items --
							--------------------------------------
							skillEXP = 72
							craftingTime = 4000
							craftingItem01 = "tin_ingot"
							processCount = 4
							craftingItem02 = ""
							processCount2 = ""
							craftingItem03 = ""
							processCount3 = ""
							craftingItem04 = ""
							processCount4 = ""
							craftedItem = ""
							craftedItemName = "Tin Sword"
							itemFailChance = 5
							baseQualityItemMod = 0
							fineQualityItemMod = 0
							superiorQualityItemMod = 0
						elseif anvilMenuOption == "Bronze Dagger" then
							skillEXP = 54
							craftingTime = 3000
							craftingItem01 = "bronze_ingot"
							processCount = 2
							craftingItem02 = ""
							processCount2 = ""
							craftingItem03 = ""
							processCount3 = ""
							craftingItem04 = ""
							processCount4 = ""
							craftedItem = ""
							craftedItemName = "Bronze dagger"
							itemFailChance = 4
							baseQualityItemMod = -3
							fineQualityItemMod = 2
							superiorQualityItemMod = 1
						elseif anvilMenuOption == "Bronze Sword" then
							skillEXP = 108
							craftingTime = 4000
							craftingItem01 = "bronze_ingot"
							processCount = 4
							craftingItem02 = ""
							processCount2 = ""
							craftingItem03 = ""
							processCount3 = ""
							craftingItem04 = ""
							processCount4 = ""
							craftedItem = ""
							craftedItemName = "Bronze Sword"
							itemFailChance = 5
							baseQualityItemMod = -3
							fineQualityItemMod = 2
							superiorQualityItemMod = 1
						elseif anvilMenuOption == "Bronze Body Armor (M)" then
							skillEXP = 216
							craftingTime = 8000
							craftingItem01 = "bronze_ingot"
							processCount = 8
							craftingItem02 = ""
							processCount2 = ""
							craftingItem03 = ""
							processCount3 = ""
							craftingItem04 = ""
							processCount4 = ""
							craftedItem = ""
							craftedItemName = "Bronze Body Armor (M)"
							itemFailChance = 6
							baseQualityItemMod = -3
							fineQualityItemMod = 2
							superiorQualityItemMod = 1
						elseif anvilMenuOption == "Bronze Body Armor (F)" then
							skillEXP = 216
							craftingTime = 8000
							craftingItem01 = "bronze_ingot"
							processCount = 8
							craftingItem02 = ""
							processCount2 = ""
							craftingItem03 = ""
							processCount3 = ""
							craftingItem04 = ""
							processCount4 = ""
							craftedItem = ""
							craftedItemName = "Bronze Body Armor (F)"
							itemFailChance = 6
							baseQualityItemMod = -3
							fineQualityItemMod = 2
							superiorQualityItemMod = 1
						elseif anvilMenuOption == "Bronze Helmet" then
							skillEXP = 162
							craftingTime = 6000
							craftingItem01 = "bronze_ingot"
							processCount = 6
							craftingItem02 = ""
							processCount2 = ""
							craftingItem03 = ""
							processCount3 = ""
							craftingItem04 = ""
							processCount4 = ""
							craftedItem = ""
							craftedItemName = "Bronze Helmet"
							itemFailChance = 6
							baseQualityItemMod = -3
							fineQualityItemMod = 2
							superiorQualityItemMod = 1
						elseif anvilMenuOption == "Bronze Glove" then
							skillEXP = 81
							craftingTime = 3000
							craftingItem01 = "bronze_ingot"
							processCount = 3
							craftingItem02 = ""
							processCount2 = ""
							craftingItem03 = ""
							processCount3 = ""
							craftingItem04 = ""
							processCount4 = ""
							craftedItem = ""
							craftedItemName = "Bronze Glove"
							itemFailChance = 6
							baseQualityItemMod = -3
							fineQualityItemMod = 2
							superiorQualityItemMod = 1
						elseif anvilMenuOption == "Bronze Boots" then
							--------------------------------------
							-- Smithing Rank 4: Orichalcum Items --
							--------------------------------------
							skillEXP = 162
							craftingTime = 6000
							craftingItem01 = "bronze_ingot"
							processCount = 6
							craftingItem02 = ""
							processCount2 = ""
							craftingItem03 = ""
							processCount3 = ""
							craftingItem04 = ""
							processCount4 = ""
							craftedItem = ""
							craftedItemName = "Bronze Boots"
							itemFailChance = 6
							baseQualityItemMod = -3
							fineQualityItemMod = 2
							superiorQualityItemMod = 1
						elseif anvilMenuOption == "Leave" then
							player:talkSelf(0, "I think I will do this at a later time...")
							return
						else
							player:talkSelf(0, "ERROR: Not a possible Menu selection!!") -- Error: Tool is not a Pestle.
							return
						end
						--player:talkSelf(0,"Item 01: "..craftingItem01)
						--player:talkSelf(0,"Item 02: "..craftingItem02)
						--player:talkSelf(0,"Item 03: "..craftingItem03)
						--player:talkSelf(0,"Item 04: "..craftingItem04)
						--player:talkSelf(0,"toolFailChance: "..toolFailChance)
						--player:talkSelf(0,"rankFailChance: "..rankFailChance)
						--player:talkSelf(0,"itemFailChance: "..itemFailChance)
						-- Calculate total failure chance ----------------------------------------------
						failChance = rankFailChance + itemFailChance + toolFailChance

						totalBaseQualityMod = baseQualityItemMod + baseQualityRankMod
						totalFineQualityMod = fineQualityItemMod + fineQualityRankMod
						totalSuperiorQualityMod = superiorQualityItemMod + superiorQualityRankMod

						finalBaseQuality = baseQualityChance + totalBaseQualityMod -- 85 - 15 = 70
						finalFineQuality = fineQualityChance + totalFineQualityMod + finalBaseQuality -- 10 + 10 = 20
						finalSuperiorQuality = superiorQualityChance + totalSuperiorQualityMod + finalFineQuality -- 5 + 5 = 10
						player:talkSelf(0, "finalBaseQuality: " .. finalBaseQuality)
						player:talkSelf(0, "finalFineQuality: " .. finalFineQuality)
						player:talkSelf(0, "finalSuperiorQuality: " .. finalSuperiorQuality)
						-- player:talkSelf(0,"failChance: "..failChance)
						if failChance <= 0 then
							failChance = 1
						end
						--------------
						-- Crafting --
						--------------
						failureRoll = math.random(1, 100)
						qualityRoll = math.random(1, 100)
						player:talkSelf(0, "qualityRoll: " .. qualityRoll)
						--	player:talkSelf(0, "failureRoll: "..failureRoll)

						if
							player:hasItem(craftingItem01, processCount) == true and craftingItem02 == "" and craftingItem03 == "" and
								craftingItem04 == ""
						 then
							player:sendAnimation(313) -- Display the spell graphic / animation for the skill
							player:removeItem(craftingItem01, processCount) -- Take away the item to be worked
							if failureRoll <= failChance then
								player:sendMinitext("I ruined this" .. craftedItemName)
								skillEXP = math.floor(skillEXP / 2)
								skill.leveling(player, skillEXP, ability)
								return
							end
							skill.leveling(player, skillEXP, ability) -- Give XP to Skill
							player:setDuration("smithing", craftingTime)
							if qualityRoll <= finalBaseQuality then
								player:addItem(craftedItem, 1) -- and the items(s) produced
								player:talkSelf(2, "I have made a " .. craftedItemName)
							elseif qualityRoll > finalBaseQuality and qualityRoll <= finalFineQuality then
								player:addItem(craftedItem .. "_fine", 1) -- and the items(s) produced
								player:talkSelf(2, "I have made a " .. craftedItemName .. "(+)")
							elseif qualityRoll > finalFineQuality and qualityRoll <= finalSuperiorQuality then
								player:addItem(craftedItem .. "_superior", 1) -- and the items(s) produced
								player:talkSelf(2, "I have made a " .. craftedItemName .. "(++)")
							else
							end
						elseif
							player:hasItem(craftingItem01, processCount) == true and player:hasItem(craftingItem02, processCount2) == true and
								craftingItem03 == "" and
								craftingItem04 == ""
						 then
							player:sendAnimation(313) -- Display the spell graphic / animation for the skill
							player:removeItem(craftingItem01, processCount) -- Take away the item to be worked
							player:removeItem(craftingItem02, processCount2) -- Take away the item to be worked
							if failureRoll <= failChance then
								player:sendMinitext("I ruined this" .. craftedItemName)
								skillEXP = math.floor(skillEXP / 2)
								skill.leveling(player, skillEXP, ability)
								return
							end
							skill.leveling(player, skillEXP, ability) -- Give XP to Skill
							player:setDuration("smithing", craftingTime)
							player:addItem(craftedItem, 1) -- and the items(s) produced
							player:talkSelf(2, "I have made a " .. craftedItemName)
						elseif
							player:hasItem(craftingItem01, processCount) == true and player:hasItem(craftingItem02, processCount2) == true and
								player:hasItem(craftingItem03, processCount3) == true and
								craftingItem04 == ""
						 then
							player:sendAnimation(313) -- Display the spell graphic / animation for the skill
							player:removeItem(craftingItem01, processCount) -- Take away the item to be worked
							player:removeItem(craftingItem02, processCount2) -- Take away the item to be worked
							player:removeItem(craftingItem03, processCount3) -- Take away the item to be worked
							if failureRoll <= failChance then
								player:sendMinitext("I ruined this" .. craftedItemName)
								skillEXP = math.floor(skillEXP / 2)
								skill.leveling(player, skillEXP, ability)
								return
							end
							skill.leveling(player, skillEXP, ability) -- Give XP to Skill
							player:setDuration("smithing", craftingTime, player.ID)
							player:addItem(craftedItem, 1) -- and the items(s) produced
							player:talkSelf(2, "I have made a " .. craftedItemName)
						elseif
							player:hasItem(craftingItem01, processCount) == true and player:hasItem(craftingItem02, processCount2) == true and
								player:hasItem(craftingItem03, processCount3) == true and
								player:hasItem(craftingItem04, processCount4) == true
						 then
							player:sendAnimation(313) -- Display the spell graphic / animation for the skill
							player:removeItem(craftingItem01, processCount) -- Take away the item to be worked
							player:removeItem(craftingItem02, processCount2) -- Take away the item to be worked
							player:removeItem(craftingItem03, processCount3) -- Take away the item to be worked
							player:removeItem(craftingItem03, processCount4) -- Take away the item to be worked
							if failureRoll <= failChance then
								player:sendMinitext("I ruined this" .. craftedItemName)
								skillEXP = math.floor(skillEXP / 2)
								skill.leveling(player, skillEXP, ability)
								return
							end
							skill.leveling(player, skillEXP, ability) -- Give XP to Skill
							player:setDuration("smithing", craftingTime, player.ID)
							player:addItem(craftedItem, 1) -- and the items(s) produced
							player:talkSelf(2, "I have made a " .. craftedItemName)
						else
							player:talkSelf(0, "I don't have everything I need on me!")
							return
						end
					else
						player:sendMinitext("I don't have everything I need on me!")
						return
					end

					return
				end
			end
		 -- Face the anvil
		end
	)
}
