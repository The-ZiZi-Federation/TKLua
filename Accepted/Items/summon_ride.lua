summon_ride = {
	use = function(player)
		local mount = player.registry["summoned_mount"]
		local item = player:getInventoryItem(player.invSlot)

		if (not player:canAction(1, 1, 1)) then
			return
		end

		if mount > 0 then
			player:sendMinitext("Nullified summoned mount")
			player:sendAction(5, 60)
			player.registry["summoned_mount"] = 0
			player.registry["mount_speed"] = 0
			return
		else
			player:sendMinitext("Summoning " .. item.name)
			player:sendAction(6, 60)
			player:sendAnimation(355, 0)
			player:playSound(60)
			player.registry["summoned_mount"] = item.look
			player.registry["mount_speed"] = item.level
			player.disguise = player.registry["summoned_mount"]
			player.speed = player.registry["mount_speed"]
			player.state = 3
			player:updateState()
			player:sendStatus()
		end
	end
}
