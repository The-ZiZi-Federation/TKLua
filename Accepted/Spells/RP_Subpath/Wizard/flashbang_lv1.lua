-------------------------------------------------------
--   Spell: Flashbang Lv1
--   Class: Wizard
--   Level: 23
--  Aether: 8 Second
--    Cost: maxMagic * 0.15
-- DmgType: Magical:
--    Type: Offensive
-- Targets: 4
--            X
--          X P X
--            X
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
flashbang_lv1 = {
	on_learn = function(player)
		player.registry["learned_flashbang_lv1"] = 1

		player:removeSpell("flashbang_lv2")
		player:removeSpell("flashbang_lv3")
		player:removeSpell("flashbang_lv4")
	end,
	on_forget = function(player)
		player.registry["learned_flashbang_lv1"] = 0
	end,
	cast = function(player)
		----------------------
		--Varable Declarations
		----------------------
		local aether = 8000

		local magicCost = (player.maxMagic * 0.15)

		local pcTargets = {
			player:getObjectsInCell(player.m, player.x + 1, player.y, BL_PC)[1],
			player:getObjectsInCell(player.m, player.x - 1, player.y, BL_PC)[1],
			player:getObjectsInCell(player.m, player.x, player.y + 1, BL_PC)[1],
			player:getObjectsInCell(player.m, player.x, player.y - 1, BL_PC)[1]
		}

		local mobTargets = {
			player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)[1],
			player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)[1],
			player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)[1],
			player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)[1]
		}
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

		if player.level < 40 then
			manaMult = 0.4
			levelMult = 40
			willMult = 40
			graceMult = 40
		elseif player.level >= 40 then
			manaMult = 0.8
			levelMult = 80
			willMult = 80
			graceMult = 80
		end

		---------------------------
		--- Spell Damage Formula---

		local damage =
			(player.maxMagic * manaMult) + (player.level * levelMult) + (player.will * willMult) + (player.grace * graceMult)
		damage = math.floor(damage)
		---------------------------------
		-- Cast Checks ------------------
		---------------------------------
		if player.blType == BL_PC then
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
			player:setAether("flashbang_lv1", aether)
			player:playSound(84)
			player:sendMinitext("You cast Flashbang.")
		end
		----------------------------------
		-- Build the target list ---------
		----------------------------------
		-- Check for Mobs --
		for i = 1, 4 do
			--	Player(4):talk(0,""..mobTargets[i].name)
			table.insert(targets, mobTargets[i])
		end
		-- Check for Players --
		for i = 1, 4 do
			if (distanceSquare(player, pcTargets[i], 1) and pcTargets[i].ID ~= player.ID) then
				table.insert(targets, pcTargets[i])
			end
		end

		if player.blType == BL_PC then
			---------------------------------------------
			-- If there are targets, remove mana cost ---
			---------------------------------------------
			if (#targets > 0) then
				player.magic = player.magic - magicCost
				player:sendStatus()
				-------------------------------------
				-- Damage Application / MP Removal --
				-- Animation, Sound, Action ---------
				-------------------------------------
				---------------------
				-- Vs. Mob ----------
				---------------------
				for i = 1, #targets do
					if (targets[i] ~= nil and targets[i].blType == BL_MOB) then
						----------------------
						-- Vs. Player --------
						----------------------
						targets[i].attacker = player.ID
						threat = targets[i]:removeHealthExtend(damage, 1, 1, 0, 1, 2)
						player:addThreat(targets[i].ID, threat)
						targets[i]:sendAnimation(anim)
						player:sendMinitext("Flashbang Lv1 DMG: " .. damage)
						targets[i]:removeHealthExtend(damage, 1, 1, 0, 1, 1)
					elseif (targets[i] ~= nil and targets[i].blType == BL_PC and player:canPK(targets[i])) then
						targets[i].attacker = player.ID
						targets[i]:sendMinitext(player.name .. " charred you with Flashbang Lv1..")
						targets[i]:sendAnimation(anim)
						targets[i]:removeHealthExtend(damage, 1, 1, 0, 1, 1)
					end
				end
			end
		end
	end,
	requirements = function(player)
		local level = 23
		local item = {0, 6001}
		local amounts = {420, 1}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Flashbang Lv1 is a spell that hits all enemies around you!", txt}
		return level, item, amounts, desc
	end
}
