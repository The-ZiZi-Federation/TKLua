-------------------------------------------------------
--   Ability: Herb Pulverization
--      Tool: Mortar
--  Job Type: Refining
--     Desc.: Crush herbs into powder.
-------------------------------------------------------
-- Script Author: John Crandell
--   Last Edited: 11/25/2016
-------------------------------------------------------
mortar = {
	use = function(player)
		player:freeAsync()
		player.lastClick = player.ID
		mortar.click(player)
	end,
	click = async(
		function(player, npc)
			----------------------------
			-- Local Variable Declare --
			----------------------------
			local mortarImage = {graphic = convertGraphic(830, "monster"), color = 0}
			player.npcGraphic = mortarImage.graphic
			player.npcColor = mortarImage.color
			player.dialogType = 0
			local ability = "pulverization"
			local pulverizeLevel = player.registry["pulverization_level"]
			local mortarObj = getObjFacing(player, player.side)
			local tool = player:getEquippedItem(EQ_WEAP)

			local optsMortar = {}
			local mortarMenuOption
			local mapNum = player.m

			local processCount
			local numberPowder
			local rankBonusPowder
			local toolBonusPowder
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
	- Basic Pestle:    3631
	- Qualty Pestle:   3632
	- Superior Pestle: 3633
	- Artisan Pestle:  3634
	-
	-
	-
	-
	-
	-
	-
	-
	-
	]] -- Is the player already pulverizing??

			if player:hasDuration("pulverizing") then
				return
			end
			-- Does the player know pulverization??
			if player.registry["learned_pulverization"] < 1 then
				player:talkSelf(0, "I don't know how to use this!")
				return
			end

			if pulverizeLevel > 0 then
				-- You are facing a Mortar
				if
					mortarObj == 7606 or mortarObj == 17509 or mortarObj == 17510 or mortarObj == 19209 or mortarObj == 18551 or
						mortarObj == 13964
				 then
					-- You have a tool in hand
					if tool ~= nil then
						-- The tool is a Pestle of some sort.
						if tool.id >= 3631 and tool.id < 3635 then
							------------------
							-- End Crafting --
							------------------
							-------------------------------------------------
							-- Increase reward based quality of Pestle     --
							-------------------------------------------------
							if tool.id == 3631 then
								toolBonusPowder = math.random(1, 1)
								toolFailChance = 7
							elseif tool.id == 3632 then
								toolBonusPowder = math.random(1, 2)
								toolFailChance = 6
							elseif tool.id == 3633 then
								toolBonusPowder = math.random(2, 2)
								toolFailChance = 5
							elseif tool.id == 3634 then
								toolBonusPowder = math.random(1, 2) + 1
								toolFailChance = 3
							else
								return
							end

							-------------------------------------------------
							-- Increase reward based on Pulverization rank --
							-------------------------------------------------
							if pulverizeLevel > 0 and pulverizeLevel <= 3 then
								rankBonusPowder = 0
								rankFailChance = 10
							elseif pulverizeLevel > 3 and pulverizeLevel <= 5 then
								rankBonusPowder = 0
								rankFailChance = 7
							elseif pulverizeLevel > 5 and pulverizeLevel <= 8 then
								rankBonusPowder = 0
								rankFailChance = 4
							elseif pulverizeLevel > 8 and pulverizeLevel <= 12 then
								rankBonusPowder = 1
								rankFailChance = 0
							elseif pulverizeLevel > 12 then
								rankBonusPowder = 2
								rankFailChance = -5
							else
								return
							end

							numberPowder = toolBonusPowder + rankBonusPowder

							-------------------------------------------
							-- What herbs can be processed by rank ----
							-- And then by what in the inventory ------
							-- Build the list -------------------------
							-------------------------------------------
							if pulverizeLevel >= 1 then -- Novice
								if player:hasItem("sanguine_flower", 1) == true then
									table.insert(optsMortar, "Sanguine Powder")
									processCount = 1
								end
								if player:hasItem("cobalt_flower", 1) == true then
									table.insert(optsMortar, "Cobalt Powder")
									processCount = 1
								end
							end
							if pulverizeLevel >= 2 then -- Apprentice
							end
							if pulverizeLevel >= 3 then -- Amature
								if player:hasItem("brown_mushroom_cap", 1) == true then
									table.insert(optsMortar, "Mushroom Enhancer")
									processCount = 1
								end
								if player:hasItem("violet_flower", 1) == true then
									table.insert(optsMortar, "Violet Powder")
									processCount = 1
								end
							end
							if pulverizeLevel >= 4 then -- Journeyman
								if player:hasItem("enhancing_leaves", 1) == true then
									table.insert(optsMortar, "Enhancing Powder")
									processCount = 1
								end
								if player:hasItem("sophoric_flower", 1) == true then
									table.insert(optsMortar, "Sophoric Powder")
									processCount = 1
								end
							end
							if pulverizeLevel >= 5 then -- Hard-Working
								if player:hasItem("draining_flower", 1) == true then
									table.insert(optsMortar, "Draining Powder")
									processCount = 1
								end
							end
							if pulverizeLevel >= 6 then -- Expert
								if player:hasItem("stupifying_flower", 1) == true then
									table.insert(optsMortar, "Stupifying Powder")
									processCount = 1
								end
							end
							if pulverizeLevel >= 7 then -- Artisan
								if player:hasItem("empowering_flower", 1) == true then
									table.insert(optsMortar, "Empowering Powder")
									processCount = 1
								end
							end
							if pulverizeLevel >= 8 then -- Superior
								if player:hasItem("brutish_flower", 1) == true then
									table.insert(optsMortar, "Brutish Powder`")
									processCount = 1
								end
							end
							if pulverizeLevel >= 9 then -- Master and Grand Master
								if player:hasItem("dancing_flower", 1) == true then
									table.insert(optsMortar, "Dancing Powder")
									processCount = 1
								end
							end
							if pulverizeLevel >= 0 then
								table.insert(optsMortar, "Leave")
							end

							--player:talkSelf(0, "processCount: "..processCount)

							------------------------------------
							-- Display Herbs to Be Pulverized --
							------------------------------------
							mortarMenuOption = player:menuString("What powder are you crafting?", optsMortar)

							----------------------------------------
							-- Check your selection ----------------
							---------------------------------------
							if mortarMenuOption == "Sanguine Powder" then
								skillEXP = 5
								craftingItem = "sanguine_flower"
								craftingItemName = "Sanguine Flower"
								craftedItem = "sanguine_powder"
								craftedItemName = "Sanguine Powder"
								powderFailChance = 3
							elseif mortarMenuOption == "Cobalt Powder" then
								skillEXP = 23
								craftingItem = "cobalt_flower"
								craftingItemName = "Cobalt Flower"
								craftedItem = "cobalt_powder"
								craftedItemName = "Cobalt Powder"
								powderFailChance = 3
							elseif mortarMenuOption == "Mushroom Enhancer" then
								skillEXP = 45
								craftingItem = "brown_mushroom_cap"
								craftingItemName = "Brown Mushroom Cap"
								craftedItem = "mushroom_enhancer"
								craftedItemName = "Mushroom Enhancer"
								powderFailChance = 5
							elseif mortarMenuOption == "Violet Powder" then
								skillEXP = 45
								craftingItem = "violet_flower"
								craftingItemName = "Violet Flower"
								craftedItem = "violet_powder"
								craftedItemName = "Violet Powder"
								powderFailChance = 6
							elseif mortarMenuOption == "Enhancing Powder" then
								skillEXP = 83
								craftingItem = "enhancing_leaves"
								craftingItemName = "Enhancing Leaves"
								craftedItem = "enhancing_powder"
								craftedItemName = "Enhancing Powder"
								powderFailChance = 7
							elseif mortarMenuOption == "Sophoric Powder" then
								skillEXP = 83
								craftingItem = "sophoric_flower"
								craftingItemName = "Sophoric Flower"
								craftedItem = "sophoric_powder"
								craftedItemName = "Sleep Powder"
								powderFailChance = 8
							elseif mortarMenuOption == "Draining Powder" then
								skillEXP = 225
								craftingItem = "draining_flower"
								craftingItemName = "Draining Flower"
								craftedItem = "draining_powder"
								craftedItemName = "Weakening Powder"
								powderFailChance = 9
							elseif mortarMenuOption == "Stupifying Powder" then
								skillEXP = 600
								craftingItem = "stupifying_flower"
								craftingItemName = "Stupifying Flower"
								craftedItem = "stupifying_powder"
								craftedItemName = "Stupifying Powder"
								powderFailChance = 10
							elseif mortarMenuOption == "Empowering Powder" then
								skillEXP = 1200
								craftingItem = "empowering_flower"
								craftingItemName = "Empowering Flower"
								craftedItem = "empowering_powder"
								craftedItemName = "Empowering Powder"
								powderFailChance = 10
							elseif mortarMenuOption == "Brutish Powder" then
								skillEXP = 2250
								craftingItem = "brutish_flower"
								craftingItemName = "Brutish Flower"
								craftedItem = "brutish_powder"
								craftedItemName = "Brutish Powder"
								powderFailChance = 12
							elseif mortarMenuOption == "Dancing Powder" then
								skillEXP = 6750
								craftingItem = "dancing_flower"
								craftingItemName = "Dancing Flower"
								craftedItem = "dancing_powder"
								craftedItemName = "Nimble Powder"
								powderFailChance = 15
							elseif mortarMenuOption == "Leave" then
								player:talkSelf(0, "I think I will do this at a later time...")
								return
							else
								player:talkSelf(0, "ERROR: Not a possible Menu selection!!") -- Error: Tool is not a Pestle.
								return
							end

							-- Calculate total failure chance ----------------------------------------------
							failChance = toolFailChance + rankFailChance + powderFailChance

							--player:talkSelf(0, "failChance: "..failChance)

							if failChance <= 0 then
								failChance = 1
							end
							--------------
							-- Crafting --
							--------------
							failureRoll = math.random(1, 100)

							--player:talkSelf(0, "failureRoll: "..failureRoll)

							if failureRoll <= failChance then
								player:sendMinitext("I ruined this powder!!")
								skillEXP = math.floor(skillEXP / 2)
								skill.leveling(player, skillEXP, ability)
								return
							end

							if player:hasItem(craftingItem, processCount) == true then -- Process each item individually, give XP and reward for each.
								player:sendAnimation(313)
								--player:sendAnimation(559)
								player:setDuration("pulverizing", 2000) -- Display the spell graphic / animation for the skill
								player:removeItem(craftingItem, processCount) -- Take away the item to be worked
								skill.leveling(player, skillEXP, ability) -- Give XP to Skill
								onGetExp2(player, skillEXP)
								-- throw in that duration function.
								player:deductDura(EQ_WEAP, duraloss) -- Damage tool for Dura Loss.
								player:addItem(craftedItem, numberPowder) -- and the items(s) produced

								if numberPowder == 1 then -- Display message showing what was created
									player:sendMinitext("I have made a " .. craftedItemName)
								elseif numberPowder > 1 then
									player:sendMinitext("I have made " .. numberPowder .. " " .. craftedItemName .. "s.")
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
						player:talkSelf(0, "I need to have a Pestle equipped!") -- You have nothing equipped!!!
						return
					end
				else
					return -- Not in Front of a Mortar
				end
			else
				player:talkSelf(0, "I don't know how to use this thing!!")
			end
		end
	) -- End of Function.
}
