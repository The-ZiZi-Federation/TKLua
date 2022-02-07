apothecary_hofmann = {
	click = async(
		function(player, npc)
			---------------------------------
			--Local Variable Initialization--
			---------------------------------
			local name
			local t

			--local hofmannLastTalkTime
			--local hofmannDispo
			--local localDispo
			local npcID = npc.id
			---------------------------------
			--Set Variables -----------------
			---------------------------------
			name = "<b>[" .. npc.name .. "]\n\n" -- Set name = "Apothecary Hofmann"
			t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor} -- Set the grapic for the window

			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			--hofmannLastTalkTime = player.registry["last_talk_time_298"]
			--hofmannDispo = player.registry["disposition_298"]

			--------------------------------
			--Main executioon---------------
			--------------------------------
			--NPC Description

			player:dialogSeq(
				{
					t,
					name ..
						"An elderly man sits behind the desk, his wise eyes stare down.  A long white beard frames his face and flows down his chest.  He looks up..."
				},
				1
			)
			if player.registry["hofmann_first_encounter"] == 0 then
				apothecary_hofmann.firstEncounter(player, npc, hofmannLastTalkTime, hofmannDispo)
			else
				--player.registry["disposition_298"] = hofmannDispo
				--hofmannLastTalkTime = player.registry["last_talk_time_298"]
				--hofmannDispo = player.registry["disposition_298"]

				--hofmannDispo = setDisposition(player, npcID, 0, 0)
				--player.registry["disposition_298"] = hofmannDispo

				apothecary_hofmann.mainMenu(player, npc, hofmannLastTalkTime, hofmannDispo)
			end
		end
	),
	firstEncounter = function(player, npc, hofmannLastTalkTime, hofmannDispo)
		--	---------------------------------
		--	--Local Variable Initialization--
		--	---------------------------------
		--	local localDispo =  hofmannDispo
		--    local localHofmannLastTalkTime = hofmannLastTalkTime
		local name = "<b>[" .. npc.name .. "]\n\n" -- Set name = "Apothecary Hofmann"
		local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor} -- Set the grapic for the window

		local playerGender = player.sex
		local playerBaseClass = player.baseClass
		local ability = "concocting"

		local optsHofmannFirst = {}
		local nameResponseMenuOption
		local npcID = npc.ID

		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		player.lastClick = npc.ID

		-- If this is the first time we have talked with Hofmann:
		--	if localHofmannLastTalkTime == 0 then
		-- Initialize the disposition and Last Talk Time
		--		localDispo = 302400
		--		localHofmannLastTalkTime = os.time()

		--		--Hofmann likes wizards, you get bonus dispo if you are one when you first talk to him.
		--		if playerBaseClass == 3 then
		--			player:dialogSeq({t, name.."A learned person you are....very good...."}, 1)
		--			localDispo = localDispo + 20000
		--			player:sendMinitext("Disposition Increased: +7,000")
		--		end

		--Set your response choices.

		table.insert(optsHofmannFirst, "" .. player.name) -- player name (Choice 1)
		table.insert(optsHofmannFirst, "Why would I tell you?") -- neutral responses
		table.insert(optsHofmannFirst, "F**k off") -- hateful work

		nameResponseMenuOption = player:menuString("Good day...", optsHofmannFirst)

		--Responses to your initial encounter.
		if nameResponseMenuOption == "" .. player.name then
			--			localDispo = localDispo + 100000
			--			if player.gmLevel > 0 then
			--				player:sendMinitext("Disposition Increased: +100,000")
			--			end
			player:dialogSeq(
				{
					t,
					name ..
						"Ahh, well I shall try and remember that.  Stop on by from time to time and say hello!\n\nWhat can I get for you today?"
				},
				1
			)
		elseif nameResponseMenuOption == "Why would I tell you?" then
			--			localDispo = localDispo
			--			if player.gmLevel > 0 then
			--				player:sendMinitext("Disposition Increased: +0")
			--			end
			player:dialogSeq({t, name .. "..."}, 1)
		elseif nameResponseMenuOption == "F**k off" then
			player:dialogSeq({t, name .. "Dude, thats uncalled for, you need to leave now!"}, 1)
		--			localDispo = localDispo - 275000
		--			if player.gmLevel > 0 then
		--				player:sendMinitext("Disposition Decreased: -275,000")
		--			end
		end
		player.registry["hofmann_first_encounter"] = 1

		--		player.registry["last_talk_time_298"] = os.time()
		--		player.registry["disposition_298"] = localDispo
		--		player.registry["last_disp_inc_time_298"] = os.time()
		--	end
		--
		return
	end,
	mainMenu = function(player, npc, hofmannLastTalkTime, hofmannDispo)
		---------------------------------
		--Local Variable Initialization--
		---------------------------------
		--local localDispo =  hofmannDispo
		--local localHofmannLastTalkTime = hofmannLastTalkTime

		local name = "<b>[" .. npc.name .. "]\n\n" -- Set name = "Apothecary Hofmann"
		local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor} -- Set the grapic for the window
		local potionImage
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		player.lastClick = npc.ID

		local playerGender = player.sex
		local playerBaseClass = player.baseClass
		local ability = "concocting"

		local optsHofmannFirst = {}
		local optsMainMenu = {}
		local mainMenuGreeting

		table.insert(optsMainMenu, "Shop")
		table.insert(optsMainMenu, "Storage") --Only some NPCs have this.
		table.insert(optsMainMenu, "Talk")
		--	table.insert(optsMainMenu, "Repair") --Only some NPCs have this.
		table.insert(optsMainMenu, "Leave")

		if player.gmLevel > 0 then
			table.insert(optsMainMenu, "Secret Shop")
			--table.insert(optsMainMenu, "Reset Disposition")
			table.insert(optsMainMenu, "Reset Concocting")
			table.insert(optsMainMenu, "Unlearn Skill")
		end
		 --

		--[[
setup greeting based off of disposition.  This is shown in the menu dialog.
529200 -- 604800            max value /super likes ya
378000 -- 529199            likes you
226800 -  302400 - 377999   Alright with ya
075600 -- 226799            Does not want you around, but does not remove you.
000000 -- 075599            Lowest you can go, keeps won't talk to you.
]] mainMenuGreeting =
			"How have you been!!!  What can I do for you today?"
		 --
		--[[  ADD THIS WHEN DISPO IS WORKING AGAIN!!!
	if localDispo > 529200 and localDispo < 604800 then
		mainMenuGreeting = "Well how the hell are you "..player.name.."!!!\n What can I get for ya!!!!"
	elseif localDispo > 378000 and localDispo < 529199 then
		mainMenuGreeting = "How have you been!!!  What can I do for you today?"
	elseif localDispo > 226800 and localDispo < 377999 then
		mainMenuGreeting = "How can I help you?"
	elseif localDispo > 075600 and localDispo < 226799 then
	    mainMenuGreeting = "Hurry up and get what you need..."
	elseif localDispo >= 000000 and localDispo < 075599 then
		mainMenuGreeting = "Get the hell out of here!!!"
		player:popUp(mainMenuGreeting.."                      Current Disposition with Hofmann: "..localDispo)
		return
	else
		mainMenuGreeting = "ERROR:  THIS SHOULD NOT BE ACCESSIBLE"
		player:talk(0,"Current Disposition: "..localDispo)
	end
]] -- Main Menu display
		mainMenuOption = player:menuString(name .. " " .. mainMenuGreeting, optsMainMenu)

		if mainMenuOption == "Secret Shop" then
			local optsShopMenu = {}
			local secretSellItems = {}
			local secretBuyitems = {}

			table.insert(optsShopMenu, "Buy")
			table.insert(optsShopMenu, "Sell")
			table.insert(optsShopMenu, "Back")

			shopMenuOption = player:menuString(name .. " " .. mainMenuGreeting, optsShopMenu)

			if shopMenuOption == "Buy" then
				--player.registry["disposition_298"] = localDispo
				--player.registry["last_talk_time_298"] = os.time()
				--botanist_cheech.mainMenu(player,npc, cheechLastTalkTime, localDispo)
				player:buyExtend(name .. "What can I sell you today?", secretBuyitems)
			elseif shopMenuOption == "Sell" then
				--player.registry["disposition_298"] = localDispo
				--player.registry["last_talk_time_298"] = os.time()
				--botanist_cheech.mainMenu(player,npc, cheechLastTalkTime, localDispo)
				player:sellExtend(name .. "What do you wish to sell?", secretSellItems)
			elseif shopMenuOption == "Back" then
			--player.registry["disposition_298"] = localDispo
			--player.registry["last_talk_time_298"] = os.time()
			--botanist_cheech.mainMenu(player,npc, cheechLastTalkTime, localDispo)
			end
		elseif mainMenuOption == "Shop" then
			local optsShopMenu = {}
			local buyitems = {407, 3531, 3532, 3631, 3632, 3103, 3104, 3130, 3200, 3201, 3202}

			local sellitems = {
				407,
				3002,
				3103,
				3104,
				3105,
				3106,
				3107,
				3108,
				3109,
				3110,
				3111, --all of the recipies can be sold
				3130,
				3131,
				3132, -- Potion Bags can be sold.
				3200,
				3201,
				3202,
				3203, -- Potion bottles can be sold
				3300,
				3301,
				3302,
				3303,
				3304,
				3305,
				3306, -- Vita Potions can be sold
				3310,
				3311,
				3312,
				3313,
				3314,
				3315,
				3316, -- Mana Potions can be sold
				3320,
				3321,
				3322,
				3323,
				3324,
				3325,
				3326, -- Shattering Potions Can be sold
				3501,
				3502,
				3503,
				3504,
				3505,
				3506,
				3507,
				3508,
				3509,
				3510,
				3511, -- Flowers can be SOld
				3601,
				3602,
				3603,
				3604,
				3605,
				3606,
				3607,
				3608,
				3609,
				3610,
				3611, -- Powders can be sold.
				3631,
				3632,
				3633,
				3634, -- Pestles can be sold.
				3531,
				3532,
				3533,
				3534
			} -- Herb Cutters can be sold back

			local secretSellItems = {3533, 3534, 3633, 3634}

			table.insert(optsShopMenu, "Buy")
			table.insert(optsShopMenu, "Sell")
			table.insert(optsShopMenu, "Back")

			shopMenuOption = player:menuString(name .. " " .. mainMenuGreeting, optsShopMenu)

			if shopMenuOption == "Buy" then
				--player.registry["disposition_298"] = localDispo
				--player.registry["last_talk_time_298"] = os.time()
				--apothecary_hofmann.mainMenu(player,npc, hofmannLastTalkTime, hofmannDispo)
				player:buyExtend(name .. "What can I sell you today?", buyitems)
			elseif shopMenuOption == "Sell" then
				--player.registry["disposition_298"] = localDispo
				--player.registry["last_talk_time_298"] = os.time()
				--apothecary_hofmann.mainMenu(player,npc, hofmannLastTalkTime, hofmannDispo)
				player:sellExtend(name .. "What do you wish to sell?", sellitems)
			elseif shopMenuOption == "Back" then
			--player.registry["disposition_298"] = localDispo
			--player.registry["last_talk_time_298"] = os.time()
			--apothecary_hofmann.mainMenu(player,npc, hofmannLastTalkTime, hofmannDispo)
			end
		elseif mainMenuOption == "Storage" then
			-------------------------------------
			-- Talk Options Menu ----------------
			-------------------------------------
			inn_keeper2.f1click(player, npc)
		elseif mainMenuOption == "Talk" then
			--elseif mainMenuOption == "Reset Disposition" then
			--	player.registry["last_talk_time_298"] = 0
			--    player.registry["disposition_298"] = 0
			--
			--	npc:talk(2, "Reset done for "..player.name)
			local optsTalkMenu = {}
			--local lastTalkTime = player.registry["last_talk_time_298"]
			--local lastDispInc = player.registry["last_disp_inc_time_298"]
			--local currentTime = os.time()
			--local timeSinceLastTalk = (lastTalkTime - currentTime)
			--local timeSinceLastDispInc = (currentTime - lastDispInc)

			table.insert(optsTalkMenu, "Small Talk")
			--if localDispo > 570000 then
			--	table.insert(optsTalkMenu, "Gossip!")
			--end
			table.insert(optsTalkMenu, "Skills")
			--table.insert(optsTalkMenu, "Part-Time Job")
			table.insert(optsTalkMenu, "End Conversation")

			talkMenuOption = player:menuString(name .. " " .. mainMenuGreeting, optsTalkMenu)

			-----------------------------
			-- Small Talk ---------------
			-----------------------------
			if talkMenuOption == "Small Talk" then
				--		A place holder for right not--
				--		Need to determine what information to give out this way.  What conditions and criteria to set in place for what is said.
				-- Disposition Update / Check --
				--if timeSinceLastDispInc > 86400 then
				--	localDispo = localDispo + 15000
				--	if player.gmLevel > 0 then
				--		player:sendMinitext("Disposition Increased: 15,000")
				--	end
				--	player.registry["last_disp_inc_time_298"] = os.time()
				--
				--else
				--	if player.gmLevel > 0 then
				--		player:sendMinitext("No Change, Come back after 24 Hours")
				--		player:sendMinitext("Time Since Last Disp Inc (SEC): "..timeSinceLastDispInc)
				--		player:sendMinitext("Time Since Last Disp Inc (HOURS): "..round((timeSinceLastDispInc / 3600),2))
				--	end
				--end
				--
				--player.registry["disposition_298"] = localDispo
				--player.registry["last_talk_time_298"] = os.time()
				--apothecary_hofmann.mainMenu(player,npc, hofmannLastTalkTime, hofmannDispo)
				---------------------------
				-- Gossip -----------------
				---------------------------
				--elseif talkMenuOption == "Gossip!" then
				--	player:dialogSeq({t, name.."I don't really know much about anyone right now."}, 1)
				--	--[[
				--	A place holder for right not
				--	Need to determine what information to give out this way
				--	Maybe have a randomization here with fun little trivia about other NPCs!
				--	]]--
				--	if timeSinceLastDispInc > 86400 then
				--		localDispo = localDispo + 15000
				--		if player.gmLevel > 0 then
				--			player:sendMinitext("Disposition Increased: 15,000")
				--		end
				--		player.registry["last_disp_inc_time_298"] = os.time()
				--
				--	else
				--		if player.gmLevel > 0 then
				--			player:sendMinitext("No Change, Come back after 24 Hours")
				--			player:sendMinitext("Time Since Last Disp Inc (SEC): "..timeSinceLastDispInc)
				--			player:sendMinitext("Time Since Last Disp Inc (HOURS): "..round((timeSinceLastDispInc / 3600),2))
				--		end
				--	end
				--	player.registry["disposition_298"] = localDispo
				--	player.registry["last_talk_time_298"] = os.time()
				--	apothecary_hofmann.mainMenu(player,npc, hofmannLastTalkTime, hofmannDispo)
				player:dialogSeq(
					{t, name .. "Oh, I don't have much to say right now.  I am new to the land and have yet to get used to things..."},
					1
				)
			elseif talkMenuOption == "Skills" then
				local optsSkillMenu = {}

				player:dialogSeq({t, name .. "Oh yes, I know about concocting potions, how can I help you??"}, 1)

				table.insert(optsSkillMenu, "About Potion Making")
				if player.registry["learned_concocting"] == 0 then
					if player.registry["production_skills"] < 3 then
						table.insert(optsSkillMenu, "Learn Potion Making")
					end
				end
				table.insert(optsSkillMenu, "Back")

				skillMenuOption = player:menuString(name .. " " .. mainMenuGreeting, optsSkillMenu)

				if skillMenuOption == "Back" then
					--apothecary_hofmann.mainMenu(player,npc, hofmannLastTalkTime, hofmannDispo)
				elseif skillMenuOption == "About Potion Making" then
					local optsAboutMenu = {}

					table.insert(optsAboutMenu, "About Potions")
					table.insert(optsAboutMenu, "About Potion Making")
					table.insert(optsAboutMenu, "About the Potion Stand")
					table.insert(optsAboutMenu, "End Conversation")

					aboutMenuOption = player:menuString(name .. " " .. mainMenuGreeting, optsAboutMenu)

					if aboutMenuOption == "About Potions" then
						local optsAboutPotionsMenu = {}

						if player.registry["concocting_level"] > 0 then
							table.insert(optsAboutPotionsMenu, "Vita Potions")
							table.insert(optsAboutPotionsMenu, "Mana Potions")
						end
						if player.registry["concocting_level"] > 1 then
						end
						if player.registry["concocting_level"] > 2 then
							table.insert(optsAboutPotionsMenu, "Shattering Potions")
						end
						if player.registry["concocting_level"] > 3 then
							table.insert(optsAboutPotionsMenu, "Sophoric Potions")
						end
						if player.registry["concocting_level"] > 4 then
							table.insert(optsAboutPotionsMenu, "Withering Potions")
						end
						if player.registry["concocting_level"] > 5 then
							table.insert(optsAboutPotionsMenu, "Stupifying Potions")
						end
						if player.registry["concocting_level"] > 6 then
							table.insert(optsAboutPotionsMenu, "Empowering Potions")
						end
						if player.registry["concocting_level"] > 7 then
							table.insert(optsAboutPotionsMenu, "Brutish Potions")
						end
						if player.registry["concocting_level"] > 8 then
							table.insert(optsAboutPotionsMenu, "Nimble Potions")
						end
						if player.registry["concocting_level"] > 9 then
						end
						if player.registry["concocting_level"] > 10 then
						end
						if player.registry["concocting_level"] > 11 then
						end
						if player.registry["concocting_level"] > 12 then
						end
						if player.registry["concocting_level"] > 13 then
						end
						if player.registry["concocting_level"] > 14 then
						end
						if player.registry["concocting_level"] > 15 then
						end

						if player.gmLevel > 0 then
							table.insert(optsAboutPowdersMenu, "General Information")
							table.insert(optsAboutPotionsMenu, "Vita Potions")
							table.insert(optsAboutPotionsMenu, "Mana Potions")
							table.insert(optsAboutPotionsMenu, "Shattering Potions")
							table.insert(optsAboutPotionsMenu, "Sophoric Potions")
							table.insert(optsAboutPotionsMenu, "Withering Potions")
							table.insert(optsAboutPotionsMenu, "Stupifying Potions")
							table.insert(optsAboutPotionsMenu, "Empowering Potions")
							table.insert(optsAboutPotionsMenu, "Brutish Potions")
							table.insert(optsAboutPotionsMenu, "Nimble Potions")
						end

						table.insert(optsAboutPotionsMenu, "Leave")

						-- local flowerImage = {graphic = convertGraphic(flowerlook#, "monster"), color = flowerColor#}	-- Set the grapic for the window

						aboutPotionsMenuOption = player:menuString(name .. " " .. mainMenuGreeting, optsAboutPotionsMenu)
						name = "<b>" .. aboutPotionsMenuOption .. "\n\n"

						if aboutPotionsMenuOption == "Vita Potions" then
							--player.registry["disposition_298"] = localDispo
							--player.registry["last_talk_time_298"] = os.time()
							--apothecary_hofmann.mainMenu(player,npc, hofmannLastTalkTime, hofmannDispo)
							player:dialogSeq({t, name .. "Test Dialog about Vita Potions."}, 1)
						elseif aboutPotionsMenuOption == "Mana Potions" then
							--player.registry["disposition_298"] = localDispo
							--player.registry["last_talk_time_298"] = os.time()
							--apothecary_hofmann.mainMenu(player,npc, hofmannLastTalkTime, hofmannDispo)
							player:dialogSeq({t, name .. "Test Dialog about Mana Potions."}, 1)
						elseif optsAboutPotionsMenu == "Shattering Potions" then
							--player.registry["disposition_298"] = localDispo
							--player.registry["last_talk_time_298"] = os.time()
							--apothecary_hofmann.mainMenu(player,npc, hofmannLastTalkTime, hofmannDispo)
							player:dialogSeq({t, name .. "Test Dialog about Shattering Potions."}, 1)
						elseif aboutPotionsMenuOption == "Sophoric Potions" then
							--player.registry["disposition_298"] = localDispo
							--player.registry["last_talk_time_298"] = os.time()
							--apothecary_hofmann.mainMenu(player,npc, hofmannLastTalkTime, hofmannDispo)
							player:dialogSeq({t, name .. "Test Dialog about Sophoric Potions."}, 1)
						elseif aboutPotionsMenuOption == "Withering Potions" then
							--player.registry["disposition_298"] = localDispo
							--player.registry["last_talk_time_298"] = os.time()
							--apothecary_hofmann.mainMenu(player,npc, hofmannLastTalkTime, hofmannDispo)
							player:dialogSeq({t, name .. "Test Dialog about Withering Potions."}, 1)
						elseif aboutPotionsMenuOption == "Stupifying Potions" then
							--player.registry["disposition_298"] = localDispo
							--player.registry["last_talk_time_298"] = os.time()
							--apothecary_hofmann.mainMenu(player,npc, hofmannLastTalkTime, hofmannDispo)
							player:dialogSeq({t, name .. "Test Dialog about Stupifying Potions."}, 1)
						elseif aboutPotionsMenuOption == "Empowering Potions" then
							--player.registry["disposition_298"] = localDispo
							--player.registry["last_talk_time_298"] = os.time()
							--apothecary_hofmann.mainMenu(player,npc, hofmannLastTalkTime, hofmannDispo)
							player:dialogSeq({t, name .. "Test Dialog about Empowering Potions."}, 1)
						elseif aboutPotionsMenuOption == "Brutish Potions" then
							--player.registry["disposition_298"] = localDispo
							--player.registry["last_talk_time_298"] = os.time()
							--apothecary_hofmann.mainMenu(player,npc, hofmannLastTalkTime, hofmannDispo)
							player:dialogSeq({t, name .. "Test Dialog about Brutish Potions."}, 1)
						elseif aboutPotionsMenuOption == "Nimble Potions" then
							--player.registry["disposition_298"] = localDispo
							--player.registry["last_talk_time_298"] = os.time()
							--apothecary_hofmann.mainMenu(player,npc, hofmannLastTalkTime, hofmannDispo)
							player:dialogSeq({t, name .. "Test Dialog about Nimble Potions."}, 1)
						elseif aboutPotionsMenuOption == "Leave" then
							player:dialogSeq({flowerImage, name .. "."}, 1)
						end
					elseif aboutMenuOption == "About Potion Making" then
						--apothecary_hofmann.mainMenu(player,npc, hofmannLastTalkTime, hofmannDispo)
						player:dialogSeq(
							{
								t,
								name ..
									"Potion Making / Concocting is the means by which one creates potions used to heal, harm and enhance oneself or an enemy."
							},
							1
						)
					elseif aboutMenuOption == "About the Potion Stand" then
						player:dialogSeq(
							{
								t,
								name ..
									"You can create your potions at a potion stand.  You need to have no weapon or item in your hands when you make a potion."
							},
							1
						)
					--apothecary_hofmann.mainMenu(player,npc, hofmannLastTalkTime, hofmannDispo)
					end
				elseif skillMenuOption == "Learn Potion Making" then
					local optsLearnConcocting = {}

					table.insert(optsLearnConcocting, "Yes, I am ready to learn.")
					table.insert(optsLearnConcocting, "No, I have reconsidered.")

					player:dialogSeq(
						{
							t,
							name .. "Potion Making is the skill by which one learns about creating and using different potions.",
							name ..
								"You will be able to heal, recover mana, weaken an enemies Might, Will or Grace and even bloster your own Might, Will or Grace.",
							name .. "Some potions are drank while others are thrown.  You can affect yourself, allies and enemies.",
							name ..
								"To make a potion of a certain type, you need to have read a recipie and have the required items in your inventory.",
							name .. "You can learn three production skills and become the a Grand Master of only one."
						},
						1
					)

					learnSkillMenuOption =
						player:menuString(name .. "Are you ready to learn the Potion Making Skill?", optsLearnConcocting)

					if learnSkillMenuOption == "Yes, I am ready to learn." then
						--player:sendMinitext("Disposition Increased: 10,000")
						--player.registry["last_disp_inc_time_297"] = os.time()
						--player.registry["disposition_298"] = localDispo + 10000
						--player.registry["last_talk_time_298"] = os.time()
						--apothecary_hofmann.mainMenu(player,npc, hofmannLastTalkTime, hofmannDispo)
						player:dialogSeq({"Congradulations, you have learned about Potion Making!"}, 1)

						if player:hasLegend("beginner_concocting") then
							player:removeLegendbyName("beginner_concocting")
						end

						player:addLegend("Beginner Potion Maker", "beginner_concocting", 125, 108)
						player:msg(4, "=== New Legend Added! ===", player.ID)
						player.registry["production_skills"] = player.registry["production_skills"] + 1
						player.registry["learned_concocting"] = 1
						player.registry["concocting_level"] = 1
						player.registry["concocting_tnl"] = 2250
						player:sendMinitext("You've learned Potion Concocting!")
					elseif learnSkillMenuOption == "No, I have reconsidered." then
						--player.registry["disposition_298"] = localDispo
						--player.registry["last_talk_time_298"] = os.time()
						player:dialogSeq({"Oh, alright, well please come back when you are ready to learn!"}, 1)
					end
				end
			elseif talkMenuOption == "Part-Time Job" then
				player:dialogSeq({t, name .. "Test Dialog about Part Time jobs."}, 1)
			--player.registry["disposition_298"] = localDispo
			--player.registry["last_talk_time_298"] = os.time()
			end
		elseif mainMenuOption == "Reset Concocting" then
			player.registry["learned_concocting"] = 0
			player.registry["concocting_level"] = 0
			player.registry["concocting_tnl"] = 0

			npc:talk(2, "Reset done for " .. player.name)
		elseif mainMenuOption == "Leave" then
			player:dialogSeq({t, name .. "Come back again!"}, 1)
		--player.registry["disposition_298"] = localDispo
		--player.registry["last_talk_time_298"] = os.time()
		end
		return
	end
}
