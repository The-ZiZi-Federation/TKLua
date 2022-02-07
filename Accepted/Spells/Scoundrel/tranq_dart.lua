-------------------------------------------------------
--   Spell: Tranq Dart
--   Class: Scoundrel
--   Level: 36
--  Aether: 9 Second
--    Cost: (player.level * 10) + (player.maxMagic / 40)
-- DmgType: Physical
--    Type: Offensive
-- Targets: 6 in line
-- Effects: Stun, 3 Second.
-------------------------------------------------------
--    Desc: Moderate damage to a single foe
--          Stun enemy for 3 seconds
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 07/07/2017
-------------------------------------------------------
tranq_dart = {
	on_learn = function(player)
		player.registry["learned_tranq_dart"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_tranq_dart"] = 0
	end,
	cast = function(player)
		----------------------
		--Varable Declarations
		----------------------
		local magicCost = (player.level * 10) + (player.maxMagic / 50)
		local aether = 9000
		local stunDuration = 3000

		local threat

		local m = player.m
		local x = player.x
		local y = player.y

		local anim = 124
		local sound = 341
		---------------------------
		--- Spell Damage Formula---
		---------------------------

		local damage
		player.critChance = 1
		-------------------------------------------------------------
		if not player:canCast(1, 1, 0) then
			return
		end
		if player.magic < magicCost then
			notEnoughMP(player)
			return
		end
		---------------------------------------------------------------

		local icon = 0006

		player:sendAction(1, 20)
		player.magic = player.magic - magicCost
		player:setAether("tranq_dart", aether)
		player:playSound(sound)
		player:sendStatus()

		for i = 1, 6 do
			local mobTarget = getTargetFacing(player, BL_MOB, 0, i)
			local pcTarget = getTargetFacing(player, BL_PC, 0, i)
			if mobTarget ~= nil then
				player.critChance = 1
				damage = math.floor(((0.025 * player.maxHealth) + (0.1 * player.level) + swingDamage(player, mobTarget, 2)) * 1.25)
				if player.side == 0 then
					if getPass(player.m, player.x, player.y - i) == 1 then
						return
					else
						player:throw(player.x, player.y - i, icon, 0, 1)
					end
				elseif player.side == 1 then
					if getPass(player.m, player.x + i, player.y) == 1 then
						return
					else
						player:throw(player.x + i, player.y, icon + 1, 0, 1)
					end
				elseif player.side == 2 then
					if getPass(player.m, player.x, player.y + i) == 1 then
						return
					else
						player:throw(player.x, player.y + i, icon + 2, 0, 1)
					end
				elseif player.side == 3 then
					if getPass(player.m, player.x - i, player.y) == 1 then
						return
					else
						player:throw(player.x - i, player.y, icon + 3, 0, 1)
					end
				end

				mobTarget.attacker = player.ID

				if player.gmLevel < 1 then
					player:sendMinitext("You stick the enemy with a Tranq Dart!!")
				end

				if player.gmLevel > 0 then
					player:sendMinitext("Tranq Dart DMG: " .. damage)
				end

				threat = mobTarget:removeHealthExtend(damage, 1, 1, 0, 1, 2)
				player:addThreat(mobTarget.ID, threat)
				mobTarget:sendAnimation(anim)
				mobTarget:removeHealthExtend(damage, 1, 1, 0, 1, 1)
				--mobTarget.paralyzed = true
				if not mobTarget:hasDuration("stun") then
					if checkResist(player, mobTarget, "stun") == 1 then
						return
					end
					mobTarget:setDuration("stun", stunDuration)
				end
			elseif pcTarget ~= nil then
				if player:canPK(pcTarget) and pcTarget.state ~= 1 then
					player.critChance = 1
					damage = math.floor(((0.025 * player.maxHealth) + (0.1 * player.level) + swingDamage(player, pcTarget, 2)) * 1.25)
					if player.side == 0 then
						if getPass(player.m, player.x, player.y - i) == 1 then
							return
						else
							player:throw(player.x, player.y - i, icon, 0, 1)
						end
					elseif player.side == 1 then
						if getPass(player.m, player.x + i, player.y) == 1 then
							return
						else
							player:throw(player.x + i, player.y, icon + 1, 0, 1)
						end
					elseif player.side == 2 then
						if getPass(player.m, player.x, player.y + i) == 1 then
							return
						else
							player:throw(player.x, player.y + i, icon + 2, 0, 1)
						end
					elseif player.side == 3 then
						if getPass(player.m, player.x - i, player.y) == 1 then
							return
						else
							player:throw(player.x - i, player.y, icon + 3, 0, 1)
						end
					end
					pcTarget.attacker = player.ID

					if player.gmLevel < 1 then
						player:sendMinitext("You stick the enemy with a Tranq Dart!!")
					end

					if player.gmLevel > 0 then
						player:sendMinitext("Tranq Dart DMG: " .. damage)
					end

					threat = pcTarget:removeHealthExtend(damage, 1, 1, 0, 1, 2)
					player:addThreat(pcTarget.ID, threat)
					pcTarget:sendAnimation(anim)
					pcTarget:removeHealthExtend(damage, 1, 1, 0, 1, 1)
					--pcTarget.paralyzed = true
					if not pcTarget:hasDuration("stun") then
						pcTarget:setDuration("stun", stunDuration)
					end
				end
			end
		end
	end,
	requirements = function(player)
		local level = 25
		local item = {0, 6033}
		local amounts = {4500, 12}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Throws a wave of darts that damage and stun a line of enemies.", txt}
		return level, item, amounts, desc
	end
}
