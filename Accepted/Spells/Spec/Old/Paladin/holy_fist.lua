--[[
holy_fist = {

on_learned = function(player) 
	
	player.registry["learned_holy_fist"]=1
end,


on_forget = function(player)
	
	player.registry["learned_holy_fist"]=0 
end,


cast = function(player)
	
	local fury = player.fury
	local mobTarget = getTargetFacing(player, BL_MOB)
	local pcTarget = getTargetFacing(player, BL_PC)
	local damage = ((player.maxHealth*.75)+(player.might*75))*fury
	local magicCost = 1000
	local aeth = 10000
	local m = player.m
	local x = player.x
	local y = player.y
	local threat
	
	if player.magic < magicCost or player.magic-magicCost <= 0 then
		player:sendAnimation(246)
		player:sendMinitext("Not Enough MP.")
		return
	end	
	
	
	
	if mobTarget ~= nil then
		mobTarget.attacker = player.ID
		player:sendAction(2, 20)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:sendMinitext("You cast Holy Fist")
		player:playSound(14)
		player:setAether("holy_fist", aeth)
		threat = mobTarget:removeHealthExtend(damage, 1, 1, 1, 1, 2)
		player:addThreat(mobTarget.ID, threat)
		mobTarget:sendAnimation(192)
		mobTarget:removeHealthExtend(damage, 1, 1, 1, 1, 0)
		mobTarget:setDuration("stun", 6000)
	elseif pcTarget ~= nil then
		pcTarget:sendAnimation(192)
		
		if (player:canPK(pcTarget)) then
			pcTarget.attacker = player.ID
			player:sendAction(2, 20)
			player.magic = player.magic - magicCost
			player:sendStatus()
			player:sendMinitext("You cast Holy Fist")
			player:playSound(14)
			player:setAether("holy_fist", aeth)
			pcTarget:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			pcTarget:setDuration("stun", 6000)
		end
	end
end
}]]
--
