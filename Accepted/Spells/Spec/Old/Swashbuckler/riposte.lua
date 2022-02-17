--[[
riposte = {

on_learn = function(player) player.registry["learned_riposte"] = 1 end,
on_forget = function(player) player.registry["learned_riposte"] = 0 end,

cast = function(player)
	
    local magicCost = 1000
    if not player:canCast(1,1,0) then return end
    if player.magic < magicCost then notEnoughMP(player) return end

    if player:hasDuration("riposte") then
        anim(player)
        player:sendMinitext("Spell already cast!")
        return
    else
        player:sendAction(6, 20)
        player.magic = player.magic - magicCost
	player:sendStatus()     
	player:setDuration("riposte", 4000)       
	player:sendAnimation(367)       
	player:playSound(0)
	player:sendMinitext("You cast riposte")
	end
end,


while_cast = function(player)

player:sendAnimation(367) 


 
end,


uncast = function(player)

	local reg = player.registry["riposte"]
	local damage = reg*10
	local mobTarget = getTargetFacing(player, BL_MOB)
	local pcTarget = getTargetFacing(player, BL_PC)


	if mobTarget ~= nil then
		mobTarget.attacker = player.ID
		mobTarget:sendAnimation(105)
		mobTarget:removeHealthExtend(damage, 1, 1, 1, 1, 0)
		player:sendAction(1, 20)
		player:sendMinitext("You find an opening and strike!")
		player.registry["riposte"] = 0
	elseif pcTarget ~= nil then
		pcTarget:sendAnimation(105)
		if (player:canPK(pcTarget)) then
			pcTarget.attacker = player.ID
			pcTarget:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			player:sendAction(1, 20)
			player:sendMinitext("You find an opening and strike!")
			player.registry["riposte"] = 0
		end
	end
	player:calcStat()
	
	end
}
]]
--
