--[[
righteous_blessing = {

on_learn = function(player) player.registry["learned_righteous_blessing"] = 1 end,
on_forget = function(player) player.registry["learned_righteous_blessing"] = 0 end,

cast = function(player)
	local aether = 180000
	local duration = 240000
	local magicCost = 500
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end
	
	for i = 1, #player.group do
		if (Player(player.group[i]).state ~= 1 and Player(player.group[i]).m == player.m) then
			
			if Player(player.group[i]):hasDuration("holy_blessing") then
				Player(player.group[i]):setDuration("holy_blessing", 0)
			end

			if Player(player.group[i]):hasDuration("minor_blessing") then
				Player(player.group[i]):setDuration("minor_blessing", 0)
			end

			if Player(player.group[i]):hasDuration("blessed_aim") then
				Player(player.group[i]):setDuration("blessed_aim", 0)
			end
			if Player(player.group[i]):hasDuration("asaks_blessing") then
				Player(player.group[i]):setDuration("asaks_blessing", 0)
			end
			if Player(player.group[i]):hasDuration("rightous_blessing") then
				Player(player.group[i]):setDuration("righteous_blessing", 0)
			end
			if Player(player.group[i]):hasDuration("unholy_blessing") then
				Player(player.group[i]):setDuration("unholy_blessing", 0)
			end

			player.magic = player.magic - magicCost	
			Player(player.group[i]):sendAnimation(168)
			Player(player.group[i]).basemight = Player(player.group[i]).basemight + 40
			Player(player.group[i]).basewill = Player(player.group[i]).basewill + 40
			Player(player.group[i]).basegrace = Player(player.group[i]).basegrace + 40
			Player(player.group[i]):sendStatus()
			Player(player.group[i]):calcStat()
			Player(player.group[i]):setDuration("righteous_blessing", duration, 0, 1)
			if player.class == 39 then player.fury = 27 end
			Player(player.group[i]):sendMinitext(player.name.." grants the courage of the lion, the strength of the bear")
		end
	end
end,
		

on_swing_while_cast = function(player)

	
	if player.side == 0 then
		pcflankTargets = {player:getObjectsInCell(player.m, player.x + 1, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_PC)[1]}

		mobflankTargets = {player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_MOB)[1]}


	
	elseif player.side == 1 then
		pcflankTargets = {player:getObjectsInCell(player.m, player.x, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_PC)[1]}

		mobflankTargets = {player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_MOB)[1]}
	
	elseif player.side == 2 then
		pcflankTargets = {player:getObjectsInCell(player.m, player.x + 1, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_PC)[1]}

		mobflankTargets = {player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_MOB)[1]}


	elseif player.side == 3 then
		pcflankTargets = {player:getObjectsInCell(player.m, player.x + 1, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_PC)[1]}

		mobflankTargets = {player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_MOB)[1]}
	end

	if player.class == 39 then
		for i = 1, 7 do
			if (mobflankTargets[i] ~= nil) then
				player:swingTarget(mobflankTargets[i])
			elseif (pcflankTargets[i] ~= nil) then
				if (player:canPK(pcflankTargets[i])) then
					pcflankTargets[i].attacker = player.ID
					player:swingTarget(pcflankTargets[i])
				end
			end
		end
	end
end,

uncast = function(player)
	player.basemight = player.basemight - 40
	player.basewill = player.basewill - 40
	player.basegrace = player.basegrace - 40
	if player.class == 39 then player.fury = 1 end
	player:calcStat()
	player:updateStatus()
	player:sendStatus()
end
}]]
--
