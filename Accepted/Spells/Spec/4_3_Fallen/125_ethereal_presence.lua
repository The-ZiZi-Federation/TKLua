-------------------------------------------------------
--   Spell: Ethereal Presence
--   Class: Fallen
--   Level: 125
--  Aether: 2 min
--    Cost: player.maxMagic * 0.025
-- DmgType: N/A
--    Type: Buff
-- Targets: Self
-------------------------------------------------------
--    Desc: Temporary invincibility
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 6/13/2017
-------------------------------------------------------
ethereal_presence = {
	on_learn = function(player)
		player.registry["learned_ethereal_presence"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_ethereal_presence"] = 0
	end,
	cast = function(player)
		local magicCost = math.floor(player.maxMagic * 0.025)
		local duration = 15000
		local aether = 120000
		local anim = 177
		local sound = 68

		if not player:canCast(1, 1, 0) then
			return
		end
		if player.magic < magicCost then
			notEnoughMP(player)
			return
		end
		if player:hasDuration("ethereal_presence") then
			alreadyCast(player)
			return
		end

		player:sendAction(6, 20)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:sendAnimation(anim)
		player:playSound(sound)
		player:setDuration("ethereal_presence", duration)
		player:setAether("ethereal_presence", aether)
		player:sendMinitext("You cast Ethereal Presence")
	end,
	uncast = function(player)
		player:sendMinitext("You are no longer ethereal")
	end,
	requirements = function(player)
		local level = 125
		local item = {0}
		local amounts = {100000}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Fade into the Ethereal plane to avoid enemy attacks.", txt}
		return level, item, amounts, desc
	end
}
