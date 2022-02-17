-------------------------------------------------------
--   Spell: Flurry of Knives
--   Class: Scoundrel
--   Level: 90
--  Aether: 22 Second
--    Cost: (player.level * 25) + (player.maxMagic / 13)
-- DmgType: Physical
--    Type: Offensive
-- Targets: 1 - 8
-- Effects: Bleed Damage. 4 Seconds
-------------------------------------------------------
--    Desc: Moderate Damage to up to 8 enemies.
--          Leaves them bleeding for 4 seconds afterward.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 07/07/2017
-------------------------------------------------------
flurry_of_knives = {
	on_learn = function(player)
		player.registry["learned_flurry_of_knives"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_flurry_of_knives"] = 0
	end,
	cast = function(player)
		----------------------
		--Varable Declarations
		----------------------
		local magicCost = (player.level * 15)
		local bleedDuration = 4000
		local aether = 22000

		local threat

		local mobTargets = player:getObjectsInArea(BL_MOB)
		local pcTargets = player:getObjectsInArea(BL_PC)

		local m = player.m
		local x = player.x
		local y = player.y

		local anim = 89
		local sound = 35
		---------------------------
		--- Spell Damage Formula---
		--------------------------
		local damage

		-------------------------------------------------------------
		if (not player:canCast(1, 1, 0)) then
			return
		end

		if (player.magic < magicCost) then
			player:sendMinitext("Not enough mana.")
			return
		end

		-------------------------------------------------------------
		if #mobTargets > 0 or #pcTargets > 0 then
			player:sendAction(1, 20)
			player:setAether("flurry_of_knives", aether)
			player:sendMinitext("You cast Flurry of Knives.")
			player:playSound(sound)
			player.magic = player.magic - magicCost
			player:sendStatus()
		end

		for i = 1, #mobTargets do
			if (mobTargets[i] ~= nil) then
				player.critChance = 1
				damage =
					math.floor(((0.025 * player.maxHealth) + (0.1 * player.level) + swingDamage(player, mobTargets[i], 2)) * 7.5)
				if distanceSquare(player, mobTargets[i], 1) then
					mobTargets[i].attacker = player.ID
					threat = mobTargets[i]:removeHealthExtend(damage, 1, 1, 0, 1, 2)
					player:addThreat(mobTargets[i].ID, threat)
					mobTargets[i]:sendAnimation(anim)
					mobTargets[i]:removeHealthExtend(damage, 1, 1, 0, 1, 1)
					if player.registry["extra_spell_info"] > 0 then
						player:sendMinitext("Flurry of Knives DMG: " .. damage)
					end
					if not mobTargets[i]:hasDuration("bleed") then
						mobTargets[i]:setDuration("bleed", bleedDuration)
					end
				end
			elseif (pcTargets[i] ~= nil) and (player:canPK(pcTargets[i])) then
				player.critChance = 1
				damage =
					math.floor(((0.025 * player.maxHealth) + (0.1 * player.level) + swingDamage(player, pcTargets[i], 2)) * 7.5)
				if distanceSquare(player, pcTargets[i], 1) then
					pcTargets[i]:sendAnimation(anim)
					pcTargets[i].attacker = player.ID
					pcTargets[i]:removeHealthExtend(damage, 1, 1, 0, 1, 1)
					pcTargets[i]:sendMinitext(player.name .. " stabs you faster than your eyes can follow.")
					if not pcTargets[i]:hasDuration("bleed") then
						pcTargets[i]:setDuration("bleed", bleedDuration)
					end
				end
			else
				player:sendMinitext("Nothing to attack!")
			end
		end
	end,
	requirements = function(player)
		local level = 90
		local item = {0, 392, 424}
		local amounts = {50000, 20, 10}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Flurry of Knives unleashes a storm of steel around around you, causing massive bleeding wounds.", txt}
		return level, item, amounts, desc
	end
}
