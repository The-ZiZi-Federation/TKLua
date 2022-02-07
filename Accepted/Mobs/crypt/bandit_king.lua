bandit_king = {
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
		mob.registry["sunder_timer"] = mob.registry["sunder_timer"] + counter
		mob.registry["heal_timer"] = mob.registry["heal_timer"] + counter

		--	mob:talk(0,"knife_throwTimer: "..mob.registry["knife_throw_timer"])

		--mob:talk(0,"healTimer: "..mob.registry["heal_timer"])

		if mob.registry["strike1_timer"] >= 14 then
			if facingPC ~= nil then
				bandit_king.strike1(mob, facingPC)
				return
			end
		end

		if mob.registry["strike2_timer"] >= 25 then
			if facingPC ~= nil then
				bandit_king.strike2(mob, facingPC)
				return
			end
		end

		if mob.registry["sunder_timer"] >= 20 then
			if facingPC ~= nil then
				bandit_king.sunder(mob, facingPC)
				return
			end
		end

		if mob.registry["heal_timer"] >= 26 then
			bandit_king.heal(mob)
			return
		end
	end,
	move = function(mob, target)
		mob_ai_basic.move(mob, target)
		bandit_king.magicCast(mob, target)
	end,
	attack = function(mob, target)
		mob_ai_basic.attack(mob, target)
		bandit_king.magicCast(mob, target)
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
		--	mob:talk(1,""..mob.name.."! TEXT GOES HERE!")
		mob.registry["strike1_timer"] = 10
		mob.registry["strike2_timer"] = 10
		mob.registry["sunder_timer"] = 10
		mob.registry["heal_timer"] = 10
		mob.state = MOB_ALIVE
	end,
	strike1 = function(mob, target)
		local damage = math.random(510, 812)

		if mob.sleep ~= 1 then
			return
		end

		mob:talk(2, "INTRUDER!")
		mob:playSound(98)
		mob:sendAction(1, 20)
		target:sendAnimation(68)
		target:removeHealthExtend(damage, 1, 1, 1, 1, 3)
		mob.registry["strike1_timer"] = 0
	end,
	strike2 = function(mob, target)
		local damage = math.random(765, 1218)

		if mob.sleep ~= 1 then
			return
		end

		mob:talk(2, "PERISH!")
		mob:playSound(98)
		mob:sendAction(1, 20)
		target:sendAnimation(140)
		target:removeHealthExtend(damage, 1, 1, 1, 1, 3)
		mob.registry["strike2_timer"] = 0
	end,
	sunder = function(mob, target)
		if mob.sleep ~= 1 then
			return
		end

		mob:playSound(98)
		if not target:hasDuration("sunder") then
			mob:talk(2, "Puny surface dweller!")
			target:sendMinitext("" .. mob.name .. " cast Sunder on you")
			target:setDuration("sunder", 175000)
			target:sendAnimation(111)
			target:calcStat()
		end

		mob.registry["sunder_timer"] = 0
	end,
	heal = function(mob)
		if mob.sleep ~= 1 then
			return
		end

		mob:talk(2, "GRRRAHH!")
		mob:sendAnimation(5)
		mob:playSound(98)
		mob.health = mob.health + 60000
		if mob.health > mob.maxHealth then
			mob.health = mob.maxHealth
		end
		mob.registry["heal_timer"] = 0
	end
}

sunder = {
	while_cast = function(player)
		player:sendAnimation(34)
	end,
	recast = function(player)
		player.armor = player.armor - 2500
		if player.armor < 0 then
			player.armor = 0
		end
	end,
	uncast = function(player)
		player:calcStat()
	end
}
