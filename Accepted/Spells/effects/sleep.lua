asleep = {
	while_cast = function(player)
		player:sendAnimation(2)
	end,
	uncast = function(player)
		player.sleep = 1.0
		player:calcStat()
	end,
	on_takedamage_while_cast = function(player)
		player:setDuration("asleep", 0)
	end
}
