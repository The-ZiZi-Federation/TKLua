mana_surge = {
	while_cast = function(player, caster)
		local user = player.registry["mana_surge"]
		local dam = ((Player(user).maxMagic * .4) + (Player(user).will * 35)) * 5

		if player.blType == BL_PC then
			player.attackSpeed = 80
		elseif player.blType == BL_MOB then
			player.newMove = 2000
			player.newAttack = 2000
		end

		player:sendAnimation(394)
		player:removeHealthExtend(dam, 1, 1, 1, 1, 0)

		player:calcStat()
		player:updateSatus()
		player:sendStatus()
	end,
	uncast = function(player)
		player.registry["mana_surge"] = 0
		if player.blType == BL_PC then
			player.attackSpeed = 20
		end
		player:calcStat()
	end
}
