mob_ai_boss = {
	before_death = function(mob)
		local attacker = mob:getBlock(mob.attacker)
		local user = mob:getUsers()

		if #user > 0 then
			for i = 1, #user do
				broadcast(-1, "=== >> [MvP] " .. mob.name .. " vanquished by " .. attacker.name .. " << ===")
			end
		end
	end,
	magicCast = function(mob, target)
		if mob.yname == "shen_lon" then
			shen_lon.cast(mob, target)
			if not distanceSquare(mob, target, 2) then
				shen_lon2.cast(mob)
			end
		end
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
				moved = FindCoords(mob, target)
				if mob:moveIntent(target.ID) == 1 then
					mob.state = MOB_HIT
				end
			end
		end
	end,
	attack = function(mob, target)
		local moved

		threat.calcHighestThreat(mob)

		if mob.target == 0 then
			mob.state = MOB_ALIVE
			return
		else
			if target ~= nil then
				if target.state ~= 1 and target.state ~= 2 then
					moved = FindCoords(mob, target)
					if mob:moveIntent(target.ID) == 1 then
						mob:attack(target.ID)
					end
				else
					mob.state = MOB_ALIVE
				end
			end
		end
		mob_ai_boss.magicCast(mob, target)
	end,
	on_healed = function(mob, healer)
		mob.attacker = healer.ID
		mob:sendHealth(healer.damage, healer.critChance)
		healer.damage = 0
	end,
	on_attacked = function(mob, attacker) --
		--[[	
	local damage = 0
	local threat
	local armor = mob.armor
	local armorPhysReduction
	local constantPKFactor = 1.0

	
	if attacker.damage > 0 then
		-- calc physical damage reduction
		armorPhysReduction = ((armor/(armor + 510)) * constantPKFactor)
		-- apply damage reduction to damage amount
		damage = (attacker.damage - (attacker.damage * (armorPhysReduction)) * constantPKFactor)
	end
	mob.attacker = attacker.ID
	mob:sendHealth(damage, attacker.critChance)
	attacker:sendStatus()
]] mob_ai_basic.on_attacked(
			mob,
			attacker
		)
	end,
	on_spawn = function(mob)
		local pc = mob:getObjectsInArea(BL_PC)

		if #pc > 0 then
			for i = 1, #pc do
				if pc[i].state ~= 1 then
					mob.target = pc[math.random(#pc)].ID
				end
			end
		end
		mob.state = MOB_ALIVE
	end
}
