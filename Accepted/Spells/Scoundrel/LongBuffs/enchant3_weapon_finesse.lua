-------------------------------------------------------
--   Spell: Weapon Finesse
--   Class: Scoundrel
--   Level: 84
--  Aether: 0 Second
--    Cost: 2100
--    Type: Enchant Bonus
-- Targets: Self
-- Effects: Enchant Mult: 7x
--        : Flank: N/A
-------------------------------------------------------
--    Desc: Multiply your weapon's damage 7x.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 6/13/2017
-------------------------------------------------------
weapon_finesse = {
	on_learn = function(player)
		player.registry["learned_weapon_finesse"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_weapon_finesse"] = 0
	end,
	cast = function(player)
		local magicCost = 2100
		local duration = 600000
		local sound = 31
		local anim = 82

		if not player:canCast(1, 1, 0) then
			return
		end
		if player:hasDuration("weapon_finesse") then
			player:setDuration("weapon_finesse", 0)
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
		player:setDuration("weapon_finesse", duration)
		player:calcStat()
		player:sendMinitext("You cast Weapon Finesse")
	end,
	recast = function(player)
		player.enchant = 8
	end,
	uncast = function(player)
		player:calcStat()
		player:sendMinitext("You have lost focus on your Weapon Finesse")
	end,
	requirements = function(player)
		local level = 84
		local item = {6001, 406}
		local amounts = {3, 20}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Weapon Finesse is a spell that enhances your skill and improves weapon damage!", txt}
		return level, item, amounts, desc
	end
}
