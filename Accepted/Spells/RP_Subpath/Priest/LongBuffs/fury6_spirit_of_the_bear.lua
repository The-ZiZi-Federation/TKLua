-------------------------------------------------------
--   Spell: Spirit of the Bear
--   Class: Priest
--   Level: 153
--  Aether: 0 Second
--    Cost: (player.level * 10) + (player.maxMagic / 25)
--    Type: Fury Bonus
-- Targets: Self
-- Effects: Fury Mult: 9x
--        : Flank: N/A
-------------------------------------------------------
--    Desc: Multiply your base damage 9x.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 6/5/2017
-------------------------------------------------------
spirit_of_the_bear = {
	on_learn = function(player)
		player.registry["learned_spirit_of_the_bear"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_spirit_of_the_bear"] = 0
	end,
	cast = function(player)
		local magicCost = (player.level * 10) + (player.maxMagic / 25)
		local duration = 600000
		local sound = 31
		local anim = 38

		if not player:canCast(1, 1, 0) then
			return
		end
		if player:hasDuration("spirit_of_the_bear") then
			player:setDuration("spirit_of_the_bear", 0)
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
		player:setDuration("spirit_of_the_bear", duration)
		player:calcStat()
		player:sendMinitext("You cast Spirit of the Bear")
	end,
	recast = function(player)
		player.fury = 14
	end,
	uncast = function(player)
		player:calcStat()
		player:sendMinitext("Spirit of the Bear ends.")
	end,
	requirements = function(player)
		local level = 153
		local item = {0}
		local amounts = {0}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {
			"Spirit of the Bear is a spell that hones your fighting technique to increase your attack damage!\nReplaces Spirit of the Lion.",
			txt
		}
		return level, item, amounts, desc
	end
}
