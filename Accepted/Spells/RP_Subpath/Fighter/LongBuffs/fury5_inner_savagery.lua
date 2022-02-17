-------------------------------------------------------
--   Spell: Inner Savagery
--   Class: Fighter
--   Level: 111
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
inner_savagery = {
	on_learn = function(player)
		player.registry["learned_inner_savagery"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_inner_savagery"] = 0
	end,
	cast = function(player)
		local magicCost = (player.level * 10) + (player.maxMagic / 25)
		local duration = 600000
		local sound = 31
		local anim = 36

		if not player:canCast(1, 1, 0) then
			return
		end
		if player:hasDuration("inner_savagery") then
			player:setDuration("inner_savagery", 0)
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
		player:setDuration("inner_savagery", duration)
		player:calcStat()
		player:sendMinitext("You cast Inner Savagery")
	end,
	recast = function(player)
		player.fury = 13
	end,
	uncast = function(player)
		player:calcStat()
		player:sendMinitext("Your Inner Savagery fades away")
	end,
	requirements = function(player)
		local level = 111
		local item = {0}
		local amounts = {100000}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {
			"Inner Savagery is a spell that focuses your spirit to increase your attack damage!\nReplaces Inner Ferocity.",
			txt
		}
		return level, item, amounts, desc
	end
}
