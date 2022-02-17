-------------------------------------------------------
--   Spell: Inner Power
--   Class: Fighter
--   Level: 42
--  Aether: 0 Second
--    Cost: 650
--    Type: Fury Bonus
-- Targets: Self
-- Effects: Fury Mult: 4x
--        : Flank: N/A
-------------------------------------------------------
--    Desc: Multiply your base damage 4x.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 6/5/2017
-------------------------------------------------------
inner_power = {
	on_learn = function(player)
		player.registry["learned_inner_power"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_inner_power"] = 0
	end,
	cast = function(player)
		local magicCost = 650
		local duration = 600000
		local sound = 31
		local anim = 36

		if not player:canCast(1, 1, 0) then
			return
		end
		if player:hasDuration("inner_power") then
			player:setDuration("inner_power", 0)
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
		player:setDuration("inner_power", duration)
		player:calcStat()
		player:sendMinitext("You cast Inner Power")
	end,
	recast = function(player)
		player.fury = 5
	end,
	uncast = function(player)
		player:calcStat()
		player:sendMinitext("Your Inner Power fades away")
	end,
	requirements = function(player)
		local level = 42
		local item = {0}
		local amounts = {5000}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {
			"Inner Power is a spell that focuses your spirit to increase your attack damage!\nReplaces Inner Fire.",
			txt
		}
		return level, item, amounts, desc
	end
}
