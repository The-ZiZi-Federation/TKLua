--[[
-- level 4 AoE

hailstorm5 = {

    on_learn = function(player) player.registry["learned_hailstorm5"] = 1 end,
    on_forget = function(player) player.registry["learned_hailstorm5"] = 0 end,

cast = function(player, target)
	pcflankTargets = {target:getObjectsInCell(target.m, target.x, target.y - 3, BL_PC)[1],
				target:getObjectsInCell(target.m, target.x + 1, target.y - 3, BL_PC)[1],
				target:getObjectsInCell(target.m, target.x - 1, target.y - 3, BL_PC)[1],

				target:getObjectsInCell(target.m, target.x, target.y + 3, BL_PC)[1],
				target:getObjectsInCell(target.m, target.x + 1, target.y + 3, BL_PC)[1],
				target:getObjectsInCell(target.m, target.x - 1, target.y + 3, BL_PC)[1],

				target:getObjectsInCell(target.m, target.x - 3, target.y, BL_PC)[1],
				target:getObjectsInCell(target.m, target.x - 3, target.y + 1, BL_PC)[1],
				target:getObjectsInCell(target.m, target.x - 3, target.y - 1, BL_PC)[1],
				
				target:getObjectsInCell(target.m, target.x + 3, target.y, BL_PC)[1],
				target:getObjectsInCell(target.m, target.x + 3, target.y + 1, BL_PC)[1],
				target:getObjectsInCell(target.m, target.x + 3, target.y - 1, BL_PC)[1],
				
				target:getObjectsInCell(target.m, target.x, target.y - 4, BL_PC)[1],
				target:getObjectsInCell(target.m, target.x + 1, target.y - 4, BL_PC)[1],
				target:getObjectsInCell(target.m, target.x - 1, target.y - 4, BL_PC)[1],

				target:getObjectsInCell(target.m, target.x, target.y + 4, BL_PC)[1],
				target:getObjectsInCell(target.m, target.x + 1, target.y + 4, BL_PC)[1],
				target:getObjectsInCell(target.m, target.x - 1, target.y + 4, BL_PC)[1],

				target:getObjectsInCell(target.m, target.x - 4, target.y, BL_PC)[1],
				target:getObjectsInCell(target.m, target.x - 4, target.y + 1, BL_PC)[1],
				target:getObjectsInCell(target.m, target.x - 4, target.y - 1, BL_PC)[1],
				
				target:getObjectsInCell(target.m, target.x + 4, target.y, BL_PC)[1],
				target:getObjectsInCell(target.m, target.x + 4, target.y + 1, BL_PC)[1],
				target:getObjectsInCell(target.m, target.x + 4, target.y - 1, BL_PC)[1],


				target:getObjectsInCell(target.m, target.x - 3, target.y - 2, BL_PC)[1],
				target:getObjectsInCell(target.m, target.x - 2, target.y - 3, BL_PC)[1],

				target:getObjectsInCell(target.m, target.x + 2, target.y - 3, BL_PC)[1],
				target:getObjectsInCell(target.m, target.x + 3, target.y - 2, BL_PC)[1],

				target:getObjectsInCell(target.m, target.x + 3, target.y + 2, BL_PC)[1],
				target:getObjectsInCell(target.m, target.x + 2, target.y + 3, BL_PC)[1],

				target:getObjectsInCell(target.m, target.x - 3, target.y + 2, BL_PC)[1],
				target:getObjectsInCell(target.m, target.x - 2, target.y + 3, BL_PC)[1]}

	mobflankTargets = {target:getObjectsInCell(target.m, target.x, target.y - 3, BL_MOB)[1],
				target:getObjectsInCell(target.m, target.x + 1, target.y - 3, BL_MOB)[1],
				target:getObjectsInCell(target.m, target.x - 1, target.y - 3, BL_MOB)[1],

				target:getObjectsInCell(target.m, target.x, target.y + 3, BL_MOB)[1],
				target:getObjectsInCell(target.m, target.x + 1, target.y + 3, BL_MOB)[1],
				target:getObjectsInCell(target.m, target.x - 1, target.y + 3, BL_MOB)[1],

				target:getObjectsInCell(target.m, target.x - 3, target.y, BL_MOB)[1],
				target:getObjectsInCell(target.m, target.x - 3, target.y + 1, BL_MOB)[1],
				target:getObjectsInCell(target.m, target.x - 3, target.y - 1, BL_MOB)[1],
				
				target:getObjectsInCell(target.m, target.x + 3, target.y, BL_MOB)[1],
				target:getObjectsInCell(target.m, target.x + 3, target.y + 1, BL_MOB)[1],
				target:getObjectsInCell(target.m, target.x + 3, target.y - 1, BL_MOB)[1],
				

				target:getObjectsInCell(target.m, target.x, target.y - 4, BL_MOB)[1],
				target:getObjectsInCell(target.m, target.x + 1, target.y - 4, BL_MOB)[1],
				target:getObjectsInCell(target.m, target.x - 1, target.y - 4, BL_MOB)[1],

				target:getObjectsInCell(target.m, target.x, target.y + 4, BL_MOB)[1],
				target:getObjectsInCell(target.m, target.x + 1, target.y + 4, BL_MOB)[1],
				target:getObjectsInCell(target.m, target.x - 1, target.y + 4, BL_MOB)[1],

				target:getObjectsInCell(target.m, target.x - 4, target.y, BL_MOB)[1],
				target:getObjectsInCell(target.m, target.x - 4, target.y + 1, BL_MOB)[1],
				target:getObjectsInCell(target.m, target.x - 4, target.y - 1, BL_MOB)[1],
				
				target:getObjectsInCell(target.m, target.x + 4, target.y, BL_MOB)[1],
				target:getObjectsInCell(target.m, target.x + 4, target.y + 1, BL_MOB)[1],
				target:getObjectsInCell(target.m, target.x + 4, target.y - 1, BL_MOB)[1],


				target:getObjectsInCell(target.m, target.x - 3, target.y - 2, BL_MOB)[1],
				target:getObjectsInCell(target.m, target.x - 2, target.y - 3, BL_MOB)[1],

				target:getObjectsInCell(target.m, target.x + 2, target.y - 3, BL_MOB)[1],
				target:getObjectsInCell(target.m, target.x + 3, target.y - 2, BL_MOB)[1],

				target:getObjectsInCell(target.m, target.x + 3, target.y + 2, BL_MOB)[1],
				target:getObjectsInCell(target.m, target.x + 2, target.y + 3, BL_MOB)[1],

				target:getObjectsInCell(target.m, target.x - 3, target.y + 2, BL_MOB)[1],
				target:getObjectsInCell(target.m, target.x - 2, target.y + 3, BL_MOB)[1]}

	
	local damage = ((player.maxMagic*2)+(player.will*200))*15
	local threat
	local magicCost = 3250
	local mobBlocks = target:getObjectsInArea(BL_MOB)
	local pcBlocks = target:getObjectsInArea(BL_PC)
	local targets = {}
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end
	
	if (target.state == 1) then
		player:sendMinitext("That is no longer useful.")
		return
	end

	for i = 1, 32 do
		if (pcflankTargets[i] ~= nil) then
			if pcflankTargets[i].state ~= 1 and player:canPK(pcflankTargets[i]) then
				table.insert(targets, pcflankTargets[i])
			end
		end
	end


	for i = 1, 32 do
		if (mobflankTargets[i] ~= nil) then
			table.insert(targets, mobflankTargets[i])
		end
	end

	
	for i = 1, #mobBlocks do
		if (distanceSquare(target, mobBlocks[i], 2) and mobBlocks[i].ID ~= target.ID and mobBlocks.state ~= 1) then
			table.insert(targets, mobBlocks[i])
		end
	end

	for i = 1, #pcBlocks do
		if (distanceSquare(target, pcBlocks[i], 2) and pcBlocks[i].ID ~= target.ID and pcBlocks[i].state ~= 1 and player:canPK(pcBlocks[i])) then
			table.insert(targets, pcBlocks[i])
		end
	end
	
	
	if (target.blType == BL_MOB) then
		player:sendAction(6, 20)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:setAether("hailstorm5", 35000)
		player:playSound(58)
		target:sendAnimation(392, 1)
		player:sendMinitext("You cast Hailstorm Lv5.")
		target.attacker = player.ID
		threat = target:removeHealthExtend(damage, 1, 1, 1, 1, 2)
		player:addThreat(target.ID, threat)
		target:removeHealthExtend(damage, 1, 1, 1, 1, 0)
	elseif (target.blType == BL_PC) then
		player:sendAction(6, 20)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:setAether("hailstorm5", 35000)
		player:playSound(58)
		target:sendAnimation(392, 1)
		player:sendMinitext("You cast Hailstorm Lv5.")
		target.attacker = player.ID
		if player:canPK(target) then
			target:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			target:sendMinitext(player.name.." pelts you with hail.")
		end
	end
	
	if (#targets > 0) then
		for i = 1, #targets do
			if (targets[i] ~= nil and targets[i].blType == BL_MOB) then
				targets[i].attacker = player.ID
				threat = targets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 2)
				player:addThreat(targets[i].ID, threat)
				target:sendAnimation(392, 1)
				targets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			elseif (targets[i] ~= nil and targets[i].blType == BL_PC and player:canPK(targets[i])) then
				targets[i].attacker = player.ID
				target:sendAnimation(392, 1)
				targets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			end
		end
	end
end
}
]]
--
