--[[
snowstorm6 = {

    on_learn = function(player) player.registry["learned_snowstorm6"] = 1 end,
    on_forget = function(player) player.registry["learned_snowstorm6"] = 0 end,

cast = function(player, target)
	
	local aether = 500
	local damage = ((player.maxMagic*.85) + (player.will*75))*15
	local threat
	local magicCost = 100
	
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
		player:setAether("snowstorm6", 500)
		player:playSound(58)
		target:sendAnimation(392, 1)
		player:sendMinitext("You cast Snowstorm Lv6.")
		target.attacker = player.ID
		threat = target:removeHealthExtend(damage, 1, 1, 1, 1, 2)
		player:addThreat(target.ID, threat)
		target:removeHealthExtend(damage, 1, 1, 1, 1, 0)
	elseif (target.blType == BL_PC and player:canPK(target)) then
		player:sendAction(6, 20)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:setAether("snowstorm6", 500)
		player:playSound(58)
		target:sendAnimation(392, 1)
		player:sendMinitext("You cast Snowstorm Lv6.")
		target.attacker = player.ID
		target:removeHealthExtend(damage, 1, 1, 1, 1, 0)
		target:sendMinitext(player.name.." pelts you with snow.")
	end
end,

requirements = function(player)
	local level = 99
	local items = {}
	local itemAmounts = {}
	local description = {"Upgrade Snowstorm to Lv5."}
	return level, items, itemAmounts, description
end
}]]
--
