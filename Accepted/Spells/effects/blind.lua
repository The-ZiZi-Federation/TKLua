blind = {
	cast = function(player)
		player.paralyzed = true
		player:sendStatus()
	end,
	while_cast = function(player)
		player:sendAnimation(1)
		player.blind = 1
		player.paralyzed = true
	end,
	uncast = function(player)
		player.blind = 0
		player.paralyzed = false
		player:calcStat()
	end
}
