skeletal_magician = {
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

		mob.registry["smolder_timer"] = mob.registry["smolder_timer"] + counter

		if mob.registry["smolder_timer"] >= 35 then
			if distanceSquare(mob, target, 7) then
				skeletal_magician.smolder(mob, target)
				return
			end
		end
	end,
	move = function(mob, target)
		mob_ai_basic.move(mob, target)
		skeletal_magician.magicCast(mob, target)
	end,
	attack = function(mob, target)
		mob_ai_basic.attack(mob, target)
		skeletal_magician.magicCast(mob, target)
	end,
	on_healed = function(mob, healer)
		mob.attacker = healer.ID
		mob:sendHealth(healer.damage, healer.critChance)
		healer.damage = 0
	end,
	on_attacked = function(mob, attacker)
		mob_ai_basic.on_attacked(mob, attacker)
	end,
	smolder = function(mob, target)
		local spellName = "Smolder"
		local anim = 46
		local damage = math.random(150, 240)

		if mob.sleep ~= 1 then
			return
		end

		mob:playSound(98)
		mob:talk(2, "Burn!")

		target:sendMinitext("" .. mob.name .. " cast " .. spellName .. " on you")
		target:sendAnimation(anim)
		target:removeHealthExtend(damage, 1, 1, 1, 1, 3)
		target:calcStat()

		mob.registry["smolder_timer"] = 0
	end
}
