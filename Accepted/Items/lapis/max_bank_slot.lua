max_bank_slot = {
	use = function(player)
		local item = player:getInventoryItem(player.invSlot)

		if not player:canAction(1, 1, 1) then
			player:sendMinitext("You cannot do that right now!")
			return
		end

		if player:hasItem(item.yname, 1) == true then
			if player.maxSlots <= 99 then
				if player:removeItemSlot(player.invSlot, 1) == true then
					player:sendAction(10, 20)
					player:sendAnimation(2)
					player.maxSlots = player.maxSlots + 1
					player:updateState()
					player:sendStatus()
					player:sendMinitext("You gain 1 Maximum Bank Slot")
					player:talk(0, "" .. player.name .. ": More Storage!")
				end
			end
		end
	end
}
