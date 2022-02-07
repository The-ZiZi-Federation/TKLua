slowtest = {
	on_learn = function(player)
		player.registry["learned_slowtest"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_slowtest"] = 0
	end,
	cast = function(player, target)
		local duration = 17000
		local aether = 22000
		local anim = 421
		local sound = 58
		local magicCost = 2500

		local threat
		local mobBlocks = player:getObjectsInArea(BL_MOB)
		local pcBlocks = player:getObjectsInArea(BL_PC)
		local targets = {}

		if (not player:canCast(1, 1, 0)) then
			return
		end

		if (player.magic < magicCost) then
			player:sendMinitext("Not enough mana.")
			return
		end

		if (player.state == 1) then
			player:sendMinitext("That is no longer useful.")
			return
		end

		player:calcStat()
		player:sendStatus()
		player:sendAction(6, 20)
		player:sendMinitext("You cast Flurry")
		player:sendAnimation(anim)
		player:playSound(sound)
		player:setAether("slowtest", aether)
		player:setDuration("slowtest", duration, player.ID)
	end,
	while_cast = function(player, caster)
		local weaponDamage = math.random(player.minDam, player.maxDam)
		local will = caster.will
		local willBonusPct = (will / (will + 50) ^ 1.1)
		local add = 1
		local fury = 1
		local whileCastManaCost = 2500

		if caster.magic >= whileCastManaCost then
			caster.magic = caster.magic - whileCastManaCost
			caster:sendStatus()
		else
			caster.magic = 0
			player:setDuration("slowtest", 0, caster.ID)
			caster:sendStatus()
		end

		local damage = (((weaponDamage + (weaponDamage * willBonusPct)) * fury) * add)

		local mob_around = player:getObjectsInArea(BL_MOB)
		local pc_around = player:getObjectsInArea(BL_PC)

		pcflankTargets = {
			player:getObjectsInCell(player.m, player.x, player.y - 2, BL_PC)[1],
			player:getObjectsInCell(player.m, player.x, player.y + 2, BL_PC)[1],
			player:getObjectsInCell(player.m, player.x - 2, player.y, BL_PC)[1],
			player:getObjectsInCell(player.m, player.x + 2, player.y, BL_PC)[1]
		}

		mobflankTargets = {
			player:getObjectsInCell(player.m, player.x, player.y - 2, BL_MOB)[1],
			player:getObjectsInCell(player.m, player.x, player.y + 2, BL_MOB)[1],
			player:getObjectsInCell(player.m, player.x - 2, player.y, BL_MOB)[1],
			player:getObjectsInCell(player.m, player.x + 2, player.y, BL_MOB)[1]
		}

		for i = 1, 4 do
			if (pcflankTargets[i] ~= nil) then
				if pcflankTargets[i].state ~= 1 and player:canPK(pcflankTargets[i]) then
					slowtest.takeDamage(player, pcflankTargets[i], damage)
				end
			end
		end

		for i = 1, 4 do
			if (mobflankTargets[i] ~= nil) then
				slowtest.takeDamage(player, mobflankTargets[i], damage)
			end
		end

		if #mob_around > 0 then
			for i = 1, #mob_around do
				if distanceSquare(player, mob_around[i], 1) then
					slowtest.takeDamage(player, mob_around[i], damage)
				end
			end
		end

		if #pc_around > 0 then
			for i = 1, #pc_around do
				if distanceSquare(player, pc_around[i], 1) then
					if pc_around[i].ID ~= player.ID then
						if pc_around[i].state ~= 1 and player:canPK(pc_around[i]) then
							slowtest.takeDamage(player, pc_around[i], damage)
						end
					end
				end
			end
		end
	end,
	takeDamage = function(player, target, damage)
		local threat

		target.attacker = player.ID
		if target.blType == BL_MOB then
			threat = target:removeHealthExtend(damage, 1, 1, 1, 1, 2)
			player:addThreat(target.ID, threat)
		end
		target:sendAnimation(421, 1)
		target:setDuration("slow", 8000)
		target:removeHealthExtend(damage, 1, 1, 1, 1, 0)
	end
}
