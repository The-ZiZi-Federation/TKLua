-------------------------------------------------------
--   Spell: Weapon Swiftness
--   Class: Scoundrel
--   Level: 160
--  Aether: 0 Second
--    Cost: 55000
--    Type: Enchant Bonus
-- Targets: Self
-- Effects: Enchant Mult: 11x
--        : Flank: N/A
-------------------------------------------------------
--    Desc: Multiply your weapon's damage 11x.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 07/07/2017
-------------------------------------------------------
weapon_swiftness = {
	on_learn = function(player)
		player.registry["learned_weapon_swiftness"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_weapon_swiftness"] = 0
	end,
	cast = function(player)
		local magicCost = 55000
		local duration = 600000
		local sound = 31
		local anim = 82

		if not player:canCast(1, 1, 0) then
			return
		end
		if player:hasDuration("weapon_swiftness") then
			player:setDuration("weapon_swiftness", 0)
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
		player:setDuration("weapon_swiftness", duration)
		player:calcStat()
		player:sendMinitext("You cast Weapon Swiftness")
	end,
	recast = function(player)
		player.enchant = 14
	end,
	uncast = function(player)
		player:calcStat()
		player:sendMinitext("You have lost focus on your Weapon Swiftness")
	end,
	requirements = function(player)
		local level = 160
		local item = {0}
		local amounts = {0}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Weapon Swiftness is a spell that enhances your skill and improves weapon damage!", txt}
		return level, item, amounts, desc
	end
}
