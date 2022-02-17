-------------------------------------------------------
--   Spell: Weapon Savvy
--   Class: Fighter
--   Level: 101
--  Aether: 0 Second
--    Cost: 6000
--    Type: Enchant Bonus
-- Targets: Self
-- Effects: Enchant Mult: 5x
--        : Flank: N/A
-------------------------------------------------------
--    Desc: Multiply your weapon's damage 5x.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 6/6/2017
-------------------------------------------------------
weapon_savvy = {
	on_learn = function(player)
		player.registry["learned_weapon_savvy"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_weapon_savvy"] = 0
	end,
	cast = function(player)
		local magicCost = 6000
		local duration = 600000
		local sound = 31
		local anim = 83

		if not player:canCast(1, 1, 0) then
			return
		end
		if player:hasDuration("weapon_savvy") then
			player:setDuration("weapon_savvy", 0)
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
		player:setDuration("weapon_savvy", duration)
		player:calcStat()
		player:sendMinitext("You cast Weapon Savvy")
	end,
	recast = function(player)
		player.enchant = 6
	end,
	uncast = function(player)
		player:calcStat()
		player:sendMinitext("You have lost focus of your Weapon Savvy")
	end,
	requirements = function(player)
		local level = 101
		local item = {6001}
		local amounts = {4}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Weapon Savvy is a spell that enhances your skill and improves weapon damage!", txt}
		return level, item, amounts, desc
	end
}
