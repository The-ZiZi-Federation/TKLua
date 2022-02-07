sticky_bud = {
	use = function(player)
		local item = player:getInventoryItem(player.invSlot)

		if not player:canAction(1, 1, 1) then
			player:sendMinitext("You cannot do that right now!")
			return
		else
			if player:hasItem(item.yname, 1) == true then
				player:deductDuraInv(player.invSlot, 1)
				player:sendAction(8, 20)
				player:sendAnimation(292)
				player:setDuration("christmas", 10000)
				player:playSound(22)
			end
			player:sendStatus()
		end
	end
}
