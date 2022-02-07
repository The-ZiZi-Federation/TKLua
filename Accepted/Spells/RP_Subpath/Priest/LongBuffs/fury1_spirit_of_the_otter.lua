-------------------------------------------------------
--   Spell: Spirit of the Otter
--   Class: Priest
--   Level: 7
--  Aether: 0 Second
--    Cost: 150
--    Type: Fury Bonus
-- Targets: Self
-- Effects: Fury Mult: 2x
--        : Flank: N/A
-------------------------------------------------------
--    Desc: Multiply your base damage 2x.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 6/5/2017
-------------------------------------------------------
spirit_of_the_otter = {
	on_learn = function(player)
		player.registry["learned_spirit_of_the_otter"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_spirit_of_the_otter"] = 0
	end,
	cast = function(player)
		local magicCost = 150
		local duration = 600000
		local sound = 31
		local anim = 38

		if not player:canCast(1, 1, 0) then
			return
		end
		if player:hasDuration("spirit_of_the_otter") then
			player:setDuration("spirit_of_the_otter", 0)
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
		player:setDuration("spirit_of_the_otter", duration)
		player:calcStat()
		player:sendMinitext("You cast Spirit of the Otter")
	end,
	recast = function(player)
		player.fury = 4
	end,
	uncast = function(player)
		player:calcStat()
		player:sendMinitext("Spirit of the Otter ends.")
	end,
	requirements = function(player)
		local level = 7
		local item = {0, 246, 50}
		local amounts = {50, 5, 10}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {
			"Spirit of the Otter is a spell that hones your fighting technique to increase your attack damage!",
			txt
		}
		return level, item, amounts, desc
	end
}
