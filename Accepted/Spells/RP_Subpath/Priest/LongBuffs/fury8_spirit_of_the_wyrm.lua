-------------------------------------------------------
--   Spell: Spirit of the Wyrm
--   Class: Priest
--   Level: 246
--  Aether: 0 Second
--    Cost: (player.level * 500) + (player.maxMagic / 15)
--    Type: Fury Bonus
-- Targets: Self
-- Effects: Fury Mult: 13x
--        : Flank: N/A
-------------------------------------------------------
--    Desc: Multiply your base damage 13x.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 6/5/2017
-------------------------------------------------------
spirit_of_the_wyrm = {
	on_learn = function(player)
		player.registry["learned_spirit_of_the_wyrm"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_spirit_of_the_wyrm"] = 0
	end,
	cast = function(player)
		local magicCost = (player.level * 500) + (player.maxMagic / 15)
		local duration = 600000
		local sound = 31
		local anim = 38

		if not player:canCast(1, 1, 0) then
			return
		end
		if player:hasDuration("spirit_of_the_wyrm") then
			player:setDuration("spirit_of_the_wyrm", 0)
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
		player:setDuration("spirit_of_the_wyrm", duration)
		player:calcStat()
		player:sendMinitext("You cast Spirit of the Wyrm")
	end,
	recast = function(player)
		player.fury = 18
	end,
	uncast = function(player)
		player:calcStat()
		player:sendMinitext("Spirit of the Wyrm ends.")
	end,
	requirements = function(player)
		local level = 246
		local item = {0}
		local amounts = {0}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {
			"Spirit of the Wyrm is a spell that hones your fighting technique to increase your attack damage!\nReplaces Spirit of the Moose.",
			txt
		}
		return level, item, amounts, desc
	end
}
