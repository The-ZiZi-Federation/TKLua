-------------------------------------------------------
--   Spell: Flare Lv4
--   Class: Wizard
--   Level: 80
--  Aether: 0.5 Sec
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
flare_lv4 = {
	on_learn = function(player)
		player.registry["learned_flare_lv4"] = 1
		player:removeSpell("flare_lv1")
		player:removeSpell("flare_lv2")
		player:removeSpell("flare_lv3")
		player:removeSpell("flare_lv5")
	end,
	on_forget = function(player)
		player.registry["learned_flare_lv4"] = 0
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
		local searDuration = 3000
		local r = math.random(1, 1000)

		local threat

		local m = player.m
		local x = player.x
		local y = player.y

		local anim = 47
		local sound = 29

		---------------------------
		--- Spell Damage Formula---
		---------------------------
		local manaMult = 2.5
		local levelMult = 250
		local willMult = 250
		local graceMult = 250
		local pcSideTargets = {}
		local mobSideTargets = {}

		local damage =
			(player.maxMagic * manaMult) + (player.level * levelMult) + (player.will * willMult) + (player.grace * graceMult)
		damage = math.floor(damage)
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
		player:sendMinitext("You cast Flare Lv4")
		if player.registry["extra_spell_info"] == 1 then
			player:sendMinitext("Flare Lv4 DMG: " .. damage)
		end

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
			target.attacker = player.ID
			threat = target:removeHealthExtend(damage, 1, 1, 0, 1, 2)
			player:addThreat(target.ID, threat)
			target:sendAnimation(anim)
			target:removeHealthExtend(damage, 1, 1, 0, 1, 1)
			if r <= 50 then
				if not target:hasDuration("seared") then
					if checkResist(player, target, "seared") == 1 then
						return
					end
					target:setDuration("seared", searDuration)
				end
			end

			for i = 1, 4 do
				if (mobSideTargets[i] ~= nil) then
					mobSideTargets[i].attacker = player.ID
					mobSideTargets[i]:removeHealthExtend(damage, 1, 1, 0, 1, 1)
					mobSideTargets[i]:sendAnimation(anim)
				end
			end
		elseif (target.blType == BL_PC and player:canPK(target)) then
			target:sendAnimation(anim)
			target.attacker = player.ID
			target:removeHealthExtend(damage, 1, 1, 0, 1, 1)
			target:sendMinitext(player.name .. " burns you with Flare Lv4")
			if r <= 50 then
				if not target:hasDuration("seared") then
					target:setDuration("seared", searDuration)
				end
			end
			for i = 1, 4 do
				if (pcSideTargets[i] ~= nil) then
					if pcSideTargets[i].state ~= 1 and player:canPK(pcSideTargets[i]) then
						pcSideTargets[i].attacker = player.ID
						pcflankTargets[i]:removeHealthExtend(damage, 1, 1, 0, 1, 1)
						pcflankTargets[i]:sendMinitext(player.name .. " burns you with Flare Lv4.")
						pcflankTargets[i]:sendAnimation(anim)
					end
				end
			end
		end
	end,
	requirements = function(player)
		local level = 80
		local item = {0, 6033, 3031}
		local amounts = {5000, 12, 25}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Flare Lv4 sets an opponent ablaze!\n\nReplaces Flare Lv3", txt}
		return level, item, amounts, desc
	end
}
