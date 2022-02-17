-------------------------------------------------------
--   Spell: Inner Ferocity
--   Class: Fighter
--   Level: 92
--  Aether: 0 Second
--    Cost: 1200
--    Type: Fury Bonus
-- Targets: Self
-- Effects: Fury Mult: 7x
--        : Flank: N/A
-------------------------------------------------------
--    Desc: Multiply your base damage 7x.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 6/5/2017
-------------------------------------------------------
inner_ferocity = {
	on_learn = function(player)
		player.registry["learned_inner_ferocity"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_inner_ferocity"] = 0
	end,
	cast = function(player)
		local magicCost = 1200
		local duration = 600000
		local sound = 31
		local anim = 36

		if not player:canCast(1, 1, 0) then
			return
		end
		if player:hasDuration("inner_ferocity") then
			player:setDuration("inner_ferocity", 0)
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
		player:setDuration("inner_ferocity", duration)
		player:calcStat()
		player:sendMinitext("You cast Inner Ferocity")
	end,
	recast = function(player)
		player.fury = 10
	end,
	uncast = function(player)
		player:calcStat()
		player:sendMinitext("Your Inner Ferocity fades away")
	end,
	requirements = function(player)
		local level = 92
		local item = {51}
		local amounts = {1}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {
			"Inner Ferocity is a spell that focuses your spirit to increase your attack damage!\nReplaces Inner Fervor.",
			txt
		}
		return level, item, amounts, desc
	end
}
