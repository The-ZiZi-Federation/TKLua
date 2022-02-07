-------------------------------------------------------
--   Spell: Flashbang Lv4
--   Class: Wizard
--   Level: 200
--  Aether: 10 Second
--    Cost: 20 MP per Level
-- DmgType: Magical:
--    Type: Offensive
-- Targets: 12
--           X
--         X X X
--       X X P X X
--         X X X
--           X
-- Effects: N/A
-------------------------------------------------------
--    Desc:
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 07/03/2017
--
--       History:
--					Date:			Action:
--					12/03/2016		QC / Review Damage Formula
--									Reformat script to standard based on "Flare"
--
--					07/03/2017		Redid the whole damn thing again
-------------------------------------------------------
flashbang_lv4 = {
	on_learn = function(player)
		player.registry["learned_flashbang_lv4"] = 1

		player:removeSpell("flashbang_lv1")
		player:removeSpell("flashbang_lv2")
		player:removeSpell("flashbang_lv3")
	end,
	on_forget = function(player)
		player.registry["learned_flashbang_lv4"] = 0
	end,
	cast = function(player)
		----------------------
		--Varable Declarations
		----------------------
		local aether = 10000
		local magicCost = (player.maxMagic * 0.15)

		local pcTargets = {
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

		local mobTargets = {
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
		local targets = {}
		local threat

		local m = player.m
		local x = player.x
		local y = player.y

		local anim = 105
		local sound = 1

		local manaMult = 12.5
		local levelMult = 1250
		local willMult = 1250
		local graceMult = 1250
		---------------------------
		--- Spell Damage Formula---

		local damage =
			(player.maxMagic * manaMult) + (player.level * levelMult) + (player.will * willMult) + (player.grace * graceMult)
		damage = math.floor(damage)

		if (not player:canCast(1, 1, 0)) then
			return
		end

		if (player.magic < magicCost) then
			player:sendMinitext("Not enough mana.")
			return
		end

		player:sendAction(1, 20)
		player:setAether("flashbang_lv4", aether)
		player:playSound(84)
		player:sendMinitext("You cast Flashbang Lv4.")
		player.magic = player.magic - magicCost
		player:sendStatus()

		for i = 1, 12 do
			if (mobTargets[i] ~= nil) then
				mobTargets[i].attacker = player.ID
				threat = mobTargets[i]:removeHealthExtend(damage, 1, 1, 0, 1, 2)
				player:addThreat(mobTargets[i].ID, threat)
				mobTargets[i]:sendAnimation(anim)
				player:sendMinitext("Flashbang Lv4 DMG: " .. damage)
				mobTargets[i]:removeHealthExtend(damage, 1, 1, 0, 1, 1)
			end
		end

		for i = 1, 12 do
			if (pcTargets[i] ~= nil) then
				pcTargets[i].attacker = player.ID
				pcTargets[i]:sendMinitext(player.name .. " charred you with Flashbang Lv4..")
				pcTargets[i]:sendAnimation(anim)
				pcTargets[i]:removeHealthExtend(damage, 1, 1, 0, 1, 1)
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

		local desc = {"Flashbang Lv4 is a spell that hits all enemies around you!\n\nReplaces Flashbang Lv3", txt}
		return level, item, amounts, desc
	end
}
