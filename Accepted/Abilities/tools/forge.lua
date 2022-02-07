-------------------------------------------------------
--   Ability: Ore Smelting
--      Tool: Furnace
--  Job Type: Refining
--     Desc.: Refine Ores into Ignots
-------------------------------------------------------
-- Script Author: John Crandell
--   Last Edited: 11/25/2016
-------------------------------------------------------
furnace = {
	use = function(player)
		player:freeAsync()
		player.lastClick = player.ID
		furnace.click(player)
	end,
	click = async(
		function(player, npc)
			----------------------------
			-- Local Variable Declare --
			----------------------------
			local furnaceImage = {graphic = convertGraphic(830, "monster"), color = 0} --change gfx to forge
			player.npcGraphic = furnaceImage.graphic
			player.npcColor = furnaceImage.color
			player.dialogType = 0
			local ability = "smelting"
			local smeltingLevel = player.registry["smelting_level"]
			if player.gmLevel > 0 then
				smeltingLevel = 15
			end
			local furnaceObj = getObjFacing(player, player.side)
			local tool = player:getEquippedItem(EQ_WEAP)

			local optsFurnace = {}
			local furnaceMenuOption
			local mapNum = player.m

			local processCount
			local numberIgnot
			local rankBonusIgnot
			local toolBonusIgnot
			local duraloss = 5
			local skillEXP
			local addItem

			local failChance
			local toolFailChance
			local rankFailChance
			local powderFailChance
			 --
			--------------------------------------------------------------------
			-- You pressed "O" in front of the Mortar on -----------------------
			-- the Alchemist's Hut map (MapID 10 or Crafter's Have (MapID 11) --
			--------------------------------------------------------------------

			--[[ Tools Listing ------------
	- Basic Crucible Tongs:    4081
	- Quality Crucible Tongs:  4082
	- Superior Crucible Tongs: 4083
	- Artisan Crucible Tongs:  4084
	]] --------------------------------------------------------------------
			-- You pressed "O" in front of the Furnace on -----------------------
			-- the Alchemist's Hut map (MapID 10 or Crafter's Have (MapID 11) --
			--------------------------------------------------------------------
			if player:hasDuration("smelting") then
				return
			end

			if player.registry["learned_smelting"] < 1 then
				player:talkSelf(0, "I don't know how to use this!")
				return
			end

			if smeltingLevel > 0 then
				-- need to edit these numbers please.
				-- You are facing a Furnace
				if furnaceObj == 696 or furnaceObj == 697 then
					-- You have a tool in hand
					if tool ~= nil then
						-- The tool is a Pestle of some sort.
						if tool.id >= 4081 and tool.id < 4085 then
							------------------
							-- End Crafting --
							------------------
							-------------------------------------------------
							-- Increase reward based quality of Pestle     --
							-------------------------------------------------
							if tool.id == 4081 then
								toolBonusIgnot = math.random(1, 1)
								toolFailChance = 7
							elseif tool.id == 4082 then
								toolBonusIgnot = math.random(1, 2)
								toolFailChance = 6
							elseif tool.id == 4083 then
								toolBonusIgnot = math.random(2, 2)
								toolFailChance = 5
							elseif tool.id == 4084 then
								toolBonusIgnot = math.random(1, 2) + 1
								toolFailChance = 3
							else
								return
							end

							-------------------------------------------------
							-- Increase reward based on Smelting rank --
							-------------------------------------------------
							if smeltingLevel > 0 and smeltingLevel <= 3 then
								rankBonusIgnot = 0
								rankFailChance = 10
							elseif smeltingLevel > 3 and smeltingLevel <= 5 then
								rankBonusIgnot = 0
								rankFailChance = 7
							elseif smeltingLevel > 5 and smeltingLevel <= 8 then
								rankBonusIgnot = 0
								rankFailChance = 4
							elseif smeltingLevel > 8 and smeltingLevel <= 12 then
								rankBonusIgnot = 1
								rankFailChance = 0
							elseif smeltingLevel > 12 then
								rankBonusIgnot = 2
								rankFailChance = -5
							else
								return
							end

							numberIgnot = toolBonusIgnot + rankBonusIgnot

							-------------------------------------------
							-- What ores can be processed by rank ----
							-- And then by what in the inventory ------
							-- Build the list -------------------------
							-------------------------------------------
							if smeltingLevel >= 1 then -- Beginner
								if player:hasItem("coal_ore", 1) == true then
									table.insert(optsFurnace, "Coke")
								end
								if player:hasItem("copper_ore", 1) == true then
									table.insert(optsFurnace, "Copper Ingot")
								end
							end
							if smeltingLevel >= 2 then -- Novice
							end
							if smeltingLevel >= 3 then -- Trainee
								if player:hasItem("tin_ore", 1) == true then
									table.insert(optsFurnace, "Tin Ingot")
								end
								if player:hasItem("tin_ingot", 1) == true and player:hasItem("copper_ingot", 1) == true then
									table.insert(optsFurnace, "Bronze Ingot")
								end
							end
							if smeltingLevel >= 4 then -- Apprentice
								if player:hasItem("orichalcum_ore", 1) == true then
									table.insert(optsFurnace, "Orichalcum Ingot")
								end
							end
							if smeltingLevel >= 5 then -- Greenhorn
								if player:hasItem("iron_ore", 2) == true then
									table.insert(optsFurnace, "Iron Ingot")
								end
							end
							if smeltingLevel >= 6 then -- Aspirant
								if player:hasItem("coke", 1) == true and player:hasItem("iron_ingot", 1) == true then
									table.insert(optsFurnace, "Steel Ingot")
								end
							end
							if smeltingLevel >= 7 then -- Amateur
								if player:hasItem("celestial_silver_ore", 2) == true then
									table.insert(optsFurnace, "Celestial Silver Ingot")
								end
							end
							if smeltingLevel >= 8 then -- Journeyman
								if player:hasItem("mornanium_ore", 2) == true then
									table.insert(optsFurnace, "Mornanium Ingot")
								end
							end
							if smeltingLevel >= 9 then -- Adept
								if player:hasItem("celestial_silver_ingot", 2) == true and player:hasItem("moranium_ingot", 2) == true then
									table.insert(optsFurnace, "Mythril Ingot")
								end
							end
							if smeltingLevel >= 10 then -- Skilled
								if player:hasItem("admantium_ore", 2) == true then
									table.insert(optsFurnace, "Admantium Ingot")
								end
							end
							if smeltingLevel >= 11 then -- Expert
								if player:hasItem("rosantium_ore", 2) == true then
									table.insert(optsFurnace, "Rosantium Ingot")
								end
							end
							if smeltingLevel >= 12 then -- Artisan
							end
							if smeltingLevel >= 13 then -- Prodigy
								if player:hasItem("sky_iron_ore", 2) == true then
									table.insert(optsFurnace, "Sky Iron Ingot")
								end
							end
							if smeltingLevel >= 14 then -- Virtuoso
								if player:hasItem("irbynite_ore", 3) == true then
									table.insert(optsFurnace, "Irbynite Ingot")
									processCount = 3
								end
							end
							if smeltingLevel >= 15 then -- Master
								if player:hasItem("duranium_ore", 3) == true then
									table.insert(optsFurnace, "Duranium Ingot")
									processCount = 3
								end
							end
							if smeltingLevel >= 16 then -- GrandMaster
								if player:hasItem("irbynite_ingot", 3) == true and player:hasItem("duranium_ingot", 3) == true then
									table.insert(optsFurnace, "Supremium Ingot")
									processCount = 3
								end
							end
							if smeltingLevel >= 0 then
								table.insert(optsFurnace, "Leave")
							end

							------------------------------------
							-- Display Herbs to Be Pulverized --
							------------------------------------
							furnaceMenuOption = player:menuString("What Ignot do you wish to make?", optsFurnace)

							----------------------------------------
							-- Check your selection ----------------
							---------------------------------------
							if furnaceMenuOption == "Coke" then
								skillEXP = 6
								craftingItem = "coal_ore"
								craftingItemName = "Coal Ore"
								processCount = 1
								craftingItem02 = ""
								craftingItemName02 = ""
								processCount2 = 0
								craftedItem = "coke"
								craftedItemName = "Coke"
							elseif furnaceMenuOption == "Copper Ingot" then
								skillEXP = 6
								craftingItem = "copper_ore"
								craftingItemName = "Copper Ore"
								processCount = 1
								craftingItem02 = ""
								craftingItemName02 = ""
								processCount2 = 0
								craftedItem = "copper_ingot"
								craftedItemName = "Copper Ingot"
							elseif furnaceMenuOption == "Tin Ingot" then
								skillEXP = 18
								craftingItem = "tin_ore"
								craftingItemName = "Tin Ore"
								processCount = 1
								craftingItem02 = ""
								craftingItemName02 = ""
								processCount2 = 0
								craftedItem = "tin_ingot"
								craftedItemName = "Tin Ingot"
							elseif furnaceMenuOption == "Bronze Ingot" then
								skillEXP = 36
								craftingItem = "tin_ingot"
								craftingItemName = "Tin Ingot"
								processCount = 1
								craftingItem02 = "copper_ingot"
								craftingItemName02 = "Copper Ingot"
								processCount2 = 1
								craftedItem = "bronze_ingot"
								craftedItemName = "Bronze Ingot"
							elseif furnaceMenuOption == "Orichalcum Ingot" then
								skillEXP = 45
								craftingItem = "orichalcum_ore"
								craftingItemName = "Orichalcum Ore"
								processCount = 1
								craftingItem02 = ""
								craftingItemName02 = ""
								processCount2 = 0
								craftedItem = "orichalcum_ingot"
								craftedItemName = "Orichalcum Ingot"
							elseif furnaceMenuOption == "Iron Ingot" then
								skillEXP = 68
								craftingItem = "iron_ore"
								craftingItemName = "Iron Ore"
								processCount = 1
								craftingItem02 = ""
								craftingItemName02 = ""
								processCount2 = 0
								craftedItem = "iron_ingot"
								craftedItemName = "Iron Ingot"
							elseif furnaceMenuOption == "Steel Ingot" then
								skillEXP = 180
								craftingItem = "coke"
								craftingItemName = "Coke"
								processCount = 1
								craftingItem02 = "iron_ingot"
								craftingItemName02 = "Iron Ingot"
								processCount2 = 1
								craftedItem = "steel_ingot"
								craftedItemName = "Steel Ingot"
							elseif furnaceMenuOption == "Celestial Silver Ingot" then
								skillEXP = 113
								craftingItem = "celestial_silver_ore"
								craftingItemName = "Celestial Silver Ore"
								processCount = 2
								craftingItem02 = ""
								craftingItemName02 = ""
								processCount2 = 0
								craftedItem = "celestial_silver_ingot"
								craftedItemName = "Celestial Silver Ingot"
							elseif furnaceMenuOption == "Mornanium Ingot" then
								skillEXP = 135
								craftingItem = "mornanium_ore"
								craftingItemName = "Mornanium Ore"
								processCount = 2
								craftingItem02 = ""
								craftingItemName02 = ""
								processCount2 = 0
								craftedItem = "moranium_ingot"
								craftedItemName = "Moranium Ingot"
							elseif furnaceMenuOption == "Mythril Ingot" then
								skillEXP = 270
								craftingItem = "celestial_silver_ingot"
								craftingItemName = "Celestial Silver Ingot"
								processCount = 2
								craftingItem02 = "moranium_ingot"
								craftingItemName02 = "Moranium Ingot"
								processCount2 = 2
								craftedItem = "mythril_ingot"
								craftedItemName = "Mythril Ingot"
							elseif furnaceMenuOption == "Admantium Ingot" then
								skillEXP = 375
								craftingItem = "admantium_ore"
								craftingItemName = "Admantium Ore"
								processCount = 2
								craftingItem02 = ""
								craftingItemName02 = ""
								processCount2 = 0
								craftedItem = "admantium_ingot"
								craftedItemName = "Admantium Ingot"
							elseif furnaceMenuOption == "Rosantium Ingot" then
								skillEXP = 600
								craftingItem = "rosantium_ore"
								craftingItemName = "Rosantium Ore"
								processCount = 2
								craftingItem02 = ""
								craftingItemName02 = ""
								processCount2 = 0
								craftedItem = "rosantium_ingot"
								craftedItemName = "Rosantium Ingot"
							elseif furnaceMenuOption == "Sky Iron Ingot" then
								skillEXP = 1200
								craftingItem = "sky_iron_ore"
								craftingItemName = "Sky Iron Ore"
								processCount = 2
								craftingItem02 = ""
								craftingItemName02 = ""
								processCount2 = 0
								craftedItem = "sky_iron_ingot"
								craftedItemName = "Sky Iron Ingot"
							elseif furnaceMenuOption == "Irbynite Ingot" then
								skillEXP = 1800
								craftingItem = "irbynite_ore"
								craftingItemName = "Irbynite Ore"
								processCount = 3
								craftingItem02 = ""
								craftingItemName02 = ""
								processCount2 = 0
								craftedItem = "irbynite_ingot"
								craftedItemName = "Irbynite Ingot"
							elseif furnaceMenuOption == "Duranium Ingot" then
								skillEXP = 2250
								craftingItem = "duranium_ore"
								craftingItemName = "Duranium Ore"
								processCount = 3
								craftingItem02 = ""
								craftingItemName02 = ""
								processCount2 = 0
								craftedItem = "duranium_ingot"
								craftedItemName = "Duranium Ingot"
							elseif furnaceMenuOption == "Supremium Ingot" then
								skillEXP = 6750
								craftingItem = "sky_iron_ingot"
								craftingItemName = "Sky Iron Ingot"
								processCount = 3
								craftingItem02 = "duranium_ingot"
								craftingItemName02 = "Duranium Ingot"
								processCount2 = 3
								craftedItem = "supremium_ingot"
								craftedItemName = "Supremium Ingot"
							elseif furnaceMenuOption == "Leave" then
								player:talkSelf(0, "I think I will do this at a later time...")
								return
							else
								player:talkSelf(0, "ERROR: Not a possible Menu selection!!") -- Error: Tool is not a Pestle.
								return
							end

							--------------
							-- Crafting --
							--------------
							if player:hasItem(craftingItem, processCount) == true and processCount2 == 0 then -- Process each item individually, give XP and reward for each.
								player:sendAnimation(312)
								player:setDuration("smelting", 2000) -- Display the spell graphic / animation for the skill
								player:removeItem(craftingItem, processCount) -- Take away the item to be worked
								skill.leveling(player, skillEXP, ability) -- Give XP to Skill
								onGetExp2(player, skillEXP)
								player:deductDura(EQ_WEAP, duraloss) -- Damage tool for Dura Loss.
								player:addItem(craftedItem, numberIgnot) -- and the items(s) produced

								if numberIgnot == 1 then -- Display message showing what was created
									player:sendMinitext("I have made a " .. craftedItemName)
								elseif numberIgnot > 1 then
									player:sendMinitext("I have made " .. numberIgnot .. " " .. craftedItemName .. "s.")
								end
							elseif
								player:hasItem(craftingItem, processCount) == true and player:hasItem(craftingItem02, processCount2) == true
							 then -- Process each item individually, give XP and reward for each.
								player:sendAnimation(312)
								player:setDuration("smelting", 3000) -- Display the spell graphic / animation for the skill
								player:removeItem(craftingItem, processCount) -- Take away the item to be worked
								player:removeItem(craftingItem02, processCount2) -- Take away the item to be worked
								skill.leveling(player, skillEXP, ability) -- Give XP to Skill
								onGetExp2(player, skillEXP)
								player:deductDura(EQ_WEAP, duraloss) -- Damage tool for Dura Loss.
								player:addItem(craftedItem, numberIgnot) -- and the items(s) produced

								if numberIgnot == 1 then -- Display message showing what was created
									player:sendMinitext("I have made a " .. craftedItemName)
								elseif numberIgnot > 1 then
									player:sendMinitext("I have made " .. numberIgnot .. " " .. craftedItemName .. "s.")
								end
							else -- The player does not have the item on them.
								player:talkSelf(0, "I don't have any " .. craftingItemName .. " on me!")
								return
							end
						else
							player:talkSelf(0, "I need to have the proper tool equipped!") -- You did not have a Pestle equipped
							return
						end
					else
						player:talkSelf(0, "I need to have smelting tongs equipped!") -- You have nothing equipped!!!
						return
					end
				else
					return -- Not in Front of a Furnace
				end
			else
				player:talkSelf(0, "I don't know how to use this thing!!")
			end
		end
	) -- End of Function.
}
