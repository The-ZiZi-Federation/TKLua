hh_ghost = {
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

		mob.registry["haunting_presence_timer"] = mob.registry["haunting_presence_timer"] + counter

		if mob.registry["haunting_presence_timer"] >= 60 then
			if distanceSquare(mob, target, 6) then
				hh_ghost.haunting_presence(mob, target)
				return
			else
				mob.registry["haunting_presence_timer"] = 0
				return
			end
		end
	end,
	move = function(mob, target)
		mob_ai_basic.move(mob, target)
		hh_ghost.magicCast(mob, target)
	end,
	attack = function(mob, target)
		mob_ai_basic.attack(mob, target)
		hh_ghost.magicCast(mob, target)
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
		mob.registry["haunting_presence_timer"] = math.random(1, 50)
		mob.state = MOB_ALIVE
	end,
	haunting_presence = function(mob, target)
		local spellName = "Haunting Presence"
		local anim = 550
		local damage
		local dialog = {"OooOOoo!", "Leave!", "Intruder!"}
		local r = math.random(1, 5000)
		local r2 = math.random(1, 3)

		if mob.level == 20 then
			damage = math.random(60, 95)
		elseif mob.level == 65 then
			damage = math.random(195, 310)
		elseif mob.level == 100 then
			damage = math.random(350, 600)
		end

		mob:playSound(25)
		mob:talk(2, dialog[r2])

		target:sendMinitext("" .. mob.name .. " cast " .. spellName .. " on you")
		target:sendAnimation(anim)
		target:removeHealthExtend(damage, 1, 1, 1, 1, 3)
		target:calcStat()

		mob.registry["haunting_presence_timer"] = 0
	end
}
