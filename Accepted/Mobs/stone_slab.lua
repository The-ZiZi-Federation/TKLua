stone_slab1 = {
	on_spawn = function(mob)
		mob.side = 2
		mob:sendSide()
	end,
	on_attacked = function(mob, attacker)
		local health = mob.maxHealth * .8

		mob_ai_basic.on_attacked(mob, attacker)

		--	Player(4):talk(0, "1")
		if mob.health <= health then
			mob:removeHealth(mob.health)
		end
	end,
	after_death = function(mob)
		mob:spawn(83, mob.x, mob.y, 1, mob.m)
	end
}

stone_slab2 = {
	on_spawn = function(mob)
		mob:removeHealthWithoutDamageNumbers(20000)
		mob.side = 2
		mob:sendSide()
	end,
	on_attacked = function(mob, attacker)
		local health = mob.maxHealth * .6

		mob_ai_basic.on_attacked(mob, attacker)

		--	Player(4):talk(0, "1")
		if mob.health <= health then
			mob:removeHealth(mob.health)
		end
	end,
	after_death = function(mob)
		mob:spawn(3004, mob.x, mob.y, 1, mob.m)
	end
}

stone_slab3 = {
	on_spawn = function(mob)
		mob:removeHealthWithoutDamageNumbers(40000)
		mob.side = 2
		mob:sendSide()
	end,
	on_attacked = function(mob, attacker)
		local health = mob.maxHealth * .4

		mob_ai_basic.on_attacked(mob, attacker)

		--	Player(4):talk(0, "1")
		if mob.health <= health then
			mob:removeHealth(mob.health)
		end
	end,
	after_death = function(mob)
		mob:spawn(3005, mob.x, mob.y, 1, mob.m)
	end
}

stone_slab4 = {
	on_spawn = function(mob)
		mob:removeHealthWithoutDamageNumbers(60000)
		mob.side = 2
		mob:sendSide()
	end,
	on_attacked = function(mob, attacker)
		local health = mob.maxHealth * .2

		mob_ai_basic.on_attacked(mob, attacker)

		--	Player(4):talk(0, "1")
		if mob.health <= health then
			mob:removeHealth(mob.health)
		end
	end,
	after_death = function(mob)
		mob:spawn(3006, mob.x, mob.y, 1, mob.m)
	end
}

stone_slab5 = {
	on_spawn = function(mob)
		mob:removeHealthWithoutDamageNumbers(80000)
		mob.side = 2
		mob:sendSide()
	end,
	on_attacked = function(mob, attacker)
		mob_ai_basic.on_attacked(mob, attacker)
	end,
	after_death = function(mob)
		--	mob:spawn(3004, mob.x, mob.y, 1, mob.m)
	end
}
