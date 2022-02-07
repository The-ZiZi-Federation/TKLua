-------------------------------------------------------
--   Spell: Spirit of the Elk
--   Class: Priest
--   Level: 63
--  Aether: 0 Second
--    Cost: 1000
--    Type: Fury Bonus
-- Targets: Self
-- Effects: Fury Mult: 4x
--        : Flank: N/A
-------------------------------------------------------
--    Desc: Multiply your base damage 4x.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 6/13/2017
-------------------------------------------------------
spirit_of_the_elk = {
	on_learn = function(player)
		player.registry["learned_spirit_of_the_elk"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_spirit_of_the_elk"] = 0
	end,
	cast = function(player)
		local magicCost = 1000
		local duration = 600000
		local sound = 31
		local anim = 38

		if not player:canCast(1, 1, 0) then
			return
		end
		if player:hasDuration("spirit_of_the_elk") then
			player:setDuration("spirit_of_the_elk", 0)
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
		player:setDuration("spirit_of_the_elk", duration)
		player:calcStat()
		player:sendMinitext("You cast Spirit of the Elk")
	end,
	recast = function(player)
		player.fury = 8
	end,
	uncast = function(player)
		player:calcStat()
		player:sendMinitext("Spirit of the Elk ends.")
	end,
	requirements = function(player)
		local level = 63
		local item = {0, 51}
		local amounts = {20000, 1}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {
			"Spirit of the Elk is a spell that hones your fighting technique to increase your attack damage!\nReplaces Spirit of the Badger.",
			txt
		}
		return level, item, amounts, desc
	end
}
