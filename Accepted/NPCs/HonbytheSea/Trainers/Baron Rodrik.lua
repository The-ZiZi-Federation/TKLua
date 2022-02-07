-- Baron Rodrik the Scoundrel Trainer of Hon by the Sea
scoundrel_trainer = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local b = {graphic = convertGraphic(3079, "item"), color = 22}
			local g = {graphic = convertGraphic(2490, "item"), color = 130}

			local you = player.level
			local job = player.class
			local quest = player.quest["scoundrel_path"]
			local opts = {}
			local opts2 = {}

			-- Class 0 ----------------------------------------------------------------------------------------------------------------------------------------------------------
			if player.class == 0 then
				-- Class 2 ----------------------------------------------------------------------------------------------------------------------------------------------------------
				if player.level >= 5 and player.quest["scoundrel_path"] == 0 then
					menu = player:menuString(name .. "So you wish to join the scoundrel's guild?", {"Yes!", "No..."})
					if menu == "Yes!" then
						armorchoice =
							player:menuString(name .. "What style of armor do you prefer?", {"Tunic (Offense)", "Leathers (Defense)"})
						if armorchoice == "Tunic (Offense)" then
							if player.sex == 0 then
								player:addItem(17101, 1)
							end
							if player.sex == 1 then
								player:addItem(17119, 1)
							end
						elseif armorchoice == "Leathers (Defense)" then
							if player.sex == 0 then
								player:addItem(17102, 1)
							end
							if player.sex == 1 then
								player:addItem(17120, 1)
							end
						end
						player.quest["scoundrel_path"] = 1
						player.class = 2
						finishedQuest(player)
						player:addItem(17001, 1)
						player:addItem("small_vita_potion", 3)
						player:addItem("small_mana_potion", 3)
						player:addGold(150)
						player:calcStat()
						player:sendStatus()
						player:addLegend("Is no longer a common peasant! " .. curT(), "path", 8, 80)
						player:msg(4, "A Legend Mark is obtained. Now the real trial begins!", player.ID)
						player:sendMinitext("You are now a scoundrel!")
					elseif menu == "No..." then
						player:warp(1003, 128, 25)
						player:dialogSeq({t, name .. "Then get out of here!"}, 1)
					end
				end
				return
			elseif player.class == 2 then
				-- Elseif not class 0 or 2 ----------------------------------------------------------------------------------------------------------------------------------------------------------
				table.insert(opts2, "Learn Spell") --needs to be "Learn Spell"
				table.insert(opts2, "Forget Spell")
				table.insert(opts2, "Future Spells")
				--table.insert(opts2, "What is my next spell?")

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
					scoundrel_trainer.learnspell(player, npc)
				elseif menu == "Forget Spell" then
					player:forgetSpell()
				elseif menu == "Future Spells" then
					-- Next Spell ------------------------------------------------------------------------------------------------------------------------------------------------------------
					player:futureSpells(npc)
				elseif menu == "What is my next spell?" then
					-- Apply for Citizenship ------------------------------------------------------------------------------------------------------------------------------------------------
					scoundrel_trainer.nextSpell(player, npc)
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
							name .. "So you're eager to start putting in work for the guild?",
							name .. "I think I have just the thing for you.",
							name ..
								"Some... let's say 'former members' are still operating out of Hon, while refusing to pay the guild our dues.",
							name .. "I need you to go send them a message for me. Let these traitors see how we deal with disloyalty.",
							name ..
								"Last I heard, their group was operating out of the deep sewers in the Hon Underground. There are entrances all over the city.",
							name .. "Go investigate and report back to me with whatever you find."
						},
						1
					)
					player.quest["scoundrel_path"] = 2
					player:msg(4, "[Quest Started] Search the sewers for bandits ", player.ID)
				elseif menu == "Sewer Bandits" and quest == 2 then
					-- About those sewer bandits ------------------------------------------------------------------------------------------------------------------------------------------------------------
					player:dialogSeq(
						{t, name .. "What are you waiting for? Get to work! Scour the sewers until you find those rogues."},
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
								"If the bandits have moved in too, they must have made a deal with him. Tread lightly, the War Thog has slain far better scoundrels than you.",
							b,
							"The guild leader gives you  piece of equipment! Press 'i' to see!"
						},
						1
					)
					player.quest["scoundrel_path"] = 4
					player:addItem(17701, 1)
					giveXP(player, 100)
					player:addGold(250)
					finishedQuest(player)
					player:calcStat()
					player:sendStatus()
					player:msg(4, "[Quest Updated] Head to the Earthworks above South Gate and find War Thog!", player.ID)
				elseif menu == "The Earthworks" and quest == 4 then
					-- The war Thog's offer ------------------------------------------------------------------------------------------------------------------------------------------------------------
					player:dialogSeq({t, name .. "What, are you afraid of a few snakes? Get to that cave and kill those traitors!"}, 1)
				elseif menu == "The War Thog's Offer" and quest == 5 then
					player:dialogSeq(
						{
							t,
							name .. "Hah! I knew those traitors would never stand up to the War Thog.",
							name .. "So his son is going to be leading them now?",
							name .. "Well, as long as they pay their dues, they can live in whatever muddy snakehole they want."
						},
						1
					)
					player.quest["scoundrel_path"] = 6
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
								player:addLegend("Scoundrel Guild Rank:  Prowler " .. curT(), "guild_rank", 10, 15)
								broadcast(-1, "[TITLE]: " .. player.name .. " has just earned the title 'Prowler'!")
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
				if player.quest["scoundrel_favor"] == 1 and player.quest["pickup_rodriks_money"] == 0 then
					player.quest["pickup_rodriks_money"] = 1
					player:addItem("rodriks_money", 1)
					player:msg(4, "[Quest Updated] You got the money Rodrik owes!", player.ID)
					player:dialogSeq(
						{
							t,
							name .. "Fine, take the money!",
							name .. "Just tell those scary bastards in Cathay to leave me alone!"
						}
					)
				else
					player:dialogSeq({t, name .. "I won't be talking to you! Go away!!"})
				end
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
		local job = player.baseClass
		local quest = player.quest["scoundrel_path"]
		local opts = {}
		local opts2 = {}
		 --
		--[[	
	if (you >= 5 and you < 25) and job == 2 and quest >= 1 and player.registry["learned_combat_reflexes"] == 0 and player.registry["learned_combat_perception"] == 0 and player.registry["learned_combat_foresight"] == 0 and player.registry["learned_combat_clairvoyance"] == 0 and player.registry["learned_combat_premonition"] == 0 then table.insert(opts, "Combat Reflexes") end
	if you >= 5 and job == 2 and quest >= 1 and player.registry["learned_stab"] == 0 then table.insert(opts, "Stab") end
	
	if you >= 10 and job == 2 and quest >= 1 and player.registry["learned_ambush"] == 0 then table.insert(opts, "Ambush") end
	if you >= 10 and job == 2 and quest >= 1 and player.registry["learned_dodging_strike"] == 0 then table.insert(opts, "Dodging Strike") end
	
	if (you >= 15 and you < 60) and job == 2 and quest >= 1 and player.registry["learned_evade"] == 0 then table.insert(opts, "Evade") end
	if you >= 15 and job == 2 and quest >= 1 and player.registry["learned_steal_essence"] == 0 then table.insert(opts, "Steal Essence") end

	if (you >= 20 and you < 80) and job == 2 and quest >= 1 and player.registry["learned_chew_dry_herbs"] == 0 and player.registry["herbal_stimulant"] == 0 then table.insert(opts, "Chew Dry Herbs") end
	
	if (you >= 25 and you < 50) and job == 2 and quest >= 1 and player.registry["learned_combat_perception"] == 0 and player.registry["learned_combat_foresight"] == 0 and player.registry["learned_combat_clairvoyance"] == 0 and player.registry["learned_combat_premonition"] == 0 then table.insert(opts, "Combat Perception") end
	if you >= 25 and job == 2 and quest >= 1 and player.registry["learned_tranq_dart"] == 0 then table.insert(opts, "Tranq Dart") end        	
	
	if (you >= 35 and you < 50) and job == 2 and quest >= 1 and player.registry["learned_flashing_blades"] == 0 and player.registry["learned_pierce_vitals"] == 0 and player.registry["learned_coup_de_grace"] == 0 then table.insert(opts, "Flashing Blades") end
	
	if you >= 42 and job == 2 and quest >= 1 and player.registry["learned_hide_in_shadows"] == 0 then table.insert(opts, "Hide in Shadows") end
	
	if (you >= 50 and you < 99) and job == 2 and quest >= 1 and player.registry["learned_pierce_vitals"] == 0 and player.registry["learned_coup_de_grace"] == 0 then table.insert(opts, "Pierce Vitals") end
	if (you >= 50 and you < 75) and job == 2 and quest >= 1 and player.registry["learned_combat_foresight"] == 0 and player.registry["learned_combat_clairvoyance"] == 0 and player.registry["learned_combat_premonition"] == 0 then table.insert(opts, "Combat Foresight") end      
	
	if you >= 60 and job == 2 and quest >= 1 and player.registry["learned_uncanny_dodge"] == 0 then table.insert(opts, "Uncanny Dodge") end
	
	if you >= 65 and job == 2 and quest >= 1 and player.registry["learned_explosive_charge"] == 0 then table.insert(opts, "Explosive Charge") end
	
	if you >= 75 and job == 2 and quest >= 1 and player.registry["learned_poisoned_shuriken"] == 0 then table.insert(opts, "Poisoned Shuriken") end
	if (you >= 75 and you < 99) and job == 2 and quest >= 1 and player.registry["learned_combat_clairvoyance"] == 0 and player.registry["learned_combat_premonition"] == 0 then table.insert(opts, "Combat Clairvoyance") end
	
	if you >= 80 and job == 2 and quest >= 1 and player.registry["learned_herbal_stimulant"] == 0 then table.insert(opts, "Herbal Stimulant") end
	
	if you >= 90 and job == 2 and quest >= 1 and player.registry["learned_flurry_of_knives"] == 0 then table.insert(opts, "Flurry of Knives") end
	
	if you >= 99 and job == 2 and quest >= 1 and player.registry["learned_combat_premonition"] == 0 then table.insert(opts, "Combat Premonition") end
	if you >= 99 and job == 2 and quest >= 1 and player.registry["learned_coup_de_grace"] == 0 then table.insert(opts, "Coup De Grace") end
]] player:learnSpell(
			npc
		)
		--[[
	menu = player:menuString(name.."I am the Training Master around here. You want to learn, you get strong and you pay me.", opts)

	if menu == "Learn Combat Reflexes" then
		player:dialogSeq({t, name.."Combat Reflexes is a spell that increases your damage and lets your attacks cause bleeding wounds. First enhancement."}, 1)
		confirm = player:menuString(name.."Do you wish to learn Combat Reflexes? This spell is free", {"Yes", "No"})
		if confirm == "Yes" then
			if player:removeGold(0) == false then
				player:dialogSeq({t, name.."I do not have time to train you for free!"}, 1)
			return else
				player:addSpell("combat_reflexes")
				player.registry["learned_combat_reflexes"] = 1
				player:sendMinitext("You learned Combat Reflexes!")
				scoundrel_trainer.learnspell(player, npc)
			end
		end

	elseif menu == "Learn Stab" then
		player:dialogSeq({t, name.."If you can not Stab your enemy. You will be the one being Stabbed."}, 1)
		confirm = player:menuString(name.."Do you wish to learn Steal Magic? I will personally teach you this skill!", {"Yes", "No"})
		if confirm == "Yes" then
			if player:removeGold(0) == false then
				player:dialogSeq({t, name.."I do not have time to train you for free!"}, 1)
			return else
				player:addSpell("stab")
				player.registry["learned_stab"] = 1
				player:sendMinitext("You learned Stab!")
				scoundrel_trainer.learnspell(player, npc)
			end
		end	
		
	elseif menu == "Learn Steal Essence" then
		player:dialogSeq({t, name.."So you think you're a thief? Steal Essence will allow you to steal an enemy's life and magical energy and use it for yourself. Impressive, huh?"}, 1)
		confirm = player:menuString(name.."Do you wish to learn Steal Essence? This spell costs 1500 coins", {"Yes", "No"})
		if confirm == "Yes" then
			if player:removeGold(1500) == false then
				player:dialogSeq({t, name.."I do not have time to train you for free!"}, 1)
			return else
				player:addSpell("steal_essence")
				player.registry["learned_steal_essence"] = 1
				player:sendMinitext("You learned Steal Essence!")
				scoundrel_trainer.learnspell(player, npc)
			end
		end

	elseif menu == "Learn Chew Dry Herbs" then
		player:dialogSeq({t, name.."Chew Dry Herbs restores a moderate amount of health"}, 1)
		confirm = player:menuString(name.."Do you wish to learn Chew Dry Herbs? This spell costs 1000 coins", {"Yes", "No"})
		if confirm == "Yes" then
			if player:removeGold(1000) == false then
				player:dialogSeq({t, name.."I do not have time to train you for free!"}, 1)
			return else
				player:addSpell("chew_dry_herbs")
				player.registry["learned_chew_dry_herbs"] = 1
				player:sendMinitext("You learned Chew Dry Herbs!")
				player:removeSpell("basic_first_aid")
				player.registry["learned_basic_first_aid"] = 0
				scoundrel_trainer.learnspell(player, npc)
			end
		end

	elseif menu == "Learn Ocular Patdown" then
		player:dialogSeq({t, name.."Ocular Patdown is a spell that allows you to assess the situation to clear an individual for passage. You might learn something too."}, 1)
		confirm = player:menuString(name.."Do you wish to learn Ocular Patdown? This spell costs 5000 coins", {"Yes", "No"})
		if confirm == "Yes" then
			if player:removeGold(5000) == false then
				player:dialogSeq({t, name.."I do not have time to train you for free!"}, 1)
			return else
				player:addSpell("ocular_patdown")
				player.registry["learned_ocular_patdown"] = 1
				player:sendMinitext("You learned Ocular Patdown!")
				scoundrel_trainer.learnspell(player, npc)
			end
		end

	elseif menu == "Learn Tranq Dart" then
		player:dialogSeq({t, name.."Tranq Dart tranquilizes a target to give you an opening"}, 1)
		confirm = player:menuString(name.."Do you wish to learn Tranq Dart? This spell costs 5000 coins", {"Yes", "No"})
		if confirm == "Yes" then
			if player:removeGold(5000) == false then
				player:dialogSeq({t, name.."I do not have time to train you for free!"}, 1)
			return else
				player:addSpell("tranq_dart")
				player.registry["learned_tranq_dart"] = 1
				player:sendMinitext("You learned Tranq Dart!")
				scoundrel_trainer.learnspell(player, npc)
			end
		end

	elseif menu == "Learn Combat Perception" then
		player:dialogSeq({t, name.."Combat Perception is a spell that increases damage. Replacing Combat Reflexes."}, 1)
		confirm = player:menuString(name.."Do you wish to learn Combat Perception? This spell costs 5000 coins", {"Yes", "No"})
		if confirm == "Yes" then
			if player:removeGold(5000) == false then
				player:dialogSeq({t, name.."I do not have time to train you for free!"}, 1)
			return else
				player:addSpell("combat_perception")
				player.registry["learned_combat_perception"] = 1
				player:sendMinitext("You learned Combat Perception!")
				player:removeSpell("combat_reflexes")
				player.registry["learned_combat_reflexes"] = 0
				scoundrel_trainer.learnspell(player, npc)
			end
		end			
				
	elseif menu == "Learn Flashing Blades" then
		player:dialogSeq({t, name.."Flashing Blades is a series of quick strikes at an opponents vitals"}, 1)
		confirm = player:menuString(name.."Do you wish to learn Flashing Blades? This spell costs 7500 coins", {"Yes", "No"})
		if confirm == "Yes" then
			if player:removeGold(7500) == false then
				player:dialogSeq({t, name.."I do not have time to train you for free!"}, 1)
			return else
				player:addSpell("flashing_blades")
				player.registry["learned_flashing_blades"] = 1
				player:sendMinitext("You learned Flashing Blades!")
				scoundrel_trainer.learnspell(player, npc)
			end
		end
		
	elseif menu == "Learn Flurry of Knives" then
		player:dialogSeq({t, name.."Flurry of Knives unleashes a storm of steel around around you, causing massive bleeding wounds."}, 1)
		confirm = player:menuString(name.."Do you wish to learn Flurry of Knives? This spell costs 7500 coins", {"Yes", "No"})
		if confirm == "Yes" then
			if player:removeGold(7500) == false then
				player:dialogSeq({t, name.."I do not have time to train you for free!"}, 1)
			return else
				player:addSpell("flurry_of_knives")
				player.registry["learned_flurry_of_knives"] = 1
				player:sendMinitext("You learned Flurry of Knives!")
				scoundrel_trainer.learnspell(player, npc)
			end
		end
		
	elseif menu == "Learn Explosive Charge" then
		player:dialogSeq({t, name.."This is a spell to set an explosive on the ground with a 2 second fuse."}, 1)
		confirm = player:menuString(name.."Do you wish to learn Explosive Charge? This spell costs 7500 coins", {"Yes", "No"})
		if confirm == "Yes" then
			if player:removeGold(7500) == false then
				player:dialogSeq({t, name.."I do not have time to train you for free!"}, 1)
			return else
				player:addSpell("explosive_charge")
				player.registry["learned_explosive_charge"] = 1
				player:sendMinitext("You learned Explosive Charge!")
				scoundrel_trainer.learnspell(player, npc)
			end
		end

	elseif menu == "Learn Hide in Shadows" then
		player:dialogSeq({t, name.."Hide in Shadows is a spell that allows you to hide from sight for a good amount of time unnoticed."}, 1)
		confirm = player:menuString(name.."Do you wish to learn Hide in Shadows? This spell costs 6000 coins", {"Yes", "No"})
		if confirm == "Yes" then
			if player:removeGold(6000) == false then
				player:dialogSeq({t, name.."I do not have time to train you for free!"}, 1)
			return else
				player:addSpell("hide_in_shadows")
				player.registry["learned_hide_in_shadows"] = 1
				player:sendMinitext("You learned Hide in Shadows!")
				scoundrel_trainer.learnspell(player, npc)
			end
		end

	elseif menu == "Learn Pierce Vitals" then
		player:dialogSeq({t, name.."Pierce Vitals is a critical strike that is more effective on a stunned target"}, 1)
		confirm = player:menuString(name.."Do you wish to learn Pierce Vitals? This spell costs 10000 coins", {"Yes", "No"})
		if confirm == "Yes" then
			if player:removeGold(10000) == false then
				player:dialogSeq({t, name.."I do not have time to train you for free!"}, 1)
			return else
				player:addSpell("pierce_vitals")
				player.registry["learned_pierce_vitals"] = 1
				player:sendMinitext("You learned Pierce Vitals!")
				player:removeSpell("flashing_blades")
				player.registry["learned_flashing_blades"] = 0
				scoundrel_trainer.learnspell(player, npc)
			end
		end            

	elseif menu == "Learn Combat Foresight" then
		player:dialogSeq({t, name.."Combat Foresight is a stronger version of Combat Perception"}, 1)
		confirm = player:menuString(name.."Do you wish to learn ? This spell costs 25000 coins", {"Yes", "No"})
		if confirm == "Yes" then
			if player:removeGold(25000) == false then
				player:dialogSeq({t, name.."I do not have time to train you for free!"}, 1)
			return else
				player:addSpell("combat_foresight")
				player.registry["learned_combat_foresight"] = 1
				player:sendMinitext("You learned Combat Foresight!")
				player:removeSpell("combat_perception")
				player.registry["learned_combat_perception"] = 0
				player:removeSpell("combat_reflexes")
				player.registry["learned_combat_reflexes"] = 0
				scoundrel_trainer.learnspell(player, npc)
			end
		end
				
	elseif menu == "Learn Poisoned Shuriken" then
		player:dialogSeq({t, name.."Throw Poisoned Shuriken to strike and stun up to 4 targets in a line."}, 1)
		confirm = player:menuString(name.."Do you wish to learn Poisoned Shuriken? This spell costs 35000 coins", {"Yes", "No"})
		if confirm == "Yes" then
			if player:removeGold(35000) == false then
				player:dialogSeq({t, name.."I do not have time to train you for free!"}, 1)
			return else
				player:addSpell("poisoned_shuriken")
				player.registry["learned_poisoned_shuriken"] = 1
				player:sendMinitext("You learned Poisoned Shuriken!")
				scoundrel_trainer.learnspell(player, npc)
			end
		end	

	elseif menu == "Learn Combat Clairvoyance" then
		player:dialogSeq({t, name.."Combat Clairvoyance is a stronger version of Combat Foresight"}, 1)
		confirm = player:menuString(name.."Do you wish to learn Combat Clairvoyance? This spell costs 75000 coins", {"Yes", "No"})
		if confirm == "Yes" then
			if player:removeGold(75000) == false then
				player:dialogSeq({t, name.."I do not have time to train you for free!"}, 1)
			return else
				player:addSpell("combat_clairvoyance")
				player.registry["learned_combat_clairvoyance"] = 1
				player:sendMinitext("You learned Combat Clairvoyance!")
				player:removeSpell("combat_perception")
				player.registry["learned_combat_perception"] = 0
				player:removeSpell("combat_reflexes")
				player.registry["learned_combat_reflexes"] = 0
				player:removeSpell("combat_foresight")
				player.registry["learned_combat_foresight"] = 0
				scoundrel_trainer.learnspell(player, npc)
			end
		end

	elseif menu == "Learn Herbal Stimulant" then
		player:dialogSeq({t, name.."Herbal Stimulant recovers a lot of health"}, 1)
		confirm = player:menuString(name.."Do you wish to learn Herbal Stimulant? This spell costs 100000 coins", {"Yes", "No"})
		if confirm == "Yes" then
			if player:removeGold(100000) == false then
				player:dialogSeq({t, name.."I do not have time to train you for free!"}, 1)
			return else
				player:addSpell("herbal_stimulant")
				player.registry["learned_herbal_stimulant"] = 1
				player:sendMinitext("You learned Herbal Stimulant!")
				player:removeSpell("basic_first_aid")
				player.registry["learned_basic_first_aid"] = 0
				player:removeSpell("chew_dry_herbs")
				player.registry["learned_chew_dry_herbs"] = 0
				scoundrel_trainer.learnspell(player, npc)
			end
		end            	

	elseif menu == "Learn Combat Premonition" then
		player:dialogSeq({t, name.."Combat Premonition is a stronger version of Combat Clairvoyance"}, 1)
		confirm = player:menuString(name.."Do you wish to learn Combat Premonition? This spell costs 250000 coins", {"Yes", "No"})
		if confirm == "Yes" then
			if player:removeGold(250000) == false then
				player:dialogSeq({t, name.."I do not have time to train you for free!"}, 1)
			return else
				player:addSpell("combat_premonition")
				player.registry["learned_combat_premonition"] = 1
				player:sendMinitext("You learned Combat Premonition!")
				player:removeSpell("combat_perception")
				player.registry["learned_combat_perception"] = 0
				player:removeSpell("combat_reflexes")
				player.registry["learned_combat_reflexes"] = 0
				player:removeSpell("combat_foresight")
				player.registry["learned_combat_foresight"] = 0
				player:removeSpell("combat_clairvoyance")
				player.registry["learned_combat_clairvoyance"] = 0
				scoundrel_trainer.learnspell(player, npc)
			end
		end            	

	elseif menu == "Learn Coup De Grace" then
		player:dialogSeq({t, name.."Coup De Grace is a powerful finishing blow for stunned opponets"}, 1)
		confirm = player:menuString(name.."Do you wish to learn Coup De Grace? This spell costs 150000 coins", {"Yes", "No"})
		if confirm == "Yes" then
			if player:removeGold(150000) == false then
				player:dialogSeq({t, name.."I do not have time to train you for free!"}, 1)
			return else
				player:addSpell("coup_de_grace")
				player.registry["learned_coup_de_grace"] = 1
				player:sendMinitext("You learned Coup De Grace!")
				player:removeSpell("flashing_blades")
				player.registry["learned_flashing_blades"] = 0
				player:removeSpell("pierce_vitals")
				player.registry["learned_pierce_vitals"] = 0
				scoundrel_trainer.learnspell(player, npc)
			end
		end
	end
	]]
	 --
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

		if you >= 5 and you <= 14 then
			table.insert(spells, "Steal Magic")
			level = 15
		end
		if you >= 15 and you <= 19 then
			table.insert(spells, "Chew Dry Herbs")
			level = 20
		end
		if you >= 20 and you <= 24 then
			table.insert(spells, "Combat Perception")
			level = 25
		end
		if you >= 20 and you <= 24 then
			table.insert(spells, "Ocular Patdown")
			level = 25
		end
		if you >= 20 and you <= 24 then
			table.insert(spells, "Tranq Dart")
			level = 25
		end
		if you >= 25 and you <= 34 then
			table.insert(spells, "Flashing Blades")
			level = 35
		end
		if you >= 35 and you <= 49 then
			table.insert(spells, "Combat Foresight")
			level = 50
		end
		if you >= 35 and you <= 49 then
			table.insert(spells, "Pierce Vitals")
			level = 50
		end
		if you >= 35 and you <= 49 then
			table.insert(spells, "Hide in Shadows")
			level = 50
		end
		if you >= 70 and you <= 74 then
			table.insert(spells, "Combat Clairvoyance")
			level = 75
		end
		if you >= 70 and you <= 74 then
			table.insert(spells, "Poisoned Shuriken")
			level = 75
		end
		if you >= 75 and you <= 79 then
			table.insert(spells, "Herbal Stimulant")
			level = 80
		end
		if you >= 95 and you <= 98 then
			table.insert(spells, "Coup de Grace")
			level = 99
		end
		if you >= 95 and you <= 98 then
			table.insert(spells, "Combat Premonition")
			level = 99
		end

		menu = player:menuString(name .. "These are the spells that your future holds", spells)

		if menu == "Steal Magic" then
			player:dialog(name .. "You are not ready to learn this secret. Return when you are level " .. level, t)
		elseif menu == "Chew Dry Herbs" then
			player:dialog(name .. "You are not ready to learn this secret. Return when you are level " .. level, t)
		elseif menu == "Combat Perception" then
			player:dialog(name .. "You are not ready to learn this secret. Return when you are level " .. level, t)
		elseif menu == "Ocular Patdown" then
			player:dialog(name .. "You are not ready to learn this secret. Return when you are level " .. level, t)
		elseif menu == "Tranq Dart" then
			player:dialog(name .. "You are not ready to learn this secret. Return when you are level " .. level, t)
		elseif menu == "Flashing Blades" then
			player:dialog(name .. "You are not ready to learn this secret. Return when you are level " .. level, t)
		elseif menu == "Combat Foresight" then
			player:dialog(name .. "You are not ready to learn this secret. Return when you are level " .. level, t)
		elseif menu == "Pierce Vitals" then
			player:dialog(name .. "You are not ready to learn this secret. Return when you are level " .. level, t)
		elseif menu == "Hide in Shadows" then
			player:dialog(name .. "You are not ready to learn this secret. Return when you are level " .. level, t)
		elseif menu == "Combat Clairvoyance" then
			player:dialog(name .. "You are not ready to learn this secret. Return when you are level " .. level, t)
		elseif menu == "Poisoned Shuriken" then
			player:dialog(name .. "You are not ready to learn this secret. Return when you are level " .. level, t)
		elseif menu == "Herbal Stimulant" then
			player:dialog(name .. "You are not ready to learn this secret. Return when you are level " .. level, t)
		elseif menu == "Coup de Grace" then
			player:dialog(name .. "You are not ready to learn this secret. Return when you are level " .. level, t)
		elseif menu == "Combat Premonition" then
			player:dialog(name .. "You are not ready to learn this secret. Return when you are level " .. level, t)
		end
	end,
	nearbyPlayers = function(npc)
		local pc = npc:getObjectsInArea(BL_PC)
		local m, x, y = npc.m, npc.x, npc.y

		if #pc > 0 then
			for i = 1, #pc do
				if pc[i].quest["scoundrel_path"] == 1 or pc[i].quest["scoundrel_path"] == 3 or pc[i].quest["scoundrel_path"] == 5 then
					pc[i]:selfAnimationXY(pc[i].ID, 248, x, y)
				elseif pc[i].quest["scoundrel_path"] == 6 and pc[i].level >= 40 and pc[i].quest["leech_lord"] == 0 then
					pc[i]:selfAnimationXY(pc[i].ID, 248, x, y)
				end
			end
		end
	end
}
