-------------------------------------------------------
--   Spell: Master Duelist
--   Class: Scoundrel
--   Level: 197
--  Aether: 0 Second
--    Cost: 100000
--    Type: Fury Bonus
-- Targets: Self
-- Effects: Fury Mult: 8x
--        : Flank: N/A
-------------------------------------------------------
--    Desc: Multiply your base damage 8x.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 07/07/2017
-------------------------------------------------------
master_duelist = {
	on_learn = function(player)
		player.registry["learned_master_duelist"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_master_duelist"] = 0
	end,
	cast = function(player)
		local magicCost = 100000
		local duration = 600000
		local sound = 31
		local anim = 35

		if not player:canCast(1, 1, 0) then
			return
		end
		if player:hasDuration("master_duelist") then
			player:setDuration("master_duelist", 0)
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
		player:setDuration("master_duelist", duration)
		player:calcStat()
		player:sendMinitext("You cast Master Duelist")
	end,
	recast = function(player)
		player.fury = 14
	end,
	uncast = function(player)
		player:calcStat()
		player:sendMinitext("Master Duelist ends.")
	end,
	requirements = function(player)
		local level = 197
		local item = {0}
		local amounts = {0}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {
			"Master Duelist is a spell that hones your fighting technique to increase your attack damage!\nReplaces Champion Duelist.",
			txt
		}
		return level, item, amounts, desc
	end
}
