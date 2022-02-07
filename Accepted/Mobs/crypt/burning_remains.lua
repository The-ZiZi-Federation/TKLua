burning_remains = {
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

		mob.registry["strike_timer"] = mob.registry["strike_timer"] + counter
		mob.registry["anguish_timer"] = mob.registry["anguish_timer"] + counter
		mob.registry["haunt_timer"] = mob.registry["haunt_timer"] + counter
		mob.registry["heal_timer"] = mob.registry["heal_timer"] + counter

		if mob.registry["strike_timer"] >= 20 then
			if facingPC ~= nil then
				burning_remains.strike(mob, facingPC)
				return
			end
		end

		if mob.registry["anguish_timer"] >= 3 then
			if distanceSquare(mob, target, 7) then
				burning_remains.anguish(mob, target)
				return
			end
		end

		if mob.registry["haunt_timer"] >= 15 then
			if facingPC ~= nil then
				burning_remains.haunt(mob, facingPC)
				return
			end
		end

		if mob.registry["heal_timer"] >= 16 then
			burning_remains.heal(mob)
			return
		end
	end,
	move = function(mob, target)
		mob_ai_basic.move(mob, target)
		burning_remains.magicCast(mob, target)
	end,
	attack = function(mob, target)
		mob_ai_basic.attack(mob, target)
		burning_remains.magicCast(mob, target)
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
		mob:talk(1, "Burning Remains! Who dares enter the Crypt?!")
		mob.registry["strike_timer"] = 10
		mob.registry["anguish_timer"] = 10
		mob.registry["haunt_timer"] = 10
		mob.registry["heal_timer"] = 10
		mob.state = MOB_ALIVE
	end,
	strike = function(mob, target)
		local damage = math.random(225, 300)

		if mob.sleep ~= 1 then
			return
		end

		mob:talk(2, "Feel my wrath!")
		mob:playSound(98)
		mob:sendAction(1, 20)
		target:sendAnimation(12)
		target:removeHealthExtend(damage, 1, 1, 1, 1, 3)
		mob.registry["strike_timer"] = 0
	end,
	anguish = function(mob, target)
		local spellName = "Anguish"
		local anim = 17
		local damage = math.random(150, 225)

		if mob.sleep ~= 1 then
			return
		end

		mob:playSound(98)
		mob:talk(2, "Die, mortal!")

		target:sendMinitext("" .. mob.name .. " cast " .. spellName .. " on you")
		target:sendAnimation(anim)
		target:removeHealthExtend(damage, 1, 1, 1, 1, 3)
		target:calcStat()

		mob.registry["anguish_timer"] = 0
	end,
	haunt = function(mob, target)
		local r = math.random(1, 2000)
		local spellName = "Haunt"
		local spellYname = "haunt"
		local duration = 100000
		local anim = 1

		if mob.sleep ~= 1 then
			return
		end

		mob:playSound(98)
		mob:talk(2, "You will pay for your insolence!")

		if not target:hasDuration(spellYname) then
			target:sendMinitext("" .. mob.name .. " cast " .. spellName .. " on you")
			target:setDuration(spellYname, duration)
			target:sendAnimation(anim)
			target:calcStat()
		end

		mob.registry["haunt_timer"] = 0
	end,
	heal = function(mob)
		if mob.sleep ~= 1 then
			return
		end

		mob:talk(2, "You cannot defeat me!")
		mob:sendAnimation(5)
		mob:playSound(708)
		mob.health = mob.health + 1200
		if mob.health > mob.maxHealth then
			mob.health = mob.maxHealth
		end
		mob.registry["heal_timer"] = 0
	end
}
