-------------------------------------------------------
--   Spell: Eminent Duelist
--   Class: Scoundrel
--   Level: 246
--  Aether: 0 Second
--    Cost: 420000
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
eminent_duelist = {
	on_learn = function(player)
		player.registry["learned_eminent_duelist"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_eminent_duelist"] = 0
	end,
	cast = function(player)
		local magicCost = 420000
		local duration = 600000
		local sound = 31
		local anim = 35

		if not player:canCast(1, 1, 0) then
			return
		end
		if player:hasDuration("eminent_duelist") then
			player:setDuration("eminent_duelist", 0)
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
		player:setDuration("eminent_duelist", duration)
		player:calcStat()
		player:sendMinitext("You cast Eminent Duelist")
	end,
	recast = function(player)
		player.fury = 15
	end,
	uncast = function(player)
		player:calcStat()
		player:sendMinitext("Eminent Duelist ends.")
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
			"Eminent Duelist is a spell that hones your fighting technique to increase your attack damage!\nReplaces Master Duelist.",
			txt
		}
		return level, item, amounts, desc
	end
}
