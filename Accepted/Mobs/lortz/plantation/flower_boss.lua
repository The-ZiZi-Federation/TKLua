flower_boss = {
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

		mob.registry["prick_timer"] = mob.registry["prick_timer"] + counter
		mob.registry["hypnotic_pollen_timer"] = mob.registry["hypnotic_pollen_timer"] + counter
		mob.registry["field_of_thorns_timer"] = mob.registry["field_of_thorns_timer"] + counter
		mob.registry["poison_ivy_timer"] = mob.registry["poison_ivy_timer"] + counter
		mob.registry["heal_timer"] = mob.registry["heal_timer"] + counter

		if mob.registry["prick_timer"] >= 20 then
			if facingPC ~= nil then
				flower_boss.prick(mob, facingPC)
				return
			end
		end

		if mob.registry["hypnotic_pollen_timer"] >= 25 then
			if distanceSquare(mob, target, 6) then
				flower_boss.hypnotic_pollen(mob, target)
				return
			else
				mob.registry["hypnotic_pollen_timer"] = 0
				return
			end
		end

		if mob.registry["field_of_thorns_timer"] >= 45 then
			if distanceSquare(mob, target, 7) then
				flower_boss.field_of_thorns(mob, target)
				return
			else
				mob.registry["field_of_thorns_timer"] = 0
				return
			end
		end

		if mob.registry["poison_ivy_timer"] >= 35 then
			if facingPC ~= nil then
				flower_boss.poison_ivy(mob, facingPC)
				return
			end
		end

		if mob.registry["heal_timer"] >= 22 then
			flower_boss.heal(mob)
			return
		end
	end,
	move = function(mob, target)
		mob_ai_basic.move(mob, target)
		flower_boss.magicCast(mob, target)
	end,
	attack = function(mob, target)
		mob_ai_basic.attack(mob, target)
		flower_boss.magicCast(mob, target)
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
		mob:talk(1, "" .. mob.name .. "! Are you from Lortz?! This is MY garden now!")
		mob.registry["prick_timer"] = math.random(1, 10)
		mob.registry["hypnotic_pollen_timer"] = math.random(1, 10)
		mob.registry["field_of_thorns_timer"] = math.random(1, 10)
		mob.registry["poison_ivy_timer"] = math.random(1, 10)
		mob.registry["heal_timer"] = math.random(1, 10)
		mob.state = MOB_ALIVE
	end,
	prick = function(mob, target)
		local damage = math.random(28000, 46000)

		mob:talk(2, "Don't get pricked!")
		mob:playSound(73)
		mob:sendAction(1, 20)
		target:sendAnimation(397)
		target:removeHealthExtend(damage, 1, 1, 1, 1, 3)
		mob.registry["prick_timer"] = 0
	end,
	hypnotic_pollen = function(mob, target)
		local spellName = "Hypnotic Pollen"
		local anim1 = 435
		local anim2 = 422
		local damage = math.random(14000, 23000)
		local dialog = {"Go to sleep!", "Naptime!"}
		local r = math.random(1, 5000)
		local r2 = math.random(1, 2)
		local sound = 106

		mob:playSound(sound)
		mob:talk(2, dialog[r2])

		target:sendMinitext("" .. mob.name .. " cast " .. spellName .. " on you")
		target:sendAnimation(anim1)
		target:sendAnimation(anim2)
		target:setDuration("hypnotic_pollen", 5000)
		target:removeHealthExtend(damage, 1, 1, 1, 1, 3)
		target:calcStat()

		mob.registry["hypnotic_pollen_timer"] = 0
	end,
	field_of_thorns = function(mob, target)
		mob:talk(2, "Slow down!")
		field_of_thorns.cast(mob, target)
		mob.registry["field_of_thorns_timer"] = 0
	end,
	poison_ivy = function(mob, target)
		local r = math.random(1, 2000)
		local spellName = "Poison Ivy"
		local spellYname = "poison_ivy"
		local duration = 20000
		local anim = 189

		mob:playSound(79)
		mob:talk(2, "Teehee!")

		if not target:hasDuration(spellYname) then
			target:sendMinitext("" .. mob.name .. " cast " .. spellName .. " on you")
			target:setDuration(spellYname, duration)
			target:sendAnimation(anim)
			target:calcStat()
		end

		mob.registry["poison_ivy_timer"] = 0
	end,
	heal = function(mob)
		mob:talk(2, "I just keep on growing back!")
		mob:sendAnimation(5)
		mob:playSound(708)
		mob.health = mob.health + 500000
		if mob.health > mob.maxHealth then
			mob.health = mob.maxHealth
		end
		mob.registry["heal_timer"] = 0
	end
}

hypnotic_pollen = {
	while_cast = function(player)
		player:sendAnimation(435)
		player.paralyzed = true
	end,
	recast = function(player)
	end,
	uncast = function(player)
		player.paralyzed = false
		player:calcStat()
	end
}

poison_ivy = {
	while_cast = function(player)
		local anim = 94
		local damage = math.random(10000, 15000)

		player:sendAnimation(anim)
		player:removeHealthExtend(damage, 1, 1, 1, 1, 3)
	end,
	recast = function(player)
	end,
	uncast = function(player)
		player:calcStat()
	end
}

field_of_thorns = {
	cast = function(mob, target)
		local dist1 = 4
		local dist2 = 5
		local m = target.m
		local sound = 82

		mob:playSound(sound)

		for x = (target.x - dist1), (target.x + dist1) do
			for y = (target.y - dist1), (target.y + dist1) do
				if distanceSquareXY(target, x, y, dist2) then
					if (x > 0 and y > 0) and (x < target.xmax and y < target.ymax) then
						mob:addNPC("field_of_thorns", m, x, y, 1000, 10000, mob.ID)
					end
				end
			end
		end
	end,
	on_spawn = function(npc)
		field_of_thorns.animation(npc)
		field_of_thorns.dealDamage(npc)
		field_of_thorns.slow(npc)
	end,
	action = function(npc)
		local m, x, y = npc.m, npc.x, npc.y
		local player = core:getObjectsInMap(m, BL_PC)
		local target

		field_of_thorns.animation(npc)
		field_of_thorns.dealDamage(npc)
		field_of_thorns.slow(npc)
	end,
	slow = function(npc)
		local target
		local m, x, y = npc.m, npc.x, npc.y

		target = npc:getObjectsInCell(m, x, y, BL_PC)
		if #target > 0 then
			for i = 1, #target do
				if not target[i]:hasDuration("field_of_thorns") then
					target[i]:setDuration("field_of_thorns", 2000)
				end
			end
		end
	end,
	dealDamage = function(npc)
		local target
		local m, x, y = npc.m, npc.x, npc.y
		local damage = math.random(7500, 12500)

		target = npc:getObjectsInCell(m, x, y, BL_PC)
		if #target > 0 then
			for i = 1, #target do
				target[i]:removeHealthExtend(damage, 1, 1, 1, 1, 3)
			end
		end
	end,
	animation = function(npc)
		local x, y = npc.x, npc.y

		npc:sendAnimationXY(399, x, y)
	end,
	endAction = function(npc)
		npc:delete()
	end,
	while_cast_250 = function(player)
		player.speed = 200
		player:updateState()
	end,
	uncast = function(player)
		local m, x, y = player.m, player.x, player.y
		local npc = player:getObjectsInCell(m, x, y, BL_NPC)

		if #npc > 0 then
			for i = 1, #npc do
				if npc[i].yname == "field_of_thorns" then
					if not player:hasDuration("field_of_thorns") then
						player:setDuration("field_of_thorns", 1000)
					end
				end
			end
		end
		player:calcStat()
	end
}
