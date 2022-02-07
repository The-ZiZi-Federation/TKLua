-------------------------------------------------------
--   Spell: Assassinate
--   Class: Assassin
--   Level: 125
--  Aether: 35 Second
--    Cost: (player.level * 50) + (player.maxMagic * 0.25)
-- DmgType: Physical
--    Type: Offensive
-- Targets: 1
-- Effects: 7 Second Stun
-------------------------------------------------------
--    Desc: A devastating blow vs. a single enemy.
--          So shocking, if they survive they are stunned for 7 seconds.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 4/10/2017
-------------------------------------------------------
assassinate = {
	on_learn = function(player)
		player.registry["learned_assassinate"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_assassinate"] = 0
	end,
	cast = function(player, target)
		----------------------
		--Varable Declarations
		----------------------
		local magicCost = math.floor((player.level * 50) + (player.maxMagic * 0.25))
		local stunDuration = 3000
		local aether = 35000
		local threat

		local mobTargets
		local pcTargets

		local m = player.m
		local x = player.x
		local y = player.y

		local anim = 306
		local anim2 = 395
		local sound = 85
		---------------------------
		--- Spell Damage Formula---
		--------------------------
		local damage = math.floor(((0.025 * player.maxHealth) + (0.1 * player.level) + swingDamage(player, target, 2)) * 15)
		-------------------------------------------------------------
		player.critChance = 1

		if distanceSquare(player, target, 6) then
			if findClearPath(player.side, player.m, player.x, player.y, target, 1) == 1 then
				if target ~= nil then
					if target.ID == player.ID then
						return
					else -- if target is ourself, then return. nothing happened
						if player.blType == BL_PC then
							if not player:canCast(1, 1, 0) then
								return
							end
							if player.magic < magicCost then
								notEnoughMP(player)
								return
							end
						end

						if target.state == 1 then
							player:sendAnimation(246)
							player:sendMinitext("Target is already dead")
							return
						end
						if player.blType == BL_PC and target.blType == BL_PC then
							if not player:canPK(target) then
								return
							else
								target:sendMinitext(player.name .. " tries to Assassinate you!")
							end
						end

						if player.blType == BL_PC then
							player.magic = player.magic - magicCost
							player:sendStatus()

							-- and here, before warp.
							player:sendAnimationXY(415, player.x, player.y)
							player:sendAnimationXY(280, player.x, player.y)
							player:playSound(73)

							if target.side == 0 then -- if target is facing north
								assassinate.checkSouth(player, target, 1)
							elseif target.side == 1 then -- facing east
								assassinate.checkWest(player, target, 1)
							elseif target.side == 2 then -- south
								assassinate.checkNorth(player, target, 1)
							elseif target.side == 3 then -- west
								assassinate.checkEast(player, target, 1)
							end

							-- here is after warp
							target.attacker = player.ID
							if target.blType == BL_MOB then
								threat = target:removeHealthExtend(damage, 1, 1, 0, 1, 2)
								player:addThreat(target.ID, threat)
							end
							target:removeHealthExtend(damage, 1, 1, 0, 1, 1)
							--	player:sendAnimationXY(279, player.x, player.y)
							player:setAether("assassinate", aether)
							if player.registry["extra_spell_info"] > 0 then
								player:sendMinitext("Assassinate DMG: " .. damage)
							end
							player:playSound(sound)
							player:sendAction(1, 20)
							target:sendAnimation(anim)
							target:sendAnimation(anim2)

							if target.blType == BL_MOB then
								if not target:hasDuration("stun") then
									if checkResist(player, target, "stun") == 0 then
										target:setDuration("stun", stunDuration)
									end
								end
							elseif target.blType == BL_PC then
								if not target:hasDuration("stun") then
									target:setDuration("stun", stunDuration)
								end
							end
							player:sendMinitext("You cast Assassinate")
						end
					end
				end
			else
				player:sendAnimation(246)
				player:sendMinitext("You don't have a clear path to your target")
			end
		else
			player:sendAnimation(246)
			player:sendMinitext("Your target is too far away")
		end
	end,
	checkSouth = function(player, target, tries)
		if tries >= 5 then
			player:sendMinitext("Can't jump there!")
			return
		end

		if getPass(target.m, target.x, target.y + 1) == 1 then -- if walkable is false dont put here.
			tries = tries + 1
			assassinate.checkEast(player, target, tries)
		else
			player:warp(target.m, target.x, target.y + 1)
			player.side = 0
			player:sendSide()
		end
	end,
	checkWest = function(player, target, tires)
		if tries >= 5 then
			player:sendMinitext("Can't jump there!")
			return
		end

		if getPass(target.m, target.x - 1, target.y) == 1 then -- if walkable is false
			tries = tries + 1
			assassinate.checkSouth(player, target, tries)
		else
			player:warp(target.m, target.x - 1, target.y)
			player.side = 1
			player:sendSide()
		end
	end,
	checkNorth = function(player, target, tries)
		if tries >= 5 then
			player:sendMinitext("Can't jump there!")
			return
		end

		if getPass(target.m, target.x, target.y - 1) == 1 then -- if walkable is false
			tries = tries + 1
			assassinate.checkWest(player, target, tries)
		else
			player:warp(target.m, target.x, target.y - 1)
			player.side = 2
			player:sendSide()
		end
	end,
	checkEast = function(player, target, tries)
		if tries >= 5 then
			player:sendMinitext("Can't jump there!")
			return
		end

		if getPass(target.m, target.x + 1, target.y) == 1 then -- if walkable is false
			tries = tries + 1
			assassinate.checkNorth(player, target, tries)
		else
			player:warp(target.m, target.x + 1, target.y)
			player.side = 3
			player:sendSide()
		end
	end,
	requirements = function(player)
		local level = 125
		local item = {0}
		local amounts = {100000}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Jump to an enemy's back. If they survive the blow, they're stunned temporarily.", txt}
		return level, item, amounts, desc
	end
}
