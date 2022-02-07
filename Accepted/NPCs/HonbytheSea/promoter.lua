promoter = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID
			local opts = {}
			local trials = {}
			local map = npc.mapTitle

			local killcount3013 = player:killCount(3013)
			local killcount3002 = player:killCount(3002)
			local killcount2065 = player:killCount(2065)

			local killcount501 = player:killCount(501)

			if map == "Fighter's Hall" then
				if player.baseClass ~= 1 then
					player:dialogSeq({t, name .. "I cannot help you. Please look elsewhere."}, 1)
					return
				end
			elseif map == "Scoundrel's Guild" then
				if player.baseClass ~= 2 then
					player:dialogSeq({t, name .. "I cannot help you. Please look elsewhere."}, 1)
					return
				end
			elseif map == "Seagrove Library" then
				if player.baseClass ~= 3 then
					player:dialogSeq({t, name .. "I cannot help you. Please look elsewhere."}, 1)
					return
				end
			elseif map == "House of ASAK" then
				if player.baseClass ~= 4 then
					player:dialogSeq({t, name .. "I cannot help you. Please look elsewhere."}, 1)
					return
				end
			end

			if player.level < 100 then
				table.insert(opts, "What do you do?")
			end
			if player.level == 99 and player.quest["level100"] == 0 then
				table.insert(opts, "I want to grow Stronger!")
			end
			if player.quest["level100"] == 1 and player.quest["level100strength"] < 2 then
				table.insert(opts, "Show me your trials!")
			end

			if player.level == 99 then
				menu = player:menuString(name .. "You look like you have been training", opts)
			elseif player.level >= 100 then
				menu = player:menuString(name .. "You finally did something right.", opts)
			else
				menu = player:menuString(name .. "Why come you so weak?", opts)
			end

			if menu == "What do you do?" then
				if player.level == 99 then
					player:dialogSeq({t, name .. "I help those who are battle tested seek a higher enlightenment."}, 1)
				else
					player:dialogSeq({t, name .. "I pound little snot-nosed, asks-stupid-questions, babies, like you."}, 1)
				end
			elseif menu == "I want to grow Stronger!" then
				player:msg(4, "[Quest Started] Click Marko to learn more and start his trials", player.ID)
				player.quest["level100"] = 1
				player:dialogSeq(
					{
						t,
						name .. "There is a way you could grow stronger.",
						name .. "I will send you on several trials to prove your worth.",
						name .. "If you fail these trials you will never be instructed in further skills.",
						name .. "I mean you might as well just fall on your sword if you can't complete these trials.",
						name .. "Like seriously, if you are just another wanna-be, please, go waste someone elses time.",
						name .. "There are 4 trials: Endurance, Wealth, Wisdom, and then a final test of Strength and Wits."
					},
					1
				)
			elseif menu == "Show me your trials!" then
				if player.quest["level100endurance"] <= 3 then
					table.insert(trials, "Endurance")
				end
				if player.quest["level100wealth"] <= 1 then
					table.insert(trials, "Wealth")
				end
				if player.quest["level100wisdom"] <= 1 then
					table.insert(trials, "Wisdom")
				end

				if
					player.quest["level100endurance"] == 4 and player.quest["level100wealth"] == 2 and
						player.quest["level100wisdom"] == 2 and
						player.quest["level100strength"] < 2
				 then
					table.insert(trials, "Strength and Wits")
				end

				menu = player:menuString(name .. "Why come you so weak?", trials)

				if menu == "Endurance" then
					if player.quest["level100endurance"] == 0 then
						player:flushKills(3002)
						player.quest["level100endurance"] = 1
						player:msg(4, "[Quest Updated] Started Trial of Endurance - Slay 100 Ogre Champions", player.ID)
						player:dialogSeq(
							{
								t,
								name ..
									"My Trial of Endurance is no easy feat. First you must climb the mountains of Lortz and slay 100 Ogre Champions.",
								name .. "Do not return before you have completed your task or I might make you start all over."
							},
							1
						)
					elseif player.quest["level100endurance"] == 1 then
						if killcount3002 >= 100 then
							player:flushKills(3013)
							player.quest["level100endurance"] = 2
							finishedQuest(player)
							player:msg(4, "[Quest Updated] Trial of Endurance - Slay 100 Elder Gargoyles", player.ID)
							player:dialogSeq(
								{
									t,
									name .. "Well, it seems you aren't completely useless.",
									name ..
										"Now then, to continue this trial, you must enter the Ruins of Bettay and dispatch 100 Elder Gargoyles.",
									name .. "Do not return before you have completed your task or I might make you start all over."
								},
								1
							)
						else
							player:dialogSeq(
								{
									t,
									name .. "What did I tell you? Do not return until you have completed your quest!",
									name .. "Are you dense? You got something lodged in that head of yours? Need me to slice it out?",
									name .. "One more time. 100 Ogre Champions. Go kill them.",
									name .. "You are lucky, I wont make you start over this once but don't test my patience! Get Going!"
								},
								1
							)
						end
					elseif player.quest["level100endurance"] == 2 then
						if killcount3013 >= 100 then
							player:flushKills(2065)
							player.quest["level100endurance"] = 3
							finishedQuest(player)
							player:msg(4, "[Quest Updated] Trial of Endurance - Slay 50 Blackstrike Gators", player.ID)
							player:dialogSeq(
								{
									t,
									name .. "Hahaha, you're a real killer now!",
									name ..
										"To finish up the trial, you must head over to the Swamps of Blackstrike and wrestle 50 Blackstrike Gators.",
									name .. "Do not return before you have completed your task or I might make you start all over."
								},
								1
							)
						else
							player:dialogSeq(
								{
									t,
									name .. "What did I tell you? Do not return until you have completed your quest!",
									name .. "Are you dense? You got something lodged in that head of yours? Need me to slice it out?",
									name .. "One more time. 100 Elder Gargoyles. Go kill them.",
									name .. "You are lucky, I wont make you start over this once but don't test my patience! Get Going!"
								},
								1
							)
						end
					elseif player.quest["level100endurance"] == 3 then
						if killcount2065 >= 50 then
							player.quest["level100endurance"] = 4
							finishedQuest(player)
							player:addLegend("Passed the Trial of Endurance " .. curT(), "level100trial", 1, 16)
							player:msg(4, "[Quest Completed] A Legend Mark is obtained. Passed the Trial of Endurance", player.ID)
							player:sendMinitext("Endurance Trial Completed")
							player:dialogSeq(
								{
									t,
									name .. "I didn't think you had it in you.",
									name .. "Congratulations, you have proved your endurance."
								},
								1
							)
						else
							player:dialogSeq(
								{
									t,
									name .. "What did I tell you? Do not return until you have completed your quest!",
									name .. "Are you dense? You got something lodged in that head of yours? Need me to slice it out?",
									name .. "One more time. 50 Blackstrike Gators. Go kill them.",
									name .. "You are lucky, I wont make you start over this once but don't test my patience! Get Going!"
								},
								1
							)
						end
					end
				elseif menu == "Wealth" then
					if player.quest["level100wealth"] == 0 then
						player:dialogSeq(
							{
								t,
								name .. "Yes, the Trial of Wealth. That's right. You must lessen your burdens. *I'll take that.*",
								name .. "I say bring me... 500,000 coins, yeah, that should be enough."
							},
							1
						)
						player.quest["level100wealth"] = 1
						player:msg(4, "[Quest Updated] Started Trial of Wealth", player.ID)
					elseif player.quest["level100wealth"] == 1 then
						if player:removeGold(500000) == true then
							player.quest["level100wealth"] = 2
							finishedQuest(player)
							player:addLegend("Passed the Trial of Wealth " .. curT(), "level100trial", 1, 16)
							player:msg(4, "[Quest Completed] A Legend Mark is obtained. Passed the Trial of Wealth", player.ID)
							player:sendMinitext("Wealth Trial Completed")
							player:dialogSeq({t, name .. "I didn't think you had it in you."}, 1)
						else
							player:dialogSeq({t, name .. "I told you to bring me 500,000 coins. So... Where is it?"}, 1)
						end
					end
				elseif menu == "Wisdom" then
					if player.quest["level100wisdom"] == 0 then
						player:dialogSeq(
							{
								t,
								name .. "So you think you are ready to show me what you have learned?",
								name .. "Return to me with 4,000,000,000 EXP.(Press F1 to return Max if needed.)"
							},
							1
						)
						player.quest["level100wisdom"] = 1
						player:msg(4, "[Quest Updated] Started Trial of Wisdom", player.ID)
					elseif player.quest["level100wisdom"] == 1 then
						local expCostReduction = player.registry["level100wisdompaidexp"] * 1000000000

						if player.exp >= 4000000000 then
							player.exp = player.exp - (4000000000 - expCostReduction)
							player.quest["level100wisdom"] = 2
							player:addLegend("Passed the Trial of Wisdom " .. curT(), "level100trial", 1, 16)
							player:msg(4, "[Quest Completed] A Legend Mark is obtained. Passed the Trial of Wisdom", player.ID)
							player:sendMinitext("Wisdom Trial Completed")
							finishedQuest(player)
							player:sendStatus()
							player:dialogSeq({t, name .. "maybe you are not all talk after all."}, 1)
						elseif player.exp < 4000000000 and player.exp >= 1000000000 then
							local confirm = player:menuString("Would you like to give 1,000,000,000 EXP towards your trial?", {"Yes", "No"})
							if confirm == "Yes" then
								player.exp = player.exp - 1000000000
								player.registry["level100wisdompaidexp"] = player.registry["level100wisdompaidexp"] + 1
								if player.registry["level100wisdompaidexp"] >= 4 then
									player.quest["level100wisdom"] = 2
									player:addLegend("Passed the Trial of Wisdom " .. curT(), "level100trial", 1, 16)
									player:msg(4, "[Quest Completed] A Legend Mark is obtained. Passed the Trial of Wisdom", player.ID)
									player:sendMinitext("Wisdom Trial Completed")
									finishedQuest(player)
									player:sendStatus()
									player:dialogSeq({t, name .. "maybe you are not all talk after all."}, 1)
								else
									player:sendStatus()
									expCostReduction = player.registry["level100wisdompaidexp"] * 1000000000
									player:dialogSeq({t, name .. "you have submitted " .. expCostReduction .. "out of 4000000000"}, 1)
								end
							end
						else
							player:dialogSeq(
								{t, name .. "I told you to return with 4,000,000,000 Experience. I worry about your competance."},
								1
							)
						end
					end
				elseif menu == "Strength and Wits" then
					if player.quest["level100strength"] == 0 then
						player:dialogSeq(
							{
								t,
								name .. "Sometimes we are our own worst enemies. This final trial is not to be taken lightly.",
								name .. "You must now prove you are capable of mastering your own essence."
							},
							1
						)
						player:flushKills(501)
						player:flushKills(502)
						player:flushKills(503)
						player.quest["level100strength"] = 1
						player:msg(4, "[Quest Updated] Started Trial of Strength and Wits", player.ID)

						choice = player:menuString("Would you like to begin the trial now?", {"Yes", "No"})
						if (choice == "Yes") then
							if (#player.group > 1) then
								player:dialog("Your group is too big! You must face this trial alone.", {})
							else
								local mapStart = getFreeInstance(1)
								if (mapStart ~= false) then
									if (loadInstance(mapStart, "strengthTrial") == true) then
										player:warp(mapStart, math.random(9, 10), math.random(12, 14))
									end
								end
							end
						end
					elseif player.quest["level100strength"] == 1 then
						if player.registry["killed_yourself"] >= 1 then
							player:dialogSeq({t, name .. "You are stronger. I can tell already. Maybe you are not all talk after all."}, 1)
							player.quest["level100strength"] = 2
							finishedQuest(player)
							player:removeLegendbyName("level100trial")
							player:addLegend("Reborn through the Trial of Strength and Wits " .. curT(), "level100", 94, 15)
							player:msg(4, "[Quest Completed] A Legend Mark is obtained. Completed the Trial of Strength and Wits", player.ID)
							player:sendMinitext("Strength and Wits Trial Completed")
						else
							player:dialogSeq({t, name .. "You going to try again?"}, 1)
							choice = player:menuString("Would you like to begin the trial now?", {"Yes", "No"})
							if (choice == "Yes") then
								if (#player.group > 1) then
									player:dialog("Your group is too big! You must face this trial alone.", {})
								else
									local mapStart = getFreeInstance(1)
									if (mapStart ~= false) then
										if (loadInstance(mapStart, "strengthTrial") == true) then
											player:warp(mapStart, math.random(9, 10), math.random(12, 14))
										end
									end
								end
							end
						end
					end
				end
			end
		end
	),
	nearbyPlayers = function(npc)
		local pc = npc:getObjectsInArea(BL_PC)
		local m, x, y = npc.m, npc.x, npc.y

		if #pc > 0 then
			for i = 1, #pc do
				if
					pc[i].level == 99 and
						(pc[i].quest["level100endurance"] == 0 and pc[i].quest["level100wealth"] == 0 and
							pc[i].quest["level100wisdom"] == 0 and
							pc[i].quest["level100strength"] < 0)
				 then
					pc[i]:selfAnimationXY(pc[i].ID, 248, x, y)
				end
			end
		end
	end
}
