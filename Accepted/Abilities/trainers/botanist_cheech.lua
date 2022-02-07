botanist_cheech = {
	click = async(
		function(player, npc)
			---------------------------------
			--Local Variable Initialization--
			---------------------------------
			local name
			local t

			--local cheechLastTalkTime
			--local cheechDispo
			--local localDispo
			local npcID = npc.id
			---------------------------------
			--Set Variables -----------------
			---------------------------------
			name = "<b>[" .. npc.name .. "]\n\n" -- Set name = "Botanist Cheech"
			t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor} -- Set the grapic for the window

			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			--cheechLastTalkTime = player.registry["last_talk_time_297"]
			--cheechDispo = player.registry["disposition_297"]

			--------------------------------
			--Main executioon---------------
			--------------------------------
			--player:talkSelf(0,"Disp Before Encounter: "..cheechDispo)
			--NPC Description
			player:dialogSeq(
				{
					t,
					name ..
						"An elderly man stands before you, he looks at you from behind bushy eyebrows.  He leans forward on a purple staff.  He looks in your direction and speaks..."
				},
				1
			)

			if player.registry["cheech_first_encounter"] == 0 then
				botanist_cheech.firstEncounter(player, npc, cheechLastTalkTime, cheechDispo)
			else
				--player.registry["disposition_297"] = cheechDispo
				--cheechLastTalkTime = player.registry["last_talk_time_297"]
				--cheechDispo = player.registry["disposition_297"]
				--
				--cheechDispo = setDisposition(player, npcID, 0, 0)
				--player.registry["disposition_297"] = cheechDispo

				botanist_cheech.mainMenu(player, npc, cheechLastTalkTime, cheechDispo)
			end
		end
	),
	firstEncounter = function(player, npc, cheechLastTalkTime, cheechDispo)
		---------------------------------
		--Local Variable Initialization--
		---------------------------------
		--local localDispo =  cheechDispo
		--local localcheechLastTalkTime = cheechLastTalkTime
		local name = "<b>[" .. npc.name .. "]\n\n" -- Set name = "botanist cheech"
		local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor} -- Set the grapic for the window

		local playerGender = player.sex
		local playerBaseClass = player.baseClass
		local ability = "pulverization"

		local optscheechFirst = {}
		local nameResponseMenuOption
		local npcID = npc.ID

		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		player.lastClick = npc.ID

		-- If this is the first time we have talked with cheech:
		--if localcheechLastTalkTime == 0 then
		-- Initialize the disposition and Last Talk Time
		--localDispo = 302400
		--localcheechLastTalkTime = os.time()

		--Cheech likes wizards, you get bonus dispo if you are one when you first talk to him.
		--if playerBaseClass == 3 then
		--	player:dialogSeq({t, name.."Hey man!  You know your herbs don't you!"}, 1)
		--	localDispo = localDispo + 20000
		--	player:sendMinitext("Disposition Increased: +7,000")
		--end

		--Set your response choices.
		--Mayeb give some different choices based on the players current Karma...
		table.insert(optscheechFirst, "" .. player.name) -- player name (Choice 1)
		table.insert(optscheechFirst, "Why would I tell you?") -- neutral responses
		table.insert(optscheechFirst, "F**k off") -- hateful work

		--NPC Description
		nameResponseMenuOption =
			player:menuString("Ay!  I don't think we have met before, what is your name??", optscheechFirst)

		--Responses to your initial encounter.
		if nameResponseMenuOption == "" .. player.name then
			--localDispo = localDispo + 100000
			--if player.gmLevel > 0 then
			--	player:sendMinitext("Disposition Increased: +100,000")
			--end
			player:dialogSeq({t, name .. "Awesome man!" .. player.name .. "!\n\nWhat can I get for you today?"}, 1)
		elseif nameResponseMenuOption == "Why would I tell you?" then
			--localDispo = localDispo
			--if player.gmLevel > 0 then
			--	player:sendMinitext("Disposition Increased: +0")
			--end
			player:dialogSeq({t, name .. "..."}, 1)
		elseif nameResponseMenuOption == "F**k off" then
			player:dialogSeq({t, name .. "You need get outta here!  Chill out before you come back..."}, 1)
		--localDispo = localDispo - 275000
		--if player.gmLevel > 0 then
		--	player:sendMinitext("Disposition Decreased: -275,000")
		--end
		end

		player.registry["cheech_first_encounter"] = 1
		--player.registry["last_talk_time_297"] = os.time()
		--player.registry["disposition_297"] = localDispo
		--player.registry["last_disp_inc_time_297"] = os.time()
		--end

		return
	end,
	mainMenu = function(player, npc, cheechLastTalkTime, cheechDispo)
		---------------------------------
		--Local Variable Initialization--
		---------------------------------
		--local localDispo =  cheechDispo
		--local localcheechLastTalkTime = cheechLastTalkTime

		local name = "<b>[" .. npc.name .. "]\n\n" -- Set name = "botanist cheech"
		local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor} -- Set the grapic for the window
		local powderImage
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		player.lastClick = npc.ID

		local playerGender = player.sex
		local playerBaseClass = player.baseClass
		local ability = "pulverization"

		local optscheechFirst = {}
		local optsMainMenu = {}
		local mainMenuGreeting

		table.insert(optsMainMenu, "Shop")
		--	table.insert(optsMainMenu, "Storage")--Only some NPCs have this.
		table.insert(optsMainMenu, "Talk")
		table.insert(optsMainMenu, "Repair") --Only some NPCs have this.
		table.insert(optsMainMenu, "Leave")

		if player.gmLevel > 0 then
			table.insert(optsMainMenu, "Secret Shop")
			table.insert(optsMainMenu, "Reset Pulverization")
			--table.insert(optsMainMenu, "Reset Disposition")
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
		--[[ADD THIS BACK IN WHEN DISPOSITION IS WORKING!!!	
	if localDispo > 529200 and localDispo < 604800 then
		mainMenuGreeting = "Hey man!  How have you been! "..player.name.."!!!\n What can I get for ya!!!!"
	elseif localDispo > 378000 and localDispo < 529199 then
		mainMenuGreeting = "How have you been!!!  What can I do for you today?"
	elseif localDispo > 226800 and localDispo < 377999 then
		mainMenuGreeting = "How can I help you?"
	elseif localDispo > 075600 and localDispo < 226799 then
	    mainMenuGreeting = "Hurry up and get what you need..."
	elseif localDispo >= 000000 and localDispo < 075599 then
		mainMenuGreeting = "Get the hell out of here!!!"
				player:popUp(mainMenuGreeting.."                      Current Disposition with Cheech: "..localDispo)
		return
	else
		mainMenuGreeting = "ERROR:  THIS SHOULD NOT BE ACCESSIBLE"
		player:talk(0,"Current Disposition: "..localDispo)
	end
]] -- Main Menu display
		mainMenuOption = player:menuString(name .. " " .. mainMenuGreeting, optsMainMenu)

		if mainMenuOption == "Secret Shop" then
			local optsShopMenu = {}
			local secretSellItems = {
				407,
				3531,
				3532,
				3533,
				3534,
				3631,
				3632,
				3633,
				3634,
				3130,
				3200,
				3201,
				3300,
				3301,
				3302,
				3303,
				3310,
				3311
			}
			local secretBuyitems = {
				407,
				3531,
				3532,
				3533,
				3534,
				3631,
				3632,
				3633,
				3634,
				3130,
				3200,
				3201,
				3300,
				3301,
				3302,
				3303,
				3310,
				3311
			}

			table.insert(optsShopMenu, "Buy")
			table.insert(optsShopMenu, "Sell")
			table.insert(optsShopMenu, "Back")

			shopMenuOption = player:menuString(name .. " " .. mainMenuGreeting, optsShopMenu)

			if shopMenuOption == "Buy" then
				--player.registry["disposition_297"] = localDispo
				--player.registry["last_talk_time_297"] = os.time()
				--botanist_cheech.mainMenu(player,npc, cheechLastTalkTime, localDispo)
				player:buyExtend(name .. "What can I sell you today?", secretBuyitems)
			elseif shopMenuOption == "Sell" then
				--player.registry["disposition_297"] = localDispo
				--player.registry["last_talk_time_297"] = os.time()
				--botanist_cheech.mainMenu(player,npc, cheechLastTalkTime, localDispo)
				player:sellExtend(name .. "What do you wish to sell?", secretSellItems)
			elseif shopMenuOption == "Back" then
			--player.registry["disposition_297"] = localDispo
			--player.registry["last_talk_time_297"] = os.time()
			--botanist_cheech.mainMenu(player,npc, cheechLastTalkTime, localDispo)
			end
		elseif mainMenuOption == "Shop" then
			--	elseif mainMenuOption == "Storage" then
			--		inn_keeper2.f1click(player, npc)
			-------------------------------------
			-- Talk Options Menu ----------------
			-------------------------------------
			local optsShopMenu = {}
			local buyitems = {407, 3103, 3104, 3631, 3632, 3200, 3201}

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
				3111, -- Potion Recipies
				3130,
				3131,
				3132, -- Potion Bags
				3200,
				3201,
				3202,
				3203, -- bottles
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
				3511, -- flowers
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
				3611, -- powders
				3531,
				3532,
				3533,
				3534, -- herbalism tools (herb cutters)
				3631,
				3632,
				3633,
				3634
			} -- pulverization tools (pestles)

			local secretSellItems = {3533, 3534, 3633, 3634}

			table.insert(optsShopMenu, "Buy")
			table.insert(optsShopMenu, "Sell")
			table.insert(optsShopMenu, "Back")

			shopMenuOption = player:menuString(name .. " " .. mainMenuGreeting, optsShopMenu)

			if shopMenuOption == "Buy" then
				--player.registry["disposition_297"] = localDispo
				--player.registry["last_talk_time_297"] = os.time()
				--botanist_cheech.mainMenu(player,npc, cheechLastTalkTime, localDispo)
				player:buyExtend(name .. "What can I sell you today?", buyitems)
			elseif shopMenuOption == "Sell" then
				--player.registry["disposition_297"] = localDispo
				--player.registry["last_talk_time_297"] = os.time()
				--botanist_cheech.mainMenu(player,npc, cheechLastTalkTime, localDispo)
				player:sellExtend(name .. "What do you wish to sell?", sellitems)
			elseif shopMenuOption == "Back" then
			--player.registry["disposition_297"] = localDispo
			--player.registry["last_talk_time_297"] = os.time()
			--botanist_cheech.mainMenu(player,npc, cheechLastTalkTime, localDispo)
			end
		elseif mainMenuOption == "Talk" then
			local optsTalkMenu = {}
			--local lastTalkTime = player.registry["last_talk_time_297"]
			--local lastDispInc = player.registry["last_disp_inc_time_297"]
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
				--[[
			A place holder for right not
			Need to determine what information to give out this way
		
			]]
				-- Disposition Update / Check --
				--if timeSinceLastDispInc > 86400 then -- Has it been 24 since the last increase?
				--	localDispo = localDispo + 15000
				--	if player.gmLevel > 0 then
				--		player:sendMinitext("Disposition Increased: 15,000")
				--	end
				--	player.registry["last_disp_inc_time_297"] = os.time()
				--
				--else
				--	if player.gmLevel > 0 then
				--		player:sendMinitext("No Change, Come back after 24 Hours")
				--		player:sendMinitext("Time Since Last Disp Inc (SEC): "..timeSinceLastDispInc)
				--		player:sendMinitext("Time Since Last Disp Inc (HOURS): "..round((timeSinceLastDispInc / 3600),2))
				--	end
				--end
				--
				--player.registry["disposition_297"] = localDispo
				--player.registry["last_talk_time_297"] = os.time()
				--botanist_cheech.mainMenu(player,npc, localcheechLastTalkTime, localDispo)
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
				--		player.registry["last_disp_inc_time_297"] = os.time()
				--
				--	else
				--		if player.gmLevel > 0 then
				--			player:sendMinitext("No Change, Come back after 24 Hours")
				--			player:sendMinitext("Time Since Last Disp Inc (SEC): "..timeSinceLastDispInc)
				--			player:sendMinitext("Time Since Last Disp Inc (HOURS): "..round((timeSinceLastDispInc / 3600),2))
				--		end
				--	end
				--	player.registry["disposition_297"] = localDispo
				--	player.registry["last_talk_time_297"] = os.time()
				--	botanist_cheech.mainMenu(player,npc, localcheechLastTalkTime, localDispo)
				player:dialogSeq(
					{t, name .. "Oh, I don't have much to say right now.  I am new to the land and have yet to get used to things..."},
					1
				)
			 --
			elseif talkMenuOption == "Skills" then
				local optsSkillMenu = {}

				player:dialogSeq(
					{t, name .. "I do know some things about pulverizing herbs, what would you like to know about?"},
					1
				)

				table.insert(optsSkillMenu, "About Herb Pulverization")
				if player.registry["learned_pulverization"] == 0 then
					if player.registry["refining_skills"] < 4 then
						table.insert(optsSkillMenu, "Learn Herb Pulverization")
					end
				end
				table.insert(optsSkillMenu, "Back")

				skillMenuOption = player:menuString(name .. " " .. mainMenuGreeting, optsSkillMenu)

				if skillMenuOption == "Back" then
					botanist_cheech.mainMenu(player, npc, localcheechLastTalkTime, localDispo)
				elseif skillMenuOption == "About Herb Pulverization" then
					local optsAboutMenu = {}

					table.insert(optsAboutMenu, "About Powders")
					table.insert(optsAboutMenu, "About Herb Pulverization")
					table.insert(optsAboutMenu, "About the Tools")
					table.insert(optsAboutMenu, "End Conversation")

					aboutMenuOption = player:menuString(name .. " " .. mainMenuGreeting, optsAboutMenu)

					if aboutMenuOption == "About Powders" then
						local optsAboutPowdersMenu = {}
						table.insert(optsAboutPowdersMenu, "General Information")

						if player.registry["pulverization_level"] > 0 then
							table.insert(optsAboutPowdersMenu, "Sanguine Powder")
							table.insert(optsAboutPowdersMenu, "Cobalt Powder")
						end
						if player.registry["pulverization_level"] > 1 then
						end
						if player.registry["pulverization_level"] > 2 then
							table.insert(optsAboutPowdersMenu, "Crushed Mushroom Caps")
						end
						if player.registry["pulverization_level"] > 3 then
						end
						if player.registry["pulverization_level"] > 4 then
							table.insert(optsAboutPowdersMenu, "Violet Powder")
						end
						if player.registry["pulverization_level"] > 5 then
							table.insert(optsAboutPowdersMenu, "Enhancing Powder")
						end
						if player.registry["pulverization_level"] > 6 then
							table.insert(optsAboutPowdersMenu, "Sleep Powder")
						end
						if player.registry["pulverization_level"] > 7 then
							table.insert(optsAboutPowdersMenu, "Weakening Powder")
						end
						if player.registry["pulverization_level"] > 8 then
							table.insert(optsAboutPowdersMenu, "Inhibiting Powder")
						end
						if player.registry["pulverization_level"] > 9 then
						end
						if player.registry["pulverization_level"] > 10 then
							table.insert(optsAboutPowdersMenu, "Empowering Powder")
						end
						if player.registry["pulverization_level"] > 11 then
							table.insert(optsAboutPowdersMenu, "Brutish Powder")
						end
						if player.registry["pulverization_level"] > 12 then
							table.insert(optsAboutPowdersMenu, "Dancing Powder")
						end
						if player.registry["pulverization_level"] > 13 then
						end
						if player.registry["pulverization_level"] > 14 then
						end
						if player.registry["pulverization_level"] > 15 then
						end

						if player.gmLevel > 0 then
							table.insert(optsAboutPowdersMenu, "General Information")
							table.insert(optsAboutPowdersMenu, "Sanguine Powder")
							table.insert(optsAboutPowdersMenu, "Cobalt Powder")
							table.insert(optsAboutPowdersMenu, "Crushed Mushroom Caps")
							table.insert(optsAboutPowdersMenu, "Violet Powder")
							table.insert(optsAboutPowdersMenu, "Enhancing Powder")
							table.insert(optsAboutPowdersMenu, "Sleep Powder")
							table.insert(optsAboutPowdersMenu, "Weakening Powder")
							table.insert(optsAboutPowdersMenu, "Inhibiting Powder")
							table.insert(optsAboutPowdersMenu, "Empowering Powder")
							table.insert(optsAboutPowdersMenu, "Brutish Powder")
							table.insert(optsAboutPowdersMenu, "Dancing Powder")
						end

						table.insert(optsAboutPowdersMenu, "Leave")

						aboutPowdersMenuOption = player:menuString(name .. " " .. mainMenuGreeting, optsAboutPowdersMenu)
						name = "<b>" .. aboutPowdersMenuOption .. "\n\n"

						if aboutPlantsMenuOption == "General Information" then
							--if timeSinceLastDispInc > 86400 then
							--	localDispo = localDispo + 15000
							--	if player.gmLevel > 0 then
							--		player:sendMinitext("Disposition Increased: 15,000")
							--	end
							--	player.registry["last_disp_inc_time_297"] = os.time()
							--
							--else
							--	if player.gmLevel > 0 then
							--		player:sendMinitext("No Change, Come back after 24 Hours")
							--		player:sendMinitext("Time Since Last Disp Inc (SEC): "..timeSinceLastDispInc)
							--		player:sendMinitext("Time Since Last Disp Inc (HOURS): "..round((timeSinceLastDispInc / 3600),2))
							--	end
							--end
							--player.registry["disposition_297"] = localDispo
							--player.registry["last_talk_time_297"] = os.time()
							--botanist_cheech.mainMenu(player,npc, localcheechLastTalkTime, localDispo)
							player:dialogSeq(
								{
									t,
									name ..
										"Many plants are found all throughout the land.  Some of these plants are very useful and can be harvested.  ",
									name ..
										"To harvest these plants, one needs to have an Herb Cutting Knife in hand.  Cut down the herb with the knife by swinging at it!  ",
									name ..
										"The better the quality of your Knife, and the more skilled you are at Herbalism, the faster you can harvest herbs and the more likely you will get more than one flower from a plant."
								},
								1
							)
						elseif aboutPowdersMenuOption == "Sanguine Powder" then
							--player.registry["disposition_297"] = localDispo
							--player.registry["last_talk_time_297"] = os.time()
							--botanist_cheech.mainMenu(player,npc, localcheechLastTalkTime, localDispo)
							player:dialogSeq({t, name .. "Test Dialog about Sanguine Powder."}, 1)
						elseif aboutPowdersMenuOption == "Cobalt Powder" then
							--player.registry["disposition_297"] = localDispo
							--player.registry["last_talk_time_297"] = os.time()
							--botanist_cheech.mainMenu(player,npc, localcheechLastTalkTime, localDispo)
							player:dialogSeq({t, name .. "Test Dialog about Cobalt Powder."}, 1)
						elseif aboutPowdersMenuOption == "Crushed Mushroom Caps" then
							--player.registry["disposition_297"] = localDispo
							--player.registry["last_talk_time_297"] = os.time()
							--botanist_cheech.mainMenu(player,npc, localcheechLastTalkTime, localDispo)
							player:dialogSeq({t, name .. "Test Dialog about Crushed Mushroom Caps."}, 1)
						elseif aboutPowdersMenuOption == "Violet Powder" then
							--player.registry["disposition_297"] = localDispo
							--player.registry["last_talk_time_297"] = os.time()
							--botanist_cheech.mainMenu(player,npc, localcheechLastTalkTime, localDispo)
							player:dialogSeq({t, name .. "Test Dialog about Violet Powder."}, 1)
						elseif aboutPowdersMenuOption == "Enhancing Powder" then
							--player.registry["disposition_297"] = localDispo
							--player.registry["last_talk_time_297"] = os.time()
							--botanist_cheech.mainMenu(player,npc, localcheechLastTalkTime, localDispo)
							player:dialogSeq({t, name .. "Test Dialog about Enhancing Powder."}, 1)
						elseif aboutPowdersMenuOption == "Sleep Powder" then
							--player.registry["disposition_297"] = localDispo
							--player.registry["last_talk_time_297"] = os.time()
							--botanist_cheech.mainMenu(player,npc, localcheechLastTalkTime, localDispo)
							player:dialogSeq({t, name .. "Test Dialog about Sleep Powder."}, 1)
						elseif aboutPowdersMenuOption == "Weakening Powder" then
							--player.registry["disposition_297"] = localDispo
							--player.registry["last_talk_time_297"] = os.time()
							--botanist_cheech.mainMenu(player,npc, localcheechLastTalkTime, localDispo)
							player:dialogSeq({t, name .. "Test Dialog about Weakening Powder."}, 1)
						elseif aboutPowdersMenuOption == "Inhibiting Powder" then
							--player.registry["disposition_297"] = localDispo
							--player.registry["last_talk_time_297"] = os.time()
							--botanist_cheech.mainMenu(player,npc, localcheechLastTalkTime, localDispo)
							player:dialogSeq({t, name .. "Test Dialog about Inhibiting Powder."}, 1)
						elseif aboutPowdersMenuOption == "Empowering Powder" then
							--player.registry["disposition_297"] = localDispo
							--player.registry["last_talk_time_297"] = os.time()
							--botanist_cheech.mainMenu(player,npc, localcheechLastTalkTime, localDispo)
							player:dialogSeq({t, name .. "Test Dialog about Empowering Powder."}, 1)
						elseif aboutPowdersMenuOption == "Brutish Powder" then
							--player.registry["disposition_297"] = localDispo
							--player.registry["last_talk_time_297"] = os.time()
							--botanist_cheech.mainMenu(player,npc, localcheechLastTalkTime, localDispo)
							player:dialogSeq({t, name .. "Test Dialog about Brutish Powder."}, 1)
						elseif aboutPowdersMenuOption == "Dancing Powder" then
							--player.registry["disposition_297"] = localDispo
							--player.registry["last_talk_time_297"] = os.time()
							--botanist_cheech.mainMenu(player,npc, localcheechLastTalkTime, localDispo)
							player:dialogSeq({t, name .. "Test Dialog about Dancing Powder."}, 1)
						elseif aboutPotionsMenuOption == "Leave" then
							player:dialogSeq({flowerImage, name .. "."}, 1)
						end
					elseif aboutMenuOption == "About Herb Pulverization" then
						player:dialogSeq(
							{
								t,
								name .. "In pharmacology, trituration can also refer to the process of grinding one compound into another to",
								name ..
									"dilute one of the ingredients, add volume for processing and handling, or to mask undesirable qualities. ."
							},
							1
						)
						botanist_cheech.mainMenu(player, npc, localcheechLastTalkTime, localDispo)
					elseif
						aboutMenuOption == "About the Tools"
					 --
					 then
						--[[ Tool List -------
					- Basic Herb Cutter:	3531
					- Quality Herb Cutter:	3532
					- Superior Herb Cutter: 3533
					- Artisan Herb Cutter:  3534
					]] player:dialogSeq(
							{
								t,
								name .. "Mortars and pestles were traditionally used in pharmacies to crush various ingredients prior ",
								name .. "to preparing an extemporaneous prescription. The mortar and pestle, with the Rod of Asclepius, ",
								name ..
									"the Orange Cross, and others, is one of the most pervasive symbols of pharmacology,[4] along with the show globe.",
								name ..
									"For pharmaceutical use, the mortar and the head of the pestle are usually made of porcelain, while the handle of the pestle is made of wood.."
							},
							1
						)
						botanist_cheech.mainMenu(player, npc, localcheechLastTalkTime, localDispo)
					end
				elseif skillMenuOption == "Learn Herb Pulverization" then
					local optsLearnHerbalism = {}

					table.insert(optsLearnHerbalism, "Yes, I am ready to learn.")
					table.insert(optsLearnHerbalism, "No, I have reconsidered.")

					player:dialogSeq(
						{
							t,
							name .. "Herb Pulverization is the skill by which we learn about powders and how we use them in making potions.",
							name .. "There are many powders which can be created from many plants and other items.",
							name ..
								"Once pulverised, the newly created paste or powder will need to have other items added and be placed into a container to be used as a drinkable (or throwable) potion.",
							name .. "You can learn and become a master of four Refining Level skills."
						},
						1
					)

					learnSkillMenuOption =
						player:menuString(name .. "Are you ready to learn the Herb Pulverization skill?", optsLearnHerbalism)

					if learnSkillMenuOption == "Yes, I am ready to learn." then
						--player:sendMinitext("Disposition Increased: 10,000")
						--player.registry["last_disp_inc_time_297"] = os.time()
						--player.registry["disposition_297"] = localDispo + 10000
						--player.registry["last_talk_time_297"] = os.time()
						--botanist_cheech.mainMenu(player,npc, localcheechLastTalkTime, localDispo)
						player:dialogSeq({"Congradulations, you have learned about Herb Pulverization!"}, 1)

						if player:hasLegend("beginner_pulverization") then
							player:removeLegendbyName("beginner_pulverization")
						end

						player:addLegend("Beginner Pulverizer", "beginner_pulverization", 125, 108)
						player:msg(4, "=== New Legend Added! ===", player.ID)
						player.registry["refining_skills"] = player.registry["refining_skills"] + 1
						player.registry["learned_pulverization"] = 1
						player.registry["pulverization_level"] = 1
						player.registry["pulverization_tnl"] = 1500
						player:sendMinitext("You've learned Herb Pulverization!")
					elseif learnSkillMenuOption == "No, I have reconsidered." then
						--player.registry["disposition_297"] = localDispo
						--player.registry["last_talk_time_297"] = os.time()
						player:dialogSeq({"Oh, alright, well please come back when you are ready to learn!"}, 1)
					end
				end
			elseif talkMenuOption == "Part-Time Job" then
				player:dialogSeq({t, name .. "Test Dialog about Part Time jobs."}, 1)
			--player.registry["disposition_297"] = localDispo
			--player.registry["last_talk_time_297"] = os.time()
			end
		elseif mainMenuOption == "Reset Disposition" then
			--player.registry["last_talk_time_297"] = 0
			--player.registry["disposition_297"] = 0

			npc:talk(2, "Reset done for " .. player.name)
		elseif mainMenuOption == "Reset Pulverization" then
			player.registry["learned_pulverization"] = 0
			player.registry["pulverization_level"] = 0
			player.registry["pulverization_tnl"] = 0

			npc:talk(2, "Reset done for " .. player.name)
		elseif mainMenuOption == "Leave" then
			player:dialogSeq({t, name .. "See you soon!"}, 1)
		--player.registry["disposition_297"] = localDispo
		--player.registry["last_talk_time_297"] = os.time()
		end
		return
	end
}
