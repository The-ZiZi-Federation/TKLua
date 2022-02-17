surge = {
	while_cast = function(player, caster)
		local user = player.registry["surge"]
		local dam = ((Player(user).maxMagic * .4) + (Player(user).will * 35)) * 5

		player:sendAnimation(290)
		player:sendAnimation(256)
		player:removeHealthExtend(dam, 1, 1, 1, 1, 0)

		player:calcStat()
		player:updateSatus()
		player:sendStatus()
	end,
	uncast = function(player)
		player.registry["surge"] = 0
		player:calcStat()
	end
}
