demonic_possession = {
	cast = function(player, target)
		player.state = 2
		player:updateState()
		player:setDuration("demonic_possession", 10000)
		target.registry["demonic_possession"] = player.ID
		target.target = 0
	end,
	while_cast = function(player, target)
	end,
	uncast = function(player, target)
	end
}
