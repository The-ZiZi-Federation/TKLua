facial_hair = {
	use = function(player)
		player:freeAsync()
		player.lastClick = player.ID
		facial_hair.click(player)
	end,
	click = async(
		function(player, npc)
			local item = player:getInventoryItem(player.invSlot)
			local facialHair = item.look

			if not player:canAction(1, 1, 1) then
				player:sendMinitext("You cannot do that right now!")
				return
			end

			if player.registry["facial_hair_" .. facialHair] == 0 then
				if player:hasItem(item.name, 1) == true then
					if player:removeItemSlot(player.invSlot, 1) == true then
						player:sendAction(10, 20)
						player:sendAnimation(2)
						player.registry["facial_hair_" .. facialHair] = 1
						player:updateState()
						player:sendStatus()
						player:sendMinitext("You got a new facial hair look! Visit the barber to try it out!")
						menu =
							player:menuString(
							"A new facial hair look was added to your collection. Would you like to equip it now?",
							{"Yes", "No"}
						)
					end
				end

				if menu == "Yes" then
					facial_hair.change(player, facialHair)
				end
			else
				player:popUp("You already have this style in your collection!")
			end
		end
	),
	change = function(player, facialHair)
		player.faceAccessoryTwo = facialHair
		player:updateState()
	end
}
