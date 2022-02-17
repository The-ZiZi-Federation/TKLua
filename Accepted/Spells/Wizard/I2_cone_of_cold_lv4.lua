-------------------------------------------------------
--   Spell: Cone of Cold Lv4
--   Class: Wizard
--   Level: 200
--  Aether: 11 Second
--    Cost: player.maxMagic * 0.2
-- DmgType: Magical
--    Type: Offensive, DOT
--  Damage: (player.maxMagic * manaMult) + (player.level * levelMult) + (player.will * willMult) + (player.grace * graceMult)
-- Targets: 15
--
--			      X
--			    X X
--			  X X X
--			P X X X
--			  X X X
--			    X X
--			      X
--
--  Effect: Chance to slow for 7 Seconds on Hit.
-------------------------------------------------------
--    Desc: Ice and snow pour forth from your hands engulfing
--          all in your path!!!
-------------------------------------------------------
-- Script Author: John Crandell, John Day / Justin Chartier
--   Last Edited: 07/04/2017
---------------------------- ---------------------------
cone_of_cold_lv4 = {
	on_learn = function(player)
		player.registry["learned_cone_of_cold_lv4"] = 1

		player:removeSpell("cone_of_cold_lv1")
		player:removeSpell("cone_of_cold_lv2")
		player:removeSpell("cone_of_cold_lv3")
	end,
	on_forget = function(player)
		player.registry["learned_cone_of_cold_lv4"] = 0
	end,
	cast = function(player)
		----------------------
		--Varable Declarations
		----------------------

		local aether = 11000
		local magicCost = player.maxMagic * 0.2
		local slowDuration = 700

		local mobTargets = {}
		local pcTargets = {}
		local threat

		local m = player.m
		local x = player.x
		local y = player.y

		local anim = 187
		local sound = 42

		local manaMult = 12
		local levelMult = 1200
		local willMult = 1200
		local graceMult = 1200

		---------------------------
		--- Spell Damage Formula---
		---------------------------
		local damage =
			(player.maxMagic * manaMult) + (player.level * levelMult) + (player.will * willMult) + (player.grace * graceMult)
		damage = math.floor(damage)
		---------------------------------
		-- Cast Checks ------------------
		---------------------------------
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

		if (player.side == 0) then
			mobTargets = {
				player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x, player.y - 2, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x, player.y - 3, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y - 2, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y - 2, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y - 3, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 2, player.y - 3, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y - 3, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 2, player.y - 3, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 2, player.y - 2, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 2, player.y - 2, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 3, player.y - 3, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 3, player.y - 3, BL_MOB)[1]
			}

			pcTargets = {
				player:getObjectsInCell(player.m, player.x, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x, player.y - 2, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x, player.y - 3, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y - 2, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y - 2, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y - 3, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 2, player.y - 3, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y - 3, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 2, player.y - 3, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 2, player.y - 2, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 2, player.y - 2, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 3, player.y - 3, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 3, player.y - 3, BL_PC)[1]
			}
		elseif (player.side == 1) then
			mobTargets = {
				player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 2, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 3, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 2, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 2, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 3, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 3, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 3, player.y + 2, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 3, player.y - 2, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 2, player.y + 2, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 2, player.y - 2, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 3, player.y + 3, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 3, player.y - 3, BL_MOB)[1]
			}

			pcTargets = {
				player:getObjectsInCell(player.m, player.x + 1, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 2, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 3, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 2, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 2, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 3, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 3, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 3, player.y + 2, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 3, player.y - 2, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 2, player.y + 2, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 2, player.y - 2, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 3, player.y + 3, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 3, player.y - 3, BL_PC)[1]
			}
		elseif (player.side == 2) then
			mobTargets = {
				player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x, player.y + 2, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x, player.y + 3, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y + 2, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y + 2, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y + 3, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 2, player.y + 3, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y + 3, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 2, player.y + 3, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 2, player.y + 2, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 2, player.y + 2, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 3, player.y + 3, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 3, player.y + 3, BL_MOB)[1]
			}

			pcTargets = {
				player:getObjectsInCell(player.m, player.x, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x, player.y + 2, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x, player.y + 3, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y + 2, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y + 2, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y + 3, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 2, player.y + 3, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y + 3, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 2, player.y + 3, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 2, player.y + 2, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 2, player.y + 2, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 3, player.y + 3, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 3, player.y + 3, BL_PC)[1]
			}
		elseif (player.side == 3) then
			mobTargets = {
				player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 2, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 3, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 2, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 2, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 3, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 3, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 3, player.y + 2, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 3, player.y - 2, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 2, player.y + 2, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 2, player.y - 2, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 3, player.y + 3, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 3, player.y - 3, BL_MOB)[1]
			}

			pcTargets = {
				player:getObjectsInCell(player.m, player.x - 1, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 2, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 3, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 2, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 2, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 3, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 3, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 3, player.y + 2, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 3, player.y - 2, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 2, player.y + 2, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 2, player.y - 2, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 3, player.y + 3, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 3, player.y - 3, BL_PC)[1]
			}
		end

		if (player.side == 0) then
			player:sendAnimationXY(anim, player.x, player.y - 1)
			player:sendAnimationXY(anim, player.x, player.y - 2)
			player:sendAnimationXY(anim, player.x, player.y - 3)
			player:sendAnimationXY(anim, player.x + 1, player.y - 2)
			player:sendAnimationXY(anim, player.x - 1, player.y - 2)
			player:sendAnimationXY(anim, player.x + 1, player.y - 3)
			player:sendAnimationXY(anim, player.x + 2, player.y - 3)
			player:sendAnimationXY(anim, player.x - 1, player.y - 3)
			player:sendAnimationXY(anim, player.x - 2, player.y - 3)
			player:sendAnimationXY(anim, player.x + 1, player.y - 1)
			player:sendAnimationXY(anim, player.x - 1, player.y - 1)
			player:sendAnimationXY(anim, player.x + 2, player.y - 2)
			player:sendAnimationXY(anim, player.x - 2, player.y - 2)
			player:sendAnimationXY(anim, player.x + 3, player.y - 3)
			player:sendAnimationXY(anim, player.x - 3, player.y - 3)
		elseif (player.side == 1) then
			player:sendAnimationXY(anim, player.x + 1, player.y)
			player:sendAnimationXY(anim, player.x + 2, player.y)
			player:sendAnimationXY(anim, player.x + 3, player.y)
			player:sendAnimationXY(anim, player.x + 2, player.y + 1)
			player:sendAnimationXY(anim, player.x + 2, player.y - 1)
			player:sendAnimationXY(anim, player.x + 3, player.y + 1)
			player:sendAnimationXY(anim, player.x + 3, player.y - 1)
			player:sendAnimationXY(anim, player.x + 3, player.y + 2)
			player:sendAnimationXY(anim, player.x + 3, player.y - 2)
			player:sendAnimationXY(anim, player.x + 1, player.y + 1)
			player:sendAnimationXY(anim, player.x + 1, player.y - 1)
			player:sendAnimationXY(anim, player.x + 2, player.y + 2)
			player:sendAnimationXY(anim, player.x + 2, player.y - 2)
			player:sendAnimationXY(anim, player.x + 3, player.y + 3)
			player:sendAnimationXY(anim, player.x + 3, player.y - 3)
		elseif (player.side == 2) then
			player:sendAnimationXY(anim, player.x, player.y + 1)
			player:sendAnimationXY(anim, player.x, player.y + 2)
			player:sendAnimationXY(anim, player.x, player.y + 3)
			player:sendAnimationXY(anim, player.x + 1, player.y + 2)
			player:sendAnimationXY(anim, player.x - 1, player.y + 2)
			player:sendAnimationXY(anim, player.x + 1, player.y + 3)
			player:sendAnimationXY(anim, player.x + 2, player.y + 3)
			player:sendAnimationXY(anim, player.x - 1, player.y + 3)
			player:sendAnimationXY(anim, player.x - 2, player.y + 3)
			player:sendAnimationXY(anim, player.x + 1, player.y + 1)
			player:sendAnimationXY(anim, player.x - 1, player.y + 1)
			player:sendAnimationXY(anim, player.x + 2, player.y + 2)
			player:sendAnimationXY(anim, player.x - 2, player.y + 2)
			player:sendAnimationXY(anim, player.x + 3, player.y + 3)
			player:sendAnimationXY(anim, player.x - 3, player.y + 3)
		elseif (player.side == 3) then
			player:sendAnimationXY(anim, player.x - 1, player.y)
			player:sendAnimationXY(anim, player.x - 2, player.y)
			player:sendAnimationXY(anim, player.x - 3, player.y)
			player:sendAnimationXY(anim, player.x - 2, player.y + 1)
			player:sendAnimationXY(anim, player.x - 2, player.y - 1)
			player:sendAnimationXY(anim, player.x - 3, player.y + 1)
			player:sendAnimationXY(anim, player.x - 3, player.y - 1)
			player:sendAnimationXY(anim, player.x - 3, player.y + 2)
			player:sendAnimationXY(anim, player.x - 3, player.y - 2)
			player:sendAnimationXY(anim, player.x - 1, player.y + 1)
			player:sendAnimationXY(anim, player.x - 1, player.y - 1)
			player:sendAnimationXY(anim, player.x - 2, player.y + 2)
			player:sendAnimationXY(anim, player.x - 2, player.y - 2)
			player:sendAnimationXY(anim, player.x - 3, player.y + 3)
			player:sendAnimationXY(anim, player.x - 3, player.y - 3)
		end

		------------------------------------
		-- Pay Cost, Set Cooldown etc ------
		------------------------------------
		player.magic = player.magic - magicCost
		player:sendAction(6, 20)
		player:setAether("cone_of_cold_lv4", aether)
		player:sendMinitext("You cast Cone of Cold Lv4")
		if player.registry["extra_spell_info"] == 1 then
			player:sendMinitext("Cone of Cold Lv4 DMG: " .. damage)
		end
		player:playSound(sound)
		player:sendStatus()

		for i = 1, 15 do
			local r = math.random(1, 1000)
			if (mobTargets[i] ~= nil) then
				mobTargets[i].attacker = player.ID
				threat = mobTargets[i]:removeHealthExtend(damage, 1, 1, 0, 1, 2)
				player:addThreat(mobTargets[i].ID, threat)

				mobTargets[i]:sendAnimation(anim)
				mobTargets[i]:removeHealthExtend(damage, 1, 1, 0, 1, 1)

				if r <= 50 then
					if not mobTargets[i]:hasDuration("slow") then
						if checkResist(player, mobTargets[i], "slow") == 1 then
							return
						end
						mobTargets[i]:setDuration("slow", slowDuration)
					end
				end
			elseif (pcTargets[i] ~= nil) then
				if (player:canPK(pcTargets[i])) then
					pcTargets[i].attacker = player.ID
					pcTargets[i]:sendAnimation(anim)
					pcTargets[i]:removeHealthExtend(damage, 1, 1, 0, 1, 1)
					pcTargets[i]:sendMinitext(player.name .. " chills you with Cone of Cold Lv4")
					if r <= 50 then
						pcTargets[i]:setDuration("slow", slowDuration)
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

		local desc = {
			"Cone of Cold Lv4 will send a cone of ice in front of you, chilling your enemies!\n\nReplaces Cone of Cold Lv3",
			txt
		}
		return level, item, amounts, desc
	end
}
