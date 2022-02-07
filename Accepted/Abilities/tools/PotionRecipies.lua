vita_potion_recipe = {
	use = function(player)
		player:freeAsync()
		player.lastClick = player.ID
		player.npcGraphic = 0
		player.dialogType = 0
		vita_potion_recipe.readRecipe(player)
	end,
	readRecipe = async(
		function(player, npc)
			local concoctingLevel = player.registry["concocting_level"]
			local makeVita = player.registry["vita_potion_knowledge"]

			local name
			local optsPotionSelectMenu = {}
			local potionRecipieMenuOption

			name = "<b>[Vita Potion Recipies]\n\n"

			if not player:canAction(1, 1, 1) then
				player:sendMinitext("You cannot do that right now!")
				return
			end

			if makeVita ~= 1 then
				player.registry["vita_potion_knowledge"] = 1
				player:dialogSeq(
					{name .. "You have read over the recipie and learned the basics steps for making a Health Recovery potion!"},
					1
				)
			end

			if concoctingLevel ~= nil then
				if concoctingLevel > 0 then
					table.insert(optsPotionSelectMenu, "Small Vita Potion")
				end

				--	if concoctingLevel > 1 then
				--	end

				if concoctingLevel > 2 then
					table.insert(optsPotionSelectMenu, "Minor Vita Potion")
				end

				--	if concoctingLevel > 3 then
				--	end

				if concoctingLevel > 4 then
					table.insert(optsPotionSelectMenu, "Vita Potion")
				end

				--	if concoctingLevel > 5 then
				--	end

				if concoctingLevel > 6 then
					table.insert(optsPotionSelectMenu, "Strong Vita Potion")
				end

				--	if concoctingLevel > 7 then
				--	end

				if concoctingLevel > 8 then
					table.insert(optsPotionSelectMenu, "Greater Vita Potion")
				end

				--	if concoctingLevel > 9 then
				--	end

				if concoctingLevel > 10 then
					table.insert(optsPotionSelectMenu, "Superior Vita Potion")
				end

				--	if concoctingLevel > 11 then
				--	end

				if concoctingLevel > 12 then
					table.insert(optsPotionSelectMenu, "Master Vita Potion")
				end

				--	if concoctingLevel > 13 then
				--	end

				--	if concoctingLevel > 14 then
				--	end

				--	if concoctingLevel > 15 then
				--	end

				--	if concoctingLevel > 16 then
				--	end

				if player.gmLevel > 0 then
					table.insert(optsPotionSelectMenu, "Small Vita Potion")
					table.insert(optsPotionSelectMenu, "Minor Vita Potion")
					table.insert(optsPotionSelectMenu, "Vita Potion")
					table.insert(optsPotionSelectMenu, "Strong Vita Potion")
					table.insert(optsPotionSelectMenu, "Greater Vita Potion")
					table.insert(optsPotionSelectMenu, "Superior Vita Potion")
					table.insert(optsPotionSelectMenu, "Master Vita Potion")
				end

				table.insert(optsPotionSelectMenu, "Finished Reading")

				potionRecipieMenuOption = player:menuString("Recipies", optsPotionSelectMenu)

				if potionRecipieMenuOption == "Small Vita Potion" then
					popup = "<b>          | " .. potionRecipieMenuOption .. " |\n"
					popup = popup .. "+=====================================+\n"
					popup = popup .. "             | Ingredients |            \n"
					popup = popup .. "             +=============+            \n "
					popup = popup .. "\n"
					popup = popup .. "1 Sanguine Powder\n"
					popup = popup .. "1 Small Empty Bottle\n"
					popup = popup .. "\n"

					player:popUp(popup)

					return
				elseif potionRecipieMenuOption == "Minor Vita Potion" then
					popup = "<b>          | " .. potionRecipieMenuOption .. " |\n"
					popup = popup .. "+=====================================+\n"
					popup = popup .. "             | Ingredients |            \n"
					popup = popup .. "             +=============+            \n "
					popup = popup .. "\n"
					popup = popup .. "1 Sanguine Powder\n"
					popup = popup .. "1 Empty Bottle\n"
					popup = popup .. "\n"

					player:popUp(popup)

					return
				elseif potionRecipieMenuOption == "Vita Potion" then
					popup = "<b>          | " .. potionRecipieMenuOption .. " |\n"
					popup = popup .. "+=====================================+\n"
					popup = popup .. "             | Ingredients |            \n"
					popup = popup .. "             +=============+            \n "
					popup = popup .. "\n"
					popup = popup .. "1 Sanguine Powder\n"
					popup = popup .. "1 Small Empty Bottle\n"
					popup = popup .. "1 Mushroom Enhancer\n"
					popup = popup .. "\n"

					player:popUp(popup)

					return
				elseif potionRecipieMenuOption == "Strong Vita Potion" then
					popup = "<b>          | " .. potionRecipieMenuOption .. " |\n"
					popup = popup .. "+=====================================+\n"
					popup = popup .. "             | Ingredients |            \n"
					popup = popup .. "             +=============+            \n "
					popup = popup .. "\n"
					popup = popup .. "1 Sanguine Powder\n"
					popup = popup .. "1 Small Empty Bottle\n"
					popup = popup .. "1 Mushroom Enhancer\n"
					popup = popup .. "1 Enhancement Powder\n"
					popup = popup .. "\n"

					player:popUp(popup)

					return
				elseif potionRecipieMenuOption == "Greater Vita Potion" then
					popup = "<b>          | " .. potionRecipieMenuOption .. " |\n"
					popup = popup .. "+=====================================+\n"
					popup = popup .. "             | Ingredients |            \n"
					popup = popup .. "             +=============+            \n "
					popup = popup .. "\n"
					popup = popup .. "1 Sanguine Powder\n"
					popup = popup .. "1 Small Empty Bottle\n"
					popup = popup .. "1 Mushroom Enhancer\n"
					popup = popup .. "\n"

					player:popUp(popup)

					return
				elseif potionRecipieMenuOption == "Finished Reading" then
					return
				else
					--player:sendMinitext("Potion Recipie 01.9")
					return
				end
			end
		end
	)
}

mana_potion_recipe = {
	use = function(player)
		player:freeAsync()
		player.lastClick = player.ID
		player.npcGraphic = 0
		player.dialogType = 0
		mana_potion_recipe.readRecipe(player)
	end,
	readRecipe = async(
		function(player, npc)
			local concoctingLevel = player.registry["concocting_level"]
			local makeMana = player.registry["mana_potion_knowledge"]

			local name
			local optsPotionSelectMenu = {}
			local potionRecipieMenuOption

			name = "<b>[Mana Potion Recipies]\n\n"

			if not player:canAction(1, 1, 1) then
				player:sendMinitext("You cannot do that right now!")
				return
			end

			if makeMana ~= 1 then
				player.registry["mana_potion_knowledge"] = 1
				player:dialogSeq(
					{name .. "You have read over the recipie and learned the basics steps for making a Mana Recovery potion!"},
					1
				)
			end

			if concoctingLevel ~= nil then
				if concoctingLevel > 0 then
					table.insert(optsPotionSelectMenu, "Small Mana Potion")
				end

				--	if concoctingLevel > 1 then
				--	end

				if concoctingLevel > 2 then
					table.insert(optsPotionSelectMenu, "Minor Mana Potion")
				end

				--	if concoctingLevel > 3 then
				--	end

				if concoctingLevel > 4 then
					table.insert(optsPotionSelectMenu, "Mana Potion")
				end

				--	if concoctingLevel > 5 then
				--	end

				if concoctingLevel > 6 then
					table.insert(optsPotionSelectMenu, "Strong Mana Potion")
				end

				--	if concoctingLevel > 7 then
				--	end

				if concoctingLevel > 8 then
					table.insert(optsPotionSelectMenu, "Greater Mana Potion")
				end

				--	if concoctingLevel > 9 then
				--	end

				if concoctingLevel > 10 then
					table.insert(optsPotionSelectMenu, "Superior Mana Potion")
				end

				--	if concoctingLevel > 11 then
				--	end

				if concoctingLevel > 12 then
					table.insert(optsPotionSelectMenu, "Master Mana Potion")
				end

				--	if concoctingLevel > 13 then
				--	end

				--	if concoctingLevel > 14 then
				--	end

				--	if concoctingLevel > 15 then
				--	end

				--	if concoctingLevel > 16 then
				--	end

				if player.gmLevel > 0 then
					table.insert(optsPotionSelectMenu, "Small Mana Potion")
					table.insert(optsPotionSelectMenu, "Minor Mana Potion")
					table.insert(optsPotionSelectMenu, "Mana Potion")
					table.insert(optsPotionSelectMenu, "Strong Mana Potion")
					table.insert(optsPotionSelectMenu, "Greater Mana Potion")
					table.insert(optsPotionSelectMenu, "Superior Mana Potion")
					table.insert(optsPotionSelectMenu, "Master Mana Potion")
				end

				table.insert(optsPotionSelectMenu, "Finished Reading")

				potionRecipieMenuOption = player:menuString("Recipies", optsPotionSelectMenu)

				if potionRecipieMenuOption == "Small Mana Potion" then
					popup = "<b>          | " .. potionRecipieMenuOption .. " |\n"
					popup = popup .. "+=====================================+\n"
					popup = popup .. "             | Ingredients |            \n"
					popup = popup .. "             +=============+            \n "
					popup = popup .. "\n"
					popup = popup .. "1 Cobalt Powder\n"
					popup = popup .. "1 Small Empty Bottle\n"
					popup = popup .. "\n"

					player:popUp(popup)

					return
				elseif potionRecipieMenuOption == "Minor Mana Potion" then
					popup = "<b>          | " .. potionRecipieMenuOption .. " |\n"
					popup = popup .. "+=====================================+\n"
					popup = popup .. "             | Ingredients |            \n"
					popup = popup .. "             +=============+            \n "
					popup = popup .. "\n"
					popup = popup .. "1 Cobalt Powder\n"
					popup = popup .. "1 Empty Bottle\n"
					popup = popup .. "\n"

					player:popUp(popup)

					return
				elseif potionRecipieMenuOption == "Mana Potion" then
					popup = "<b>          | " .. potionRecipieMenuOption .. " |\n"
					popup = popup .. "+=====================================+\n"
					popup = popup .. "             | Ingredients |            \n"
					popup = popup .. "             +=============+            \n "
					popup = popup .. "\n"
					popup = popup .. "1 Cobalt Powder\n"
					popup = popup .. "1 Small Empty Bottle\n"
					popup = popup .. "1 Mushroom Enhancer\n"
					popup = popup .. "\n"

					player:popUp(popup)

					return
				elseif potionRecipieMenuOption == "Strong Mana Potion" then
					popup = "<b>          | " .. potionRecipieMenuOption .. " |\n"
					popup = popup .. "+=====================================+\n"
					popup = popup .. "             | Ingredients |            \n"
					popup = popup .. "             +=============+            \n "
					popup = popup .. "\n"
					popup = popup .. "1 Cobalt Powder\n"
					popup = popup .. "1 Small Empty Bottle\n"
					popup = popup .. "1 Mushroom Enhancer\n"
					popup = popup .. "1 Enhancement Powder\n"
					popup = popup .. "\n"

					player:popUp(popup)

					return
				elseif potionRecipieMenuOption == "Greater Mana Potion" then
					popup = "<b>          | " .. potionRecipieMenuOption .. " |\n"
					popup = popup .. "+=====================================+\n"
					popup = popup .. "             | Ingredients |            \n"
					popup = popup .. "             +=============+            \n "
					popup = popup .. "\n"
					popup = popup .. "1 Cobalt Powder\n"
					popup = popup .. "1 Small Empty Bottle\n"
					popup = popup .. "1 Mushroom Enhancer\n"
					popup = popup .. "\n"

					player:popUp(popup)

					return
				elseif potionRecipieMenuOption == "Finished Reading" then
					return
				else
					--player:sendMinitext("Potion Recipie 01.9")
					return
				end
			end
		end
	)
}

shattering_potion_recipe = {
	use = function(player)
	end
}
