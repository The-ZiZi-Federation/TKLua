-------------------------------------------------------
--   Spell: Alley Duelist
--   Class: Scoundrel
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
--   Last Edited: 07/07/2017
-------------------------------------------------------
alley_duelist = {
	on_learn = function(player)
		player.registry["learned_alley_duelist"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_alley_duelist"] = 0
	end,
	cast = function(player)
		local magicCost = 150
		local duration = 600000
		local sound = 31
		local anim = 35

		if not player:canCast(1, 1, 0) then
			return
		end
		if player:hasDuration("alley_duelist") then
			player:setDuration("alley_duelist", 0)
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
		player:setDuration("alley_duelist", duration)
		player:calcStat()
		player:sendMinitext("You cast Alley Duelist")
	end,
	recast = function(player)
		player.fury = 3
	end,
	uncast = function(player)
		player:calcStat()
		player:sendMinitext("Alley Duelist ends.")
	end,
	requirements = function(player)
		local level = 7
		local item = {50, 248, 3001}
		local amounts = {10, 5, 1}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Alley Duelist is a spell that hones your fighting technique to increase your attack damage!", txt}
		return level, item, amounts, desc
	end
}
