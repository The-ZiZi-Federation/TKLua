spelltest = {
	cast = function(player)
		player:setDuration("spelltest", 30000)
	end,
	while_cast_250 = function(player)
		player.actionTime = 0
	end
}
