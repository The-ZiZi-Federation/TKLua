shock = {
	while_cast = function(player)
		player:sendAnimation(143)
	end,
	while_cast_250 = function(player)
		player.paralyzed = true
	end,
	uncast = function(player)
		player.paralyzed = false
		player:calcStat()
	end
}
