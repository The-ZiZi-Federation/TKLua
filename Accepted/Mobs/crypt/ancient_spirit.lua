ancient_spirit = {
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

		mob.registry["dispel_timer"] = mob.registry["dispel_timer"] + counter
		mob.registry["strike1_timer"] = mob.registry["strike1_timer"] + counter
		mob.registry["sunder_timer"] = mob.registry["sunder_timer"] + counter
		mob.registry["flesh_peel_timer"] = mob.registry["flesh_peel_timer"] + counter
		mob.registry["heal_timer"] = mob.registry["heal_timer"] + counter

		--	mob:talk(0,"flesh_peelTimer: "..mob.registry["flesh_peel_timer"])

		--mob:talk(0,"healTimer: "..mob.registry["heal_timer"])

		if mob.registry["dispel_timer"] >= 5 then
			ancient_spirit.dispel(mob)
			return
		end

		if mob.registry["strike1_timer"] >= 11 then
			if facingPC ~= nil then
				ancient_spirit.strike1(mob, facingPC)
				return
			end
		end

		if mob.registry["sunder_timer"] >= 21 then
			if facingPC ~= nil then
				ancient_spirit.sunder(mob, facingPC)
				return
			end
		end

		if mob.registry["flesh_peel_timer"] >= 14 then
			if distanceSquare(mob, target, 6) then
				ancient_spirit.flesh_peel(mob, targetPC)
				return
			end
		end

		if mob.registry["heal_timer"] >= 24 then
			ancient_spirit.heal(mob)
			return
		end
	end,
	move = function(mob, target)
		mob_ai_basic.move(mob, target)
		ancient_spirit.magicCast(mob, target)
	end,
	attack = function(mob, target)
		mob_ai_basic.attack(mob, target)
		ancient_spirit.magicCast(mob, target)
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
		mob:talk(1, "" .. mob.name .. "! WHO DARES TO DISTURB US?")
		mob.registry["singe_timer"] = 10
		mob.registry["strike1_timer"] = 10
		mob.registry["strike2_timer"] = 10
		mob.registry["sunder_timer"] = 10
		mob.registry["flesh_peel_timer"] = 10
		mob.registry["heal_timer"] = 10
		mob.state = MOB_ALIVE
	end,
	dispel = function(mob)
		if not mob:hasDuration("asleep") then
			mob:sendAnimation(58)
			mob:playSound(98)
			mob:flushDuration()
			mob.registry["dispel_timer"] = 0
		end
	end,
	strike1 = function(mob, target)
		local damage = math.random(24525, 39018)

		if mob.sleep ~= 1 then
			return
		end

		mob:talk(2, "JOIN US")
		mob:playSound(98)
		mob:sendAction(1, 20)
		target:sendAnimation(140)
		target:removeHealthExtend(damage, 1, 1, 1, 1, 3)
		mob.registry["strike1_timer"] = 0
	end,
	sunder = function(mob, target)
		if mob.sleep ~= 1 then
			return
		end

		mob:playSound(98)
		if not target:hasDuration("sunder") then
			mob:talk(2, "YOU WILL NOT SURVIVE")
			target:sendMinitext("" .. mob.name .. " cast Sunder on you")
			target:setDuration("sunder", 215000)
			target:sendAnimation(111)
			target:calcStat()
		end

		mob.registry["sunder_timer"] = 0
	end,
	flesh_peel = function(mob, target)
		local spellName = "Flesh Peel"
		local anim = 404
		local damage = math.random(16350, 26012)

		if mob.sleep ~= 1 then
			return
		end

		mob:playSound(98)
		mob:talk(2, "RUN!")

		target:sendMinitext("" .. mob.name .. " cast " .. spellName .. " on you")
		target:sendAnimation(anim)
		target:removeHealthExtend(damage, 1, 1, 1, 1, 3)
		target:calcStat()

		mob.registry["flesh_peel_timer"] = 0
	end,
	heal = function(mob)
		if mob.sleep ~= 1 then
			return
		end

		mob:talk(2, "SPIRITS AID ME")
		mob:sendAnimation(5)
		mob:playSound(98)
		mob.health = mob.health + 350000
		if mob.health > mob.maxHealth then
			mob.health = mob.maxHealth
		end
		mob.registry["heal_timer"] = 0
	end
}

sunder_lv2 = {
	while_cast = function(player)
		player:sendAnimation(34)
	end,
	recast = function(player)
		player.armor = player.armor - 10000
		if player.armor < 0 then
			player.armor = 0
		end
	end,
	uncast = function(player)
		player:calcStat()
	end
}
