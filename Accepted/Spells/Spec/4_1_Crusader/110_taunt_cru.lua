-------------------------------------------------------
--   Spell: Taunt
--   Class: Crusader
--   Level: 110
--  Aether: 1 Second
-- Targets: 1
-------------------------------------------------------
--   Desc.: Threaten a target into attacking you.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 08/20/2017
-------------------------------------------------------

taunt_cru = {
	on_learn = function(player)
		player.registry["learned_taunt_cru"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_taunt_cru"] = 0
	end,
	cast = function(player, target)
		------------------------
		--Varable Declarations--
		------------------------
		local aether = 1000
		local magicCost = 500
		local threat = 100000
		local anim = 170
		local sound = 35
		player.critChance = 1
		---------------------------------------------------------
		if not player:canCast(1, 1, 0) then
			return
		end
		--------------------------------------------
		if player.magic < magicCost then
			notEnoughMP(player)
			return
		end

		if target.blType == BL_PC then
			invalidTarget(player)
			return
		end

		---------------------------------------------
		if (target.blType == BL_MOB) then
			target.attacker = player.ID
			player.magic = player.magic - magicCost
			player:addThreat(target.ID, threat)
			player:sendAction(6, 20)
			player:playSound(sound)
			player:sendMinitext("You cast Taunt")
			player:setAether("taunt_cru", aether)
			player:sendStatus()
			target:sendAnimation(anim)
		end
	end,
	requirements = function(player)
		local level = 5
		local item = {0}
		local amounts = {50000}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Taunt an enemy into attacking you!", txt}
		return level, item, amounts, desc
	end
}
