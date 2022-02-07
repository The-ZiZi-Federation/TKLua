-------------------------------------------------------
--   Spell: Weapon Dexterity
--   Class: Scoundrel
--   Level: 67
--  Aether: 0 Second
--    Cost: 950
--    Type: Enchant Bonus
-- Targets: Self
-- Effects: Enchant Mult: 5x
--        : Flank: N/A
-------------------------------------------------------
--    Desc: Multiply your weapon's damage 5x.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 6/5/2017
-------------------------------------------------------
weapon_dexterity = {
	on_learn = function(player)
		player.registry["learned_weapon_dexterity"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_weapon_dexterity"] = 0
	end,
	cast = function(player)
		local magicCost = 950
		local duration = 600000
		local sound = 31
		local anim = 82

		if not player:canCast(1, 1, 0) then
			return
		end
		if player:hasDuration("weapon_dexterity") then
			player:setDuration("weapon_dexterity", 0)
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
		player:setDuration("weapon_dexterity", duration)
		player:calcStat()
		player:sendMinitext("You cast Weapon Dexterity")
	end,
	recast = function(player)
		player.enchant = 6
	end,
	uncast = function(player)
		player:calcStat()
		player:sendMinitext("You have lost focus on your Weapon Dexterity")
	end,
	requirements = function(player)
		local level = 67
		local item = {6001, 297}
		local amounts = {2, 50}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Weapon Dexterity is a spell that enhances your skill and improves weapon damage!", txt}
		return level, item, amounts, desc
	end
}
