elemental_burst = {
	while_cast = function(player, caster)
		local user = player.registry["elemental_burst"]
		local dam = ((Player(user).maxMagic * .4) + (Player(user).will * 35)) * 5

		player:sendAnimation(107)
		player:sendAnimation(159)
		player:removeHealthExtend(dam, 1, 1, 1, 1, 0)

		player:calcStat()
		player:updateSatus()
		player:sendStatus()
	end,
	uncast = function(player)
		player.registry["elemental_burst"] = 0
		player:calcStat()
	end
}
