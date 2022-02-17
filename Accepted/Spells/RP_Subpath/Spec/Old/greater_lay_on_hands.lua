--[[
-------------------------------------------------------
--   Spell: Greater Lay on Hands                          
--   Class: Paladin
--   Level: 125
--  Aether: 1 Second
--    Cost: 1000 MP
-- DmgType: N/A 
--    Type: Heal
-- Targets: Single Target
-- Effects: Restore Vita
-------------------------------------------------------
--    Desc: Self Heal, base 3000 Vita
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 3/25/2017
-------------------------------------------------------
--cure wounds- single target high heal level 125
greater_lay_on_hands = {

on_learn = function(player) player.registry["learned_greater_lay_on_hands"] = 1 end,
on_forget = function(player) player.registry["learned_greater_lay_on_hands"] = 0 end,

cast = function(player, target)
	local recoverAmount = player.maxHealth - player.health
	local will = player.will
	local willBonusPct = ((will / (will + 50)) ^ 1.1)
	local level = player.level

	local magicCost = math.floor((2600 + (12 * level)))
	local healBase = math.floor((8000 + (16 * level)))
	local aether = math.ceil(4000 - (4000 * (willBonusPct / 3)))
	local healBonus = math.floor((healBase * willBonusPct))
	local totalHeal = healBase + healBonus

--	player:sendMinitext("Heal Base (8000 + (16 * Level)) "..healBase)
--	player:sendMinitext("Heal Bonus (Will based) "..healBonus)
--	player:sendMinitext("Total Heal: "..totalHeal)
--	player:sendMinitext("Magic Cost (2600 + (12 * Level)) "..magicCost)
--	player:sendMinitext("Aether "..aether)
	
	if not player:canCast(1,1,0) then return else
		if player.magic < magicCost then notEnoughMP(player) return else
			if target.health == target.maxHealth then
				player:sendMinitext("Your target is at Max Vita!!")
				return
			end
			if target.health <= 0 or target then
				player:sendMinitext("Your target is dead!")
				return
			end
			if target ~= nil then
				if target.state == 1 or player.health <= 0 then return else
					player:sendAction(6, 20)
					player.magic = player.magic - magicCost
					player:calcStat()
					player:sendStatus()
					player:sendMinitext("You cast Greater Lay on Hands.  You heal your target for "..totalHeal.." Vita.")
					player:playSound(22)
					target:sendAnimation(325)
					target:sendAnimation(422)
					addHealth(target, totalHeal)
					player:setAether("greater_lay_on_hands", aether)
					if target.blType == BL_PC and target.ID ~= player.ID then 
						target:sendMinitext(player.name.." cast Greater Lay on Hands on you.  You are healed for "..totalHeal.." Vita.")
					end
				end
			end
		end
	end
end
}
]]
--
