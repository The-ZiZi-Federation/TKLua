--[[
-------------------------------------------------------
--   Spell: Bolster Armor Lv2                    
--   Class: Fighter
--   Level: 125-200
--  Aether: 0 Seconds
--    Cost: 500 MP
-- DmgType: N/A
--    Type: Armor Buff
-- Targets: Self
-- Effects: Armor + 50
-------------------------------------------------------
--    Desc: Boost your Armor.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 3/25/2017
-------------------------------------------------------
bolster_armor_2 = {

on_learn = function(player) player.registry["bolster_armor_2"] = 1 end,
on_forget = function(player) player.registry["bolster_armor_2"] = 0 end,

cast = function(player, target)

	local magicCost = 500
	local duration = 600000

	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	if player:hasDuration("bolster_armor_2") then alreadyCast(player) return end

	player:sendAction(6, 20)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendAnimation(21)
	player:playSound(8)
	player:setDuration("bolster_armor_2", duration)
	player:calcStat()
	player:sendMinitext("You cast Bolster Armor Lv2")
end,


recast = function(player)
	local willBonusPct
	local grace = player.grace
	
	willBonusPct = math.floor((((grace/(grace+50))^1.1)))
	
	player.armor = player.armor + (50 + math.floor(50 * willBonusPct))

end,


uncast = function(player)
	local willBonusPct
	local grace = player.grace
	
	willBonusPct = math.floor((((grace/(grace+50))^1.1)))

	player.armor = player.armor - (50 + math.floor(50 * willBonusPct))

	player:calcStat()
	player:sendMinitext("Your armor bonus fades")
end
}]]
--
