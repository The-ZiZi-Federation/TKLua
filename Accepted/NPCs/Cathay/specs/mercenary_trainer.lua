mercenary_trainer = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = 0
			player.npcColor = 0
			player.dialogType = 1
			player.lastClick = npc.ID

			local mercenary = 12
			local opts = {}
			local opts2 = {}
			local rank1opts = {}
			local rank2opts = {}
			local rank3opts = {}
			local rank4opts = {}
			local rank5opts = {}
			local rank6opts = {}
			local menu
			local specMenu

			local killcount3087 = player:killCount(3087)

			if player.class == mercenary and player.mark < 1 and (player.baseHealth >= 457500 or player.baseMagic >= 457500) then
				table.insert(opts, "Rank 1")
			end
			--if player.class == mercenary and player.mark < 2 and (player.baseHealth >= 1197500 or player.baseMagic >= 1197500) then table.insert(opts, "Rank 2") end
			--if player.class == mercenary and player.mark < 3 and (player.baseHealth >= 1970000 or player.baseMagic >= 1970000) then table.insert(opts, "Rank 3") end
			--if player.class == mercenary and player.mark < 4 and (player.baseHealth >= 3020000 or player.baseMagic >= 3020000) then table.insert(opts, "Rank 4") end
			--if player.class == mercenary and player.mark < 5 and (player.baseHealth >= 4257500 or player.baseMagic >= 4257500) then table.insert(opts, "Rank 5") end
			--if player.class == mercenary and player.mark < 5 and (player.baseHealth >= 5682500 or player.baseMagic >= 5682500) then table.insert(opts, "Rank 6") end

			if player.baseClass == 2 and player.class < 5 then
				table.insert(opts, "I want to be a Mercenary")
			end

			if player.class == mercenary then
				table.insert(opts, "Learn Spell") --needs to be "Learn Spell"
				table.insert(opts, "Forget Spell")
			end

			menu = player:menuString(name .. "What can I do for you?", opts)

			-- Join Path
			if menu == "I want to be a Mercenary" then
				-- Learn Spells
				if player.level < 105 then
					player:dialogSeq({t, name .. "You have a lot of growing to do before I will discuss that with you."}, 1)
				elseif player.level >= 105 and player.level <= 109 then
					player:dialogSeq(
						{
							t,
							name .. "You have been growing stronger. I can see your experience has increased greatly.",
							name .. "I just do not feel you are ready for such a life long decision.",
							name .. "Come to me when you are stronger and wiser and I might consider your request."
						},
						1
					)
				elseif player.level == 110 then
					player:dialogSeq(
						{
							t,
							name .. "Well, you're not here because you want to be a baker. You look like you've been in a few fights.",
							name .. "Want a little taste of the glory and power you find on the front lines of a battlefield?",
							name .. "Join us and we'll make a real combatant out of you in no time."
						},
						1
					)
					confirm =
						player:menuString("Are you sure you want to be a Mercenary. You can not undo this choice!", {"Yes", "No"})
					if confirm == "Yes" then
						player:dialogSeq(
							{
								t,
								name .. "Welcome to the company. Time to learn which end of a sword is the sharp one.",
								name .. "What are you waiting for? Get out there and prove yourself!"
							},
							1
						)
						broadcast(-1, "[Congratulations] " .. player.name .. " has become a Bravo!")
						specRebirth(player, mercenary)
					end
				end
			elseif menu == "Learn Spell" then
				-- Forget Spells
				player:learnSpell(npc)
			elseif menu == "Forget Spell" then
				-- Rank 1 Trials
				player:forgetSpell()
			elseif menu == "Rank 1" then
				if player.quest["rank1strength"] <= 1 then
					table.insert(rank1opts, "Strength")
				end
				if player.quest["rank1wisdom"] <= 1 then
					table.insert(rank1opts, "Wisdom")
				end
				if player.quest["rank1wealth"] <= 1 then
					table.insert(rank1opts, "Wealth")
				end
				if player.quest["rank1skill"] <= 1 then
					table.insert(rank1opts, "Skill")
				end
				if player.quest["rank1duty"] <= 1 then
					table.insert(rank1opts, "Duty")
				end
				if
					player.quest["rank1strength"] >= 2 and player.quest["rank1wisdom"] >= 2 and player.quest["rank1wealth"] >= 2 and
						player.quest["rank1skill"] >= 2 and
						player.quest["rank1duty"] >= 2 and
						player.mark < 1
				 then
					table.insert(rank1opts, "Ready for Promotion!")
				end

				specMenu = player:menuString(name .. "You are up for a promotion!", rank1opts)

				if specMenu == "Strength" then
					if player.quest["rank1strength"] == 0 then
						player:flushKills(3087)
					end

					player.quest["rank1strength"] = 1
					player:dialogSeq({t, name .. "Prove your Strength! Kill Gebhard and return with his Stone Axe!"}, 1)

					if killcount3087 >= 1 then
						if player:hasItem("stone_axe", 1) == true then --Stone axe is Item # 8075
							if player:removeItem("stone_axe", 1) == true then
								player:flushKills(3087)
								finishedQuest(player)
								player:msg(4, "[Trial Completed] A Legend Mark is obtained. Passed the Trial of Strength!", player.ID)
								player:sendMinitext("Strength Trial Completed")
								player:addLegend("Passed the Trial of Strength " .. curT(), "rank1Trial", 1, 16)
								player.quest["rank1strength"] = 2
								player:dialogSeq({t, name .. "Great Work! "}, 1)
							end
						end
					else
						player:dialogSeq({t, name .. "I want the blood of Gebhard on your blade and his Stone Axe!"}, 1)
					end
				elseif specMenu == "Wisdom" then
					if player.quest["rank1wisdom"] == 0 then
						player.quest["rank1wisdom"] = 1
						player:dialogSeq(
							{t, name .. "Wisdom Trial: Return to me with 4,000,000,000 EXP.(Press F1 to return Max if needed.)"},
							1
						)
					elseif player.quest["rank1wisdom"] == 1 then
						local expCostReduction = player.registry["rank1wisdompaidexp"] * 1000000000

						if player.exp >= 4000000000 then
							player.exp = player.exp - (4000000000 - expCostReduction)
							player.quest["rank1wisdom"] = 2
							player:addLegend("Passed the Trial of Wisdom " .. curT(), "rank1Trial", 1, 16)
							player:msg(4, "[Trial Completed] A Legend Mark is obtained. Passed the Trial of Wisdom", player.ID)
							player:sendMinitext("Wisdom Trial Completed")
							finishedQuest(player)
							player:sendStatus()
							player:dialogSeq({t, name .. "It is good to see you trying so hard!"}, 1)
						elseif player.exp < 4000000000 and player.exp >= 1000000000 then
							local confirm = player:menuString("Would you like to give 1,000,000,000 EXP towards your trial?", {"Yes", "No"})

							if confirm == "Yes" then
								player.exp = player.exp - 1000000000
								player.registry["rank1wisdompaidexp"] = player.registry["rank1wisdompaidexp"] + 1
								if player.registry["rank1wisdompaidexp"] >= 4 then
									player.quest["rank1wisdom"] = 2
									player:addLegend("Passed the Trial of Wisdom " .. curT(), "rank1Trial", 1, 16)
									player:msg(4, "[Quest Completed] A Legend Mark is obtained. Passed the Trial of Wisdom", player.ID)
									player:sendMinitext("Wisdom Trial Completed")
									finishedQuest(player)
									player:sendStatus()
									player:dialogSeq({t, name .. "Keep up the good work!"}, 1)
								else
									player:sendStatus()
									expCostReduction = player.registry["rank1wisdompaidexp"] * 1000000000
									player:dialogSeq({t, name .. "you have submitted " .. expCostReduction .. "out of 4000000000"}, 1)
								end
							end
						else
							player:dialogSeq({t, name .. "I told you to return with 4,000,000,000 Experience!"}, 1)
						end
					end
				elseif specMenu == "Wealth" then
					player.quest["rank1wealth"] = 1
					player:dialogSeq(
						{
							t,
							name ..
								"The Wealth Trial. All Specialization Trainers personal Favorite. Bring me 1,000,000 coins to continue your training!"
						},
						1
					)

					if player:removeGold(1000000) == true then
						player.quest["rank1wealth"] = 2
						finishedQuest(player)
						player:msg(4, "[Trial Completed] A Legend Mark is obtained. Passed the Trial of Wealth!", player.ID)
						player:sendMinitext("Wealth Trial Completed")
						player:addLegend("Passed the Trial of Wealth " .. curT(), "rank1Trial", 1, 16)
						player:dialogSeq(
							{t, name .. "Congratulations. You have passed your Wealth Trial. What a Glorious Task you have performed!"},
							1
						)
					else
						player:dialogSeq({t, name .. "What are you trying to pull. I will count these coins before you leave!"}, 1)
					end
				elseif specMenu == "Skill" then
					player.quest["rank1skill"] = 1
					player:dialogSeq(
						{t, name .. "You want to rank up, you need to be Skilled. Learn Knockback Strike to continue Training!"},
						1
					)

					if player:hasSpell("knockback_strike") then
						player.quest["rank1skill"] = 2
						finishedQuest(player)
						player:msg(4, "[Trial Completed] A Legend Mark is obtained. Passed the Trial of Skill!", player.ID)
						player:sendMinitext("Skill Trial Completed")
						player:addLegend("Passed the Trial of Skill " .. curT(), "rank1Trial", 1, 16)
						player:dialogSeq({t, name .. "Congratulations! You'll Rank up in no time!"}, 1)
					else
						player:dialogSeq({t, name .. "I said return with the spell Knockback Strike to continue your Training!"}, 1)
					end
				elseif specMenu == "Duty" then
					player.quest["rank1duty"] = 1
					player:dialogSeq({t, name .. "Rank 1 Duty Trial: Complete 5 Path Kill and Supply Quests."}, 1)

					if player.registry["dailyq_path_kill_complete"] >= 5 and player.registry["dailyq_path_supply_complete"] >= 5 then
						player.quest["rank1duty"] = 2
						finishedQuest(player)
						player:msg(4, "[Trial Completed] A Legend Mark is obtained. Passed the Duty Trial!", player.ID)
						player:sendMinitext("Duty Trial Completed")
						player:addLegend("Passed the Duty Trial " .. curT(), "rank1Trial", 1, 16)
						player:dialogSeq({t, name .. "Congratulations. It appears you have completed the Duty Trial Requirements!"}, 1)
					else
						player:dialogSeq(
							{
								t,
								name .. "You need to complete 5 Daily Path Kill and 15 Daily Path Supply Quests to satisfy the requirements."
							},
							1
						)
					end
				elseif specMenu == "Ready for Promotion!" then
					player:removeLegendbyName("rank1Trial")
					finishedQuest(player)
					player.mark = 1
					player:updateState()
					broadcast(-1, "[CONGRATULATIONS!] " .. player.name .. " has Achieved Rank 1!")
					player:msg(4, "[Trial Completed] A Legend Mark is obtained. Rank 1 Achieved", player.ID)
					player:sendMinitext("Duty Trial Completed")
					player:addLegend("Rank 1 Achieved " .. curT(), "rank1Achieved", 1, 16)
					player.quest["rank1strength"] = 0
					player.quest["rank1wisdom"] = 0
					player.quest["rank1wealth"] = 0
					player.quest["rank1skill"] = 0
					player.quest["rank1duty"] = 0

					player:dialogSeq({t, name .. "Congratulations. It appears you have completed the Rank 1 Trials!"}, 1)
				end
			end
		end
	)
}
