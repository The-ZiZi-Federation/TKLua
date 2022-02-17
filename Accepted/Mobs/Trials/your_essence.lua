might_essence = {
	spells = function(mob, target)
		local areaPC = mob:getObjectsInArea(BL_PC)
		local targetPC = areaPC[math.random(#areaPC)]

		mob.registry["great_cleave_timer"] = mob.registry["great_cleave_timer"] + 1
		mob.registry["stun_timer"] = mob.registry["stun_timer"] + 1
		mob.registry["leap_timer"] = mob.registry["leap_timer"] + 1
		mob.registry["heal_timer"] = mob.registry["heal_timer"] + 1

		--mob:talk(0,"snowstormTimer: "..mob.registry["snowstorm_timer"])
		--mob:talk(0,"flareTimer: "..mob.registry["flare_timer"])
		--mob:talk(0,"flurryTimer: "..mob.registry["flurry_timer"])
		--mob:talk(0,"healTimer: "..mob.registry["heal_timer"])

		if mob.registry["great_cleave_timer"] >= 21 then
			if distanceSquare(mob, targetPC, 2) then
				might_essence.great_cleave(mob)
				return
			end
		end

		if mob.registry["stun_timer"] >= 16 then
			if (distanceSquare(mob, targetPC, 6)) then
				might_essence.stun(mob, targetPC)
				return
			end
		end

		if mob.registry["leap_timer"] >= 10 then
			if ((not distanceSquare(mob, targetPC, 2)) and (distanceSquare(mob, targetPC, 5))) then
				might_essence.leap(mob, targetPC)
				return
			end
		end

		if mob.registry["heal_timer"] >= 22 then
			if mob.sleep ~= 1 then
				return
			end
			mob:sendAnimation(5)
			mob:playSound(98)
			mob:addHealth(500000)
			mob.registry["heal_timer"] = 0
		end
	end,
	move = function(mob, target)
		if mob.paralyzed == true then
			mob.paralyzed = false
			mob:calcStat()
		end
		--	might_essence.disguise(mob)
		might_essence.spells(mob, target)
		mob_ai_basic.move(mob, target)
	end,
	attack = function(mob, target)
		if mob.paralyzed == true then
			mob.paralyzed = false
			mob:calcStat()
		end
		--	might_essence.disguise(mob)
		might_essence.spells(mob, target)
		mob_ai_basic.attack(mob, target)
	end,
	on_healed = function(mob, healer)
		if mob.paralyzed == true then
			mob.paralyzed = false
			mob:calcStat()
		end

		mob_ai_basic.on_healed(mob, healer)
	end,
	on_attacked = function(mob, attacker)
		if mob.paralyzed == true then
			mob.paralyzed = false
			mob:calcStat()
		end

		mob_ai_basic.on_attacked(mob, attacker)
	end,
	after_death = function(mob)
		local attacker = mob:getObjectsInArea(BL_PC)

		if #attacker > 0 then
			for i = 1, #attacker do
				attacker[i]:msg(4, "[Quest Completed] Congratulations! You killed... yourself? What the...?", attacker[i].ID)
				attacker[i]:sendMinitext("You've done it. You've defeated yourself. What could possibly be left to do?")
				attacker[i]:popUp("You feel your chest compressing. It is getting difficult to breathe.")
				attacker[i]:setDuration("might_essence", 5000)
			end
		end
	end,
	uncast = function(player)
		player:sendAnimation(1)
		player:playSound(1)
		player.health = 0
		player.state = 1
		player:updateState()
		player:sendStatus()
		player.registry["strength_trial_death_timer"] = os.time() + 5
	end,
	autoWarp = function(player)
		if player.mapTitle == "Trial of Strength and Wits" and player.state == 1 then
			if player.registry["strength_trial_death_timer"] > 0 and player.registry["strength_trial_death_timer"] < os.time() then
				player:warp(52, 0, 0)
			end
		end
	end,
	on_spawn = function(mob)
		might_essence.disguise(mob)
		mob:setDuration("essence_clone", 9999999)
		mob.state = MOB_ALIVE
	end,
	disguise = function(mob)
		local pc = mob:getObjectsInArea(BL_PC)

		if #pc > 0 then
			for i = 1, #pc do
				if pc[i].state ~= 1 then
					clone.equip(pc[i], mob)
					mob.gfxClone = 1
					pc[i]:refresh()
					mob.target = pc[math.random(#pc)].ID
				end
			end
		end
	end,
	great_cleave = function(mob, target)
		local anim = 7
		local sound = 84
		local m = mob.m
		local x = mob.x
		local y = mob.y

		local mobBlocks = mob:getObjectsInArea(BL_MOB)
		local pcBlocks = mob:getObjectsInArea(BL_PC)
		local targets = {}

		local threat
		local damage = math.random(5000, 15000)

		if mob.sleep ~= 1 then
			return
		end

		local pcflankTargets = {
			mob:getObjectsInCell(mob.m, mob.x + 1, mob.y, BL_PC)[1],
			mob:getObjectsInCell(mob.m, mob.x - 1, mob.y, BL_PC)[1],
			mob:getObjectsInCell(mob.m, mob.x, mob.y - 1, BL_PC)[1],
			mob:getObjectsInCell(mob.m, mob.x, mob.y + 1, BL_PC)[1],
			mob:getObjectsInCell(mob.m, mob.x + 1, mob.y + 1, BL_PC)[1],
			mob:getObjectsInCell(mob.m, mob.x - 1, mob.y - 1, BL_PC)[1],
			mob:getObjectsInCell(mob.m, mob.x + 1, mob.y - 1, BL_PC)[1],
			mob:getObjectsInCell(mob.m, mob.x - 1, mob.y + 1, BL_PC)[1],
			mob:getObjectsInCell(mob.m, mob.x, mob.y - 2, BL_PC)[1],
			mob:getObjectsInCell(mob.m, mob.x, mob.y + 2, BL_PC)[1],
			mob:getObjectsInCell(mob.m, mob.x - 2, mob.y, BL_PC)[1],
			mob:getObjectsInCell(mob.m, mob.x + 2, mob.y, BL_PC)[1]
		}

		mob:sendAction(1, 20)
		mob:playSound(sound)
		mob:talk(2, "CLEAVE~!")

		for i = 1, 12 do
			if (pcflankTargets[i] ~= nil) then
				if pcflankTargets[i].state ~= 1 then
					pcflankTargets[i].attacker = mob.ID
					pcflankTargets[i]:sendMinitext(mob.name .. " cleaves you with a mighty blow.")
					pcflankTargets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 3)
					pcflankTargets[i]:sendAnimation(anim)
				end
			end
		end
		mob.registry["great_cleave_timer"] = 0
	end,
	stun = function(mob, target)
		local anim = 127
		local damage = math.random(1000, 2000)

		if mob.sleep ~= 1 then
			return
		end

		mob:playSound(55)
		target:sendAnimation(anim)
		target:removeHealthExtend(damage, 1, 1, 1, 1, 3)
		target:calcStat()
		mob.registry["stun_timer"] = 0
	end,
	leap = function(mob, target)
		local m = mob.m
		local x = mob.x
		local y = mob.y

		local anim = 306
		local anim2 = 60
		local sound = 350

		if mob.sleep ~= 1 then
			return
		end

		-------------------------------------------------------------
		if findClearPath(mob.side, mob.m, mob.x, mob.y, target, 1) == 1 then
			if target ~= nil then
				if target.ID == mob.ID then
					return
				else
					if distanceSquare(mob, target, 5) then
						if target.state == 1 then
							mob:sendAnimation(246)
							mob:sendMinitext("Target is already dead")
							return
						else
							if target.blType == BL_PC then
								target:sendMinitext(mob.name .. " cast Leap on you.")
							end

							mob:sendAnimationXY(15, mob.x, mob.y)
							mob:playSound(73)

							if target.side == 0 then -- if target is facing north
								might_essence.checkNorth(mob, target)
							elseif target.side == 1 then -- facing east
								might_essence.checkEast(mob, target)
							elseif target.side == 2 then -- south
								might_essence.checkSouth(mob, target)
							elseif target.side == 3 then -- west
								might_essence.checkWest(mob, target)
							end

							-- here is after warp
							target.attacker = mob.ID
							mob:playSound(sound)
							mob:sendAction(1, 20)
							target:sendAnimation(anim)
							target:sendAnimation(anim2)
						end
					else
						mob:sendAnimation(246)
						mob:sendMinitext("Your target is too far away")
					end
				end
			end
		else
			mob:sendAnimation(246)
			mob:sendMinitext("You don't have a clear path to your target")
		end
		mob.registry["leap_timer"] = 0
	end,
	checkSouth = function(mob, target)
		if getPass(target.m, target.x, target.y + 1) == 1 then -- if walkable is false dont put here.
			might_essence.checkEast(mob, target)
		else
			mob:warp(target.m, target.x, target.y + 1)
			mob.side = 0
			mob:sendSide()
		end
	end,
	checkWest = function(mob, target)
		if getPass(target.m, target.x - 1, target.y) == 1 then -- if walkable is false
			might_essence.checkSouth(mob, target)
		else
			mob:warp(target.m, target.x - 1, target.y)
			mob.side = 1
			mob:sendSide()
		end
	end,
	checkNorth = function(mob, target)
		if getPass(target.m, target.x, target.y - 1) == 1 then -- if walkable is false
			might_essence.checkWest(mob, target)
		else
			mob:warp(target.m, target.x, target.y - 1)
			mob.side = 2
			mob:sendSide()
		end
	end,
	checkEast = function(mob, target)
		if getPass(target.m, target.x + 1, target.y) == 1 then -- if walkable is false
			might_essence.checkNorth(mob, target)
		else
			mob:warp(target.m, target.x + 1, target.y)
			mob.side = 3
			mob:sendSide()
		end
	end
}

grace_essence = {
	spells = function(mob, target)
		local r = math.random(1, 20)
		local areaPC = mob:getObjectsInArea(BL_PC)
		local targetPC = areaPC[1]
		local pc = getTargetFacing(mob, BL_PC)
		local pcTargets = {}

		if (mob.side == 0) then
			pcTargets = {
				mob:getObjectsInCell(mob.m, mob.x, mob.y - 1, BL_PC)[1],
				mob:getObjectsInCell(mob.m, mob.x, mob.y - 2, BL_PC)[1],
				mob:getObjectsInCell(mob.m, mob.x, mob.y - 3, BL_PC)[1],
				mob:getObjectsInCell(mob.m, mob.x + 1, mob.y - 2, BL_PC)[1],
				mob:getObjectsInCell(mob.m, mob.x - 1, mob.y - 2, BL_PC)[1],
				mob:getObjectsInCell(mob.m, mob.x + 1, mob.y - 3, BL_PC)[1],
				mob:getObjectsInCell(mob.m, mob.x + 2, mob.y - 3, BL_PC)[1],
				mob:getObjectsInCell(mob.m, mob.x - 1, mob.y - 3, BL_PC)[1],
				mob:getObjectsInCell(mob.m, mob.x - 2, mob.y - 3, BL_PC)[1]
			}
		elseif (mob.side == 1) then
			pcTargets = {
				mob:getObjectsInCell(mob.m, mob.x + 1, mob.y, BL_PC)[1],
				mob:getObjectsInCell(mob.m, mob.x + 2, mob.y, BL_PC)[1],
				mob:getObjectsInCell(mob.m, mob.x + 3, mob.y, BL_PC)[1],
				mob:getObjectsInCell(mob.m, mob.x + 2, mob.y + 1, BL_PC)[1],
				mob:getObjectsInCell(mob.m, mob.x + 2, mob.y - 1, BL_PC)[1],
				mob:getObjectsInCell(mob.m, mob.x + 3, mob.y + 1, BL_PC)[1],
				mob:getObjectsInCell(mob.m, mob.x + 3, mob.y - 1, BL_PC)[1],
				mob:getObjectsInCell(mob.m, mob.x + 3, mob.y + 2, BL_PC)[1],
				mob:getObjectsInCell(mob.m, mob.x + 3, mob.y - 2, BL_PC)[1]
			}
		elseif (mob.side == 2) then
			pcTargets = {
				mob:getObjectsInCell(mob.m, mob.x, mob.y + 1, BL_PC)[1],
				mob:getObjectsInCell(mob.m, mob.x, mob.y + 2, BL_PC)[1],
				mob:getObjectsInCell(mob.m, mob.x, mob.y + 3, BL_PC)[1],
				mob:getObjectsInCell(mob.m, mob.x + 1, mob.y + 2, BL_PC)[1],
				mob:getObjectsInCell(mob.m, mob.x - 1, mob.y + 2, BL_PC)[1],
				mob:getObjectsInCell(mob.m, mob.x + 1, mob.y + 3, BL_PC)[1],
				mob:getObjectsInCell(mob.m, mob.x + 2, mob.y + 3, BL_PC)[1],
				mob:getObjectsInCell(mob.m, mob.x - 1, mob.y + 3, BL_PC)[1],
				mob:getObjectsInCell(mob.m, mob.x - 2, mob.y + 3, BL_PC)[1]
			}
		elseif (mob.side == 3) then
			pcTargets = {
				mob:getObjectsInCell(mob.m, mob.x - 1, mob.y, BL_PC)[1],
				mob:getObjectsInCell(mob.m, mob.x - 2, mob.y, BL_PC)[1],
				mob:getObjectsInCell(mob.m, mob.x - 3, mob.y, BL_PC)[1],
				mob:getObjectsInCell(mob.m, mob.x - 2, mob.y + 1, BL_PC)[1],
				mob:getObjectsInCell(mob.m, mob.x - 2, mob.y - 1, BL_PC)[1],
				mob:getObjectsInCell(mob.m, mob.x - 3, mob.y + 1, BL_PC)[1],
				mob:getObjectsInCell(mob.m, mob.x - 3, mob.y - 1, BL_PC)[1],
				mob:getObjectsInCell(mob.m, mob.x - 3, mob.y + 2, BL_PC)[1],
				mob:getObjectsInCell(mob.m, mob.x - 3, mob.y - 2, BL_PC)[1]
			}
		end

		mob.registry["poisoned_shuriken_timer"] = mob.registry["poisoned_shuriken_timer"] + 1
		mob.registry["assassinate_timer"] = mob.registry["assassinate_timer"] + 1
		mob.registry["coup_de_grace_timer"] = mob.registry["coup_de_grace_timer"] + 1
		mob.registry["heal_timer"] = mob.registry["heal_timer"] + 1

		--mob:talk(0,"snowstormTimer: "..mob.registry["snowstorm_timer"])
		--mob:talk(0,"flareTimer: "..mob.registry["flare_timer"])
		--Player(4):talk(0,"assassinate_timer: "..mob.registry["assassinate_timer"])
		--mob:talk(0,"healTimer: "..mob.registry["heal_timer"])

		if mob.registry["poisoned_shuriken_timer"] >= 17 then
			if #pcTargets > 0 then
				grace_essence.poisoned_shuriken(mob)
				mob.registry["poisoned_shuriken_timer"] = 0
				return
			end
		end

		if mob.registry["assassinate_timer"] >= 12 then
			if distanceSquare(mob, targetPC, 5) and not distanceSquare(mob, targetPC, 2) then
				grace_essence.assassinate(mob, targetPC)
				mob.registry["assassinate_timer"] = 0
				return
			end
		end

		if mob.registry["coup_de_grace_timer"] >= 21 then
			if pc ~= nil then
				grace_essence.coup_de_grace(mob, pc)
				mob.registry["coup_de_grace_timer"] = 0
				return
			end
		end

		if mob.registry["heal_timer"] >= 22 then
			if mob.sleep ~= 1 then
				return
			end
			mob:sendAnimation(5)
			mob:playSound(98)
			mob:addHealth(500000)
			mob.registry["heal_timer"] = 0
		end
	end,
	move = function(mob, target)
		if mob.paralyzed == true then
			mob.paralyzed = false
			mob:calcStat()
		end
		--	grace_essence.disguise(mob)
		grace_essence.spells(mob, target)
		mob_ai_basic.move(mob, target)
	end,
	attack = function(mob, target)
		if mob.paralyzed == true then
			mob.paralyzed = false
			mob:calcStat()
		end
		--	grace_essence.disguise(mob)
		grace_essence.spells(mob, target)
		grace_essence.attackBehavior(mob, target)
	end,
	on_healed = function(mob, healer)
		if mob.paralyzed == true then
			mob.paralyzed = false
			mob:calcStat()
		end

		mob_ai_basic.on_healed(mob, healer)
	end,
	on_attacked = function(mob, attacker)
		if mob.paralyzed == true then
			mob.paralyzed = false
			mob:calcStat()
		end
		mob_ai_basic.on_attacked(mob, attacker)
	end,
	after_death = function(mob)
		local attacker = mob:getObjectsInArea(BL_PC)

		if #attacker > 0 then
			for i = 1, #attacker do
				attacker[i]:msg(4, "[Quest Completed] Congratulations! You killed... yourself? What the...?", attacker[i].ID)
				attacker[i]:sendMinitext("You've done it. You've defeated yourself. What could possibly be left to do?")
				attacker[i]:popUp("You feel your chest compressing. It is getting difficult to breathe.")
				attacker[i]:setDuration("grace_essence", 5000)
			end
		end
	end,
	uncast = function(player)
		player:sendAnimation(1)
		player:playSound(1)
		player.health = 0
		player.state = 1
		player:updateState()
		player:sendStatus()
		player.registry["strength_trial_death_timer"] = os.time() + 5
	end,
	autoWarp = function(player)
		if player.mapTitle == "Trial of Strength and Wits" and player.state == 1 then
			if player.registry["strength_trial_death_timer"] > 0 and player.registry["strength_trial_death_timer"] < os.time() then
				player:warp(52, 0, 0)
			end
		end
	end,
	on_spawn = function(mob)
		grace_essence.disguise(mob)
		mob:setDuration("essence_clone", 9999999)
		mob.state = MOB_ALIVE
	end,
	disguise = function(mob)
		local pc = mob:getObjectsInArea(BL_PC)

		if #pc > 0 then
			for i = 1, #pc do
				if pc[i].state ~= 1 then
					clone.equip(pc[i], mob)
					mob.gfxClone = 1
					pc[i]:refresh()
					mob.target = pc[math.random(#pc)].ID
				end
			end
		end
	end,
	attackBehavior = function(mob, target)
		local moved
		local pc = getTargetFacing(mob, BL_PC)

		if (mob.target == 0) then
			mob.state = MOB_ALIVE
			mob_ai_basic.move(mob, target)
			return
		end

		if (mob.paralyzed or mob.sleep ~= 1) then
			return
		end

		if (target) then
			threat.calcHighestThreat(mob)
			local block = mob:getBlock(mob.target)
			if (block ~= nil) then
				target = block
			end

			if target.state ~= 1 then
				moved = FindCoords(mob, target)
				if mob:moveIntent(target.ID) == 1 and mob.target ~= mob.owner then
					if pc ~= nil and pc.ID == target.ID then
						ambush.cast(mob, pc.ID)
					--mob:attack(pc.ID)
					end
				else
					mob.target = 0
					mob.state = MOB_ALIVE
				end
			end
		else
			mob.target = 0
			mob.state = MOB_ALIVE
		end
	end,
	poisoned_shuriken = function(mob)
		local stunDuration = 3000
		local mobTargets
		local pcTargets

		local m = mob.m
		local x = mob.x
		local y = mob.y

		local anim = 122
		local sound = 332

		if mob.sleep ~= 1 then
			return
		end

		---------------------------
		--- Spell Damage Formula---
		---------------------------
		local damage = math.random(1000, 2000)

		mobTargets, pcTargets = grace_essence.getTargets(mob)

		mob:sendAction(1, 20)
		mob:playSound(sound)
		mob:sendStatus()
		grace_essence.animation(mob)

		for i = 1, 9 do
			if (pcTargets[i] ~= nil) then
				pcTargets[i].attacker = mob.ID
				--pcTargets[i]:sendAnimation(anim, 0)
				pcTargets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 3)
				pcTargets[i]:sendMinitext(mob.name .. " strikes you with Poisoned Shuriken")
				if not pcTargets[i]:hasDuration("stun") then
					pcTargets[i]:setDuration("stun", stunDuration)
				end
			end
		end
	end,
	animation = function(player)
		local x, y = player.x, player.y
		local s = player.side
		local anim = 122

		if s == 0 then
			player:sendAnimationXY(anim, x, y - 1)
			player:sendAnimationXY(anim, x, y - 2)
			player:sendAnimationXY(anim, x + 1, y - 2)
			player:sendAnimationXY(anim, x - 1, y - 2)
			player:sendAnimationXY(anim, x, y - 3)
			player:sendAnimationXY(anim, x + 1, y - 3)
			player:sendAnimationXY(anim, x - 1, y - 3)
			player:sendAnimationXY(anim, x + 2, y - 3)
			player:sendAnimationXY(anim, x - 2, y - 3)
		elseif s == 1 then
			player:sendAnimationXY(anim, x + 1, y)
			player:sendAnimationXY(anim, x + 2, y)
			player:sendAnimationXY(anim, x + 2, y + 1)
			player:sendAnimationXY(anim, x + 2, y - 1)
			player:sendAnimationXY(anim, x + 3, y)
			player:sendAnimationXY(anim, x + 3, y + 1)
			player:sendAnimationXY(anim, x + 3, y - 1)
			player:sendAnimationXY(anim, x + 3, y + 2)
			player:sendAnimationXY(anim, x + 3, y - 2)
		elseif s == 2 then
			player:sendAnimationXY(anim, x, y + 1)
			player:sendAnimationXY(anim, x, y + 2)
			player:sendAnimationXY(anim, x + 1, y + 2)
			player:sendAnimationXY(anim, x - 1, y + 2)
			player:sendAnimationXY(anim, x, y + 3)
			player:sendAnimationXY(anim, x + 1, y + 3)
			player:sendAnimationXY(anim, x - 1, y + 3)
			player:sendAnimationXY(anim, x + 2, y + 3)
			player:sendAnimationXY(anim, x - 2, y + 3)
		elseif s == 3 then
			player:sendAnimationXY(anim, x - 1, y)
			player:sendAnimationXY(anim, x - 2, y)
			player:sendAnimationXY(anim, x - 2, y + 1)
			player:sendAnimationXY(anim, x - 2, y - 1)
			player:sendAnimationXY(anim, x - 3, y)
			player:sendAnimationXY(anim, x - 3, y + 1)
			player:sendAnimationXY(anim, x - 3, y - 1)
			player:sendAnimationXY(anim, x - 3, y + 2)
			player:sendAnimationXY(anim, x - 3, y - 2)
		end
	end,
	getTargets = function(player)
		local level = player.level
		local side = player.side

		if (player.side == 0) then
			mobTargets = {
				player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x, player.y - 2, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x, player.y - 3, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y - 2, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y - 2, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y - 3, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 2, player.y - 3, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y - 3, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 2, player.y - 3, BL_MOB)[1]
			}

			pcTargets = {
				player:getObjectsInCell(player.m, player.x, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x, player.y - 2, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x, player.y - 3, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y - 2, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y - 2, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y - 3, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 2, player.y - 3, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y - 3, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 2, player.y - 3, BL_PC)[1]
			}
		elseif (player.side == 1) then
			mobTargets = {
				player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 2, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 3, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 2, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 2, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 3, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 3, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 3, player.y + 2, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 3, player.y - 2, BL_MOB)[1]
			}

			pcTargets = {
				player:getObjectsInCell(player.m, player.x + 1, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 2, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 3, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 2, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 2, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 3, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 3, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 3, player.y + 2, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 3, player.y - 2, BL_PC)[1]
			}
		elseif (player.side == 2) then
			mobTargets = {
				player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x, player.y + 2, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x, player.y + 3, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y + 2, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y + 2, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y + 3, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 2, player.y + 3, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y + 3, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 2, player.y + 3, BL_MOB)[1]
			}

			pcTargets = {
				player:getObjectsInCell(player.m, player.x, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x, player.y + 2, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x, player.y + 3, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y + 2, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y + 2, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y + 3, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 2, player.y + 3, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y + 3, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 2, player.y + 3, BL_PC)[1]
			}
		elseif (player.side == 3) then
			mobTargets = {
				player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 2, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 3, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 2, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 2, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 3, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 3, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 3, player.y + 2, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 3, player.y - 2, BL_MOB)[1]
			}

			pcTargets = {
				player:getObjectsInCell(player.m, player.x - 1, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 2, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 3, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 2, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 2, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 3, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 3, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 3, player.y + 2, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 3, player.y - 2, BL_PC)[1]
			}
		end

		return mobTargets, pcTargets
	end,
	coup_de_grace = function(mob, target)
		local damage = math.random(5000, 15000)

		if mob.sleep ~= 1 then
			return
		end

		mob:talk(2, "Die!")
		mob:playSound(14)
		mob:sendAction(1, 20)
		target:sendAnimation(128)
		target:removeHealthExtend(damage, 1, 1, 1, 1, 3)
	end,
	assassinate = function(mob, target)
		local stunDuration = 7000
		local pcTargets

		local m = mob.m
		local x = mob.x
		local y = mob.y

		local anim = 306
		local anim2 = 410
		local sound = 350

		if mob.sleep ~= 1 then
			return
		end

		-------------------------------------------------------------
		if distanceSquare(mob, target, 5) then
			if findClearPath(mob.side, mob.m, mob.x, mob.y, target, 1) == 1 then
				if target ~= nil then
					-- and here, before warp.
					mob:sendAnimationXY(415, mob.x, mob.y)
					mob:sendAnimationXY(280, mob.x, mob.y)
					mob:playSound(73)

					if target.side == 0 then -- if target is facing north
						grace_essence.checkSouth(mob, target, 1)
					elseif target.side == 1 then -- facing east
						grace_essence.checkWest(mob, target, 1)
					elseif target.side == 2 then -- south
						grace_essence.checkNorth(mob, target, 1)
					elseif target.side == 3 then -- west
						grace_essence.checkEast(mob, target, 1)
					end

					-- here is after warp
					target.attacker = mob.ID
					mob:playSound(sound)
					mob:sendAction(1, 20)
					target:sendAnimation(anim)
					target:sendAnimation(anim2)
					if not target:hasDuration("stun") then
						target:setDuration("stun", 2000)
					end
				end
			end
		end
	end,
	checkSouth = function(player, target, tries)
		if tries >= 5 then
			return
		end

		if getPass(target.m, target.x, target.y + 1) == 1 then -- if walkable is false dont put here.
			tries = tries + 1
			grace_essence.checkEast(player, target, tries)
		else
			player:warp(target.m, target.x, target.y + 1)
			player.side = 0
			player:sendSide()
		end
	end,
	checkWest = function(player, target, tires)
		if tries >= 5 then
			return
		end

		if getPass(target.m, target.x - 1, target.y) == 1 then -- if walkable is false
			tries = tries + 1
			grace_essence.checkSouth(player, target, tries)
		else
			player:warp(target.m, target.x - 1, target.y)
			player.side = 1
			player:sendSide()
		end
	end,
	checkNorth = function(player, target, tries)
		if tries >= 5 then
			return
		end

		if getPass(target.m, target.x, target.y - 1) == 1 then -- if walkable is false
			tries = tries + 1
			grace_essence.checkWest(player, target, tries)
		else
			player:warp(target.m, target.x, target.y - 1)
			player.side = 2
			player:sendSide()
		end
	end,
	checkEast = function(player, target, tries)
		if tries >= 5 then
			return
		end

		if getPass(target.m, target.x + 1, target.y) == 1 then -- if walkable is false
			tries = tries + 1
			grace_essence.checkNorth(player, target, tries)
		else
			player:warp(target.m, target.x + 1, target.y)
			player.side = 3
			player:sendSide()
		end
	end
}

essence_clone = {
	recast = function(mob)
		--	if mob.gfxClone == 0 then
		mob.gfxClone = 1
		--	end
	end
}

will_essence = {
	spells = function(mob, target)
		local areaPC = mob:getObjectsInArea(BL_PC)
		local targetPC = areaPC[1]
		local facingPC = getTargetFacing(mob, BL_PC)

		mob.registry["elemental_sphere_timer"] = mob.registry["elemental_sphere_timer"] + 1
		mob.registry["stop_action_timer"] = mob.registry["stop_action_timer"] + 1
		mob.registry["blink_timer"] = mob.registry["blink_timer"] + 1
		mob.registry["finisher_timer"] = mob.registry["finisher_timer"] + 1
		mob.registry["heal_timer"] = mob.registry["heal_timer"] + 1

		--mob:talk(0,"elemental_sphereTimer: "..mob.registry["elemental_sphere_timer"])
		--mob:talk(0,"stop_actionTimer: "..mob.registry["stop_action_timer"])
		--mob:talk(0,"flurryTimer: "..mob.registry["flurry_timer"])
		--mob:talk(0,"healTimer: "..mob.registry["heal_timer"])

		if mob.registry["elemental_sphere_timer"] >= 18 then
			will_essence.elemental_sphere(mob)
			mob.registry["elemental_sphere_timer"] = 0
			return
		end

		if mob.registry["stop_action_timer"] >= 13 then
			will_essence.stop_action(mob, targetPC)
			mob.registry["stop_action_timer"] = 0
			return
		end

		if mob.registry["blink_timer"] >= 11 then
			if not distanceSquare(mob, targetPC, 2) then
				will_essence.blink(mob)
				mob.registry["blink_timer"] = 0
				return
			end
		end

		if mob.registry["finisher_timer"] >= 21 then
			if facingPC ~= nil then
				will_essence.finisher(mob, facingPC)
				mob.registry["finisher_timer"] = 0
				return
			end
		end

		if mob.registry["heal_timer"] >= 22 then
			if mob.sleep ~= 1 then
				return
			end
			mob:sendAnimation(5)
			mob:playSound(98)
			mob:addHealth(500000)
			mob.registry["heal_timer"] = 0
		end

		--[[
	if r == 1 then
		elemental_sphere.cast(mob, targetPC)
	elseif r == 2 then
		stop_action.cast(mob, targetPC)
	elseif r == 3 then
		if not mob:hasDuration("flurry") then flurry.cast(mob, mob) end
	elseif r == 4 then
		mob:sendAnimation(5)
		mob:playSound(98)
		mob:addHealthExtend(1000000, 1,1,1,1,0)
	end
]]
	 --
	end,
	move = function(mob, target)
		if mob.paralyzed == true then
			mob.paralyzed = false
			mob:calcStat()
		end

		--	will_essence.disguise(mob)
		mob_ai_basic.move(mob, target)
		will_essence.spells(mob, target)
	end,
	attack = function(mob, target)
		if mob.paralyzed == true then
			mob.paralyzed = false
			mob:calcStat()
		end

		--	will_essence.disguise(mob)
		mob_ai_basic.attack(mob, target)
		will_essence.spells(mob, target)
	end,
	on_healed = function(mob, healer)
		if mob.paralyzed == true then
			mob.paralyzed = false
			mob:calcStat()
		end

		mob_ai_basic.on_healed(mob, healer)
	end,
	on_attacked = function(mob, attacker)
		if mob.paralyzed == true then
			mob.paralyzed = false
			mob:calcStat()
		end
		mob_ai_basic.on_attacked(mob, attacker)
	end,
	after_death = function(mob)
		local attacker = mob:getObjectsInArea(BL_PC)

		if #attacker > 0 then
			for i = 1, #attacker do
				attacker[i]:msg(4, "[Quest Completed] Congratulations! You killed... yourself? What the...?", attacker[i].ID)
				attacker[i]:sendMinitext("You've done it. You've defeated yourself. What could possibly be left to do?")
				attacker[i]:popUp("You feel your chest compressing. It is getting difficult to breathe.")
				attacker[i]:setDuration("will_essence", 5000)
			end
		end
	end,
	uncast = function(player)
		player:sendAnimation(1)
		player:playSound(1)
		player.health = 0
		player.state = 1
		player:updateState()
		player:sendStatus()
		player.registry["strength_trial_death_timer"] = os.time() + 5
	end,
	autoWarp = function(player)
		if player.mapTitle == "Trial of Strength and Wits" and player.state == 1 then
			if player.registry["strength_trial_death_timer"] > 0 and player.registry["strength_trial_death_timer"] < os.time() then
				player:warp(52, 0, 0)
			end
		end
	end,
	on_spawn = function(mob)
		will_essence.disguise(mob)
		mob:setDuration("essence_clone", 9999999)
		mob.state = MOB_ALIVE
	end,
	disguise = function(mob)
		local pc = mob:getObjectsInArea(BL_PC)

		if #pc > 0 then
			for i = 1, #pc do
				if pc[i].state ~= 1 then
					clone.equip(pc[i], mob)
					mob.gfxClone = 1
					pc[i]:refresh()
					mob.target = pc[math.random(#pc)].ID
				end
			end
		end
	end,
	elemental_sphere = function(mob)
		local pcTargets = {}
		local targets = {}

		local m = mob.m
		local x = mob.x
		local y = mob.y

		local anim
		local sound
		local effect
		local duration

		if mob.sleep ~= 1 then
			return
		end

		local pcTargets = {
			mob:getObjectsInCell(mob.m, mob.x + 1, mob.y, BL_PC)[1],
			mob:getObjectsInCell(mob.m, mob.x - 1, mob.y, BL_PC)[1],
			mob:getObjectsInCell(mob.m, mob.x, mob.y + 1, BL_PC)[1],
			mob:getObjectsInCell(mob.m, mob.x, mob.y - 1, BL_PC)[1],
			mob:getObjectsInCell(mob.m, mob.x + 1, mob.y + 1, BL_PC)[1],
			mob:getObjectsInCell(mob.m, mob.x + 1, mob.y - 1, BL_PC)[1],
			mob:getObjectsInCell(mob.m, mob.x - 1, mob.y + 1, BL_PC)[1],
			mob:getObjectsInCell(mob.m, mob.x - 1, mob.y - 1, BL_PC)[1]
		}

		---------------------------
		--- Spell Damage Formula---

		local damage = math.random(3500, 10000)
		---------------------------------
		-- Cast Checks ------------------
		---------------------------------

		-- Check for Players --
		for i = 1, #pcTargets do
			if (distanceSquare(mob, pcTargets[i], 1) and pcTargets[i].ID ~= mob.ID) then
				table.insert(targets, pcTargets[i])
			end
		end

		---------------------------------------------
		-- If there are targets, remove mana cost ---
		---------------------------------------------
		if (#targets > 0) then
			for i = 1, #targets do
				if targets[i] ~= nil then
					if targets[i].registry["wizard_element_choice"] == 1 then --Ice
						anim = 26
						sound = 46
						effect = "slow"
						duration = 5000
					elseif targets[i].registry["wizard_element_choice"] == 2 then --Fire
						anim = 48
						sound = 29
						effect = "seared"
						duration = 3000
					elseif targets[i].registry["wizard_element_choice"] == 3 then --Lightning
						anim = 4
						sound = 57
						effect = "shock"
						duration = 3000
					end
					targets[i]:playSound(sound)
					targets[i].attacker = mob.ID
					targets[i]:sendMinitext(mob.name .. " blasts you with an Elemental Sphere")
					targets[i]:sendAnimation(anim)
					targets[i]:setDuration(effect, duration)
					targets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 3)
				end
			end
		end
	end,
	stop_action = function(mob, target)
		local spellName = "Stop Action"
		local anim1 = 1
		local damage = math.random(1000, 2000)
		local sound = 106

		if mob.sleep ~= 1 then
			return
		end

		mob:playSound(sound)

		target:sendMinitext("" .. mob.name .. " cast " .. spellName .. " on you")
		target:sendAnimation(anim1)
		target:setDuration("stun", 2000)
		target:removeHealthExtend(damage, 1, 1, 1, 1, 3)
		target:calcStat()
	end,
	blink = function(mob)
		if mob.sleep ~= 1 then
			return
		end

		mob:sendAction(6, 20)
		will_essence.blinkWarp(mob, 1)
	end,
	blinkWarp = function(mob, tries)
		local m = mob.m
		local x = mob.x + math.random(-3, 3)
		local y = mob.y + math.random(-3, 3)
		local sound = 735
		local anim = 415

		local mob = mob:getObjectsInCell(m, x, y, BL_MOB)
		local pc = mob:getObjectsInCell(m, x, y, BL_PC)

		local startX, startY = mob.x, mob.y

		tries = tries + 1
		if tries >= 10 then
			return
		end

		if x < 1 then
			x = 1
		elseif x > mob.xmax then
			x = mob.xmax - 1
		end

		if y < 1 then
			y = 1
		elseif y > mob.ymax then
			y = mob.ymax - 1
		end

		if findClearPath(mob.side, mob.m, x, y, mob, 1) == 1 then
			if getPass(m, x, y) == 0 then
				if getObject(m, x, y) == 0 then
					if #mob == 0 then
						if #pc == 0 then
							mob:playSound(sound)
							mob:sendAnimationXY(anim, mob.x, mob.y, 1)
							mob:warp(m, x, y)
							mob:sendAnimation(anim)
							--mob:talk(0,"Warped: "..m..", "..x..", "..y.."!")
							if mob.x == startX and mob.y == startY then
								return will_essence.blinkWarp(mob, tries)
							end
						else
							return will_essence.blinkWarp(mob, tries)
						end
					else
						return will_essence.blinkWarp(mob, tries)
					end
				else
					return will_essence.blinkWarp(mob, tries)
				end
			else
				return will_essence.blinkWarp(mob, tries)
			end
		else
			return will_essence.blinkWarp(mob, tries)
		end
	end,
	finisher = function(mob, target)
		local damage = math.random(5000, 15000)

		if mob.sleep ~= 1 then
			return
		end

		mob:playSound(14)
		mob:sendAction(1, 20)
		target:sendAnimation(105)
		target:removeHealthExtend(damage, 1, 1, 1, 1, 3)
	end
}
