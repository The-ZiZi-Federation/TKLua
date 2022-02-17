-------------------------------------------------------
--   Spell: Hasten Core
--   Class: Priest
--   Level: 110
--  Aether: 60 Second
--    Cost: maxMagic * 0.05
--    Type: Enchant Bonus
-- Targets: Self
-- Effects: 10 Speed and 5 player.dam
--        : Flank: N/A
-------------------------------------------------------
--    Desc: Self Haste
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 07/05/2017
-------------------------------------------------------
hasten_core = {
	on_learn = function(player)
		player.registry["learned_hasten_core"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_hasten_core"] = 0
	end,
	cast = function(player)
		local magicCost = (player.maxMagic * 0.05)
		local aether = 60000
		local duration = 15000
		local sound = 118
		local anim = 146

		if not player:canCast(1, 1, 0) then
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
		player:setDuration("hasten_core", duration)
		player:setAether("hasten_core", aether)
		player:calcStat()
		player:sendMinitext("You cast Hasten Core")
	end,
	recast = function(player)
		player.dam = player.dam + 5
		player.speed = 70
	end,
	uncast = function(player)
		player:calcStat()
		player:sendMinitext("You have lost focus on your Hasten Core")
	end,
	requirements = function(player)
		local level = 5
		local item = {0}
		local amounts = {50000}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Hasten Core is a spell that enhances your speed and dam!", txt}
		return level, item, amounts, desc
	end
}
