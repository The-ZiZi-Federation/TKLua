fire_sprout = {
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

		mob.registry["controlled_burn_timer"] = mob.registry["controlled_burn_timer"] + counter

		if mob.registry["controlled_burn_timer"] >= 60 then
			if distanceSquare(mob, target, 7) then
				fire_sprout.controlled_burn(mob, target)
				return
			else
				mob.registry["controlled_burn_timer"] = 0
				return
			end
		end
	end,
	move = function(mob, target)
		mob_ai_basic.move(mob, target)
		fire_sprout.magicCast(mob, target)
	end,
	attack = function(mob, target)
		mob_ai_basic.attack(mob, target)
		fire_sprout.magicCast(mob, target)
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
		mob.registry["controlled_burn_timer"] = math.random(1, 50)
		mob.state = MOB_ALIVE
	end,
	controlled_burn = function(mob, target)
		local spellName = "Controlled Burn"
		local anim = 48
		local damage = math.random(5100, 8144)
		local dialog = {"Fire! Fire!   Hahahaha!", "Burn, baby, burn!", "Too hot for you?"}
		local r = math.random(1, 5000)
		local r2 = math.random(1, 3)
		local sound = 63

		mob:playSound(sound)
		mob:talk(2, dialog[r2])

		target:sendMinitext("" .. mob.name .. " cast " .. spellName .. " on you")
		target:sendAnimation(anim)
		target:removeHealthExtend(damage, 1, 1, 1, 1, 3)
		target:calcStat()

		mob.registry["controlled_burn_timer"] = 0
	end
}
