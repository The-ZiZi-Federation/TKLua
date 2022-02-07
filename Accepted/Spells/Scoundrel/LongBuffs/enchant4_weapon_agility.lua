-------------------------------------------------------
--   Spell: Weapon Agility
--   Class: Scoundrel
--   Level: 101
--  Aether: 0 Second
--    Cost: 6000
--    Type: Enchant Bonus
-- Targets: Self
-- Effects: Enchant Mult: 9x
--        : Flank: N/A
-------------------------------------------------------
--    Desc: Multiply your weapon's damage 9x.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 07/07/2017
-------------------------------------------------------
weapon_agility = {
	on_learn = function(player)
		player.registry["learned_weapon_agility"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_weapon_agility"] = 0
	end,
	cast = function(player)
		local magicCost = 6000
		local duration = 600000
		local sound = 31
		local anim = 82

		if not player:canCast(1, 1, 0) then
			return
		end
		if player:hasDuration("weapon_agility") then
			player:setDuration("weapon_agility", 0)
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
		player:setDuration("weapon_agility", duration)
		player:calcStat()
		player:sendMinitext("You cast Weapon Agility")
	end,
	recast = function(player)
		player.enchant = 10
	end,
	uncast = function(player)
		player:calcStat()
		player:sendMinitext("You have lost focus on your Weapon Agility")
	end,
	requirements = function(player)
		local level = 101
		local item = {6001, 418}
		local amounts = {4, 50}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Weapon Agility is a spell that enhances your skill and improves weapon damage!", txt}
		return level, item, amounts, desc
	end
}
