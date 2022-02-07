max_inv_slot = {
	use = function(player)
		local item = player:getInventoryItem(player.invSlot)

		if not player:canAction(1, 1, 1) then
			player:sendMinitext("You cannot do that right now!")
			return
		end

		if player:hasItem(item.yname, 1) == true then
			if player.maxInv <= 51 then
				if player:removeItemSlot(player.invSlot, 1) == true then
					player:sendAction(10, 20)
					player:sendAnimation(2)
					player.maxInv = player.maxInv + 1
					player:updateState()
					player:sendStatus()
					player:sendMinitext("You gain 1 Maximum Inventory Slot")
					player:talk(0, "" .. player.name .. ": More Loot!")
				end
			end
		end
	end
}
