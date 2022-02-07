-------------------------------------------------------
--   Ability: Potion Concoction
--      Tool: Potion Stand
--  Job Type: Production
--     Desc.: Make many different types of potion.
-------------------------------------------------------
-- Script Author: John Crandell
--   Last Edited: 11/25/2016
-------------------------------------------------------

potionStand = {
	use = function(player)
		player:freeAsync()
		player.lastClick = player.ID
		potionStand.click(player)
	end,
	click = async(
		function(player, npc)
			--	local potionStandImage
			--	player.npcGraphic = potionStandImage.graphic-
			--	player.npcColor = potionStandImage.color
			--	player.dialogType = 0
			----------------------------
			-- Local Variable Declare --
			----------------------------
			local ability = "concocting"
			local concoctingLevel = player.registry["concocting_level"]
			local potionStandObj = getObjFacing(player, player.side)
			local tool = player:getEquippedItem(EQ_WEAP)

			local optsPotionStand = {}
			local potionStandImage
			local potionStandMenuOption
			local mapNum = player.m

			local makeVita = player.registry["vita_potion_knowledge"]
			local makeMana = player.registry["mana_potion_knowledge"]
			local makeScourge = player.registry["scouge_potion_knowledge"]
			local makeSophoric = player.registry["sophoric_potion_knowledge"]
			local makeDraining = player.registry["draining_potion_knowledge"]
			local makeStupifying = player.registry["stupifying_potion_knowledge"]
			local makeEmpowering = player.registry["empowering_potion_knowledge"]
			local makeBrutish = player.registry["brutish_potion_knowledge"]
			local makeNimble = player.registry["nimble_potion_knowledge"]

			local processCount
			local numberPotions
			local rankBonusPotions
			local skillEXP
			local addItem

			local failChance
			local rankFailChance
			local potionFailChance

			-- Set these for testing purposes.
			--	makeVita = 1
			--	makeMana = 1
			--	makeScourge = 1
			--	makeSophoric = 1
			--	makeDraining = 1
			--	makeStupifying = 1
			--	makeEmpowering = 1
			--	makeBrutish = 1
			--	makeNimble = 1
			--	concoctingLevel = 15
			--------------------------------------------------------------------
			-- You pressed "O" in front of the Potion Stand on -----------------
			-- the Alchemist's Hut map (MapID 10 or Crafter's Have (MapID 11) --
			--------------------------------------------------------------------

			-- You are facing a Mortar
			if player:hasDuration("concocting") then
				return
			end

			if player.registry["learned_concocting"] < 1 then
				player:talkSelf(0, "I don't know how to use this!")
				return
			end

			if potionStandObj == 13593 or potionStandObj == 13523 then
				-- You need to be empty handed
				if tool == nil then
					------------------
					-- End Crafting --
					------------------
					-------------------------------------------------
					-- Increase reward based on Concoting rank     --
					-------------------------------------------------
					if concoctingLevel > 0 and concoctingLevel <= 3 then
						rankBonusPotions = math.random(1, 1)
						rankFailChance = 10
					elseif concoctingLevel > 3 and concoctingLevel <= 5 then
						rankBonusPotions = math.random(1, 1)
						rankFailChance = 7
					elseif concoctingLevel > 5 and concoctingLevel <= 8 then
						rankBonusPotions = math.random(1, 1)
						rankFailChance = 4
					elseif concoctingLevel > 8 and concoctingLevel <= 12 then
						rankBonusPotions = math.random(1, 2)
						rankFailChance = 0
					elseif concoctingLevel > 12 then
						rankBonusPotions = math.random(2, 2)
						rankFailChance = -5
					else
						-- Error Handler: Rank is not set.
						player:talkSelf(0, "My Concocting Rank seems odd...")
						return
					end

					numberPotions = rankBonusPotions
					-------------------------------------------
					-- What powders can be processed by rank --
					-- And then by what in the inventory ------
					-- Build the list -------------------------
					-------------------------------------------

					--Build a listing of what powders can be brewed
					--------------------------------------
					-- Concocting Rank 1: Small Potions --
					--------------------------------------
					if concoctingLevel >= 1 then -- Beginner
						if makeVita == 1 then
							if player:hasItem("sanguine_powder", 1) == true and player:hasItem("small_empty_bottle", 1) == true then
								table.insert(optsPotionStand, "Small Vita Potion")
							end
						end

						if makeMana == 1 then
							if player:hasItem("cobalt_powder", 1) == true and player:hasItem("small_empty_bottle", 1) == true then
								table.insert(optsPotionStand, "Small Mana Potion")
							end
						end

						if makeScourge == 1 then
							if player:hasItem("violet_powder", 1) == true and player:hasItem("small_empty_bottle", 1) == true then
								table.insert(optsPotionStand, "Small Shattering Potion")
							end
						end

						if makeSophoric == 1 then
							if player:hasItem("sophoric_powder", 1) == true and player:hasItem("small_empty_bottle", 1) == true then
								table.insert(optsPotionStand, "Small Sophoric Potion")
							end
						end

						if makeDraining == 1 then
							if player:hasItem("draining_powder", 1) == true and player:hasItem("small_empty_bottle", 1) == true then
								table.insert(optsPotionStand, "Small Withering Potion")
							end
						end

						if makeStupifying == 1 then
							if player:hasItem("stupifying_powder", 1) == true and player:hasItem("small_empty_bottle", 1) == true then
								table.insert(optsPotionStand, "Small Stupifying Potion")
							end
						end

						if makeEmpowering == 1 then
							if player:hasItem("empowering_powder", 1) == true and player:hasItem("small_empty_bottle", 1) == true then
								table.insert(optsPotionStand, "Small Empowering Potion")
							end
						end

						if makeBrutish == 1 then
							if player:hasItem("brutish_powder", 1) == true and player:hasItem("small_empty_bottle", 1) == true then
								table.insert(optsPotionStand, "Small Brutish Potion")
							end
						end

						if makeNimble == 1 then
							if player:hasItem("dancing_powder", 1) == true and player:hasItem("small_empty_bottle", 1) == true then
								table.insert(optsPotionStand, "Small Nimble Potion")
							end
						end
					end

					--------------------------------------
					-- Concocting Rank 3: Minor Potions --
					--------------------------------------
					if concoctingLevel >= 3 then -- Trainee
						if makeVita == 1 then
							if player:hasItem("sanguine_powder", 1) == true and player:hasItem("empty_bottle", 1) == true then
								table.insert(optsPotionStand, "Minor Vita Potion")
							end
						end

						if makeMana == 1 then
							if player:hasItem("cobalt_powder", 1) == true and player:hasItem("empty_bottle", 1) == true then
								table.insert(optsPotionStand, "Minor Mana Potion")
							end
						end

						if makeScourge == 1 then
							if player:hasItem("violet_powder", 1) == true and player:hasItem("empty_bottle", 1) == true then
								table.insert(optsPotionStand, "Minor Shattering Potion")
							end
						end

						if makeSophoric == 1 then
							if player:hasItem("sophoric_powder", 1) == true and player:hasItem("empty_bottle", 1) == true then
								table.insert(optsPotionStand, "Minor Sophoric Potion")
							end
						end

						if makeDraining == 1 then
							if player:hasItem("draining_powder", 1) == true and player:hasItem("empty_bottle", 1) == true then
								table.insert(optsPotionStand, "Minor Withering Potion")
							end
						end

						if makeStupifying == 1 then
							if player:hasItem("stupifying_powder", 1) == true and player:hasItem("empty_bottle", 1) == true then
								table.insert(optsPotionStand, "Minor Stupifying Potion")
							end
						end

						if makeEmpowering == 1 then
							if player:hasItem("empowering_powder", 1) == true and player:hasItem("empty_bottle", 1) == true then
								table.insert(optsPotionStand, "Minor Empowering Potion")
							end
						end

						if makeBrutish == 1 then
							if player:hasItem("brutish_powder", 1) == true and player:hasItem("empty_bottle", 1) == true then
								table.insert(optsPotionStand, "Minor Brutish Potion")
							end
						end

						if makeNimble == 1 then
							if player:hasItem("dancing_powder", 1) == true and player:hasItem("empty_bottle", 1) == true then
								table.insert(optsPotionStand, "Minor Nimble Potion")
							end
						end
					end

					----------------------------------------
					-- Concocting Rank 5: Regular Potions --
					----------------------------------------
					if concoctingLevel >= 5 then -- Greenhorn
						if makeVita == 1 then
							if
								player:hasItem("sanguine_powder", 1) == true and player:hasItem("empty_bottle", 1) == true and
									player:hasItem("mushroom_enhancer", 1) == true
							 then
								table.insert(optsPotionStand, "Vita Potion")
							end
						end

						if makeMana == 1 then
							if
								player:hasItem("cobalt_powder", 1) == true and player:hasItem("empty_bottle", 1) == true and
									player:hasItem("mushroom_enhancer", 1) == true
							 then
								table.insert(optsPotionStand, "Mana Potion")
							end
						end

						if makeScourge == 1 then
							if
								player:hasItem("violet_powder", 1) == true and player:hasItem("empty_bottle", 1) == true and
									player:hasItem("mushroom_enhancer", 1) == true
							 then
								table.insert(optsPotionStand, "Shattering Potion")
							end
						end

						if makeSophoric == 1 then
							if
								player:hasItem("sophoric_powder", 1) == true and player:hasItem("empty_bottle", 1) == true and
									player:hasItem("mushroom_enhancer", 1) == true
							 then
								table.insert(optsPotionStand, "Sophoric Potion")
							end
						end

						if makeDraining == 1 then
							if
								player:hasItem("draining_powder", 1) == true and player:hasItem("empty_bottle", 1) == true and
									player:hasItem("mushroom_enhancer", 1) == true
							 then
								table.insert(optsPotionStand, "Withering Potion")
							end
						end

						if makeStupifying == 1 then
							if
								player:hasItem("stupifying_powder", 1) == true and player:hasItem("empty_bottle", 1) == true and
									player:hasItem("mushroom_enhancer", 1) == true
							 then
								table.insert(optsPotionStand, "Stupifying Potion")
							end
						end

						if makeEmpowering == 1 then
							if
								player:hasItem("empowering_powder", 1) == true and player:hasItem("empty_bottle", 1) == true and
									player:hasItem("mushroom_enhancer", 1) == true
							 then
								table.insert(optsPotionStand, "Empowering Potion")
							end
						end

						if makeBrutish == 1 then
							if
								player:hasItem("brutish_powder", 1) == true and player:hasItem("empty_bottle", 1) == true and
									player:hasItem("mushroom_enhancer", 1) == true
							 then
								table.insert(optsPotionStand, "Brutish Potion")
							end
						end

						if makeNimble == 1 then
							if
								player:hasItem("dancing_powder", 1) == true and player:hasItem("empty_bottle", 1) == true and
									player:hasItem("mushroom_enhancer", 1) == true
							 then
								table.insert(optsPotionStand, "Nimble Potion")
							end
						end
					end

					----------------------------------------
					-- Concocting Rank 7: Strong Potions --
					----------------------------------------
					if concoctingLevel >= 7 then -- Amateur
						if makeVita == 1 then
							if
								player:hasItem("sanguine_powder", 1) == true and player:hasItem("empty_bottle", 1) == true and
									player:hasItem("mushroom_enhancer", 1) == true and
									player:hasItem("enhancing_powder", 1) == true
							 then
								table.insert(optsPotionStand, "Strong Vita Potion")
							end
						end

						if makeMana == 1 then
							if
								player:hasItem("cobalt_powder", 1) == true and player:hasItem("empty_bottle", 1) == true and
									player:hasItem("mushroom_enhancer", 1) == true and
									player:hasItem("enhancing_powder", 1) == true
							 then
								table.insert(optsPotionStand, "Strong Mana Potion")
							end
						end

						if makeScourge == 1 then
							if
								player:hasItem("violet_powder", 1) == true and player:hasItem("empty_bottle", 1) == true and
									player:hasItem("mushroom_enhancer", 1) == true and
									player:hasItem("enhancing_powder", 1) == true
							 then
								table.insert(optsPotionStand, "Strong Shattering Potion")
							end
						end

						if makeSophoric == 1 then
							if
								player:hasItem("sophoric_powder", 1) == true and player:hasItem("empty_bottle", 1) == true and
									player:hasItem("mushroom_enhancer", 1) == true and
									player:hasItem("enhancing_powder", 1) == true
							 then
								table.insert(optsPotionStand, "Strong Sophoric Potion")
							end
						end

						if makeDraining == 1 then
							if
								player:hasItem("draining_powder", 1) == true and player:hasItem("empty_bottle", 1) == true and
									player:hasItem("mushroom_enhancer", 1) == true and
									player:hasItem("enhancing_powder", 1) == true
							 then
								table.insert(optsPotionStand, "Strong Withering Potion")
							end
						end

						if makeStupifying == 1 then
							if
								player:hasItem("stupifying_powder", 1) == true and player:hasItem("empty_bottle", 1) == true and
									player:hasItem("mushroom_enhancer", 1) == true and
									player:hasItem("enhancing_powder", 1) == true
							 then
								table.insert(optsPotionStand, "Strong Stupifying Potion")
							end
						end

						if makeEmpowering == 1 then
							if
								player:hasItem("empowering_powder", 1) == true and player:hasItem("empty_bottle", 1) == true and
									player:hasItem("mushroom_enhancer", 1) == true and
									player:hasItem("enhancing_powder", 1) == true
							 then
								table.insert(optsPotionStand, "Strong Empowering Potion")
							end
						end

						if makeBrutish == 1 then
							if
								player:hasItem("brutish_powder", 1) == true and player:hasItem("empty_bottle", 1) == true and
									player:hasItem("mushroom_enhancer", 1) == true and
									player:hasItem("enhancing_powder", 1) == true
							 then
								table.insert(optsPotionStand, "Strong Brutish Potion")
							end
						end

						if makeNimble == 1 then
							if
								player:hasItem("dancing_powder", 1) == true and player:hasItem("empty_bottle", 1) == true and
									player:hasItem("mushroom_enhancer", 1) == true and
									player:hasItem("enhancing_powder", 1) == true
							 then
								table.insert(optsPotionStand, "Strong Nimble Potion")
							end
						end
					end

					----------------------------------------
					-- Concocting Rank 9: Greater Potions --
					----------------------------------------
					if concoctingLevel >= 9 then -- Adept
						if makeVita == 1 then
							if player:hasItem("sanguine_powder", 1) == true and player:hasItem("medium_empty_bottle", 1) == true then
								table.insert(optsPotionStand, "Greater Vita Potion")
							end
						end

						if makeMana == 1 then
							if player:hasItem("cobalt_powder", 1) == true and player:hasItem("medium_empty_bottle", 1) == true then
								table.insert(optsPotionStand, "Greater Mana Potion")
							end
						end

						if makeScourge == 1 then
							if player:hasItem("violet_powder", 1) == true and player:hasItem("medium_empty_bottle", 1) == true then
								table.insert(optsPotionStand, "Greater Shattering Potion")
							end
						end

						if makeSophoric == 1 then
							if player:hasItem("sophoric_powder", 1) == true and player:hasItem("medium_empty_bottle", 1) == true then
								table.insert(optsPotionStand, "Greater Sophoric Potion")
							end
						end

						if makeDraining == 1 then
							if player:hasItem("draining_powder", 1) == true and player:hasItem("medium_empty_bottle", 1) == true then
								table.insert(optsPotionStand, "Greater Withering Potion")
							end
						end

						if makeStupifying == 1 then
							if player:hasItem("stupifying_powder", 1) == true and player:hasItem("medium_empty_bottle", 1) == true then
								table.insert(optsPotionStand, "Greater Stupifying Potion")
							end
						end

						if makeEmpowering == 1 then
							if player:hasItem("empowering_powder", 1) == true and player:hasItem("medium_empty_bottle", 1) == true then
								table.insert(optsPotionStand, "Greater Empowering Potion")
							end
						end

						if makeBrutish == 1 then
							if player:hasItem("brutish_powder", 1) == true and player:hasItem("medium_empty_bottle", 1) == true then
								table.insert(optsPotionStand, "Greater Brutish Potion")
							end
						end

						if makeNimble == 1 then
							if player:hasItem("dancing_powder", 1) == true and player:hasItem("medium_empty_bottle", 1) == true then
								table.insert(optsPotionStand, "Greater Nimble Potion")
							end
						end
					end

					----------------------------------------
					-- Concocting Rank 11: Superior Potions --
					----------------------------------------
					if concoctingLevel >= 11 then -- Expert
						if makeVita == 1 then
							if
								player:hasItem("sanguine_powder", 1) == true and player:hasItem("large_empty_bottle", 1) == true and
									player:hasItem("mushroom_enhancer", 1) == true
							 then
								table.insert(optsPotionStand, "Superior Vita Potion")
							end
						end

						if makeMana == 1 then
							if
								player:hasItem("cobalt_powder", 1) == true and player:hasItem("large_empty_bottle", 1) == true and
									player:hasItem("mushroom_enhancer", 1) == true
							 then
								table.insert(optsPotionStand, "Superior Mana Potion")
							end
						end

						if makeScourge == 1 then
							if
								player:hasItem("violet_powder", 1) == true and player:hasItem("large_empty_bottle", 1) == true and
									player:hasItem("mushroom_enhancer", 1) == true
							 then
								table.insert(optsPotionStand, "Superior Shattering Potion")
							end
						end

						if makeSophoric == 1 then
							if
								player:hasItem("sophoric_powder", 1) == true and player:hasItem("large_empty_bottle", 1) == true and
									player:hasItem("mushroom_enhancer", 1) == true
							 then
								table.insert(optsPotionStand, "Superior Sophoric Potion")
							end
						end

						if makeDraining == 1 then
							if
								player:hasItem("draining_powder", 1) == true and player:hasItem("large_empty_bottle", 1) == true and
									player:hasItem("mushroom_enhancer", 1) == true
							 then
								table.insert(optsPotionStand, "Superior Withering Potion")
							end
						end

						if makeStupifying == 1 then
							if
								player:hasItem("stupifying_powder", 1) == true and player:hasItem("large_empty_bottle", 1) == true and
									player:hasItem("mushroom_enhancer", 1) == true
							 then
								table.insert(optsPotionStand, "Superior Stupifying Potion")
							end
						end

						if makeEmpowering == 1 then
							if
								player:hasItem("empowering_powder", 1) == true and player:hasItem("large_empty_bottle", 1) == true and
									player:hasItem("mushroom_enhancer", 1) == true
							 then
								table.insert(optsPotionStand, "Superior Empowering Potion")
							end
						end

						if makeBrutish == 1 then
							if
								player:hasItem("brutish_powder", 1) == true and player:hasItem("large_empty_bottle", 1) == true and
									player:hasItem("mushroom_enhancer", 1) == true
							 then
								table.insert(optsPotionStand, "Superior Brutish Potion")
							end
						end

						if makeNimble == 1 then
							if
								player:hasItem("dancing_powder", 1) == true and player:hasItem("large_empty_bottle", 1) == true and
									player:hasItem("mushroom_enhancer", 1) == true
							 then
								table.insert(optsPotionStand, "Superior Nimble Potion")
							end
						end
					end

					----------------------------------------
					-- Concocting Rank 13: Master Potions --
					----------------------------------------

					if concoctingLevel >= 13 then -- Prodigy, Virtuoso, Master and Grand Master
						if makeVita == 1 then
							if
								player:hasItem("sanguine_powder", 1) == true and player:hasItem("large_empty_bottle", 1) == true and
									player:hasItem("mushroom_enhancer", 1) == true and
									player:hasItem("enhancing_powder", 1) == true
							 then
								table.insert(optsPotionStand, "Master Vita Potion")
							end
						end

						if makeMana == 1 then
							if
								player:hasItem("cobalt_powder", 1) == true and player:hasItem("large_empty_bottle", 1) == true and
									player:hasItem("mushroom_enhancer", 1) == true and
									player:hasItem("enhancing_powder", 1) == true
							 then
								table.insert(optsPotionStand, "Master Mana Potion")
							end
						end

						if makeScourge == 1 then
							if
								player:hasItem("violet_powder", 1) == true and player:hasItem("large_empty_bottle", 1) == true and
									player:hasItem("mushroom_enhancer", 1) == true and
									player:hasItem("enhancing_powder", 1) == true
							 then
								table.insert(optsPotionStand, "Master Shattering Potion")
							end
						end

						if makeSophoric == 1 then
							if
								player:hasItem("sophoric_powder", 1) == true and player:hasItem("large_empty_bottle", 1) == true and
									player:hasItem("mushroom_enhancer", 1) == true and
									player:hasItem("enhancing_powder", 1) == true
							 then
								table.insert(optsPotionStand, "Master Sophoric Potion")
							end
						end

						if makeDraining == 1 then
							if
								player:hasItem("draining_powder", 1) == true and player:hasItem("large_empty_bottle", 1) == true and
									player:hasItem("mushroom_enhancer", 1) == true and
									player:hasItem("enhancing_powder", 1) == true
							 then
								table.insert(optsPotionStand, "Master Withering Potion")
							end
						end

						if makeStupifying == 1 then
							if
								player:hasItem("stupifying_powder", 1) == true and player:hasItem("large_empty_bottle", 1) == true and
									player:hasItem("mushroom_enhancer", 1) == true and
									player:hasItem("enhancing_powder", 1) == true
							 then
								table.insert(optsPotionStand, "Master Stupifying Potion")
							end
						end

						if makeEmpowering == 1 then
							if
								player:hasItem("empowering_powder", 1) == true and player:hasItem("large_empty_bottle", 1) == true and
									player:hasItem("mushroom_enhancer", 1) == true and
									player:hasItem("enhancing_powder", 1) == true
							 then
								table.insert(optsPotionStand, "Master Empowering Potion")
							end
						end

						if makeBrutish == 1 then
							if
								player:hasItem("brutish_powder", 1) == true and player:hasItem("large_empty_bottle", 1) == true and
									player:hasItem("mushroom_enhancer", 1) == true and
									player:hasItem("enhancing_powder", 1) == true
							 then
								table.insert(optsPotionStand, "Master Brutish Potion")
							end
						end

						if makeNimble == 1 then
							if
								player:hasItem("dancing_powder", 1) == true and player:hasItem("large_empty_bottle", 1) == true and
									player:hasItem("mushroom_enhancer", 1) == true and
									player:hasItem("enhancing_powder", 1) == true
							 then
								table.insert(optsPotionStand, "Master Nimble Potion")
							end
						end
					end

					table.insert(optsPotionStand, "Leave")
					------------------------------------
					-- Display Potions to brew        --
					------------------------------------
					potionStandMenuOption = player:menuString("What potion to brew?", optsPotionStand)

					----------------------------------------
					-- Small Potions -----------------------
					----------------------------------------
					if potionStandMenuOption == "Small Vita Potion" then
						skillEXP = 8
						craftingTime = 2000
						craftingItem01 = "sanguine_powder"
						craftingItem02 = "small_empty_bottle"
						craftingItem03 = ""
						craftingItem04 = ""
						craftedItem = "small_vita_potion"
						craftedItemName = "Small Vita Potion"
						potionFailChance = 3
					elseif potionStandMenuOption == "Small Mana Potion" then
						skillEXP = 8
						craftingTime = 2000
						craftingItem01 = "cobalt_powder"
						craftingItem02 = "small_empty_bottle"
						craftingItem03 = ""
						craftingItem04 = ""
						craftedItem = "small_mana_potion"
						craftedItemName = "Small Mana Potion"
						potionFailChance = 3
					elseif potionStandMenuOption == "Small Shattering Potion" then
						skillEXP = 8
						craftingTime = 2000
						craftingItem01 = "violet_powder"
						craftingItem02 = "small_empty_bottle"
						craftingItem03 = ""
						craftingItem04 = ""
						craftedItem = "small_shattering_potion"
						craftedItemName = "Small Shattering Potion"
						potionFailChance = 5
					elseif potionStandMenuOption == "Small Sophoric Potion" then
						skillEXP = 8
						craftingTime = 2000
						craftingItem01 = "sophoric_powder"
						craftingItem02 = "small_empty_bottle"
						craftingItem03 = ""
						craftingItem04 = ""
						craftedItem = "small_sophoric_potion"
						craftedItemName = "Small Sophoric Potion"
						potionFailChance = 6
					elseif potionStandMenuOption == "Small Withering Potion" then
						skillEXP = 8
						craftingTime = 2000
						craftingItem01 = "draining_powder"
						craftingItem02 = "small_empty_bottle"
						craftingItem03 = ""
						craftingItem04 = ""
						craftedItem = "small_withering_potion"
						craftedItemName = "Small Withering Potion"
						potionFailChance = 7
					elseif potionStandMenuOption == "Small Stupifying Potion" then
						skillEXP = 8
						craftingTime = 2000
						craftingItem01 = "stupifying_powder"
						craftingItem02 = "small_empty_bottle"
						craftingItem03 = ""
						craftingItem04 = ""
						craftedItem = "small_stupifying_potion"
						craftedItemName = "Small Stupifying Potion"
						potionFailChance = 8
					elseif potionStandMenuOption == "Small Empowering Potion" then
						skillEXP = 8
						craftingTime = 2000
						craftingItem01 = "empowering_powder"
						craftingItem02 = "small_empty_bottle"
						craftingItem03 = ""
						craftingItem04 = ""
						craftedItem = "small_empowering_potion"
						craftedItemName = "Small Empowering Potion"
						potionFailChance = 9
					elseif potionStandMenuOption == "Small Brutish Potion" then
						skillEXP = 8
						craftingTime = 2000
						craftingItem01 = "brutish_powder"
						craftingItem02 = "small_empty_bottle"
						craftingItem03 = ""
						craftingItem04 = ""
						craftedItem = "small_brutish_potion"
						craftedItemName = "Small Brutish Potion"
						potionFailChance = 10
					elseif potionStandMenuOption == "Small Nimble Potion" then
						----------------------------------------
						-- Minor Potions -----------------------
						----------------------------------------
						skillEXP = 8
						craftingTime = 2000
						craftingItem01 = "dancing_powder"
						craftingItem02 = "small_empty_bottle"
						craftingItem03 = ""
						craftingItem04 = ""
						craftedItem = "small_dancing_potion"
						craftedItemName = "Small Nimble Potion"
						potionFailChance = 10
					elseif potionStandMenuOption == "Minor Vita Potion" then
						skillEXP = 35
						craftingTime = 2000
						craftingItem01 = "sanguine_powder"
						craftingItem02 = "empty_bottle"
						craftingItem03 = ""
						craftingItem04 = ""
						craftedItem = "minor_vita_potion"
						craftedItemName = "Minor Vita Potion"
						potionFailChance = 4
					elseif potionStandMenuOption == "Minor Mana Potion" then
						skillEXP = 35
						craftingTime = 2000
						craftingItem01 = "cobalt_powder"
						craftingItem02 = "empty_bottle"
						craftingItem03 = ""
						craftingItem04 = ""
						craftedItem = "minor_mana_potion"
						craftedItemName = "Minor Mana Potion"
						potionFailChance = 4
					elseif potionStandMenuOption == "Minor Shattering Potion" then
						skillEXP = 35
						craftingTime = 2000
						craftingItem01 = "violet_powder"
						craftingItem02 = "empty_bottle"
						craftingItem03 = ""
						craftingItem04 = ""
						craftedItem = "minor_shattering_potion"
						craftedItemName = "Minor Shattering Potion"
						potionFailChance = 6
					elseif potionStandMenuOption == "Minor Sophoric Potion" then
						skillEXP = 35
						craftingTime = 2000
						craftingItem01 = "sophoric_powder"
						craftingItem02 = "empty_bottle"
						craftingItem03 = ""
						craftingItem04 = ""
						craftedItem = "minor_sophoric_potion"
						craftedItemName = "Minor Sophoric Potion"
						potionFailChance = 7
					elseif potionStandMenuOption == "Minor Withering Potion" then
						skillEXP = 35
						craftingTime = 2000
						craftingItem01 = "draining_powder"
						craftingItem02 = "empty_bottle"
						craftingItem03 = ""
						craftingItem04 = ""
						craftedItem = "minor_withering_potion"
						craftedItemName = "Minor Withering Potion"
						potionFailChance = 8
					elseif potionStandMenuOption == "Minor Stupifying Potion" then
						skillEXP = 35
						craftingTime = 2000
						craftingItem01 = "stupifying_powder"
						craftingItem02 = "empty_bottle"
						craftingItem03 = ""
						craftingItem04 = ""
						craftedItem = "minor_stupifying_potion"
						craftedItemName = "Minor Stupifying Potion"
						potionFailChance = 9
					elseif potionStandMenuOption == "Minor Empowering Potion" then
						skillEXP = 35
						craftingTime = 2000
						craftingItem01 = "empowering_powder"
						craftingItem02 = "empty_bottle"
						craftingItem03 = ""
						craftingItem04 = ""
						craftedItem = "minor_empowering_potion"
						craftedItemName = "Minor Empowering Potion"
						potionFailChance = 10
					elseif potionStandMenuOption == "Minor Brutish Potion" then
						skillEXP = 35
						craftingTime = 2000
						craftingItem01 = "brutish_powder"
						craftingItem02 = "empty_bottle"
						craftingItem03 = ""
						craftingItem04 = ""
						craftedItem = "minor_brutish_potion"
						craftedItemName = "Minor Brutish Potion"
						potionFailChance = 11
					elseif potionStandMenuOption == "Minor Nimble Potion" then
						----------------------------------------
						-- Regular Potions  (Rank 5)------------
						----------------------------------------
						skillEXP = 35
						craftingTime = 2000
						craftingItem01 = "dancing_powder"
						craftingItem02 = "empty_bottle"
						craftingItem03 = ""
						craftingItem04 = ""
						craftedItem = "minor_dancing_potion"
						craftedItemName = "Minor Nimble Potion"
						potionFailChance = 11
					elseif potionStandMenuOption == "Vita Potion" then
						skillEXP = 68
						craftingTime = 2000
						craftingItem01 = "sanguine_powder"
						craftingItem02 = "empty_bottle"
						craftingItem03 = "mushroom_enhancer"
						craftingItem04 = ""
						craftedItem = "reg_vita_potion"
						craftedItemName = "Vita Potion"
						potionFailChance = 5
					elseif potionStandMenuOption == "Mana Potion" then
						skillEXP = 68
						craftingTime = 2000
						craftingItem01 = "cobalt_powder"
						craftingItem02 = "empty_bottle"
						craftingItem03 = "mushroom_enhancer"
						craftingItem04 = ""
						craftedItem = "reg_mana_potion"
						craftedItemName = "Mana Potion"
						potionFailChance = 5
					elseif potionStandMenuOption == "Shattering Potion" then
						skillEXP = 68
						craftingTime = 2000
						craftingItem01 = "violet_powder"
						craftingItem02 = "empty_bottle"
						craftingItem03 = "mushroom_enhancer"
						craftingItem04 = ""
						craftedItem = "reg_shattering_potion"
						craftedItemName = "Shattering Potion"
						potionFailChance = 7
					elseif potionStandMenuOption == "Sophoric Potion" then
						skillEXP = 68
						craftingTime = 2000
						craftingItem01 = "sophoric_powder"
						craftingItem02 = "empty_bottle"
						craftingItem03 = "mushroom_enhancer"
						craftingItem04 = ""
						craftedItem = "reg_sophoric_potion"
						craftedItemName = "Sophoric Potion"
						potionFailChance = 8
					elseif potionStandMenuOption == "Withering Potion" then
						skillEXP = 68
						craftingTime = 2000
						craftingItem01 = "draining_powder"
						craftingItem02 = "empty_bottle"
						craftingItem03 = "mushroom_enhancer"
						craftingItem04 = ""
						craftedItem = "reg_withering_potion"
						craftedItemName = "Withering Potion"
						potionFailChance = 9
					elseif potionStandMenuOption == "Stupifying Potion" then
						skillEXP = 68
						craftingTime = 2000
						craftingItem01 = "stupifying_powder"
						craftingItem02 = "empty_bottle"
						craftingItem03 = "mushroom_enhancer"
						craftingItem04 = ""
						craftedItem = "reg_stupifying_potion"
						craftedItemName = "Stupifying Potion"
						potionFailChance = 10
					elseif potionStandMenuOption == "Empowering Potion" then
						skillEXP = 68
						craftingTime = 2000
						craftingItem01 = "empowering_powder"
						craftingItem02 = "empty_bottle"
						craftingItem03 = "mushroom_enhancer"
						craftingItem04 = ""
						craftedItem = "reg_empowering_potion"
						craftedItemName = "Empowering Potion"
						potionFailChance = 11
					elseif potionStandMenuOption == "Brutish Potion" then
						skillEXP = 68
						craftingTime = 2000
						craftingItem01 = "brutish_powder"
						craftingItem02 = "empty_bottle"
						craftingItem03 = "mushroom_enhancer"
						craftingItem04 = ""
						craftedItem = "reg_brutish_potion"
						craftedItemName = "Brutish Potion"
						potionFailChance = 12
					elseif potionStandMenuOption == "Nimble Potion" then
						----------------------------------------
						-- Strong Potions (Rank 7) -------------
						----------------------------------------
						skillEXP = 68
						craftingTime = 2000
						craftingItem01 = "dancing_powder"
						craftingItem02 = "empty_bottle"
						craftingItem03 = "mushroom_enhancer"
						craftingItem04 = ""
						craftedItem = "dancing_potion"
						craftedItemName = "Nimble Potion"
						potionFailChance = 12
					elseif potionStandMenuOption == "Strong Vita Potion" then
						skillEXP = 125
						craftingTime = 2000
						craftingItem01 = "sanguine_powder"
						craftingItem02 = "empty_bottle"
						craftingItem03 = "mushroom_enhancer"
						craftingItem04 = "enhancing_powder"
						craftedItem = "strong_vita_potion"
						craftedItemName = "Strong Vita Potion"
						potionFailChance = 7
					elseif potionStandMenuOption == "Strong Mana Potion" then
						skillEXP = 125
						craftingTime = 2000
						craftingItem01 = "cobalt_powder"
						craftingItem02 = "empty_bottle"
						craftingItem03 = "mushroom_enhancer"
						craftingItem04 = "enhancing_powder"
						craftedItem = "strong_mana_potion"
						craftedItemName = "Strong Mana Potion"
						potionFailChance = 7
					elseif potionStandMenuOption == "Strong Shattering Potion" then
						skillEXP = 125
						craftingTime = 2000
						craftingItem01 = "violet_powder"
						craftingItem02 = "empty_bottle"
						craftingItem03 = "mushroom_enhancer"
						craftingItem04 = "enhancing_powder"
						craftedItem = "strong_shattering_potion"
						craftedItemName = "Strong Shattering Potion"
						potionFailChance = 9
					elseif potionStandMenuOption == "Strong Sophoric Potion" then
						skillEXP = 125
						craftingTime = 3000
						craftingItem01 = "sophoric_powder"
						craftingItem02 = "empty_bottle"
						craftingItem03 = "mushroom_enhancer"
						craftingItem04 = "enhancing_powder"
						craftedItem = "strong_sophoric_potion"
						craftedItemName = "Strong Sophoric Potion"
						potionFailChance = 10
					elseif potionStandMenuOption == "Strong Withering Potion" then
						skillEXP = 125
						craftingTime = 3000
						craftingItem01 = "draining_powder"
						craftingItem02 = "empty_bottle"
						craftingItem03 = "mushroom_enhancer"
						craftingItem04 = "enhancing_powder"
						craftedItem = "strong_withering_potion"
						craftedItemName = "Strong Withering Potion"
						potionFailChance = 11
					elseif potionStandMenuOption == "Strong Stupifying Potion" then
						skillEXP = 125
						craftingTime = 3000
						craftingItem01 = "stupifying_powder"
						craftingItem02 = "empty_bottle"
						craftingItem03 = "mushroom_enhancer"
						craftingItem04 = "enhancing_powder"
						craftedItem = "strong_stupifying_potion"
						craftedItemName = "Strong Stupifying Potion"
						potionFailChance = 12
					elseif potionStandMenuOption == "Strong Empowering Potion" then
						skillEXP = 125
						craftingTime = 3000
						craftingItem01 = "empowering_powder"
						craftingItem02 = "empty_bottle"
						craftingItem03 = "mushroom_enhancer"
						craftingItem04 = "enhancing_powder"
						craftedItem = "strong_empowering_potion"
						craftedItemName = "Strong Empowering Potion"
						potionFailChance = 13
					elseif potionStandMenuOption == "Strong Brutish Potion" then
						skillEXP = 125
						craftingTime = 3000
						craftingItem01 = "brutish_powder"
						craftingItem02 = "empty_bottle"
						craftingItem03 = "mushroom_enhancer"
						craftingItem04 = "enhancing_powder"
						craftedItem = "strong_brutish_potion"
						craftedItemName = "Strong Brutish Potion"
						potionFailChance = 14
					elseif potionStandMenuOption == "Strong Nimble Potion" then
						----------------------------------------
						-- Greater Potions (Rank 9)-------------
						----------------------------------------
						skillEXP = 125
						craftingTime = 3000
						craftingItem01 = "dancing_powder"
						craftingItem02 = "empty_bottle"
						craftingItem03 = "mushroom_enhancer"
						craftingItem04 = "enhancing_powder"
						craftedItem = "strong_dancing_potion"
						craftedItemName = "Strong Nimble Potion"
						potionFailChance = 14
					elseif potionStandMenuOption == "Greater Vita Potion" then
						skillEXP = 338
						craftingTime = 2000
						craftingItem01 = "sanguine_powder"
						craftingItem02 = "empty_bottle"
						craftingItem03 = "mushroom_enhancer"
						craftingItem04 = "enhancing_powder"
						craftedItem = "greater_vita_potion"
						craftedItemName = "Greater Vita Potion"
						potionFailChance = 8
					elseif potionStandMenuOption == "Greater Mana Potion" then
						skillEXP = 338
						craftingTime = 2000
						craftingItem01 = "cobalt_powder"
						craftingItem02 = "empty_bottle"
						craftingItem03 = "mushroom_enhancer"
						craftingItem04 = "enhancing_powder"
						craftedItem = "greater_mana_potion"
						craftedItemName = "Greater Mana Potion"
						potionFailChance = 8
					elseif potionStandMenuOption == "Greater Shattering Potion" then
						skillEXP = 338
						craftingTime = 2000
						craftingItem01 = "violet_powder"
						craftingItem02 = "empty_bottle"
						craftingItem03 = "mushroom_enhancer"
						craftingItem04 = "enhancing_powder"
						craftedItem = "greater_shattering_potion"
						craftedItemName = "Greater Shattering Potion"
						potionFailChance = 10
					elseif potionStandMenuOption == "Greater Sophoric Potion" then
						skillEXP = 338
						craftingTime = 3000
						craftingItem01 = "sophoric_powder"
						craftingItem02 = "empty_bottle"
						craftingItem03 = "mushroom_enhancer"
						craftingItem04 = "enhancing_powder"
						craftedItem = "greater_sophoric_potion"
						craftedItemName = "Greater Sophoric Potion"
						potionFailChance = 11
					elseif potionStandMenuOption == "Greater Withering Potion" then
						skillEXP = 338
						craftingTime = 3000
						craftingItem01 = "draining_powder"
						craftingItem02 = "empty_bottle"
						craftingItem03 = "mushroom_enhancer"
						craftingItem04 = "enhancing_powder"
						craftedItem = "greater_withering_potion"
						craftedItemName = "Greater Withering Potion"
						potionFailChance = 12
					elseif potionStandMenuOption == "Greater Stupifying Potion" then
						skillEXP = 338
						craftingTime = 3000
						craftingItem01 = "stupifying_powder"
						craftingItem02 = "empty_bottle"
						craftingItem03 = "mushroom_enhancer"
						craftingItem04 = "enhancing_powder"
						craftedItem = "greater_stupifying_potion"
						craftedItemName = "Greater Stupifying Potion"
						potionFailChance = 13
					elseif potionStandMenuOption == "Greater Empowering Potion" then
						skillEXP = 338
						craftingTime = 3000
						craftingItem01 = "empowering_powder"
						craftingItem02 = "empty_bottle"
						craftingItem03 = "mushroom_enhancer"
						craftingItem04 = "enhancing_powder"
						craftedItem = "greater_empowering_potion"
						craftedItemName = "Greater Empowering Potion"
						potionFailChance = 14
					elseif potionStandMenuOption == "Greater Brutish Potion" then
						skillEXP = 338
						craftingTime = 3000
						craftingItem01 = "brutish_powder"
						craftingItem02 = "empty_bottle"
						craftingItem03 = "mushroom_enhancer"
						craftingItem04 = "enhancing_powder"
						craftedItem = "greater_brutish_potion"
						craftedItemName = "Greater Brutish Potion"
						potionFailChance = 15
					elseif potionStandMenuOption == "Greater Nimble Potion" then
						----------------------------------------
						-- Superior Potions (Rank 11)-------------
						----------------------------------------
						skillEXP = 338
						craftingTime = 3000
						craftingItem01 = "dancing_powder"
						craftingItem02 = "empty_bottle"
						craftingItem03 = "mushroom_enhancer"
						craftingItem04 = "enhancing_powder"
						craftedItem = "greater_dancing_potion"
						craftedItemName = "Greater Nimble Potion"
						potionFailChance = 15
					elseif potionStandMenuOption == "Superior Vita Potion" then
						skillEXP = 1200
						craftingTime = 3000
						craftingItem01 = "sanguine_powder"
						craftingItem02 = "large_empty_bottle"
						craftingItem03 = "mushroom_enhancer"
						craftingItem04 = ""
						craftedItem = "superior_vita_potion"
						craftedItemName = "Superior Vita Potion"
						potionFailChance = 9
					elseif potionStandMenuOption == "Superior Mana Potion" then
						skillEXP = 1200
						craftingTime = 3000
						craftingItem01 = "cobalt_powder"
						craftingItem02 = "large_empty_bottle"
						craftingItem03 = "mushroom_enhancer"
						craftingItem04 = ""
						craftedItem = "superior_mana_potion"
						craftedItemName = "Superior Mana Potion"
						potionFailChance = 9
					elseif potionStandMenuOption == "Superior Shattering Potion" then
						skillEXP = 1200
						craftingTime = 3000
						craftingItem01 = "violet_powder"
						craftingItem02 = "large_empty_bottle"
						craftingItem03 = "mushroom_enhancer"
						craftingItem04 = ""
						craftedItem = "superior_shattering_potion"
						craftedItemName = "Superior Shattering Potion"
						potionFailChance = 11
					elseif potionStandMenuOption == "Superior Sophoric Potion" then
						skillEXP = 1600
						craftingTime = 4000
						craftingItem01 = "sophoric_powder"
						craftingItem02 = "large_empty_bottle"
						craftingItem03 = "mushroom_enhancer"
						craftingItem04 = ""
						craftedItem = "superior_sophoric_potion"
						craftedItemName = "Superior Sophoric Potion"
						potionFailChance = 12
					elseif potionStandMenuOption == "Superior Withering Potion" then
						skillEXP = 1600
						craftingTime = 4000
						craftingItem01 = "draining_powder"
						craftingItem02 = "large_empty_bottle"
						craftingItem03 = "mushroom_enhancer"
						craftingItem04 = ""
						craftedItem = "superior_withering_potion"
						craftedItemName = "Superior Withering Potion"
						potionFailChance = 13
					elseif potionStandMenuOption == "Superior Stupifying Potion" then
						skillEXP = 1600
						craftingTime = 4000
						craftingItem01 = "stupifying_powder"
						craftingItem02 = "large_empty_bottle"
						craftingItem03 = "mushroom_enhancer"
						craftingItem04 = ""
						craftedItem = "superior_stupifying_potion"
						craftedItemName = "Superior Stupifying Potion"
						potionFailChance = 14
					elseif potionStandMenuOption == "Superior Empowering Potion" then
						skillEXP = 1600
						craftingTime = 4000
						craftingItem01 = "empowering_powder"
						craftingItem02 = "large_empty_bottle"
						craftingItem03 = "mushroom_enhancer"
						craftingItem04 = ""
						craftedItem = "superior_empowering_potion"
						craftedItemName = "Superior Empowering Potion"
						potionFailChance = 15
					elseif potionStandMenuOption == "Superior Brutish Potion" then
						skillEXP = 1600
						craftingTime = 4000
						craftingItem01 = "brutish_powder"
						craftingItem02 = "large_empty_bottle"
						craftingItem03 = "mushroom_enhancer"
						craftingItem04 = ""
						craftedItem = "superior_brutish_potion"
						craftedItemName = "Superior Brutish Potion"
						potionFailChance = 16
					elseif potionStandMenuOption == "Superior Nimble Potion" then
						----------------------------------------
						-- Master Potions (Rank 13)-------------
						----------------------------------------
						skillEXP = 1600
						craftingTime = 4000
						craftingItem01 = "dancing_powder"
						craftingItem02 = "large_empty_bottle"
						craftingItem03 = "mushroom_enhancer"
						craftingItem04 = ""
						craftedItem = "superior_dancing_potion"
						craftedItemName = "Superior Nimble Potion"
						potionFailChance = 17
					elseif potionStandMenuOption == "Master Vita Potion" then
						skillEXP = 2500
						craftingTime = 3000
						craftingItem01 = "sanguine_powder"
						craftingItem02 = "large_empty_bottle"
						craftingItem03 = "mushroom_enhancer"
						craftingItem04 = "enhancing_powder"
						craftedItem = "master_vita_potion"
						craftedItemName = "Master Vita Potion"
						potionFailChance = 10
					elseif potionStandMenuOption == "Master Mana Potion" then
						skillEXP = 2500
						craftingTime = 3000
						craftingItem01 = "cobalt_powder"
						craftingItem02 = "large_empty_bottle"
						craftingItem03 = "mushroom_enhancer"
						craftingItem04 = "enhancing_powder"
						craftedItem = "master_mana_potion"
						craftedItemName = "Master Mana Potion"
						potionFailChance = 10
					elseif potionStandMenuOption == "Master Shattering Potion" then
						skillEXP = 2500
						craftingTime = 3000
						craftingItem01 = "violet_powder"
						craftingItem02 = "large_empty_bottle"
						craftingItem03 = "mushroom_enhancer"
						craftingItem04 = "enhancing_powder"
						craftedItem = "master_shattering_potion"
						craftedItemName = "Master Shattering Potion"
						potionFailChance = 12
					elseif potionStandMenuOption == "Master Sophoric Potion" then
						skillEXP = 2500
						craftingTime = 4000
						craftingItem01 = "sophoric_powder"
						craftingItem02 = "large_empty_bottle"
						craftingItem03 = "mushroom_enhancer"
						craftingItem04 = "enhancing_powder"
						craftedItem = "master_sophoric_potion"
						craftedItemName = "Master Sophoric Potion"
						potionFailChance = 13
					elseif potionStandMenuOption == "Master Withering Potion" then
						skillEXP = 2500
						craftingTime = 4000
						craftingItem01 = "draining_powder"
						craftingItem02 = "large_empty_bottle"
						craftingItem03 = "mushroom_enhancer"
						craftingItem04 = "enhancing_powder"
						craftedItem = "master_withering_potion"
						craftedItemName = "Master Withering Potion"
						potionFailChance = 14
					elseif potionStandMenuOption == "Master Stupifying Potion" then
						skillEXP = 2500
						craftingTime = 4000
						craftingItem01 = "stupifying_powder"
						craftingItem02 = "large_empty_bottle"
						craftingItem03 = "mushroom_enhancer"
						craftingItem04 = "enhancing_powder"
						craftedItem = "master_stupifying_potion"
						craftedItemName = "Master Stupifying Potion"
						potionFailChance = 15
					elseif potionStandMenuOption == "Master Empowering Potion" then
						skillEXP = 2500
						craftingTime = 4000
						craftingItem01 = "empowering_powder"
						craftingItem02 = "large_empty_bottle"
						craftingItem03 = "mushroom_enhancer"
						craftingItem04 = "enhancing_powder"
						craftedItem = "master_empowering_potion"
						craftedItemName = "Master Empowering Potion"
						potionFailChance = 16
					elseif potionStandMenuOption == "Master Brutish Potion" then
						skillEXP = 2500
						craftingTime = 4000
						craftingItem01 = "brutish_powder"
						craftingItem02 = "large_empty_bottle"
						craftingItem03 = "mushroom_enhancer"
						craftingItem04 = "enhancing_powder"
						craftedItem = "master_brutish_potion"
						craftedItemName = "Master Brutish Potion"
						potionFailChance = 17
					elseif potionStandMenuOption == "Master Nimble Potion" then
						skillEXP = 2500
						craftingTime = 4000
						craftingItem01 = "dancing_powder"
						craftingItem02 = "large_empty_bottle"
						craftingItem03 = "mushroom_enhancer"
						craftingItem04 = "enhancing_powder"
						craftedItem = "master_dancing_potion"
						craftedItemName = "Master Nimble Potion"
						potionFailChance = 17
					elseif potionStandMenuOption == "Leave" then
						player:talkSelf(0, "I think I will do this at a later time...")
						return
					else
						player:talkSelf(0, "ERROR: Not a possible Menu selection!!") -- Error: Tool is not a Pestle.
						return
					end
					--------------
					-- Crafting --
					--------------
					--player:talkSelf(0,"Item 01: "..craftingItem01)
					--player:talkSelf(0,"Item 02: "..craftingItem02)
					--player:talkSelf(0,"Item 03: "..craftingItem03)
					--player:talkSelf(0,"Item 04: "..craftingItem04)
					--				player:talkSelf(0,"potionFailChance: "..potionFailChance)
					--				player:talkSelf(0,"rankFailChance: "..rankFailChance)
					--				player:talkSelf(0,"numberPotions: "..numberPotions)
					-- Calculate total failure chance ----------------------------------------------
					failChance = rankFailChance + potionFailChance

					--			player:talkSelf(0,"failChance: "..failChance)

					if failChance <= 0 then
						failChance = 1
					end
					--------------
					-- Crafting --
					--------------
					failureRoll = math.random(1, 100)
					--	player:talkSelf(0, "failureRoll: "..failureRoll)

					if
						player:hasItem(craftingItem01, 1) == true and player:hasItem(craftingItem02, 1) == true and craftingItem03 == "" and
							craftingItem04 == ""
					 then
						player:sendAnimation(313) -- Display the spell graphic / animation for the skill
						player:removeItem(craftingItem01, 1) -- Take away the item to be worked
						player:removeItem(craftingItem02, 1)
						if failureRoll <= failChance then
							player:sendMinitext("I ruined this powder!!")
							skillEXP = math.floor(skillEXP / 2)
							skill.leveling(player, skillEXP, ability)
							return
						end -- Take away the item to be worked
						skill.leveling(player, skillEXP, ability) -- Give XP to Skill
						player:setDuration("concocting", craftingTime)
						player:addItem(craftedItem, numberPotions) -- and the items(s) produced

						if numberPotions == 1 then -- Display message showing what was created
							player:talkSelf(2, "I have made a " .. craftedItemName)
						elseif numberPotions > 1 then
							player:talkSelf(2, "I have made " .. numberPotions .. " " .. craftedItemName .. "s.")
						end
					elseif
						player:hasItem(craftingItem01, 1) == true and player:hasItem(craftingItem02, 1) == true and
							player:hasItem(craftingItem03, 1) == true and
							craftingItem04 == ""
					 then
						player:sendAnimation(313) -- Display the spell graphic / animation for the skill
						player:removeItem(craftingItem01, 1) -- Take away the item to be worked
						player:removeItem(craftingItem02, 1) -- Take away the item to be worked
						player:removeItem(craftingItem03, 1)
						if failureRoll <= failChance then
							player:sendMinitext("I ruined this powder!!")
							skillEXP = math.floor(skillEXP / 2)
							skill.leveling(player, skillEXP, ability)
							return
						end -- Take away the item to be worked
						skill.leveling(player, skillEXP, ability) -- Give XP to Skill
						player:setDuration("concocting", craftingTime, player.ID)
						player:addItem(craftedItem, numberPotions) -- and the items(s) produced

						if numberPotions == 1 then -- Display message showing what was created
							player:talkSelf(2, "I have made a " .. craftedItemName)
						elseif numberPotions > 1 then
							player:talkSelf(2, "I have made " .. numberPotions .. " " .. craftedItemName .. "s.")
						end
					elseif
						player:hasItem(craftingItem01, 1) == true and player:hasItem(craftingItem02, 1) == true and
							player:hasItem(craftingItem03, 1) == true and
							player:hasItem(craftingItem04, 1) == true
					 then
						player:sendAnimation(313) -- Display the spell graphic / animation for the skill
						player:removeItem(craftingItem01, 1) -- Take away the item to be worked
						player:removeItem(craftingItem02, 1) -- Take away the item to be worked
						player:removeItem(craftingItem03, 1) -- Take away the item to be worked
						player:removeItem(craftingItem04, 1) -- Take away the item to be worked
						if failureRoll <= failChance then
							player:sendMinitext("I ruined this powder!!")
							skillEXP = math.floor(skillEXP / 2)
							skill.leveling(player, skillEXP, ability)
							return
						end
						skill.leveling(player, skillEXP, ability) -- Give XP to Skill
						player:setDuration("concocting", craftingTime, player.ID)
						player:addItem(craftedItem, numberPotions) -- and the items(s) produced

						if numberPotions == 1 then -- Display message showing what was created
							player:talkSelf(2, "I have made a " .. craftedItemName)
						elseif numberPotions > 1 then
							player:talkSelf(2, "I have made " .. numberPotions .. " " .. craftedItemName .. "s.")
						end
					else
						player:talkSelf(0, "I don't have everything I need on me!")
						return
					end
				else
					player:sendMinitext("I am going to have to empty my hands before I can use the concoction stand!")
					return
				end
			end
		end
	)
}
