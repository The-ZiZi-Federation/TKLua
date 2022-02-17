eat_food = {
	use = function(player)
		local item = player:getInventoryItem(player.invSlot)

		if not player:canAction(1, 1, 1) then
			return
		end
		if player.health <= 0 then
			player:sendMinitext("You need a physical body in order to eat.")
			return
		end

		if player:hasItem(item.yname, 1) == true then
			--	if player:removeItemSlot(player.invSlot, 1) == true then

			player:sendAction(7, 20)
			addHealth(player, item.look)
			player:playSound(22)
		--	end
		end
	end
}
