--[[
pin_target = {

    on_learn = function(player) player.registry["learned_pin_target"] = 1 end,
    on_forget = function(player) player.registry["learned_pin_target"] = 0 end,

cast = function(player, target)
	
	local aether = 500
	local threat
	local magicCost = 5
	
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
	
	if (target.blType == BL_MOB) then
		player:sendAction(6, 20)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:setAether("pin_target", 500)
		player:playSound(58)
		target:sendAnimation(14)
		player:sendMinitext("You cast Pin Target.")
		target:setDuration("pin_target", 60000)
		target.attacker = player.ID
		
	elseif (target.blType == BL_PC and player:canPK(target)) then
		player:sendAction(6, 20)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:setAether("pin_target", 500)
		player:playSound(58)
		target:sendAnimation(14)
		player:sendMinitext("You cast Pin Target.")
		target:setDuration("pin_target", 60000)
		target.attacker = player.ID
		target:sendMinitext(player.name.." pins you!")
	end
end,


on_takedamage_while_cast = function(player)

	if player:hasDuration("pin_target") then
		player:setDuration("pin_target", 0)

	end
end
}
]]
--
