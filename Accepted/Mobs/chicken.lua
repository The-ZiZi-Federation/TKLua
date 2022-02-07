chicken = {
	move = function(mob, target)
		local moved = true
		local pc = mob:getObjectsInArea(BL_PC)
		local ch1 = math.random(0, 10)
		local ch2 = math.random(0, 20)

		if mob.sleep ~= 1 then
			return
		end

		if mob.paralyzed == true then
			return
		else
			if not mob.snare and not mob.blind then
				if target == nil then
					if ch1 <= 3 then
						mob.side = ch1
						mob:sendSide()
					else
						if ch2 < ch1 then
							moved = mob:move()
						end
					end
					if #pc > 0 then
						for i = 1, #pc do
							if pc[i].state ~= 1 and pc[i].state ~= 2 then
								if distanceSquare(mob, pc[i], 3) then
									anim(mob)
									RunAway(mob, pc[i])
									break
								end
							end
						end
					end
					return
				else
					if target.state ~= 1 and target.state ~= 2 then
						moved = FindCoords(mob, target)
						if mob:moveIntent(target.ID) == 1 then
							mob.state = MOB_HIT
						end
					end
				end
			end
		end
	end,
	on_attacked = function(mob, attacker)
		anim(mob)
		capture.chicken(attacker)
		RunAway(mob, attacker)
		mob.attacker = attacker.ID
		mob.target = 0
		mob:sendHealth(0, 0)
	end,
	on_spawn = function(mob)
		local pc = mob:getObjectsInArea(BL_PC)

		if mob.target == 0 then
			if #pc > 0 then
				for i = 1, #pc do
					if pc[i].state ~= 1 then
						mob.state = MOB_HIT
					end
				end
			end
		end
	end,
	on_healed = function(mob, healer)
		return
	end,
	before_death = function(mob)
		return
	end,
	after_death = function(mob)
		return
	end,
	attack = function(mob, target)
		local moved = true
		local pc = getTargetFacing(mob, BL_PC)

		if mob.sleep ~= 1 then
			return
		end

		if mob.paralyzed == true then
			return
		else
			if not mob.snare and not mob.blind then
				if target.state ~= 1 and target.state ~= 2 then
					moved = FindCoords(mob, target)
					if mob:moveIntent(target.ID) == 1 then
						if pc ~= nil and pc.ID == target.ID then
							mob:attack(pc.ID)
						end
					end
				else
					mob.target = 0
					mob.state = MOB_ALIVE
				end
			end
		end
	end
}

black_chicken = {
	move = function(mob, target)
		local moved = true
		local pc = mob:getObjectsInArea(BL_PC)
		local ch1 = math.random(0, 10)
		local ch2 = math.random(0, 20)

		if mob.sleep ~= 1 then
			return
		end

		if mob.paralyzed == true then
			return
		else
			if not mob.snare and not mob.blind then
				if target == nil then
					if ch1 <= 3 then
						mob.side = ch1
						mob:sendSide()
					else
						if ch2 < ch1 then
							moved = mob:move()
						end
					end
					if #pc > 0 then
						for i = 1, #pc do
							if pc[i].state ~= 1 and pc[i].state ~= 2 then
								if distanceSquare(mob, pc[i], 3) then
									anim(mob)
									RunAway(mob, pc[i])
									break
								end
							end
						end
					end
					return
				else
					if target.state ~= 1 and target.state ~= 2 then
						moved = FindCoords(mob, target)
						if mob:moveIntent(target.ID) == 1 then
							mob.state = MOB_HIT
						end
					end
				end
			end
		end
	end,
	on_attacked = function(mob, attacker)
		anim(mob)
		capture.chicken(attacker)
		RunAway(mob, attacker)
		mob.attacker = attacker.ID
		mob.target = 0
		mob:sendHealth(0, 0)
	end,
	on_spawn = function(mob)
		local pc = mob:getObjectsInArea(BL_PC)

		if mob.target == 0 then
			if #pc > 0 then
				for i = 1, #pc do
					if pc[i].state ~= 1 then
						mob.state = MOB_HIT
					end
				end
			end
		end
	end,
	on_healed = function(mob, healer)
		return
	end,
	before_death = function(mob)
		return
	end,
	after_death = function(mob)
		return
	end,
	attack = function(mob, target)
		local moved = true
		local pc = getTargetFacing(mob, BL_PC)

		if mob.sleep ~= 1 then
			return
		end

		if mob.paralyzed == true then
			return
		else
			if not mob.snare and not mob.blind then
				if target.state ~= 1 and target.state ~= 2 then
					moved = FindCoords(mob, target)
					if mob:moveIntent(target.ID) == 1 then
						if pc ~= nil and pc.ID == target.ID then
							mob:attack(pc.ID)
						end
					end
				else
					mob.target = 0
					mob.state = MOB_ALIVE
				end
			end
		end
	end
}

capture = {
	chicken = function(player)
		local target = getTargetFacing(player, BL_MOB)
		--	local chickens = player.registry["chickens_caught"]
		--	local chickens2 = player.registry["black_chickens_caught"]

		if target ~= nil then
			if target.yname == "chicken" and player.registry["chickens_caught"] <= 3 then
				target.look = 433
				player:refresh()
				player:sendAnimationXY(397, target.x, target.y)
				target:removeHealthWithoutDamageNumbers(999999999)
				player:addItem("white_chicken", 1)
				player:sendMinitext("You caught a chicken!")
				player.registry["chickens_caught"] = player.registry["chickens_caught"] + 1
			elseif target.yname == "black_chicken" and player.registry["black_chickens_caught"] == 0 then
				if player:hasDuration("quickness") then
					target.look = 433
					player:refresh()
					player:sendAnimationXY(397, target.x, target.y)
					target:removeHealthWithoutDamageNumbers(999999999)
					player:addItem("black_chicken", 1)
					player:sendMinitext("Thanks to your Quickness, you finally caught the Black Chicken!")
					player.registry["black_chickens_caught"] = player.registry["black_chickens_caught"] + 1
				else
					player:sendMinitext("The chicken got away! You don't seem to be fast enough...")
					RunAway(mob, attacker)
				end
			elseif target.yname == "chicken" or target.yname == "black_chicken" then
				target:sendHealth(0, 0)
				player:sendMinitext("You've caught enough chickens already!")
			end
		end
	end
}
