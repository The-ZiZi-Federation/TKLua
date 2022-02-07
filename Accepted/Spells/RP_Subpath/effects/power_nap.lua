power_nap = {
	cast = function(player)
		if player:hasDuration("inn_keeper") then
			player:setDuration("inn_keeper", 0)
		end
		if player:hasDuration("power_nap") then
			return
		end
		player.registry["mounted"] = 0
		if player.state ~= 1 then
			player:setDuration("power_nap", 4000)
			player.blind = 1
			player:lock()
			player:playSound(112)
		else
			player:sendAnimation(246)
			player:sendMinitext("Dia tidak berbicara dengan Hantu")
		end
	end,
	while_cast = function(player)
		player:lock()
		player.blind = 1
		player:sendAction(16, 400)
		player:sendAnimation(133)
	end,
	uncast = function(player)
		player:unlock()
		player.blind = 0
		player.state = 0
		player.magic = player.maxMagic
		player.health = player.maxHealth
		player:sendStatus()
		player:updateState()
		player:calcStat()
		player:sendAction(10, 60)
		player:sendAnimation(117)
		player:playSound(67)
		player:sendMinitext("You feel more healthy now")
	end
}
