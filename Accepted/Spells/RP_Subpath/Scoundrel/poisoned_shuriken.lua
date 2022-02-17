-------------------------------------------------------
--   Spell: Poisoned Shuriken
--   Class: Scoundrel
--   Level: 74
--  Aether: 17 Second
--    Cost: (player.level * 10) + (player.maxMagic / 25)
-- DmgType: Physical
--    Type: Offensive
-- Targets: 1 - 9
-- Effects:  stun 5 sec
-------------------------------------------------------
--    Desc:
--
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 07/07/2017
-------------------------------------------------------
poisoned_shuriken = {
	on_learn = function(player)
		player.registry["learned_poisoned_shuriken"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_poisoned_shuriken"] = 0
	end,
	cast = function(player)
		----------------------
		--Varable Declarations
		----------------------
		local magicCost = (player.level * 10) + (player.maxMagic / 40)
		local stunDuration = 5000
		local stunDurationPK = 3000
		local bleedDuration = 5000
		local aether = 17000

		if (not player:canCast(1, 1, 0)) then
			return
		end

		if (player.magic < magicCost) then
			player:sendMinitext("Not enough mana.")
			return
		end

		local threat

		local mobTargets
		local pcTargets

		local m = player.m
		local x = player.x
		local y = player.y

		local anim = 122
		local sound = 332
		---------------------------
		--- Spell Damage Formula---
		---------------------------
		local damage

		----get targets---------------------------------------------------------

		mobTargets, pcTargets = poisoned_shuriken.getTargets(player)

		player:sendAction(1, 20)
		player:setAether("poisoned_shuriken", aether)
		player:sendMinitext("You use Poisoned Shuriken")
		player:playSound(sound)
		player.magic = player.magic - magicCost
		player:sendStatus()
		poisoned_shuriken.animation(player)
		for i = 1, 22 do
			if (mobTargets[i] ~= nil) then
				player.critChance = 1
				damage =
					math.floor(((0.025 * player.maxHealth) + (0.1 * player.level) + swingDamage(player, mobTargets[i], 2)) * 3.5)
				mobTargets[i].attacker = player.ID
				threat = mobTargets[i]:removeHealthExtend(damage, 1, 1, 0, 1, 2)
				player:addThreat(mobTargets[i].ID, threat)
				--mobTargets[i]:sendAnimation(anim, 0)
				mobTargets[i]:removeHealthExtend(damage, 1, 1, 0, 1, 1)
				if player.gmLevel > 0 then
					player:sendMinitext("Poisoned Shuriken DMG: " .. damage)
				end
				if not mobTargets[i]:hasDuration("stun") then
					if checkResist(player, mobTargets[i], "stun") == 0 then
						mobTargets[i]:setDuration("stun", stunDuration)
					end
				end
				if not mobTargets[i]:hasDuration("bleed") then
					mobTargets[i]:setDuration("bleed", bleedDuration)
				end
			elseif (pcTargets[i] ~= nil) then
				if (player:canPK(pcTargets[i])) then
					player.critChance = 1
					damage =
						math.floor(((0.025 * player.maxHealth) + (0.1 * player.level) + swingDamage(player, pcTargets[i], 2)) * 3.5)
					pcTargets[i].attacker = player.ID
					--pcTargets[i]:sendAnimation(anim, 0)
					pcTargets[i]:removeHealthExtend(damage, 1, 1, 0, 1, 1)
					pcTargets[i]:sendMinitext(player.name .. " strikes you with Poisoned Shuriken")
					if not pcTargets[i]:hasDuration("stun") then
						pcTargets[i]:setDuration("stun", stunDurationPK)
					end

					if not pcTargets[i]:hasDuration("bleed") then
						pcTargets[i]:setDuration("bleed", bleedDuration)
					end
				end
			end
		end
	end,
	animation = function(player)
		local x, y = player.x, player.y
		local s = player.side
		local anim = 122

		if player.level >= 100 then
			if s == 0 then
				player:sendAnimationXY(anim, x, y - 1)
				player:sendAnimationXY(anim, x + 1, y - 1)
				player:sendAnimationXY(anim, x - 1, y - 1)

				player:sendAnimationXY(anim, x, y - 2)
				player:sendAnimationXY(anim, x + 1, y - 2)
				player:sendAnimationXY(anim, x - 1, y - 2)
				player:sendAnimationXY(anim, x + 2, y - 2)
				player:sendAnimationXY(anim, x - 2, y - 2)

				player:sendAnimationXY(anim, x, y - 3)
				player:sendAnimationXY(anim, x + 1, y - 3)
				player:sendAnimationXY(anim, x - 1, y - 3)
				player:sendAnimationXY(anim, x + 2, y - 3)
				player:sendAnimationXY(anim, x - 2, y - 3)
				player:sendAnimationXY(anim, x + 3, y - 3)
				player:sendAnimationXY(anim, x - 3, y - 3)

				--player:sendAnimationXY(anim, x + 4, y - 4)
				--player:sendAnimationXY(anim, x - 4, y - 4)
				player:sendAnimationXY(anim, x, y - 4)
				player:sendAnimationXY(anim, x + 1, y - 4)
				player:sendAnimationXY(anim, x - 1, y - 4)
				player:sendAnimationXY(anim, x + 2, y - 4)
				player:sendAnimationXY(anim, x - 2, y - 4)
				player:sendAnimationXY(anim, x + 3, y - 4)
				player:sendAnimationXY(anim, x - 3, y - 4)
			elseif s == 1 then
				--player:sendAnimationXY(anim, x + 4, y + 4)
				--player:sendAnimationXY(anim, x + 4, y - 4)
				player:sendAnimationXY(anim, x + 1, y)
				player:sendAnimationXY(anim, x + 2, y)
				player:sendAnimationXY(anim, x + 3, y)
				player:sendAnimationXY(anim, x + 4, y)

				player:sendAnimationXY(anim, x + 1, y + 1)
				player:sendAnimationXY(anim, x + 1, y - 1)

				player:sendAnimationXY(anim, x + 2, y + 1)
				player:sendAnimationXY(anim, x + 2, y - 1)
				player:sendAnimationXY(anim, x + 2, y + 2)
				player:sendAnimationXY(anim, x + 2, y - 2)

				player:sendAnimationXY(anim, x + 3, y + 1)
				player:sendAnimationXY(anim, x + 3, y - 1)
				player:sendAnimationXY(anim, x + 3, y + 2)
				player:sendAnimationXY(anim, x + 3, y - 2)
				player:sendAnimationXY(anim, x + 3, y + 3)
				player:sendAnimationXY(anim, x + 3, y - 3)

				player:sendAnimationXY(anim, x + 4, y + 1)
				player:sendAnimationXY(anim, x + 4, y - 1)
				player:sendAnimationXY(anim, x + 4, y + 2)
				player:sendAnimationXY(anim, x + 4, y - 2)
				player:sendAnimationXY(anim, x + 4, y + 3)
				player:sendAnimationXY(anim, x + 4, y - 3)
			elseif s == 2 then
				player:sendAnimationXY(anim, x, y + 1)
				player:sendAnimationXY(anim, x + 1, y + 1)
				player:sendAnimationXY(anim, x - 1, y + 1)

				player:sendAnimationXY(anim, x, y + 2)
				player:sendAnimationXY(anim, x + 1, y + 2)
				player:sendAnimationXY(anim, x - 1, y + 2)
				player:sendAnimationXY(anim, x + 2, y + 2)
				player:sendAnimationXY(anim, x - 2, y + 2)

				player:sendAnimationXY(anim, x, y + 3)
				player:sendAnimationXY(anim, x + 1, y + 3)
				player:sendAnimationXY(anim, x - 1, y + 3)
				player:sendAnimationXY(anim, x + 2, y + 3)
				player:sendAnimationXY(anim, x - 2, y + 3)
				player:sendAnimationXY(anim, x + 3, y + 3)
				player:sendAnimationXY(anim, x - 3, y + 3)

				--player:sendAnimationXY(anim, x + 4, y + 4)
				--player:sendAnimationXY(anim, x - 4, y + 4)
				player:sendAnimationXY(anim, x, y + 4)
				player:sendAnimationXY(anim, x + 1, y + 4)
				player:sendAnimationXY(anim, x - 1, y + 4)
				player:sendAnimationXY(anim, x + 2, y + 4)
				player:sendAnimationXY(anim, x - 2, y + 4)
				player:sendAnimationXY(anim, x + 3, y + 4)
				player:sendAnimationXY(anim, x - 3, y + 4)
			elseif s == 3 then
				player:sendAnimationXY(anim, x - 1, y)
				player:sendAnimationXY(anim, x - 2, y)
				player:sendAnimationXY(anim, x - 3, y)
				player:sendAnimationXY(anim, x - 4, y)

				player:sendAnimationXY(anim, x - 1, y + 1)
				player:sendAnimationXY(anim, x - 1, y - 1)

				player:sendAnimationXY(anim, x - 2, y + 1)
				player:sendAnimationXY(anim, x - 2, y - 1)
				player:sendAnimationXY(anim, x - 2, y + 2)
				player:sendAnimationXY(anim, x - 2, y - 2)

				player:sendAnimationXY(anim, x - 3, y + 1)
				player:sendAnimationXY(anim, x - 3, y - 1)
				player:sendAnimationXY(anim, x - 3, y + 2)
				player:sendAnimationXY(anim, x - 3, y - 2)
				player:sendAnimationXY(anim, x - 3, y + 3)
				player:sendAnimationXY(anim, x - 3, y - 3)

				player:sendAnimationXY(anim, x - 4, y + 1)
				player:sendAnimationXY(anim, x - 4, y - 1)
				player:sendAnimationXY(anim, x - 4, y + 2)
				player:sendAnimationXY(anim, x - 4, y - 2)
				player:sendAnimationXY(anim, x - 4, y + 3)
				player:sendAnimationXY(anim, x - 4, y - 3)
			--player:sendAnimationXY(anim, x - 4, y + 4)
			--player:sendAnimationXY(anim, x - 4, y - 4)
			end
		elseif player.level <= 99 then
			if s == 0 then
				player:sendAnimationXY(anim, x, y - 1)
				player:sendAnimationXY(anim, x, y - 2)
				player:sendAnimationXY(anim, x + 1, y - 2)
				player:sendAnimationXY(anim, x - 1, y - 2)
				player:sendAnimationXY(anim, x, y - 3)
				player:sendAnimationXY(anim, x + 1, y - 3)
				player:sendAnimationXY(anim, x - 1, y - 3)
				player:sendAnimationXY(anim, x + 2, y - 3)
				player:sendAnimationXY(anim, x - 2, y - 3)
			elseif s == 1 then
				player:sendAnimationXY(anim, x + 1, y)
				player:sendAnimationXY(anim, x + 2, y)
				player:sendAnimationXY(anim, x + 2, y + 1)
				player:sendAnimationXY(anim, x + 2, y - 1)
				player:sendAnimationXY(anim, x + 3, y)
				player:sendAnimationXY(anim, x + 3, y + 1)
				player:sendAnimationXY(anim, x + 3, y - 1)
				player:sendAnimationXY(anim, x + 3, y + 2)
				player:sendAnimationXY(anim, x + 3, y - 2)
			elseif s == 2 then
				player:sendAnimationXY(anim, x, y + 1)
				player:sendAnimationXY(anim, x, y + 2)
				player:sendAnimationXY(anim, x + 1, y + 2)
				player:sendAnimationXY(anim, x - 1, y + 2)
				player:sendAnimationXY(anim, x, y + 3)
				player:sendAnimationXY(anim, x + 1, y + 3)
				player:sendAnimationXY(anim, x - 1, y + 3)
				player:sendAnimationXY(anim, x + 2, y + 3)
				player:sendAnimationXY(anim, x - 2, y + 3)
			elseif s == 3 then
				player:sendAnimationXY(anim, x - 1, y)
				player:sendAnimationXY(anim, x - 2, y)
				player:sendAnimationXY(anim, x - 2, y + 1)
				player:sendAnimationXY(anim, x - 2, y - 1)
				player:sendAnimationXY(anim, x - 3, y)
				player:sendAnimationXY(anim, x - 3, y + 1)
				player:sendAnimationXY(anim, x - 3, y - 1)
				player:sendAnimationXY(anim, x - 3, y + 2)
				player:sendAnimationXY(anim, x - 3, y - 2)
			end
		end
	end,
	getTargets = function(player)
		local level = player.level
		local side = player.side

		if level >= 100 then
			if (side == 0) then
				--player:getObjectsInCell(player.m, player.x - 4, player.y - 4, BL_PC)[1],
				--player:getObjectsInCell(player.m, player.x + 4, player.y - 4, BL_PC)[1]}
				mobTargets = {
					player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x, player.y - 2, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x + 1, player.y - 2, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x - 1, player.y - 2, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x + 2, player.y - 2, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x - 2, player.y - 2, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x, player.y - 3, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x + 1, player.y - 3, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x + 2, player.y - 3, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x - 1, player.y - 3, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x - 2, player.y - 3, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x + 3, player.y - 3, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x - 3, player.y - 3, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x, player.y - 4, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x - 1, player.y - 4, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x + 1, player.y - 4, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x - 2, player.y - 4, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x + 2, player.y - 4, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x - 3, player.y - 4, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x + 3, player.y - 4, BL_MOB)[1]
				}
				--player:getObjectsInCell(player.m, player.x - 4, player.y - 4, BL_MOB)[1],
				--player:getObjectsInCell(player.m, player.x + 4, player.y - 4, BL_MOB)[1]}

				pcTargets = {
					player:getObjectsInCell(player.m, player.x, player.y - 1, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x, player.y - 2, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x + 1, player.y - 2, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x - 1, player.y - 2, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x + 2, player.y - 2, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x - 2, player.y - 2, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x, player.y - 3, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x + 1, player.y - 3, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x + 2, player.y - 3, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x - 1, player.y - 3, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x - 2, player.y - 3, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x + 3, player.y - 3, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x - 3, player.y - 3, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x, player.y - 4, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x - 1, player.y - 4, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x + 1, player.y - 4, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x - 2, player.y - 4, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x + 2, player.y - 4, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x - 3, player.y - 4, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x + 3, player.y - 4, BL_PC)[1]
				}
			elseif (side == 1) then
				--player:getObjectsInCell(player.m, player.x + 4, player.y + 4, BL_PC)[1],
				--player:getObjectsInCell(player.m, player.x + 4, player.y - 4, BL_PC)[1]}
				mobTargets = {
					player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x + 2, player.y, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x + 3, player.y, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x + 4, player.y, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x + 2, player.y + 1, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x + 2, player.y - 1, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x + 2, player.y + 2, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x + 2, player.y - 2, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x + 3, player.y + 1, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x + 3, player.y - 1, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x + 3, player.y + 2, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x + 3, player.y - 2, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x + 3, player.y + 3, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x + 3, player.y - 3, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x + 4, player.y + 1, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x + 4, player.y - 1, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x + 4, player.y + 2, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x + 4, player.y - 2, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x + 4, player.y + 3, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x + 4, player.y - 3, BL_MOB)[1]
				}
				--player:getObjectsInCell(player.m, player.x + 4, player.y + 4, BL_MOB)[1],
				--player:getObjectsInCell(player.m, player.x + 4, player.y - 4, BL_MOB)[1]}

				pcTargets = {
					player:getObjectsInCell(player.m, player.x + 1, player.y, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x + 2, player.y, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x + 3, player.y, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x + 4, player.y, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x + 2, player.y + 1, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x + 2, player.y - 1, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x + 2, player.y + 2, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x + 2, player.y - 2, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x + 3, player.y + 1, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x + 3, player.y - 1, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x + 3, player.y + 2, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x + 3, player.y - 2, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x + 3, player.y + 3, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x + 3, player.y - 3, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x + 4, player.y + 1, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x + 4, player.y - 1, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x + 4, player.y + 2, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x + 4, player.y - 2, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x + 4, player.y + 3, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x + 4, player.y - 3, BL_PC)[1]
				}
			elseif (side == 2) then
				--player:getObjectsInCell(player.m, player.x - 4, player.y + 4, BL_PC)[1],
				--player:getObjectsInCell(player.m, player.x + 4, player.y + 4, BL_PC)[1]}
				mobTargets = {
					player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x, player.y + 2, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x + 1, player.y + 2, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x - 1, player.y + 2, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x + 2, player.y + 2, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x - 2, player.y + 2, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x, player.y + 3, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x + 1, player.y + 3, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x + 2, player.y + 3, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x - 1, player.y + 3, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x - 2, player.y + 3, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x + 3, player.y + 3, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x - 3, player.y + 3, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x, player.y + 4, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x - 1, player.y + 4, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x + 1, player.y + 4, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x - 2, player.y + 4, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x + 2, player.y + 4, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x - 3, player.y + 4, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x + 3, player.y + 4, BL_MOB)[1]
				}
				--player:getObjectsInCell(player.m, player.x - 4, player.y + 4, BL_MOB)[1],
				--player:getObjectsInCell(player.m, player.x + 4, player.y + 4, BL_MOB)[1]}

				pcTargets = {
					player:getObjectsInCell(player.m, player.x, player.y + 1, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x, player.y + 2, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x + 1, player.y + 2, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x - 1, player.y + 2, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x + 2, player.y + 2, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x - 2, player.y + 2, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x, player.y + 3, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x + 1, player.y + 3, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x + 2, player.y + 3, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x - 1, player.y + 3, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x - 2, player.y + 3, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x + 3, player.y + 3, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x - 3, player.y + 3, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x, player.y + 4, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x - 1, player.y + 4, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x + 1, player.y + 4, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x - 2, player.y + 4, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x + 2, player.y + 4, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x - 3, player.y + 4, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x + 3, player.y + 4, BL_PC)[1]
				}
			elseif (side == 3) then
				mobTargets = {
					player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x - 2, player.y, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x - 3, player.y, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x - 4, player.y, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x - 2, player.y + 1, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x - 2, player.y - 1, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x - 2, player.y + 2, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x - 2, player.y - 2, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x - 3, player.y + 1, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x - 3, player.y - 1, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x - 3, player.y + 2, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x - 3, player.y - 2, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x - 3, player.y + 3, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x - 3, player.y - 3, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x - 4, player.y + 1, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x - 4, player.y - 1, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x - 4, player.y + 2, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x - 4, player.y - 2, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x - 4, player.y + 3, BL_MOB)[1],
					player:getObjectsInCell(player.m, player.x - 4, player.y - 3, BL_MOB)[1]
				}
				--player:getObjectsInCell(player.m, player.x - 4, player.y + 4, BL_MOB)[1],
				--player:getObjectsInCell(player.m, player.x - 4, player.y - 4, BL_MOB)[1]}

				pcTargets = {
					player:getObjectsInCell(player.m, player.x - 1, player.y, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x - 2, player.y, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x - 3, player.y, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x - 4, player.y, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x - 2, player.y + 1, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x - 2, player.y - 1, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x - 2, player.y + 2, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x - 2, player.y - 2, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x - 3, player.y + 1, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x - 3, player.y - 1, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x - 3, player.y + 2, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x - 3, player.y - 2, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x - 3, player.y + 3, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x - 3, player.y - 3, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x - 4, player.y + 1, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x - 4, player.y - 1, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x - 4, player.y + 2, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x - 4, player.y - 2, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x - 4, player.y + 3, BL_PC)[1],
					player:getObjectsInCell(player.m, player.x - 4, player.y - 3, BL_PC)[1]
				}
			--player:getObjectsInCell(player.m, player.x - 4, player.y + 4, BL_PC)[1],
			--player:getObjectsInCell(player.m, player.x - 4, player.y - 4, BL_PC)[1]}
			end
		elseif player.level <= 99 then
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
					player:getObjectsInCell(player.m, player.x - 2, player.y - 3, BL_MOB)[1]
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
					player:getObjectsInCell(player.m, player.x - 2, player.y - 3, BL_PC)[1]
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
					player:getObjectsInCell(player.m, player.x + 3, player.y - 2, BL_MOB)[1]
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
					player:getObjectsInCell(player.m, player.x + 3, player.y - 2, BL_PC)[1]
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
					player:getObjectsInCell(player.m, player.x - 2, player.y + 3, BL_MOB)[1]
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
					player:getObjectsInCell(player.m, player.x - 2, player.y + 3, BL_PC)[1]
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
					player:getObjectsInCell(player.m, player.x - 3, player.y - 2, BL_MOB)[1]
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
					player:getObjectsInCell(player.m, player.x - 3, player.y - 2, BL_PC)[1]
				}
			end
		end
		return mobTargets, pcTargets
	end,
	requirements = function(player)
		local level = 74
		local item = {0, 3034}
		local amounts = {3500, 35}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Throw a wave of Poisoned Shuriken to strike and stun many targets.", txt}
		return level, item, amounts, desc
	end
}
