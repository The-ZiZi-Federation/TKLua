-------------------------------------------------------
--   Spell: Great Cleave
--   Class: Crusader
--   Level: 110
--  Aether: 18 Seconds
--    Cost: (player.maxMagic * 0.35)
-- DmgType: Physical
--    Type: Offensive
-- Targets: 8
--          XXX
--			XPX
--			XXX
-- Effects: N/A
-------------------------------------------------------
--    Desc: You heft your blade and spin a full 360
-- 			cleavng anyone in the way for heavy damage.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 08/20/2017
-------------------------------------------------------
great_cleave_cru = {
	on_learn = function(player)
		player.registry["learned_great_cleave_cru"] = 1
		player:removeSpell("whirlwind_attack")
		player:removeSpell("cleave")
	end,
	on_forget = function(player)
		player.registry["learned_great_cleave_cru"] = 0
	end,
	cast = function(player)
		----------------------
		--Varable Declarations
		----------------------

		local magicCost = (player.maxMagic * 0.35)
		local aether = 18000
		local anim = 7
		local sound = 84
		local m = player.m
		local x = player.x
		local y = player.y

		local mobBlocks = player:getObjectsInArea(BL_MOB)
		local pcBlocks = player:getObjectsInArea(BL_PC)
		local targets = {}

		local threat
		local damage
		local damage2

		if player.blType == BL_PC then
			if (not player:canCast(1, 1, 0)) then
				return
			end

			if (player.magic < magicCost) then
				player:sendMinitext("Not enough mana.")
				return
			end

			player:sendAction(1, 20)
			player:setAether("great_cleave_cru", aether)
			player:playSound(sound)
			player:sendMinitext("You cast Great Cleave.")
			player.magic = player.magic - magicCost
			player:sendStatus()

			local pcflankTargets = {
				player:getObjectsInCell(player.m, player.x + 1, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x, player.y - 2, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x, player.y + 2, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 2, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 2, player.y, BL_PC)[1]
			}

			local mobflankTargets = {
				player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x, player.y - 2, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x, player.y + 2, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 2, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 2, player.y, BL_MOB)[1]
			}

			for i = 1, 12 do
				if (pcflankTargets[i] ~= nil) then
					if pcflankTargets[i].state ~= 1 and player:canPK(pcflankTargets[i]) then
						player.critChance = 1
						damage = ((0.15 * player.maxHealth) + (0.1 * player.level) + swingDamage(player, pcflankTargets[i], 2)) * 18
						pcflankTargets[i].attacker = player.ID
						pcflankTargets[i]:removeHealthExtend(damage, 1, 1, 0, 1, 1)
						pcflankTargets[i]:sendMinitext(player.name .. " cleaves you with a mighty blow.")
						pcflankTargets[i]:sendAnimation(anim)
					end
				end
			end

			for i = 1, 12 do
				if (mobflankTargets[i] ~= nil) then
					player.critChance = 1
					damage = ((0.15 * player.maxHealth) + (0.1 * player.level) + swingDamage(player, mobflankTargets[i], 2)) * 18
					mobflankTargets[i].attacker = player.ID
					threat = mobflankTargets[i]:removeHealthExtend(damage, 1, 1, 0, 1, 2)
					player:addThreat(mobflankTargets[i].ID, threat)
					mobflankTargets[i]:removeHealthExtend(damage, 1, 1, 0, 1, 1)
					mobflankTargets[i]:sendAnimation(anim)
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

		local desc = {"Great Cleave is a massive attack with long range.\nReplaces Cleave.", txt}
		return level, item, amounts, desc
	end
}
