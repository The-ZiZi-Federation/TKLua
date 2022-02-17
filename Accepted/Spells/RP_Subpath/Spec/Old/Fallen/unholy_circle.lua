--[[
unholy_circle = {


on_learned = function(player) 
	
	player.registry["learned_unholy_circle"]=1
end,


on_forget = function(player)
	
	player.registry["learned_unholy_circle"]=0 
end,

cast = function(player)
	local fury = player.fury
	local mobBlocks = player:getObjectsInArea(BL_MOB)
	local pcBlocks = player:getObjectsInArea(BL_PC)
	local aether = 16000
	local targets = {}
	local damage = ((player.maxHealth*.75)+(player.will*50))*fury
	local threat
	local magicCost = 1200
	
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
		player:sendMinitext("You cast Unholy Circle.")
		player:sendStatus()
		player:sendAction(1, 20)
		player:setAether("unholy_circle", aether)
		player:playSound(84)
		player:sendAnimationXY(416, player.x, player.y)
	end

	for i = 1, #targets do
		if (targets[i] ~= nil and targets[i].blType == BL_MOB) then
			targets[i].attacker = player.ID			
			threat = targets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 2)
			player:addThreat(targets[i].ID, threat)
			targets[i]:sendAnimation(417)
			targets[i]:setDuration("stun", 5000)
			targets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
		elseif (targets[i] ~= nil and targets[i].blType == BL_PC and player:canPK(targets[i])) then
			targets[i].attacker = player.ID
			targets[i]:sendAnimation(417)
			targets[i]:setDuration("stun", 5000)
			targets[i]:sendMinitext(player.name.." attacks you with dark energy")
			targets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
		end
	end
end
}]]
--
