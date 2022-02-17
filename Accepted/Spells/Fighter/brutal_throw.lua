-------------------------------------------------------
--   Spell: Brutal Throw
--   Class: Fighter
--   Level: 78
--  Aether: 15 Second
--    Cost: (player.maxMagic * 0.25) + (player.level * 5)
-- DmgType: Physical
--    Type: Offensive
-- Targets: 1
-- Effects: Stun (5 Seconds)
-------------------------------------------------------
--    Desc: You slam the enemy to the ground stunning them.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 07/07/2016
-------------------------------------------------------
brutal_throw = {
	on_learn = function(player)
		player.registry["learned_brutal_throw"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_brutal_throw"] = 0
	end,
	cast = function(player)
		------------------------
		--Varable Declarations--
		------------------------
		local magicCost = (player.maxMagic * 0.1) + (player.level * 10)
		local aether = 15000
		local stunDura = 5000
		---------------------------------------------

		local mobTarget = getTargetFacing(player, BL_MOB)
		local pcTarget = getTargetFacing(player, BL_PC)

		local m = player.m
		local x = player.x
		local y = player.y
		local threat
		-------------------------------
		local damage
		-------------------------------------------------------
		if not player:canCast(1, 1, 0) then
			return
		end
		-------------------------------------------------------
		if player.magic < magicCost then
			notEnoughMP(player)
			return
		end
		-------------------------------------------------------

		local icon = 0787
		local sound = 0
		local anim = 423
		for i = 1, 6 do
			local mobTarget = getTargetFacing(player, BL_MOB, 0, i)
			local pcTarget = getTargetFacing(player, BL_PC, 0, i)

			if mobTarget ~= nil then
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
						player:throw(player.x + i, player.y, icon, 0, 1)
					end
				elseif player.side == 2 then
					if getPass(player.m, player.x, player.y + i) == 1 then
						return
					else
						player:throw(player.x, player.y + i, icon, 0, 1)
					end
				elseif player.side == 3 then
					if getPass(player.m, player.x - i, player.y) == 1 then
						return
					else
						player:throw(player.x - i, player.y, icon, 0, 1)
					end
				end
				player.critChance = 1
				damage = ((0.25 * player.maxHealth) + (0.1 * player.level) + swingDamage(player, mobTarget, 2)) * 6
				mobTarget.attacker = player.ID
				player:sendAction(1, 20)
				player.magic = player.magic - magicCost
				player:setAether("brutal_throw", aether)
				player:sendStatus()
				player:sendMinitext("You hurl an axe at your foe!")
				if player.registry["extra_spell_info"] == 1 then
					player:sendMinitext("Brutal Throw DMG: " .. damage)
				end
				player:playSound(sound)
				threat = mobTarget:removeHealthExtend(damage, 1, 1, 0, 1, 2)
				player:addThreat(mobTarget.ID, threat)
				mobTarget:sendAnimation(anim)
				mobTarget:removeHealthExtend(damage, 1, 1, 0, 1, 1)
				mobTarget.paralyzed = true
				mobTarget:setDuration("stun", stunDura)
				if not mobTarget:hasDuration("stun") then
					if checkResist(player, mobTarget, "stun") == 1 then
						return
					end
					mobTarget:setDuration("stun", stunDura)
				end
				return
			elseif pcTarget ~= nil then
				if player:canPK(pcTarget) and pcTarget.state ~= 1 then
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
							player:throw(player.x + i, player.y, icon, 0, 1)
						end
					elseif player.side == 2 then
						if getPass(player.m, player.x, player.y + i) == 1 then
							return
						else
							player:throw(player.x, player.y + i, icon, 0, 1)
						end
					elseif player.side == 3 then
						if getPass(player.m, player.x - i, player.y) == 1 then
							return
						else
							player:throw(player.x - i, player.y, icon, 0, 1)
						end
					end
					damage = ((0.25 * player.maxHealth) + (0.1 * player.level) + swingDamage(player, pcTarget, 2)) * 7.5

					pcTarget.attacker = player.ID
					player:sendAction(1, 20)
					player.magic = player.magic - magicCost
					player:setAether("brutal_throw", aether)

					player:sendStatus()

					player:sendMinitext("You hurl an axe at your foe!")
					if player.registry["extra_spell_info"] == 1 then
						player:sendMinitext("Brutal Throw DMG: " .. damage)
					end
					player:playSound(sound)
					pcTarget:sendAnimation(anim)
					pcTarget:removeHealthExtend(damage, 1, 1, 0, 1, 1)
					pcTarget.paralyzed = true
					if not pcTarget:hasDuration("stun") then
						pcTarget:setDuration("stun", stunDura)
					end
				end
				return
			end
		end
	end,
	requirements = function(player)
		local level = 78
		local item = {0, 3032, 3034}
		local amounts = {3500, 30, 50}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Throws an axe up to 6 squares, stunning and damaging whoever it strikes.", txt}
		return level, item, amounts, desc
	end
}
