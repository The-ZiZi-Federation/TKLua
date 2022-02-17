magic_saddle_brown = {
	use = function(player)
		local item = player:getInventoryItem(player.invSlot)

		if player.m == 15000 or player.m == 15010 or player.m == 15011 then
			player:sendMinitext("Can't ride here!")
			return
		end

		if player.registry["mounted"] == 0 and player.state == 0 then
			player.state = 3
			player.registry["summoned_mount"] = item.look
			player.registry["mount_speed"] = item.level
			player.disguise = player.registry["summoned_mount"]
			player.speed = player.registry["mount_speed"]
			player:updateState()
			player.registry["mounted"] = 1
			player:sendMinitext("You are now mounted")
		elseif player.registry["mounted"] == 1 and player.state == 3 then
			player.state = 0
			player.speed = 90
			player:updateState()
			player:sendStatus()
			player.registry["summoned_mount"] = 0
			player.registry["mount_speed"] = 0
			player.registry["mounted"] = 0
			player:sendMinitext("You are no longer mounted")
		end
		--	end
	end
}

magic_saddle_white = {
	use = function(player)
		local item = player:getInventoryItem(player.invSlot)

		if player.m == 15000 or player.m == 15010 or player.m == 15011 then
			player:sendMinitext("Can't ride here!")
			return
		end

		if player.registry["mounted"] == 0 and player.state == 0 then
			player.state = 3
			player.registry["summoned_mount"] = item.look
			player.registry["mount_speed"] = item.level
			player.disguise = player.registry["summoned_mount"]
			player.speed = player.registry["mount_speed"]
			player:updateState()
			player.registry["mounted"] = 1
			player:sendMinitext("You are now mounted")
		elseif player.registry["mounted"] == 1 and player.state == 3 then
			player.state = 0
			player.speed = 90
			player:updateState()
			player:sendStatus()
			player.registry["summoned_mount"] = 0
			player.registry["mount_speed"] = 0
			player.registry["mounted"] = 0
			player:sendMinitext("You are no longer mounted")
		end
	end
}

magic_saddle_black = {
	use = function(player)
		local item = player:getInventoryItem(player.invSlot)

		if player.m == 15000 or player.m == 15010 or player.m == 15011 then
			player:sendMinitext("Can't ride here!")
			return
		end
		if player.registry["mounted"] == 0 and player.state == 0 then
			player.state = 3
			player.registry["summoned_mount"] = item.look
			player.registry["mount_speed"] = item.level
			player.disguise = player.registry["summoned_mount"]
			player.speed = player.registry["mount_speed"]
			player:updateState()
			player.registry["mounted"] = 1
			player:sendMinitext("You are now mounted")
		elseif player.registry["mounted"] == 1 and player.state == 3 then
			player.state = 0
			player.speed = 90
			player:updateState()
			player:sendStatus()
			player.registry["summoned_mount"] = 0
			player.registry["mount_speed"] = 0
			player.registry["mounted"] = 0
			player:sendMinitext("You are no longer mounted")
		end
	end
}
