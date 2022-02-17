-------------------------------------------------------
--   Spell: Hailstorm Lv2
--   Class: Wizard
--   Level: 200
--  Aether: 24 Second
--    Cost: player.maxMagic * 0.25
-- DmgType: Magical: Ice
--  Damage: (player.maxMagic * manaMult) + (player.level * levelMult) + (player.will * willMult) + (player.grace * graceMult)
--    Type: Offensive
-- Targets: 21
--
--            X X X
--          X X X X X
--          X X T X X
--          X X X X X
--            X X X
--
-- Effects: N/A
-------------------------------------------------------
--    Desc: A burst of ice engulfs a group of enemies.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 07/05/17
-------------------------------------------------------

hailstorm_lv2 = {
	on_learn = function(player)
		player.registry["learned_hailstorm_lv2"] = 1
		player:removeSpell("hailstorm_lv1")
	end,
	on_forget = function(player)
		player.registry["learned_hailstorm_lv2"] = 0
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

		local manaMult = 25
		local levelMult = 2500
		local willMult = 2500
		local graceMult = 2500
		local r = math.random(1, 1000)

		---------------------------
		--- Spell Damage Formula---
		---------------------------

		local damage =
			(player.maxMagic * manaMult) + (player.level * levelMult) + (player.will * willMult) + (player.grace * graceMult)
		damage = math.floor(damage)

		pcTargets = {
			player:getObjectsInCell(target.m, target.x, target.y - 2, BL_PC)[1],
			player:getObjectsInCell(target.m, target.x + 1, target.y - 2, BL_PC)[1],
			player:getObjectsInCell(target.m, target.x - 1, target.y - 2, BL_PC)[1],
			player:getObjectsInCell(target.m, target.x, target.y + 2, BL_PC)[1],
			player:getObjectsInCell(target.m, target.x + 1, target.y + 2, BL_PC)[1],
			player:getObjectsInCell(target.m, target.x - 1, target.y + 2, BL_PC)[1],
			player:getObjectsInCell(target.m, target.x - 2, target.y, BL_PC)[1],
			player:getObjectsInCell(target.m, target.x - 2, target.y + 1, BL_PC)[1],
			player:getObjectsInCell(target.m, target.x - 2, target.y - 1, BL_PC)[1],
			player:getObjectsInCell(target.m, target.x + 2, target.y, BL_PC)[1],
			player:getObjectsInCell(target.m, target.x + 2, target.y + 1, BL_PC)[1],
			player:getObjectsInCell(target.m, target.x + 2, target.y - 1, BL_PC)[1]
		}

		mobTargets = {
			player:getObjectsInCell(target.m, target.x, target.y - 2, BL_MOB)[1],
			player:getObjectsInCell(target.m, target.x + 1, target.y - 2, BL_MOB)[1],
			player:getObjectsInCell(target.m, target.x - 1, target.y - 2, BL_MOB)[1],
			player:getObjectsInCell(target.m, target.x, target.y + 2, BL_MOB)[1],
			player:getObjectsInCell(target.m, target.x + 1, target.y + 2, BL_MOB)[1],
			player:getObjectsInCell(target.m, target.x - 1, target.y + 2, BL_MOB)[1],
			player:getObjectsInCell(target.m, target.x - 2, target.y, BL_MOB)[1],
			player:getObjectsInCell(target.m, target.x - 2, target.y + 1, BL_MOB)[1],
			player:getObjectsInCell(target.m, target.x - 2, target.y - 1, BL_MOB)[1],
			player:getObjectsInCell(target.m, target.x + 2, target.y, BL_MOB)[1],
			player:getObjectsInCell(target.m, target.x + 2, target.y + 1, BL_MOB)[1],
			player:getObjectsInCell(target.m, target.x + 2, target.y - 1, BL_MOB)[1]
		}

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

		for i = 1, #mobBlocks do
			if (distanceSquare(target, mobBlocks[i], 1) and mobBlocks[i].ID ~= target.ID and mobBlocks.state ~= 1) then
				table.insert(targets, mobBlocks[i])
			end
		end

		for i = 1, #pcBlocks do
			if (distanceSquare(target, pcBlocks[i], 1) and pcBlocks[i].ID ~= target.ID and pcBlocks[i].state ~= 1) then
				table.insert(targets, pcBlocks[i])
			end
		end

		player:sendAction(6, 20)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:setAether("hailstorm_lv2", aether)
		player:playSound(sound)
		player:sendMinitext("You cast Hailstorm Lv2.")
		if player.registry["extra_spell_info"] == 1 then
			player:sendMinitext("Hailstorm Lv2 DMG: " .. damage)
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
				target:sendMinitext(player.name .. " chills you with Hailstorm Lv2.")
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
					targets[i]:sendMinitext(player.name .. " chills you with Hailstorm Lv2.")
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
		local level = 200
		local item = {0}
		local amounts = {500000}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Hailstorm Lv2 will drop a sheet of ice on an area!\n\nReplaces Hailstorm Lv1.", txt}
		return level, item, amounts, desc
	end
}
