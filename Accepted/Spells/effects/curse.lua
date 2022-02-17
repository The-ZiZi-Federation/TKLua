curse = {
	cast = function(player)
		player.armor = player.armor - 100
		player:sendStatus()
	end,
	while_cast = function(player)
	end,
	uncast = function(player)
		player.armor = player.armor + 100
		player:sendStatus()
	end
}
