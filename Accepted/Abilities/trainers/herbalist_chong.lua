herbalist_chong = {
	click = async(
		function(player, npc)
			---------------------------------
			--Local Variable Initialization--
			---------------------------------
			local name
			local t

			--local chongLastTalkTime
			--local chongDispo
			--local localDispo
			local npcID = npc.id
			---------------------------------
			--Set Variables -----------------
			---------------------------------
			name = "<b>[" .. npc.name .. "]\n\n" -- Set name = "Herbalist Chong"
			t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor} -- Set the grapic for the window

			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			--chongLastTalkTime = player.registry["last_talk_time_296"]
			--chongDispo = player.registry["disposition_296"]

			--------------------------------
			--Main executioon---------------
			--------------------------------
			--NPC Description
			player:dialogSeq(
				{
					t,
					name ..
						"An elderly man stands before you, his wise eyes stare past you.  He holds a heavy oak staff which he leans on to keep upright."
				},
				1
			)
			if player.registry["chong_first_encounter"] == 0 then
				--chongLastTalkTime = player.registry["last_talk_time_296"]
				--chongDispo = player.registry["disposition_296"]
				--
				--chongDispo = setDisposition(player, npcID, 0, 0)
				--player.registry["disposition_296"] = chongDispo
				herbalist_chong.firstEncounter(player, npc, chongLastTalkTime, chongDispo)
			else
				--player.registry["disposition_296"] = chongDispo
				herbalist_chong.mainMenu(player, npc, chongLastTalkTime, chongDispo)
			end
		end
	),
	firstEncounter = function(player, npc, chongLastTalkTime, chongDispo)
		---------------------------------
		--Local Variable Initialization--
		---------------------------------
		--local localDispo =  chongDispo
		--local localChongLastTalkTime = chongLastTalkTime
		local name = "<b>[" .. npc.name .. "]\n\n" -- Set name = "Herbalist Chong"
		local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor} -- Set the grapic for the window

		local playerGender = player.sex
		local playerBaseClass = player.baseClass
		local ability = "herbalism"

		local optsChongFirst = {}
		local nameResponseMenuOption
		local npcID = npc.ID

		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		player.lastClick = npc.ID

		-- If this is the first time we have talked with Chong:
		--if localChongLastTalkTime == 0 then
		-- Initialize the disposition and Last Talk Time
		--	localDispo = 302400
		--	localChongLastTalkTime = os.time()

		--Chong likes wizards, you get bonus dispo if you are one when you first talk to him.
		--if playerBaseClass == 3 then
		--	player:dialogSeq({t, name.."You know some stuff, don't you man...I can feel it, you are in tune..."}, 1)
		--	localDispo = localDispo + 20000
		--	player:sendMinitext("Disposition Increased: +7,000")
		--end

		--Set your response choices.
		--Mayeb give some different choices based on the players current Karma...
		table.insert(optsChongFirst, "" .. player.name) -- player name (Choice 1)
		table.insert(optsChongFirst, "Why would I tell you?") -- neutral responses
		table.insert(optsChongFirst, "F**k off") -- hateful work

		--NPC Description
		nameResponseMenuOption =
			player:menuString("Hey there man, I don't think we have met before.  What is your name??", optsChongFirst)

		--Responses to your initial encounter.
		if nameResponseMenuOption == "" .. player.name then
			--localDispo = localDispo + 100000
			--if player.gmLevel > 0 then
			--	player:sendMinitext("Disposition Increased: +100,000")
			--end
			player:dialogSeq(
				{
					t,
					name ..
						"Ahh, well I will try and remember that.  Stop on by from time to time and say hello!\n\nWhat can I get for you today?"
				},
				1
			)
		elseif nameResponseMenuOption == "Why would I tell you?" then
			--localDispo = localDispo
			--if player.gmLevel > 0 then
			--	player:sendMinitext("Disposition Increased: +0")
			--end
			player:dialogSeq({t, name .. "Wow man, chill out..."}, 1)
		elseif nameResponseMenuOption == "F**k off" then
			player:dialogSeq({t, name .. "Dude, that is uncalled for man...you need to leave."}, 1)
		--localDispo = localDispo - 275000
		--if player.gmLevel > 0 then
		--	player:sendMinitext("Disposition Decreased: -275,000")
		--end
		end

		player.registry["chong_first_encounter"] = 1
		--player.registry["last_talk_time_296"] = os.time()
		--player.registry["disposition_296"] = localDispo
		--player.registry["last_disp_inc_time_296"] = os.time()
		--end

		return
	end,
	mainMenu = function(player, npc, chongLastTalkTime, chongDispo)
		---------------------------------
		--Local Variable Initialization--
		---------------------------------
		--local localDispo =  chongDispo
		--local localChongLastTalkTime = chongLastTalkTime

		local name = "<b>[" .. npc.name .. "]\n\n" -- Set name = "Herbalist Chong"
		local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor} -- Set the grapic for the window
		local flowerImage
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		player.lastClick = npc.ID

		local playerGender = player.sex
		local playerBaseClass = player.baseClass
		local ability = "herbalism"

		local optsChongFirst = {}
		local optsMainMenu = {}
		local mainMenuGreeting

		table.insert(optsMainMenu, "Shop")
		--	table.insert(optsMainMenu, "Storage")--Only some NPCs have this.
		table.insert(optsMainMenu, "Talk")
		table.insert(optsMainMenu, "Repair") --Only some NPCs have this.
		table.insert(optsMainMenu, "Leave")

		if player.gmLevel > 0 then
			table.insert(optsMainMenu, "Secret Shop")
			--table.insert(optsMainMenu, "Reset Disposition")
			table.insert(optsMainMenu, "Reset Herbalism")
			table.insert(optsMainMenu, "Unlearn Skill")
		end
		 --

		--[[ setup greeting based off of disposition.  This is shown in the menu dialog.
529200 -- 604800            max value /super likes ya
378000 -- 529199            likes you
226800 -  302400 - 377999   Alright with ya
075600 -- 226799            Does not want you around, but does not remove you.
000000 -- 075599            Lowest you can go, keeps won't talk to you.
]] mainMenuGreeting =
			"How have you been!!!  What can I do for you today?"
		 --
		--[[ADD BACK AFTER DISPOSITION IS FIXED
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
				player:popUp(mainMenuGreeting.."                      Current Disposition with Chong: "..localDispo)
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
				3535,
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
				--player.registry["disposition_296"] = localDispo
				--player.registry["last_talk_time_296"] = os.time()
				--herbalist_chong.mainMenu(player,npc, localChongLastTalkTime, localDispo)
				player:buyExtend(name .. "What can I sell you today?", secretBuyitems)
			elseif shopMenuOption == "Sell" then
				--player.registry["disposition_296"] = localDispo
				--player.registry["last_talk_time_296"] = os.time()
				--herbalist_chong.mainMenu(player,npc, localChongLastTalkTime, localDispo)
				player:sellExtend(name .. "What do you wish to sell?", secretSellItems)
			elseif shopMenuOption == "Back" then
			--player.registry["disposition_296"] = localDispo
			--player.registry["last_talk_time_296"] = os.time()
			--herbalist_chong.mainMenu(player,npc, localChongLastTalkTime, localDispo)
			end
		elseif mainMenuOption == "Shop" then
			--	elseif mainMenuOption == "Storage" then
			--		inn_keeper2.f1click(player, npc)
			-------------------------------------
			-- Talk Options ---------------------
			-------------------------------------
			local optsShopMenu = {}
			local buyitems = {407, 3531, 3532, 3130, 3200, 3201}

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
				3531,
				3532,
				3533,
				3534,
				3300,
				3301,
				3302,
				3310,
				3311
			} -- Herb Cutters can be sold back

			local secretSellItems = {3533, 3534, 3633, 3634}

			table.insert(optsShopMenu, "Buy")
			table.insert(optsShopMenu, "Sell")
			table.insert(optsShopMenu, "Back")

			shopMenuOption = player:menuString(name .. " " .. mainMenuGreeting, optsShopMenu)

			if shopMenuOption == "Buy" then
				--player.registry["disposition_296"] = localDispo
				--player.registry["last_talk_time_296"] = os.time()
				--herbalist_chong.mainMenu(player,npc, localChongLastTalkTime, localDispo)
				player:buyExtend(name .. "What can I sell you today?", buyitems)
			elseif shopMenuOption == "Sell" then
				--player.registry["disposition_296"] = localDispo
				--player.registry["last_talk_time_296"] = os.time()
				--herbalist_chong.mainMenu(player,npc, localChongLastTalkTime, localDispo)
				player:sellExtend(name .. "What do you wish to sell?", sellitems)
			elseif shopMenuOption == "Back" then
			--player.registry["disposition_296"] = localDispo
			--player.registry["last_talk_time_296"] = os.time()
			--herbalist_chong.mainMenu(player,npc, localChongLastTalkTime, localDispo)
			end
		elseif mainMenuOption == "Talk" then
			--elseif mainMenuOption == "Reset Disposition" then
			--	player.registry["last_talk_time_296"] = 0
			--    player.registry["disposition_296"] = 0
			--	player.registry["last_disp_inc_time_296"] = 0
			--
			--	npc:talk(2, "Reset done for "..player.name)
			local optsTalkMenu = {}
			--local lastTalkTime = player.registry["last_talk_time_296"]
			--local lastDispInc = player.registry["last_disp_inc_time_296"]
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
			Maybe have a randomization here with fun little trivia about other NPCs!
			]]
				--if timeSinceLastDispInc > 86400 then
				--	localDispo = localDispo + 15000
				--	if player.gmLevel > 0 then
				--		player:sendMinitext("Disposition Increased: 15,000")
				--	end
				--	player.registry["last_disp_inc_time_296"] = os.time()
				--
				--else
				--	if player.gmLevel > 0 then
				--		player:sendMinitext("No Change, Come back after 24 Hours")
				--		player:sendMinitext("Time Since Last Disp Inc (SEC): "..timeSinceLastDispInc)
				--		player:sendMinitext("Time Since Last Disp Inc (HOURS): "..round((timeSinceLastDispInc / 3600),2))
				--	end
				--end
				--player.registry["disposition_296"] = localDispo
				--player.registry["last_talk_time_296"] = os.time()
				--herbalist_chong.mainMenu(player,npc, localChongLastTalkTime, localDispo)
				player:dialogSeq(
					{t, name .. "Oh, I don't have much to say right now.  I am new to the land and have yet to get used to things..."},
					1
				)
				 --
				--[[
			A place holder for right not
			Need to determine what information to give out this way.  What conditions and criteria to set in place for what is said.
			Maybe have a randomization here with fun little trivia about other NPCs!
			]] -- Disposition Update / Check --
				--chongDispo = setDisposition(player, npcID, 2, 15000)
				--
				--player.registry["disposition_296"] = localDispo
				--player.registry["last_talk_time_296"] = os.time()
				--herbalist_chong.mainMenu(player,npc, localChongLastTalkTime, localDispo)

				---------------------------
				-- Gossip -----------------
				---------------------------
				--elseif talkMenuOption == "Gossip!" then
				player:dialogSeq(
					{
						t,
						name .. "Man, I know that the better you get at picking herbs, the more of them you can get from a single plant."
					},
					1
				)
			 --
			elseif talkMenuOption == "Skills" then
				local optsSkillMenu = {}

				player:dialogSeq({t, name .. "I do know some things about herbalism, what would you like to know about?"}, 1)

				table.insert(optsSkillMenu, "About Herbalism")
				if player.registry["learned_herbalism"] == 0 then
					table.insert(optsSkillMenu, "Learn Herbalism")
				end
				table.insert(optsSkillMenu, "Back")

				skillMenuOption = player:menuString(name .. " " .. mainMenuGreeting, optsSkillMenu)

				if skillMenuOption == "Back" then
					herbalist_chong.mainMenu(player, npc, localChongLastTalkTime, localDispo)
				elseif skillMenuOption == "About Herbalism" then
					local optsAboutMenu = {}

					table.insert(optsAboutMenu, "About Plants")
					table.insert(optsAboutMenu, "About Herbalism")
					table.insert(optsAboutMenu, "About the Tools")
					table.insert(optsAboutMenu, "End Conversation")

					aboutMenuOption = player:menuString(name .. " " .. mainMenuGreeting, optsAboutMenu)

					if aboutMenuOption == "About Plants" then
						local optsAboutPlantsMenu = {}
						table.insert(optsAboutPlantsMenu, "General Information")

						if player.registry["herbalism_level"] > 0 then
							table.insert(optsAboutPlantsMenu, "Sanguine Flower")
							table.insert(optsAboutPlantsMenu, "Cobalt Flower")
						end
						if player.registry["herbalism_level"] > 1 then
						end
						if player.registry["herbalism_level"] > 2 then
							table.insert(optsAboutPlantsMenu, "Brown Mushroom")
						end
						if player.registry["herbalism_level"] > 3 then
						end
						if player.registry["herbalism_level"] > 4 then
							table.insert(optsAboutPlantsMenu, "Violet Flower")
						end
						if player.registry["herbalism_level"] > 5 then
							table.insert(optsAboutPlantsMenu, "Enhancing Leaves")
						end
						if player.registry["herbalism_level"] > 6 then
							table.insert(optsAboutPlantsMenu, "Sophoric Flower")
						end
						if player.registry["herbalism_level"] > 7 then
							table.insert(optsAboutPlantsMenu, "Draining Flower")
						end
						if player.registry["herbalism_level"] > 8 then
							table.insert(optsAboutPlantsMenu, "Stupifying Flower")
						end
						if player.registry["herbalism_level"] > 9 then
						end
						if player.registry["herbalism_level"] > 10 then
							table.insert(optsAboutPlantsMenu, "Empowering Flower")
						end
						if player.registry["herbalism_level"] > 11 then
							table.insert(optsAboutPlantsMenu, "Brutish Flower")
						end
						if player.registry["herbalism_level"] > 12 then
							table.insert(optsAboutPlantsMenu, "Dancing Flower")
						end
						if player.registry["herbalism_level"] > 13 then
						end
						if player.registry["herbalism_level"] > 14 then
						end
						if player.registry["herbalism_level"] > 15 then
						end

						if player.gmLevel > 0 then
							table.insert(optsAboutPlantsMenu, "General Information")
							table.insert(optsAboutPlantsMenu, "Sanguine Flower")
							table.insert(optsAboutPlantsMenu, "Cobalt Flower")
							table.insert(optsAboutPlantsMenu, "Brown Mushroom")
							table.insert(optsAboutPlantsMenu, "Violet Flower")
							table.insert(optsAboutPlantsMenu, "Enhancing Leaves")
							table.insert(optsAboutPlantsMenu, "Sophoric Flower")
							table.insert(optsAboutPlantsMenu, "Draining Flower")
							table.insert(optsAboutPlantsMenu, "Stupifying Flower")
							table.insert(optsAboutPlantsMenu, "Empowering Flower")
							table.insert(optsAboutPlantsMenu, "Brutish Flower")
							table.insert(optsAboutPlantsMenu, "Dancing Flower")
						end

						table.insert(optsAboutPlantsMenu, "Leave")

						aboutPlantsMenuOption = player:menuString(name .. " " .. mainMenuGreeting, optsAboutPlantsMenu)
						name = "<b>" .. aboutPlantsMenuOption .. "\n\n"

						if aboutPlantsMenuOption == "General Information" then
							--if timeSinceLastDispInc > 86400 then
							--	localDispo = localDispo + 15000
							--	if player.gmLevel > 0 then
							--		player:sendMinitext("Disposition Increased: 15,000")
							--	end
							--	player.registry["last_disp_inc_time_296"] = os.time()
							--
							--else
							--	if player.gmLevel > 0 then
							--		player:sendMinitext("No Change, Come back after 24 Hours")
							--		player:sendMinitext("Time Since Last Disp Inc (SEC): "..timeSinceLastDispInc)
							--		player:sendMinitext("Time Since Last Disp Inc (HOURS): "..round((timeSinceLastDispInc / 3600),2))
							--	end
							--end
							--player.registry["disposition_296"] = localDispo
							--player.registry["last_talk_time_296"] = os.time()
							--herbalist_chong.mainMenu(player,npc, localChongLastTalkTime, localDispo)
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
						elseif aboutPlantsMenuOption == "Sanguine Flower" then
							--if timeSinceLastDispInc > 86400 then
							--	localDispo = localDispo + 5000
							--	player:sendMinitext("Disposition Increased: 5000")
							--	player.registry["last_disp_inc_time_296"] = os.time()
							--else
							--	player:sendMinitext("No Change, Come back after 24 Hours")
							--	player:sendMinitext("Time Since Last Disp Inc (SEC): "..timeSinceLastDispInc)
							--	player:sendMinitext("Time Since Last Disp Inc (HOURS): "..round((timeSinceLastDispInc / 3600),2))
							--end
							--player.registry["disposition_296"] = localDispo
							--player.registry["last_talk_time_296"] = os.time()
							--herbalist_chong.mainMenu(player,npc, localChongLastTalkTime, localDispo)
							flowerImage = {graphic = convertGraphic(825, "monster"), color = 0}
							player:dialogSeq(
								{
									flowerImage,
									name .. "Ahh, the Sanguine Flower...Rotono Asiaticum.  These flowers have healing properties.",
									name ..
										"They are very common, they can be found all over the place!  They grow pretty fast too.  All around they are easy to pick.",
									name ..
										"When you pulverize these flowers and mix them with some kind of base, you will have a potion which can instantly recover your vitality during battle!"
								},
								1
							)
						elseif aboutPlantsMenuOption == "Cobalt Flower" then
							--if timeSinceLastDispInc > 86400 then
							--	localDispo = localDispo + 5000
							--	player:sendMinitext("Disposition Increased: 5000")
							--	player:sendMinitext("New Disp: "..localDispo)
							--	player.registry["last_disp_inc_time_296"] = os.time()
							--else
							--	player:sendMinitext("No Change, Come back after 24 Hours")
							--	player:sendMinitext("Time Since Last Disp Inc (SEC): "..timeSinceLastDispInc)
							--	player:sendMinitext("Time Since Last Disp Inc (HOURS): "..round((timeSinceLastDispInc / 3600),2))
							--end
							--player.registry["disposition_296"] = localDispo
							--player.registry["last_talk_time_296"] = os.time()
							--herbalist_chong.mainMenu(player,npc, localChongLastTalkTime, localDispo)
							flowerImage = {graphic = convertGraphic(825, "monster"), color = 6}
							player:dialogSeq(
								{
									flowerImage,
									name .. "Oh, the Cobalt Flower...Azulian Asiaticum.  These flowers have energizing properties.",
									name ..
										"They are very common, they can be found all over the place!  They grow fast.  Overall they are easy to pick.",
									name ..
										"When you pulverize these flowers and mix them with some kind of base, you will have a potion which can instantly recover your mana essence during battle!"
								},
								1
							)
						elseif optsAboutPlantsMenu == "Brown Mushroom" then
							--if timeSinceLastDispInc < 86400 then
							--	localDispo = localDispo + 5000
							--	player:sendMinitext("Disposition Increased: 5000")
							--	player.registry["last_disp_inc_time_296"] = os.time()
							--else
							--	player:sendMinitext("No Change, Come back after 24 Hours")
							--end
							--player.registry["disposition_296"] = localDispo
							--player.registry["last_talk_time_296"] = os.time()
							--herbalist_chong.mainMenu(player,npc, localChongLastTalkTime, localDispo)
							flowerImage = {graphic = convertGraphic(817, "monster"), color = 0}
							player:dialogSeq(
								{
									flowerImage,
									name ..
										"The mushrooms, Maronisca Agaricus.  Mixing these in with other componets of a potion will increase the potions effectiveness.",
									name ..
										"They are common, they can be found in caverns all over!  They moderatly fast.  Overall they are easy to pick.!"
								},
								1
							)
						elseif aboutPlantsMenuOption == "Violet Flower" then
							--if timeSinceLastDispInc < 86400 then
							--	localDispo = localDispo + 5000
							--	player:sendMinitext("Disposition Increased: 5000")
							--	player.registry["last_disp_inc_time_296"] = os.time()
							--else
							--	player:sendMinitext("No Change, Come back after 24 Hours")
							--end
							--player.registry["disposition_296"] = localDispo
							--player.registry["last_talk_time_296"] = os.time()
							--herbalist_chong.mainMenu(player,npc, localChongLastTalkTime, localDispo)
							flowerImage = {graphic = convertGraphic(815, "monster"), color = 0}
							player:dialogSeq(
								{
									flowerImage,
									name ..
										"The Violet Flower...Royal Asiaticum.  This flower will drop the physical defenses of your target.  You will need to splash them!",
									name ..
										"They are common, they can be found in areas all over!  They grow at a fair rate.  Overall these may be tricky to gather due to their delicate nature."
								},
								1
							)
						elseif aboutPlantsMenuOption == "Enhancing Leaves" then
							--if timeSinceLastDispInc < 86400 then
							--	localDispo = localDispo + 5000
							--	player:sendMinitext("Disposition Increased: 5000")
							--	player.registry["last_disp_inc_time_296"] = os.time()
							--else
							--	player:sendMinitext("No Change, Come back after 24 Hours")
							--end
							--player.registry["disposition_296"] = localDispo
							--player.registry["last_talk_time_296"] = os.time()
							--herbalist_chong.mainMenu(player,npc, localChongLastTalkTime, localDispo)
							flowerImage = {graphic = convertGraphic(822, "monster"), color = 0}
							player:dialogSeq(
								{
									flowerImage,
									name ..
										"Ahh, enhancing leaves.  These are used to stabalize the active agents in the larger potions.  This is required for more advanced potion making.",
									name ..
										"They are uncommon, they can be found in some more remote areas.  They grow at a fair rate.  Overall these may be tricky to gather due to their delicate nature."
								},
								1
							)
						elseif aboutPlantsMenuOption == "Sophoric Flower" then
							--if timeSinceLastDispInc < 86400 then
							--	localDispo = localDispo + 5000
							--	player:sendMinitext("Disposition Increased: 5000")
							--	player.registry["last_disp_inc_time_296"] = os.time()
							--else
							--	player:sendMinitext("No Change, Come back after 24 Hours")
							--end
							--player.registry["disposition_296"] = localDispo
							--player.registry["last_talk_time_296"] = os.time()
							--herbalist_chong.mainMenu(player,npc, localChongLastTalkTime, localDispo)
							flowerImage = {graphic = convertGraphic(771, "monster"), color = 0}
							player:dialogSeq(
								{
									flowerImage,
									name ..
										"Oh?  Sophoric Flowers!  The Arescet Asiaticum.  These seem to make the user slow down, the are not as nimble after exposure to a potion made from this flower.",
									name ..
										"They are uncommon, they can be found in some more remote areas.  They grow at a fair rate.  Overall these may be tricky to gather due to their delicate nature."
								},
								1
							)
						elseif aboutPlantsMenuOption == "Draining Flower" then
							--if timeSinceLastDispInc < 86400 then
							--	localDispo = localDispo + 5000
							--	player:sendMinitext("Disposition Increased: 5000")
							--	player.registry["last_disp_inc_time_296"] = os.time()
							--else
							--	player:sendMinitext("No Change, Come back after 24 Hours")
							--end
							--player.registry["disposition_296"] = localDispo
							--player.registry["last_talk_time_296"] = os.time()
							--herbalist_chong.mainMenu(player,npc, localChongLastTalkTime, localDispo)
							flowerImage = {graphic = convertGraphic(768, "monster"), color = 0}
							player:dialogSeq(
								{
									flowerImage,
									name ..
										"Draining flowers.  Exhaurire Asiaticum.  Skill is needed when working with these flowers as they will slowly sap your strength!  This can be used to you advantage though by grinding this down into something you can splash on an opponent",
									name ..
										"They are uncommon, they can be found in some more remote areas.  They grow at a fair rate.  Overall these may be tricky to gather due to their delicate nature."
								},
								1
							)
						elseif aboutPlantsMenuOption == "Stupifying Flower" then
							--if timeSinceLastDispInc < 86400 then
							--	localDispo = localDispo + 5000
							--	player:sendMinitext("Disposition Increased: 5000")
							--	player.registry["last_disp_inc_time_296"] = os.time()
							--else
							--	player:sendMinitext("No Change, Come back after 24 Hours")
							--end
							--player.registry["disposition_296"] = localDispo
							--player.registry["last_talk_time_296"] = os.time()
							--herbalist_chong.mainMenu(player,npc, localChongLastTalkTime, localDispo)
							flowerImage = {graphic = convertGraphic(815, "monster"), color = 0}
							player:dialogSeq(
								{
									flowerImage,
									name ..
										"Eww....the Stultus Asiaticum.  These seem to make the user stupiuder to put is simply.  Great skill is needed when handling these!",
									name ..
										"They are very uncommon, they can only be found in remote areas.  They grow at a slow rate.  Overall these are tricky to gather due to their delicate nature."
								},
								1
							)
						elseif aboutPlantsMenuOption == "Empowering Flower" then
							--if timeSinceLastDispInc < 86400 then
							--	localDispo = localDispo + 5000
							--	player:sendMinitext("Disposition Increased: 5000")
							--	player.registry["last_disp_inc_time_296"] = os.time()
							--else
							--	player:sendMinitext("No Change, Come back after 24 Hours")
							--end
							--player.registry["disposition_296"] = localDispo
							--player.registry["last_talk_time_296"] = os.time()
							--herbalist_chong.mainMenu(player,npc, localChongLastTalkTime, localDispo)
							flowerImage = {graphic = convertGraphic(769, "monster"), color = 0}
							player:dialogSeq(
								{
									flowerImage,
									name ..
										"Oh! The Intelligens Asiaticum.  The opposite of the Stultus Asiaticum, these actually seem to enhance intelligence making magics more powerful.  They are hard to gather though, due to their delicate nature.",
									name ..
										"They are rare, they can only be found in remote areas.  They grow at a slow rate.  Overall these are tricky to gather due to their delicate nature."
								},
								1
							)
						elseif aboutPlantsMenuOption == "Brutish Flower" then
							--if timeSinceLastDispInc < 86400 then
							--	localDispo = localDispo + 5000
							--	player:sendMinitext("Disposition Increased: 5000")
							--	player.registry["last_disp_inc_time_296"] = os.time()
							--else
							--	player:sendMinitext("No Change, Come back after 24 Hours")
							--end
							--player.registry["disposition_296"] = localDispo
							--player.registry["last_talk_time_296"] = os.time()
							--herbalist_chong.mainMenu(player,npc, localChongLastTalkTime, localDispo)
							--
							flowerImage = {graphic = convertGraphic(772, "monster"), color = 0}
							player:dialogSeq(
								{
									flowerImage,
									name ..
										"The Potentia Asiaticum.  The opposite of the Exhaurire Asiaticum, these bolster strength.  They are hard to gather though, due to their delicate nature.",
									name ..
										"They are very rare, they can only be found in remote areas.  They grow at a very slow rate.  Overall these are very tricky to gather due to their delicate nature."
								},
								1
							)
						elseif aboutPlantsMenuOption == "Dancing Flower" then
							--if timeSinceLastDispInc < 86400 then
							--	localDispo = localDispo + 5000
							--	player:sendMinitext("Disposition Increased: 5000")
							--	player.registry["last_disp_inc_time_296"] = os.time()
							--else
							--	player:sendMinitext("No Change, Come back after 24 Hours")
							--end
							--player.registry["disposition_296"] = localDispo
							--player.registry["last_talk_time_296"] = os.time()
							--herbalist_chong.mainMenu(player,npc, localChongLastTalkTime, localDispo)
							flowerImage = {graphic = convertGraphic(770, "monster"), color = 0}
							player:dialogSeq(
								{
									flowerImage,
									name ..
										"Agilis Asiaticum.  The opposite of the Arescet Asiaticum, these increase your gracefulness.  They are very hard to gather though, due to their delicate nature.",
									name ..
										"They are extremely rare, they can only be found in remote areas.  They grow at a very slow rate.  Overall these are extremely tricky to gather due to their very delicate nature."
								},
								1
							)
						elseif aboutPlantsMenuOption == "Back" then
							player:dialogSeq({flowerImage, name .. "Alrighty, I will talk to you later then!"}, 1)
						--player.registry["disposition_296"] = localDispo
						--player.registry["last_talk_time_296"] = os.time()
						--herbalist_chong.mainMenu(player,npc, localChongLastTalkTime, localDispo)
						end
					elseif aboutMenuOption == "About Herbalism" then
						--if timeSinceLastDispInc < 86400 then
						--	localDispo = localDispo + 5000
						--	player:sendMinitext("Disposition Increased: 5000")
						--	player.registry["last_disp_inc_time_296"] = os.time()
						--else
						--	player:sendMinitext("No Change, Come back after 24 Hours")
						--end
						--player.registry["disposition_296"] = localDispo
						--player.registry["last_talk_time_296"] = os.time()
						--herbalist_chong.mainMenu(player,npc, localChongLastTalkTime, localDispo)
						player:dialogSeq(
							{
								t,
								name ..
									"Herbalism  (also herbology or herbal medicine) is the use of plants for medicinal purposes, and the study of botany for such use. Plants have been the basis for medical treatments through much of human history, and such traditional medicine is still widely practiced today.",
								name ..
									"There are many forms in which herbs can be administered, the most common of which is in the form of a liquid that is drunk by the patient—either an herbal tea or a (possibly diluted) plant extract.",
								name ..
									"Herbal teas, or tisanes, are the resultant liquid of extracting herbs into water, though they are made in a few different ways. Infusions are hot water extracts of herbs, such as chamomile or mint, through steeping. ",
								name ..
									"Decoctions are the long-term boiled extracts, usually of harder substances like roots or bark. Maceration is the old infusion of plants with high mucilage-content, such as sage, thyme, etc. To make macerates, plants are chopped and added to cold water. They are then left to stand for 7 to 12 hours (depending on herb used). For most macerates 10 hours is used.",
								name ..
									"Tinctures are alcoholic extracts of herbs, which are generally stronger than herbal teas. Tinctures are usually obtained by combining 100% pure ethanol (or a mixture of 100% ethanol with water) with the herb. A completed tincture has an ethanol percentage of at least 25% (sometimes up to 90%).",
								name ..
									"Herbal wine and elixirs are alcoholic extract of herbs, usually with an ethanol percentage of 12-38%.  Herbal wine is a maceration of herbs in wine, while an elixir is a maceration of herbs in spirits (e.g., vodka, grappa, etc.).",
								name ..
									"Extracts include liquid extracts, dry extracts, and nebulisates. Liquid extracts are liquids with a lower ethanol percentage than tinctures. They are usually made by vacuum distilling tinctures. Dry extracts are extracts of plant material that are evaporated into a dry mass. They can then be further refined to a capsule or tablet."
							},
							1
						)
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
								name ..
									"The tool used for cutting herbs is the Herb Cutter.  There are four quality levels you can find these in.  Basic and Quality are what I have.  Basic is just that.  It gets the job done, but needs replaced quickly.",
								name .. "A Quality Herb Cutter does no better in helping cut additional flowers, but it is more durable.",
								name ..
									"A Superior Herb Cutter will help in gathering additional flowers than normal and it is even more durable.",
								name ..
									"An Artisan Herb Cutter will help in gathering additional flowers than normal and it is even more durabilty than the Superior Herb Cutter."
							},
							1
						)

					--if timeSinceLastDispInc < 86400 then
					--	localDispo = localDispo + 5000
					--	player:sendMinitext("Disposition Increased: 5000")
					--	player.registry["last_disp_inc_time_296"] = os.time()
					--else
					--	player:sendMinitext("No Change, Come back after 24 Hours")
					--end
					--
					--player.registry["disposition_296"] = localDispo
					--player.registry["last_talk_time_296"] = os.time()
					--herbalist_chong.mainMenu(player,npc, localChongLastTalkTime, localDispo)
					end
				elseif skillMenuOption == "Unlearn Skill" then
					local optsForgetHerbalism = {}

					table.insert(optsForgetHerbalism, "Yes, I want to forget.")
					table.insert(optsForgetHerbalism, "No, I have reconsidered.")

					forgetSkillMenuOption =
						player:menuString(name .. "Are you ready to forget the Herbalism Skill?", optsForgetHerbalism)

					if forgetSkillMenuOption == "Yes, I want to forget." then
						--localDispo = localDispo - 15000
						--player.registry["disposition_296"] = localDispo
						--player.registry["last_talk_time_296"] = os.time()
						--herbalist_chong.mainMenu(player,npc, localChongLastTalkTime, localDispo)
						player.registry["learned_herbalism"] = 0
						player.registry["herbalism_level"] = 0
						player.registry["herbalism_tnl"] = 0

						npc:talk(2, "You have forgotten the Herbalism skill.")
					elseif forgetSkillMenuOption == "No, I have reconsidered." then

					--player.registry["disposition_296"] = localDispo
					--player.registry["last_talk_time_296"] = os.time()
					--herbalist_chong.mainMenu(player,npc, localChongLastTalkTime, localDispo)
					end
				elseif skillMenuOption == "Learn Herbalism" then
					local optsLearnHerbalism = {}

					table.insert(optsLearnHerbalism, "Yes, I am ready to learn.")
					table.insert(optsLearnHerbalism, "No, I have reconsidered.")

					player:dialogSeq(
						{
							t,
							name .. "Herbalism is the skill by which we learn about plants and how to pick them for use in making potions.",
							name .. "There are many plants which can be plucked from the ground and then pulverised.",
							name ..
								"Once pulverised, the newly created paste or powder will need to have other items added and be placed into a container to be used as a drinkable (or throwable) potion.",
							name .. "You can learn and become a master of any number of base gathering skills."
						},
						1
					)

					learnSkillMenuOption = player:menuString(name .. "Are you ready to learn the Herbalism Skill?", optsLearnHerbalism)

					if learnSkillMenuOption == "Yes, I am ready to learn." then
						--player.registry["disposition_296"] = localDispo + 70000
						--player:sendMinitext("Disposition Increased: 10,000")
						--player.registry["last_disp_inc_time_296"] = os.time()
						--player.registry["last_talk_time_296"] = os.time()
						--herbalist_chong.mainMenu(player,npc, localChongLastTalkTime, localDispo)
						player:dialogSeq({"Congradulations, you have learned about Herbalism!"}, 1)

						if player:hasLegend("beginner_herbalism") then
							player:removeLegendbyName("beginner_herbalism")
						end

						player:addLegend("Beginner Herbalist", "beginner_herbalism", 125, 108)
						player:msg(4, "=== New Legend Added! ===", player.ID)
						player.registry["learned_herbalism"] = 1
						player.registry["herbalism_level"] = 1
						player.registry["herbalism_tnl"] = 1000

						player:sendMinitext("You've learned Herbalism!")
					elseif learnSkillMenuOption == "No, I have reconsidered." then
						--player.registry["disposition_296"] = localDispo
						--player.registry["last_talk_time_296"] = os.time()
						player:dialogSeq({"Oh, alright, well please come back when you are ready to learn!"}, 1)
					end
				end
			elseif talkMenuOption == "Part-Time Job" then
				player:dialogSeq({t, name .. "I am still getting the shop setup, I am not ready to take on hired help yet."}, 1)

			--if timeSinceLastDispInc < 86400 then
			--	localDispo = localDispo + 5000
			--	player:sendMinitext("Disposition Increased: 5000")
			--	player.registry["last_disp_inc_time_296"] = os.time()
			--else
			--	player:sendMinitext("No Change, Come back after 24 Hours")
			--end
			--player.registry["disposition_296"] = localDispo
			--player.registry["last_talk_time_296"] = os.time()
			--herbalist_chong.mainMenu(player,npc, localChongLastTalkTime, localDispo)
			end
		elseif mainMenuOption == "Reset Herbalism" then
			player.registry["learned_herbalism"] = 0
			player.registry["herbalism_level"] = 0
			player.registry["herbalism_tnl"] = 0

			npc:talk(2, "Reset done for " .. player.name)
		elseif mainMenuOption == "Leave" then
			--player.registry["disposition_296"] = localDispo
			--player.registry["last_talk_time_296"] = os.time()
			player:dialogSeq({t, name .. "Come back again!"}, 1)
		end

		return
	end
	--[[
say = function(player, npc)

	if string.lower(player.speech) == "reset" then
        player.registry["last_talk_time_296"] = 0
        player.registry["disposition_296""] = 0

		--player.registry["learned_mining"] = 0
		--player.registry["mining_level"] = 0
		--player.registry["mining_tnl"] = 0
		npc:talk(2, "Reset done for "..player.name)
		--player:removeLegendbyName("beginner_ore_mining")
	end
end,
--]]
}
