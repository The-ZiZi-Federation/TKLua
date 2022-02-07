-- Hon by the Sea Jamlamin
fighter_trainer = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local b = {graphic = convertGraphic(2059, "item"), color = 11}

			local quest1 = player.quest["fighter_path"]
			local opts = {}
			local opts2 = {}
			local you = player.level
			local job = player.class

			-- Class 0 ----------------------------------------------------------------------------------------------------------------------------------------------------------
			if player.class == 0 then
				-- Class 2 ----------------------------------------------------------------------------------------------------------------------------------------------------------
				if player.level >= 5 and player.quest["fighter_path"] == 0 then
					menu = player:menuString(name .. "So you wish to join the fighter's guild?", {"Yes!", "No..."})
					if menu == "Yes!" then
						armorchoice =
							player:menuString(name .. "What style of armor do you prefer?", {"Chainmail (Offense)", "Platemail (Defense)"})
						if armorchoice == "Chainmail (Offense)" then
							if player.sex == 0 then
								player:addItem(16101, 1)
							end
							if player.sex == 1 then
								player:addItem(16119, 1)
							end
						elseif armorchoice == "Platemail (Defense)" then
							if player.sex == 0 then
								player:addItem(16102, 1)
							end
							if player.sex == 1 then
								player:addItem(16120, 1)
							end
						end
						player.quest["fighter_path"] = 1
						player.class = 1
						player:addItem(16001, 1)
						player:addItem("small_vita_potion", 3)
						player:addItem("small_mana_potion", 3)
						player:addGold(150)
						finishedQuest(player)
						player:sendStatus()
						player:addLegend("Is no longer a common peasant! " .. curT(), "path", 8, 80)
						player:msg(4, "A Legend Mark is obtained. Now the real trial begins!", player.ID)
						player:sendMinitext("You are now a fighter!")
					elseif menu == "No..." then
						player:warp(1003, 128, 25)
						player:dialogSeq({t, name .. "Then get out of here!"}, 1)
					end
				end
				return
			elseif player.class == 1 then
				table.insert(opts2, "Learn Spell") --needs to be "Learn Spell"
				table.insert(opts2, "Forget Spell")
				table.insert(opts2, "Future Spells")
				--table.insert(opts2, "What is my next spell?")

				if player.registry["citizen"] == 0 then
					table.insert(opts2, "Apply for Citizenship")
				end
				if quest1 == 1 then
					table.insert(opts2, "Your First Job")
				end
				if quest1 == 2 then
					table.insert(opts2, "Sewer Bandits")
				end
				if quest1 == 3 then
					table.insert(opts2, "About those sewer bandits...")
				end
				if quest1 == 4 then
					table.insert(opts2, "The Earthworks")
				end
				if quest1 == 5 then
					table.insert(opts2, "The War Thog's Offer")
				end
				if quest1 == 6 and player.level >= 40 and player.quest["leech_lord"] == 0 then
					table.insert(opts2, "The Next Mission")
				end
				if player.quest["leech_lord"] == 1 then
					table.insert(opts2, "Leech Cave")
				end

				menu = player:menuString(name .. "Why are you bothering me?", opts2)

				-- Learn Spell ----------------------------------------------------------------------------------------------------------------------------------------------------------
				if menu == "Learn Spell" then
					fighter_trainer.learnspell(player, npc)
				elseif menu == "Forget Spell" then
					player:forgetSpell()
				elseif menu == "Future Spells" then
					-- Next Spell -----------------------------------------------------------------------------------------------------------------------------------------------------------
					player:futureSpells(npc)
				elseif menu == "What is my next spell?" then
					-- Apply for Citizenship ------------------------------------------------------------------------------------------------------------------------------------------------
					fighter_trainer.nextSpell(player, npc)
				elseif menu == "Apply for Citizenship" then
					-- Your First Job -------------------------------------------------------------------------------------------------------------------------------------------------------
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
				elseif menu == "Your First Job" and quest1 == 1 then
					-- Sewer Bandits ------------------------------------------------------------------------------------------------------------------------------------------------------------
					player:dialogSeq(
						{
							t,
							name .. "One of our guards noticed a bandit creeping into the sewers last night.",
							name .. "Hon by the Sea is plagued with Scoundrels, Bandits, and Thieves.",
							name ..
								"Some of our own guards might be on the take. We know the bandits are entering the sewers somewhere near the south gate.",
							name .. "I need you to go see who you may find in the Deep Sewers.",
							name .. "Last I heard, there was a Scoundrel guild using the sewers to get in and out of the city with goods.",
							name .. "Go investigate and report back to me with whatever you find."
						},
						1
					)
					player.quest["fighter_path"] = 2
					player:msg(4, "[Quest Started] Search the sewers for bandits", player.ID)
				elseif menu == "Sewer Bandits" and quest1 == 2 then
					-- About those sewer bandits ------------------------------------------------------------------------------------------------------------------------------------------------------------
					player:dialogSeq(
						{t, name .. "What are you waiting for? Get to work! We do not have anyone else to spare right now."},
						1
					)
				elseif menu == "About those sewer bandits..." and quest1 == 3 then
					--The Earthworks ------------------------------------------------------------------------------------------------------------------------------------------------------------
					player:dialogSeq(
						{
							t,
							name .. "A cave full of snakes? He must have been talking about the Earthworks!",
							name .. "It's a cave located near Hon's South Gate. It was once going to be dug out and built over",
							name ..
								"Then the snakes showed up. Now it's a deserted mudhole. I thought the only person stupid enough to go in there anymore was the War Thog.",
							name ..
								"If the bandits have moved in too, they must have made a deal with him. Tread lightly, the War Thog has slain far better fighters than you.",
							name ..
								"Now, go enter the Earthworks and find out how many strong they are. If you run into War Thog, you are to tell him that we don't want these bandits running around our city.",
							b,
							"The guild leader gives you  piece of equipment! Press 'i' to see!"
						},
						1
					)
					player.quest["fighter_path"] = 4
					player:addItem(16701, 1)
					giveXP(player, 100)
					player:addGold(250)
					finishedQuest(player)
					player:calcStat()
					player:sendStatus()
					player:msg(4, "[Quest Updated] Head to the Earthworks above South Gate and find War Thog!", player.ID)
				elseif menu == "The Earthworks" and quest1 == 4 then
					-- The war Thog's offer ------------------------------------------------------------------------------------------------------------------------------------------------------------
					player:dialogSeq({t, name .. "What, are you afraid of a few snakes? Get to that cave and find those bandits!"}, 1)
				elseif menu == "The War Thog's Offer" and quest1 == 5 then
					-- Elseif not class 0 or 2 ----------------------------------------------------------------------------------------------------------------------------------------------------------
					player:dialogSeq(
						{
							t,
							name .. "Hah! So the bandits got beaten into servitude by the War Thog you say?",
							name .. "The War Thog had a kid too? WHAT!?! And his son is going to be leading them now?",
							name ..
								"Well, as long as they are not stealing from the locals anymore, they can live in whatever muddy snakehole they want."
						},
						1
					)
					player.quest["fighter_path"] = 6
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
								player:sendStatus()
								player:addLegend("Fighter Guild Rank: Brawler " .. curT(), "guild_rank", 9, 9)
								broadcast(-1, "[TITLE]: " .. player.name .. " has just earned the title 'Brawler'!")
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
				player:dialogSeq({t, name .. "What is your pupose here? Leave!!!"})
			end
		end
	),
	learnspell = function(player, npc)
		local name = "<b>[" .. npc.name .. "]\n\n"
		local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.lastClick = npc.ID
		player.dialogType = 0

		player:learnSpell(npc)
	end,
	nextSpell = function(player, npc)
		local name = "<b>[" .. npc.name .. "]\n\n"
		local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		player.lastClick = npc.ID

		local quest1 = player.quest["fighter_path"]
		local spells = {}
		local opts2 = {}
		local you = player.level
		local job = player.class
		local level = 0

		if you >= 5 and you <= 14 then
			table.insert(spells, "Second Wind")
			level = 15
		end
		if you >= 15 and you <= 19 then
			table.insert(spells, "Minor First Aid")
			level = 20
		end
		if you >= 20 and you <= 24 then
			table.insert(spells, "Combat Intuition")
			level = 25
		end
		if you >= 20 and you <= 24 then
			table.insert(spells, "Intimidate")
			level = 25
		end
		if you >= 25 and you <= 34 then
			table.insert(spells, "Provoke")
			level = 35
		end
		if you >= 35 and you <= 49 then
			table.insert(spells, "Combat Affinity")
			level = 50
		end
		if you >= 35 and you <= 49 then
			table.insert(spells, "Whirlwind Attack")
			level = 50
		end
		if you >= 50 and you <= 69 then
			table.insert(spells, "Cleave")
			level = 70
		end
		if you >= 70 and you <= 74 then
			table.insert(spells, "Combat Devotion")
			level = 75
		end
		if you >= 75 and you <= 79 then
			table.insert(spells, "Advanced First Aid")
			level = 80
		end
		if you >= 80 and you <= 84 then
			table.insert(spells, "Pommel Strike")
			level = 85
		end
		if you >= 85 and you <= 94 then
			table.insert(spells, "Battle Stance")
			level = 95
		end
		if you >= 95 and you <= 98 then
			table.insert(spells, "Combat Trance")
			level = 99
		end
		if you >= 95 and you <= 98 then
			table.insert(spells, "Room Provoke")
			level = 99
		end
		if you >= 95 and you <= 98 then
			table.insert(spells, "Great Cleave")
			level = 99
		end

		menu = player:menuString(name .. "These are the spells that your future holds", spells)

		if menu == "Second Wind" then
			player:dialog(name .. "You are not ready to learn this secret. Return when you are level " .. level, t)
		elseif menu == "Minor First Aid" then
			player:dialog(name .. "You are not ready to learn this secret. Return when you are level " .. level, t)
		elseif menu == "Combat Intuition" then
			player:dialog(name .. "You are not ready to learn this secret. Return when you are level " .. level, t)
		elseif menu == "Intimidate" then
			player:dialog(name .. "You are not ready to learn this secret. Return when you are level " .. level, t)
		elseif menu == "Provoke" then
			player:dialog(name .. "You are not ready to learn this secret. Return when you are level " .. level, t)
		elseif menu == "Combat Affinity" then
			player:dialog(name .. "You are not ready to learn this secret. Return when you are level " .. level, t)
		elseif menu == "Whirlwind Attack" then
			player:dialog(name .. "You are not ready to learn this secret. Return when you are level " .. level, t)
		elseif menu == "Cleave" then
			player:dialog(name .. "You are not ready to learn this secret. Return when you are level " .. level, t)
		elseif menu == "Combat Devotion" then
			player:dialog(name .. "You are not ready to learn this secret. Return when you are level " .. level, t)
		elseif menu == "Advanced First Aid" then
			player:dialog(name .. "You are not ready to learn this secret. Return when you are level " .. level, t)
		elseif menu == "Pommel Strike" then
			player:dialog(name .. "You are not ready to learn this secret. Return when you are level " .. level, t)
		elseif menu == "Battle Stance" then
			player:dialog(name .. "You are not ready to learn this secret. Return when you are level " .. level, t)
		elseif menu == "Combat Trance" then
			player:dialog(name .. "You are not ready to learn this secret. Return when you are level " .. level, t)
		elseif menu == "Room Provoke" then
			player:dialog(name .. "You are not ready to learn this secret. Return when you are level " .. level, t)
		elseif menu == "Great Cleave" then
			player:dialog(name .. "You are not ready to learn this secret. Return when you are level " .. level, t)
		end
	end,
	nearbyPlayers = function(npc)
		local pc = npc:getObjectsInArea(BL_PC)
		local m, x, y = npc.m, npc.x, npc.y

		if #pc > 0 then
			for i = 1, #pc do
				if pc[i].quest["fighter_path"] == 1 or pc[i].quest["fighter_path"] == 3 or pc[i].quest["fighter_path"] == 5 then
					pc[i]:selfAnimationXY(pc[i].ID, 248, x, y)
				elseif pc[i].quest["fighter_path"] == 6 and pc[i].level >= 40 and pc[i].quest["leech_lord"] == 0 then
					pc[i]:selfAnimationXY(pc[i].ID, 248, x, y)
				end
			end
		end
	end
}
