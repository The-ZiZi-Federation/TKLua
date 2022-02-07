-------------------------------------------------------
--   Spell: Greater Cleave
--   Class: Dark Knight
--   Level: 110
--  Aether: 18 Seconds
--    Cost: (player.maxMagic * 0.25)
-- DmgType: Physical
--    Type: Offensive
-- Targets: 12
--			  X
--           XXX
--			XXPXX
--			 XXX
--			  X
-- Effects: N/A
-------------------------------------------------------
--    Desc: You heft your blade and spin a full 360
-- 			cleavng anyone in the way for heavy damage.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 08/12/2017
-------------------------------------------------------
greater_cleave_dk = {
	on_learn = function(player)
		player.registry["learned_greater_cleave_dk"] = 1
		player:removeSpell("whirlwind_attack")
		player:removeSpell("cleave")
		player:removeSpell("greater_cleave_dk")
	end,
	on_forget = function(player)
		player.registry["learned_greater_cleave_dk"] = 0
	end,
	cast = function(player)
		----------------------
		--Varable Declarations
		----------------------

		local magicCost = (player.maxMagic * 0.25)
		local aether = 18000
		local anim = 140
		local sound = 514
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
			player:setAether("greater_cleave_dk", aether)
			player:playSound(sound)
			player:sendMinitext("You cast Greater Cleave.")
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
						damage = ((0.15 * player.maxHealth) + (0.1 * player.level) + swingDamage(player, pcflankTargets[i], 2)) * 20
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
					damage = ((0.15 * player.maxHealth) + (0.1 * player.level) + swingDamage(player, mobflankTargets[i], 2)) * 20
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

		local desc = {"Greater Cleave is an incredibly powerful area attack.\nReplaces Great Cleave.", txt}
		return level, item, amounts, desc
	end
}
