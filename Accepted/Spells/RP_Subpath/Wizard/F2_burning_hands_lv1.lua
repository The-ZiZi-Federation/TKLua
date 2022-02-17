-------------------------------------------------------
--   Spell: Burning Hands Lv1
--   Class: Wizard
--   Level: 35
--  Aether: 7 Second
--    Cost: player.maxMagic * 0.2
-- DmgType: Magical
--    Type: Offensive, DOT
--  Damage: (player.maxMagic * manaMult) + (player.level * levelMult) + (player.will * willMult) + (player.grace * graceMult)
-- Targets: 4
--
--              X
--          P X X
--              X
--
--  Effect: Chance to Sear for 4 Seconds on Hit.
-------------------------------------------------------
--    Desc: Flames pour forth from your hands engulfing
--          all in your path!!!
-------------------------------------------------------
-- Script Author: John Crandell, John Day / Justin Chartier
--   Last Edited: 07/04/2017
---------------------------- ---------------------------
burning_hands_lv1 = {
	on_learn = function(player)
		player.registry["learned_burning_hands_lv1"] = 1
		player:removeSpell("burning_hands_lv2")
		player:removeSpell("burning_hands_lv3")
		player:removeSpell("burning_hands_lv4")
	end,
	on_forget = function(player)
		player.registry["learned_burning_hands_lv1"] = 0
	end,
	cast = function(player)
		----------------------
		--Varable Declarations
		----------------------

		local aether = 7000
		local magicCost = player.maxMagic * 0.2
		local searDuration = 4000

		local mobTargets = {}
		local pcTargets = {}
		local threat

		local m = player.m
		local x = player.x
		local y = player.y

		local anim = 188
		local sound = 52

		local manaMult = 0
		local levelMult = 0
		local willMult = 0
		local graceMult = 0

		if player.level < 40 then
			manaMult = 0.5
			levelMult = 50
			willMult = 50
			graceMult = 50
		elseif player.level >= 40 then
			manaMult = 1.3
			levelMult = 130
			willMult = 130
			graceMult = 130
		end

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

		if player.side == 0 then
			mobTargets = {
				player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x, player.y - 2, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y - 2, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y - 2, BL_MOB)[1]
			}

			pcTargets = {
				player:getObjectsInCell(player.m, player.x, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x, player.y - 2, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y - 2, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y - 2, BL_PC)[1]
			}
		elseif (player.side == 1) then
			mobTargets = {
				player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 2, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 2, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 2, player.y - 1, BL_MOB)[1]
			}

			pcTargets = {
				player:getObjectsInCell(player.m, player.x + 1, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 2, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 2, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 2, player.y - 1, BL_PC)[1]
			}
		elseif (player.side == 2) then
			mobTargets = {
				player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x, player.y + 2, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y + 2, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y + 2, BL_MOB)[1]
			}

			pcTargets = {
				player:getObjectsInCell(player.m, player.x, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x, player.y + 2, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y + 2, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y + 2, BL_PC)[1]
			}
		elseif (player.side == 3) then
			mobTargets = {
				player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 2, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 2, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 2, player.y - 1, BL_MOB)[1]
			}

			pcTargets = {
				player:getObjectsInCell(player.m, player.x - 1, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 2, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 2, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 2, player.y - 1, BL_PC)[1]
			}
		end

		if (player.side == 0) then
			player:sendAnimationXY(anim, player.x, player.y - 1)
			player:sendAnimationXY(anim, player.x, player.y - 2)
			player:sendAnimationXY(anim, player.x + 1, player.y - 2)
			player:sendAnimationXY(anim, player.x - 1, player.y - 2)
		elseif (player.side == 1) then
			player:sendAnimationXY(anim, player.x + 1, player.y)
			player:sendAnimationXY(anim, player.x + 2, player.y)
			player:sendAnimationXY(anim, player.x + 2, player.y + 1)
			player:sendAnimationXY(anim, player.x + 2, player.y - 1)
		elseif (player.side == 2) then
			player:sendAnimationXY(anim, player.x, player.y + 1)
			player:sendAnimationXY(anim, player.x, player.y + 2)
			player:sendAnimationXY(anim, player.x + 1, player.y + 2)
			player:sendAnimationXY(anim, player.x - 1, player.y + 2)
		elseif (player.side == 3) then
			player:sendAnimationXY(anim, player.x - 1, player.y)
			player:sendAnimationXY(anim, player.x - 2, player.y)
			player:sendAnimationXY(anim, player.x - 2, player.y + 1)
			player:sendAnimationXY(anim, player.x - 2, player.y - 1)
		end

		------------------------------------
		-- Pay Cost, Set Cooldown etc ------
		------------------------------------
		player.magic = player.magic - magicCost
		player:sendAction(6, 20)
		player:setAether("burning_hands_lv1", aether)
		player:sendMinitext("You cast Burning Hands Lv1")
		if player.registry["extra_spell_info"] == 1 then
			player:sendMinitext("Burning Hands Lv1 DMG: " .. damage)
		end
		player:playSound(sound)
		player:sendStatus()

		for i = 1, 4 do
			local r = math.random(1, 1000)
			if (mobTargets[i] ~= nil) then
				mobTargets[i].attacker = player.ID
				threat = mobTargets[i]:removeHealthExtend(damage, 1, 1, 0, 1, 2)
				player:addThreat(mobTargets[i].ID, threat)

				mobTargets[i]:sendAnimation(anim)
				mobTargets[i]:removeHealthExtend(damage, 1, 1, 0, 1, 1)

				if r <= 50 then
					if not mobTargets[i]:hasDuration("seared") then
						if checkResist(player, mobTargets[i], "seared") == 1 then
							return
						end
						mobTargets[i]:setDuration("seared", searDuration)
					end
				end
			elseif (pcTargets[i] ~= nil) then
				if (player:canPK(pcTargets[i])) then
					pcTargets[i].attacker = player.ID
					pcTargets[i]:sendAnimation(anim)
					pcTargets[i]:removeHealthExtend(damage, 1, 1, 0, 1, 1)
					pcTargets[i]:sendMinitext(player.name .. " burns you with Burning Hands Lv1")
					if r <= 50 then
						pcTargets[i]:setDuration("seared", searDuration)
					end
				end
			end
		end
	end,
	requirements = function(player)
		local level = 35
		local item = {0, 6032, 6030, 6031}
		local amounts = {5500, 3, 1, 2}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Burning Hands Lv1 will send a cone of fire infront of you burning your enemies alive!", txt}
		return level, item, amounts, desc
	end
}
