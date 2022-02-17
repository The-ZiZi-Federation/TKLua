sumo_mob = {
	move = function(mob, target)
		mob_ai_basic.move(mob, target)
	end,
	attack = function(mob, target)
		local moved
		local pc = getTargetFacing(mob, BL_PC)
		local mobT = getTargetFacing(mob, BL_MOB)
		local targetBlock = mob:getBlock(mob.target)

		if (mob.target == 0) or (targetBlock.state == 2) then --updated 5-3-17 for new hide in shadows
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
						--mob:attack(pc.ID)
						sumo_mob.push(mob, target)
					elseif mobT ~= nil then
						mob:attack(mobT.ID)
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
	push = function(mob, target)
		local waterTile = {628, 35012, 35013, 17816, 35011, 35010, 35009, 35017, 35015, 35014, 35025, 35016}
		local targetPC = getTargetFacing(mob, BL_PC)
		local targetMob = getTargetFacing(mob, BL_MOB)
		local m, x, y = mob.m, mob.x, mob.y

		if targetPC ~= nil and targetPC.state ~= 1 then
			mob:sendFrontAnimation(191)
			if mob.side == 0 then
				x = targetPC.x
				y = targetPC.y - 1
			elseif mob.side == 1 then
				x = targetPC.x + 1
				y = targetPC.y
			elseif mob.side == 2 then
				x = targetPC.x
				y = targetPC.y + 1
			elseif mob.side == 3 then
				x = targetPC.x - 1
				y = targetPC.y
			end

			if getPass(m, x, y) == 0 then
				targetPC:warp(targetPC.m, x, y)
				mob:sendAction(1, 20)
			elseif getPass(m, x, y) == 1 then
				mob:sendAction(1, 20)
				for i = 1, #waterTile do
					if getTile(m, x, y) == waterTile[i] then
						if mob.m == 1000 then
							--targetPC:warp(1000, 27, 83)
							targetPC:warp(targetPC.m, x, y)
							targetPC.state = 1
							targetPC:updateState()
							targetPC:sendAnimation(142)
							targetPC:sendAnimationXY(137, targetPC.x, targetPC.y)
							mob:playSound(73)
							mob:talk(2, "Die!")
						else
							sumo_course.splash(targetPC)
						end
					end
				end
			end
		end
	end,
	on_healed = function(mob, healer)
		mob.attacker = healer.ID
		mob:sendHealth(healer.damage, healer.critChance)
		healer.damage = 0
	end,
	on_attacked = function(mob, attacker)
		--mob_ai_basic.on_attacked(mob, attacker)
	end
}
