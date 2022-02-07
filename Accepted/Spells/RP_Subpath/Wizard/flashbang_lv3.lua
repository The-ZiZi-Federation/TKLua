-------------------------------------------------------
--   Spell: Flashbang Lv3
--   Class: Wizard
--   Level: 92
--  Aether: 8 Second
--    Cost: 20 MP per Level
-- DmgType: Magical:
--    Type: Offensive
-- Targets: 8 - 12
--                 X
--     X X X     X X X
--     X P X - X X P X X
--     X X X     X X X
--                 X
-- Effects: N/A
-------------------------------------------------------
--    Desc:
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 07/07/2017
--
--       History:
--					Date:			Action:
--					12/03/2016		QC / Review Damage Formula
--									Reformat script to standard based on "Flare"
--
--					07/07/2017		Redid the whole damn thing again
-------------------------------------------------------
flashbang_lv3 = {
	on_learn = function(player)
		player.registry["learned_flashbang_lv3"] = 1
		player:removeSpell("flashbang_lv1")
		player:removeSpell("flashbang_lv2")
		player:removeSpell("flashbang_lv4")
	end,
	on_forget = function(player)
		player.registry["learned_flashbang_lv3"] = 0
	end,
	cast = function(player)
		----------------------
		--Varable Declarations
		----------------------
		local aether
		local magicCost = (player.maxMagic * 0.15)

		local pcTargets = {}
		local mobTargets = {}
		local targets = {}
		local threat

		local m = player.m
		local x = player.x
		local y = player.y

		local anim = 105
		local sound = 1

		local manaMult = 7.5
		local levelMult = 750
		local willMult = 750
		local graceMult = 750

		if player.level < 150 then
			aether = 9000
			pcTargets = {
				player:getObjectsInCell(player.m, player.x + 1, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_PC)[1]
			}

			mobTargets = {
				player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_MOB)[1]
			}
		elseif player.level >= 150 then
			aether = 10000
			pcTargets = {
				player:getObjectsInCell(player.m, player.x + 1, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 2, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 2, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x, player.y + 2, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x, player.y - 2, BL_PC)[1]
			}

			mobTargets = {
				player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 2, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 2, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x, player.y + 2, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x, player.y - 2, BL_MOB)[1]
			}
		end

		---------------------------
		--- Spell Damage Formula---

		local damage =
			(player.maxMagic * manaMult) + (player.level * levelMult) + (player.will * willMult) + (player.grace * graceMult)
		damage = math.floor(damage)
		---------------------------------
		-- Cast Checks ------------------
		---------------------------------
		------------------------
		-- Player can cast ? ---
		------------------------
		if (not player:canCast(1, 1, 0)) then
			return
		end
		------------------------
		-- Enough MP ? ---
		------------------------
		if (player.magic < magicCost) then
			player:sendMinitext("Not enough mana.")
			return
		end

		player:sendAction(1, 20)
		player:setAether("flashbang_lv3", aether)
		player:playSound(84)
		player:sendMinitext("You cast Flashbang Lv3.")
		player.magic = player.magic - magicCost
		player:sendStatus()

		for i = 1, 12 do
			if (mobTargets[i] ~= nil) then
				mobTargets[i].attacker = player.ID
				threat = mobTargets[i]:removeHealthExtend(damage, 1, 1, 0, 1, 2)
				player:addThreat(mobTargets[i].ID, threat)
				mobTargets[i]:sendAnimation(anim)
				player:sendMinitext("Flashbang Lv3 DMG: " .. damage)
				mobTargets[i]:removeHealthExtend(damage, 1, 1, 0, 1, 1)
			end
		end

		for i = 1, 12 do
			if (pcTargets[i] ~= nil) then
				if player:canPK(pcTargets[i]) then
					pcTargets[i].attacker = player.ID
					pcTargets[i]:sendMinitext(player.name .. " charred you with Flashbang Lv3..")
					pcTargets[i]:sendAnimation(anim)
					pcTargets[i]:removeHealthExtend(damage, 1, 1, 0, 1, 1)
				end
			end
		end
	end,
	requirements = function(player)
		local level = 92
		local item = {0, 294, 295}
		local amounts = {7500, 50, 2}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Flashbang Lv3 is a spell that hits all enemies around you!\n\nReplaces Flashbang Lv2", txt}
		return level, item, amounts, desc
	end
}
