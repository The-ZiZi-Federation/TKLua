-------------------------------------------------------
--   Spell: Smite Evil
--   Class: Priest
--   Level: 100
--  Aether: 45 Second
-- Targets: 1
-------------------------------------------------------
--   Desc.: A holy light douses the foe.  Depends more on
-- 			Will for damage.  Considered a Magic Attack for defense calculations
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 07/08/2017
-------------------------------------------------------

smite_evil = {
	on_learn = function(player)
		player.registry["learned_smite_evil"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_smite_evil"] = 0
	end,
	cast = function(player)
		------------------------
		--Varable Declarations--
		------------------------
		local magicCost = player.maxMagic * 0.3 -- calculate MP cost of spell
		local healthCost = player.maxHealth * 0.3 -- calculate MP cost of spell
		local damage
		local aether = 45000

		local mobTarget = getTargetFacing(player, BL_MOB)
		local pcTarget = getTargetFacing(player, BL_PC)

		local m = player.m
		local x = player.x
		local y = player.y

		local threat
		player.critChance = 1
		----------------------------
		-- Check if Castable--------
		----------------------------
		if (not player:canCast(1, 1, 0)) then
			return
		end
		----------------------------
		-- Check if MP available----
		----------------------------
		if player.magic < magicCost or player.magic - magicCost <= 0 then
			player:sendAnimation(246)
			player:sendMinitext("Not Enough MP.")
			return
		end
		----------------------------
		-- Check if HP available----
		----------------------------
		if player.health < healthCost or player.health - healthCost <= 0 then
			player:sendAnimation(246)
			player:sendMinitext("Not Enough HP.")
			return
		end
		-- Target is an enemy
		if mobTarget ~= nil then
			damage = ((0.025 * player.maxHealth) + (0.1 * player.level) + swingDamage(player, mobTarget, 2)) * 23
			mobTarget.attacker = player.ID
			player.magic = player.magic - magicCost
			player.health = player.health - healthCost
			-------------------
			-- Agro -----------
			-------------------
			threat = mobTarget:removeHealthExtend(damage, 1, 1, 0, 1, 2)
			player:addThreat(mobTarget.ID, threat)
			-------------------------------------
			-- Action, Animation, Text, Sound ---
			-------------------------------------
			player:sendAction(1, 20)
			player:talk(2, "BEGONE!!!")
			player:sendMinitext("You Smite Evil")
			player:playSound(14)
			----------------------------------------------------
			player:setAether("smite_evil", aether)
			player:sendStatus()
			-- Affect Mobs ----------------------
			mobTarget:sendAnimation(6, 0)
			mobTarget:sendAnimation(412, 0)
			mobTarget:removeHealthExtend(damage, 1, 1, 0, 1, 1)
		elseif pcTarget ~= nil then
			if (player:canPK(pcTarget)) then
				damage = ((0.025 * player.maxHealth) + (0.1 * player.level) + swingDamage(player, pcTarget, 2)) * 23
				player:sendAction(1, 20)
				player.magic = player.magic - magicCost
				player:sendStatus()
				player:sendMinitext("You Smite Evil")
				player:playSound(14)

				pcTarget:sendAnimation(6, 0)
				pcTarget:sendAnimation(412, 0)
				player:setAether("smite_evil", aether)
				pcTarget.attacker = player.ID
				pcTarget:removeHealthExtend(damage, 1, 1, 0, 1, 1)
			end
		end
	end,
	on_takedamage_while_cast = function(block)
		block:setDuration("smite_evil", 0)
	end,
	while_cast = function(block)
		block:sendAnimation(33)
		block:sendAnimation(12)
	end,
	uncast = function(block)
		target.paralyzed = false
		block:calcStat()
	end,
	requirements = function(player)
		local level = 100
		local item = {0, 437}
		local amounts = {150000, 1}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Smite your enemies with Holy might!", txt}
		return level, item, amounts, desc
	end
}
