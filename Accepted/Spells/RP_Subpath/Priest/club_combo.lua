-------------------------------------------------------
--   Spell: Club Combo
--   Class: Priest
--   Level: 35
--  Aether: 14 Second
-- Targets: 1
-------------------------------------------------------
--   Desc.: A heavy strike against a single foe.
--          Damage based more on Might than Will
-------------------------------------------------------
-- Script Author: John Day / John Crandell
--   Last Edited: 07/07/2017
-------------------------------------------------------

club_combo = {
	on_learn = function(player)
		player.registry["learned_club_combo"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_club_combo"] = 0
	end,
	cast = function(player)
		------------------------
		--Varable Declarations--
		------------------------
		local magicCost = (player.level * 30) + (player.maxMagic / 10)
		local damage = 0
		local aether = 14000
		local sound = 87

		local mobTargets = getTargetFacing(player, BL_MOB)
		local pcTargets = getTargetFacing(player, BL_PC)

		local m = player.m
		local x = player.x
		local y = player.y

		local threat

		----------------------------
		-- Check if Castable--------
		----------------------------
		local counter = false
		player.critChance = 1
		if (not player:canCast(1, 1, 0)) then
			return
		end
		----------------------------
		-- Check if MP available----
		----------------------------
		if (player.magic < magicCost) then
			player:sendMinitext("Not enough mana.")
			return
		end

		----------------------------------------------
		-- Check the direction the player is facing --
		----------------------------------------------
		if player.side == 0 then
			pcTargets = {
				player:getObjectsInCell(player.m, player.x + 1, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x, player.y - 1, BL_PC)[1]
			}

			mobTargets = {
				player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)[1]
			}
		elseif player.side == 1 then
			pcTargets = {
				player:getObjectsInCell(player.m, player.x, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y, BL_PC)[1]
			}

			mobTargets = {
				player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)[1]
			}
		elseif player.side == 2 then
			pcTargets = {
				player:getObjectsInCell(player.m, player.x + 1, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x, player.y + 1, BL_PC)[1]
			}

			mobTargets = {
				player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)[1]
			}
		elseif player.side == 3 then
			pcTargets = {
				player:getObjectsInCell(player.m, player.x, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y, BL_PC)[1]
			}

			mobTargets = {
				player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)[1]
			}
		end

		player.magic = player.magic - magicCost -- Apply Mana Cost
		-------------------------------------
		-- Action, Animation, Text, Sound ---
		-------------------------------------
		player:sendAction(1, 20) -- Swing action, 20 seconds long
		player:sendMinitext("You use Club Combo")
		player:playSound(sound)

		player:setAether("club_combo", aether)
		player:sendStatus()
		----------------------------
		-- Apply Damage ------------
		----------------------------
		for i = 1, 5 do -- Loop to apply actions to all enemies.
			-- Target is an enemy
			if (mobTargets[i] ~= nil) then
				-- Target is a player
				player.critChance = 1
				damage = ((0.03 * player.maxHealth) + (0.1 * player.level) + swingDamage(player, mobTargets[i], 2)) * 10
				mobTargets[i].attacker = player.ID -- Set attacker ID
				-------------------
				-- Agro -----------
				-------------------
				threat = mobTargets[i]:removeHealthExtend(damage, 1, 1, 0, 1, 2) -- Derive agro from damage
				player:addThreat(mobTargets[i].ID, threat) -- Apply agro

				mobTargets[i]:sendAnimation(396, 0) -- Play animation on Enemy
				----------------------------------------------------
				-- Damage application ------------------------------
				----------------------------------------------------
				mobTargets[i]:removeHealthExtend(damage, 1, 1, 0, 1, 1)
			elseif (pcTargets[i] ~= nil) then
				pcTargets[i]:sendAnimation(396, 0)
				-- Player has PK turned on
				if (player:canPK(pcTargets[i])) then
					player.critChance = 1
					damage = ((0.03 * player.maxHealth) + (0.1 * player.level) + swingDamage(player, pcTargets[i], 2)) * 10
					pcTargets[i].attacker = player.ID
					pcTargets[i]:removeHealthExtend(damage, 1, 1, 0, 1, 1)
					pcTargets[i]:sendMinitext(player.name .. " is raining blows upon you")
				end
			end
		end
	end,
	requirements = function(player)
		local level = 46
		local item = {0, 6032}
		local amounts = {850, 1}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Club Combo is a spell that strikes three foes at once!", txt}
		return level, item, amounts, desc
	end
}
