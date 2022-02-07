clan_creator = {
	click = async(
		function(player, npc)
			local groupCheck = false
			groupCheck = clanGroupCheck(player)

			local t = {graphic = convertGraphic(552, "monster"), color = 0}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			local promotionopts = {}
			local clanfeatures = {}
			local opts = {}
			local clannumber = player.clan

			if player.registry["clan_create_approval"] == 0 then
				return
			end

			if getClanRank(player.name) >= 0 and player.clan == 0 and player.registry["clan_create_approval"] == 1 then
				table.insert(opts, "Create a Clan")
			end

			if groupCheck == true then
				table.remove(opts, 1)

				if (player.registry["clan_trial_sacrifice"] == 1) then
					table.insert(opts, "Trial of Sacrifice")
				end
				if (player.registry["clan_trial_storytelling"] == 1) then
					table.insert(opts, "Trial of Storytelling")
				end
				if (player.registry["clan_trial_goodvsevil"] == 1) then
					table.insert(opts, "Trial of Good vs. Evil")
				end

				if (player.registry["clan_trial_wealth"] == 1) then
					table.insert(opts, "Trial of Wealth")
				end
				if (player.registry["clan_trial_endurance"] == 1) then
					table.insert(opts, "Trial of Endurance")
				end

				if #opts == 0 then -- this signifies all trials have been completed
					table.insert(opts, "Formally Establish the Clan")
				end
			end

			if #opts >= 1 then
				table.insert(opts, "Abandon members/reset") -- Allows the group leader to disband/reset even if all members are not online
			end

			local menuOption = player:menuString("How may I help you?", opts)

			if (menuOption == "Create a Clan") then
				clan_creator.createClan(player, npc)
			elseif (menuOption == "Abandon members/reset") then
				player:dialogSeq(
					{
						t,
						"During this reset process, you will permanently abandon all progress that has been gained towards the creation of the clan as well as having to start over the entire process, which includes seeking out a GM for approval and to initiating the process again."
					},
					1
				)
				local choice2 = player:menuString("Are you sure you want to do this?", {"Yes", "No"})
				if choice2 == "Yes" then
					player.registry["clan_create_member_1"] = 0
					player.registry["clan_create_member_2"] = 0
					player.registry["clan_create_member_3"] = 0
					player.registry["clan_create_member_4"] = 0
					player.registry["clan_trial_sacrifice"] = 0
					player.registry["clan_trial_storytelling"] = 0
					player.registry["clan_trial_goodvsevil"] = 0
					player.registry["clan_trial_wealth"] = 0
					player.registry["clan_trial_endurance"] = 0
					player.registry["clan_create_approval"] = 0
					npc:talk(0, "How unfortunate that you have succumbed to this disgrace. Better luck next time.")
				end
			elseif
				(menuOption ~= "" and menuOption ~= "Create a Clan" and menuOption ~= "Formally Establish the Clan" and
					menuOption ~= "Complete all trials -- GM")
			 then
				clan_creator.presentTrial(player, npc, menuOption)
			elseif (menuOption == "Complete all trials -- GM") then
				clan_creator.completeTrials(player, npc)
			elseif menuOption == "Formally Establish the Clan" then
				clan_creator.establishClan(player, npc)
			end
		end
	),
	createClan = function(player, npc)
		local groupedPlayer
		local sameIPdetected = 0

		player:dialogSeq(
			{
				t,
				"\nSo " ..
					player.name ..
						",\n\nthe word on the streets of Hon say that you want to create a clan.\n\nListen carefully to the following instructions."
			},
			1
		)
		player:dialogSeq(
			{
				t,
				"To accomplish this goal, you must find at least 3 other willing members that wish to begin this arduous journey with you. It will be necessary to complete the upcoming trials of varying difficulty, ultimately proving your worth to the Gods by showing your ability to work as a team in a future clan."
			},
			1
		)
		player:dialogSeq(
			{
				t,
				"These 3 other members must not only be willing to face and overcome great adversity but also depict a high level of commitment to the Clan. Only this will bring success."
			},
			1
		)
		player:dialogSeq(
			{
				t,
				"You must consider carefully the members you wish to partake this journey with you, as they will be required every step of the way.\n\nIf one member is to fall, the whole team falls."
			},
			1
		)
		player:dialogSeq(
			{t, "Each perspective group member must be present for each of the Trials and substitutions cannot be made."},
			1
		)
		player:dialogSeq(
			{
				t,
				"As the leader of the group, and the hereto default primogen of the perspective clan, it is solely your responsibility to keep your members together and initiate each Trial."
			},
			1
		)
		player:dialogSeq(
			{
				t,
				"Lastly, it is important to note again that these Trials will not be easy and for good reason. You must choose wisely in your starting members (who will become your council).\n\nYou may reset your progress at any time by choosing Abandon/reset but know that reimbursements for lost time or materials will not be made."
			},
			1
		)
		player:dialogSeq({t, "You may complete the trials in any order you desire."}, 1)
		player:dialogSeq({t, "Only through the successful completion of all trials, will you have appeased the Gods."}, 1)

		local choice =
			player:menuString(
			"Do you understand these risks and are willing to endure complete and utter hardship?",
			{"Yes", "No, I am not worthy."}
		)

		if (#player.group ~= 4) then
			player:popUp("Sorry but you must have a total of 4 group members to attempt the trials.")
			return
		end

		----- IP address Checks -------- Don't want a new clan of only alts-------
		local ipaddress = Player(player.group[1]).ipaddress

		for i = 2, #player.group do
			if Player(player.group[i]).ipaddress == ipaddress then
				sameIPdetected = 1
				break
			end
		end

		if sameIPdetected == 1 then
			player:popUp("Sorry, the founding clan members can not be alts.")
			return
		end
		--------------------------------------------------------------------

		------- This section establishes the player IDs into the group leaders registries. This gets used during each trial to determine if they are with orignal group members
		for i = 1, #player.group do
			groupedPlayer = Player(player.group[i])
			player.registry["clan_create_member_" .. i] = groupedPlayer.ID
		end

		player:dialogSeq(
			{
				t,
				"Your perspective clan members have been selected and recorded in the records. You must seek out these members (and only these members) to fulfill your upcoming trials."
			}
		)
		----------------------------------------------------------------------------------------------------
	end,
	establishClan = function(player, npc)
		if groupCheck == false then
			player:dialogSeq({t, "You must be grouped with your original group members to continue the creation process."})
			return
		end

		local clanName =
			player:input(
			"Please use your GM approved clan name. GMs will be checking this - if a different name is used, clan will be deleted."
		)

		local choice =
			player:menuString("You have entered: " .. clanName .. "\n\nAre you absolutely sure this is correct?", {"Yes", "No"})

		if choice == "No" or choice == nil then
			return
		end

		if clanName == nil or clanName == "" then
			return
		end

		local newClanId = player:addClan(clanName)

		if newClanId == 0 then
			player:popUp("Clan creation unsuccessful. Please contact a GM for assistance.")
			return
		elseif newClanId ~= 0 then
			player.registry["clan_create_approval"] = 0
			for i = 1, #player.group do
				player.registry["clan_create_member_" .. i] = 0 -- return clan member registries to 0
				Player(player.group[i]).clan = newClanId
				if Player(player.group[i]).ID == player.ID then
					setClanRank((Player(player.group[i]).name), 5)
					Player(player.group[i]):addLegend(
						"Primogen of " .. clanName .. " since Year " .. (curYear()) .. ", " .. (getCurSeason()),
						"primogen",
						7,
						128
					)
				else
					setClanRank((Player(player.group[i]).name), 4)
				end
				Player(player.group[i]):updateState()
				Player(player.group[i]):dialogSeq(
					{
						t,
						"Congratulations on rising above the challenges of the Trials. Your new clan has been created and is accessible in game."
					},
					1
				)
			end
			broadcast(-1, "[CLAN]: Congratulations to " .. clanName .. " for completing the Clan Trials!")
		end
	end,
	completeTrials = function(player)
		player.registry["clan_trial_sacrifice"] = 0
		player.registry["clan_trial_storytelling"] = 0
		player.registry["clan_trial_goodvsevil"] = 0
		player.registry["clan_trial_wealth"] = 0
		player.registry["clan_trial_endurance"] = 0
	end,
	presentTrial = function(player, npc, trialName)
		local sacrificedPlayer
		local count = 0
		local worked = 0

		if trialName == "Trial of Sacrifice" then
			player:dialogSeq(
				{
					t,
					"\nAh, Trial of Sacrifice and it is your hardship to bear as the future Primogen.\n\nYou must be willing to become one with death and give up some of your life experiences (you know, for the greater good?). 4 Bil Experience will be required."
				},
				1
			)

			local choice = player:menuString("Would you like to proceed?", {"Yes", "No way!"})

			if choice == "Yes" then
				if player.exp >= 4000000000 then
					npc:talk(0, "Hold still, this will hurt just a little.")
					player:sendAnimation(198)
					player.paralyzed = true
					player:sendMinitext("Your experiences dissipate as a pleasant aroma to the Gods...")
					player:setDuration("clan_experience_drain", 30000)
				else
					player:popUp("Sorry you are not worthy (not enough experience).")
					return
				end
			end
		elseif trialName == "Trial of Good vs. Evil" then
			npc:talk(0, "Beginning the " .. trialName)

			player:dialogSeq(
				{
					t,
					"Ah, the Trial of Good vs. Evil.\n\nThis one is simple, just select how good or evil you want your clan to be on the next page."
				},
				1
			)
			player:dialogSeq(
				{
					t,
					"....Hah, you thought that was it?  If only things in this life were so simple... or so Ol' Pappy Grimloch use to say to me when I was a youngin'"
				},
				1
			)
			player:dialogSeq(
				{
					t,
					"Your perspective clan needs to seek out my closest (and only) living relative, Elder Grimloch, who lives as a Hermit in the far northern reaches of Cathay. He likes to keep himself guarded as he is not so fond of people."
				},
				1
			)
			player:dialogSeq(
				{t, "Be wary on your travels to that far away land, as I've heard rumors of some troubling folk along the way."},
				1
			)
			player:dialogSeq({t, "Report back to me when you have finished with your task."})
		elseif trialName == "Trial of Storytelling" then
			npc:talk(0, "Beginning the " .. trialName)
		elseif trialName == "Trial of Wealth" then
			player:talk(0, "" .. trialName)
		elseif trialName == "Trial of Endurance" then
			player:talk(0, "" .. trialName)
		end
	end
}

clan_experience_drain = {
	while_cast = function(player)
		local expToTake = 4000000000
		local expLoss = (expToTake / 30)
		local anim = 309
		local totalTaken = 0

		player.paralyzed = true
		player:sendAnimation(anim)

		if player.exp > 0 then
			player.exp = round(math.abs(player.exp - expLoss))
			totalTaken = totalTaken + expLoss
			player:calcStat()
			player:sendStatus()
		elseif totalTaken == expToTake then
			return
		end
		player:sendStatus()
	end,
	uncast = function(player)
		local item = 455
		local amount = 1

		player.paralyzed = false

		player:sendStatus()

		player.registry["clan_trial_sacrifice"] = 0

		player:popUp(
			"P.S. While you were watching your experiences melt away, I managed to catch your tears in a bottle for you.\n\nI heard the Gods are extra thirsty and may desire this offering."
		)
		player:addItem(item, amount)

		for i = 1, #player.group do
			Player(player.group[i]):popUp(
				"Congratulations on completing this Trial! This is just one trial of many with much more to come!"
			)
		end
	end
}
