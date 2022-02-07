--[[
-------------------------------------------------------
--   Spell: Incredible First Aid                      
--   Class: Fighter
--   Level: 130
--  Aether: 5 Seconds - (Will Bonus / 3) seconds
--    Cost: 2500 + (7 * level)
-- DmgType: N/A
--    Type: Vita Recovery
-- Targets: Self
-- Effects: Heal Formula: 4000 Vita + (12 * level) + Will Bonus %
-------------------------------------------------------
--    Desc: A Massive heal.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 3/25/2017
-------------------------------------------------------
incredible_first_aid = {

on_learn = function(player) 
	
	if (player:hasSpell("supreme_first_aid")) then
		player:removeSpell("supreme_first_aid")
	end
	
	player.registry["learned_incredible_first_aid"] = 1 
end,

on_forget = function(player) 
	
	player.registry["learned_incredible_first_aid"] = 0 
end,

cast = function(player)
	local recoverAmount = player.maxHealth - player.health
	local will = player.will
	local willBonusPct = ((will / (will + 50)) ^ 1.1)
	local level = player.level

	local healBase = (4000 + (12 * level))
	local healBonus = (healBase * willBonusPct)
	local totalHeal = healBase + healBonus
	totalHeal = math.floor(totalHeal)
--	player:sendMinitext("Heal Base (6000 + 12x Level) "..healBase)
--	player:sendMinitext("Heal Bonus (Will based) "..healBonus)
--	player:sendMinitext("Total Heal: "..totalHeal)
	local magicCost = math.floor((2500 + (7 * level)))
--	player:sendMinitext("Magic Cost"..magicCost)
	local aether = math.ceil(5000 - (5000 * (willBonusPct / 3)))
--	player:sendMinitext("Magic Cost"..aether)
	if not player:canCast(1,1,0) then return end
	if player.state == 1 or player.health <= 0 then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	if player.health == player.maxHealth then
		player:sendMinitext("You are at Max Vita!!")
		return
	end
	player:sendAction(6, 20)
	player.magic = player.magic - magicCost
	player:sendAnimation(5)
	player:playSound(3)
	player:setAether("incredible_first_aid", aether)
	addHealth(player, totalHeal)
	player:sendMinitext("You cast Incredible First Aid.  You heal yourself for "..totalHeal.." Vita.")

end
}]]
--
