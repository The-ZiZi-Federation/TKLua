-------------------------------------------------------
--   Spell: Consecrated Weapon
--   Class: Priest
--   Level: 194
--  Aether: 0 Second
--    Cost: player.maxMagic / 15
--    Type: Enchant Bonus
-- Targets: Self
-- Effects: Enchant Mult: 14x
--        : Flank: N/A
-------------------------------------------------------
--    Desc: Multiply your weapon's damage 14x.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 6/6/2017
-------------------------------------------------------
consecrated_weapon = {
	on_learn = function(player)
		player.registry["learned_consecrated_weapon"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_consecrated_weapon"] = 0
	end,
	cast = function(player)
		local magicCost = player.maxMagic / 15
		local duration = 600000
		local sound = 31
		local anim = 80

		if not player:canCast(1, 1, 0) then
			return
		end
		if player:hasDuration("consecrated_weapon") then
			player:setDuration("consecrated_weapon", 0)
			return
		end
		if player.magic < magicCost then
			notEnoughMP(player)
			return
		end

		player:sendAction(6, 20)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:sendAnimation(anim)
		player:playSound(sound)
		player:setDuration("consecrated_weapon", duration)
		player:calcStat()
		player:sendMinitext("You cast Consecrated Weapon")
	end,
	recast = function(player)
		player.enchant = 16
	end,
	uncast = function(player)
		player:calcStat()
		player:sendMinitext("You have lost focus on your Consecrated Weapon")
	end,
	requirements = function(player)
		local level = 194
		local item = {0}
		local amounts = {0}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Consecrated Weapon is a spell that enhances your skill and improves weapon damage!", txt}
		return level, item, amounts, desc
	end
}
