haunted_tree = {
	on_spawn = function(mob)
		--	mob.state = MOB_HIT
		mob.side = 2
		mob:sendSide()
		mob:talk(2, "Haunted Tree: WE ARE IMMORTAL!")

		mob.registry["roots_timer"] = math.random(1, 50)
		mob.registry["talk_timer"] = math.random(1, 50)
	end,
	on_attacked = function(mob, attacker)
		mob:sendHealth(0, 0)
		--	mob.attacker = attacker.ID
		--	mob:sendHealth(attacker.damage, attacker.critChance)
		--	mob.side = 2
		--	mob:sendSide()
	end,
	move = function(mob, target)
		local facing = getTargetFacing(mob, BL_ALL)
		local moved = true
		local move1, move2 = math.random(0, 10), math.random(0, 20)
		local pcarea = mob:getObjectsInArea(BL_PC)

		threat.calcHighestThreat(mob)
		if target == nil then
			pc = mob:getObjectsInArea(BL_PC)
			if #pc > 0 then
				for i = 1, #pc do
					if distanceSquare(mob, pc[i], 7) then
						if pc[i].state ~= 1 and pc[i].state ~= 2 then
							mob.target = pc[math.random(#pc)].ID
						end
					end
				end
			end
			return
		else
			if target.state ~= 1 and target.state ~= 2 then
				--			moved = FindCoords(mob, target)
				--			if mob:moveIntent(target.ID) == 1 then
				mob.state = MOB_HIT
			--			end
			end
		end
		mob.side = 2
		mob:sendSide()
	end,
	attack = function(mob, target)
		mob.registry["roots_timer"] = mob.registry["roots_timer"] + 1
		mob.registry["talk_timer"] = mob.registry["talk_timer"] + 1

		if mob.registry["roots_timer"] >= 60 then
			haunted_tree.roots(mob, target)
			mob.registry["roots_timer"] = 0
		end

		if mob.registry["talk_timer"] >= 60 then
			haunted_tree.talk(mob)
			mob.registry["talk_timer"] = 0
		end

		--	if mob.paralyzed == true or mob.sleep ~= 1 then return end

		mob.side = 2
		mob:sendSide()
		--	mob_ai_basic.attack(mob, target)
	end,
	before_death = function(mob, attacker)
		if not mob:hasDuration("eclipse_burn") then
			mob:spawn(3007, mob.x, mob.y, 1, mob.m)
		else
			if attacker.sex == 0 then
				gender = "HE"
			elseif attacker.sex == 1 then
				gender = "SHE"
			end
			mob:talk(2, "" .. mob.name .. ": NOOOO! " .. gender .. " HAS THE TORCH! Curse you, " .. attacker.name .. "!")
		end
	end,
	talk = function(mob)
		if #pc > 0 then
			for i = 1, 1 do
				t = pc[math.random(#pc)].ID
			end
		end

		local rtalk = {
			"Leave while you still can!",
			"This place is death!",
			"You're going to die here, " .. Player(t).name .. "!",
			"You can't kill us, mortal!",
			"Your magic is worthless here!"
		}

		mob:talk(2, "" .. mob.name .. ": " .. rtalk[math.random(#rtalk)])
	end,
	roots = function(mob, target)
		local pc = mob:getObjectsInMap(mob.m, BL_PC)
		local damage = math.random(800, 1200)

		if #pc > 0 then
			for i = 1, 1 do
				t = pc[math.random(#pc)].ID
				if Player(t) ~= nil and Player(t).state ~= 1 then
				end
			end
		end

		if distanceSquare(mob, Player(t), 7) then
			Player(t).attacker = mob.ID
			Player(t):sendAnimation(399)
			Player(t):playSound(59)
			Player(t):sendMinitext("Strangling Roots hold you in place!")
			mob:talk(2, "" .. mob.name .. ": *cackles*")
			if not Player(t):hasDuration("strangling_roots") then
				Player(t):setDuration("strangling_roots", 5000)
			end
			Player(t):removeHealthExtend(damage, 1, 1, 1, 1, 3)
		end
	end
}
