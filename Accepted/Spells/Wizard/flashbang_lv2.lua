-------------------------------------------------------
--   Spell: Flashbang Lv2
--   Class: Wizard
--   Level: 55
--  Aether: 8-9 Second
--    Cost: (player.maxMagic * 0.15)
-- DmgType: Magical
--    Type: Offensive
-- Targets: 4 - 8
--        X     X X X
--      X P X - X P X
--        X     X X X
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
flashbang_lv2 = {
	on_learn = function(player)
		player.registry["learned_flashbang_lv2"] = 1
		player:removeSpell("flashbang_lv1")
		player:removeSpell("flashbang_lv3")
		player:removeSpell("flashbang_lv4")
	end,
	on_forget = function(player)
		player.registry["learned_flashbang_lv2"] = 0
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

		local manaMult = 0
		local levelMult = 0
		local willMult = 0
		local graceMult = 0

		if player.level < 69 then
			aether = 8000
			manaMult = 2.5
			levelMult = 250
			willMult = 250
			graceMult = 250
			pcTargets = {
				player:getObjectsInCell(player.m, player.x + 1, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x, player.y - 1, BL_PC)[1]
			}

			mobTargets = {
				player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)[1]
			}
		elseif player.level >= 69 then
			aether = 9000
			manaMult = 4
			levelMult = 400
			willMult = 400
			graceMult = 400

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
		player:setAether("flashbang_lv2", aether)
		player:playSound(84)
		player:sendMinitext("You cast Flashbang Lv2.")
		player.magic = player.magic - magicCost
		player:sendStatus()

		for i = 1, 8 do
			if (mobTargets[i] ~= nil) then
				mobTargets[i].attacker = player.ID
				threat = mobTargets[i]:removeHealthExtend(damage, 1, 1, 0, 1, 2)
				player:addThreat(mobTargets[i].ID, threat)
				mobTargets[i]:sendAnimation(anim)
				player:sendMinitext("Flashbang Lv2 DMG: " .. damage)
				mobTargets[i]:removeHealthExtend(damage, 1, 1, 0, 1, 1)
			end
		end

		for i = 1, 8 do
			if (pcTargets[i] ~= nil) then
				if player:canPK(pcTargets[i]) then
					pcTargets[i].attacker = player.ID
					pcTargets[i]:sendMinitext(player.name .. " charred you with Flashbang Lv2..")
					pcTargets[i]:sendAnimation(anim)
					pcTargets[i]:removeHealthExtend(damage, 1, 1, 0, 1, 1)
				end
			end
		end
	end,
	requirements = function(player)
		local level = 55
		local item = {0, 294, 295}
		local amounts = {1250, 20, 1}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Flashbang Lv2 is a spell that hits all enemies around you!\n\nReplaces Flashbang Lv1", txt}
		return level, item, amounts, desc
	end
}
