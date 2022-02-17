mob_ai_basic = {
	on_healed = function(mob, healer)
		mob.attacker = healer.ID
		mob:sendHealth(healer.damage, healer.critChance)
		healer.damage = 0
	end,
	on_attacked = function(mob, attacker)
		if (mob:hasDuration("mark_of_death")) then
			attacker.damage = attacker.damage * 2
		end

		if (attacker.blType == BL_PC) then
			if (attacker.registry["dps_potion"] > 0) then
				attacker.dmgDealt = attacker.dmgDealt + attacker.damage
			end
		end

		mob.attacker = attacker.ID
		mob:sendHealth(attacker.damage, attacker.critChance)
		attacker.damage = 0
	end,
	move = function(mob, target)
		local found
		local moved = true
		local oldside = mob.side
		local checkmove = math.random(0, 10)

		if (mob.paralyzed == true or mob.sleep ~= 1) then
			return
		end

		if (mob.retDist <= distanceXY(mob, mob.startX, mob.startY) and mob.retDist > 1 and mob.returning == false) then
			mob.newMove = 250
			mob.deduction = mob.deduction - 1
			mob.returning = true
		elseif (mob.returning == true and mob.retDist > distanceXY(mob, mob.startX, mob.startY) and mob.retDist > 1) then
			mob.newMove = mob.baseMove
			mob.deduction = mob.deduction + 1
			mob.returning = false
		end

		if (mob.returning == true) then
			found = toStart(mob, mob.startX, mob.startY)
		else
			if (mob.owner == 0 or mob.owner > 1073741823) then
				threat.calcHighestThreat(mob)
				local block = mob:getBlock(mob.target)
				if (block ~= nil and block.state ~= 2) then
					target = block
				end
			end

			if not distanceSquare(mob, target, 10) then
				target = nil
			end

			if (mob.state ~= MOB_HIT and target == nil and mob.owner == 0) then
				if (checkmove >= 4) then
					mob.side = math.random(0, 3)
					mob:sendSide()
					if (mob.side == oldside and not mob.snare and not mob.blind) then
						moved = mob:move()
					end
				elseif (not mob.snare and not mob.blind) then
					moved = mob:move()
				end
			else
				local owner = mob:getBlock(mob.owner)

				if (target == nil and owner ~= nil) then
					target = mob:getBlock(owner.target)
					mob.target = owner.target
				end
				if (target ~= nil) then
					if (not mob.snare and not mob.blind) then
						moved = FindCoords(mob, target)
					end

					if ((moved or mob:moveIntent(target.ID) == 1) and mob.target ~= mob.owner) then
						mob.state = MOB_HIT
					end
				end
			end
		end

		if (found == true) then
			mob.newMove = 0
			mob.deduction = mob.deduction + 1
			mob.returning = false
		end
	end,
	 --
	--[[on_hit=function(mob,target)
		
		if target then
				
				
				local moved=FindCoords(mob,target,1)
				if(moved) then
					--We are right next to them, so attack!	
					mob:attackIT(target,mob.might,mob.might/2)
				end
				-- mob:spawn(1,mob.x+1,mob.y,1,5)	
				
			
		end
		
	end,]] attack = function(
		mob,
		target)
		local moved
		--		Player(4):talk(0,"!!!!!!!!!!!!!!!!!!!!1111111111111111!")

		if (mob.target == 0) or (target.state == 2) then
			--	Player(4):talk(0,"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
			mob.target = 0
			mob.state = MOB_ALIVE
			mob_ai_basic.move(mob, target)
			return
		end

		if (mob.paralyzed or mob.sleep ~= 1) then
			return
		end

		if (target) then
			if (target.state == 2) then
				--	Player(4):talk(0,"state")
				mob.target = 0
				mob.state = MOB_ALIVE
				mob_ai_basic.move(mob, target)
				return
			end
			threat.calcHighestThreat(mob)
			local block = mob:getBlock(mob.target)
			if (block ~= nil) then
				target = block
			end
			moved = FindCoords(mob, target)
			if (moved and mob.target ~= mob.owner) then
				--We are right next to them, so attack!
				mob:attack(target.ID)
			else
				mob.state = MOB_ALIVE
			end
		else
			mob.state = MOB_ALIVE
		end
	end
}

mob_ai_basic_backup = {
	--swapped on 8-28-17 back to version from 8-11
	on_healed = function(mob, healer)
		mob.attacker = healer.ID
		mob:sendHealth(healer.damage, healer.critChance)
		healer.damage = 0
	end,
	on_attacked = function(mob, attacker)
		local damage = attacker.damage

		if mob:hasDuration("called_shot") then
			damage = damage * 2
		--mob:setDuration("called_shot", 0)
		end

		mob.attacker = attacker.ID
		mob:sendHealth(damage, attacker.critChance)
		attacker.damage = 0
	end,
	move = function(mob, target)
		local found
		local moved = true
		local oldside = mob.side
		local checkmove = math.random(0, 10)

		if (mob.paralyzed == true or mob.sleep ~= 1) then
			return
		end

		if (mob.retDist <= distanceXY(mob, mob.startX, mob.startY) and mob.retDist > 1 and mob.returning == false) then
			mob.newMove = 250
			mob.deduction = mob.deduction - 1
			mob.returning = true
		elseif (mob.returning == true and mob.retDist > distanceXY(mob, mob.startX, mob.startY) and mob.retDist > 1) then
			mob.newMove = mob.baseMove
			mob.deduction = mob.deduction + 1
			mob.returning = false
		end

		if (mob.returning == true) then
			found = toStart(mob, mob.startX, mob.startY)
		else
			--if mob.m == 1 then Player(4):talk(0,"1") end
			if (mob.owner == 0 or mob.owner > 1073741823) then
				--if mob.m == 1 then Player(4):talk(0,"2") end
				threat.calcHighestThreat(mob)
				--if mob.m == 1 then Player(4):talk(0,"3") end
				local block = mob:getBlock(mob.target)
				--if mob.m == 1 then Player(4):talk(0,"4") end
				if (block ~= nil and block.state ~= 2) then
					--if mob.m == 1 then Player(4):talk(0,"5") end
					target = block
				end
			end
			--if mob.m == 1 then Player(4):talk(0,"6") end
			if distance(mob, target) > 10 then
				target = nil
			end
			--if mob.m == 1 then Player(4):talk(0,"7") end
			if (mob.state ~= MOB_HIT and target == nil and mob.owner == 0) then
				--if mob.m == 1 then Player(4):talk(0,"8") end
				if (checkmove >= 4) then
					--if mob.m == 1 then Player(4):talk(0,"13") end
					--if mob.m == 1 then Player(4):talk(0,"9") end
					mob.side = math.random(0, 3)
					--if mob.m == 1 then Player(4):talk(0,"10") end
					mob:sendSide()
					--if mob.m == 1 then Player(4):talk(0,"11") end
					if (mob.side == oldside and not mob.snare and not mob.blind) then
						--if mob.m == 1 then Player(4):talk(0,"12") end
						moved = mob:move()
					end
				elseif (not mob.snare and not mob.blind) then
					--if mob.m == 1 then Player(4):talk(0,"14") end
					moved = mob:move()
				end
			else
				--if mob.m == 1 then Player(4):talk(0,"15") end
				local owner = mob:getBlock(mob.owner)
				--if mob.m == 1 then Player(4):talk(0,"16") end
				if (target == nil and owner ~= nil) then
					--if mob.m == 1 then Player(4):talk(0,"17") end
					target = mob:getBlock(owner.target)
					--if mob.m == 1 then Player(4):talk(0,"18") end
					if owner.target > 0 then
						--if mob.m == 1 then Player(4):talk(0,"19") end
						mob.target = owner.target
					else
						--if mob.m == 1 then Player(4):talk(0,"20") end
						mob.target = owner.ID
					end
				end
				--if mob.m == 1 then Player(4):talk(0,"21") end
				if (target ~= nil) then
					--if mob.m == 1 then Player(4):talk(0,"22") end
					if (not mob.snare and not mob.blind) then
						--if mob.m == 1 then Player(4):talk(0,"23") end
						moved = FindCoords(mob, target)
					end
					--if mob.m == 1 then Player(4):talk(0,"24")	end
					if ((moved or mob:moveIntent(target.ID) == 1) and mob.target ~= mob.owner) then
						--if mob.m == 1 then Player(4):talk(0,"25") end
						mob.state = MOB_HIT
					end
				end
			end
		end

		if (found == true) then
			mob.newMove = 0
			mob.deduction = mob.deduction + 1
			mob.returning = false
		end
	end,
	 --
	--[[on_hit=function(mob,target)
		
		if target then
				
				
				local moved=FindCoords(mob,target,1)
				if(moved) then
					--We are right next to them, so attack!	
					mob:attackIT(target,mob.might,mob.might/2)
				end
				-- mob:spawn(1,mob.x+1,mob.y,1,5)	
				
			
		end
		
	end,]] attack = function(
		mob,
		target)
		local moved
		--		Player(4):talk(0,"!!!!!!!!!!!!!!!!!!!!1111111111111111!")

		if (mob.target == 0) or (target.state == 2) then
			--	Player(4):talk(0,"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
			mob.target = 0
			mob.state = MOB_ALIVE
			mob_ai_basic.move(mob, target)
			return
		end

		if (mob.paralyzed or mob.sleep ~= 1) then
			return
		end

		if (target) then
			if (target.state == 2) then
				--	Player(4):talk(0,"state")
				mob.target = 0
				mob.state = MOB_ALIVE
				mob_ai_basic.move(mob, target)
				return
			end
			threat.calcHighestThreat(mob)
			local block = mob:getBlock(mob.target)
			if (block ~= nil) then
				target = block
			end
			moved = FindCoords(mob, target)
			if (moved and mob.target ~= mob.owner) then
				--We are right next to them, so attack!
				mob:attack(target.ID)
			else
				mob.state = MOB_ALIVE
			end
		else
			mob.state = MOB_ALIVE
		end
	end
}
