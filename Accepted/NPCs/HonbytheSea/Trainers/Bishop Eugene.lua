-- Hon by the Sea Bishop Eugene
priest_trainer = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local b = {graphic = convertGraphic(2058, "item"), color = 23}

			local quest = player.quest["priest_path"]
			local you = player.level
			local job = player.class
			local opts = {}
			local opts2 = {}

			-- Class 0 ----------------------------------------------------------------------------------------------------------------------------------------------------------
			if player.class == 0 then
				-- Class 2 ----------------------------------------------------------------------------------------------------------------------------------------------------------
				if player.level >= 5 and player.quest["priest_path"] == 0 then
					menu = player:menuString(name .. "So you wish to be a priest of ASAK?", {"Yes!", "No..."})
					if menu == "Yes!" then
						armorchoice = player:menuString(name .. "What style of armor do you prefer?", {"Hauberk (Armor)", "Hide (Magic)"})
						if armorchoice == "Hauberk (Armor)" then
							if player.sex == 0 then
								player:addItem(19101, 1)
							end
							if player.sex == 1 then
								player:addItem(19119, 1)
							end
						elseif armorchoice == "Hide (Magic)" then
							if player.sex == 0 then
								player:addItem(19102, 1)
							end
							if player.sex == 1 then
								player:addItem(19120, 1)
							end
						end
						player.quest["priest_path"] = 1
						player.class = 4
						player:addItem(19001, 1)
						player:addItem("small_vita_potion", 3)
						player:addItem("small_mana_potion", 3)
						player:addGold(150)
						finishedQuest(player)
						player:calcStat()
						player:sendStatus()
						player:addLegend("Is no longer a common peasant! " .. curT(), "path", 8, 80)
						player:msg(4, "A Legend Mark is obtained. Now the real trial begins!", player.ID)
						player:sendMinitext("You are now a priest!")
					elseif menu == "No..." then
						player:warp(1003, 128, 25)
						player:dialogSeq({t, name .. "Then get out of here!"}, 1)
					end
				end
				return
			elseif player.class == 4 then
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

				menu = player:menuString(name .. "May the Blessings of ASAK guide your path?", opts2)

				-- Learn Spell ------------------------------------------------------------------------------------------------------------------------------------------------------------
				if menu == "Learn Spell" then
					priest_trainer.learnspell(player, npc)
				elseif menu == "Forget Spell" then
					player:forgetSpell()
				elseif menu == "Future Spells" then
					-- Next Spell ------------------------------------------------------------------------------------------------------------------------------------------------------------
					player:futureSpells(npc)
				elseif menu == "What is my next spell?" then
					-- Apply for Citizenship ------------------------------------------------------------------------------------------------------------------------------------------------
					priest_trainer.nextSpell(player, npc)
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
							name .. "So you think you are ready for Missionry Work?",
							name .. "I think I have just the thing for you.",
							name .. "Some of the locals have noticed rats coming from the sewers.",
							name .. "There is also a rumor that some bandits have moved in to the Deep Sewers.",
							name .. "Last I heard, this group of bandits once tried taking on the War Thog.",
							name ..
								"Go check out the sewers, I only know one of the entrances, it is close to south gate, look behind a stand of trees for an entrance.",
							name .. "Go investigate and report back to me with whatever you find."
						},
						1
					)
					player.quest["priest_path"] = 2
					player:msg(4, "[Quest Started] Search the sewers for bandits ", player.ID)
				elseif menu == "Sewer Bandits" and quest == 2 then
					-- About those sewer bandits ------------------------------------------------------------------------------------------------------------------------------------------------------------
					player:dialogSeq(
						{
							t,
							name .. "What are you waiting for? Someone could get hurt. Let the All Seeing All Knowing GOD light your path.",
							name .. "Do not sit around here all day, you have work to do."
						},
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
								"Then the snakes showed up. Now it's a deserted mudhole. I thought the only person brave enough to go in there anymore was the War Thog.",
							name ..
								"If the bandits have moved in too, they must have made a deal with him. Tread lightly, the War Thog has slain far better priests than you.",
							name ..
								"If you find yourself face to face with War Thog, I suggest you offer him the blessing of ASAK and hope he is feeling merciful.",
							b,
							"The guild leader gives you  piece of equipment! Press 'i' to see!"
						},
						1
					)
					player.quest["priest_path"] = 4
					player:addItem(19701, 1)
					giveXP(player, 100)
					player:addGold(250)
					finishedQuest(player)
					player:calcStat()
					player:sendStatus()
					player:msg(4, "[Quest Updated] Head to the Earthworks above South Gate and find War Thog!", player.ID)
				elseif menu == "The Earthworks" and quest == 4 then
					-- The war Thog's offer ------------------------------------------------------------------------------------------------------------------------------------------------------------
					player:dialogSeq({t, name .. "What are you afraid of? Trust that ASAK will guide you in your quest!"}, 1)
				elseif menu == "The War Thog's Offer" and quest == 5 then
					player:dialogSeq(
						{
							t,
							name .. "So War Thog had a son... He is also raising a small army?.",
							name .. "And his son is going to be leading them now?",
							name ..
								"Well, as long as they leave Hon when they are finished training, they can live in whatever muddy snakehole they want."
						},
						1
					)
					player.quest["priest_path"] = 6
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
								player:addLegend("Priest Guild Rank: Aspirant " .. curT(), "guild_rank", 12, 16)
								broadcast(-1, "[TITLE]: " .. player.name .. " has just earned the title 'Aspirant'!")
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
				player:dialogSeq(
					{
						t,
						name ..
							"May the infinite wisdom of the All Seeing All Knowing GOD, turn you from your path and towards his light."
					},
					1
				)
			end
		end
	),
	learnspell = function(player, npc)
		local name = "<b>[" .. npc.name .. "]\n\n"
		local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0

		local quest = player.quest["priest_path"]
		local you = player.level
		local job = player.class
		local opts = {}
		local opts2 = {}
		 --

		--[[
	if you >= 5 and job == 4 and quest >= 1 and 
		player.registry["learned_divine_favor"] == 0 and 
		player.registry["learned_divine_prowess"] == 0 and 
		player.registry["learned_divine_strength"] == 0 and 
		player.registry["learned_divine_power"] == 0 and 
		player.registry["learned_divine_spirit"] == 0 then 
		table.insert(opts, "Divine Favor") 
	end	

	if you >= 20 and job == 4 and quest >= 1 and 
		player.registry["learned_divine_favor"] == 1 and 
		player.registry["learned_divine_prowess"] == 0 and 
		player.registry["learned_divine_strength"] == 0 and 
		player.registry["learned_divine_power"] == 0 and 
		player.registry["learned_divine_spirit"] == 0 then 
		table.insert(opts, "Divine Prowess") 
	end

	if you >= 40 and job == 4 and quest >= 1 and 
		player.registry["learned_divine_favor"] == 0 and 
		player.registry["learned_divine_prowess"] == 1 and 
		player.registry["learned_divine_strength"] == 0 and 
		player.registry["learned_divine_power"] == 0 and 
		player.registry["learned_divine_spirit"] == 0 then 
		table.insert(opts, "Divine Strength") 
	end

	if you >= 60 and job == 4 and quest >= 1 and 
		player.registry["learned_divine_favor"] == 0 and 
		player.registry["learned_divine_prowess"] == 0 and 
		player.registry["learned_divine_strength"] == 1 and 
		player.registry["learned_divine_power"] == 0 and 
		player.registry["learned_divine_spirit"] == 0 then 
		table.insert(opts, "Divine Power") 
	end

	if you >= 80 and job == 4 and quest >= 1 and 
		player.registry["learned_divine_favor"] == 0 and 
		player.registry["learned_divine_prowess"] == 0 and 
		player.registry["learned_divine_strength"] == 0 and 
		player.registry["learned_divine_power"] == 1 and 
		player.registry["learned_divine_spirit"] == 0 then 
		table.insert(opts, "Divine Spirit") 
	end

	if you >= 5 and job == 4 and quest >= 1 and player.registry["learned_sacred_blessing"] == 0 then table.insert(opts, "Sacred Blessing") end
	if (you >= 5 and you < 20) and job == 4 and quest >= 1 and player.registry["learned_cure_minor_wounds"] == 0 and player.registry["learned_cure_light_wounds"] == 0 and player.registry["learned_cure_moderate_wounds"] == 0 and player.registry["learned_cure_serious_wounds"] == 0 and player.registry["learned_cure_critical_wounds"] == 0 then table.insert(opts, "Cure Minor Wounds") end
	if you >= 5 and job == 4 and quest >= 1 and player.registry["learned_club_strike"] == 0 then table.insert(opts, "Club Strike") end
	
	if you >= 10 and job == 4 and quest >= 1 and player.registry["learned_healing_word"] == 0 then table.insert(opts, "Healing Word") end

	if (you >= 10 and you < 60) and job == 4 and quest >= 1 and player.registry["learned_pray"] == 0 and player.registry["learned_pray2"] == 0 and player.registry["learned_pray3"] == 0 then table.insert(opts, "Pray") end
	
	if you >= 15  and job == 4 and quest >= 1 and player.registry["learned_harden_armor"] == 0 and player.registry["learned_harden_spirit"] == 0 then table.insert(opts, "Harden Armor") end
	
	if (you >= 20 and you < 50) and job == 4 and quest >= 1 and player.registry["learned_cure_light_wounds"] == 0 and player.registry["learned_cure_moderate_wounds"] == 0 and player.registry["learned_cure_serious_wounds"] == 0 and player.registry["learned_cure_critical_wounds"] == 0 then table.insert(opts, "Cure Light Wounds") end
	if you >= 20 and job == 4 and quest >= 1 and player.registry["learned_invigorate"] == 0 then table.insert(opts, "Invigorate") end   	

	if you >= 25 and job == 4 and quest >= 1 and player.registry["learned_raise_dead"] == 0 then table.insert(opts, "Raise Dead") end
	if you >= 25 and job == 4 and quest >= 1 and player.registry["learned_club_combo"] == 0 then table.insert(opts, "Club Combo") end
	
	if you >= 35 and job == 4 and quest >= 1 and player.registry["learned_healing_aura"] == 0 then table.insert(opts, "Healing Aura") end

	if you >= 40 and job == 4 and quest >= 1 and player.registry["learned_mass_cure_wounds"] == 0 then table.insert(opts, "Mass Cure Wounds") end
	
	if you >= 50 and job == 4 and quest >= 1 and player.registry["learned_searing_light"] == 0 then table.insert(opts, "Searing Light") end
	if (you >= 50 and you < 80) and job == 4 and quest >= 1 and player.registry["learned_cure_moderate_wounds"] == 0 and player.registry["learned_cure_serious_wounds"] == 0 and player.registry["learned_cure_critical_wounds"] == 0 then table.insert(opts, "Cure Moderate Wounds") end
	
	if you >= 60 and job == 4 and quest >= 1 and player.registry["learned_harden_spirit"] == 0 then table.insert(opts, "Harden Spirit") end  
	if (you >= 60 and you < 99) and job == 4 and quest >= 1 and player.registry["learned_pray_lv2"] == 0 and player.registry["learned_pray_lv3"] == 0 then table.insert(opts, "Pray Lv2") end
	
	if you >= 75 and job == 4 and quest >= 1 and player.registry["learned_lunging_club_strike"] == 0 then table.insert(opts, "Lunging Club Strike") end   
	
	if (you >= 80 and you < 99) and job == 4 and quest >= 1 and player.registry["learned_cure_serious_wounds"] == 0 and player.registry["learned_cure_critical_wounds"] == 0 then table.insert(opts, "Cure Serious Wounds") end
	
	if you >= 85 and job == 4 and quest >= 1 and player.registry["learned_hold_people"] == 0 then table.insert(opts, "Hold People") end   
	
	if you >= 99 and job == 4 and quest >= 1 and player.registry["learned_pray_lv3"] == 0 then table.insert(opts, "Pray Lv3") end
	if you >= 99 and job == 4 and quest >= 1 and player.registry["learned_smite_evil"] == 0 then table.insert(opts, "Smite Evil") end
	if you >= 99 and job == 4 and quest >= 1 and player.registry["learned_cure_critical_wounds"] == 0 then table.insert(opts, "Cure Critical Wounds") end
	if you >= 99 and job == 4 and quest >= 1 and player.registry["learned_self_raise"] == 0 then table.insert(opts, "Self Raise") end
]] player:learnSpell(
			npc
		)

		--[[
	menu = player:menuString(name.."I am the Training Master around here. You want to learn, you get strong and you pay me.", opts)
	
	if menu == "Learn Sacred Blessing" then
		player:dialogSeq({t, name.."Sacred Blessing is a spell to increase your ally's Might, Will, and Grace!"}, 1)
		confirm = player:menuString(name.."Do you wish to learn Sacred Blessing? This spell is free.", {"Yes", "No"})
		if confirm == "Yes" then
			if player:removeGold(0) == false then
				player:dialogSeq({t, name.."I do not have time to train you for free!"}, 1)
			return else
				player:addSpell("sacred_blessing")
				player.registry["learned_sacred_blessing"] = 1
				player:sendMinitext("You learned Sacred Blessing!")
				priest_trainer.learnspell(player, npc)
			end
		end
		
	elseif menu == "Learn Club Strike" then
		player:dialogSeq({t, name.."Club Strike is essential if you are to survive outside city walls!"}, 1)
		confirm = player:menuString(name.."Do you wish to learn Pray? I will personally show you how to do this!", {"Yes", "No"})
		if confirm == "Yes" then
			if player:removeGold(0) == false then
				player:dialogSeq({t, name.."I do not have time to train you for free!"}, 1)
			return else
				player:addSpell("club_strike")
				player.registry["learned_club_strike"] = 1
				player:sendMinitext("You learned Club Strike!")
				priest_trainer.learnspell(player, npc)
			end
		end
	
	elseif menu == "Learn Divine Favor" then
		player:dialogSeq({t, name.."Call upon your GOD to boost your combat potential."}, 1)
		confirm = player:menuString(name.."Do you wish to learn Divine Favor? This spell is free.", {"Yes", "No"})
		if confirm == "Yes" then
			if player:removeGold(0) == false then
				player:dialogSeq({t, name.."I do not have time to train you for free!"}, 1)
			return else
				player:addSpell("divine_favor")
				player.registry["learned_divine_favor"] = 1
				player:sendMinitext("You learned Divine Favor!")
				priest_trainer.learnspell(player, npc)
			end
		end
		
	elseif menu == "Learn Cure Minor Wounds" then
		player:dialogSeq({t, name.."Cure Minor Wounds is a spell to heal a tiny amount of someone's health!"}, 1)
		confirm = player:menuString(name.."Do you wish to learn Cure Minor Wounds? This spell is free.", {"Yes", "No"})
		if confirm == "Yes" then
			if player:removeGold(0) == false then
				player:dialogSeq({t, name.."I do not have time to train you for free!"}, 1)
			return else
				player:addSpell("cure_minor_wounds")
				player.registry["learned_cure_minor_wounds"] = 1
				player:sendMinitext("You learned Cure Minor Wounds!")
				priest_trainer.learnspell(player, npc)
			end
		end
		
	elseif menu == "Learn Healing Word" then
		player:dialogSeq({t, name.."Healing Word is a spell to instantly heal a miniscule amount of someone's health!"}, 1)
		confirm = player:menuString(name.."Do you wish to learn Healing Word? This spell is 500 coins.", {"Yes", "No"})
		if confirm == "Yes" then
			if player:removeGold(500) == false then
				player:dialogSeq({t, name.."I do not have time to train you for free!"}, 1)
			return else
				player:addSpell("healing_word")
				player.registry["learned_healing_word"] = 1
				player:sendMinitext("You learned Healing Word!")
				priest_trainer.learnspell(player, npc)
			end
		end
	
	elseif menu == "Learn Pray" then
		player:dialogSeq({t, name.."Pray is a spell to return mana by asking the God's for their blessing!"}, 1)
		confirm = player:menuString(name.."Do you wish to learn Pray? This spell costs 1000 coins", {"Yes", "No"})
		if confirm == "Yes" then
			if player:removeGold(1000) == false then
				player:dialogSeq({t, name.."I do not have time to train you for free!"}, 1)
			return else
				player:addSpell("pray")
				player.registry["learned_pray"] = 1
				player:sendMinitext("You learned Pray!")
				priest_trainer.learnspell(player, npc)
			end
		end
	
	elseif menu == "Learn Cure Light Wounds" then
		player:dialogSeq({t, name.."Cure Light Wounds is a spell to heal a small amount of someone's health!"}, 1)
		confirm = player:menuString(name.."Do you wish to learn Cure Light Wounds? This spell costs 5000 coins", {"Yes", "No"})
		if confirm == "Yes" then
			if player:removeGold(5000) == false then
				player:dialogSeq({t, name.."I do not have time to train you for free!"}, 1)
			return else
				player:addSpell("cure_light_wounds")
				player.registry["learned_cure_light_wounds"] = 1
				player:sendMinitext("You learned Cure Light Wounds!")
				player:removeSpell("cure_minor_wounds")
				player.registry["learned_cure_minor_wounds"] = 0
				player:removeSpell("basic_first_aid")
				player.registry["learned_basic_first_aid"] = 0
				priest_trainer.learnspell(player, npc)
			end
		end

	elseif menu == "Learn Invigorate" then
		player:dialogSeq({t, name.."Invigorate is a spell to restore someone's mana at the cost of your own!"}, 1)
		confirm = player:menuString(name.."Do you wish to learn Invigorate? This spell costs 10000 coins", {"Yes", "No"})
		if confirm == "Yes" then
			if player:removeGold(10000) == false then
				player:dialogSeq({t, name.."I do not have time to train you for free!"}, 1)
			return else
				player:addSpell("invigorate")
				player.registry["learned_invigorate"] = 1
				player:sendMinitext("You learned Invigorate!")
				priest_trainer.learnspell(player, npc)
			end
		end

	elseif menu == "Learn Divine Prowess" then
		player:dialogSeq({t, name.."Call upon your GOD to boost your combat potential. This spell replaces Divine Favor."}, 1)
		confirm = player:menuString(name.."Do you wish to learn Divine Prowess? This spell costs 15000 coins.", {"Yes", "No"})
		if confirm == "Yes" then
			if player:removeGold(15000) == false then
				player:dialogSeq({t, name.."I do not have time to train you for free!"}, 1)
			return else
				player:removeSpell("divine_favor")
				player:addSpell("divine_prowess")
				player.registry["learned_divine_prowess"] = 1
				player:sendMinitext("You learned Divine Prowess!")
				priest_trainer.learnspell(player, npc)
			end
		end
	
	elseif menu == "Learn Raise Dead" then
		player:dialogSeq({t, name.."Raise Dead is a spell to revive an ally from death!"}, 1)
		confirm = player:menuString(name.."Do you wish to learn Raise Dead? This spell costs 25000 coins", {"Yes", "No"})
		if confirm == "Yes" then
			if player:removeGold(25000) == false then
				player:dialogSeq({t, name.."I do not have time to train you for free!"}, 1)
			return else
				player:addSpell("raise_dead")
				player.registry["learned_raise_dead"] = 1
				player:sendMinitext("You learned Raise Dead!")
				priest_trainer.learnspell(player, npc)
			end
		end
	
	elseif menu == "Learn Club Combo" then
		player:dialogSeq({t, name.."Club Combo is a spell that strikes multiple foes at once!"}, 1)
		confirm = player:menuString(name.."Do you wish to learn Club Combo? This spell costs 15000 coins", {"Yes", "No"})
		if confirm == "Yes" then
			if player:removeGold(15000) == false then
				player:dialogSeq({t, name.."I do not have time to train you for free!"}, 1)
			return else
				player:addSpell("club_combo")
				player.registry["learned_club_combo"] = 1
				player:sendMinitext("You learned Club Combo!")
				priest_trainer.learnspell(player, npc)
			end
		end
	elseif menu == "Learn Healing Aura" then
		player:dialogSeq({t, name.."Healing Aura is a spell puts a healing aura on nearby party members!"}, 1)
		confirm = player:menuString(name.."Do you wish to learn Healing Aura? This spell costs 15000 coins", {"Yes", "No"})
		if confirm == "Yes" then
			if player:removeGold(15000) == false then
				player:dialogSeq({t, name.."I do not have time to train you for free!"}, 1)
			return else
				player:addSpell("healing_aura")
				player.registry["learned_healing_aura"] = 1
				player:sendMinitext("You learned Healing Aura!")
				priest_trainer.learnspell(player, npc)
			end
		end
	elseif menu == "Learn Knockback Strike" then
		player:dialogSeq({t, name.."Knockback Strike is a spell that hits a target, then pushes back and stuns surrounding enemies!"}, 1)
		confirm = player:menuString(name.."Do you wish to learn Knockback Strike? This spell costs 15000 coins", {"Yes", "No"})
		if confirm == "Yes" then
			if player:removeGold(15000) == false then
				player:dialogSeq({t, name.."I do not have time to train you for free!"}, 1)
			return else
				player:addSpell("knockback_strike")
				player.registry["learned_knockback_strike"] = 1
				player:sendMinitext("You learned Knockback Strike!")
				priest_trainer.learnspell(player, npc)
			end
		end
	elseif menu == "Learn Mass Cure Wounds" then
		player:dialogSeq({t, name.."Mass Cure Wounds is a spell that heals your entire party!"}, 1)
		confirm = player:menuString(name.."Do you wish to learn Mass Cure Wounds? This spell costs 15000 coins", {"Yes", "No"})
		if confirm == "Yes" then
			if player:removeGold(15000) == false then
				player:dialogSeq({t, name.."I do not have time to train you for free!"}, 1)
			return else
				player:addSpell("mass_cure_wounds")
				player.registry["learned_mass_cure_wounds"] = 1
				player:sendMinitext("You learned Mass Cure Wounds!")
				priest_trainer.learnspell(player, npc)
			end
		end

	elseif menu == "Learn Divine Strength" then
		player:dialogSeq({t, name.."Call upon your GOD to boost your combat potential. This spell replaces Divine Prowess."}, 1)
		confirm = player:menuString(name.."Do you wish to learn Divine Strength? This spell costs 25000 coins.", {"Yes", "No"})
		if confirm == "Yes" then
			if player:removeGold(25000) == false then
				player:dialogSeq({t, name.."I do not have time to train you for free!"}, 1)
			return else
				player:removeSpell("divine_prowess")
				player:addSpell("divine_strength")
				player.registry["learned_divine_strength"] = 1
				player:sendMinitext("You learned Divine Strength!")
				priest_trainer.learnspell(player, npc)
			end
		end
	
	elseif menu == "Learn Searing Light" then
		player:dialogSeq({t, name.."Searing Light is a spell to call on the sun from your God to blind and burn your enemies!"}, 1)
		confirm = player:menuString(name.."Do you wish to learn Searing Light? This spell costs 50000 coins", {"Yes", "No"})
		if confirm == "Yes" then
			if player:removeGold(50000) == false then
				player:dialogSeq({t, name.."I do not have time to train you for free!"}, 1)
			return else
				player:addSpell("searing_light")
				player.registry["learned_searing_light"] = 1
				player:sendMinitext("You learned Searing Light!")
				priest_trainer.learnspell(player, npc)
			end
		end
	
	elseif menu == "Learn Cure Moderate Wounds" then
		player:dialogSeq({t, name.."Cure Moderate Wounds is a spell to heal a good amount of someone's health!"}, 1)
		confirm = player:menuString(name.."Do you wish to learn Cure Moderate Wounds? This spell costs 20000 coins", {"Yes", "No"})
		if confirm == "Yes" then
			if player:removeGold(20000) == false then
				player:dialogSeq({t, name.."I do not have time to train you for free!"}, 1)
			return else
				player:addSpell("cure_moderate_wounds")
				player.registry["learned_cure_moderate_wounds"] = 1
				player:sendMinitext("You learned Cure Moderate Wounds!")
				player:removeSpell("cure_light_wounds")
				player.registry["learned_cure_light_wounds"] = 0
				player:removeSpell("cure_minor_wounds")
				player.registry["learned_cure_minor_wounds"] = 0
				player:removeSpell("basic_first_aid")
				player.registry["learned_basic_first_aid"] = 0
				priest_trainer.learnspell(player, npc)
			end
		end
	
	elseif menu == "Learn Pray Lv2" then
		player:dialogSeq({t, name.."Upgrades your Pray spell, which recovers your mana"}, 1)
		confirm = player:menuString(name.."Do you wish to learn Pray Lv2? This spell costs 25000 coins", {"Yes", "No"})
		if confirm == "Yes" then
			if player:removeGold(25000) == false then
				player:dialogSeq({t, name.."I do not have time to train you for free!"}, 1)
			return else
				player:addSpell("pray2")
				player.registry["learned_pray2"] = 1
				player:sendMinitext("You learned Pray Lv2!")
				player:removeSpell("pray")
				player.registry["learned_pray"] = 0
				priest_trainer.learnspell(player, npc)
			end
		end
	
	elseif menu == "Learn Divine Power" then
		player:dialogSeq({t, name.."Call upon your GOD to boost your combat potential. This spell replaces Divine Strength."}, 1)
		confirm = player:menuString(name.."Do you wish to learn Divine Power? This spell costs 40000 coins.", {"Yes", "No"})
		if confirm == "Yes" then
			if player:removeGold(25000) == false then
				player:dialogSeq({t, name.."I do not have time to train you for free!"}, 1)
			return else
				player:removeSpell("divine_strength")
				player:addSpell("divine_power")
				player.registry["learned_divine_power"] = 1
				player:sendMinitext("You learned Divine Power!")
				priest_trainer.learnspell(player, npc)
			end
		end

	elseif menu == "Learn Lunging Club Strike" then
		player:dialogSeq({t, name.."Lunging Strike is a spell that jumps the priest forward and knocking back enemies!"}, 1)
		confirm = player:menuString(name.."Do you wish to learn Lunging Club Strike? This spell costs 50000 coins", {"Yes", "No"})
		if confirm == "Yes" then
			if player:removeGold(50000) == false then
				player:dialogSeq({t, name.."I do not have time to train you for free!"}, 1)
			return else
				player:addSpell("lunging_club_strike")
				player.registry["learned_lunging_club_strike"] = 1
				player:sendMinitext("You learned Lunging Club Strike!")
				priest_trainer.learnspell(player, npc)
			end
		end
			
	elseif menu == "Learn Cure Serious Wounds" then
		player:dialogSeq({t, name.."Cure Serious Wounds is a spell to heal a large amount of someone's health!"}, 1)
		confirm = player:menuString(name.."Do you wish to learn Cure Serious Wounds? This spell costs 75000 coins", {"Yes", "No"})
		if confirm == "Yes" then
			if player:removeGold(75000) == false then
				player:dialogSeq({t, name.."I do not have time to train you for free!"}, 1)
			return else
				player:addSpell("cure_serious_wounds")
				player.registry["learned_cure_serious_wounds"] = 1
				player:sendMinitext("You learned Cure Serious Wounds!")
				player:removeSpell("cure_moderate_wounds")
				player.registry["learned_cure_moderate_wounds"] = 0
				player:removeSpell("cure_light_wounds")
				player.registry["learned_cure_light_wounds"] = 0
				player:removeSpell("cure_minor_wounds")
				player.registry["learned_cure_minor_wounds"] = 0
				player:removeSpell("basic_first_aid")
				player.registry["learned_basic_first_aid"] = 0
				priest_trainer.learnspell(player, npc)
			end
		end
			
	elseif menu == "Learn Pray Lv3" then
		player:dialogSeq({t, name.."Upgrades your Pray spell, which recovers your mana"}, 1)
		confirm = player:menuString(name.."Do you wish to learn Pray Lv3? This spell costs 150000 coins", {"Yes", "No"})
		if confirm == "Yes" then
			if player:removeGold(150000) == false then
				player:dialogSeq({t, name.."I do not have time to train you for free!"}, 1)
			return else
				player:addSpell("pray3")
				player.registry["learned_pray3"] = 1
				player:sendMinitext("You learned Pray Lv3!")
				player:removeSpell("pray2")
				player.registry["learned_pray2"] = 0
				player:sendMinitext("You learned Pray Lv2!")
				player:removeSpell("pray")
				player.registry["learned_pray"] = 0
				priest_trainer.learnspell(player, npc)
			end
		end
			
	elseif menu == "Learn Smite Evil" then
		player:dialogSeq({t, name.."Smite your enemies with Holy might"}, 1)
		confirm = player:menuString(name.."Do you wish to learn Smite Evil? This spell costs 150000 coins", {"Yes", "No"})
		if confirm == "Yes" then
			if player:removeGold(150000) == false then
				player:dialogSeq({t, name.."I do not have time to train you for free!"}, 1)
			return else
				player:addSpell("smite_evil")
				player.registry["learned_smite_evil"] = 1
				player:sendMinitext("You learned Smite Evil!")
				priest_trainer.learnspell(player, npc)
			end
		end
	
	elseif menu == "Learn Cure Critical Wounds" then
		player:dialogSeq({t, name.."Cure Critical Wounds is a spell to heal a large amount of someone's health!"}, 1)
		confirm = player:menuString(name.."Do you wish to learn Cure Critical Wounds? This spell costs 100000 coins", {"Yes", "No"})
		if confirm == "Yes" then
			if player:removeGold(100000) == false then
				player:dialogSeq({t, name.."I do not have time to train you for free!"}, 1)
			return else
				player:addSpell("cure_critical_wounds")
				player.registry["learned_cure_critical_wounds"] = 1
				player:sendMinitext("You learned Cure Critical Wounds!")
				player:removeSpell("cure_serious_wounds")
				player.registry["learned_cure_serious_wounds"] = 0
				player:removeSpell("cure_moderate_wounds")
				player.registry["learned_cure_moderate_wounds"] = 0
				player:removeSpell("cure_light_wounds")
				player.registry["learned_cure_light_wounds"] = 0
				player:removeSpell("cure_minor_wounds")
				player.registry["learned_cure_minor_wounds"] = 0
				player:removeSpell("basic_first_aid")
				player.registry["learned_basic_first_aid"] = 0
				priest_trainer.learnspell(player, npc)
			end
		end 
	elseif menu == "Learn Divine Spirit" then
		player:dialogSeq({t, name.."Call upon your GOD to boost your combat potential. This spell replaces Divine Power."}, 1)
		confirm = player:menuString(name.."Do you wish to learn Divine Spirit? This spell costs 75000 coins.", {"Yes", "No"})
		if confirm == "Yes" then
			if player:removeGold(75000) == false then
				player:dialogSeq({t, name.."I do not have time to train you for free!"}, 1)
			return else
				player:removeSpell("divine_power")
				player:addSpell("divine_spirit")
				player.registry["learned_divine_spirit"] = 1
				player:sendMinitext("You learned Divine Spirit!")
				priest_trainer.learnspell(player, npc)
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

		local spells = {}
		local you = player.level
		local level = 0

		if you >= 5 and you <= 14 then
			table.insert(spells, "Pray Lv1")
			level = 15
		end
		if you >= 15 and you <= 19 then
			table.insert(spells, "Cure Light Wounds")
			level = 20
		end
		if you >= 20 and you <= 24 then
			table.insert(spells, "Raise Dead")
			level = 25
		end
		if you >= 25 and you <= 34 then
			table.insert(spells, "Club Combo")
			level = 35
		end
		if you >= 35 and you <= 49 then
			table.insert(spells, "Cure Moderate Wounds")
			level = 50
		end
		if you >= 35 and you <= 49 then
			table.insert(spells, "Searing Light")
			level = 50
		end
		if you >= 70 and you <= 74 then
			table.insert(spells, "Lunging Club Strike")
			level = 75
		end
		if you >= 75 and you <= 79 then
			table.insert(spells, "Pray Lv2")
			level = 80
		end
		if you >= 75 and you <= 79 then
			table.insert(spells, "Cure Serious Wounds")
			level = 80
		end
		if you >= 95 and you <= 98 then
			table.insert(spells, "Smite Evil")
			level = 99
		end
		if you >= 95 and you <= 98 then
			table.insert(spells, "Pray Lv3")
			level = 99
		end
		if you >= 95 and you <= 98 then
			table.insert(spells, "Cure Critical Wounds")
			level = 99
		end

		menu = player:menuString(name .. "These are the spells that your future holds", spells)

		if menu == "Pray Lv1" then
			player:dialog(name .. "You are not ready to learn this secret. Return when you are level " .. level, t)
		elseif menu == "Cure Light Wounds" then
			player:dialog(name .. "You are not ready to learn this secret. Return when you are level " .. level, t)
		elseif menu == "Raise Dead" then
			player:dialog(name .. "You are not ready to learn this secret. Return when you are level " .. level, t)
		elseif menu == "Club Combo" then
			player:dialog(name .. "You are not ready to learn this secret. Return when you are level " .. level, t)
		elseif menu == "Cure Moderate Wounds" then
			player:dialog(name .. "You are not ready to learn this secret. Return when you are level " .. level, t)
		elseif menu == "Searing Light" then
			player:dialog(name .. "You are not ready to learn this secret. Return when you are level " .. level, t)
		elseif menu == "Lunging Club Strike" then
			player:dialog(name .. "You are not ready to learn this secret. Return when you are level " .. level, t)
		elseif menu == "Pray Lv2" then
			player:dialog(name .. "You are not ready to learn this secret. Return when you are level " .. level, t)
		elseif menu == "Cure Serious Wounds" then
			player:dialog(name .. "You are not ready to learn this secret. Return when you are level " .. level, t)
		elseif menu == "Smite Evil" then
			player:dialog(name .. "You are not ready to learn this secret. Return when you are level " .. level, t)
		elseif menu == "Pray Lv3" then
			player:dialog(name .. "You are not ready to learn this secret. Return when you are level " .. level, t)
		elseif menu == "Cure Critical Wounds" then
			player:dialog(name .. "You are not ready to learn this secret. Return when you are level " .. level, t)
		end
	end,
	nearbyPlayers = function(npc)
		local pc = npc:getObjectsInArea(BL_PC)
		local m, x, y = npc.m, npc.x, npc.y

		if #pc > 0 then
			for i = 1, #pc do
				if pc[i].quest["priest_path"] == 1 or pc[i].quest["priest_path"] == 3 or pc[i].quest["priest_path"] == 5 then
					pc[i]:selfAnimationXY(pc[i].ID, 248, x, y)
				elseif pc[i].quest["priest_path"] == 6 and pc[i].level >= 40 and pc[i].quest["leech_lord"] == 0 then
					pc[i]:selfAnimationXY(pc[i].ID, 248, x, y)
				end
			end
		end
	end
}
