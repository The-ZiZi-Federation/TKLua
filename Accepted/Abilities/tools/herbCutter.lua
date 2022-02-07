-------------------------------------------------------
--   Ability: Herb Cutting
--      Tool: Herb Cutter
--  Job Type: Gathering
--     Desc.: Cut Herbs
-------------------------------------------------------
-- Script Author: John Crandell
--   Last Edited: 06/24/2017
-------------------------------------------------------
herb_cutter = {
	on_swing = function(player)
		---------------------------------
		--local variable intializations--
		---------------------------------
		local ability = "herbalism"
		local herbalismRank = player.registry["herbalism_level"]
		local herbalismLearned = player.registry["learned_herbalism"]
		local mob = getTargetFacing(player, BL_MOB)
		local tool = player:getEquippedItem(EQ_WEAP)
		local pc = Player(player.ID)

		local amountGatheredMult
		local duraloss
		local skillEXP
		local addItem

		local failChance
		local toolFailChance
		local rankFailChance
		local flowerFailChance
		local flowerName = ""
		local flowerDBName = ""

		-- All of the flowers that can be harvested, their MOB ID from the Mob DB.
		local flower01 = "sanguine_flower" -- Sanguine Flower
		local flower02 = "cobalt_flower" -- Cobalt Flower
		local flower03 = "brown_mushroom" -- Brown Mushroom Cap
		local flower04 = "violet_flower" -- Violet Flower
		local flower05 = "enhancing_herb" -- Enhancing Leaves
		local flower06 = "snow_flower" -- Sophoric Flower
		local flower07 = "draining_flower" -- Draining Flower
		local flower08 = "stupifying_flower" -- Stupifying Flower
		local flower09 = "empowering_flower" -- Empowering Flower
		local flower10 = "brutish_flower" -- Brutish Flower
		local flower11 = "dancing_flower" -- Dancing Flower
		 --

		--[[ Tool List -------
	- Basic Herb Cutter:							3531
	- Quality Herb Cutter:							3532
	- Superior Herb Cutter: 						3533
	- Artisan Herb Cutter:  						3534
	- Chong's Herb Cutter:  						3535
	- Copper Herb Cutter (Ordianry Quality):		3536
	- Copper Herb Cutter (Exceptional Quality):		3537
	- Copper Herb Cutter (Superior Quality):		3538
	- Iron Herb Cutter (Ordianry Quality):			3539
	- Iron Herb Cutter (Exceptional Quality):		3540
	- Iron Herb Cutter (Superior Quality):			3541
	- Admantium Herb Cutter (Ordianry Quality):		3542
	- Admantium Herb Cutter (Exceptional Quality):	3543
	- Admantium Herb Cutter (Superior Quality):		3544
	
	
	]] --Establish variables for the tools
		local toolDamage = tool.minDmg

		--Animations and sounds
		local anim01 = 313
		local anim02 = 331
		local sound01 = 352
		local sound02 = 353
		--End Declares ---------------------------------------------------------

		-- Do you even know Herbalism?? ----------------------------------------
		if player.registry["learned_herbalism"] < 1 then
			player:talkSelf(0, "I don't know how to use this!")
			return
		end
		------------------------------------------------------------------------
		-- Apply Bonuses ---------------------------------------------------
		-- Do you even know Herbalism?? --
		if herbalismLearned ~= 0 then
			-- Tool based bonuses -----------------------------------------
			-- Tool based failure rates -----------------------------------
			if tool.id == 3531 then
				toolBonus = math.random(1, 1)
				toolFailChance = 7
			elseif tool.id == 3532 then
				toolBonus = math.random(1, 2)
				toolFailChance = 6
			elseif tool.id == 3533 then
				toolBonus = math.random(2, 2)
				toolFailChance = 5
			elseif tool.id == 3534 then
				toolBonus = math.random(2, 3)
				toolFailChance = 3
			elseif tool.id == 3535 then
				toolBonus = math.random(3, 4)
				herbalismRank = herbalismRank + 1
				toolFailChance = -10
			elseif tool.id == 3536 then
				toolBonus = math.random(1, 1)
				toolFailChance = 5
			elseif tool.id == 3537 then
				toolBonus = math.random(1, 2)
				toolFailChance = 4
			elseif tool.id == 3538 then
				toolBonus = math.random(1, 2)
				toolFailChance = 3
			elseif tool.id == 3539 then
				toolBonus = math.random(1, 2)
				toolFailChance = 3
			elseif tool.id == 3540 then
				toolBonus = math.random(1, 2)
				toolFailChance = 2
			elseif tool.id == 3541 then
				toolBonus = math.random(1, 2)
				toolFailChance = 1
			elseif tool.id == 3542 then
				toolBonus = math.random(2, 2)
				toolFailChance = 1
			elseif tool.id == 3543 then
				toolBonus = math.random(2, 2)
				toolFailChance = 0
			elseif tool.id == 3544 then
				toolBonus = math.random(2, 3)
				toolFailChance = -2
			end

			-- End Tool Based Bonuses -------------------------------------

			-- Rank Based Bonuses -----------------------------------------
			-- Give a bonus herb based on players Herbalism Rank --
			-- Level 01 through 08: No Bonus
			-- Level 09 thtough 12: + 1 picked
			-- Level 13:		    + 2 picked
			-- ERROR if herbalism rank is not set.

			-- Fail Rates ------------------------------------------------
			-- Level 01 through 03:  10% Failure
			-- Level 04 through 05:  07% Failure
			-- Level 06 through 08:  04% Failure
			-- Level 09 through 12:  00% Failure
			-- Level 13 through 16: -05% Failure

			if herbalismRank > 0 and herbalismRank <= 3 then
				amountGatheredMult = 0
				rankFailChance = 10
			elseif herbalismRank > 3 and herbalismRank <= 5 then
				amountGatheredMult = 0
				rankFailChance = 7
			elseif herbalismRank > 5 and herbalismRank <= 8 then
				amountGatheredMult = 0
				rankFailChance = 4
			elseif herbalismRank > 8 and herbalismRank <= 12 then
				amountGatheredMult = 1
				rankFailChance = 0
			elseif herbalismRank > 12 then
				amountGatheredMult = 2
				rankFailChance = -5
			else
				--Error Handler
				player:talkSelf(0, "ERROR: herbalismRank Registry: " .. herbalismRank)
			end
			-- End Rank Based Bonuses -------------------------------------------
			-- End Bonuses ---------------------------------------------------------

			player:playSound(math.random(sound01, sound02))
			player:sendAnimation(anim01)

			-- Load mob parameters based on what mob is hit with the tool -----------------------
			if mob ~= nil then -- You are hitting something
				---------------------------------------------------------------
				--[[
			flower01 = 52001 -- Sanguine Flower
			flower02 = 52002 -- Cobalt Flower
			flower03 = 52003 -- Brown Mushroom Cap
			flower04 = 52004 -- Violet Flower
			flower05 = 52005 -- Enhancing Leaves
			flower06 = 52006 -- Sophoric Flower
			flower07 = 52007 -- Draining Flower
			flower08 = 52008 -- Stupifying Flower
			flower09 = 52009 -- Empowering Flower
			flower10 = 52010 -- Brutish Flower
			flower11 = 52011 -- Dancing Flower
			flower12 = 52012 -- 
		--]]
				flowerName = mob.name

				if mob.yname == flower01 then
					duraloss = 1
					flowerFailChance = 3
					flowerDBName = "sanguine_flower"
				elseif mob.yname == flower02 then
					duraloss = 3
					flowerFailChance = 3
					flowerDBName = "cobalt_flower"
				elseif mob.yname == flower03 then
					duraloss = 6
					flowerFailChance = 5
					flowerDBName = "brown_mushroom_cap"
				elseif mob.yname == flower04 then
					duraloss = 10
					flowerFailChance = 6
					flowerDBName = "violet_flower"
				elseif mob.yname == flower05 then
					duraloss = 8
					flowerFailChance = 7
					flowerDBName = "enhancing_le aves"
				elseif mob.yname == flower06 then
					duraloss = 25
					flowerFailChance = 8
					flowerDBName = "sophoric_flower"
				elseif mob.yname == flower07 then
					duraloss = 40
					flowerFailChance = 9
					flowerDBName = "draining_flower"
				elseif mob.yname == flower08 then
					duraloss = 80
					flowerFailChance = 10
					flowerDBName = "stupifying_flower"
				elseif mob.yname == flower09 then
					duraloss = 200
					flowerFailChance = 10
					flowerDBName = "empowering_flower"
				elseif mob.yname == flower10 then
					duraloss = 400
					flowerFailChance = 12
					flowerDBName = "brutish_flower"
				elseif mob.yname == flower11 then
					duraloss = 1000
					flowerFailChance = 15
					flowerDBName = "dancing_flower"
				else
					-- error handler
				end
				--player:talkSelf(0, "mob.yname: "..mob.yname)
				--player:talkSelf(0, "flowerName: "..flowerName)
				--player:talkSelf(0, "flowerDBName: "..flowerDBName)
				-- End Mob Parameters ------------------------------------------------------------

				-- Calculate total failure chance ----------------------------------------------
				failChance = toolFailChance + rankFailChance + flowerFailChance

				if failChance <= 0 then
					failChance = 1
				end

				-- Check ranks to determine what flowers can be harvested ------------------------
				-- Rank 1: Beginner --
				if herbalismRank == 1 then
					-- Rank 2: Novice --
					if mob.yname == flower01 or mob.yname == flower02 then
						player:deductDura(EQ_WEAP, duraloss)
						player:sendAnimationXY(anim02, mob.x, mob.y)
						mob.attacker = 0
						mob:removeHealthWithoutDamageNumbers(toolDamage)
						skillEXP = mob.experience

						if mob.health < 1 then
							amountGatheredMult = amountGatheredMult + toolBonus

							failureRoll = math.random(1, 100)

							if failureRoll <= failChance then
								player:sendMinitext("I ruined this flower!!")
								skillEXP = math.floor(skillEXP / 2)
								skill.leveling(player, skillEXP, "herbalism")
								return
							end

							if amountGatheredMult == 1 then
								player:sendMinitext("I cut a " .. flowerName)
							else
								player:sendMinitext("I cut " .. amountGatheredMult .. " " .. flowerName .. "s!")
								skillEXP = skillEXP * amountGatheredMult
							end

							skill.leveling(player, skillEXP, "herbalism")
							player:addItem(flowerDBName, amountGatheredMult)
						end
					elseif mob.yname >= flower03 and mob.yname <= flower11 then
						player:talkSelf(0, "There is no way, I am too clumsy for this!!!")
						return
					else
						player:sendMinitext("I cannot use the Herb Cutter on this!!!")
						return
					end
				elseif herbalismRank == 2 then
					-- Rank 3: Trainee --
					if mob.yname == flower01 or mob.yname == flower02 then
						player:deductDura(EQ_WEAP, duraloss)
						player:sendAnimationXY(anim02, mob.x, mob.y)
						mob.attacker = 0
						mob:removeHealthWithoutDamageNumbers(toolDamage)
						skillEXP = mob.experience

						if mob.health < 1 then
							amountGatheredMult = amountGatheredMult + toolBonus

							failureRoll = math.random(1, 100)

							if failureRoll <= failChance then
								player:sendMinitext("I ruined this flower!!")
								skillEXP = math.floor(skillEXP / 2)
								skill.leveling(player, skillEXP, "herbalism")
								return
							end

							if amountGatheredMult == 1 then
								player:sendMinitext("I cut a " .. flowerName)
							else
								player:sendMinitext("I cut " .. amountGatheredMult .. " " .. flowerName .. "s!")
								skillEXP = skillEXP * amountGatheredMult
							end

							skill.leveling(player, skillEXP, "herbalism")
							player:addItem(flowerDBName, amountGatheredMult)
						end
					elseif mob.yname == flower03 then
						player:talkSelf(0, "I nearly understand how to cut this one!!! ")
					elseif mob.yname >= flower04 and mob.yname <= flower11 then
						player:talkSelf(0, "There is no way, I am too clumsy for this!!!")
					else
						player:sendMinitext("I cannot use the Herb Cutter on this!!!")
					end
				elseif herbalismRank == 3 then
					-- Rank 4: Apprentice --
					if mob.yname == flower01 or mob.yname == flower02 or mob.yname == flower03 then
						player:deductDura(EQ_WEAP, duraloss)
						player:sendAnimationXY(anim02, mob.x, mob.y)
						mob.attacker = 0
						mob:removeHealthWithoutDamageNumbers(toolDamage)
						skillEXP = mob.experience

						if mob.health < 1 then
							amountGatheredMult = amountGatheredMult + toolBonus

							failureRoll = math.random(1, 100)

							if failureRoll <= failChance then
								player:sendMinitext("I ruined this flower!!")
								skillEXP = math.floor(skillEXP / 2)
								skill.leveling(player, skillEXP, "herbalism")
								return
							end

							if amountGatheredMult == 1 then
								player:sendMinitext("I cut a " .. flowerName)
							else
								player:sendMinitext("I cut " .. amountGatheredMult .. " " .. flowerName .. "s!")
								skillEXP = skillEXP * amountGatheredMult
							end

							skill.leveling(player, skillEXP, "herbalism")
							player:addItem(flowerDBName, amountGatheredMult)
						end
					elseif mob.yname >= flower04 and mob.yname <= flower11 then
						player:talkSelf(0, "There is no way, I am too clumsy for this!!!")
					else
						player:sendMinitext("I cannot use the Herb Cutter on this!!!")
					end
				elseif herbalismRank == 4 then
					-- Rank 5: Greenhorn --
					if mob.yname == flower01 or mob.yname == flower02 or mob.yname == flower03 then
						player:deductDura(EQ_WEAP, duraloss)
						player:sendAnimationXY(anim02, mob.x, mob.y)
						mob.attacker = 0
						mob:removeHealthWithoutDamageNumbers(toolDamage)
						skillEXP = mob.experience

						if mob.health < 1 then
							amountGatheredMult = amountGatheredMult + toolBonus

							failureRoll = math.random(1, 100)

							if failureRoll <= failChance then
								player:sendMinitext("I ruined this flower!!")
								skillEXP = math.floor(skillEXP / 2)
								skill.leveling(player, skillEXP, "herbalism")
								return
							end

							if amountGatheredMult == 1 then
								player:sendMinitext("I cut a " .. flowerName)
							else
								player:sendMinitext("I cut " .. amountGatheredMult .. " " .. flowerName .. "s!")
								skillEXP = skillEXP * amountGatheredMult
							end

							skill.leveling(player, skillEXP, "herbalism")
							player:addItem(flowerDBName, amountGatheredMult)
						end
					elseif mob.yname == flower04 then
						player:talkSelf(0, "I nearly understand how to cut this one!!! ")
					elseif mob.yname >= flower05 and mob.yname <= flower11 then
						player:talkSelf(0, "There is no way, I am too clumsy for this!!!")
					else
						player:sendMinitext("I cannot use the Herb Cutter on this!!!")
					end
				elseif herbalismRank == 5 then
					-- Rank 6: Aspirant --
					if mob.yname == flower01 or mob.yname == flower02 or mob.yname == flower03 or mob.yname == flower04 then
						player:deductDura(EQ_WEAP, duraloss)
						player:sendAnimationXY(anim02, mob.x, mob.y)
						mob.attacker = 0
						mob:removeHealthWithoutDamageNumbers(toolDamage)
						skillEXP = mob.experience
						if mob.health < 1 then
							amountGatheredMult = amountGatheredMult + toolBonus

							failureRoll = math.random(1, 100)

							if failureRoll <= failChance then
								player:sendMinitext("I ruined this flower!!")
								skillEXP = math.floor(skillEXP / 2)
								skill.leveling(player, skillEXP, "herbalism")
								return
							end

							if amountGatheredMult == 1 then
								player:sendMinitext("I cut a " .. flowerName)
							else
								player:sendMinitext("I cut " .. amountGatheredMult .. " " .. flowerName .. "s!")
								skillEXP = skillEXP * amountGatheredMult
							end

							skill.leveling(player, skillEXP, "herbalism")
							player:addItem(flowerDBName, amountGatheredMult)
						end
					elseif mob.yname == flower05 then
						player:talkSelf(0, "I nearly understand how to cut this one!!! ")
					elseif mob.yname >= flower06 and mob.yname <= flower11 then
						player:talkSelf(0, "There is no way, I am too clumsy for this!!!")
					else
						player:sendMinitext("I cannot use the Herb Cutter on this!!!")
					end
				elseif herbalismRank == 6 then
					-- Rank 7: Amateur --
					if
						mob.yname == flower01 or mob.yname == flower02 or mob.yname == flower03 or mob.yname == flower04 or
							mob.yname == flower05
					 then
						player:deductDura(EQ_WEAP, duraloss)
						player:sendAnimationXY(anim02, mob.x, mob.y)
						mob.attacker = 0
						mob:removeHealthWithoutDamageNumbers(toolDamage)
						skillEXP = mob.experience
						if mob.health < 1 then
							amountGatheredMult = amountGatheredMult + toolBonus

							failureRoll = math.random(1, 100)

							if failureRoll <= failChance then
								player:sendMinitext("I ruined this flower!!")
								skillEXP = math.floor(skillEXP / 2)
								skill.leveling(player, skillEXP, "herbalism")
								return
							end

							if amountGatheredMult == 1 then
								player:sendMinitext("I cut a " .. flowerName)
							else
								player:sendMinitext("I cut " .. amountGatheredMult .. " " .. flowerName .. "s!")
								skillEXP = skillEXP * amountGatheredMult
							end

							skill.leveling(player, skillEXP, "herbalism")
							player:addItem(flowerDBName, amountGatheredMult)
						end
					elseif mob.yname == flower06 then
						player:talkSelf(0, "I nearly understand how to cut this one!!! ")
					elseif mob.yname >= flower07 and mob.yname <= flower11 then
						player:talkSelf(0, "There is no way, I am too clumsy for this!!!")
					else
						player:sendMinitext("I cannot use the Herb Cutter on this!!!")
					end
				elseif herbalismRank == 7 then
					-- Rank 8: Journeyman --
					if
						mob.yname == flower01 or mob.yname == flower02 or mob.yname == flower03 or mob.yname == flower04 or
							mob.yname == flower05 or
							mob.yname == flower06
					 then
						player:deductDura(EQ_WEAP, duraloss)
						player:sendAnimationXY(anim02, mob.x, mob.y)
						mob.attacker = 0
						mob:removeHealthWithoutDamageNumbers(toolDamage)
						skillEXP = mob.experience
						if mob.health < 1 then
							amountGatheredMult = amountGatheredMult + toolBonus

							failureRoll = math.random(1, 100)

							if failureRoll <= failChance then
								player:sendMinitext("I ruined this flower!!")
								skillEXP = math.floor(skillEXP / 2)
								skill.leveling(player, skillEXP, "herbalism")
								return
							end

							if amountGatheredMult == 1 then
								player:sendMinitext("I cut a " .. flowerName)
							else
								player:sendMinitext("I cut " .. amountGatheredMult .. " " .. flowerName .. "s!")
								skillEXP = skillEXP * amountGatheredMult
							end

							skill.leveling(player, skillEXP, "herbalism")
							player:addItem(flowerDBName, amountGatheredMult)
						end
					elseif mob.yname == flower07 then
						player:talkSelf(0, "I nearly understand how to cut this one!!! ")
					elseif mob.yname >= flower08 and mob.yname <= flower11 then
						player:talkSelf(0, "There is no way, I am too clumsy for this!!!")
					else
						player:sendMinitext("I cannot use the Herb Cutter on this!!!")
					end
				elseif herbalismRank == 8 then
					-- Rank 9: Adept --
					if
						mob.yname == flower01 or mob.yname == flower02 or mob.yname == flower03 or mob.yname == flower04 or
							mob.yname == flower05 or
							mob.yname == flower06 or
							mob.yname == flower07
					 then
						player:deductDura(EQ_WEAP, duraloss)
						player:sendAnimationXY(anim02, mob.x, mob.y)
						mob.attacker = 0
						mob:removeHealthWithoutDamageNumbers(toolDamage)
						skillEXP = mob.experience
						if mob.health < 1 then
							amountGatheredMult = amountGatheredMult + toolBonus

							failureRoll = math.random(1, 100)

							if failureRoll <= failChance then
								player:sendMinitext("I ruined this flower!!")
								skillEXP = math.floor(skillEXP / 2)
								skill.leveling(player, skillEXP, "herbalism")
								return
							end

							if amountGatheredMult == 1 then
								player:sendMinitext("I cut a " .. flowerName)
							else
								player:sendMinitext("I cut " .. amountGatheredMult .. " " .. flowerName .. "s!")
								skillEXP = skillEXP * amountGatheredMult
							end

							skill.leveling(player, skillEXP, "herbalism")
							player:addItem(flowerDBName, amountGatheredMult)
						end
					elseif mob.yname == flower08 then
						player:talkSelf(0, "I nearly understand how to cut this one!!! ")
					elseif mob.yname >= flower09 and mob.yname <= flower11 then
						player:talkSelf(0, "There is no way, I am too clumsy for this!!!")
					else
						player:sendMinitext("I cannot use the Herb Cutter on this!!!")
					end
				elseif herbalismRank == 9 then
					-- Rank 10: Skilled --
					if
						mob.yname == flower01 or mob.yname == flower02 or mob.yname == flower03 or mob.yname == flower04 or
							mob.yname == flower05 or
							mob.yname == flower06 or
							mob.yname == flower07 or
							mob.yname == flower08
					 then
						player:deductDura(EQ_WEAP, duraloss)
						player:sendAnimationXY(anim02, mob.x, mob.y)
						mob.attacker = 0
						mob:removeHealthWithoutDamageNumbers(toolDamage)
						skillEXP = mob.experience
						if mob.health < 1 then
							amountGatheredMult = amountGatheredMult + toolBonus

							failureRoll = math.random(1, 100)

							if failureRoll <= failChance then
								player:sendMinitext("I ruined this flower!!")
								skillEXP = math.floor(skillEXP / 2)
								skill.leveling(player, skillEXP, "herbalism")
								return
							end

							if amountGatheredMult == 1 then
								player:sendMinitext("I cut a " .. flowerName)
							else
								player:sendMinitext("I cut " .. amountGatheredMult .. " " .. flowerName .. "s!")
								skillEXP = skillEXP * amountGatheredMult
							end

							skill.leveling(player, skillEXP, "herbalism")
							player:addItem(flowerDBName, amountGatheredMult)
						end
					elseif mob.yname >= flower09 and mob.yname <= flower11 then
						player:talkSelf(0, "There is no way, I am too clumsy for this!!!")
					else
						player:sendMinitext("I cannot use the Herb Cutter on this!!!")
					end
				elseif herbalismRank == 10 then
					-- Rank 11: Expert --
					if
						mob.yname == flower01 or mob.yname == flower02 or mob.yname == flower03 or mob.yname == flower04 or
							mob.yname == flower05 or
							mob.yname == flower06 or
							mob.yname == flower07 or
							mob.yname == flower08
					 then
						player:deductDura(EQ_WEAP, duraloss)
						player:sendAnimationXY(anim02, mob.x, mob.y)
						mob.attacker = 0
						mob:removeHealthWithoutDamageNumbers(toolDamage)
						skillEXP = mob.experience
						if mob.health < 1 then
							amountGatheredMult = amountGatheredMult + toolBonus

							failureRoll = math.random(1, 100)

							if failureRoll <= failChance then
								player:sendMinitext("I ruined this flower!!")
								skillEXP = math.floor(skillEXP / 2)
								skill.leveling(player, skillEXP, "herbalism")
								return
							end

							if amountGatheredMult == 1 then
								player:sendMinitext("I cut a " .. flowerName)
							else
								player:sendMinitext("I cut " .. amountGatheredMult .. " " .. flowerName .. "s!")
								skillEXP = skillEXP * amountGatheredMult
							end

							skill.leveling(player, skillEXP, "herbalism")
							player:addItem(flowerDBName, amountGatheredMult)
						end
					elseif mob.yname == flower09 then
						player:talkSelf(0, "I nearly understand how to cut this one!!! ")
					elseif mob.yname >= flower10 and mob.yname <= flower11 then
						player:talkSelf(0, "There is no way, I am too clumsy for this!!!")
					else
						player:sendMinitext("I cannot use the Herb Cutter on this!!!")
					end
				elseif herbalismRank == 11 then
					-- Rank 12: Artisan --
					if
						mob.yname == flower01 or mob.yname == flower02 or mob.yname == flower03 or mob.yname == flower04 or
							mob.yname == flower05 or
							mob.yname == flower06 or
							mob.yname == flower07 or
							mob.yname == flower08 or
							mob.yname == flower09
					 then
						player:deductDura(EQ_WEAP, duraloss)
						player:sendAnimationXY(anim02, mob.x, mob.y)
						mob.attacker = 0
						mob:removeHealthWithoutDamageNumbers(toolDamage)
						skillEXP = mob.experience
						if mob.health < 1 then
							amountGatheredMult = amountGatheredMult + toolBonus

							failureRoll = math.random(1, 100)

							if failureRoll <= failChance then
								player:sendMinitext("I ruined this flower!!")
								skillEXP = math.floor(skillEXP / 2)
								skill.leveling(player, skillEXP, "herbalism")
								return
							end

							if amountGatheredMult == 1 then
								player:sendMinitext("I cut a " .. flowerName)
							else
								player:sendMinitext("I cut " .. amountGatheredMult .. " " .. flowerName .. "s!")
								skillEXP = skillEXP * amountGatheredMult
							end

							skill.leveling(player, skillEXP, "herbalism")
							player:addItem(flowerDBName, amountGatheredMult)
						end
					elseif mob.yname == flower10 then
						player:talkSelf(0, "I nearly understand how to cut this one!!! ")
					elseif mob.yname >= flower11 then
						player:talkSelf(0, "There is no way, I am too clumsy for this!!!")
					else
						player:sendMinitext("I cannot use the Herb Cutter on this!!!")
					end
				elseif herbalismRank == 12 then
					-- Rank 13: Prodigy --
					if
						mob.yname == flower01 or mob.yname == flower02 or mob.yname == flower03 or mob.yname == flower04 or
							mob.yname == flower05 or
							mob.yname == flower06 or
							mob.yname == flower07 or
							mob.yname == flower08 or
							mob.yname == flower09 or
							mob.yname == flower10
					 then
						player:deductDura(EQ_WEAP, duraloss)
						player:sendAnimationXY(anim02, mob.x, mob.y)
						mob.attacker = 0
						mob:removeHealthWithoutDamageNumbers(toolDamage)
						skillEXP = mob.experience
						if mob.health < 1 then
							amountGatheredMult = amountGatheredMult + toolBonus

							failureRoll = math.random(1, 100)

							if failureRoll <= failChance then
								player:sendMinitext("I ruined this flower!!")
								skillEXP = math.floor(skillEXP / 2)
								skill.leveling(player, skillEXP, "herbalism")
								return
							end

							if amountGatheredMult == 1 then
								player:sendMinitext("I cut a " .. flowerName)
							else
								player:sendMinitext("I cut " .. amountGatheredMult .. " " .. flowerName .. "s!")
								skillEXP = skillEXP * amountGatheredMult
							end

							skill.leveling(player, skillEXP, "herbalism")
							player:addItem(flowerDBName, amountGatheredMult)
						end
					elseif mob.yname == flower11 then
						player:talkSelf(0, "I nearly understand how to cut this one!!! ")
					else
						player:sendMinitext("I cannot use the Herb Cutter on this!!!")
					end
				elseif herbalismRank == 13 then
					-- Rank 14: Virtuoso --
					if
						mob.yname == flower01 or mob.yname == flower02 or mob.yname == flower03 or mob.yname == flower04 or
							mob.yname == flower05 or
							mob.yname == flower06 or
							mob.yname == flower07 or
							mob.yname == flower08 or
							mob.yname == flower09 or
							mob.yname == flower10 or
							mob.yname == flower11
					 then
						player:deductDura(EQ_WEAP, duraloss)
						player:sendAnimationXY(anim02, mob.x, mob.y)
						mob.attacker = 0
						mob:removeHealthWithoutDamageNumbers(toolDamage)
						skillEXP = mob.experience
						if mob.health < 1 then
							amountGatheredMult = amountGatheredMult + toolBonus

							failureRoll = math.random(1, 100)

							if failureRoll <= failChance then
								player:sendMinitext("I ruined this flower!!")
								skillEXP = math.floor(skillEXP / 2)
								skill.leveling(player, skillEXP, "herbalism")
								return
							end

							if amountGatheredMult == 1 then
								player:sendMinitext("I cut a " .. flowerName)
							else
								player:sendMinitext("I cut " .. amountGatheredMult .. " " .. flowerName .. "s!")
								skillEXP = skillEXP * amountGatheredMult
							end

							skill.leveling(player, skillEXP, "herbalism")
							player:addItem(flowerDBName, amountGatheredMult)
						end
					else
						player:sendMinitext("I cannot use the Herb Cutter on this!!!")
					end
				elseif herbalismRank == 14 then
					-- Rank 15: Master --
					if
						mob.yname == flower01 or mob.yname == flower02 or mob.yname == flower03 or mob.yname == flower04 or
							mob.yname == flower05 or
							mob.yname == flower06 or
							mob.yname == flower07 or
							mob.yname == flower08 or
							mob.yname == flower09 or
							mob.yname == flower10 or
							mob.yname == flower11
					 then
						player:deductDura(EQ_WEAP, duraloss)
						player:sendAnimationXY(anim02, mob.x, mob.y)
						mob.attacker = 0
						mob:removeHealthWithoutDamageNumbers(toolDamage)
						skillEXP = mob.experience
						if mob.health < 1 then
							amountGatheredMult = amountGatheredMult + toolBonus

							failureRoll = math.random(1, 100)

							if failureRoll <= failChance then
								player:sendMinitext("I ruined this flower!!")
								skillEXP = math.floor(skillEXP / 2)
								skill.leveling(player, skillEXP, "herbalism")
								return
							end

							if amountGatheredMult == 1 then
								player:sendMinitext("I cut a " .. flowerName)
							else
								player:sendMinitext("I cut " .. amountGatheredMult .. " " .. flowerName .. "s!")
								skillEXP = skillEXP * amountGatheredMult
							end

							skill.leveling(player, skillEXP, "herbalism")
							player:addItem(flowerDBName, amountGatheredMult)
						end
					else
						player:sendMinitext("I cannot use the Herb Cutter on this!!!")
					end
				elseif herbalismRank == 15 then
					-- Rank 16: Grand-Master --
					if
						mob.yname == flower01 or mob.yname == flower02 or mob.yname == flower03 or mob.yname == flower04 or
							mob.yname == flower05 or
							mob.yname == flower06 or
							mob.yname == flower07 or
							mob.yname == flower08 or
							mob.yname == flower09 or
							mob.yname == flower10 or
							mob.yname == flower11
					 then
						player:deductDura(EQ_WEAP, duraloss)
						player:sendAnimationXY(anim02, mob.x, mob.y)
						mob.attacker = 0
						mob:removeHealthWithoutDamageNumbers(toolDamage)
						skillEXP = mob.experience
						if mob.health < 1 then
							amountGatheredMult = amountGatheredMult + toolBonus

							failureRoll = math.random(1, 100)

							if failureRoll <= failChance then
								player:sendMinitext("I ruined this flower!!")
								skillEXP = math.floor(skillEXP / 2)
								skill.leveling(player, skillEXP, "herbalism")
								return
							end

							if amountGatheredMult == 1 then
								player:sendMinitext("I cut a " .. flowerName)
							else
								player:sendMinitext("I cut " .. amountGatheredMult .. " " .. flowerName .. "s!")
								skillEXP = skillEXP * amountGatheredMult
							end

							skill.leveling(player, skillEXP, "herbalism")
							player:addItem(flowerDBName, amountGatheredMult)
						end
					else
						player:sendMinitext("I cannot use the Herb Cutter on this!!!")
					end
				elseif herbalismRank > 15 then
					-- End Herbalist Level Checks ----------------------------------------------------
					if
						mob.yname == flower01 or mob.yname == flower02 or mob.yname == flower03 or mob.yname == flower04 or
							mob.yname == flower05 or
							mob.yname == flower06 or
							mob.yname == flower07 or
							mob.yname == flower08 or
							mob.yname == flower09 or
							mob.yname == flower10 or
							mob.yname == flower11
					 then
						player:deductDura(EQ_WEAP, duraloss)
						player:sendAnimationXY(anim02, mob.x, mob.y)
						mob.attacker = 0
						mob:removeHealthWithoutDamageNumbers(toolDamage)
						skillEXP = mob.experience
						if mob.health < 1 then
							amountGatheredMult = amountGatheredMult + toolBonus

							failureRoll = math.random(1, 100)

							if failureRoll <= failChance then
								player:sendMinitext("I ruined this flower!!")
								skillEXP = math.floor(skillEXP / 2)
								skill.leveling(player, skillEXP, "herbalism")
								return
							end

							if amountGatheredMult == 1 then
								player:sendMinitext("I cut a " .. flowerName)
							else
								player:sendMinitext("I cut " .. amountGatheredMult .. " " .. flowerName .. "s!")
								skillEXP = skillEXP * amountGatheredMult
							end

							skill.leveling(player, skillEXP, "herbalism")
							player:addItem(flowerDBName, amountGatheredMult)
						end
					else
						player:sendMinitext("I cannot use the Herb Cutter on this!!!")
					end
				else
					player:talkSelf(0, "I apparently don't know enough to cut this properly!")
				end
			else
				--player:talkSelfSelf(0,"I am swinging at the air!!!")
			end
		else
			player:talkSelf(0, "I need to train in the Herbalism skill to cut herbs!!")
		end
	end
}
