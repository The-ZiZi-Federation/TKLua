gloth = {
	magicCast = function(mob, target)
		--	local areaPC = mob:getObjectsInArea(BL_PC)
		--	local r = math.random(1, #areaPC)
		--	local targetPC = areaPC[r]
		--	mob:talk(0,""..target.name)
		local pc = mob:getObjectsInArea(BL_PC)
		local targetPC = target
		local facingPC = getTargetFacing(mob, BL_PC)
		local counter = math.random(0, 2)

		if #pc == 0 then
			return
		end
		if target == nil then
			return
		end
		if target.m ~= mob.m then
			return
		end
		if mob.paralyzed == true or mob.sleep > 1 or mob.blind then
			return
		end

		mob.registry["strike1_timer"] = mob.registry["strike1_timer"] + counter
		mob.registry["strike2_timer"] = mob.registry["strike2_timer"] + counter
		mob.registry["singe_timer"] = mob.registry["singe_timer"] + counter
		mob.registry["ignite_timer"] = mob.registry["ignite_timer"] + counter
		mob.registry["acidic_film_timer"] = mob.registry["acidic_film_timer"] + counter
		mob.registry["heal_timer"] = mob.registry["heal_timer"] + counter

		--	mob:talk(0,"leapTimer: "..mob.registry["leap_timer"])

		--mob:talk(0,"healTimer: "..mob.registry["heal_timer"])
		mob:sendAnimation(375)

		if mob.registry["strike1_timer"] >= 18 then
			if facingPC ~= nil then
				gloth.strike1(mob, facingPC)
				return
			end
		end

		if mob.registry["strike2_timer"] >= 28 then
			if facingPC ~= nil then
				gloth.strike2(mob, facingPC)
				return
			end
		end

		if mob.registry["acidic_film_timer"] >= 22 then
			if facingPC ~= nil then
				gloth.acidicfilm(mob, facingPC)
				return
			end
		end

		if mob.registry["singe_timer"] >= 25 then
			if distanceSquare(mob, target, 6) then
				gloth.singe(mob, targetPC)
				return
			end
		end

		if mob.registry["ignite_timer"] >= 3 then
			if distanceSquare(mob, targetPC, 1) then
				gloth.ignite(mob, targetPC)
				return
			end
		end

		if mob.registry["heal_timer"] >= 30 then
			gloth.heal(mob)
			return
		end
	end,
	move = function(mob, target)
		mob_ai_basic.move(mob, target)
		gloth.magicCast(mob, target)
	end,
	attack = function(mob, target)
		mob_ai_basic.attack(mob, target)
		gloth.magicCast(mob, target)
	end,
	on_healed = function(mob, healer)
		mob.attacker = healer.ID
		mob:sendHealth(healer.damage, healer.critChance)
		healer.damage = 0
	end,
	on_attacked = function(mob, attacker)
		mob_ai_basic.on_attacked(mob, attacker)
	end,
	on_spawn = function(mob)
		--	mob:talk(1,"gloth! YOU KILL MY BROTHER?! I KILL YOU!")
		mob.registry["strike1_timer"] = 10
		mob.registry["strike2_timer"] = 10
		mob.registry["singe_timer"] = 10
		mob.registry["ignite_timer"] = 10
		mob.registry["acidic_film_timer"] = 10
		mob.registry["heal_timer"] = 10
		mob.state = MOB_ALIVE
	end,
	strike1 = function(mob, target)
		local damage = math.random(300, 478)

		if mob.sleep ~= 1 then
			return
		end

		mob:talk(2, "GLOTH SMASH!")
		mob:playSound(98)
		mob:sendAction(1, 20)
		target:sendAnimation(68)
		target:removeHealthExtend(damage, 1, 1, 1, 1, 3)
		mob.registry["strike1_timer"] = 0
	end,
	strike2 = function(mob, target)
		local damage = math.random(450, 717)

		if mob.sleep ~= 1 then
			return
		end

		mob:talk(2, "GRRRRRRRRARRRRR!")
		mob:playSound(98)
		mob:sendAction(1, 20)
		target:sendAnimation(67)
		target:removeHealthExtend(damage, 1, 1, 1, 1, 3)
		mob.registry["strike2_timer"] = 0
	end,
	acidicfilm = function(mob, target)
		local r = math.random(1, 2000)
		local spellName = "Acidic Film"
		local spellYname = "acidic_film"
		local duration = 120000
		local anim = 111

		if mob.sleep ~= 1 then
			return
		end

		mob:playSound(98)
		mob:sendAnimation(27)
		mob:talk(2, "GLOTH SPIT")

		if not target:hasDuration(spellYname) then
			target:sendMinitext("" .. mob.name .. " cast " .. spellName .. " on you")
			target:setDuration(spellYname, duration)
			target:sendAnimation(anim)
			target:calcStat()
		end

		mob.registry["acidic_film_timer"] = 0
	end,
	singe = function(mob, target)
		mob:talk(2, "RRRAAAAGGGGHHH!")
		mob:sendAnimation(30)
		mob:playSound(60)
		mob.registry["singe_timer"] = 0
	end,
	ignite = function(mob, target)
		local damage = math.random(300, 478)

		if mob.sleep ~= 1 then
			return
		end

		target:sendAnimation(4)
		target:removeHealthExtend(damage, 1, 1, 1, 1, 3)
		mob:playSound(60)
		mob.registry["ignite_timer"] = 0
	end,
	heal = function(mob)
		if mob.sleep ~= 1 then
			return
		end

		mob:talk(2, "GRRRAHH!")
		mob:sendAnimation(5)
		mob:playSound(708)
		mob.health = mob.health + 3500
		if mob.health > mob.maxHealth then
			mob.health = mob.maxHealth
		end
		mob.registry["heal_timer"] = 0
	end
}

acidic_film = {
	while_cast = function(player)
		player:sendAnimation(34)
	end,
	recast = function(player)
		player.armor = player.armor - 1250
		if player.armor < 0 then
			player.armor = 0
		end
	end,
	uncast = function(player)
		player:calcStat()
	end
}
