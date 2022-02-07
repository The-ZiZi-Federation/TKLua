--[[
--Level 3 Tick AoE
flurry4 = {

    on_learn = function(player) player.registry["learned_flurry4"] = 1 end,
    on_forget = function(player) player.registry["learned_flurry4"] = 0 end,

cast = function(player, target)
	
	local damage = ((player.maxMagic*1.25) + (player.will*125))*15
	local threat
	local magicCost = 3500
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
	
	
	for i = 1, #mobBlocks do
		if (distanceSquare(target, mobBlocks[i], 1) and mobBlocks[i].ID ~= target.ID and mobBlocks.state ~= 1) then
			table.insert(targets, mobBlocks[i])
		end
	end

	for i = 1, #pcBlocks do
		if (distanceSquare(target, pcBlocks[i], 1) and pcBlocks[i].ID ~= target.ID and pcBlocks[i].state ~= 1 and player:canPK(pcBlocks[i])) then
			table.insert(targets, pcBlocks[i])
		end
	end
	
	
	if (target.blType == BL_MOB) then
		player:sendMinitext("Invalid Target.")
	elseif (target.blType == BL_PC) then
		player:sendAction(6, 20)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:setAether("flurry4", 15000)
		player:playSound(58)
		target:sendAnimation(421)
		player:sendMinitext("You cast Flurry Lv4.")
		target.attacker = player.ID
		target:sendMinitext(player.name.." sends a Flurry to surround you.")
		target:setDuration("flurry4", 10000, player.ID)
	end
	
	
	
end,

-- so we 

while_cast = function(player, caster)   -- this spell is the target fighter, and it hurt everything around fighter. wait, i'll create one spell. and you can see if it was right or wrong. ok 
	
	pcflankTargets = {player:getObjectsInCell(player.m, player.x, player.y - 4, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x, player.y - 5, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y - 4, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y - 4, BL_PC)[1],
	
				player:getObjectsInCell(player.m, player.x, player.y + 4, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x, player.y + 5, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y + 4, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y + 4, BL_PC)[1],

				player:getObjectsInCell(player.m, player.x - 4, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 5, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 4, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 4, player.y - 1, BL_PC)[1],

				player:getObjectsInCell(player.m, player.x + 4, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 5, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 4, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 4, player.y - 1, BL_PC)[1]}

	mobflankTargets = {player:getObjectsInCell(player.m, player.x, player.y - 4, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x, player.y - 5, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y - 4, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y - 4, BL_MOB)[1],
	
				player:getObjectsInCell(player.m, player.x, player.y + 4, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x, player.y + 5, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y + 4, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y + 4, BL_MOB)[1],

				player:getObjectsInCell(player.m, player.x - 4, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 5, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 4, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 4, player.y - 1, BL_MOB)[1],

				player:getObjectsInCell(player.m, player.x + 4, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 5, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 4, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 4, player.y - 1, BL_MOB)[1]}


	local damage = ((caster.maxMagic*.55) + (caster.will*35))*12
	local mob_around = player:getObjectsInArea(BL_MOB)
	local pc_around = player:getObjectsInArea(BL_PC)
	

	for i = 1, 16 do
		if (pcflankTargets[i] ~= nil) then
			if pcflankTargets[i].state ~= 1 and player:canPK(pcflankTargets[i]) then
				flurry4.takeDamage(player, pcflankTargets[i], damage)
			end
		end
	end


	for i = 1, 16 do
		if (mobflankTargets[i] ~= nil) then
			flurry4.takeDamage(player, mobflankTargets[i], damage)
		end
	end



	if #mob_around > 0 then
		for i = 1, #mob_around do
			if distanceSquare(player, mob_around[i], 3) then
				flurry4.takeDamage(player, mob_around[i], damage)
			end
		end 
	end
	
	if #pc_around > 0 then
		for i = 1, #pc_around do
			if distanceSquare(player, pc_around[i], 3) then
				if pc_around[i].ID ~= player.ID then
					if pc_around[i].state ~= 1 and player:canPK(pc_around[i]) then
						flurry4.takeDamage(player, pc_around[i], damage)
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
		threat = target:removeHealthExtend(damage, 1,1,1,1,2)
		player:addThreat(target.ID, threat)
	end
	target:removeHealthExtend(damage, 1,1,1,1,0)
	target:sendAnimation(421)
end,



requirements = function(player)
	local level = 75
	local items = {}
	local itemAmounts = {}
	local description = {"Upgrade Flurry to Lv3."}
	return level, items, itemAmounts, description
end
}]]
--
