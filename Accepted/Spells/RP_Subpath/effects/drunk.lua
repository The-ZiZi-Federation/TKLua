drunk = {
	oncast = function(player)
		if player:hasDuration("drunk") then
			return
		end
	end,
	while_cast = function(player)
		player.drunk = 1
		player:sendAnimation(318)
	end,
	uncast = function(player)
		player.drunk = 0
	end
}
