--[[
holy_wrath = {
on_learned = function(player) 
	
	player.registry["holy_wrath"]=1
end,


on_forget = function(player) 
	
	player.registry["holy_wrath"]=0 
end,


cast = function(player)
	
	local fury = player.fury
	local mobTarget = getTargetFacing(player, BL_MOB)
	local pcTarget = getTargetFacing(player, BL_PC)
	local damage = ((player.health*1.15)+(player.will*65))*fury
	local magicCost = 1500
	local m = player.m
	local x = player.x
	local y = player.y
	local threat
	
	if (not player:canCast(1, 1, 0)) then
		return
	end

	if player.magic < magicCost or player.magic-magicCost <= 0 then
		player:sendAnimation(246)
		player:sendMinitext("Not Enough MP.")
		return
	end	
		player:sendAction(1, 20)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:sendMinitext("You cast Holy Wrath")
		player:playSound(14)
		player:setAether("holy_wrath", 16000)
		

	
	if mobTarget ~= nil then
		mobTarget.attacker = player.ID
		threat = mobTarget:removeHealthExtend(damage, 1, 1, 1, 1, 2)
		player:addThreat(mobTarget.ID, threat)
		mobTarget:sendAnimation(412, 0)
		mobTarget:removeHealthExtend(damage, 1, 1, 1, 1, 0)
	elseif pcTarget ~= nil then
		pcTarget:sendAnimation(412, 0)
		
		if (player:canPK(pcTarget)) then
			pcTarget.attacker = player.ID
			pcTarget:removeHealthExtend(damage, 1, 1, 1, 1, 0)
		end
	end
end
}]]
--
