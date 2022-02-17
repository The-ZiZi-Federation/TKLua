-------------------------------------------------------
--   Spell: Inner Storm
--   Class: Fighter
--   Level: 246
--  Aether: 0 Second
--    Cost: (player.level * 500) + (player.maxMagic / 15)
--    Type: Fury Bonus
-- Targets: Self
-- Effects: Fury Mult: 15x
--        : Flank: N/A
-------------------------------------------------------
--    Desc: Multiply your base damage 15x.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 6/5/2017
-------------------------------------------------------
inner_storm = {
	on_learn = function(player)
		player.registry["learned_inner_storm"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_inner_storm"] = 0
	end,
	cast = function(player)
		local magicCost = (player.level * 500) + (player.maxMagic / 15)
		local duration = 600000
		local sound = 31
		local anim = 36

		if not player:canCast(1, 1, 0) then
			return
		end
		if player:hasDuration("inner_storm") then
			player:setDuration("inner_storm", 0)
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
		player:setDuration("inner_storm", duration)
		player:calcStat()
		player:sendMinitext("You cast Inner Storm")
	end,
	recast = function(player)
		player.fury = 16
	end,
	uncast = function(player)
		player:calcStat()
		player:sendMinitext("Your Inner Storm fades away")
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
			"Inner Storm is a spell that focuses your spirit to increase your attack damage!\nReplaces Inner Violence.",
			txt
		}
		return level, item, amounts, desc
	end
}
