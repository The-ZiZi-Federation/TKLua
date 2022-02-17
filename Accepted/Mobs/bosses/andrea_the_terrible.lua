andrea_the_terrible = {
	before_death = function(mob)
	end,
	magicCast = function(mob, target)
		local areaPC = mob:getObjectsInArea(BL_PC)
		local r = math.random(1, #areaPC)
		local targetPC = areaPC[r]

		mob.registry["medusas_darkness_timer"] = mob.registry["medusas_darkness_timer"] + 1
		mob.registry["medusas_gaze_timer"] = mob.registry["medusas_gaze_timer"] + 1
		mob.registry["heal_timer"] = mob.registry["heal_timer"] + 1

		if mob.registry["medusas_darkness_timer"] >= 12 then
			if targetPC.state ~= 1 then
				medusas_darkness.cast(mob, targetPC)
				mob.registry["medusas_darkness_timer"] = 0
			end
		end

		if mob.registry["medusas_gaze_timer"] >= 19 then
			if targetPC.state ~= 1 then
				medusas_gaze.cast(mob, targetPC)
				mob.registry["medusas_gaze_timer"] = 0
			end
		end

		if mob.registry["heal_timer"] >= 22 then
			if mob.sleep ~= 1 then
				return
			end
			mob:sendAnimation(5)
			mob:playSound(98)
			mob:addHealth(300000)
			mob.registry["heal_timer"] = 0
		end
	end,
	move = function(mob, target)
		local facing = getTargetFacing(mob, BL_ALL)
		local moved = true
		local move1, move2 = math.random(0, 10), math.random(0, 20)
		local pc

		threat.calcHighestThreat(mob)
		if target == nil then
			pc = mob:getObjectsInArea(BL_PC)
			if #pc > 0 then
				for i = 1, #pc do
					if distanceSquare(mob, pc[i], 7) then
						if pc[i].state ~= 1 and pc[i].state ~= 2 then
							mob.target = pc[math.random(#pc)].ID
						end
					end
				end
			end
			return
		else
			if target.state ~= 1 and target.state ~= 2 then
				moved = FindCoords(mob, target)
				if mob:moveIntent(target.ID) == 1 then
					mob.state = MOB_HIT
				end
			end
		end
	end,
	attack = function(mob, target)
		--	Player(4):talk(0,"1")

		andrea_the_terrible.magicCast(mob, target)
		mob_ai_basic.attack(mob, target)
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
		local pc = mob:getObjectsInArea(BL_PC)

		if #pc > 0 then
			for i = 1, #pc do
				if pc[i].state ~= 1 then
					mob.target = pc[math.random(#pc)].ID
				end
			end
		end
		mob.state = MOB_ALIVE
	end
}
