costume = {
	cast = function(player)
		local duration = 30000
		local anim = 3

		local facingPC = getTargetFacing(player, BL_PC)
		local facingNPC = getTargetFacing(player, BL_NPC)
		local facingMob = getTargetFacing(player, BL_MOB)

		if facingPC ~= nil then
			if facingPC.ID < 250 then
				if player.gmLevel < 1 then
					frog.cast(facingPC, player)
					return
				end
			end
			if facingPC.state ~= 4 then
				clone.playerToPlayer(player, facingPC)
			else
				player.disguise = facingPC.disguise
				player.disguiseColor = facingPC.lookColor
				player.state = 4
				player:updateState()
			end
		end

		if facingNPC ~= nil then
			player.disguise = facingNPC.look
			player.disguiseColor = facingNPC.lookColor
			player.state = 4
			player:updateState()
		end

		if facingMob ~= nil then
			player.disguise = facingMob.look
			player.disguiseColor = facingMob.lookColor
			player.state = 4
			player:updateState()
		end

		player:sendAnimation(anim)
		player:setDuration("costume", duration)
	end,
	uncast = function(player)
		local anim = 3

		if player.state == 4 then
			player.state = 0
			player:updateState()
		end
		clone.wipe(player)
		player:sendAnimation(anim)
	end
}
