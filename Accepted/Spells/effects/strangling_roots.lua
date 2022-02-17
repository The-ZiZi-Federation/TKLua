strangling_roots = {
	cast = function(player)
		player.paralyzed = true
		player:sendStatus()
	end,
	while_cast = function(player)
		player:sendAnimation(399)
		player.paralyzed = true
		--player:removeHealth(250)
	end,
	uncast = function(player)
		player.paralyzed = false
		player:calcStat()
	end
}
