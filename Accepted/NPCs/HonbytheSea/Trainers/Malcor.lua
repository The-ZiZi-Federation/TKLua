-- Hon by the Sea Malcor
wizard_trainer = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local b = {graphic = convertGraphic(2062, "item"), color = 29}

			local you = player.level
			local job = player.class
			local quest = player.quest["wizard_path"]
			local opts = {}
			local opts2 = {}

			-- Class 0 ----------------------------------------------------------------------------------------------------------------------------------------------------------
			if player.class == 0 then
				-- Class 3 ----------------------------------------------------------------------------------------------------------------------------------------------------------
				if player.level >= 5 and player.quest["wizard_path"] == 0 then
					menu = player:menuString(name .. "So you wish to learn the arts of Magic, do you??", {"Yes!", "No..."})
					if menu == "Yes!" then
						armorchoice =
							player:menuString(name .. "What style of armor do you prefer?", {"Shroud (Magic)", "Robes (Defense)"})
						if armorchoice == "Shroud (Magic)" then
							if player.sex == 0 then
								player:addItem(18101, 1)
							end
							if player.sex == 1 then
								player:addItem(18119, 1)
							end
						elseif armorchoice == "Robes (Defense)" then
							if player.sex == 0 then
								player:addItem(18102, 1)
							end
							if player.sex == 1 then
								player:addItem(18120, 1)
							end
						end
						player.quest["wizard_path"] = 1
						player.class = 3
						finishedQuest(player)
						player:addItem(18001, 1)
						player:addItem("small_vita_potion", 3)
						player:addItem("small_mana_potion", 3)
						player:addGold(150)
						player:sendStatus()
						player:addLegend("Is no longer a common peasant! " .. curT(), "path", 8, 80)
						player:msg(4, "A Legend Mark is obtained. Now the real trial begins!", player.ID)
						player:sendMinitext("You are now a wizard!")
						player.registry["spell_choice_1"] = 1
						player:msg(4, "You have a choice to make! Press F1 to pick a spell!", player.ID)
					elseif menu == "No..." then
						player:warp(1003, 128, 25)
						player:dialogSeq({t, name .. "Then get out of here!"}, 1)
					end
				end
				return
			elseif player.class == 3 then
				-- Elseif not class 0 or 2 ----------------------------------------------------------------------------------------------------------------------------------------------------------
				table.insert(opts2, "Learn Spell") --needs to be "Learn Spell"
				table.insert(opts2, "Forget Spell")
				table.insert(opts2, "Future Spells")

				if player.registry["citizen"] == 0 then
					table.insert(opts2, "Apply for Citizenship")
				end
				if quest == 1 then
					table.insert(opts2, "Your First Job")
				end
				if quest == 2 then
					table.insert(opts2, "Sewer Bandits")
				end
				if quest == 3 then
					table.insert(opts2, "About those sewer bandits...")
				end
				if quest == 4 then
					table.insert(opts2, "The Earthworks")
				end
				if quest == 5 then
					table.insert(opts2, "The War Thog's Offer")
				end
				if quest == 6 and player.level >= 40 and player.quest["leech_lord"] == 0 then
					table.insert(opts2, "The Next Mission")
				end
				if player.quest["leech_lord"] == 1 then
					table.insert(opts2, "Leech Cave")
				end

				menu = player:menuString(name .. "Why are you bothering me?", opts2)

				-- Learn Spell ------------------------------------------------------------------------------------------------------------------------------------------------------------
				if menu == "Learn Spell" then
					wizard_trainer.learnspell(player, npc)
				elseif menu == "Forget Spell" then
					player:forgetSpell()
				elseif menu == "Future Spells" then
					-- Next Spell ------------------------------------------------------------------------------------------------------------------------------------------------------------
					player:futureSpells(npc)
				elseif menu == "What is my next spell?" then
					wizard_trainer.nextSpell(player, npc)
				elseif menu == "Forget Spell" then
					-- Apply for Citizenship ------------------------------------------------------------------------------------------------------------------------------------------------
					player:forgetSpell()
				elseif menu == "Apply for Citizenship" then
					-- Your First Job ------------------------------------------------------------------------------------------------------------------------------------------------------------
					player:dialogSeq(
						{
							t,
							name .. "You have decided your fate. Now you must become a citizen here.",
							name .. "Go see Chi-Fu near the Palace in the Hon Administration Building.",
							name .. "He can be found at (15,37) in Hon by the Sea!"
						},
						1
					)
					player:msg(4, "[Become a Citizen of Hon] Apply to become a citizenship at (15, 37) Hon by the Sea.", player.ID)
				elseif menu == "Your First Job" and quest == 1 then
					-- Sewer Bandits ------------------------------------------------------------------------------------------------------------------------------------------------------------
					player:dialogSeq(
						{
							t,
							name .. "So you just became a wizard, and you think you are ready for a job?",
							name .. "I think I have just the thing for you.",
							name ..
								"We need you to run on into the sewers and see why the rats are leaving. Someone must be down there to have stirred them up..",
							name .. "If you find someone down there, find out who they are, and why they are there..",
							name ..
								"Unless you think this job is not good enough for you. You can find entrances to the sewers all over the city.",
							name .. "Go investigate and report back to me with whatever you find."
						},
						1
					)
					player.quest["wizard_path"] = 2
					player:msg(4, "[Quest Started] Search the sewers for bandits ", player.ID)
				elseif menu == "Sewer Bandits" and quest == 2 then
					-- About those sewer bandits ------------------------------------------------------------------------------------------------------------------------------------------------------------
					player:dialogSeq(
						{t, name .. "If you find this task too tough, you might not be cut out for the arts of Magic.."},
						1
					)
				elseif menu == "About those sewer bandits..." and quest == 3 then
					--The Earthworks ------------------------------------------------------------------------------------------------------------------------------------------------------------
					player:dialogSeq(
						{
							t,
							name .. "A cave full of snakes? He must have been talking about the Earthworks!",
							name .. "It's a cave located near Hon's South Gate. It was once going to be dug out and built over",
							name ..
								"Then the snakes showed up. Now it's a deserted mudhole. I thought the only person stupid enough to go in there anymore was the War Thog.",
							name ..
								"If the bandits have moved in too, they must have made a deal with him. Tread lightly, the War Thog has slain far better wizards than you.",
							name ..
								"We need to know how many there are down there. If you do find the War Thog, tell him Delta sent you. It might be the only way you leave alive.",
							b,
							"The guild leader gives you  piece of equipment! Press 'i' to see!"
						},
						1
					)
					player.quest["wizard_path"] = 4
					player:addItem(18701, 1)
					giveXP(player, 100)
					player:addGold(250)
					finishedQuest(player)
					player:calcStat()
					player:sendStatus()
					player:msg(4, "[Quest Updated] Head to the Earthworks above South Gate and find War Thog!", player.ID)
				elseif menu == "The Earthworks" and quest == 4 then
					-- The war Thog's offer ------------------------------------------------------------------------------------------------------------------------------------------------------------
					player:dialogSeq({anything, "What, are you afraid of a few snakes? Get to that cave and kill those traitors!"}, 1)
				elseif menu == "The War Thog's Offer" and quest == 5 then
					-- Path Quest Leech Lord ----------------------------------------------------------------------------------------------------------------------------------------------------------
					player:dialogSeq(
						{
							t,
							name .. "Oh great, so War Thog has a small army now?.",
							name .. "And he had a SON? So his son is going to be leading them now?",
							name .. "Well, as long as Delta can keep them in check, they can live in whatever muddy snakehole they want."
						},
						1
					)
					player.quest["wizard_path"] = 6
					giveXP(player, 1500)
					player:addGold(1500)
					finishedQuest(player)
					player:calcStat()
					player:sendStatus()
					player:addLegend("Survived an encounter with The War Thog " .. curT(), "war_thog", 1, 71)
					player:msg(4, "[Quest Completed] A Legend Mark is obtained. On to the next mission.", player.ID)
				elseif menu == "The Next Mission" then
					player:dialogSeq(
						{
							t,
							name .. "Venture into the Leech Cave.",
							name .. "There are entrances near the North Gate and in the Southern Shores of Hon.",
							name .. "Inside, slay the leeches and their lord.",
							name .. "Once the Leech Lord is dead, return to me with 100 Leech Ooze."
						},
						1
					)
					player.quest["leech_lord"] = 1
					player:flushKills(1065)
					player:msg(4, "[Quest Started] Slay the Leech Lord and gather 100 Leech Ooze!", player.ID)
				elseif menu == "Leech Cave" then
					if player:killCount(1065) >= 1 then
						if player:hasItem("leech_ooze", 100) == true then
							if player:removeItem("leech_ooze", 100) == true then
								player.quest["leech_lord"] = 2
								giveXP(player, 750000)
								player:addGold(25000)
								finishedQuest(player)
								player:calcStat()
								player:sendStatus()
								player:addLegend("Wizard Guild Rank: Apprentice " .. curT(), "guild_rank", 11, 12)
								broadcast(-1, "[TITLE]: " .. player.name .. " has just earned the title 'Apprentice'!")
								player:msg(4, "[Quest Completed] You increased your Guild Rank!", player.ID)
							else
								player:dialogSeq({t, name .. "Where is the Leech Ooze I asked for?"}, 1)
							end
						else
							player:dialogSeq({t, name .. "Where is the Leech Ooze I asked for?"}, 1)
						end
					else
						player:dialogSeq({t, name .. "Why haven't you slain the Leech Lord yet?"}, 1)
					end
				end
			else
				player:dialogSeq({t, name .. "Do not make me turn you into a cat. You do not belong here."})
			end
		end
	),
	learnspell = function(player, npc)
		local name = "<b>[" .. npc.name .. "]\n\n"
		local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		player.lastClick = npc.ID

		local you = player.level
		local job = player.class
		local quest = player.quest["wizard_path"]
		local opts = {}
		local opts2 = {}
		local element

		if player.registry["wizard_element_choice"] == 0 then
			player:dialogSeq(
				{
					t,
					name .. "Oh boy, another one...",
					name .. "Let me explain the most important decision of your life.",
					name .. "If you do not pay attention to what I say, do not cry.",
					name .. "This decision is final. If you cannot be happy with your choice, die now and get it over with.",
					name .. "The three choices are as follows: Ice, Fire or Lightning.",
					name .. "Ice wizards specialize in slowing down their opponents movement and attack speed.",
					name .. "Fire wizards specialize in, well, setting their opponents on fire, letting them burn over time.",
					name .. "Lightning wizards specialize in shocking their enemies into a catatonic state.",
					name .. "So, what kind of wizard are you? Speak clearly, for you don't want me to mishear.",
					name .. "**THIS DECISION CAN NOT BE REVERSED, CHANGED OR UNDONE. IT IS FOR FOREVER AND ALL TIME**",
					name .. "**IF YOU ARE NOT READY TO MAKE THIS DECISION, CANCEL NOW AND SEEK ASSISTANCE**"
				},
				1
			)
			element =
				string.lower(
				tostring(
					player:input(
						"Which element would you like to specialize in? ((Type 'ice', 'fire', or 'lightning' with no quotes))"
					)
				)
			)

			if element == "ice" then
				player.registry["wizard_element_choice"] = 1
				player:dialogSeq(
					{t, name .. "Excellent, you have chosen to be an Ice Wizard! Speak to Deaupuo for instruction in the ways of Ice."},
					1
				)
			elseif element == "fire" then
				player.registry["wizard_element_choice"] = 2
				player:dialogSeq(
					{
						t,
						name .. "Excellent, you have chosen to be a Fire Wizard! Speak to Deaupuo for instruction in the ways of Fire."
					},
					1
				)
			elseif element == "lightning" then
				player.registry["wizard_element_choice"] = 3
				player:dialogSeq(
					{
						t,
						name ..
							"Excellent, you have chosen to be a Lightning Wizard! Speak to Deaupuo for instruction in the ways of Lightning."
					},
					1
				)
			else
				player:dialogSeq(
					{t, name .. "That wasn't an option. Come back when you are ready to treat the Art with the respect it deserves."},
					1
				)
			end
			return
		end

		player:learnSpell(npc)
	end,
	nextSpell = function(player, npc)
		local name = "<b>[" .. npc.name .. "]\n\n"
		local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		player.lastClick = npc.ID

		local spells = {}
		local you = player.level
		local level = 0

		if you >= 5 and you <= 9 then
			table.insert(spells, "Rest Lv1")
			level = 10
		end
		if you >= 10 and you <= 19 then
			table.insert(spells, "Apprentice Heal")
			level = 20
		end
		if you >= 20 and you <= 24 then
			table.insert(spells, "Flashbang")
			level = 25
		end
		if you >= 25 and you <= 34 then
			table.insert(spells, "Remove Petrify")
			level = 35
		end
		if you >= 35 and you <= 49 then
			table.insert(spells, "Rest Lv2")
			level = 50
		end
		if you >= 70 and you <= 74 then
			table.insert(spells, "Blink")
			level = 75
		end
		if you >= 75 and you <= 79 then
			table.insert(spells, "Magus Heal")
			level = 80
		end
		if you >= 95 and you <= 98 then
			table.insert(spells, "Rest Lv3")
			level = 99
		end
		if you >= 95 and you <= 98 then
			table.insert(spells, "Rain of the Nether")
			level = 99
		end

		menu = player:menuString(name .. "These are the spells that your future holds", spells)

		if menu == "Rest Lv1" then
			player:dialog(name .. "You are not ready to learn this secret. Return when you are level " .. level, t)
		elseif menu == "Apprentice Heal" then
			player:dialog(name .. "You are not ready to learn this secret. Return when you are level " .. level, t)
		elseif menu == "Flashbang" then
			player:dialog(name .. "You are not ready to learn this secret. Return when you are level " .. level, t)
		elseif menu == "Remove Petrify" then
			player:dialog(name .. "You are not ready to learn this secret. Return when you are level " .. level, t)
		elseif menu == "Rest Lv2" then
			player:dialog(name .. "You are not ready to learn this secret. Return when you are level " .. level, t)
		elseif menu == "Blink" then
			player:dialog(name .. "You are not ready to learn this secret. Return when you are level " .. level, t)
		elseif menu == "Magus Heal" then
			player:dialog(name .. "You are not ready to learn this secret. Return when you are level " .. level, t)
		elseif menu == "Rest Lv3" then
			player:dialog(name .. "You are not ready to learn this secret. Return when you are level " .. level, t)
		elseif menu == "Rain of the Nether" then
			player:dialog(name .. "You are not ready to learn this secret. Return when you are level " .. level, t)
		end
	end,
	nearbyPlayers = function(npc)
		local pc = npc:getObjectsInArea(BL_PC)
		local m, x, y = npc.m, npc.x, npc.y

		if #pc > 0 then
			for i = 1, #pc do
				if pc[i].quest["wizard_path"] == 1 or pc[i].quest["wizard_path"] == 3 or pc[i].quest["wizard_path"] == 5 then
					pc[i]:selfAnimationXY(pc[i].ID, 248, x, y)
				elseif pc[i].quest["wizard_path"] == 6 and pc[i].level >= 40 and pc[i].quest["leech_lord"] == 0 then
					pc[i]:selfAnimationXY(pc[i].ID, 248, x, y)
				end
			end
		end
	end
}
