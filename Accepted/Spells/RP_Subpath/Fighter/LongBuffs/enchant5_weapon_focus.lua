-------------------------------------------------------
--   Spell: Weapon Focus
--   Class: Fighter
--   Level: 136
--  Aether: 0 Second
--    Cost: (player.maxMagic / 15)
--    Type: Enchant Bonus
-- Targets: Self
-- Effects: Enchant Mult: 6x
--        : Flank: N/A
-------------------------------------------------------
--    Desc: Multiply your weapon's damage 6x.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 6/6/2017
-------------------------------------------------------
weapon_focus = {
	on_learn = function(player)
		player.registry["learned_weapon_focus"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_weapon_focus"] = 0
	end,
	cast = function(player)
		local magicCost = (player.maxMagic / 15)
		local duration = 600000
		local sound = 31
		local anim = 36

		if not player:canCast(1, 1, 0) then
			return
		end
		if player:hasDuration("weapon_focus") then
			player:setDuration("weapon_focus", 0)
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
		player:setDuration("weapon_focus", duration)
		player:calcStat()
		player:sendMinitext("You cast Weapon Focus")
	end,
	recast = function(player)
		player.enchant = 7
	end,
	uncast = function(player)
		player:calcStat()
		player:sendMinitext("You have lost focus of your Weapon Focus")
	end,
	requirements = function(player)
		local level = 136
		local item = {0}
		local amounts = {0}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Weapon Focus is a spell that enhances your skill and improves weapon damage!", txt}
		return level, item, amounts, desc
	end
}
