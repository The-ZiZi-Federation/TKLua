--[[
-- level 1 AoE

fireball_old = {

    on_learn = function(player) player.registry["learned_fireball"] = 1 end,
    on_forget = function(player) player.registry["learned_fireball"] = 0 end,

cast = function(player, target)
	
	
	local damage = ((player.maxMagic)+(player.will*50))*5
	local threat
	local magicCost = 1000
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
		player:sendAction(6, 20)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:setAether("fireball", 1000)
		player:playSound(58)
		target:sendAnimation(222)
		player:sendMinitext("You cast Fireball")
		target.attacker = player.ID
		threat = target:removeHealthExtend(damage, 1, 1, 1, 1, 2)
		player:addThreat(target.ID, threat)
		target:removeHealthExtend(damage, 1, 1, 1, 1, 0)
	elseif (target.blType == BL_PC) then
		player:sendAction(6, 20)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:setAether("fireball", 1000)
		player:playSound(58)
		target:sendAnimation(222)
		player:sendMinitext("You cast Fireball")
		target.attacker = player.ID
		if player:canPK(target) then
			target:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			target:sendMinitext(player.name.." burns you with Fireball")
		end
	end
	
	if (#targets > 0) then
		for i = 1, #targets do
			if (targets[i] ~= nil and targets[i].blType == BL_MOB) then
				targets[i].attacker = player.ID
				threat = targets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 2)
				player:addThreat(targets[i].ID, threat)
				targets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
				target:sendAnimation(222)
			elseif (targets[i] ~= nil and targets[i].blType == BL_PC and player:canPK(targets[i])) then
				targets[i].attacker = player.ID
				targets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
				target:sendAnimation(222)
			end
		end
	end
end
}]]
--
