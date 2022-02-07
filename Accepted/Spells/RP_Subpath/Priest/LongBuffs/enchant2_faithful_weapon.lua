-------------------------------------------------------
--   Spell: Faithful Weapon
--   Class: Priest
--   Level: 67
--  Aether: 0 Second
--    Cost: 750
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
faithful_weapon = {
	on_learn = function(player)
		player.registry["learned_faithful_weapon"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_faithful_weapon"] = 0
	end,
	cast = function(player)
		local magicCost = 750
		local duration = 600000
		local sound = 31
		local anim = 38

		if not player:canCast(1, 1, 0) then
			return
		end
		if player:hasDuration("faithful_weapon") then
			player:setDuration("faithful_weapon", 0)
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
		player:setDuration("faithful_weapon", duration)
		player:calcStat()
		player:sendMinitext("You cast Faithful Weapon")
	end,
	recast = function(player)
		player.enchant = 6
	end,
	uncast = function(player)
		player:calcStat()
		player:sendMinitext("You have lost focus on your Faithful Weapon")
	end,
	requirements = function(player)
		local level = 67
		local item = {6001}
		local amounts = {2}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Faithful Weapon is a spell that enhances your skill and improves weapon damage!", txt}
		return level, item, amounts, desc
	end
}
