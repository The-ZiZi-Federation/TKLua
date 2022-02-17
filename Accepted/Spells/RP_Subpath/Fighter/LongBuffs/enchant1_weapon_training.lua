-------------------------------------------------------
--   Spell: Weapon Training
--   Class: Fighter
--   Level: 17
--  Aether: 0 Second
--    Cost: 500 mana
--    Type: Enchant Bonus
-- Targets: Self
-- Effects: Enchant Mult: 2x
--        : Flank: N/A
-------------------------------------------------------
--    Desc: Multiply your weapon's damage 2x.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 6/13/2017
-------------------------------------------------------
weapon_training = {
	on_learn = function(player)
		player.registry["learned_weapon_training"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_weapon_training"] = 0
	end,
	cast = function(player)
		local magicCost = 500
		local duration = 600000
		local sound = 31
		local anim = 36

		if not player:canCast(1, 1, 0) then
			return
		end
		if player:hasDuration("weapon_training") then
			player:setDuration("weapon_training", 0)
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
		player:setDuration("weapon_training", duration)
		player:calcStat()
		player:sendMinitext("You cast Weapon Training")
	end,
	recast = function(player)
		player.enchant = 2
	end,
	uncast = function(player)
		player:calcStat()
		player:sendMinitext("You have lost focus of your Weapon Training")
	end,
	requirements = function(player)
		local level = 17
		local item = {6001}
		local amounts = {1}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Weapon Training is a spell that enhances your skill and improves weapon damage!", txt}
		return level, item, amounts, desc
	end
}
