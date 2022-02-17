exhausted = {
	while_cast = function(player)
		player.paralyzed = true
		player:sendAnimation(324)
	end,
	uncast = function(player)
		player.paralyzed = false
		player:calcStat()
		player:sendMinitext("You are back on your feet.")
	end
}
