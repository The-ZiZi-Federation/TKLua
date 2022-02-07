--[[
slit_throat = {
on_learned = function(player) player.registry["learned_slit_throat"]=1 end,
on_forget = function(player) player.registry["learned_slit_throat"]=0 end,

cast = function(player)
	local fury = player.fury
	local mobTarget = getTargetFacing(player, BL_MOB)
	local pcTarget = getTargetFacing(player, BL_PC)
	local damage = ((player.maxHealth*1.25)+(player.grace*100))*fury
	local damage2 = (((player.maxHealth*1.25)+(player.grace*100))*fury)*3
	local magicCost = 4500
	local m = player.m
	local x = player.x
	local y = player.y
	local threat
	local aether = 21000
	
	if not player:canCast(1,1,0) then player:sendAnimation(246) return end
	if player.magic < magicCost or player.magic-magicCost <= 0 then
		player:sendAnimation(246)
		player:sendMinitext("Not Enough MP.")
		return
	end	
		
		

	if mobTarget ~= nil then
        if mobTarget:hasDuration("stun") then
            mobTarget.attacker = player.ID
			player:sendAction(1, 20)
			player:talk(2, "*cuts throat*")
			player.magic = player.magic - magicCost
			player:setAether("slit_throat", aether)
			player:sendStatus()
			player:sendMinitext("You use Slit Throat")
			player:playSound(14)
            threat = mobTarget:removeHealthExtend(damage2, 1, 1, 1, 1, 2)
            player:addThreat(mobTarget.ID, threat)
            mobTarget:sendAnimation(128, 0)
            mobTarget:removeHealthExtend(damage2, 1, 1, 1, 1, 0)
        else
            mobTarget.attacker = player.ID
			player:sendAction(1, 20)
			player:talk(2, "*cuts throat*")
			player.magic = player.magic - magicCost
			player:setAether("slit_throat", aether)
			player:sendStatus()
			player:sendMinitext("You use Slit Throat")
			player:playSound(14)
            threat = mobTarget:removeHealthExtend(damage, 1, 1, 1, 1, 2)
            player:addThreat(mobTarget.ID, threat)
            mobTarget:sendAnimation(128, 0)
            mobTarget:removeHealthExtend(damage, 1, 1, 1, 1, 0)
        end
        
        
    elseif pcTarget ~= nil then
		player:sendAction(1, 20)
		player:talk(2, "*Now you die!*")
		pcTarget:sendAnimation(128, 0)
		player:setAether("slit_throat", aether)
		if (player:canPK(pcTarget)) then
          if pcTarget:hasDuration("stun") then
			pcTarget.attacker = player.ID
			player.magic = player.magic - magicCost
			player:sendStatus()
			player:sendMinitext("You use Slit Throat")
			player:playSound(14)
			pcTarget:removeHealthExtend(damage2, 1, 1, 1, 1, 0)
		else
		   	pcTarget.attacker = player.ID
			player.magic = player.magic - magicCost
			player:sendStatus()
			player:sendMinitext("You use Slit Throat")
			player:playSound(14)
			pcTarget:removeHealthExtend(damage, 1, 1, 1, 1, 0)
		end
	end
end
end
}]]
--
