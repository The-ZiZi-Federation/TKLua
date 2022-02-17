toxic_poison = {
	while_cast = function(player, caster)
		local user = player.registry["toxic_poison"]
		local dam = ((Player(user).maxMagic * .5) + (Player(user).will * 50)) * 6

		player:sendAnimation(289)

		player:removeHealthExtend(dam, 1, 1, 1, 1, 0)
		player:calcStat()
		player:updateSatus()
		player:sendStatus()
	end,
	uncast = function(player)
		player.registry["toxic_poison"] = 0
		player:calcStat()
	end
}
