-------------------------------------------------------
--   Spell: Inner Fervor
--   Class: Fighter
--   Level: 63
--  Aether: 0 Second
--    Cost: 1000
--    Type: Fury Bonus
-- Targets: Self
-- Effects: Fury Mult: 5x
--        : Flank: N/A
-------------------------------------------------------
--    Desc: Multiply your base damage 5x.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 6/13/2017
-------------------------------------------------------
inner_fervor = {
	on_learn = function(player)
		player.registry["learned_inner_fervor"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_inner_fervor"] = 0
	end,
	cast = function(player)
		local magicCost = 1000
		local duration = 600000
		local sound = 31
		local anim = 36

		if not player:canCast(1, 1, 0) then
			return
		end
		if player:hasDuration("inner_fervor") then
			player:setDuration("inner_fervor", 0)
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
		player:setDuration("inner_fervor", duration)
		player:calcStat()
		player:sendMinitext("You cast Inner Fervor")
	end,
	recast = function(player)
		player.fury = 7
	end,
	uncast = function(player)
		player:calcStat()
		player:sendMinitext("Your Inner Fervor fades away")
	end,
	requirements = function(player)
		local level = 63
		local item = {0}
		local amounts = {7500}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {
			"Inner Fervor is a spell that focuses your spirit to increase your attack damage!\nReplaces Inner Power.",
			txt
		}
		return level, item, amounts, desc
	end
}
