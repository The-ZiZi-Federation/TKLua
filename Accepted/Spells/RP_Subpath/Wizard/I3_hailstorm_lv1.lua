-------------------------------------------------------
--   Spell: Hailstorm Lv1
--   Class: Wizard
--   Level: 63
--  Aether: 24 Second
--    Cost: player.maxMagic * 0.25
-- DmgType: Magical: Ice
--  Damage: (player.maxMagic * manaMult) + (player.level * levelMult) + (player.will * willMult) + (player.grace * graceMult)
--    Type: Offensive
-- Targets: 8 - 12
--                 X
--     X X X     X X X
--     X P X - X X P X X
--     X X X     X X X
--                 X
-- Effects: N/A
-------------------------------------------------------
--    Desc: A burst of ice engulfs a group of enemies.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 07/05/17
-------------------------------------------------------

hailstorm_lv1 = {
	on_learn = function(player)
		player.registry["learned_hailstorm_lv1"] = 1
		player:removeSpell("hailstorm_lv2")
	end,
	on_forget = function(player)
		player.registry["learned_hailstorm_lv1"] = 0
	end,
	cast = function(player, target)
		--------------------------
		--Varable Declarations ---
		--------------------------
		if not distanceSquare(player, target, 6) then
			player:sendMinitext("Target is too far away!")
			return
		end

		local duration = 9000
		local aether = 24000
		local magicCost = player.maxMagic * 0.25

		local mobTargets = {}
		local pcTargets = {}
		local threat

		local m = player.m
		local x = player.x
		local y = player.y

		local anim = 392
		local sound = 44

		local manaMult = 0
		local levelMult = 0
		local willMult = 0
		local graceMult = 0
		local r = math.random(1, 1000)

		---------------------------
		--- Spell Damage Formula---
		---------------------------

		if player.level < 150 then
			manaMult = 7.5
			levelMult = 750
			willMult = 750
			graceMult = 750

			pcTargets = {
				player:getObjectsInCell(target.m, target.x + 1, target.y, BL_PC)[1],
				player:getObjectsInCell(target.m, target.x - 1, target.y, BL_PC)[1],
				player:getObjectsInCell(target.m, target.x, target.y + 1, BL_PC)[1],
				player:getObjectsInCell(target.m, target.x, target.y - 1, BL_PC)[1],
				player:getObjectsInCell(target.m, target.x + 1, target.y + 1, BL_PC)[1],
				player:getObjectsInCell(target.m, target.x + 1, target.y - 1, BL_PC)[1],
				player:getObjectsInCell(target.m, target.x - 1, target.y + 1, BL_PC)[1],
				player:getObjectsInCell(target.m, target.x - 1, target.y - 1, BL_PC)[1]
			}

			mobTargets = {
				player:getObjectsInCell(target.m, target.x + 1, target.y, BL_MOB)[1],
				player:getObjectsInCell(target.m, target.x - 1, target.y, BL_MOB)[1],
				player:getObjectsInCell(target.m, target.x, target.y + 1, BL_MOB)[1],
				player:getObjectsInCell(target.m, target.x, target.y - 1, BL_MOB)[1],
				player:getObjectsInCell(target.m, target.x + 1, target.y + 1, BL_MOB)[1],
				player:getObjectsInCell(target.m, target.x + 1, target.y - 1, BL_MOB)[1],
				player:getObjectsInCell(target.m, target.x - 1, target.y + 1, BL_MOB)[1],
				player:getObjectsInCell(target.m, target.x - 1, target.y - 1, BL_MOB)[1]
			}
		elseif player.level >= 150 then
			manaMult = 13
			levelMult = 1300
			willMult = 1300
			graceMult = 1300

			pcTargets = {
				player:getObjectsInCell(target.m, target.x + 1, target.y, BL_PC)[1],
				player:getObjectsInCell(target.m, target.x - 1, target.y, BL_PC)[1],
				player:getObjectsInCell(target.m, target.x, target.y + 1, BL_PC)[1],
				player:getObjectsInCell(target.m, target.x, target.y - 1, BL_PC)[1],
				player:getObjectsInCell(target.m, target.x + 1, target.y + 1, BL_PC)[1],
				player:getObjectsInCell(target.m, target.x + 1, target.y - 1, BL_PC)[1],
				player:getObjectsInCell(target.m, target.x - 1, target.y + 1, BL_PC)[1],
				player:getObjectsInCell(target.m, target.x - 1, target.y - 1, BL_PC)[1],
				player:getObjectsInCell(target.m, target.x + 2, target.y, BL_PC)[1],
				player:getObjectsInCell(target.m, target.x - 2, target.y, BL_PC)[1],
				player:getObjectsInCell(target.m, target.x, target.y + 2, BL_PC)[1],
				player:getObjectsInCell(target.m, target.x, target.y - 2, BL_PC)[1]
			}

			mobTargets = {
				player:getObjectsInCell(target.m, target.x + 1, target.y, BL_MOB)[1],
				player:getObjectsInCell(target.m, target.x - 1, target.y, BL_MOB)[1],
				player:getObjectsInCell(target.m, target.x, target.y + 1, BL_MOB)[1],
				player:getObjectsInCell(target.m, target.x, target.y - 1, BL_MOB)[1],
				player:getObjectsInCell(target.m, target.x + 1, target.y + 1, BL_MOB)[1],
				player:getObjectsInCell(target.m, target.x + 1, target.y - 1, BL_MOB)[1],
				player:getObjectsInCell(target.m, target.x - 1, target.y + 1, BL_MOB)[1],
				player:getObjectsInCell(target.m, target.x - 1, target.y - 1, BL_MOB)[1],
				player:getObjectsInCell(target.m, target.x + 2, target.y, BL_MOB)[1],
				player:getObjectsInCell(target.m, target.x - 2, target.y, BL_MOB)[1],
				player:getObjectsInCell(target.m, target.x, target.y + 2, BL_MOB)[1],
				player:getObjectsInCell(target.m, target.x, target.y - 2, BL_MOB)[1]
			}
		end

		local damage =
			(player.maxMagic * manaMult) + (player.level * levelMult) + (player.will * willMult) + (player.grace * graceMult)
		damage = math.floor(damage)

		local targets = {}

		if (not player:canCast(1, 1, 0)) then
			return
		end

		if (player.magic < magicCost) then
			player:sendMinitext("Not enough mana.")
			return
		end

		if (target.state == 1) then
			if player.blType == BL_PC then
				player:sendMinitext("That is no longer useful.")
			end
			return
		end

		for i = 1, 12 do
			if (pcTargets[i] ~= nil) then
				if (pcTargets[i].state ~= 1) then
					table.insert(targets, pcTargets[i])
				end
			end
		end

		for i = 1, 12 do
			if (mobTargets[i] ~= nil) then
				table.insert(targets, mobTargets[i])
			end
		end

		player:sendAction(6, 20)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:setAether("hailstorm_lv1", aether)
		player:playSound(sound)
		player:sendMinitext("You cast Hailstorm Lv1.")
		if player.registry["extra_spell_info"] == 1 then
			player:sendMinitext("Hailstorm Lv1 DMG: " .. damage)
		end

		if (target.blType == BL_MOB) then
			target:sendAnimation(anim)
			target.attacker = player.ID
			threat = target:removeHealthExtend(damage, 1, 1, 0, 1, 2)
			player:addThreat(target.ID, threat)
			target:removeHealthExtend(damage, 1, 1, 0, 1, 1)

			if r <= 50 then
				if not target:hasDuration("slow") then
					if checkResist(player, target, "slow") == 1 then
						return
					end
					target:setDuration("slow", duration)
				end
			end
		elseif (target.blType == BL_PC) then
			target:sendAnimation(anim)
			target.attacker = player.ID
			if player:canPK(target) then
				target:removeHealthExtend(damage, 1, 1, 0, 1, 1)
				target:sendMinitext(player.name .. " chills you with Hailstorm Lv1.")
				if r <= 50 then
					if not target:hasDuration("slow") then
						target:setDuration("slow", duration)
					end
				end
			end
		end

		if (#targets > 0) then
			for i = 1, #targets do
				if (targets[i] ~= nil and targets[i].blType == BL_MOB) then
					targets[i].attacker = player.ID
					threat = targets[i]:removeHealthExtend(damage, 1, 1, 0, 1, 2)
					player:addThreat(targets[i].ID, threat)

					targets[i]:removeHealthExtend(damage, 1, 1, 0, 1, 1)
					if r <= 50 then
						if not targets[i]:hasDuration("slow") then
							if checkResist(player, targets[i], "slow") == 1 then
								return
							end
							targets[i]:setDuration("slow", duration)
						end
					end
				elseif (targets[i] ~= nil and targets[i].blType == BL_PC and player:canPK(targets[i])) then
					targets[i].attacker = player.ID
					targets[i]:removeHealthExtend(damage, 1, 1, 0, 1, 1)
					targets[i]:sendMinitext(player.name .. " chills you with Hailstorm Lv1.")
					if r <= 50 then
						if not targets[i]:hasDuration("slow") then
							targets[i]:setDuration("slow", duration)
						end
					end
				end
			end
		end
	end,
	requirements = function(player)
		local level = 63
		local item = {0, 297, 401}
		local amounts = {2500, 25, 1}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Hailstorm Lv1 will drop a sheet of ice on an area!", txt}
		return level, item, amounts, desc
	end
}
