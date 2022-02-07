--[[
flashbang6 = {

    on_learn = function(player) player.registry["learned_flashbang6"] = 1 end,
    on_forget = function(player) player.registry["learned_flashbang6"] = 0 end,

cast = function(player)
	local mobBlocks = player:getObjectsInArea(BL_MOB)
	local pcBlocks = player:getObjectsInArea(BL_PC)
	local aether = 10000
	local targets = {}
	local damage = ((player.maxMagic*1.5) + (player.will*75))*15
	local threat
	local magicCost = 1000
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end
	
	player:sendAction(1, 20)
	player:setAether("flashbang6", aether)
	player:playSound(84)
	player:sendMinitext("You cast Flashbang Lv6.")
	
	for i = 1, #mobBlocks do
		if (distanceSquare(player, mobBlocks[i], 1) and mobBlocks[i].ID ~= player.ID) then
			table.insert(targets, mobBlocks[i])
		end
	end
	
	for i = 1, #pcBlocks do
		if (distanceSquare(player, pcBlocks[i], 1) and pcBlocks[i].ID ~= player.ID) then
			table.insert(targets, pcBlocks[i])
		end
	end
	
	if (#targets > 0) then
		player.magic = player.magic - magicCost
		player:sendStatus()
		
		
		for i = 1, #targets do
			if (targets[i] ~= nil and targets[i].blType == BL_MOB) then
				targets[i].attacker = player.ID
				threat = targets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 2)
				player:addThreat(targets[i].ID, threat)
				targets[i].registry["mana_surge"] = player.ID
				targets[i]:sendAnimation(105)
				targets[i]:setDuration("mana_surge", 4000)
				targets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			elseif (targets[i] ~= nil and targets[i].blType == BL_PC and player:canPK(targets[i])) then
				targets[i].attacker = player.ID
				targets[i].registry["mana_surge"] = player.ID
				targets[i]:sendMinitext(player.name.." charred you with a Flashbang..")
				targets[i]:sendAnimation(105)
				targets[i]:setDuration("mana_surge", 4000)
				targets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			end
		end
	end
end
}]]
--
