--heals and says GRRRAHH! 22s
--cast Diseased saliva, has black ghost gfx, probably armor debuff,
--says "YOU KILL BRUDDER!" and does back and forth blue slashes 19s
--says DIE NOW and does back and forth triple slashes 28s
--plays red circle swirl on himself for some reason -- dispel, every 5s
-- walk away he says COME HERE leaps with single slash gfx
--immune to scream
--can be para'd

bloth = {
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

		mob.registry["strike1_timer"] = mob.registry["strike1_timer"] + counter
		mob.registry["strike2_timer"] = mob.registry["strike2_timer"] + counter
		mob.registry["dispel_timer"] = mob.registry["dispel_timer"] + counter
		mob.registry["saliva_timer"] = mob.registry["saliva_timer"] + counter
		mob.registry["leap_timer"] = mob.registry["leap_timer"] + counter
		mob.registry["heal_timer"] = mob.registry["heal_timer"] + counter

		--	mob:talk(0,"leapTimer: "..mob.registry["leap_timer"])

		--mob:talk(0,"healTimer: "..mob.registry["heal_timer"])
		mob:sendAnimation(320)

		if mob.registry["strike1_timer"] >= 22 then
			if facingPC ~= nil then
				bloth.strike1(mob, facingPC)
				return
			end
		end

		if mob.registry["strike2_timer"] >= 31 then
			if facingPC ~= nil then
				bloth.strike2(mob, facingPC)
				return
			end
		end

		if mob.registry["dispel_timer"] >= 11 then
			bloth.dispel(mob)
			return
		end

		if mob.registry["saliva_timer"] >= 25 then
			if facingPC ~= nil then
				bloth.saliva(mob, facingPC)
				return
			end
		end

		if mob.registry["leap_timer"] >= 28 then
			if not distanceSquare(mob, targetPC, 1) then
				bloth.leap(mob, targetPC)
				return
			end
		end

		if mob.registry["heal_timer"] >= 33 then
			bloth.heal(mob)
			return
		end
	end,
	move = function(mob, target)
		mob_ai_basic.move(mob, target)
		bloth.magicCast(mob, target)
	end,
	attack = function(mob, target)
		mob_ai_basic.attack(mob, target)
		bloth.magicCast(mob, target)
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
		mob:talk(1, "Bloth! YOU KILL MY BROTHER?! I KILL YOU!")
		mob.registry["strike1_timer"] = 10
		mob.registry["strike2_timer"] = 10
		mob.registry["dispel_timer"] = 10
		mob.registry["saliva_timer"] = 10
		mob.registry["leap_timer"] = 10
		mob.registry["heal_timer"] = 10
		mob.state = MOB_ALIVE
	end,
	strike1 = function(mob, target)
		local damage = math.random(594, 946)

		if mob.sleep ~= 1 then
			return
		end

		mob:talk(2, "YOU KILL BRUDDER!")
		mob:playSound(98)
		mob:sendAction(1, 20)
		target:sendAnimation(68)
		target:removeHealthExtend(damage, 1, 1, 1, 1, 3)
		mob.registry["strike1_timer"] = 0
	end,
	strike2 = function(mob, target)
		local damage = math.random(891, 1419)

		if mob.sleep ~= 1 then
			return
		end

		mob:talk(2, "DIE NOW")
		mob:playSound(98)
		mob:sendAction(1, 20)
		target:sendAnimation(67)
		target:removeHealthExtend(damage, 1, 1, 1, 1, 3)
		mob.registry["strike2_timer"] = 0
	end,
	dispel = function(mob)
		if not mob:hasDuration("asleep") then
			mob:sendAnimation(51)
			mob:playSound(98)
			mob:flushDuration()
			mob.registry["dispel_timer"] = 0
		end
	end,
	saliva = function(mob, target)
		if mob.sleep ~= 1 then
			return
		end

		mob:playSound(98)
		mob:sendAnimation(27)
		if not target:hasDuration("diseased_saliva") then
			target:sendMinitext("Bloth cast Diseased Saliva on you")
			target:setDuration("diseased_saliva", 200000)
			target:sendAnimation(111)
			target:calcStat()
		end

		mob.registry["saliva_timer"] = 0
	end,
	leap = function(mob, target)
		mob:talk(2, "COME HERE")
		bloth.leapAction(mob, target)
		mob.registry["leap_timer"] = 0
	end,
	heal = function(mob)
		if mob.sleep ~= 1 then
			return
		end

		mob:talk(2, "GRRRAHH!")
		mob:sendAnimation(5)
		mob:playSound(98)
		mob.health = mob.health + 250000
		if mob.health > mob.maxHealth then
			mob.health = mob.maxHealth
		end
		mob.registry["heal_timer"] = 0
	end,
	leapAction = function(mob, target)
		local damage = math.random(891, 1419)
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
							target:removeHealthExtend(damage, 1, 1, 1, 1, 3)
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
	end
}

diseased_saliva = {
	while_cast = function(player)
		player:sendAnimation(34)
	end,
	recast = function(player)
		player.armor = player.armor - 5000
		if player.armor < 0 then
			player.armor = 0
		end
	end,
	uncast = function(player)
		player:calcStat()
	end
}
