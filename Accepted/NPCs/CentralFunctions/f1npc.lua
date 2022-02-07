f1npc = {
	click = async(
		function(player, npc)
			local t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0

			local opts = {}
			local opts2 = {}
			local opts3 = {}
			local deathPileFound = 0
			if player:hasDuration("dre_locs_drain") then
				player:popUp("You can't even think, Dre Loc's magic is overwhelming you.")
				return
			end

			local deathPile = player:getObjectsInArea(BL_ITEM) --added 4/2/17 for death pile recovery
			if #deathPile > 0 then
				for i = 1, #deathPile do
					if distanceSquare(player, deathPile[i], 3) then
						if deathPile[i].cursed == player.ID then
							deathPileFound = 1
						elseif deathPile[i].cursed > 0 and player.gmLevel > 0 then
							deathPileFound = 1
						end
					end
				end
			end

			if player.gmLevel > 0 then
				table.insert(opts, "GM Menu")
			end
			if player.state == 1 then
				table.insert(opts, "Silver thread")
			end

			if deathPileFound == 1 and player.state ~= 1 then
				table.insert(opts, "Recover Death Pile")
			end --added 4/2/17 for death pile recovery

			if
				player.m == 1 --[[or player.gmLevel > 0]] or player.m == 4090 or
					(player.m == 1000 and (player.x >= 45 and player.x <= 132 and player.y >= 40 and player.y <= 70))
			 then
				table.insert(opts, "Vending")
			end

			table.insert(opts, "Divine Light Status")
			table.insert(opts, "Spend SP")
			table.insert(opts, "Character Status")
			table.insert(opts, "Quest Log")
			table.insert(opts, "Bestiary")
			table.insert(opts, "Cave Chart")
			table.insert(opts, "Spellbook")
			table.insert(opts, "Character Info")

			-------------------------------ACTIVATION-----------------------------------
			if (player.actId == 0) then
				table.insert(opts, "Activate")
			end

			--table.insert(opts, "Reputation")

			--table.insert(opts, "Crafting Journal")
			--table.insert(opts, "Item Journal")
			--table.insert(opts, "Away Mode")
			--table.insert(opts, "Delete Item")

			table.insert(opts2, "Character Titles")
			table.insert(opts2, "Ability Info")
			table.insert(opts2, "Toggle Extra Spell Info")
			table.insert(opts2, "Toggle See Warps")
			table.insert(opts2, "Set AFK Message")

			if (player.profileStatus == 0) then
				table.insert(opts2, "Show Player Profile")
			else
				table.insert(opts2, "Hide Player Profile")
			end

			if (player.miniMapToggle == 0) then
				table.insert(opts2, "Enable MiniMap")
			else
				table.insert(opts2, "Disable MiniMap")
			end

			if player.gmLevel > 0 then
				if player.ID == 2 or player.ID == 3 or player.ID == 4 or player.ID == 5 or player.ID == 6 or player.ID == 7 then
					table.insert(opts3, "God Tools")
					table.insert(opts3, "Private Tools")
					if player.m >= 15000 and player.m < 16000 then
						table.insert(opts3, "Minigame Powers")
					end
				end
			end

			if morna2.checkID(player) == true or player.ID == 2 then
				table.insert(opts3, "Team Morna")
			end

			if player.registry["exp_maxes"] >= 1 then
				table.insert(opts, "Exchange EXP Max [Current: " .. player.registry["exp_maxes"] .. "]")
			end

			table.insert(opts, "Exit")

			if player.gmLevel > 0 then
				menu =
					player:menuString(
					"<b>[Main Menu]\n\n" ..
						os.date() ..
							"\n(" ..
								get_totem_time(player) ..
									" Time)\n" .. player.mapTitle .. " (" .. player.m .. ", X: " .. player.x .. " , Y: " .. player.y .. ")",
					opts
				)
			else
				menu =
					player:menuString(
					"<b>[Main Menu]\n\n" ..
						os.date() ..
							"\n(" ..
								get_totem_time(player) .. " Time)\n" .. player.mapTitle .. "(X: " .. player.x .. " , Y: " .. player.y .. ")",
					opts
				)
			end

			if menu == "GM Menu" then
				menu = player:menuString("<b>[GM Menu]\n\nWhat would you like to do?", opts3)
				if menu == "God Tools" then
					god_tools.f1click(player, npc)
				elseif menu == "Team Morna" then
					morna2.click(player, npc)
				elseif menu == "Private Tools" then
					private_tools.click(player, npc)
				elseif menu == "Minigame Powers" then
					minigame_powers.f1click(player, npc)
				end
			elseif menu == "Quest Log" then
				questLog.click(player, npc)
			elseif menu == "Cave Chart" then
				cave_chart.click(player, npc)
			elseif menu == "Spellbook" then
				player:spellBook(npc)
			elseif menu == "Bestiary" then
				bestiary.click(player, npc)
			elseif menu == "Bestiary test" then
				bestiary.clicktest(player, npc)
			elseif menu == "Spend SP" then
				spend_sp.click(player, npc)
			elseif menu == "Exchange EXP Max [Current: " .. player.registry["exp_maxes"] .. "]" then
				-----------------------------------------------------
				-- Reputation menu ----------------------------------
				-----------------------------------------------------
				--elseif menu == "Reputation" then
				--	--[[ setup greeting based off of disposition.  This is shown in the menu dialog.
				--	529200 -- 604800            max value /super likes ya
				--	378000 -- 529199            likes you
				--	226800 -  302400 - 377999   Alright with ya
				--	075600 -- 226799            Does not want you around, but does not remove you.
				--	000000 -- 075599            Lowest you can go, keeps won't talk to you.
				--	]]--
				--	local npcid = {296, 297, 298}
				--	local npcRep = {}
				--
				--	for i = 1, #npcid do
				--		if player.registry["disposition_"..npcid[i]] > 0 then
				--			table.insert(npcRep, ""..NPC(npcid[i]).name)
				--		end
				--	end
				--
				--	if #npcRep > 0 then
				--
				--		menu = player:menuString("Check your reputation with who?", npcRep)
				--		for i = 1, #npcRep do
				--
				--			if menu == ""..NPC(npcid[i]).name then
				--
				--				local localDispo = player.registry["disposition_"..npcid[i]]
				--				local lastTalkTime = player.registry["last_talk_time_"..npcid[i]]
				--				local lastRepCheckTime = player.registry["last_repcheck_time_"..npcid[i]]
				--
				--				local timeSinceLastTalkSeconds = (os.time() - lastTalkTime)
				--				local timeSinceLastTalkDays = math.floor((timeSinceLastTalkSeconds / 86400))
				--				local dayRemovedSecondsLeft = timeSinceLastTalkSeconds - (timeSinceLastTalkDays * 86400)
				--				local timeSinceLastTalkHours = math.floor((dayRemovedSecondsLeft / 3600))
				--				local hoursRemovedSecondsLeft = timeSinceLastTalkSeconds - (timeSinceLastTalkHours * 3600)
				--				local timeSinceLastTalkMinutes = math.floor((hoursRemovedSecondsLeft / 60))
				--				local minutesRemovedSecondsLeft = hoursRemovedSecondsLeft - (timeSinceLastTalkMinutes * 60)
				--
				--				local timeSinceLastRepCheckSeconds = (os.time() - lastRepCheckTime)
				--
				--				local lastTalkTimeString = os.date("%a, %b %d %Y @ %I:%M:%S %p",lastTalkTime)
				--
				--				local newLocalDispo = setDisposition(player, npcid[i], 1, 0)
				--				-- How far above or below neutral are you with this NPC??
				--				local dispoOffsetFromNeutral = (302400 - newLocalDispo)  -- 302400 is Half of a Week, our mid-point.  Neutral.
				--				-- If this comes out negative, you are good with the NPC.
				--
				--				-- 86400 is 24 hours.
				--				-- How long is it since you last talked to the NPC?
				--				local deltaTalkTime = timeSinceLastTalkSeconds
				--
				--				local timeToForgetMin = round(((86400 - timeSinceLastTalkSeconds) / 60))    -- 86400 / 60 = 1440 (Number of minutes in a day)
				--				local timeToForgetHour = round(((86400 - timeSinceLastTalkSeconds) / 3600)) -- 86400 / 3600 = 24 (Number of hours in a day)
				--				if timeToForgetHour < 0 then
				--					timeToForgetHour = 0
				--				end
				--				if timeToForgetMin < 0 then
				--					timeToForgetMin = 0
				--				end
				--
				--				local daysToNeutral
				--
				--				local repPercent = (newLocalDispo / 604800) * 100
				--				local statusString = ""
				--
				--				local minToNeutral = 0
				--				local minToNeutralNoForget = 0
				--
				--				if repPercent >= 0 and repPercent < 12.5 then
				--					displayBar = "	         |-E-----------------|       "
				--					statusString = "Hated"
				--				elseif repPercent >= 12.5 and repPercent < 37.5 then
				--					displayBar = "	         |----E--------------|       "
				--					statusString = "Loathed"
				--				elseif repPercent >= 37.5 and repPercent < 50.0 then
				--					displayBar = "	         |------E------------|       "
				--					statusString = "Disliked"
				--				elseif repPercent == 50.0  then
				--					displayBar = "	         |---------N---------|       "
				--					statusString = "Neutral"
				--				elseif repPercent > 50.0 and repPercent < 62.5 then
				--					displayBar = "	         |-----------G-------|       "
				--					statusString = "Liked"
				--				elseif repPercent >= 62.5 and repPercent < 87.5 then
				--					displayBar = "	         |-------------G-----|       "
				--					statusString = "Revered"
				--				elseif repPercent >= 87.5 and repPercent < 100 then
				--					displayBar = "	         |----------------G--|       "
				--					statusString = "Exalted"
				--				else
				--					statusString = "ERROR: Invalid RepPercent"
				--				end
				--
				--				if dispoOffsetFromNeutral > 0 then
				--					dispoOffsetFromNeutralDisplay = "Dis-Liked "..math.abs(dispoOffsetFromNeutral)
				--					minToNeutral = round((dispoOffsetFromNeutral / 60),2).." Minutes"
				--
				--				elseif dispoOffsetFromNeutral == 0 then
				--					dispoOffsetFromNeutralDisplay = "At Neutral"
				--
				--				elseif dispoOffsetFromNeutral < 0 then
				--
				--					if deltaTalkTime > 86400 then -- stop a deduction from your disposition if you have talked to him in the  last day.
				--						dispoOffsetFromNeutralDisplay = "Liked "..math.abs(dispoOffsetFromNeutral)
				--					end
				--
				--					dispoOffsetFromNeutralDisplay = "Liked "..math.abs(dispoOffsetFromNeutral)
				--					minToNeutral = math.abs(round((dispoOffsetFromNeutral / 60),2)) + math.abs(timeToForgetMin)
				--					minToNeutralNoForget = math.abs(round((dispoOffsetFromNeutral / 60),2))
				--
				--				end
				--
				--				popup = "<b>           | "..npcRep[i].." |\n"
				--				popup = popup.."+=====================================+\n"
				--				popup = popup.."             | Reputation |            \n"
				--				popup = popup.."             +============+              "
				--				popup = popup.."	                                     "
				--				popup = popup.."  	       Hated    Neutral   Exalted    "
				--				popup = popup.."	         |         |         |       "
				--				popup = popup..""..displayBar..""
				--				if player.gmLevel > 0 then
				--					popup = popup.."	         |    |    |    |    |       "
				--					popup = popup.."	       00000  |  302400 |  604800    "
				--					popup = popup.."	            075600    378000         "
				--				end
				--				popup = popup.."	                                     "
				--				popup = popup.."<b>          Current Rep: "..statusString.."\n"
				--				--if player.gmLevel > 0 then
				--					popup = popup.."<b>          Current Rep: "..player.registry["disposition_"..npcid[i]]..""
				--				--end
				--				popup = popup.."	                                    \n"
				--				if player.gmLevel > 0 then
				--					popup = popup.."       Current Time: "..os.time().."\n"
				--					popup = popup.."     Last Talk Time: "..player.registry["last_talk_time_"..npcid[i]].."\n"
				--					popup = popup.."  ============================== \n"
				--					popup = popup.."   Sec Since Talked: "..timeSinceLastTalkSeconds.."\n"
				--					popup = popup.."\n"
				--					popup = popup.."Last Rep Check Time: "..player.registry["last_repcheck_time_"..npcid[i]].."\n"
				--					popup = popup.."Sec Since Rep Check: "..timeSinceLastRepCheckSeconds.."\n"
				--					popup = popup.."+=====================================+\n"
				--					popup = popup.."       + / - Neutral: "..dispoOffsetFromNeutralDisplay.."\n"
				--					popup = popup.."\n"
				--					popup = popup.."  Minutes to Neutral: "..minToNeutralNoForget.." Minutes \n"
				--					popup = popup.."   Minutes to Forget: "..timeToForgetMin.."\n"
				--					popup = popup.."+=====================================+\n"
				--					popup = popup.."Total Min to Neutral: "..minToNeutral.." Minutes \n"
				--					popup = popup.."     Hours to Forget: "..timeToForgetHour.."\n"
				--					popup = popup.."+=====================================+\n"
				--				end
				--				popup = popup.."\n"
				--				popup = popup.."<b>    Time Passed Since Last Talk Time\n\n"
				--				popup = popup.."         Day(s): "..timeSinceLastTalkDays.."\n"
				--				popup = popup.."        Hour(s): "..timeSinceLastTalkHours.."\n"
				--				popup = popup.."         Min(s): "..timeSinceLastTalkMinutes.."\n"
				--				popup = popup.."         Sec(s): "..minutesRemovedSecondsLeft.."\n"
				--				popup = popup.."\n"
				--				popup = popup.."<b>            Last Spoke to:\n"
				--				popup = popup.."     "..lastTalkTimeString.."\n\n"
				--				popup = popup.."+=====================================+\n"
				--
				--				player:popUp(popup)
				--
				--				player.registry["last_repcheck_time_"..npcid[i]] = os.time()
				--				player.registry["disposition_"..npcid[i]] = newLocalDispo
				--			end
				--		end
				--	else
				--		player:popUp("You don't have any reputation yet!")
				--	end
				-----------------------------------------------------
				-- End Reputation menu ------------------------------
				-----------------------------------------------------
				-----------------------------------------------------
				-- Divine Light Status menu -------------------------
				-----------------------------------------------------
				if player.exp >= 200000001 then
					player:popUp("You have too much EXP to exchange a max!")
				else
					if player.registry["exp_maxes"] >= 1 then
						player.registry["exp_maxes"] = player.registry["exp_maxes"] - 1
						player:giveXP(4000000000)
						player:calcStat()
						player:sendStatus()
						player:sendMinitext("You exchange an EXP Max for 4,000,000,000 EXP")
					end
				end
			elseif menu == "Divine Light Status" then
				-----------------------------------------------------
				-- End Divine Light Status menu ---------------------
				-----------------------------------------------------
				--------------------------------------------------------
				-----ACTIVATION-----------------------------------------
				--------------------------------------------------------
				local status
				local multiplier = 0
				local timeRemaining = (os.time() - core.gameRegistry["divine_light_timer"])
				local lapisAmount = 0

				if core.gameRegistry["divine_light"] == 0 then
					status = "OFF"
					multiplier = 1
					timeRemaining = 0
				else
					status = "ON"
					if core.gameRegistry["divine_light_multiplier"] == 1 then
						multiplier = 1.5
					elseif core.gameRegistry["divine_light_multiplier"] == 2 then
						multiplier = 1.75
					elseif core.gameRegistry["divine_light_multiplier"] == 3 then
						multiplier = 2
					elseif core.gameRegistry["divine_light_multiplier"] == 4 then
						multiplier = 3
					end
				end

				choice =
					player:menuString(
					"<b>[DIVINE LIGHT]\n\nStatus: " ..
						status ..
							" | " ..
								multiplier ..
									"x EXP\n\nTime remaining: " ..
										getTimerValues("divine_light_timer") ..
											"\n\nCurrent Daily Total: " .. format_number(core.gameRegistry["divine_light_lapis_daily"]),
					opts
				)
			elseif menu == "Activate" then
				------------------------ END ACTIVATION STUFF --------------------------------------------------
				-----------------------------------------------------------------------------------
				-- Status Menu --------------------------------------------------------------------
				-----------------------------------------------------------------------------------
				local selections = {"Enter Key", "Resend Email"}

				local choice = player:menuString(player.name .. "\n\nPlease make a selection.", selections)

				if choice == "Enter Key" then
					player_key = player:input("Please enter the key that was provided in your email.")
					checkActivation(player, player_key)
					return
				elseif choice == "Resend Email" then
					local choice2 =
						player:menuString(
						player.name ..
							"\n\nWould you like to resend the email to the email address you already provided or change the email?",
						{"Yes", "No", "Change Email"}
					)

					if (choice2 == "Yes") then
						sendEmail(player, player.email)
						player:popUp("Another email has been sent with a new key. Please check it.")
						return
					elseif (choice2 == "No") then
						return
					elseif (choice2 == "Change Email") then
						local email =
							string.lower(
							player:input(
								"What is your Email address? (VALID EMAIL REQUIRED FOR CHARACTER PROGRESSION AND PASSWORD RECOVERY)"
							)
						)

						if (string.len(email) > 32) then
							player:popUp("Your email address must be no longer than 32-characters.")
							return
						end

						local goodEmail = validateEmail(email)

						if (goodEmail == nil or goodEmail == false) then
							player:popUp("Your email address is invalid. Please retry.")
							return
						end

						sendEmail(player, email)
						player.email = email

						player:dialogSeq(
							{
								t,
								player.name ..
									"\n\nThe email address you provided has been registered with this character, however the registration process is not complete just yet. In the email that has been sent to you, an activation key has been provided. You must enter that key in the F1->Activate menu to progress past level 5 and to choose a path."
							},
							1
						)
					end
				end
			elseif menu == "Character Status" then
				-----------------------------------------------------------------------------
				-- End Status Screen --------------------------------------------------------
				-----------------------------------------------------------------------------
				-- Local variable initialization --------------------------------------------------
				local swingPerSec = 3
				local popup = "<b>       | Character Status |\n"
				local vitastr = tostring(player.vRegenAmount)
				local manastr = tostring(player.mRegenAmount)
				local vitafind = string.find(vitastr, "%p")
				local manafind = string.find(manastr, "%p")
				local expSold = player.expSold
				local quantifier
				local pkstr = ""
				local pkdurastr = ""
				local fury = player.fury
				local enchant = player.enchant
				local rage = player.rage
				local add = 1
				local might, grace, will = player.might, player.grace, player.will
				local pathName = ""
				if (vitafind ~= nil) then
					vitafind = vitafind + 1
				end
				if (manafind ~= nil) then
					manafind = manafind + 1
				end
				vitastr = string.sub(vitastr, 0, vitafind)
				manastr = string.sub(manastr, 0, manafind)
				-----Flags and such --
				if (player.PK == 0) then
					pkstr = "Normal"
				elseif (player.PK == 1) then
					pkstr = "PK"
					if (player.durationPK / 1000 > 120) then
						pkdurastr = "\nPK Duration: " .. tostring((player.durationPK / 1000) / 60)
					else
						pkdurastr = "\nPK Duration: " .. tostring(player.durationPK / 1000)
					end
				--else
				--	pkstr = "Bounty"
				--	if (player.durationPK / 1000 > 120) then pkdurastr = "\nPK Duration: "..tostring((player.durationPK / 1000) / 60)
				--		else pkdurastr = "\nPK Duration: "..tostring(player.durationPK / 1000)
				--	end
				end

				if (expSold < 1000000) then
					quantifier = "K"
					expSold = expSold / 1000
				elseif (expSold < 1000000000) then
					quantifier = "M"
					expSold = expSold / 1000000
				else
					quantifier = "B"
					expSold = expSold / 1000000000
				end
				expSold = string.format("%.2f", expSold)

				local titlestats, stats, info = "", "", ""

				player.dialogType = 2

				if player.PK == 1 then
					stats = "ON"
				else
					stats = "OFF"
				end

				local stat = {}
				local armorBonus = 0
				local mightBonus = 0
				local graceBonus = 0
				local willBonus = 0
				local vitaBonus = 0
				local manaBonus = 0
				local critBonus = 0
				local pierceBonus = 0

				-- End intial Local declares -----------------------

				----------------------------------------------------
				-- Set Player Stats --------------------------------
				----------------------------------------------------
				local might = player.might
				local grace = player.grace
				local will = player.will

				if player.baseClass == 0 then
					levelMight = 0
					levelWill = 0
					levelGrace = 0
				elseif player.baseClass == 1 then
					levelMight = math.ceil(((player.level) * .2))
					levelGrace = math.ceil((levelMight * .5))
					levelWill = math.ceil((levelGrace * .6))
				elseif player.baseClass == 2 then
					levelGrace = math.ceil(((player.level) * .2))
					levelMight = math.ceil((levelGrace * .5))
					levelWill = math.ceil((levelMight * .6))
				elseif player.baseClass == 3 then
					levelWill = math.ceil(((player.level) * .2))
					levelGrace = math.ceil((levelWill * .5))
					levelMight = math.ceil((levelGrace * .6))
				elseif player.baseClass == 4 then
					levelWill = math.ceil(((player.level) * .2))
					levelMight = math.ceil((levelWill * .5))
					levelGrace = math.ceil((levelMight * .6))
				elseif player.baseClass == 5 then
					levelMight = 0
					levelWill = 0
					levelGrace = 0
				end
				----------------------------------------------------
				-- End Player Stat Set -----------------------------
				----------------------------------------------------

				----------------------------------------------------------------
				-- Grab all of the equipment and calculate bonuses from that.
				----------------------------------------------------------------
				local weap = player:getEquippedItem(0)
				local armor = player:getEquippedItem(1)
				local shield = player:getEquippedItem(2)
				local helm = player:getEquippedItem(3)
				local left = player:getEquippedItem(4)
				local right = player:getEquippedItem(5)
				local script1 = player:getEquippedItem(6)
				local script2 = player:getEquippedItem(7)
				local facea = player:getEquippedItem(8)
				local crown = player:getEquippedItem(9)
				local mantle = player:getEquippedItem(10)
				local necklace = player:getEquippedItem(11)
				local boots = player:getEquippedItem(12)
				local coat = player:getEquippedItem(13)

				-----------------------------------------------
				-- Set bonuses from weapon if one is equiped --
				-----------------------------------------------
				if weap ~= nil then
					weaponName = weap.name
					maxWeaponDam = weap.maxDmg
					minWeaponDam = weap.minDmg

					armorBonus = armorBonus + weap.ac
					mightBonus = mightBonus + weap.might
					graceBonus = graceBonus + weap.grace
					willBonus = willBonus + weap.will
					vitaBonus = vitaBonus + weap.vita
					manaBonus = manaBonus + weap.mana

					weaponDamageRange = maxWeaponDam - minWeaponDam
					avgWeaponDamage = (minWeaponDam + minWeaponDam) / 2
				else
					weaponName = "Unarmed"
					maxWeaponDam = 0
					minWeaponDam = 0
					weaponDamageRange = maxWeaponDam - minWeaponDam

					if weaponDamageRange < 0 then
						weaponDamageRange = 1
					end

					avgWeaponDamage = (minWeaponDam + maxWeaponDam) / 2
				end
				--------------------------------------------
				-- End weapon set --------------------------
				--------------------------------------------
				if armor ~= nil then
					armorName = armor.name
					armorBonus = armorBonus + armor.ac
					mightBonus = mightBonus + armor.might
					graceBonus = graceBonus + armor.grace
					willBonus = willBonus + armor.will
					vitaBonus = vitaBonus + armor.vita
					manaBonus = manaBonus + armor.mana
				else
					armorName = "None"
				end

				if shield ~= nil then
					shieldName = shield.name
					armorBonus = armorBonus + shield.ac
					mightBonus = mightBonus + shield.might
					graceBonus = graceBonus + shield.grace
					willBonus = willBonus + shield.will
					vitaBonus = vitaBonus + shield.vita
					manaBonus = manaBonus + shield.mana
				else
					shieldName = "None"
				end

				if helm ~= nil then
					helmName = helm.name
					armorBonus = armorBonus + helm.ac
					mightBonus = mightBonus + helm.might
					graceBonus = graceBonus + helm.grace
					willBonus = willBonus + helm.will
					vitaBonus = vitaBonus + helm.vita
					manaBonus = manaBonus + helm.mana
				else
					helmName = "None"
				end

				if left ~= nil then
					leftName = left.name
					armorBonus = armorBonus + left.ac
					mightBonus = mightBonus + left.might
					graceBonus = graceBonus + left.grace
					willBonus = willBonus + left.will
					vitaBonus = vitaBonus + left.vita
					manaBonus = manaBonus + left.mana
				else
					leftName = "None"
				end

				if right ~= nil then
					rightName = right.name
					armorBonus = armorBonus + right.ac
					mightBonus = mightBonus + right.might
					graceBonus = graceBonus + right.grace
					willBonus = willBonus + right.will
					vitaBonus = vitaBonus + right.vita
					manaBonus = manaBonus + right.mana
				else
					rightName = "None"
				end

				if script1 ~= nil then
					script1Name = script1.name
					armorBonus = armorBonus + script1.ac
					mightBonus = mightBonus + script1.might
					graceBonus = graceBonus + script1.grace
					willBonus = willBonus + script1.will
					vitaBonus = vitaBonus + script1.vita
					manaBonus = manaBonus + script1.mana
				else
					script1Name = "None"
				end

				if script2 ~= nil then
					script2Name = script2.name
					armorBonus = armorBonus + script2.ac
					mightBonus = mightBonus + script2.might
					graceBonus = graceBonus + script2.grace
					willBonus = willBonus + script2.will
					vitaBonus = vitaBonus + script2.vita
					manaBonus = manaBonus + script2.mana
				else
					script2Name = "None"
				end

				if mantle ~= nil then
					mantleName = mantle.name
					armorBonus = armorBonus + mantle.ac
					mightBonus = mightBonus + mantle.might
					graceBonus = graceBonus + mantle.grace
					willBonus = willBonus + mantle.will
					vitaBonus = vitaBonus + mantle.vita
					manaBonus = manaBonus + mantle.mana
				else
					mantleName = "None"
				end

				if necklace ~= nil then
					necklaceName = necklace.name
					armorBonus = armorBonus + necklace.ac
					mightBonus = mightBonus + necklace.might
					graceBonus = graceBonus + necklace.grace
					willBonus = willBonus + necklace.will
					vitaBonus = vitaBonus + necklace.vita
					manaBonus = manaBonus + necklace.mana
				else
					necklaceName = "None"
				end

				if boots ~= nil then
					bootsName = boots.name
					armorBonus = armorBonus + boots.ac
					mightBonus = mightBonus + boots.might
					graceBonus = graceBonus + boots.grace
					willBonus = willBonus + boots.will
					vitaBonus = vitaBonus + boots.vita
					manaBonus = manaBonus + boots.mana
				else
					bootsName = "None"
				end
				--------------------------------------
				-- End Armor Stat Bonus Total Calc----
				--------------------------------------

				---------------------------------------------------------
				-- Set number of targets information by class and level--
				---------------------------------------------------------
				local maxTargets

				if player.baseClass == 1 then
					if player.level > 0 and player.level < 19 then -- Levels 1 - 25
						maxTargets = 1
					elseif player.level >= 19 and player.level < 69 then -- Levels 26 - 75
						maxTargets = 4
					elseif player.level >= 69 and player.level < 150 then -- Levels 76 - 249
						maxTargets = 8
					elseif player.level >= 125 then -- Levels 250
						maxTargets = 12
					end
				elseif player.baseClass == 2 then
					if player.level > 0 and player.level < 19 then -- Levels 1 - 25
						maxTargets = 1
					elseif player.level >= 19 and player.level < 69 then -- Levels 26 - 75
						maxTargets = 2
					elseif player.level >= 69 and player.level < 150 then -- Levels 76 - 249
						maxTargets = 4
					elseif player.level >= 125 then -- Levels 250
						maxTargets = 6
					end
				elseif player.baseClass == 3 then
					if player.level > 0 and player.level < 19 then -- Levels 1 - 25
						maxTargets = 1
					elseif player.level >= 19 and player.level < 69 then -- Levels 26 - 75
						maxTargets = 1
					elseif player.level >= 69 and player.level < 150 then -- Levels 76 - 249
						maxTargets = 1
					elseif player.level >= 125 then -- Levels 250
						maxTargets = 1
					end
				elseif player.baseClass == 4 then
					if player.level > 0 and player.level < 19 then -- Levels 1 - 25
						maxTargets = 1
					elseif player.level >= 19 and player.level < 69 then -- Levels 26 - 75
						maxTargets = 3
					elseif player.level >= 69 and player.level < 150 then -- Levels 76 - 249
						maxTargets = 5
					elseif player.level >= 125 then -- Levels 250
						maxTargets = 7
					end
				else
					maxTargets = 6
				end
				--------------------------
				-- End Set Target Calc ---
				--------------------------

				------------------------------------------------
				-- Calc Magic Damage Stats ---------------------
				------------------------------------------------
				local currentMagic = player.magic
				local maxMagic = player.maxMagic
				local nakedMagic = player.baseMagic
				---------------------------------
				-- End Magic Damage Calcs -------
				---------------------------------

				----------------------------------
				-- Armor and Grace Based Calcs ---
				----------------------------------
				if player.baseClass == 0 then
					levelArmor = 0
				elseif player.baseClass == 1 then
					levelArmor = player.level * 100
				elseif player.baseClass == 2 then
					levelArmor = player.level * 35
				elseif player.baseClass == 3 then
					levelArmor = player.level * 20
				elseif player.baseClass == 4 then
					levelArmor = player.level * 60
				elseif player.baseClass == 5 then
					levelArmor = 0
				end

				local SPGainedArmor = player.registry["sp_spent_armor"]

				local totalArmor = player.armor
				local naturalArmor = SPGainedArmor + levelArmor
				local gearArmor = armorBonus

				--	player:talk(0,"Natural Armor: "..naturalArmor)
				--	player:talk(0,"Natural Armor Redux %: "..naturalPhysicalDamageReductionPct)

				-------------------------------
				----------------------------

				------------------------------------------------
				-- Calc Weapon Damage and Final Damage output --
				------------------------------------------------
				if weap == nil then -- You do not have a Weapon equiped, damage is bare handed.
					finalDamage = 0
					avgWeaponDamage = 0
				end
				-- You DO have a weapon equiped.
				-- Warrior and Priest
				if player.baseClass == 0 or player.baseClass == 1 or player.baseClass == 5 then
				end
				-- Scoundrel
				if player.baseClass == 2 then
				end
				-- Wizard
				if player.baseClass == 3 then
				end
				-- Preist
				if player.baseClass == 4 then
				end

				---------------------------------------
				-- End Damage Calc --------------------
				---------------------------------------

				--------------------------------------
				-- Life / Vita Calcs -----------------
				--------------------------------------
				local currentLife = player.health
				local maxLife = player.maxHealth
				local nakedLife = player.baseHealth
				-----------------------------------------
				-- End vita / life calcs ----------------
				-----------------------------------------

				--------------------------------------------------------
				-- Set values for display purposes ---------------------
				--------------------------------------------------------

				currentManaPct = (currentMagic / maxMagic) * 100
				currentLifePct = (currentLife / maxLife) * 100
				-----------------------------------------------
				-- End Display Variables ----------------------
				-----------------------------------------------

				local playerNation = ""
				local playerAlignment = ""

				if player.registry["hon_citizen"] == 1 then
					playerNation = "Hon by the Sea"
				end
				if player.registry["cathay_citizen"] == 1 then
					playerNation = "Empire of Cathay"
				end

				if (player.registry["good_karma"] - player.registry["bad_karma"]) > 0 then
					playerAlignment = "Good"
				end

				if (player.registry["good_karma"] - player.registry["bad_karma"]) < 0 then
					playerAlignment = "Evil"
				end

				if (player.registry["good_karma"] - player.registry["bad_karma"]) == 0 then
					playerAlignment = "Neutral"
				end

				if
					(player.registry["neutral_karma"] > player.registry["bad_karma"]) and
						(player.registry["neutral_karma"] > player.registry["good_karma"])
				 then
					playerAlignment = "Neutral"
				end

				-----------------------------------------------------------------------------
				-- Build the screen----------------------------------------------------------
				-----------------------------------------------------------------------------
				-- Display the top of the screen -------------
				popup = popup .. "<b>       +------------------+\n"
				popup = popup .. "+================================+\n"
				popup = popup .. "   Name: " .. player.name .. "\n"
				popup = popup .. "   Path: " .. getPathName(player) .. "\n"
				popup = popup .. "  Title: " .. player.title .. "\n"
				popup = popup .. "  Level: " .. player.level .. "\n"

				if player.gmLevel > 0 then
					if player.ID == 2 or player.ID == 4 or player.ID == 3 or player.ID == 7 then
						if player.ID ~= player.ID then
							popup = popup .. " GM LVL: " .. player.gmLevel .. "\n"
						end
					end
				end
				popup = popup .. "+--------------------------------+\n"
				popup = popup .. " Nation: " .. playerNation .. "\n"
				popup = popup .. "   Clan: \n"
				popup = popup .. "  Totem: " .. player:totemName(player.totem) .. "\n"
				popup = popup .. "  Karma: " .. player.wisdom .. "\n"
				popup = popup .. "Alignment: " .. playerAlignment .. "\n"
				popup = popup .. "+--------------------------------+\n"
				popup = popup .. "\n"
				 --
				-- increments every 5%,  XP vs. TNL
				--[[		
			if player.tnl ==  0 then
				popup = popup.."      |--------------------|\n"
			end
			if player.tnl >= 1 and player.tnl < 6 then
				popup = popup.."      |*-------------------|\n"
			end
			if player.tnl >= 6 and player.tnl < 11 then
				popup = popup.."      |**------------------|\n"
			end
			if player.tnl >= 11 and player.tnl < 16 then
				popup = popup.."      |***-----------------|\n"
			end
			if player.tnl >= 16 and player.tnl < 21 then
				popup = popup.."      |****----------------|\n"
			end
			if player.tnl >= 21 and player.tnl < 26 then
				popup = popup.."      |*****---------------|\n"
			end
			if player.tnl >= 26 and player.tnl < 31 then
				popup = popup.."      |******--------------|\n"
			end
			if player.tnl >= 31 and player.tnl < 36 then
				popup = popup.."      |*******-------------|\n"
			end
			if player.tnl >= 36 and player.tnl < 41 then
				popup = popup.."      |********------------|\n"
			end
			if player.tnl >= 41 and player.tnl < 46 then
				popup = popup.."      |*********-----------|\n"
			end
			if player.tnl >= 46 and player.tnl < 51 then
				popup = popup.."      |**********----------|\n"
			end
			if player.tnl >= 51 and player.tnl < 56 then
				popup = popup.."      |***********---------|\n"
			end
			if player.tnl >= 56 and player.tnl < 61 then
				popup = popup.."      |************--------|\n"
			end
			if player.tnl >= 61 and player.tnl < 66 then
				popup = popup.."      |*************-------|\n"
			end
			if player.tnl >= 66 and player.tnl < 71 then
				popup = popup.."      |**************------|\n"
			end
			if player.tnl >= 71 and player.tnl < 76 then
				popup = popup.."      |***************-----|\n"
			end
			if player.tnl >= 76 and player.tnl < 81 then
				popup = popup.."      |****************----|\n"
			end
			if player.tnl >= 81 and player.tnl < 86 then
				popup = popup.."      |*****************---|\n"
			end
			if player.tnl >= 86 and player.tnl < 91 then
				popup = popup.."      |******************--|\n"
			end
			if player.tnl >= 91 and player.tnl < 96 then
				popup = popup.."      |*******************-|\n"
			end
			if player.tnl >= 96 then
				popup = popup.."      |********************|\n"
			end
]] totalEXP =
					player.exp + (player.registry["exp_maxes"] * 4000000000)

				popup = popup .. "\n"
				popup = popup .. "<b>    Exp: " .. format_number(player.exp) .. "\n"
				popup = popup .. "<b>    Total: " .. format_number(totalEXP) .. "\n"
				--		popup = popup.."<b>      TNL: "..format_number(player.realtnl).." ("..player.tnl.."%) \n"
				popup = popup .. "+--------------------------------+\n"
				popup = popup .. "   Coins: " .. format_number(player.money) .. "\n"
				popup = popup .. "   Lapis: " .. player.lapis .. " \n"
				-- end top of screen / exp & coin information -------------------------------------------
				-- Display HP Bar and information ------------
				popup = popup .. "+================================+\n"
				popup = popup .. "<b>          | Base Stats |\n"
				popup = popup .. "          +------------+\n"
				popup = popup .. "\n"
				-- A life bar, increments every 10%,  need curret vita / max vita
				if currentLifePct < 0 then
					popup = popup .. " |----------|\n"
				end
				if currentLifePct > 0 and currentLifePct < 11 then
					popup = popup .. " |*---------|\n"
				end
				if currentLifePct > 10 and currentLifePct < 21 then
					popup = popup .. " |**--------|\n"
				end
				if currentLifePct > 20 and currentLifePct < 31 then
					popup = popup .. " |***-------|\n"
				end
				if currentLifePct > 30 and currentLifePct < 41 then
					popup = popup .. " |****------|\n"
				end
				if currentLifePct > 40 and currentLifePct < 51 then
					popup = popup .. " |*****-----|\n"
				end
				if currentLifePct > 50 and currentLifePct < 61 then
					popup = popup .. " |******----|\n"
				end
				if currentLifePct > 60 and currentLifePct < 71 then
					popup = popup .. " |*******---|\n"
				end
				if currentLifePct > 70 and currentLifePct < 81 then
					popup = popup .. " |********--|\n"
				end
				if currentLifePct > 80 and currentLifePct < 91 then
					popup = popup .. " |*********-|\n"
				end
				if currentLifePct > 90 and currentLifePct < 101 then
					popup = popup .. " |**********|\n"
				end
				-- end lifebar ------------------------------------------------------
				lifePct = currentLifePct

				popup = popup .. "<b> Current Vita: " .. format_number(currentLife) .. " (" .. round(lifePct) .. "%)\n"
				popup = popup .. "       Base Vita: " .. format_number(nakedLife) .. "\n"
				popup = popup .. " +   Equip Bonus: " .. format_number(vitaBonus) .. "\n"
				popup = popup .. "  =========================        \n"
				popup = popup .. " =      Max Vita: " .. format_number(maxLife) .. " \n"
				popup = popup .. "\n"
				popup = popup .. "  VitaRegen Rate: N/A\n"
				-- end vita data display -----------------------------------------------
				-- Display Mana Data ---------------------------------------------------
				popup = popup .. "+================================+\n"
				popup = popup .. "\n"
				-- Mana Bar display ------------------------------------------
				if currentManaPct < 0 then
					popup = popup .. " |----------|\n"
				end
				if currentManaPct > 0 and currentManaPct < 11 then
					popup = popup .. " |*---------|\n"
				end
				if currentManaPct > 10 and currentManaPct < 21 then
					popup = popup .. " |**--------|\n"
				end
				if currentManaPct > 20 and currentManaPct < 31 then
					popup = popup .. " |***-------|\n"
				end
				if currentManaPct > 30 and currentManaPct < 41 then
					popup = popup .. " |****------|\n"
				end
				if currentManaPct > 40 and currentManaPct < 51 then
					popup = popup .. " |*****-----|\n"
				end
				if currentManaPct > 50 and currentManaPct < 61 then
					popup = popup .. " |******----|\n"
				end
				if currentManaPct > 60 and currentManaPct < 71 then
					popup = popup .. " |*******---|\n"
				end
				if currentManaPct > 70 and currentManaPct < 81 then
					popup = popup .. " |********--|\n"
				end
				if currentManaPct > 80 and currentManaPct < 91 then
					popup = popup .. " |*********-|\n"
				end
				if currentManaPct > 90 and currentManaPct < 101 then
					popup = popup .. " |**********|\n"
				end
				-- End Mana Bar ---------------------------------------------
				manaPct = currentManaPct

				popup = popup .. "<b> Current Mana: " .. format_number(currentMagic) .. " (" .. round(manaPct) .. "%)\n"
				popup = popup .. "       Base Mana: " .. format_number(nakedMagic) .. "\n"
				popup = popup .. " +   Equip Bonus: " .. format_number(manaBonus) .. "\n"
				popup = popup .. "  =========================        \n"
				popup = popup .. " =      Max Mana: " .. format_number(maxMagic) .. " \n"
				popup = popup .. "\n"
				popup = popup .. "  ManaRegen Rate: N/A\n"
				-- End Mana Section Display -----------------
				-- Start Might Calc Display -----------------
				popup = popup .. "+================================+\n"
				popup = popup .. "<b>   Total Might: " .. player.might .. "\n"
				popup = popup .. "       Base Might: " .. player.basemight .. "\n"
				popup = popup .. "      Equip Bonus: +" .. mightBonus .. "\n"
				popup = popup .. "    Natural Might: +" .. levelMight .. "\n"
				popup = popup .. "\n"

				-- End Might Calc Display ---------------------
				-- Start Will Calc Display --------------------
				popup = popup .. "+================================+\n"
				popup = popup .. "<b>    Total Will: " .. player.will .. "\n"
				popup = popup .. "      Equip Bonus: +" .. willBonus .. "\n"
				popup = popup .. "        Base Will: " .. player.basewill .. "\n"
				popup = popup .. "     Natural Will: +" .. levelWill .. "\n"
				popup = popup .. "\n"

				popup = popup .. "+================================+\n"
				popup = popup .. "<b>   Total Grace: " .. player.grace .. "\n"
				popup = popup .. "      Equip Bonus: +" .. graceBonus .. "\n"
				popup = popup .. "       Base Grace: " .. player.basegrace .. "\n"
				popup = popup .. "    Natural Grace: +" .. levelGrace .. "\n"
				popup = popup .. "\n"

				popup = popup .. "+================================+\n"
				popup = popup .. "<b>    Total  Armor: " .. player.armor .. "\n"
				popup = popup .. "      Equiped Armor: +" .. armorBonus .. "\n"
				popup = popup .. " Natural + SP Armor: " .. naturalArmor .. "\n"
				popup = popup .. "      Natural Armor: " .. levelArmor .. "\n"
				popup = popup .. "\n"
				-- Only show Void Reist if they have learned about it.
				--popup = popup.."  Void Resist: __%\n"
				popup = popup .. "\n"

				popup = popup .. "+================================+\n"
				popup = popup .. "<b>          |Damage Output|\n"
				popup = popup .. "          +-------------+\n"
				popup = popup .. "\n"
				popup = popup .. "  Weapon Min Damage: " .. minWeaponDam .. "\n"
				popup = popup .. "  Weapon Max Damage: " .. maxWeaponDam .. "\n"
				popup = popup .. "       Damage Range: " .. weaponDamageRange .. "\n"
				popup = popup .. "\n"
				popup = popup .. "\n"

				popup = popup .. "\n"
				popup = popup .. "       Fury Multiplier: x" .. player.fury .. "\n"
				popup = popup .. "    Enchant Multiplier: x" .. player.enchant .. "\n"
				popup = popup .. "       Rage Multiplier: x" .. player.rage .. "\n"
				popup = popup .. "-------------------------------\n"

				--player:talkSelf(0,"Calculated Total Pierce: "..round((calcPierce),3))

				popup = popup .. "+--------------------------------+\n"
				popup = popup .. "<b>          |  Equipment |\n"
				popup = popup .. "          +------------+\n"
				popup = popup .. "\n"
				popup = popup .. "<b>   Weapon: " .. weaponName .. "\n"
				popup = popup .. "   Helmet: " .. helmName .. "\n"
				popup = popup .. " Necklace: " .. necklaceName .. "\n"
				popup = popup .. "   Shield: " .. shieldName .. "\n"
				popup = popup .. "    Armor: " .. armorName .. "\n"
				popup = popup .. "  L. Hand: " .. leftName .. "\n"
				popup = popup .. "  R. Hand: " .. rightName .. "\n"
				popup = popup .. "    Boots: " .. bootsName .. "\n"
				popup = popup .. "   L. Sub: " .. script1Name .. "\n"
				popup = popup .. "   R. Sub: " .. script2Name .. "\n"
				--popup = popup.."     Cape: "..mantleName.."\n"
				--popup = popup.."    Crown: "..crown.name.."\n"
				--popup = popup.." Face Acc: "..facea.name.."\n"
				--popup = popup.."     Coat: "..coat.name.."\n"
				popup = popup .. "+================================+\n"
				popup = popup .. "<b>         |SP Information|\n"
				popup = popup .. "         +--------------+\n"
				popup = popup .. "          SP Available: " .. player.registry["stat_points"] .. "\n"
				popup = popup .. "\n"
				popup = popup .. "          Bought Might: " .. player.registry["sp_spent_might"] .. "\n"
				popup = popup .. "          Bought Grace: " .. player.registry["sp_spent_grace"] .. "\n"
				popup = popup .. "          Bought  Will: " .. player.registry["sp_spent_will"] .. "\n"
				popup = popup .. "          Bought Armor: " .. player.registry["sp_spent_armor"] .. "\n"
				popup = popup .. "\n"
				popup = popup .. "       Total SP  Spent: " .. player.registry["sp_spent"] .. "\n"
				popup = popup .. "       Total SP Earned: " .. player.registry["total_stat_points"] .. "\n"
				popup = popup .. "\n"
				popup = popup .. "              Exp Sold: " .. player.expSold .. "\n"
				popup = popup .. "Vita Training Sessions: " .. player.registry["vita_sold"] .. "\n"
				popup = popup .. "Mana Training Sessions: " .. player.registry["mana_sold"] .. "\n"
				popup = popup .. "\n"
				popup = popup .. "+================================+\n"

				-----------------------------------------------------------------------------
				-- Display the screen -------------------------------------------------------
				-----------------------------------------------------------------------------
				player:popUp(popup)
			elseif menu == "Character Info" then
				menu = player:menuString("<b>[Character Menu]\n\nWhat would you like to do?", opts2)

				if menu == "Character Titles" then
					if player.registry["show_title"] > 0 then
						txt = "Enabled"
					else
						txt = "Disabled"
					end
					local ti = {}
					if player.registry["show_title"] > 0 then
						table.insert(ti, "Hide Title")
					else
						table.insert(ti, "Show Title")
					end
					table.insert(ti, "My titles")
					table.insert(ti, "Exit")
					title = player:menuString("<b>[Character Title]\n\nTitle  : " .. player.title .. "", ti)

					if title == "Hide Title" then
						player.registry["show_title"] = 0
						player:updateState()
						player:sendMinitext("Show title : Off")
					elseif title == "Show Title" then
						player.registry["show_title"] = 1
						player:updateState()
						player:sendMinitext("Show title : On")
						f1npc.click(player, npc)
					elseif title == "My titles" then
						local av = {"No Title", "Peasant", "Reborn"}

						if player.ID == 2 then
							table.insert(av, "Mauler")
						end
						if player.ID == 4 then
							table.insert(av, "Protector")
						end
						if player.gmLevel >= 1 then
							table.insert(av, "GM")
						end

						if player.ID == 300 then
							table.insert(av, "Herald of")
						end --custom title reward for player Destruction
						if player.ID == 301 then
							table.insert(av, "Cross Blesser")
						end --custom title reward for player Destruction
						if player.ID == 560 then
							table.insert(av, "Santos")
						end --custom title reward for player BridgeTooFar

						if player.baseClass == 1 then
							table.insert(av, "Fighter")
						end
						if player.baseClass == 2 then
							table.insert(av, "Scoundrel")
						end
						if player.baseClass == 3 then
							table.insert(av, "Wizard")
						end
						if player.baseClass == 4 then
							table.insert(av, "Priest")
						end

						if player.class == 6 then
							table.insert(av, "Knight")
						end
						if player.class == 7 then
							table.insert(av, "Troubadour")
						end
						if player.class == 8 then
							table.insert(av, "Magi")
						end
						if player.class == 9 then
							table.insert(av, "Warpriest")
						end
						if player.class == 11 then
							table.insert(av, "Ronin")
						end
						if player.class == 12 then
							table.insert(av, "Bravo")
						end
						if player.class == 13 then
							table.insert(av, "Naturist")
						end
						if player.class == 14 then
							table.insert(av, "Cleric")
						end
						if player.class == 16 then
							table.insert(av, "Thrall")
						end
						if player.class == 17 then
							table.insert(av, "Cutthroat")
						end
						if player.class == 18 then
							table.insert(av, "Occultist")
						end
						if player.class == 19 then
							table.insert(av, "Heretic")
						end

						if player:hasLegend("guild_rank") then
							if player.baseClass == 1 then
								table.insert(av, "Brawler")
							elseif player.baseClass == 2 then
								table.insert(av, "Prowler")
							elseif player.baseClass == 3 then
								table.insert(av, "Apprentice")
							elseif player.baseClass == 4 then
								table.insert(av, "Aspirant")
							end
						end

						if player.level >= 99 then
							table.insert(av, "Paragon")
						end
						if player.level >= 100 then
							table.insert(av, "Exemplar")
						end

						if player.registry["mentor"] >= 1 then
							table.insert(av, "Mentor")
						end

						if player.registry["pontiff"] >= 1 then
							table.insert(av, "Pontiff")
						end
						if player.registry["senator"] >= 1 then
							table.insert(av, "Senator")
						end
						if player.registry["ambassador"] >= 1 then
							table.insert(av, "Ambassador")
						end

						if player.registry["baron"] >= 1 then
							table.insert(av, "Baron")
						end
						if player.registry["regent"] >= 1 then
							table.insert(av, "Regent")
						end
						if player.registry["mayor"] >= 1 then
							table.insert(av, "Mayor")
						end
						if player.registry["king"] >= 1 then
							table.insert(av, "King")
						end
						if player.registry["queen"] >= 1 then
							table.insert(av, "Queen")
						end
						if player.registry["prince"] >= 1 then
							table.insert(av, "Prince")
						end
						if player.registry["princess"] >= 1 then
							table.insert(av, "Princess")
						end

						if player.registry["alpha_tester"] >= 1 then
							table.insert(av, "Alpha Tester")
						end
						if player.registry["beta_tester"] >= 1 then
							table.insert(av, "Beta Tester")
						end

						-- if player.ID == 279 then table.insert(av, "") end
						-- if player.ID == 300 then table.insert(av, "") end
						-- if player.ID == 301 then table.insert(av, "") end

						if player.registry["total_lapis_bought"] >= 100 then
							table.insert(av, "Donator")
						end -- $1
						if player.registry["total_lapis_bought"] >= 2500 then
							table.insert(av, "Contributor")
						end -- $25
						if player.registry["total_lapis_bought"] >= 5000 then
							table.insert(av, "Patron")
						end -- $50
						if player.registry["total_lapis_bought"] >= 10000 then
							table.insert(av, "Benefactor")
						end -- $100
						if player.registry["total_lapis_bought"] >= 20000 then
							table.insert(av, "Sponsor")
						end -- $100

						if player.registry["jukebox_songs_purchased"] >= 100 then
							table.insert(av, "DJ")
						end

						if player.registry["dailyq_hon_bartender_complete"] >= 10 then
							table.insert(av, "Barfly")
						end
						if player.registry["dailyq_hon_bartender_complete"] >= 100 then
							table.insert(av, "Bounty Hunter")
						end

						if player.registry["daily_quests_complete"] >= 10 then
							table.insert(av, "Quester")
						end
						if player.registry["daily_quests_complete"] >= 100 then
							table.insert(av, "Quest Master")
						end

						if player.registry["daily_ogre_hunts_complete"] >= 10 then
							table.insert(av, "Ogre Hunter")
						end
						if player.registry["daily_ogre_hunts_complete"] >= 100 then
							table.insert(av, "Ogre Slayer")
						end

						if player.registry["daily_root_stew_complete"] >= 25 then
							table.insert(av, "Stew Lover")
						end
						if player.registry["daily_root_stew_complete"] >= 100 then
							table.insert(av, "Stew Fanatic")
						end

						if player.registry["dailyq_path_kill_complete"] >= 10 then
							table.insert(av, "Recruit")
						end
						if player.registry["dailyq_path_kill_complete"] >= 100 then
							table.insert(av, "Veteran")
						end

						if player.registry["dailyq_path_supply_complete"] >= 10 then
							table.insert(av, "Gatherer")
						end
						if player.registry["dailyq_path_supply_complete"] >= 100 then
							table.insert(av, "Runner")
						end

						if player.registry["dailyq_flowergirl_complete"] >= 50 then
							table.insert(av, "Flower Fan")
						end
						if player.registry["dailyq_flowergirl_complete"] >= 250 then
							table.insert(av, "Florist")
						end

						if player.registry["ghost_hunt_completed"] >= 100 then
							table.insert(av, "Ghost Hunter")
						end
						if player.registry["ghost_hunt_completed"] >= 250 then
							table.insert(av, "Ghost Killer")
						end
						if player.registry["ghost_hunt_completed"] >= 500 then
							table.insert(av, "Ghost Buster")
						end

						-------- GAMBLING TITLES --------
						if player.registry["Gambling_plays"] >= 10 then
							table.insert(av, "Gambler")
						end
						if player.registry["Gambling_plays"] >= 50 then
							table.insert(av, "Easy Mark")
						end
						if player.registry["Gambling_plays"] >= 125 then
							table.insert(av, "Fish")
						end
						if player.registry["Gambling_plays"] >= 250 then
							table.insert(av, "Sucker")
						end
						if player.registry["Gambling_plays"] >= 500 then
							table.insert(av, "Junkie")
						end

						-- Gambling Specialty titles --
						if player.registry["Gambling_plays"] >= 100 and player.registry["Gambling_spent"] <= 50000 then
							table.insert(av, "Nit")
						end
						if player.registry["Gambling_plays"] >= 200 and player.registry["Gambling_spent"] >= 300000 then
							table.insert(av, "Regular")
						end
						if player.registry["Gambling_plays"] >= 20 and player.registry["Gambling_spent"] >= 1000000 then
							table.insert(av, "Whale")
						end

						-- Winner Gambling Titles --
						if player.registry["Gambling_wins"] >= 5 then
							table.insert(av, "Lucky")
						end
						if player.registry["Gambling_wins"] >= 25 then
							table.insert(av, "Running Hot")
						end
						if player.registry["Gambling_wins"] >= 50 then
							table.insert(av, "Hot Shot")
						end
						if player.registry["Gambling_wins"] >= 150 then
							table.insert(av, "Too Hot")
						end
						if player.registry["Gambling_wins"] >= 250 then
							table.insert(av, "Maverick")
						end
						if player.registry["Gambling_wins"] >= 500 then
							table.insert(av, "Legendary")
						end

						if player.registry["epic_mount"] >= 1 then
							table.insert(av, "Epic")
						end

						ch =
							player:menuString(
							"<b>[Character Title]\n\nYou can get titles from quests, events, etc.\n\nCurrent Title: " .. player.title .. "",
							av
						)
						if ch ~= nil then
							if ch == "No Title" then
								player.title = ""
							end
							if ch == "Reborn" then
								player.title = "Reborn"
							end
							if ch == "Peasant" then
								player.title = "Peasant"
							end

							if ch == "Mauler" then
								player.title = "Mauler"
							end
							if ch == "Protector" then
								player.title = "Protector"
							end
							if ch == "GM" then
								player.title = "GM"
							end

							if ch == "Herald of" then
								player.title = "Herald of"
							end
							if ch == "Cross Blesser" then
								player.title = "Cross Blesser"
							end
							if ch == "Santos" then
								player.title = "Santos "
							end

							if ch == "Fighter" then
								player.title = "Fighter"
							end
							if ch == "Scoundrel" then
								player.title = "Scoundrel"
							end
							if ch == "Wizard" then
								player.title = "Wizard"
							end
							if ch == "Priest" then
								player.title = "Priest"
							end

							if ch == "Knight" then
								player.title = "Knight"
							end
							if ch == "Troubadour" then
								player.title = "Troubadour"
							end
							if ch == "Magi" then
								player.title = "Magi"
							end
							if ch == "Warpriest" then
								player.title = "Warpriest"
							end
							if ch == "Ronin" then
								player.title = "Ronin"
							end
							if ch == "Bravo" then
								player.title = "Bravo"
							end
							if ch == "Naturist" then
								player.title = "Naturist"
							end
							if ch == "Cleric" then
								player.title = "Cleric"
							end
							if ch == "Thrall" then
								player.title = "Thrall"
							end
							if ch == "Cutthroat" then
								player.title = "Cutthroat"
							end
							if ch == "Occultist" then
								player.title = "Occultist"
							end
							if ch == "Heretic" then
								player.title = "Heretic"
							end

							if ch == "Brawler" then
								player.title = "Brawler"
							end
							if ch == "Prowler" then
								player.title = "Prowler"
							end
							if ch == "Apprentice" then
								player.title = "Apprentice"
							end
							if ch == "Aspirant" then
								player.title = "Aspirant"
							end

							if ch == "Paragon" then
								player.title = "Paragon"
							end
							if ch == "Exemplar" then
								player.title = "Exemplar"
							end

							if ch == "Mentor" then
								player.title = "Mentor"
							end

							if ch == "Pontiff" then
								player.title = "Pontiff"
							end
							if ch == "Senator" then
								player.title = "Senator"
							end
							if ch == "Ambassador" then
								player.title = "Ambassador"
							end

							if ch == "Baron" then
								player.title = "Baron"
							end
							if ch == "Regent" then
								player.title = "Regent"
							end
							if ch == "Mayor" then
								player.title = "Mayor"
							end
							if ch == "King" then
								player.title = "King"
							end
							if ch == "Queen" then
								player.title = "Queen"
							end
							if ch == "Prince" then
								player.title = "Prince"
							end
							if ch == "Princess" then
								player.title = "Princess"
							end

							if ch == "Alpha Tester" then
								player.title = "Alpha Tester"
							end
							if ch == "Beta Tester" then
								player.title = "Beta Tester"
							end

							if ch == "Donator" then
								player.title = "Donator"
							end
							if ch == "Patron" then
								player.title = "Patron"
							end
							if ch == "Benefactor" then
								player.title = "Benefactor"
							end
							if ch == "Sponsor" then
								player.title = "Sponsor"
							end
							if ch == "Contributor" then
								player.title = "Contributor"
							end

							if ch == "DJ" then
								player.title = "DJ"
							end

							if ch == "Barfly" then
								player.title = "Barfly"
							end
							if ch == "Bounty Hunter" then
								player.title = "Bounty Hunter"
							end

							if ch == "Quester" then
								player.title = "Quester"
							end
							if ch == "Quest Master" then
								player.title = "Quest Master"
							end

							if ch == "Ogre Hunter" then
								player.title = "Ogre Hunter"
							end
							if ch == "Ogre Slayer" then
								player.title = "Ogre Slayer"
							end

							if ch == "Stew Lover" then
								player.title = "Stew Lover"
							end
							if ch == "Stew Fanatic" then
								player.title = "Stew Fanatic"
							end

							if ch == "Recruit" then
								player.title = "Recruit"
							end
							if ch == "Veteran" then
								player.title = "Veteran"
							end

							if ch == "Gatherer" then
								player.title = "Gatherer"
							end
							if ch == "Runner" then
								player.title = "Runner"
							end

							if ch == "Flower Fan" then
								player.title = "Flower Fan"
							end
							if ch == "Florist" then
								player.title = "Florist"
							end

							if ch == "Ghost Hunter" then
								player.title = "Ghost Hunter"
							end
							if ch == "Ghost Killer" then
								player.title = "Ghost Killer"
							end
							if ch == "Ghost Buster" then
								player.title = "Ghost Buster"
							end

							if ch == "Epic" then
								player.title = "Epic"
							end

							-------- Gambling Titles -------------
							if ch == "Gambler" then
								player.title = ch
							end
							if ch == "Easy Mark" then
								player.title = ch
							end
							if ch == "Fish" then
								player.title = ch
							end
							if ch == "Sucker" then
								player.title = ch
							end
							if ch == "Junkie" then
								player.title = ch
							end
							if ch == "Nit" then
								player.title = ch
							end
							if ch == "Regular" then
								player.title = ch
							end
							if ch == "Whale" then
								player.title = ch
							end
							if ch == "Lucky" then
								player.title = ch
							end
							if ch == "Running Hot" then
								player.title = ch
							end
							if ch == "Hot Shot" then
								player.title = ch
							end
							if ch == "Too Hot" then
								player.title = ch
							end
							if ch == "Maverick" then
								player.title = ch
							end
							if ch == "Legendary" then
								player.title = ch
							end

							player:updateState()
							player:sendMinitext("Done!")
							player:freeAsync()
							f1npc.click(player, npc)
						end
					end
				elseif menu == "Set AFK Message" then
					afkMessage =
						player:input("Current AFK Message: " .. player.afkMessage .. "\n\nPlease set your AFK Message below: ")
					player.afkMessage = afkMessage
					player:sendMinitext("AFK Message updated")
					player:updateState()
				elseif menu == "Ability Info" then
					ability.click(player, npc)
				elseif menu == "Hide Player Profile" then
					player:showProfile(0)
				elseif menu == "Show Player Profile" then
					player:showProfile(1)
				elseif menu == "Disable MiniMap" then
					player:setMiniMapToggle(0)
				elseif menu == "Enable MiniMap" then
					player:setMiniMapToggle(1)
				elseif menu == "Toggle See Warps" then
					local currentStatus
					if player.registry["see_warps"] == 0 then
						currentStatus = "OFF"
					elseif player.registry["see_warps"] == 1 then
						currentStatus = "ON"
					end
					confirmation =
						player:menuString(
						"<B>[See Warps]\nThis will magically highlight entrances in the world.\n\nCurrent display: " .. currentStatus,
						{"Switch On", "Switch Off"}
					)
					if confirmation == "Switch On" then
						player:sendMinitext("See Warps: ON")
						player.registry["see_warps"] = 1
						player:freeAsync()
						f1npc.click(player, npc)
					elseif confirmation == "Switch Off" then
						player:sendMinitext("See Warps: OFF")
						player.registry["see_warps"] = 0
						player:freeAsync()
						f1npc.click(player, npc)
					end
				elseif menu == "Toggle Extra Spell Info" then
					local currentStatus
					if player.registry["extra_spell_info"] == 0 then
						currentStatus = "OFF"
					elseif player.registry["extra_spell_info"] == 1 then
						currentStatus = "ON"
					end
					confirmation =
						player:menuString(
						"<B>[Extra Spell Info]\nSome spells can display extra information in your status bar.\n\nCurrent display: " ..
							currentStatus,
						{"Switch On", "Switch Off"}
					)
					if confirmation == "Switch On" then
						player:sendMinitext("Extra Spell Info: ON")
						player.registry["extra_spell_info"] = 1
						player:freeAsync()
						f1npc.click(player, npc)
					elseif confirmation == "Switch Off" then
						player:sendMinitext("Extra Spell Info: OFF")
						player.registry["extra_spell_info"] = 0
						player:freeAsync()
						f1npc.click(player, npc)
					end
				end
			elseif menu == "Spawn tool" then
				spawn_tool.click(player, npc)
			elseif menu == "War info (GM only)" then
				war.f1click(player, npc)
			elseif menu == "Mob Tools" then
				add_mon.click(player, npc)
			elseif menu == "Silver thread" then
				if player.state == 1 then
					if player.m == 2001 and player.quest["maiden"] == 9 then
						player:warp(1014, 20, 18)
						player.quest["maiden"] = 8
						if player.health == 0 then
							player.state = 1
							player:updateState()
						end
					elseif player.region == 1 or player.region == 2 or player.region == 3 then
						player:warp(1014, 20, 18)
						if player.health == 0 then
							player.state = 1
							player:updateState()
						end
					elseif player.region == 4 then
						player:warp(4058, 5, 9)
						if player.health == 0 then
							player.state = 1
							player:updateState()
						end
					elseif player.mapTitle == "Trial of Strength and Wits" then
						player:warp(1014, 20, 18)
						if player.health == 0 then
							player.state = 1
							player:updateState()
						end
					end
				end
			elseif menu == "Recover Death Pile" then
				player:recoverDeathPile()
			elseif menu == "Test Script" then
				--elseif menu == "Away Mode" then
				--	local afkMessage = player:input("I'm Away Right Now! Please call me later!\n<<Type afk to use current>>\nor Enter New AFK Message:")
				--	player.afkMessage = afkMessage
				--player:sendMinitext("Done!")
				npc_test_vending.click(player, npc)
			elseif menu == "Delete Item" then
				f1npc.deleteItem(player, npc)
			elseif menu == "Vending" then
				vending_menu.click(player, npc)
			end
		end
	),
	deleteItem = function(player, npc)
		--	clone.gfx(player, npc)

		local name = "<b>[Delete Item]\n\n"
		local t = {graphic = convertGraphic(1190, "monster"), color = 0}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 2

		local items, found, amount = {}, 0, 0

		for i = 0, player.maxInv do
			nItem = player:getInventoryItem(i)
			if nItem ~= nil and nItem.id > 0 then
				if (#items > 0) then
					found = 0
					for j = 1, #items do
						if (items[j] == nItem.id) then
							found = 1
							break
						end
					end
					if (found == 0) then
						table.insert(items, nItem.id)
					end
				else
					table.insert(items, nItem.id)
				end
			end
		end
		if #items == 0 then
			player:dialogSeq({t, name .. "You don't have any item in your inventory!"})
			return
		else
			clone.gfx(player, npc)
			choice = player:sell(name .. "What item do you wish to delete?", items)
			item = player:getInventoryItem(choice - 1)
			if item == nil then
				return
			else
				if item.maxAmount > 1 and item.amount > 1 then
					amount = math.abs(tonumber(math.floor(player:input(name .. "How many " .. item.name .. " to delete?"))))
					if player:hasItem(item.id, amount) ~= true then
						amountCheck = player:hasItem(item.id, amount)
						amount = amountCheck
					end
				else
					amount = 1
				end
				confirm = player:menuString(name .. "Are you sure to delete " .. amount .. " " .. item.name .. "?", {"Yes", "No"})
				if confirm == "Yes" then
					if player.registry["bank_pin"] == 0 then
						register_bankPin.click(player, npc)
					else
						input = tonumber(player:input(name .. "Enter your bank pin to proceed."))
						if input == player.registry["bank_pin"] then
							if player:hasItem(item.id, amount) == true then
								player:msg(4, "[INFO] You successfuly delete " .. amount .. " pcs of your " .. item.name .. "!", player.ID)
								player:removeItem(item.id, amount)
								f1npc.deleteItem(player, npc)
							else
								player:dialogSeq({t, name .. "You don't have that item!"})
							end
						else
							player:dialogSeq({t, name .. "Access Denied"})
						end
					end
				end
			end
		end
	end
}
