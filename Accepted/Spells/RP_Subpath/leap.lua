-------------------------------------------------------
--   Spell: leap
--   Class: Scoundrel
--   Level: 85
--  Aether: 45 Second
--    Cost: 50 MP per Level
-- DmgType: Physical
--    Type: Offensive
-- Targets: 1
-- Effects: 7 Second Stun
-------------------------------------------------------
--    Desc: A devastating blow vs. a single enemy.
--          So shocking, if they survive they are stunned for 7 seconds.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 01/27/2017
-------------------------------------------------------
leap = {
	on_learn = function(player)
		player.registry["learned_leap"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_leap"] = 0
	end,
	cast = function(player, target)
		----------------------
		--Varable Declarations
		----------------------
		local magicCost = (player.level * 50)
		local stunDuration = 3000
		local stunDurationPK = 3000

		local buff = player.fury
		local might = player.might

		local threat

		local mobTargets
		local pcTargets

		local m = player.m
		local x = player.x
		local y = player.y

		local anim = 306
		local anim2 = 60
		local sound = 350
		---------------------------
		--- Spell Damage Formula---

		--------------------------
		local mightBase = might ^ 1.03
		local mightMult = might ^ 0.11
		local damCalc = (mightBase * mightMult)

		local damage = (damCalc)

		damage = math.floor(damage)
		-------------------------------------------------------------
		if findClearPath(player.side, player.m, player.x, player.y, target, 1) == 1 then
			if target ~= nil then
				if target.ID == player.ID then
					return
				else -- if target is ourself, then return. nothing happened
					if distanceSquare(player, target, 6) then
						if target.state == 1 then
							player:sendAnimation(246)
							player:sendMinitext("Target is already dead")
							return
						else
							if target.blType == BL_PC then
								target:sendMinitext(player.name .. " cast Leap on you.")
							end

							player:sendAnimationXY(15, player.x, player.y)
							player:playSound(73)

							if target.side == 0 then -- if target is facing north
								leap.checkNorth(player, target)
							elseif target.side == 1 then -- facing east
								leap.checkEast(player, target)
							elseif target.side == 2 then -- south
								leap.checkSouth(player, target)
							elseif target.side == 3 then -- west
								leap.checkWest(player, target)
							end

							-- here is after warp
							target.attacker = player.ID
							if target.blType == BL_MOB then
								threat = target:removeHealthExtend(damage, 1, 1, 1, 1, 2)
								player:addThreat(target.ID, threat)
							end
							--	player:sendAnimationXY(279, player.x, player.y)

							player:playSound(sound)
							player:sendAction(1, 20)
							target:sendAnimation(anim)
							target:sendAnimation(anim2)
							--player:talk(0, "LEAP DAMAGE: "..damage)
							if not target:hasDuration("stun") then
								target.paralyzed = true
								target:setDuration("stun", stunDuration)
							end
							target:removeHealth(damage)
						end
					else
						player:sendAnimation(246)
						player:sendMinitext("Your target is too far away")
					end
				end
			end
		else
			player:sendAnimation(246)
			player:sendMinitext("You don't have a clear path to your target")
		end
	end,
	checkSouth = function(player, target)
		if getPass(target.m, target.x, target.y + 1) == 1 then -- if walkable is false dont put here.
			leap.checkEast(player, target)
		else
			player:warp(target.m, target.x, target.y + 1)
			player.side = 0
			player:sendSide()
		end
	end,
	checkWest = function(player, target)
		if getPass(target.m, target.x - 1, target.y) == 1 then -- if walkable is false
			leap.checkSouth(player, target)
		else
			player:warp(target.m, target.x - 1, target.y)
			player.side = 1
			player:sendSide()
		end
	end,
	checkNorth = function(player, target)
		if getPass(target.m, target.x, target.y - 1) == 1 then -- if walkable is false
			leap.checkWest(player, target)
		else
			player:warp(target.m, target.x, target.y - 1)
			player.side = 2
			player:sendSide()
		end
	end,
	checkEast = function(player, target)
		if getPass(target.m, target.x + 1, target.y) == 1 then -- if walkable is false
			leap.checkNorth(player, target)
		else
			player:warp(target.m, target.x + 1, target.y)
			player.side = 3
			player:sendSide()
		end
	end
}
