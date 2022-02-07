mud_sprout = {
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

		mob.registry["mud_quake_timer"] = mob.registry["mud_quake_timer"] + counter

		--Player(4):talk(0,"timer: "..mob.registry["mud_quake_timer"])
		if mob.registry["mud_quake_timer"] >= 45 then
			--Player(4):talk(0,"1")
			mud_sprout.mud_quake(mob)
			return
		end
	end,
	move = function(mob, target)
		mob_ai_basic.move(mob, target)
		mud_sprout.magicCast(mob, target)
	end,
	attack = function(mob, target)
		mob_ai_basic.attack(mob, target)
		mud_sprout.magicCast(mob, target)
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
		mob.registry["mud_quake_timer"] = math.random(1, 35)
		mob.state = MOB_ALIVE
	end,
	mud_quake = function(mob)
		local damage

		local pc = mob:getObjectsInArea(BL_PC)
		local pcTargets = {}
		local anim = 138
		local sound = 736

		if #pc > 0 then
			for i = 1, #pc do
				if distanceSquare(mob, pc[i], 1) then
					table.insert(pcTargets, pc[i])
				end
			end
		end

		if #pcTargets > 0 then
			for i = 1, #pcTargets do
				damage = math.random(7500, 12500)
				pcTargets[i]:sendAnimation(anim)
				pcTargets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 3)
				--pushBack(pcTargets[i])
				pcTargets[i]:sendMinitext("Mud Sprout uses Mud Quake on you!")
			end
			mob:talk(2, "CRASH!")
			mob:sendAction(1, 20)
			mob:playSound(sound)
			mob.registry["mud_quake_timer"] = 0
		end
	end
}
