item_break_protection = {
	use = function(player)
		player:freeAsync()
		player.lastClick = player.ID
		item_break_protection.click(player)
	end,
	click = async(
		function(player, npc)
			local t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0

			local item = player:getInventoryItem(player.invSlot)
			local opts = {
				"Weapon",
				"Armor",
				"Helm",
				"Shield",
				"Left Hand",
				"Right Hand",
				"Left Accessory",
				"Right Accessory",
				"Necklace"
			}

			local protectedItem = ""

			if not player:canAction(1, 1, 1) then
				player:sendMinitext("You cannot do that right now!")
				return
			end

			menu = player:menuString("What equipment slot would you like to protect?", opts)

			protectedItem = string.lower(menu)

			if player:removeItemSlot(player.invSlot, 1) == true then
				player.registry["" .. protectedItem .. "_protected"] = player.registry["" .. protectedItem .. "_protected"] + 1
				player:sendMinitext("Your " .. protectedItem .. " slot is protected from breaking on death!")
				player:sendMinitext(
					"Total protections on " .. protectedItem .. " slot: " .. player.registry["" .. protectedItem .. "_protected"]
				)
			else
				player:sendMinitext("Something went wrong...")
			end
		end
	)
}
