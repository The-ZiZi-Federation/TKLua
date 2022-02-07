leaf_sprout = {
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

		mob.registry["leaf_curse_timer"] = mob.registry["leaf_curse_timer"] + counter
		mob.registry["leaf_heal_timer"] = mob.registry["leaf_heal_timer"] + counter

		--Player(4):talk(0,"timer: "..mob.registry["leaf_curse_timer"])
		if mob.registry["leaf_curse_timer"] >= 30 then
			--Player(4):talk(0,"1")
			leaf_sprout.leaf_curse(mob, target)
			return
		end
		--Player(4):talk(0,""..mob.registry["leaf_heal_timer"])
		if mob.registry["leaf_heal_timer"] >= 15 then
			--Player(4):talk(0,"1")

			leaf_sprout.leaf_heal(mob)
			return
		end
	end,
	move = function(mob, target)
		mob_ai_basic.move(mob, target)
		leaf_sprout.magicCast(mob, target)
	end,
	attack = function(mob, target)
		mob_ai_basic.attack(mob, target)
		leaf_sprout.magicCast(mob, target)
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
		mob.registry["leaf_curse_timer"] = math.random(1, 20)
		mob.registry["leaf_heal_timer"] = math.random(1, 25)
		mob.state = MOB_ALIVE
	end,
	leaf_curse = function(mob, target)
		local damage

		local anim = 139
		local sound = 730

		if distanceSquare(mob, target, 6) then
			if target:hasDuration("leaf_curse") then
				return
			end
			damage = math.random(6500, 10000)
			target:sendAnimation(anim)
			target:removeHealthExtend(damage, 1, 1, 1, 1, 3)
			target.blind = 1
			target:setDuration("leaf_curse", 4000)
			target:sendMinitext("Leaf Sprout uses Leaf Curse on you!")
			mob:talk(2, "Stop looking at me!")
			mob:sendAction(1, 20)
			mob:playSound(sound)
			mob.registry["leaf_curse_timer"] = 0
		end
	end,
	leaf_heal = function(mob)
		local heal = 250000

		local mobs = mob:getObjectsInArea(BL_MOB)
		local pcTargets = {}
		local anim = 5
		local sound = 708
		local r
		local mobTargets = {}

		if #mobs > 1 then
			for i = 1, #mobs do
				if mobs[i].health < mobs[i].maxHealth then
					table.insert(mobTargets, mobs[i])
				end
			end
		end

		r = math.random(1, #mobTargets)

		if #mobTargets > 0 then
			if distanceSquare(mob, mobTargets[r], 6) then
				mobTargets[r]:sendAnimation(anim)
				mobTargets[r]:addHealth(heal)
				mob:talk(2, "Don't hurt my friends!")
				mob:sendAction(1, 20)
				mob:playSound(sound)
				mob.registry["leaf_heal_timer"] = 0
			end
		end
	end
}

leaf_curse = {
	while_cast = function(player)
		local anim = 139
		player:sendAnimation(anim)
	end,
	uncast = function(player)
		player.blind = 0
		player:calcStat()
	end
}
