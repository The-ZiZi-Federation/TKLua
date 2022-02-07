-------------------------------------------------------
--   Spell: Kingdom Duelist
--   Class: Scoundrel
--   Level: 111
--  Aether: 0 Second
--    Cost: 11000
--    Type: Fury Bonus
-- Targets: Self
-- Effects: Fury Mult: 6x
--        : Flank: N/A
-------------------------------------------------------
--    Desc: Multiply your base damage 6x.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 6/5/2017
-------------------------------------------------------
kingdom_duelist = {
	on_learn = function(player)
		player.registry["learned_kingdom_duelist"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_kingdom_duelist"] = 0
	end,
	cast = function(player)
		local magicCost = 11000
		local duration = 600000
		local sound = 31
		local anim = 35

		if not player:canCast(1, 1, 0) then
			return
		end
		if player:hasDuration("kingdom_duelist") then
			player:setDuration("kingdom_duelist", 0)
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
		player:setDuration("kingdom_duelist", duration)
		player:calcStat()
		player:sendMinitext("You cast Kingdom Duelist")
	end,
	recast = function(player)
		player.fury = 10
	end,
	uncast = function(player)
		player:calcStat()
		player:sendMinitext("Kingdom Duelist ends.")
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
			"Kingdom Duelist is a spell that hones your fighting technique to increase your attack damage!\nReplaces Guild Duelist.",
			txt
		}
		return level, item, amounts, desc
	end
}
