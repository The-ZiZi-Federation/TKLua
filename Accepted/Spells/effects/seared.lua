seared = {
	while_cast = function(player)
		local anim = 188
		local damage = (player.health) * 0.023
		damage = math.floor(damage)

		player:sendAnimation(anim)
		player:removeHealth(damage)
		player:sendStatus()
	end,
	uncast = function(player)
		player:calcStat()
	end
}
