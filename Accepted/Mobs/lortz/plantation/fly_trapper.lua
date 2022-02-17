fly_trapper = {
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

		mob.registry["crushing_jaws_timer"] = mob.registry["crushing_jaws_timer"] + counter

		if mob.registry["crushing_jaws_timer"] >= 60 then
			if facingPC ~= nil then
				fly_trapper.crushing_jaws(mob, facingPC)
				return
			else
				mob.registry["crushing_jaws_timer"] = 0
				return
			end
		end
	end,
	move = function(mob, target)
		mob_ai_basic.move(mob, target)
		fly_trapper.magicCast(mob, target)
	end,
	attack = function(mob, target)
		mob_ai_basic.attack(mob, target)
		fly_trapper.magicCast(mob, target)
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
		mob.registry["crushing_jaws_timer"] = math.random(1, 50)
		mob.state = MOB_ALIVE
	end,
	crushing_jaws = function(mob, target)
		local spellName = "Crushing Jaws"
		local anim = 44
		local damage = math.random(10000, 20000)
		local dialog = {"SNAP!"}
		local r = math.random(1, 5000)
		local sound = 14

		mob:playSound(sound)
		mob:talk(2, dialog[1])

		target:sendMinitext("" .. mob.name .. " cast " .. spellName .. " on you")
		target:sendAnimation(anim)
		target:removeHealthExtend(damage, 1, 1, 1, 1, 3)
		target:calcStat()

		mob.registry["crushing_jaws_timer"] = 0
	end
}
