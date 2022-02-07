-------------------------------------------------------
--   Ability: Pickaxe
--      Tool: Ore Mining
--  Job Type: Gathering
--     Desc.: Mine Ore Nodes
-------------------------------------------------------
-- Script Author: John Crandell
--   Last Edited: 07/23/2017
-------------------------------------------------------
basic_pickaxe = {
	on_swing = function(player)
		---------------------------------
		--local variable intializations--
		---------------------------------
		local ability = "mining"
		local miningRank = player.registry["mining_level"]
		local miningLearned = player.registry["learned_mining"]
		if player.gmLevel > 0 then
			miningRank = 15
		end
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
		local oreFailChance

		-- All of the ores that can be harvested, their MOB ID from the Mob DB.
		local ore01 = 51001 -- Small Ore Node
		local ore02 = 51002 -- Ore Node
		local ore03 = 51003 -- Large Ore Node
		local ore04 = 51010 -- Orichalcum Ore Node
		local ore05 = 51004 -- Heavy Ore Node
		local ore06 = 51005 -- Shining Ore Node
		local ore07 = 51006 -- Superior Ore Node
		local ore08 = 51007 -- High Ore Node
		local ore09 = 51011 -- Rosantium Ore Node
		local ore10 = 51008 -- Celestial Ore Node
		local ore11 = 51012 -- Irbynite Ore Node
		local ore12 = 51009 -- Hardened Celestial Ore Node
		 --

		--[[ Tool List -------
	- Basic Pickaxe:							4031
	- Quality Pickaxe:							4032
	- Superior Pickaxe: 						4033
	- Artisan Pickaxe:  						4034
	- Old Pickaxe:  							4035
	- Old Rusty Pickaxe:						4036
	- Busted Pickaxe:							4037
	- Copper Pickaxe (Ordianry Quality):		4038
	- Copper Pickaxe (Exceptional Quality):		4039
	- Copper Pickaxe (Superior Quality):		4040
	- Iron Pickaxe (Ordianry Quality):			4041
	- Iron Pickaxe (Exceptional Quality):		4042
	- Iron Herb Cutter (Superior Quality):		4043
	- Admantium Pickaxe (Ordianry Quality):		4044
	- Admantium Pickaxe (Exceptional Quality):	4045
	- Admantium Pickaxe (Superior Quality):		4046
	]] --Establish variables for the tools
		local toolDamage = tool.minDmg

		--Animations and sounds
		local anim01 = 315
		local anim02 = 331
		local sound01 = 352
		local sound02 = 353
		--End Declares ---------------------------------------------------------

		-- Do you even know mining?? ----------------------------------------
		--	if player.registry["learned_mining"] < 1 then
		--		player:talkSelf(0,"I don't know how to use this!")
		--		return
		--	end
		------------------------------------------------------------------------
		-- Apply Bonuses ---------------------------------------------------
		-- Do you even know Mining?? --
		if miningLearned ~= 0 then
			-- Tool based bonuses -----------------------------------------
			-- Tool based failure rates -----------------------------------
			if tool.id == 4031 then
				toolBonus = math.random(1, 1)
				toolFailChance = 7
			elseif tool.id == 4032 then
				toolBonus = math.random(1, 2)
				toolFailChance = 6
			elseif tool.id == 4033 then
				toolBonus = math.random(2, 2)
				toolFailChance = 5
			elseif tool.id == 4034 then
				toolBonus = math.random(2, 3)
				toolFailChance = 3
			elseif tool.id == 4035 then
				toolBonus = math.random(1, 1)
				toolFailChance = 7
			elseif tool.id == 4036 then
				toolBonus = math.random(1, 1)
				toolFailChance = 8
			elseif tool.id == 4037 then
				toolBonus = math.random(1, 1)
				toolFailChance = 9
			elseif tool.id == 4038 then
				toolBonus = math.random(1, 1)
				toolFailChance = 5
			elseif tool.id == 4039 then
				toolBonus = math.random(1, 2)
				toolFailChance = 4
			elseif tool.id == 4040 then
				toolBonus = math.random(1, 2)
				toolFailChance = 3
			elseif tool.id == 4041 then
				toolBonus = math.random(1, 2)
				toolFailChance = 3
			elseif tool.id == 4042 then
				toolBonus = math.random(1, 2)
				toolFailChance = 2
			elseif tool.id == 4043 then
				toolBonus = math.random(1, 2)
				toolFailChance = 1
			elseif tool.id == 4044 then
				toolBonus = math.random(2, 2)
				toolFailChance = 1
			elseif tool.id == 4045 then
				toolBonus = math.random(2, 2)
				toolFailChance = 0
			elseif tool.id == 4046 then
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

			if miningRank > 0 and miningRank <= 3 then
				amountGatheredMult = 0
				rankFailChance = 10
			elseif miningRank > 3 and miningRank <= 5 then
				amountGatheredMult = 0
				rankFailChance = 7
			elseif miningRank > 5 and miningRank <= 8 then
				amountGatheredMult = 0
				rankFailChance = 4
			elseif miningRank > 8 and miningRank <= 12 then
				amountGatheredMult = 1
				rankFailChance = 0
			elseif miningRank > 12 then
				amountGatheredMult = 2
				rankFailChance = -5
			else
				--Error Handler
				player:talkSelf(0, "ERROR: miningRank Registry: " .. miningRank)
			end
			-- End Rank Based Bonuses -------------------------------------------
			-- End Bonuses ---------------------------------------------------------

			-- Load mob parameters based on what mob is hit with the tool -----------------------
			if mob ~= nil then
				player:playSound(math.random(sound01, sound02))
				player:sendAnimation(anim01) -- You are hitting something
				---------------------------------------------------------------
				--[[
		ore01 = 51001 -- Small Ore Node
		ore02 = 51002 -- Ore Node
		ore03 = 51003 -- Large Ore Node
		ore04 = 51010 -- Orichalcum Ore Node
		ore05 = 51004 -- Heavy Ore Node
		ore06 = 51005 -- Shining Ore Node
		ore07 = 51006 -- Superior Ore Node
		ore08 = 51007 -- High Ore Node
		ore09 = 51011 -- Rosantium Ore Node
		ore10 = 51008 -- Celestial Ore Node
		ore11 = 51012 -- Irbynite Ore Node
		ore12 = 51009 -- Hardened Celestial Ore Node
		--]]
				oreName = mob.name

				if mob.mobID == ore01 then
					oreDBName = "coal_ore"
					duraloss = 1
					oreFailChance = 3
				elseif mob.mobID == ore02 then
					oreDBName = "copper_ore"
					duraloss = 3
					oreFailChance = 3
				elseif mob.mobID == ore03 then
					oreDBName = "tin_ore"
					duraloss = 6
					oreFailChance = 5
				elseif mob.mobID == ore04 then
					oreDBName = "orichalcum_ore"
					duraloss = 10
					oreFailChance = 7
				elseif mob.mobID == ore05 then
					oreDBName = "iron_ore"
					duraloss = 25
					oreFailChance = 7
				elseif mob.mobID == ore06 then
					oreDBName = "celestial_silver_ore"
					duraloss = 40
					oreFailChance = 7
				elseif mob.mobID == ore07 then
					oreDBName = "mornanium_ore"
					duraloss = 80
					oreFailChance = 8
				elseif mob.mobID == ore08 then
					oreDBName = "admantium_ore"
					duraloss = 200
					oreFailChance = 9
				elseif mob.mobID == ore09 then
					oreDBName = "rosantium_ore"
					duraloss = 400
					oreFailChance = 10
				elseif mob.mobID == ore10 then
					oreDBName = "sky_iron_ore"
					duraloss = 1000
					oreFailChance = 10
				elseif mob.mobID == ore11 then
					oreDBName = "irbynite_ore"
					duraloss = 1750
					oreFailChance = 12
				elseif mob.mobID == ore12 then
					--]]
					oreDBName = "duranium_ore"
					duraloss = 2500
					oreFailChance = 15
				else
					-- error handler
				end

				-- End Mob Parameters ------------------------------------------------------------

				-- Calculate total failure chance ----------------------------------------------
				failChance = toolFailChance + rankFailChance + oreFailChance

				if failChance <= 0 then
					failChance = 1
				end

				-- Check ranks to determine what ores can be harvested ------------------------
				-- Rank 1: Beginner --
				if miningRank == 1 then
					-- Rank 2: Novice --
					if mob.mobID == ore01 or mob.mobID == ore02 then
						player:deductDura(EQ_WEAP, duraloss)
						player:sendAnimationXY(anim02, mob.x, mob.y)
						mob.attacker = 0
						mob:removeHealthWithoutDamageNumbers(toolDamage)
						skillEXP = mob.experience

						if mob.health < 1 then
							amountGatheredMult = amountGatheredMult + toolBonus

							failureRoll = math.random(1, 100)

							if failureRoll <= failChance then
								player:sendMinitext("This ore crumbled to dust!!")
								skillEXP = math.floor(skillEXP / 2)
								skill.leveling(player, skillEXP, ability)
								return
							end

							if amountGatheredMult == 1 then
								player:sendMinitext("I mined a " .. oreName)
							else
								player:sendMinitext("I mined " .. amountGatheredMult .. " " .. oreName .. "s!")
								skillEXP = skillEXP * amountGatheredMult
							end

							skill.leveling(player, skillEXP, "mining")
							player:addItem(oreDBName, amountGatheredMult)
						end
					elseif mob.mobID == ore03 then
						player:talkSelf(0, "I nearly understand how to mine this one!!! ")
					elseif mob.mobID >= ore04 and mob.mobID <= ore12 then
						player:talkSelf(0, "There is no way, I am too clumsy for this!!!")
					else
						player:sendMinitext("I cannot use the Pick Axe on this!!!")
						return
					end
				elseif miningRank == 2 then
					-- Rank 3: Trainee --
					if mob.mobID == ore01 or mob.mobID == ore02 then
						player:deductDura(EQ_WEAP, duraloss)
						player:sendAnimationXY(anim02, mob.x, mob.y)
						mob.attacker = 0
						mob:removeHealth(toolDamage)
						skillEXP = mob.experience

						if mob.health < 1 then
							amountGatheredMult = amountGatheredMult + toolBonus

							failureRoll = math.random(1, 100)

							if failureRoll <= failChance then
								player:sendMinitext("This ore crumbled to dust!!")
								skillEXP = math.floor(skillEXP / 2)
								skill.leveling(player, skillEXP, ability)
								return
							end

							if amountGatheredMult == 1 then
								player:sendMinitext("I mined a " .. oreName)
							else
								player:sendMinitext("I mined " .. amountGatheredMult .. " " .. oreName .. "s!")
								skillEXP = skillEXP * amountGatheredMult
							end

							skill.leveling(player, skillEXP, "mining")
							player:addItem(oreDBName, amountGatheredMult)
						end
					elseif mob.mobID == ore03 then
						player:talkSelf(0, "I nearly understand how to mine this one!!!")
					elseif mob.mobID >= ore04 and mob.mobID <= ore12 then
						player:talkSelf(0, "There is no way, I am too clumsy for this!!!")
					else
						player:sendMinitext("I cannot use the Pick Axe on this!!!")
					end
				elseif miningRank == 3 then
					-- Rank 4: Apprentice --
					if mob.mobID == ore01 or mob.mobID == ore02 or mob.mobID == ore03 then
						player:deductDura(EQ_WEAP, duraloss)
						player:sendAnimationXY(anim02, mob.x, mob.y)
						mob.attacker = 0
						mob:removeHealth(toolDamage)
						skillEXP = mob.experience

						if mob.health < 1 then
							amountGatheredMult = amountGatheredMult + toolBonus

							failureRoll = math.random(1, 100)

							if failureRoll <= failChance then
								player:sendMinitext("This ore crumbled to dust!!")
								skillEXP = math.floor(skillEXP / 2)
								skill.leveling(player, skillEXP, ability)
								return
							end

							if amountGatheredMult == 1 then
								player:sendMinitext("I mined a " .. oreName)
							else
								player:sendMinitext("I mined " .. amountGatheredMult .. " " .. oreName .. "s!")
								skillEXP = skillEXP * amountGatheredMult
							end

							skill.leveling(player, skillEXP, "mining")
							player:addItem(oreDBName, amountGatheredMult)
						end
					elseif mob.mobID >= ore04 and mob.mobID <= ore12 then
						player:talkSelf(0, "There is no way, I am too clumsy for this!!!")
					else
						player:sendMinitext("I cannot use the Pickaxe on this!!!")
					end
				elseif miningRank == 4 then
					-- Rank 5: Greenhorn --
					if mob.mobID == ore01 or mob.mobID == ore02 or mob.mobID == ore03 or mob.mobID == ore04 then
						player:deductDura(EQ_WEAP, duraloss)
						player:sendAnimationXY(anim02, mob.x, mob.y)
						mob.attacker = 0
						mob:removeHealth(toolDamage)
						skillEXP = mob.experience

						if mob.health < 1 then
							amountGatheredMult = amountGatheredMult + toolBonus

							failureRoll = math.random(1, 100)

							if failureRoll <= failChance then
								player:sendMinitext("This ore crumbled to dust!!")
								skillEXP = math.floor(skillEXP / 2)
								skill.leveling(player, skillEXP, ability)
								return
							end

							if amountGatheredMult == 1 then
								player:sendMinitext("I mined a " .. oreName)
							else
								player:sendMinitext("I mined " .. amountGatheredMult .. " " .. oreName .. "s!")
								skillEXP = skillEXP * amountGatheredMult
							end

							skill.leveling(player, skillEXP, "mining")
							player:addItem(oreDBName, amountGatheredMult)
						end
					elseif mob.mobID == ore05 then
						player:talkSelf(0, "I nearly understand how to mine this one!!!")
					elseif mob.mobID >= ore06 and mob.mobID <= ore12 then
						player:talkSelf(0, "There is no way, I am too clumsy for this!!!")
					else
						player:sendMinitext("I cannot use the Pickaxe on this!!!")
					end
				elseif miningRank == 5 then
					-- Rank 6: Aspirant --
					if mob.mobID == ore01 or mob.mobID == ore02 or mob.mobID == ore03 or mob.mobID == ore04 or mob.mobID == ore05 then
						player:deductDura(EQ_WEAP, duraloss)
						player:sendAnimationXY(anim02, mob.x, mob.y)
						mob.attacker = 0
						mob:removeHealth(toolDamage)
						skillEXP = mob.experience
						if mob.health < 1 then
							amountGatheredMult = amountGatheredMult + toolBonus

							failureRoll = math.random(1, 100)

							if failureRoll <= failChance then
								player:sendMinitext("This ore crumbled to dust!!")
								skillEXP = math.floor(skillEXP / 2)
								skill.leveling(player, skillEXP, ability)
								return
							end

							if amountGatheredMult == 1 then
								player:sendMinitext("I mined a " .. oreName)
							else
								player:sendMinitext("I mined " .. amountGatheredMult .. " " .. oreName .. "s!")
								skillEXP = skillEXP * amountGatheredMult
							end

							skill.leveling(player, skillEXP, "mining")
							player:addItem(oreDBName, amountGatheredMult)
						end
					elseif mob.mobID == ore06 then
						player:talkSelf(0, "I nearly understand how to mine this one!!!")
					elseif mob.mobID >= ore07 and mob.mobID <= ore12 then
						player:talkSelf(0, "There is no way, I am too clumsy for this!!!")
					else
						player:sendMinitext("I cannot use the Pickaxe on this!!!")
					end
				elseif miningRank == 6 then
					-- Rank 7: Amateur --
					if mob.mobID == ore01 or mob.mobID == ore02 or mob.mobID == ore03 or mob.mobID == ore04 or mob.mobID == ore05 then
						player:deductDura(EQ_WEAP, duraloss)
						player:sendAnimationXY(anim02, mob.x, mob.y)
						mob.attacker = 0
						mob:removeHealth(toolDamage)
						skillEXP = mob.experience
						if mob.health < 1 then
							amountGatheredMult = amountGatheredMult + toolBonus

							failureRoll = math.random(1, 100)

							if failureRoll <= failChance then
								player:sendMinitext("This ore crumbled to dust!!")
								skillEXP = math.floor(skillEXP / 2)
								skill.leveling(player, skillEXP, ability)
								return
							end

							if amountGatheredMult == 1 then
								player:sendMinitext("I mined a " .. oreName)
							else
								player:sendMinitext("I mined " .. amountGatheredMult .. " " .. oreName .. "s!")
								skillEXP = skillEXP * amountGatheredMult
							end

							skill.leveling(player, skillEXP, "mining")
							player:addItem(oreDBName, amountGatheredMult)
						end
					elseif mob.mobID == ore06 then
						player:talkSelf(0, "I nearly understand how to mine this one!!!")
					elseif mob.mobID >= ore07 and mob.mobID <= ore12 then
						player:talkSelf(0, "There is no way, I am too clumsy for this!!!")
					else
						player:sendMinitext("I cannot use the Pickaxe on this!!!")
					end
				elseif miningRank == 7 then
					-- Rank 8: Journeyman --
					if
						mob.mobID == ore01 or mob.mobID == ore02 or mob.mobID == ore03 or mob.mobID == ore04 or mob.mobID == ore05 or
							mob.mobID == ore06
					 then
						player:deductDura(EQ_WEAP, duraloss)
						player:sendAnimationXY(anim02, mob.x, mob.y)
						mob.attacker = 0
						mob:removeHealth(toolDamage)
						skillEXP = mob.experience
						if mob.health < 1 then
							amountGatheredMult = amountGatheredMult + toolBonus

							failureRoll = math.random(1, 100)

							if failureRoll <= failChance then
								player:sendMinitext("This ore crumbled to dust!!")
								skillEXP = math.floor(skillEXP / 2)
								skill.leveling(player, skillEXP, ability)
								return
							end

							if amountGatheredMult == 1 then
								player:sendMinitext("I mined a " .. oreName)
							else
								player:sendMinitext("I mined " .. amountGatheredMult .. " " .. oreName .. "s!")
								skillEXP = skillEXP * amountGatheredMult
							end

							skill.leveling(player, skillEXP, "mining")
							player:addItem(oreDBName, amountGatheredMult)
						end
					elseif mob.mobID == ore07 then
						player:talkSelf(0, "I nearly understand how to mine this one!!!")
					elseif mob.mobID >= ore08 and mob.mobID <= ore12 then
						player:talkSelf(0, "There is no way, I am too clumsy for this!!!")
					else
						player:sendMinitext("I cannot use the Pickaxe on this!!!")
					end
				elseif miningRank == 8 then
					-- Rank 9: Adept --
					if
						mob.mobID == ore01 or mob.mobID == ore02 or mob.mobID == ore03 or mob.mobID == ore04 or mob.mobID == ore05 or
							mob.mobID == ore06 or
							mob.mobID == ore07
					 then
						player:deductDura(EQ_WEAP, duraloss)
						player:sendAnimationXY(anim02, mob.x, mob.y)
						mob.attacker = 0
						mob:removeHealth(toolDamage)
						skillEXP = mob.experience
						if mob.health < 1 then
							amountGatheredMult = amountGatheredMult + toolBonus

							failureRoll = math.random(1, 100)

							if failureRoll <= failChance then
								player:sendMinitext("This ore crumbled to dust!!")
								skillEXP = math.floor(skillEXP / 2)
								skill.leveling(player, skillEXP, ability)
								return
							end

							if amountGatheredMult == 1 then
								player:sendMinitext("I mined a " .. oreName)
							else
								player:sendMinitext("I mined " .. amountGatheredMult .. " " .. oreName .. "s!")
								skillEXP = skillEXP * amountGatheredMult
							end

							skill.leveling(player, skillEXP, "mining")
							player:addItem(oreDBName, amountGatheredMult)
						end
					elseif mob.mobID == ore08 then
						player:talkSelf(0, "I nearly understand how to mine this one!!!")
					elseif mob.mobID >= ore09 and mob.mobID <= ore11 then
						player:talkSelf(0, "There is no way, I am too clumsy for this!!!")
					else
						player:sendMinitext("I cannot use the Pickaxe on this!!!")
					end
				elseif miningRank == 9 then
					-- Rank 10: Skilled --
					if
						mob.mobID == ore01 or mob.mobID == ore02 or mob.mobID == ore03 or mob.mobID == ore04 or mob.mobID == ore05 or
							mob.mobID == ore06 or
							mob.mobID == ore07
					 then
						player:deductDura(EQ_WEAP, duraloss)
						player:sendAnimationXY(anim02, mob.x, mob.y)
						mob.attacker = 0
						mob:removeHealth(toolDamage)
						skillEXP = mob.experience
						if mob.health < 1 then
							amountGatheredMult = amountGatheredMult + toolBonus

							failureRoll = math.random(1, 100)

							if failureRoll <= failChance then
								player:sendMinitext("This ore crumbled to dust!!")
								skillEXP = math.floor(skillEXP / 2)
								skill.leveling(player, skillEXP, ability)
								return
							end

							if amountGatheredMult == 1 then
								player:sendMinitext("I mined a " .. oreName)
							else
								player:sendMinitext("I mined " .. amountGatheredMult .. " " .. oreName .. "s!")
								skillEXP = skillEXP * amountGatheredMult
							end

							skill.leveling(player, skillEXP, "mining")
							player:addItem(oreDBName, amountGatheredMult)
						end
					elseif mob.mobID == ore08 then
						player:talkSelf(0, "I nearly understand how to mine this one!!!")
					elseif mob.mobID >= ore09 and mob.mobID <= ore12 then
						player:talkSelf(0, "There is no way, I am too clumsy for this!!!")
					else
						player:sendMinitext("I cannot use the Pickaxe on this!!!")
					end
				elseif miningRank == 10 then
					-- Rank 11: Expert --
					if
						mob.mobID == ore01 or mob.mobID == ore02 or mob.mobID == ore03 or mob.mobID == ore04 or mob.mobID == ore05 or
							mob.mobID == ore06 or
							mob.mobID == ore07 or
							mob.mobID == ore08
					 then
						player:deductDura(EQ_WEAP, duraloss)
						player:sendAnimationXY(anim02, mob.x, mob.y)
						mob.attacker = 0
						mob:removeHealth(toolDamage)
						skillEXP = mob.experience
						if mob.health < 1 then
							amountGatheredMult = amountGatheredMult + toolBonus

							failureRoll = math.random(1, 100)

							if failureRoll <= failChance then
								player:sendMinitext("This ore crumbled to dust!!")
								skillEXP = math.floor(skillEXP / 2)
								skill.leveling(player, skillEXP, ability)
								return
							end

							if amountGatheredMult == 1 then
								player:sendMinitext("I mined a " .. oreName)
							else
								player:sendMinitext("I mined " .. amountGatheredMult .. " " .. oreName .. "s!")
								skillEXP = skillEXP * amountGatheredMult
							end

							skill.leveling(player, skillEXP, "mining")
							player:addItem(oreDBName, amountGatheredMult)
						end
					elseif mob.mobID == ore09 then
						player:talkSelf(0, "I nearly understand how to mine this one!!!")
					elseif mob.mobID >= ore10 and mob.mobID <= ore12 then
						player:talkSelf(0, "There is no way, I am too clumsy for this!!!")
					else
						player:sendMinitext("I cannot use the Pickaxe on this!!!")
					end
				elseif miningRank == 11 then
					-- Rank 12: Artisan --
					if
						mob.mobID == ore01 or mob.mobID == ore02 or mob.mobID == ore03 or mob.mobID == ore04 or mob.mobID == ore05 or
							mob.mobID == ore06 or
							mob.mobID == ore07 or
							mob.mobID == ore08 or
							mob.mobID == ore09
					 then
						player:deductDura(EQ_WEAP, duraloss)
						player:sendAnimationXY(anim02, mob.x, mob.y)
						mob.attacker = 0
						mob:removeHealth(toolDamage)
						skillEXP = mob.experience
						if mob.health < 1 then
							amountGatheredMult = amountGatheredMult + toolBonus

							failureRoll = math.random(1, 100)

							if failureRoll <= failChance then
								player:sendMinitext("This ore crumbled to dust!!")
								skillEXP = math.floor(skillEXP / 2)
								skill.leveling(player, skillEXP, ability)
								return
							end

							if amountGatheredMult == 1 then
								player:sendMinitext("I mined a " .. oreName)
							else
								player:sendMinitext("I mined " .. amountGatheredMult .. " " .. oreName .. "s!")
								skillEXP = skillEXP * amountGatheredMult
							end

							skill.leveling(player, skillEXP, "mining")
							player:addItem(oreDBName, amountGatheredMult)
						end
					elseif mob.mobID == ore10 then
						player:talkSelf(0, "I nearly understand how to mine this one!!!")
					elseif mob.mobID >= ore11 and mob.mobID <= ore12 then
						player:talkSelf(0, "There is no way, I am too clumsy for this!!!")
					else
						player:sendMinitext("I cannot use the Pickaxe on this!!!")
					end
				elseif miningRank == 12 then
					-- Rank 13: Prodigy --
					if
						mob.mobID == ore01 or mob.mobID == ore02 or mob.mobID == ore03 or mob.mobID == ore04 or mob.mobID == ore05 or
							mob.mobID == ore06 or
							mob.mobID == ore07 or
							mob.mobID == ore08 or
							mob.mobID == ore09
					 then
						player:deductDura(EQ_WEAP, duraloss)
						player:sendAnimationXY(anim02, mob.x, mob.y)
						mob.attacker = 0
						mob:removeHealth(toolDamage)
						skillEXP = mob.experience
						if mob.health < 1 then
							amountGatheredMult = amountGatheredMult + toolBonus

							failureRoll = math.random(1, 100)

							if failureRoll <= failChance then
								player:sendMinitext("This ore crumbled to dust!!")
								skillEXP = math.floor(skillEXP / 2)
								skill.leveling(player, skillEXP, ability)
								return
							end

							if amountGatheredMult == 1 then
								player:sendMinitext("I mined a " .. oreName)
							else
								player:sendMinitext("I mined " .. amountGatheredMult .. " " .. oreName .. "s!")
								skillEXP = skillEXP * amountGatheredMult
							end

							skill.leveling(player, skillEXP, "mining")
							player:addItem(oreDBName, amountGatheredMult)
						end
					elseif mob.mobID == ore10 then
						player:talkSelf(0, "I nearly understand how to mine this one!!!")
					elseif mob.mobID >= ore11 and mob.mobID <= ore12 then
						player:talkSelf(0, "There is no way, I am too clumsy for this!!!")
					else
						player:sendMinitext("I cannot use the Pickaxe on this!!!")
					end
				elseif miningRank == 13 then
					-- Rank 14: Virtuoso --
					if
						mob.mobID == ore01 or mob.mobID == ore02 or mob.mobID == ore03 or mob.mobID == ore04 or mob.mobID == ore05 or
							mob.mobID == ore06 or
							mob.mobID == ore07 or
							mob.mobID == ore08 or
							mob.mobID == ore09 or
							mob.mobID == ore10
					 then
						player:deductDura(EQ_WEAP, duraloss)
						player:sendAnimationXY(anim02, mob.x, mob.y)
						mob.attacker = 0
						mob:removeHealth(toolDamage)
						skillEXP = mob.experience
						if mob.health < 1 then
							amountGatheredMult = amountGatheredMult + toolBonus

							failureRoll = math.random(1, 100)

							if failureRoll <= failChance then
								player:sendMinitext("This ore crumbled to dust!!")
								skillEXP = math.floor(skillEXP / 2)
								skill.leveling(player, skillEXP, ability)
								return
							end

							if amountGatheredMult == 1 then
								player:sendMinitext("I mined a " .. oreName)
							else
								player:sendMinitext("I mined " .. amountGatheredMult .. " " .. oreName .. "s!")
								skillEXP = skillEXP * amountGatheredMult
							end

							skill.leveling(player, skillEXP, "mining")
							player:addItem(oreDBName, amountGatheredMult)
						end
					elseif mob.mobID == ore11 then
						player:talkSelf(0, "I nearly understand how to mine this one!!!")
					elseif mob.mobID >= ore12 then
						player:talkSelf(0, "There is no way, I am too clumsy for this!!!")
					else
						player:sendMinitext("I cannot use the Pickaxe on this!!!")
					end
				elseif miningRank == 14 then
					-- Rank 15: Master --
					if
						mob.mobID == ore01 or mob.mobID == ore02 or mob.mobID == ore03 or mob.mobID == ore04 or mob.mobID == ore05 or
							mob.mobID == ore06 or
							mob.mobID == ore07 or
							mob.mobID == ore08 or
							mob.mobID == ore09 or
							mob.mobID == ore10 or
							mob.mobID == ore11
					 then
						player:deductDura(EQ_WEAP, duraloss)
						player:sendAnimationXY(anim02, mob.x, mob.y)
						mob.attacker = 0
						mob:removeHealth(toolDamage)
						skillEXP = mob.experience
						if mob.health < 1 then
							amountGatheredMult = amountGatheredMult + toolBonus

							failureRoll = math.random(1, 100)

							if failureRoll <= failChance then
								player:sendMinitext("This ore crumbled to dust!!")
								skillEXP = math.floor(skillEXP / 2)
								skill.leveling(player, skillEXP, ability)
								return
							end

							if amountGatheredMult == 1 then
								player:sendMinitext("I mined a " .. oreName)
							else
								player:sendMinitext("I mined " .. amountGatheredMult .. " " .. oreName .. "s!")
								skillEXP = skillEXP * amountGatheredMult
							end

							skill.leveling(player, skillEXP, "mining")
							player:addItem(oreDBName, amountGatheredMult)
						end
					elseif mob.mobID == ore12 then
						player:talkSelf(0, "I nearly understand how to mine this one!!!")
					else
						player:sendMinitext("I cannot use the Pickaxe on this!!!")
					end
				elseif miningRank >= 15 then
					if
						mob.mobID == ore01 or mob.mobID == ore02 or mob.mobID == ore03 or mob.mobID == ore04 or mob.mobID == ore05 or
							mob.mobID == ore06 or
							mob.mobID == ore07 or
							mob.mobID == ore08 or
							mob.mobID == ore09 or
							mob.mobID == ore10 or
							mob.mobID == ore11 or
							mob.mobID == ore12
					 then
						player:deductDura(EQ_WEAP, duraloss)
						player:sendAnimationXY(anim02, mob.x, mob.y)
						mob.attacker = 0
						mob:removeHealth(toolDamage)
						skillEXP = mob.experience
						if mob.health < 1 then
							amountGatheredMult = amountGatheredMult + toolBonus

							failureRoll = math.random(1, 100)

							if failureRoll <= failChance then
								player:sendMinitext("This ore crumbled to dust!!")
								skillEXP = math.floor(skillEXP / 2)
								skill.leveling(player, skillEXP, ability)
								return
							end

							if amountGatheredMult == 1 then
								player:sendMinitext("I mined a " .. oreName)
							else
								player:sendMinitext("I mined " .. amountGatheredMult .. " " .. oreName .. "s!")
								skillEXP = skillEXP * amountGatheredMult
							end

							skill.leveling(player, skillEXP, "mining")
							player:addItem(oreDBName, amountGatheredMult)
						end
					else
						-- Rank 16: Grand-Master --
						-- End Mining Level Checks ----------------------------------------------------
						player:sendMinitext("I cannot use the Pickaxe on this!!!")
					end
				else
					player:talkSelf(0, "I apparently don't know enough to mine this properly!")
				end
			else
				--player:talkSelfSelf(0,"I am swinging at the air!!!")
			end
		else
			player:talkSelf(0, "I need to train in the mining skill to mine ores!")
		end
	end
}
