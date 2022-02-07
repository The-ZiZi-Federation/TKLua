-------------------------------------------------------
--   Spell: Aligned Weapon
--   Class: Priest
--   Level: 17
--  Aether: 0 Second
--    Cost: 500 mana
--    Type: Enchant Bonus
-- Targets: Self
-- Effects: Enchant Mult: 3x
--        : Flank: N/A
-------------------------------------------------------
--    Desc: Multiply your weapon's damage 3x.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 07/05/2017
-------------------------------------------------------
aligned_weapon = {
	on_learn = function(player)
		player.registry["learned_aligned_weapon"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_aligned_weapon"] = 0
	end,
	cast = function(player)
		local magicCost = 500
		local duration = 600000
		local sound = 31
		local anim = 38

		if not player:canCast(1, 1, 0) then
			return
		end
		if player:hasDuration("aligned_weapon") then
			player:setDuration("aligned_weapon", 0)
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
		player:setDuration("aligned_weapon", duration)
		player:calcStat()
		player:sendMinitext("You cast Aligned Weapon")
	end,
	recast = function(player)
		player.enchant = 4
	end,
	uncast = function(player)
		player:calcStat()
		player:sendMinitext("You have lost focus on your Aligned Weapon")
	end,
	requirements = function(player)
		local level = 17
		local item = {0, 3016, 3017, 3018, 3019}
		local amounts = {500, 5, 5, 1, 1}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Aligned Weapon is a spell that enhances your skill and improves weapon damage!", txt}
		return level, item, amounts, desc
	end
}
