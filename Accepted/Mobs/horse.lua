horse = {
	on_mount = function(player, mob)
		local pc = player:getObjectsInArea(BL_PC)

		if player:hasDuration("dismounting") then
			player:sendMinitext("You need to wait a second to ride again!")
			return
		end
		player.state = 3
		player.disguise = 26
		mob:vanish2()
		player.speed = 70
		player:updateState()
		player.registry["wild_horse"] = 1
	end,
	move = function(mob, target)
		mob_ai_basic.move(mob, target)
	end,
	attack = function(mob, target)
		mob_ai_basic.attack(mob, target)
	end,
	on_attacked = function(mob, attacker)
		if mob.m == 1040 then
			return
		end

		if mob.health <= mob.maxHealth * .5 then
			mob.health = mob.maxHealth
			mob:sendStatus()
		end

		mob.attacker = attacker.ID
		mob:sendAnimation(301)
		attacker:playSound(353)

		mob:talk(2, attacker.name .. " damage: " .. format_number(math.ceil(attacker.damage)))
		mob_ai_basic.on_attacked(mob, attacker)
	end
}
