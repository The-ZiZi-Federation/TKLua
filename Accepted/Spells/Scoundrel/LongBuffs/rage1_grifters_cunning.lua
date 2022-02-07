-------------------------------------------------------
--   Spell: Grifter's Cunning
--   Class: Scoundrel
--   Level: 5
--  Aether: 0 Second
--    Cost: 100
--    Type: Rage Bonus
-- Targets: Self
-- Effects: Rage Mult: 2x
--        : Flank: N/A
-------------------------------------------------------
--    Desc: Double your damage output to swing and spells while cast.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 07/07/2017
-------------------------------------------------------
grifters_cunning = {
	on_learn = function(player)
		player.registry["learned_grifters_cunning"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_grifters_cunning"] = 0
	end,
	cast = function(player)
		local magicCost = 100
		local duration = 600000
		local sound = 31
		local anim = 35

		if not player:canCast(1, 1, 0) then
			return
		end
		if player:hasDuration("grifters_cunning") then
			player:setDuration("grifters_cunning", 0)
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
		player:setDuration("grifters_cunning", duration)
		player:calcStat()
		player:sendMinitext("You cast Grifter's Cunning")
	end,
	on_swing_while_cast = function(player)
		local pcTarget = getTargetFacing(player, BL_PC)
		local mobTarget = getTargetFacing(player, BL_MOB)

		if mobTarget ~= nil then
			if not mobTarget:hasDuration("bleed") then
				mobTarget.attacker = player.ID
				mobTarget:setDuration("bleed", 3000)
			end
		elseif pcTarget ~= nil then
			if (player:canPK(pcTarget)) then
				pcTarget.attacker = player.ID
				pcTarget:setDuration("bleed", 3000)
			end
		end
	end,
	recast = function(player)
		player.rage = 3
	end,
	uncast = function(player)
		player:calcStat()
		player:sendMinitext("Your Grifter's Cunning fades away")
	end,
	requirements = function(player)
		local level = 5
		local item = {0}
		local amounts = {0}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Grifter's Cunning is a spell that multiplies your attack damage!", txt}
		return level, item, amounts, desc
	end
}
