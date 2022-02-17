-------------------------------------------------------
--   Spell: Wide Slash
--   Class: Fighter
--   Level: 26
--  Aether: 9 Second
--  MagicCost: (player.maxMagic / 15)
-- DmgType: Physical
--    Type: Offensive
-- Targets: 3
--          X X X
--          . P .
--          . . .
-- Effects: N/A
-------------------------------------------------------
--    Desc: A heavy strike against three foes.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 07/07/2017
-------------------------------------------------------

wide_slash = {
	on_learn = function(player)
		player.registry["learned_wide_slash"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_wide_slash"] = 0
	end,
	cast = function(player)
		----------------------
		--Varable Declarations
		----------------------

		local mobTarget = getTargetFacing(player, BL_MOB)
		local pcTarget = getTargetFacing(player, BL_PC)

		local m = player.m
		local x = player.x
		local y = player.y

		local threat

		local aether = 9000
		local magicCost = (player.level * 30)

		local anim = 60
		local sound = 14
		---------------------------
		--- Spell Damage Formula---
		---------------------------
		local damage
		-------------------------------------------------------
		if (not player:canCast(1, 1, 0)) then
			return
		end
		-------------------------------------------------------
		if player.magic < magicCost or player.magic - magicCost <= 0 then
			player:sendAnimation(246)
			player:sendMinitext("Not Enough MP.")
			return
		end
		-------------------------------------------------------
		if (player.side == 0) then
			mobTargets = {
				player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_MOB)[1]
			}
			pcTargets = {
				player:getObjectsInCell(player.m, player.x, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_PC)[1]
			}
		elseif (player.side == 1) then
			mobTargets = {
				player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_MOB)[1]
			}
			pcTargets = {
				player:getObjectsInCell(player.m, player.x + 1, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_PC)[1]
			}
		elseif (player.side == 2) then
			mobTargets = {
				player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_MOB)[1]
			}
			pcTargets = {
				player:getObjectsInCell(player.m, player.x, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_PC)[1]
			}
		elseif (player.side == 3) then
			mobTargets = {
				player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_MOB)[1]
			}
			pcTargets = {
				player:getObjectsInCell(player.m, player.x - 1, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_PC)[1]
			}
		end
		-----------------------------------
		-- One off actions for technique --
		-- Target is Mob ------------------
		-----------------------------------
		if #mobTargets > 0 then
			------------------------
			-- Target is Player ----
			------------------------
			-- Action, Animation, Text, Sound ---
			player:sendAction(1, 20)
			player:talk(2, "~UAGH!!!~")
			if player.gmLevel < 1 then
				player:sendMinitext("You cut a large swath in front you!")
			end
			player:setAether("wide_slash", aether)
			player:playSound(sound)
			-- Pay MP Cost ----
			player.magic = player.magic - magicCost
			player:sendStatus()
		elseif #pcTargets > 0 then
			-- Action, Animation, Text, Sound ---
			player:sendAction(1, 20)
			player:talk(2, "~UAGH!!!~")
			player:sendMinitext("You cut a large swath in front you!")
			player:setAether("wide_slash", aether)
			player:playSound(sound)
			-- Pay MP Cost ----
			player.magic = player.magic - magicCost
			player:sendStatus()
		end
		-----------------------------
		-- Actions for each target --
		-- Target is Mob ------------
		-----------------------------
		for i = 1, 3 do
			if (mobTargets[i] ~= nil) then
				----------------------
				-- Target is Player --
				----------------------
				player.critChance = 1
				damage = ((0.025 * player.health) + (0.1 * player.level) + swingDamage(player, mobTargets[i], 2)) * 7
				mobTargets[i].attacker = player.ID
				-- Animation on Enemy --
				mobTargets[i]:sendAnimation(anim, 0)
				-- Agro -----------
				threat = mobTargets[i]:removeHealthExtend(damage, 1, 1, 0, 1, 2)
				player:addThreat(mobTargets[i].ID, threat)
				-- Apply Damage ---
				if player.registry["extra_spell_info"] > 0 then
					player:sendMinitext("Wide Slash DMG: " .. damage)
				end
				mobTargets[i]:removeHealthExtend(damage, 1, 1, 0, 1, 1)
			elseif (pcTargets[i] ~= nil) then
				if (player:canPK(pcTargets[i])) then
					player.critChance = 1
					damage = ((0.025 * player.health) + (0.1 * player.level) + swingDamage(player, pcTargets[i], 2)) * 4.2
					pcTargets[i].attacker = player.ID
					-- Animation on Enemy --
					pcTargets[i]:sendAnimation(anim, 0)
					-- Apply Damage ---
					pcTargets[i]:removeHealthExtend(damage, 1, 1, 0, 1, 1)
					pcTargets[i]:sendMinitext(player.name .. " strikes you with a Wide Slash")
				end
			else
			end
		end
	end,
	requirements = function(player)
		local level = 26
		local item = {0, 50, 3018}
		local amounts = {500, 30, 5}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"A wide attack that strikes 3 foes in front of you.", txt}
		return level, item, amounts, desc
	end
}
