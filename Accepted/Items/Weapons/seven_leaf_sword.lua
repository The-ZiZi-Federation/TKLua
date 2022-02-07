seven_leaf_sword = {
	on_swing = function(player)
		local pc = getTargetFacing(player, BL_PC)
		local mob = getTargetFacing(player, BL_MOB)
		local chance = math.random(100)

		player:playSound(700)
		if chance <= 20 then
			if pc ~= nil then
				if player:canPK(pc) and pc.state ~= 1 then
					pc.attacker = player.ID
					seven_leaf_sword.poison(pc)
				end
			end
			if mob ~= nil then
				mob.attacker = player.ID
				seven_leaf_sword.poison(mob)
			end
		end
	end,
	while_cast = function(player)
		local damage = player.health * .01

		player:sendAnimation(289)
		player:removeHealthExtend(damage, 1, 1, 1, 1, 0)
	end,
	uncast = function(player)
		local damage = player.health * .1

		player:sendAnimation(306)
		player:playSound(370)
		player:playSound(352)
		player:playSound(364)
		player:removeHealthExtend(damage, 1, 1, 1, 1, 0)
	end,
	poison = function(player)
		if player:hasDuration("seven_leaf_sword") then
			return
		end
		player:playSound(368)
		player:setDuration("seven_leaf_sword", 20000)
		player:sendAnimation(288)
		player:sendMinitext("You're infected by seven leaf's poison")
	end
}
