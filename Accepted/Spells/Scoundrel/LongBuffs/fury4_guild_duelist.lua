-------------------------------------------------------
--   Spell: Guild Duelist
--   Class: Scoundrel
--   Level: 92
--  Aether: 0 Second
--    Cost: 1500
--    Type: Fury Bonus
-- Targets: Self
-- Effects: Fury Mult: 5x
--        : Flank: N/A
-------------------------------------------------------
--    Desc: Multiply your base damage 5x.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 07/07/2017
-------------------------------------------------------
guild_duelist = {
	on_learn = function(player)
		player.registry["learned_guild_duelist"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_guild_duelist"] = 0
	end,
	cast = function(player)
		local magicCost = 1500
		local duration = 600000
		local sound = 31
		local anim = 36

		if not player:canCast(1, 1, 0) then
			return
		end
		if player:hasDuration("guild_duelist") then
			player:setDuration("guild_duelist", 0)
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
		player:setDuration("guild_duelist", duration)
		player:calcStat()
		player:sendMinitext("You cast Guild Duelist")
	end,
	recast = function(player)
		player.fury = 8
	end,
	uncast = function(player)
		player:calcStat()
		player:sendMinitext("Guild Duelist ends.")
	end,
	requirements = function(player)
		local level = 92
		local item = {0, 51}
		local amounts = {25000, 1}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {
			"Guild Duelist is a spell that hones your fighting technique to increase your attack damage!\nReplaces Tavern Duelist.",
			txt
		}
		return level, item, amounts, desc
	end
}
