demon_witch = {
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
		mob.registry["menacing_glare_timer"] = mob.registry["menacing_glare_timer"] + counter
		mob.registry["possess_timer"] = mob.registry["possess_timer"] + counter
		mob.registry["heal_timer"] = mob.registry["heal_timer"] + counter

		if mob.registry["strike_timer"] >= 16 then
			if facingPC ~= nil then
				demon_witch.strike(mob, facingPC)
				return
			end
		end

		if mob.registry["menacing_glare_timer"] >= 23 then
			if distanceSquare(mob, target, 7) then
				demon_witch.menacing_glare(mob, target)
				return
			end
		end

		if mob.registry["possess_timer"] >= 20 then
			if facingPC ~= nil then
				demon_witch.possess(mob, facingPC)
				return
			end
		end

		if mob.registry["heal_timer"] >= 25 then
			demon_witch.heal(mob)
			return
		end
	end,
	move = function(mob, target)
		mob_ai_basic.move(mob, target)
		demon_witch.magicCast(mob, target)
	end,
	attack = function(mob, target)
		mob_ai_basic.attack(mob, target)
		demon_witch.magicCast(mob, target)
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
		--	mob:talk(1,"demon_witch! YOU KILL MY BROTHER?! I KILL YOU!")
		mob.registry["strike_timer"] = 10
		mob.registry["menacing_glare_timer"] = 10
		mob.registry["possess_timer"] = 10
		mob.registry["heal_timer"] = 10
		mob.state = MOB_ALIVE
	end,
	strike = function(mob, target)
		local damage = math.random(315, 501)

		if mob.sleep ~= 1 then
			return
		end

		mob:talk(2, "Die!")
		mob:playSound(98)
		mob:sendAction(1, 20)
		target:sendAnimation(12)
		target:removeHealthExtend(damage, 1, 1, 1, 1, 3)
		mob.registry["strike_timer"] = 0
	end,
	menacing_glare = function(mob, target)
		local spellName = "Menacing Glare"
		local duration = 120000
		local anim = 88
		local damage = math.random(210, 334)

		if mob.sleep ~= 1 then
			return
		end

		mob:playSound(98)
		mob:talk(2, "You cannot hide!")

		target:sendMinitext("" .. mob.name .. " cast " .. spellName .. " on you")
		target:sendAnimation(anim)
		target:removeHealthExtend(damage, 1, 1, 1, 1, 3)
		target:calcStat()

		mob.registry["menacing_glare_timer"] = 0
	end,
	possess = function(mob, target)
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

		mob:talk(2, "Spirits, heal me!")
		mob:sendAnimation(5)
		mob:playSound(708)
		mob.health = mob.health + 2000
		if mob.health > mob.maxHealth then
			mob.health = mob.maxHealth
		end
		mob.registry["heal_timer"] = 0
	end
}

possess = {
	while_cast = function(player)
		player:sendAnimation(34)
	end,
	recast = function(player)
		player.armor = player.armor - 1000
		if player.armor < 0 then
			player.armor = 0
		end
	end,
	uncast = function(player)
		player:calcStat()
	end
}
