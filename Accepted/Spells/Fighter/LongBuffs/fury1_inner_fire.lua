-------------------------------------------------------
--   Spell: Inner Fire
--   Class: Fighter
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
--   Last Edited: 6/5/2017
-------------------------------------------------------
inner_fire = {
	on_learn = function(player)
		player.registry["learned_inner_fire"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_inner_fire"] = 0
	end,
	cast = function(player)
		local magicCost = 150
		local duration = 600000
		local sound = 31
		local anim = 36

		if not player:canCast(1, 1, 0) then
			return
		end
		if player:hasDuration("inner_fire") then
			player:setDuration("inner_fire", 0)
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
		player:setDuration("inner_fire", duration)
		player:calcStat()
		player:sendMinitext("You cast Inner Fire")
	end,
	recast = function(player)
		player.fury = 2
	end,
	uncast = function(player)
		player:calcStat()
		player:sendMinitext("Your Inner Fire fades away")
	end,
	requirements = function(player)
		local level = 7
		local item = {3003, 52}
		local amounts = {3, 1}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Inner Fire is a spell that focuses your spirit to increase your attack damage!", txt}
		return level, item, amounts, desc
	end
}
