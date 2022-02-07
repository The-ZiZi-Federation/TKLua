-------------------------------------------------------
--   Spell: Dark Magic
--   Class: Wizard
--   Level: 80
--  Aether: 0 seconds
--    Cost: (player.maxMagic * 0.025)
--	Damage: (player.maxMagic * manaMult) + (player.level * levelMult) + (player.will * willMult) + (player.grace * graceMult)
-- DmgType: Magical
--    Type: Fire
-- Targets: Single, Ranged
--  Effect: Chance to Sear on Hit for 3 seconds.
-------------------------------------------------------
--    Desc: Fire rains on the target.
-------------------------------------------------------
-- Script Author: John Crandell, John Day, Justin Chartier
--   Last Edited: 07/02/2017
-------------------------------------------------------
dark_magic = {
	on_learn = function(player)
		player.registry["learned_dark_magic"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_dark_magic"] = 0
	end,
	cast = function(player, target)
		----------------------
		--Varable Declarations
		----------------------

		if not distanceSquare(player, target, 9) then
			player:sendMinitext("Target is too far away!")
			return
		end

		local magicCost = (player.maxMagic * 0.01)
		local poisonDuration = 3000
		local r = math.random(1, 1000)

		local threat

		local m = player.m
		local x = player.x
		local y = player.y

		local anim = 51
		local sound = 361

		---------------------------
		--- Spell Damage Formula---
		---------------------------

		local pcSideTargets = {}
		local mobSideTargets = {}

		local damage
		---------------------------------
		-- Cast Checks ------------------
		---------------------------------
		if (player.blType == BL_PC) then
			if (not player:canCast(1, 1, 0)) then
				return
			end
		end

		if (player.magic < magicCost) then
			player:sendAnimation(246)
			player:sendMinitext("Not enough mana.")
			return
		end

		if (target.state == 1) then
			player:sendMinitext("That is no longer useful.")
			return
		end

		player.magic = player.magic - magicCost
		player:sendAction(6, 20)
		player:sendStatus()
		player:playSound(sound)
		player:sendMinitext("You cast Dark Magic!")
		if player.level >= 99 then
			pcSideTargets = {
				player:getObjectsInCell(target.m, target.x + 1, target.y, BL_PC)[1],
				player:getObjectsInCell(target.m, target.x - 1, target.y, BL_PC)[1],
				player:getObjectsInCell(target.m, target.x, target.y + 1, BL_PC)[1],
				player:getObjectsInCell(target.m, target.x, target.y - 1, BL_PC)[1]
			}

			mobSideTargets = {
				player:getObjectsInCell(target.m, target.x + 1, target.y, BL_MOB)[1],
				player:getObjectsInCell(target.m, target.x - 1, target.y, BL_MOB)[1],
				player:getObjectsInCell(target.m, target.x, target.y + 1, BL_MOB)[1],
				player:getObjectsInCell(target.m, target.x, target.y - 1, BL_MOB)[1]
			}
		end

		-----------------player vs mob-------------------------------

		if (target.blType == BL_MOB) then
			----------------player vs player-----------------------------------------------------------
			player.critChance = 1
			damage = ((0.025 * player.maxHealth) + (0.1 * player.level) + swingDamage(player, target, 2)) * 5
			target.attacker = player.ID
			threat = target:removeHealthExtend(damage, 1, 1, 0, 1, 2)
			player:addThreat(target.ID, threat)
			target:sendAnimation(anim)
			target:removeHealthExtend(damage, 1, 1, 0, 1, 1)
			if r <= 50 then
				if not target:hasDuration("poison") then
					if checkResist(player, target, "poison") == 1 then
						return
					end
					target:setDuration("poison", poisonDuration)
				end
			end

			for i = 1, 4 do
				if (mobSideTargets[i] ~= nil) then
					player.critChance = 1
					damage = ((0.025 * player.maxHealth) + (0.1 * player.level) + swingDamage(player, mobSideTargets[i], 2)) * 5
					mobSideTargets[i].attacker = player.ID
					mobSideTargets[i]:removeHealthExtend(damage, 1, 1, 0, 1, 1)
					mobSideTargets[i]:sendAnimation(anim)
				end
			end
		elseif (target.blType == BL_PC and player:canPK(target)) then
			target:sendAnimation(anim)
			target.attacker = player.ID
			target:removeHealthExtend(damage, 1, 1, 0, 1, 1)
			target:sendMinitext(player.name .. " poisons you with Dark Magic.")
			if r <= 50 then
				if not target:hasDuration("poison") then
					target:setDuration("poison", poisonDuration)
				end
			end
			for i = 1, 4 do
				if (pcSideTargets[i] ~= nil) then
					if pcSideTargets[i].state ~= 1 and player:canPK(pcSideTargets[i]) then
						pcSideTargets[i].attacker = player.ID
						pcflankTargets[i]:removeHealthExtend(damage, 1, 1, 0, 1, 1)
						pcflankTargets[i]:sendMinitext(player.name .. " poisons you with Dark Magic.")
						pcflankTargets[i]:sendAnimation(anim)
					end
				end
			end
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

		local desc = {"Dark Magic corrupts and poisons your target!", txt}
		return level, item, amounts, desc
	end
}
