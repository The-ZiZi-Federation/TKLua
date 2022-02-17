skeletal_blademaster = {
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

		mob.registry["crush_timer"] = mob.registry["crush_timer"] + counter
		mob.registry["possess_timer"] = mob.registry["possess_timer"] + counter
		mob.registry["heal_timer"] = mob.registry["heal_timer"] + counter

		if mob.registry["crush_timer"] >= 14 then
			if facingPC ~= nil then
				skeletal_blademaster.crush(mob, facingPC)
				return
			end
		end

		if mob.registry["possess_timer"] >= 18 then
			if facingPC ~= nil then
				skeletal_blademaster.possess(mob, facingPC)
				return
			end
		end

		if mob.registry["heal_timer"] >= 20 then
			skeletal_blademaster.heal(mob)
			return
		end
	end,
	move = function(mob, target)
		mob_ai_basic.move(mob, target)
		skeletal_blademaster.magicCast(mob, target)
	end,
	attack = function(mob, target)
		mob_ai_basic.attack(mob, target)
		skeletal_blademaster.magicCast(mob, target)
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
		--	mob:talk(1,"skeletal_blademaster! YOU KILL MY BROTHER?! I KILL YOU!")
		mob.registry["crush_timer"] = 10
		mob.registry["possess_timer"] = 10
		mob.registry["heal_timer"] = 10
		mob.state = MOB_ALIVE
	end,
	crush = function(mob, target)
		local damage = math.random(270, 429)

		if mob.sleep ~= 1 then
			return
		end

		mob:talk(2, "Crush!")
		mob:playSound(98)
		mob:sendAction(1, 20)
		target:sendAnimation(68)
		target:removeHealthExtend(damage, 1, 1, 1, 1, 3)
		mob.registry["crush_timer"] = 0
	end,
	possess = function(mob, target)
		local r = math.random(1, 2000)
		local spellName = "Possess"
		local spellYname = "possess"
		local duration = 120000
		local anim = 111

		if mob.sleep ~= 1 then
			return
		end

		mob:playSound(98)
		mob:talk(2, "Your death will be swift!")

		if not target:hasDuration(spellYname) then
			target:sendMinitext("" .. mob.name .. " cast " .. spellName .. " on you")
			target:setDuration(spellYname, duration)
			target:sendAnimation(anim)
			target:calcStat()
		end

		mob.registry["possess_timer"] = 0
	end,
	heal = function(mob)
		if mob.sleep ~= 1 then
			return
		end

		mob:talk(2, "GRRRAHH!")
		mob:sendAnimation(5)
		mob:playSound(708)
		mob.health = mob.health + 1750
		if mob.health > mob.maxHealth then
			mob.health = mob.maxHealth
		end
		mob.registry["heal_timer"] = 0
	end
}
