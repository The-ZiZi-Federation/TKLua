-------------------------------------------------------
--   Spell: Tavern Duelist
--   Class: Scoundrel
--   Level: 63
--  Aether: 0 Second
--    Cost: 900
--    Type: Fury Bonus
-- Targets: Self
-- Effects: Fury Mult: 4x
--        : Flank: N/A
-------------------------------------------------------
--    Desc: Multiply your base damage 4x.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 07/07/2017
-------------------------------------------------------
tavern_duelist = {
	on_learn = function(player)
		player.registry["learned_tavern_duelist"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_tavern_duelist"] = 0
	end,
	cast = function(player)
		local magicCost = 900
		local duration = 600000
		local sound = 31
		local anim = 35

		if not player:canCast(1, 1, 0) then
			return
		end
		if player:hasDuration("tavern_duelist") then
			player:setDuration("tavern_duelist", 0)
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
		player:setDuration("tavern_duelist", duration)
		player:calcStat()
		player:sendMinitext("You cast Tavern Duelist")
	end,
	recast = function(player)
		player.fury = 6
	end,
	uncast = function(player)
		player:calcStat()
		player:sendMinitext("Tavern Duelist ends.")
	end,
	requirements = function(player)
		local level = 63
		local item = {15005}
		local amounts = {1}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {
			"Tavern Duelist is a spell that hones your fighting technique to increase your attack damage!\nReplaces Street Duelist.",
			txt
		}
		return level, item, amounts, desc
	end
}
