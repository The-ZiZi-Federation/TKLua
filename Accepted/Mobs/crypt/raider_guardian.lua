raider_guardian = {
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

		mob.registry["singe_timer"] = mob.registry["singe_timer"] + counter
		mob.registry["strike1_timer"] = mob.registry["strike1_timer"] + counter
		mob.registry["strike2_timer"] = mob.registry["strike2_timer"] + counter
		mob.registry["weaken_armor_timer"] = mob.registry["weaken_armor_timer"] + counter
		mob.registry["knife_throw_timer"] = mob.registry["knife_throw_timer"] + counter
		mob.registry["heal_timer"] = mob.registry["heal_timer"] + counter

		--	mob:talk(0,"knife_throwTimer: "..mob.registry["knife_throw_timer"])

		--mob:talk(0,"healTimer: "..mob.registry["heal_timer"])

		if mob.registry["strike1_timer"] >= 16 then
			if facingPC ~= nil then
				raider_guardian.strike1(mob, facingPC)
				return
			end
		end

		if mob.registry["strike2_timer"] >= 27 then
			if facingPC ~= nil then
				raider_guardian.strike2(mob, facingPC)
				return
			end
		end

		if mob.registry["singe_timer"] >= 9 then
			raider_guardian.singe(mob)
			return
		end

		if mob.registry["weaken_armor_timer"] >= 22 then
			if facingPC ~= nil then
				raider_guardian.weaken_armor(mob, facingPC)
				return
			end
		end

		if mob.registry["knife_throw_timer"] >= 19 then
			if distanceSquare(mob, target, 6) then
				raider_guardian.knife_throw(mob, targetPC)
				return
			end
		end

		if mob.registry["heal_timer"] >= 24 then
			raider_guardian.heal(mob)
			return
		end
	end,
	move = function(mob, target)
		mob_ai_basic.move(mob, target)
		raider_guardian.magicCast(mob, target)
	end,
	attack = function(mob, target)
		mob_ai_basic.attack(mob, target)
		raider_guardian.magicCast(mob, target)
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
		mob.registry["singe_timer"] = 10
		mob.registry["weaken_armor_timer"] = 10
		mob.registry["knife_throw_timer"] = 10
		mob.registry["heal_timer"] = 10
		mob.state = MOB_ALIVE
	end,
	strike1 = function(mob, target)
		local damage = math.random(390, 620)

		if mob.sleep ~= 1 then
			return
		end

		mob:talk(2, "H'YAH")
		mob:playSound(98)
		mob:sendAction(1, 20)
		target:sendAnimation(31)
		target:removeHealthExtend(damage, 1, 1, 1, 1, 3)
		mob.registry["strike1_timer"] = 0
	end,
	strike2 = function(mob, target)
		local damage = math.random(585, 930)

		if mob.sleep ~= 1 then
			return
		end

		mob:talk(2, "BOW BEFORE ME!")
		mob:playSound(98)
		mob:sendAction(1, 20)
		target:sendAnimation(67)
		target:removeHealthExtend(damage, 1, 1, 1, 1, 3)
		mob.registry["strike2_timer"] = 0
	end,
	singe = function(mob)
		mob:talk(2, "Hahaha, fools!")
		mob:sendAnimation(28)
		mob:playSound(98)
		mob:flushDuration()
		mob.registry["singe_timer"] = 0
	end,
	weaken_armor = function(mob, target)
		if mob.sleep ~= 1 then
			return
		end
		mob:playSound(98)
		if not target:hasDuration("weaken_armor") then
			mob:talk(2, "I see your weakness!")
			target:sendMinitext("Raider Guardian cast Weaken Armor on you")
			target:setDuration("weaken_armor", 160000)
			target:sendAnimation(89)
			target:calcStat()
		end

		mob.registry["weaken_armor_timer"] = 0
	end,
	knife_throw = function(mob, target)
		local r = math.random(1, 5000)
		local spellName = "Knife Throw"
		local anim = 327
		local damage = math.random(585, 930)

		if mob.sleep ~= 1 then
			return
		end

		mob:playSound(98)
		mob:talk(2, "Feel my blade!")

		target:sendMinitext("" .. mob.name .. " cast " .. spellName .. " on you")
		target:sendAnimation(anim)
		target:removeHealthExtend(damage, 1, 1, 1, 1, 3)
		target:calcStat()

		mob.registry["knife_throw_timer"] = 0
	end,
	heal = function(mob)
		if mob.sleep ~= 1 then
			return
		end

		mob:talk(2, "*applies bandage*")
		mob:sendAnimation(5)
		mob:playSound(98)
		mob.health = mob.health + 25000
		if mob.health > mob.maxHealth then
			mob.health = mob.maxHealth
		end
		mob.registry["heal_timer"] = 0
	end
}

weaken_armor = {
	while_cast = function(player)
		player:sendAnimation(34)
	end,
	recast = function(player)
		player.armor = player.armor - 1500
		if player.armor < 0 then
			player.armor = 0
		end
	end,
	uncast = function(player)
		player:calcStat()
	end
}
