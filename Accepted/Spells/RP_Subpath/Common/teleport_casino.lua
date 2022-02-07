teleport_casino = {
	on_learn = function(player)
		player.registry["learned_teleport_casino"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_teleport_casino"] = 0
	end,
	cast = function(player)
		local RandomX = math.random(3, 5)
		local aether = 0

		if player.health <= 0 then
			player:sendMinitext("Spirits cannot use Gateway")
			return
		end
		if not player:canCast(1, 1, 0) then
			return
		end
		if player.warpOut > 0 then
			player:sendAnimation(246)
			player:sendMinitext("It doesn't work here")
			return
		end

		player:playSound(29)
		player:sendAnimation(16)
		player:sendAction(6, 20)
		player:setAether("teleport_casino", aether)
		player:sendMinitext("You cast Teleport Casino")
		player:warp(1042, RandomX, 17)
	end
}
