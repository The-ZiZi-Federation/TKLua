-------------------------------------------------------
--   Spell: Street Duelist
--   Class: Scoundrel
--   Level: 42
--  Aether: 0 Second
--    Cost: 600
--    Type: Fury Bonus
-- Targets: Self
-- Effects: Fury Mult: 3x
--        : Flank: N/A
-------------------------------------------------------
--    Desc: Multiply your base damage 3x.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 6/5/2017
-------------------------------------------------------
street_duelist = {
	on_learn = function(player)
		player.registry["learned_street_duelist"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_street_duelist"] = 0
	end,
	cast = function(player)
		local magicCost = 600
		local duration = 600000
		local sound = 31
		local anim = 35

		if not player:canCast(1, 1, 0) then
			return
		end
		if player:hasDuration("street_duelist") then
			player:setDuration("street_duelist", 0)
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
		player:setDuration("street_duelist", duration)
		player:calcStat()
		player:sendMinitext("You cast Street Duelist")
	end,
	recast = function(player)
		player.fury = 4
	end,
	uncast = function(player)
		player:calcStat()
		player:sendMinitext("Street Duelist ends.")
	end,
	requirements = function(player)
		local level = 42
		local item = {0}
		local amounts = {7500}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {
			"Street Duelistis a spell that hones your fighting technique to increase your attack damage!\nReplaces Alley Duelist.",
			txt
		}
		return level, item, amounts, desc
	end
}
