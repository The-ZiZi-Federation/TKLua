dragon_fire = {
	cast = function(player)
	end,
	while_cast = function(player)
		player:sendAnimation(94)
		player:lock()
	end,
	uncast = function(player)
		player:unlock()
		player:sendStatus()
		player:calcStat()
	end
}
