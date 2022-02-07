--[[
chain_ectoplasmic_blast = {

on_learn = function(player) player.registry["learned_chain_ectoplasmic_blast"] = 1 end,
on_forget = function(player) player.registry["learned_chain_ectoplasmic_blast"] = 0 end,

cast = function(player, target)
	
	local damage = ((player.maxMagic*3) + (player.will*300))*20
	local magicCost = player.maxMagic*0.35

	local mobBlocks = {target:getObjectsInCell(target.m, target.x + 1, target.y, BL_MOB)[1], 
			target:getObjectsInCell(target.m, target.x - 1, target.y, BL_MOB)[1],
			target:getObjectsInCell(target.m, target.x, target.y + 1, BL_MOB)[1],
			target:getObjectsInCell(target.m, target.x, target.y - 1, BL_MOB)[1]}

	local pcBlocks = {target:getObjectsInCell(target.m, target.x + 1, target.y, BL_PC)[1], 
			target:getObjectsInCell(target.m, target.x - 1, target.y, BL_PC)[1],
			target:getObjectsInCell(target.m, target.x, target.y + 1, BL_PC)[1],
			target:getObjectsInCell(target.m, target.x, target.y - 1, BL_PC)[1]}

	local targets = {}
	

	if not player:canCast(1,1,0) then return else
		if target.blType == BL_PC then
			if not player:canPK(target) or target.state == 1 then return else target:sendMinitext(player.name.." casts Chain Ectoplasmic Blast on you") end
		end
	end

	if player.magic < magicCost then notEnoughMP(player) return end


	for i = 1, 4 do
		if (mobBlocks[i] ~= nil) then
			table.insert(targets, mobBlocks[i])
		end
	end



	for i = 1, 4 do
		if (pcBlocks[i] ~= nil) then
			if pcBlocks[i].state ~= 1 and player:canPK(pcBlocks[i]) then
				table.insert(targets, pcBlocks[i])
			end
		end
	end



	
	if (target.blType == BL_MOB) then
		player:sendAction(6, 20)
		target:sendAnimation(198)
		player:playSound(73)
		player.magic = player.magic - magicCost
		player:sendMinitext("You cast Chain Ectoplasmic Blast")
		player:setAether("chain_ectoplasmic_blast", 37000)
		player:sendStatus()
		target:removeHealth(damage)
	elseif (target.blType == BL_PC) then
		player:sendAction(6, 20)
		target:sendAnimation(198)
		player:playSound(73)
		player.magic = player.magic - magicCost
		player:sendMinitext("You cast Chain Ectoplasmic Blast")
		player:setAether("chain_ectoplasmic_blast", 37000)
		player:sendStatus()
		if player:canPK(target) then
			target:removeHealth(damage)
		end
	end

	if (#targets > 0) then
		for i = 1, #targets do
			if (targets[i] ~= nil and targets[i].blType == BL_MOB) then
				targets[i].attacker = player.ID
				threat = targets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 2)
				player:addThreat(targets[i].ID, threat)
				targets[i]:sendAnimation(198)
				targets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			elseif (targets[i] ~= nil and targets[i].blType == BL_PC and player:canPK(targets[i])) then
				targets[i].attacker = player.ID
				targets[i]:sendAnimation(198)
				targets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			end
		end
	end
end
}]]
--
