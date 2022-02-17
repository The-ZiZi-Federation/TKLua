--[[
circle_of_retribution = {


on_learned = function(player) 
	
	player.registry["learned_circle_of_retribution"]=1
end,


on_forget = function(player)
	
	player.registry["learned_circle_of_retribution"]=0 
end,

cast = function(player)
	local fury = player.fury
	local mobBlocks = player:getObjectsInArea(BL_MOB)
	local pcBlocks = player:getObjectsInArea(BL_PC)
	local aether = 12000
	local targets = {}
	local damage = ((player.maxHealth*.65)+(player.will*50))*fury
	local threat
	local magicCost = 250
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end
	
	
	
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
	
	if #targets > 0 then
		player.magic = player.magic - magicCost
		player:sendMinitext("You cast Circle of Retribution.")
		player:sendStatus()
		player:sendAnimation(346)
		player:sendAction(1, 20)
		player:setAether("circle_of_retribution", aether)
		player:playSound(84)
	end

	for i = 1, #targets do
		if (targets[i] ~= nil and targets[i].blType == BL_MOB) then
			targets[i].attacker = player.ID			
			threat = targets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 2)
			player:addThreat(targets[i].ID, threat)
			targets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			targets[i]:sendAnimation(327)
		elseif (targets[i] ~= nil and targets[i].blType == BL_PC and player:canPK(targets[i])) then
			targets[i].attacker = player.ID
			targets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			targets[i]:sendMinitext(player.name.." attacks you with Circle of Retribution")
			targets[i]:sendAnimation(327)
		end
	end
end
}]]
--
