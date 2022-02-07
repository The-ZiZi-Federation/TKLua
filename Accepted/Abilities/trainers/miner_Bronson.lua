miner_bronson = {
	click = async(
		function(player, npc)
			---------------------------------
			--Local Variable Initialization--
			---------------------------------
			local name
			local t

			local bronsonLastTalkTime
			local bronsonDispo
			local localDispo
			local npcID = npc.id
			---------------------------------
			--Set Variables -----------------
			---------------------------------
			name = "<b>[" .. npc.name .. "]\n\n" -- Set name = "Miner Bronson"
			t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor} -- Set the grapic for the window

			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			--bronsonLastTalkTime = player.registry["last_talk_time_102"]
			--bronsonDispo = player.registry["disposition_102"]

			--------------------------------
			--Main executioon---------------
			--------------------------------
			--NPC Description
			player:dialogSeq({t, name .. "A large, burly man stands before you, leaning over on his pickaxe..."}, 1)
			if player.registry["bronson_first_encounter"] == 0 then
				miner_bronson.firstEncounter(player, npc, bronsonLastTalkTime, bronsonDispo)
			else
				--player.registry["disposition_102"] = bronsonDispo
				--bronsonLastTalkTime = player.registry["last_talk_time_102"]
				--bronsonDispo = player.registry["disposition_102"]
				--
				--bronsonDispo = setDisposition(player, npcID, 0, 0)
				--player.registry["disposition_102"] = bronsonDispo

				miner_bronson.mainMenu(player, npc, bronsonLastTalkTime, bronsonDispo)
			end
		end
	),
	firstEncounter = function(player, npc, bronsonLastTalkTime, bronsonDispo)
		---------------------------------
		--Local Variable Initialization--
		---------------------------------
		--local localDispo =  bronsonDispo
		--local localBronsonLastTalkTime = bronsonLastTalkTime
		local name = "<b>[" .. npc.name .. "]\n\n" -- Set name = "Miner Bronson"
		local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor} -- Set the grapic for the window

		local playerGender = player.sex
		local playerBaseClass = player.baseClass
		local ability = "mining"

		local optsBronsonFirst = {}
		local nameResponseMenuOption
		local npcID = npc.ID

		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		player.lastClick = npc.ID

		-- If this is the first time we have talked with Bronson:
		--if localBronsonLastTalkTime == 0 then
		-- Initialize the disposition and Last Talk Time
		--	localDispo = 302400
		--	localBronsonLastTalkTime = os.time()

		--Bronson likes wizards, you get bonus dispo if you are one when you first talk to him.
		--if playerBaseClass == 3 then
		--	player:dialogSeq({t, name.."You know some stuff, don't you man...I can feel it, you are in tune..."}, 1)
		--	localDispo = localDispo + 20000
		--	player:sendMinitext("Disposition Increased: +7,000")
		--end

		--Set your response choices.
		--Mayeb give some different choices based on the players current Karma...
		table.insert(optsBronsonFirst, "" .. player.name) -- player name (Choice 1)
		table.insert(optsBronsonFirst, "Why would I tell you?") -- neutral responses
		table.insert(optsBronsonFirst, "F**k off") -- hateful work

		--NPC Description
		nameResponseMenuOption =
			player:menuString("Hey there man, I don't think we have met before.  What is your name??", optsBronsonFirst)

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

		player.registry["bronson_first_encounter"] = 1
		--player.registry["last_talk_time_102"] = os.time()
		--player.registry["disposition_102"] = localDispo
		--player.registry["last_disp_inc_time_102"] = os.time()
		--end

		return
	end,
	mainMenu = function(player, npc, bronsonLastTalkTime, bronsonDispo)
		---------------------------------
		--Local Variable Initialization--
		---------------------------------
		--local localDispo =  bronsonDispo
		--local localBronsonLastTalkTime = bronsonLastTalkTime

		local name = "<b>[" .. npc.name .. "]\n\n" -- Set name = "Miner Bronson"
		local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor} -- Set the grapic for the window
		local flowerImage
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		player.lastClick = npc.ID

		local playerGender = player.sex
		local playerBaseClass = player.baseClass
		local ability = "mining"

		local optsBronsonFirst = {}
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
			table.insert(optsMainMenu, "Reset Mining")
			table.insert(optsMainMenu, "Reset Forging")
			table.insert(optsMainMenu, "Reset Smithing")
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
			"How can I help you?"
		 --
		--[[
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
				player:popUp(mainMenuGreeting.."                      Current Disposition with Bronson: "..localDispo)
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
				--player.registry["disposition_102"] = localDispo
				--player.registry["last_talk_time_102"] = os.time()
				--miner_bronson.mainMenu(player,npc, localBronsonLastTalkTime, localDispo)
				player:buyExtend(name .. "What can I sell you today?", secretBuyitems)
			elseif shopMenuOption == "Sell" then
				--player.registry["disposition_102"] = localDispo
				--player.registry["last_talk_time_102"] = os.time()
				--miner_bronson.mainMenu(player,npc, localBronsonLastTalkTime, localDispo)
				player:sellExtend(name .. "What do you wish to sell?", secretSellItems)
			elseif shopMenuOption == "Back" then
			--player.registry["disposition_102"] = localDispo
			--player.registry["last_talk_time_102"] = os.time()
			--miner_bronson.mainMenu(player,npc, localBronsonLastTalkTime, localDispo)
			end
		elseif mainMenuOption == "Shop" then
			--	elseif mainMenuOption == "Storage" then
			--		inn_keeper2.f1click(player, npc)
			-------------------------------------
			-- Talk Options ---------------------
			-------------------------------------
			local optsShopMenu = {}
			local buyitems = {4031, 4032, 4081, 4082}

			local sellitems = {
				4031,
				4032,
				4033,
				4034,
				4035,
				4036,
				4038,
				4039,
				4040, -- all of picks can be sold
				4041,
				4042,
				4043,
				4044,
				4045,
				4046, -- all of picks can be sold
				4050,
				4051,
				4052,
				4053,
				4054,
				4055,
				4056,
				4057,
				4058
			} -- Some Ingots can be sold.

			local secretSellItems = {3533, 3534, 3633, 3634}

			table.insert(optsShopMenu, "Buy")
			table.insert(optsShopMenu, "Sell")
			table.insert(optsShopMenu, "Back")

			shopMenuOption = player:menuString(name .. " " .. mainMenuGreeting, optsShopMenu)

			if shopMenuOption == "Buy" then
				--player.registry["disposition_102"] = localDispo
				--player.registry["last_talk_time_102"] = os.time()
				--miner_bronson.mainMenu(player,npc, localBronsonLastTalkTime, localDispo)
				player:buyExtend(name .. "What can I sell you today?", buyitems)
			elseif shopMenuOption == "Sell" then
				--player.registry["disposition_102"] = localDispo
				--player.registry["last_talk_time_102"] = os.time()
				--miner_bronson.mainMenu(player,npc, localBronsonLastTalkTime, localDispo)
				player:sellExtend(name .. "What do you wish to sell?", sellitems)
			elseif shopMenuOption == "Back" then
			--player.registry["disposition_102"] = localDispo
			--player.registry["last_talk_time_102"] = os.time()
			--miner_bronson.mainMenu(player,npc, localBronsonLastTalkTime, localDispo)
			end
		elseif mainMenuOption == "Talk" then
			--elseif mainMenuOption == "Reset Disposition" then
			--	player.registry["last_talk_time_102"] = 0
			--  player.registry["disposition_102"] = 0
			--	player.registry["last_disp_inc_time_102"] = 0
			--	npc:talk(2, "Reset done for "..player.name)
			local optsTalkMenu = {}
			--local lastTalkTime = player.registry["last_talk_time_102"]
			--local lastDispInc = player.registry["last_disp_inc_time_102"]
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
			Need to determine what information to give out this way.  What conditions and criteria to set in place for what is said.
			Maybe have a randomization here with fun little trivia about other NPCs!
			]]
				-- Disposition Update / Check --
				--bronsonDispo = setDisposition(player, npcID, 2, 15000)
				--
				--player.registry["disposition_102"] = localDispo
				--player.registry["last_talk_time_102"] = os.time()
				--miner_bronson.mainMenu(player,npc, localBronsonLastTalkTime, localDispo)
				---------------------------
				-- Gossip -----------------
				---------------------------
				player:dialogSeq(
					{t, name .. "Oh, I don't have much to say right now.  I am new to the land and have yet to get used to things..."},
					1
				)
			 --
			elseif talkMenuOption == "Gossip!" then
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
				--	player.registry["last_disp_inc_time_102"] = os.time()
				--
				--else
				--	if player.gmLevel > 0 then
				--		player:sendMinitext("No Change, Come back after 24 Hours")
				--		player:sendMinitext("Time Since Last Disp Inc (SEC): "..timeSinceLastDispInc)
				--		player:sendMinitext("Time Since Last Disp Inc (HOURS): "..round((timeSinceLastDispInc / 3600),2))
				--	end
				--end
				--player.registry["disposition_102"] = localDispo
				--player.registry["last_talk_time_102"] = os.time()
				--miner_bronson.mainMenu(player,npc, localBronsonLastTalkTime, localDispo)
				---------------------------
				-- Skills -----------------
				---------------------------
				player:dialogSeq({t, name .. "PLACE HOLDER DIALOG"}, 1)
			 --
			elseif talkMenuOption == "Skills" then
				local optsSkillMenu = {}

				player:dialogSeq({t, name .. "What would you like to know about?"}, 1)

				table.insert(optsSkillMenu, "About Mining")
				if player.registry["learned_mining"] == 0 then
					table.insert(optsSkillMenu, "Learn Mining")
				end
				table.insert(optsSkillMenu, "About Smelting")
				if player.registry["learned_smelting"] == 0 then
					table.insert(optsSkillMenu, "Learn Smelting")
				end
				table.insert(optsSkillMenu, "About Smithing")
				if player.registry["learned_smithing"] == 0 then
					table.insert(optsSkillMenu, "Learn Smithing")
				end
				table.insert(optsSkillMenu, "Back")

				skillMenuOption = player:menuString(name .. " " .. mainMenuGreeting, optsSkillMenu)

				if skillMenuOption == "Back" then
					miner_bronson.mainMenu(player, npc, localBronsonLastTalkTime, localDispo)
				elseif skillMenuOption == "About Mining" then
					local optsAboutMenu = {}

					table.insert(optsAboutMenu, "About Ores")
					table.insert(optsAboutMenu, "About Mining")
					table.insert(optsAboutMenu, "About the Tools")
					table.insert(optsAboutMenu, "End Conversation")

					aboutMenuOption = player:menuString(name .. " " .. mainMenuGreeting, optsAboutMenu)

					if aboutMenuOption == "About Ores" then
						local optsAboutOresMenu = {}
						table.insert(optsAboutOresMenu, "General Information")

						if player.registry["mining_level"] > 0 then
							table.insert(optsAboutOresMenu, "Small Ore Node")
							table.insert(optsAboutOresMenu, "Ore Node")
						end
						if player.registry["mining_level"] > 1 then
						end
						if player.registry["mining_level"] > 2 then
							table.insert(optsAboutOresMenu, "Large Ore Node")
						end
						if player.registry["mining_level"] > 3 then
							table.insert(optsAboutOresMenu, "Orichalcum Ore Node")
						end
						if player.registry["mining_level"] > 4 then
							table.insert(optsAboutOresMenu, "Heavy Ore Node")
						end
						if player.registry["mining_level"] > 5 then
						end
						if player.registry["mining_level"] > 6 then
							table.insert(optsAboutOresMenu, "Shining Ore Node")
						end
						if player.registry["mining_level"] > 7 then
							table.insert(optsAboutOresMenu, "Superior Ore Node")
						end
						if player.registry["mining_level"] > 8 then
						end
						if player.registry["mining_level"] > 9 then
							table.insert(optsAboutOresMenu, "High Ore Node")
						end
						if player.registry["mining_level"] > 10 then
							table.insert(optsAboutOresMenu, "Rosantium Ore Node")
						end
						if player.registry["mining_level"] > 11 then
						end
						if player.registry["mining_level"] > 12 then
							table.insert(optsAboutOresMenu, "Celestial Ore Node")
						end
						if player.registry["mining_level"] > 13 then
							table.insert(optsAboutOresMenu, "Irbynite Ore node")
						end
						if player.registry["mining_level"] > 14 then
							table.insert(optsAboutOresMenu, "Hardened Celestial Ore Node")
						end
						if player.registry["mining_level"] > 15 then
						end

						if player.gmLevel > 0 then
						end

						table.insert(optsAboutOresMenu, "Leave")
						-------------------------------------------------
						-- Talk about Ores ------------------------------
						-------------------------------------------------
						aboutOresMenuOption = player:menuString(name .. " " .. mainMenuGreeting, optsAboutOresMenu)
						name = "<b>" .. aboutOresMenuOption .. "\n\n"
						-----General Info---------
						if aboutOresMenuOption == "General Information" then
							--if timeSinceLastDispInc > 86400 then
							--	localDispo = localDispo + 15000
							--	if player.gmLevel > 0 then
							--		player:sendMinitext("Disposition Increased: 15,000")
							--	end
							--	player.registry["last_disp_inc_time_102"] = os.time()
							--
							--else
							--	if player.gmLevel > 0 then
							--		player:sendMinitext("No Change, Come back after 24 Hours")
							--		player:sendMinitext("Time Since Last Disp Inc (SEC): "..timeSinceLastDispInc)
							--		player:sendMinitext("Time Since Last Disp Inc (HOURS): "..round((timeSinceLastDispInc / 3600),2))
							--	end
							--end
							--player.registry["disposition_102"] = localDispo
							--player.registry["last_talk_time_102"] = os.time()
							--miner_bronson.mainMenu(player,npc, localBronsonLastTalkTime, localDispo)
							-----Small Ore Node-----
							player:dialogSeq(
								{
									t,
									name .. "Mining is how you gather ores for use in refining Ingots and smithing armor, weapons and tools.",
									name ..
										"You will need to equip yourself with a pickaxe to be able to mine nods you find in the wild and in caverns.",
									name .. "As many gathering skills may be learned as you wish."
								},
								1
							)
						elseif aboutOresMenuOption == "Small Ore Node" then
							--if timeSinceLastDispInc > 86400 then
							--	localDispo = localDispo + 15000
							--	if player.gmLevel > 0 then
							--		player:sendMinitext("Disposition Increased: 15,000")
							--	end
							--	player.registry["last_disp_inc_time_102"] = os.time()
							--
							--else
							--	if player.gmLevel > 0 then
							--		player:sendMinitext("No Change, Come back after 24 Hours")
							--		player:sendMinitext("Time Since Last Disp Inc (SEC): "..timeSinceLastDispInc)
							--		player:sendMinitext("Time Since Last Disp Inc (HOURS): "..round((timeSinceLastDispInc / 3600),2))
							--	end
							--end
							--player.registry["disposition_102"] = localDispo
							--player.registry["last_talk_time_102"] = os.time()
							--miner_bronson.mainMenu(player,npc, localBronsonLastTalkTime, localDispo)
							-----Ore Node-----
							flowerImage = {graphic = convertGraphic(1174, "monster"), color = 0}
							player:dialogSeq(
								{
									flowerImage,
									name .. "This small ore node will yeild coal when harvested.",
									name .. "This is found in caves all over the world.",
									name .. "Coal can be used with other metals to make an alloty."
								},
								1
							)
						elseif aboutOresMenuOption == "Ore Node" then
							--if timeSinceLastDispInc > 86400 then
							--	localDispo = localDispo + 15000
							--	if player.gmLevel > 0 then
							--		player:sendMinitext("Disposition Increased: 15,000")
							--	end
							--	player.registry["last_disp_inc_time_102"] = os.time()
							--
							--else
							--	if player.gmLevel > 0 then
							--		player:sendMinitext("No Change, Come back after 24 Hours")
							--		player:sendMinitext("Time Since Last Disp Inc (SEC): "..timeSinceLastDispInc)
							--		player:sendMinitext("Time Since Last Disp Inc (HOURS): "..round((timeSinceLastDispInc / 3600),2))
							--	end
							--end
							--player.registry["disposition_102"] = localDispo
							--player.registry["last_talk_time_102"] = os.time()
							--miner_bronson.mainMenu(player,npc, localBronsonLastTalkTime, localDispo)
							-----Large Ore Node---------
							flowerImage = {graphic = convertGraphic(848, "monster"), color = 6}
							player:dialogSeq(
								{
									flowerImage,
									name .. "The common ore node.  This will yeild copper when harvested!",
									name .. "They are very common, they can be found all over the place!  "
								},
								1
							)
						elseif aboutOresMenuOption == "Large Ore Node" then
							--if timeSinceLastDispInc > 86400 then
							--	localDispo = localDispo + 15000
							--	if player.gmLevel > 0 then
							--		player:sendMinitext("Disposition Increased: 15,000")
							--	end
							--	player.registry["last_disp_inc_time_102"] = os.time()
							--
							--else
							--	if player.gmLevel > 0 then
							--		player:sendMinitext("No Change, Come back after 24 Hours")
							--		player:sendMinitext("Time Since Last Disp Inc (SEC): "..timeSinceLastDispInc)
							--		player:sendMinitext("Time Since Last Disp Inc (HOURS): "..round((timeSinceLastDispInc / 3600),2))
							--	end
							--end
							--player.registry["disposition_102"] = localDispo
							--player.registry["last_talk_time_102"] = os.time()
							--miner_bronson.mainMenu(player,npc, localBronsonLastTalkTime, localDispo)
							-----Orichalcum Ore Node------
							flowerImage = {graphic = convertGraphic(849, "monster"), color = 18}
							player:dialogSeq(
								{
									flowerImage,
									name .. "The Large Ore Nodes will yeild Tin ore when mined.",
									name .. "Tin ore can be refined into Tin Ingots which are used to make Tin Knives and Bronze Ingots!"
								},
								1
							)
						elseif aboutOresMenuOption == "Orichalcum Ore Node" then
							--if timeSinceLastDispInc > 86400 then
							--	localDispo = localDispo + 15000
							--	if player.gmLevel > 0 then
							--		player:sendMinitext("Disposition Increased: 15,000")
							--	end
							--	player.registry["last_disp_inc_time_102"] = os.time()
							--
							--else
							--	if player.gmLevel > 0 then
							--		player:sendMinitext("No Change, Come back after 24 Hours")
							--		player:sendMinitext("Time Since Last Disp Inc (SEC): "..timeSinceLastDispInc)
							--		player:sendMinitext("Time Since Last Disp Inc (HOURS): "..round((timeSinceLastDispInc / 3600),2))
							--	end
							--end
							--player.registry["disposition_102"] = localDispo
							--player.registry["last_talk_time_102"] = os.time()
							--miner_bronson.mainMenu(player,npc, localBronsonLastTalkTime, localDispo)
							-----Heavy Ore Node-----
							flowerImage = {graphic = convertGraphic(816, "monster"), color = 26}
							player:dialogSeq(
								{
									flowerImage,
									name .. "Orichalcum Ore nodes will yeild Hardened Celestial Ore when mined.",
									name .. "Orichalcum is a beautiful green metal that is very strong.  It is used mainly for armor plate."
								},
								1
							)
						elseif aboutPlantsMenuOption == "Heavy Ore Node" then
							--if timeSinceLastDispInc > 86400 then
							--	localDispo = localDispo + 15000
							--	if player.gmLevel > 0 then
							--		player:sendMinitext("Disposition Increased: 15,000")
							--	end
							--	player.registry["last_disp_inc_time_102"] = os.time()
							--
							--else
							--	if player.gmLevel > 0 then
							--		player:sendMinitext("No Change, Come back after 24 Hours")
							--		player:sendMinitext("Time Since Last Disp Inc (SEC): "..timeSinceLastDispInc)
							--		player:sendMinitext("Time Since Last Disp Inc (HOURS): "..round((timeSinceLastDispInc / 3600),2))
							--	end
							--end
							--player.registry["disposition_102"] = localDispo
							--player.registry["last_talk_time_102"] = os.time()
							--miner_bronson.mainMenu(player,npc, localBronsonLastTalkTime, localDispo)
							-----Shining Ore Node-----
							flowerImage = {graphic = convertGraphic(816, "monster"), color = 22}
							player:dialogSeq(
								{
									flowerImage,
									name .. "The Heavy Ore Node will yeild Iron Ore when it is mined.",
									name .. "Iron is used in many things including materials for armor and building homes."
								},
								1
							)
						elseif aboutPlantsMenuOption == "Shining Ore Node" then
							--if timeSinceLastDispInc > 86400 then
							--	localDispo = localDispo + 15000
							--	if player.gmLevel > 0 then
							--		player:sendMinitext("Disposition Increased: 15,000")
							--	end
							--	player.registry["last_disp_inc_time_102"] = os.time()
							--
							--else
							--	if player.gmLevel > 0 then
							--		player:sendMinitext("No Change, Come back after 24 Hours")
							--		player:sendMinitext("Time Since Last Disp Inc (SEC): "..timeSinceLastDispInc)
							--		player:sendMinitext("Time Since Last Disp Inc (HOURS): "..round((timeSinceLastDispInc / 3600),2))
							--	end
							--end
							--player.registry["disposition_102"] = localDispo
							--player.registry["last_talk_time_102"] = os.time()
							--miner_bronson.mainMenu(player,npc, localBronsonLastTalkTime, localDispo)
							-----Superior Ore Node----
							flowerImage = {graphic = convertGraphic(847, "monster"), color = 24}
							player:dialogSeq(
								{
									flowerImage,
									name .. "Shining Ore will yeild Celestial Silver ore when mined.",
									name .. "This ore is used in making armor and is a component of the Mythril Alloy."
								},
								1
							)
						elseif aboutPlantsMenuOption == "Superior Ore Node" then
							--if timeSinceLastDispInc > 86400 then
							--	localDispo = localDispo + 15000
							--	if player.gmLevel > 0 then
							--		player:sendMinitext("Disposition Increased: 15,000")
							--	end
							--	player.registry["last_disp_inc_time_102"] = os.time()
							--
							--else
							--	if player.gmLevel > 0 then
							--		player:sendMinitext("No Change, Come back after 24 Hours")
							--		player:sendMinitext("Time Since Last Disp Inc (SEC): "..timeSinceLastDispInc)
							--		player:sendMinitext("Time Since Last Disp Inc (HOURS): "..round((timeSinceLastDispInc / 3600),2))
							--	end
							--end
							--player.registry["disposition_102"] = localDispo
							--player.registry["last_talk_time_102"] = os.time()
							--miner_bronson.mainMenu(player,npc, localBronsonLastTalkTime, localDispo)
							-----High Ore Node-----
							flowerImage = {graphic = convertGraphic(851, "monster"), color = 12}
							player:dialogSeq(
								{
									flowerImage,
									name .. "These Superior Ore nodes wll yeild Mornanium Ore when mined.",
									name .. "Mornanium is of the realm itself.  This very stong metal is used for crafting fine armors."
								},
								1
							)
						elseif aboutPlantsMenuOption == "High Ore Node" then
							--if timeSinceLastDispInc > 86400 then
							--	localDispo = localDispo + 15000
							--	if player.gmLevel > 0 then
							--		player:sendMinitext("Disposition Increased: 15,000")
							--	end
							--	player.registry["last_disp_inc_time_102"] = os.time()
							--
							--else
							--	if player.gmLevel > 0 then
							--		player:sendMinitext("No Change, Come back after 24 Hours")
							--		player:sendMinitext("Time Since Last Disp Inc (SEC): "..timeSinceLastDispInc)
							--		player:sendMinitext("Time Since Last Disp Inc (HOURS): "..round((timeSinceLastDispInc / 3600),2))
							--	end
							--end
							--player.registry["disposition_102"] = localDispo
							--player.registry["last_talk_time_102"] = os.time()
							--miner_bronson.mainMenu(player,npc, localBronsonLastTalkTime, localDispo)
							-----Rosantium Ore Node-----
							flowerImage = {graphic = convertGraphic(818, "monster"), color = 1}
							player:dialogSeq(
								{
									flowerImage,
									name .. "High Ore nodes will yeild Admantium Ore when mined. ",
									name .. "Admantium is used mainly for the creation of very powerful weapons and armor."
								},
								1
							)
						elseif aboutPlantsMenuOption == "Rosantium Ore Node" then
							--if timeSinceLastDispInc > 86400 then
							--	localDispo = localDispo + 15000
							--	if player.gmLevel > 0 then
							--		player:sendMinitext("Disposition Increased: 15,000")
							--	end
							--	player.registry["last_disp_inc_time_102"] = os.time()
							--
							--else
							--	if player.gmLevel > 0 then
							--		player:sendMinitext("No Change, Come back after 24 Hours")
							--		player:sendMinitext("Time Since Last Disp Inc (SEC): "..timeSinceLastDispInc)
							--		player:sendMinitext("Time Since Last Disp Inc (HOURS): "..round((timeSinceLastDispInc / 3600),2))
							--	end
							--end
							--player.registry["disposition_102"] = localDispo
							--player.registry["last_talk_time_102"] = os.time()
							--miner_bronson.mainMenu(player,npc, localBronsonLastTalkTime, localDispo)
							-----Celestial Ore Node-----
							flowerImage = {graphic = convertGraphic(848, "monster"), color = 12}
							player:dialogSeq(
								{
									flowerImage,
									name .. "Relatively rare, Rosantium Ore nodes will yeild Rosantium Ore when Mined.",
									name .. "Rosantium has a lovely red hue to the metal and is a component in very strong weapons and armor."
								},
								1
							)
						elseif aboutPlantsMenuOption == "Celestial Ore Node" then
							--if timeSinceLastDispInc > 86400 then
							--	localDispo = localDispo + 15000
							--	if player.gmLevel > 0 then
							--		player:sendMinitext("Disposition Increased: 15,000")
							--	end
							--	player.registry["last_disp_inc_time_102"] = os.time()
							--
							--else
							--	if player.gmLevel > 0 then
							--		player:sendMinitext("No Change, Come back after 24 Hours")
							--		player:sendMinitext("Time Since Last Disp Inc (SEC): "..timeSinceLastDispInc)
							--		player:sendMinitext("Time Since Last Disp Inc (HOURS): "..round((timeSinceLastDispInc / 3600),2))
							--	end
							--end
							--player.registry["disposition_102"] = localDispo
							--player.registry["last_talk_time_102"] = os.time()
							--miner_bronson.mainMenu(player,npc, localBronsonLastTalkTime, localDispo)
							-----Irbynite Ore node-----
							flowerImage = {graphic = convertGraphic(853, "monster"), color = 18}
							player:dialogSeq(
								{
									flowerImage,
									name .. "Celestial Ore nodes will yeild Sky Iron Ore when mined.",
									name ..
										"Sky Iron is rare and is used in making some of the most powerful arms and armor. It is a componenet of Supremium too."
								},
								1
							)
						elseif aboutPlantsMenuOption == "Irbynite Ore node" then
							--if timeSinceLastDispInc > 86400 then
							--	localDispo = localDispo + 15000
							--	if player.gmLevel > 0 then
							--		player:sendMinitext("Disposition Increased: 15,000")
							--	end
							--	player.registry["last_disp_inc_time_102"] = os.time()
							--
							--else
							--	if player.gmLevel > 0 then
							--		player:sendMinitext("No Change, Come back after 24 Hours")
							--		player:sendMinitext("Time Since Last Disp Inc (SEC): "..timeSinceLastDispInc)
							--		player:sendMinitext("Time Since Last Disp Inc (HOURS): "..round((timeSinceLastDispInc / 3600),2))
							--	end
							--end
							--player.registry["disposition_102"] = localDispo
							--player.registry["last_talk_time_102"] = os.time()
							--miner_bronson.mainMenu(player,npc, localBronsonLastTalkTime, localDispo)
							-----Hardened Celestial Ore Node-----
							flowerImage = {graphic = convertGraphic(818, "monster"), color = 24}
							player:dialogSeq(
								{
									flowerImage,
									name .. "Irbynite Ore nodes will yeild Irbynite Ore when mined.",
									name .. "This ore is a primary componenet in many pieces of powerful armor."
								},
								1
							)
						elseif aboutPlantsMenuOption == "Hardened Celestial Ore Node" then
							--if timeSinceLastDispInc > 86400 then
							--	localDispo = localDispo + 15000
							--	if player.gmLevel > 0 then
							--		player:sendMinitext("Disposition Increased: 15,000")
							--	end
							--	player.registry["last_disp_inc_time_102"] = os.time()
							--
							--else
							--	if player.gmLevel > 0 then
							--		player:sendMinitext("No Change, Come back after 24 Hours")
							--		player:sendMinitext("Time Since Last Disp Inc (SEC): "..timeSinceLastDispInc)
							--		player:sendMinitext("Time Since Last Disp Inc (HOURS): "..round((timeSinceLastDispInc / 3600),2))
							--	end
							--end
							--player.registry["disposition_102"] = localDispo
							--player.registry["last_talk_time_102"] = os.time()
							--miner_bronson.mainMenu(player,npc, localBronsonLastTalkTime, localDispo)
							flowerImage = {graphic = convertGraphic(852, "monster"), color = 0}
							player:dialogSeq(
								{
									flowerImage,
									name .. "Hardened Celestial Ore Nodes will yeild Duranium Ore when mined.",
									name ..
										"Duranium is the other component is making Supremium Ingots, metal used in the most powerful arms and armor in the world!!"
								},
								1
							)
						elseif aboutPlantsMenuOption == "Back" then
							player:dialogSeq({flowerImage, name .. "Alrighty, I will talk to you later then!"}, 1)
						--player.registry["disposition_102"] = localDispo
						--player.registry["last_talk_time_102"] = os.time()
						--miner_bronson.mainMenu(player,npc, localBronsonLastTalkTime, localDispo)
						end
					elseif aboutMenuOption == "About Mining" then
						--if timeSinceLastDispInc > 86400 then
						--			localDispo = localDispo + 15000
						--			if player.gmLevel > 0 then
						--				player:sendMinitext("Disposition Increased: 15,000")
						--			end
						--			player.registry["last_disp_inc_time_102"] = os.time()
						--
						--		else
						--			if player.gmLevel > 0 then
						--				player:sendMinitext("No Change, Come back after 24 Hours")
						--				player:sendMinitext("Time Since Last Disp Inc (SEC): "..timeSinceLastDispInc)
						--				player:sendMinitext("Time Since Last Disp Inc (HOURS): "..round((timeSinceLastDispInc / 3600),2))
						--			end
						--		end
						--player.registry["disposition_102"] = localDispo
						--player.registry["last_talk_time_102"] = os.time()
						--miner_bronson.mainMenu(player,npc, localBronsonLastTalkTime, localDispo)
						player:dialogSeq(
							{
								t,
								name ..
									"Mining is the extraction of valuable minerals or other geological materials from the earth usually from an orebody, lode, vein, seam, reef or placer deposits. These deposits form a mineralized package that is of economic interest to the miner.",
								name ..
									"Ores recovered by mining include metals, coal, oil shale, gemstones, limestone, chalk, dimension stone, rock salt, potash, gravel, and clay"
							},
							1
						)
					elseif
						aboutMenuOption == "About the Tools"
					 --
					 then
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
						]] player:dialogSeq(
							{
								t,
								name .. "",
								name .. ""
							},
							1
						)

					--if timeSinceLastDispInc > 86400 then
					--	localDispo = localDispo + 15000
					--	if player.gmLevel > 0 then
					--		player:sendMinitext("Disposition Increased: 15,000")
					--	end
					--	player.registry["last_disp_inc_time_102"] = os.time()
					--
					--else
					--	if player.gmLevel > 0 then
					--		player:sendMinitext("No Change, Come back after 24 Hours")
					--		player:sendMinitext("Time Since Last Disp Inc (SEC): "..timeSinceLastDispInc)
					--		player:sendMinitext("Time Since Last Disp Inc (HOURS): "..round((timeSinceLastDispInc / 3600),2))
					--	end
					--end
					--
					--player.registry["disposition_102"] = localDispo
					--player.registry["last_talk_time_102"] = os.time()
					--miner_bronson.mainMenu(player,npc, localBronsonLastTalkTime, localDispo)
					end
				elseif skillMenuOption == "Unlearn Skill" then
					local optsForgetMining = {}

					table.insert(optsForgetMining, "Yes, I want to forget.")
					table.insert(optsForgetMining, "No, I have reconsidered.")

					forgetSkillMenuOption = player:menuString(name .. "Are you ready to forget the Mining Skill?", optsForgetMining)

					if forgetSkillMenuOption == "Yes, I want to forget." then
						--localDispo = localDispo - 15000
						--player.registry["disposition_102"] = localDispo
						--player.registry["last_talk_time_102"] = os.time()
						--miner_bronson.mainMenu(player,npc, localBronsonLastTalkTime, localDispo)
						player.registry["learned_mining"] = 0
						player.registry["mining_level"] = 0
						player.registry["mining_tnl"] = 0

						npc:talk(2, "You have forgotten the Mining skill.")
					elseif forgetSkillMenuOption == "No, I have reconsidered." then

					--player.registry["disposition_102"] = localDispo
					--player.registry["last_talk_time_102"] = os.time()
					--miner_bronson.mainMenu(player,npc, localBronsonLastTalkTime, localDispo)
					end
				elseif skillMenuOption == "Learn Mining" then
					local optsLearnMining = {}

					table.insert(optsLearnMining, "Yes, I am ready to learn.")
					table.insert(optsLearnMining, "No, I have reconsidered.")

					player:dialogSeq(
						{
							t,
							name .. "Mining.",
							name .. ""
						},
						1
					)

					learnSkillMenuOption = player:menuString(name .. "Are you ready to learn the Mining Skill?", optsLearnMining)

					if learnSkillMenuOption == "Yes, I am ready to learn." then
						--player.registry["disposition_102"] = localDispo + 70000
						--player:sendMinitext("Disposition Increased: 10,000")
						--player.registry["last_disp_inc_time_102"] = os.time()
						--player.registry["last_talk_time_102"] = os.time()
						--miner_bronson.mainMenu(player,npc, localBronsonLastTalkTime, localDispo)
						player:dialogSeq({"Congradulations, you have learned about Mining!"}, 1)

						if player:hasLegend("beginner_mining") then
							player:removeLegendbyName("beginner_mining")
						end

						player:addLegend("Beginner Miner", "beginner_mining", 125, 108)
						player:msg(4, "=== New Legend Added! ===", player.ID)
						player.registry["learned_mining"] = 1
						player.registry["mining_level"] = 1
						player.registry["mining_tnl"] = 1000

						player:sendMinitext("You've learned Mining!")
					elseif learnSkillMenuOption == "No, I have reconsidered." then
						--player.registry["disposition_102"] = localDispo
						--player.registry["last_talk_time_102"] = os.time()
						player:dialogSeq({"Oh, alright, well please come back when you are ready to learn!"}, 1)
					end
				elseif skillMenuOption == "Learn Smelting" then
					local optsLearnSmelting = {}

					table.insert(optsLearnSmelting, "Yes, I am ready to learn.")
					table.insert(optsLearnSmelting, "No, I have reconsidered.")

					player:dialogSeq(
						{
							t,
							name .. "Smelting",
							name .. ""
						},
						1
					)

					learnSkillMenuOption = player:menuString(name .. "Are you ready to learn the Smelting Skill?", optsLearnSmelting)

					if learnSkillMenuOption == "Yes, I am ready to learn." then
						--player.registry["disposition_102"] = localDispo + 70000
						--player:sendMinitext("Disposition Increased: 10,000")
						--player.registry["last_disp_inc_time_102"] = os.time()
						--player.registry["last_talk_time_102"] = os.time()
						--miner_bronson.mainMenu(player,npc, localBronsonLastTalkTime, localDispo)
						player:dialogSeq({"Congradulations, you have learned about Smelting!"}, 1)

						if player:hasLegend("beginner_smelting") then
							player:removeLegendbyName("beginner_smelting")
						end

						player:addLegend("Beginner Smelter", "beginner_smelting", 125, 108)
						player:msg(4, "=== New Legend Added! ===", player.ID)
						player.registry["learned_smelting"] = 1
						player.registry["smelting_level"] = 1
						player.registry["smelting_tnl"] = 1500

						player:sendMinitext("You've learned Smelting!")
					elseif learnSkillMenuOption == "No, I have reconsidered." then
						--player.registry["disposition_102"] = localDispo
						--player.registry["last_talk_time_102"] = os.time()
						player:dialogSeq({"Oh, alright, well please come back when you are ready to learn!"}, 1)
					end
				elseif skillMenuOption == "Learn Smithing" then
					local optsLearnSmithing = {}

					table.insert(optsLearnSmithing, "Yes, I am ready to learn.")
					table.insert(optsLearnSmithing, "No, I have reconsidered.")

					player:dialogSeq(
						{
							t,
							name .. "",
							name .. "Smithing"
						},
						1
					)

					learnSkillMenuOption = player:menuString(name .. "Are you ready to learn the Smithing Skill?", optsLearnSmithing)

					if learnSkillMenuOption == "Yes, I am ready to learn." then
						--player.registry["disposition_102"] = localDispo + 70000
						--player:sendMinitext("Disposition Increased: 10,000")
						--player.registry["last_disp_inc_time_102"] = os.time()
						--player.registry["last_talk_time_102"] = os.time()
						--miner_bronson.mainMenu(player,npc, localBronsonLastTalkTime, localDispo)
						player:dialogSeq({"Congradulations, you have learned about Smithing!"}, 1)

						if player:hasLegend("beginner_smithing") then
							player:removeLegendbyName("beginner_smithing")
						end

						player:addLegend("Beginner Smith", "beginner_smelting", 125, 108)
						player:msg(4, "=== New Legend Added! ===", player.ID)
						player.registry["learned_smithing"] = 1
						player.registry["smithing_level"] = 1
						player.registry["smithing_tnl"] = 2250

						player:sendMinitext("You've learned Smithing!")
					elseif learnSkillMenuOption == "No, I have reconsidered." then
						--player.registry["disposition_102"] = localDispo
						--player.registry["last_talk_time_102"] = os.time()
						player:dialogSeq({"Oh, alright, well please come back when you are ready to learn!"}, 1)
					end
				end
			elseif talkMenuOption == "Part-Time Job" then
				player:dialogSeq({t, name .. "I am still getting the shop setup, I am not ready to take on hired help yet."}, 1)

			--if timeSinceLastDispInc < 86400 then
			--	localDispo = localDispo + 5000
			--	player:sendMinitext("Disposition Increased: 5000")
			--	player.registry["last_disp_inc_time_102"] = os.time()
			--else
			--	player:sendMinitext("No Change, Come back after 24 Hours")
			--end
			--player.registry["disposition_102"] = localDispo
			--player.registry["last_talk_time_102"] = os.time()
			--miner_bronson.mainMenu(player,npc, localBronsonLastTalkTime, localDispo)
			end
		elseif mainMenuOption == "Reset Mining" then
			player.registry["learned_mining"] = 0
			player.registry["mining_level"] = 0
			player.registry["mining_tnl"] = 0

			npc:talk(2, "Reset done for " .. player.name)
		elseif mainMenuOption == "Leave" then
			--player.registry["disposition_102"] = localDispo
			--player.registry["last_talk_time_102"] = os.time()
			player:dialogSeq({t, name .. "Come back again!"}, 1)
		end

		return
	end
	--[[
say = function(player, npc)

	if string.lower(player.speech) == "reset" then
        player.registry["last_talk_time_102"] = 0
        player.registry["disposition_102""] = 0

		--player.registry["learned_mining"] = 0
		--player.registry["mining_level"] = 0
		--player.registry["mining_tnl"] = 0
		npc:talk(2, "Reset done for "..player.name)
		--player:removeLegendbyName("beginner_ore_mining")
	end
end,
--]]
}
