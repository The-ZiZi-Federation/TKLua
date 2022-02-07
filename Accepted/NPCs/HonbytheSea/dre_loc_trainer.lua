-- First EXP Seller Version 1.0

dre_loc_trainer = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0

			local menu, req, max, txt, input, add, ok
			local xp = player.exp
			local opts = {"Yes", "No"}
			local opts2 = {}

			if player:hasDuration("dre_locs_drain") then
				player:popUp("You try to protest, but you are too weak to fight Dre Loc's magic.")
				return
			end

			-- First Talk -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

			if player.quest["dre_loc_rambles"] == 0 then
				player:dialogSeq(
					{
						t,
						name ..
							"I am the Greatest Mage of all time. Student of the Temple of Pai Kang, Grandmaster of the Tzu Kang, Destroyer of the Ngyen Pi Bok.",
						name .. "Raggedy Traveller, River Crosser, Mountain Climber, and For a Time Ruler of the Empire of Cathay... ",
						name ..
							"Preparer of the Way, Wiseman to Lempkins the Bold, Grand Counselor of the Empire of Spetan, Advisor to Gods both Forgotten and Known.",
						name .. "Donator to the Library of Gypto, Knowledge Bearer for the Knights of Honor.",
						name .. "Contemporary of Booly, of Crom, of Ella Rue, Sarvis Nestle, and one time associate of the Crucimigrator.",
						name ..
							"Friend of Dragons, but Killer of Dragons. Slayer of Vampires. JUPEWALKER. Passer Through the Curtain of Time. Mirror Mover, Ground Shaker,",
						name .. "Friend to Founders of Orders, Great Heroes, Ancient Beings, and Those That Came Before.",
						name ..
							"Crusher of Morte, Enemy of Phaganites. Blood Brother to Delta, Father Figure to Caltus and His Seed, Escort to Anger.",
						name ..
							"Author of Spellbooks both Arcane and Divine, Founder of Mage Orders Olde and New,and Writer of Damnation Seals.",
						name ..
							"Bearer of the Head of Carragus Oakendagger. Crusher of the Order of the Ebon Hand. Mageslayer, Magic Drainer. The Mage Who Has Lived a Thousand Years.",
						name .. "The One. The Only. Dre Loc.",
						name .. "Ugh, What is that smell? Do you know what a bath is? Never you mind, this will have to do."
					},
					1
				)
				player.state = 0
				player.health = player.maxHealth
				player:updateState()
				player:sendStatus()
				player:sendAnimation(121)
				player:playSound(73)
				xmasLegendFix.removeLegend(player)
				player:addLegend("Reborn Before the First Cataclysm " .. curT(), "born", 122, 165)
				xmasLegendFix.readdLegend(player)
				player.quest["dre_loc_rambles"] = 1
				return
			elseif player.quest["dre_loc_rambles"] == 1 then
				player:dialogSeq(
					{
						t,
						name .. "What's this? Another soul too stubborn to move on to the afterlife?",
						name .. "If you're going to stay, you can at least dress yourself.",
						name .. "I think I have some clothes here...",
						name .. "I don't know if you've heard of Morna before, but it is very dangerous here.",
						name .. "You'll need to arm yourself as well, but I don't have any weapons just lying around here to hand out.",
						name ..
							"You are in the city of Hon by the Sea, and you should be able to find plenty of Sturdy Sticks and Sharp Stones around the South Gate.",
						name ..
							"((You will find these near X:60, Y:100, north of South Gate. Press 'o' while facing some objects on the ground to pick them up))",
						name ..
							"Once you've gathered up about 5 of each, seek out Banon in the west of town. He can help you fashion them into something a little more formidable.",
						name .. "He might try to charge you, so take a few coins. ((Find Banon at: X:27, Y:113))",
						name ..
							"I'll even teach you some magic to help out. Use this Gateway spell to warp to one of the Hon gates\n\n((Press '1' to cast the spell, then type n, e, s or w and press 'enter'))"
					},
					1
				)
				if player.sex == 0 then
					player:addItem("hon_duds", 1)
				end
				if player.sex == 1 then
					player:addItem("hon_skirt", 1)
				end
				player:addItem("hon_shoes", 1)
				player:addSpell("gateway")
				player:addGold(150)
				player:sendMinitext("You learn Gateway!")
				player.quest["dre_loc_rambles"] = 2
				player:msg(4, "[Quest Started] Gather 5 Sharp Rocks and 5 Sturdy Sticks, then visit Banon!", player.ID)
			elseif player.quest["dre_loc_rambles"] == 2 or player.quest["dre_loc_rambles"] == 3 then
				player:dialogSeq(
					{
						t,
						name .. "I don't see a spear. Have you met Banon yet?",
						name ..
							"Gather 5 Sturdy Sticks and 5 Sharp Rocks near the South Gate ((X:60, Y:100)) and then go find Banon.((X:27, Y:113))"
					},
					1
				)
			elseif player.quest["dre_loc_rambles"] == 4 then
				giveXP(player, 750)
				player:addGold(100)
				finishedQuest(player)
				player.quest["dre_loc_rambles"] = 5
				player:addLegend("Created Improvised Spear " .. curT(), "tutorial_spear", 17, 16)
				player:msg(4, "[Quest Update] Gather 6 Pink Flowers!", player.ID)
				player:dialogSeq(
					{
						t,
						name .. "Good, good, at least you're no longer unarmed.",
						name .. "Did you notice the pink flowers out in the same field where you gathered your rocks and sticks?",
						name .. "Go and fetch me 6 of them, will you?"
					},
					1
				)
			elseif player.quest["dre_loc_rambles"] == 5 then
				if player:hasItem("pink_flower", 6) == true then
					player:addItem("bouquet_ribbon", 1)
					player.quest["dre_loc_rambles"] = 6
					player:dialogSeq(
						{
							t,
							name .. "Oh, neat. You actually did it.",
							name .. "Here, take this ribbon and wrap them up into a bouquet.",
							name .. "Did Banon teach you how to use the Creation System?",
							name .. "Just do the same thing here. Combine 6 Pink Flowers with that Bouquet Ribbon."
						},
						1
					)
				else
					player:dialogSeq({t, name .. "You don't have enough flowers. Come back with 6 of them."}, 1)
				end
			elseif player.quest["dre_loc_rambles"] == 6 then
				if player:hasItem("pink_flower_bouquet", 1) == true then
					giveXP(player, 1500)
					finishedQuest(player)
					player.quest["dre_loc_rambles"] = 7
					player:msg(4, "[Quest Complete] Created a Bouquet!", player.ID)
					player:dialogSeq(
						{
							t,
							name ..
								"There you go! Maybe when you go to join a Guild, you can give your Guildmaster a gift of flowers, Bahahaha!"
						},
						1
					)
				else
					player:dialogSeq(
						{
							t,
							name ..
								"Press Shift + 'i' to use the creation system. Combine 6 Pink Flowers with the Bouquet Ribbon to make a Pink Flower Bouquet."
						},
						1
					)
				end
			elseif player.quest["dre_loc_rambles"] == 7 then
				player.quest["dre_loc_rambles"] = 8
				player:addSpell("basic_first_aid")
				player:sendMinitext("You learned Basic First Aid!")
				player:msg(4, "[Quest Started] Get the Serum from Harvey!", player.ID)
				player:dialogSeq(
					{
						t,
						name .. "Now it is time to see if you are truly ready for a life in Morna.",
						name .. "There are many caves and dungeons across the world filled with dangerous beasts.",
						name .. "There is even a small one here, near my temple.",
						name ..
							"My magical barrier prevents the creatures from escaping, but they should prove a fine test of your mettle.",
						name .. "To pass the barrier and enter the cave you will need my special Serum.",
						name .. "Most of my supply is at Harvey's Hut. He's a good kid and offered to keep it safe for me.",
						name .. "You can find Harvey's Hut just west of here, it is difficult to miss.",
						name .. "Harvey is... fond of explosions. I'd better teach you a little bit about healing, to be safe.",
						name .. "((You learned Basic First Aid! Press '2' to heal yourself))"
					},
					1
				)
			elseif player.quest["dre_loc_rambles"] == 8 then
				if player.quest["tutorial_serum"] == 1 then
					if player:hasItem("honey", 10) == true then
						player:removeItem("honey", 10)
						player:addGold(150)
						giveXP(player, 4500)
						finishedQuest(player)
						player.quest["dre_loc_rambles"] = 9
						player:msg(4, "[Quest Complete] Brought Dre Loc some honey for his tea!", player.ID)
						player:addItem("minor_vita_potion", 2)
						player:addItem("minor_mana_potion", 2)
						player:dialogSeq(
							{t, name .. "You got my honey! Thanks! I use it to make these great potions, try a couple if you will."},
							1
						)
					else
						player:dialogSeq({t, name .. "Where's the honey?"}, 1)
					end
				else
					player:dialogSeq(
						{
							t,
							name .. "What are you waiting for?",
							name .. "You can find Harvey's Hut just west of here, it is difficult to miss."
						},
						1
					)
				end
			elseif player.quest["dre_loc_rambles"] == 9 then
				if player.level >= 5 then
					menu = player:menuString(name .. "It's time to choose your destiny. Are you ready to pick your Path?", opts)

					if menu == "Yes" then
						----------- ACTIVATION CHECK -----------------
						if (player.actId == 0) then
							player:popUp(
								"Your character is currently not activated/registered. You must resolve this issue before can progress. Please see the F1 menu -> Activate option."
							)
							return
						end
						---------------------------------------------------

						player:dialogSeq(
							{
								t,
								name .. "You should know that Morna is a dangerous place.",
								name .. "Keep your wits about you if you want to survive for long.",
								name ..
									"All of the options develop into many different ways based on specialization, which you will experience if you survive long enough.",
								name ..
									"You could start as a Fighter. They stand out infront commanding the attention of your enemies while your allies pick them off and keep you alive. ",
								name ..
									"You could start as a Scoundrel. Quick, Agile, and stealthy. They will single out an opponent and before they know it, the scoundrel is behind them with a dagger in their back.",
								name ..
									"You could start as a Wizard. They manipulate the elements around them in order to call upon magical energy to defeat their enemies, or assist their allies.",
								name ..
									"You could start as a Priest. They heal their allies while bashing enemies with a club. Their faith guides them through every dark path.",
								name ..
									"Now it is time to start your journey, I will send you to where you please. Make this choice wisely, as you will not get another chance to make this life choice."
							},
							1
						)
						table.insert(opts2, "I want to be a Fighter!")
						table.insert(opts2, "I want to be a Scoundrel!")
						table.insert(opts2, "I want to be a Wizard!")
						table.insert(opts2, "I want to be a Priest!")

						menu = player:menuString(name .. "How would you like to begin your adventure?", opts2)

						if (menu == "I want to be a Fighter!") then
							player:sendAnimation(364)
							player:warp(1004, 16, 8)
							player:sendAnimation(254)
							player.quest["dre_loc_rambles"] = 10
						elseif (menu == "I want to be a Scoundrel!") then
							player:sendAnimation(364)
							player:warp(1005, 10, 10)
							player:sendAnimation(254)
							player.quest["dre_loc_rambles"] = 10
						elseif (menu == "I want to be a Wizard!") then
							player:sendAnimation(364)
							player:warp(1013, 8, 8)
							player:sendAnimation(254)
							player.quest["dre_loc_rambles"] = 10
						elseif (menu == "I want to be a Priest!") then
							player:sendAnimation(364)
							player:warp(1014, 15, 12)
							player:sendAnimation(254)
							player.quest["dre_loc_rambles"] = 10
						end
					elseif menu == "No" then
						player:dialogSeq({t, name .. "You'll have to decide sometime."}, 1)
					end
				else
					player:dialogSeq(
						{
							t,
							name .. "You're almost ready to join a Guild, but you still need a bit more training, I think.",
							name .. "Try fighting a few more bees to toughen up, and then come back."
						},
						1
					)
				end
			end

			-- Level 99 ---------------------------------------------------------------------------------------------------------------------------------------

			if player.level >= 99 then
				if player.registry["drained_by_dre_loc"] == 0 then
					if player.exp >= 2000000000 then
						player:dialogSeq(
							{
								t,
								name .. "I can sense the fresh Experience coursing through your veins...",
								name .. "I'm guessing you have returned to me for training.",
								name .. "You are a needy one, aren't you?",
								name .. "Well there's a cost."
							},
							1
						)
						player.registry["exp_drained"] = 0
						player:sendAnimation(198)
						player.paralyzed = true
						player:sendMinitext("Dre Loc is draining away your experiences in this life...")
						player:setDuration("dre_locs_drain", 30000)
						return
					elseif player.exp < 2000000000 and player.registry["exp_maxes"] >= 1 then
						player:dialogSeq(
							{
								t,
								name .. "I can tell you've been hoarding your experiences.",
								name .. "I'm guessing you have returned to me for training.",
								name .. "I'm sure you had plans for all this experience.",
								name .. "Well I had a plan too, from the moment I saw your dead face."
							},
							1
						)
						player.registry["exp_drained"] = 0
						player:sendAnimation(198)
						player.paralyzed = true
						player:sendMinitext("Dre Loc is draining away your experiences in this life...")
						player:setDuration("dre_locs_drain", 30000)
						return
					else
						player:dialogSeq({t, name .. ""})
						return
					end
				end

				if player.state == 1 then
					player:dialogSeq({t, name .. "I won't be talking with spirits anymore! I learned that lesson long ago..."})
					return
				elseif player.state == 0 or player.state == 3 then
					player.health = player.maxHealth
					player.magic = player.maxMagic
					player:sendStatus()

					----------- ACTIVATION CHECK -----------------
					if (player.actId == 0) then
						player:popUp(
							"Your character is currently not activated/registered. You must resolve this issue before can progress. Please see the F1 menu -> Activate option."
						)
						return
					end
					---------------------------------------------------

					menu =
						player:menuString(
						name .. "What kind of training are you here for?",
						{"Info", "Increase Health", "Increase Mana", "Exit"}
					)

					if menu == "Info" then
						-- Health Exchange --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
						player:dialogSeq(
							{
								t,
								name .. "When exchanging your experience, the exchanged value is in the form of training sessions.",
								name .. "The value is different depending on which kind of training session you untertake.",
								name .. "For instance, there are Vita, Mana, Might (not active), Will (not active), Grace (not active).",
								name ..
									"The experience cost of a training session is different for each Path. You can exchange your experience when you reached level 99."
							}
						)
					elseif menu == "Increase Health" then
						-- Mana Training ------------------------------------------------------------------------------------------------------------------------------
						local baseVReq = changeXP2.getReqXPhealth2(player, player.baseClass)
						txt = "Ready to train?\n\n"
						txt = txt .. "Base Vita : " .. player.baseHealth .. "\n"
						txt = txt .. "1 Session   = Additional 50 vita\n"
						txt = txt .. "1 Session   = " .. baseVReq .. " exp\n"
						txt = txt .. "How many training sessions would you like? (To a maximum of 500 at a time)"
						input = player:input(txt)

						if tonumber(input) <= 0 then
							return
						elseif tonumber(input) > 500 then
							player:dialogSeq({t, "<b>[Vita Exchange]\n\nYou need to expand your mind if you wish to learn these secrets!"})
							return
						else
							player.registry["trainer_stop"] = 0
							for i = 1, tonumber(input) do
								dre_loc_trainer.expSellVita(player)
							end
						end
					elseif menu == "Increase Mana" then
						local baseMReq = changeXP2.getReqXPmagic2(player, player.baseClass)
						txt = "Ready to train?\n\n"
						txt = txt .. "Base Mana : " .. player.baseMagic .. "\n"
						txt = txt .. "1 Session   = Additional 50 mana\n"
						txt = txt .. "1 Session   = " .. baseMReq .. " exp\n"
						txt = txt .. "How many training sessions would you like? (To a maximum of 500 at a time)"
						input = player:input(txt)

						if tonumber(input) <= 0 then
							return
						elseif tonumber(input) > 500 then
							player:dialogSeq({t, "<b>[Mana Exchange]\n\nYou need to expand your mind if you wish to learn these secrets!"})
							return
						else
							player.registry["trainer_stop"] = 0
							for i = 1, tonumber(input) do
								dre_loc_trainer.expSellMana(player)
							end
							player:sendMinitext(
								"Successfully completed " .. player.registry["current_training_sessions"] .. " training sessions"
							)
							player.registry["current_training_sessions"] = 0
						end
					end
				end
			end
		end
	),
	expSellVita = function(player)
		local expReq = changeXP2.getReqXPhealth2(player, player.baseClass)

		if player.baseHealth >= (player.baseMagic * 3) then
			player:sendMinitext("Your mental fortitude is too weak to undertake this training.")
			return
		end

		if player.level == 99 and player.class < 5 then
			if player.baseHealth >= 49999 then
				player:sendMinitext("Your body has reached its current limit. Seek training elsewhere.")
				return
			end
		elseif player.level >= 110 and player.level < 124 then
			if player.class < 6 then
				if player.baseHealth >= 185000 then
					player:sendMinitext("Your body has reached its current limit. Seek training elsewhere.")
					return
				end
			end
		elseif player.level >= 124 and player.level < 150 then
			if player.mark < 1 then
				if player.baseHealth >= 459500 then
					player:sendMinitext("Your body has reached its current limit. Seek training elsewhere.")
					return
				end
			end
		elseif player.level >= 150 and player.level < 175 then
			if player.mark < 2 then
				if player.baseHealth >= 1110000 then
					player:sendMinitext("Your body has reached its current limit. Seek training elsewhere.")
					return
				end
			end
		elseif player.level >= 175 and player.level < 200 then
			if player.mark < 3 then
				if player.baseHealth >= 1972500 then
					player:sendMinitext("Your body has reached its current limit. Seek training elsewhere.")
					return
				end
			end
		elseif player.level >= 200 and player.level < 225 then
			if player.mark < 4 then
				if player.baseHealth >= 3022500 then
					player:sendMinitext("Your body has reached its current limit. Seek training elsewhere.")
					return
				end
			end
		elseif player.level >= 225 and player.level < 250 then
			if player.mark < 5 then
				if player.baseHealth >= 4260000 then
					player:sendMinitext("Your body has reached its current limit. Seek training elsewhere.")
					return
				end
			end
		elseif player.level == 250 then
			if player.mark < 6 then
				if player.baseHealth >= 5685000 then
					player:sendMinitext("Your body has reached its current limit. Seek training elsewhere.")
					return
				end
			end
		end

		if player.registry["trainer_stop"] == 0 then
			if player.exp >= expReq then
				player.baseHealth = player.baseHealth + 50
				player.exp = player.exp - expReq
				player.registry["vita_sold"] = player.registry["vita_sold"] + 1
				player.expSold = player.expSold + expReq
				player:sendMinitext("Training session complete!")
				player:sendStatus()
				player:calcStat()
				player.registry["current_training_sessions"] = player.registry["current_training_sessions"] + 1
				changeXP2.checkLevelUp(player)
			else
				player:sendMinitext("You're out of EXP!")
				player.registry["trainer_stop"] = 1
			end
		elseif player.registry["trainer_stop"] == 1 then
			return
		end
	end,
	expSellMana = function(player)
		local expReq = changeXP2.getReqXPmagic2(player, player.baseClass)

		if player.baseMagic >= (player.baseHealth * 3) then
			player:sendMinitext("Your physical fortitude is too weak to undertake this training.")

			return
		end

		if player.level == 99 and player.class < 5 then
			if player.baseMagic >= 49999 then
				player:sendMinitext("Your body has reached its current limit. Seek training elsewhere.")
				return
			end
		elseif player.level >= 110 and player.level < 124 then
			if player.class < 6 then
				if player.baseMagic >= 185000 then
					player:sendMinitext("Your mind has reached its current limit. Seek training elsewhere.")
					return
				end
			end
		elseif player.level >= 124 and player.level < 150 then
			if player.mark < 1 then
				if player.baseMagic >= 459500 then
					player:sendMinitext("Your mind has reached its current limit. Seek training elsewhere.")
					return
				end
			end
		elseif player.level >= 150 and player.level < 175 then
			if player.mark < 2 then
				if player.baseMagic >= 1199500 then
					player:sendMinitext("Your mind has reached its current limit. Seek training elsewhere.")
					return
				end
			end
		elseif player.level >= 175 and player.level < 200 then
			if player.mark < 3 then
				if player.baseMagic >= 1972000 then
					player:sendMinitext("Your mind has reached its current limit. Seek training elsewhere.")
					return
				end
			end
		elseif player.level >= 200 and player.level < 225 then
			if player.mark < 4 then
				if player.baseMagic >= 3022000 then
					player:sendMinitext("Your mind has reached its current limit. Seek training elsewhere.")
					return
				end
			end
		elseif player.level >= 225 and player.level < 250 then
			if player.mark < 5 then
				if player.baseMagic >= 4259500 then
					player:sendMinitext("Your mind has reached its current limit. Seek training elsewhere.")
					return
				end
			end
		elseif player.level == 250 then
			if player.mark < 6 then
				if player.baseMagic >= 5684500 then
					player:sendMinitext("Your body has reached its current limit. Seek training elsewhere.")
					return
				end
			end
		end

		if player.registry["trainer_stop"] == 0 then
			if player.exp >= expReq then
				player.baseMagic = player.baseMagic + 50
				player.exp = player.exp - expReq
				player.registry["mana_sold"] = player.registry["mana_sold"] + 1
				player.expSold = player.expSold + expReq
				player:sendMinitext("Training session complete!")
				player:sendStatus()
				player:calcStat()
				player.registry["current_training_sessions"] = player.registry["current_training_sessions"] + 1
				changeXP2.checkLevelUp(player)
			else
				player:sendMinitext("You're out of EXP!")
				player.registry["trainer_stop"] = 1
			end
		elseif player.registry["trainer_stop"] == 1 then
			return
		end
	end,
	say = function(player, npc)
		local s = string.lower(player.speech)

		if
			(string.find(s, "(.*)thank you(.*)") or string.find(s, "(.*)terima kasih(.*)") or string.find(s, "(.*)tq(.*)") or
				string.find(s, "(.*)thx(.*)") or
				string.find(s, "(.*)ty(.*)"))
		 then
			if player.state ~= 1 then
				player:playSound(505)
				player.health = player.maxHealth
				player.magic = player.maxMagic
				player:calcStat()
				player:sendStatus()
				npc:talk(0, "" .. npc.name .. ": You're welcome " .. player.name .. "!")
			else
				npc:talk(0, "" .. npc.name .. ": For what?")
			end
		end
	end,
	nearbyPlayers = function(npc)
		local pc = npc:getObjectsInArea(BL_PC)
		local m, x, y = npc.m, npc.x, npc.y

		if #pc > 0 then
			for i = 1, #pc do
				if
					(pc[i].quest["dre_loc_rambles"] == 0 or pc[i].quest["dre_loc_rambles"] == 1 or pc[i].quest["dre_loc_rambles"] == 7) or
						(pc[i].level >= 5 and pc[i].quest["dre_loc_rambles"] == 9)
				 then
					pc[i]:selfAnimationXY(pc[i].ID, 248, x, y)
				end
			end
		end
	end
}

-- XP Exhange Rates ---------------------------------------------------------------------------------------------------------------------------

changeXP2 = {
	getReqXPhealth2 = function(player, class) -- Exp amount required for 1 time health exchange
		local hp = player.baseHealth
		local job = player.baseClass
		local req

		if job == 1 then -- Fighter
			if hp <= 20000 then
				req = 10000000
			end
			if hp > 20000 and hp <= 30000 then
				req = 12000000
			end
			if hp > 30000 and hp <= 40000 then
				req = 14000000
			end
			if hp > 40000 and hp <= 50000 then
				req = 16000000
			end
			if hp > 50000 and hp <= 60000 then
				req = 18000000
			end
			if hp > 60000 and hp <= 70000 then
				req = 20000000
			end
			if hp > 70000 and hp <= 80000 then
				req = 22000000
			end
			if hp > 80000 and hp <= 90000 then
				req = 24000000
			end
			if hp > 90000 and hp <= 100000 then
				req = 26000000
			end
			if hp > 100000 and hp <= 110000 then
				req = 28000000
			end
			if hp > 110000 and hp <= 120000 then
				req = 30000000
			end
			if hp > 120000 and hp <= 130000 then
				req = 32000000
			end
			if hp > 130000 and hp <= 140000 then
				req = 34000000
			end
			if hp > 140000 and hp <= 150000 then
				req = 36000000
			end
			if hp > 150000 and hp <= 160000 then
				req = 38000000
			end
			if hp > 160000 and hp <= 170000 then
				req = 40000000
			end
			if hp > 170000 and hp <= 180000 then
				req = 42000000
			end
			if hp > 180000 and hp <= 190000 then
				req = 44000000
			end
			if hp > 190000 and hp <= 200000 then
				req = 46000000
			end
			if hp > 200000 and hp <= 210000 then
				req = 48000000
			end
			if hp > 210000 and hp <= 220000 then
				req = 50000000
			end
			if hp > 220000 and hp <= 230000 then
				req = 52000000
			end
			if hp > 230000 and hp <= 240000 then
				req = 54000000
			end
			if hp > 240000 and hp <= 250000 then
				req = 56000000
			end
			if hp > 250000 and hp <= 260000 then
				req = 58000000
			end
			if hp > 260000 and hp <= 270000 then
				req = 60000000
			end
			if hp > 270000 and hp <= 280000 then
				req = 62000000
			end
			if hp > 280000 and hp <= 290000 then
				req = 64000000
			end
			if hp > 290000 and hp <= 300000 then
				req = 66000000
			end
			if hp > 300000 and hp <= 310000 then
				req = 68000000
			end
			if hp > 310000 and hp <= 320000 then
				req = 70000000
			end
			if hp > 320000 and hp <= 330000 then
				req = 72000000
			end
			if hp > 330000 and hp <= 340000 then
				req = 74000000
			end
			if hp > 340000 and hp <= 350000 then
				req = 76000000
			end
			if hp > 350000 and hp <= 360000 then
				req = 78000000
			end
			if hp > 360000 and hp <= 370000 then
				req = 80000000
			end
			if hp > 370000 and hp <= 380000 then
				req = 82000000
			end
			if hp > 380000 and hp <= 390000 then
				req = 84000000
			end
			if hp > 390000 and hp <= 400000 then
				req = 86000000
			end
			if hp > 400000 and hp <= 410000 then
				req = 88000000
			end
			if hp > 410000 and hp <= 420000 then
				req = 90000000
			end
			if hp > 420000 and hp <= 430000 then
				req = 92000000
			end
			if hp > 430000 and hp <= 440000 then
				req = 94000000
			end
			if hp > 440000 and hp <= 450000 then
				req = 96000000
			end
			if hp > 450000 and hp <= 460000 then
				req = 98000000
			end
			if hp > 460000 and hp <= 470000 then
				req = 100000000
			end
			if hp > 470000 and hp <= 480000 then
				req = 102000000
			end
			if hp > 480000 and hp <= 490000 then
				req = 104000000
			end
			if hp > 490000 and hp <= 500000 then
				req = 106000000
			end
			if hp > 500000 and hp <= 510000 then
				req = 108000000
			end
			if hp > 510000 and hp <= 520000 then
				req = 110000000
			end
			if hp > 520000 and hp <= 530000 then
				req = 112000000
			end
			if hp > 530000 and hp <= 540000 then
				req = 114000000
			end
			if hp > 540000 and hp <= 550000 then
				req = 116000000
			end
			if hp > 550000 and hp <= 560000 then
				req = 118000000
			end
			if hp > 560000 and hp <= 570000 then
				req = 120000000
			end
			if hp > 570000 and hp <= 580000 then
				req = 122000000
			end
			if hp > 580000 and hp <= 590000 then
				req = 124000000
			end
			if hp > 590000 and hp <= 600000 then
				req = 126000000
			end
			if hp > 600000 and hp <= 610000 then
				req = 128000000
			end
			if hp > 610000 and hp <= 620000 then
				req = 130000000
			end
			if hp > 620000 and hp <= 630000 then
				req = 132000000
			end
			if hp > 630000 and hp <= 640000 then
				req = 134000000
			end
			if hp > 640000 and hp <= 650000 then
				req = 136000000
			end
			if hp > 650000 and hp <= 660000 then
				req = 138000000
			end
			if hp > 660000 and hp <= 670000 then
				req = 140000000
			end
			if hp > 670000 and hp <= 680000 then
				req = 142000000
			end
			if hp > 680000 and hp <= 690000 then
				req = 144000000
			end
			if hp > 690000 and hp <= 700000 then
				req = 146000000
			end
			if hp > 700000 and hp <= 710000 then
				req = 148000000
			end
			if hp > 710000 and hp <= 720000 then
				req = 150000000
			end
			if hp > 720000 and hp <= 730000 then
				req = 152000000
			end
			if hp > 730000 and hp <= 740000 then
				req = 154000000
			end
			if hp > 740000 and hp <= 750000 then
				req = 156000000
			end
			if hp > 750000 and hp <= 760000 then
				req = 158000000
			end
			if hp > 760000 and hp <= 770000 then
				req = 160000000
			end
			if hp > 770000 and hp <= 780000 then
				req = 162000000
			end
			if hp > 780000 and hp <= 790000 then
				req = 164000000
			end
			if hp > 790000 and hp <= 800000 then
				req = 166000000
			end
			if hp > 800000 and hp <= 810000 then
				req = 168000000
			end
			if hp > 810000 and hp <= 820000 then
				req = 170000000
			end
			if hp > 820000 and hp <= 830000 then
				req = 172000000
			end
			if hp > 830000 and hp <= 840000 then
				req = 174000000
			end
			if hp > 840000 and hp <= 850000 then
				req = 176000000
			end
			if hp > 850000 and hp <= 860000 then
				req = 178000000
			end
			if hp > 860000 and hp <= 870000 then
				req = 180000000
			end
			if hp > 870000 and hp <= 880000 then
				req = 182000000
			end
			if hp > 880000 and hp <= 890000 then
				req = 184000000
			end
			if hp > 890000 and hp <= 900000 then
				req = 186000000
			end
			if hp > 900000 and hp <= 910000 then
				req = 188000000
			end
			if hp > 910000 and hp <= 920000 then
				req = 190000000
			end
			if hp > 920000 and hp <= 930000 then
				req = 192000000
			end
			if hp > 930000 and hp <= 940000 then
				req = 194000000
			end
			if hp > 940000 and hp <= 950000 then
				req = 196000000
			end
			if hp > 950000 and hp <= 960000 then
				req = 198000000
			end
			if hp > 960000 and hp <= 970000 then
				req = 200000000
			end
			if hp > 970000 and hp <= 980000 then
				req = 202000000
			end
			if hp > 980000 and hp <= 990000 then
				req = 204000000
			end
			if hp > 990000 and hp <= 1000000 then
				req = 206000000
			end
			if hp > 1000000 and hp <= 1010000 then
				req = 208000000
			end
			if hp > 1010000 and hp <= 1020000 then
				req = 210000000
			end
			if hp > 1020000 and hp <= 1030000 then
				req = 212000000
			end
			if hp > 1030000 and hp <= 1040000 then
				req = 214000000
			end
			if hp > 1040000 and hp <= 1050000 then
				req = 216000000
			end
			if hp > 1050000 and hp <= 1060000 then
				req = 218000000
			end
			if hp > 1060000 and hp <= 1070000 then
				req = 220000000
			end
			if hp > 1070000 and hp <= 1080000 then
				req = 222000000
			end
			if hp > 1080000 and hp <= 1090000 then
				req = 224000000
			end
			if hp > 1090000 and hp <= 1100000 then
				req = 226000000
			end
			if hp > 1100000 and hp <= 1110000 then
				req = 228000000
			end
			if hp > 1110000 and hp <= 1120000 then
				req = 230000000
			end
			if hp > 1120000 and hp <= 1130000 then
				req = 232000000
			end
			if hp > 1130000 and hp <= 1140000 then
				req = 234000000
			end
			if hp > 1140000 and hp <= 1150000 then
				req = 236000000
			end
			if hp > 1150000 and hp <= 1160000 then
				req = 238000000
			end
			if hp > 1160000 and hp <= 1170000 then
				req = 240000000
			end
			if hp > 1170000 and hp <= 1180000 then
				req = 242000000
			end
			if hp > 1180000 and hp <= 1190000 then
				req = 244000000
			end
			if hp > 1190000 and hp <= 1200000 then
				req = 246000000
			end
			if hp > 1200000 and hp <= 1210000 then
				req = 248000000
			end
			if hp > 1210000 and hp <= 1220000 then
				req = 250000000
			end
			if hp > 1220000 and hp <= 1230000 then
				req = 252000000
			end
			if hp > 1230000 and hp <= 1240000 then
				req = 254000000
			end
			if hp > 1240000 and hp <= 1250000 then
				req = 256000000
			end
			if hp > 1250000 and hp <= 1260000 then
				req = 258000000
			end
			if hp > 1260000 and hp <= 1270000 then
				req = 260000000
			end
			if hp > 1270000 and hp <= 1280000 then
				req = 262000000
			end
			if hp > 1280000 and hp <= 1290000 then
				req = 264000000
			end
			if hp > 1290000 and hp <= 1300000 then
				req = 266000000
			end
			if hp > 1300000 and hp <= 1310000 then
				req = 268000000
			end
			if hp > 1310000 and hp <= 1320000 then
				req = 270000000
			end
			if hp > 1320000 and hp <= 1330000 then
				req = 272000000
			end
			if hp > 1330000 and hp <= 1340000 then
				req = 274000000
			end
			if hp > 1340000 and hp <= 1350000 then
				req = 276000000
			end
			if hp > 1350000 and hp <= 1360000 then
				req = 278000000
			end
			if hp > 1360000 and hp <= 1370000 then
				req = 280000000
			end
			if hp > 1370000 and hp <= 1380000 then
				req = 282000000
			end
			if hp > 1380000 and hp <= 1390000 then
				req = 284000000
			end
			if hp > 1390000 and hp <= 1400000 then
				req = 286000000
			end
			if hp > 1400000 and hp <= 1410000 then
				req = 288000000
			end
			if hp > 1410000 and hp <= 1420000 then
				req = 290000000
			end
			if hp > 1420000 and hp <= 1430000 then
				req = 292000000
			end
			if hp > 1430000 and hp <= 1440000 then
				req = 294000000
			end
			if hp > 1440000 and hp <= 1450000 then
				req = 296000000
			end
			if hp > 1450000 and hp <= 1460000 then
				req = 298000000
			end
			if hp > 1460000 and hp <= 1470000 then
				req = 300000000
			end
			if hp > 1470000 and hp <= 1480000 then
				req = 302000000
			end
			if hp > 1480000 and hp <= 1490000 then
				req = 304000000
			end
			if hp > 1490000 and hp <= 1500000 then
				req = 306000000
			end
			if hp > 1500000 and hp <= 1510000 then
				req = 308000000
			end
			if hp > 1510000 and hp <= 1520000 then
				req = 310000000
			end
			if hp > 1520000 and hp <= 1530000 then
				req = 312000000
			end
			if hp > 1530000 and hp <= 1540000 then
				req = 314000000
			end
			if hp > 1540000 and hp <= 1550000 then
				req = 316000000
			end
			if hp > 1550000 and hp <= 1560000 then
				req = 318000000
			end
			if hp > 1560000 and hp <= 1570000 then
				req = 320000000
			end
			if hp > 1570000 and hp <= 1580000 then
				req = 322000000
			end
			if hp > 1580000 and hp <= 1590000 then
				req = 324000000
			end
			if hp > 1590000 and hp <= 1600000 then
				req = 326000000
			end
			if hp > 1600000 and hp <= 1610000 then
				req = 328000000
			end
			if hp > 1610000 and hp <= 1620000 then
				req = 330000000
			end
			if hp > 1620000 and hp <= 1630000 then
				req = 332000000
			end
			if hp > 1630000 and hp <= 1640000 then
				req = 334000000
			end
			if hp > 1640000 and hp <= 1650000 then
				req = 336000000
			end
			if hp > 1650000 and hp <= 1660000 then
				req = 338000000
			end
			if hp > 1660000 and hp <= 1670000 then
				req = 340000000
			end
			if hp > 1670000 and hp <= 1680000 then
				req = 342000000
			end
			if hp > 1680000 and hp <= 1690000 then
				req = 344000000
			end
			if hp > 1690000 and hp <= 1700000 then
				req = 346000000
			end
			if hp > 1700000 and hp <= 1710000 then
				req = 348000000
			end
			if hp > 1710000 and hp <= 1720000 then
				req = 350000000
			end
			if hp > 1720000 and hp <= 1730000 then
				req = 352000000
			end
			if hp > 1730000 and hp <= 1740000 then
				req = 354000000
			end
			if hp > 1740000 and hp <= 1750000 then
				req = 356000000
			end
			if hp > 1750000 and hp <= 1760000 then
				req = 358000000
			end
			if hp > 1760000 and hp <= 1770000 then
				req = 360000000
			end
			if hp > 1770000 and hp <= 1780000 then
				req = 362000000
			end
			if hp > 1780000 and hp <= 1790000 then
				req = 364000000
			end
			if hp > 1790000 and hp <= 1800000 then
				req = 366000000
			end
			if hp > 1800000 and hp <= 1810000 then
				req = 368000000
			end
			if hp > 1810000 and hp <= 1820000 then
				req = 370000000
			end
			if hp > 1820000 and hp <= 1830000 then
				req = 372000000
			end
			if hp > 1830000 and hp <= 1840000 then
				req = 374000000
			end
			if hp > 1840000 and hp <= 1850000 then
				req = 376000000
			end
			if hp > 1850000 and hp <= 1860000 then
				req = 378000000
			end
			if hp > 1860000 and hp <= 1870000 then
				req = 380000000
			end
			if hp > 1870000 and hp <= 1880000 then
				req = 382000000
			end
			if hp > 1880000 and hp <= 1890000 then
				req = 384000000
			end
			if hp > 1890000 and hp <= 1900000 then
				req = 386000000
			end
			if hp > 1900000 and hp <= 1910000 then
				req = 388000000
			end
			if hp > 1910000 and hp <= 1920000 then
				req = 390000000
			end
			if hp > 1920000 and hp <= 1930000 then
				req = 392000000
			end
			if hp > 1930000 and hp <= 1940000 then
				req = 394000000
			end
			if hp > 1940000 and hp <= 1950000 then
				req = 396000000
			end
			if hp > 1950000 and hp <= 1960000 then
				req = 398000000
			end
			if hp > 1960000 and hp <= 1970000 then
				req = 400000000
			end
			if hp > 1970000 and hp <= 1980000 then
				req = 402000000
			end
			if hp > 1980000 and hp <= 1990000 then
				req = 404000000
			end
			if hp > 1990000 and hp <= 2000000 then
				req = 406000000
			end
			if hp > 2000000 and hp <= 2010000 then
				req = 408000000
			end
			if hp > 2010000 and hp <= 2020000 then
				req = 410000000
			end
			if hp > 2020000 and hp <= 2030000 then
				req = 412000000
			end
			if hp > 2030000 and hp <= 2040000 then
				req = 414000000
			end
			if hp > 2040000 and hp <= 2050000 then
				req = 416000000
			end
			if hp > 2050000 and hp <= 2060000 then
				req = 418000000
			end
			if hp > 2060000 and hp <= 2070000 then
				req = 420000000
			end
			if hp > 2070000 and hp <= 2080000 then
				req = 422000000
			end
			if hp > 2080000 and hp <= 2090000 then
				req = 424000000
			end
			if hp > 2090000 and hp <= 2100000 then
				req = 426000000
			end
			if hp > 2100000 and hp <= 2110000 then
				req = 428000000
			end
			if hp > 2110000 and hp <= 2120000 then
				req = 430000000
			end
			if hp > 2120000 and hp <= 2130000 then
				req = 432000000
			end
			if hp > 2130000 and hp <= 2140000 then
				req = 434000000
			end
			if hp > 2140000 and hp <= 2150000 then
				req = 436000000
			end
			if hp > 2150000 and hp <= 2160000 then
				req = 438000000
			end
			if hp > 2160000 and hp <= 2170000 then
				req = 440000000
			end
			if hp > 2170000 and hp <= 2180000 then
				req = 442000000
			end
			if hp > 2180000 and hp <= 2190000 then
				req = 444000000
			end
			if hp > 2190000 and hp <= 2200000 then
				req = 446000000
			end
			if hp > 2200000 and hp <= 2210000 then
				req = 448000000
			end
			if hp > 2210000 and hp <= 2220000 then
				req = 450000000
			end
			if hp > 2220000 and hp <= 2230000 then
				req = 452000000
			end
			if hp > 2230000 and hp <= 2240000 then
				req = 454000000
			end
			if hp > 2240000 and hp <= 2250000 then
				req = 456000000
			end
			if hp > 2250000 and hp <= 2260000 then
				req = 458000000
			end
			if hp > 2260000 and hp <= 2270000 then
				req = 460000000
			end
			if hp > 2270000 and hp <= 2280000 then
				req = 462000000
			end
			if hp > 2280000 and hp <= 2290000 then
				req = 464000000
			end
			if hp > 2290000 and hp <= 2300000 then
				req = 466000000
			end
			if hp > 2300000 and hp <= 2310000 then
				req = 468000000
			end
			if hp > 2310000 and hp <= 2320000 then
				req = 470000000
			end
			if hp > 2320000 and hp <= 2330000 then
				req = 472000000
			end
			if hp > 2330000 and hp <= 2340000 then
				req = 474000000
			end
			if hp > 2340000 and hp <= 2350000 then
				req = 476000000
			end
			if hp > 2350000 and hp <= 2360000 then
				req = 478000000
			end
			if hp > 2360000 and hp <= 2370000 then
				req = 480000000
			end
			if hp > 2370000 and hp <= 2380000 then
				req = 482000000
			end
			if hp > 2380000 and hp <= 2390000 then
				req = 484000000
			end
			if hp > 2390000 and hp <= 2400000 then
				req = 486000000
			end
			if hp > 2400000 and hp <= 2410000 then
				req = 488000000
			end
			if hp > 2410000 and hp <= 2420000 then
				req = 490000000
			end
			if hp > 2420000 and hp <= 2430000 then
				req = 492000000
			end
			if hp > 2430000 and hp <= 2440000 then
				req = 494000000
			end
			if hp > 2440000 and hp <= 2450000 then
				req = 496000000
			end
			if hp > 2450000 and hp <= 2460000 then
				req = 498000000
			end
			if hp > 2460000 and hp <= 2470000 then
				req = 500000000
			end
			if hp > 2470000 and hp <= 2480000 then
				req = 502000000
			end
			if hp > 2480000 and hp <= 2490000 then
				req = 504000000
			end
			if hp > 2490000 and hp <= 2500000 then
				req = 506000000
			end
			if hp > 2500000 and hp <= 2510000 then
				req = 508000000
			end
			if hp > 2510000 and hp <= 2520000 then
				req = 510000000
			end
			if hp > 2520000 and hp <= 2530000 then
				req = 512000000
			end
			if hp > 2530000 and hp <= 2540000 then
				req = 514000000
			end
			if hp > 2540000 and hp <= 2550000 then
				req = 516000000
			end
			if hp > 2550000 and hp <= 2560000 then
				req = 518000000
			end
			if hp > 2560000 and hp <= 2570000 then
				req = 520000000
			end
			if hp > 2570000 and hp <= 2580000 then
				req = 522000000
			end
			if hp > 2580000 and hp <= 2590000 then
				req = 524000000
			end
			if hp > 2590000 and hp <= 2600000 then
				req = 526000000
			end
			if hp > 2600000 and hp <= 2610000 then
				req = 528000000
			end
			if hp > 2610000 and hp <= 2620000 then
				req = 490000000
			end
			if hp > 2620000 and hp <= 2630000 then
				req = 492000000
			end
			if hp > 2630000 and hp <= 2640000 then
				req = 494000000
			end
			if hp > 2640000 and hp <= 2650000 then
				req = 496000000
			end
			if hp > 2650000 and hp <= 2660000 then
				req = 498000000
			end
			if hp > 2660000 and hp <= 2670000 then
				req = 500000000
			end
			if hp > 2670000 and hp <= 2680000 then
				req = 502000000
			end
			if hp > 2680000 and hp <= 2690000 then
				req = 504000000
			end
			if hp > 2690000 and hp <= 2700000 then
				req = 506000000
			end
			if hp > 2700000 and hp <= 2710000 then
				req = 508000000
			end
			if hp > 2710000 and hp <= 2720000 then
				req = 510000000
			end
			if hp > 2720000 and hp <= 2730000 then
				req = 512000000
			end
			if hp > 2730000 and hp <= 2740000 then
				req = 514000000
			end
			if hp > 2740000 and hp <= 2750000 then
				req = 516000000
			end
			if hp > 2750000 and hp <= 2760000 then
				req = 518000000
			end
			if hp > 2760000 and hp <= 2770000 then
				req = 520000000
			end
			if hp > 2770000 and hp <= 2780000 then
				req = 522000000
			end
			if hp > 2780000 and hp <= 2790000 then
				req = 524000000
			end
			if hp > 2790000 and hp <= 2800000 then
				req = 526000000
			end
			if hp > 2800000 and hp <= 2810000 then
				req = 528000000
			end
			if hp > 2810000 and hp <= 2820000 then
				req = 530000000
			end
			if hp > 2820000 and hp <= 2830000 then
				req = 532000000
			end
			if hp > 2830000 and hp <= 2840000 then
				req = 534000000
			end
			if hp > 2840000 and hp <= 2850000 then
				req = 536000000
			end
			if hp > 2850000 and hp <= 2860000 then
				req = 538000000
			end
			if hp > 2860000 and hp <= 2870000 then
				req = 540000000
			end
			if hp > 2870000 and hp <= 2880000 then
				req = 542000000
			end
			if hp > 2880000 and hp <= 2890000 then
				req = 544000000
			end
			if hp > 2890000 and hp <= 2900000 then
				req = 546000000
			end
			if hp > 2900000 and hp <= 2910000 then
				req = 548000000
			end
			if hp > 2910000 and hp <= 2920000 then
				req = 550000000
			end
			if hp > 2920000 and hp <= 2930000 then
				req = 552000000
			end
			if hp > 2930000 and hp <= 2940000 then
				req = 554000000
			end
			if hp > 2940000 and hp <= 2950000 then
				req = 556000000
			end
			if hp > 2950000 and hp <= 2960000 then
				req = 558000000
			end
			if hp > 2960000 and hp <= 2970000 then
				req = 560000000
			end
			if hp > 2970000 and hp <= 2980000 then
				req = 562000000
			end
			if hp > 2980000 and hp <= 2990000 then
				req = 564000000
			end
			if hp > 2990000 and hp <= 3000000 then
				req = 566000000
			end
			if hp > 3000000 and hp <= 3010000 then
				req = 568000000
			end
			if hp > 3010000 and hp <= 3020000 then
				req = 570000000
			end
			if hp > 3020000 and hp <= 3030000 then
				req = 572000000
			end
			if hp > 3030000 and hp <= 3040000 then
				req = 574000000
			end
			if hp > 3040000 and hp <= 3050000 then
				req = 576000000
			end
			if hp > 3050000 and hp <= 3060000 then
				req = 578000000
			end
			if hp > 3060000 and hp <= 3070000 then
				req = 580000000
			end
			if hp > 3070000 and hp <= 3080000 then
				req = 582000000
			end
			if hp > 3080000 and hp <= 3090000 then
				req = 584000000
			end
			if hp > 3090000 and hp <= 3100000 then
				req = 586000000
			end
			if hp > 3100000 and hp <= 3110000 then
				req = 588000000
			end
			if hp > 3110000 and hp <= 3120000 then
				req = 590000000
			end
			if hp > 3120000 and hp <= 3130000 then
				req = 592000000
			end
			if hp > 3130000 and hp <= 3140000 then
				req = 594000000
			end
			if hp > 3140000 and hp <= 3150000 then
				req = 596000000
			end
			if hp > 3150000 and hp <= 3160000 then
				req = 598000000
			end
			if hp > 3160000 and hp <= 3170000 then
				req = 600000000
			end
			if hp > 3170000 and hp <= 3180000 then
				req = 602000000
			end
			if hp > 3180000 and hp <= 3190000 then
				req = 604000000
			end
			if hp > 3190000 and hp <= 3200000 then
				req = 606000000
			end
			if hp > 3200000 and hp <= 3210000 then
				req = 608000000
			end
			if hp > 3210000 and hp <= 3220000 then
				req = 610000000
			end
			if hp > 3220000 and hp <= 3230000 then
				req = 612000000
			end
			if hp > 3230000 and hp <= 3240000 then
				req = 614000000
			end
			if hp > 3240000 and hp <= 3250000 then
				req = 616000000
			end
			if hp > 3250000 and hp <= 3260000 then
				req = 618000000
			end
			if hp > 3260000 and hp <= 3270000 then
				req = 620000000
			end
			if hp > 3270000 and hp <= 3280000 then
				req = 622000000
			end
			if hp > 3280000 and hp <= 3290000 then
				req = 624000000
			end
			if hp > 3290000 and hp <= 3300000 then
				req = 626000000
			end
			if hp > 3300000 and hp <= 3310000 then
				req = 628000000
			end
			if hp > 3310000 and hp <= 3320000 then
				req = 630000000
			end
			if hp > 3320000 and hp <= 3330000 then
				req = 632000000
			end
			if hp > 3330000 and hp <= 3340000 then
				req = 634000000
			end
			if hp > 3340000 and hp <= 3350000 then
				req = 636000000
			end
			if hp > 3350000 and hp <= 3360000 then
				req = 638000000
			end
			if hp > 3360000 and hp <= 3370000 then
				req = 640000000
			end
			if hp > 3370000 and hp <= 3380000 then
				req = 642000000
			end
			if hp > 3380000 and hp <= 3390000 then
				req = 644000000
			end
			if hp > 3390000 and hp <= 3400000 then
				req = 646000000
			end
			if hp > 3400000 and hp <= 3410000 then
				req = 648000000
			end
			if hp > 3410000 and hp <= 3420000 then
				req = 650000000
			end
			if hp > 3420000 and hp <= 3430000 then
				req = 652000000
			end
			if hp > 3430000 and hp <= 3440000 then
				req = 654000000
			end
			if hp > 3440000 and hp <= 3450000 then
				req = 656000000
			end
			if hp > 3450000 and hp <= 3460000 then
				req = 658000000
			end
			if hp > 3460000 and hp <= 3470000 then
				req = 660000000
			end
			if hp > 3470000 and hp <= 3480000 then
				req = 662000000
			end
			if hp > 3480000 and hp <= 3490000 then
				req = 664000000
			end
			if hp > 3490000 and hp <= 3500000 then
				req = 666000000
			end
			if hp > 3500000 and hp <= 3510000 then
				req = 668000000
			end
			if hp > 3510000 and hp <= 3520000 then
				req = 670000000
			end
			if hp > 3520000 and hp <= 3530000 then
				req = 672000000
			end
			if hp > 3530000 and hp <= 3540000 then
				req = 674000000
			end
			if hp > 3540000 and hp <= 3550000 then
				req = 676000000
			end
			if hp > 3550000 and hp <= 3560000 then
				req = 678000000
			end
			if hp > 3560000 and hp <= 3570000 then
				req = 680000000
			end
			if hp > 3570000 and hp <= 3580000 then
				req = 682000000
			end
			if hp > 3580000 and hp <= 3590000 then
				req = 684000000
			end
			if hp > 3590000 and hp <= 3600000 then
				req = 686000000
			end
			if hp > 3600000 and hp <= 3610000 then
				req = 688000000
			end
			if hp > 3610000 and hp <= 3620000 then
				req = 690000000
			end
			if hp > 3620000 and hp <= 3630000 then
				req = 692000000
			end
			if hp > 3630000 and hp <= 3640000 then
				req = 694000000
			end
			if hp > 3640000 and hp <= 3650000 then
				req = 696000000
			end
			if hp > 3650000 and hp <= 3660000 then
				req = 698000000
			end
			if hp > 3660000 and hp <= 3670000 then
				req = 700000000
			end
			if hp > 3670000 and hp <= 3680000 then
				req = 702000000
			end
			if hp > 3680000 and hp <= 3690000 then
				req = 704000000
			end
			if hp > 3690000 and hp <= 3700000 then
				req = 706000000
			end
			if hp > 3700000 and hp <= 3710000 then
				req = 708000000
			end
			if hp > 3710000 and hp <= 3720000 then
				req = 710000000
			end
			if hp > 3720000 and hp <= 3730000 then
				req = 712000000
			end
			if hp > 3730000 and hp <= 3740000 then
				req = 714000000
			end
			if hp > 3740000 and hp <= 3750000 then
				req = 716000000
			end
			if hp > 3750000 and hp <= 3760000 then
				req = 718000000
			end
			if hp > 3760000 and hp <= 3770000 then
				req = 720000000
			end
			if hp > 3770000 and hp <= 3780000 then
				req = 722000000
			end
			if hp > 3780000 and hp <= 3790000 then
				req = 724000000
			end
			if hp > 3790000 and hp <= 3800000 then
				req = 726000000
			end
			if hp > 3800000 and hp <= 3810000 then
				req = 728000000
			end
			if hp > 3810000 and hp <= 3820000 then
				req = 730000000
			end
			if hp > 3820000 and hp <= 3830000 then
				req = 732000000
			end
			if hp > 3830000 and hp <= 3840000 then
				req = 734000000
			end
			if hp > 3840000 and hp <= 3850000 then
				req = 736000000
			end
			if hp > 3850000 and hp <= 3860000 then
				req = 738000000
			end
			if hp > 3860000 and hp <= 3870000 then
				req = 740000000
			end
			if hp > 3870000 and hp <= 3880000 then
				req = 742000000
			end
			if hp > 3880000 and hp <= 3890000 then
				req = 744000000
			end
			if hp > 3890000 and hp <= 3900000 then
				req = 746000000
			end
			if hp > 3900000 and hp <= 3910000 then
				req = 748000000
			end
			if hp > 3910000 and hp <= 3920000 then
				req = 750000000
			end
			if hp > 3920000 and hp <= 3930000 then
				req = 752000000
			end
			if hp > 3930000 and hp <= 3940000 then
				req = 754000000
			end
			if hp > 3940000 and hp <= 3950000 then
				req = 756000000
			end
			if hp > 3950000 and hp <= 3960000 then
				req = 758000000
			end
			if hp > 3960000 and hp <= 3970000 then
				req = 760000000
			end
			if hp > 3970000 and hp <= 3980000 then
				req = 762000000
			end
			if hp > 3980000 and hp <= 3990000 then
				req = 764000000
			end
			if hp > 3990000 and hp <= 4000000 then
				req = 766000000
			end
			if hp > 4000000 and hp <= 4010000 then
				req = 768000000
			end
			if hp > 4010000 and hp <= 4020000 then
				req = 770000000
			end
			if hp > 4020000 and hp <= 4030000 then
				req = 772000000
			end
			if hp > 4030000 and hp <= 4040000 then
				req = 774000000
			end
			if hp > 4040000 and hp <= 4050000 then
				req = 776000000
			end
			if hp > 4050000 and hp <= 4060000 then
				req = 778000000
			end
			if hp > 4060000 and hp <= 4070000 then
				req = 780000000
			end
			if hp > 4070000 and hp <= 4080000 then
				req = 782000000
			end
			if hp > 4080000 and hp <= 4090000 then
				req = 784000000
			end
			if hp > 4090000 and hp <= 4100000 then
				req = 786000000
			end
			if hp > 4100000 and hp <= 4110000 then
				req = 788000000
			end
			if hp > 4110000 and hp <= 4120000 then
				req = 790000000
			end
			if hp > 4120000 and hp <= 4130000 then
				req = 792000000
			end
			if hp > 4130000 and hp <= 4140000 then
				req = 794000000
			end
			if hp > 4140000 and hp <= 4150000 then
				req = 796000000
			end
			if hp > 4150000 and hp <= 4160000 then
				req = 798000000
			end
			if hp > 4160000 and hp <= 4170000 then
				req = 800000000
			end
			if hp > 4170000 and hp <= 4180000 then
				req = 802000000
			end
			if hp > 4180000 and hp <= 4190000 then
				req = 804000000
			end
			if hp > 4190000 and hp <= 4200000 then
				req = 806000000
			end
			if hp > 4200000 and hp <= 4210000 then
				req = 808000000
			end
			if hp > 4210000 and hp <= 4220000 then
				req = 810000000
			end
			if hp > 4220000 and hp <= 4230000 then
				req = 812000000
			end
			if hp > 4230000 and hp <= 4240000 then
				req = 814000000
			end
			if hp > 4240000 and hp <= 4250000 then
				req = 816000000
			end
			if hp > 4250000 and hp <= 4260000 then
				req = 818000000
			end
			if hp > 4260000 and hp <= 4270000 then
				req = 820000000
			end
			if hp > 4270000 and hp <= 4280000 then
				req = 822000000
			end
			if hp > 4280000 and hp <= 4290000 then
				req = 824000000
			end
			if hp > 4290000 and hp <= 4300000 then
				req = 826000000
			end
			if hp > 4300000 and hp <= 4310000 then
				req = 828000000
			end
			if hp > 4310000 and hp <= 4320000 then
				req = 830000000
			end
			if hp > 4320000 and hp <= 4330000 then
				req = 832000000
			end
			if hp > 4330000 and hp <= 4340000 then
				req = 834000000
			end
			if hp > 4340000 and hp <= 4350000 then
				req = 836000000
			end
			if hp > 4350000 and hp <= 4360000 then
				req = 838000000
			end
			if hp > 4360000 and hp <= 4370000 then
				req = 840000000
			end
			if hp > 4370000 and hp <= 4380000 then
				req = 842000000
			end
			if hp > 4380000 and hp <= 4390000 then
				req = 844000000
			end
			if hp > 4390000 and hp <= 4400000 then
				req = 846000000
			end
			if hp > 4400000 and hp <= 4410000 then
				req = 848000000
			end
			if hp > 4410000 and hp <= 4420000 then
				req = 850000000
			end
			if hp > 4420000 and hp <= 4430000 then
				req = 852000000
			end
			if hp > 4430000 and hp <= 4440000 then
				req = 854000000
			end
			if hp > 4440000 and hp <= 4450000 then
				req = 856000000
			end
			if hp > 4450000 and hp <= 4460000 then
				req = 858000000
			end
			if hp > 4460000 and hp <= 4470000 then
				req = 860000000
			end
			if hp > 4470000 and hp <= 4480000 then
				req = 862000000
			end
			if hp > 4480000 and hp <= 4490000 then
				req = 864000000
			end
			if hp > 4490000 and hp <= 4500000 then
				req = 866000000
			end
			if hp > 4500000 and hp <= 4510000 then
				req = 868000000
			end
			if hp > 4510000 and hp <= 4520000 then
				req = 870000000
			end
			if hp > 4520000 and hp <= 4530000 then
				req = 872000000
			end
			if hp > 4530000 and hp <= 4540000 then
				req = 874000000
			end
			if hp > 4540000 and hp <= 4550000 then
				req = 876000000
			end
			if hp > 4550000 and hp <= 4560000 then
				req = 878000000
			end
			if hp > 4560000 and hp <= 4570000 then
				req = 880000000
			end
			if hp > 4570000 and hp <= 4580000 then
				req = 882000000
			end
			if hp > 4580000 and hp <= 4590000 then
				req = 884000000
			end
			if hp > 4590000 and hp <= 4600000 then
				req = 886000000
			end
			if hp > 4600000 and hp <= 4610000 then
				req = 888000000
			end
			if hp > 4610000 and hp <= 4620000 then
				req = 890000000
			end
			if hp > 4620000 and hp <= 4630000 then
				req = 892000000
			end
			if hp > 4630000 and hp <= 4640000 then
				req = 894000000
			end
			if hp > 4640000 and hp <= 4650000 then
				req = 896000000
			end
			if hp > 4650000 and hp <= 4660000 then
				req = 898000000
			end
			if hp > 4660000 and hp <= 4670000 then
				req = 900000000
			end
			if hp > 4670000 and hp <= 4680000 then
				req = 902000000
			end
			if hp > 4680000 and hp <= 4690000 then
				req = 904000000
			end
			if hp > 4690000 and hp <= 4700000 then
				req = 906000000
			end
			if hp > 4700000 and hp <= 4710000 then
				req = 908000000
			end
			if hp > 4710000 and hp <= 4720000 then
				req = 910000000
			end
			if hp > 4720000 and hp <= 4730000 then
				req = 912000000
			end
			if hp > 4730000 and hp <= 4740000 then
				req = 914000000
			end
			if hp > 4740000 and hp <= 4750000 then
				req = 916000000
			end
			if hp > 4750000 and hp <= 4760000 then
				req = 918000000
			end
			if hp > 4760000 and hp <= 4770000 then
				req = 920000000
			end
			if hp > 4770000 and hp <= 4780000 then
				req = 922000000
			end
			if hp > 4780000 and hp <= 4790000 then
				req = 924000000
			end
			if hp > 4790000 and hp <= 4800000 then
				req = 926000000
			end
			if hp > 4800000 and hp <= 4810000 then
				req = 928000000
			end
			if hp > 4810000 and hp <= 4820000 then
				req = 930000000
			end
			if hp > 4820000 and hp <= 4830000 then
				req = 932000000
			end
			if hp > 4830000 and hp <= 4840000 then
				req = 934000000
			end
			if hp > 4840000 and hp <= 4850000 then
				req = 936000000
			end
			if hp > 4850000 and hp <= 4860000 then
				req = 938000000
			end
			if hp > 4860000 and hp <= 4870000 then
				req = 940000000
			end
			if hp > 4870000 and hp <= 4880000 then
				req = 942000000
			end
			if hp > 4880000 and hp <= 4890000 then
				req = 944000000
			end
			if hp > 4890000 and hp <= 4900000 then
				req = 946000000
			end
			if hp > 4900000 and hp <= 4910000 then
				req = 948000000
			end
			if hp > 4910000 and hp <= 4920000 then
				req = 950000000
			end
			if hp > 4920000 and hp <= 4930000 then
				req = 952000000
			end
			if hp > 4930000 and hp <= 4940000 then
				req = 954000000
			end
			if hp > 4940000 and hp <= 4950000 then
				req = 956000000
			end
			if hp > 4950000 and hp <= 4960000 then
				req = 958000000
			end
			if hp > 4960000 and hp <= 4970000 then
				req = 960000000
			end
			if hp > 4970000 and hp <= 4980000 then
				req = 962000000
			end
			if hp > 4980000 and hp <= 4990000 then
				req = 964000000
			end
			if hp > 4990000 and hp <= 5000000 then
				req = 966000000
			end
			if hp > 5000000 and hp <= 5010000 then
				req = 968000000
			end
			if hp > 5010000 and hp <= 5020000 then
				req = 970000000
			end
			if hp > 5020000 and hp <= 5030000 then
				req = 972000000
			end
			if hp > 5030000 and hp <= 5040000 then
				req = 974000000
			end
			if hp > 5040000 and hp <= 5050000 then
				req = 976000000
			end
			if hp > 5050000 and hp <= 5060000 then
				req = 978000000
			end
			if hp > 5060000 and hp <= 5070000 then
				req = 980000000
			end
			if hp > 5070000 and hp <= 5080000 then
				req = 982000000
			end
			if hp > 5080000 and hp <= 5090000 then
				req = 984000000
			end
			if hp > 5090000 and hp <= 5100000 then
				req = 986000000
			end
			if hp > 5100000 and hp <= 5110000 then
				req = 988000000
			end
			if hp > 5110000 and hp <= 5120000 then
				req = 990000000
			end
			if hp > 5120000 and hp <= 5130000 then
				req = 992000000
			end
			if hp > 5130000 and hp <= 5140000 then
				req = 994000000
			end
			if hp > 5140000 and hp <= 5150000 then
				req = 996000000
			end
			if hp > 5150000 and hp <= 5160000 then
				req = 998000000
			end
			if hp > 5160000 and hp <= 5170000 then
				req = 1000000000
			end
			if hp > 5170000 and hp <= 5180000 then
				req = 1002000000
			end
			if hp > 5180000 and hp <= 5190000 then
				req = 1004000000
			end
			if hp > 5190000 and hp <= 5200000 then
				req = 1006000000
			end
			if hp > 5200000 and hp <= 5210000 then
				req = 1008000000
			end
			if hp > 5210000 and hp <= 5220000 then
				req = 1010000000
			end
			if hp > 5220000 and hp <= 5230000 then
				req = 1012000000
			end
			if hp > 5230000 and hp <= 5240000 then
				req = 1014000000
			end
			if hp > 5240000 and hp <= 5250000 then
				req = 1016000000
			end
			if hp > 5250000 and hp <= 5260000 then
				req = 1018000000
			end
			if hp > 5260000 and hp <= 5270000 then
				req = 1020000000
			end
			if hp > 5270000 and hp <= 5280000 then
				req = 1022000000
			end
			if hp > 5280000 and hp <= 5290000 then
				req = 1024000000
			end
			if hp > 5290000 and hp <= 5300000 then
				req = 1026000000
			end
			if hp > 5300000 and hp <= 5310000 then
				req = 1028000000
			end
			if hp > 5310000 and hp <= 5320000 then
				req = 1030000000
			end
			if hp > 5320000 and hp <= 5330000 then
				req = 1032000000
			end
			if hp > 5330000 and hp <= 5340000 then
				req = 1034000000
			end
			if hp > 5340000 and hp <= 5350000 then
				req = 1036000000
			end
			if hp > 5350000 and hp <= 5360000 then
				req = 1038000000
			end
			if hp > 5360000 and hp <= 5370000 then
				req = 1040000000
			end
			if hp > 5370000 and hp <= 5380000 then
				req = 1042000000
			end
			if hp > 5380000 and hp <= 5390000 then
				req = 1044000000
			end
			if hp > 5390000 and hp <= 5400000 then
				req = 1046000000
			end
			if hp > 5400000 and hp <= 5410000 then
				req = 1048000000
			end
			if hp > 5410000 and hp <= 5420000 then
				req = 1050000000
			end
			if hp > 5420000 and hp <= 5430000 then
				req = 1052000000
			end
			if hp > 5430000 and hp <= 5440000 then
				req = 1054000000
			end
			if hp > 5440000 and hp <= 5450000 then
				req = 1056000000
			end
			if hp > 5450000 and hp <= 5460000 then
				req = 1058000000
			end
			if hp > 5460000 and hp <= 5470000 then
				req = 1060000000
			end
			if hp > 5470000 and hp <= 5480000 then
				req = 1062000000
			end
			if hp > 5480000 and hp <= 5490000 then
				req = 1064000000
			end
			if hp > 5490000 and hp <= 5500000 then
				req = 1066000000
			end
			if hp > 5500000 and hp <= 5510000 then
				req = 1068000000
			end
			if hp > 5510000 and hp <= 5520000 then
				req = 1070000000
			end
			if hp > 5520000 and hp <= 5530000 then
				req = 1072000000
			end
			if hp > 5530000 and hp <= 5540000 then
				req = 1074000000
			end
			if hp > 5540000 and hp <= 5550000 then
				req = 1076000000
			end
			if hp > 5550000 and hp <= 5560000 then
				req = 1078000000
			end
			if hp > 5560000 and hp <= 5570000 then
				req = 1080000000
			end
			if hp > 5570000 and hp <= 5580000 then
				req = 1082000000
			end
			if hp > 5580000 and hp <= 5590000 then
				req = 1084000000
			end
			if hp > 5590000 and hp <= 5600000 then
				req = 1086000000
			end
			if hp > 5600000 and hp <= 5610000 then
				req = 1088000000
			end
			if hp > 5610000 and hp <= 5620000 then
				req = 1090000000
			end
			if hp > 5620000 and hp <= 5630000 then
				req = 1092000000
			end
			if hp > 5630000 and hp <= 5640000 then
				req = 1094000000
			end
			if hp > 5640000 and hp <= 5650000 then
				req = 1096000000
			end
			if hp > 5650000 and hp <= 5660000 then
				req = 1098000000
			end
			if hp > 5660000 and hp <= 5670000 then
				req = 1100000000
			end
			if hp > 5670000 and hp <= 5680000 then
				req = 1102000000
			end
			if hp > 5680000 and hp <= 5690000 then
				req = 1104000000
			end
			if hp > 5690000 and hp <= 5700000 then
				req = 1106000000
			end
			if hp > 5700000 and hp <= 5710000 then
				req = 1108000000
			end
			if hp > 5710000 and hp <= 5720000 then
				req = 1110000000
			end
			if hp > 5720000 and hp <= 5730000 then
				req = 1112000000
			end
			if hp > 5730000 and hp <= 5740000 then
				req = 1114000000
			end
			if hp > 5740000 and hp <= 5750000 then
				req = 1116000000
			end
			if hp > 5750000 and hp <= 5760000 then
				req = 1118000000
			end
			if hp > 5760000 and hp <= 5770000 then
				req = 1120000000
			end
			if hp > 5770000 and hp <= 5780000 then
				req = 1122000000
			end
			if hp > 5780000 and hp <= 5790000 then
				req = 1124000000
			end
			if hp > 5790000 and hp <= 5800000 then
				req = 1126000000
			end
			if hp > 5800000 and hp <= 5810000 then
				req = 1128000000
			end
			if hp > 5810000 and hp <= 5820000 then
				req = 1130000000
			end
			if hp > 5820000 and hp <= 5830000 then
				req = 1132000000
			end
			if hp > 5830000 and hp <= 5840000 then
				req = 1134000000
			end
			if hp > 5840000 and hp <= 5850000 then
				req = 1136000000
			end
			if hp > 5850000 and hp <= 5860000 then
				req = 1138000000
			end
			if hp > 5860000 and hp <= 5870000 then
				req = 1140000000
			end
			if hp > 5870000 and hp <= 5880000 then
				req = 1142000000
			end
			if hp > 5880000 and hp <= 5890000 then
				req = 1144000000
			end
			if hp > 5890000 and hp <= 5900000 then
				req = 1146000000
			end
			if hp > 5900000 and hp <= 5910000 then
				req = 1148000000
			end
			if hp > 5910000 and hp <= 5920000 then
				req = 1150000000
			end
			if hp > 5920000 and hp <= 5930000 then
				req = 1152000000
			end
			if hp > 5930000 and hp <= 5940000 then
				req = 1154000000
			end
			if hp > 5940000 and hp <= 5950000 then
				req = 1156000000
			end
			if hp > 5950000 and hp <= 5960000 then
				req = 1158000000
			end
			if hp > 5960000 and hp <= 5970000 then
				req = 1160000000
			end
			if hp > 5970000 and hp <= 5980000 then
				req = 1162000000
			end
			if hp > 5980000 and hp <= 5990000 then
				req = 1164000000
			end
			if hp > 5990000 and hp <= 6000000 then
				req = 1166000000
			end
			if hp > 6000000 and hp <= 6010000 then
				req = 1168000000
			end
			if hp > 6010000 and hp <= 6020000 then
				req = 1170000000
			end
			if hp > 6020000 and hp <= 6030000 then
				req = 1172000000
			end
			if hp > 6030000 and hp <= 6040000 then
				req = 1174000000
			end
			if hp > 6040000 and hp <= 6050000 then
				req = 1176000000
			end
			if hp > 6050000 and hp <= 6060000 then
				req = 1178000000
			end
			if hp > 6060000 and hp <= 6070000 then
				req = 1180000000
			end
			if hp > 6070000 and hp <= 6080000 then
				req = 1182000000
			end
			if hp > 6080000 and hp <= 6090000 then
				req = 1184000000
			end
			if hp > 6090000 and hp <= 6100000 then
				req = 1186000000
			end
			if hp > 6100000 and hp <= 6110000 then
				req = 1188000000
			end
			if hp > 6110000 and hp <= 6120000 then
				req = 1190000000
			end
			if hp > 6120000 and hp <= 6130000 then
				req = 1192000000
			end
			if hp > 6130000 and hp <= 6140000 then
				req = 1194000000
			end
			if hp > 6140000 and hp <= 6150000 then
				req = 1196000000
			end
			if hp > 6150000 and hp <= 6160000 then
				req = 1198000000
			end
			if hp > 6160000 and hp <= 6170000 then
				req = 1200000000
			end
			if hp > 6170000 and hp <= 6180000 then
				req = 1202000000
			end
			if hp > 6180000 and hp <= 6190000 then
				req = 1204000000
			end
			if hp > 6190000 and hp <= 6200000 then
				req = 1206000000
			end
			if hp > 6200000 and hp <= 6210000 then
				req = 1208000000
			end
			if hp > 6210000 and hp <= 6220000 then
				req = 1210000000
			end
			if hp > 6220000 and hp <= 6230000 then
				req = 1212000000
			end
			if hp > 6230000 and hp <= 6240000 then
				req = 1214000000
			end
			if hp > 6240000 and hp <= 6250000 then
				req = 1216000000
			end
			if hp > 6250000 and hp <= 6260000 then
				req = 1218000000
			end
			if hp > 6260000 and hp <= 6270000 then
				req = 1220000000
			end
			if hp > 6270000 and hp <= 6280000 then
				req = 1222000000
			end
			if hp > 6280000 and hp <= 6290000 then
				req = 1224000000
			end
			if hp > 6290000 and hp <= 6300000 then
				req = 1226000000
			end
			if hp > 6300000 and hp <= 6310000 then
				req = 1228000000
			end
			if hp > 6310000 and hp <= 6320000 then
				req = 1230000000
			end
			if hp > 6320000 and hp <= 6330000 then
				req = 1232000000
			end
			if hp > 6330000 and hp <= 6340000 then
				req = 1234000000
			end
			if hp > 6340000 and hp <= 6350000 then
				req = 1236000000
			end
			if hp > 6350000 and hp <= 6360000 then
				req = 1238000000
			end
			if hp > 6360000 and hp <= 6370000 then
				req = 1240000000
			end
			if hp > 6370000 and hp <= 6380000 then
				req = 1242000000
			end
			if hp > 6380000 and hp <= 6390000 then
				req = 1244000000
			end
			if hp > 6390000 and hp <= 6400000 then
				req = 1246000000
			end
			if hp > 6400000 and hp <= 6410000 then
				req = 1248000000
			end
			if hp > 6410000 and hp <= 6420000 then
				req = 1250000000
			end
			if hp > 6420000 and hp <= 6430000 then
				req = 1252000000
			end
			if hp > 6430000 and hp <= 6440000 then
				req = 1254000000
			end
			if hp > 6440000 and hp <= 6450000 then
				req = 1256000000
			end
			if hp > 6450000 and hp <= 6460000 then
				req = 1258000000
			end
			if hp > 6460000 and hp <= 6470000 then
				req = 1260000000
			end
			if hp > 6470000 and hp <= 6480000 then
				req = 1262000000
			end
			if hp > 6480000 and hp <= 6490000 then
				req = 1264000000
			end
			if hp > 6490000 and hp <= 6500000 then
				req = 1266000000
			end
			if hp > 6500000 and hp <= 6510000 then
				req = 1268000000
			end
			if hp > 6510000 and hp <= 6520000 then
				req = 1270000000
			end
			if hp > 6520000 and hp <= 6530000 then
				req = 1272000000
			end
			if hp > 6530000 and hp <= 6540000 then
				req = 1274000000
			end
			if hp > 6540000 and hp <= 6550000 then
				req = 1276000000
			end
			if hp > 6550000 and hp <= 6560000 then
				req = 1278000000
			end
			if hp > 6560000 and hp <= 6570000 then
				req = 1280000000
			end
			if hp > 6570000 and hp <= 6580000 then
				req = 1282000000
			end
			if hp > 6580000 and hp <= 6590000 then
				req = 1284000000
			end
			if hp > 6590000 and hp <= 6600000 then
				req = 1286000000
			end
			if hp > 6600000 and hp <= 6610000 then
				req = 1288000000
			end
			if hp > 6610000 and hp <= 6620000 then
				req = 1290000000
			end
			if hp > 6620000 and hp <= 6630000 then
				req = 1292000000
			end
			if hp > 6630000 and hp <= 6640000 then
				req = 1294000000
			end
			if hp > 6640000 and hp <= 6650000 then
				req = 1296000000
			end
			if hp > 6650000 and hp <= 6660000 then
				req = 1298000000
			end
			if hp > 6660000 and hp <= 6670000 then
				req = 1300000000
			end
			if hp > 6670000 and hp <= 6680000 then
				req = 1302000000
			end
			if hp > 6680000 and hp <= 6690000 then
				req = 1304000000
			end
			if hp > 6690000 and hp <= 6700000 then
				req = 1306000000
			end
			if hp > 6700000 and hp <= 6710000 then
				req = 1308000000
			end
			if hp > 6710000 and hp <= 6720000 then
				req = 1310000000
			end
			if hp > 6720000 and hp <= 6730000 then
				req = 1312000000
			end
			if hp > 6730000 and hp <= 6740000 then
				req = 1314000000
			end
			if hp > 6740000 and hp <= 6750000 then
				req = 1316000000
			end
			if hp > 6750000 and hp <= 6760000 then
				req = 1318000000
			end
			if hp > 6760000 and hp <= 6770000 then
				req = 1320000000
			end
			if hp > 6770000 and hp <= 6780000 then
				req = 1322000000
			end
			if hp > 6780000 and hp <= 6790000 then
				req = 1324000000
			end
			if hp > 6790000 and hp <= 6800000 then
				req = 1326000000
			end
			if hp > 6800000 and hp <= 6810000 then
				req = 1328000000
			end
			if hp > 6810000 and hp <= 6820000 then
				req = 1330000000
			end
			if hp > 6820000 and hp <= 6830000 then
				req = 1332000000
			end
			if hp > 6830000 and hp <= 6840000 then
				req = 1334000000
			end
			if hp > 6840000 and hp <= 6850000 then
				req = 1336000000
			end
			if hp > 6850000 and hp <= 6860000 then
				req = 1338000000
			end
			if hp > 6860000 and hp <= 6870000 then
				req = 1340000000
			end
			if hp > 6870000 and hp <= 6880000 then
				req = 1342000000
			end
			if hp > 6880000 and hp <= 6890000 then
				req = 1344000000
			end
			if hp > 6890000 and hp <= 6900000 then
				req = 1346000000
			end
			if hp > 6900000 and hp <= 6910000 then
				req = 1348000000
			end
			if hp > 6910000 and hp <= 6920000 then
				req = 1350000000
			end
			if hp > 6920000 and hp <= 6930000 then
				req = 1352000000
			end
			if hp > 6930000 and hp <= 6940000 then
				req = 1354000000
			end
			if hp > 6940000 and hp <= 6950000 then
				req = 1356000000
			end
			if hp > 6950000 and hp <= 6960000 then
				req = 1358000000
			end
			if hp > 6960000 and hp <= 6970000 then
				req = 1360000000
			end
			if hp > 6970000 and hp <= 6980000 then
				req = 1362000000
			end
			if hp > 6980000 and hp <= 6990000 then
				req = 1364000000
			end
			if hp > 6990000 and hp <= 7000000 then
				req = 1366000000
			end
			if hp > 7000000 and hp <= 7010000 then
				req = 1368000000
			end
			if hp > 7010000 and hp <= 7020000 then
				req = 1370000000
			end
			if hp > 7020000 and hp <= 7030000 then
				req = 1372000000
			end
			if hp > 7030000 and hp <= 7040000 then
				req = 1374000000
			end
			if hp > 7040000 and hp <= 7050000 then
				req = 1376000000
			end
			if hp > 7050000 and hp <= 7060000 then
				req = 1378000000
			end
			if hp > 7060000 and hp <= 7070000 then
				req = 1380000000
			end
			if hp > 7070000 and hp <= 7080000 then
				req = 1382000000
			end
			if hp > 7080000 and hp <= 7090000 then
				req = 1384000000
			end
			if hp > 7090000 and hp <= 7100000 then
				req = 1386000000
			end
			if hp > 7100000 and hp <= 7110000 then
				req = 1388000000
			end
			if hp > 7110000 and hp <= 7120000 then
				req = 1390000000
			end
			if hp > 7120000 and hp <= 7130000 then
				req = 1392000000
			end
			if hp > 7130000 and hp <= 7140000 then
				req = 1394000000
			end
			if hp > 7140000 and hp <= 7150000 then
				req = 1396000000
			end
			if hp > 7150000 and hp <= 7160000 then
				req = 1398000000
			end
			if hp > 7160000 and hp <= 7170000 then
				req = 1400000000
			end
			if hp > 7170000 and hp <= 7180000 then
				req = 1402000000
			end
			if hp > 7180000 and hp <= 7190000 then
				req = 1404000000
			end
			if hp > 7190000 and hp <= 7200000 then
				req = 1406000000
			end
			if hp > 7200000 and hp <= 7210000 then
				req = 1408000000
			end
			if hp > 7210000 and hp <= 7220000 then
				req = 1410000000
			end
			if hp > 7220000 and hp <= 7230000 then
				req = 1412000000
			end
			if hp > 7230000 and hp <= 7240000 then
				req = 1414000000
			end
			if hp > 7240000 and hp <= 7250000 then
				req = 1416000000
			end
			if hp > 7250000 and hp <= 7260000 then
				req = 1418000000
			end
			if hp > 7260000 and hp <= 7270000 then
				req = 1420000000
			end
			if hp > 7270000 and hp <= 7280000 then
				req = 1422000000
			end
			if hp > 7280000 and hp <= 7290000 then
				req = 1424000000
			end
			if hp > 7290000 and hp <= 7300000 then
				req = 1426000000
			end
			if hp > 7300000 and hp <= 7310000 then
				req = 1428000000
			end
			if hp > 7310000 and hp <= 7320000 then
				req = 1430000000
			end
			if hp > 7320000 and hp <= 7330000 then
				req = 1432000000
			end
			if hp > 7330000 and hp <= 7340000 then
				req = 1434000000
			end
			if hp > 7340000 and hp <= 7350000 then
				req = 1436000000
			end
			if hp > 7350000 and hp <= 7360000 then
				req = 1438000000
			end
			if hp > 7360000 and hp <= 7370000 then
				req = 1440000000
			end
			if hp > 7370000 and hp <= 7380000 then
				req = 1442000000
			end
			if hp > 7380000 and hp <= 7390000 then
				req = 1444000000
			end
			if hp > 7390000 and hp <= 7400000 then
				req = 1446000000
			end
			if hp > 7400000 and hp <= 7410000 then
				req = 1448000000
			end
			if hp > 7410000 and hp <= 7420000 then
				req = 1450000000
			end
			if hp > 7420000 and hp <= 7430000 then
				req = 1452000000
			end
			if hp > 7430000 and hp <= 7440000 then
				req = 1454000000
			end
			if hp > 7440000 and hp <= 7450000 then
				req = 1456000000
			end
			if hp > 7450000 and hp <= 7460000 then
				req = 1458000000
			end
			if hp > 7460000 and hp <= 7470000 then
				req = 1460000000
			end
			if hp > 7470000 and hp <= 7480000 then
				req = 1462000000
			end
			if hp > 7480000 and hp <= 7490000 then
				req = 1464000000
			end
			if hp > 7490000 and hp <= 7500000 then
				req = 1466000000
			end
			if hp > 7500000 and hp <= 7510000 then
				req = 1468000000
			end
			if hp > 7510000 and hp <= 7520000 then
				req = 1470000000
			end
			if hp > 7520000 and hp <= 7530000 then
				req = 1472000000
			end
			if hp > 7530000 and hp <= 7540000 then
				req = 1474000000
			end
			if hp > 7540000 and hp <= 7550000 then
				req = 1476000000
			end
			if hp > 7550000 and hp <= 7560000 then
				req = 1478000000
			end
			if hp > 7560000 and hp <= 7570000 then
				req = 1480000000
			end
			if hp > 7570000 and hp <= 7580000 then
				req = 1482000000
			end
			if hp > 7580000 and hp <= 7590000 then
				req = 1484000000
			end
			if hp > 7590000 and hp <= 7600000 then
				req = 1486000000
			end
			if hp > 7600000 and hp <= 7610000 then
				req = 1488000000
			end
			if hp > 7610000 and hp <= 7620000 then
				req = 1490000000
			end
			if hp > 7620000 and hp <= 7630000 then
				req = 1492000000
			end
			if hp > 7630000 and hp <= 7640000 then
				req = 1494000000
			end
			if hp > 7640000 and hp <= 7650000 then
				req = 1496000000
			end
			if hp > 7650000 and hp <= 7660000 then
				req = 1498000000
			end
			if hp > 7660000 and hp <= 7670000 then
				req = 1500000000
			end
			if hp > 7670000 and hp <= 7680000 then
				req = 1502000000
			end
			if hp > 7680000 and hp <= 7690000 then
				req = 1504000000
			end
			if hp > 7690000 and hp <= 7700000 then
				req = 1506000000
			end
			if hp > 7700000 and hp <= 7710000 then
				req = 1508000000
			end
			if hp > 7710000 and hp <= 7720000 then
				req = 1510000000
			end
			if hp > 7720000 and hp <= 7730000 then
				req = 1512000000
			end
			if hp > 7730000 and hp <= 7740000 then
				req = 1514000000
			end
			if hp > 7740000 and hp <= 7750000 then
				req = 1516000000
			end
			if hp > 7750000 and hp <= 7760000 then
				req = 1518000000
			end
			if hp > 7760000 and hp <= 7770000 then
				req = 1520000000
			end
			if hp > 7770000 and hp <= 7780000 then
				req = 1522000000
			end
			if hp > 7780000 and hp <= 7790000 then
				req = 1524000000
			end
			if hp > 7790000 and hp <= 7800000 then
				req = 1526000000
			end
			if hp > 7800000 and hp <= 7810000 then
				req = 1528000000
			end
			if hp > 7810000 and hp <= 7820000 then
				req = 1530000000
			end
			if hp > 7820000 and hp <= 7830000 then
				req = 1532000000
			end
			if hp > 7830000 and hp <= 7840000 then
				req = 1534000000
			end
			if hp > 7840000 and hp <= 7850000 then
				req = 1536000000
			end
			if hp > 7850000 and hp <= 7860000 then
				req = 1538000000
			end
			if hp > 7860000 and hp <= 7870000 then
				req = 1540000000
			end
			if hp > 7870000 and hp <= 7880000 then
				req = 1542000000
			end
			if hp > 7880000 and hp <= 7890000 then
				req = 1544000000
			end
			if hp > 7890000 and hp <= 7900000 then
				req = 1546000000
			end
			if hp > 7900000 and hp <= 7910000 then
				req = 1548000000
			end
			if hp > 7910000 and hp <= 7920000 then
				req = 1550000000
			end
			if hp > 7920000 and hp <= 7930000 then
				req = 1552000000
			end
			if hp > 7930000 and hp <= 7940000 then
				req = 1554000000
			end
			if hp > 7940000 and hp <= 7950000 then
				req = 1556000000
			end
			if hp > 7950000 and hp <= 7960000 then
				req = 1558000000
			end
			if hp > 7960000 and hp <= 7970000 then
				req = 1560000000
			end
			if hp > 7970000 and hp <= 7980000 then
				req = 1562000000
			end
			if hp > 7980000 and hp <= 7990000 then
				req = 1564000000
			end
			if hp > 7990000 and hp <= 8000000 then
				req = 1566000000
			end
			if hp > 8000000 and hp <= 8010000 then
				req = 1568000000
			end
			if hp > 8010000 and hp <= 8020000 then
				req = 1570000000
			end
			if hp > 8020000 and hp <= 8030000 then
				req = 1572000000
			end
			if hp > 8030000 and hp <= 8040000 then
				req = 1574000000
			end
			if hp > 8040000 and hp <= 8050000 then
				req = 1576000000
			end
			if hp > 8050000 and hp <= 8060000 then
				req = 1578000000
			end
			if hp > 8060000 and hp <= 8070000 then
				req = 1580000000
			end
			if hp > 8070000 and hp <= 8080000 then
				req = 1582000000
			end
			if hp > 8080000 and hp <= 8090000 then
				req = 1584000000
			end
			if hp > 8090000 and hp <= 8100000 then
				req = 1586000000
			end
			if hp > 8100000 and hp <= 8110000 then
				req = 1588000000
			end
			if hp > 8110000 and hp <= 8120000 then
				req = 1590000000
			end
			if hp > 8120000 and hp <= 8130000 then
				req = 1592000000
			end
			if hp > 8130000 and hp <= 8140000 then
				req = 1594000000
			end
			if hp > 8140000 and hp <= 8150000 then
				req = 1596000000
			end
			if hp > 8150000 and hp <= 8160000 then
				req = 1598000000
			end
			if hp > 8160000 and hp <= 8170000 then
				req = 1600000000
			end
			if hp > 8170000 and hp <= 8180000 then
				req = 1602000000
			end
			if hp > 8180000 and hp <= 8190000 then
				req = 1604000000
			end
			if hp > 8190000 and hp <= 8200000 then
				req = 1606000000
			end
			if hp > 8200000 and hp <= 8210000 then
				req = 1608000000
			end
			if hp > 8210000 and hp <= 8220000 then
				req = 1610000000
			end
			if hp > 8220000 and hp <= 8230000 then
				req = 1612000000
			end
			if hp > 8230000 and hp <= 8240000 then
				req = 1614000000
			end
			if hp > 8240000 and hp <= 8250000 then
				req = 1616000000
			end
			if hp > 8250000 and hp <= 8260000 then
				req = 1618000000
			end
			if hp > 8260000 and hp <= 8270000 then
				req = 1620000000
			end
			if hp > 8270000 and hp <= 8280000 then
				req = 1622000000
			end
			if hp > 8280000 and hp <= 8290000 then
				req = 1624000000
			end
			if hp > 8290000 and hp <= 8300000 then
				req = 1626000000
			end
			if hp > 8300000 and hp <= 8310000 then
				req = 1628000000
			end
			if hp > 8310000 and hp <= 8320000 then
				req = 1630000000
			end
			if hp > 8320000 and hp <= 8330000 then
				req = 1632000000
			end
			if hp > 8330000 and hp <= 8340000 then
				req = 1634000000
			end
			if hp > 8340000 and hp <= 8350000 then
				req = 1636000000
			end
			if hp > 8350000 and hp <= 8360000 then
				req = 1638000000
			end
			if hp > 8360000 and hp <= 8370000 then
				req = 1640000000
			end
			if hp > 8370000 and hp <= 8380000 then
				req = 1642000000
			end
			if hp > 8380000 and hp <= 8390000 then
				req = 1644000000
			end
			if hp > 8390000 and hp <= 8400000 then
				req = 1646000000
			end
			if hp > 8400000 and hp <= 8410000 then
				req = 1648000000
			end
			if hp > 8410000 and hp <= 8420000 then
				req = 1650000000
			end
			if hp > 8420000 and hp <= 8430000 then
				req = 1652000000
			end
			if hp > 8430000 and hp <= 8440000 then
				req = 1654000000
			end
			if hp > 8440000 and hp <= 8450000 then
				req = 1656000000
			end
			if hp > 8450000 and hp <= 8460000 then
				req = 1658000000
			end
			if hp > 8460000 and hp <= 8470000 then
				req = 1660000000
			end
			if hp > 8470000 and hp <= 8480000 then
				req = 1662000000
			end
			if hp > 8480000 and hp <= 8490000 then
				req = 1664000000
			end
			if hp > 8490000 and hp <= 8500000 then
				req = 1666000000
			end
			if hp > 8500000 and hp <= 8510000 then
				req = 1668000000
			end
			if hp > 8510000 and hp <= 8520000 then
				req = 1670000000
			end
			if hp > 8520000 and hp <= 8530000 then
				req = 1672000000
			end
			if hp > 8530000 and hp <= 8540000 then
				req = 1674000000
			end
			if hp > 8540000 and hp <= 8550000 then
				req = 1676000000
			end
			if hp > 8550000 and hp <= 8560000 then
				req = 1678000000
			end
			if hp > 8560000 and hp <= 8570000 then
				req = 1680000000
			end
			if hp > 8570000 and hp <= 8580000 then
				req = 1682000000
			end
			if hp > 8580000 and hp <= 8590000 then
				req = 1684000000
			end
			if hp > 8590000 and hp <= 8600000 then
				req = 1686000000
			end
			if hp > 8600000 and hp <= 8610000 then
				req = 1688000000
			end
			if hp > 8610000 and hp <= 8620000 then
				req = 1690000000
			end
			if hp > 8620000 and hp <= 8630000 then
				req = 1692000000
			end
			if hp > 8630000 and hp <= 8640000 then
				req = 1694000000
			end
			if hp > 8640000 and hp <= 8650000 then
				req = 1696000000
			end
			if hp > 8650000 and hp <= 8660000 then
				req = 1698000000
			end
			if hp > 8660000 and hp <= 8670000 then
				req = 1700000000
			end
			if hp > 8670000 and hp <= 8680000 then
				req = 1702000000
			end
			if hp > 8680000 and hp <= 8690000 then
				req = 1704000000
			end
			if hp > 8690000 and hp <= 8700000 then
				req = 1706000000
			end
			if hp > 8700000 and hp <= 8710000 then
				req = 1708000000
			end
			if hp > 8710000 and hp <= 8720000 then
				req = 1710000000
			end
			if hp > 8720000 and hp <= 8730000 then
				req = 1712000000
			end
			if hp > 8730000 and hp <= 8740000 then
				req = 1714000000
			end
			if hp > 8740000 and hp <= 8750000 then
				req = 1716000000
			end
			if hp > 8750000 and hp <= 8760000 then
				req = 1718000000
			end
			if hp > 8760000 and hp <= 8770000 then
				req = 1720000000
			end
			if hp > 8770000 and hp <= 8780000 then
				req = 1722000000
			end
			if hp > 8780000 and hp <= 8790000 then
				req = 1724000000
			end
			if hp > 8790000 and hp <= 8800000 then
				req = 1726000000
			end
			if hp > 8800000 and hp <= 8810000 then
				req = 1728000000
			end
			if hp > 8810000 and hp <= 8820000 then
				req = 1730000000
			end
			if hp > 8820000 and hp <= 8830000 then
				req = 1732000000
			end
			if hp > 8830000 and hp <= 8840000 then
				req = 1734000000
			end
			if hp > 8840000 and hp <= 8850000 then
				req = 1736000000
			end
			if hp > 8850000 and hp <= 8860000 then
				req = 1738000000
			end
			if hp > 8860000 and hp <= 8870000 then
				req = 1740000000
			end
			if hp > 8870000 and hp <= 8880000 then
				req = 1742000000
			end
			if hp > 8880000 and hp <= 8890000 then
				req = 1744000000
			end
			if hp > 8890000 and hp <= 8900000 then
				req = 1746000000
			end
			if hp > 8900000 and hp <= 8910000 then
				req = 1748000000
			end
			if hp > 8910000 and hp <= 8920000 then
				req = 1750000000
			end
			if hp > 8920000 and hp <= 8930000 then
				req = 1752000000
			end
			if hp > 8930000 and hp <= 8940000 then
				req = 1754000000
			end
			if hp > 8940000 and hp <= 8950000 then
				req = 1756000000
			end
			if hp > 8950000 and hp <= 8960000 then
				req = 1758000000
			end
			if hp > 8960000 and hp <= 8970000 then
				req = 1760000000
			end
			if hp > 8970000 and hp <= 8980000 then
				req = 1762000000
			end
			if hp > 8980000 and hp <= 8990000 then
				req = 1764000000
			end
			if hp > 8990000 and hp <= 9000000 then
				req = 1766000000
			end
			if hp > 9000000 and hp <= 9010000 then
				req = 1768000000
			end
			if hp > 9010000 and hp <= 9020000 then
				req = 1770000000
			end
			if hp > 9020000 and hp <= 9030000 then
				req = 1772000000
			end
			if hp > 9030000 and hp <= 9040000 then
				req = 1774000000
			end
			if hp > 9040000 and hp <= 9050000 then
				req = 1776000000
			end
			if hp > 9050000 and hp <= 9060000 then
				req = 1778000000
			end
			if hp > 9060000 and hp <= 9070000 then
				req = 1780000000
			end
			if hp > 9070000 and hp <= 9080000 then
				req = 1782000000
			end
			if hp > 9080000 and hp <= 9090000 then
				req = 1784000000
			end
			if hp > 9090000 and hp <= 9100000 then
				req = 1786000000
			end
			if hp > 9100000 and hp <= 9110000 then
				req = 1788000000
			end
			if hp > 9110000 and hp <= 9120000 then
				req = 1790000000
			end
			if hp > 9120000 and hp <= 9130000 then
				req = 1792000000
			end
			if hp > 9130000 and hp <= 9140000 then
				req = 1794000000
			end
			if hp > 9140000 and hp <= 9150000 then
				req = 1796000000
			end
			if hp > 9150000 and hp <= 9160000 then
				req = 1798000000
			end
			if hp > 9160000 and hp <= 9170000 then
				req = 1800000000
			end
			if hp > 9170000 and hp <= 9180000 then
				req = 1802000000
			end
			if hp > 9180000 and hp <= 9190000 then
				req = 1804000000
			end
			if hp > 9190000 and hp <= 9200000 then
				req = 1806000000
			end
			if hp > 9200000 and hp <= 9210000 then
				req = 1808000000
			end
			if hp > 9210000 and hp <= 9220000 then
				req = 1810000000
			end
			if hp > 9220000 and hp <= 9230000 then
				req = 1812000000
			end
			if hp > 9230000 and hp <= 9240000 then
				req = 1814000000
			end
			if hp > 9240000 and hp <= 9250000 then
				req = 1816000000
			end
			if hp > 9250000 and hp <= 9260000 then
				req = 1818000000
			end
			if hp > 9260000 and hp <= 9270000 then
				req = 1820000000
			end
			if hp > 9270000 and hp <= 9280000 then
				req = 1822000000
			end
			if hp > 9280000 and hp <= 9290000 then
				req = 1824000000
			end
			if hp > 9290000 and hp <= 9300000 then
				req = 1826000000
			end
			if hp > 9300000 and hp <= 9310000 then
				req = 1828000000
			end
			if hp > 9310000 and hp <= 9320000 then
				req = 1830000000
			end
			if hp > 9320000 and hp <= 9330000 then
				req = 1832000000
			end
			if hp > 9330000 and hp <= 9340000 then
				req = 1834000000
			end
			if hp > 9340000 and hp <= 9350000 then
				req = 1836000000
			end
			if hp > 9350000 and hp <= 9360000 then
				req = 1838000000
			end
			if hp > 9360000 and hp <= 9370000 then
				req = 1840000000
			end
			if hp > 9370000 and hp <= 9380000 then
				req = 1842000000
			end
			if hp > 9380000 and hp <= 9390000 then
				req = 1844000000
			end
			if hp > 9390000 and hp <= 9400000 then
				req = 1846000000
			end
			if hp > 9400000 and hp <= 9410000 then
				req = 1848000000
			end
			if hp > 9410000 and hp <= 9420000 then
				req = 1850000000
			end
			if hp > 9420000 and hp <= 9430000 then
				req = 1852000000
			end
			if hp > 9430000 and hp <= 9440000 then
				req = 1854000000
			end
			if hp > 9440000 and hp <= 9450000 then
				req = 1856000000
			end
			if hp > 9450000 and hp <= 9460000 then
				req = 1858000000
			end
			if hp > 9460000 and hp <= 9470000 then
				req = 1860000000
			end
			if hp > 9470000 and hp <= 9480000 then
				req = 1862000000
			end
			if hp > 9480000 and hp <= 9490000 then
				req = 1864000000
			end
			if hp > 9490000 and hp <= 9500000 then
				req = 1866000000
			end
			if hp > 9500000 and hp <= 9510000 then
				req = 1868000000
			end
			if hp > 9510000 and hp <= 9520000 then
				req = 1870000000
			end
			if hp > 9520000 and hp <= 9530000 then
				req = 1872000000
			end
			if hp > 9530000 and hp <= 9540000 then
				req = 1874000000
			end
			if hp > 9540000 and hp <= 9550000 then
				req = 1876000000
			end
			if hp > 9550000 and hp <= 9560000 then
				req = 1878000000
			end
			if hp > 9560000 and hp <= 9570000 then
				req = 1880000000
			end
			if hp > 9570000 and hp <= 9580000 then
				req = 1882000000
			end
			if hp > 9580000 and hp <= 9590000 then
				req = 1884000000
			end
			if hp > 9590000 and hp <= 9600000 then
				req = 1886000000
			end
			if hp > 9600000 and hp <= 9610000 then
				req = 1888000000
			end
			if hp > 9610000 and hp <= 9620000 then
				req = 1890000000
			end
			if hp > 9620000 and hp <= 9630000 then
				req = 1892000000
			end
			if hp > 9630000 and hp <= 9640000 then
				req = 1894000000
			end
			if hp > 9640000 and hp <= 9650000 then
				req = 1896000000
			end
			if hp > 9650000 and hp <= 9660000 then
				req = 1898000000
			end
			if hp > 9660000 and hp <= 9670000 then
				req = 1900000000
			end
			if hp > 9670000 and hp <= 9680000 then
				req = 1902000000
			end
			if hp > 9680000 and hp <= 9690000 then
				req = 1904000000
			end
			if hp > 9690000 and hp <= 9700000 then
				req = 1906000000
			end
			if hp > 9700000 and hp <= 9710000 then
				req = 1908000000
			end
			if hp > 9710000 and hp <= 9720000 then
				req = 1910000000
			end
			if hp > 9720000 and hp <= 9730000 then
				req = 1912000000
			end
			if hp > 9730000 and hp <= 9740000 then
				req = 1914000000
			end
			if hp > 9740000 and hp <= 9750000 then
				req = 1916000000
			end
			if hp > 9750000 and hp <= 9760000 then
				req = 1918000000
			end
			if hp > 9760000 and hp <= 9770000 then
				req = 1920000000
			end
			if hp > 9770000 and hp <= 9780000 then
				req = 1922000000
			end
			if hp > 9780000 and hp <= 9790000 then
				req = 1924000000
			end
			if hp > 9790000 and hp <= 9800000 then
				req = 1926000000
			end
			if hp > 9800000 and hp <= 9810000 then
				req = 1928000000
			end
			if hp > 9810000 and hp <= 9820000 then
				req = 1930000000
			end
			if hp > 9820000 and hp <= 9830000 then
				req = 1932000000
			end
			if hp > 9830000 and hp <= 9840000 then
				req = 1934000000
			end
			if hp > 9840000 and hp <= 9850000 then
				req = 1936000000
			end
			if hp > 9850000 and hp <= 9860000 then
				req = 1938000000
			end
			if hp > 9860000 and hp <= 9870000 then
				req = 1940000000
			end
			if hp > 9870000 and hp <= 9880000 then
				req = 1942000000
			end
			if hp > 9880000 and hp <= 9890000 then
				req = 1944000000
			end
			if hp > 9890000 and hp <= 9900000 then
				req = 1946000000
			end
			if hp > 9900000 and hp <= 9910000 then
				req = 1948000000
			end
			if hp > 9910000 and hp <= 9920000 then
				req = 1950000000
			end
			if hp > 9920000 and hp <= 9930000 then
				req = 1952000000
			end
			if hp > 9930000 and hp <= 9940000 then
				req = 1954000000
			end
			if hp > 9940000 and hp <= 9950000 then
				req = 1956000000
			end
			if hp > 9950000 and hp <= 9960000 then
				req = 1958000000
			end
			if hp > 9960000 and hp <= 9970000 then
				req = 1960000000
			end
			if hp > 9970000 and hp <= 9980000 then
				req = 1962000000
			end
			if hp > 9980000 and hp <= 9990000 then
				req = 1964000000
			end
			if hp > 9990000 and hp <= 10000000 then
				req = 1966000000
			end
			if hp > 10000000 and hp <= 10010000 then
				req = 1968000000
			end
		elseif job == 2 then -- Scoundrel
			if hp <= 20000 then
				req = 10000000
			end
			if hp > 20000 and hp <= 30000 then
				req = 12000000
			end
			if hp > 30000 and hp <= 40000 then
				req = 14000000
			end
			if hp > 40000 and hp <= 50000 then
				req = 16000000
			end
			if hp > 50000 and hp <= 60000 then
				req = 18000000
			end
			if hp > 60000 and hp <= 70000 then
				req = 20000000
			end
			if hp > 70000 and hp <= 80000 then
				req = 22000000
			end
			if hp > 80000 and hp <= 90000 then
				req = 24000000
			end
			if hp > 90000 and hp <= 100000 then
				req = 26000000
			end
			if hp > 100000 and hp <= 110000 then
				req = 28000000
			end
			if hp > 110000 and hp <= 120000 then
				req = 30000000
			end
			if hp > 120000 and hp <= 130000 then
				req = 32000000
			end
			if hp > 130000 and hp <= 140000 then
				req = 34000000
			end
			if hp > 140000 and hp <= 150000 then
				req = 36000000
			end
			if hp > 150000 and hp <= 160000 then
				req = 38000000
			end
			if hp > 160000 and hp <= 170000 then
				req = 40000000
			end
			if hp > 170000 and hp <= 180000 then
				req = 42000000
			end
			if hp > 180000 and hp <= 190000 then
				req = 44000000
			end
			if hp > 190000 and hp <= 200000 then
				req = 46000000
			end
			if hp > 200000 and hp <= 210000 then
				req = 48000000
			end
			if hp > 210000 and hp <= 220000 then
				req = 50000000
			end
			if hp > 220000 and hp <= 230000 then
				req = 52000000
			end
			if hp > 230000 and hp <= 240000 then
				req = 54000000
			end
			if hp > 240000 and hp <= 250000 then
				req = 56000000
			end
			if hp > 250000 and hp <= 260000 then
				req = 58000000
			end
			if hp > 260000 and hp <= 270000 then
				req = 60000000
			end
			if hp > 270000 and hp <= 280000 then
				req = 62000000
			end
			if hp > 280000 and hp <= 290000 then
				req = 64000000
			end
			if hp > 290000 and hp <= 300000 then
				req = 66000000
			end
			if hp > 300000 and hp <= 310000 then
				req = 68000000
			end
			if hp > 310000 and hp <= 320000 then
				req = 70000000
			end
			if hp > 320000 and hp <= 330000 then
				req = 72000000
			end
			if hp > 330000 and hp <= 340000 then
				req = 74000000
			end
			if hp > 340000 and hp <= 350000 then
				req = 76000000
			end
			if hp > 350000 and hp <= 360000 then
				req = 78000000
			end
			if hp > 360000 and hp <= 370000 then
				req = 80000000
			end
			if hp > 370000 and hp <= 380000 then
				req = 82000000
			end
			if hp > 380000 and hp <= 390000 then
				req = 84000000
			end
			if hp > 390000 and hp <= 400000 then
				req = 86000000
			end
			if hp > 400000 and hp <= 410000 then
				req = 88000000
			end
			if hp > 410000 and hp <= 420000 then
				req = 90000000
			end
			if hp > 420000 and hp <= 430000 then
				req = 92000000
			end
			if hp > 430000 and hp <= 440000 then
				req = 94000000
			end
			if hp > 440000 and hp <= 450000 then
				req = 96000000
			end
			if hp > 450000 and hp <= 460000 then
				req = 98000000
			end
			if hp > 460000 and hp <= 470000 then
				req = 100000000
			end
			if hp > 470000 and hp <= 480000 then
				req = 102000000
			end
			if hp > 480000 and hp <= 490000 then
				req = 104000000
			end
			if hp > 490000 and hp <= 500000 then
				req = 106000000
			end
			if hp > 500000 and hp <= 510000 then
				req = 108000000
			end
			if hp > 510000 and hp <= 520000 then
				req = 110000000
			end
			if hp > 520000 and hp <= 530000 then
				req = 112000000
			end
			if hp > 530000 and hp <= 540000 then
				req = 114000000
			end
			if hp > 540000 and hp <= 550000 then
				req = 116000000
			end
			if hp > 550000 and hp <= 560000 then
				req = 118000000
			end
			if hp > 560000 and hp <= 570000 then
				req = 120000000
			end
			if hp > 570000 and hp <= 580000 then
				req = 122000000
			end
			if hp > 580000 and hp <= 590000 then
				req = 124000000
			end
			if hp > 590000 and hp <= 600000 then
				req = 126000000
			end
			if hp > 600000 and hp <= 610000 then
				req = 128000000
			end
			if hp > 610000 and hp <= 620000 then
				req = 130000000
			end
			if hp > 620000 and hp <= 630000 then
				req = 132000000
			end
			if hp > 630000 and hp <= 640000 then
				req = 134000000
			end
			if hp > 640000 and hp <= 650000 then
				req = 136000000
			end
			if hp > 650000 and hp <= 660000 then
				req = 138000000
			end
			if hp > 660000 and hp <= 670000 then
				req = 140000000
			end
			if hp > 670000 and hp <= 680000 then
				req = 142000000
			end
			if hp > 680000 and hp <= 690000 then
				req = 144000000
			end
			if hp > 690000 and hp <= 700000 then
				req = 146000000
			end
			if hp > 700000 and hp <= 710000 then
				req = 148000000
			end
			if hp > 710000 and hp <= 720000 then
				req = 150000000
			end
			if hp > 720000 and hp <= 730000 then
				req = 152000000
			end
			if hp > 730000 and hp <= 740000 then
				req = 154000000
			end
			if hp > 740000 and hp <= 750000 then
				req = 156000000
			end
			if hp > 750000 and hp <= 760000 then
				req = 158000000
			end
			if hp > 760000 and hp <= 770000 then
				req = 160000000
			end
			if hp > 770000 and hp <= 780000 then
				req = 162000000
			end
			if hp > 780000 and hp <= 790000 then
				req = 164000000
			end
			if hp > 790000 and hp <= 800000 then
				req = 166000000
			end
			if hp > 800000 and hp <= 810000 then
				req = 168000000
			end
			if hp > 810000 and hp <= 820000 then
				req = 170000000
			end
			if hp > 820000 and hp <= 830000 then
				req = 172000000
			end
			if hp > 830000 and hp <= 840000 then
				req = 174000000
			end
			if hp > 840000 and hp <= 850000 then
				req = 176000000
			end
			if hp > 850000 and hp <= 860000 then
				req = 178000000
			end
			if hp > 860000 and hp <= 870000 then
				req = 180000000
			end
			if hp > 870000 and hp <= 880000 then
				req = 182000000
			end
			if hp > 880000 and hp <= 890000 then
				req = 184000000
			end
			if hp > 890000 and hp <= 900000 then
				req = 186000000
			end
			if hp > 900000 and hp <= 910000 then
				req = 188000000
			end
			if hp > 910000 and hp <= 920000 then
				req = 190000000
			end
			if hp > 920000 and hp <= 930000 then
				req = 192000000
			end
			if hp > 930000 and hp <= 940000 then
				req = 194000000
			end
			if hp > 940000 and hp <= 950000 then
				req = 196000000
			end
			if hp > 950000 and hp <= 960000 then
				req = 198000000
			end
			if hp > 960000 and hp <= 970000 then
				req = 200000000
			end
			if hp > 970000 and hp <= 980000 then
				req = 202000000
			end
			if hp > 980000 and hp <= 990000 then
				req = 204000000
			end
			if hp > 990000 and hp <= 1000000 then
				req = 206000000
			end
			if hp > 1000000 and hp <= 1010000 then
				req = 208000000
			end
			if hp > 1010000 and hp <= 1020000 then
				req = 210000000
			end
			if hp > 1020000 and hp <= 1030000 then
				req = 212000000
			end
			if hp > 1030000 and hp <= 1040000 then
				req = 214000000
			end
			if hp > 1040000 and hp <= 1050000 then
				req = 216000000
			end
			if hp > 1050000 and hp <= 1060000 then
				req = 218000000
			end
			if hp > 1060000 and hp <= 1070000 then
				req = 220000000
			end
			if hp > 1070000 and hp <= 1080000 then
				req = 222000000
			end
			if hp > 1080000 and hp <= 1090000 then
				req = 224000000
			end
			if hp > 1090000 and hp <= 1100000 then
				req = 226000000
			end
			if hp > 1100000 and hp <= 1110000 then
				req = 228000000
			end
			if hp > 1110000 and hp <= 1120000 then
				req = 230000000
			end
			if hp > 1120000 and hp <= 1130000 then
				req = 232000000
			end
			if hp > 1130000 and hp <= 1140000 then
				req = 234000000
			end
			if hp > 1140000 and hp <= 1150000 then
				req = 236000000
			end
			if hp > 1150000 and hp <= 1160000 then
				req = 238000000
			end
			if hp > 1160000 and hp <= 1170000 then
				req = 240000000
			end
			if hp > 1170000 and hp <= 1180000 then
				req = 242000000
			end
			if hp > 1180000 and hp <= 1190000 then
				req = 244000000
			end
			if hp > 1190000 and hp <= 1200000 then
				req = 246000000
			end
			if hp > 1200000 and hp <= 1210000 then
				req = 248000000
			end
			if hp > 1210000 and hp <= 1220000 then
				req = 250000000
			end
			if hp > 1220000 and hp <= 1230000 then
				req = 252000000
			end
			if hp > 1230000 and hp <= 1240000 then
				req = 254000000
			end
			if hp > 1240000 and hp <= 1250000 then
				req = 256000000
			end
			if hp > 1250000 and hp <= 1260000 then
				req = 258000000
			end
			if hp > 1260000 and hp <= 1270000 then
				req = 260000000
			end
			if hp > 1270000 and hp <= 1280000 then
				req = 262000000
			end
			if hp > 1280000 and hp <= 1290000 then
				req = 264000000
			end
			if hp > 1290000 and hp <= 1300000 then
				req = 266000000
			end
			if hp > 1300000 and hp <= 1310000 then
				req = 268000000
			end
			if hp > 1310000 and hp <= 1320000 then
				req = 270000000
			end
			if hp > 1320000 and hp <= 1330000 then
				req = 272000000
			end
			if hp > 1330000 and hp <= 1340000 then
				req = 274000000
			end
			if hp > 1340000 and hp <= 1350000 then
				req = 276000000
			end
			if hp > 1350000 and hp <= 1360000 then
				req = 278000000
			end
			if hp > 1360000 and hp <= 1370000 then
				req = 280000000
			end
			if hp > 1370000 and hp <= 1380000 then
				req = 282000000
			end
			if hp > 1380000 and hp <= 1390000 then
				req = 284000000
			end
			if hp > 1390000 and hp <= 1400000 then
				req = 286000000
			end
			if hp > 1400000 and hp <= 1410000 then
				req = 288000000
			end
			if hp > 1410000 and hp <= 1420000 then
				req = 290000000
			end
			if hp > 1420000 and hp <= 1430000 then
				req = 292000000
			end
			if hp > 1430000 and hp <= 1440000 then
				req = 294000000
			end
			if hp > 1440000 and hp <= 1450000 then
				req = 296000000
			end
			if hp > 1450000 and hp <= 1460000 then
				req = 298000000
			end
			if hp > 1460000 and hp <= 1470000 then
				req = 300000000
			end
			if hp > 1470000 and hp <= 1480000 then
				req = 302000000
			end
			if hp > 1480000 and hp <= 1490000 then
				req = 304000000
			end
			if hp > 1490000 and hp <= 1500000 then
				req = 306000000
			end
			if hp > 1500000 and hp <= 1510000 then
				req = 308000000
			end
			if hp > 1510000 and hp <= 1520000 then
				req = 310000000
			end
			if hp > 1520000 and hp <= 1530000 then
				req = 312000000
			end
			if hp > 1530000 and hp <= 1540000 then
				req = 314000000
			end
			if hp > 1540000 and hp <= 1550000 then
				req = 316000000
			end
			if hp > 1550000 and hp <= 1560000 then
				req = 318000000
			end
			if hp > 1560000 and hp <= 1570000 then
				req = 320000000
			end
			if hp > 1570000 and hp <= 1580000 then
				req = 322000000
			end
			if hp > 1580000 and hp <= 1590000 then
				req = 324000000
			end
			if hp > 1590000 and hp <= 1600000 then
				req = 326000000
			end
			if hp > 1600000 and hp <= 1610000 then
				req = 328000000
			end
			if hp > 1610000 and hp <= 1620000 then
				req = 330000000
			end
			if hp > 1620000 and hp <= 1630000 then
				req = 332000000
			end
			if hp > 1630000 and hp <= 1640000 then
				req = 334000000
			end
			if hp > 1640000 and hp <= 1650000 then
				req = 336000000
			end
			if hp > 1650000 and hp <= 1660000 then
				req = 338000000
			end
			if hp > 1660000 and hp <= 1670000 then
				req = 340000000
			end
			if hp > 1670000 and hp <= 1680000 then
				req = 342000000
			end
			if hp > 1680000 and hp <= 1690000 then
				req = 344000000
			end
			if hp > 1690000 and hp <= 1700000 then
				req = 346000000
			end
			if hp > 1700000 and hp <= 1710000 then
				req = 348000000
			end
			if hp > 1710000 and hp <= 1720000 then
				req = 350000000
			end
			if hp > 1720000 and hp <= 1730000 then
				req = 352000000
			end
			if hp > 1730000 and hp <= 1740000 then
				req = 354000000
			end
			if hp > 1740000 and hp <= 1750000 then
				req = 356000000
			end
			if hp > 1750000 and hp <= 1760000 then
				req = 358000000
			end
			if hp > 1760000 and hp <= 1770000 then
				req = 360000000
			end
			if hp > 1770000 and hp <= 1780000 then
				req = 362000000
			end
			if hp > 1780000 and hp <= 1790000 then
				req = 364000000
			end
			if hp > 1790000 and hp <= 1800000 then
				req = 366000000
			end
			if hp > 1800000 and hp <= 1810000 then
				req = 368000000
			end
			if hp > 1810000 and hp <= 1820000 then
				req = 370000000
			end
			if hp > 1820000 and hp <= 1830000 then
				req = 372000000
			end
			if hp > 1830000 and hp <= 1840000 then
				req = 374000000
			end
			if hp > 1840000 and hp <= 1850000 then
				req = 376000000
			end
			if hp > 1850000 and hp <= 1860000 then
				req = 378000000
			end
			if hp > 1860000 and hp <= 1870000 then
				req = 380000000
			end
			if hp > 1870000 and hp <= 1880000 then
				req = 382000000
			end
			if hp > 1880000 and hp <= 1890000 then
				req = 384000000
			end
			if hp > 1890000 and hp <= 1900000 then
				req = 386000000
			end
			if hp > 1900000 and hp <= 1910000 then
				req = 388000000
			end
			if hp > 1910000 and hp <= 1920000 then
				req = 390000000
			end
			if hp > 1920000 and hp <= 1930000 then
				req = 392000000
			end
			if hp > 1930000 and hp <= 1940000 then
				req = 394000000
			end
			if hp > 1940000 and hp <= 1950000 then
				req = 396000000
			end
			if hp > 1950000 and hp <= 1960000 then
				req = 398000000
			end
			if hp > 1960000 and hp <= 1970000 then
				req = 400000000
			end
			if hp > 1970000 and hp <= 1980000 then
				req = 402000000
			end
			if hp > 1980000 and hp <= 1990000 then
				req = 404000000
			end
			if hp > 1990000 and hp <= 2000000 then
				req = 406000000
			end
			if hp > 2000000 and hp <= 2010000 then
				req = 408000000
			end
			if hp > 2010000 and hp <= 2020000 then
				req = 410000000
			end
			if hp > 2020000 and hp <= 2030000 then
				req = 412000000
			end
			if hp > 2030000 and hp <= 2040000 then
				req = 414000000
			end
			if hp > 2040000 and hp <= 2050000 then
				req = 416000000
			end
			if hp > 2050000 and hp <= 2060000 then
				req = 418000000
			end
			if hp > 2060000 and hp <= 2070000 then
				req = 420000000
			end
			if hp > 2070000 and hp <= 2080000 then
				req = 422000000
			end
			if hp > 2080000 and hp <= 2090000 then
				req = 424000000
			end
			if hp > 2090000 and hp <= 2100000 then
				req = 426000000
			end
			if hp > 2100000 and hp <= 2110000 then
				req = 428000000
			end
			if hp > 2110000 and hp <= 2120000 then
				req = 430000000
			end
			if hp > 2120000 and hp <= 2130000 then
				req = 432000000
			end
			if hp > 2130000 and hp <= 2140000 then
				req = 434000000
			end
			if hp > 2140000 and hp <= 2150000 then
				req = 436000000
			end
			if hp > 2150000 and hp <= 2160000 then
				req = 438000000
			end
			if hp > 2160000 and hp <= 2170000 then
				req = 440000000
			end
			if hp > 2170000 and hp <= 2180000 then
				req = 442000000
			end
			if hp > 2180000 and hp <= 2190000 then
				req = 444000000
			end
			if hp > 2190000 and hp <= 2200000 then
				req = 446000000
			end
			if hp > 2200000 and hp <= 2210000 then
				req = 448000000
			end
			if hp > 2210000 and hp <= 2220000 then
				req = 450000000
			end
			if hp > 2220000 and hp <= 2230000 then
				req = 452000000
			end
			if hp > 2230000 and hp <= 2240000 then
				req = 454000000
			end
			if hp > 2240000 and hp <= 2250000 then
				req = 456000000
			end
			if hp > 2250000 and hp <= 2260000 then
				req = 458000000
			end
			if hp > 2260000 and hp <= 2270000 then
				req = 460000000
			end
			if hp > 2270000 and hp <= 2280000 then
				req = 462000000
			end
			if hp > 2280000 and hp <= 2290000 then
				req = 464000000
			end
			if hp > 2290000 and hp <= 2300000 then
				req = 466000000
			end
			if hp > 2300000 and hp <= 2310000 then
				req = 468000000
			end
			if hp > 2310000 and hp <= 2320000 then
				req = 470000000
			end
			if hp > 2320000 and hp <= 2330000 then
				req = 472000000
			end
			if hp > 2330000 and hp <= 2340000 then
				req = 474000000
			end
			if hp > 2340000 and hp <= 2350000 then
				req = 476000000
			end
			if hp > 2350000 and hp <= 2360000 then
				req = 478000000
			end
			if hp > 2360000 and hp <= 2370000 then
				req = 480000000
			end
			if hp > 2370000 and hp <= 2380000 then
				req = 482000000
			end
			if hp > 2380000 and hp <= 2390000 then
				req = 484000000
			end
			if hp > 2390000 and hp <= 2400000 then
				req = 486000000
			end
			if hp > 2400000 and hp <= 2410000 then
				req = 488000000
			end
			if hp > 2410000 and hp <= 2420000 then
				req = 490000000
			end
			if hp > 2420000 and hp <= 2430000 then
				req = 492000000
			end
			if hp > 2430000 and hp <= 2440000 then
				req = 494000000
			end
			if hp > 2440000 and hp <= 2450000 then
				req = 496000000
			end
			if hp > 2450000 and hp <= 2460000 then
				req = 498000000
			end
			if hp > 2460000 and hp <= 2470000 then
				req = 500000000
			end
			if hp > 2470000 and hp <= 2480000 then
				req = 502000000
			end
			if hp > 2480000 and hp <= 2490000 then
				req = 504000000
			end
			if hp > 2490000 and hp <= 2500000 then
				req = 506000000
			end
			if hp > 2500000 and hp <= 2510000 then
				req = 508000000
			end
			if hp > 2510000 and hp <= 2520000 then
				req = 510000000
			end
			if hp > 2520000 and hp <= 2530000 then
				req = 512000000
			end
			if hp > 2530000 and hp <= 2540000 then
				req = 514000000
			end
			if hp > 2540000 and hp <= 2550000 then
				req = 516000000
			end
			if hp > 2550000 and hp <= 2560000 then
				req = 518000000
			end
			if hp > 2560000 and hp <= 2570000 then
				req = 520000000
			end
			if hp > 2570000 and hp <= 2580000 then
				req = 522000000
			end
			if hp > 2580000 and hp <= 2590000 then
				req = 524000000
			end
			if hp > 2590000 and hp <= 2600000 then
				req = 526000000
			end
			if hp > 2600000 and hp <= 2610000 then
				req = 528000000
			end
			if hp > 2610000 and hp <= 2620000 then
				req = 490000000
			end
			if hp > 2620000 and hp <= 2630000 then
				req = 492000000
			end
			if hp > 2630000 and hp <= 2640000 then
				req = 494000000
			end
			if hp > 2640000 and hp <= 2650000 then
				req = 496000000
			end
			if hp > 2650000 and hp <= 2660000 then
				req = 498000000
			end
			if hp > 2660000 and hp <= 2670000 then
				req = 500000000
			end
			if hp > 2670000 and hp <= 2680000 then
				req = 502000000
			end
			if hp > 2680000 and hp <= 2690000 then
				req = 504000000
			end
			if hp > 2690000 and hp <= 2700000 then
				req = 506000000
			end
			if hp > 2700000 and hp <= 2710000 then
				req = 508000000
			end
			if hp > 2710000 and hp <= 2720000 then
				req = 510000000
			end
			if hp > 2720000 and hp <= 2730000 then
				req = 512000000
			end
			if hp > 2730000 and hp <= 2740000 then
				req = 514000000
			end
			if hp > 2740000 and hp <= 2750000 then
				req = 516000000
			end
			if hp > 2750000 and hp <= 2760000 then
				req = 518000000
			end
			if hp > 2760000 and hp <= 2770000 then
				req = 520000000
			end
			if hp > 2770000 and hp <= 2780000 then
				req = 522000000
			end
			if hp > 2780000 and hp <= 2790000 then
				req = 524000000
			end
			if hp > 2790000 and hp <= 2800000 then
				req = 526000000
			end
			if hp > 2800000 and hp <= 2810000 then
				req = 528000000
			end
			if hp > 2810000 and hp <= 2820000 then
				req = 530000000
			end
			if hp > 2820000 and hp <= 2830000 then
				req = 532000000
			end
			if hp > 2830000 and hp <= 2840000 then
				req = 534000000
			end
			if hp > 2840000 and hp <= 2850000 then
				req = 536000000
			end
			if hp > 2850000 and hp <= 2860000 then
				req = 538000000
			end
			if hp > 2860000 and hp <= 2870000 then
				req = 540000000
			end
			if hp > 2870000 and hp <= 2880000 then
				req = 542000000
			end
			if hp > 2880000 and hp <= 2890000 then
				req = 544000000
			end
			if hp > 2890000 and hp <= 2900000 then
				req = 546000000
			end
			if hp > 2900000 and hp <= 2910000 then
				req = 548000000
			end
			if hp > 2910000 and hp <= 2920000 then
				req = 550000000
			end
			if hp > 2920000 and hp <= 2930000 then
				req = 552000000
			end
			if hp > 2930000 and hp <= 2940000 then
				req = 554000000
			end
			if hp > 2940000 and hp <= 2950000 then
				req = 556000000
			end
			if hp > 2950000 and hp <= 2960000 then
				req = 558000000
			end
			if hp > 2960000 and hp <= 2970000 then
				req = 560000000
			end
			if hp > 2970000 and hp <= 2980000 then
				req = 562000000
			end
			if hp > 2980000 and hp <= 2990000 then
				req = 564000000
			end
			if hp > 2990000 and hp <= 3000000 then
				req = 566000000
			end
			if hp > 3000000 and hp <= 3010000 then
				req = 568000000
			end
			if hp > 3010000 and hp <= 3020000 then
				req = 570000000
			end
			if hp > 3020000 and hp <= 3030000 then
				req = 572000000
			end
			if hp > 3030000 and hp <= 3040000 then
				req = 574000000
			end
			if hp > 3040000 and hp <= 3050000 then
				req = 576000000
			end
			if hp > 3050000 and hp <= 3060000 then
				req = 578000000
			end
			if hp > 3060000 and hp <= 3070000 then
				req = 580000000
			end
			if hp > 3070000 and hp <= 3080000 then
				req = 582000000
			end
			if hp > 3080000 and hp <= 3090000 then
				req = 584000000
			end
			if hp > 3090000 and hp <= 3100000 then
				req = 586000000
			end
			if hp > 3100000 and hp <= 3110000 then
				req = 588000000
			end
			if hp > 3110000 and hp <= 3120000 then
				req = 590000000
			end
			if hp > 3120000 and hp <= 3130000 then
				req = 592000000
			end
			if hp > 3130000 and hp <= 3140000 then
				req = 594000000
			end
			if hp > 3140000 and hp <= 3150000 then
				req = 596000000
			end
			if hp > 3150000 and hp <= 3160000 then
				req = 598000000
			end
			if hp > 3160000 and hp <= 3170000 then
				req = 600000000
			end
			if hp > 3170000 and hp <= 3180000 then
				req = 602000000
			end
			if hp > 3180000 and hp <= 3190000 then
				req = 604000000
			end
			if hp > 3190000 and hp <= 3200000 then
				req = 606000000
			end
			if hp > 3200000 and hp <= 3210000 then
				req = 608000000
			end
			if hp > 3210000 and hp <= 3220000 then
				req = 610000000
			end
			if hp > 3220000 and hp <= 3230000 then
				req = 612000000
			end
			if hp > 3230000 and hp <= 3240000 then
				req = 614000000
			end
			if hp > 3240000 and hp <= 3250000 then
				req = 616000000
			end
			if hp > 3250000 and hp <= 3260000 then
				req = 618000000
			end
			if hp > 3260000 and hp <= 3270000 then
				req = 620000000
			end
			if hp > 3270000 and hp <= 3280000 then
				req = 622000000
			end
			if hp > 3280000 and hp <= 3290000 then
				req = 624000000
			end
			if hp > 3290000 and hp <= 3300000 then
				req = 626000000
			end
			if hp > 3300000 and hp <= 3310000 then
				req = 628000000
			end
			if hp > 3310000 and hp <= 3320000 then
				req = 630000000
			end
			if hp > 3320000 and hp <= 3330000 then
				req = 632000000
			end
			if hp > 3330000 and hp <= 3340000 then
				req = 634000000
			end
			if hp > 3340000 and hp <= 3350000 then
				req = 636000000
			end
			if hp > 3350000 and hp <= 3360000 then
				req = 638000000
			end
			if hp > 3360000 and hp <= 3370000 then
				req = 640000000
			end
			if hp > 3370000 and hp <= 3380000 then
				req = 642000000
			end
			if hp > 3380000 and hp <= 3390000 then
				req = 644000000
			end
			if hp > 3390000 and hp <= 3400000 then
				req = 646000000
			end
			if hp > 3400000 and hp <= 3410000 then
				req = 648000000
			end
			if hp > 3410000 and hp <= 3420000 then
				req = 650000000
			end
			if hp > 3420000 and hp <= 3430000 then
				req = 652000000
			end
			if hp > 3430000 and hp <= 3440000 then
				req = 654000000
			end
			if hp > 3440000 and hp <= 3450000 then
				req = 656000000
			end
			if hp > 3450000 and hp <= 3460000 then
				req = 658000000
			end
			if hp > 3460000 and hp <= 3470000 then
				req = 660000000
			end
			if hp > 3470000 and hp <= 3480000 then
				req = 662000000
			end
			if hp > 3480000 and hp <= 3490000 then
				req = 664000000
			end
			if hp > 3490000 and hp <= 3500000 then
				req = 666000000
			end
			if hp > 3500000 and hp <= 3510000 then
				req = 668000000
			end
			if hp > 3510000 and hp <= 3520000 then
				req = 670000000
			end
			if hp > 3520000 and hp <= 3530000 then
				req = 672000000
			end
			if hp > 3530000 and hp <= 3540000 then
				req = 674000000
			end
			if hp > 3540000 and hp <= 3550000 then
				req = 676000000
			end
			if hp > 3550000 and hp <= 3560000 then
				req = 678000000
			end
			if hp > 3560000 and hp <= 3570000 then
				req = 680000000
			end
			if hp > 3570000 and hp <= 3580000 then
				req = 682000000
			end
			if hp > 3580000 and hp <= 3590000 then
				req = 684000000
			end
			if hp > 3590000 and hp <= 3600000 then
				req = 686000000
			end
			if hp > 3600000 and hp <= 3610000 then
				req = 688000000
			end
			if hp > 3610000 and hp <= 3620000 then
				req = 690000000
			end
			if hp > 3620000 and hp <= 3630000 then
				req = 692000000
			end
			if hp > 3630000 and hp <= 3640000 then
				req = 694000000
			end
			if hp > 3640000 and hp <= 3650000 then
				req = 696000000
			end
			if hp > 3650000 and hp <= 3660000 then
				req = 698000000
			end
			if hp > 3660000 and hp <= 3670000 then
				req = 700000000
			end
			if hp > 3670000 and hp <= 3680000 then
				req = 702000000
			end
			if hp > 3680000 and hp <= 3690000 then
				req = 704000000
			end
			if hp > 3690000 and hp <= 3700000 then
				req = 706000000
			end
			if hp > 3700000 and hp <= 3710000 then
				req = 708000000
			end
			if hp > 3710000 and hp <= 3720000 then
				req = 710000000
			end
			if hp > 3720000 and hp <= 3730000 then
				req = 712000000
			end
			if hp > 3730000 and hp <= 3740000 then
				req = 714000000
			end
			if hp > 3740000 and hp <= 3750000 then
				req = 716000000
			end
			if hp > 3750000 and hp <= 3760000 then
				req = 718000000
			end
			if hp > 3760000 and hp <= 3770000 then
				req = 720000000
			end
			if hp > 3770000 and hp <= 3780000 then
				req = 722000000
			end
			if hp > 3780000 and hp <= 3790000 then
				req = 724000000
			end
			if hp > 3790000 and hp <= 3800000 then
				req = 726000000
			end
			if hp > 3800000 and hp <= 3810000 then
				req = 728000000
			end
			if hp > 3810000 and hp <= 3820000 then
				req = 730000000
			end
			if hp > 3820000 and hp <= 3830000 then
				req = 732000000
			end
			if hp > 3830000 and hp <= 3840000 then
				req = 734000000
			end
			if hp > 3840000 and hp <= 3850000 then
				req = 736000000
			end
			if hp > 3850000 and hp <= 3860000 then
				req = 738000000
			end
			if hp > 3860000 and hp <= 3870000 then
				req = 740000000
			end
			if hp > 3870000 and hp <= 3880000 then
				req = 742000000
			end
			if hp > 3880000 and hp <= 3890000 then
				req = 744000000
			end
			if hp > 3890000 and hp <= 3900000 then
				req = 746000000
			end
			if hp > 3900000 and hp <= 3910000 then
				req = 748000000
			end
			if hp > 3910000 and hp <= 3920000 then
				req = 750000000
			end
			if hp > 3920000 and hp <= 3930000 then
				req = 752000000
			end
			if hp > 3930000 and hp <= 3940000 then
				req = 754000000
			end
			if hp > 3940000 and hp <= 3950000 then
				req = 756000000
			end
			if hp > 3950000 and hp <= 3960000 then
				req = 758000000
			end
			if hp > 3960000 and hp <= 3970000 then
				req = 760000000
			end
			if hp > 3970000 and hp <= 3980000 then
				req = 762000000
			end
			if hp > 3980000 and hp <= 3990000 then
				req = 764000000
			end
			if hp > 3990000 and hp <= 4000000 then
				req = 766000000
			end
			if hp > 4000000 and hp <= 4010000 then
				req = 768000000
			end
			if hp > 4010000 and hp <= 4020000 then
				req = 770000000
			end
			if hp > 4020000 and hp <= 4030000 then
				req = 772000000
			end
			if hp > 4030000 and hp <= 4040000 then
				req = 774000000
			end
			if hp > 4040000 and hp <= 4050000 then
				req = 776000000
			end
			if hp > 4050000 and hp <= 4060000 then
				req = 778000000
			end
			if hp > 4060000 and hp <= 4070000 then
				req = 780000000
			end
			if hp > 4070000 and hp <= 4080000 then
				req = 782000000
			end
			if hp > 4080000 and hp <= 4090000 then
				req = 784000000
			end
			if hp > 4090000 and hp <= 4100000 then
				req = 786000000
			end
			if hp > 4100000 and hp <= 4110000 then
				req = 788000000
			end
			if hp > 4110000 and hp <= 4120000 then
				req = 790000000
			end
			if hp > 4120000 and hp <= 4130000 then
				req = 792000000
			end
			if hp > 4130000 and hp <= 4140000 then
				req = 794000000
			end
			if hp > 4140000 and hp <= 4150000 then
				req = 796000000
			end
			if hp > 4150000 and hp <= 4160000 then
				req = 798000000
			end
			if hp > 4160000 and hp <= 4170000 then
				req = 800000000
			end
			if hp > 4170000 and hp <= 4180000 then
				req = 802000000
			end
			if hp > 4180000 and hp <= 4190000 then
				req = 804000000
			end
			if hp > 4190000 and hp <= 4200000 then
				req = 806000000
			end
			if hp > 4200000 and hp <= 4210000 then
				req = 808000000
			end
			if hp > 4210000 and hp <= 4220000 then
				req = 810000000
			end
			if hp > 4220000 and hp <= 4230000 then
				req = 812000000
			end
			if hp > 4230000 and hp <= 4240000 then
				req = 814000000
			end
			if hp > 4240000 and hp <= 4250000 then
				req = 816000000
			end
			if hp > 4250000 and hp <= 4260000 then
				req = 818000000
			end
			if hp > 4260000 and hp <= 4270000 then
				req = 820000000
			end
			if hp > 4270000 and hp <= 4280000 then
				req = 822000000
			end
			if hp > 4280000 and hp <= 4290000 then
				req = 824000000
			end
			if hp > 4290000 and hp <= 4300000 then
				req = 826000000
			end
			if hp > 4300000 and hp <= 4310000 then
				req = 828000000
			end
			if hp > 4310000 and hp <= 4320000 then
				req = 830000000
			end
			if hp > 4320000 and hp <= 4330000 then
				req = 832000000
			end
			if hp > 4330000 and hp <= 4340000 then
				req = 834000000
			end
			if hp > 4340000 and hp <= 4350000 then
				req = 836000000
			end
			if hp > 4350000 and hp <= 4360000 then
				req = 838000000
			end
			if hp > 4360000 and hp <= 4370000 then
				req = 840000000
			end
			if hp > 4370000 and hp <= 4380000 then
				req = 842000000
			end
			if hp > 4380000 and hp <= 4390000 then
				req = 844000000
			end
			if hp > 4390000 and hp <= 4400000 then
				req = 846000000
			end
			if hp > 4400000 and hp <= 4410000 then
				req = 848000000
			end
			if hp > 4410000 and hp <= 4420000 then
				req = 850000000
			end
			if hp > 4420000 and hp <= 4430000 then
				req = 852000000
			end
			if hp > 4430000 and hp <= 4440000 then
				req = 854000000
			end
			if hp > 4440000 and hp <= 4450000 then
				req = 856000000
			end
			if hp > 4450000 and hp <= 4460000 then
				req = 858000000
			end
			if hp > 4460000 and hp <= 4470000 then
				req = 860000000
			end
			if hp > 4470000 and hp <= 4480000 then
				req = 862000000
			end
			if hp > 4480000 and hp <= 4490000 then
				req = 864000000
			end
			if hp > 4490000 and hp <= 4500000 then
				req = 866000000
			end
			if hp > 4500000 and hp <= 4510000 then
				req = 868000000
			end
			if hp > 4510000 and hp <= 4520000 then
				req = 870000000
			end
			if hp > 4520000 and hp <= 4530000 then
				req = 872000000
			end
			if hp > 4530000 and hp <= 4540000 then
				req = 874000000
			end
			if hp > 4540000 and hp <= 4550000 then
				req = 876000000
			end
			if hp > 4550000 and hp <= 4560000 then
				req = 878000000
			end
			if hp > 4560000 and hp <= 4570000 then
				req = 880000000
			end
			if hp > 4570000 and hp <= 4580000 then
				req = 882000000
			end
			if hp > 4580000 and hp <= 4590000 then
				req = 884000000
			end
			if hp > 4590000 and hp <= 4600000 then
				req = 886000000
			end
			if hp > 4600000 and hp <= 4610000 then
				req = 888000000
			end
			if hp > 4610000 and hp <= 4620000 then
				req = 890000000
			end
			if hp > 4620000 and hp <= 4630000 then
				req = 892000000
			end
			if hp > 4630000 and hp <= 4640000 then
				req = 894000000
			end
			if hp > 4640000 and hp <= 4650000 then
				req = 896000000
			end
			if hp > 4650000 and hp <= 4660000 then
				req = 898000000
			end
			if hp > 4660000 and hp <= 4670000 then
				req = 900000000
			end
			if hp > 4670000 and hp <= 4680000 then
				req = 902000000
			end
			if hp > 4680000 and hp <= 4690000 then
				req = 904000000
			end
			if hp > 4690000 and hp <= 4700000 then
				req = 906000000
			end
			if hp > 4700000 and hp <= 4710000 then
				req = 908000000
			end
			if hp > 4710000 and hp <= 4720000 then
				req = 910000000
			end
			if hp > 4720000 and hp <= 4730000 then
				req = 912000000
			end
			if hp > 4730000 and hp <= 4740000 then
				req = 914000000
			end
			if hp > 4740000 and hp <= 4750000 then
				req = 916000000
			end
			if hp > 4750000 and hp <= 4760000 then
				req = 918000000
			end
			if hp > 4760000 and hp <= 4770000 then
				req = 920000000
			end
			if hp > 4770000 and hp <= 4780000 then
				req = 922000000
			end
			if hp > 4780000 and hp <= 4790000 then
				req = 924000000
			end
			if hp > 4790000 and hp <= 4800000 then
				req = 926000000
			end
			if hp > 4800000 and hp <= 4810000 then
				req = 928000000
			end
			if hp > 4810000 and hp <= 4820000 then
				req = 930000000
			end
			if hp > 4820000 and hp <= 4830000 then
				req = 932000000
			end
			if hp > 4830000 and hp <= 4840000 then
				req = 934000000
			end
			if hp > 4840000 and hp <= 4850000 then
				req = 936000000
			end
			if hp > 4850000 and hp <= 4860000 then
				req = 938000000
			end
			if hp > 4860000 and hp <= 4870000 then
				req = 940000000
			end
			if hp > 4870000 and hp <= 4880000 then
				req = 942000000
			end
			if hp > 4880000 and hp <= 4890000 then
				req = 944000000
			end
			if hp > 4890000 and hp <= 4900000 then
				req = 946000000
			end
			if hp > 4900000 and hp <= 4910000 then
				req = 948000000
			end
			if hp > 4910000 and hp <= 4920000 then
				req = 950000000
			end
			if hp > 4920000 and hp <= 4930000 then
				req = 952000000
			end
			if hp > 4930000 and hp <= 4940000 then
				req = 954000000
			end
			if hp > 4940000 and hp <= 4950000 then
				req = 956000000
			end
			if hp > 4950000 and hp <= 4960000 then
				req = 958000000
			end
			if hp > 4960000 and hp <= 4970000 then
				req = 960000000
			end
			if hp > 4970000 and hp <= 4980000 then
				req = 962000000
			end
			if hp > 4980000 and hp <= 4990000 then
				req = 964000000
			end
			if hp > 4990000 and hp <= 5000000 then
				req = 966000000
			end
			if hp > 5000000 and hp <= 5010000 then
				req = 968000000
			end
			if hp > 5010000 and hp <= 5020000 then
				req = 970000000
			end
			if hp > 5020000 and hp <= 5030000 then
				req = 972000000
			end
			if hp > 5030000 and hp <= 5040000 then
				req = 974000000
			end
			if hp > 5040000 and hp <= 5050000 then
				req = 976000000
			end
			if hp > 5050000 and hp <= 5060000 then
				req = 978000000
			end
			if hp > 5060000 and hp <= 5070000 then
				req = 980000000
			end
			if hp > 5070000 and hp <= 5080000 then
				req = 982000000
			end
			if hp > 5080000 and hp <= 5090000 then
				req = 984000000
			end
			if hp > 5090000 and hp <= 5100000 then
				req = 986000000
			end
			if hp > 5100000 and hp <= 5110000 then
				req = 988000000
			end
			if hp > 5110000 and hp <= 5120000 then
				req = 990000000
			end
			if hp > 5120000 and hp <= 5130000 then
				req = 992000000
			end
			if hp > 5130000 and hp <= 5140000 then
				req = 994000000
			end
			if hp > 5140000 and hp <= 5150000 then
				req = 996000000
			end
			if hp > 5150000 and hp <= 5160000 then
				req = 998000000
			end
			if hp > 5160000 and hp <= 5170000 then
				req = 1000000000
			end
			if hp > 5170000 and hp <= 5180000 then
				req = 1002000000
			end
			if hp > 5180000 and hp <= 5190000 then
				req = 1004000000
			end
			if hp > 5190000 and hp <= 5200000 then
				req = 1006000000
			end
			if hp > 5200000 and hp <= 5210000 then
				req = 1008000000
			end
			if hp > 5210000 and hp <= 5220000 then
				req = 1010000000
			end
			if hp > 5220000 and hp <= 5230000 then
				req = 1012000000
			end
			if hp > 5230000 and hp <= 5240000 then
				req = 1014000000
			end
			if hp > 5240000 and hp <= 5250000 then
				req = 1016000000
			end
			if hp > 5250000 and hp <= 5260000 then
				req = 1018000000
			end
			if hp > 5260000 and hp <= 5270000 then
				req = 1020000000
			end
			if hp > 5270000 and hp <= 5280000 then
				req = 1022000000
			end
			if hp > 5280000 and hp <= 5290000 then
				req = 1024000000
			end
			if hp > 5290000 and hp <= 5300000 then
				req = 1026000000
			end
			if hp > 5300000 and hp <= 5310000 then
				req = 1028000000
			end
			if hp > 5310000 and hp <= 5320000 then
				req = 1030000000
			end
			if hp > 5320000 and hp <= 5330000 then
				req = 1032000000
			end
			if hp > 5330000 and hp <= 5340000 then
				req = 1034000000
			end
			if hp > 5340000 and hp <= 5350000 then
				req = 1036000000
			end
			if hp > 5350000 and hp <= 5360000 then
				req = 1038000000
			end
			if hp > 5360000 and hp <= 5370000 then
				req = 1040000000
			end
			if hp > 5370000 and hp <= 5380000 then
				req = 1042000000
			end
			if hp > 5380000 and hp <= 5390000 then
				req = 1044000000
			end
			if hp > 5390000 and hp <= 5400000 then
				req = 1046000000
			end
			if hp > 5400000 and hp <= 5410000 then
				req = 1048000000
			end
			if hp > 5410000 and hp <= 5420000 then
				req = 1050000000
			end
			if hp > 5420000 and hp <= 5430000 then
				req = 1052000000
			end
			if hp > 5430000 and hp <= 5440000 then
				req = 1054000000
			end
			if hp > 5440000 and hp <= 5450000 then
				req = 1056000000
			end
			if hp > 5450000 and hp <= 5460000 then
				req = 1058000000
			end
			if hp > 5460000 and hp <= 5470000 then
				req = 1060000000
			end
			if hp > 5470000 and hp <= 5480000 then
				req = 1062000000
			end
			if hp > 5480000 and hp <= 5490000 then
				req = 1064000000
			end
			if hp > 5490000 and hp <= 5500000 then
				req = 1066000000
			end
			if hp > 5500000 and hp <= 5510000 then
				req = 1068000000
			end
			if hp > 5510000 and hp <= 5520000 then
				req = 1070000000
			end
			if hp > 5520000 and hp <= 5530000 then
				req = 1072000000
			end
			if hp > 5530000 and hp <= 5540000 then
				req = 1074000000
			end
			if hp > 5540000 and hp <= 5550000 then
				req = 1076000000
			end
			if hp > 5550000 and hp <= 5560000 then
				req = 1078000000
			end
			if hp > 5560000 and hp <= 5570000 then
				req = 1080000000
			end
			if hp > 5570000 and hp <= 5580000 then
				req = 1082000000
			end
			if hp > 5580000 and hp <= 5590000 then
				req = 1084000000
			end
			if hp > 5590000 and hp <= 5600000 then
				req = 1086000000
			end
			if hp > 5600000 and hp <= 5610000 then
				req = 1088000000
			end
			if hp > 5610000 and hp <= 5620000 then
				req = 1090000000
			end
			if hp > 5620000 and hp <= 5630000 then
				req = 1092000000
			end
			if hp > 5630000 and hp <= 5640000 then
				req = 1094000000
			end
			if hp > 5640000 and hp <= 5650000 then
				req = 1096000000
			end
			if hp > 5650000 and hp <= 5660000 then
				req = 1098000000
			end
			if hp > 5660000 and hp <= 5670000 then
				req = 1100000000
			end
			if hp > 5670000 and hp <= 5680000 then
				req = 1102000000
			end
			if hp > 5680000 and hp <= 5690000 then
				req = 1104000000
			end
			if hp > 5690000 and hp <= 5700000 then
				req = 1106000000
			end
			if hp > 5700000 and hp <= 5710000 then
				req = 1108000000
			end
			if hp > 5710000 and hp <= 5720000 then
				req = 1110000000
			end
			if hp > 5720000 and hp <= 5730000 then
				req = 1112000000
			end
			if hp > 5730000 and hp <= 5740000 then
				req = 1114000000
			end
			if hp > 5740000 and hp <= 5750000 then
				req = 1116000000
			end
			if hp > 5750000 and hp <= 5760000 then
				req = 1118000000
			end
			if hp > 5760000 and hp <= 5770000 then
				req = 1120000000
			end
			if hp > 5770000 and hp <= 5780000 then
				req = 1122000000
			end
			if hp > 5780000 and hp <= 5790000 then
				req = 1124000000
			end
			if hp > 5790000 and hp <= 5800000 then
				req = 1126000000
			end
			if hp > 5800000 and hp <= 5810000 then
				req = 1128000000
			end
			if hp > 5810000 and hp <= 5820000 then
				req = 1130000000
			end
			if hp > 5820000 and hp <= 5830000 then
				req = 1132000000
			end
			if hp > 5830000 and hp <= 5840000 then
				req = 1134000000
			end
			if hp > 5840000 and hp <= 5850000 then
				req = 1136000000
			end
			if hp > 5850000 and hp <= 5860000 then
				req = 1138000000
			end
			if hp > 5860000 and hp <= 5870000 then
				req = 1140000000
			end
			if hp > 5870000 and hp <= 5880000 then
				req = 1142000000
			end
			if hp > 5880000 and hp <= 5890000 then
				req = 1144000000
			end
			if hp > 5890000 and hp <= 5900000 then
				req = 1146000000
			end
			if hp > 5900000 and hp <= 5910000 then
				req = 1148000000
			end
			if hp > 5910000 and hp <= 5920000 then
				req = 1150000000
			end
			if hp > 5920000 and hp <= 5930000 then
				req = 1152000000
			end
			if hp > 5930000 and hp <= 5940000 then
				req = 1154000000
			end
			if hp > 5940000 and hp <= 5950000 then
				req = 1156000000
			end
			if hp > 5950000 and hp <= 5960000 then
				req = 1158000000
			end
			if hp > 5960000 and hp <= 5970000 then
				req = 1160000000
			end
			if hp > 5970000 and hp <= 5980000 then
				req = 1162000000
			end
			if hp > 5980000 and hp <= 5990000 then
				req = 1164000000
			end
			if hp > 5990000 and hp <= 6000000 then
				req = 1166000000
			end
			if hp > 6000000 and hp <= 6010000 then
				req = 1168000000
			end
			if hp > 6010000 and hp <= 6020000 then
				req = 1170000000
			end
			if hp > 6020000 and hp <= 6030000 then
				req = 1172000000
			end
			if hp > 6030000 and hp <= 6040000 then
				req = 1174000000
			end
			if hp > 6040000 and hp <= 6050000 then
				req = 1176000000
			end
			if hp > 6050000 and hp <= 6060000 then
				req = 1178000000
			end
			if hp > 6060000 and hp <= 6070000 then
				req = 1180000000
			end
			if hp > 6070000 and hp <= 6080000 then
				req = 1182000000
			end
			if hp > 6080000 and hp <= 6090000 then
				req = 1184000000
			end
			if hp > 6090000 and hp <= 6100000 then
				req = 1186000000
			end
			if hp > 6100000 and hp <= 6110000 then
				req = 1188000000
			end
			if hp > 6110000 and hp <= 6120000 then
				req = 1190000000
			end
			if hp > 6120000 and hp <= 6130000 then
				req = 1192000000
			end
			if hp > 6130000 and hp <= 6140000 then
				req = 1194000000
			end
			if hp > 6140000 and hp <= 6150000 then
				req = 1196000000
			end
			if hp > 6150000 and hp <= 6160000 then
				req = 1198000000
			end
			if hp > 6160000 and hp <= 6170000 then
				req = 1200000000
			end
			if hp > 6170000 and hp <= 6180000 then
				req = 1202000000
			end
			if hp > 6180000 and hp <= 6190000 then
				req = 1204000000
			end
			if hp > 6190000 and hp <= 6200000 then
				req = 1206000000
			end
			if hp > 6200000 and hp <= 6210000 then
				req = 1208000000
			end
			if hp > 6210000 and hp <= 6220000 then
				req = 1210000000
			end
			if hp > 6220000 and hp <= 6230000 then
				req = 1212000000
			end
			if hp > 6230000 and hp <= 6240000 then
				req = 1214000000
			end
			if hp > 6240000 and hp <= 6250000 then
				req = 1216000000
			end
			if hp > 6250000 and hp <= 6260000 then
				req = 1218000000
			end
			if hp > 6260000 and hp <= 6270000 then
				req = 1220000000
			end
			if hp > 6270000 and hp <= 6280000 then
				req = 1222000000
			end
			if hp > 6280000 and hp <= 6290000 then
				req = 1224000000
			end
			if hp > 6290000 and hp <= 6300000 then
				req = 1226000000
			end
			if hp > 6300000 and hp <= 6310000 then
				req = 1228000000
			end
			if hp > 6310000 and hp <= 6320000 then
				req = 1230000000
			end
			if hp > 6320000 and hp <= 6330000 then
				req = 1232000000
			end
			if hp > 6330000 and hp <= 6340000 then
				req = 1234000000
			end
			if hp > 6340000 and hp <= 6350000 then
				req = 1236000000
			end
			if hp > 6350000 and hp <= 6360000 then
				req = 1238000000
			end
			if hp > 6360000 and hp <= 6370000 then
				req = 1240000000
			end
			if hp > 6370000 and hp <= 6380000 then
				req = 1242000000
			end
			if hp > 6380000 and hp <= 6390000 then
				req = 1244000000
			end
			if hp > 6390000 and hp <= 6400000 then
				req = 1246000000
			end
			if hp > 6400000 and hp <= 6410000 then
				req = 1248000000
			end
			if hp > 6410000 and hp <= 6420000 then
				req = 1250000000
			end
			if hp > 6420000 and hp <= 6430000 then
				req = 1252000000
			end
			if hp > 6430000 and hp <= 6440000 then
				req = 1254000000
			end
			if hp > 6440000 and hp <= 6450000 then
				req = 1256000000
			end
			if hp > 6450000 and hp <= 6460000 then
				req = 1258000000
			end
			if hp > 6460000 and hp <= 6470000 then
				req = 1260000000
			end
			if hp > 6470000 and hp <= 6480000 then
				req = 1262000000
			end
			if hp > 6480000 and hp <= 6490000 then
				req = 1264000000
			end
			if hp > 6490000 and hp <= 6500000 then
				req = 1266000000
			end
			if hp > 6500000 and hp <= 6510000 then
				req = 1268000000
			end
			if hp > 6510000 and hp <= 6520000 then
				req = 1270000000
			end
			if hp > 6520000 and hp <= 6530000 then
				req = 1272000000
			end
			if hp > 6530000 and hp <= 6540000 then
				req = 1274000000
			end
			if hp > 6540000 and hp <= 6550000 then
				req = 1276000000
			end
			if hp > 6550000 and hp <= 6560000 then
				req = 1278000000
			end
			if hp > 6560000 and hp <= 6570000 then
				req = 1280000000
			end
			if hp > 6570000 and hp <= 6580000 then
				req = 1282000000
			end
			if hp > 6580000 and hp <= 6590000 then
				req = 1284000000
			end
			if hp > 6590000 and hp <= 6600000 then
				req = 1286000000
			end
			if hp > 6600000 and hp <= 6610000 then
				req = 1288000000
			end
			if hp > 6610000 and hp <= 6620000 then
				req = 1290000000
			end
			if hp > 6620000 and hp <= 6630000 then
				req = 1292000000
			end
			if hp > 6630000 and hp <= 6640000 then
				req = 1294000000
			end
			if hp > 6640000 and hp <= 6650000 then
				req = 1296000000
			end
			if hp > 6650000 and hp <= 6660000 then
				req = 1298000000
			end
			if hp > 6660000 and hp <= 6670000 then
				req = 1300000000
			end
			if hp > 6670000 and hp <= 6680000 then
				req = 1302000000
			end
			if hp > 6680000 and hp <= 6690000 then
				req = 1304000000
			end
			if hp > 6690000 and hp <= 6700000 then
				req = 1306000000
			end
			if hp > 6700000 and hp <= 6710000 then
				req = 1308000000
			end
			if hp > 6710000 and hp <= 6720000 then
				req = 1310000000
			end
			if hp > 6720000 and hp <= 6730000 then
				req = 1312000000
			end
			if hp > 6730000 and hp <= 6740000 then
				req = 1314000000
			end
			if hp > 6740000 and hp <= 6750000 then
				req = 1316000000
			end
			if hp > 6750000 and hp <= 6760000 then
				req = 1318000000
			end
			if hp > 6760000 and hp <= 6770000 then
				req = 1320000000
			end
			if hp > 6770000 and hp <= 6780000 then
				req = 1322000000
			end
			if hp > 6780000 and hp <= 6790000 then
				req = 1324000000
			end
			if hp > 6790000 and hp <= 6800000 then
				req = 1326000000
			end
			if hp > 6800000 and hp <= 6810000 then
				req = 1328000000
			end
			if hp > 6810000 and hp <= 6820000 then
				req = 1330000000
			end
			if hp > 6820000 and hp <= 6830000 then
				req = 1332000000
			end
			if hp > 6830000 and hp <= 6840000 then
				req = 1334000000
			end
			if hp > 6840000 and hp <= 6850000 then
				req = 1336000000
			end
			if hp > 6850000 and hp <= 6860000 then
				req = 1338000000
			end
			if hp > 6860000 and hp <= 6870000 then
				req = 1340000000
			end
			if hp > 6870000 and hp <= 6880000 then
				req = 1342000000
			end
			if hp > 6880000 and hp <= 6890000 then
				req = 1344000000
			end
			if hp > 6890000 and hp <= 6900000 then
				req = 1346000000
			end
			if hp > 6900000 and hp <= 6910000 then
				req = 1348000000
			end
			if hp > 6910000 and hp <= 6920000 then
				req = 1350000000
			end
			if hp > 6920000 and hp <= 6930000 then
				req = 1352000000
			end
			if hp > 6930000 and hp <= 6940000 then
				req = 1354000000
			end
			if hp > 6940000 and hp <= 6950000 then
				req = 1356000000
			end
			if hp > 6950000 and hp <= 6960000 then
				req = 1358000000
			end
			if hp > 6960000 and hp <= 6970000 then
				req = 1360000000
			end
			if hp > 6970000 and hp <= 6980000 then
				req = 1362000000
			end
			if hp > 6980000 and hp <= 6990000 then
				req = 1364000000
			end
			if hp > 6990000 and hp <= 7000000 then
				req = 1366000000
			end
			if hp > 7000000 and hp <= 7010000 then
				req = 1368000000
			end
			if hp > 7010000 and hp <= 7020000 then
				req = 1370000000
			end
			if hp > 7020000 and hp <= 7030000 then
				req = 1372000000
			end
			if hp > 7030000 and hp <= 7040000 then
				req = 1374000000
			end
			if hp > 7040000 and hp <= 7050000 then
				req = 1376000000
			end
			if hp > 7050000 and hp <= 7060000 then
				req = 1378000000
			end
			if hp > 7060000 and hp <= 7070000 then
				req = 1380000000
			end
			if hp > 7070000 and hp <= 7080000 then
				req = 1382000000
			end
			if hp > 7080000 and hp <= 7090000 then
				req = 1384000000
			end
			if hp > 7090000 and hp <= 7100000 then
				req = 1386000000
			end
			if hp > 7100000 and hp <= 7110000 then
				req = 1388000000
			end
			if hp > 7110000 and hp <= 7120000 then
				req = 1390000000
			end
			if hp > 7120000 and hp <= 7130000 then
				req = 1392000000
			end
			if hp > 7130000 and hp <= 7140000 then
				req = 1394000000
			end
			if hp > 7140000 and hp <= 7150000 then
				req = 1396000000
			end
			if hp > 7150000 and hp <= 7160000 then
				req = 1398000000
			end
			if hp > 7160000 and hp <= 7170000 then
				req = 1400000000
			end
			if hp > 7170000 and hp <= 7180000 then
				req = 1402000000
			end
			if hp > 7180000 and hp <= 7190000 then
				req = 1404000000
			end
			if hp > 7190000 and hp <= 7200000 then
				req = 1406000000
			end
			if hp > 7200000 and hp <= 7210000 then
				req = 1408000000
			end
			if hp > 7210000 and hp <= 7220000 then
				req = 1410000000
			end
			if hp > 7220000 and hp <= 7230000 then
				req = 1412000000
			end
			if hp > 7230000 and hp <= 7240000 then
				req = 1414000000
			end
			if hp > 7240000 and hp <= 7250000 then
				req = 1416000000
			end
			if hp > 7250000 and hp <= 7260000 then
				req = 1418000000
			end
			if hp > 7260000 and hp <= 7270000 then
				req = 1420000000
			end
			if hp > 7270000 and hp <= 7280000 then
				req = 1422000000
			end
			if hp > 7280000 and hp <= 7290000 then
				req = 1424000000
			end
			if hp > 7290000 and hp <= 7300000 then
				req = 1426000000
			end
			if hp > 7300000 and hp <= 7310000 then
				req = 1428000000
			end
			if hp > 7310000 and hp <= 7320000 then
				req = 1430000000
			end
			if hp > 7320000 and hp <= 7330000 then
				req = 1432000000
			end
			if hp > 7330000 and hp <= 7340000 then
				req = 1434000000
			end
			if hp > 7340000 and hp <= 7350000 then
				req = 1436000000
			end
			if hp > 7350000 and hp <= 7360000 then
				req = 1438000000
			end
			if hp > 7360000 and hp <= 7370000 then
				req = 1440000000
			end
			if hp > 7370000 and hp <= 7380000 then
				req = 1442000000
			end
			if hp > 7380000 and hp <= 7390000 then
				req = 1444000000
			end
			if hp > 7390000 and hp <= 7400000 then
				req = 1446000000
			end
			if hp > 7400000 and hp <= 7410000 then
				req = 1448000000
			end
			if hp > 7410000 and hp <= 7420000 then
				req = 1450000000
			end
			if hp > 7420000 and hp <= 7430000 then
				req = 1452000000
			end
			if hp > 7430000 and hp <= 7440000 then
				req = 1454000000
			end
			if hp > 7440000 and hp <= 7450000 then
				req = 1456000000
			end
			if hp > 7450000 and hp <= 7460000 then
				req = 1458000000
			end
			if hp > 7460000 and hp <= 7470000 then
				req = 1460000000
			end
			if hp > 7470000 and hp <= 7480000 then
				req = 1462000000
			end
			if hp > 7480000 and hp <= 7490000 then
				req = 1464000000
			end
			if hp > 7490000 and hp <= 7500000 then
				req = 1466000000
			end
			if hp > 7500000 and hp <= 7510000 then
				req = 1468000000
			end
			if hp > 7510000 and hp <= 7520000 then
				req = 1470000000
			end
			if hp > 7520000 and hp <= 7530000 then
				req = 1472000000
			end
			if hp > 7530000 and hp <= 7540000 then
				req = 1474000000
			end
			if hp > 7540000 and hp <= 7550000 then
				req = 1476000000
			end
			if hp > 7550000 and hp <= 7560000 then
				req = 1478000000
			end
			if hp > 7560000 and hp <= 7570000 then
				req = 1480000000
			end
			if hp > 7570000 and hp <= 7580000 then
				req = 1482000000
			end
			if hp > 7580000 and hp <= 7590000 then
				req = 1484000000
			end
			if hp > 7590000 and hp <= 7600000 then
				req = 1486000000
			end
			if hp > 7600000 and hp <= 7610000 then
				req = 1488000000
			end
			if hp > 7610000 and hp <= 7620000 then
				req = 1490000000
			end
			if hp > 7620000 and hp <= 7630000 then
				req = 1492000000
			end
			if hp > 7630000 and hp <= 7640000 then
				req = 1494000000
			end
			if hp > 7640000 and hp <= 7650000 then
				req = 1496000000
			end
			if hp > 7650000 and hp <= 7660000 then
				req = 1498000000
			end
			if hp > 7660000 and hp <= 7670000 then
				req = 1500000000
			end
			if hp > 7670000 and hp <= 7680000 then
				req = 1502000000
			end
			if hp > 7680000 and hp <= 7690000 then
				req = 1504000000
			end
			if hp > 7690000 and hp <= 7700000 then
				req = 1506000000
			end
			if hp > 7700000 and hp <= 7710000 then
				req = 1508000000
			end
			if hp > 7710000 and hp <= 7720000 then
				req = 1510000000
			end
			if hp > 7720000 and hp <= 7730000 then
				req = 1512000000
			end
			if hp > 7730000 and hp <= 7740000 then
				req = 1514000000
			end
			if hp > 7740000 and hp <= 7750000 then
				req = 1516000000
			end
			if hp > 7750000 and hp <= 7760000 then
				req = 1518000000
			end
			if hp > 7760000 and hp <= 7770000 then
				req = 1520000000
			end
			if hp > 7770000 and hp <= 7780000 then
				req = 1522000000
			end
			if hp > 7780000 and hp <= 7790000 then
				req = 1524000000
			end
			if hp > 7790000 and hp <= 7800000 then
				req = 1526000000
			end
			if hp > 7800000 and hp <= 7810000 then
				req = 1528000000
			end
			if hp > 7810000 and hp <= 7820000 then
				req = 1530000000
			end
			if hp > 7820000 and hp <= 7830000 then
				req = 1532000000
			end
			if hp > 7830000 and hp <= 7840000 then
				req = 1534000000
			end
			if hp > 7840000 and hp <= 7850000 then
				req = 1536000000
			end
			if hp > 7850000 and hp <= 7860000 then
				req = 1538000000
			end
			if hp > 7860000 and hp <= 7870000 then
				req = 1540000000
			end
			if hp > 7870000 and hp <= 7880000 then
				req = 1542000000
			end
			if hp > 7880000 and hp <= 7890000 then
				req = 1544000000
			end
			if hp > 7890000 and hp <= 7900000 then
				req = 1546000000
			end
			if hp > 7900000 and hp <= 7910000 then
				req = 1548000000
			end
			if hp > 7910000 and hp <= 7920000 then
				req = 1550000000
			end
			if hp > 7920000 and hp <= 7930000 then
				req = 1552000000
			end
			if hp > 7930000 and hp <= 7940000 then
				req = 1554000000
			end
			if hp > 7940000 and hp <= 7950000 then
				req = 1556000000
			end
			if hp > 7950000 and hp <= 7960000 then
				req = 1558000000
			end
			if hp > 7960000 and hp <= 7970000 then
				req = 1560000000
			end
			if hp > 7970000 and hp <= 7980000 then
				req = 1562000000
			end
			if hp > 7980000 and hp <= 7990000 then
				req = 1564000000
			end
			if hp > 7990000 and hp <= 8000000 then
				req = 1566000000
			end
			if hp > 8000000 and hp <= 8010000 then
				req = 1568000000
			end
			if hp > 8010000 and hp <= 8020000 then
				req = 1570000000
			end
			if hp > 8020000 and hp <= 8030000 then
				req = 1572000000
			end
			if hp > 8030000 and hp <= 8040000 then
				req = 1574000000
			end
			if hp > 8040000 and hp <= 8050000 then
				req = 1576000000
			end
			if hp > 8050000 and hp <= 8060000 then
				req = 1578000000
			end
			if hp > 8060000 and hp <= 8070000 then
				req = 1580000000
			end
			if hp > 8070000 and hp <= 8080000 then
				req = 1582000000
			end
			if hp > 8080000 and hp <= 8090000 then
				req = 1584000000
			end
			if hp > 8090000 and hp <= 8100000 then
				req = 1586000000
			end
			if hp > 8100000 and hp <= 8110000 then
				req = 1588000000
			end
			if hp > 8110000 and hp <= 8120000 then
				req = 1590000000
			end
			if hp > 8120000 and hp <= 8130000 then
				req = 1592000000
			end
			if hp > 8130000 and hp <= 8140000 then
				req = 1594000000
			end
			if hp > 8140000 and hp <= 8150000 then
				req = 1596000000
			end
			if hp > 8150000 and hp <= 8160000 then
				req = 1598000000
			end
			if hp > 8160000 and hp <= 8170000 then
				req = 1600000000
			end
			if hp > 8170000 and hp <= 8180000 then
				req = 1602000000
			end
			if hp > 8180000 and hp <= 8190000 then
				req = 1604000000
			end
			if hp > 8190000 and hp <= 8200000 then
				req = 1606000000
			end
			if hp > 8200000 and hp <= 8210000 then
				req = 1608000000
			end
			if hp > 8210000 and hp <= 8220000 then
				req = 1610000000
			end
			if hp > 8220000 and hp <= 8230000 then
				req = 1612000000
			end
			if hp > 8230000 and hp <= 8240000 then
				req = 1614000000
			end
			if hp > 8240000 and hp <= 8250000 then
				req = 1616000000
			end
			if hp > 8250000 and hp <= 8260000 then
				req = 1618000000
			end
			if hp > 8260000 and hp <= 8270000 then
				req = 1620000000
			end
			if hp > 8270000 and hp <= 8280000 then
				req = 1622000000
			end
			if hp > 8280000 and hp <= 8290000 then
				req = 1624000000
			end
			if hp > 8290000 and hp <= 8300000 then
				req = 1626000000
			end
			if hp > 8300000 and hp <= 8310000 then
				req = 1628000000
			end
			if hp > 8310000 and hp <= 8320000 then
				req = 1630000000
			end
			if hp > 8320000 and hp <= 8330000 then
				req = 1632000000
			end
			if hp > 8330000 and hp <= 8340000 then
				req = 1634000000
			end
			if hp > 8340000 and hp <= 8350000 then
				req = 1636000000
			end
			if hp > 8350000 and hp <= 8360000 then
				req = 1638000000
			end
			if hp > 8360000 and hp <= 8370000 then
				req = 1640000000
			end
			if hp > 8370000 and hp <= 8380000 then
				req = 1642000000
			end
			if hp > 8380000 and hp <= 8390000 then
				req = 1644000000
			end
			if hp > 8390000 and hp <= 8400000 then
				req = 1646000000
			end
			if hp > 8400000 and hp <= 8410000 then
				req = 1648000000
			end
			if hp > 8410000 and hp <= 8420000 then
				req = 1650000000
			end
			if hp > 8420000 and hp <= 8430000 then
				req = 1652000000
			end
			if hp > 8430000 and hp <= 8440000 then
				req = 1654000000
			end
			if hp > 8440000 and hp <= 8450000 then
				req = 1656000000
			end
			if hp > 8450000 and hp <= 8460000 then
				req = 1658000000
			end
			if hp > 8460000 and hp <= 8470000 then
				req = 1660000000
			end
			if hp > 8470000 and hp <= 8480000 then
				req = 1662000000
			end
			if hp > 8480000 and hp <= 8490000 then
				req = 1664000000
			end
			if hp > 8490000 and hp <= 8500000 then
				req = 1666000000
			end
			if hp > 8500000 and hp <= 8510000 then
				req = 1668000000
			end
			if hp > 8510000 and hp <= 8520000 then
				req = 1670000000
			end
			if hp > 8520000 and hp <= 8530000 then
				req = 1672000000
			end
			if hp > 8530000 and hp <= 8540000 then
				req = 1674000000
			end
			if hp > 8540000 and hp <= 8550000 then
				req = 1676000000
			end
			if hp > 8550000 and hp <= 8560000 then
				req = 1678000000
			end
			if hp > 8560000 and hp <= 8570000 then
				req = 1680000000
			end
			if hp > 8570000 and hp <= 8580000 then
				req = 1682000000
			end
			if hp > 8580000 and hp <= 8590000 then
				req = 1684000000
			end
			if hp > 8590000 and hp <= 8600000 then
				req = 1686000000
			end
			if hp > 8600000 and hp <= 8610000 then
				req = 1688000000
			end
			if hp > 8610000 and hp <= 8620000 then
				req = 1690000000
			end
			if hp > 8620000 and hp <= 8630000 then
				req = 1692000000
			end
			if hp > 8630000 and hp <= 8640000 then
				req = 1694000000
			end
			if hp > 8640000 and hp <= 8650000 then
				req = 1696000000
			end
			if hp > 8650000 and hp <= 8660000 then
				req = 1698000000
			end
			if hp > 8660000 and hp <= 8670000 then
				req = 1700000000
			end
			if hp > 8670000 and hp <= 8680000 then
				req = 1702000000
			end
			if hp > 8680000 and hp <= 8690000 then
				req = 1704000000
			end
			if hp > 8690000 and hp <= 8700000 then
				req = 1706000000
			end
			if hp > 8700000 and hp <= 8710000 then
				req = 1708000000
			end
			if hp > 8710000 and hp <= 8720000 then
				req = 1710000000
			end
			if hp > 8720000 and hp <= 8730000 then
				req = 1712000000
			end
			if hp > 8730000 and hp <= 8740000 then
				req = 1714000000
			end
			if hp > 8740000 and hp <= 8750000 then
				req = 1716000000
			end
			if hp > 8750000 and hp <= 8760000 then
				req = 1718000000
			end
			if hp > 8760000 and hp <= 8770000 then
				req = 1720000000
			end
			if hp > 8770000 and hp <= 8780000 then
				req = 1722000000
			end
			if hp > 8780000 and hp <= 8790000 then
				req = 1724000000
			end
			if hp > 8790000 and hp <= 8800000 then
				req = 1726000000
			end
			if hp > 8800000 and hp <= 8810000 then
				req = 1728000000
			end
			if hp > 8810000 and hp <= 8820000 then
				req = 1730000000
			end
			if hp > 8820000 and hp <= 8830000 then
				req = 1732000000
			end
			if hp > 8830000 and hp <= 8840000 then
				req = 1734000000
			end
			if hp > 8840000 and hp <= 8850000 then
				req = 1736000000
			end
			if hp > 8850000 and hp <= 8860000 then
				req = 1738000000
			end
			if hp > 8860000 and hp <= 8870000 then
				req = 1740000000
			end
			if hp > 8870000 and hp <= 8880000 then
				req = 1742000000
			end
			if hp > 8880000 and hp <= 8890000 then
				req = 1744000000
			end
			if hp > 8890000 and hp <= 8900000 then
				req = 1746000000
			end
			if hp > 8900000 and hp <= 8910000 then
				req = 1748000000
			end
			if hp > 8910000 and hp <= 8920000 then
				req = 1750000000
			end
			if hp > 8920000 and hp <= 8930000 then
				req = 1752000000
			end
			if hp > 8930000 and hp <= 8940000 then
				req = 1754000000
			end
			if hp > 8940000 and hp <= 8950000 then
				req = 1756000000
			end
			if hp > 8950000 and hp <= 8960000 then
				req = 1758000000
			end
			if hp > 8960000 and hp <= 8970000 then
				req = 1760000000
			end
			if hp > 8970000 and hp <= 8980000 then
				req = 1762000000
			end
			if hp > 8980000 and hp <= 8990000 then
				req = 1764000000
			end
			if hp > 8990000 and hp <= 9000000 then
				req = 1766000000
			end
			if hp > 9000000 and hp <= 9010000 then
				req = 1768000000
			end
			if hp > 9010000 and hp <= 9020000 then
				req = 1770000000
			end
			if hp > 9020000 and hp <= 9030000 then
				req = 1772000000
			end
			if hp > 9030000 and hp <= 9040000 then
				req = 1774000000
			end
			if hp > 9040000 and hp <= 9050000 then
				req = 1776000000
			end
			if hp > 9050000 and hp <= 9060000 then
				req = 1778000000
			end
			if hp > 9060000 and hp <= 9070000 then
				req = 1780000000
			end
			if hp > 9070000 and hp <= 9080000 then
				req = 1782000000
			end
			if hp > 9080000 and hp <= 9090000 then
				req = 1784000000
			end
			if hp > 9090000 and hp <= 9100000 then
				req = 1786000000
			end
			if hp > 9100000 and hp <= 9110000 then
				req = 1788000000
			end
			if hp > 9110000 and hp <= 9120000 then
				req = 1790000000
			end
			if hp > 9120000 and hp <= 9130000 then
				req = 1792000000
			end
			if hp > 9130000 and hp <= 9140000 then
				req = 1794000000
			end
			if hp > 9140000 and hp <= 9150000 then
				req = 1796000000
			end
			if hp > 9150000 and hp <= 9160000 then
				req = 1798000000
			end
			if hp > 9160000 and hp <= 9170000 then
				req = 1800000000
			end
			if hp > 9170000 and hp <= 9180000 then
				req = 1802000000
			end
			if hp > 9180000 and hp <= 9190000 then
				req = 1804000000
			end
			if hp > 9190000 and hp <= 9200000 then
				req = 1806000000
			end
			if hp > 9200000 and hp <= 9210000 then
				req = 1808000000
			end
			if hp > 9210000 and hp <= 9220000 then
				req = 1810000000
			end
			if hp > 9220000 and hp <= 9230000 then
				req = 1812000000
			end
			if hp > 9230000 and hp <= 9240000 then
				req = 1814000000
			end
			if hp > 9240000 and hp <= 9250000 then
				req = 1816000000
			end
			if hp > 9250000 and hp <= 9260000 then
				req = 1818000000
			end
			if hp > 9260000 and hp <= 9270000 then
				req = 1820000000
			end
			if hp > 9270000 and hp <= 9280000 then
				req = 1822000000
			end
			if hp > 9280000 and hp <= 9290000 then
				req = 1824000000
			end
			if hp > 9290000 and hp <= 9300000 then
				req = 1826000000
			end
			if hp > 9300000 and hp <= 9310000 then
				req = 1828000000
			end
			if hp > 9310000 and hp <= 9320000 then
				req = 1830000000
			end
			if hp > 9320000 and hp <= 9330000 then
				req = 1832000000
			end
			if hp > 9330000 and hp <= 9340000 then
				req = 1834000000
			end
			if hp > 9340000 and hp <= 9350000 then
				req = 1836000000
			end
			if hp > 9350000 and hp <= 9360000 then
				req = 1838000000
			end
			if hp > 9360000 and hp <= 9370000 then
				req = 1840000000
			end
			if hp > 9370000 and hp <= 9380000 then
				req = 1842000000
			end
			if hp > 9380000 and hp <= 9390000 then
				req = 1844000000
			end
			if hp > 9390000 and hp <= 9400000 then
				req = 1846000000
			end
			if hp > 9400000 and hp <= 9410000 then
				req = 1848000000
			end
			if hp > 9410000 and hp <= 9420000 then
				req = 1850000000
			end
			if hp > 9420000 and hp <= 9430000 then
				req = 1852000000
			end
			if hp > 9430000 and hp <= 9440000 then
				req = 1854000000
			end
			if hp > 9440000 and hp <= 9450000 then
				req = 1856000000
			end
			if hp > 9450000 and hp <= 9460000 then
				req = 1858000000
			end
			if hp > 9460000 and hp <= 9470000 then
				req = 1860000000
			end
			if hp > 9470000 and hp <= 9480000 then
				req = 1862000000
			end
			if hp > 9480000 and hp <= 9490000 then
				req = 1864000000
			end
			if hp > 9490000 and hp <= 9500000 then
				req = 1866000000
			end
			if hp > 9500000 and hp <= 9510000 then
				req = 1868000000
			end
			if hp > 9510000 and hp <= 9520000 then
				req = 1870000000
			end
			if hp > 9520000 and hp <= 9530000 then
				req = 1872000000
			end
			if hp > 9530000 and hp <= 9540000 then
				req = 1874000000
			end
			if hp > 9540000 and hp <= 9550000 then
				req = 1876000000
			end
			if hp > 9550000 and hp <= 9560000 then
				req = 1878000000
			end
			if hp > 9560000 and hp <= 9570000 then
				req = 1880000000
			end
			if hp > 9570000 and hp <= 9580000 then
				req = 1882000000
			end
			if hp > 9580000 and hp <= 9590000 then
				req = 1884000000
			end
			if hp > 9590000 and hp <= 9600000 then
				req = 1886000000
			end
			if hp > 9600000 and hp <= 9610000 then
				req = 1888000000
			end
			if hp > 9610000 and hp <= 9620000 then
				req = 1890000000
			end
			if hp > 9620000 and hp <= 9630000 then
				req = 1892000000
			end
			if hp > 9630000 and hp <= 9640000 then
				req = 1894000000
			end
			if hp > 9640000 and hp <= 9650000 then
				req = 1896000000
			end
			if hp > 9650000 and hp <= 9660000 then
				req = 1898000000
			end
			if hp > 9660000 and hp <= 9670000 then
				req = 1900000000
			end
			if hp > 9670000 and hp <= 9680000 then
				req = 1902000000
			end
			if hp > 9680000 and hp <= 9690000 then
				req = 1904000000
			end
			if hp > 9690000 and hp <= 9700000 then
				req = 1906000000
			end
			if hp > 9700000 and hp <= 9710000 then
				req = 1908000000
			end
			if hp > 9710000 and hp <= 9720000 then
				req = 1910000000
			end
			if hp > 9720000 and hp <= 9730000 then
				req = 1912000000
			end
			if hp > 9730000 and hp <= 9740000 then
				req = 1914000000
			end
			if hp > 9740000 and hp <= 9750000 then
				req = 1916000000
			end
			if hp > 9750000 and hp <= 9760000 then
				req = 1918000000
			end
			if hp > 9760000 and hp <= 9770000 then
				req = 1920000000
			end
			if hp > 9770000 and hp <= 9780000 then
				req = 1922000000
			end
			if hp > 9780000 and hp <= 9790000 then
				req = 1924000000
			end
			if hp > 9790000 and hp <= 9800000 then
				req = 1926000000
			end
			if hp > 9800000 and hp <= 9810000 then
				req = 1928000000
			end
			if hp > 9810000 and hp <= 9820000 then
				req = 1930000000
			end
			if hp > 9820000 and hp <= 9830000 then
				req = 1932000000
			end
			if hp > 9830000 and hp <= 9840000 then
				req = 1934000000
			end
			if hp > 9840000 and hp <= 9850000 then
				req = 1936000000
			end
			if hp > 9850000 and hp <= 9860000 then
				req = 1938000000
			end
			if hp > 9860000 and hp <= 9870000 then
				req = 1940000000
			end
			if hp > 9870000 and hp <= 9880000 then
				req = 1942000000
			end
			if hp > 9880000 and hp <= 9890000 then
				req = 1944000000
			end
			if hp > 9890000 and hp <= 9900000 then
				req = 1946000000
			end
			if hp > 9900000 and hp <= 9910000 then
				req = 1948000000
			end
			if hp > 9910000 and hp <= 9920000 then
				req = 1950000000
			end
			if hp > 9920000 and hp <= 9930000 then
				req = 1952000000
			end
			if hp > 9930000 and hp <= 9940000 then
				req = 1954000000
			end
			if hp > 9940000 and hp <= 9950000 then
				req = 1956000000
			end
			if hp > 9950000 and hp <= 9960000 then
				req = 1958000000
			end
			if hp > 9960000 and hp <= 9970000 then
				req = 1960000000
			end
			if hp > 9970000 and hp <= 9980000 then
				req = 1962000000
			end
			if hp > 9980000 and hp <= 9990000 then
				req = 1964000000
			end
			if hp > 9990000 and hp <= 10000000 then
				req = 1966000000
			end
			if hp > 10000000 and hp <= 10010000 then
				req = 1968000000
			end
		elseif job == 3 then -- Wizard
			if hp <= 20000 then
				req = 10000000
			end
			if hp > 20000 and hp <= 30000 then
				req = 12000000
			end
			if hp > 30000 and hp <= 40000 then
				req = 14000000
			end
			if hp > 40000 and hp <= 50000 then
				req = 16000000
			end
			if hp > 50000 and hp <= 60000 then
				req = 18000000
			end
			if hp > 60000 and hp <= 70000 then
				req = 20000000
			end
			if hp > 70000 and hp <= 80000 then
				req = 22000000
			end
			if hp > 80000 and hp <= 90000 then
				req = 24000000
			end
			if hp > 90000 and hp <= 100000 then
				req = 26000000
			end
			if hp > 100000 and hp <= 110000 then
				req = 28000000
			end
			if hp > 110000 and hp <= 120000 then
				req = 30000000
			end
			if hp > 120000 and hp <= 130000 then
				req = 32000000
			end
			if hp > 130000 and hp <= 140000 then
				req = 34000000
			end
			if hp > 140000 and hp <= 150000 then
				req = 36000000
			end
			if hp > 150000 and hp <= 160000 then
				req = 38000000
			end
			if hp > 160000 and hp <= 170000 then
				req = 40000000
			end
			if hp > 170000 and hp <= 180000 then
				req = 42000000
			end
			if hp > 180000 and hp <= 190000 then
				req = 44000000
			end
			if hp > 190000 and hp <= 200000 then
				req = 46000000
			end
			if hp > 200000 and hp <= 210000 then
				req = 48000000
			end
			if hp > 210000 and hp <= 220000 then
				req = 50000000
			end
			if hp > 220000 and hp <= 230000 then
				req = 52000000
			end
			if hp > 230000 and hp <= 240000 then
				req = 54000000
			end
			if hp > 240000 and hp <= 250000 then
				req = 56000000
			end
			if hp > 250000 and hp <= 260000 then
				req = 58000000
			end
			if hp > 260000 and hp <= 270000 then
				req = 60000000
			end
			if hp > 270000 and hp <= 280000 then
				req = 62000000
			end
			if hp > 280000 and hp <= 290000 then
				req = 64000000
			end
			if hp > 290000 and hp <= 300000 then
				req = 66000000
			end
			if hp > 300000 and hp <= 310000 then
				req = 68000000
			end
			if hp > 310000 and hp <= 320000 then
				req = 70000000
			end
			if hp > 320000 and hp <= 330000 then
				req = 72000000
			end
			if hp > 330000 and hp <= 340000 then
				req = 74000000
			end
			if hp > 340000 and hp <= 350000 then
				req = 76000000
			end
			if hp > 350000 and hp <= 360000 then
				req = 78000000
			end
			if hp > 360000 and hp <= 370000 then
				req = 80000000
			end
			if hp > 370000 and hp <= 380000 then
				req = 82000000
			end
			if hp > 380000 and hp <= 390000 then
				req = 84000000
			end
			if hp > 390000 and hp <= 400000 then
				req = 86000000
			end
			if hp > 400000 and hp <= 410000 then
				req = 88000000
			end
			if hp > 410000 and hp <= 420000 then
				req = 90000000
			end
			if hp > 420000 and hp <= 430000 then
				req = 92000000
			end
			if hp > 430000 and hp <= 440000 then
				req = 94000000
			end
			if hp > 440000 and hp <= 450000 then
				req = 96000000
			end
			if hp > 450000 and hp <= 460000 then
				req = 98000000
			end
			if hp > 460000 and hp <= 470000 then
				req = 100000000
			end
			if hp > 470000 and hp <= 480000 then
				req = 102000000
			end
			if hp > 480000 and hp <= 490000 then
				req = 104000000
			end
			if hp > 490000 and hp <= 500000 then
				req = 106000000
			end
			if hp > 500000 and hp <= 510000 then
				req = 108000000
			end
			if hp > 510000 and hp <= 520000 then
				req = 110000000
			end
			if hp > 520000 and hp <= 530000 then
				req = 112000000
			end
			if hp > 530000 and hp <= 540000 then
				req = 114000000
			end
			if hp > 540000 and hp <= 550000 then
				req = 116000000
			end
			if hp > 550000 and hp <= 560000 then
				req = 118000000
			end
			if hp > 560000 and hp <= 570000 then
				req = 120000000
			end
			if hp > 570000 and hp <= 580000 then
				req = 122000000
			end
			if hp > 580000 and hp <= 590000 then
				req = 124000000
			end
			if hp > 590000 and hp <= 600000 then
				req = 126000000
			end
			if hp > 600000 and hp <= 610000 then
				req = 128000000
			end
			if hp > 610000 and hp <= 620000 then
				req = 130000000
			end
			if hp > 620000 and hp <= 630000 then
				req = 132000000
			end
			if hp > 630000 and hp <= 640000 then
				req = 134000000
			end
			if hp > 640000 and hp <= 650000 then
				req = 136000000
			end
			if hp > 650000 and hp <= 660000 then
				req = 138000000
			end
			if hp > 660000 and hp <= 670000 then
				req = 140000000
			end
			if hp > 670000 and hp <= 680000 then
				req = 142000000
			end
			if hp > 680000 and hp <= 690000 then
				req = 144000000
			end
			if hp > 690000 and hp <= 700000 then
				req = 146000000
			end
			if hp > 700000 and hp <= 710000 then
				req = 148000000
			end
			if hp > 710000 and hp <= 720000 then
				req = 150000000
			end
			if hp > 720000 and hp <= 730000 then
				req = 152000000
			end
			if hp > 730000 and hp <= 740000 then
				req = 154000000
			end
			if hp > 740000 and hp <= 750000 then
				req = 156000000
			end
			if hp > 750000 and hp <= 760000 then
				req = 158000000
			end
			if hp > 760000 and hp <= 770000 then
				req = 160000000
			end
			if hp > 770000 and hp <= 780000 then
				req = 162000000
			end
			if hp > 780000 and hp <= 790000 then
				req = 164000000
			end
			if hp > 790000 and hp <= 800000 then
				req = 166000000
			end
			if hp > 800000 and hp <= 810000 then
				req = 168000000
			end
			if hp > 810000 and hp <= 820000 then
				req = 170000000
			end
			if hp > 820000 and hp <= 830000 then
				req = 172000000
			end
			if hp > 830000 and hp <= 840000 then
				req = 174000000
			end
			if hp > 840000 and hp <= 850000 then
				req = 176000000
			end
			if hp > 850000 and hp <= 860000 then
				req = 178000000
			end
			if hp > 860000 and hp <= 870000 then
				req = 180000000
			end
			if hp > 870000 and hp <= 880000 then
				req = 182000000
			end
			if hp > 880000 and hp <= 890000 then
				req = 184000000
			end
			if hp > 890000 and hp <= 900000 then
				req = 186000000
			end
			if hp > 900000 and hp <= 910000 then
				req = 188000000
			end
			if hp > 910000 and hp <= 920000 then
				req = 190000000
			end
			if hp > 920000 and hp <= 930000 then
				req = 192000000
			end
			if hp > 930000 and hp <= 940000 then
				req = 194000000
			end
			if hp > 940000 and hp <= 950000 then
				req = 196000000
			end
			if hp > 950000 and hp <= 960000 then
				req = 198000000
			end
			if hp > 960000 and hp <= 970000 then
				req = 200000000
			end
			if hp > 970000 and hp <= 980000 then
				req = 202000000
			end
			if hp > 980000 and hp <= 990000 then
				req = 204000000
			end
			if hp > 990000 and hp <= 1000000 then
				req = 206000000
			end
			if hp > 1000000 and hp <= 1010000 then
				req = 208000000
			end
			if hp > 1010000 and hp <= 1020000 then
				req = 210000000
			end
			if hp > 1020000 and hp <= 1030000 then
				req = 212000000
			end
			if hp > 1030000 and hp <= 1040000 then
				req = 214000000
			end
			if hp > 1040000 and hp <= 1050000 then
				req = 216000000
			end
			if hp > 1050000 and hp <= 1060000 then
				req = 218000000
			end
			if hp > 1060000 and hp <= 1070000 then
				req = 220000000
			end
			if hp > 1070000 and hp <= 1080000 then
				req = 222000000
			end
			if hp > 1080000 and hp <= 1090000 then
				req = 224000000
			end
			if hp > 1090000 and hp <= 1100000 then
				req = 226000000
			end
			if hp > 1100000 and hp <= 1110000 then
				req = 228000000
			end
			if hp > 1110000 and hp <= 1120000 then
				req = 230000000
			end
			if hp > 1120000 and hp <= 1130000 then
				req = 232000000
			end
			if hp > 1130000 and hp <= 1140000 then
				req = 234000000
			end
			if hp > 1140000 and hp <= 1150000 then
				req = 236000000
			end
			if hp > 1150000 and hp <= 1160000 then
				req = 238000000
			end
			if hp > 1160000 and hp <= 1170000 then
				req = 240000000
			end
			if hp > 1170000 and hp <= 1180000 then
				req = 242000000
			end
			if hp > 1180000 and hp <= 1190000 then
				req = 244000000
			end
			if hp > 1190000 and hp <= 1200000 then
				req = 246000000
			end
			if hp > 1200000 and hp <= 1210000 then
				req = 248000000
			end
			if hp > 1210000 and hp <= 1220000 then
				req = 250000000
			end
			if hp > 1220000 and hp <= 1230000 then
				req = 252000000
			end
			if hp > 1230000 and hp <= 1240000 then
				req = 254000000
			end
			if hp > 1240000 and hp <= 1250000 then
				req = 256000000
			end
			if hp > 1250000 and hp <= 1260000 then
				req = 258000000
			end
			if hp > 1260000 and hp <= 1270000 then
				req = 260000000
			end
			if hp > 1270000 and hp <= 1280000 then
				req = 262000000
			end
			if hp > 1280000 and hp <= 1290000 then
				req = 264000000
			end
			if hp > 1290000 and hp <= 1300000 then
				req = 266000000
			end
			if hp > 1300000 and hp <= 1310000 then
				req = 268000000
			end
			if hp > 1310000 and hp <= 1320000 then
				req = 270000000
			end
			if hp > 1320000 and hp <= 1330000 then
				req = 272000000
			end
			if hp > 1330000 and hp <= 1340000 then
				req = 274000000
			end
			if hp > 1340000 and hp <= 1350000 then
				req = 276000000
			end
			if hp > 1350000 and hp <= 1360000 then
				req = 278000000
			end
			if hp > 1360000 and hp <= 1370000 then
				req = 280000000
			end
			if hp > 1370000 and hp <= 1380000 then
				req = 282000000
			end
			if hp > 1380000 and hp <= 1390000 then
				req = 284000000
			end
			if hp > 1390000 and hp <= 1400000 then
				req = 286000000
			end
			if hp > 1400000 and hp <= 1410000 then
				req = 288000000
			end
			if hp > 1410000 and hp <= 1420000 then
				req = 290000000
			end
			if hp > 1420000 and hp <= 1430000 then
				req = 292000000
			end
			if hp > 1430000 and hp <= 1440000 then
				req = 294000000
			end
			if hp > 1440000 and hp <= 1450000 then
				req = 296000000
			end
			if hp > 1450000 and hp <= 1460000 then
				req = 298000000
			end
			if hp > 1460000 and hp <= 1470000 then
				req = 300000000
			end
			if hp > 1470000 and hp <= 1480000 then
				req = 302000000
			end
			if hp > 1480000 and hp <= 1490000 then
				req = 304000000
			end
			if hp > 1490000 and hp <= 1500000 then
				req = 306000000
			end
			if hp > 1500000 and hp <= 1510000 then
				req = 308000000
			end
			if hp > 1510000 and hp <= 1520000 then
				req = 310000000
			end
			if hp > 1520000 and hp <= 1530000 then
				req = 312000000
			end
			if hp > 1530000 and hp <= 1540000 then
				req = 314000000
			end
			if hp > 1540000 and hp <= 1550000 then
				req = 316000000
			end
			if hp > 1550000 and hp <= 1560000 then
				req = 318000000
			end
			if hp > 1560000 and hp <= 1570000 then
				req = 320000000
			end
			if hp > 1570000 and hp <= 1580000 then
				req = 322000000
			end
			if hp > 1580000 and hp <= 1590000 then
				req = 324000000
			end
			if hp > 1590000 and hp <= 1600000 then
				req = 326000000
			end
			if hp > 1600000 and hp <= 1610000 then
				req = 328000000
			end
			if hp > 1610000 and hp <= 1620000 then
				req = 330000000
			end
			if hp > 1620000 and hp <= 1630000 then
				req = 332000000
			end
			if hp > 1630000 and hp <= 1640000 then
				req = 334000000
			end
			if hp > 1640000 and hp <= 1650000 then
				req = 336000000
			end
			if hp > 1650000 and hp <= 1660000 then
				req = 338000000
			end
			if hp > 1660000 and hp <= 1670000 then
				req = 340000000
			end
			if hp > 1670000 and hp <= 1680000 then
				req = 342000000
			end
			if hp > 1680000 and hp <= 1690000 then
				req = 344000000
			end
			if hp > 1690000 and hp <= 1700000 then
				req = 346000000
			end
			if hp > 1700000 and hp <= 1710000 then
				req = 348000000
			end
			if hp > 1710000 and hp <= 1720000 then
				req = 350000000
			end
			if hp > 1720000 and hp <= 1730000 then
				req = 352000000
			end
			if hp > 1730000 and hp <= 1740000 then
				req = 354000000
			end
			if hp > 1740000 and hp <= 1750000 then
				req = 356000000
			end
			if hp > 1750000 and hp <= 1760000 then
				req = 358000000
			end
			if hp > 1760000 and hp <= 1770000 then
				req = 360000000
			end
			if hp > 1770000 and hp <= 1780000 then
				req = 362000000
			end
			if hp > 1780000 and hp <= 1790000 then
				req = 364000000
			end
			if hp > 1790000 and hp <= 1800000 then
				req = 366000000
			end
			if hp > 1800000 and hp <= 1810000 then
				req = 368000000
			end
			if hp > 1810000 and hp <= 1820000 then
				req = 370000000
			end
			if hp > 1820000 and hp <= 1830000 then
				req = 372000000
			end
			if hp > 1830000 and hp <= 1840000 then
				req = 374000000
			end
			if hp > 1840000 and hp <= 1850000 then
				req = 376000000
			end
			if hp > 1850000 and hp <= 1860000 then
				req = 378000000
			end
			if hp > 1860000 and hp <= 1870000 then
				req = 380000000
			end
			if hp > 1870000 and hp <= 1880000 then
				req = 382000000
			end
			if hp > 1880000 and hp <= 1890000 then
				req = 384000000
			end
			if hp > 1890000 and hp <= 1900000 then
				req = 386000000
			end
			if hp > 1900000 and hp <= 1910000 then
				req = 388000000
			end
			if hp > 1910000 and hp <= 1920000 then
				req = 390000000
			end
			if hp > 1920000 and hp <= 1930000 then
				req = 392000000
			end
			if hp > 1930000 and hp <= 1940000 then
				req = 394000000
			end
			if hp > 1940000 and hp <= 1950000 then
				req = 396000000
			end
			if hp > 1950000 and hp <= 1960000 then
				req = 398000000
			end
			if hp > 1960000 and hp <= 1970000 then
				req = 400000000
			end
			if hp > 1970000 and hp <= 1980000 then
				req = 402000000
			end
			if hp > 1980000 and hp <= 1990000 then
				req = 404000000
			end
			if hp > 1990000 and hp <= 2000000 then
				req = 406000000
			end
			if hp > 2000000 and hp <= 2010000 then
				req = 408000000
			end
			if hp > 2010000 and hp <= 2020000 then
				req = 410000000
			end
			if hp > 2020000 and hp <= 2030000 then
				req = 412000000
			end
			if hp > 2030000 and hp <= 2040000 then
				req = 414000000
			end
			if hp > 2040000 and hp <= 2050000 then
				req = 416000000
			end
			if hp > 2050000 and hp <= 2060000 then
				req = 418000000
			end
			if hp > 2060000 and hp <= 2070000 then
				req = 420000000
			end
			if hp > 2070000 and hp <= 2080000 then
				req = 422000000
			end
			if hp > 2080000 and hp <= 2090000 then
				req = 424000000
			end
			if hp > 2090000 and hp <= 2100000 then
				req = 426000000
			end
			if hp > 2100000 and hp <= 2110000 then
				req = 428000000
			end
			if hp > 2110000 and hp <= 2120000 then
				req = 430000000
			end
			if hp > 2120000 and hp <= 2130000 then
				req = 432000000
			end
			if hp > 2130000 and hp <= 2140000 then
				req = 434000000
			end
			if hp > 2140000 and hp <= 2150000 then
				req = 436000000
			end
			if hp > 2150000 and hp <= 2160000 then
				req = 438000000
			end
			if hp > 2160000 and hp <= 2170000 then
				req = 440000000
			end
			if hp > 2170000 and hp <= 2180000 then
				req = 442000000
			end
			if hp > 2180000 and hp <= 2190000 then
				req = 444000000
			end
			if hp > 2190000 and hp <= 2200000 then
				req = 446000000
			end
			if hp > 2200000 and hp <= 2210000 then
				req = 448000000
			end
			if hp > 2210000 and hp <= 2220000 then
				req = 450000000
			end
			if hp > 2220000 and hp <= 2230000 then
				req = 452000000
			end
			if hp > 2230000 and hp <= 2240000 then
				req = 454000000
			end
			if hp > 2240000 and hp <= 2250000 then
				req = 456000000
			end
			if hp > 2250000 and hp <= 2260000 then
				req = 458000000
			end
			if hp > 2260000 and hp <= 2270000 then
				req = 460000000
			end
			if hp > 2270000 and hp <= 2280000 then
				req = 462000000
			end
			if hp > 2280000 and hp <= 2290000 then
				req = 464000000
			end
			if hp > 2290000 and hp <= 2300000 then
				req = 466000000
			end
			if hp > 2300000 and hp <= 2310000 then
				req = 468000000
			end
			if hp > 2310000 and hp <= 2320000 then
				req = 470000000
			end
			if hp > 2320000 and hp <= 2330000 then
				req = 472000000
			end
			if hp > 2330000 and hp <= 2340000 then
				req = 474000000
			end
			if hp > 2340000 and hp <= 2350000 then
				req = 476000000
			end
			if hp > 2350000 and hp <= 2360000 then
				req = 478000000
			end
			if hp > 2360000 and hp <= 2370000 then
				req = 480000000
			end
			if hp > 2370000 and hp <= 2380000 then
				req = 482000000
			end
			if hp > 2380000 and hp <= 2390000 then
				req = 484000000
			end
			if hp > 2390000 and hp <= 2400000 then
				req = 486000000
			end
			if hp > 2400000 and hp <= 2410000 then
				req = 488000000
			end
			if hp > 2410000 and hp <= 2420000 then
				req = 490000000
			end
			if hp > 2420000 and hp <= 2430000 then
				req = 492000000
			end
			if hp > 2430000 and hp <= 2440000 then
				req = 494000000
			end
			if hp > 2440000 and hp <= 2450000 then
				req = 496000000
			end
			if hp > 2450000 and hp <= 2460000 then
				req = 498000000
			end
			if hp > 2460000 and hp <= 2470000 then
				req = 500000000
			end
			if hp > 2470000 and hp <= 2480000 then
				req = 502000000
			end
			if hp > 2480000 and hp <= 2490000 then
				req = 504000000
			end
			if hp > 2490000 and hp <= 2500000 then
				req = 506000000
			end
			if hp > 2500000 and hp <= 2510000 then
				req = 508000000
			end
			if hp > 2510000 and hp <= 2520000 then
				req = 510000000
			end
			if hp > 2520000 and hp <= 2530000 then
				req = 512000000
			end
			if hp > 2530000 and hp <= 2540000 then
				req = 514000000
			end
			if hp > 2540000 and hp <= 2550000 then
				req = 516000000
			end
			if hp > 2550000 and hp <= 2560000 then
				req = 518000000
			end
			if hp > 2560000 and hp <= 2570000 then
				req = 520000000
			end
			if hp > 2570000 and hp <= 2580000 then
				req = 522000000
			end
			if hp > 2580000 and hp <= 2590000 then
				req = 524000000
			end
			if hp > 2590000 and hp <= 2600000 then
				req = 526000000
			end
			if hp > 2600000 and hp <= 2610000 then
				req = 528000000
			end
			if hp > 2610000 and hp <= 2620000 then
				req = 490000000
			end
			if hp > 2620000 and hp <= 2630000 then
				req = 492000000
			end
			if hp > 2630000 and hp <= 2640000 then
				req = 494000000
			end
			if hp > 2640000 and hp <= 2650000 then
				req = 496000000
			end
			if hp > 2650000 and hp <= 2660000 then
				req = 498000000
			end
			if hp > 2660000 and hp <= 2670000 then
				req = 500000000
			end
			if hp > 2670000 and hp <= 2680000 then
				req = 502000000
			end
			if hp > 2680000 and hp <= 2690000 then
				req = 504000000
			end
			if hp > 2690000 and hp <= 2700000 then
				req = 506000000
			end
			if hp > 2700000 and hp <= 2710000 then
				req = 508000000
			end
			if hp > 2710000 and hp <= 2720000 then
				req = 510000000
			end
			if hp > 2720000 and hp <= 2730000 then
				req = 512000000
			end
			if hp > 2730000 and hp <= 2740000 then
				req = 514000000
			end
			if hp > 2740000 and hp <= 2750000 then
				req = 516000000
			end
			if hp > 2750000 and hp <= 2760000 then
				req = 518000000
			end
			if hp > 2760000 and hp <= 2770000 then
				req = 520000000
			end
			if hp > 2770000 and hp <= 2780000 then
				req = 522000000
			end
			if hp > 2780000 and hp <= 2790000 then
				req = 524000000
			end
			if hp > 2790000 and hp <= 2800000 then
				req = 526000000
			end
			if hp > 2800000 and hp <= 2810000 then
				req = 528000000
			end
			if hp > 2810000 and hp <= 2820000 then
				req = 530000000
			end
			if hp > 2820000 and hp <= 2830000 then
				req = 532000000
			end
			if hp > 2830000 and hp <= 2840000 then
				req = 534000000
			end
			if hp > 2840000 and hp <= 2850000 then
				req = 536000000
			end
			if hp > 2850000 and hp <= 2860000 then
				req = 538000000
			end
			if hp > 2860000 and hp <= 2870000 then
				req = 540000000
			end
			if hp > 2870000 and hp <= 2880000 then
				req = 542000000
			end
			if hp > 2880000 and hp <= 2890000 then
				req = 544000000
			end
			if hp > 2890000 and hp <= 2900000 then
				req = 546000000
			end
			if hp > 2900000 and hp <= 2910000 then
				req = 548000000
			end
			if hp > 2910000 and hp <= 2920000 then
				req = 550000000
			end
			if hp > 2920000 and hp <= 2930000 then
				req = 552000000
			end
			if hp > 2930000 and hp <= 2940000 then
				req = 554000000
			end
			if hp > 2940000 and hp <= 2950000 then
				req = 556000000
			end
			if hp > 2950000 and hp <= 2960000 then
				req = 558000000
			end
			if hp > 2960000 and hp <= 2970000 then
				req = 560000000
			end
			if hp > 2970000 and hp <= 2980000 then
				req = 562000000
			end
			if hp > 2980000 and hp <= 2990000 then
				req = 564000000
			end
			if hp > 2990000 and hp <= 3000000 then
				req = 566000000
			end
			if hp > 3000000 and hp <= 3010000 then
				req = 568000000
			end
			if hp > 3010000 and hp <= 3020000 then
				req = 570000000
			end
			if hp > 3020000 and hp <= 3030000 then
				req = 572000000
			end
			if hp > 3030000 and hp <= 3040000 then
				req = 574000000
			end
			if hp > 3040000 and hp <= 3050000 then
				req = 576000000
			end
			if hp > 3050000 and hp <= 3060000 then
				req = 578000000
			end
			if hp > 3060000 and hp <= 3070000 then
				req = 580000000
			end
			if hp > 3070000 and hp <= 3080000 then
				req = 582000000
			end
			if hp > 3080000 and hp <= 3090000 then
				req = 584000000
			end
			if hp > 3090000 and hp <= 3100000 then
				req = 586000000
			end
			if hp > 3100000 and hp <= 3110000 then
				req = 588000000
			end
			if hp > 3110000 and hp <= 3120000 then
				req = 590000000
			end
			if hp > 3120000 and hp <= 3130000 then
				req = 592000000
			end
			if hp > 3130000 and hp <= 3140000 then
				req = 594000000
			end
			if hp > 3140000 and hp <= 3150000 then
				req = 596000000
			end
			if hp > 3150000 and hp <= 3160000 then
				req = 598000000
			end
			if hp > 3160000 and hp <= 3170000 then
				req = 600000000
			end
			if hp > 3170000 and hp <= 3180000 then
				req = 602000000
			end
			if hp > 3180000 and hp <= 3190000 then
				req = 604000000
			end
			if hp > 3190000 and hp <= 3200000 then
				req = 606000000
			end
			if hp > 3200000 and hp <= 3210000 then
				req = 608000000
			end
			if hp > 3210000 and hp <= 3220000 then
				req = 610000000
			end
			if hp > 3220000 and hp <= 3230000 then
				req = 612000000
			end
			if hp > 3230000 and hp <= 3240000 then
				req = 614000000
			end
			if hp > 3240000 and hp <= 3250000 then
				req = 616000000
			end
			if hp > 3250000 and hp <= 3260000 then
				req = 618000000
			end
			if hp > 3260000 and hp <= 3270000 then
				req = 620000000
			end
			if hp > 3270000 and hp <= 3280000 then
				req = 622000000
			end
			if hp > 3280000 and hp <= 3290000 then
				req = 624000000
			end
			if hp > 3290000 and hp <= 3300000 then
				req = 626000000
			end
			if hp > 3300000 and hp <= 3310000 then
				req = 628000000
			end
			if hp > 3310000 and hp <= 3320000 then
				req = 630000000
			end
			if hp > 3320000 and hp <= 3330000 then
				req = 632000000
			end
			if hp > 3330000 and hp <= 3340000 then
				req = 634000000
			end
			if hp > 3340000 and hp <= 3350000 then
				req = 636000000
			end
			if hp > 3350000 and hp <= 3360000 then
				req = 638000000
			end
			if hp > 3360000 and hp <= 3370000 then
				req = 640000000
			end
			if hp > 3370000 and hp <= 3380000 then
				req = 642000000
			end
			if hp > 3380000 and hp <= 3390000 then
				req = 644000000
			end
			if hp > 3390000 and hp <= 3400000 then
				req = 646000000
			end
			if hp > 3400000 and hp <= 3410000 then
				req = 648000000
			end
			if hp > 3410000 and hp <= 3420000 then
				req = 650000000
			end
			if hp > 3420000 and hp <= 3430000 then
				req = 652000000
			end
			if hp > 3430000 and hp <= 3440000 then
				req = 654000000
			end
			if hp > 3440000 and hp <= 3450000 then
				req = 656000000
			end
			if hp > 3450000 and hp <= 3460000 then
				req = 658000000
			end
			if hp > 3460000 and hp <= 3470000 then
				req = 660000000
			end
			if hp > 3470000 and hp <= 3480000 then
				req = 662000000
			end
			if hp > 3480000 and hp <= 3490000 then
				req = 664000000
			end
			if hp > 3490000 and hp <= 3500000 then
				req = 666000000
			end
			if hp > 3500000 and hp <= 3510000 then
				req = 668000000
			end
			if hp > 3510000 and hp <= 3520000 then
				req = 670000000
			end
			if hp > 3520000 and hp <= 3530000 then
				req = 672000000
			end
			if hp > 3530000 and hp <= 3540000 then
				req = 674000000
			end
			if hp > 3540000 and hp <= 3550000 then
				req = 676000000
			end
			if hp > 3550000 and hp <= 3560000 then
				req = 678000000
			end
			if hp > 3560000 and hp <= 3570000 then
				req = 680000000
			end
			if hp > 3570000 and hp <= 3580000 then
				req = 682000000
			end
			if hp > 3580000 and hp <= 3590000 then
				req = 684000000
			end
			if hp > 3590000 and hp <= 3600000 then
				req = 686000000
			end
			if hp > 3600000 and hp <= 3610000 then
				req = 688000000
			end
			if hp > 3610000 and hp <= 3620000 then
				req = 690000000
			end
			if hp > 3620000 and hp <= 3630000 then
				req = 692000000
			end
			if hp > 3630000 and hp <= 3640000 then
				req = 694000000
			end
			if hp > 3640000 and hp <= 3650000 then
				req = 696000000
			end
			if hp > 3650000 and hp <= 3660000 then
				req = 698000000
			end
			if hp > 3660000 and hp <= 3670000 then
				req = 700000000
			end
			if hp > 3670000 and hp <= 3680000 then
				req = 702000000
			end
			if hp > 3680000 and hp <= 3690000 then
				req = 704000000
			end
			if hp > 3690000 and hp <= 3700000 then
				req = 706000000
			end
			if hp > 3700000 and hp <= 3710000 then
				req = 708000000
			end
			if hp > 3710000 and hp <= 3720000 then
				req = 710000000
			end
			if hp > 3720000 and hp <= 3730000 then
				req = 712000000
			end
			if hp > 3730000 and hp <= 3740000 then
				req = 714000000
			end
			if hp > 3740000 and hp <= 3750000 then
				req = 716000000
			end
			if hp > 3750000 and hp <= 3760000 then
				req = 718000000
			end
			if hp > 3760000 and hp <= 3770000 then
				req = 720000000
			end
			if hp > 3770000 and hp <= 3780000 then
				req = 722000000
			end
			if hp > 3780000 and hp <= 3790000 then
				req = 724000000
			end
			if hp > 3790000 and hp <= 3800000 then
				req = 726000000
			end
			if hp > 3800000 and hp <= 3810000 then
				req = 728000000
			end
			if hp > 3810000 and hp <= 3820000 then
				req = 730000000
			end
			if hp > 3820000 and hp <= 3830000 then
				req = 732000000
			end
			if hp > 3830000 and hp <= 3840000 then
				req = 734000000
			end
			if hp > 3840000 and hp <= 3850000 then
				req = 736000000
			end
			if hp > 3850000 and hp <= 3860000 then
				req = 738000000
			end
			if hp > 3860000 and hp <= 3870000 then
				req = 740000000
			end
			if hp > 3870000 and hp <= 3880000 then
				req = 742000000
			end
			if hp > 3880000 and hp <= 3890000 then
				req = 744000000
			end
			if hp > 3890000 and hp <= 3900000 then
				req = 746000000
			end
			if hp > 3900000 and hp <= 3910000 then
				req = 748000000
			end
			if hp > 3910000 and hp <= 3920000 then
				req = 750000000
			end
			if hp > 3920000 and hp <= 3930000 then
				req = 752000000
			end
			if hp > 3930000 and hp <= 3940000 then
				req = 754000000
			end
			if hp > 3940000 and hp <= 3950000 then
				req = 756000000
			end
			if hp > 3950000 and hp <= 3960000 then
				req = 758000000
			end
			if hp > 3960000 and hp <= 3970000 then
				req = 760000000
			end
			if hp > 3970000 and hp <= 3980000 then
				req = 762000000
			end
			if hp > 3980000 and hp <= 3990000 then
				req = 764000000
			end
			if hp > 3990000 and hp <= 4000000 then
				req = 766000000
			end
			if hp > 4000000 and hp <= 4010000 then
				req = 768000000
			end
			if hp > 4010000 and hp <= 4020000 then
				req = 770000000
			end
			if hp > 4020000 and hp <= 4030000 then
				req = 772000000
			end
			if hp > 4030000 and hp <= 4040000 then
				req = 774000000
			end
			if hp > 4040000 and hp <= 4050000 then
				req = 776000000
			end
			if hp > 4050000 and hp <= 4060000 then
				req = 778000000
			end
			if hp > 4060000 and hp <= 4070000 then
				req = 780000000
			end
			if hp > 4070000 and hp <= 4080000 then
				req = 782000000
			end
			if hp > 4080000 and hp <= 4090000 then
				req = 784000000
			end
			if hp > 4090000 and hp <= 4100000 then
				req = 786000000
			end
			if hp > 4100000 and hp <= 4110000 then
				req = 788000000
			end
			if hp > 4110000 and hp <= 4120000 then
				req = 790000000
			end
			if hp > 4120000 and hp <= 4130000 then
				req = 792000000
			end
			if hp > 4130000 and hp <= 4140000 then
				req = 794000000
			end
			if hp > 4140000 and hp <= 4150000 then
				req = 796000000
			end
			if hp > 4150000 and hp <= 4160000 then
				req = 798000000
			end
			if hp > 4160000 and hp <= 4170000 then
				req = 800000000
			end
			if hp > 4170000 and hp <= 4180000 then
				req = 802000000
			end
			if hp > 4180000 and hp <= 4190000 then
				req = 804000000
			end
			if hp > 4190000 and hp <= 4200000 then
				req = 806000000
			end
			if hp > 4200000 and hp <= 4210000 then
				req = 808000000
			end
			if hp > 4210000 and hp <= 4220000 then
				req = 810000000
			end
			if hp > 4220000 and hp <= 4230000 then
				req = 812000000
			end
			if hp > 4230000 and hp <= 4240000 then
				req = 814000000
			end
			if hp > 4240000 and hp <= 4250000 then
				req = 816000000
			end
			if hp > 4250000 and hp <= 4260000 then
				req = 818000000
			end
			if hp > 4260000 and hp <= 4270000 then
				req = 820000000
			end
			if hp > 4270000 and hp <= 4280000 then
				req = 822000000
			end
			if hp > 4280000 and hp <= 4290000 then
				req = 824000000
			end
			if hp > 4290000 and hp <= 4300000 then
				req = 826000000
			end
			if hp > 4300000 and hp <= 4310000 then
				req = 828000000
			end
			if hp > 4310000 and hp <= 4320000 then
				req = 830000000
			end
			if hp > 4320000 and hp <= 4330000 then
				req = 832000000
			end
			if hp > 4330000 and hp <= 4340000 then
				req = 834000000
			end
			if hp > 4340000 and hp <= 4350000 then
				req = 836000000
			end
			if hp > 4350000 and hp <= 4360000 then
				req = 838000000
			end
			if hp > 4360000 and hp <= 4370000 then
				req = 840000000
			end
			if hp > 4370000 and hp <= 4380000 then
				req = 842000000
			end
			if hp > 4380000 and hp <= 4390000 then
				req = 844000000
			end
			if hp > 4390000 and hp <= 4400000 then
				req = 846000000
			end
			if hp > 4400000 and hp <= 4410000 then
				req = 848000000
			end
			if hp > 4410000 and hp <= 4420000 then
				req = 850000000
			end
			if hp > 4420000 and hp <= 4430000 then
				req = 852000000
			end
			if hp > 4430000 and hp <= 4440000 then
				req = 854000000
			end
			if hp > 4440000 and hp <= 4450000 then
				req = 856000000
			end
			if hp > 4450000 and hp <= 4460000 then
				req = 858000000
			end
			if hp > 4460000 and hp <= 4470000 then
				req = 860000000
			end
			if hp > 4470000 and hp <= 4480000 then
				req = 862000000
			end
			if hp > 4480000 and hp <= 4490000 then
				req = 864000000
			end
			if hp > 4490000 and hp <= 4500000 then
				req = 866000000
			end
			if hp > 4500000 and hp <= 4510000 then
				req = 868000000
			end
			if hp > 4510000 and hp <= 4520000 then
				req = 870000000
			end
			if hp > 4520000 and hp <= 4530000 then
				req = 872000000
			end
			if hp > 4530000 and hp <= 4540000 then
				req = 874000000
			end
			if hp > 4540000 and hp <= 4550000 then
				req = 876000000
			end
			if hp > 4550000 and hp <= 4560000 then
				req = 878000000
			end
			if hp > 4560000 and hp <= 4570000 then
				req = 880000000
			end
			if hp > 4570000 and hp <= 4580000 then
				req = 882000000
			end
			if hp > 4580000 and hp <= 4590000 then
				req = 884000000
			end
			if hp > 4590000 and hp <= 4600000 then
				req = 886000000
			end
			if hp > 4600000 and hp <= 4610000 then
				req = 888000000
			end
			if hp > 4610000 and hp <= 4620000 then
				req = 890000000
			end
			if hp > 4620000 and hp <= 4630000 then
				req = 892000000
			end
			if hp > 4630000 and hp <= 4640000 then
				req = 894000000
			end
			if hp > 4640000 and hp <= 4650000 then
				req = 896000000
			end
			if hp > 4650000 and hp <= 4660000 then
				req = 898000000
			end
			if hp > 4660000 and hp <= 4670000 then
				req = 900000000
			end
			if hp > 4670000 and hp <= 4680000 then
				req = 902000000
			end
			if hp > 4680000 and hp <= 4690000 then
				req = 904000000
			end
			if hp > 4690000 and hp <= 4700000 then
				req = 906000000
			end
			if hp > 4700000 and hp <= 4710000 then
				req = 908000000
			end
			if hp > 4710000 and hp <= 4720000 then
				req = 910000000
			end
			if hp > 4720000 and hp <= 4730000 then
				req = 912000000
			end
			if hp > 4730000 and hp <= 4740000 then
				req = 914000000
			end
			if hp > 4740000 and hp <= 4750000 then
				req = 916000000
			end
			if hp > 4750000 and hp <= 4760000 then
				req = 918000000
			end
			if hp > 4760000 and hp <= 4770000 then
				req = 920000000
			end
			if hp > 4770000 and hp <= 4780000 then
				req = 922000000
			end
			if hp > 4780000 and hp <= 4790000 then
				req = 924000000
			end
			if hp > 4790000 and hp <= 4800000 then
				req = 926000000
			end
			if hp > 4800000 and hp <= 4810000 then
				req = 928000000
			end
			if hp > 4810000 and hp <= 4820000 then
				req = 930000000
			end
			if hp > 4820000 and hp <= 4830000 then
				req = 932000000
			end
			if hp > 4830000 and hp <= 4840000 then
				req = 934000000
			end
			if hp > 4840000 and hp <= 4850000 then
				req = 936000000
			end
			if hp > 4850000 and hp <= 4860000 then
				req = 938000000
			end
			if hp > 4860000 and hp <= 4870000 then
				req = 940000000
			end
			if hp > 4870000 and hp <= 4880000 then
				req = 942000000
			end
			if hp > 4880000 and hp <= 4890000 then
				req = 944000000
			end
			if hp > 4890000 and hp <= 4900000 then
				req = 946000000
			end
			if hp > 4900000 and hp <= 4910000 then
				req = 948000000
			end
			if hp > 4910000 and hp <= 4920000 then
				req = 950000000
			end
			if hp > 4920000 and hp <= 4930000 then
				req = 952000000
			end
			if hp > 4930000 and hp <= 4940000 then
				req = 954000000
			end
			if hp > 4940000 and hp <= 4950000 then
				req = 956000000
			end
			if hp > 4950000 and hp <= 4960000 then
				req = 958000000
			end
			if hp > 4960000 and hp <= 4970000 then
				req = 960000000
			end
			if hp > 4970000 and hp <= 4980000 then
				req = 962000000
			end
			if hp > 4980000 and hp <= 4990000 then
				req = 964000000
			end
			if hp > 4990000 and hp <= 5000000 then
				req = 966000000
			end
			if hp > 5000000 and hp <= 5010000 then
				req = 968000000
			end
			if hp > 5010000 and hp <= 5020000 then
				req = 970000000
			end
			if hp > 5020000 and hp <= 5030000 then
				req = 972000000
			end
			if hp > 5030000 and hp <= 5040000 then
				req = 974000000
			end
			if hp > 5040000 and hp <= 5050000 then
				req = 976000000
			end
			if hp > 5050000 and hp <= 5060000 then
				req = 978000000
			end
			if hp > 5060000 and hp <= 5070000 then
				req = 980000000
			end
			if hp > 5070000 and hp <= 5080000 then
				req = 982000000
			end
			if hp > 5080000 and hp <= 5090000 then
				req = 984000000
			end
			if hp > 5090000 and hp <= 5100000 then
				req = 986000000
			end
			if hp > 5100000 and hp <= 5110000 then
				req = 988000000
			end
			if hp > 5110000 and hp <= 5120000 then
				req = 990000000
			end
			if hp > 5120000 and hp <= 5130000 then
				req = 992000000
			end
			if hp > 5130000 and hp <= 5140000 then
				req = 994000000
			end
			if hp > 5140000 and hp <= 5150000 then
				req = 996000000
			end
			if hp > 5150000 and hp <= 5160000 then
				req = 998000000
			end
			if hp > 5160000 and hp <= 5170000 then
				req = 1000000000
			end
			if hp > 5170000 and hp <= 5180000 then
				req = 1002000000
			end
			if hp > 5180000 and hp <= 5190000 then
				req = 1004000000
			end
			if hp > 5190000 and hp <= 5200000 then
				req = 1006000000
			end
			if hp > 5200000 and hp <= 5210000 then
				req = 1008000000
			end
			if hp > 5210000 and hp <= 5220000 then
				req = 1010000000
			end
			if hp > 5220000 and hp <= 5230000 then
				req = 1012000000
			end
			if hp > 5230000 and hp <= 5240000 then
				req = 1014000000
			end
			if hp > 5240000 and hp <= 5250000 then
				req = 1016000000
			end
			if hp > 5250000 and hp <= 5260000 then
				req = 1018000000
			end
			if hp > 5260000 and hp <= 5270000 then
				req = 1020000000
			end
			if hp > 5270000 and hp <= 5280000 then
				req = 1022000000
			end
			if hp > 5280000 and hp <= 5290000 then
				req = 1024000000
			end
			if hp > 5290000 and hp <= 5300000 then
				req = 1026000000
			end
			if hp > 5300000 and hp <= 5310000 then
				req = 1028000000
			end
			if hp > 5310000 and hp <= 5320000 then
				req = 1030000000
			end
			if hp > 5320000 and hp <= 5330000 then
				req = 1032000000
			end
			if hp > 5330000 and hp <= 5340000 then
				req = 1034000000
			end
			if hp > 5340000 and hp <= 5350000 then
				req = 1036000000
			end
			if hp > 5350000 and hp <= 5360000 then
				req = 1038000000
			end
			if hp > 5360000 and hp <= 5370000 then
				req = 1040000000
			end
			if hp > 5370000 and hp <= 5380000 then
				req = 1042000000
			end
			if hp > 5380000 and hp <= 5390000 then
				req = 1044000000
			end
			if hp > 5390000 and hp <= 5400000 then
				req = 1046000000
			end
			if hp > 5400000 and hp <= 5410000 then
				req = 1048000000
			end
			if hp > 5410000 and hp <= 5420000 then
				req = 1050000000
			end
			if hp > 5420000 and hp <= 5430000 then
				req = 1052000000
			end
			if hp > 5430000 and hp <= 5440000 then
				req = 1054000000
			end
			if hp > 5440000 and hp <= 5450000 then
				req = 1056000000
			end
			if hp > 5450000 and hp <= 5460000 then
				req = 1058000000
			end
			if hp > 5460000 and hp <= 5470000 then
				req = 1060000000
			end
			if hp > 5470000 and hp <= 5480000 then
				req = 1062000000
			end
			if hp > 5480000 and hp <= 5490000 then
				req = 1064000000
			end
			if hp > 5490000 and hp <= 5500000 then
				req = 1066000000
			end
			if hp > 5500000 and hp <= 5510000 then
				req = 1068000000
			end
			if hp > 5510000 and hp <= 5520000 then
				req = 1070000000
			end
			if hp > 5520000 and hp <= 5530000 then
				req = 1072000000
			end
			if hp > 5530000 and hp <= 5540000 then
				req = 1074000000
			end
			if hp > 5540000 and hp <= 5550000 then
				req = 1076000000
			end
			if hp > 5550000 and hp <= 5560000 then
				req = 1078000000
			end
			if hp > 5560000 and hp <= 5570000 then
				req = 1080000000
			end
			if hp > 5570000 and hp <= 5580000 then
				req = 1082000000
			end
			if hp > 5580000 and hp <= 5590000 then
				req = 1084000000
			end
			if hp > 5590000 and hp <= 5600000 then
				req = 1086000000
			end
			if hp > 5600000 and hp <= 5610000 then
				req = 1088000000
			end
			if hp > 5610000 and hp <= 5620000 then
				req = 1090000000
			end
			if hp > 5620000 and hp <= 5630000 then
				req = 1092000000
			end
			if hp > 5630000 and hp <= 5640000 then
				req = 1094000000
			end
			if hp > 5640000 and hp <= 5650000 then
				req = 1096000000
			end
			if hp > 5650000 and hp <= 5660000 then
				req = 1098000000
			end
			if hp > 5660000 and hp <= 5670000 then
				req = 1100000000
			end
			if hp > 5670000 and hp <= 5680000 then
				req = 1102000000
			end
			if hp > 5680000 and hp <= 5690000 then
				req = 1104000000
			end
			if hp > 5690000 and hp <= 5700000 then
				req = 1106000000
			end
			if hp > 5700000 and hp <= 5710000 then
				req = 1108000000
			end
			if hp > 5710000 and hp <= 5720000 then
				req = 1110000000
			end
			if hp > 5720000 and hp <= 5730000 then
				req = 1112000000
			end
			if hp > 5730000 and hp <= 5740000 then
				req = 1114000000
			end
			if hp > 5740000 and hp <= 5750000 then
				req = 1116000000
			end
			if hp > 5750000 and hp <= 5760000 then
				req = 1118000000
			end
			if hp > 5760000 and hp <= 5770000 then
				req = 1120000000
			end
			if hp > 5770000 and hp <= 5780000 then
				req = 1122000000
			end
			if hp > 5780000 and hp <= 5790000 then
				req = 1124000000
			end
			if hp > 5790000 and hp <= 5800000 then
				req = 1126000000
			end
			if hp > 5800000 and hp <= 5810000 then
				req = 1128000000
			end
			if hp > 5810000 and hp <= 5820000 then
				req = 1130000000
			end
			if hp > 5820000 and hp <= 5830000 then
				req = 1132000000
			end
			if hp > 5830000 and hp <= 5840000 then
				req = 1134000000
			end
			if hp > 5840000 and hp <= 5850000 then
				req = 1136000000
			end
			if hp > 5850000 and hp <= 5860000 then
				req = 1138000000
			end
			if hp > 5860000 and hp <= 5870000 then
				req = 1140000000
			end
			if hp > 5870000 and hp <= 5880000 then
				req = 1142000000
			end
			if hp > 5880000 and hp <= 5890000 then
				req = 1144000000
			end
			if hp > 5890000 and hp <= 5900000 then
				req = 1146000000
			end
			if hp > 5900000 and hp <= 5910000 then
				req = 1148000000
			end
			if hp > 5910000 and hp <= 5920000 then
				req = 1150000000
			end
			if hp > 5920000 and hp <= 5930000 then
				req = 1152000000
			end
			if hp > 5930000 and hp <= 5940000 then
				req = 1154000000
			end
			if hp > 5940000 and hp <= 5950000 then
				req = 1156000000
			end
			if hp > 5950000 and hp <= 5960000 then
				req = 1158000000
			end
			if hp > 5960000 and hp <= 5970000 then
				req = 1160000000
			end
			if hp > 5970000 and hp <= 5980000 then
				req = 1162000000
			end
			if hp > 5980000 and hp <= 5990000 then
				req = 1164000000
			end
			if hp > 5990000 and hp <= 6000000 then
				req = 1166000000
			end
			if hp > 6000000 and hp <= 6010000 then
				req = 1168000000
			end
			if hp > 6010000 and hp <= 6020000 then
				req = 1170000000
			end
			if hp > 6020000 and hp <= 6030000 then
				req = 1172000000
			end
			if hp > 6030000 and hp <= 6040000 then
				req = 1174000000
			end
			if hp > 6040000 and hp <= 6050000 then
				req = 1176000000
			end
			if hp > 6050000 and hp <= 6060000 then
				req = 1178000000
			end
			if hp > 6060000 and hp <= 6070000 then
				req = 1180000000
			end
			if hp > 6070000 and hp <= 6080000 then
				req = 1182000000
			end
			if hp > 6080000 and hp <= 6090000 then
				req = 1184000000
			end
			if hp > 6090000 and hp <= 6100000 then
				req = 1186000000
			end
			if hp > 6100000 and hp <= 6110000 then
				req = 1188000000
			end
			if hp > 6110000 and hp <= 6120000 then
				req = 1190000000
			end
			if hp > 6120000 and hp <= 6130000 then
				req = 1192000000
			end
			if hp > 6130000 and hp <= 6140000 then
				req = 1194000000
			end
			if hp > 6140000 and hp <= 6150000 then
				req = 1196000000
			end
			if hp > 6150000 and hp <= 6160000 then
				req = 1198000000
			end
			if hp > 6160000 and hp <= 6170000 then
				req = 1200000000
			end
			if hp > 6170000 and hp <= 6180000 then
				req = 1202000000
			end
			if hp > 6180000 and hp <= 6190000 then
				req = 1204000000
			end
			if hp > 6190000 and hp <= 6200000 then
				req = 1206000000
			end
			if hp > 6200000 and hp <= 6210000 then
				req = 1208000000
			end
			if hp > 6210000 and hp <= 6220000 then
				req = 1210000000
			end
			if hp > 6220000 and hp <= 6230000 then
				req = 1212000000
			end
			if hp > 6230000 and hp <= 6240000 then
				req = 1214000000
			end
			if hp > 6240000 and hp <= 6250000 then
				req = 1216000000
			end
			if hp > 6250000 and hp <= 6260000 then
				req = 1218000000
			end
			if hp > 6260000 and hp <= 6270000 then
				req = 1220000000
			end
			if hp > 6270000 and hp <= 6280000 then
				req = 1222000000
			end
			if hp > 6280000 and hp <= 6290000 then
				req = 1224000000
			end
			if hp > 6290000 and hp <= 6300000 then
				req = 1226000000
			end
			if hp > 6300000 and hp <= 6310000 then
				req = 1228000000
			end
			if hp > 6310000 and hp <= 6320000 then
				req = 1230000000
			end
			if hp > 6320000 and hp <= 6330000 then
				req = 1232000000
			end
			if hp > 6330000 and hp <= 6340000 then
				req = 1234000000
			end
			if hp > 6340000 and hp <= 6350000 then
				req = 1236000000
			end
			if hp > 6350000 and hp <= 6360000 then
				req = 1238000000
			end
			if hp > 6360000 and hp <= 6370000 then
				req = 1240000000
			end
			if hp > 6370000 and hp <= 6380000 then
				req = 1242000000
			end
			if hp > 6380000 and hp <= 6390000 then
				req = 1244000000
			end
			if hp > 6390000 and hp <= 6400000 then
				req = 1246000000
			end
			if hp > 6400000 and hp <= 6410000 then
				req = 1248000000
			end
			if hp > 6410000 and hp <= 6420000 then
				req = 1250000000
			end
			if hp > 6420000 and hp <= 6430000 then
				req = 1252000000
			end
			if hp > 6430000 and hp <= 6440000 then
				req = 1254000000
			end
			if hp > 6440000 and hp <= 6450000 then
				req = 1256000000
			end
			if hp > 6450000 and hp <= 6460000 then
				req = 1258000000
			end
			if hp > 6460000 and hp <= 6470000 then
				req = 1260000000
			end
			if hp > 6470000 and hp <= 6480000 then
				req = 1262000000
			end
			if hp > 6480000 and hp <= 6490000 then
				req = 1264000000
			end
			if hp > 6490000 and hp <= 6500000 then
				req = 1266000000
			end
			if hp > 6500000 and hp <= 6510000 then
				req = 1268000000
			end
			if hp > 6510000 and hp <= 6520000 then
				req = 1270000000
			end
			if hp > 6520000 and hp <= 6530000 then
				req = 1272000000
			end
			if hp > 6530000 and hp <= 6540000 then
				req = 1274000000
			end
			if hp > 6540000 and hp <= 6550000 then
				req = 1276000000
			end
			if hp > 6550000 and hp <= 6560000 then
				req = 1278000000
			end
			if hp > 6560000 and hp <= 6570000 then
				req = 1280000000
			end
			if hp > 6570000 and hp <= 6580000 then
				req = 1282000000
			end
			if hp > 6580000 and hp <= 6590000 then
				req = 1284000000
			end
			if hp > 6590000 and hp <= 6600000 then
				req = 1286000000
			end
			if hp > 6600000 and hp <= 6610000 then
				req = 1288000000
			end
			if hp > 6610000 and hp <= 6620000 then
				req = 1290000000
			end
			if hp > 6620000 and hp <= 6630000 then
				req = 1292000000
			end
			if hp > 6630000 and hp <= 6640000 then
				req = 1294000000
			end
			if hp > 6640000 and hp <= 6650000 then
				req = 1296000000
			end
			if hp > 6650000 and hp <= 6660000 then
				req = 1298000000
			end
			if hp > 6660000 and hp <= 6670000 then
				req = 1300000000
			end
			if hp > 6670000 and hp <= 6680000 then
				req = 1302000000
			end
			if hp > 6680000 and hp <= 6690000 then
				req = 1304000000
			end
			if hp > 6690000 and hp <= 6700000 then
				req = 1306000000
			end
			if hp > 6700000 and hp <= 6710000 then
				req = 1308000000
			end
			if hp > 6710000 and hp <= 6720000 then
				req = 1310000000
			end
			if hp > 6720000 and hp <= 6730000 then
				req = 1312000000
			end
			if hp > 6730000 and hp <= 6740000 then
				req = 1314000000
			end
			if hp > 6740000 and hp <= 6750000 then
				req = 1316000000
			end
			if hp > 6750000 and hp <= 6760000 then
				req = 1318000000
			end
			if hp > 6760000 and hp <= 6770000 then
				req = 1320000000
			end
			if hp > 6770000 and hp <= 6780000 then
				req = 1322000000
			end
			if hp > 6780000 and hp <= 6790000 then
				req = 1324000000
			end
			if hp > 6790000 and hp <= 6800000 then
				req = 1326000000
			end
			if hp > 6800000 and hp <= 6810000 then
				req = 1328000000
			end
			if hp > 6810000 and hp <= 6820000 then
				req = 1330000000
			end
			if hp > 6820000 and hp <= 6830000 then
				req = 1332000000
			end
			if hp > 6830000 and hp <= 6840000 then
				req = 1334000000
			end
			if hp > 6840000 and hp <= 6850000 then
				req = 1336000000
			end
			if hp > 6850000 and hp <= 6860000 then
				req = 1338000000
			end
			if hp > 6860000 and hp <= 6870000 then
				req = 1340000000
			end
			if hp > 6870000 and hp <= 6880000 then
				req = 1342000000
			end
			if hp > 6880000 and hp <= 6890000 then
				req = 1344000000
			end
			if hp > 6890000 and hp <= 6900000 then
				req = 1346000000
			end
			if hp > 6900000 and hp <= 6910000 then
				req = 1348000000
			end
			if hp > 6910000 and hp <= 6920000 then
				req = 1350000000
			end
			if hp > 6920000 and hp <= 6930000 then
				req = 1352000000
			end
			if hp > 6930000 and hp <= 6940000 then
				req = 1354000000
			end
			if hp > 6940000 and hp <= 6950000 then
				req = 1356000000
			end
			if hp > 6950000 and hp <= 6960000 then
				req = 1358000000
			end
			if hp > 6960000 and hp <= 6970000 then
				req = 1360000000
			end
			if hp > 6970000 and hp <= 6980000 then
				req = 1362000000
			end
			if hp > 6980000 and hp <= 6990000 then
				req = 1364000000
			end
			if hp > 6990000 and hp <= 7000000 then
				req = 1366000000
			end
			if hp > 7000000 and hp <= 7010000 then
				req = 1368000000
			end
			if hp > 7010000 and hp <= 7020000 then
				req = 1370000000
			end
			if hp > 7020000 and hp <= 7030000 then
				req = 1372000000
			end
			if hp > 7030000 and hp <= 7040000 then
				req = 1374000000
			end
			if hp > 7040000 and hp <= 7050000 then
				req = 1376000000
			end
			if hp > 7050000 and hp <= 7060000 then
				req = 1378000000
			end
			if hp > 7060000 and hp <= 7070000 then
				req = 1380000000
			end
			if hp > 7070000 and hp <= 7080000 then
				req = 1382000000
			end
			if hp > 7080000 and hp <= 7090000 then
				req = 1384000000
			end
			if hp > 7090000 and hp <= 7100000 then
				req = 1386000000
			end
			if hp > 7100000 and hp <= 7110000 then
				req = 1388000000
			end
			if hp > 7110000 and hp <= 7120000 then
				req = 1390000000
			end
			if hp > 7120000 and hp <= 7130000 then
				req = 1392000000
			end
			if hp > 7130000 and hp <= 7140000 then
				req = 1394000000
			end
			if hp > 7140000 and hp <= 7150000 then
				req = 1396000000
			end
			if hp > 7150000 and hp <= 7160000 then
				req = 1398000000
			end
			if hp > 7160000 and hp <= 7170000 then
				req = 1400000000
			end
			if hp > 7170000 and hp <= 7180000 then
				req = 1402000000
			end
			if hp > 7180000 and hp <= 7190000 then
				req = 1404000000
			end
			if hp > 7190000 and hp <= 7200000 then
				req = 1406000000
			end
			if hp > 7200000 and hp <= 7210000 then
				req = 1408000000
			end
			if hp > 7210000 and hp <= 7220000 then
				req = 1410000000
			end
			if hp > 7220000 and hp <= 7230000 then
				req = 1412000000
			end
			if hp > 7230000 and hp <= 7240000 then
				req = 1414000000
			end
			if hp > 7240000 and hp <= 7250000 then
				req = 1416000000
			end
			if hp > 7250000 and hp <= 7260000 then
				req = 1418000000
			end
			if hp > 7260000 and hp <= 7270000 then
				req = 1420000000
			end
			if hp > 7270000 and hp <= 7280000 then
				req = 1422000000
			end
			if hp > 7280000 and hp <= 7290000 then
				req = 1424000000
			end
			if hp > 7290000 and hp <= 7300000 then
				req = 1426000000
			end
			if hp > 7300000 and hp <= 7310000 then
				req = 1428000000
			end
			if hp > 7310000 and hp <= 7320000 then
				req = 1430000000
			end
			if hp > 7320000 and hp <= 7330000 then
				req = 1432000000
			end
			if hp > 7330000 and hp <= 7340000 then
				req = 1434000000
			end
			if hp > 7340000 and hp <= 7350000 then
				req = 1436000000
			end
			if hp > 7350000 and hp <= 7360000 then
				req = 1438000000
			end
			if hp > 7360000 and hp <= 7370000 then
				req = 1440000000
			end
			if hp > 7370000 and hp <= 7380000 then
				req = 1442000000
			end
			if hp > 7380000 and hp <= 7390000 then
				req = 1444000000
			end
			if hp > 7390000 and hp <= 7400000 then
				req = 1446000000
			end
			if hp > 7400000 and hp <= 7410000 then
				req = 1448000000
			end
			if hp > 7410000 and hp <= 7420000 then
				req = 1450000000
			end
			if hp > 7420000 and hp <= 7430000 then
				req = 1452000000
			end
			if hp > 7430000 and hp <= 7440000 then
				req = 1454000000
			end
			if hp > 7440000 and hp <= 7450000 then
				req = 1456000000
			end
			if hp > 7450000 and hp <= 7460000 then
				req = 1458000000
			end
			if hp > 7460000 and hp <= 7470000 then
				req = 1460000000
			end
			if hp > 7470000 and hp <= 7480000 then
				req = 1462000000
			end
			if hp > 7480000 and hp <= 7490000 then
				req = 1464000000
			end
			if hp > 7490000 and hp <= 7500000 then
				req = 1466000000
			end
			if hp > 7500000 and hp <= 7510000 then
				req = 1468000000
			end
			if hp > 7510000 and hp <= 7520000 then
				req = 1470000000
			end
			if hp > 7520000 and hp <= 7530000 then
				req = 1472000000
			end
			if hp > 7530000 and hp <= 7540000 then
				req = 1474000000
			end
			if hp > 7540000 and hp <= 7550000 then
				req = 1476000000
			end
			if hp > 7550000 and hp <= 7560000 then
				req = 1478000000
			end
			if hp > 7560000 and hp <= 7570000 then
				req = 1480000000
			end
			if hp > 7570000 and hp <= 7580000 then
				req = 1482000000
			end
			if hp > 7580000 and hp <= 7590000 then
				req = 1484000000
			end
			if hp > 7590000 and hp <= 7600000 then
				req = 1486000000
			end
			if hp > 7600000 and hp <= 7610000 then
				req = 1488000000
			end
			if hp > 7610000 and hp <= 7620000 then
				req = 1490000000
			end
			if hp > 7620000 and hp <= 7630000 then
				req = 1492000000
			end
			if hp > 7630000 and hp <= 7640000 then
				req = 1494000000
			end
			if hp > 7640000 and hp <= 7650000 then
				req = 1496000000
			end
			if hp > 7650000 and hp <= 7660000 then
				req = 1498000000
			end
			if hp > 7660000 and hp <= 7670000 then
				req = 1500000000
			end
			if hp > 7670000 and hp <= 7680000 then
				req = 1502000000
			end
			if hp > 7680000 and hp <= 7690000 then
				req = 1504000000
			end
			if hp > 7690000 and hp <= 7700000 then
				req = 1506000000
			end
			if hp > 7700000 and hp <= 7710000 then
				req = 1508000000
			end
			if hp > 7710000 and hp <= 7720000 then
				req = 1510000000
			end
			if hp > 7720000 and hp <= 7730000 then
				req = 1512000000
			end
			if hp > 7730000 and hp <= 7740000 then
				req = 1514000000
			end
			if hp > 7740000 and hp <= 7750000 then
				req = 1516000000
			end
			if hp > 7750000 and hp <= 7760000 then
				req = 1518000000
			end
			if hp > 7760000 and hp <= 7770000 then
				req = 1520000000
			end
			if hp > 7770000 and hp <= 7780000 then
				req = 1522000000
			end
			if hp > 7780000 and hp <= 7790000 then
				req = 1524000000
			end
			if hp > 7790000 and hp <= 7800000 then
				req = 1526000000
			end
			if hp > 7800000 and hp <= 7810000 then
				req = 1528000000
			end
			if hp > 7810000 and hp <= 7820000 then
				req = 1530000000
			end
			if hp > 7820000 and hp <= 7830000 then
				req = 1532000000
			end
			if hp > 7830000 and hp <= 7840000 then
				req = 1534000000
			end
			if hp > 7840000 and hp <= 7850000 then
				req = 1536000000
			end
			if hp > 7850000 and hp <= 7860000 then
				req = 1538000000
			end
			if hp > 7860000 and hp <= 7870000 then
				req = 1540000000
			end
			if hp > 7870000 and hp <= 7880000 then
				req = 1542000000
			end
			if hp > 7880000 and hp <= 7890000 then
				req = 1544000000
			end
			if hp > 7890000 and hp <= 7900000 then
				req = 1546000000
			end
			if hp > 7900000 and hp <= 7910000 then
				req = 1548000000
			end
			if hp > 7910000 and hp <= 7920000 then
				req = 1550000000
			end
			if hp > 7920000 and hp <= 7930000 then
				req = 1552000000
			end
			if hp > 7930000 and hp <= 7940000 then
				req = 1554000000
			end
			if hp > 7940000 and hp <= 7950000 then
				req = 1556000000
			end
			if hp > 7950000 and hp <= 7960000 then
				req = 1558000000
			end
			if hp > 7960000 and hp <= 7970000 then
				req = 1560000000
			end
			if hp > 7970000 and hp <= 7980000 then
				req = 1562000000
			end
			if hp > 7980000 and hp <= 7990000 then
				req = 1564000000
			end
			if hp > 7990000 and hp <= 8000000 then
				req = 1566000000
			end
			if hp > 8000000 and hp <= 8010000 then
				req = 1568000000
			end
			if hp > 8010000 and hp <= 8020000 then
				req = 1570000000
			end
			if hp > 8020000 and hp <= 8030000 then
				req = 1572000000
			end
			if hp > 8030000 and hp <= 8040000 then
				req = 1574000000
			end
			if hp > 8040000 and hp <= 8050000 then
				req = 1576000000
			end
			if hp > 8050000 and hp <= 8060000 then
				req = 1578000000
			end
			if hp > 8060000 and hp <= 8070000 then
				req = 1580000000
			end
			if hp > 8070000 and hp <= 8080000 then
				req = 1582000000
			end
			if hp > 8080000 and hp <= 8090000 then
				req = 1584000000
			end
			if hp > 8090000 and hp <= 8100000 then
				req = 1586000000
			end
			if hp > 8100000 and hp <= 8110000 then
				req = 1588000000
			end
			if hp > 8110000 and hp <= 8120000 then
				req = 1590000000
			end
			if hp > 8120000 and hp <= 8130000 then
				req = 1592000000
			end
			if hp > 8130000 and hp <= 8140000 then
				req = 1594000000
			end
			if hp > 8140000 and hp <= 8150000 then
				req = 1596000000
			end
			if hp > 8150000 and hp <= 8160000 then
				req = 1598000000
			end
			if hp > 8160000 and hp <= 8170000 then
				req = 1600000000
			end
			if hp > 8170000 and hp <= 8180000 then
				req = 1602000000
			end
			if hp > 8180000 and hp <= 8190000 then
				req = 1604000000
			end
			if hp > 8190000 and hp <= 8200000 then
				req = 1606000000
			end
			if hp > 8200000 and hp <= 8210000 then
				req = 1608000000
			end
			if hp > 8210000 and hp <= 8220000 then
				req = 1610000000
			end
			if hp > 8220000 and hp <= 8230000 then
				req = 1612000000
			end
			if hp > 8230000 and hp <= 8240000 then
				req = 1614000000
			end
			if hp > 8240000 and hp <= 8250000 then
				req = 1616000000
			end
			if hp > 8250000 and hp <= 8260000 then
				req = 1618000000
			end
			if hp > 8260000 and hp <= 8270000 then
				req = 1620000000
			end
			if hp > 8270000 and hp <= 8280000 then
				req = 1622000000
			end
			if hp > 8280000 and hp <= 8290000 then
				req = 1624000000
			end
			if hp > 8290000 and hp <= 8300000 then
				req = 1626000000
			end
			if hp > 8300000 and hp <= 8310000 then
				req = 1628000000
			end
			if hp > 8310000 and hp <= 8320000 then
				req = 1630000000
			end
			if hp > 8320000 and hp <= 8330000 then
				req = 1632000000
			end
			if hp > 8330000 and hp <= 8340000 then
				req = 1634000000
			end
			if hp > 8340000 and hp <= 8350000 then
				req = 1636000000
			end
			if hp > 8350000 and hp <= 8360000 then
				req = 1638000000
			end
			if hp > 8360000 and hp <= 8370000 then
				req = 1640000000
			end
			if hp > 8370000 and hp <= 8380000 then
				req = 1642000000
			end
			if hp > 8380000 and hp <= 8390000 then
				req = 1644000000
			end
			if hp > 8390000 and hp <= 8400000 then
				req = 1646000000
			end
			if hp > 8400000 and hp <= 8410000 then
				req = 1648000000
			end
			if hp > 8410000 and hp <= 8420000 then
				req = 1650000000
			end
			if hp > 8420000 and hp <= 8430000 then
				req = 1652000000
			end
			if hp > 8430000 and hp <= 8440000 then
				req = 1654000000
			end
			if hp > 8440000 and hp <= 8450000 then
				req = 1656000000
			end
			if hp > 8450000 and hp <= 8460000 then
				req = 1658000000
			end
			if hp > 8460000 and hp <= 8470000 then
				req = 1660000000
			end
			if hp > 8470000 and hp <= 8480000 then
				req = 1662000000
			end
			if hp > 8480000 and hp <= 8490000 then
				req = 1664000000
			end
			if hp > 8490000 and hp <= 8500000 then
				req = 1666000000
			end
			if hp > 8500000 and hp <= 8510000 then
				req = 1668000000
			end
			if hp > 8510000 and hp <= 8520000 then
				req = 1670000000
			end
			if hp > 8520000 and hp <= 8530000 then
				req = 1672000000
			end
			if hp > 8530000 and hp <= 8540000 then
				req = 1674000000
			end
			if hp > 8540000 and hp <= 8550000 then
				req = 1676000000
			end
			if hp > 8550000 and hp <= 8560000 then
				req = 1678000000
			end
			if hp > 8560000 and hp <= 8570000 then
				req = 1680000000
			end
			if hp > 8570000 and hp <= 8580000 then
				req = 1682000000
			end
			if hp > 8580000 and hp <= 8590000 then
				req = 1684000000
			end
			if hp > 8590000 and hp <= 8600000 then
				req = 1686000000
			end
			if hp > 8600000 and hp <= 8610000 then
				req = 1688000000
			end
			if hp > 8610000 and hp <= 8620000 then
				req = 1690000000
			end
			if hp > 8620000 and hp <= 8630000 then
				req = 1692000000
			end
			if hp > 8630000 and hp <= 8640000 then
				req = 1694000000
			end
			if hp > 8640000 and hp <= 8650000 then
				req = 1696000000
			end
			if hp > 8650000 and hp <= 8660000 then
				req = 1698000000
			end
			if hp > 8660000 and hp <= 8670000 then
				req = 1700000000
			end
			if hp > 8670000 and hp <= 8680000 then
				req = 1702000000
			end
			if hp > 8680000 and hp <= 8690000 then
				req = 1704000000
			end
			if hp > 8690000 and hp <= 8700000 then
				req = 1706000000
			end
			if hp > 8700000 and hp <= 8710000 then
				req = 1708000000
			end
			if hp > 8710000 and hp <= 8720000 then
				req = 1710000000
			end
			if hp > 8720000 and hp <= 8730000 then
				req = 1712000000
			end
			if hp > 8730000 and hp <= 8740000 then
				req = 1714000000
			end
			if hp > 8740000 and hp <= 8750000 then
				req = 1716000000
			end
			if hp > 8750000 and hp <= 8760000 then
				req = 1718000000
			end
			if hp > 8760000 and hp <= 8770000 then
				req = 1720000000
			end
			if hp > 8770000 and hp <= 8780000 then
				req = 1722000000
			end
			if hp > 8780000 and hp <= 8790000 then
				req = 1724000000
			end
			if hp > 8790000 and hp <= 8800000 then
				req = 1726000000
			end
			if hp > 8800000 and hp <= 8810000 then
				req = 1728000000
			end
			if hp > 8810000 and hp <= 8820000 then
				req = 1730000000
			end
			if hp > 8820000 and hp <= 8830000 then
				req = 1732000000
			end
			if hp > 8830000 and hp <= 8840000 then
				req = 1734000000
			end
			if hp > 8840000 and hp <= 8850000 then
				req = 1736000000
			end
			if hp > 8850000 and hp <= 8860000 then
				req = 1738000000
			end
			if hp > 8860000 and hp <= 8870000 then
				req = 1740000000
			end
			if hp > 8870000 and hp <= 8880000 then
				req = 1742000000
			end
			if hp > 8880000 and hp <= 8890000 then
				req = 1744000000
			end
			if hp > 8890000 and hp <= 8900000 then
				req = 1746000000
			end
			if hp > 8900000 and hp <= 8910000 then
				req = 1748000000
			end
			if hp > 8910000 and hp <= 8920000 then
				req = 1750000000
			end
			if hp > 8920000 and hp <= 8930000 then
				req = 1752000000
			end
			if hp > 8930000 and hp <= 8940000 then
				req = 1754000000
			end
			if hp > 8940000 and hp <= 8950000 then
				req = 1756000000
			end
			if hp > 8950000 and hp <= 8960000 then
				req = 1758000000
			end
			if hp > 8960000 and hp <= 8970000 then
				req = 1760000000
			end
			if hp > 8970000 and hp <= 8980000 then
				req = 1762000000
			end
			if hp > 8980000 and hp <= 8990000 then
				req = 1764000000
			end
			if hp > 8990000 and hp <= 9000000 then
				req = 1766000000
			end
			if hp > 9000000 and hp <= 9010000 then
				req = 1768000000
			end
			if hp > 9010000 and hp <= 9020000 then
				req = 1770000000
			end
			if hp > 9020000 and hp <= 9030000 then
				req = 1772000000
			end
			if hp > 9030000 and hp <= 9040000 then
				req = 1774000000
			end
			if hp > 9040000 and hp <= 9050000 then
				req = 1776000000
			end
			if hp > 9050000 and hp <= 9060000 then
				req = 1778000000
			end
			if hp > 9060000 and hp <= 9070000 then
				req = 1780000000
			end
			if hp > 9070000 and hp <= 9080000 then
				req = 1782000000
			end
			if hp > 9080000 and hp <= 9090000 then
				req = 1784000000
			end
			if hp > 9090000 and hp <= 9100000 then
				req = 1786000000
			end
			if hp > 9100000 and hp <= 9110000 then
				req = 1788000000
			end
			if hp > 9110000 and hp <= 9120000 then
				req = 1790000000
			end
			if hp > 9120000 and hp <= 9130000 then
				req = 1792000000
			end
			if hp > 9130000 and hp <= 9140000 then
				req = 1794000000
			end
			if hp > 9140000 and hp <= 9150000 then
				req = 1796000000
			end
			if hp > 9150000 and hp <= 9160000 then
				req = 1798000000
			end
			if hp > 9160000 and hp <= 9170000 then
				req = 1800000000
			end
			if hp > 9170000 and hp <= 9180000 then
				req = 1802000000
			end
			if hp > 9180000 and hp <= 9190000 then
				req = 1804000000
			end
			if hp > 9190000 and hp <= 9200000 then
				req = 1806000000
			end
			if hp > 9200000 and hp <= 9210000 then
				req = 1808000000
			end
			if hp > 9210000 and hp <= 9220000 then
				req = 1810000000
			end
			if hp > 9220000 and hp <= 9230000 then
				req = 1812000000
			end
			if hp > 9230000 and hp <= 9240000 then
				req = 1814000000
			end
			if hp > 9240000 and hp <= 9250000 then
				req = 1816000000
			end
			if hp > 9250000 and hp <= 9260000 then
				req = 1818000000
			end
			if hp > 9260000 and hp <= 9270000 then
				req = 1820000000
			end
			if hp > 9270000 and hp <= 9280000 then
				req = 1822000000
			end
			if hp > 9280000 and hp <= 9290000 then
				req = 1824000000
			end
			if hp > 9290000 and hp <= 9300000 then
				req = 1826000000
			end
			if hp > 9300000 and hp <= 9310000 then
				req = 1828000000
			end
			if hp > 9310000 and hp <= 9320000 then
				req = 1830000000
			end
			if hp > 9320000 and hp <= 9330000 then
				req = 1832000000
			end
			if hp > 9330000 and hp <= 9340000 then
				req = 1834000000
			end
			if hp > 9340000 and hp <= 9350000 then
				req = 1836000000
			end
			if hp > 9350000 and hp <= 9360000 then
				req = 1838000000
			end
			if hp > 9360000 and hp <= 9370000 then
				req = 1840000000
			end
			if hp > 9370000 and hp <= 9380000 then
				req = 1842000000
			end
			if hp > 9380000 and hp <= 9390000 then
				req = 1844000000
			end
			if hp > 9390000 and hp <= 9400000 then
				req = 1846000000
			end
			if hp > 9400000 and hp <= 9410000 then
				req = 1848000000
			end
			if hp > 9410000 and hp <= 9420000 then
				req = 1850000000
			end
			if hp > 9420000 and hp <= 9430000 then
				req = 1852000000
			end
			if hp > 9430000 and hp <= 9440000 then
				req = 1854000000
			end
			if hp > 9440000 and hp <= 9450000 then
				req = 1856000000
			end
			if hp > 9450000 and hp <= 9460000 then
				req = 1858000000
			end
			if hp > 9460000 and hp <= 9470000 then
				req = 1860000000
			end
			if hp > 9470000 and hp <= 9480000 then
				req = 1862000000
			end
			if hp > 9480000 and hp <= 9490000 then
				req = 1864000000
			end
			if hp > 9490000 and hp <= 9500000 then
				req = 1866000000
			end
			if hp > 9500000 and hp <= 9510000 then
				req = 1868000000
			end
			if hp > 9510000 and hp <= 9520000 then
				req = 1870000000
			end
			if hp > 9520000 and hp <= 9530000 then
				req = 1872000000
			end
			if hp > 9530000 and hp <= 9540000 then
				req = 1874000000
			end
			if hp > 9540000 and hp <= 9550000 then
				req = 1876000000
			end
			if hp > 9550000 and hp <= 9560000 then
				req = 1878000000
			end
			if hp > 9560000 and hp <= 9570000 then
				req = 1880000000
			end
			if hp > 9570000 and hp <= 9580000 then
				req = 1882000000
			end
			if hp > 9580000 and hp <= 9590000 then
				req = 1884000000
			end
			if hp > 9590000 and hp <= 9600000 then
				req = 1886000000
			end
			if hp > 9600000 and hp <= 9610000 then
				req = 1888000000
			end
			if hp > 9610000 and hp <= 9620000 then
				req = 1890000000
			end
			if hp > 9620000 and hp <= 9630000 then
				req = 1892000000
			end
			if hp > 9630000 and hp <= 9640000 then
				req = 1894000000
			end
			if hp > 9640000 and hp <= 9650000 then
				req = 1896000000
			end
			if hp > 9650000 and hp <= 9660000 then
				req = 1898000000
			end
			if hp > 9660000 and hp <= 9670000 then
				req = 1900000000
			end
			if hp > 9670000 and hp <= 9680000 then
				req = 1902000000
			end
			if hp > 9680000 and hp <= 9690000 then
				req = 1904000000
			end
			if hp > 9690000 and hp <= 9700000 then
				req = 1906000000
			end
			if hp > 9700000 and hp <= 9710000 then
				req = 1908000000
			end
			if hp > 9710000 and hp <= 9720000 then
				req = 1910000000
			end
			if hp > 9720000 and hp <= 9730000 then
				req = 1912000000
			end
			if hp > 9730000 and hp <= 9740000 then
				req = 1914000000
			end
			if hp > 9740000 and hp <= 9750000 then
				req = 1916000000
			end
			if hp > 9750000 and hp <= 9760000 then
				req = 1918000000
			end
			if hp > 9760000 and hp <= 9770000 then
				req = 1920000000
			end
			if hp > 9770000 and hp <= 9780000 then
				req = 1922000000
			end
			if hp > 9780000 and hp <= 9790000 then
				req = 1924000000
			end
			if hp > 9790000 and hp <= 9800000 then
				req = 1926000000
			end
			if hp > 9800000 and hp <= 9810000 then
				req = 1928000000
			end
			if hp > 9810000 and hp <= 9820000 then
				req = 1930000000
			end
			if hp > 9820000 and hp <= 9830000 then
				req = 1932000000
			end
			if hp > 9830000 and hp <= 9840000 then
				req = 1934000000
			end
			if hp > 9840000 and hp <= 9850000 then
				req = 1936000000
			end
			if hp > 9850000 and hp <= 9860000 then
				req = 1938000000
			end
			if hp > 9860000 and hp <= 9870000 then
				req = 1940000000
			end
			if hp > 9870000 and hp <= 9880000 then
				req = 1942000000
			end
			if hp > 9880000 and hp <= 9890000 then
				req = 1944000000
			end
			if hp > 9890000 and hp <= 9900000 then
				req = 1946000000
			end
			if hp > 9900000 and hp <= 9910000 then
				req = 1948000000
			end
			if hp > 9910000 and hp <= 9920000 then
				req = 1950000000
			end
			if hp > 9920000 and hp <= 9930000 then
				req = 1952000000
			end
			if hp > 9930000 and hp <= 9940000 then
				req = 1954000000
			end
			if hp > 9940000 and hp <= 9950000 then
				req = 1956000000
			end
			if hp > 9950000 and hp <= 9960000 then
				req = 1958000000
			end
			if hp > 9960000 and hp <= 9970000 then
				req = 1960000000
			end
			if hp > 9970000 and hp <= 9980000 then
				req = 1962000000
			end
			if hp > 9980000 and hp <= 9990000 then
				req = 1964000000
			end
			if hp > 9990000 and hp <= 10000000 then
				req = 1966000000
			end
			if hp > 10000000 and hp <= 10010000 then
				req = 1968000000
			end
		elseif job == 4 then -- Priest
			if hp <= 20000 then
				req = 10000000
			end
			if hp > 20000 and hp <= 30000 then
				req = 12000000
			end
			if hp > 30000 and hp <= 40000 then
				req = 14000000
			end
			if hp > 40000 and hp <= 50000 then
				req = 16000000
			end
			if hp > 50000 and hp <= 60000 then
				req = 18000000
			end
			if hp > 60000 and hp <= 70000 then
				req = 20000000
			end
			if hp > 70000 and hp <= 80000 then
				req = 22000000
			end
			if hp > 80000 and hp <= 90000 then
				req = 24000000
			end
			if hp > 90000 and hp <= 100000 then
				req = 26000000
			end
			if hp > 100000 and hp <= 110000 then
				req = 28000000
			end
			if hp > 110000 and hp <= 120000 then
				req = 30000000
			end
			if hp > 120000 and hp <= 130000 then
				req = 32000000
			end
			if hp > 130000 and hp <= 140000 then
				req = 34000000
			end
			if hp > 140000 and hp <= 150000 then
				req = 36000000
			end
			if hp > 150000 and hp <= 160000 then
				req = 38000000
			end
			if hp > 160000 and hp <= 170000 then
				req = 40000000
			end
			if hp > 170000 and hp <= 180000 then
				req = 42000000
			end
			if hp > 180000 and hp <= 190000 then
				req = 44000000
			end
			if hp > 190000 and hp <= 200000 then
				req = 46000000
			end
			if hp > 200000 and hp <= 210000 then
				req = 48000000
			end
			if hp > 210000 and hp <= 220000 then
				req = 50000000
			end
			if hp > 220000 and hp <= 230000 then
				req = 52000000
			end
			if hp > 230000 and hp <= 240000 then
				req = 54000000
			end
			if hp > 240000 and hp <= 250000 then
				req = 56000000
			end
			if hp > 250000 and hp <= 260000 then
				req = 58000000
			end
			if hp > 260000 and hp <= 270000 then
				req = 60000000
			end
			if hp > 270000 and hp <= 280000 then
				req = 62000000
			end
			if hp > 280000 and hp <= 290000 then
				req = 64000000
			end
			if hp > 290000 and hp <= 300000 then
				req = 66000000
			end
			if hp > 300000 and hp <= 310000 then
				req = 68000000
			end
			if hp > 310000 and hp <= 320000 then
				req = 70000000
			end
			if hp > 320000 and hp <= 330000 then
				req = 72000000
			end
			if hp > 330000 and hp <= 340000 then
				req = 74000000
			end
			if hp > 340000 and hp <= 350000 then
				req = 76000000
			end
			if hp > 350000 and hp <= 360000 then
				req = 78000000
			end
			if hp > 360000 and hp <= 370000 then
				req = 80000000
			end
			if hp > 370000 and hp <= 380000 then
				req = 82000000
			end
			if hp > 380000 and hp <= 390000 then
				req = 84000000
			end
			if hp > 390000 and hp <= 400000 then
				req = 86000000
			end
			if hp > 400000 and hp <= 410000 then
				req = 88000000
			end
			if hp > 410000 and hp <= 420000 then
				req = 90000000
			end
			if hp > 420000 and hp <= 430000 then
				req = 92000000
			end
			if hp > 430000 and hp <= 440000 then
				req = 94000000
			end
			if hp > 440000 and hp <= 450000 then
				req = 96000000
			end
			if hp > 450000 and hp <= 460000 then
				req = 98000000
			end
			if hp > 460000 and hp <= 470000 then
				req = 100000000
			end
			if hp > 470000 and hp <= 480000 then
				req = 102000000
			end
			if hp > 480000 and hp <= 490000 then
				req = 104000000
			end
			if hp > 490000 and hp <= 500000 then
				req = 106000000
			end
			if hp > 500000 and hp <= 510000 then
				req = 108000000
			end
			if hp > 510000 and hp <= 520000 then
				req = 110000000
			end
			if hp > 520000 and hp <= 530000 then
				req = 112000000
			end
			if hp > 530000 and hp <= 540000 then
				req = 114000000
			end
			if hp > 540000 and hp <= 550000 then
				req = 116000000
			end
			if hp > 550000 and hp <= 560000 then
				req = 118000000
			end
			if hp > 560000 and hp <= 570000 then
				req = 120000000
			end
			if hp > 570000 and hp <= 580000 then
				req = 122000000
			end
			if hp > 580000 and hp <= 590000 then
				req = 124000000
			end
			if hp > 590000 and hp <= 600000 then
				req = 126000000
			end
			if hp > 600000 and hp <= 610000 then
				req = 128000000
			end
			if hp > 610000 and hp <= 620000 then
				req = 130000000
			end
			if hp > 620000 and hp <= 630000 then
				req = 132000000
			end
			if hp > 630000 and hp <= 640000 then
				req = 134000000
			end
			if hp > 640000 and hp <= 650000 then
				req = 136000000
			end
			if hp > 650000 and hp <= 660000 then
				req = 138000000
			end
			if hp > 660000 and hp <= 670000 then
				req = 140000000
			end
			if hp > 670000 and hp <= 680000 then
				req = 142000000
			end
			if hp > 680000 and hp <= 690000 then
				req = 144000000
			end
			if hp > 690000 and hp <= 700000 then
				req = 146000000
			end
			if hp > 700000 and hp <= 710000 then
				req = 148000000
			end
			if hp > 710000 and hp <= 720000 then
				req = 150000000
			end
			if hp > 720000 and hp <= 730000 then
				req = 152000000
			end
			if hp > 730000 and hp <= 740000 then
				req = 154000000
			end
			if hp > 740000 and hp <= 750000 then
				req = 156000000
			end
			if hp > 750000 and hp <= 760000 then
				req = 158000000
			end
			if hp > 760000 and hp <= 770000 then
				req = 160000000
			end
			if hp > 770000 and hp <= 780000 then
				req = 162000000
			end
			if hp > 780000 and hp <= 790000 then
				req = 164000000
			end
			if hp > 790000 and hp <= 800000 then
				req = 166000000
			end
			if hp > 800000 and hp <= 810000 then
				req = 168000000
			end
			if hp > 810000 and hp <= 820000 then
				req = 170000000
			end
			if hp > 820000 and hp <= 830000 then
				req = 172000000
			end
			if hp > 830000 and hp <= 840000 then
				req = 174000000
			end
			if hp > 840000 and hp <= 850000 then
				req = 176000000
			end
			if hp > 850000 and hp <= 860000 then
				req = 178000000
			end
			if hp > 860000 and hp <= 870000 then
				req = 180000000
			end
			if hp > 870000 and hp <= 880000 then
				req = 182000000
			end
			if hp > 880000 and hp <= 890000 then
				req = 184000000
			end
			if hp > 890000 and hp <= 900000 then
				req = 186000000
			end
			if hp > 900000 and hp <= 910000 then
				req = 188000000
			end
			if hp > 910000 and hp <= 920000 then
				req = 190000000
			end
			if hp > 920000 and hp <= 930000 then
				req = 192000000
			end
			if hp > 930000 and hp <= 940000 then
				req = 194000000
			end
			if hp > 940000 and hp <= 950000 then
				req = 196000000
			end
			if hp > 950000 and hp <= 960000 then
				req = 198000000
			end
			if hp > 960000 and hp <= 970000 then
				req = 200000000
			end
			if hp > 970000 and hp <= 980000 then
				req = 202000000
			end
			if hp > 980000 and hp <= 990000 then
				req = 204000000
			end
			if hp > 990000 and hp <= 1000000 then
				req = 206000000
			end
			if hp > 1000000 and hp <= 1010000 then
				req = 208000000
			end
			if hp > 1010000 and hp <= 1020000 then
				req = 210000000
			end
			if hp > 1020000 and hp <= 1030000 then
				req = 212000000
			end
			if hp > 1030000 and hp <= 1040000 then
				req = 214000000
			end
			if hp > 1040000 and hp <= 1050000 then
				req = 216000000
			end
			if hp > 1050000 and hp <= 1060000 then
				req = 218000000
			end
			if hp > 1060000 and hp <= 1070000 then
				req = 220000000
			end
			if hp > 1070000 and hp <= 1080000 then
				req = 222000000
			end
			if hp > 1080000 and hp <= 1090000 then
				req = 224000000
			end
			if hp > 1090000 and hp <= 1100000 then
				req = 226000000
			end
			if hp > 1100000 and hp <= 1110000 then
				req = 228000000
			end
			if hp > 1110000 and hp <= 1120000 then
				req = 230000000
			end
			if hp > 1120000 and hp <= 1130000 then
				req = 232000000
			end
			if hp > 1130000 and hp <= 1140000 then
				req = 234000000
			end
			if hp > 1140000 and hp <= 1150000 then
				req = 236000000
			end
			if hp > 1150000 and hp <= 1160000 then
				req = 238000000
			end
			if hp > 1160000 and hp <= 1170000 then
				req = 240000000
			end
			if hp > 1170000 and hp <= 1180000 then
				req = 242000000
			end
			if hp > 1180000 and hp <= 1190000 then
				req = 244000000
			end
			if hp > 1190000 and hp <= 1200000 then
				req = 246000000
			end
			if hp > 1200000 and hp <= 1210000 then
				req = 248000000
			end
			if hp > 1210000 and hp <= 1220000 then
				req = 250000000
			end
			if hp > 1220000 and hp <= 1230000 then
				req = 252000000
			end
			if hp > 1230000 and hp <= 1240000 then
				req = 254000000
			end
			if hp > 1240000 and hp <= 1250000 then
				req = 256000000
			end
			if hp > 1250000 and hp <= 1260000 then
				req = 258000000
			end
			if hp > 1260000 and hp <= 1270000 then
				req = 260000000
			end
			if hp > 1270000 and hp <= 1280000 then
				req = 262000000
			end
			if hp > 1280000 and hp <= 1290000 then
				req = 264000000
			end
			if hp > 1290000 and hp <= 1300000 then
				req = 266000000
			end
			if hp > 1300000 and hp <= 1310000 then
				req = 268000000
			end
			if hp > 1310000 and hp <= 1320000 then
				req = 270000000
			end
			if hp > 1320000 and hp <= 1330000 then
				req = 272000000
			end
			if hp > 1330000 and hp <= 1340000 then
				req = 274000000
			end
			if hp > 1340000 and hp <= 1350000 then
				req = 276000000
			end
			if hp > 1350000 and hp <= 1360000 then
				req = 278000000
			end
			if hp > 1360000 and hp <= 1370000 then
				req = 280000000
			end
			if hp > 1370000 and hp <= 1380000 then
				req = 282000000
			end
			if hp > 1380000 and hp <= 1390000 then
				req = 284000000
			end
			if hp > 1390000 and hp <= 1400000 then
				req = 286000000
			end
			if hp > 1400000 and hp <= 1410000 then
				req = 288000000
			end
			if hp > 1410000 and hp <= 1420000 then
				req = 290000000
			end
			if hp > 1420000 and hp <= 1430000 then
				req = 292000000
			end
			if hp > 1430000 and hp <= 1440000 then
				req = 294000000
			end
			if hp > 1440000 and hp <= 1450000 then
				req = 296000000
			end
			if hp > 1450000 and hp <= 1460000 then
				req = 298000000
			end
			if hp > 1460000 and hp <= 1470000 then
				req = 300000000
			end
			if hp > 1470000 and hp <= 1480000 then
				req = 302000000
			end
			if hp > 1480000 and hp <= 1490000 then
				req = 304000000
			end
			if hp > 1490000 and hp <= 1500000 then
				req = 306000000
			end
			if hp > 1500000 and hp <= 1510000 then
				req = 308000000
			end
			if hp > 1510000 and hp <= 1520000 then
				req = 310000000
			end
			if hp > 1520000 and hp <= 1530000 then
				req = 312000000
			end
			if hp > 1530000 and hp <= 1540000 then
				req = 314000000
			end
			if hp > 1540000 and hp <= 1550000 then
				req = 316000000
			end
			if hp > 1550000 and hp <= 1560000 then
				req = 318000000
			end
			if hp > 1560000 and hp <= 1570000 then
				req = 320000000
			end
			if hp > 1570000 and hp <= 1580000 then
				req = 322000000
			end
			if hp > 1580000 and hp <= 1590000 then
				req = 324000000
			end
			if hp > 1590000 and hp <= 1600000 then
				req = 326000000
			end
			if hp > 1600000 and hp <= 1610000 then
				req = 328000000
			end
			if hp > 1610000 and hp <= 1620000 then
				req = 330000000
			end
			if hp > 1620000 and hp <= 1630000 then
				req = 332000000
			end
			if hp > 1630000 and hp <= 1640000 then
				req = 334000000
			end
			if hp > 1640000 and hp <= 1650000 then
				req = 336000000
			end
			if hp > 1650000 and hp <= 1660000 then
				req = 338000000
			end
			if hp > 1660000 and hp <= 1670000 then
				req = 340000000
			end
			if hp > 1670000 and hp <= 1680000 then
				req = 342000000
			end
			if hp > 1680000 and hp <= 1690000 then
				req = 344000000
			end
			if hp > 1690000 and hp <= 1700000 then
				req = 346000000
			end
			if hp > 1700000 and hp <= 1710000 then
				req = 348000000
			end
			if hp > 1710000 and hp <= 1720000 then
				req = 350000000
			end
			if hp > 1720000 and hp <= 1730000 then
				req = 352000000
			end
			if hp > 1730000 and hp <= 1740000 then
				req = 354000000
			end
			if hp > 1740000 and hp <= 1750000 then
				req = 356000000
			end
			if hp > 1750000 and hp <= 1760000 then
				req = 358000000
			end
			if hp > 1760000 and hp <= 1770000 then
				req = 360000000
			end
			if hp > 1770000 and hp <= 1780000 then
				req = 362000000
			end
			if hp > 1780000 and hp <= 1790000 then
				req = 364000000
			end
			if hp > 1790000 and hp <= 1800000 then
				req = 366000000
			end
			if hp > 1800000 and hp <= 1810000 then
				req = 368000000
			end
			if hp > 1810000 and hp <= 1820000 then
				req = 370000000
			end
			if hp > 1820000 and hp <= 1830000 then
				req = 372000000
			end
			if hp > 1830000 and hp <= 1840000 then
				req = 374000000
			end
			if hp > 1840000 and hp <= 1850000 then
				req = 376000000
			end
			if hp > 1850000 and hp <= 1860000 then
				req = 378000000
			end
			if hp > 1860000 and hp <= 1870000 then
				req = 380000000
			end
			if hp > 1870000 and hp <= 1880000 then
				req = 382000000
			end
			if hp > 1880000 and hp <= 1890000 then
				req = 384000000
			end
			if hp > 1890000 and hp <= 1900000 then
				req = 386000000
			end
			if hp > 1900000 and hp <= 1910000 then
				req = 388000000
			end
			if hp > 1910000 and hp <= 1920000 then
				req = 390000000
			end
			if hp > 1920000 and hp <= 1930000 then
				req = 392000000
			end
			if hp > 1930000 and hp <= 1940000 then
				req = 394000000
			end
			if hp > 1940000 and hp <= 1950000 then
				req = 396000000
			end
			if hp > 1950000 and hp <= 1960000 then
				req = 398000000
			end
			if hp > 1960000 and hp <= 1970000 then
				req = 400000000
			end
			if hp > 1970000 and hp <= 1980000 then
				req = 402000000
			end
			if hp > 1980000 and hp <= 1990000 then
				req = 404000000
			end
			if hp > 1990000 and hp <= 2000000 then
				req = 406000000
			end
			if hp > 2000000 and hp <= 2010000 then
				req = 408000000
			end
			if hp > 2010000 and hp <= 2020000 then
				req = 410000000
			end
			if hp > 2020000 and hp <= 2030000 then
				req = 412000000
			end
			if hp > 2030000 and hp <= 2040000 then
				req = 414000000
			end
			if hp > 2040000 and hp <= 2050000 then
				req = 416000000
			end
			if hp > 2050000 and hp <= 2060000 then
				req = 418000000
			end
			if hp > 2060000 and hp <= 2070000 then
				req = 420000000
			end
			if hp > 2070000 and hp <= 2080000 then
				req = 422000000
			end
			if hp > 2080000 and hp <= 2090000 then
				req = 424000000
			end
			if hp > 2090000 and hp <= 2100000 then
				req = 426000000
			end
			if hp > 2100000 and hp <= 2110000 then
				req = 428000000
			end
			if hp > 2110000 and hp <= 2120000 then
				req = 430000000
			end
			if hp > 2120000 and hp <= 2130000 then
				req = 432000000
			end
			if hp > 2130000 and hp <= 2140000 then
				req = 434000000
			end
			if hp > 2140000 and hp <= 2150000 then
				req = 436000000
			end
			if hp > 2150000 and hp <= 2160000 then
				req = 438000000
			end
			if hp > 2160000 and hp <= 2170000 then
				req = 440000000
			end
			if hp > 2170000 and hp <= 2180000 then
				req = 442000000
			end
			if hp > 2180000 and hp <= 2190000 then
				req = 444000000
			end
			if hp > 2190000 and hp <= 2200000 then
				req = 446000000
			end
			if hp > 2200000 and hp <= 2210000 then
				req = 448000000
			end
			if hp > 2210000 and hp <= 2220000 then
				req = 450000000
			end
			if hp > 2220000 and hp <= 2230000 then
				req = 452000000
			end
			if hp > 2230000 and hp <= 2240000 then
				req = 454000000
			end
			if hp > 2240000 and hp <= 2250000 then
				req = 456000000
			end
			if hp > 2250000 and hp <= 2260000 then
				req = 458000000
			end
			if hp > 2260000 and hp <= 2270000 then
				req = 460000000
			end
			if hp > 2270000 and hp <= 2280000 then
				req = 462000000
			end
			if hp > 2280000 and hp <= 2290000 then
				req = 464000000
			end
			if hp > 2290000 and hp <= 2300000 then
				req = 466000000
			end
			if hp > 2300000 and hp <= 2310000 then
				req = 468000000
			end
			if hp > 2310000 and hp <= 2320000 then
				req = 470000000
			end
			if hp > 2320000 and hp <= 2330000 then
				req = 472000000
			end
			if hp > 2330000 and hp <= 2340000 then
				req = 474000000
			end
			if hp > 2340000 and hp <= 2350000 then
				req = 476000000
			end
			if hp > 2350000 and hp <= 2360000 then
				req = 478000000
			end
			if hp > 2360000 and hp <= 2370000 then
				req = 480000000
			end
			if hp > 2370000 and hp <= 2380000 then
				req = 482000000
			end
			if hp > 2380000 and hp <= 2390000 then
				req = 484000000
			end
			if hp > 2390000 and hp <= 2400000 then
				req = 486000000
			end
			if hp > 2400000 and hp <= 2410000 then
				req = 488000000
			end
			if hp > 2410000 and hp <= 2420000 then
				req = 490000000
			end
			if hp > 2420000 and hp <= 2430000 then
				req = 492000000
			end
			if hp > 2430000 and hp <= 2440000 then
				req = 494000000
			end
			if hp > 2440000 and hp <= 2450000 then
				req = 496000000
			end
			if hp > 2450000 and hp <= 2460000 then
				req = 498000000
			end
			if hp > 2460000 and hp <= 2470000 then
				req = 500000000
			end
			if hp > 2470000 and hp <= 2480000 then
				req = 502000000
			end
			if hp > 2480000 and hp <= 2490000 then
				req = 504000000
			end
			if hp > 2490000 and hp <= 2500000 then
				req = 506000000
			end
			if hp > 2500000 and hp <= 2510000 then
				req = 508000000
			end
			if hp > 2510000 and hp <= 2520000 then
				req = 510000000
			end
			if hp > 2520000 and hp <= 2530000 then
				req = 512000000
			end
			if hp > 2530000 and hp <= 2540000 then
				req = 514000000
			end
			if hp > 2540000 and hp <= 2550000 then
				req = 516000000
			end
			if hp > 2550000 and hp <= 2560000 then
				req = 518000000
			end
			if hp > 2560000 and hp <= 2570000 then
				req = 520000000
			end
			if hp > 2570000 and hp <= 2580000 then
				req = 522000000
			end
			if hp > 2580000 and hp <= 2590000 then
				req = 524000000
			end
			if hp > 2590000 and hp <= 2600000 then
				req = 526000000
			end
			if hp > 2600000 and hp <= 2610000 then
				req = 528000000
			end
			if hp > 2610000 and hp <= 2620000 then
				req = 490000000
			end
			if hp > 2620000 and hp <= 2630000 then
				req = 492000000
			end
			if hp > 2630000 and hp <= 2640000 then
				req = 494000000
			end
			if hp > 2640000 and hp <= 2650000 then
				req = 496000000
			end
			if hp > 2650000 and hp <= 2660000 then
				req = 498000000
			end
			if hp > 2660000 and hp <= 2670000 then
				req = 500000000
			end
			if hp > 2670000 and hp <= 2680000 then
				req = 502000000
			end
			if hp > 2680000 and hp <= 2690000 then
				req = 504000000
			end
			if hp > 2690000 and hp <= 2700000 then
				req = 506000000
			end
			if hp > 2700000 and hp <= 2710000 then
				req = 508000000
			end
			if hp > 2710000 and hp <= 2720000 then
				req = 510000000
			end
			if hp > 2720000 and hp <= 2730000 then
				req = 512000000
			end
			if hp > 2730000 and hp <= 2740000 then
				req = 514000000
			end
			if hp > 2740000 and hp <= 2750000 then
				req = 516000000
			end
			if hp > 2750000 and hp <= 2760000 then
				req = 518000000
			end
			if hp > 2760000 and hp <= 2770000 then
				req = 520000000
			end
			if hp > 2770000 and hp <= 2780000 then
				req = 522000000
			end
			if hp > 2780000 and hp <= 2790000 then
				req = 524000000
			end
			if hp > 2790000 and hp <= 2800000 then
				req = 526000000
			end
			if hp > 2800000 and hp <= 2810000 then
				req = 528000000
			end
			if hp > 2810000 and hp <= 2820000 then
				req = 530000000
			end
			if hp > 2820000 and hp <= 2830000 then
				req = 532000000
			end
			if hp > 2830000 and hp <= 2840000 then
				req = 534000000
			end
			if hp > 2840000 and hp <= 2850000 then
				req = 536000000
			end
			if hp > 2850000 and hp <= 2860000 then
				req = 538000000
			end
			if hp > 2860000 and hp <= 2870000 then
				req = 540000000
			end
			if hp > 2870000 and hp <= 2880000 then
				req = 542000000
			end
			if hp > 2880000 and hp <= 2890000 then
				req = 544000000
			end
			if hp > 2890000 and hp <= 2900000 then
				req = 546000000
			end
			if hp > 2900000 and hp <= 2910000 then
				req = 548000000
			end
			if hp > 2910000 and hp <= 2920000 then
				req = 550000000
			end
			if hp > 2920000 and hp <= 2930000 then
				req = 552000000
			end
			if hp > 2930000 and hp <= 2940000 then
				req = 554000000
			end
			if hp > 2940000 and hp <= 2950000 then
				req = 556000000
			end
			if hp > 2950000 and hp <= 2960000 then
				req = 558000000
			end
			if hp > 2960000 and hp <= 2970000 then
				req = 560000000
			end
			if hp > 2970000 and hp <= 2980000 then
				req = 562000000
			end
			if hp > 2980000 and hp <= 2990000 then
				req = 564000000
			end
			if hp > 2990000 and hp <= 3000000 then
				req = 566000000
			end
			if hp > 3000000 and hp <= 3010000 then
				req = 568000000
			end
			if hp > 3010000 and hp <= 3020000 then
				req = 570000000
			end
			if hp > 3020000 and hp <= 3030000 then
				req = 572000000
			end
			if hp > 3030000 and hp <= 3040000 then
				req = 574000000
			end
			if hp > 3040000 and hp <= 3050000 then
				req = 576000000
			end
			if hp > 3050000 and hp <= 3060000 then
				req = 578000000
			end
			if hp > 3060000 and hp <= 3070000 then
				req = 580000000
			end
			if hp > 3070000 and hp <= 3080000 then
				req = 582000000
			end
			if hp > 3080000 and hp <= 3090000 then
				req = 584000000
			end
			if hp > 3090000 and hp <= 3100000 then
				req = 586000000
			end
			if hp > 3100000 and hp <= 3110000 then
				req = 588000000
			end
			if hp > 3110000 and hp <= 3120000 then
				req = 590000000
			end
			if hp > 3120000 and hp <= 3130000 then
				req = 592000000
			end
			if hp > 3130000 and hp <= 3140000 then
				req = 594000000
			end
			if hp > 3140000 and hp <= 3150000 then
				req = 596000000
			end
			if hp > 3150000 and hp <= 3160000 then
				req = 598000000
			end
			if hp > 3160000 and hp <= 3170000 then
				req = 600000000
			end
			if hp > 3170000 and hp <= 3180000 then
				req = 602000000
			end
			if hp > 3180000 and hp <= 3190000 then
				req = 604000000
			end
			if hp > 3190000 and hp <= 3200000 then
				req = 606000000
			end
			if hp > 3200000 and hp <= 3210000 then
				req = 608000000
			end
			if hp > 3210000 and hp <= 3220000 then
				req = 610000000
			end
			if hp > 3220000 and hp <= 3230000 then
				req = 612000000
			end
			if hp > 3230000 and hp <= 3240000 then
				req = 614000000
			end
			if hp > 3240000 and hp <= 3250000 then
				req = 616000000
			end
			if hp > 3250000 and hp <= 3260000 then
				req = 618000000
			end
			if hp > 3260000 and hp <= 3270000 then
				req = 620000000
			end
			if hp > 3270000 and hp <= 3280000 then
				req = 622000000
			end
			if hp > 3280000 and hp <= 3290000 then
				req = 624000000
			end
			if hp > 3290000 and hp <= 3300000 then
				req = 626000000
			end
			if hp > 3300000 and hp <= 3310000 then
				req = 628000000
			end
			if hp > 3310000 and hp <= 3320000 then
				req = 630000000
			end
			if hp > 3320000 and hp <= 3330000 then
				req = 632000000
			end
			if hp > 3330000 and hp <= 3340000 then
				req = 634000000
			end
			if hp > 3340000 and hp <= 3350000 then
				req = 636000000
			end
			if hp > 3350000 and hp <= 3360000 then
				req = 638000000
			end
			if hp > 3360000 and hp <= 3370000 then
				req = 640000000
			end
			if hp > 3370000 and hp <= 3380000 then
				req = 642000000
			end
			if hp > 3380000 and hp <= 3390000 then
				req = 644000000
			end
			if hp > 3390000 and hp <= 3400000 then
				req = 646000000
			end
			if hp > 3400000 and hp <= 3410000 then
				req = 648000000
			end
			if hp > 3410000 and hp <= 3420000 then
				req = 650000000
			end
			if hp > 3420000 and hp <= 3430000 then
				req = 652000000
			end
			if hp > 3430000 and hp <= 3440000 then
				req = 654000000
			end
			if hp > 3440000 and hp <= 3450000 then
				req = 656000000
			end
			if hp > 3450000 and hp <= 3460000 then
				req = 658000000
			end
			if hp > 3460000 and hp <= 3470000 then
				req = 660000000
			end
			if hp > 3470000 and hp <= 3480000 then
				req = 662000000
			end
			if hp > 3480000 and hp <= 3490000 then
				req = 664000000
			end
			if hp > 3490000 and hp <= 3500000 then
				req = 666000000
			end
			if hp > 3500000 and hp <= 3510000 then
				req = 668000000
			end
			if hp > 3510000 and hp <= 3520000 then
				req = 670000000
			end
			if hp > 3520000 and hp <= 3530000 then
				req = 672000000
			end
			if hp > 3530000 and hp <= 3540000 then
				req = 674000000
			end
			if hp > 3540000 and hp <= 3550000 then
				req = 676000000
			end
			if hp > 3550000 and hp <= 3560000 then
				req = 678000000
			end
			if hp > 3560000 and hp <= 3570000 then
				req = 680000000
			end
			if hp > 3570000 and hp <= 3580000 then
				req = 682000000
			end
			if hp > 3580000 and hp <= 3590000 then
				req = 684000000
			end
			if hp > 3590000 and hp <= 3600000 then
				req = 686000000
			end
			if hp > 3600000 and hp <= 3610000 then
				req = 688000000
			end
			if hp > 3610000 and hp <= 3620000 then
				req = 690000000
			end
			if hp > 3620000 and hp <= 3630000 then
				req = 692000000
			end
			if hp > 3630000 and hp <= 3640000 then
				req = 694000000
			end
			if hp > 3640000 and hp <= 3650000 then
				req = 696000000
			end
			if hp > 3650000 and hp <= 3660000 then
				req = 698000000
			end
			if hp > 3660000 and hp <= 3670000 then
				req = 700000000
			end
			if hp > 3670000 and hp <= 3680000 then
				req = 702000000
			end
			if hp > 3680000 and hp <= 3690000 then
				req = 704000000
			end
			if hp > 3690000 and hp <= 3700000 then
				req = 706000000
			end
			if hp > 3700000 and hp <= 3710000 then
				req = 708000000
			end
			if hp > 3710000 and hp <= 3720000 then
				req = 710000000
			end
			if hp > 3720000 and hp <= 3730000 then
				req = 712000000
			end
			if hp > 3730000 and hp <= 3740000 then
				req = 714000000
			end
			if hp > 3740000 and hp <= 3750000 then
				req = 716000000
			end
			if hp > 3750000 and hp <= 3760000 then
				req = 718000000
			end
			if hp > 3760000 and hp <= 3770000 then
				req = 720000000
			end
			if hp > 3770000 and hp <= 3780000 then
				req = 722000000
			end
			if hp > 3780000 and hp <= 3790000 then
				req = 724000000
			end
			if hp > 3790000 and hp <= 3800000 then
				req = 726000000
			end
			if hp > 3800000 and hp <= 3810000 then
				req = 728000000
			end
			if hp > 3810000 and hp <= 3820000 then
				req = 730000000
			end
			if hp > 3820000 and hp <= 3830000 then
				req = 732000000
			end
			if hp > 3830000 and hp <= 3840000 then
				req = 734000000
			end
			if hp > 3840000 and hp <= 3850000 then
				req = 736000000
			end
			if hp > 3850000 and hp <= 3860000 then
				req = 738000000
			end
			if hp > 3860000 and hp <= 3870000 then
				req = 740000000
			end
			if hp > 3870000 and hp <= 3880000 then
				req = 742000000
			end
			if hp > 3880000 and hp <= 3890000 then
				req = 744000000
			end
			if hp > 3890000 and hp <= 3900000 then
				req = 746000000
			end
			if hp > 3900000 and hp <= 3910000 then
				req = 748000000
			end
			if hp > 3910000 and hp <= 3920000 then
				req = 750000000
			end
			if hp > 3920000 and hp <= 3930000 then
				req = 752000000
			end
			if hp > 3930000 and hp <= 3940000 then
				req = 754000000
			end
			if hp > 3940000 and hp <= 3950000 then
				req = 756000000
			end
			if hp > 3950000 and hp <= 3960000 then
				req = 758000000
			end
			if hp > 3960000 and hp <= 3970000 then
				req = 760000000
			end
			if hp > 3970000 and hp <= 3980000 then
				req = 762000000
			end
			if hp > 3980000 and hp <= 3990000 then
				req = 764000000
			end
			if hp > 3990000 and hp <= 4000000 then
				req = 766000000
			end
			if hp > 4000000 and hp <= 4010000 then
				req = 768000000
			end
			if hp > 4010000 and hp <= 4020000 then
				req = 770000000
			end
			if hp > 4020000 and hp <= 4030000 then
				req = 772000000
			end
			if hp > 4030000 and hp <= 4040000 then
				req = 774000000
			end
			if hp > 4040000 and hp <= 4050000 then
				req = 776000000
			end
			if hp > 4050000 and hp <= 4060000 then
				req = 778000000
			end
			if hp > 4060000 and hp <= 4070000 then
				req = 780000000
			end
			if hp > 4070000 and hp <= 4080000 then
				req = 782000000
			end
			if hp > 4080000 and hp <= 4090000 then
				req = 784000000
			end
			if hp > 4090000 and hp <= 4100000 then
				req = 786000000
			end
			if hp > 4100000 and hp <= 4110000 then
				req = 788000000
			end
			if hp > 4110000 and hp <= 4120000 then
				req = 790000000
			end
			if hp > 4120000 and hp <= 4130000 then
				req = 792000000
			end
			if hp > 4130000 and hp <= 4140000 then
				req = 794000000
			end
			if hp > 4140000 and hp <= 4150000 then
				req = 796000000
			end
			if hp > 4150000 and hp <= 4160000 then
				req = 798000000
			end
			if hp > 4160000 and hp <= 4170000 then
				req = 800000000
			end
			if hp > 4170000 and hp <= 4180000 then
				req = 802000000
			end
			if hp > 4180000 and hp <= 4190000 then
				req = 804000000
			end
			if hp > 4190000 and hp <= 4200000 then
				req = 806000000
			end
			if hp > 4200000 and hp <= 4210000 then
				req = 808000000
			end
			if hp > 4210000 and hp <= 4220000 then
				req = 810000000
			end
			if hp > 4220000 and hp <= 4230000 then
				req = 812000000
			end
			if hp > 4230000 and hp <= 4240000 then
				req = 814000000
			end
			if hp > 4240000 and hp <= 4250000 then
				req = 816000000
			end
			if hp > 4250000 and hp <= 4260000 then
				req = 818000000
			end
			if hp > 4260000 and hp <= 4270000 then
				req = 820000000
			end
			if hp > 4270000 and hp <= 4280000 then
				req = 822000000
			end
			if hp > 4280000 and hp <= 4290000 then
				req = 824000000
			end
			if hp > 4290000 and hp <= 4300000 then
				req = 826000000
			end
			if hp > 4300000 and hp <= 4310000 then
				req = 828000000
			end
			if hp > 4310000 and hp <= 4320000 then
				req = 830000000
			end
			if hp > 4320000 and hp <= 4330000 then
				req = 832000000
			end
			if hp > 4330000 and hp <= 4340000 then
				req = 834000000
			end
			if hp > 4340000 and hp <= 4350000 then
				req = 836000000
			end
			if hp > 4350000 and hp <= 4360000 then
				req = 838000000
			end
			if hp > 4360000 and hp <= 4370000 then
				req = 840000000
			end
			if hp > 4370000 and hp <= 4380000 then
				req = 842000000
			end
			if hp > 4380000 and hp <= 4390000 then
				req = 844000000
			end
			if hp > 4390000 and hp <= 4400000 then
				req = 846000000
			end
			if hp > 4400000 and hp <= 4410000 then
				req = 848000000
			end
			if hp > 4410000 and hp <= 4420000 then
				req = 850000000
			end
			if hp > 4420000 and hp <= 4430000 then
				req = 852000000
			end
			if hp > 4430000 and hp <= 4440000 then
				req = 854000000
			end
			if hp > 4440000 and hp <= 4450000 then
				req = 856000000
			end
			if hp > 4450000 and hp <= 4460000 then
				req = 858000000
			end
			if hp > 4460000 and hp <= 4470000 then
				req = 860000000
			end
			if hp > 4470000 and hp <= 4480000 then
				req = 862000000
			end
			if hp > 4480000 and hp <= 4490000 then
				req = 864000000
			end
			if hp > 4490000 and hp <= 4500000 then
				req = 866000000
			end
			if hp > 4500000 and hp <= 4510000 then
				req = 868000000
			end
			if hp > 4510000 and hp <= 4520000 then
				req = 870000000
			end
			if hp > 4520000 and hp <= 4530000 then
				req = 872000000
			end
			if hp > 4530000 and hp <= 4540000 then
				req = 874000000
			end
			if hp > 4540000 and hp <= 4550000 then
				req = 876000000
			end
			if hp > 4550000 and hp <= 4560000 then
				req = 878000000
			end
			if hp > 4560000 and hp <= 4570000 then
				req = 880000000
			end
			if hp > 4570000 and hp <= 4580000 then
				req = 882000000
			end
			if hp > 4580000 and hp <= 4590000 then
				req = 884000000
			end
			if hp > 4590000 and hp <= 4600000 then
				req = 886000000
			end
			if hp > 4600000 and hp <= 4610000 then
				req = 888000000
			end
			if hp > 4610000 and hp <= 4620000 then
				req = 890000000
			end
			if hp > 4620000 and hp <= 4630000 then
				req = 892000000
			end
			if hp > 4630000 and hp <= 4640000 then
				req = 894000000
			end
			if hp > 4640000 and hp <= 4650000 then
				req = 896000000
			end
			if hp > 4650000 and hp <= 4660000 then
				req = 898000000
			end
			if hp > 4660000 and hp <= 4670000 then
				req = 900000000
			end
			if hp > 4670000 and hp <= 4680000 then
				req = 902000000
			end
			if hp > 4680000 and hp <= 4690000 then
				req = 904000000
			end
			if hp > 4690000 and hp <= 4700000 then
				req = 906000000
			end
			if hp > 4700000 and hp <= 4710000 then
				req = 908000000
			end
			if hp > 4710000 and hp <= 4720000 then
				req = 910000000
			end
			if hp > 4720000 and hp <= 4730000 then
				req = 912000000
			end
			if hp > 4730000 and hp <= 4740000 then
				req = 914000000
			end
			if hp > 4740000 and hp <= 4750000 then
				req = 916000000
			end
			if hp > 4750000 and hp <= 4760000 then
				req = 918000000
			end
			if hp > 4760000 and hp <= 4770000 then
				req = 920000000
			end
			if hp > 4770000 and hp <= 4780000 then
				req = 922000000
			end
			if hp > 4780000 and hp <= 4790000 then
				req = 924000000
			end
			if hp > 4790000 and hp <= 4800000 then
				req = 926000000
			end
			if hp > 4800000 and hp <= 4810000 then
				req = 928000000
			end
			if hp > 4810000 and hp <= 4820000 then
				req = 930000000
			end
			if hp > 4820000 and hp <= 4830000 then
				req = 932000000
			end
			if hp > 4830000 and hp <= 4840000 then
				req = 934000000
			end
			if hp > 4840000 and hp <= 4850000 then
				req = 936000000
			end
			if hp > 4850000 and hp <= 4860000 then
				req = 938000000
			end
			if hp > 4860000 and hp <= 4870000 then
				req = 940000000
			end
			if hp > 4870000 and hp <= 4880000 then
				req = 942000000
			end
			if hp > 4880000 and hp <= 4890000 then
				req = 944000000
			end
			if hp > 4890000 and hp <= 4900000 then
				req = 946000000
			end
			if hp > 4900000 and hp <= 4910000 then
				req = 948000000
			end
			if hp > 4910000 and hp <= 4920000 then
				req = 950000000
			end
			if hp > 4920000 and hp <= 4930000 then
				req = 952000000
			end
			if hp > 4930000 and hp <= 4940000 then
				req = 954000000
			end
			if hp > 4940000 and hp <= 4950000 then
				req = 956000000
			end
			if hp > 4950000 and hp <= 4960000 then
				req = 958000000
			end
			if hp > 4960000 and hp <= 4970000 then
				req = 960000000
			end
			if hp > 4970000 and hp <= 4980000 then
				req = 962000000
			end
			if hp > 4980000 and hp <= 4990000 then
				req = 964000000
			end
			if hp > 4990000 and hp <= 5000000 then
				req = 966000000
			end
			if hp > 5000000 and hp <= 5010000 then
				req = 968000000
			end
			if hp > 5010000 and hp <= 5020000 then
				req = 970000000
			end
			if hp > 5020000 and hp <= 5030000 then
				req = 972000000
			end
			if hp > 5030000 and hp <= 5040000 then
				req = 974000000
			end
			if hp > 5040000 and hp <= 5050000 then
				req = 976000000
			end
			if hp > 5050000 and hp <= 5060000 then
				req = 978000000
			end
			if hp > 5060000 and hp <= 5070000 then
				req = 980000000
			end
			if hp > 5070000 and hp <= 5080000 then
				req = 982000000
			end
			if hp > 5080000 and hp <= 5090000 then
				req = 984000000
			end
			if hp > 5090000 and hp <= 5100000 then
				req = 986000000
			end
			if hp > 5100000 and hp <= 5110000 then
				req = 988000000
			end
			if hp > 5110000 and hp <= 5120000 then
				req = 990000000
			end
			if hp > 5120000 and hp <= 5130000 then
				req = 992000000
			end
			if hp > 5130000 and hp <= 5140000 then
				req = 994000000
			end
			if hp > 5140000 and hp <= 5150000 then
				req = 996000000
			end
			if hp > 5150000 and hp <= 5160000 then
				req = 998000000
			end
			if hp > 5160000 and hp <= 5170000 then
				req = 1000000000
			end
			if hp > 5170000 and hp <= 5180000 then
				req = 1002000000
			end
			if hp > 5180000 and hp <= 5190000 then
				req = 1004000000
			end
			if hp > 5190000 and hp <= 5200000 then
				req = 1006000000
			end
			if hp > 5200000 and hp <= 5210000 then
				req = 1008000000
			end
			if hp > 5210000 and hp <= 5220000 then
				req = 1010000000
			end
			if hp > 5220000 and hp <= 5230000 then
				req = 1012000000
			end
			if hp > 5230000 and hp <= 5240000 then
				req = 1014000000
			end
			if hp > 5240000 and hp <= 5250000 then
				req = 1016000000
			end
			if hp > 5250000 and hp <= 5260000 then
				req = 1018000000
			end
			if hp > 5260000 and hp <= 5270000 then
				req = 1020000000
			end
			if hp > 5270000 and hp <= 5280000 then
				req = 1022000000
			end
			if hp > 5280000 and hp <= 5290000 then
				req = 1024000000
			end
			if hp > 5290000 and hp <= 5300000 then
				req = 1026000000
			end
			if hp > 5300000 and hp <= 5310000 then
				req = 1028000000
			end
			if hp > 5310000 and hp <= 5320000 then
				req = 1030000000
			end
			if hp > 5320000 and hp <= 5330000 then
				req = 1032000000
			end
			if hp > 5330000 and hp <= 5340000 then
				req = 1034000000
			end
			if hp > 5340000 and hp <= 5350000 then
				req = 1036000000
			end
			if hp > 5350000 and hp <= 5360000 then
				req = 1038000000
			end
			if hp > 5360000 and hp <= 5370000 then
				req = 1040000000
			end
			if hp > 5370000 and hp <= 5380000 then
				req = 1042000000
			end
			if hp > 5380000 and hp <= 5390000 then
				req = 1044000000
			end
			if hp > 5390000 and hp <= 5400000 then
				req = 1046000000
			end
			if hp > 5400000 and hp <= 5410000 then
				req = 1048000000
			end
			if hp > 5410000 and hp <= 5420000 then
				req = 1050000000
			end
			if hp > 5420000 and hp <= 5430000 then
				req = 1052000000
			end
			if hp > 5430000 and hp <= 5440000 then
				req = 1054000000
			end
			if hp > 5440000 and hp <= 5450000 then
				req = 1056000000
			end
			if hp > 5450000 and hp <= 5460000 then
				req = 1058000000
			end
			if hp > 5460000 and hp <= 5470000 then
				req = 1060000000
			end
			if hp > 5470000 and hp <= 5480000 then
				req = 1062000000
			end
			if hp > 5480000 and hp <= 5490000 then
				req = 1064000000
			end
			if hp > 5490000 and hp <= 5500000 then
				req = 1066000000
			end
			if hp > 5500000 and hp <= 5510000 then
				req = 1068000000
			end
			if hp > 5510000 and hp <= 5520000 then
				req = 1070000000
			end
			if hp > 5520000 and hp <= 5530000 then
				req = 1072000000
			end
			if hp > 5530000 and hp <= 5540000 then
				req = 1074000000
			end
			if hp > 5540000 and hp <= 5550000 then
				req = 1076000000
			end
			if hp > 5550000 and hp <= 5560000 then
				req = 1078000000
			end
			if hp > 5560000 and hp <= 5570000 then
				req = 1080000000
			end
			if hp > 5570000 and hp <= 5580000 then
				req = 1082000000
			end
			if hp > 5580000 and hp <= 5590000 then
				req = 1084000000
			end
			if hp > 5590000 and hp <= 5600000 then
				req = 1086000000
			end
			if hp > 5600000 and hp <= 5610000 then
				req = 1088000000
			end
			if hp > 5610000 and hp <= 5620000 then
				req = 1090000000
			end
			if hp > 5620000 and hp <= 5630000 then
				req = 1092000000
			end
			if hp > 5630000 and hp <= 5640000 then
				req = 1094000000
			end
			if hp > 5640000 and hp <= 5650000 then
				req = 1096000000
			end
			if hp > 5650000 and hp <= 5660000 then
				req = 1098000000
			end
			if hp > 5660000 and hp <= 5670000 then
				req = 1100000000
			end
			if hp > 5670000 and hp <= 5680000 then
				req = 1102000000
			end
			if hp > 5680000 and hp <= 5690000 then
				req = 1104000000
			end
			if hp > 5690000 and hp <= 5700000 then
				req = 1106000000
			end
			if hp > 5700000 and hp <= 5710000 then
				req = 1108000000
			end
			if hp > 5710000 and hp <= 5720000 then
				req = 1110000000
			end
			if hp > 5720000 and hp <= 5730000 then
				req = 1112000000
			end
			if hp > 5730000 and hp <= 5740000 then
				req = 1114000000
			end
			if hp > 5740000 and hp <= 5750000 then
				req = 1116000000
			end
			if hp > 5750000 and hp <= 5760000 then
				req = 1118000000
			end
			if hp > 5760000 and hp <= 5770000 then
				req = 1120000000
			end
			if hp > 5770000 and hp <= 5780000 then
				req = 1122000000
			end
			if hp > 5780000 and hp <= 5790000 then
				req = 1124000000
			end
			if hp > 5790000 and hp <= 5800000 then
				req = 1126000000
			end
			if hp > 5800000 and hp <= 5810000 then
				req = 1128000000
			end
			if hp > 5810000 and hp <= 5820000 then
				req = 1130000000
			end
			if hp > 5820000 and hp <= 5830000 then
				req = 1132000000
			end
			if hp > 5830000 and hp <= 5840000 then
				req = 1134000000
			end
			if hp > 5840000 and hp <= 5850000 then
				req = 1136000000
			end
			if hp > 5850000 and hp <= 5860000 then
				req = 1138000000
			end
			if hp > 5860000 and hp <= 5870000 then
				req = 1140000000
			end
			if hp > 5870000 and hp <= 5880000 then
				req = 1142000000
			end
			if hp > 5880000 and hp <= 5890000 then
				req = 1144000000
			end
			if hp > 5890000 and hp <= 5900000 then
				req = 1146000000
			end
			if hp > 5900000 and hp <= 5910000 then
				req = 1148000000
			end
			if hp > 5910000 and hp <= 5920000 then
				req = 1150000000
			end
			if hp > 5920000 and hp <= 5930000 then
				req = 1152000000
			end
			if hp > 5930000 and hp <= 5940000 then
				req = 1154000000
			end
			if hp > 5940000 and hp <= 5950000 then
				req = 1156000000
			end
			if hp > 5950000 and hp <= 5960000 then
				req = 1158000000
			end
			if hp > 5960000 and hp <= 5970000 then
				req = 1160000000
			end
			if hp > 5970000 and hp <= 5980000 then
				req = 1162000000
			end
			if hp > 5980000 and hp <= 5990000 then
				req = 1164000000
			end
			if hp > 5990000 and hp <= 6000000 then
				req = 1166000000
			end
			if hp > 6000000 and hp <= 6010000 then
				req = 1168000000
			end
			if hp > 6010000 and hp <= 6020000 then
				req = 1170000000
			end
			if hp > 6020000 and hp <= 6030000 then
				req = 1172000000
			end
			if hp > 6030000 and hp <= 6040000 then
				req = 1174000000
			end
			if hp > 6040000 and hp <= 6050000 then
				req = 1176000000
			end
			if hp > 6050000 and hp <= 6060000 then
				req = 1178000000
			end
			if hp > 6060000 and hp <= 6070000 then
				req = 1180000000
			end
			if hp > 6070000 and hp <= 6080000 then
				req = 1182000000
			end
			if hp > 6080000 and hp <= 6090000 then
				req = 1184000000
			end
			if hp > 6090000 and hp <= 6100000 then
				req = 1186000000
			end
			if hp > 6100000 and hp <= 6110000 then
				req = 1188000000
			end
			if hp > 6110000 and hp <= 6120000 then
				req = 1190000000
			end
			if hp > 6120000 and hp <= 6130000 then
				req = 1192000000
			end
			if hp > 6130000 and hp <= 6140000 then
				req = 1194000000
			end
			if hp > 6140000 and hp <= 6150000 then
				req = 1196000000
			end
			if hp > 6150000 and hp <= 6160000 then
				req = 1198000000
			end
			if hp > 6160000 and hp <= 6170000 then
				req = 1200000000
			end
			if hp > 6170000 and hp <= 6180000 then
				req = 1202000000
			end
			if hp > 6180000 and hp <= 6190000 then
				req = 1204000000
			end
			if hp > 6190000 and hp <= 6200000 then
				req = 1206000000
			end
			if hp > 6200000 and hp <= 6210000 then
				req = 1208000000
			end
			if hp > 6210000 and hp <= 6220000 then
				req = 1210000000
			end
			if hp > 6220000 and hp <= 6230000 then
				req = 1212000000
			end
			if hp > 6230000 and hp <= 6240000 then
				req = 1214000000
			end
			if hp > 6240000 and hp <= 6250000 then
				req = 1216000000
			end
			if hp > 6250000 and hp <= 6260000 then
				req = 1218000000
			end
			if hp > 6260000 and hp <= 6270000 then
				req = 1220000000
			end
			if hp > 6270000 and hp <= 6280000 then
				req = 1222000000
			end
			if hp > 6280000 and hp <= 6290000 then
				req = 1224000000
			end
			if hp > 6290000 and hp <= 6300000 then
				req = 1226000000
			end
			if hp > 6300000 and hp <= 6310000 then
				req = 1228000000
			end
			if hp > 6310000 and hp <= 6320000 then
				req = 1230000000
			end
			if hp > 6320000 and hp <= 6330000 then
				req = 1232000000
			end
			if hp > 6330000 and hp <= 6340000 then
				req = 1234000000
			end
			if hp > 6340000 and hp <= 6350000 then
				req = 1236000000
			end
			if hp > 6350000 and hp <= 6360000 then
				req = 1238000000
			end
			if hp > 6360000 and hp <= 6370000 then
				req = 1240000000
			end
			if hp > 6370000 and hp <= 6380000 then
				req = 1242000000
			end
			if hp > 6380000 and hp <= 6390000 then
				req = 1244000000
			end
			if hp > 6390000 and hp <= 6400000 then
				req = 1246000000
			end
			if hp > 6400000 and hp <= 6410000 then
				req = 1248000000
			end
			if hp > 6410000 and hp <= 6420000 then
				req = 1250000000
			end
			if hp > 6420000 and hp <= 6430000 then
				req = 1252000000
			end
			if hp > 6430000 and hp <= 6440000 then
				req = 1254000000
			end
			if hp > 6440000 and hp <= 6450000 then
				req = 1256000000
			end
			if hp > 6450000 and hp <= 6460000 then
				req = 1258000000
			end
			if hp > 6460000 and hp <= 6470000 then
				req = 1260000000
			end
			if hp > 6470000 and hp <= 6480000 then
				req = 1262000000
			end
			if hp > 6480000 and hp <= 6490000 then
				req = 1264000000
			end
			if hp > 6490000 and hp <= 6500000 then
				req = 1266000000
			end
			if hp > 6500000 and hp <= 6510000 then
				req = 1268000000
			end
			if hp > 6510000 and hp <= 6520000 then
				req = 1270000000
			end
			if hp > 6520000 and hp <= 6530000 then
				req = 1272000000
			end
			if hp > 6530000 and hp <= 6540000 then
				req = 1274000000
			end
			if hp > 6540000 and hp <= 6550000 then
				req = 1276000000
			end
			if hp > 6550000 and hp <= 6560000 then
				req = 1278000000
			end
			if hp > 6560000 and hp <= 6570000 then
				req = 1280000000
			end
			if hp > 6570000 and hp <= 6580000 then
				req = 1282000000
			end
			if hp > 6580000 and hp <= 6590000 then
				req = 1284000000
			end
			if hp > 6590000 and hp <= 6600000 then
				req = 1286000000
			end
			if hp > 6600000 and hp <= 6610000 then
				req = 1288000000
			end
			if hp > 6610000 and hp <= 6620000 then
				req = 1290000000
			end
			if hp > 6620000 and hp <= 6630000 then
				req = 1292000000
			end
			if hp > 6630000 and hp <= 6640000 then
				req = 1294000000
			end
			if hp > 6640000 and hp <= 6650000 then
				req = 1296000000
			end
			if hp > 6650000 and hp <= 6660000 then
				req = 1298000000
			end
			if hp > 6660000 and hp <= 6670000 then
				req = 1300000000
			end
			if hp > 6670000 and hp <= 6680000 then
				req = 1302000000
			end
			if hp > 6680000 and hp <= 6690000 then
				req = 1304000000
			end
			if hp > 6690000 and hp <= 6700000 then
				req = 1306000000
			end
			if hp > 6700000 and hp <= 6710000 then
				req = 1308000000
			end
			if hp > 6710000 and hp <= 6720000 then
				req = 1310000000
			end
			if hp > 6720000 and hp <= 6730000 then
				req = 1312000000
			end
			if hp > 6730000 and hp <= 6740000 then
				req = 1314000000
			end
			if hp > 6740000 and hp <= 6750000 then
				req = 1316000000
			end
			if hp > 6750000 and hp <= 6760000 then
				req = 1318000000
			end
			if hp > 6760000 and hp <= 6770000 then
				req = 1320000000
			end
			if hp > 6770000 and hp <= 6780000 then
				req = 1322000000
			end
			if hp > 6780000 and hp <= 6790000 then
				req = 1324000000
			end
			if hp > 6790000 and hp <= 6800000 then
				req = 1326000000
			end
			if hp > 6800000 and hp <= 6810000 then
				req = 1328000000
			end
			if hp > 6810000 and hp <= 6820000 then
				req = 1330000000
			end
			if hp > 6820000 and hp <= 6830000 then
				req = 1332000000
			end
			if hp > 6830000 and hp <= 6840000 then
				req = 1334000000
			end
			if hp > 6840000 and hp <= 6850000 then
				req = 1336000000
			end
			if hp > 6850000 and hp <= 6860000 then
				req = 1338000000
			end
			if hp > 6860000 and hp <= 6870000 then
				req = 1340000000
			end
			if hp > 6870000 and hp <= 6880000 then
				req = 1342000000
			end
			if hp > 6880000 and hp <= 6890000 then
				req = 1344000000
			end
			if hp > 6890000 and hp <= 6900000 then
				req = 1346000000
			end
			if hp > 6900000 and hp <= 6910000 then
				req = 1348000000
			end
			if hp > 6910000 and hp <= 6920000 then
				req = 1350000000
			end
			if hp > 6920000 and hp <= 6930000 then
				req = 1352000000
			end
			if hp > 6930000 and hp <= 6940000 then
				req = 1354000000
			end
			if hp > 6940000 and hp <= 6950000 then
				req = 1356000000
			end
			if hp > 6950000 and hp <= 6960000 then
				req = 1358000000
			end
			if hp > 6960000 and hp <= 6970000 then
				req = 1360000000
			end
			if hp > 6970000 and hp <= 6980000 then
				req = 1362000000
			end
			if hp > 6980000 and hp <= 6990000 then
				req = 1364000000
			end
			if hp > 6990000 and hp <= 7000000 then
				req = 1366000000
			end
			if hp > 7000000 and hp <= 7010000 then
				req = 1368000000
			end
			if hp > 7010000 and hp <= 7020000 then
				req = 1370000000
			end
			if hp > 7020000 and hp <= 7030000 then
				req = 1372000000
			end
			if hp > 7030000 and hp <= 7040000 then
				req = 1374000000
			end
			if hp > 7040000 and hp <= 7050000 then
				req = 1376000000
			end
			if hp > 7050000 and hp <= 7060000 then
				req = 1378000000
			end
			if hp > 7060000 and hp <= 7070000 then
				req = 1380000000
			end
			if hp > 7070000 and hp <= 7080000 then
				req = 1382000000
			end
			if hp > 7080000 and hp <= 7090000 then
				req = 1384000000
			end
			if hp > 7090000 and hp <= 7100000 then
				req = 1386000000
			end
			if hp > 7100000 and hp <= 7110000 then
				req = 1388000000
			end
			if hp > 7110000 and hp <= 7120000 then
				req = 1390000000
			end
			if hp > 7120000 and hp <= 7130000 then
				req = 1392000000
			end
			if hp > 7130000 and hp <= 7140000 then
				req = 1394000000
			end
			if hp > 7140000 and hp <= 7150000 then
				req = 1396000000
			end
			if hp > 7150000 and hp <= 7160000 then
				req = 1398000000
			end
			if hp > 7160000 and hp <= 7170000 then
				req = 1400000000
			end
			if hp > 7170000 and hp <= 7180000 then
				req = 1402000000
			end
			if hp > 7180000 and hp <= 7190000 then
				req = 1404000000
			end
			if hp > 7190000 and hp <= 7200000 then
				req = 1406000000
			end
			if hp > 7200000 and hp <= 7210000 then
				req = 1408000000
			end
			if hp > 7210000 and hp <= 7220000 then
				req = 1410000000
			end
			if hp > 7220000 and hp <= 7230000 then
				req = 1412000000
			end
			if hp > 7230000 and hp <= 7240000 then
				req = 1414000000
			end
			if hp > 7240000 and hp <= 7250000 then
				req = 1416000000
			end
			if hp > 7250000 and hp <= 7260000 then
				req = 1418000000
			end
			if hp > 7260000 and hp <= 7270000 then
				req = 1420000000
			end
			if hp > 7270000 and hp <= 7280000 then
				req = 1422000000
			end
			if hp > 7280000 and hp <= 7290000 then
				req = 1424000000
			end
			if hp > 7290000 and hp <= 7300000 then
				req = 1426000000
			end
			if hp > 7300000 and hp <= 7310000 then
				req = 1428000000
			end
			if hp > 7310000 and hp <= 7320000 then
				req = 1430000000
			end
			if hp > 7320000 and hp <= 7330000 then
				req = 1432000000
			end
			if hp > 7330000 and hp <= 7340000 then
				req = 1434000000
			end
			if hp > 7340000 and hp <= 7350000 then
				req = 1436000000
			end
			if hp > 7350000 and hp <= 7360000 then
				req = 1438000000
			end
			if hp > 7360000 and hp <= 7370000 then
				req = 1440000000
			end
			if hp > 7370000 and hp <= 7380000 then
				req = 1442000000
			end
			if hp > 7380000 and hp <= 7390000 then
				req = 1444000000
			end
			if hp > 7390000 and hp <= 7400000 then
				req = 1446000000
			end
			if hp > 7400000 and hp <= 7410000 then
				req = 1448000000
			end
			if hp > 7410000 and hp <= 7420000 then
				req = 1450000000
			end
			if hp > 7420000 and hp <= 7430000 then
				req = 1452000000
			end
			if hp > 7430000 and hp <= 7440000 then
				req = 1454000000
			end
			if hp > 7440000 and hp <= 7450000 then
				req = 1456000000
			end
			if hp > 7450000 and hp <= 7460000 then
				req = 1458000000
			end
			if hp > 7460000 and hp <= 7470000 then
				req = 1460000000
			end
			if hp > 7470000 and hp <= 7480000 then
				req = 1462000000
			end
			if hp > 7480000 and hp <= 7490000 then
				req = 1464000000
			end
			if hp > 7490000 and hp <= 7500000 then
				req = 1466000000
			end
			if hp > 7500000 and hp <= 7510000 then
				req = 1468000000
			end
			if hp > 7510000 and hp <= 7520000 then
				req = 1470000000
			end
			if hp > 7520000 and hp <= 7530000 then
				req = 1472000000
			end
			if hp > 7530000 and hp <= 7540000 then
				req = 1474000000
			end
			if hp > 7540000 and hp <= 7550000 then
				req = 1476000000
			end
			if hp > 7550000 and hp <= 7560000 then
				req = 1478000000
			end
			if hp > 7560000 and hp <= 7570000 then
				req = 1480000000
			end
			if hp > 7570000 and hp <= 7580000 then
				req = 1482000000
			end
			if hp > 7580000 and hp <= 7590000 then
				req = 1484000000
			end
			if hp > 7590000 and hp <= 7600000 then
				req = 1486000000
			end
			if hp > 7600000 and hp <= 7610000 then
				req = 1488000000
			end
			if hp > 7610000 and hp <= 7620000 then
				req = 1490000000
			end
			if hp > 7620000 and hp <= 7630000 then
				req = 1492000000
			end
			if hp > 7630000 and hp <= 7640000 then
				req = 1494000000
			end
			if hp > 7640000 and hp <= 7650000 then
				req = 1496000000
			end
			if hp > 7650000 and hp <= 7660000 then
				req = 1498000000
			end
			if hp > 7660000 and hp <= 7670000 then
				req = 1500000000
			end
			if hp > 7670000 and hp <= 7680000 then
				req = 1502000000
			end
			if hp > 7680000 and hp <= 7690000 then
				req = 1504000000
			end
			if hp > 7690000 and hp <= 7700000 then
				req = 1506000000
			end
			if hp > 7700000 and hp <= 7710000 then
				req = 1508000000
			end
			if hp > 7710000 and hp <= 7720000 then
				req = 1510000000
			end
			if hp > 7720000 and hp <= 7730000 then
				req = 1512000000
			end
			if hp > 7730000 and hp <= 7740000 then
				req = 1514000000
			end
			if hp > 7740000 and hp <= 7750000 then
				req = 1516000000
			end
			if hp > 7750000 and hp <= 7760000 then
				req = 1518000000
			end
			if hp > 7760000 and hp <= 7770000 then
				req = 1520000000
			end
			if hp > 7770000 and hp <= 7780000 then
				req = 1522000000
			end
			if hp > 7780000 and hp <= 7790000 then
				req = 1524000000
			end
			if hp > 7790000 and hp <= 7800000 then
				req = 1526000000
			end
			if hp > 7800000 and hp <= 7810000 then
				req = 1528000000
			end
			if hp > 7810000 and hp <= 7820000 then
				req = 1530000000
			end
			if hp > 7820000 and hp <= 7830000 then
				req = 1532000000
			end
			if hp > 7830000 and hp <= 7840000 then
				req = 1534000000
			end
			if hp > 7840000 and hp <= 7850000 then
				req = 1536000000
			end
			if hp > 7850000 and hp <= 7860000 then
				req = 1538000000
			end
			if hp > 7860000 and hp <= 7870000 then
				req = 1540000000
			end
			if hp > 7870000 and hp <= 7880000 then
				req = 1542000000
			end
			if hp > 7880000 and hp <= 7890000 then
				req = 1544000000
			end
			if hp > 7890000 and hp <= 7900000 then
				req = 1546000000
			end
			if hp > 7900000 and hp <= 7910000 then
				req = 1548000000
			end
			if hp > 7910000 and hp <= 7920000 then
				req = 1550000000
			end
			if hp > 7920000 and hp <= 7930000 then
				req = 1552000000
			end
			if hp > 7930000 and hp <= 7940000 then
				req = 1554000000
			end
			if hp > 7940000 and hp <= 7950000 then
				req = 1556000000
			end
			if hp > 7950000 and hp <= 7960000 then
				req = 1558000000
			end
			if hp > 7960000 and hp <= 7970000 then
				req = 1560000000
			end
			if hp > 7970000 and hp <= 7980000 then
				req = 1562000000
			end
			if hp > 7980000 and hp <= 7990000 then
				req = 1564000000
			end
			if hp > 7990000 and hp <= 8000000 then
				req = 1566000000
			end
			if hp > 8000000 and hp <= 8010000 then
				req = 1568000000
			end
			if hp > 8010000 and hp <= 8020000 then
				req = 1570000000
			end
			if hp > 8020000 and hp <= 8030000 then
				req = 1572000000
			end
			if hp > 8030000 and hp <= 8040000 then
				req = 1574000000
			end
			if hp > 8040000 and hp <= 8050000 then
				req = 1576000000
			end
			if hp > 8050000 and hp <= 8060000 then
				req = 1578000000
			end
			if hp > 8060000 and hp <= 8070000 then
				req = 1580000000
			end
			if hp > 8070000 and hp <= 8080000 then
				req = 1582000000
			end
			if hp > 8080000 and hp <= 8090000 then
				req = 1584000000
			end
			if hp > 8090000 and hp <= 8100000 then
				req = 1586000000
			end
			if hp > 8100000 and hp <= 8110000 then
				req = 1588000000
			end
			if hp > 8110000 and hp <= 8120000 then
				req = 1590000000
			end
			if hp > 8120000 and hp <= 8130000 then
				req = 1592000000
			end
			if hp > 8130000 and hp <= 8140000 then
				req = 1594000000
			end
			if hp > 8140000 and hp <= 8150000 then
				req = 1596000000
			end
			if hp > 8150000 and hp <= 8160000 then
				req = 1598000000
			end
			if hp > 8160000 and hp <= 8170000 then
				req = 1600000000
			end
			if hp > 8170000 and hp <= 8180000 then
				req = 1602000000
			end
			if hp > 8180000 and hp <= 8190000 then
				req = 1604000000
			end
			if hp > 8190000 and hp <= 8200000 then
				req = 1606000000
			end
			if hp > 8200000 and hp <= 8210000 then
				req = 1608000000
			end
			if hp > 8210000 and hp <= 8220000 then
				req = 1610000000
			end
			if hp > 8220000 and hp <= 8230000 then
				req = 1612000000
			end
			if hp > 8230000 and hp <= 8240000 then
				req = 1614000000
			end
			if hp > 8240000 and hp <= 8250000 then
				req = 1616000000
			end
			if hp > 8250000 and hp <= 8260000 then
				req = 1618000000
			end
			if hp > 8260000 and hp <= 8270000 then
				req = 1620000000
			end
			if hp > 8270000 and hp <= 8280000 then
				req = 1622000000
			end
			if hp > 8280000 and hp <= 8290000 then
				req = 1624000000
			end
			if hp > 8290000 and hp <= 8300000 then
				req = 1626000000
			end
			if hp > 8300000 and hp <= 8310000 then
				req = 1628000000
			end
			if hp > 8310000 and hp <= 8320000 then
				req = 1630000000
			end
			if hp > 8320000 and hp <= 8330000 then
				req = 1632000000
			end
			if hp > 8330000 and hp <= 8340000 then
				req = 1634000000
			end
			if hp > 8340000 and hp <= 8350000 then
				req = 1636000000
			end
			if hp > 8350000 and hp <= 8360000 then
				req = 1638000000
			end
			if hp > 8360000 and hp <= 8370000 then
				req = 1640000000
			end
			if hp > 8370000 and hp <= 8380000 then
				req = 1642000000
			end
			if hp > 8380000 and hp <= 8390000 then
				req = 1644000000
			end
			if hp > 8390000 and hp <= 8400000 then
				req = 1646000000
			end
			if hp > 8400000 and hp <= 8410000 then
				req = 1648000000
			end
			if hp > 8410000 and hp <= 8420000 then
				req = 1650000000
			end
			if hp > 8420000 and hp <= 8430000 then
				req = 1652000000
			end
			if hp > 8430000 and hp <= 8440000 then
				req = 1654000000
			end
			if hp > 8440000 and hp <= 8450000 then
				req = 1656000000
			end
			if hp > 8450000 and hp <= 8460000 then
				req = 1658000000
			end
			if hp > 8460000 and hp <= 8470000 then
				req = 1660000000
			end
			if hp > 8470000 and hp <= 8480000 then
				req = 1662000000
			end
			if hp > 8480000 and hp <= 8490000 then
				req = 1664000000
			end
			if hp > 8490000 and hp <= 8500000 then
				req = 1666000000
			end
			if hp > 8500000 and hp <= 8510000 then
				req = 1668000000
			end
			if hp > 8510000 and hp <= 8520000 then
				req = 1670000000
			end
			if hp > 8520000 and hp <= 8530000 then
				req = 1672000000
			end
			if hp > 8530000 and hp <= 8540000 then
				req = 1674000000
			end
			if hp > 8540000 and hp <= 8550000 then
				req = 1676000000
			end
			if hp > 8550000 and hp <= 8560000 then
				req = 1678000000
			end
			if hp > 8560000 and hp <= 8570000 then
				req = 1680000000
			end
			if hp > 8570000 and hp <= 8580000 then
				req = 1682000000
			end
			if hp > 8580000 and hp <= 8590000 then
				req = 1684000000
			end
			if hp > 8590000 and hp <= 8600000 then
				req = 1686000000
			end
			if hp > 8600000 and hp <= 8610000 then
				req = 1688000000
			end
			if hp > 8610000 and hp <= 8620000 then
				req = 1690000000
			end
			if hp > 8620000 and hp <= 8630000 then
				req = 1692000000
			end
			if hp > 8630000 and hp <= 8640000 then
				req = 1694000000
			end
			if hp > 8640000 and hp <= 8650000 then
				req = 1696000000
			end
			if hp > 8650000 and hp <= 8660000 then
				req = 1698000000
			end
			if hp > 8660000 and hp <= 8670000 then
				req = 1700000000
			end
			if hp > 8670000 and hp <= 8680000 then
				req = 1702000000
			end
			if hp > 8680000 and hp <= 8690000 then
				req = 1704000000
			end
			if hp > 8690000 and hp <= 8700000 then
				req = 1706000000
			end
			if hp > 8700000 and hp <= 8710000 then
				req = 1708000000
			end
			if hp > 8710000 and hp <= 8720000 then
				req = 1710000000
			end
			if hp > 8720000 and hp <= 8730000 then
				req = 1712000000
			end
			if hp > 8730000 and hp <= 8740000 then
				req = 1714000000
			end
			if hp > 8740000 and hp <= 8750000 then
				req = 1716000000
			end
			if hp > 8750000 and hp <= 8760000 then
				req = 1718000000
			end
			if hp > 8760000 and hp <= 8770000 then
				req = 1720000000
			end
			if hp > 8770000 and hp <= 8780000 then
				req = 1722000000
			end
			if hp > 8780000 and hp <= 8790000 then
				req = 1724000000
			end
			if hp > 8790000 and hp <= 8800000 then
				req = 1726000000
			end
			if hp > 8800000 and hp <= 8810000 then
				req = 1728000000
			end
			if hp > 8810000 and hp <= 8820000 then
				req = 1730000000
			end
			if hp > 8820000 and hp <= 8830000 then
				req = 1732000000
			end
			if hp > 8830000 and hp <= 8840000 then
				req = 1734000000
			end
			if hp > 8840000 and hp <= 8850000 then
				req = 1736000000
			end
			if hp > 8850000 and hp <= 8860000 then
				req = 1738000000
			end
			if hp > 8860000 and hp <= 8870000 then
				req = 1740000000
			end
			if hp > 8870000 and hp <= 8880000 then
				req = 1742000000
			end
			if hp > 8880000 and hp <= 8890000 then
				req = 1744000000
			end
			if hp > 8890000 and hp <= 8900000 then
				req = 1746000000
			end
			if hp > 8900000 and hp <= 8910000 then
				req = 1748000000
			end
			if hp > 8910000 and hp <= 8920000 then
				req = 1750000000
			end
			if hp > 8920000 and hp <= 8930000 then
				req = 1752000000
			end
			if hp > 8930000 and hp <= 8940000 then
				req = 1754000000
			end
			if hp > 8940000 and hp <= 8950000 then
				req = 1756000000
			end
			if hp > 8950000 and hp <= 8960000 then
				req = 1758000000
			end
			if hp > 8960000 and hp <= 8970000 then
				req = 1760000000
			end
			if hp > 8970000 and hp <= 8980000 then
				req = 1762000000
			end
			if hp > 8980000 and hp <= 8990000 then
				req = 1764000000
			end
			if hp > 8990000 and hp <= 9000000 then
				req = 1766000000
			end
			if hp > 9000000 and hp <= 9010000 then
				req = 1768000000
			end
			if hp > 9010000 and hp <= 9020000 then
				req = 1770000000
			end
			if hp > 9020000 and hp <= 9030000 then
				req = 1772000000
			end
			if hp > 9030000 and hp <= 9040000 then
				req = 1774000000
			end
			if hp > 9040000 and hp <= 9050000 then
				req = 1776000000
			end
			if hp > 9050000 and hp <= 9060000 then
				req = 1778000000
			end
			if hp > 9060000 and hp <= 9070000 then
				req = 1780000000
			end
			if hp > 9070000 and hp <= 9080000 then
				req = 1782000000
			end
			if hp > 9080000 and hp <= 9090000 then
				req = 1784000000
			end
			if hp > 9090000 and hp <= 9100000 then
				req = 1786000000
			end
			if hp > 9100000 and hp <= 9110000 then
				req = 1788000000
			end
			if hp > 9110000 and hp <= 9120000 then
				req = 1790000000
			end
			if hp > 9120000 and hp <= 9130000 then
				req = 1792000000
			end
			if hp > 9130000 and hp <= 9140000 then
				req = 1794000000
			end
			if hp > 9140000 and hp <= 9150000 then
				req = 1796000000
			end
			if hp > 9150000 and hp <= 9160000 then
				req = 1798000000
			end
			if hp > 9160000 and hp <= 9170000 then
				req = 1800000000
			end
			if hp > 9170000 and hp <= 9180000 then
				req = 1802000000
			end
			if hp > 9180000 and hp <= 9190000 then
				req = 1804000000
			end
			if hp > 9190000 and hp <= 9200000 then
				req = 1806000000
			end
			if hp > 9200000 and hp <= 9210000 then
				req = 1808000000
			end
			if hp > 9210000 and hp <= 9220000 then
				req = 1810000000
			end
			if hp > 9220000 and hp <= 9230000 then
				req = 1812000000
			end
			if hp > 9230000 and hp <= 9240000 then
				req = 1814000000
			end
			if hp > 9240000 and hp <= 9250000 then
				req = 1816000000
			end
			if hp > 9250000 and hp <= 9260000 then
				req = 1818000000
			end
			if hp > 9260000 and hp <= 9270000 then
				req = 1820000000
			end
			if hp > 9270000 and hp <= 9280000 then
				req = 1822000000
			end
			if hp > 9280000 and hp <= 9290000 then
				req = 1824000000
			end
			if hp > 9290000 and hp <= 9300000 then
				req = 1826000000
			end
			if hp > 9300000 and hp <= 9310000 then
				req = 1828000000
			end
			if hp > 9310000 and hp <= 9320000 then
				req = 1830000000
			end
			if hp > 9320000 and hp <= 9330000 then
				req = 1832000000
			end
			if hp > 9330000 and hp <= 9340000 then
				req = 1834000000
			end
			if hp > 9340000 and hp <= 9350000 then
				req = 1836000000
			end
			if hp > 9350000 and hp <= 9360000 then
				req = 1838000000
			end
			if hp > 9360000 and hp <= 9370000 then
				req = 1840000000
			end
			if hp > 9370000 and hp <= 9380000 then
				req = 1842000000
			end
			if hp > 9380000 and hp <= 9390000 then
				req = 1844000000
			end
			if hp > 9390000 and hp <= 9400000 then
				req = 1846000000
			end
			if hp > 9400000 and hp <= 9410000 then
				req = 1848000000
			end
			if hp > 9410000 and hp <= 9420000 then
				req = 1850000000
			end
			if hp > 9420000 and hp <= 9430000 then
				req = 1852000000
			end
			if hp > 9430000 and hp <= 9440000 then
				req = 1854000000
			end
			if hp > 9440000 and hp <= 9450000 then
				req = 1856000000
			end
			if hp > 9450000 and hp <= 9460000 then
				req = 1858000000
			end
			if hp > 9460000 and hp <= 9470000 then
				req = 1860000000
			end
			if hp > 9470000 and hp <= 9480000 then
				req = 1862000000
			end
			if hp > 9480000 and hp <= 9490000 then
				req = 1864000000
			end
			if hp > 9490000 and hp <= 9500000 then
				req = 1866000000
			end
			if hp > 9500000 and hp <= 9510000 then
				req = 1868000000
			end
			if hp > 9510000 and hp <= 9520000 then
				req = 1870000000
			end
			if hp > 9520000 and hp <= 9530000 then
				req = 1872000000
			end
			if hp > 9530000 and hp <= 9540000 then
				req = 1874000000
			end
			if hp > 9540000 and hp <= 9550000 then
				req = 1876000000
			end
			if hp > 9550000 and hp <= 9560000 then
				req = 1878000000
			end
			if hp > 9560000 and hp <= 9570000 then
				req = 1880000000
			end
			if hp > 9570000 and hp <= 9580000 then
				req = 1882000000
			end
			if hp > 9580000 and hp <= 9590000 then
				req = 1884000000
			end
			if hp > 9590000 and hp <= 9600000 then
				req = 1886000000
			end
			if hp > 9600000 and hp <= 9610000 then
				req = 1888000000
			end
			if hp > 9610000 and hp <= 9620000 then
				req = 1890000000
			end
			if hp > 9620000 and hp <= 9630000 then
				req = 1892000000
			end
			if hp > 9630000 and hp <= 9640000 then
				req = 1894000000
			end
			if hp > 9640000 and hp <= 9650000 then
				req = 1896000000
			end
			if hp > 9650000 and hp <= 9660000 then
				req = 1898000000
			end
			if hp > 9660000 and hp <= 9670000 then
				req = 1900000000
			end
			if hp > 9670000 and hp <= 9680000 then
				req = 1902000000
			end
			if hp > 9680000 and hp <= 9690000 then
				req = 1904000000
			end
			if hp > 9690000 and hp <= 9700000 then
				req = 1906000000
			end
			if hp > 9700000 and hp <= 9710000 then
				req = 1908000000
			end
			if hp > 9710000 and hp <= 9720000 then
				req = 1910000000
			end
			if hp > 9720000 and hp <= 9730000 then
				req = 1912000000
			end
			if hp > 9730000 and hp <= 9740000 then
				req = 1914000000
			end
			if hp > 9740000 and hp <= 9750000 then
				req = 1916000000
			end
			if hp > 9750000 and hp <= 9760000 then
				req = 1918000000
			end
			if hp > 9760000 and hp <= 9770000 then
				req = 1920000000
			end
			if hp > 9770000 and hp <= 9780000 then
				req = 1922000000
			end
			if hp > 9780000 and hp <= 9790000 then
				req = 1924000000
			end
			if hp > 9790000 and hp <= 9800000 then
				req = 1926000000
			end
			if hp > 9800000 and hp <= 9810000 then
				req = 1928000000
			end
			if hp > 9810000 and hp <= 9820000 then
				req = 1930000000
			end
			if hp > 9820000 and hp <= 9830000 then
				req = 1932000000
			end
			if hp > 9830000 and hp <= 9840000 then
				req = 1934000000
			end
			if hp > 9840000 and hp <= 9850000 then
				req = 1936000000
			end
			if hp > 9850000 and hp <= 9860000 then
				req = 1938000000
			end
			if hp > 9860000 and hp <= 9870000 then
				req = 1940000000
			end
			if hp > 9870000 and hp <= 9880000 then
				req = 1942000000
			end
			if hp > 9880000 and hp <= 9890000 then
				req = 1944000000
			end
			if hp > 9890000 and hp <= 9900000 then
				req = 1946000000
			end
			if hp > 9900000 and hp <= 9910000 then
				req = 1948000000
			end
			if hp > 9910000 and hp <= 9920000 then
				req = 1950000000
			end
			if hp > 9920000 and hp <= 9930000 then
				req = 1952000000
			end
			if hp > 9930000 and hp <= 9940000 then
				req = 1954000000
			end
			if hp > 9940000 and hp <= 9950000 then
				req = 1956000000
			end
			if hp > 9950000 and hp <= 9960000 then
				req = 1958000000
			end
			if hp > 9960000 and hp <= 9970000 then
				req = 1960000000
			end
			if hp > 9970000 and hp <= 9980000 then
				req = 1962000000
			end
			if hp > 9980000 and hp <= 9990000 then
				req = 1964000000
			end
			if hp > 9990000 and hp <= 10000000 then
				req = 1966000000
			end
			if hp > 10000000 and hp <= 10010000 then
				req = 1968000000
			end
		end
		return req
	end,
	-- Shows the changes ----------------------------------------------------------------------------------------------------

	showExchange2 = function(player, type, times, req, add)
		local xp = req * times

		if type == "vita" then
			player:msg(12, "=================== Vita Training =======================", player.ID)
			player:msg(
				12,
				"Vita : " ..
					format_number(player.baseHealth) ..
						" + " .. format_number(add) .. " = " .. format_number(player.baseHealth + add) .. "",
				player.ID
			)
		elseif type == "mana" then
			player:msg(12, "=================== Mana Training =======================", player.ID)
			player:msg(
				12,
				"Mana : " ..
					format_number(player.baseMagic) ..
						" + " .. format_number(add) .. " = " .. format_number(player.baseMagic + add) .. "",
				player.ID
			)
		end
		player:msg(12, "Rate : " .. times .. " times x " .. format_number(req) .. " Exp", player.ID)
		player:msg(
			12,
			"Exp  : " ..
				format_number(player.exp) .. " - " .. format_number(xp) .. "  = " .. format_number(player.exp - xp) .. "",
			player.ID
		)
		player:msg(12, "=========================================================", player.ID)
	end,
	-- Mana Exchange Rate --------------------------------------------------------------------------------------------------------------------------------------------------

	getReqXPmagic2 = function(player, class) -- Exp amount required for 1 time magic exchange
		local mp = player.baseMagic
		local job = player.baseClass
		local req

		if job == 1 then -- Fighter
			if mp <= 20000 then
				req = 10000000
			end
			if mp > 20000 and mp <= 30000 then
				req = 12000000
			end
			if mp > 30000 and mp <= 40000 then
				req = 14000000
			end
			if mp > 40000 and mp <= 50000 then
				req = 16000000
			end
			if mp > 50000 and mp <= 60000 then
				req = 18000000
			end
			if mp > 60000 and mp <= 70000 then
				req = 20000000
			end
			if mp > 70000 and mp <= 80000 then
				req = 22000000
			end
			if mp > 80000 and mp <= 90000 then
				req = 24000000
			end
			if mp > 90000 and mp <= 100000 then
				req = 26000000
			end
			if mp > 100000 and mp <= 110000 then
				req = 28000000
			end
			if mp > 110000 and mp <= 120000 then
				req = 30000000
			end
			if mp > 120000 and mp <= 130000 then
				req = 32000000
			end
			if mp > 130000 and mp <= 140000 then
				req = 34000000
			end
			if mp > 140000 and mp <= 150000 then
				req = 36000000
			end
			if mp > 150000 and mp <= 160000 then
				req = 38000000
			end
			if mp > 160000 and mp <= 170000 then
				req = 40000000
			end
			if mp > 170000 and mp <= 180000 then
				req = 42000000
			end
			if mp > 180000 and mp <= 190000 then
				req = 44000000
			end
			if mp > 190000 and mp <= 200000 then
				req = 46000000
			end
			if mp > 200000 and mp <= 210000 then
				req = 48000000
			end
			if mp > 210000 and mp <= 220000 then
				req = 50000000
			end
			if mp > 220000 and mp <= 230000 then
				req = 52000000
			end
			if mp > 230000 and mp <= 240000 then
				req = 54000000
			end
			if mp > 240000 and mp <= 250000 then
				req = 56000000
			end
			if mp > 250000 and mp <= 260000 then
				req = 58000000
			end
			if mp > 260000 and mp <= 270000 then
				req = 60000000
			end
			if mp > 270000 and mp <= 280000 then
				req = 62000000
			end
			if mp > 280000 and mp <= 290000 then
				req = 64000000
			end
			if mp > 290000 and mp <= 300000 then
				req = 66000000
			end
			if mp > 300000 and mp <= 310000 then
				req = 68000000
			end
			if mp > 310000 and mp <= 320000 then
				req = 70000000
			end
			if mp > 320000 and mp <= 330000 then
				req = 72000000
			end
			if mp > 330000 and mp <= 340000 then
				req = 74000000
			end
			if mp > 340000 and mp <= 350000 then
				req = 76000000
			end
			if mp > 350000 and mp <= 360000 then
				req = 78000000
			end
			if mp > 360000 and mp <= 370000 then
				req = 80000000
			end
			if mp > 370000 and mp <= 380000 then
				req = 82000000
			end
			if mp > 380000 and mp <= 390000 then
				req = 84000000
			end
			if mp > 390000 and mp <= 400000 then
				req = 86000000
			end
			if mp > 400000 and mp <= 410000 then
				req = 88000000
			end
			if mp > 410000 and mp <= 420000 then
				req = 90000000
			end
			if mp > 420000 and mp <= 430000 then
				req = 92000000
			end
			if mp > 430000 and mp <= 440000 then
				req = 94000000
			end
			if mp > 440000 and mp <= 450000 then
				req = 96000000
			end
			if mp > 450000 and mp <= 460000 then
				req = 98000000
			end
			if mp > 460000 and mp <= 470000 then
				req = 100000000
			end
			if mp > 470000 and mp <= 480000 then
				req = 102000000
			end
			if mp > 480000 and mp <= 490000 then
				req = 104000000
			end
			if mp > 490000 and mp <= 500000 then
				req = 106000000
			end
			if mp > 500000 and mp <= 510000 then
				req = 108000000
			end
			if mp > 510000 and mp <= 520000 then
				req = 110000000
			end
			if mp > 520000 and mp <= 530000 then
				req = 112000000
			end
			if mp > 530000 and mp <= 540000 then
				req = 114000000
			end
			if mp > 540000 and mp <= 550000 then
				req = 116000000
			end
			if mp > 550000 and mp <= 560000 then
				req = 118000000
			end
			if mp > 560000 and mp <= 570000 then
				req = 120000000
			end
			if mp > 570000 and mp <= 580000 then
				req = 122000000
			end
			if mp > 580000 and mp <= 590000 then
				req = 124000000
			end
			if mp > 590000 and mp <= 600000 then
				req = 126000000
			end
			if mp > 600000 and mp <= 610000 then
				req = 128000000
			end
			if mp > 610000 and mp <= 620000 then
				req = 130000000
			end
			if mp > 620000 and mp <= 630000 then
				req = 132000000
			end
			if mp > 630000 and mp <= 640000 then
				req = 134000000
			end
			if mp > 640000 and mp <= 650000 then
				req = 136000000
			end
			if mp > 650000 and mp <= 660000 then
				req = 138000000
			end
			if mp > 660000 and mp <= 670000 then
				req = 140000000
			end
			if mp > 670000 and mp <= 680000 then
				req = 142000000
			end
			if mp > 680000 and mp <= 690000 then
				req = 144000000
			end
			if mp > 690000 and mp <= 700000 then
				req = 146000000
			end
			if mp > 700000 and mp <= 710000 then
				req = 148000000
			end
			if mp > 710000 and mp <= 720000 then
				req = 150000000
			end
			if mp > 720000 and mp <= 730000 then
				req = 152000000
			end
			if mp > 730000 and mp <= 740000 then
				req = 154000000
			end
			if mp > 740000 and mp <= 750000 then
				req = 156000000
			end
			if mp > 750000 and mp <= 760000 then
				req = 158000000
			end
			if mp > 760000 and mp <= 770000 then
				req = 160000000
			end
			if mp > 770000 and mp <= 780000 then
				req = 162000000
			end
			if mp > 780000 and mp <= 790000 then
				req = 164000000
			end
			if mp > 790000 and mp <= 800000 then
				req = 166000000
			end
			if mp > 800000 and mp <= 810000 then
				req = 168000000
			end
			if mp > 810000 and mp <= 820000 then
				req = 170000000
			end
			if mp > 820000 and mp <= 830000 then
				req = 172000000
			end
			if mp > 830000 and mp <= 840000 then
				req = 174000000
			end
			if mp > 840000 and mp <= 850000 then
				req = 176000000
			end
			if mp > 850000 and mp <= 860000 then
				req = 178000000
			end
			if mp > 860000 and mp <= 870000 then
				req = 180000000
			end
			if mp > 870000 and mp <= 880000 then
				req = 182000000
			end
			if mp > 880000 and mp <= 890000 then
				req = 184000000
			end
			if mp > 890000 and mp <= 900000 then
				req = 186000000
			end
			if mp > 900000 and mp <= 910000 then
				req = 188000000
			end
			if mp > 910000 and mp <= 920000 then
				req = 190000000
			end
			if mp > 920000 and mp <= 930000 then
				req = 192000000
			end
			if mp > 930000 and mp <= 940000 then
				req = 194000000
			end
			if mp > 940000 and mp <= 950000 then
				req = 196000000
			end
			if mp > 950000 and mp <= 960000 then
				req = 198000000
			end
			if mp > 960000 and mp <= 970000 then
				req = 200000000
			end
			if mp > 970000 and mp <= 980000 then
				req = 202000000
			end
			if mp > 980000 and mp <= 990000 then
				req = 204000000
			end
			if mp > 990000 and mp <= 1000000 then
				req = 206000000
			end
			if mp > 1000000 and mp <= 1010000 then
				req = 208000000
			end
			if mp > 1010000 and mp <= 1020000 then
				req = 210000000
			end
			if mp > 1020000 and mp <= 1030000 then
				req = 212000000
			end
			if mp > 1030000 and mp <= 1040000 then
				req = 214000000
			end
			if mp > 1040000 and mp <= 1050000 then
				req = 216000000
			end
			if mp > 1050000 and mp <= 1060000 then
				req = 218000000
			end
			if mp > 1060000 and mp <= 1070000 then
				req = 220000000
			end
			if mp > 1070000 and mp <= 1080000 then
				req = 222000000
			end
			if mp > 1080000 and mp <= 1090000 then
				req = 224000000
			end
			if mp > 1090000 and mp <= 1100000 then
				req = 226000000
			end
			if mp > 1100000 and mp <= 1110000 then
				req = 228000000
			end
			if mp > 1110000 and mp <= 1120000 then
				req = 230000000
			end
			if mp > 1120000 and mp <= 1130000 then
				req = 232000000
			end
			if mp > 1130000 and mp <= 1140000 then
				req = 234000000
			end
			if mp > 1140000 and mp <= 1150000 then
				req = 236000000
			end
			if mp > 1150000 and mp <= 1160000 then
				req = 238000000
			end
			if mp > 1160000 and mp <= 1170000 then
				req = 240000000
			end
			if mp > 1170000 and mp <= 1180000 then
				req = 242000000
			end
			if mp > 1180000 and mp <= 1190000 then
				req = 244000000
			end
			if mp > 1190000 and mp <= 1200000 then
				req = 246000000
			end
			if mp > 1200000 and mp <= 1210000 then
				req = 248000000
			end
			if mp > 1210000 and mp <= 1220000 then
				req = 250000000
			end
			if mp > 1220000 and mp <= 1230000 then
				req = 252000000
			end
			if mp > 1230000 and mp <= 1240000 then
				req = 254000000
			end
			if mp > 1240000 and mp <= 1250000 then
				req = 256000000
			end
			if mp > 1250000 and mp <= 1260000 then
				req = 258000000
			end
			if mp > 1260000 and mp <= 1270000 then
				req = 260000000
			end
			if mp > 1270000 and mp <= 1280000 then
				req = 262000000
			end
			if mp > 1280000 and mp <= 1290000 then
				req = 264000000
			end
			if mp > 1290000 and mp <= 1300000 then
				req = 266000000
			end
			if mp > 1300000 and mp <= 1310000 then
				req = 268000000
			end
			if mp > 1310000 and mp <= 1320000 then
				req = 270000000
			end
			if mp > 1320000 and mp <= 1330000 then
				req = 272000000
			end
			if mp > 1330000 and mp <= 1340000 then
				req = 274000000
			end
			if mp > 1340000 and mp <= 1350000 then
				req = 276000000
			end
			if mp > 1350000 and mp <= 1360000 then
				req = 278000000
			end
			if mp > 1360000 and mp <= 1370000 then
				req = 280000000
			end
			if mp > 1370000 and mp <= 1380000 then
				req = 282000000
			end
			if mp > 1380000 and mp <= 1390000 then
				req = 284000000
			end
			if mp > 1390000 and mp <= 1400000 then
				req = 286000000
			end
			if mp > 1400000 and mp <= 1410000 then
				req = 288000000
			end
			if mp > 1410000 and mp <= 1420000 then
				req = 290000000
			end
			if mp > 1420000 and mp <= 1430000 then
				req = 292000000
			end
			if mp > 1430000 and mp <= 1440000 then
				req = 294000000
			end
			if mp > 1440000 and mp <= 1450000 then
				req = 296000000
			end
			if mp > 1450000 and mp <= 1460000 then
				req = 298000000
			end
			if mp > 1460000 and mp <= 1470000 then
				req = 300000000
			end
			if mp > 1470000 and mp <= 1480000 then
				req = 302000000
			end
			if mp > 1480000 and mp <= 1490000 then
				req = 304000000
			end
			if mp > 1490000 and mp <= 1500000 then
				req = 306000000
			end
			if mp > 1500000 and mp <= 1510000 then
				req = 308000000
			end
			if mp > 1510000 and mp <= 1520000 then
				req = 310000000
			end
			if mp > 1520000 and mp <= 1530000 then
				req = 312000000
			end
			if mp > 1530000 and mp <= 1540000 then
				req = 314000000
			end
			if mp > 1540000 and mp <= 1550000 then
				req = 316000000
			end
			if mp > 1550000 and mp <= 1560000 then
				req = 318000000
			end
			if mp > 1560000 and mp <= 1570000 then
				req = 320000000
			end
			if mp > 1570000 and mp <= 1580000 then
				req = 322000000
			end
			if mp > 1580000 and mp <= 1590000 then
				req = 324000000
			end
			if mp > 1590000 and mp <= 1600000 then
				req = 326000000
			end
			if mp > 1600000 and mp <= 1610000 then
				req = 328000000
			end
			if mp > 1610000 and mp <= 1620000 then
				req = 330000000
			end
			if mp > 1620000 and mp <= 1630000 then
				req = 332000000
			end
			if mp > 1630000 and mp <= 1640000 then
				req = 334000000
			end
			if mp > 1640000 and mp <= 1650000 then
				req = 336000000
			end
			if mp > 1650000 and mp <= 1660000 then
				req = 338000000
			end
			if mp > 1660000 and mp <= 1670000 then
				req = 340000000
			end
			if mp > 1670000 and mp <= 1680000 then
				req = 342000000
			end
			if mp > 1680000 and mp <= 1690000 then
				req = 344000000
			end
			if mp > 1690000 and mp <= 1700000 then
				req = 346000000
			end
			if mp > 1700000 and mp <= 1710000 then
				req = 348000000
			end
			if mp > 1710000 and mp <= 1720000 then
				req = 350000000
			end
			if mp > 1720000 and mp <= 1730000 then
				req = 352000000
			end
			if mp > 1730000 and mp <= 1740000 then
				req = 354000000
			end
			if mp > 1740000 and mp <= 1750000 then
				req = 356000000
			end
			if mp > 1750000 and mp <= 1760000 then
				req = 358000000
			end
			if mp > 1760000 and mp <= 1770000 then
				req = 360000000
			end
			if mp > 1770000 and mp <= 1780000 then
				req = 362000000
			end
			if mp > 1780000 and mp <= 1790000 then
				req = 364000000
			end
			if mp > 1790000 and mp <= 1800000 then
				req = 366000000
			end
			if mp > 1800000 and mp <= 1810000 then
				req = 368000000
			end
			if mp > 1810000 and mp <= 1820000 then
				req = 370000000
			end
			if mp > 1820000 and mp <= 1830000 then
				req = 372000000
			end
			if mp > 1830000 and mp <= 1840000 then
				req = 374000000
			end
			if mp > 1840000 and mp <= 1850000 then
				req = 376000000
			end
			if mp > 1850000 and mp <= 1860000 then
				req = 378000000
			end
			if mp > 1860000 and mp <= 1870000 then
				req = 380000000
			end
			if mp > 1870000 and mp <= 1880000 then
				req = 382000000
			end
			if mp > 1880000 and mp <= 1890000 then
				req = 384000000
			end
			if mp > 1890000 and mp <= 1900000 then
				req = 386000000
			end
			if mp > 1900000 and mp <= 1910000 then
				req = 388000000
			end
			if mp > 1910000 and mp <= 1920000 then
				req = 390000000
			end
			if mp > 1920000 and mp <= 1930000 then
				req = 392000000
			end
			if mp > 1930000 and mp <= 1940000 then
				req = 394000000
			end
			if mp > 1940000 and mp <= 1950000 then
				req = 396000000
			end
			if mp > 1950000 and mp <= 1960000 then
				req = 398000000
			end
			if mp > 1960000 and mp <= 1970000 then
				req = 400000000
			end
			if mp > 1970000 and mp <= 1980000 then
				req = 402000000
			end
			if mp > 1980000 and mp <= 1990000 then
				req = 404000000
			end
			if mp > 1990000 and mp <= 2000000 then
				req = 406000000
			end
			if mp > 2000000 and mp <= 2010000 then
				req = 408000000
			end
			if mp > 2010000 and mp <= 2020000 then
				req = 410000000
			end
			if mp > 2020000 and mp <= 2030000 then
				req = 412000000
			end
			if mp > 2030000 and mp <= 2040000 then
				req = 414000000
			end
			if mp > 2040000 and mp <= 2050000 then
				req = 416000000
			end
			if mp > 2050000 and mp <= 2060000 then
				req = 418000000
			end
			if mp > 2060000 and mp <= 2070000 then
				req = 420000000
			end
			if mp > 2070000 and mp <= 2080000 then
				req = 422000000
			end
			if mp > 2080000 and mp <= 2090000 then
				req = 424000000
			end
			if mp > 2090000 and mp <= 2100000 then
				req = 426000000
			end
			if mp > 2100000 and mp <= 2110000 then
				req = 428000000
			end
			if mp > 2110000 and mp <= 2120000 then
				req = 430000000
			end
			if mp > 2120000 and mp <= 2130000 then
				req = 432000000
			end
			if mp > 2130000 and mp <= 2140000 then
				req = 434000000
			end
			if mp > 2140000 and mp <= 2150000 then
				req = 436000000
			end
			if mp > 2150000 and mp <= 2160000 then
				req = 438000000
			end
			if mp > 2160000 and mp <= 2170000 then
				req = 440000000
			end
			if mp > 2170000 and mp <= 2180000 then
				req = 442000000
			end
			if mp > 2180000 and mp <= 2190000 then
				req = 444000000
			end
			if mp > 2190000 and mp <= 2200000 then
				req = 446000000
			end
			if mp > 2200000 and mp <= 2210000 then
				req = 448000000
			end
			if mp > 2210000 and mp <= 2220000 then
				req = 450000000
			end
			if mp > 2220000 and mp <= 2230000 then
				req = 452000000
			end
			if mp > 2230000 and mp <= 2240000 then
				req = 454000000
			end
			if mp > 2240000 and mp <= 2250000 then
				req = 456000000
			end
			if mp > 2250000 and mp <= 2260000 then
				req = 458000000
			end
			if mp > 2260000 and mp <= 2270000 then
				req = 460000000
			end
			if mp > 2270000 and mp <= 2280000 then
				req = 462000000
			end
			if mp > 2280000 and mp <= 2290000 then
				req = 464000000
			end
			if mp > 2290000 and mp <= 2300000 then
				req = 466000000
			end
			if mp > 2300000 and mp <= 2310000 then
				req = 468000000
			end
			if mp > 2310000 and mp <= 2320000 then
				req = 470000000
			end
			if mp > 2320000 and mp <= 2330000 then
				req = 472000000
			end
			if mp > 2330000 and mp <= 2340000 then
				req = 474000000
			end
			if mp > 2340000 and mp <= 2350000 then
				req = 476000000
			end
			if mp > 2350000 and mp <= 2360000 then
				req = 478000000
			end
			if mp > 2360000 and mp <= 2370000 then
				req = 480000000
			end
			if mp > 2370000 and mp <= 2380000 then
				req = 482000000
			end
			if mp > 2380000 and mp <= 2390000 then
				req = 484000000
			end
			if mp > 2390000 and mp <= 2400000 then
				req = 486000000
			end
			if mp > 2400000 and mp <= 2410000 then
				req = 488000000
			end
			if mp > 2410000 and mp <= 2420000 then
				req = 490000000
			end
			if mp > 2420000 and mp <= 2430000 then
				req = 492000000
			end
			if mp > 2430000 and mp <= 2440000 then
				req = 494000000
			end
			if mp > 2440000 and mp <= 2450000 then
				req = 496000000
			end
			if mp > 2450000 and mp <= 2460000 then
				req = 498000000
			end
			if mp > 2460000 and mp <= 2470000 then
				req = 500000000
			end
			if mp > 2470000 and mp <= 2480000 then
				req = 502000000
			end
			if mp > 2480000 and mp <= 2490000 then
				req = 504000000
			end
			if mp > 2490000 and mp <= 2500000 then
				req = 506000000
			end
			if mp > 2500000 and mp <= 2510000 then
				req = 508000000
			end
			if mp > 2510000 and mp <= 2520000 then
				req = 510000000
			end
			if mp > 2520000 and mp <= 2530000 then
				req = 512000000
			end
			if mp > 2530000 and mp <= 2540000 then
				req = 514000000
			end
			if mp > 2540000 and mp <= 2550000 then
				req = 516000000
			end
			if mp > 2550000 and mp <= 2560000 then
				req = 518000000
			end
			if mp > 2560000 and mp <= 2570000 then
				req = 520000000
			end
			if mp > 2570000 and mp <= 2580000 then
				req = 522000000
			end
			if mp > 2580000 and mp <= 2590000 then
				req = 524000000
			end
			if mp > 2590000 and mp <= 2600000 then
				req = 526000000
			end
			if mp > 2600000 and mp <= 2610000 then
				req = 528000000
			end
			if mp > 2610000 and mp <= 2620000 then
				req = 490000000
			end
			if mp > 2620000 and mp <= 2630000 then
				req = 492000000
			end
			if mp > 2630000 and mp <= 2640000 then
				req = 494000000
			end
			if mp > 2640000 and mp <= 2650000 then
				req = 496000000
			end
			if mp > 2650000 and mp <= 2660000 then
				req = 498000000
			end
			if mp > 2660000 and mp <= 2670000 then
				req = 500000000
			end
			if mp > 2670000 and mp <= 2680000 then
				req = 502000000
			end
			if mp > 2680000 and mp <= 2690000 then
				req = 504000000
			end
			if mp > 2690000 and mp <= 2700000 then
				req = 506000000
			end
			if mp > 2700000 and mp <= 2710000 then
				req = 508000000
			end
			if mp > 2710000 and mp <= 2720000 then
				req = 510000000
			end
			if mp > 2720000 and mp <= 2730000 then
				req = 512000000
			end
			if mp > 2730000 and mp <= 2740000 then
				req = 514000000
			end
			if mp > 2740000 and mp <= 2750000 then
				req = 516000000
			end
			if mp > 2750000 and mp <= 2760000 then
				req = 518000000
			end
			if mp > 2760000 and mp <= 2770000 then
				req = 520000000
			end
			if mp > 2770000 and mp <= 2780000 then
				req = 522000000
			end
			if mp > 2780000 and mp <= 2790000 then
				req = 524000000
			end
			if mp > 2790000 and mp <= 2800000 then
				req = 526000000
			end
			if mp > 2800000 and mp <= 2810000 then
				req = 528000000
			end
			if mp > 2810000 and mp <= 2820000 then
				req = 530000000
			end
			if mp > 2820000 and mp <= 2830000 then
				req = 532000000
			end
			if mp > 2830000 and mp <= 2840000 then
				req = 534000000
			end
			if mp > 2840000 and mp <= 2850000 then
				req = 536000000
			end
			if mp > 2850000 and mp <= 2860000 then
				req = 538000000
			end
			if mp > 2860000 and mp <= 2870000 then
				req = 540000000
			end
			if mp > 2870000 and mp <= 2880000 then
				req = 542000000
			end
			if mp > 2880000 and mp <= 2890000 then
				req = 544000000
			end
			if mp > 2890000 and mp <= 2900000 then
				req = 546000000
			end
			if mp > 2900000 and mp <= 2910000 then
				req = 548000000
			end
			if mp > 2910000 and mp <= 2920000 then
				req = 550000000
			end
			if mp > 2920000 and mp <= 2930000 then
				req = 552000000
			end
			if mp > 2930000 and mp <= 2940000 then
				req = 554000000
			end
			if mp > 2940000 and mp <= 2950000 then
				req = 556000000
			end
			if mp > 2950000 and mp <= 2960000 then
				req = 558000000
			end
			if mp > 2960000 and mp <= 2970000 then
				req = 560000000
			end
			if mp > 2970000 and mp <= 2980000 then
				req = 562000000
			end
			if mp > 2980000 and mp <= 2990000 then
				req = 564000000
			end
			if mp > 2990000 and mp <= 3000000 then
				req = 566000000
			end
			if mp > 3000000 and mp <= 3010000 then
				req = 568000000
			end
			if mp > 3010000 and mp <= 3020000 then
				req = 570000000
			end
			if mp > 3020000 and mp <= 3030000 then
				req = 572000000
			end
			if mp > 3030000 and mp <= 3040000 then
				req = 574000000
			end
			if mp > 3040000 and mp <= 3050000 then
				req = 576000000
			end
			if mp > 3050000 and mp <= 3060000 then
				req = 578000000
			end
			if mp > 3060000 and mp <= 3070000 then
				req = 580000000
			end
			if mp > 3070000 and mp <= 3080000 then
				req = 582000000
			end
			if mp > 3080000 and mp <= 3090000 then
				req = 584000000
			end
			if mp > 3090000 and mp <= 3100000 then
				req = 586000000
			end
			if mp > 3100000 and mp <= 3110000 then
				req = 588000000
			end
			if mp > 3110000 and mp <= 3120000 then
				req = 590000000
			end
			if mp > 3120000 and mp <= 3130000 then
				req = 592000000
			end
			if mp > 3130000 and mp <= 3140000 then
				req = 594000000
			end
			if mp > 3140000 and mp <= 3150000 then
				req = 596000000
			end
			if mp > 3150000 and mp <= 3160000 then
				req = 598000000
			end
			if mp > 3160000 and mp <= 3170000 then
				req = 600000000
			end
			if mp > 3170000 and mp <= 3180000 then
				req = 602000000
			end
			if mp > 3180000 and mp <= 3190000 then
				req = 604000000
			end
			if mp > 3190000 and mp <= 3200000 then
				req = 606000000
			end
			if mp > 3200000 and mp <= 3210000 then
				req = 608000000
			end
			if mp > 3210000 and mp <= 3220000 then
				req = 610000000
			end
			if mp > 3220000 and mp <= 3230000 then
				req = 612000000
			end
			if mp > 3230000 and mp <= 3240000 then
				req = 614000000
			end
			if mp > 3240000 and mp <= 3250000 then
				req = 616000000
			end
			if mp > 3250000 and mp <= 3260000 then
				req = 618000000
			end
			if mp > 3260000 and mp <= 3270000 then
				req = 620000000
			end
			if mp > 3270000 and mp <= 3280000 then
				req = 622000000
			end
			if mp > 3280000 and mp <= 3290000 then
				req = 624000000
			end
			if mp > 3290000 and mp <= 3300000 then
				req = 626000000
			end
			if mp > 3300000 and mp <= 3310000 then
				req = 628000000
			end
			if mp > 3310000 and mp <= 3320000 then
				req = 630000000
			end
			if mp > 3320000 and mp <= 3330000 then
				req = 632000000
			end
			if mp > 3330000 and mp <= 3340000 then
				req = 634000000
			end
			if mp > 3340000 and mp <= 3350000 then
				req = 636000000
			end
			if mp > 3350000 and mp <= 3360000 then
				req = 638000000
			end
			if mp > 3360000 and mp <= 3370000 then
				req = 640000000
			end
			if mp > 3370000 and mp <= 3380000 then
				req = 642000000
			end
			if mp > 3380000 and mp <= 3390000 then
				req = 644000000
			end
			if mp > 3390000 and mp <= 3400000 then
				req = 646000000
			end
			if mp > 3400000 and mp <= 3410000 then
				req = 648000000
			end
			if mp > 3410000 and mp <= 3420000 then
				req = 650000000
			end
			if mp > 3420000 and mp <= 3430000 then
				req = 652000000
			end
			if mp > 3430000 and mp <= 3440000 then
				req = 654000000
			end
			if mp > 3440000 and mp <= 3450000 then
				req = 656000000
			end
			if mp > 3450000 and mp <= 3460000 then
				req = 658000000
			end
			if mp > 3460000 and mp <= 3470000 then
				req = 660000000
			end
			if mp > 3470000 and mp <= 3480000 then
				req = 662000000
			end
			if mp > 3480000 and mp <= 3490000 then
				req = 664000000
			end
			if mp > 3490000 and mp <= 3500000 then
				req = 666000000
			end
			if mp > 3500000 and mp <= 3510000 then
				req = 668000000
			end
			if mp > 3510000 and mp <= 3520000 then
				req = 670000000
			end
			if mp > 3520000 and mp <= 3530000 then
				req = 672000000
			end
			if mp > 3530000 and mp <= 3540000 then
				req = 674000000
			end
			if mp > 3540000 and mp <= 3550000 then
				req = 676000000
			end
			if mp > 3550000 and mp <= 3560000 then
				req = 678000000
			end
			if mp > 3560000 and mp <= 3570000 then
				req = 680000000
			end
			if mp > 3570000 and mp <= 3580000 then
				req = 682000000
			end
			if mp > 3580000 and mp <= 3590000 then
				req = 684000000
			end
			if mp > 3590000 and mp <= 3600000 then
				req = 686000000
			end
			if mp > 3600000 and mp <= 3610000 then
				req = 688000000
			end
			if mp > 3610000 and mp <= 3620000 then
				req = 690000000
			end
			if mp > 3620000 and mp <= 3630000 then
				req = 692000000
			end
			if mp > 3630000 and mp <= 3640000 then
				req = 694000000
			end
			if mp > 3640000 and mp <= 3650000 then
				req = 696000000
			end
			if mp > 3650000 and mp <= 3660000 then
				req = 698000000
			end
			if mp > 3660000 and mp <= 3670000 then
				req = 700000000
			end
			if mp > 3670000 and mp <= 3680000 then
				req = 702000000
			end
			if mp > 3680000 and mp <= 3690000 then
				req = 704000000
			end
			if mp > 3690000 and mp <= 3700000 then
				req = 706000000
			end
			if mp > 3700000 and mp <= 3710000 then
				req = 708000000
			end
			if mp > 3710000 and mp <= 3720000 then
				req = 710000000
			end
			if mp > 3720000 and mp <= 3730000 then
				req = 712000000
			end
			if mp > 3730000 and mp <= 3740000 then
				req = 714000000
			end
			if mp > 3740000 and mp <= 3750000 then
				req = 716000000
			end
			if mp > 3750000 and mp <= 3760000 then
				req = 718000000
			end
			if mp > 3760000 and mp <= 3770000 then
				req = 720000000
			end
			if mp > 3770000 and mp <= 3780000 then
				req = 722000000
			end
			if mp > 3780000 and mp <= 3790000 then
				req = 724000000
			end
			if mp > 3790000 and mp <= 3800000 then
				req = 726000000
			end
			if mp > 3800000 and mp <= 3810000 then
				req = 728000000
			end
			if mp > 3810000 and mp <= 3820000 then
				req = 730000000
			end
			if mp > 3820000 and mp <= 3830000 then
				req = 732000000
			end
			if mp > 3830000 and mp <= 3840000 then
				req = 734000000
			end
			if mp > 3840000 and mp <= 3850000 then
				req = 736000000
			end
			if mp > 3850000 and mp <= 3860000 then
				req = 738000000
			end
			if mp > 3860000 and mp <= 3870000 then
				req = 740000000
			end
			if mp > 3870000 and mp <= 3880000 then
				req = 742000000
			end
			if mp > 3880000 and mp <= 3890000 then
				req = 744000000
			end
			if mp > 3890000 and mp <= 3900000 then
				req = 746000000
			end
			if mp > 3900000 and mp <= 3910000 then
				req = 748000000
			end
			if mp > 3910000 and mp <= 3920000 then
				req = 750000000
			end
			if mp > 3920000 and mp <= 3930000 then
				req = 752000000
			end
			if mp > 3930000 and mp <= 3940000 then
				req = 754000000
			end
			if mp > 3940000 and mp <= 3950000 then
				req = 756000000
			end
			if mp > 3950000 and mp <= 3960000 then
				req = 758000000
			end
			if mp > 3960000 and mp <= 3970000 then
				req = 760000000
			end
			if mp > 3970000 and mp <= 3980000 then
				req = 762000000
			end
			if mp > 3980000 and mp <= 3990000 then
				req = 764000000
			end
			if mp > 3990000 and mp <= 4000000 then
				req = 766000000
			end
			if mp > 4000000 and mp <= 4010000 then
				req = 768000000
			end
			if mp > 4010000 and mp <= 4020000 then
				req = 770000000
			end
			if mp > 4020000 and mp <= 4030000 then
				req = 772000000
			end
			if mp > 4030000 and mp <= 4040000 then
				req = 774000000
			end
			if mp > 4040000 and mp <= 4050000 then
				req = 776000000
			end
			if mp > 4050000 and mp <= 4060000 then
				req = 778000000
			end
			if mp > 4060000 and mp <= 4070000 then
				req = 780000000
			end
			if mp > 4070000 and mp <= 4080000 then
				req = 782000000
			end
			if mp > 4080000 and mp <= 4090000 then
				req = 784000000
			end
			if mp > 4090000 and mp <= 4100000 then
				req = 786000000
			end
			if mp > 4100000 and mp <= 4110000 then
				req = 788000000
			end
			if mp > 4110000 and mp <= 4120000 then
				req = 790000000
			end
			if mp > 4120000 and mp <= 4130000 then
				req = 792000000
			end
			if mp > 4130000 and mp <= 4140000 then
				req = 794000000
			end
			if mp > 4140000 and mp <= 4150000 then
				req = 796000000
			end
			if mp > 4150000 and mp <= 4160000 then
				req = 798000000
			end
			if mp > 4160000 and mp <= 4170000 then
				req = 800000000
			end
			if mp > 4170000 and mp <= 4180000 then
				req = 802000000
			end
			if mp > 4180000 and mp <= 4190000 then
				req = 804000000
			end
			if mp > 4190000 and mp <= 4200000 then
				req = 806000000
			end
			if mp > 4200000 and mp <= 4210000 then
				req = 808000000
			end
			if mp > 4210000 and mp <= 4220000 then
				req = 810000000
			end
			if mp > 4220000 and mp <= 4230000 then
				req = 812000000
			end
			if mp > 4230000 and mp <= 4240000 then
				req = 814000000
			end
			if mp > 4240000 and mp <= 4250000 then
				req = 816000000
			end
			if mp > 4250000 and mp <= 4260000 then
				req = 818000000
			end
			if mp > 4260000 and mp <= 4270000 then
				req = 820000000
			end
			if mp > 4270000 and mp <= 4280000 then
				req = 822000000
			end
			if mp > 4280000 and mp <= 4290000 then
				req = 824000000
			end
			if mp > 4290000 and mp <= 4300000 then
				req = 826000000
			end
			if mp > 4300000 and mp <= 4310000 then
				req = 828000000
			end
			if mp > 4310000 and mp <= 4320000 then
				req = 830000000
			end
			if mp > 4320000 and mp <= 4330000 then
				req = 832000000
			end
			if mp > 4330000 and mp <= 4340000 then
				req = 834000000
			end
			if mp > 4340000 and mp <= 4350000 then
				req = 836000000
			end
			if mp > 4350000 and mp <= 4360000 then
				req = 838000000
			end
			if mp > 4360000 and mp <= 4370000 then
				req = 840000000
			end
			if mp > 4370000 and mp <= 4380000 then
				req = 842000000
			end
			if mp > 4380000 and mp <= 4390000 then
				req = 844000000
			end
			if mp > 4390000 and mp <= 4400000 then
				req = 846000000
			end
			if mp > 4400000 and mp <= 4410000 then
				req = 848000000
			end
			if mp > 4410000 and mp <= 4420000 then
				req = 850000000
			end
			if mp > 4420000 and mp <= 4430000 then
				req = 852000000
			end
			if mp > 4430000 and mp <= 4440000 then
				req = 854000000
			end
			if mp > 4440000 and mp <= 4450000 then
				req = 856000000
			end
			if mp > 4450000 and mp <= 4460000 then
				req = 858000000
			end
			if mp > 4460000 and mp <= 4470000 then
				req = 860000000
			end
			if mp > 4470000 and mp <= 4480000 then
				req = 862000000
			end
			if mp > 4480000 and mp <= 4490000 then
				req = 864000000
			end
			if mp > 4490000 and mp <= 4500000 then
				req = 866000000
			end
			if mp > 4500000 and mp <= 4510000 then
				req = 868000000
			end
			if mp > 4510000 and mp <= 4520000 then
				req = 870000000
			end
			if mp > 4520000 and mp <= 4530000 then
				req = 872000000
			end
			if mp > 4530000 and mp <= 4540000 then
				req = 874000000
			end
			if mp > 4540000 and mp <= 4550000 then
				req = 876000000
			end
			if mp > 4550000 and mp <= 4560000 then
				req = 878000000
			end
			if mp > 4560000 and mp <= 4570000 then
				req = 880000000
			end
			if mp > 4570000 and mp <= 4580000 then
				req = 882000000
			end
			if mp > 4580000 and mp <= 4590000 then
				req = 884000000
			end
			if mp > 4590000 and mp <= 4600000 then
				req = 886000000
			end
			if mp > 4600000 and mp <= 4610000 then
				req = 888000000
			end
			if mp > 4610000 and mp <= 4620000 then
				req = 890000000
			end
			if mp > 4620000 and mp <= 4630000 then
				req = 892000000
			end
			if mp > 4630000 and mp <= 4640000 then
				req = 894000000
			end
			if mp > 4640000 and mp <= 4650000 then
				req = 896000000
			end
			if mp > 4650000 and mp <= 4660000 then
				req = 898000000
			end
			if mp > 4660000 and mp <= 4670000 then
				req = 900000000
			end
			if mp > 4670000 and mp <= 4680000 then
				req = 902000000
			end
			if mp > 4680000 and mp <= 4690000 then
				req = 904000000
			end
			if mp > 4690000 and mp <= 4700000 then
				req = 906000000
			end
			if mp > 4700000 and mp <= 4710000 then
				req = 908000000
			end
			if mp > 4710000 and mp <= 4720000 then
				req = 910000000
			end
			if mp > 4720000 and mp <= 4730000 then
				req = 912000000
			end
			if mp > 4730000 and mp <= 4740000 then
				req = 914000000
			end
			if mp > 4740000 and mp <= 4750000 then
				req = 916000000
			end
			if mp > 4750000 and mp <= 4760000 then
				req = 918000000
			end
			if mp > 4760000 and mp <= 4770000 then
				req = 920000000
			end
			if mp > 4770000 and mp <= 4780000 then
				req = 922000000
			end
			if mp > 4780000 and mp <= 4790000 then
				req = 924000000
			end
			if mp > 4790000 and mp <= 4800000 then
				req = 926000000
			end
			if mp > 4800000 and mp <= 4810000 then
				req = 928000000
			end
			if mp > 4810000 and mp <= 4820000 then
				req = 930000000
			end
			if mp > 4820000 and mp <= 4830000 then
				req = 932000000
			end
			if mp > 4830000 and mp <= 4840000 then
				req = 934000000
			end
			if mp > 4840000 and mp <= 4850000 then
				req = 936000000
			end
			if mp > 4850000 and mp <= 4860000 then
				req = 938000000
			end
			if mp > 4860000 and mp <= 4870000 then
				req = 940000000
			end
			if mp > 4870000 and mp <= 4880000 then
				req = 942000000
			end
			if mp > 4880000 and mp <= 4890000 then
				req = 944000000
			end
			if mp > 4890000 and mp <= 4900000 then
				req = 946000000
			end
			if mp > 4900000 and mp <= 4910000 then
				req = 948000000
			end
			if mp > 4910000 and mp <= 4920000 then
				req = 950000000
			end
			if mp > 4920000 and mp <= 4930000 then
				req = 952000000
			end
			if mp > 4930000 and mp <= 4940000 then
				req = 954000000
			end
			if mp > 4940000 and mp <= 4950000 then
				req = 956000000
			end
			if mp > 4950000 and mp <= 4960000 then
				req = 958000000
			end
			if mp > 4960000 and mp <= 4970000 then
				req = 960000000
			end
			if mp > 4970000 and mp <= 4980000 then
				req = 962000000
			end
			if mp > 4980000 and mp <= 4990000 then
				req = 964000000
			end
			if mp > 4990000 and mp <= 5000000 then
				req = 966000000
			end
			if mp > 5000000 and mp <= 5010000 then
				req = 968000000
			end
			if mp > 5010000 and mp <= 5020000 then
				req = 970000000
			end
			if mp > 5020000 and mp <= 5030000 then
				req = 972000000
			end
			if mp > 5030000 and mp <= 5040000 then
				req = 974000000
			end
			if mp > 5040000 and mp <= 5050000 then
				req = 976000000
			end
			if mp > 5050000 and mp <= 5060000 then
				req = 978000000
			end
			if mp > 5060000 and mp <= 5070000 then
				req = 980000000
			end
			if mp > 5070000 and mp <= 5080000 then
				req = 982000000
			end
			if mp > 5080000 and mp <= 5090000 then
				req = 984000000
			end
			if mp > 5090000 and mp <= 5100000 then
				req = 986000000
			end
			if mp > 5100000 and mp <= 5110000 then
				req = 988000000
			end
			if mp > 5110000 and mp <= 5120000 then
				req = 990000000
			end
			if mp > 5120000 and mp <= 5130000 then
				req = 992000000
			end
			if mp > 5130000 and mp <= 5140000 then
				req = 994000000
			end
			if mp > 5140000 and mp <= 5150000 then
				req = 996000000
			end
			if mp > 5150000 and mp <= 5160000 then
				req = 998000000
			end
			if mp > 5160000 and mp <= 5170000 then
				req = 1000000000
			end
			if mp > 5170000 and mp <= 5180000 then
				req = 1002000000
			end
			if mp > 5180000 and mp <= 5190000 then
				req = 1004000000
			end
			if mp > 5190000 and mp <= 5200000 then
				req = 1006000000
			end
			if mp > 5200000 and mp <= 5210000 then
				req = 1008000000
			end
			if mp > 5210000 and mp <= 5220000 then
				req = 1010000000
			end
			if mp > 5220000 and mp <= 5230000 then
				req = 1012000000
			end
			if mp > 5230000 and mp <= 5240000 then
				req = 1014000000
			end
			if mp > 5240000 and mp <= 5250000 then
				req = 1016000000
			end
			if mp > 5250000 and mp <= 5260000 then
				req = 1018000000
			end
			if mp > 5260000 and mp <= 5270000 then
				req = 1020000000
			end
			if mp > 5270000 and mp <= 5280000 then
				req = 1022000000
			end
			if mp > 5280000 and mp <= 5290000 then
				req = 1024000000
			end
			if mp > 5290000 and mp <= 5300000 then
				req = 1026000000
			end
			if mp > 5300000 and mp <= 5310000 then
				req = 1028000000
			end
			if mp > 5310000 and mp <= 5320000 then
				req = 1030000000
			end
			if mp > 5320000 and mp <= 5330000 then
				req = 1032000000
			end
			if mp > 5330000 and mp <= 5340000 then
				req = 1034000000
			end
			if mp > 5340000 and mp <= 5350000 then
				req = 1036000000
			end
			if mp > 5350000 and mp <= 5360000 then
				req = 1038000000
			end
			if mp > 5360000 and mp <= 5370000 then
				req = 1040000000
			end
			if mp > 5370000 and mp <= 5380000 then
				req = 1042000000
			end
			if mp > 5380000 and mp <= 5390000 then
				req = 1044000000
			end
			if mp > 5390000 and mp <= 5400000 then
				req = 1046000000
			end
			if mp > 5400000 and mp <= 5410000 then
				req = 1048000000
			end
			if mp > 5410000 and mp <= 5420000 then
				req = 1050000000
			end
			if mp > 5420000 and mp <= 5430000 then
				req = 1052000000
			end
			if mp > 5430000 and mp <= 5440000 then
				req = 1054000000
			end
			if mp > 5440000 and mp <= 5450000 then
				req = 1056000000
			end
			if mp > 5450000 and mp <= 5460000 then
				req = 1058000000
			end
			if mp > 5460000 and mp <= 5470000 then
				req = 1060000000
			end
			if mp > 5470000 and mp <= 5480000 then
				req = 1062000000
			end
			if mp > 5480000 and mp <= 5490000 then
				req = 1064000000
			end
			if mp > 5490000 and mp <= 5500000 then
				req = 1066000000
			end
			if mp > 5500000 and mp <= 5510000 then
				req = 1068000000
			end
			if mp > 5510000 and mp <= 5520000 then
				req = 1070000000
			end
			if mp > 5520000 and mp <= 5530000 then
				req = 1072000000
			end
			if mp > 5530000 and mp <= 5540000 then
				req = 1074000000
			end
			if mp > 5540000 and mp <= 5550000 then
				req = 1076000000
			end
			if mp > 5550000 and mp <= 5560000 then
				req = 1078000000
			end
			if mp > 5560000 and mp <= 5570000 then
				req = 1080000000
			end
			if mp > 5570000 and mp <= 5580000 then
				req = 1082000000
			end
			if mp > 5580000 and mp <= 5590000 then
				req = 1084000000
			end
			if mp > 5590000 and mp <= 5600000 then
				req = 1086000000
			end
			if mp > 5600000 and mp <= 5610000 then
				req = 1088000000
			end
			if mp > 5610000 and mp <= 5620000 then
				req = 1090000000
			end
			if mp > 5620000 and mp <= 5630000 then
				req = 1092000000
			end
			if mp > 5630000 and mp <= 5640000 then
				req = 1094000000
			end
			if mp > 5640000 and mp <= 5650000 then
				req = 1096000000
			end
			if mp > 5650000 and mp <= 5660000 then
				req = 1098000000
			end
			if mp > 5660000 and mp <= 5670000 then
				req = 1100000000
			end
			if mp > 5670000 and mp <= 5680000 then
				req = 1102000000
			end
			if mp > 5680000 and mp <= 5690000 then
				req = 1104000000
			end
			if mp > 5690000 and mp <= 5700000 then
				req = 1106000000
			end
			if mp > 5700000 and mp <= 5710000 then
				req = 1108000000
			end
			if mp > 5710000 and mp <= 5720000 then
				req = 1110000000
			end
			if mp > 5720000 and mp <= 5730000 then
				req = 1112000000
			end
			if mp > 5730000 and mp <= 5740000 then
				req = 1114000000
			end
			if mp > 5740000 and mp <= 5750000 then
				req = 1116000000
			end
			if mp > 5750000 and mp <= 5760000 then
				req = 1118000000
			end
			if mp > 5760000 and mp <= 5770000 then
				req = 1120000000
			end
			if mp > 5770000 and mp <= 5780000 then
				req = 1122000000
			end
			if mp > 5780000 and mp <= 5790000 then
				req = 1124000000
			end
			if mp > 5790000 and mp <= 5800000 then
				req = 1126000000
			end
			if mp > 5800000 and mp <= 5810000 then
				req = 1128000000
			end
			if mp > 5810000 and mp <= 5820000 then
				req = 1130000000
			end
			if mp > 5820000 and mp <= 5830000 then
				req = 1132000000
			end
			if mp > 5830000 and mp <= 5840000 then
				req = 1134000000
			end
			if mp > 5840000 and mp <= 5850000 then
				req = 1136000000
			end
			if mp > 5850000 and mp <= 5860000 then
				req = 1138000000
			end
			if mp > 5860000 and mp <= 5870000 then
				req = 1140000000
			end
			if mp > 5870000 and mp <= 5880000 then
				req = 1142000000
			end
			if mp > 5880000 and mp <= 5890000 then
				req = 1144000000
			end
			if mp > 5890000 and mp <= 5900000 then
				req = 1146000000
			end
			if mp > 5900000 and mp <= 5910000 then
				req = 1148000000
			end
			if mp > 5910000 and mp <= 5920000 then
				req = 1150000000
			end
			if mp > 5920000 and mp <= 5930000 then
				req = 1152000000
			end
			if mp > 5930000 and mp <= 5940000 then
				req = 1154000000
			end
			if mp > 5940000 and mp <= 5950000 then
				req = 1156000000
			end
			if mp > 5950000 and mp <= 5960000 then
				req = 1158000000
			end
			if mp > 5960000 and mp <= 5970000 then
				req = 1160000000
			end
			if mp > 5970000 and mp <= 5980000 then
				req = 1162000000
			end
			if mp > 5980000 and mp <= 5990000 then
				req = 1164000000
			end
			if mp > 5990000 and mp <= 6000000 then
				req = 1166000000
			end
			if mp > 6000000 and mp <= 6010000 then
				req = 1168000000
			end
			if mp > 6010000 and mp <= 6020000 then
				req = 1170000000
			end
			if mp > 6020000 and mp <= 6030000 then
				req = 1172000000
			end
			if mp > 6030000 and mp <= 6040000 then
				req = 1174000000
			end
			if mp > 6040000 and mp <= 6050000 then
				req = 1176000000
			end
			if mp > 6050000 and mp <= 6060000 then
				req = 1178000000
			end
			if mp > 6060000 and mp <= 6070000 then
				req = 1180000000
			end
			if mp > 6070000 and mp <= 6080000 then
				req = 1182000000
			end
			if mp > 6080000 and mp <= 6090000 then
				req = 1184000000
			end
			if mp > 6090000 and mp <= 6100000 then
				req = 1186000000
			end
			if mp > 6100000 and mp <= 6110000 then
				req = 1188000000
			end
			if mp > 6110000 and mp <= 6120000 then
				req = 1190000000
			end
			if mp > 6120000 and mp <= 6130000 then
				req = 1192000000
			end
			if mp > 6130000 and mp <= 6140000 then
				req = 1194000000
			end
			if mp > 6140000 and mp <= 6150000 then
				req = 1196000000
			end
			if mp > 6150000 and mp <= 6160000 then
				req = 1198000000
			end
			if mp > 6160000 and mp <= 6170000 then
				req = 1200000000
			end
			if mp > 6170000 and mp <= 6180000 then
				req = 1202000000
			end
			if mp > 6180000 and mp <= 6190000 then
				req = 1204000000
			end
			if mp > 6190000 and mp <= 6200000 then
				req = 1206000000
			end
			if mp > 6200000 and mp <= 6210000 then
				req = 1208000000
			end
			if mp > 6210000 and mp <= 6220000 then
				req = 1210000000
			end
			if mp > 6220000 and mp <= 6230000 then
				req = 1212000000
			end
			if mp > 6230000 and mp <= 6240000 then
				req = 1214000000
			end
			if mp > 6240000 and mp <= 6250000 then
				req = 1216000000
			end
			if mp > 6250000 and mp <= 6260000 then
				req = 1218000000
			end
			if mp > 6260000 and mp <= 6270000 then
				req = 1220000000
			end
			if mp > 6270000 and mp <= 6280000 then
				req = 1222000000
			end
			if mp > 6280000 and mp <= 6290000 then
				req = 1224000000
			end
			if mp > 6290000 and mp <= 6300000 then
				req = 1226000000
			end
			if mp > 6300000 and mp <= 6310000 then
				req = 1228000000
			end
			if mp > 6310000 and mp <= 6320000 then
				req = 1230000000
			end
			if mp > 6320000 and mp <= 6330000 then
				req = 1232000000
			end
			if mp > 6330000 and mp <= 6340000 then
				req = 1234000000
			end
			if mp > 6340000 and mp <= 6350000 then
				req = 1236000000
			end
			if mp > 6350000 and mp <= 6360000 then
				req = 1238000000
			end
			if mp > 6360000 and mp <= 6370000 then
				req = 1240000000
			end
			if mp > 6370000 and mp <= 6380000 then
				req = 1242000000
			end
			if mp > 6380000 and mp <= 6390000 then
				req = 1244000000
			end
			if mp > 6390000 and mp <= 6400000 then
				req = 1246000000
			end
			if mp > 6400000 and mp <= 6410000 then
				req = 1248000000
			end
			if mp > 6410000 and mp <= 6420000 then
				req = 1250000000
			end
			if mp > 6420000 and mp <= 6430000 then
				req = 1252000000
			end
			if mp > 6430000 and mp <= 6440000 then
				req = 1254000000
			end
			if mp > 6440000 and mp <= 6450000 then
				req = 1256000000
			end
			if mp > 6450000 and mp <= 6460000 then
				req = 1258000000
			end
			if mp > 6460000 and mp <= 6470000 then
				req = 1260000000
			end
			if mp > 6470000 and mp <= 6480000 then
				req = 1262000000
			end
			if mp > 6480000 and mp <= 6490000 then
				req = 1264000000
			end
			if mp > 6490000 and mp <= 6500000 then
				req = 1266000000
			end
			if mp > 6500000 and mp <= 6510000 then
				req = 1268000000
			end
			if mp > 6510000 and mp <= 6520000 then
				req = 1270000000
			end
			if mp > 6520000 and mp <= 6530000 then
				req = 1272000000
			end
			if mp > 6530000 and mp <= 6540000 then
				req = 1274000000
			end
			if mp > 6540000 and mp <= 6550000 then
				req = 1276000000
			end
			if mp > 6550000 and mp <= 6560000 then
				req = 1278000000
			end
			if mp > 6560000 and mp <= 6570000 then
				req = 1280000000
			end
			if mp > 6570000 and mp <= 6580000 then
				req = 1282000000
			end
			if mp > 6580000 and mp <= 6590000 then
				req = 1284000000
			end
			if mp > 6590000 and mp <= 6600000 then
				req = 1286000000
			end
			if mp > 6600000 and mp <= 6610000 then
				req = 1288000000
			end
			if mp > 6610000 and mp <= 6620000 then
				req = 1290000000
			end
			if mp > 6620000 and mp <= 6630000 then
				req = 1292000000
			end
			if mp > 6630000 and mp <= 6640000 then
				req = 1294000000
			end
			if mp > 6640000 and mp <= 6650000 then
				req = 1296000000
			end
			if mp > 6650000 and mp <= 6660000 then
				req = 1298000000
			end
			if mp > 6660000 and mp <= 6670000 then
				req = 1300000000
			end
			if mp > 6670000 and mp <= 6680000 then
				req = 1302000000
			end
			if mp > 6680000 and mp <= 6690000 then
				req = 1304000000
			end
			if mp > 6690000 and mp <= 6700000 then
				req = 1306000000
			end
			if mp > 6700000 and mp <= 6710000 then
				req = 1308000000
			end
			if mp > 6710000 and mp <= 6720000 then
				req = 1310000000
			end
			if mp > 6720000 and mp <= 6730000 then
				req = 1312000000
			end
			if mp > 6730000 and mp <= 6740000 then
				req = 1314000000
			end
			if mp > 6740000 and mp <= 6750000 then
				req = 1316000000
			end
			if mp > 6750000 and mp <= 6760000 then
				req = 1318000000
			end
			if mp > 6760000 and mp <= 6770000 then
				req = 1320000000
			end
			if mp > 6770000 and mp <= 6780000 then
				req = 1322000000
			end
			if mp > 6780000 and mp <= 6790000 then
				req = 1324000000
			end
			if mp > 6790000 and mp <= 6800000 then
				req = 1326000000
			end
			if mp > 6800000 and mp <= 6810000 then
				req = 1328000000
			end
			if mp > 6810000 and mp <= 6820000 then
				req = 1330000000
			end
			if mp > 6820000 and mp <= 6830000 then
				req = 1332000000
			end
			if mp > 6830000 and mp <= 6840000 then
				req = 1334000000
			end
			if mp > 6840000 and mp <= 6850000 then
				req = 1336000000
			end
			if mp > 6850000 and mp <= 6860000 then
				req = 1338000000
			end
			if mp > 6860000 and mp <= 6870000 then
				req = 1340000000
			end
			if mp > 6870000 and mp <= 6880000 then
				req = 1342000000
			end
			if mp > 6880000 and mp <= 6890000 then
				req = 1344000000
			end
			if mp > 6890000 and mp <= 6900000 then
				req = 1346000000
			end
			if mp > 6900000 and mp <= 6910000 then
				req = 1348000000
			end
			if mp > 6910000 and mp <= 6920000 then
				req = 1350000000
			end
			if mp > 6920000 and mp <= 6930000 then
				req = 1352000000
			end
			if mp > 6930000 and mp <= 6940000 then
				req = 1354000000
			end
			if mp > 6940000 and mp <= 6950000 then
				req = 1356000000
			end
			if mp > 6950000 and mp <= 6960000 then
				req = 1358000000
			end
			if mp > 6960000 and mp <= 6970000 then
				req = 1360000000
			end
			if mp > 6970000 and mp <= 6980000 then
				req = 1362000000
			end
			if mp > 6980000 and mp <= 6990000 then
				req = 1364000000
			end
			if mp > 6990000 and mp <= 7000000 then
				req = 1366000000
			end
			if mp > 7000000 and mp <= 7010000 then
				req = 1368000000
			end
			if mp > 7010000 and mp <= 7020000 then
				req = 1370000000
			end
			if mp > 7020000 and mp <= 7030000 then
				req = 1372000000
			end
			if mp > 7030000 and mp <= 7040000 then
				req = 1374000000
			end
			if mp > 7040000 and mp <= 7050000 then
				req = 1376000000
			end
			if mp > 7050000 and mp <= 7060000 then
				req = 1378000000
			end
			if mp > 7060000 and mp <= 7070000 then
				req = 1380000000
			end
			if mp > 7070000 and mp <= 7080000 then
				req = 1382000000
			end
			if mp > 7080000 and mp <= 7090000 then
				req = 1384000000
			end
			if mp > 7090000 and mp <= 7100000 then
				req = 1386000000
			end
			if mp > 7100000 and mp <= 7110000 then
				req = 1388000000
			end
			if mp > 7110000 and mp <= 7120000 then
				req = 1390000000
			end
			if mp > 7120000 and mp <= 7130000 then
				req = 1392000000
			end
			if mp > 7130000 and mp <= 7140000 then
				req = 1394000000
			end
			if mp > 7140000 and mp <= 7150000 then
				req = 1396000000
			end
			if mp > 7150000 and mp <= 7160000 then
				req = 1398000000
			end
			if mp > 7160000 and mp <= 7170000 then
				req = 1400000000
			end
			if mp > 7170000 and mp <= 7180000 then
				req = 1402000000
			end
			if mp > 7180000 and mp <= 7190000 then
				req = 1404000000
			end
			if mp > 7190000 and mp <= 7200000 then
				req = 1406000000
			end
			if mp > 7200000 and mp <= 7210000 then
				req = 1408000000
			end
			if mp > 7210000 and mp <= 7220000 then
				req = 1410000000
			end
			if mp > 7220000 and mp <= 7230000 then
				req = 1412000000
			end
			if mp > 7230000 and mp <= 7240000 then
				req = 1414000000
			end
			if mp > 7240000 and mp <= 7250000 then
				req = 1416000000
			end
			if mp > 7250000 and mp <= 7260000 then
				req = 1418000000
			end
			if mp > 7260000 and mp <= 7270000 then
				req = 1420000000
			end
			if mp > 7270000 and mp <= 7280000 then
				req = 1422000000
			end
			if mp > 7280000 and mp <= 7290000 then
				req = 1424000000
			end
			if mp > 7290000 and mp <= 7300000 then
				req = 1426000000
			end
			if mp > 7300000 and mp <= 7310000 then
				req = 1428000000
			end
			if mp > 7310000 and mp <= 7320000 then
				req = 1430000000
			end
			if mp > 7320000 and mp <= 7330000 then
				req = 1432000000
			end
			if mp > 7330000 and mp <= 7340000 then
				req = 1434000000
			end
			if mp > 7340000 and mp <= 7350000 then
				req = 1436000000
			end
			if mp > 7350000 and mp <= 7360000 then
				req = 1438000000
			end
			if mp > 7360000 and mp <= 7370000 then
				req = 1440000000
			end
			if mp > 7370000 and mp <= 7380000 then
				req = 1442000000
			end
			if mp > 7380000 and mp <= 7390000 then
				req = 1444000000
			end
			if mp > 7390000 and mp <= 7400000 then
				req = 1446000000
			end
			if mp > 7400000 and mp <= 7410000 then
				req = 1448000000
			end
			if mp > 7410000 and mp <= 7420000 then
				req = 1450000000
			end
			if mp > 7420000 and mp <= 7430000 then
				req = 1452000000
			end
			if mp > 7430000 and mp <= 7440000 then
				req = 1454000000
			end
			if mp > 7440000 and mp <= 7450000 then
				req = 1456000000
			end
			if mp > 7450000 and mp <= 7460000 then
				req = 1458000000
			end
			if mp > 7460000 and mp <= 7470000 then
				req = 1460000000
			end
			if mp > 7470000 and mp <= 7480000 then
				req = 1462000000
			end
			if mp > 7480000 and mp <= 7490000 then
				req = 1464000000
			end
			if mp > 7490000 and mp <= 7500000 then
				req = 1466000000
			end
			if mp > 7500000 and mp <= 7510000 then
				req = 1468000000
			end
			if mp > 7510000 and mp <= 7520000 then
				req = 1470000000
			end
			if mp > 7520000 and mp <= 7530000 then
				req = 1472000000
			end
			if mp > 7530000 and mp <= 7540000 then
				req = 1474000000
			end
			if mp > 7540000 and mp <= 7550000 then
				req = 1476000000
			end
			if mp > 7550000 and mp <= 7560000 then
				req = 1478000000
			end
			if mp > 7560000 and mp <= 7570000 then
				req = 1480000000
			end
			if mp > 7570000 and mp <= 7580000 then
				req = 1482000000
			end
			if mp > 7580000 and mp <= 7590000 then
				req = 1484000000
			end
			if mp > 7590000 and mp <= 7600000 then
				req = 1486000000
			end
			if mp > 7600000 and mp <= 7610000 then
				req = 1488000000
			end
			if mp > 7610000 and mp <= 7620000 then
				req = 1490000000
			end
			if mp > 7620000 and mp <= 7630000 then
				req = 1492000000
			end
			if mp > 7630000 and mp <= 7640000 then
				req = 1494000000
			end
			if mp > 7640000 and mp <= 7650000 then
				req = 1496000000
			end
			if mp > 7650000 and mp <= 7660000 then
				req = 1498000000
			end
			if mp > 7660000 and mp <= 7670000 then
				req = 1500000000
			end
			if mp > 7670000 and mp <= 7680000 then
				req = 1502000000
			end
			if mp > 7680000 and mp <= 7690000 then
				req = 1504000000
			end
			if mp > 7690000 and mp <= 7700000 then
				req = 1506000000
			end
			if mp > 7700000 and mp <= 7710000 then
				req = 1508000000
			end
			if mp > 7710000 and mp <= 7720000 then
				req = 1510000000
			end
			if mp > 7720000 and mp <= 7730000 then
				req = 1512000000
			end
			if mp > 7730000 and mp <= 7740000 then
				req = 1514000000
			end
			if mp > 7740000 and mp <= 7750000 then
				req = 1516000000
			end
			if mp > 7750000 and mp <= 7760000 then
				req = 1518000000
			end
			if mp > 7760000 and mp <= 7770000 then
				req = 1520000000
			end
			if mp > 7770000 and mp <= 7780000 then
				req = 1522000000
			end
			if mp > 7780000 and mp <= 7790000 then
				req = 1524000000
			end
			if mp > 7790000 and mp <= 7800000 then
				req = 1526000000
			end
			if mp > 7800000 and mp <= 7810000 then
				req = 1528000000
			end
			if mp > 7810000 and mp <= 7820000 then
				req = 1530000000
			end
			if mp > 7820000 and mp <= 7830000 then
				req = 1532000000
			end
			if mp > 7830000 and mp <= 7840000 then
				req = 1534000000
			end
			if mp > 7840000 and mp <= 7850000 then
				req = 1536000000
			end
			if mp > 7850000 and mp <= 7860000 then
				req = 1538000000
			end
			if mp > 7860000 and mp <= 7870000 then
				req = 1540000000
			end
			if mp > 7870000 and mp <= 7880000 then
				req = 1542000000
			end
			if mp > 7880000 and mp <= 7890000 then
				req = 1544000000
			end
			if mp > 7890000 and mp <= 7900000 then
				req = 1546000000
			end
			if mp > 7900000 and mp <= 7910000 then
				req = 1548000000
			end
			if mp > 7910000 and mp <= 7920000 then
				req = 1550000000
			end
			if mp > 7920000 and mp <= 7930000 then
				req = 1552000000
			end
			if mp > 7930000 and mp <= 7940000 then
				req = 1554000000
			end
			if mp > 7940000 and mp <= 7950000 then
				req = 1556000000
			end
			if mp > 7950000 and mp <= 7960000 then
				req = 1558000000
			end
			if mp > 7960000 and mp <= 7970000 then
				req = 1560000000
			end
			if mp > 7970000 and mp <= 7980000 then
				req = 1562000000
			end
			if mp > 7980000 and mp <= 7990000 then
				req = 1564000000
			end
			if mp > 7990000 and mp <= 8000000 then
				req = 1566000000
			end
			if mp > 8000000 and mp <= 8010000 then
				req = 1568000000
			end
			if mp > 8010000 and mp <= 8020000 then
				req = 1570000000
			end
			if mp > 8020000 and mp <= 8030000 then
				req = 1572000000
			end
			if mp > 8030000 and mp <= 8040000 then
				req = 1574000000
			end
			if mp > 8040000 and mp <= 8050000 then
				req = 1576000000
			end
			if mp > 8050000 and mp <= 8060000 then
				req = 1578000000
			end
			if mp > 8060000 and mp <= 8070000 then
				req = 1580000000
			end
			if mp > 8070000 and mp <= 8080000 then
				req = 1582000000
			end
			if mp > 8080000 and mp <= 8090000 then
				req = 1584000000
			end
			if mp > 8090000 and mp <= 8100000 then
				req = 1586000000
			end
			if mp > 8100000 and mp <= 8110000 then
				req = 1588000000
			end
			if mp > 8110000 and mp <= 8120000 then
				req = 1590000000
			end
			if mp > 8120000 and mp <= 8130000 then
				req = 1592000000
			end
			if mp > 8130000 and mp <= 8140000 then
				req = 1594000000
			end
			if mp > 8140000 and mp <= 8150000 then
				req = 1596000000
			end
			if mp > 8150000 and mp <= 8160000 then
				req = 1598000000
			end
			if mp > 8160000 and mp <= 8170000 then
				req = 1600000000
			end
			if mp > 8170000 and mp <= 8180000 then
				req = 1602000000
			end
			if mp > 8180000 and mp <= 8190000 then
				req = 1604000000
			end
			if mp > 8190000 and mp <= 8200000 then
				req = 1606000000
			end
			if mp > 8200000 and mp <= 8210000 then
				req = 1608000000
			end
			if mp > 8210000 and mp <= 8220000 then
				req = 1610000000
			end
			if mp > 8220000 and mp <= 8230000 then
				req = 1612000000
			end
			if mp > 8230000 and mp <= 8240000 then
				req = 1614000000
			end
			if mp > 8240000 and mp <= 8250000 then
				req = 1616000000
			end
			if mp > 8250000 and mp <= 8260000 then
				req = 1618000000
			end
			if mp > 8260000 and mp <= 8270000 then
				req = 1620000000
			end
			if mp > 8270000 and mp <= 8280000 then
				req = 1622000000
			end
			if mp > 8280000 and mp <= 8290000 then
				req = 1624000000
			end
			if mp > 8290000 and mp <= 8300000 then
				req = 1626000000
			end
			if mp > 8300000 and mp <= 8310000 then
				req = 1628000000
			end
			if mp > 8310000 and mp <= 8320000 then
				req = 1630000000
			end
			if mp > 8320000 and mp <= 8330000 then
				req = 1632000000
			end
			if mp > 8330000 and mp <= 8340000 then
				req = 1634000000
			end
			if mp > 8340000 and mp <= 8350000 then
				req = 1636000000
			end
			if mp > 8350000 and mp <= 8360000 then
				req = 1638000000
			end
			if mp > 8360000 and mp <= 8370000 then
				req = 1640000000
			end
			if mp > 8370000 and mp <= 8380000 then
				req = 1642000000
			end
			if mp > 8380000 and mp <= 8390000 then
				req = 1644000000
			end
			if mp > 8390000 and mp <= 8400000 then
				req = 1646000000
			end
			if mp > 8400000 and mp <= 8410000 then
				req = 1648000000
			end
			if mp > 8410000 and mp <= 8420000 then
				req = 1650000000
			end
			if mp > 8420000 and mp <= 8430000 then
				req = 1652000000
			end
			if mp > 8430000 and mp <= 8440000 then
				req = 1654000000
			end
			if mp > 8440000 and mp <= 8450000 then
				req = 1656000000
			end
			if mp > 8450000 and mp <= 8460000 then
				req = 1658000000
			end
			if mp > 8460000 and mp <= 8470000 then
				req = 1660000000
			end
			if mp > 8470000 and mp <= 8480000 then
				req = 1662000000
			end
			if mp > 8480000 and mp <= 8490000 then
				req = 1664000000
			end
			if mp > 8490000 and mp <= 8500000 then
				req = 1666000000
			end
			if mp > 8500000 and mp <= 8510000 then
				req = 1668000000
			end
			if mp > 8510000 and mp <= 8520000 then
				req = 1670000000
			end
			if mp > 8520000 and mp <= 8530000 then
				req = 1672000000
			end
			if mp > 8530000 and mp <= 8540000 then
				req = 1674000000
			end
			if mp > 8540000 and mp <= 8550000 then
				req = 1676000000
			end
			if mp > 8550000 and mp <= 8560000 then
				req = 1678000000
			end
			if mp > 8560000 and mp <= 8570000 then
				req = 1680000000
			end
			if mp > 8570000 and mp <= 8580000 then
				req = 1682000000
			end
			if mp > 8580000 and mp <= 8590000 then
				req = 1684000000
			end
			if mp > 8590000 and mp <= 8600000 then
				req = 1686000000
			end
			if mp > 8600000 and mp <= 8610000 then
				req = 1688000000
			end
			if mp > 8610000 and mp <= 8620000 then
				req = 1690000000
			end
			if mp > 8620000 and mp <= 8630000 then
				req = 1692000000
			end
			if mp > 8630000 and mp <= 8640000 then
				req = 1694000000
			end
			if mp > 8640000 and mp <= 8650000 then
				req = 1696000000
			end
			if mp > 8650000 and mp <= 8660000 then
				req = 1698000000
			end
			if mp > 8660000 and mp <= 8670000 then
				req = 1700000000
			end
			if mp > 8670000 and mp <= 8680000 then
				req = 1702000000
			end
			if mp > 8680000 and mp <= 8690000 then
				req = 1704000000
			end
			if mp > 8690000 and mp <= 8700000 then
				req = 1706000000
			end
			if mp > 8700000 and mp <= 8710000 then
				req = 1708000000
			end
			if mp > 8710000 and mp <= 8720000 then
				req = 1710000000
			end
			if mp > 8720000 and mp <= 8730000 then
				req = 1712000000
			end
			if mp > 8730000 and mp <= 8740000 then
				req = 1714000000
			end
			if mp > 8740000 and mp <= 8750000 then
				req = 1716000000
			end
			if mp > 8750000 and mp <= 8760000 then
				req = 1718000000
			end
			if mp > 8760000 and mp <= 8770000 then
				req = 1720000000
			end
			if mp > 8770000 and mp <= 8780000 then
				req = 1722000000
			end
			if mp > 8780000 and mp <= 8790000 then
				req = 1724000000
			end
			if mp > 8790000 and mp <= 8800000 then
				req = 1726000000
			end
			if mp > 8800000 and mp <= 8810000 then
				req = 1728000000
			end
			if mp > 8810000 and mp <= 8820000 then
				req = 1730000000
			end
			if mp > 8820000 and mp <= 8830000 then
				req = 1732000000
			end
			if mp > 8830000 and mp <= 8840000 then
				req = 1734000000
			end
			if mp > 8840000 and mp <= 8850000 then
				req = 1736000000
			end
			if mp > 8850000 and mp <= 8860000 then
				req = 1738000000
			end
			if mp > 8860000 and mp <= 8870000 then
				req = 1740000000
			end
			if mp > 8870000 and mp <= 8880000 then
				req = 1742000000
			end
			if mp > 8880000 and mp <= 8890000 then
				req = 1744000000
			end
			if mp > 8890000 and mp <= 8900000 then
				req = 1746000000
			end
			if mp > 8900000 and mp <= 8910000 then
				req = 1748000000
			end
			if mp > 8910000 and mp <= 8920000 then
				req = 1750000000
			end
			if mp > 8920000 and mp <= 8930000 then
				req = 1752000000
			end
			if mp > 8930000 and mp <= 8940000 then
				req = 1754000000
			end
			if mp > 8940000 and mp <= 8950000 then
				req = 1756000000
			end
			if mp > 8950000 and mp <= 8960000 then
				req = 1758000000
			end
			if mp > 8960000 and mp <= 8970000 then
				req = 1760000000
			end
			if mp > 8970000 and mp <= 8980000 then
				req = 1762000000
			end
			if mp > 8980000 and mp <= 8990000 then
				req = 1764000000
			end
			if mp > 8990000 and mp <= 9000000 then
				req = 1766000000
			end
			if mp > 9000000 and mp <= 9010000 then
				req = 1768000000
			end
			if mp > 9010000 and mp <= 9020000 then
				req = 1770000000
			end
			if mp > 9020000 and mp <= 9030000 then
				req = 1772000000
			end
			if mp > 9030000 and mp <= 9040000 then
				req = 1774000000
			end
			if mp > 9040000 and mp <= 9050000 then
				req = 1776000000
			end
			if mp > 9050000 and mp <= 9060000 then
				req = 1778000000
			end
			if mp > 9060000 and mp <= 9070000 then
				req = 1780000000
			end
			if mp > 9070000 and mp <= 9080000 then
				req = 1782000000
			end
			if mp > 9080000 and mp <= 9090000 then
				req = 1784000000
			end
			if mp > 9090000 and mp <= 9100000 then
				req = 1786000000
			end
			if mp > 9100000 and mp <= 9110000 then
				req = 1788000000
			end
			if mp > 9110000 and mp <= 9120000 then
				req = 1790000000
			end
			if mp > 9120000 and mp <= 9130000 then
				req = 1792000000
			end
			if mp > 9130000 and mp <= 9140000 then
				req = 1794000000
			end
			if mp > 9140000 and mp <= 9150000 then
				req = 1796000000
			end
			if mp > 9150000 and mp <= 9160000 then
				req = 1798000000
			end
			if mp > 9160000 and mp <= 9170000 then
				req = 1800000000
			end
			if mp > 9170000 and mp <= 9180000 then
				req = 1802000000
			end
			if mp > 9180000 and mp <= 9190000 then
				req = 1804000000
			end
			if mp > 9190000 and mp <= 9200000 then
				req = 1806000000
			end
			if mp > 9200000 and mp <= 9210000 then
				req = 1808000000
			end
			if mp > 9210000 and mp <= 9220000 then
				req = 1810000000
			end
			if mp > 9220000 and mp <= 9230000 then
				req = 1812000000
			end
			if mp > 9230000 and mp <= 9240000 then
				req = 1814000000
			end
			if mp > 9240000 and mp <= 9250000 then
				req = 1816000000
			end
			if mp > 9250000 and mp <= 9260000 then
				req = 1818000000
			end
			if mp > 9260000 and mp <= 9270000 then
				req = 1820000000
			end
			if mp > 9270000 and mp <= 9280000 then
				req = 1822000000
			end
			if mp > 9280000 and mp <= 9290000 then
				req = 1824000000
			end
			if mp > 9290000 and mp <= 9300000 then
				req = 1826000000
			end
			if mp > 9300000 and mp <= 9310000 then
				req = 1828000000
			end
			if mp > 9310000 and mp <= 9320000 then
				req = 1830000000
			end
			if mp > 9320000 and mp <= 9330000 then
				req = 1832000000
			end
			if mp > 9330000 and mp <= 9340000 then
				req = 1834000000
			end
			if mp > 9340000 and mp <= 9350000 then
				req = 1836000000
			end
			if mp > 9350000 and mp <= 9360000 then
				req = 1838000000
			end
			if mp > 9360000 and mp <= 9370000 then
				req = 1840000000
			end
			if mp > 9370000 and mp <= 9380000 then
				req = 1842000000
			end
			if mp > 9380000 and mp <= 9390000 then
				req = 1844000000
			end
			if mp > 9390000 and mp <= 9400000 then
				req = 1846000000
			end
			if mp > 9400000 and mp <= 9410000 then
				req = 1848000000
			end
			if mp > 9410000 and mp <= 9420000 then
				req = 1850000000
			end
			if mp > 9420000 and mp <= 9430000 then
				req = 1852000000
			end
			if mp > 9430000 and mp <= 9440000 then
				req = 1854000000
			end
			if mp > 9440000 and mp <= 9450000 then
				req = 1856000000
			end
			if mp > 9450000 and mp <= 9460000 then
				req = 1858000000
			end
			if mp > 9460000 and mp <= 9470000 then
				req = 1860000000
			end
			if mp > 9470000 and mp <= 9480000 then
				req = 1862000000
			end
			if mp > 9480000 and mp <= 9490000 then
				req = 1864000000
			end
			if mp > 9490000 and mp <= 9500000 then
				req = 1866000000
			end
			if mp > 9500000 and mp <= 9510000 then
				req = 1868000000
			end
			if mp > 9510000 and mp <= 9520000 then
				req = 1870000000
			end
			if mp > 9520000 and mp <= 9530000 then
				req = 1872000000
			end
			if mp > 9530000 and mp <= 9540000 then
				req = 1874000000
			end
			if mp > 9540000 and mp <= 9550000 then
				req = 1876000000
			end
			if mp > 9550000 and mp <= 9560000 then
				req = 1878000000
			end
			if mp > 9560000 and mp <= 9570000 then
				req = 1880000000
			end
			if mp > 9570000 and mp <= 9580000 then
				req = 1882000000
			end
			if mp > 9580000 and mp <= 9590000 then
				req = 1884000000
			end
			if mp > 9590000 and mp <= 9600000 then
				req = 1886000000
			end
			if mp > 9600000 and mp <= 9610000 then
				req = 1888000000
			end
			if mp > 9610000 and mp <= 9620000 then
				req = 1890000000
			end
			if mp > 9620000 and mp <= 9630000 then
				req = 1892000000
			end
			if mp > 9630000 and mp <= 9640000 then
				req = 1894000000
			end
			if mp > 9640000 and mp <= 9650000 then
				req = 1896000000
			end
			if mp > 9650000 and mp <= 9660000 then
				req = 1898000000
			end
			if mp > 9660000 and mp <= 9670000 then
				req = 1900000000
			end
			if mp > 9670000 and mp <= 9680000 then
				req = 1902000000
			end
			if mp > 9680000 and mp <= 9690000 then
				req = 1904000000
			end
			if mp > 9690000 and mp <= 9700000 then
				req = 1906000000
			end
			if mp > 9700000 and mp <= 9710000 then
				req = 1908000000
			end
			if mp > 9710000 and mp <= 9720000 then
				req = 1910000000
			end
			if mp > 9720000 and mp <= 9730000 then
				req = 1912000000
			end
			if mp > 9730000 and mp <= 9740000 then
				req = 1914000000
			end
			if mp > 9740000 and mp <= 9750000 then
				req = 1916000000
			end
			if mp > 9750000 and mp <= 9760000 then
				req = 1918000000
			end
			if mp > 9760000 and mp <= 9770000 then
				req = 1920000000
			end
			if mp > 9770000 and mp <= 9780000 then
				req = 1922000000
			end
			if mp > 9780000 and mp <= 9790000 then
				req = 1924000000
			end
			if mp > 9790000 and mp <= 9800000 then
				req = 1926000000
			end
			if mp > 9800000 and mp <= 9810000 then
				req = 1928000000
			end
			if mp > 9810000 and mp <= 9820000 then
				req = 1930000000
			end
			if mp > 9820000 and mp <= 9830000 then
				req = 1932000000
			end
			if mp > 9830000 and mp <= 9840000 then
				req = 1934000000
			end
			if mp > 9840000 and mp <= 9850000 then
				req = 1936000000
			end
			if mp > 9850000 and mp <= 9860000 then
				req = 1938000000
			end
			if mp > 9860000 and mp <= 9870000 then
				req = 1940000000
			end
			if mp > 9870000 and mp <= 9880000 then
				req = 1942000000
			end
			if mp > 9880000 and mp <= 9890000 then
				req = 1944000000
			end
			if mp > 9890000 and mp <= 9900000 then
				req = 1946000000
			end
			if mp > 9900000 and mp <= 9910000 then
				req = 1948000000
			end
			if mp > 9910000 and mp <= 9920000 then
				req = 1950000000
			end
			if mp > 9920000 and mp <= 9930000 then
				req = 1952000000
			end
			if mp > 9930000 and mp <= 9940000 then
				req = 1954000000
			end
			if mp > 9940000 and mp <= 9950000 then
				req = 1956000000
			end
			if mp > 9950000 and mp <= 9960000 then
				req = 1958000000
			end
			if mp > 9960000 and mp <= 9970000 then
				req = 1960000000
			end
			if mp > 9970000 and mp <= 9980000 then
				req = 1962000000
			end
			if mp > 9980000 and mp <= 9990000 then
				req = 1964000000
			end
			if mp > 9990000 and mp <= 10000000 then
				req = 1966000000
			end
			if mp > 10000000 and mp <= 10010000 then
				req = 1968000000
			end
		elseif job == 2 then -- Scoundrel
			if mp <= 20000 then
				req = 10000000
			end
			if mp > 20000 and mp <= 30000 then
				req = 12000000
			end
			if mp > 30000 and mp <= 40000 then
				req = 14000000
			end
			if mp > 40000 and mp <= 50000 then
				req = 16000000
			end
			if mp > 50000 and mp <= 60000 then
				req = 18000000
			end
			if mp > 60000 and mp <= 70000 then
				req = 20000000
			end
			if mp > 70000 and mp <= 80000 then
				req = 22000000
			end
			if mp > 80000 and mp <= 90000 then
				req = 24000000
			end
			if mp > 90000 and mp <= 100000 then
				req = 26000000
			end
			if mp > 100000 and mp <= 110000 then
				req = 28000000
			end
			if mp > 110000 and mp <= 120000 then
				req = 30000000
			end
			if mp > 120000 and mp <= 130000 then
				req = 32000000
			end
			if mp > 130000 and mp <= 140000 then
				req = 34000000
			end
			if mp > 140000 and mp <= 150000 then
				req = 36000000
			end
			if mp > 150000 and mp <= 160000 then
				req = 38000000
			end
			if mp > 160000 and mp <= 170000 then
				req = 40000000
			end
			if mp > 170000 and mp <= 180000 then
				req = 42000000
			end
			if mp > 180000 and mp <= 190000 then
				req = 44000000
			end
			if mp > 190000 and mp <= 200000 then
				req = 46000000
			end
			if mp > 200000 and mp <= 210000 then
				req = 48000000
			end
			if mp > 210000 and mp <= 220000 then
				req = 50000000
			end
			if mp > 220000 and mp <= 230000 then
				req = 52000000
			end
			if mp > 230000 and mp <= 240000 then
				req = 54000000
			end
			if mp > 240000 and mp <= 250000 then
				req = 56000000
			end
			if mp > 250000 and mp <= 260000 then
				req = 58000000
			end
			if mp > 260000 and mp <= 270000 then
				req = 60000000
			end
			if mp > 270000 and mp <= 280000 then
				req = 62000000
			end
			if mp > 280000 and mp <= 290000 then
				req = 64000000
			end
			if mp > 290000 and mp <= 300000 then
				req = 66000000
			end
			if mp > 300000 and mp <= 310000 then
				req = 68000000
			end
			if mp > 310000 and mp <= 320000 then
				req = 70000000
			end
			if mp > 320000 and mp <= 330000 then
				req = 72000000
			end
			if mp > 330000 and mp <= 340000 then
				req = 74000000
			end
			if mp > 340000 and mp <= 350000 then
				req = 76000000
			end
			if mp > 350000 and mp <= 360000 then
				req = 78000000
			end
			if mp > 360000 and mp <= 370000 then
				req = 80000000
			end
			if mp > 370000 and mp <= 380000 then
				req = 82000000
			end
			if mp > 380000 and mp <= 390000 then
				req = 84000000
			end
			if mp > 390000 and mp <= 400000 then
				req = 86000000
			end
			if mp > 400000 and mp <= 410000 then
				req = 88000000
			end
			if mp > 410000 and mp <= 420000 then
				req = 90000000
			end
			if mp > 420000 and mp <= 430000 then
				req = 92000000
			end
			if mp > 430000 and mp <= 440000 then
				req = 94000000
			end
			if mp > 440000 and mp <= 450000 then
				req = 96000000
			end
			if mp > 450000 and mp <= 460000 then
				req = 98000000
			end
			if mp > 460000 and mp <= 470000 then
				req = 100000000
			end
			if mp > 470000 and mp <= 480000 then
				req = 102000000
			end
			if mp > 480000 and mp <= 490000 then
				req = 104000000
			end
			if mp > 490000 and mp <= 500000 then
				req = 106000000
			end
			if mp > 500000 and mp <= 510000 then
				req = 108000000
			end
			if mp > 510000 and mp <= 520000 then
				req = 110000000
			end
			if mp > 520000 and mp <= 530000 then
				req = 112000000
			end
			if mp > 530000 and mp <= 540000 then
				req = 114000000
			end
			if mp > 540000 and mp <= 550000 then
				req = 116000000
			end
			if mp > 550000 and mp <= 560000 then
				req = 118000000
			end
			if mp > 560000 and mp <= 570000 then
				req = 120000000
			end
			if mp > 570000 and mp <= 580000 then
				req = 122000000
			end
			if mp > 580000 and mp <= 590000 then
				req = 124000000
			end
			if mp > 590000 and mp <= 600000 then
				req = 126000000
			end
			if mp > 600000 and mp <= 610000 then
				req = 128000000
			end
			if mp > 610000 and mp <= 620000 then
				req = 130000000
			end
			if mp > 620000 and mp <= 630000 then
				req = 132000000
			end
			if mp > 630000 and mp <= 640000 then
				req = 134000000
			end
			if mp > 640000 and mp <= 650000 then
				req = 136000000
			end
			if mp > 650000 and mp <= 660000 then
				req = 138000000
			end
			if mp > 660000 and mp <= 670000 then
				req = 140000000
			end
			if mp > 670000 and mp <= 680000 then
				req = 142000000
			end
			if mp > 680000 and mp <= 690000 then
				req = 144000000
			end
			if mp > 690000 and mp <= 700000 then
				req = 146000000
			end
			if mp > 700000 and mp <= 710000 then
				req = 148000000
			end
			if mp > 710000 and mp <= 720000 then
				req = 150000000
			end
			if mp > 720000 and mp <= 730000 then
				req = 152000000
			end
			if mp > 730000 and mp <= 740000 then
				req = 154000000
			end
			if mp > 740000 and mp <= 750000 then
				req = 156000000
			end
			if mp > 750000 and mp <= 760000 then
				req = 158000000
			end
			if mp > 760000 and mp <= 770000 then
				req = 160000000
			end
			if mp > 770000 and mp <= 780000 then
				req = 162000000
			end
			if mp > 780000 and mp <= 790000 then
				req = 164000000
			end
			if mp > 790000 and mp <= 800000 then
				req = 166000000
			end
			if mp > 800000 and mp <= 810000 then
				req = 168000000
			end
			if mp > 810000 and mp <= 820000 then
				req = 170000000
			end
			if mp > 820000 and mp <= 830000 then
				req = 172000000
			end
			if mp > 830000 and mp <= 840000 then
				req = 174000000
			end
			if mp > 840000 and mp <= 850000 then
				req = 176000000
			end
			if mp > 850000 and mp <= 860000 then
				req = 178000000
			end
			if mp > 860000 and mp <= 870000 then
				req = 180000000
			end
			if mp > 870000 and mp <= 880000 then
				req = 182000000
			end
			if mp > 880000 and mp <= 890000 then
				req = 184000000
			end
			if mp > 890000 and mp <= 900000 then
				req = 186000000
			end
			if mp > 900000 and mp <= 910000 then
				req = 188000000
			end
			if mp > 910000 and mp <= 920000 then
				req = 190000000
			end
			if mp > 920000 and mp <= 930000 then
				req = 192000000
			end
			if mp > 930000 and mp <= 940000 then
				req = 194000000
			end
			if mp > 940000 and mp <= 950000 then
				req = 196000000
			end
			if mp > 950000 and mp <= 960000 then
				req = 198000000
			end
			if mp > 960000 and mp <= 970000 then
				req = 200000000
			end
			if mp > 970000 and mp <= 980000 then
				req = 202000000
			end
			if mp > 980000 and mp <= 990000 then
				req = 204000000
			end
			if mp > 990000 and mp <= 1000000 then
				req = 206000000
			end
			if mp > 1000000 and mp <= 1010000 then
				req = 208000000
			end
			if mp > 1010000 and mp <= 1020000 then
				req = 210000000
			end
			if mp > 1020000 and mp <= 1030000 then
				req = 212000000
			end
			if mp > 1030000 and mp <= 1040000 then
				req = 214000000
			end
			if mp > 1040000 and mp <= 1050000 then
				req = 216000000
			end
			if mp > 1050000 and mp <= 1060000 then
				req = 218000000
			end
			if mp > 1060000 and mp <= 1070000 then
				req = 220000000
			end
			if mp > 1070000 and mp <= 1080000 then
				req = 222000000
			end
			if mp > 1080000 and mp <= 1090000 then
				req = 224000000
			end
			if mp > 1090000 and mp <= 1100000 then
				req = 226000000
			end
			if mp > 1100000 and mp <= 1110000 then
				req = 228000000
			end
			if mp > 1110000 and mp <= 1120000 then
				req = 230000000
			end
			if mp > 1120000 and mp <= 1130000 then
				req = 232000000
			end
			if mp > 1130000 and mp <= 1140000 then
				req = 234000000
			end
			if mp > 1140000 and mp <= 1150000 then
				req = 236000000
			end
			if mp > 1150000 and mp <= 1160000 then
				req = 238000000
			end
			if mp > 1160000 and mp <= 1170000 then
				req = 240000000
			end
			if mp > 1170000 and mp <= 1180000 then
				req = 242000000
			end
			if mp > 1180000 and mp <= 1190000 then
				req = 244000000
			end
			if mp > 1190000 and mp <= 1200000 then
				req = 246000000
			end
			if mp > 1200000 and mp <= 1210000 then
				req = 248000000
			end
			if mp > 1210000 and mp <= 1220000 then
				req = 250000000
			end
			if mp > 1220000 and mp <= 1230000 then
				req = 252000000
			end
			if mp > 1230000 and mp <= 1240000 then
				req = 254000000
			end
			if mp > 1240000 and mp <= 1250000 then
				req = 256000000
			end
			if mp > 1250000 and mp <= 1260000 then
				req = 258000000
			end
			if mp > 1260000 and mp <= 1270000 then
				req = 260000000
			end
			if mp > 1270000 and mp <= 1280000 then
				req = 262000000
			end
			if mp > 1280000 and mp <= 1290000 then
				req = 264000000
			end
			if mp > 1290000 and mp <= 1300000 then
				req = 266000000
			end
			if mp > 1300000 and mp <= 1310000 then
				req = 268000000
			end
			if mp > 1310000 and mp <= 1320000 then
				req = 270000000
			end
			if mp > 1320000 and mp <= 1330000 then
				req = 272000000
			end
			if mp > 1330000 and mp <= 1340000 then
				req = 274000000
			end
			if mp > 1340000 and mp <= 1350000 then
				req = 276000000
			end
			if mp > 1350000 and mp <= 1360000 then
				req = 278000000
			end
			if mp > 1360000 and mp <= 1370000 then
				req = 280000000
			end
			if mp > 1370000 and mp <= 1380000 then
				req = 282000000
			end
			if mp > 1380000 and mp <= 1390000 then
				req = 284000000
			end
			if mp > 1390000 and mp <= 1400000 then
				req = 286000000
			end
			if mp > 1400000 and mp <= 1410000 then
				req = 288000000
			end
			if mp > 1410000 and mp <= 1420000 then
				req = 290000000
			end
			if mp > 1420000 and mp <= 1430000 then
				req = 292000000
			end
			if mp > 1430000 and mp <= 1440000 then
				req = 294000000
			end
			if mp > 1440000 and mp <= 1450000 then
				req = 296000000
			end
			if mp > 1450000 and mp <= 1460000 then
				req = 298000000
			end
			if mp > 1460000 and mp <= 1470000 then
				req = 300000000
			end
			if mp > 1470000 and mp <= 1480000 then
				req = 302000000
			end
			if mp > 1480000 and mp <= 1490000 then
				req = 304000000
			end
			if mp > 1490000 and mp <= 1500000 then
				req = 306000000
			end
			if mp > 1500000 and mp <= 1510000 then
				req = 308000000
			end
			if mp > 1510000 and mp <= 1520000 then
				req = 310000000
			end
			if mp > 1520000 and mp <= 1530000 then
				req = 312000000
			end
			if mp > 1530000 and mp <= 1540000 then
				req = 314000000
			end
			if mp > 1540000 and mp <= 1550000 then
				req = 316000000
			end
			if mp > 1550000 and mp <= 1560000 then
				req = 318000000
			end
			if mp > 1560000 and mp <= 1570000 then
				req = 320000000
			end
			if mp > 1570000 and mp <= 1580000 then
				req = 322000000
			end
			if mp > 1580000 and mp <= 1590000 then
				req = 324000000
			end
			if mp > 1590000 and mp <= 1600000 then
				req = 326000000
			end
			if mp > 1600000 and mp <= 1610000 then
				req = 328000000
			end
			if mp > 1610000 and mp <= 1620000 then
				req = 330000000
			end
			if mp > 1620000 and mp <= 1630000 then
				req = 332000000
			end
			if mp > 1630000 and mp <= 1640000 then
				req = 334000000
			end
			if mp > 1640000 and mp <= 1650000 then
				req = 336000000
			end
			if mp > 1650000 and mp <= 1660000 then
				req = 338000000
			end
			if mp > 1660000 and mp <= 1670000 then
				req = 340000000
			end
			if mp > 1670000 and mp <= 1680000 then
				req = 342000000
			end
			if mp > 1680000 and mp <= 1690000 then
				req = 344000000
			end
			if mp > 1690000 and mp <= 1700000 then
				req = 346000000
			end
			if mp > 1700000 and mp <= 1710000 then
				req = 348000000
			end
			if mp > 1710000 and mp <= 1720000 then
				req = 350000000
			end
			if mp > 1720000 and mp <= 1730000 then
				req = 352000000
			end
			if mp > 1730000 and mp <= 1740000 then
				req = 354000000
			end
			if mp > 1740000 and mp <= 1750000 then
				req = 356000000
			end
			if mp > 1750000 and mp <= 1760000 then
				req = 358000000
			end
			if mp > 1760000 and mp <= 1770000 then
				req = 360000000
			end
			if mp > 1770000 and mp <= 1780000 then
				req = 362000000
			end
			if mp > 1780000 and mp <= 1790000 then
				req = 364000000
			end
			if mp > 1790000 and mp <= 1800000 then
				req = 366000000
			end
			if mp > 1800000 and mp <= 1810000 then
				req = 368000000
			end
			if mp > 1810000 and mp <= 1820000 then
				req = 370000000
			end
			if mp > 1820000 and mp <= 1830000 then
				req = 372000000
			end
			if mp > 1830000 and mp <= 1840000 then
				req = 374000000
			end
			if mp > 1840000 and mp <= 1850000 then
				req = 376000000
			end
			if mp > 1850000 and mp <= 1860000 then
				req = 378000000
			end
			if mp > 1860000 and mp <= 1870000 then
				req = 380000000
			end
			if mp > 1870000 and mp <= 1880000 then
				req = 382000000
			end
			if mp > 1880000 and mp <= 1890000 then
				req = 384000000
			end
			if mp > 1890000 and mp <= 1900000 then
				req = 386000000
			end
			if mp > 1900000 and mp <= 1910000 then
				req = 388000000
			end
			if mp > 1910000 and mp <= 1920000 then
				req = 390000000
			end
			if mp > 1920000 and mp <= 1930000 then
				req = 392000000
			end
			if mp > 1930000 and mp <= 1940000 then
				req = 394000000
			end
			if mp > 1940000 and mp <= 1950000 then
				req = 396000000
			end
			if mp > 1950000 and mp <= 1960000 then
				req = 398000000
			end
			if mp > 1960000 and mp <= 1970000 then
				req = 400000000
			end
			if mp > 1970000 and mp <= 1980000 then
				req = 402000000
			end
			if mp > 1980000 and mp <= 1990000 then
				req = 404000000
			end
			if mp > 1990000 and mp <= 2000000 then
				req = 406000000
			end
			if mp > 2000000 and mp <= 2010000 then
				req = 408000000
			end
			if mp > 2010000 and mp <= 2020000 then
				req = 410000000
			end
			if mp > 2020000 and mp <= 2030000 then
				req = 412000000
			end
			if mp > 2030000 and mp <= 2040000 then
				req = 414000000
			end
			if mp > 2040000 and mp <= 2050000 then
				req = 416000000
			end
			if mp > 2050000 and mp <= 2060000 then
				req = 418000000
			end
			if mp > 2060000 and mp <= 2070000 then
				req = 420000000
			end
			if mp > 2070000 and mp <= 2080000 then
				req = 422000000
			end
			if mp > 2080000 and mp <= 2090000 then
				req = 424000000
			end
			if mp > 2090000 and mp <= 2100000 then
				req = 426000000
			end
			if mp > 2100000 and mp <= 2110000 then
				req = 428000000
			end
			if mp > 2110000 and mp <= 2120000 then
				req = 430000000
			end
			if mp > 2120000 and mp <= 2130000 then
				req = 432000000
			end
			if mp > 2130000 and mp <= 2140000 then
				req = 434000000
			end
			if mp > 2140000 and mp <= 2150000 then
				req = 436000000
			end
			if mp > 2150000 and mp <= 2160000 then
				req = 438000000
			end
			if mp > 2160000 and mp <= 2170000 then
				req = 440000000
			end
			if mp > 2170000 and mp <= 2180000 then
				req = 442000000
			end
			if mp > 2180000 and mp <= 2190000 then
				req = 444000000
			end
			if mp > 2190000 and mp <= 2200000 then
				req = 446000000
			end
			if mp > 2200000 and mp <= 2210000 then
				req = 448000000
			end
			if mp > 2210000 and mp <= 2220000 then
				req = 450000000
			end
			if mp > 2220000 and mp <= 2230000 then
				req = 452000000
			end
			if mp > 2230000 and mp <= 2240000 then
				req = 454000000
			end
			if mp > 2240000 and mp <= 2250000 then
				req = 456000000
			end
			if mp > 2250000 and mp <= 2260000 then
				req = 458000000
			end
			if mp > 2260000 and mp <= 2270000 then
				req = 460000000
			end
			if mp > 2270000 and mp <= 2280000 then
				req = 462000000
			end
			if mp > 2280000 and mp <= 2290000 then
				req = 464000000
			end
			if mp > 2290000 and mp <= 2300000 then
				req = 466000000
			end
			if mp > 2300000 and mp <= 2310000 then
				req = 468000000
			end
			if mp > 2310000 and mp <= 2320000 then
				req = 470000000
			end
			if mp > 2320000 and mp <= 2330000 then
				req = 472000000
			end
			if mp > 2330000 and mp <= 2340000 then
				req = 474000000
			end
			if mp > 2340000 and mp <= 2350000 then
				req = 476000000
			end
			if mp > 2350000 and mp <= 2360000 then
				req = 478000000
			end
			if mp > 2360000 and mp <= 2370000 then
				req = 480000000
			end
			if mp > 2370000 and mp <= 2380000 then
				req = 482000000
			end
			if mp > 2380000 and mp <= 2390000 then
				req = 484000000
			end
			if mp > 2390000 and mp <= 2400000 then
				req = 486000000
			end
			if mp > 2400000 and mp <= 2410000 then
				req = 488000000
			end
			if mp > 2410000 and mp <= 2420000 then
				req = 490000000
			end
			if mp > 2420000 and mp <= 2430000 then
				req = 492000000
			end
			if mp > 2430000 and mp <= 2440000 then
				req = 494000000
			end
			if mp > 2440000 and mp <= 2450000 then
				req = 496000000
			end
			if mp > 2450000 and mp <= 2460000 then
				req = 498000000
			end
			if mp > 2460000 and mp <= 2470000 then
				req = 500000000
			end
			if mp > 2470000 and mp <= 2480000 then
				req = 502000000
			end
			if mp > 2480000 and mp <= 2490000 then
				req = 504000000
			end
			if mp > 2490000 and mp <= 2500000 then
				req = 506000000
			end
			if mp > 2500000 and mp <= 2510000 then
				req = 508000000
			end
			if mp > 2510000 and mp <= 2520000 then
				req = 510000000
			end
			if mp > 2520000 and mp <= 2530000 then
				req = 512000000
			end
			if mp > 2530000 and mp <= 2540000 then
				req = 514000000
			end
			if mp > 2540000 and mp <= 2550000 then
				req = 516000000
			end
			if mp > 2550000 and mp <= 2560000 then
				req = 518000000
			end
			if mp > 2560000 and mp <= 2570000 then
				req = 520000000
			end
			if mp > 2570000 and mp <= 2580000 then
				req = 522000000
			end
			if mp > 2580000 and mp <= 2590000 then
				req = 524000000
			end
			if mp > 2590000 and mp <= 2600000 then
				req = 526000000
			end
			if mp > 2600000 and mp <= 2610000 then
				req = 528000000
			end
			if mp > 2610000 and mp <= 2620000 then
				req = 490000000
			end
			if mp > 2620000 and mp <= 2630000 then
				req = 492000000
			end
			if mp > 2630000 and mp <= 2640000 then
				req = 494000000
			end
			if mp > 2640000 and mp <= 2650000 then
				req = 496000000
			end
			if mp > 2650000 and mp <= 2660000 then
				req = 498000000
			end
			if mp > 2660000 and mp <= 2670000 then
				req = 500000000
			end
			if mp > 2670000 and mp <= 2680000 then
				req = 502000000
			end
			if mp > 2680000 and mp <= 2690000 then
				req = 504000000
			end
			if mp > 2690000 and mp <= 2700000 then
				req = 506000000
			end
			if mp > 2700000 and mp <= 2710000 then
				req = 508000000
			end
			if mp > 2710000 and mp <= 2720000 then
				req = 510000000
			end
			if mp > 2720000 and mp <= 2730000 then
				req = 512000000
			end
			if mp > 2730000 and mp <= 2740000 then
				req = 514000000
			end
			if mp > 2740000 and mp <= 2750000 then
				req = 516000000
			end
			if mp > 2750000 and mp <= 2760000 then
				req = 518000000
			end
			if mp > 2760000 and mp <= 2770000 then
				req = 520000000
			end
			if mp > 2770000 and mp <= 2780000 then
				req = 522000000
			end
			if mp > 2780000 and mp <= 2790000 then
				req = 524000000
			end
			if mp > 2790000 and mp <= 2800000 then
				req = 526000000
			end
			if mp > 2800000 and mp <= 2810000 then
				req = 528000000
			end
			if mp > 2810000 and mp <= 2820000 then
				req = 530000000
			end
			if mp > 2820000 and mp <= 2830000 then
				req = 532000000
			end
			if mp > 2830000 and mp <= 2840000 then
				req = 534000000
			end
			if mp > 2840000 and mp <= 2850000 then
				req = 536000000
			end
			if mp > 2850000 and mp <= 2860000 then
				req = 538000000
			end
			if mp > 2860000 and mp <= 2870000 then
				req = 540000000
			end
			if mp > 2870000 and mp <= 2880000 then
				req = 542000000
			end
			if mp > 2880000 and mp <= 2890000 then
				req = 544000000
			end
			if mp > 2890000 and mp <= 2900000 then
				req = 546000000
			end
			if mp > 2900000 and mp <= 2910000 then
				req = 548000000
			end
			if mp > 2910000 and mp <= 2920000 then
				req = 550000000
			end
			if mp > 2920000 and mp <= 2930000 then
				req = 552000000
			end
			if mp > 2930000 and mp <= 2940000 then
				req = 554000000
			end
			if mp > 2940000 and mp <= 2950000 then
				req = 556000000
			end
			if mp > 2950000 and mp <= 2960000 then
				req = 558000000
			end
			if mp > 2960000 and mp <= 2970000 then
				req = 560000000
			end
			if mp > 2970000 and mp <= 2980000 then
				req = 562000000
			end
			if mp > 2980000 and mp <= 2990000 then
				req = 564000000
			end
			if mp > 2990000 and mp <= 3000000 then
				req = 566000000
			end
			if mp > 3000000 and mp <= 3010000 then
				req = 568000000
			end
			if mp > 3010000 and mp <= 3020000 then
				req = 570000000
			end
			if mp > 3020000 and mp <= 3030000 then
				req = 572000000
			end
			if mp > 3030000 and mp <= 3040000 then
				req = 574000000
			end
			if mp > 3040000 and mp <= 3050000 then
				req = 576000000
			end
			if mp > 3050000 and mp <= 3060000 then
				req = 578000000
			end
			if mp > 3060000 and mp <= 3070000 then
				req = 580000000
			end
			if mp > 3070000 and mp <= 3080000 then
				req = 582000000
			end
			if mp > 3080000 and mp <= 3090000 then
				req = 584000000
			end
			if mp > 3090000 and mp <= 3100000 then
				req = 586000000
			end
			if mp > 3100000 and mp <= 3110000 then
				req = 588000000
			end
			if mp > 3110000 and mp <= 3120000 then
				req = 590000000
			end
			if mp > 3120000 and mp <= 3130000 then
				req = 592000000
			end
			if mp > 3130000 and mp <= 3140000 then
				req = 594000000
			end
			if mp > 3140000 and mp <= 3150000 then
				req = 596000000
			end
			if mp > 3150000 and mp <= 3160000 then
				req = 598000000
			end
			if mp > 3160000 and mp <= 3170000 then
				req = 600000000
			end
			if mp > 3170000 and mp <= 3180000 then
				req = 602000000
			end
			if mp > 3180000 and mp <= 3190000 then
				req = 604000000
			end
			if mp > 3190000 and mp <= 3200000 then
				req = 606000000
			end
			if mp > 3200000 and mp <= 3210000 then
				req = 608000000
			end
			if mp > 3210000 and mp <= 3220000 then
				req = 610000000
			end
			if mp > 3220000 and mp <= 3230000 then
				req = 612000000
			end
			if mp > 3230000 and mp <= 3240000 then
				req = 614000000
			end
			if mp > 3240000 and mp <= 3250000 then
				req = 616000000
			end
			if mp > 3250000 and mp <= 3260000 then
				req = 618000000
			end
			if mp > 3260000 and mp <= 3270000 then
				req = 620000000
			end
			if mp > 3270000 and mp <= 3280000 then
				req = 622000000
			end
			if mp > 3280000 and mp <= 3290000 then
				req = 624000000
			end
			if mp > 3290000 and mp <= 3300000 then
				req = 626000000
			end
			if mp > 3300000 and mp <= 3310000 then
				req = 628000000
			end
			if mp > 3310000 and mp <= 3320000 then
				req = 630000000
			end
			if mp > 3320000 and mp <= 3330000 then
				req = 632000000
			end
			if mp > 3330000 and mp <= 3340000 then
				req = 634000000
			end
			if mp > 3340000 and mp <= 3350000 then
				req = 636000000
			end
			if mp > 3350000 and mp <= 3360000 then
				req = 638000000
			end
			if mp > 3360000 and mp <= 3370000 then
				req = 640000000
			end
			if mp > 3370000 and mp <= 3380000 then
				req = 642000000
			end
			if mp > 3380000 and mp <= 3390000 then
				req = 644000000
			end
			if mp > 3390000 and mp <= 3400000 then
				req = 646000000
			end
			if mp > 3400000 and mp <= 3410000 then
				req = 648000000
			end
			if mp > 3410000 and mp <= 3420000 then
				req = 650000000
			end
			if mp > 3420000 and mp <= 3430000 then
				req = 652000000
			end
			if mp > 3430000 and mp <= 3440000 then
				req = 654000000
			end
			if mp > 3440000 and mp <= 3450000 then
				req = 656000000
			end
			if mp > 3450000 and mp <= 3460000 then
				req = 658000000
			end
			if mp > 3460000 and mp <= 3470000 then
				req = 660000000
			end
			if mp > 3470000 and mp <= 3480000 then
				req = 662000000
			end
			if mp > 3480000 and mp <= 3490000 then
				req = 664000000
			end
			if mp > 3490000 and mp <= 3500000 then
				req = 666000000
			end
			if mp > 3500000 and mp <= 3510000 then
				req = 668000000
			end
			if mp > 3510000 and mp <= 3520000 then
				req = 670000000
			end
			if mp > 3520000 and mp <= 3530000 then
				req = 672000000
			end
			if mp > 3530000 and mp <= 3540000 then
				req = 674000000
			end
			if mp > 3540000 and mp <= 3550000 then
				req = 676000000
			end
			if mp > 3550000 and mp <= 3560000 then
				req = 678000000
			end
			if mp > 3560000 and mp <= 3570000 then
				req = 680000000
			end
			if mp > 3570000 and mp <= 3580000 then
				req = 682000000
			end
			if mp > 3580000 and mp <= 3590000 then
				req = 684000000
			end
			if mp > 3590000 and mp <= 3600000 then
				req = 686000000
			end
			if mp > 3600000 and mp <= 3610000 then
				req = 688000000
			end
			if mp > 3610000 and mp <= 3620000 then
				req = 690000000
			end
			if mp > 3620000 and mp <= 3630000 then
				req = 692000000
			end
			if mp > 3630000 and mp <= 3640000 then
				req = 694000000
			end
			if mp > 3640000 and mp <= 3650000 then
				req = 696000000
			end
			if mp > 3650000 and mp <= 3660000 then
				req = 698000000
			end
			if mp > 3660000 and mp <= 3670000 then
				req = 700000000
			end
			if mp > 3670000 and mp <= 3680000 then
				req = 702000000
			end
			if mp > 3680000 and mp <= 3690000 then
				req = 704000000
			end
			if mp > 3690000 and mp <= 3700000 then
				req = 706000000
			end
			if mp > 3700000 and mp <= 3710000 then
				req = 708000000
			end
			if mp > 3710000 and mp <= 3720000 then
				req = 710000000
			end
			if mp > 3720000 and mp <= 3730000 then
				req = 712000000
			end
			if mp > 3730000 and mp <= 3740000 then
				req = 714000000
			end
			if mp > 3740000 and mp <= 3750000 then
				req = 716000000
			end
			if mp > 3750000 and mp <= 3760000 then
				req = 718000000
			end
			if mp > 3760000 and mp <= 3770000 then
				req = 720000000
			end
			if mp > 3770000 and mp <= 3780000 then
				req = 722000000
			end
			if mp > 3780000 and mp <= 3790000 then
				req = 724000000
			end
			if mp > 3790000 and mp <= 3800000 then
				req = 726000000
			end
			if mp > 3800000 and mp <= 3810000 then
				req = 728000000
			end
			if mp > 3810000 and mp <= 3820000 then
				req = 730000000
			end
			if mp > 3820000 and mp <= 3830000 then
				req = 732000000
			end
			if mp > 3830000 and mp <= 3840000 then
				req = 734000000
			end
			if mp > 3840000 and mp <= 3850000 then
				req = 736000000
			end
			if mp > 3850000 and mp <= 3860000 then
				req = 738000000
			end
			if mp > 3860000 and mp <= 3870000 then
				req = 740000000
			end
			if mp > 3870000 and mp <= 3880000 then
				req = 742000000
			end
			if mp > 3880000 and mp <= 3890000 then
				req = 744000000
			end
			if mp > 3890000 and mp <= 3900000 then
				req = 746000000
			end
			if mp > 3900000 and mp <= 3910000 then
				req = 748000000
			end
			if mp > 3910000 and mp <= 3920000 then
				req = 750000000
			end
			if mp > 3920000 and mp <= 3930000 then
				req = 752000000
			end
			if mp > 3930000 and mp <= 3940000 then
				req = 754000000
			end
			if mp > 3940000 and mp <= 3950000 then
				req = 756000000
			end
			if mp > 3950000 and mp <= 3960000 then
				req = 758000000
			end
			if mp > 3960000 and mp <= 3970000 then
				req = 760000000
			end
			if mp > 3970000 and mp <= 3980000 then
				req = 762000000
			end
			if mp > 3980000 and mp <= 3990000 then
				req = 764000000
			end
			if mp > 3990000 and mp <= 4000000 then
				req = 766000000
			end
			if mp > 4000000 and mp <= 4010000 then
				req = 768000000
			end
			if mp > 4010000 and mp <= 4020000 then
				req = 770000000
			end
			if mp > 4020000 and mp <= 4030000 then
				req = 772000000
			end
			if mp > 4030000 and mp <= 4040000 then
				req = 774000000
			end
			if mp > 4040000 and mp <= 4050000 then
				req = 776000000
			end
			if mp > 4050000 and mp <= 4060000 then
				req = 778000000
			end
			if mp > 4060000 and mp <= 4070000 then
				req = 780000000
			end
			if mp > 4070000 and mp <= 4080000 then
				req = 782000000
			end
			if mp > 4080000 and mp <= 4090000 then
				req = 784000000
			end
			if mp > 4090000 and mp <= 4100000 then
				req = 786000000
			end
			if mp > 4100000 and mp <= 4110000 then
				req = 788000000
			end
			if mp > 4110000 and mp <= 4120000 then
				req = 790000000
			end
			if mp > 4120000 and mp <= 4130000 then
				req = 792000000
			end
			if mp > 4130000 and mp <= 4140000 then
				req = 794000000
			end
			if mp > 4140000 and mp <= 4150000 then
				req = 796000000
			end
			if mp > 4150000 and mp <= 4160000 then
				req = 798000000
			end
			if mp > 4160000 and mp <= 4170000 then
				req = 800000000
			end
			if mp > 4170000 and mp <= 4180000 then
				req = 802000000
			end
			if mp > 4180000 and mp <= 4190000 then
				req = 804000000
			end
			if mp > 4190000 and mp <= 4200000 then
				req = 806000000
			end
			if mp > 4200000 and mp <= 4210000 then
				req = 808000000
			end
			if mp > 4210000 and mp <= 4220000 then
				req = 810000000
			end
			if mp > 4220000 and mp <= 4230000 then
				req = 812000000
			end
			if mp > 4230000 and mp <= 4240000 then
				req = 814000000
			end
			if mp > 4240000 and mp <= 4250000 then
				req = 816000000
			end
			if mp > 4250000 and mp <= 4260000 then
				req = 818000000
			end
			if mp > 4260000 and mp <= 4270000 then
				req = 820000000
			end
			if mp > 4270000 and mp <= 4280000 then
				req = 822000000
			end
			if mp > 4280000 and mp <= 4290000 then
				req = 824000000
			end
			if mp > 4290000 and mp <= 4300000 then
				req = 826000000
			end
			if mp > 4300000 and mp <= 4310000 then
				req = 828000000
			end
			if mp > 4310000 and mp <= 4320000 then
				req = 830000000
			end
			if mp > 4320000 and mp <= 4330000 then
				req = 832000000
			end
			if mp > 4330000 and mp <= 4340000 then
				req = 834000000
			end
			if mp > 4340000 and mp <= 4350000 then
				req = 836000000
			end
			if mp > 4350000 and mp <= 4360000 then
				req = 838000000
			end
			if mp > 4360000 and mp <= 4370000 then
				req = 840000000
			end
			if mp > 4370000 and mp <= 4380000 then
				req = 842000000
			end
			if mp > 4380000 and mp <= 4390000 then
				req = 844000000
			end
			if mp > 4390000 and mp <= 4400000 then
				req = 846000000
			end
			if mp > 4400000 and mp <= 4410000 then
				req = 848000000
			end
			if mp > 4410000 and mp <= 4420000 then
				req = 850000000
			end
			if mp > 4420000 and mp <= 4430000 then
				req = 852000000
			end
			if mp > 4430000 and mp <= 4440000 then
				req = 854000000
			end
			if mp > 4440000 and mp <= 4450000 then
				req = 856000000
			end
			if mp > 4450000 and mp <= 4460000 then
				req = 858000000
			end
			if mp > 4460000 and mp <= 4470000 then
				req = 860000000
			end
			if mp > 4470000 and mp <= 4480000 then
				req = 862000000
			end
			if mp > 4480000 and mp <= 4490000 then
				req = 864000000
			end
			if mp > 4490000 and mp <= 4500000 then
				req = 866000000
			end
			if mp > 4500000 and mp <= 4510000 then
				req = 868000000
			end
			if mp > 4510000 and mp <= 4520000 then
				req = 870000000
			end
			if mp > 4520000 and mp <= 4530000 then
				req = 872000000
			end
			if mp > 4530000 and mp <= 4540000 then
				req = 874000000
			end
			if mp > 4540000 and mp <= 4550000 then
				req = 876000000
			end
			if mp > 4550000 and mp <= 4560000 then
				req = 878000000
			end
			if mp > 4560000 and mp <= 4570000 then
				req = 880000000
			end
			if mp > 4570000 and mp <= 4580000 then
				req = 882000000
			end
			if mp > 4580000 and mp <= 4590000 then
				req = 884000000
			end
			if mp > 4590000 and mp <= 4600000 then
				req = 886000000
			end
			if mp > 4600000 and mp <= 4610000 then
				req = 888000000
			end
			if mp > 4610000 and mp <= 4620000 then
				req = 890000000
			end
			if mp > 4620000 and mp <= 4630000 then
				req = 892000000
			end
			if mp > 4630000 and mp <= 4640000 then
				req = 894000000
			end
			if mp > 4640000 and mp <= 4650000 then
				req = 896000000
			end
			if mp > 4650000 and mp <= 4660000 then
				req = 898000000
			end
			if mp > 4660000 and mp <= 4670000 then
				req = 900000000
			end
			if mp > 4670000 and mp <= 4680000 then
				req = 902000000
			end
			if mp > 4680000 and mp <= 4690000 then
				req = 904000000
			end
			if mp > 4690000 and mp <= 4700000 then
				req = 906000000
			end
			if mp > 4700000 and mp <= 4710000 then
				req = 908000000
			end
			if mp > 4710000 and mp <= 4720000 then
				req = 910000000
			end
			if mp > 4720000 and mp <= 4730000 then
				req = 912000000
			end
			if mp > 4730000 and mp <= 4740000 then
				req = 914000000
			end
			if mp > 4740000 and mp <= 4750000 then
				req = 916000000
			end
			if mp > 4750000 and mp <= 4760000 then
				req = 918000000
			end
			if mp > 4760000 and mp <= 4770000 then
				req = 920000000
			end
			if mp > 4770000 and mp <= 4780000 then
				req = 922000000
			end
			if mp > 4780000 and mp <= 4790000 then
				req = 924000000
			end
			if mp > 4790000 and mp <= 4800000 then
				req = 926000000
			end
			if mp > 4800000 and mp <= 4810000 then
				req = 928000000
			end
			if mp > 4810000 and mp <= 4820000 then
				req = 930000000
			end
			if mp > 4820000 and mp <= 4830000 then
				req = 932000000
			end
			if mp > 4830000 and mp <= 4840000 then
				req = 934000000
			end
			if mp > 4840000 and mp <= 4850000 then
				req = 936000000
			end
			if mp > 4850000 and mp <= 4860000 then
				req = 938000000
			end
			if mp > 4860000 and mp <= 4870000 then
				req = 940000000
			end
			if mp > 4870000 and mp <= 4880000 then
				req = 942000000
			end
			if mp > 4880000 and mp <= 4890000 then
				req = 944000000
			end
			if mp > 4890000 and mp <= 4900000 then
				req = 946000000
			end
			if mp > 4900000 and mp <= 4910000 then
				req = 948000000
			end
			if mp > 4910000 and mp <= 4920000 then
				req = 950000000
			end
			if mp > 4920000 and mp <= 4930000 then
				req = 952000000
			end
			if mp > 4930000 and mp <= 4940000 then
				req = 954000000
			end
			if mp > 4940000 and mp <= 4950000 then
				req = 956000000
			end
			if mp > 4950000 and mp <= 4960000 then
				req = 958000000
			end
			if mp > 4960000 and mp <= 4970000 then
				req = 960000000
			end
			if mp > 4970000 and mp <= 4980000 then
				req = 962000000
			end
			if mp > 4980000 and mp <= 4990000 then
				req = 964000000
			end
			if mp > 4990000 and mp <= 5000000 then
				req = 966000000
			end
			if mp > 5000000 and mp <= 5010000 then
				req = 968000000
			end
			if mp > 5010000 and mp <= 5020000 then
				req = 970000000
			end
			if mp > 5020000 and mp <= 5030000 then
				req = 972000000
			end
			if mp > 5030000 and mp <= 5040000 then
				req = 974000000
			end
			if mp > 5040000 and mp <= 5050000 then
				req = 976000000
			end
			if mp > 5050000 and mp <= 5060000 then
				req = 978000000
			end
			if mp > 5060000 and mp <= 5070000 then
				req = 980000000
			end
			if mp > 5070000 and mp <= 5080000 then
				req = 982000000
			end
			if mp > 5080000 and mp <= 5090000 then
				req = 984000000
			end
			if mp > 5090000 and mp <= 5100000 then
				req = 986000000
			end
			if mp > 5100000 and mp <= 5110000 then
				req = 988000000
			end
			if mp > 5110000 and mp <= 5120000 then
				req = 990000000
			end
			if mp > 5120000 and mp <= 5130000 then
				req = 992000000
			end
			if mp > 5130000 and mp <= 5140000 then
				req = 994000000
			end
			if mp > 5140000 and mp <= 5150000 then
				req = 996000000
			end
			if mp > 5150000 and mp <= 5160000 then
				req = 998000000
			end
			if mp > 5160000 and mp <= 5170000 then
				req = 1000000000
			end
			if mp > 5170000 and mp <= 5180000 then
				req = 1002000000
			end
			if mp > 5180000 and mp <= 5190000 then
				req = 1004000000
			end
			if mp > 5190000 and mp <= 5200000 then
				req = 1006000000
			end
			if mp > 5200000 and mp <= 5210000 then
				req = 1008000000
			end
			if mp > 5210000 and mp <= 5220000 then
				req = 1010000000
			end
			if mp > 5220000 and mp <= 5230000 then
				req = 1012000000
			end
			if mp > 5230000 and mp <= 5240000 then
				req = 1014000000
			end
			if mp > 5240000 and mp <= 5250000 then
				req = 1016000000
			end
			if mp > 5250000 and mp <= 5260000 then
				req = 1018000000
			end
			if mp > 5260000 and mp <= 5270000 then
				req = 1020000000
			end
			if mp > 5270000 and mp <= 5280000 then
				req = 1022000000
			end
			if mp > 5280000 and mp <= 5290000 then
				req = 1024000000
			end
			if mp > 5290000 and mp <= 5300000 then
				req = 1026000000
			end
			if mp > 5300000 and mp <= 5310000 then
				req = 1028000000
			end
			if mp > 5310000 and mp <= 5320000 then
				req = 1030000000
			end
			if mp > 5320000 and mp <= 5330000 then
				req = 1032000000
			end
			if mp > 5330000 and mp <= 5340000 then
				req = 1034000000
			end
			if mp > 5340000 and mp <= 5350000 then
				req = 1036000000
			end
			if mp > 5350000 and mp <= 5360000 then
				req = 1038000000
			end
			if mp > 5360000 and mp <= 5370000 then
				req = 1040000000
			end
			if mp > 5370000 and mp <= 5380000 then
				req = 1042000000
			end
			if mp > 5380000 and mp <= 5390000 then
				req = 1044000000
			end
			if mp > 5390000 and mp <= 5400000 then
				req = 1046000000
			end
			if mp > 5400000 and mp <= 5410000 then
				req = 1048000000
			end
			if mp > 5410000 and mp <= 5420000 then
				req = 1050000000
			end
			if mp > 5420000 and mp <= 5430000 then
				req = 1052000000
			end
			if mp > 5430000 and mp <= 5440000 then
				req = 1054000000
			end
			if mp > 5440000 and mp <= 5450000 then
				req = 1056000000
			end
			if mp > 5450000 and mp <= 5460000 then
				req = 1058000000
			end
			if mp > 5460000 and mp <= 5470000 then
				req = 1060000000
			end
			if mp > 5470000 and mp <= 5480000 then
				req = 1062000000
			end
			if mp > 5480000 and mp <= 5490000 then
				req = 1064000000
			end
			if mp > 5490000 and mp <= 5500000 then
				req = 1066000000
			end
			if mp > 5500000 and mp <= 5510000 then
				req = 1068000000
			end
			if mp > 5510000 and mp <= 5520000 then
				req = 1070000000
			end
			if mp > 5520000 and mp <= 5530000 then
				req = 1072000000
			end
			if mp > 5530000 and mp <= 5540000 then
				req = 1074000000
			end
			if mp > 5540000 and mp <= 5550000 then
				req = 1076000000
			end
			if mp > 5550000 and mp <= 5560000 then
				req = 1078000000
			end
			if mp > 5560000 and mp <= 5570000 then
				req = 1080000000
			end
			if mp > 5570000 and mp <= 5580000 then
				req = 1082000000
			end
			if mp > 5580000 and mp <= 5590000 then
				req = 1084000000
			end
			if mp > 5590000 and mp <= 5600000 then
				req = 1086000000
			end
			if mp > 5600000 and mp <= 5610000 then
				req = 1088000000
			end
			if mp > 5610000 and mp <= 5620000 then
				req = 1090000000
			end
			if mp > 5620000 and mp <= 5630000 then
				req = 1092000000
			end
			if mp > 5630000 and mp <= 5640000 then
				req = 1094000000
			end
			if mp > 5640000 and mp <= 5650000 then
				req = 1096000000
			end
			if mp > 5650000 and mp <= 5660000 then
				req = 1098000000
			end
			if mp > 5660000 and mp <= 5670000 then
				req = 1100000000
			end
			if mp > 5670000 and mp <= 5680000 then
				req = 1102000000
			end
			if mp > 5680000 and mp <= 5690000 then
				req = 1104000000
			end
			if mp > 5690000 and mp <= 5700000 then
				req = 1106000000
			end
			if mp > 5700000 and mp <= 5710000 then
				req = 1108000000
			end
			if mp > 5710000 and mp <= 5720000 then
				req = 1110000000
			end
			if mp > 5720000 and mp <= 5730000 then
				req = 1112000000
			end
			if mp > 5730000 and mp <= 5740000 then
				req = 1114000000
			end
			if mp > 5740000 and mp <= 5750000 then
				req = 1116000000
			end
			if mp > 5750000 and mp <= 5760000 then
				req = 1118000000
			end
			if mp > 5760000 and mp <= 5770000 then
				req = 1120000000
			end
			if mp > 5770000 and mp <= 5780000 then
				req = 1122000000
			end
			if mp > 5780000 and mp <= 5790000 then
				req = 1124000000
			end
			if mp > 5790000 and mp <= 5800000 then
				req = 1126000000
			end
			if mp > 5800000 and mp <= 5810000 then
				req = 1128000000
			end
			if mp > 5810000 and mp <= 5820000 then
				req = 1130000000
			end
			if mp > 5820000 and mp <= 5830000 then
				req = 1132000000
			end
			if mp > 5830000 and mp <= 5840000 then
				req = 1134000000
			end
			if mp > 5840000 and mp <= 5850000 then
				req = 1136000000
			end
			if mp > 5850000 and mp <= 5860000 then
				req = 1138000000
			end
			if mp > 5860000 and mp <= 5870000 then
				req = 1140000000
			end
			if mp > 5870000 and mp <= 5880000 then
				req = 1142000000
			end
			if mp > 5880000 and mp <= 5890000 then
				req = 1144000000
			end
			if mp > 5890000 and mp <= 5900000 then
				req = 1146000000
			end
			if mp > 5900000 and mp <= 5910000 then
				req = 1148000000
			end
			if mp > 5910000 and mp <= 5920000 then
				req = 1150000000
			end
			if mp > 5920000 and mp <= 5930000 then
				req = 1152000000
			end
			if mp > 5930000 and mp <= 5940000 then
				req = 1154000000
			end
			if mp > 5940000 and mp <= 5950000 then
				req = 1156000000
			end
			if mp > 5950000 and mp <= 5960000 then
				req = 1158000000
			end
			if mp > 5960000 and mp <= 5970000 then
				req = 1160000000
			end
			if mp > 5970000 and mp <= 5980000 then
				req = 1162000000
			end
			if mp > 5980000 and mp <= 5990000 then
				req = 1164000000
			end
			if mp > 5990000 and mp <= 6000000 then
				req = 1166000000
			end
			if mp > 6000000 and mp <= 6010000 then
				req = 1168000000
			end
			if mp > 6010000 and mp <= 6020000 then
				req = 1170000000
			end
			if mp > 6020000 and mp <= 6030000 then
				req = 1172000000
			end
			if mp > 6030000 and mp <= 6040000 then
				req = 1174000000
			end
			if mp > 6040000 and mp <= 6050000 then
				req = 1176000000
			end
			if mp > 6050000 and mp <= 6060000 then
				req = 1178000000
			end
			if mp > 6060000 and mp <= 6070000 then
				req = 1180000000
			end
			if mp > 6070000 and mp <= 6080000 then
				req = 1182000000
			end
			if mp > 6080000 and mp <= 6090000 then
				req = 1184000000
			end
			if mp > 6090000 and mp <= 6100000 then
				req = 1186000000
			end
			if mp > 6100000 and mp <= 6110000 then
				req = 1188000000
			end
			if mp > 6110000 and mp <= 6120000 then
				req = 1190000000
			end
			if mp > 6120000 and mp <= 6130000 then
				req = 1192000000
			end
			if mp > 6130000 and mp <= 6140000 then
				req = 1194000000
			end
			if mp > 6140000 and mp <= 6150000 then
				req = 1196000000
			end
			if mp > 6150000 and mp <= 6160000 then
				req = 1198000000
			end
			if mp > 6160000 and mp <= 6170000 then
				req = 1200000000
			end
			if mp > 6170000 and mp <= 6180000 then
				req = 1202000000
			end
			if mp > 6180000 and mp <= 6190000 then
				req = 1204000000
			end
			if mp > 6190000 and mp <= 6200000 then
				req = 1206000000
			end
			if mp > 6200000 and mp <= 6210000 then
				req = 1208000000
			end
			if mp > 6210000 and mp <= 6220000 then
				req = 1210000000
			end
			if mp > 6220000 and mp <= 6230000 then
				req = 1212000000
			end
			if mp > 6230000 and mp <= 6240000 then
				req = 1214000000
			end
			if mp > 6240000 and mp <= 6250000 then
				req = 1216000000
			end
			if mp > 6250000 and mp <= 6260000 then
				req = 1218000000
			end
			if mp > 6260000 and mp <= 6270000 then
				req = 1220000000
			end
			if mp > 6270000 and mp <= 6280000 then
				req = 1222000000
			end
			if mp > 6280000 and mp <= 6290000 then
				req = 1224000000
			end
			if mp > 6290000 and mp <= 6300000 then
				req = 1226000000
			end
			if mp > 6300000 and mp <= 6310000 then
				req = 1228000000
			end
			if mp > 6310000 and mp <= 6320000 then
				req = 1230000000
			end
			if mp > 6320000 and mp <= 6330000 then
				req = 1232000000
			end
			if mp > 6330000 and mp <= 6340000 then
				req = 1234000000
			end
			if mp > 6340000 and mp <= 6350000 then
				req = 1236000000
			end
			if mp > 6350000 and mp <= 6360000 then
				req = 1238000000
			end
			if mp > 6360000 and mp <= 6370000 then
				req = 1240000000
			end
			if mp > 6370000 and mp <= 6380000 then
				req = 1242000000
			end
			if mp > 6380000 and mp <= 6390000 then
				req = 1244000000
			end
			if mp > 6390000 and mp <= 6400000 then
				req = 1246000000
			end
			if mp > 6400000 and mp <= 6410000 then
				req = 1248000000
			end
			if mp > 6410000 and mp <= 6420000 then
				req = 1250000000
			end
			if mp > 6420000 and mp <= 6430000 then
				req = 1252000000
			end
			if mp > 6430000 and mp <= 6440000 then
				req = 1254000000
			end
			if mp > 6440000 and mp <= 6450000 then
				req = 1256000000
			end
			if mp > 6450000 and mp <= 6460000 then
				req = 1258000000
			end
			if mp > 6460000 and mp <= 6470000 then
				req = 1260000000
			end
			if mp > 6470000 and mp <= 6480000 then
				req = 1262000000
			end
			if mp > 6480000 and mp <= 6490000 then
				req = 1264000000
			end
			if mp > 6490000 and mp <= 6500000 then
				req = 1266000000
			end
			if mp > 6500000 and mp <= 6510000 then
				req = 1268000000
			end
			if mp > 6510000 and mp <= 6520000 then
				req = 1270000000
			end
			if mp > 6520000 and mp <= 6530000 then
				req = 1272000000
			end
			if mp > 6530000 and mp <= 6540000 then
				req = 1274000000
			end
			if mp > 6540000 and mp <= 6550000 then
				req = 1276000000
			end
			if mp > 6550000 and mp <= 6560000 then
				req = 1278000000
			end
			if mp > 6560000 and mp <= 6570000 then
				req = 1280000000
			end
			if mp > 6570000 and mp <= 6580000 then
				req = 1282000000
			end
			if mp > 6580000 and mp <= 6590000 then
				req = 1284000000
			end
			if mp > 6590000 and mp <= 6600000 then
				req = 1286000000
			end
			if mp > 6600000 and mp <= 6610000 then
				req = 1288000000
			end
			if mp > 6610000 and mp <= 6620000 then
				req = 1290000000
			end
			if mp > 6620000 and mp <= 6630000 then
				req = 1292000000
			end
			if mp > 6630000 and mp <= 6640000 then
				req = 1294000000
			end
			if mp > 6640000 and mp <= 6650000 then
				req = 1296000000
			end
			if mp > 6650000 and mp <= 6660000 then
				req = 1298000000
			end
			if mp > 6660000 and mp <= 6670000 then
				req = 1300000000
			end
			if mp > 6670000 and mp <= 6680000 then
				req = 1302000000
			end
			if mp > 6680000 and mp <= 6690000 then
				req = 1304000000
			end
			if mp > 6690000 and mp <= 6700000 then
				req = 1306000000
			end
			if mp > 6700000 and mp <= 6710000 then
				req = 1308000000
			end
			if mp > 6710000 and mp <= 6720000 then
				req = 1310000000
			end
			if mp > 6720000 and mp <= 6730000 then
				req = 1312000000
			end
			if mp > 6730000 and mp <= 6740000 then
				req = 1314000000
			end
			if mp > 6740000 and mp <= 6750000 then
				req = 1316000000
			end
			if mp > 6750000 and mp <= 6760000 then
				req = 1318000000
			end
			if mp > 6760000 and mp <= 6770000 then
				req = 1320000000
			end
			if mp > 6770000 and mp <= 6780000 then
				req = 1322000000
			end
			if mp > 6780000 and mp <= 6790000 then
				req = 1324000000
			end
			if mp > 6790000 and mp <= 6800000 then
				req = 1326000000
			end
			if mp > 6800000 and mp <= 6810000 then
				req = 1328000000
			end
			if mp > 6810000 and mp <= 6820000 then
				req = 1330000000
			end
			if mp > 6820000 and mp <= 6830000 then
				req = 1332000000
			end
			if mp > 6830000 and mp <= 6840000 then
				req = 1334000000
			end
			if mp > 6840000 and mp <= 6850000 then
				req = 1336000000
			end
			if mp > 6850000 and mp <= 6860000 then
				req = 1338000000
			end
			if mp > 6860000 and mp <= 6870000 then
				req = 1340000000
			end
			if mp > 6870000 and mp <= 6880000 then
				req = 1342000000
			end
			if mp > 6880000 and mp <= 6890000 then
				req = 1344000000
			end
			if mp > 6890000 and mp <= 6900000 then
				req = 1346000000
			end
			if mp > 6900000 and mp <= 6910000 then
				req = 1348000000
			end
			if mp > 6910000 and mp <= 6920000 then
				req = 1350000000
			end
			if mp > 6920000 and mp <= 6930000 then
				req = 1352000000
			end
			if mp > 6930000 and mp <= 6940000 then
				req = 1354000000
			end
			if mp > 6940000 and mp <= 6950000 then
				req = 1356000000
			end
			if mp > 6950000 and mp <= 6960000 then
				req = 1358000000
			end
			if mp > 6960000 and mp <= 6970000 then
				req = 1360000000
			end
			if mp > 6970000 and mp <= 6980000 then
				req = 1362000000
			end
			if mp > 6980000 and mp <= 6990000 then
				req = 1364000000
			end
			if mp > 6990000 and mp <= 7000000 then
				req = 1366000000
			end
			if mp > 7000000 and mp <= 7010000 then
				req = 1368000000
			end
			if mp > 7010000 and mp <= 7020000 then
				req = 1370000000
			end
			if mp > 7020000 and mp <= 7030000 then
				req = 1372000000
			end
			if mp > 7030000 and mp <= 7040000 then
				req = 1374000000
			end
			if mp > 7040000 and mp <= 7050000 then
				req = 1376000000
			end
			if mp > 7050000 and mp <= 7060000 then
				req = 1378000000
			end
			if mp > 7060000 and mp <= 7070000 then
				req = 1380000000
			end
			if mp > 7070000 and mp <= 7080000 then
				req = 1382000000
			end
			if mp > 7080000 and mp <= 7090000 then
				req = 1384000000
			end
			if mp > 7090000 and mp <= 7100000 then
				req = 1386000000
			end
			if mp > 7100000 and mp <= 7110000 then
				req = 1388000000
			end
			if mp > 7110000 and mp <= 7120000 then
				req = 1390000000
			end
			if mp > 7120000 and mp <= 7130000 then
				req = 1392000000
			end
			if mp > 7130000 and mp <= 7140000 then
				req = 1394000000
			end
			if mp > 7140000 and mp <= 7150000 then
				req = 1396000000
			end
			if mp > 7150000 and mp <= 7160000 then
				req = 1398000000
			end
			if mp > 7160000 and mp <= 7170000 then
				req = 1400000000
			end
			if mp > 7170000 and mp <= 7180000 then
				req = 1402000000
			end
			if mp > 7180000 and mp <= 7190000 then
				req = 1404000000
			end
			if mp > 7190000 and mp <= 7200000 then
				req = 1406000000
			end
			if mp > 7200000 and mp <= 7210000 then
				req = 1408000000
			end
			if mp > 7210000 and mp <= 7220000 then
				req = 1410000000
			end
			if mp > 7220000 and mp <= 7230000 then
				req = 1412000000
			end
			if mp > 7230000 and mp <= 7240000 then
				req = 1414000000
			end
			if mp > 7240000 and mp <= 7250000 then
				req = 1416000000
			end
			if mp > 7250000 and mp <= 7260000 then
				req = 1418000000
			end
			if mp > 7260000 and mp <= 7270000 then
				req = 1420000000
			end
			if mp > 7270000 and mp <= 7280000 then
				req = 1422000000
			end
			if mp > 7280000 and mp <= 7290000 then
				req = 1424000000
			end
			if mp > 7290000 and mp <= 7300000 then
				req = 1426000000
			end
			if mp > 7300000 and mp <= 7310000 then
				req = 1428000000
			end
			if mp > 7310000 and mp <= 7320000 then
				req = 1430000000
			end
			if mp > 7320000 and mp <= 7330000 then
				req = 1432000000
			end
			if mp > 7330000 and mp <= 7340000 then
				req = 1434000000
			end
			if mp > 7340000 and mp <= 7350000 then
				req = 1436000000
			end
			if mp > 7350000 and mp <= 7360000 then
				req = 1438000000
			end
			if mp > 7360000 and mp <= 7370000 then
				req = 1440000000
			end
			if mp > 7370000 and mp <= 7380000 then
				req = 1442000000
			end
			if mp > 7380000 and mp <= 7390000 then
				req = 1444000000
			end
			if mp > 7390000 and mp <= 7400000 then
				req = 1446000000
			end
			if mp > 7400000 and mp <= 7410000 then
				req = 1448000000
			end
			if mp > 7410000 and mp <= 7420000 then
				req = 1450000000
			end
			if mp > 7420000 and mp <= 7430000 then
				req = 1452000000
			end
			if mp > 7430000 and mp <= 7440000 then
				req = 1454000000
			end
			if mp > 7440000 and mp <= 7450000 then
				req = 1456000000
			end
			if mp > 7450000 and mp <= 7460000 then
				req = 1458000000
			end
			if mp > 7460000 and mp <= 7470000 then
				req = 1460000000
			end
			if mp > 7470000 and mp <= 7480000 then
				req = 1462000000
			end
			if mp > 7480000 and mp <= 7490000 then
				req = 1464000000
			end
			if mp > 7490000 and mp <= 7500000 then
				req = 1466000000
			end
			if mp > 7500000 and mp <= 7510000 then
				req = 1468000000
			end
			if mp > 7510000 and mp <= 7520000 then
				req = 1470000000
			end
			if mp > 7520000 and mp <= 7530000 then
				req = 1472000000
			end
			if mp > 7530000 and mp <= 7540000 then
				req = 1474000000
			end
			if mp > 7540000 and mp <= 7550000 then
				req = 1476000000
			end
			if mp > 7550000 and mp <= 7560000 then
				req = 1478000000
			end
			if mp > 7560000 and mp <= 7570000 then
				req = 1480000000
			end
			if mp > 7570000 and mp <= 7580000 then
				req = 1482000000
			end
			if mp > 7580000 and mp <= 7590000 then
				req = 1484000000
			end
			if mp > 7590000 and mp <= 7600000 then
				req = 1486000000
			end
			if mp > 7600000 and mp <= 7610000 then
				req = 1488000000
			end
			if mp > 7610000 and mp <= 7620000 then
				req = 1490000000
			end
			if mp > 7620000 and mp <= 7630000 then
				req = 1492000000
			end
			if mp > 7630000 and mp <= 7640000 then
				req = 1494000000
			end
			if mp > 7640000 and mp <= 7650000 then
				req = 1496000000
			end
			if mp > 7650000 and mp <= 7660000 then
				req = 1498000000
			end
			if mp > 7660000 and mp <= 7670000 then
				req = 1500000000
			end
			if mp > 7670000 and mp <= 7680000 then
				req = 1502000000
			end
			if mp > 7680000 and mp <= 7690000 then
				req = 1504000000
			end
			if mp > 7690000 and mp <= 7700000 then
				req = 1506000000
			end
			if mp > 7700000 and mp <= 7710000 then
				req = 1508000000
			end
			if mp > 7710000 and mp <= 7720000 then
				req = 1510000000
			end
			if mp > 7720000 and mp <= 7730000 then
				req = 1512000000
			end
			if mp > 7730000 and mp <= 7740000 then
				req = 1514000000
			end
			if mp > 7740000 and mp <= 7750000 then
				req = 1516000000
			end
			if mp > 7750000 and mp <= 7760000 then
				req = 1518000000
			end
			if mp > 7760000 and mp <= 7770000 then
				req = 1520000000
			end
			if mp > 7770000 and mp <= 7780000 then
				req = 1522000000
			end
			if mp > 7780000 and mp <= 7790000 then
				req = 1524000000
			end
			if mp > 7790000 and mp <= 7800000 then
				req = 1526000000
			end
			if mp > 7800000 and mp <= 7810000 then
				req = 1528000000
			end
			if mp > 7810000 and mp <= 7820000 then
				req = 1530000000
			end
			if mp > 7820000 and mp <= 7830000 then
				req = 1532000000
			end
			if mp > 7830000 and mp <= 7840000 then
				req = 1534000000
			end
			if mp > 7840000 and mp <= 7850000 then
				req = 1536000000
			end
			if mp > 7850000 and mp <= 7860000 then
				req = 1538000000
			end
			if mp > 7860000 and mp <= 7870000 then
				req = 1540000000
			end
			if mp > 7870000 and mp <= 7880000 then
				req = 1542000000
			end
			if mp > 7880000 and mp <= 7890000 then
				req = 1544000000
			end
			if mp > 7890000 and mp <= 7900000 then
				req = 1546000000
			end
			if mp > 7900000 and mp <= 7910000 then
				req = 1548000000
			end
			if mp > 7910000 and mp <= 7920000 then
				req = 1550000000
			end
			if mp > 7920000 and mp <= 7930000 then
				req = 1552000000
			end
			if mp > 7930000 and mp <= 7940000 then
				req = 1554000000
			end
			if mp > 7940000 and mp <= 7950000 then
				req = 1556000000
			end
			if mp > 7950000 and mp <= 7960000 then
				req = 1558000000
			end
			if mp > 7960000 and mp <= 7970000 then
				req = 1560000000
			end
			if mp > 7970000 and mp <= 7980000 then
				req = 1562000000
			end
			if mp > 7980000 and mp <= 7990000 then
				req = 1564000000
			end
			if mp > 7990000 and mp <= 8000000 then
				req = 1566000000
			end
			if mp > 8000000 and mp <= 8010000 then
				req = 1568000000
			end
			if mp > 8010000 and mp <= 8020000 then
				req = 1570000000
			end
			if mp > 8020000 and mp <= 8030000 then
				req = 1572000000
			end
			if mp > 8030000 and mp <= 8040000 then
				req = 1574000000
			end
			if mp > 8040000 and mp <= 8050000 then
				req = 1576000000
			end
			if mp > 8050000 and mp <= 8060000 then
				req = 1578000000
			end
			if mp > 8060000 and mp <= 8070000 then
				req = 1580000000
			end
			if mp > 8070000 and mp <= 8080000 then
				req = 1582000000
			end
			if mp > 8080000 and mp <= 8090000 then
				req = 1584000000
			end
			if mp > 8090000 and mp <= 8100000 then
				req = 1586000000
			end
			if mp > 8100000 and mp <= 8110000 then
				req = 1588000000
			end
			if mp > 8110000 and mp <= 8120000 then
				req = 1590000000
			end
			if mp > 8120000 and mp <= 8130000 then
				req = 1592000000
			end
			if mp > 8130000 and mp <= 8140000 then
				req = 1594000000
			end
			if mp > 8140000 and mp <= 8150000 then
				req = 1596000000
			end
			if mp > 8150000 and mp <= 8160000 then
				req = 1598000000
			end
			if mp > 8160000 and mp <= 8170000 then
				req = 1600000000
			end
			if mp > 8170000 and mp <= 8180000 then
				req = 1602000000
			end
			if mp > 8180000 and mp <= 8190000 then
				req = 1604000000
			end
			if mp > 8190000 and mp <= 8200000 then
				req = 1606000000
			end
			if mp > 8200000 and mp <= 8210000 then
				req = 1608000000
			end
			if mp > 8210000 and mp <= 8220000 then
				req = 1610000000
			end
			if mp > 8220000 and mp <= 8230000 then
				req = 1612000000
			end
			if mp > 8230000 and mp <= 8240000 then
				req = 1614000000
			end
			if mp > 8240000 and mp <= 8250000 then
				req = 1616000000
			end
			if mp > 8250000 and mp <= 8260000 then
				req = 1618000000
			end
			if mp > 8260000 and mp <= 8270000 then
				req = 1620000000
			end
			if mp > 8270000 and mp <= 8280000 then
				req = 1622000000
			end
			if mp > 8280000 and mp <= 8290000 then
				req = 1624000000
			end
			if mp > 8290000 and mp <= 8300000 then
				req = 1626000000
			end
			if mp > 8300000 and mp <= 8310000 then
				req = 1628000000
			end
			if mp > 8310000 and mp <= 8320000 then
				req = 1630000000
			end
			if mp > 8320000 and mp <= 8330000 then
				req = 1632000000
			end
			if mp > 8330000 and mp <= 8340000 then
				req = 1634000000
			end
			if mp > 8340000 and mp <= 8350000 then
				req = 1636000000
			end
			if mp > 8350000 and mp <= 8360000 then
				req = 1638000000
			end
			if mp > 8360000 and mp <= 8370000 then
				req = 1640000000
			end
			if mp > 8370000 and mp <= 8380000 then
				req = 1642000000
			end
			if mp > 8380000 and mp <= 8390000 then
				req = 1644000000
			end
			if mp > 8390000 and mp <= 8400000 then
				req = 1646000000
			end
			if mp > 8400000 and mp <= 8410000 then
				req = 1648000000
			end
			if mp > 8410000 and mp <= 8420000 then
				req = 1650000000
			end
			if mp > 8420000 and mp <= 8430000 then
				req = 1652000000
			end
			if mp > 8430000 and mp <= 8440000 then
				req = 1654000000
			end
			if mp > 8440000 and mp <= 8450000 then
				req = 1656000000
			end
			if mp > 8450000 and mp <= 8460000 then
				req = 1658000000
			end
			if mp > 8460000 and mp <= 8470000 then
				req = 1660000000
			end
			if mp > 8470000 and mp <= 8480000 then
				req = 1662000000
			end
			if mp > 8480000 and mp <= 8490000 then
				req = 1664000000
			end
			if mp > 8490000 and mp <= 8500000 then
				req = 1666000000
			end
			if mp > 8500000 and mp <= 8510000 then
				req = 1668000000
			end
			if mp > 8510000 and mp <= 8520000 then
				req = 1670000000
			end
			if mp > 8520000 and mp <= 8530000 then
				req = 1672000000
			end
			if mp > 8530000 and mp <= 8540000 then
				req = 1674000000
			end
			if mp > 8540000 and mp <= 8550000 then
				req = 1676000000
			end
			if mp > 8550000 and mp <= 8560000 then
				req = 1678000000
			end
			if mp > 8560000 and mp <= 8570000 then
				req = 1680000000
			end
			if mp > 8570000 and mp <= 8580000 then
				req = 1682000000
			end
			if mp > 8580000 and mp <= 8590000 then
				req = 1684000000
			end
			if mp > 8590000 and mp <= 8600000 then
				req = 1686000000
			end
			if mp > 8600000 and mp <= 8610000 then
				req = 1688000000
			end
			if mp > 8610000 and mp <= 8620000 then
				req = 1690000000
			end
			if mp > 8620000 and mp <= 8630000 then
				req = 1692000000
			end
			if mp > 8630000 and mp <= 8640000 then
				req = 1694000000
			end
			if mp > 8640000 and mp <= 8650000 then
				req = 1696000000
			end
			if mp > 8650000 and mp <= 8660000 then
				req = 1698000000
			end
			if mp > 8660000 and mp <= 8670000 then
				req = 1700000000
			end
			if mp > 8670000 and mp <= 8680000 then
				req = 1702000000
			end
			if mp > 8680000 and mp <= 8690000 then
				req = 1704000000
			end
			if mp > 8690000 and mp <= 8700000 then
				req = 1706000000
			end
			if mp > 8700000 and mp <= 8710000 then
				req = 1708000000
			end
			if mp > 8710000 and mp <= 8720000 then
				req = 1710000000
			end
			if mp > 8720000 and mp <= 8730000 then
				req = 1712000000
			end
			if mp > 8730000 and mp <= 8740000 then
				req = 1714000000
			end
			if mp > 8740000 and mp <= 8750000 then
				req = 1716000000
			end
			if mp > 8750000 and mp <= 8760000 then
				req = 1718000000
			end
			if mp > 8760000 and mp <= 8770000 then
				req = 1720000000
			end
			if mp > 8770000 and mp <= 8780000 then
				req = 1722000000
			end
			if mp > 8780000 and mp <= 8790000 then
				req = 1724000000
			end
			if mp > 8790000 and mp <= 8800000 then
				req = 1726000000
			end
			if mp > 8800000 and mp <= 8810000 then
				req = 1728000000
			end
			if mp > 8810000 and mp <= 8820000 then
				req = 1730000000
			end
			if mp > 8820000 and mp <= 8830000 then
				req = 1732000000
			end
			if mp > 8830000 and mp <= 8840000 then
				req = 1734000000
			end
			if mp > 8840000 and mp <= 8850000 then
				req = 1736000000
			end
			if mp > 8850000 and mp <= 8860000 then
				req = 1738000000
			end
			if mp > 8860000 and mp <= 8870000 then
				req = 1740000000
			end
			if mp > 8870000 and mp <= 8880000 then
				req = 1742000000
			end
			if mp > 8880000 and mp <= 8890000 then
				req = 1744000000
			end
			if mp > 8890000 and mp <= 8900000 then
				req = 1746000000
			end
			if mp > 8900000 and mp <= 8910000 then
				req = 1748000000
			end
			if mp > 8910000 and mp <= 8920000 then
				req = 1750000000
			end
			if mp > 8920000 and mp <= 8930000 then
				req = 1752000000
			end
			if mp > 8930000 and mp <= 8940000 then
				req = 1754000000
			end
			if mp > 8940000 and mp <= 8950000 then
				req = 1756000000
			end
			if mp > 8950000 and mp <= 8960000 then
				req = 1758000000
			end
			if mp > 8960000 and mp <= 8970000 then
				req = 1760000000
			end
			if mp > 8970000 and mp <= 8980000 then
				req = 1762000000
			end
			if mp > 8980000 and mp <= 8990000 then
				req = 1764000000
			end
			if mp > 8990000 and mp <= 9000000 then
				req = 1766000000
			end
			if mp > 9000000 and mp <= 9010000 then
				req = 1768000000
			end
			if mp > 9010000 and mp <= 9020000 then
				req = 1770000000
			end
			if mp > 9020000 and mp <= 9030000 then
				req = 1772000000
			end
			if mp > 9030000 and mp <= 9040000 then
				req = 1774000000
			end
			if mp > 9040000 and mp <= 9050000 then
				req = 1776000000
			end
			if mp > 9050000 and mp <= 9060000 then
				req = 1778000000
			end
			if mp > 9060000 and mp <= 9070000 then
				req = 1780000000
			end
			if mp > 9070000 and mp <= 9080000 then
				req = 1782000000
			end
			if mp > 9080000 and mp <= 9090000 then
				req = 1784000000
			end
			if mp > 9090000 and mp <= 9100000 then
				req = 1786000000
			end
			if mp > 9100000 and mp <= 9110000 then
				req = 1788000000
			end
			if mp > 9110000 and mp <= 9120000 then
				req = 1790000000
			end
			if mp > 9120000 and mp <= 9130000 then
				req = 1792000000
			end
			if mp > 9130000 and mp <= 9140000 then
				req = 1794000000
			end
			if mp > 9140000 and mp <= 9150000 then
				req = 1796000000
			end
			if mp > 9150000 and mp <= 9160000 then
				req = 1798000000
			end
			if mp > 9160000 and mp <= 9170000 then
				req = 1800000000
			end
			if mp > 9170000 and mp <= 9180000 then
				req = 1802000000
			end
			if mp > 9180000 and mp <= 9190000 then
				req = 1804000000
			end
			if mp > 9190000 and mp <= 9200000 then
				req = 1806000000
			end
			if mp > 9200000 and mp <= 9210000 then
				req = 1808000000
			end
			if mp > 9210000 and mp <= 9220000 then
				req = 1810000000
			end
			if mp > 9220000 and mp <= 9230000 then
				req = 1812000000
			end
			if mp > 9230000 and mp <= 9240000 then
				req = 1814000000
			end
			if mp > 9240000 and mp <= 9250000 then
				req = 1816000000
			end
			if mp > 9250000 and mp <= 9260000 then
				req = 1818000000
			end
			if mp > 9260000 and mp <= 9270000 then
				req = 1820000000
			end
			if mp > 9270000 and mp <= 9280000 then
				req = 1822000000
			end
			if mp > 9280000 and mp <= 9290000 then
				req = 1824000000
			end
			if mp > 9290000 and mp <= 9300000 then
				req = 1826000000
			end
			if mp > 9300000 and mp <= 9310000 then
				req = 1828000000
			end
			if mp > 9310000 and mp <= 9320000 then
				req = 1830000000
			end
			if mp > 9320000 and mp <= 9330000 then
				req = 1832000000
			end
			if mp > 9330000 and mp <= 9340000 then
				req = 1834000000
			end
			if mp > 9340000 and mp <= 9350000 then
				req = 1836000000
			end
			if mp > 9350000 and mp <= 9360000 then
				req = 1838000000
			end
			if mp > 9360000 and mp <= 9370000 then
				req = 1840000000
			end
			if mp > 9370000 and mp <= 9380000 then
				req = 1842000000
			end
			if mp > 9380000 and mp <= 9390000 then
				req = 1844000000
			end
			if mp > 9390000 and mp <= 9400000 then
				req = 1846000000
			end
			if mp > 9400000 and mp <= 9410000 then
				req = 1848000000
			end
			if mp > 9410000 and mp <= 9420000 then
				req = 1850000000
			end
			if mp > 9420000 and mp <= 9430000 then
				req = 1852000000
			end
			if mp > 9430000 and mp <= 9440000 then
				req = 1854000000
			end
			if mp > 9440000 and mp <= 9450000 then
				req = 1856000000
			end
			if mp > 9450000 and mp <= 9460000 then
				req = 1858000000
			end
			if mp > 9460000 and mp <= 9470000 then
				req = 1860000000
			end
			if mp > 9470000 and mp <= 9480000 then
				req = 1862000000
			end
			if mp > 9480000 and mp <= 9490000 then
				req = 1864000000
			end
			if mp > 9490000 and mp <= 9500000 then
				req = 1866000000
			end
			if mp > 9500000 and mp <= 9510000 then
				req = 1868000000
			end
			if mp > 9510000 and mp <= 9520000 then
				req = 1870000000
			end
			if mp > 9520000 and mp <= 9530000 then
				req = 1872000000
			end
			if mp > 9530000 and mp <= 9540000 then
				req = 1874000000
			end
			if mp > 9540000 and mp <= 9550000 then
				req = 1876000000
			end
			if mp > 9550000 and mp <= 9560000 then
				req = 1878000000
			end
			if mp > 9560000 and mp <= 9570000 then
				req = 1880000000
			end
			if mp > 9570000 and mp <= 9580000 then
				req = 1882000000
			end
			if mp > 9580000 and mp <= 9590000 then
				req = 1884000000
			end
			if mp > 9590000 and mp <= 9600000 then
				req = 1886000000
			end
			if mp > 9600000 and mp <= 9610000 then
				req = 1888000000
			end
			if mp > 9610000 and mp <= 9620000 then
				req = 1890000000
			end
			if mp > 9620000 and mp <= 9630000 then
				req = 1892000000
			end
			if mp > 9630000 and mp <= 9640000 then
				req = 1894000000
			end
			if mp > 9640000 and mp <= 9650000 then
				req = 1896000000
			end
			if mp > 9650000 and mp <= 9660000 then
				req = 1898000000
			end
			if mp > 9660000 and mp <= 9670000 then
				req = 1900000000
			end
			if mp > 9670000 and mp <= 9680000 then
				req = 1902000000
			end
			if mp > 9680000 and mp <= 9690000 then
				req = 1904000000
			end
			if mp > 9690000 and mp <= 9700000 then
				req = 1906000000
			end
			if mp > 9700000 and mp <= 9710000 then
				req = 1908000000
			end
			if mp > 9710000 and mp <= 9720000 then
				req = 1910000000
			end
			if mp > 9720000 and mp <= 9730000 then
				req = 1912000000
			end
			if mp > 9730000 and mp <= 9740000 then
				req = 1914000000
			end
			if mp > 9740000 and mp <= 9750000 then
				req = 1916000000
			end
			if mp > 9750000 and mp <= 9760000 then
				req = 1918000000
			end
			if mp > 9760000 and mp <= 9770000 then
				req = 1920000000
			end
			if mp > 9770000 and mp <= 9780000 then
				req = 1922000000
			end
			if mp > 9780000 and mp <= 9790000 then
				req = 1924000000
			end
			if mp > 9790000 and mp <= 9800000 then
				req = 1926000000
			end
			if mp > 9800000 and mp <= 9810000 then
				req = 1928000000
			end
			if mp > 9810000 and mp <= 9820000 then
				req = 1930000000
			end
			if mp > 9820000 and mp <= 9830000 then
				req = 1932000000
			end
			if mp > 9830000 and mp <= 9840000 then
				req = 1934000000
			end
			if mp > 9840000 and mp <= 9850000 then
				req = 1936000000
			end
			if mp > 9850000 and mp <= 9860000 then
				req = 1938000000
			end
			if mp > 9860000 and mp <= 9870000 then
				req = 1940000000
			end
			if mp > 9870000 and mp <= 9880000 then
				req = 1942000000
			end
			if mp > 9880000 and mp <= 9890000 then
				req = 1944000000
			end
			if mp > 9890000 and mp <= 9900000 then
				req = 1946000000
			end
			if mp > 9900000 and mp <= 9910000 then
				req = 1948000000
			end
			if mp > 9910000 and mp <= 9920000 then
				req = 1950000000
			end
			if mp > 9920000 and mp <= 9930000 then
				req = 1952000000
			end
			if mp > 9930000 and mp <= 9940000 then
				req = 1954000000
			end
			if mp > 9940000 and mp <= 9950000 then
				req = 1956000000
			end
			if mp > 9950000 and mp <= 9960000 then
				req = 1958000000
			end
			if mp > 9960000 and mp <= 9970000 then
				req = 1960000000
			end
			if mp > 9970000 and mp <= 9980000 then
				req = 1962000000
			end
			if mp > 9980000 and mp <= 9990000 then
				req = 1964000000
			end
			if mp > 9990000 and mp <= 10000000 then
				req = 1966000000
			end
			if mp > 10000000 and mp <= 10010000 then
				req = 1968000000
			end
		elseif job == 3 then -- Wizard
			if mp <= 20000 then
				req = 10000000
			end
			if mp > 20000 and mp <= 30000 then
				req = 12000000
			end
			if mp > 30000 and mp <= 40000 then
				req = 14000000
			end
			if mp > 40000 and mp <= 50000 then
				req = 16000000
			end
			if mp > 50000 and mp <= 60000 then
				req = 18000000
			end
			if mp > 60000 and mp <= 70000 then
				req = 20000000
			end
			if mp > 70000 and mp <= 80000 then
				req = 22000000
			end
			if mp > 80000 and mp <= 90000 then
				req = 24000000
			end
			if mp > 90000 and mp <= 100000 then
				req = 26000000
			end
			if mp > 100000 and mp <= 110000 then
				req = 28000000
			end
			if mp > 110000 and mp <= 120000 then
				req = 30000000
			end
			if mp > 120000 and mp <= 130000 then
				req = 32000000
			end
			if mp > 130000 and mp <= 140000 then
				req = 34000000
			end
			if mp > 140000 and mp <= 150000 then
				req = 36000000
			end
			if mp > 150000 and mp <= 160000 then
				req = 38000000
			end
			if mp > 160000 and mp <= 170000 then
				req = 40000000
			end
			if mp > 170000 and mp <= 180000 then
				req = 42000000
			end
			if mp > 180000 and mp <= 190000 then
				req = 44000000
			end
			if mp > 190000 and mp <= 200000 then
				req = 46000000
			end
			if mp > 200000 and mp <= 210000 then
				req = 48000000
			end
			if mp > 210000 and mp <= 220000 then
				req = 50000000
			end
			if mp > 220000 and mp <= 230000 then
				req = 52000000
			end
			if mp > 230000 and mp <= 240000 then
				req = 54000000
			end
			if mp > 240000 and mp <= 250000 then
				req = 56000000
			end
			if mp > 250000 and mp <= 260000 then
				req = 58000000
			end
			if mp > 260000 and mp <= 270000 then
				req = 60000000
			end
			if mp > 270000 and mp <= 280000 then
				req = 62000000
			end
			if mp > 280000 and mp <= 290000 then
				req = 64000000
			end
			if mp > 290000 and mp <= 300000 then
				req = 66000000
			end
			if mp > 300000 and mp <= 310000 then
				req = 68000000
			end
			if mp > 310000 and mp <= 320000 then
				req = 70000000
			end
			if mp > 320000 and mp <= 330000 then
				req = 72000000
			end
			if mp > 330000 and mp <= 340000 then
				req = 74000000
			end
			if mp > 340000 and mp <= 350000 then
				req = 76000000
			end
			if mp > 350000 and mp <= 360000 then
				req = 78000000
			end
			if mp > 360000 and mp <= 370000 then
				req = 80000000
			end
			if mp > 370000 and mp <= 380000 then
				req = 82000000
			end
			if mp > 380000 and mp <= 390000 then
				req = 84000000
			end
			if mp > 390000 and mp <= 400000 then
				req = 86000000
			end
			if mp > 400000 and mp <= 410000 then
				req = 88000000
			end
			if mp > 410000 and mp <= 420000 then
				req = 90000000
			end
			if mp > 420000 and mp <= 430000 then
				req = 92000000
			end
			if mp > 430000 and mp <= 440000 then
				req = 94000000
			end
			if mp > 440000 and mp <= 450000 then
				req = 96000000
			end
			if mp > 450000 and mp <= 460000 then
				req = 98000000
			end
			if mp > 460000 and mp <= 470000 then
				req = 100000000
			end
			if mp > 470000 and mp <= 480000 then
				req = 102000000
			end
			if mp > 480000 and mp <= 490000 then
				req = 104000000
			end
			if mp > 490000 and mp <= 500000 then
				req = 106000000
			end
			if mp > 500000 and mp <= 510000 then
				req = 108000000
			end
			if mp > 510000 and mp <= 520000 then
				req = 110000000
			end
			if mp > 520000 and mp <= 530000 then
				req = 112000000
			end
			if mp > 530000 and mp <= 540000 then
				req = 114000000
			end
			if mp > 540000 and mp <= 550000 then
				req = 116000000
			end
			if mp > 550000 and mp <= 560000 then
				req = 118000000
			end
			if mp > 560000 and mp <= 570000 then
				req = 120000000
			end
			if mp > 570000 and mp <= 580000 then
				req = 122000000
			end
			if mp > 580000 and mp <= 590000 then
				req = 124000000
			end
			if mp > 590000 and mp <= 600000 then
				req = 126000000
			end
			if mp > 600000 and mp <= 610000 then
				req = 128000000
			end
			if mp > 610000 and mp <= 620000 then
				req = 130000000
			end
			if mp > 620000 and mp <= 630000 then
				req = 132000000
			end
			if mp > 630000 and mp <= 640000 then
				req = 134000000
			end
			if mp > 640000 and mp <= 650000 then
				req = 136000000
			end
			if mp > 650000 and mp <= 660000 then
				req = 138000000
			end
			if mp > 660000 and mp <= 670000 then
				req = 140000000
			end
			if mp > 670000 and mp <= 680000 then
				req = 142000000
			end
			if mp > 680000 and mp <= 690000 then
				req = 144000000
			end
			if mp > 690000 and mp <= 700000 then
				req = 146000000
			end
			if mp > 700000 and mp <= 710000 then
				req = 148000000
			end
			if mp > 710000 and mp <= 720000 then
				req = 150000000
			end
			if mp > 720000 and mp <= 730000 then
				req = 152000000
			end
			if mp > 730000 and mp <= 740000 then
				req = 154000000
			end
			if mp > 740000 and mp <= 750000 then
				req = 156000000
			end
			if mp > 750000 and mp <= 760000 then
				req = 158000000
			end
			if mp > 760000 and mp <= 770000 then
				req = 160000000
			end
			if mp > 770000 and mp <= 780000 then
				req = 162000000
			end
			if mp > 780000 and mp <= 790000 then
				req = 164000000
			end
			if mp > 790000 and mp <= 800000 then
				req = 166000000
			end
			if mp > 800000 and mp <= 810000 then
				req = 168000000
			end
			if mp > 810000 and mp <= 820000 then
				req = 170000000
			end
			if mp > 820000 and mp <= 830000 then
				req = 172000000
			end
			if mp > 830000 and mp <= 840000 then
				req = 174000000
			end
			if mp > 840000 and mp <= 850000 then
				req = 176000000
			end
			if mp > 850000 and mp <= 860000 then
				req = 178000000
			end
			if mp > 860000 and mp <= 870000 then
				req = 180000000
			end
			if mp > 870000 and mp <= 880000 then
				req = 182000000
			end
			if mp > 880000 and mp <= 890000 then
				req = 184000000
			end
			if mp > 890000 and mp <= 900000 then
				req = 186000000
			end
			if mp > 900000 and mp <= 910000 then
				req = 188000000
			end
			if mp > 910000 and mp <= 920000 then
				req = 190000000
			end
			if mp > 920000 and mp <= 930000 then
				req = 192000000
			end
			if mp > 930000 and mp <= 940000 then
				req = 194000000
			end
			if mp > 940000 and mp <= 950000 then
				req = 196000000
			end
			if mp > 950000 and mp <= 960000 then
				req = 198000000
			end
			if mp > 960000 and mp <= 970000 then
				req = 200000000
			end
			if mp > 970000 and mp <= 980000 then
				req = 202000000
			end
			if mp > 980000 and mp <= 990000 then
				req = 204000000
			end
			if mp > 990000 and mp <= 1000000 then
				req = 206000000
			end
			if mp > 1000000 and mp <= 1010000 then
				req = 208000000
			end
			if mp > 1010000 and mp <= 1020000 then
				req = 210000000
			end
			if mp > 1020000 and mp <= 1030000 then
				req = 212000000
			end
			if mp > 1030000 and mp <= 1040000 then
				req = 214000000
			end
			if mp > 1040000 and mp <= 1050000 then
				req = 216000000
			end
			if mp > 1050000 and mp <= 1060000 then
				req = 218000000
			end
			if mp > 1060000 and mp <= 1070000 then
				req = 220000000
			end
			if mp > 1070000 and mp <= 1080000 then
				req = 222000000
			end
			if mp > 1080000 and mp <= 1090000 then
				req = 224000000
			end
			if mp > 1090000 and mp <= 1100000 then
				req = 226000000
			end
			if mp > 1100000 and mp <= 1110000 then
				req = 228000000
			end
			if mp > 1110000 and mp <= 1120000 then
				req = 230000000
			end
			if mp > 1120000 and mp <= 1130000 then
				req = 232000000
			end
			if mp > 1130000 and mp <= 1140000 then
				req = 234000000
			end
			if mp > 1140000 and mp <= 1150000 then
				req = 236000000
			end
			if mp > 1150000 and mp <= 1160000 then
				req = 238000000
			end
			if mp > 1160000 and mp <= 1170000 then
				req = 240000000
			end
			if mp > 1170000 and mp <= 1180000 then
				req = 242000000
			end
			if mp > 1180000 and mp <= 1190000 then
				req = 244000000
			end
			if mp > 1190000 and mp <= 1200000 then
				req = 246000000
			end
			if mp > 1200000 and mp <= 1210000 then
				req = 248000000
			end
			if mp > 1210000 and mp <= 1220000 then
				req = 250000000
			end
			if mp > 1220000 and mp <= 1230000 then
				req = 252000000
			end
			if mp > 1230000 and mp <= 1240000 then
				req = 254000000
			end
			if mp > 1240000 and mp <= 1250000 then
				req = 256000000
			end
			if mp > 1250000 and mp <= 1260000 then
				req = 258000000
			end
			if mp > 1260000 and mp <= 1270000 then
				req = 260000000
			end
			if mp > 1270000 and mp <= 1280000 then
				req = 262000000
			end
			if mp > 1280000 and mp <= 1290000 then
				req = 264000000
			end
			if mp > 1290000 and mp <= 1300000 then
				req = 266000000
			end
			if mp > 1300000 and mp <= 1310000 then
				req = 268000000
			end
			if mp > 1310000 and mp <= 1320000 then
				req = 270000000
			end
			if mp > 1320000 and mp <= 1330000 then
				req = 272000000
			end
			if mp > 1330000 and mp <= 1340000 then
				req = 274000000
			end
			if mp > 1340000 and mp <= 1350000 then
				req = 276000000
			end
			if mp > 1350000 and mp <= 1360000 then
				req = 278000000
			end
			if mp > 1360000 and mp <= 1370000 then
				req = 280000000
			end
			if mp > 1370000 and mp <= 1380000 then
				req = 282000000
			end
			if mp > 1380000 and mp <= 1390000 then
				req = 284000000
			end
			if mp > 1390000 and mp <= 1400000 then
				req = 286000000
			end
			if mp > 1400000 and mp <= 1410000 then
				req = 288000000
			end
			if mp > 1410000 and mp <= 1420000 then
				req = 290000000
			end
			if mp > 1420000 and mp <= 1430000 then
				req = 292000000
			end
			if mp > 1430000 and mp <= 1440000 then
				req = 294000000
			end
			if mp > 1440000 and mp <= 1450000 then
				req = 296000000
			end
			if mp > 1450000 and mp <= 1460000 then
				req = 298000000
			end
			if mp > 1460000 and mp <= 1470000 then
				req = 300000000
			end
			if mp > 1470000 and mp <= 1480000 then
				req = 302000000
			end
			if mp > 1480000 and mp <= 1490000 then
				req = 304000000
			end
			if mp > 1490000 and mp <= 1500000 then
				req = 306000000
			end
			if mp > 1500000 and mp <= 1510000 then
				req = 308000000
			end
			if mp > 1510000 and mp <= 1520000 then
				req = 310000000
			end
			if mp > 1520000 and mp <= 1530000 then
				req = 312000000
			end
			if mp > 1530000 and mp <= 1540000 then
				req = 314000000
			end
			if mp > 1540000 and mp <= 1550000 then
				req = 316000000
			end
			if mp > 1550000 and mp <= 1560000 then
				req = 318000000
			end
			if mp > 1560000 and mp <= 1570000 then
				req = 320000000
			end
			if mp > 1570000 and mp <= 1580000 then
				req = 322000000
			end
			if mp > 1580000 and mp <= 1590000 then
				req = 324000000
			end
			if mp > 1590000 and mp <= 1600000 then
				req = 326000000
			end
			if mp > 1600000 and mp <= 1610000 then
				req = 328000000
			end
			if mp > 1610000 and mp <= 1620000 then
				req = 330000000
			end
			if mp > 1620000 and mp <= 1630000 then
				req = 332000000
			end
			if mp > 1630000 and mp <= 1640000 then
				req = 334000000
			end
			if mp > 1640000 and mp <= 1650000 then
				req = 336000000
			end
			if mp > 1650000 and mp <= 1660000 then
				req = 338000000
			end
			if mp > 1660000 and mp <= 1670000 then
				req = 340000000
			end
			if mp > 1670000 and mp <= 1680000 then
				req = 342000000
			end
			if mp > 1680000 and mp <= 1690000 then
				req = 344000000
			end
			if mp > 1690000 and mp <= 1700000 then
				req = 346000000
			end
			if mp > 1700000 and mp <= 1710000 then
				req = 348000000
			end
			if mp > 1710000 and mp <= 1720000 then
				req = 350000000
			end
			if mp > 1720000 and mp <= 1730000 then
				req = 352000000
			end
			if mp > 1730000 and mp <= 1740000 then
				req = 354000000
			end
			if mp > 1740000 and mp <= 1750000 then
				req = 356000000
			end
			if mp > 1750000 and mp <= 1760000 then
				req = 358000000
			end
			if mp > 1760000 and mp <= 1770000 then
				req = 360000000
			end
			if mp > 1770000 and mp <= 1780000 then
				req = 362000000
			end
			if mp > 1780000 and mp <= 1790000 then
				req = 364000000
			end
			if mp > 1790000 and mp <= 1800000 then
				req = 366000000
			end
			if mp > 1800000 and mp <= 1810000 then
				req = 368000000
			end
			if mp > 1810000 and mp <= 1820000 then
				req = 370000000
			end
			if mp > 1820000 and mp <= 1830000 then
				req = 372000000
			end
			if mp > 1830000 and mp <= 1840000 then
				req = 374000000
			end
			if mp > 1840000 and mp <= 1850000 then
				req = 376000000
			end
			if mp > 1850000 and mp <= 1860000 then
				req = 378000000
			end
			if mp > 1860000 and mp <= 1870000 then
				req = 380000000
			end
			if mp > 1870000 and mp <= 1880000 then
				req = 382000000
			end
			if mp > 1880000 and mp <= 1890000 then
				req = 384000000
			end
			if mp > 1890000 and mp <= 1900000 then
				req = 386000000
			end
			if mp > 1900000 and mp <= 1910000 then
				req = 388000000
			end
			if mp > 1910000 and mp <= 1920000 then
				req = 390000000
			end
			if mp > 1920000 and mp <= 1930000 then
				req = 392000000
			end
			if mp > 1930000 and mp <= 1940000 then
				req = 394000000
			end
			if mp > 1940000 and mp <= 1950000 then
				req = 396000000
			end
			if mp > 1950000 and mp <= 1960000 then
				req = 398000000
			end
			if mp > 1960000 and mp <= 1970000 then
				req = 400000000
			end
			if mp > 1970000 and mp <= 1980000 then
				req = 402000000
			end
			if mp > 1980000 and mp <= 1990000 then
				req = 404000000
			end
			if mp > 1990000 and mp <= 2000000 then
				req = 406000000
			end
			if mp > 2000000 and mp <= 2010000 then
				req = 408000000
			end
			if mp > 2010000 and mp <= 2020000 then
				req = 410000000
			end
			if mp > 2020000 and mp <= 2030000 then
				req = 412000000
			end
			if mp > 2030000 and mp <= 2040000 then
				req = 414000000
			end
			if mp > 2040000 and mp <= 2050000 then
				req = 416000000
			end
			if mp > 2050000 and mp <= 2060000 then
				req = 418000000
			end
			if mp > 2060000 and mp <= 2070000 then
				req = 420000000
			end
			if mp > 2070000 and mp <= 2080000 then
				req = 422000000
			end
			if mp > 2080000 and mp <= 2090000 then
				req = 424000000
			end
			if mp > 2090000 and mp <= 2100000 then
				req = 426000000
			end
			if mp > 2100000 and mp <= 2110000 then
				req = 428000000
			end
			if mp > 2110000 and mp <= 2120000 then
				req = 430000000
			end
			if mp > 2120000 and mp <= 2130000 then
				req = 432000000
			end
			if mp > 2130000 and mp <= 2140000 then
				req = 434000000
			end
			if mp > 2140000 and mp <= 2150000 then
				req = 436000000
			end
			if mp > 2150000 and mp <= 2160000 then
				req = 438000000
			end
			if mp > 2160000 and mp <= 2170000 then
				req = 440000000
			end
			if mp > 2170000 and mp <= 2180000 then
				req = 442000000
			end
			if mp > 2180000 and mp <= 2190000 then
				req = 444000000
			end
			if mp > 2190000 and mp <= 2200000 then
				req = 446000000
			end
			if mp > 2200000 and mp <= 2210000 then
				req = 448000000
			end
			if mp > 2210000 and mp <= 2220000 then
				req = 450000000
			end
			if mp > 2220000 and mp <= 2230000 then
				req = 452000000
			end
			if mp > 2230000 and mp <= 2240000 then
				req = 454000000
			end
			if mp > 2240000 and mp <= 2250000 then
				req = 456000000
			end
			if mp > 2250000 and mp <= 2260000 then
				req = 458000000
			end
			if mp > 2260000 and mp <= 2270000 then
				req = 460000000
			end
			if mp > 2270000 and mp <= 2280000 then
				req = 462000000
			end
			if mp > 2280000 and mp <= 2290000 then
				req = 464000000
			end
			if mp > 2290000 and mp <= 2300000 then
				req = 466000000
			end
			if mp > 2300000 and mp <= 2310000 then
				req = 468000000
			end
			if mp > 2310000 and mp <= 2320000 then
				req = 470000000
			end
			if mp > 2320000 and mp <= 2330000 then
				req = 472000000
			end
			if mp > 2330000 and mp <= 2340000 then
				req = 474000000
			end
			if mp > 2340000 and mp <= 2350000 then
				req = 476000000
			end
			if mp > 2350000 and mp <= 2360000 then
				req = 478000000
			end
			if mp > 2360000 and mp <= 2370000 then
				req = 480000000
			end
			if mp > 2370000 and mp <= 2380000 then
				req = 482000000
			end
			if mp > 2380000 and mp <= 2390000 then
				req = 484000000
			end
			if mp > 2390000 and mp <= 2400000 then
				req = 486000000
			end
			if mp > 2400000 and mp <= 2410000 then
				req = 488000000
			end
			if mp > 2410000 and mp <= 2420000 then
				req = 490000000
			end
			if mp > 2420000 and mp <= 2430000 then
				req = 492000000
			end
			if mp > 2430000 and mp <= 2440000 then
				req = 494000000
			end
			if mp > 2440000 and mp <= 2450000 then
				req = 496000000
			end
			if mp > 2450000 and mp <= 2460000 then
				req = 498000000
			end
			if mp > 2460000 and mp <= 2470000 then
				req = 500000000
			end
			if mp > 2470000 and mp <= 2480000 then
				req = 502000000
			end
			if mp > 2480000 and mp <= 2490000 then
				req = 504000000
			end
			if mp > 2490000 and mp <= 2500000 then
				req = 506000000
			end
			if mp > 2500000 and mp <= 2510000 then
				req = 508000000
			end
			if mp > 2510000 and mp <= 2520000 then
				req = 510000000
			end
			if mp > 2520000 and mp <= 2530000 then
				req = 512000000
			end
			if mp > 2530000 and mp <= 2540000 then
				req = 514000000
			end
			if mp > 2540000 and mp <= 2550000 then
				req = 516000000
			end
			if mp > 2550000 and mp <= 2560000 then
				req = 518000000
			end
			if mp > 2560000 and mp <= 2570000 then
				req = 520000000
			end
			if mp > 2570000 and mp <= 2580000 then
				req = 522000000
			end
			if mp > 2580000 and mp <= 2590000 then
				req = 524000000
			end
			if mp > 2590000 and mp <= 2600000 then
				req = 526000000
			end
			if mp > 2600000 and mp <= 2610000 then
				req = 528000000
			end
			if mp > 2610000 and mp <= 2620000 then
				req = 490000000
			end
			if mp > 2620000 and mp <= 2630000 then
				req = 492000000
			end
			if mp > 2630000 and mp <= 2640000 then
				req = 494000000
			end
			if mp > 2640000 and mp <= 2650000 then
				req = 496000000
			end
			if mp > 2650000 and mp <= 2660000 then
				req = 498000000
			end
			if mp > 2660000 and mp <= 2670000 then
				req = 500000000
			end
			if mp > 2670000 and mp <= 2680000 then
				req = 502000000
			end
			if mp > 2680000 and mp <= 2690000 then
				req = 504000000
			end
			if mp > 2690000 and mp <= 2700000 then
				req = 506000000
			end
			if mp > 2700000 and mp <= 2710000 then
				req = 508000000
			end
			if mp > 2710000 and mp <= 2720000 then
				req = 510000000
			end
			if mp > 2720000 and mp <= 2730000 then
				req = 512000000
			end
			if mp > 2730000 and mp <= 2740000 then
				req = 514000000
			end
			if mp > 2740000 and mp <= 2750000 then
				req = 516000000
			end
			if mp > 2750000 and mp <= 2760000 then
				req = 518000000
			end
			if mp > 2760000 and mp <= 2770000 then
				req = 520000000
			end
			if mp > 2770000 and mp <= 2780000 then
				req = 522000000
			end
			if mp > 2780000 and mp <= 2790000 then
				req = 524000000
			end
			if mp > 2790000 and mp <= 2800000 then
				req = 526000000
			end
			if mp > 2800000 and mp <= 2810000 then
				req = 528000000
			end
			if mp > 2810000 and mp <= 2820000 then
				req = 530000000
			end
			if mp > 2820000 and mp <= 2830000 then
				req = 532000000
			end
			if mp > 2830000 and mp <= 2840000 then
				req = 534000000
			end
			if mp > 2840000 and mp <= 2850000 then
				req = 536000000
			end
			if mp > 2850000 and mp <= 2860000 then
				req = 538000000
			end
			if mp > 2860000 and mp <= 2870000 then
				req = 540000000
			end
			if mp > 2870000 and mp <= 2880000 then
				req = 542000000
			end
			if mp > 2880000 and mp <= 2890000 then
				req = 544000000
			end
			if mp > 2890000 and mp <= 2900000 then
				req = 546000000
			end
			if mp > 2900000 and mp <= 2910000 then
				req = 548000000
			end
			if mp > 2910000 and mp <= 2920000 then
				req = 550000000
			end
			if mp > 2920000 and mp <= 2930000 then
				req = 552000000
			end
			if mp > 2930000 and mp <= 2940000 then
				req = 554000000
			end
			if mp > 2940000 and mp <= 2950000 then
				req = 556000000
			end
			if mp > 2950000 and mp <= 2960000 then
				req = 558000000
			end
			if mp > 2960000 and mp <= 2970000 then
				req = 560000000
			end
			if mp > 2970000 and mp <= 2980000 then
				req = 562000000
			end
			if mp > 2980000 and mp <= 2990000 then
				req = 564000000
			end
			if mp > 2990000 and mp <= 3000000 then
				req = 566000000
			end
			if mp > 3000000 and mp <= 3010000 then
				req = 568000000
			end
			if mp > 3010000 and mp <= 3020000 then
				req = 570000000
			end
			if mp > 3020000 and mp <= 3030000 then
				req = 572000000
			end
			if mp > 3030000 and mp <= 3040000 then
				req = 574000000
			end
			if mp > 3040000 and mp <= 3050000 then
				req = 576000000
			end
			if mp > 3050000 and mp <= 3060000 then
				req = 578000000
			end
			if mp > 3060000 and mp <= 3070000 then
				req = 580000000
			end
			if mp > 3070000 and mp <= 3080000 then
				req = 582000000
			end
			if mp > 3080000 and mp <= 3090000 then
				req = 584000000
			end
			if mp > 3090000 and mp <= 3100000 then
				req = 586000000
			end
			if mp > 3100000 and mp <= 3110000 then
				req = 588000000
			end
			if mp > 3110000 and mp <= 3120000 then
				req = 590000000
			end
			if mp > 3120000 and mp <= 3130000 then
				req = 592000000
			end
			if mp > 3130000 and mp <= 3140000 then
				req = 594000000
			end
			if mp > 3140000 and mp <= 3150000 then
				req = 596000000
			end
			if mp > 3150000 and mp <= 3160000 then
				req = 598000000
			end
			if mp > 3160000 and mp <= 3170000 then
				req = 600000000
			end
			if mp > 3170000 and mp <= 3180000 then
				req = 602000000
			end
			if mp > 3180000 and mp <= 3190000 then
				req = 604000000
			end
			if mp > 3190000 and mp <= 3200000 then
				req = 606000000
			end
			if mp > 3200000 and mp <= 3210000 then
				req = 608000000
			end
			if mp > 3210000 and mp <= 3220000 then
				req = 610000000
			end
			if mp > 3220000 and mp <= 3230000 then
				req = 612000000
			end
			if mp > 3230000 and mp <= 3240000 then
				req = 614000000
			end
			if mp > 3240000 and mp <= 3250000 then
				req = 616000000
			end
			if mp > 3250000 and mp <= 3260000 then
				req = 618000000
			end
			if mp > 3260000 and mp <= 3270000 then
				req = 620000000
			end
			if mp > 3270000 and mp <= 3280000 then
				req = 622000000
			end
			if mp > 3280000 and mp <= 3290000 then
				req = 624000000
			end
			if mp > 3290000 and mp <= 3300000 then
				req = 626000000
			end
			if mp > 3300000 and mp <= 3310000 then
				req = 628000000
			end
			if mp > 3310000 and mp <= 3320000 then
				req = 630000000
			end
			if mp > 3320000 and mp <= 3330000 then
				req = 632000000
			end
			if mp > 3330000 and mp <= 3340000 then
				req = 634000000
			end
			if mp > 3340000 and mp <= 3350000 then
				req = 636000000
			end
			if mp > 3350000 and mp <= 3360000 then
				req = 638000000
			end
			if mp > 3360000 and mp <= 3370000 then
				req = 640000000
			end
			if mp > 3370000 and mp <= 3380000 then
				req = 642000000
			end
			if mp > 3380000 and mp <= 3390000 then
				req = 644000000
			end
			if mp > 3390000 and mp <= 3400000 then
				req = 646000000
			end
			if mp > 3400000 and mp <= 3410000 then
				req = 648000000
			end
			if mp > 3410000 and mp <= 3420000 then
				req = 650000000
			end
			if mp > 3420000 and mp <= 3430000 then
				req = 652000000
			end
			if mp > 3430000 and mp <= 3440000 then
				req = 654000000
			end
			if mp > 3440000 and mp <= 3450000 then
				req = 656000000
			end
			if mp > 3450000 and mp <= 3460000 then
				req = 658000000
			end
			if mp > 3460000 and mp <= 3470000 then
				req = 660000000
			end
			if mp > 3470000 and mp <= 3480000 then
				req = 662000000
			end
			if mp > 3480000 and mp <= 3490000 then
				req = 664000000
			end
			if mp > 3490000 and mp <= 3500000 then
				req = 666000000
			end
			if mp > 3500000 and mp <= 3510000 then
				req = 668000000
			end
			if mp > 3510000 and mp <= 3520000 then
				req = 670000000
			end
			if mp > 3520000 and mp <= 3530000 then
				req = 672000000
			end
			if mp > 3530000 and mp <= 3540000 then
				req = 674000000
			end
			if mp > 3540000 and mp <= 3550000 then
				req = 676000000
			end
			if mp > 3550000 and mp <= 3560000 then
				req = 678000000
			end
			if mp > 3560000 and mp <= 3570000 then
				req = 680000000
			end
			if mp > 3570000 and mp <= 3580000 then
				req = 682000000
			end
			if mp > 3580000 and mp <= 3590000 then
				req = 684000000
			end
			if mp > 3590000 and mp <= 3600000 then
				req = 686000000
			end
			if mp > 3600000 and mp <= 3610000 then
				req = 688000000
			end
			if mp > 3610000 and mp <= 3620000 then
				req = 690000000
			end
			if mp > 3620000 and mp <= 3630000 then
				req = 692000000
			end
			if mp > 3630000 and mp <= 3640000 then
				req = 694000000
			end
			if mp > 3640000 and mp <= 3650000 then
				req = 696000000
			end
			if mp > 3650000 and mp <= 3660000 then
				req = 698000000
			end
			if mp > 3660000 and mp <= 3670000 then
				req = 700000000
			end
			if mp > 3670000 and mp <= 3680000 then
				req = 702000000
			end
			if mp > 3680000 and mp <= 3690000 then
				req = 704000000
			end
			if mp > 3690000 and mp <= 3700000 then
				req = 706000000
			end
			if mp > 3700000 and mp <= 3710000 then
				req = 708000000
			end
			if mp > 3710000 and mp <= 3720000 then
				req = 710000000
			end
			if mp > 3720000 and mp <= 3730000 then
				req = 712000000
			end
			if mp > 3730000 and mp <= 3740000 then
				req = 714000000
			end
			if mp > 3740000 and mp <= 3750000 then
				req = 716000000
			end
			if mp > 3750000 and mp <= 3760000 then
				req = 718000000
			end
			if mp > 3760000 and mp <= 3770000 then
				req = 720000000
			end
			if mp > 3770000 and mp <= 3780000 then
				req = 722000000
			end
			if mp > 3780000 and mp <= 3790000 then
				req = 724000000
			end
			if mp > 3790000 and mp <= 3800000 then
				req = 726000000
			end
			if mp > 3800000 and mp <= 3810000 then
				req = 728000000
			end
			if mp > 3810000 and mp <= 3820000 then
				req = 730000000
			end
			if mp > 3820000 and mp <= 3830000 then
				req = 732000000
			end
			if mp > 3830000 and mp <= 3840000 then
				req = 734000000
			end
			if mp > 3840000 and mp <= 3850000 then
				req = 736000000
			end
			if mp > 3850000 and mp <= 3860000 then
				req = 738000000
			end
			if mp > 3860000 and mp <= 3870000 then
				req = 740000000
			end
			if mp > 3870000 and mp <= 3880000 then
				req = 742000000
			end
			if mp > 3880000 and mp <= 3890000 then
				req = 744000000
			end
			if mp > 3890000 and mp <= 3900000 then
				req = 746000000
			end
			if mp > 3900000 and mp <= 3910000 then
				req = 748000000
			end
			if mp > 3910000 and mp <= 3920000 then
				req = 750000000
			end
			if mp > 3920000 and mp <= 3930000 then
				req = 752000000
			end
			if mp > 3930000 and mp <= 3940000 then
				req = 754000000
			end
			if mp > 3940000 and mp <= 3950000 then
				req = 756000000
			end
			if mp > 3950000 and mp <= 3960000 then
				req = 758000000
			end
			if mp > 3960000 and mp <= 3970000 then
				req = 760000000
			end
			if mp > 3970000 and mp <= 3980000 then
				req = 762000000
			end
			if mp > 3980000 and mp <= 3990000 then
				req = 764000000
			end
			if mp > 3990000 and mp <= 4000000 then
				req = 766000000
			end
			if mp > 4000000 and mp <= 4010000 then
				req = 768000000
			end
			if mp > 4010000 and mp <= 4020000 then
				req = 770000000
			end
			if mp > 4020000 and mp <= 4030000 then
				req = 772000000
			end
			if mp > 4030000 and mp <= 4040000 then
				req = 774000000
			end
			if mp > 4040000 and mp <= 4050000 then
				req = 776000000
			end
			if mp > 4050000 and mp <= 4060000 then
				req = 778000000
			end
			if mp > 4060000 and mp <= 4070000 then
				req = 780000000
			end
			if mp > 4070000 and mp <= 4080000 then
				req = 782000000
			end
			if mp > 4080000 and mp <= 4090000 then
				req = 784000000
			end
			if mp > 4090000 and mp <= 4100000 then
				req = 786000000
			end
			if mp > 4100000 and mp <= 4110000 then
				req = 788000000
			end
			if mp > 4110000 and mp <= 4120000 then
				req = 790000000
			end
			if mp > 4120000 and mp <= 4130000 then
				req = 792000000
			end
			if mp > 4130000 and mp <= 4140000 then
				req = 794000000
			end
			if mp > 4140000 and mp <= 4150000 then
				req = 796000000
			end
			if mp > 4150000 and mp <= 4160000 then
				req = 798000000
			end
			if mp > 4160000 and mp <= 4170000 then
				req = 800000000
			end
			if mp > 4170000 and mp <= 4180000 then
				req = 802000000
			end
			if mp > 4180000 and mp <= 4190000 then
				req = 804000000
			end
			if mp > 4190000 and mp <= 4200000 then
				req = 806000000
			end
			if mp > 4200000 and mp <= 4210000 then
				req = 808000000
			end
			if mp > 4210000 and mp <= 4220000 then
				req = 810000000
			end
			if mp > 4220000 and mp <= 4230000 then
				req = 812000000
			end
			if mp > 4230000 and mp <= 4240000 then
				req = 814000000
			end
			if mp > 4240000 and mp <= 4250000 then
				req = 816000000
			end
			if mp > 4250000 and mp <= 4260000 then
				req = 818000000
			end
			if mp > 4260000 and mp <= 4270000 then
				req = 820000000
			end
			if mp > 4270000 and mp <= 4280000 then
				req = 822000000
			end
			if mp > 4280000 and mp <= 4290000 then
				req = 824000000
			end
			if mp > 4290000 and mp <= 4300000 then
				req = 826000000
			end
			if mp > 4300000 and mp <= 4310000 then
				req = 828000000
			end
			if mp > 4310000 and mp <= 4320000 then
				req = 830000000
			end
			if mp > 4320000 and mp <= 4330000 then
				req = 832000000
			end
			if mp > 4330000 and mp <= 4340000 then
				req = 834000000
			end
			if mp > 4340000 and mp <= 4350000 then
				req = 836000000
			end
			if mp > 4350000 and mp <= 4360000 then
				req = 838000000
			end
			if mp > 4360000 and mp <= 4370000 then
				req = 840000000
			end
			if mp > 4370000 and mp <= 4380000 then
				req = 842000000
			end
			if mp > 4380000 and mp <= 4390000 then
				req = 844000000
			end
			if mp > 4390000 and mp <= 4400000 then
				req = 846000000
			end
			if mp > 4400000 and mp <= 4410000 then
				req = 848000000
			end
			if mp > 4410000 and mp <= 4420000 then
				req = 850000000
			end
			if mp > 4420000 and mp <= 4430000 then
				req = 852000000
			end
			if mp > 4430000 and mp <= 4440000 then
				req = 854000000
			end
			if mp > 4440000 and mp <= 4450000 then
				req = 856000000
			end
			if mp > 4450000 and mp <= 4460000 then
				req = 858000000
			end
			if mp > 4460000 and mp <= 4470000 then
				req = 860000000
			end
			if mp > 4470000 and mp <= 4480000 then
				req = 862000000
			end
			if mp > 4480000 and mp <= 4490000 then
				req = 864000000
			end
			if mp > 4490000 and mp <= 4500000 then
				req = 866000000
			end
			if mp > 4500000 and mp <= 4510000 then
				req = 868000000
			end
			if mp > 4510000 and mp <= 4520000 then
				req = 870000000
			end
			if mp > 4520000 and mp <= 4530000 then
				req = 872000000
			end
			if mp > 4530000 and mp <= 4540000 then
				req = 874000000
			end
			if mp > 4540000 and mp <= 4550000 then
				req = 876000000
			end
			if mp > 4550000 and mp <= 4560000 then
				req = 878000000
			end
			if mp > 4560000 and mp <= 4570000 then
				req = 880000000
			end
			if mp > 4570000 and mp <= 4580000 then
				req = 882000000
			end
			if mp > 4580000 and mp <= 4590000 then
				req = 884000000
			end
			if mp > 4590000 and mp <= 4600000 then
				req = 886000000
			end
			if mp > 4600000 and mp <= 4610000 then
				req = 888000000
			end
			if mp > 4610000 and mp <= 4620000 then
				req = 890000000
			end
			if mp > 4620000 and mp <= 4630000 then
				req = 892000000
			end
			if mp > 4630000 and mp <= 4640000 then
				req = 894000000
			end
			if mp > 4640000 and mp <= 4650000 then
				req = 896000000
			end
			if mp > 4650000 and mp <= 4660000 then
				req = 898000000
			end
			if mp > 4660000 and mp <= 4670000 then
				req = 900000000
			end
			if mp > 4670000 and mp <= 4680000 then
				req = 902000000
			end
			if mp > 4680000 and mp <= 4690000 then
				req = 904000000
			end
			if mp > 4690000 and mp <= 4700000 then
				req = 906000000
			end
			if mp > 4700000 and mp <= 4710000 then
				req = 908000000
			end
			if mp > 4710000 and mp <= 4720000 then
				req = 910000000
			end
			if mp > 4720000 and mp <= 4730000 then
				req = 912000000
			end
			if mp > 4730000 and mp <= 4740000 then
				req = 914000000
			end
			if mp > 4740000 and mp <= 4750000 then
				req = 916000000
			end
			if mp > 4750000 and mp <= 4760000 then
				req = 918000000
			end
			if mp > 4760000 and mp <= 4770000 then
				req = 920000000
			end
			if mp > 4770000 and mp <= 4780000 then
				req = 922000000
			end
			if mp > 4780000 and mp <= 4790000 then
				req = 924000000
			end
			if mp > 4790000 and mp <= 4800000 then
				req = 926000000
			end
			if mp > 4800000 and mp <= 4810000 then
				req = 928000000
			end
			if mp > 4810000 and mp <= 4820000 then
				req = 930000000
			end
			if mp > 4820000 and mp <= 4830000 then
				req = 932000000
			end
			if mp > 4830000 and mp <= 4840000 then
				req = 934000000
			end
			if mp > 4840000 and mp <= 4850000 then
				req = 936000000
			end
			if mp > 4850000 and mp <= 4860000 then
				req = 938000000
			end
			if mp > 4860000 and mp <= 4870000 then
				req = 940000000
			end
			if mp > 4870000 and mp <= 4880000 then
				req = 942000000
			end
			if mp > 4880000 and mp <= 4890000 then
				req = 944000000
			end
			if mp > 4890000 and mp <= 4900000 then
				req = 946000000
			end
			if mp > 4900000 and mp <= 4910000 then
				req = 948000000
			end
			if mp > 4910000 and mp <= 4920000 then
				req = 950000000
			end
			if mp > 4920000 and mp <= 4930000 then
				req = 952000000
			end
			if mp > 4930000 and mp <= 4940000 then
				req = 954000000
			end
			if mp > 4940000 and mp <= 4950000 then
				req = 956000000
			end
			if mp > 4950000 and mp <= 4960000 then
				req = 958000000
			end
			if mp > 4960000 and mp <= 4970000 then
				req = 960000000
			end
			if mp > 4970000 and mp <= 4980000 then
				req = 962000000
			end
			if mp > 4980000 and mp <= 4990000 then
				req = 964000000
			end
			if mp > 4990000 and mp <= 5000000 then
				req = 966000000
			end
			if mp > 5000000 and mp <= 5010000 then
				req = 968000000
			end
			if mp > 5010000 and mp <= 5020000 then
				req = 970000000
			end
			if mp > 5020000 and mp <= 5030000 then
				req = 972000000
			end
			if mp > 5030000 and mp <= 5040000 then
				req = 974000000
			end
			if mp > 5040000 and mp <= 5050000 then
				req = 976000000
			end
			if mp > 5050000 and mp <= 5060000 then
				req = 978000000
			end
			if mp > 5060000 and mp <= 5070000 then
				req = 980000000
			end
			if mp > 5070000 and mp <= 5080000 then
				req = 982000000
			end
			if mp > 5080000 and mp <= 5090000 then
				req = 984000000
			end
			if mp > 5090000 and mp <= 5100000 then
				req = 986000000
			end
			if mp > 5100000 and mp <= 5110000 then
				req = 988000000
			end
			if mp > 5110000 and mp <= 5120000 then
				req = 990000000
			end
			if mp > 5120000 and mp <= 5130000 then
				req = 992000000
			end
			if mp > 5130000 and mp <= 5140000 then
				req = 994000000
			end
			if mp > 5140000 and mp <= 5150000 then
				req = 996000000
			end
			if mp > 5150000 and mp <= 5160000 then
				req = 998000000
			end
			if mp > 5160000 and mp <= 5170000 then
				req = 1000000000
			end
			if mp > 5170000 and mp <= 5180000 then
				req = 1002000000
			end
			if mp > 5180000 and mp <= 5190000 then
				req = 1004000000
			end
			if mp > 5190000 and mp <= 5200000 then
				req = 1006000000
			end
			if mp > 5200000 and mp <= 5210000 then
				req = 1008000000
			end
			if mp > 5210000 and mp <= 5220000 then
				req = 1010000000
			end
			if mp > 5220000 and mp <= 5230000 then
				req = 1012000000
			end
			if mp > 5230000 and mp <= 5240000 then
				req = 1014000000
			end
			if mp > 5240000 and mp <= 5250000 then
				req = 1016000000
			end
			if mp > 5250000 and mp <= 5260000 then
				req = 1018000000
			end
			if mp > 5260000 and mp <= 5270000 then
				req = 1020000000
			end
			if mp > 5270000 and mp <= 5280000 then
				req = 1022000000
			end
			if mp > 5280000 and mp <= 5290000 then
				req = 1024000000
			end
			if mp > 5290000 and mp <= 5300000 then
				req = 1026000000
			end
			if mp > 5300000 and mp <= 5310000 then
				req = 1028000000
			end
			if mp > 5310000 and mp <= 5320000 then
				req = 1030000000
			end
			if mp > 5320000 and mp <= 5330000 then
				req = 1032000000
			end
			if mp > 5330000 and mp <= 5340000 then
				req = 1034000000
			end
			if mp > 5340000 and mp <= 5350000 then
				req = 1036000000
			end
			if mp > 5350000 and mp <= 5360000 then
				req = 1038000000
			end
			if mp > 5360000 and mp <= 5370000 then
				req = 1040000000
			end
			if mp > 5370000 and mp <= 5380000 then
				req = 1042000000
			end
			if mp > 5380000 and mp <= 5390000 then
				req = 1044000000
			end
			if mp > 5390000 and mp <= 5400000 then
				req = 1046000000
			end
			if mp > 5400000 and mp <= 5410000 then
				req = 1048000000
			end
			if mp > 5410000 and mp <= 5420000 then
				req = 1050000000
			end
			if mp > 5420000 and mp <= 5430000 then
				req = 1052000000
			end
			if mp > 5430000 and mp <= 5440000 then
				req = 1054000000
			end
			if mp > 5440000 and mp <= 5450000 then
				req = 1056000000
			end
			if mp > 5450000 and mp <= 5460000 then
				req = 1058000000
			end
			if mp > 5460000 and mp <= 5470000 then
				req = 1060000000
			end
			if mp > 5470000 and mp <= 5480000 then
				req = 1062000000
			end
			if mp > 5480000 and mp <= 5490000 then
				req = 1064000000
			end
			if mp > 5490000 and mp <= 5500000 then
				req = 1066000000
			end
			if mp > 5500000 and mp <= 5510000 then
				req = 1068000000
			end
			if mp > 5510000 and mp <= 5520000 then
				req = 1070000000
			end
			if mp > 5520000 and mp <= 5530000 then
				req = 1072000000
			end
			if mp > 5530000 and mp <= 5540000 then
				req = 1074000000
			end
			if mp > 5540000 and mp <= 5550000 then
				req = 1076000000
			end
			if mp > 5550000 and mp <= 5560000 then
				req = 1078000000
			end
			if mp > 5560000 and mp <= 5570000 then
				req = 1080000000
			end
			if mp > 5570000 and mp <= 5580000 then
				req = 1082000000
			end
			if mp > 5580000 and mp <= 5590000 then
				req = 1084000000
			end
			if mp > 5590000 and mp <= 5600000 then
				req = 1086000000
			end
			if mp > 5600000 and mp <= 5610000 then
				req = 1088000000
			end
			if mp > 5610000 and mp <= 5620000 then
				req = 1090000000
			end
			if mp > 5620000 and mp <= 5630000 then
				req = 1092000000
			end
			if mp > 5630000 and mp <= 5640000 then
				req = 1094000000
			end
			if mp > 5640000 and mp <= 5650000 then
				req = 1096000000
			end
			if mp > 5650000 and mp <= 5660000 then
				req = 1098000000
			end
			if mp > 5660000 and mp <= 5670000 then
				req = 1100000000
			end
			if mp > 5670000 and mp <= 5680000 then
				req = 1102000000
			end
			if mp > 5680000 and mp <= 5690000 then
				req = 1104000000
			end
			if mp > 5690000 and mp <= 5700000 then
				req = 1106000000
			end
			if mp > 5700000 and mp <= 5710000 then
				req = 1108000000
			end
			if mp > 5710000 and mp <= 5720000 then
				req = 1110000000
			end
			if mp > 5720000 and mp <= 5730000 then
				req = 1112000000
			end
			if mp > 5730000 and mp <= 5740000 then
				req = 1114000000
			end
			if mp > 5740000 and mp <= 5750000 then
				req = 1116000000
			end
			if mp > 5750000 and mp <= 5760000 then
				req = 1118000000
			end
			if mp > 5760000 and mp <= 5770000 then
				req = 1120000000
			end
			if mp > 5770000 and mp <= 5780000 then
				req = 1122000000
			end
			if mp > 5780000 and mp <= 5790000 then
				req = 1124000000
			end
			if mp > 5790000 and mp <= 5800000 then
				req = 1126000000
			end
			if mp > 5800000 and mp <= 5810000 then
				req = 1128000000
			end
			if mp > 5810000 and mp <= 5820000 then
				req = 1130000000
			end
			if mp > 5820000 and mp <= 5830000 then
				req = 1132000000
			end
			if mp > 5830000 and mp <= 5840000 then
				req = 1134000000
			end
			if mp > 5840000 and mp <= 5850000 then
				req = 1136000000
			end
			if mp > 5850000 and mp <= 5860000 then
				req = 1138000000
			end
			if mp > 5860000 and mp <= 5870000 then
				req = 1140000000
			end
			if mp > 5870000 and mp <= 5880000 then
				req = 1142000000
			end
			if mp > 5880000 and mp <= 5890000 then
				req = 1144000000
			end
			if mp > 5890000 and mp <= 5900000 then
				req = 1146000000
			end
			if mp > 5900000 and mp <= 5910000 then
				req = 1148000000
			end
			if mp > 5910000 and mp <= 5920000 then
				req = 1150000000
			end
			if mp > 5920000 and mp <= 5930000 then
				req = 1152000000
			end
			if mp > 5930000 and mp <= 5940000 then
				req = 1154000000
			end
			if mp > 5940000 and mp <= 5950000 then
				req = 1156000000
			end
			if mp > 5950000 and mp <= 5960000 then
				req = 1158000000
			end
			if mp > 5960000 and mp <= 5970000 then
				req = 1160000000
			end
			if mp > 5970000 and mp <= 5980000 then
				req = 1162000000
			end
			if mp > 5980000 and mp <= 5990000 then
				req = 1164000000
			end
			if mp > 5990000 and mp <= 6000000 then
				req = 1166000000
			end
			if mp > 6000000 and mp <= 6010000 then
				req = 1168000000
			end
			if mp > 6010000 and mp <= 6020000 then
				req = 1170000000
			end
			if mp > 6020000 and mp <= 6030000 then
				req = 1172000000
			end
			if mp > 6030000 and mp <= 6040000 then
				req = 1174000000
			end
			if mp > 6040000 and mp <= 6050000 then
				req = 1176000000
			end
			if mp > 6050000 and mp <= 6060000 then
				req = 1178000000
			end
			if mp > 6060000 and mp <= 6070000 then
				req = 1180000000
			end
			if mp > 6070000 and mp <= 6080000 then
				req = 1182000000
			end
			if mp > 6080000 and mp <= 6090000 then
				req = 1184000000
			end
			if mp > 6090000 and mp <= 6100000 then
				req = 1186000000
			end
			if mp > 6100000 and mp <= 6110000 then
				req = 1188000000
			end
			if mp > 6110000 and mp <= 6120000 then
				req = 1190000000
			end
			if mp > 6120000 and mp <= 6130000 then
				req = 1192000000
			end
			if mp > 6130000 and mp <= 6140000 then
				req = 1194000000
			end
			if mp > 6140000 and mp <= 6150000 then
				req = 1196000000
			end
			if mp > 6150000 and mp <= 6160000 then
				req = 1198000000
			end
			if mp > 6160000 and mp <= 6170000 then
				req = 1200000000
			end
			if mp > 6170000 and mp <= 6180000 then
				req = 1202000000
			end
			if mp > 6180000 and mp <= 6190000 then
				req = 1204000000
			end
			if mp > 6190000 and mp <= 6200000 then
				req = 1206000000
			end
			if mp > 6200000 and mp <= 6210000 then
				req = 1208000000
			end
			if mp > 6210000 and mp <= 6220000 then
				req = 1210000000
			end
			if mp > 6220000 and mp <= 6230000 then
				req = 1212000000
			end
			if mp > 6230000 and mp <= 6240000 then
				req = 1214000000
			end
			if mp > 6240000 and mp <= 6250000 then
				req = 1216000000
			end
			if mp > 6250000 and mp <= 6260000 then
				req = 1218000000
			end
			if mp > 6260000 and mp <= 6270000 then
				req = 1220000000
			end
			if mp > 6270000 and mp <= 6280000 then
				req = 1222000000
			end
			if mp > 6280000 and mp <= 6290000 then
				req = 1224000000
			end
			if mp > 6290000 and mp <= 6300000 then
				req = 1226000000
			end
			if mp > 6300000 and mp <= 6310000 then
				req = 1228000000
			end
			if mp > 6310000 and mp <= 6320000 then
				req = 1230000000
			end
			if mp > 6320000 and mp <= 6330000 then
				req = 1232000000
			end
			if mp > 6330000 and mp <= 6340000 then
				req = 1234000000
			end
			if mp > 6340000 and mp <= 6350000 then
				req = 1236000000
			end
			if mp > 6350000 and mp <= 6360000 then
				req = 1238000000
			end
			if mp > 6360000 and mp <= 6370000 then
				req = 1240000000
			end
			if mp > 6370000 and mp <= 6380000 then
				req = 1242000000
			end
			if mp > 6380000 and mp <= 6390000 then
				req = 1244000000
			end
			if mp > 6390000 and mp <= 6400000 then
				req = 1246000000
			end
			if mp > 6400000 and mp <= 6410000 then
				req = 1248000000
			end
			if mp > 6410000 and mp <= 6420000 then
				req = 1250000000
			end
			if mp > 6420000 and mp <= 6430000 then
				req = 1252000000
			end
			if mp > 6430000 and mp <= 6440000 then
				req = 1254000000
			end
			if mp > 6440000 and mp <= 6450000 then
				req = 1256000000
			end
			if mp > 6450000 and mp <= 6460000 then
				req = 1258000000
			end
			if mp > 6460000 and mp <= 6470000 then
				req = 1260000000
			end
			if mp > 6470000 and mp <= 6480000 then
				req = 1262000000
			end
			if mp > 6480000 and mp <= 6490000 then
				req = 1264000000
			end
			if mp > 6490000 and mp <= 6500000 then
				req = 1266000000
			end
			if mp > 6500000 and mp <= 6510000 then
				req = 1268000000
			end
			if mp > 6510000 and mp <= 6520000 then
				req = 1270000000
			end
			if mp > 6520000 and mp <= 6530000 then
				req = 1272000000
			end
			if mp > 6530000 and mp <= 6540000 then
				req = 1274000000
			end
			if mp > 6540000 and mp <= 6550000 then
				req = 1276000000
			end
			if mp > 6550000 and mp <= 6560000 then
				req = 1278000000
			end
			if mp > 6560000 and mp <= 6570000 then
				req = 1280000000
			end
			if mp > 6570000 and mp <= 6580000 then
				req = 1282000000
			end
			if mp > 6580000 and mp <= 6590000 then
				req = 1284000000
			end
			if mp > 6590000 and mp <= 6600000 then
				req = 1286000000
			end
			if mp > 6600000 and mp <= 6610000 then
				req = 1288000000
			end
			if mp > 6610000 and mp <= 6620000 then
				req = 1290000000
			end
			if mp > 6620000 and mp <= 6630000 then
				req = 1292000000
			end
			if mp > 6630000 and mp <= 6640000 then
				req = 1294000000
			end
			if mp > 6640000 and mp <= 6650000 then
				req = 1296000000
			end
			if mp > 6650000 and mp <= 6660000 then
				req = 1298000000
			end
			if mp > 6660000 and mp <= 6670000 then
				req = 1300000000
			end
			if mp > 6670000 and mp <= 6680000 then
				req = 1302000000
			end
			if mp > 6680000 and mp <= 6690000 then
				req = 1304000000
			end
			if mp > 6690000 and mp <= 6700000 then
				req = 1306000000
			end
			if mp > 6700000 and mp <= 6710000 then
				req = 1308000000
			end
			if mp > 6710000 and mp <= 6720000 then
				req = 1310000000
			end
			if mp > 6720000 and mp <= 6730000 then
				req = 1312000000
			end
			if mp > 6730000 and mp <= 6740000 then
				req = 1314000000
			end
			if mp > 6740000 and mp <= 6750000 then
				req = 1316000000
			end
			if mp > 6750000 and mp <= 6760000 then
				req = 1318000000
			end
			if mp > 6760000 and mp <= 6770000 then
				req = 1320000000
			end
			if mp > 6770000 and mp <= 6780000 then
				req = 1322000000
			end
			if mp > 6780000 and mp <= 6790000 then
				req = 1324000000
			end
			if mp > 6790000 and mp <= 6800000 then
				req = 1326000000
			end
			if mp > 6800000 and mp <= 6810000 then
				req = 1328000000
			end
			if mp > 6810000 and mp <= 6820000 then
				req = 1330000000
			end
			if mp > 6820000 and mp <= 6830000 then
				req = 1332000000
			end
			if mp > 6830000 and mp <= 6840000 then
				req = 1334000000
			end
			if mp > 6840000 and mp <= 6850000 then
				req = 1336000000
			end
			if mp > 6850000 and mp <= 6860000 then
				req = 1338000000
			end
			if mp > 6860000 and mp <= 6870000 then
				req = 1340000000
			end
			if mp > 6870000 and mp <= 6880000 then
				req = 1342000000
			end
			if mp > 6880000 and mp <= 6890000 then
				req = 1344000000
			end
			if mp > 6890000 and mp <= 6900000 then
				req = 1346000000
			end
			if mp > 6900000 and mp <= 6910000 then
				req = 1348000000
			end
			if mp > 6910000 and mp <= 6920000 then
				req = 1350000000
			end
			if mp > 6920000 and mp <= 6930000 then
				req = 1352000000
			end
			if mp > 6930000 and mp <= 6940000 then
				req = 1354000000
			end
			if mp > 6940000 and mp <= 6950000 then
				req = 1356000000
			end
			if mp > 6950000 and mp <= 6960000 then
				req = 1358000000
			end
			if mp > 6960000 and mp <= 6970000 then
				req = 1360000000
			end
			if mp > 6970000 and mp <= 6980000 then
				req = 1362000000
			end
			if mp > 6980000 and mp <= 6990000 then
				req = 1364000000
			end
			if mp > 6990000 and mp <= 7000000 then
				req = 1366000000
			end
			if mp > 7000000 and mp <= 7010000 then
				req = 1368000000
			end
			if mp > 7010000 and mp <= 7020000 then
				req = 1370000000
			end
			if mp > 7020000 and mp <= 7030000 then
				req = 1372000000
			end
			if mp > 7030000 and mp <= 7040000 then
				req = 1374000000
			end
			if mp > 7040000 and mp <= 7050000 then
				req = 1376000000
			end
			if mp > 7050000 and mp <= 7060000 then
				req = 1378000000
			end
			if mp > 7060000 and mp <= 7070000 then
				req = 1380000000
			end
			if mp > 7070000 and mp <= 7080000 then
				req = 1382000000
			end
			if mp > 7080000 and mp <= 7090000 then
				req = 1384000000
			end
			if mp > 7090000 and mp <= 7100000 then
				req = 1386000000
			end
			if mp > 7100000 and mp <= 7110000 then
				req = 1388000000
			end
			if mp > 7110000 and mp <= 7120000 then
				req = 1390000000
			end
			if mp > 7120000 and mp <= 7130000 then
				req = 1392000000
			end
			if mp > 7130000 and mp <= 7140000 then
				req = 1394000000
			end
			if mp > 7140000 and mp <= 7150000 then
				req = 1396000000
			end
			if mp > 7150000 and mp <= 7160000 then
				req = 1398000000
			end
			if mp > 7160000 and mp <= 7170000 then
				req = 1400000000
			end
			if mp > 7170000 and mp <= 7180000 then
				req = 1402000000
			end
			if mp > 7180000 and mp <= 7190000 then
				req = 1404000000
			end
			if mp > 7190000 and mp <= 7200000 then
				req = 1406000000
			end
			if mp > 7200000 and mp <= 7210000 then
				req = 1408000000
			end
			if mp > 7210000 and mp <= 7220000 then
				req = 1410000000
			end
			if mp > 7220000 and mp <= 7230000 then
				req = 1412000000
			end
			if mp > 7230000 and mp <= 7240000 then
				req = 1414000000
			end
			if mp > 7240000 and mp <= 7250000 then
				req = 1416000000
			end
			if mp > 7250000 and mp <= 7260000 then
				req = 1418000000
			end
			if mp > 7260000 and mp <= 7270000 then
				req = 1420000000
			end
			if mp > 7270000 and mp <= 7280000 then
				req = 1422000000
			end
			if mp > 7280000 and mp <= 7290000 then
				req = 1424000000
			end
			if mp > 7290000 and mp <= 7300000 then
				req = 1426000000
			end
			if mp > 7300000 and mp <= 7310000 then
				req = 1428000000
			end
			if mp > 7310000 and mp <= 7320000 then
				req = 1430000000
			end
			if mp > 7320000 and mp <= 7330000 then
				req = 1432000000
			end
			if mp > 7330000 and mp <= 7340000 then
				req = 1434000000
			end
			if mp > 7340000 and mp <= 7350000 then
				req = 1436000000
			end
			if mp > 7350000 and mp <= 7360000 then
				req = 1438000000
			end
			if mp > 7360000 and mp <= 7370000 then
				req = 1440000000
			end
			if mp > 7370000 and mp <= 7380000 then
				req = 1442000000
			end
			if mp > 7380000 and mp <= 7390000 then
				req = 1444000000
			end
			if mp > 7390000 and mp <= 7400000 then
				req = 1446000000
			end
			if mp > 7400000 and mp <= 7410000 then
				req = 1448000000
			end
			if mp > 7410000 and mp <= 7420000 then
				req = 1450000000
			end
			if mp > 7420000 and mp <= 7430000 then
				req = 1452000000
			end
			if mp > 7430000 and mp <= 7440000 then
				req = 1454000000
			end
			if mp > 7440000 and mp <= 7450000 then
				req = 1456000000
			end
			if mp > 7450000 and mp <= 7460000 then
				req = 1458000000
			end
			if mp > 7460000 and mp <= 7470000 then
				req = 1460000000
			end
			if mp > 7470000 and mp <= 7480000 then
				req = 1462000000
			end
			if mp > 7480000 and mp <= 7490000 then
				req = 1464000000
			end
			if mp > 7490000 and mp <= 7500000 then
				req = 1466000000
			end
			if mp > 7500000 and mp <= 7510000 then
				req = 1468000000
			end
			if mp > 7510000 and mp <= 7520000 then
				req = 1470000000
			end
			if mp > 7520000 and mp <= 7530000 then
				req = 1472000000
			end
			if mp > 7530000 and mp <= 7540000 then
				req = 1474000000
			end
			if mp > 7540000 and mp <= 7550000 then
				req = 1476000000
			end
			if mp > 7550000 and mp <= 7560000 then
				req = 1478000000
			end
			if mp > 7560000 and mp <= 7570000 then
				req = 1480000000
			end
			if mp > 7570000 and mp <= 7580000 then
				req = 1482000000
			end
			if mp > 7580000 and mp <= 7590000 then
				req = 1484000000
			end
			if mp > 7590000 and mp <= 7600000 then
				req = 1486000000
			end
			if mp > 7600000 and mp <= 7610000 then
				req = 1488000000
			end
			if mp > 7610000 and mp <= 7620000 then
				req = 1490000000
			end
			if mp > 7620000 and mp <= 7630000 then
				req = 1492000000
			end
			if mp > 7630000 and mp <= 7640000 then
				req = 1494000000
			end
			if mp > 7640000 and mp <= 7650000 then
				req = 1496000000
			end
			if mp > 7650000 and mp <= 7660000 then
				req = 1498000000
			end
			if mp > 7660000 and mp <= 7670000 then
				req = 1500000000
			end
			if mp > 7670000 and mp <= 7680000 then
				req = 1502000000
			end
			if mp > 7680000 and mp <= 7690000 then
				req = 1504000000
			end
			if mp > 7690000 and mp <= 7700000 then
				req = 1506000000
			end
			if mp > 7700000 and mp <= 7710000 then
				req = 1508000000
			end
			if mp > 7710000 and mp <= 7720000 then
				req = 1510000000
			end
			if mp > 7720000 and mp <= 7730000 then
				req = 1512000000
			end
			if mp > 7730000 and mp <= 7740000 then
				req = 1514000000
			end
			if mp > 7740000 and mp <= 7750000 then
				req = 1516000000
			end
			if mp > 7750000 and mp <= 7760000 then
				req = 1518000000
			end
			if mp > 7760000 and mp <= 7770000 then
				req = 1520000000
			end
			if mp > 7770000 and mp <= 7780000 then
				req = 1522000000
			end
			if mp > 7780000 and mp <= 7790000 then
				req = 1524000000
			end
			if mp > 7790000 and mp <= 7800000 then
				req = 1526000000
			end
			if mp > 7800000 and mp <= 7810000 then
				req = 1528000000
			end
			if mp > 7810000 and mp <= 7820000 then
				req = 1530000000
			end
			if mp > 7820000 and mp <= 7830000 then
				req = 1532000000
			end
			if mp > 7830000 and mp <= 7840000 then
				req = 1534000000
			end
			if mp > 7840000 and mp <= 7850000 then
				req = 1536000000
			end
			if mp > 7850000 and mp <= 7860000 then
				req = 1538000000
			end
			if mp > 7860000 and mp <= 7870000 then
				req = 1540000000
			end
			if mp > 7870000 and mp <= 7880000 then
				req = 1542000000
			end
			if mp > 7880000 and mp <= 7890000 then
				req = 1544000000
			end
			if mp > 7890000 and mp <= 7900000 then
				req = 1546000000
			end
			if mp > 7900000 and mp <= 7910000 then
				req = 1548000000
			end
			if mp > 7910000 and mp <= 7920000 then
				req = 1550000000
			end
			if mp > 7920000 and mp <= 7930000 then
				req = 1552000000
			end
			if mp > 7930000 and mp <= 7940000 then
				req = 1554000000
			end
			if mp > 7940000 and mp <= 7950000 then
				req = 1556000000
			end
			if mp > 7950000 and mp <= 7960000 then
				req = 1558000000
			end
			if mp > 7960000 and mp <= 7970000 then
				req = 1560000000
			end
			if mp > 7970000 and mp <= 7980000 then
				req = 1562000000
			end
			if mp > 7980000 and mp <= 7990000 then
				req = 1564000000
			end
			if mp > 7990000 and mp <= 8000000 then
				req = 1566000000
			end
			if mp > 8000000 and mp <= 8010000 then
				req = 1568000000
			end
			if mp > 8010000 and mp <= 8020000 then
				req = 1570000000
			end
			if mp > 8020000 and mp <= 8030000 then
				req = 1572000000
			end
			if mp > 8030000 and mp <= 8040000 then
				req = 1574000000
			end
			if mp > 8040000 and mp <= 8050000 then
				req = 1576000000
			end
			if mp > 8050000 and mp <= 8060000 then
				req = 1578000000
			end
			if mp > 8060000 and mp <= 8070000 then
				req = 1580000000
			end
			if mp > 8070000 and mp <= 8080000 then
				req = 1582000000
			end
			if mp > 8080000 and mp <= 8090000 then
				req = 1584000000
			end
			if mp > 8090000 and mp <= 8100000 then
				req = 1586000000
			end
			if mp > 8100000 and mp <= 8110000 then
				req = 1588000000
			end
			if mp > 8110000 and mp <= 8120000 then
				req = 1590000000
			end
			if mp > 8120000 and mp <= 8130000 then
				req = 1592000000
			end
			if mp > 8130000 and mp <= 8140000 then
				req = 1594000000
			end
			if mp > 8140000 and mp <= 8150000 then
				req = 1596000000
			end
			if mp > 8150000 and mp <= 8160000 then
				req = 1598000000
			end
			if mp > 8160000 and mp <= 8170000 then
				req = 1600000000
			end
			if mp > 8170000 and mp <= 8180000 then
				req = 1602000000
			end
			if mp > 8180000 and mp <= 8190000 then
				req = 1604000000
			end
			if mp > 8190000 and mp <= 8200000 then
				req = 1606000000
			end
			if mp > 8200000 and mp <= 8210000 then
				req = 1608000000
			end
			if mp > 8210000 and mp <= 8220000 then
				req = 1610000000
			end
			if mp > 8220000 and mp <= 8230000 then
				req = 1612000000
			end
			if mp > 8230000 and mp <= 8240000 then
				req = 1614000000
			end
			if mp > 8240000 and mp <= 8250000 then
				req = 1616000000
			end
			if mp > 8250000 and mp <= 8260000 then
				req = 1618000000
			end
			if mp > 8260000 and mp <= 8270000 then
				req = 1620000000
			end
			if mp > 8270000 and mp <= 8280000 then
				req = 1622000000
			end
			if mp > 8280000 and mp <= 8290000 then
				req = 1624000000
			end
			if mp > 8290000 and mp <= 8300000 then
				req = 1626000000
			end
			if mp > 8300000 and mp <= 8310000 then
				req = 1628000000
			end
			if mp > 8310000 and mp <= 8320000 then
				req = 1630000000
			end
			if mp > 8320000 and mp <= 8330000 then
				req = 1632000000
			end
			if mp > 8330000 and mp <= 8340000 then
				req = 1634000000
			end
			if mp > 8340000 and mp <= 8350000 then
				req = 1636000000
			end
			if mp > 8350000 and mp <= 8360000 then
				req = 1638000000
			end
			if mp > 8360000 and mp <= 8370000 then
				req = 1640000000
			end
			if mp > 8370000 and mp <= 8380000 then
				req = 1642000000
			end
			if mp > 8380000 and mp <= 8390000 then
				req = 1644000000
			end
			if mp > 8390000 and mp <= 8400000 then
				req = 1646000000
			end
			if mp > 8400000 and mp <= 8410000 then
				req = 1648000000
			end
			if mp > 8410000 and mp <= 8420000 then
				req = 1650000000
			end
			if mp > 8420000 and mp <= 8430000 then
				req = 1652000000
			end
			if mp > 8430000 and mp <= 8440000 then
				req = 1654000000
			end
			if mp > 8440000 and mp <= 8450000 then
				req = 1656000000
			end
			if mp > 8450000 and mp <= 8460000 then
				req = 1658000000
			end
			if mp > 8460000 and mp <= 8470000 then
				req = 1660000000
			end
			if mp > 8470000 and mp <= 8480000 then
				req = 1662000000
			end
			if mp > 8480000 and mp <= 8490000 then
				req = 1664000000
			end
			if mp > 8490000 and mp <= 8500000 then
				req = 1666000000
			end
			if mp > 8500000 and mp <= 8510000 then
				req = 1668000000
			end
			if mp > 8510000 and mp <= 8520000 then
				req = 1670000000
			end
			if mp > 8520000 and mp <= 8530000 then
				req = 1672000000
			end
			if mp > 8530000 and mp <= 8540000 then
				req = 1674000000
			end
			if mp > 8540000 and mp <= 8550000 then
				req = 1676000000
			end
			if mp > 8550000 and mp <= 8560000 then
				req = 1678000000
			end
			if mp > 8560000 and mp <= 8570000 then
				req = 1680000000
			end
			if mp > 8570000 and mp <= 8580000 then
				req = 1682000000
			end
			if mp > 8580000 and mp <= 8590000 then
				req = 1684000000
			end
			if mp > 8590000 and mp <= 8600000 then
				req = 1686000000
			end
			if mp > 8600000 and mp <= 8610000 then
				req = 1688000000
			end
			if mp > 8610000 and mp <= 8620000 then
				req = 1690000000
			end
			if mp > 8620000 and mp <= 8630000 then
				req = 1692000000
			end
			if mp > 8630000 and mp <= 8640000 then
				req = 1694000000
			end
			if mp > 8640000 and mp <= 8650000 then
				req = 1696000000
			end
			if mp > 8650000 and mp <= 8660000 then
				req = 1698000000
			end
			if mp > 8660000 and mp <= 8670000 then
				req = 1700000000
			end
			if mp > 8670000 and mp <= 8680000 then
				req = 1702000000
			end
			if mp > 8680000 and mp <= 8690000 then
				req = 1704000000
			end
			if mp > 8690000 and mp <= 8700000 then
				req = 1706000000
			end
			if mp > 8700000 and mp <= 8710000 then
				req = 1708000000
			end
			if mp > 8710000 and mp <= 8720000 then
				req = 1710000000
			end
			if mp > 8720000 and mp <= 8730000 then
				req = 1712000000
			end
			if mp > 8730000 and mp <= 8740000 then
				req = 1714000000
			end
			if mp > 8740000 and mp <= 8750000 then
				req = 1716000000
			end
			if mp > 8750000 and mp <= 8760000 then
				req = 1718000000
			end
			if mp > 8760000 and mp <= 8770000 then
				req = 1720000000
			end
			if mp > 8770000 and mp <= 8780000 then
				req = 1722000000
			end
			if mp > 8780000 and mp <= 8790000 then
				req = 1724000000
			end
			if mp > 8790000 and mp <= 8800000 then
				req = 1726000000
			end
			if mp > 8800000 and mp <= 8810000 then
				req = 1728000000
			end
			if mp > 8810000 and mp <= 8820000 then
				req = 1730000000
			end
			if mp > 8820000 and mp <= 8830000 then
				req = 1732000000
			end
			if mp > 8830000 and mp <= 8840000 then
				req = 1734000000
			end
			if mp > 8840000 and mp <= 8850000 then
				req = 1736000000
			end
			if mp > 8850000 and mp <= 8860000 then
				req = 1738000000
			end
			if mp > 8860000 and mp <= 8870000 then
				req = 1740000000
			end
			if mp > 8870000 and mp <= 8880000 then
				req = 1742000000
			end
			if mp > 8880000 and mp <= 8890000 then
				req = 1744000000
			end
			if mp > 8890000 and mp <= 8900000 then
				req = 1746000000
			end
			if mp > 8900000 and mp <= 8910000 then
				req = 1748000000
			end
			if mp > 8910000 and mp <= 8920000 then
				req = 1750000000
			end
			if mp > 8920000 and mp <= 8930000 then
				req = 1752000000
			end
			if mp > 8930000 and mp <= 8940000 then
				req = 1754000000
			end
			if mp > 8940000 and mp <= 8950000 then
				req = 1756000000
			end
			if mp > 8950000 and mp <= 8960000 then
				req = 1758000000
			end
			if mp > 8960000 and mp <= 8970000 then
				req = 1760000000
			end
			if mp > 8970000 and mp <= 8980000 then
				req = 1762000000
			end
			if mp > 8980000 and mp <= 8990000 then
				req = 1764000000
			end
			if mp > 8990000 and mp <= 9000000 then
				req = 1766000000
			end
			if mp > 9000000 and mp <= 9010000 then
				req = 1768000000
			end
			if mp > 9010000 and mp <= 9020000 then
				req = 1770000000
			end
			if mp > 9020000 and mp <= 9030000 then
				req = 1772000000
			end
			if mp > 9030000 and mp <= 9040000 then
				req = 1774000000
			end
			if mp > 9040000 and mp <= 9050000 then
				req = 1776000000
			end
			if mp > 9050000 and mp <= 9060000 then
				req = 1778000000
			end
			if mp > 9060000 and mp <= 9070000 then
				req = 1780000000
			end
			if mp > 9070000 and mp <= 9080000 then
				req = 1782000000
			end
			if mp > 9080000 and mp <= 9090000 then
				req = 1784000000
			end
			if mp > 9090000 and mp <= 9100000 then
				req = 1786000000
			end
			if mp > 9100000 and mp <= 9110000 then
				req = 1788000000
			end
			if mp > 9110000 and mp <= 9120000 then
				req = 1790000000
			end
			if mp > 9120000 and mp <= 9130000 then
				req = 1792000000
			end
			if mp > 9130000 and mp <= 9140000 then
				req = 1794000000
			end
			if mp > 9140000 and mp <= 9150000 then
				req = 1796000000
			end
			if mp > 9150000 and mp <= 9160000 then
				req = 1798000000
			end
			if mp > 9160000 and mp <= 9170000 then
				req = 1800000000
			end
			if mp > 9170000 and mp <= 9180000 then
				req = 1802000000
			end
			if mp > 9180000 and mp <= 9190000 then
				req = 1804000000
			end
			if mp > 9190000 and mp <= 9200000 then
				req = 1806000000
			end
			if mp > 9200000 and mp <= 9210000 then
				req = 1808000000
			end
			if mp > 9210000 and mp <= 9220000 then
				req = 1810000000
			end
			if mp > 9220000 and mp <= 9230000 then
				req = 1812000000
			end
			if mp > 9230000 and mp <= 9240000 then
				req = 1814000000
			end
			if mp > 9240000 and mp <= 9250000 then
				req = 1816000000
			end
			if mp > 9250000 and mp <= 9260000 then
				req = 1818000000
			end
			if mp > 9260000 and mp <= 9270000 then
				req = 1820000000
			end
			if mp > 9270000 and mp <= 9280000 then
				req = 1822000000
			end
			if mp > 9280000 and mp <= 9290000 then
				req = 1824000000
			end
			if mp > 9290000 and mp <= 9300000 then
				req = 1826000000
			end
			if mp > 9300000 and mp <= 9310000 then
				req = 1828000000
			end
			if mp > 9310000 and mp <= 9320000 then
				req = 1830000000
			end
			if mp > 9320000 and mp <= 9330000 then
				req = 1832000000
			end
			if mp > 9330000 and mp <= 9340000 then
				req = 1834000000
			end
			if mp > 9340000 and mp <= 9350000 then
				req = 1836000000
			end
			if mp > 9350000 and mp <= 9360000 then
				req = 1838000000
			end
			if mp > 9360000 and mp <= 9370000 then
				req = 1840000000
			end
			if mp > 9370000 and mp <= 9380000 then
				req = 1842000000
			end
			if mp > 9380000 and mp <= 9390000 then
				req = 1844000000
			end
			if mp > 9390000 and mp <= 9400000 then
				req = 1846000000
			end
			if mp > 9400000 and mp <= 9410000 then
				req = 1848000000
			end
			if mp > 9410000 and mp <= 9420000 then
				req = 1850000000
			end
			if mp > 9420000 and mp <= 9430000 then
				req = 1852000000
			end
			if mp > 9430000 and mp <= 9440000 then
				req = 1854000000
			end
			if mp > 9440000 and mp <= 9450000 then
				req = 1856000000
			end
			if mp > 9450000 and mp <= 9460000 then
				req = 1858000000
			end
			if mp > 9460000 and mp <= 9470000 then
				req = 1860000000
			end
			if mp > 9470000 and mp <= 9480000 then
				req = 1862000000
			end
			if mp > 9480000 and mp <= 9490000 then
				req = 1864000000
			end
			if mp > 9490000 and mp <= 9500000 then
				req = 1866000000
			end
			if mp > 9500000 and mp <= 9510000 then
				req = 1868000000
			end
			if mp > 9510000 and mp <= 9520000 then
				req = 1870000000
			end
			if mp > 9520000 and mp <= 9530000 then
				req = 1872000000
			end
			if mp > 9530000 and mp <= 9540000 then
				req = 1874000000
			end
			if mp > 9540000 and mp <= 9550000 then
				req = 1876000000
			end
			if mp > 9550000 and mp <= 9560000 then
				req = 1878000000
			end
			if mp > 9560000 and mp <= 9570000 then
				req = 1880000000
			end
			if mp > 9570000 and mp <= 9580000 then
				req = 1882000000
			end
			if mp > 9580000 and mp <= 9590000 then
				req = 1884000000
			end
			if mp > 9590000 and mp <= 9600000 then
				req = 1886000000
			end
			if mp > 9600000 and mp <= 9610000 then
				req = 1888000000
			end
			if mp > 9610000 and mp <= 9620000 then
				req = 1890000000
			end
			if mp > 9620000 and mp <= 9630000 then
				req = 1892000000
			end
			if mp > 9630000 and mp <= 9640000 then
				req = 1894000000
			end
			if mp > 9640000 and mp <= 9650000 then
				req = 1896000000
			end
			if mp > 9650000 and mp <= 9660000 then
				req = 1898000000
			end
			if mp > 9660000 and mp <= 9670000 then
				req = 1900000000
			end
			if mp > 9670000 and mp <= 9680000 then
				req = 1902000000
			end
			if mp > 9680000 and mp <= 9690000 then
				req = 1904000000
			end
			if mp > 9690000 and mp <= 9700000 then
				req = 1906000000
			end
			if mp > 9700000 and mp <= 9710000 then
				req = 1908000000
			end
			if mp > 9710000 and mp <= 9720000 then
				req = 1910000000
			end
			if mp > 9720000 and mp <= 9730000 then
				req = 1912000000
			end
			if mp > 9730000 and mp <= 9740000 then
				req = 1914000000
			end
			if mp > 9740000 and mp <= 9750000 then
				req = 1916000000
			end
			if mp > 9750000 and mp <= 9760000 then
				req = 1918000000
			end
			if mp > 9760000 and mp <= 9770000 then
				req = 1920000000
			end
			if mp > 9770000 and mp <= 9780000 then
				req = 1922000000
			end
			if mp > 9780000 and mp <= 9790000 then
				req = 1924000000
			end
			if mp > 9790000 and mp <= 9800000 then
				req = 1926000000
			end
			if mp > 9800000 and mp <= 9810000 then
				req = 1928000000
			end
			if mp > 9810000 and mp <= 9820000 then
				req = 1930000000
			end
			if mp > 9820000 and mp <= 9830000 then
				req = 1932000000
			end
			if mp > 9830000 and mp <= 9840000 then
				req = 1934000000
			end
			if mp > 9840000 and mp <= 9850000 then
				req = 1936000000
			end
			if mp > 9850000 and mp <= 9860000 then
				req = 1938000000
			end
			if mp > 9860000 and mp <= 9870000 then
				req = 1940000000
			end
			if mp > 9870000 and mp <= 9880000 then
				req = 1942000000
			end
			if mp > 9880000 and mp <= 9890000 then
				req = 1944000000
			end
			if mp > 9890000 and mp <= 9900000 then
				req = 1946000000
			end
			if mp > 9900000 and mp <= 9910000 then
				req = 1948000000
			end
			if mp > 9910000 and mp <= 9920000 then
				req = 1950000000
			end
			if mp > 9920000 and mp <= 9930000 then
				req = 1952000000
			end
			if mp > 9930000 and mp <= 9940000 then
				req = 1954000000
			end
			if mp > 9940000 and mp <= 9950000 then
				req = 1956000000
			end
			if mp > 9950000 and mp <= 9960000 then
				req = 1958000000
			end
			if mp > 9960000 and mp <= 9970000 then
				req = 1960000000
			end
			if mp > 9970000 and mp <= 9980000 then
				req = 1962000000
			end
			if mp > 9980000 and mp <= 9990000 then
				req = 1964000000
			end
			if mp > 9990000 and mp <= 10000000 then
				req = 1966000000
			end
			if mp > 10000000 and mp <= 10010000 then
				req = 1968000000
			end
		elseif job == 4 then -- Priest
			if mp <= 20000 then
				req = 10000000
			end
			if mp > 20000 and mp <= 30000 then
				req = 12000000
			end
			if mp > 30000 and mp <= 40000 then
				req = 14000000
			end
			if mp > 40000 and mp <= 50000 then
				req = 16000000
			end
			if mp > 50000 and mp <= 60000 then
				req = 18000000
			end
			if mp > 60000 and mp <= 70000 then
				req = 20000000
			end
			if mp > 70000 and mp <= 80000 then
				req = 22000000
			end
			if mp > 80000 and mp <= 90000 then
				req = 24000000
			end
			if mp > 90000 and mp <= 100000 then
				req = 26000000
			end
			if mp > 100000 and mp <= 110000 then
				req = 28000000
			end
			if mp > 110000 and mp <= 120000 then
				req = 30000000
			end
			if mp > 120000 and mp <= 130000 then
				req = 32000000
			end
			if mp > 130000 and mp <= 140000 then
				req = 34000000
			end
			if mp > 140000 and mp <= 150000 then
				req = 36000000
			end
			if mp > 150000 and mp <= 160000 then
				req = 38000000
			end
			if mp > 160000 and mp <= 170000 then
				req = 40000000
			end
			if mp > 170000 and mp <= 180000 then
				req = 42000000
			end
			if mp > 180000 and mp <= 190000 then
				req = 44000000
			end
			if mp > 190000 and mp <= 200000 then
				req = 46000000
			end
			if mp > 200000 and mp <= 210000 then
				req = 48000000
			end
			if mp > 210000 and mp <= 220000 then
				req = 50000000
			end
			if mp > 220000 and mp <= 230000 then
				req = 52000000
			end
			if mp > 230000 and mp <= 240000 then
				req = 54000000
			end
			if mp > 240000 and mp <= 250000 then
				req = 56000000
			end
			if mp > 250000 and mp <= 260000 then
				req = 58000000
			end
			if mp > 260000 and mp <= 270000 then
				req = 60000000
			end
			if mp > 270000 and mp <= 280000 then
				req = 62000000
			end
			if mp > 280000 and mp <= 290000 then
				req = 64000000
			end
			if mp > 290000 and mp <= 300000 then
				req = 66000000
			end
			if mp > 300000 and mp <= 310000 then
				req = 68000000
			end
			if mp > 310000 and mp <= 320000 then
				req = 70000000
			end
			if mp > 320000 and mp <= 330000 then
				req = 72000000
			end
			if mp > 330000 and mp <= 340000 then
				req = 74000000
			end
			if mp > 340000 and mp <= 350000 then
				req = 76000000
			end
			if mp > 350000 and mp <= 360000 then
				req = 78000000
			end
			if mp > 360000 and mp <= 370000 then
				req = 80000000
			end
			if mp > 370000 and mp <= 380000 then
				req = 82000000
			end
			if mp > 380000 and mp <= 390000 then
				req = 84000000
			end
			if mp > 390000 and mp <= 400000 then
				req = 86000000
			end
			if mp > 400000 and mp <= 410000 then
				req = 88000000
			end
			if mp > 410000 and mp <= 420000 then
				req = 90000000
			end
			if mp > 420000 and mp <= 430000 then
				req = 92000000
			end
			if mp > 430000 and mp <= 440000 then
				req = 94000000
			end
			if mp > 440000 and mp <= 450000 then
				req = 96000000
			end
			if mp > 450000 and mp <= 460000 then
				req = 98000000
			end
			if mp > 460000 and mp <= 470000 then
				req = 100000000
			end
			if mp > 470000 and mp <= 480000 then
				req = 102000000
			end
			if mp > 480000 and mp <= 490000 then
				req = 104000000
			end
			if mp > 490000 and mp <= 500000 then
				req = 106000000
			end
			if mp > 500000 and mp <= 510000 then
				req = 108000000
			end
			if mp > 510000 and mp <= 520000 then
				req = 110000000
			end
			if mp > 520000 and mp <= 530000 then
				req = 112000000
			end
			if mp > 530000 and mp <= 540000 then
				req = 114000000
			end
			if mp > 540000 and mp <= 550000 then
				req = 116000000
			end
			if mp > 550000 and mp <= 560000 then
				req = 118000000
			end
			if mp > 560000 and mp <= 570000 then
				req = 120000000
			end
			if mp > 570000 and mp <= 580000 then
				req = 122000000
			end
			if mp > 580000 and mp <= 590000 then
				req = 124000000
			end
			if mp > 590000 and mp <= 600000 then
				req = 126000000
			end
			if mp > 600000 and mp <= 610000 then
				req = 128000000
			end
			if mp > 610000 and mp <= 620000 then
				req = 130000000
			end
			if mp > 620000 and mp <= 630000 then
				req = 132000000
			end
			if mp > 630000 and mp <= 640000 then
				req = 134000000
			end
			if mp > 640000 and mp <= 650000 then
				req = 136000000
			end
			if mp > 650000 and mp <= 660000 then
				req = 138000000
			end
			if mp > 660000 and mp <= 670000 then
				req = 140000000
			end
			if mp > 670000 and mp <= 680000 then
				req = 142000000
			end
			if mp > 680000 and mp <= 690000 then
				req = 144000000
			end
			if mp > 690000 and mp <= 700000 then
				req = 146000000
			end
			if mp > 700000 and mp <= 710000 then
				req = 148000000
			end
			if mp > 710000 and mp <= 720000 then
				req = 150000000
			end
			if mp > 720000 and mp <= 730000 then
				req = 152000000
			end
			if mp > 730000 and mp <= 740000 then
				req = 154000000
			end
			if mp > 740000 and mp <= 750000 then
				req = 156000000
			end
			if mp > 750000 and mp <= 760000 then
				req = 158000000
			end
			if mp > 760000 and mp <= 770000 then
				req = 160000000
			end
			if mp > 770000 and mp <= 780000 then
				req = 162000000
			end
			if mp > 780000 and mp <= 790000 then
				req = 164000000
			end
			if mp > 790000 and mp <= 800000 then
				req = 166000000
			end
			if mp > 800000 and mp <= 810000 then
				req = 168000000
			end
			if mp > 810000 and mp <= 820000 then
				req = 170000000
			end
			if mp > 820000 and mp <= 830000 then
				req = 172000000
			end
			if mp > 830000 and mp <= 840000 then
				req = 174000000
			end
			if mp > 840000 and mp <= 850000 then
				req = 176000000
			end
			if mp > 850000 and mp <= 860000 then
				req = 178000000
			end
			if mp > 860000 and mp <= 870000 then
				req = 180000000
			end
			if mp > 870000 and mp <= 880000 then
				req = 182000000
			end
			if mp > 880000 and mp <= 890000 then
				req = 184000000
			end
			if mp > 890000 and mp <= 900000 then
				req = 186000000
			end
			if mp > 900000 and mp <= 910000 then
				req = 188000000
			end
			if mp > 910000 and mp <= 920000 then
				req = 190000000
			end
			if mp > 920000 and mp <= 930000 then
				req = 192000000
			end
			if mp > 930000 and mp <= 940000 then
				req = 194000000
			end
			if mp > 940000 and mp <= 950000 then
				req = 196000000
			end
			if mp > 950000 and mp <= 960000 then
				req = 198000000
			end
			if mp > 960000 and mp <= 970000 then
				req = 200000000
			end
			if mp > 970000 and mp <= 980000 then
				req = 202000000
			end
			if mp > 980000 and mp <= 990000 then
				req = 204000000
			end
			if mp > 990000 and mp <= 1000000 then
				req = 206000000
			end
			if mp > 1000000 and mp <= 1010000 then
				req = 208000000
			end
			if mp > 1010000 and mp <= 1020000 then
				req = 210000000
			end
			if mp > 1020000 and mp <= 1030000 then
				req = 212000000
			end
			if mp > 1030000 and mp <= 1040000 then
				req = 214000000
			end
			if mp > 1040000 and mp <= 1050000 then
				req = 216000000
			end
			if mp > 1050000 and mp <= 1060000 then
				req = 218000000
			end
			if mp > 1060000 and mp <= 1070000 then
				req = 220000000
			end
			if mp > 1070000 and mp <= 1080000 then
				req = 222000000
			end
			if mp > 1080000 and mp <= 1090000 then
				req = 224000000
			end
			if mp > 1090000 and mp <= 1100000 then
				req = 226000000
			end
			if mp > 1100000 and mp <= 1110000 then
				req = 228000000
			end
			if mp > 1110000 and mp <= 1120000 then
				req = 230000000
			end
			if mp > 1120000 and mp <= 1130000 then
				req = 232000000
			end
			if mp > 1130000 and mp <= 1140000 then
				req = 234000000
			end
			if mp > 1140000 and mp <= 1150000 then
				req = 236000000
			end
			if mp > 1150000 and mp <= 1160000 then
				req = 238000000
			end
			if mp > 1160000 and mp <= 1170000 then
				req = 240000000
			end
			if mp > 1170000 and mp <= 1180000 then
				req = 242000000
			end
			if mp > 1180000 and mp <= 1190000 then
				req = 244000000
			end
			if mp > 1190000 and mp <= 1200000 then
				req = 246000000
			end
			if mp > 1200000 and mp <= 1210000 then
				req = 248000000
			end
			if mp > 1210000 and mp <= 1220000 then
				req = 250000000
			end
			if mp > 1220000 and mp <= 1230000 then
				req = 252000000
			end
			if mp > 1230000 and mp <= 1240000 then
				req = 254000000
			end
			if mp > 1240000 and mp <= 1250000 then
				req = 256000000
			end
			if mp > 1250000 and mp <= 1260000 then
				req = 258000000
			end
			if mp > 1260000 and mp <= 1270000 then
				req = 260000000
			end
			if mp > 1270000 and mp <= 1280000 then
				req = 262000000
			end
			if mp > 1280000 and mp <= 1290000 then
				req = 264000000
			end
			if mp > 1290000 and mp <= 1300000 then
				req = 266000000
			end
			if mp > 1300000 and mp <= 1310000 then
				req = 268000000
			end
			if mp > 1310000 and mp <= 1320000 then
				req = 270000000
			end
			if mp > 1320000 and mp <= 1330000 then
				req = 272000000
			end
			if mp > 1330000 and mp <= 1340000 then
				req = 274000000
			end
			if mp > 1340000 and mp <= 1350000 then
				req = 276000000
			end
			if mp > 1350000 and mp <= 1360000 then
				req = 278000000
			end
			if mp > 1360000 and mp <= 1370000 then
				req = 280000000
			end
			if mp > 1370000 and mp <= 1380000 then
				req = 282000000
			end
			if mp > 1380000 and mp <= 1390000 then
				req = 284000000
			end
			if mp > 1390000 and mp <= 1400000 then
				req = 286000000
			end
			if mp > 1400000 and mp <= 1410000 then
				req = 288000000
			end
			if mp > 1410000 and mp <= 1420000 then
				req = 290000000
			end
			if mp > 1420000 and mp <= 1430000 then
				req = 292000000
			end
			if mp > 1430000 and mp <= 1440000 then
				req = 294000000
			end
			if mp > 1440000 and mp <= 1450000 then
				req = 296000000
			end
			if mp > 1450000 and mp <= 1460000 then
				req = 298000000
			end
			if mp > 1460000 and mp <= 1470000 then
				req = 300000000
			end
			if mp > 1470000 and mp <= 1480000 then
				req = 302000000
			end
			if mp > 1480000 and mp <= 1490000 then
				req = 304000000
			end
			if mp > 1490000 and mp <= 1500000 then
				req = 306000000
			end
			if mp > 1500000 and mp <= 1510000 then
				req = 308000000
			end
			if mp > 1510000 and mp <= 1520000 then
				req = 310000000
			end
			if mp > 1520000 and mp <= 1530000 then
				req = 312000000
			end
			if mp > 1530000 and mp <= 1540000 then
				req = 314000000
			end
			if mp > 1540000 and mp <= 1550000 then
				req = 316000000
			end
			if mp > 1550000 and mp <= 1560000 then
				req = 318000000
			end
			if mp > 1560000 and mp <= 1570000 then
				req = 320000000
			end
			if mp > 1570000 and mp <= 1580000 then
				req = 322000000
			end
			if mp > 1580000 and mp <= 1590000 then
				req = 324000000
			end
			if mp > 1590000 and mp <= 1600000 then
				req = 326000000
			end
			if mp > 1600000 and mp <= 1610000 then
				req = 328000000
			end
			if mp > 1610000 and mp <= 1620000 then
				req = 330000000
			end
			if mp > 1620000 and mp <= 1630000 then
				req = 332000000
			end
			if mp > 1630000 and mp <= 1640000 then
				req = 334000000
			end
			if mp > 1640000 and mp <= 1650000 then
				req = 336000000
			end
			if mp > 1650000 and mp <= 1660000 then
				req = 338000000
			end
			if mp > 1660000 and mp <= 1670000 then
				req = 340000000
			end
			if mp > 1670000 and mp <= 1680000 then
				req = 342000000
			end
			if mp > 1680000 and mp <= 1690000 then
				req = 344000000
			end
			if mp > 1690000 and mp <= 1700000 then
				req = 346000000
			end
			if mp > 1700000 and mp <= 1710000 then
				req = 348000000
			end
			if mp > 1710000 and mp <= 1720000 then
				req = 350000000
			end
			if mp > 1720000 and mp <= 1730000 then
				req = 352000000
			end
			if mp > 1730000 and mp <= 1740000 then
				req = 354000000
			end
			if mp > 1740000 and mp <= 1750000 then
				req = 356000000
			end
			if mp > 1750000 and mp <= 1760000 then
				req = 358000000
			end
			if mp > 1760000 and mp <= 1770000 then
				req = 360000000
			end
			if mp > 1770000 and mp <= 1780000 then
				req = 362000000
			end
			if mp > 1780000 and mp <= 1790000 then
				req = 364000000
			end
			if mp > 1790000 and mp <= 1800000 then
				req = 366000000
			end
			if mp > 1800000 and mp <= 1810000 then
				req = 368000000
			end
			if mp > 1810000 and mp <= 1820000 then
				req = 370000000
			end
			if mp > 1820000 and mp <= 1830000 then
				req = 372000000
			end
			if mp > 1830000 and mp <= 1840000 then
				req = 374000000
			end
			if mp > 1840000 and mp <= 1850000 then
				req = 376000000
			end
			if mp > 1850000 and mp <= 1860000 then
				req = 378000000
			end
			if mp > 1860000 and mp <= 1870000 then
				req = 380000000
			end
			if mp > 1870000 and mp <= 1880000 then
				req = 382000000
			end
			if mp > 1880000 and mp <= 1890000 then
				req = 384000000
			end
			if mp > 1890000 and mp <= 1900000 then
				req = 386000000
			end
			if mp > 1900000 and mp <= 1910000 then
				req = 388000000
			end
			if mp > 1910000 and mp <= 1920000 then
				req = 390000000
			end
			if mp > 1920000 and mp <= 1930000 then
				req = 392000000
			end
			if mp > 1930000 and mp <= 1940000 then
				req = 394000000
			end
			if mp > 1940000 and mp <= 1950000 then
				req = 396000000
			end
			if mp > 1950000 and mp <= 1960000 then
				req = 398000000
			end
			if mp > 1960000 and mp <= 1970000 then
				req = 400000000
			end
			if mp > 1970000 and mp <= 1980000 then
				req = 402000000
			end
			if mp > 1980000 and mp <= 1990000 then
				req = 404000000
			end
			if mp > 1990000 and mp <= 2000000 then
				req = 406000000
			end
			if mp > 2000000 and mp <= 2010000 then
				req = 408000000
			end
			if mp > 2010000 and mp <= 2020000 then
				req = 410000000
			end
			if mp > 2020000 and mp <= 2030000 then
				req = 412000000
			end
			if mp > 2030000 and mp <= 2040000 then
				req = 414000000
			end
			if mp > 2040000 and mp <= 2050000 then
				req = 416000000
			end
			if mp > 2050000 and mp <= 2060000 then
				req = 418000000
			end
			if mp > 2060000 and mp <= 2070000 then
				req = 420000000
			end
			if mp > 2070000 and mp <= 2080000 then
				req = 422000000
			end
			if mp > 2080000 and mp <= 2090000 then
				req = 424000000
			end
			if mp > 2090000 and mp <= 2100000 then
				req = 426000000
			end
			if mp > 2100000 and mp <= 2110000 then
				req = 428000000
			end
			if mp > 2110000 and mp <= 2120000 then
				req = 430000000
			end
			if mp > 2120000 and mp <= 2130000 then
				req = 432000000
			end
			if mp > 2130000 and mp <= 2140000 then
				req = 434000000
			end
			if mp > 2140000 and mp <= 2150000 then
				req = 436000000
			end
			if mp > 2150000 and mp <= 2160000 then
				req = 438000000
			end
			if mp > 2160000 and mp <= 2170000 then
				req = 440000000
			end
			if mp > 2170000 and mp <= 2180000 then
				req = 442000000
			end
			if mp > 2180000 and mp <= 2190000 then
				req = 444000000
			end
			if mp > 2190000 and mp <= 2200000 then
				req = 446000000
			end
			if mp > 2200000 and mp <= 2210000 then
				req = 448000000
			end
			if mp > 2210000 and mp <= 2220000 then
				req = 450000000
			end
			if mp > 2220000 and mp <= 2230000 then
				req = 452000000
			end
			if mp > 2230000 and mp <= 2240000 then
				req = 454000000
			end
			if mp > 2240000 and mp <= 2250000 then
				req = 456000000
			end
			if mp > 2250000 and mp <= 2260000 then
				req = 458000000
			end
			if mp > 2260000 and mp <= 2270000 then
				req = 460000000
			end
			if mp > 2270000 and mp <= 2280000 then
				req = 462000000
			end
			if mp > 2280000 and mp <= 2290000 then
				req = 464000000
			end
			if mp > 2290000 and mp <= 2300000 then
				req = 466000000
			end
			if mp > 2300000 and mp <= 2310000 then
				req = 468000000
			end
			if mp > 2310000 and mp <= 2320000 then
				req = 470000000
			end
			if mp > 2320000 and mp <= 2330000 then
				req = 472000000
			end
			if mp > 2330000 and mp <= 2340000 then
				req = 474000000
			end
			if mp > 2340000 and mp <= 2350000 then
				req = 476000000
			end
			if mp > 2350000 and mp <= 2360000 then
				req = 478000000
			end
			if mp > 2360000 and mp <= 2370000 then
				req = 480000000
			end
			if mp > 2370000 and mp <= 2380000 then
				req = 482000000
			end
			if mp > 2380000 and mp <= 2390000 then
				req = 484000000
			end
			if mp > 2390000 and mp <= 2400000 then
				req = 486000000
			end
			if mp > 2400000 and mp <= 2410000 then
				req = 488000000
			end
			if mp > 2410000 and mp <= 2420000 then
				req = 490000000
			end
			if mp > 2420000 and mp <= 2430000 then
				req = 492000000
			end
			if mp > 2430000 and mp <= 2440000 then
				req = 494000000
			end
			if mp > 2440000 and mp <= 2450000 then
				req = 496000000
			end
			if mp > 2450000 and mp <= 2460000 then
				req = 498000000
			end
			if mp > 2460000 and mp <= 2470000 then
				req = 500000000
			end
			if mp > 2470000 and mp <= 2480000 then
				req = 502000000
			end
			if mp > 2480000 and mp <= 2490000 then
				req = 504000000
			end
			if mp > 2490000 and mp <= 2500000 then
				req = 506000000
			end
			if mp > 2500000 and mp <= 2510000 then
				req = 508000000
			end
			if mp > 2510000 and mp <= 2520000 then
				req = 510000000
			end
			if mp > 2520000 and mp <= 2530000 then
				req = 512000000
			end
			if mp > 2530000 and mp <= 2540000 then
				req = 514000000
			end
			if mp > 2540000 and mp <= 2550000 then
				req = 516000000
			end
			if mp > 2550000 and mp <= 2560000 then
				req = 518000000
			end
			if mp > 2560000 and mp <= 2570000 then
				req = 520000000
			end
			if mp > 2570000 and mp <= 2580000 then
				req = 522000000
			end
			if mp > 2580000 and mp <= 2590000 then
				req = 524000000
			end
			if mp > 2590000 and mp <= 2600000 then
				req = 526000000
			end
			if mp > 2600000 and mp <= 2610000 then
				req = 528000000
			end
			if mp > 2610000 and mp <= 2620000 then
				req = 490000000
			end
			if mp > 2620000 and mp <= 2630000 then
				req = 492000000
			end
			if mp > 2630000 and mp <= 2640000 then
				req = 494000000
			end
			if mp > 2640000 and mp <= 2650000 then
				req = 496000000
			end
			if mp > 2650000 and mp <= 2660000 then
				req = 498000000
			end
			if mp > 2660000 and mp <= 2670000 then
				req = 500000000
			end
			if mp > 2670000 and mp <= 2680000 then
				req = 502000000
			end
			if mp > 2680000 and mp <= 2690000 then
				req = 504000000
			end
			if mp > 2690000 and mp <= 2700000 then
				req = 506000000
			end
			if mp > 2700000 and mp <= 2710000 then
				req = 508000000
			end
			if mp > 2710000 and mp <= 2720000 then
				req = 510000000
			end
			if mp > 2720000 and mp <= 2730000 then
				req = 512000000
			end
			if mp > 2730000 and mp <= 2740000 then
				req = 514000000
			end
			if mp > 2740000 and mp <= 2750000 then
				req = 516000000
			end
			if mp > 2750000 and mp <= 2760000 then
				req = 518000000
			end
			if mp > 2760000 and mp <= 2770000 then
				req = 520000000
			end
			if mp > 2770000 and mp <= 2780000 then
				req = 522000000
			end
			if mp > 2780000 and mp <= 2790000 then
				req = 524000000
			end
			if mp > 2790000 and mp <= 2800000 then
				req = 526000000
			end
			if mp > 2800000 and mp <= 2810000 then
				req = 528000000
			end
			if mp > 2810000 and mp <= 2820000 then
				req = 530000000
			end
			if mp > 2820000 and mp <= 2830000 then
				req = 532000000
			end
			if mp > 2830000 and mp <= 2840000 then
				req = 534000000
			end
			if mp > 2840000 and mp <= 2850000 then
				req = 536000000
			end
			if mp > 2850000 and mp <= 2860000 then
				req = 538000000
			end
			if mp > 2860000 and mp <= 2870000 then
				req = 540000000
			end
			if mp > 2870000 and mp <= 2880000 then
				req = 542000000
			end
			if mp > 2880000 and mp <= 2890000 then
				req = 544000000
			end
			if mp > 2890000 and mp <= 2900000 then
				req = 546000000
			end
			if mp > 2900000 and mp <= 2910000 then
				req = 548000000
			end
			if mp > 2910000 and mp <= 2920000 then
				req = 550000000
			end
			if mp > 2920000 and mp <= 2930000 then
				req = 552000000
			end
			if mp > 2930000 and mp <= 2940000 then
				req = 554000000
			end
			if mp > 2940000 and mp <= 2950000 then
				req = 556000000
			end
			if mp > 2950000 and mp <= 2960000 then
				req = 558000000
			end
			if mp > 2960000 and mp <= 2970000 then
				req = 560000000
			end
			if mp > 2970000 and mp <= 2980000 then
				req = 562000000
			end
			if mp > 2980000 and mp <= 2990000 then
				req = 564000000
			end
			if mp > 2990000 and mp <= 3000000 then
				req = 566000000
			end
			if mp > 3000000 and mp <= 3010000 then
				req = 568000000
			end
			if mp > 3010000 and mp <= 3020000 then
				req = 570000000
			end
			if mp > 3020000 and mp <= 3030000 then
				req = 572000000
			end
			if mp > 3030000 and mp <= 3040000 then
				req = 574000000
			end
			if mp > 3040000 and mp <= 3050000 then
				req = 576000000
			end
			if mp > 3050000 and mp <= 3060000 then
				req = 578000000
			end
			if mp > 3060000 and mp <= 3070000 then
				req = 580000000
			end
			if mp > 3070000 and mp <= 3080000 then
				req = 582000000
			end
			if mp > 3080000 and mp <= 3090000 then
				req = 584000000
			end
			if mp > 3090000 and mp <= 3100000 then
				req = 586000000
			end
			if mp > 3100000 and mp <= 3110000 then
				req = 588000000
			end
			if mp > 3110000 and mp <= 3120000 then
				req = 590000000
			end
			if mp > 3120000 and mp <= 3130000 then
				req = 592000000
			end
			if mp > 3130000 and mp <= 3140000 then
				req = 594000000
			end
			if mp > 3140000 and mp <= 3150000 then
				req = 596000000
			end
			if mp > 3150000 and mp <= 3160000 then
				req = 598000000
			end
			if mp > 3160000 and mp <= 3170000 then
				req = 600000000
			end
			if mp > 3170000 and mp <= 3180000 then
				req = 602000000
			end
			if mp > 3180000 and mp <= 3190000 then
				req = 604000000
			end
			if mp > 3190000 and mp <= 3200000 then
				req = 606000000
			end
			if mp > 3200000 and mp <= 3210000 then
				req = 608000000
			end
			if mp > 3210000 and mp <= 3220000 then
				req = 610000000
			end
			if mp > 3220000 and mp <= 3230000 then
				req = 612000000
			end
			if mp > 3230000 and mp <= 3240000 then
				req = 614000000
			end
			if mp > 3240000 and mp <= 3250000 then
				req = 616000000
			end
			if mp > 3250000 and mp <= 3260000 then
				req = 618000000
			end
			if mp > 3260000 and mp <= 3270000 then
				req = 620000000
			end
			if mp > 3270000 and mp <= 3280000 then
				req = 622000000
			end
			if mp > 3280000 and mp <= 3290000 then
				req = 624000000
			end
			if mp > 3290000 and mp <= 3300000 then
				req = 626000000
			end
			if mp > 3300000 and mp <= 3310000 then
				req = 628000000
			end
			if mp > 3310000 and mp <= 3320000 then
				req = 630000000
			end
			if mp > 3320000 and mp <= 3330000 then
				req = 632000000
			end
			if mp > 3330000 and mp <= 3340000 then
				req = 634000000
			end
			if mp > 3340000 and mp <= 3350000 then
				req = 636000000
			end
			if mp > 3350000 and mp <= 3360000 then
				req = 638000000
			end
			if mp > 3360000 and mp <= 3370000 then
				req = 640000000
			end
			if mp > 3370000 and mp <= 3380000 then
				req = 642000000
			end
			if mp > 3380000 and mp <= 3390000 then
				req = 644000000
			end
			if mp > 3390000 and mp <= 3400000 then
				req = 646000000
			end
			if mp > 3400000 and mp <= 3410000 then
				req = 648000000
			end
			if mp > 3410000 and mp <= 3420000 then
				req = 650000000
			end
			if mp > 3420000 and mp <= 3430000 then
				req = 652000000
			end
			if mp > 3430000 and mp <= 3440000 then
				req = 654000000
			end
			if mp > 3440000 and mp <= 3450000 then
				req = 656000000
			end
			if mp > 3450000 and mp <= 3460000 then
				req = 658000000
			end
			if mp > 3460000 and mp <= 3470000 then
				req = 660000000
			end
			if mp > 3470000 and mp <= 3480000 then
				req = 662000000
			end
			if mp > 3480000 and mp <= 3490000 then
				req = 664000000
			end
			if mp > 3490000 and mp <= 3500000 then
				req = 666000000
			end
			if mp > 3500000 and mp <= 3510000 then
				req = 668000000
			end
			if mp > 3510000 and mp <= 3520000 then
				req = 670000000
			end
			if mp > 3520000 and mp <= 3530000 then
				req = 672000000
			end
			if mp > 3530000 and mp <= 3540000 then
				req = 674000000
			end
			if mp > 3540000 and mp <= 3550000 then
				req = 676000000
			end
			if mp > 3550000 and mp <= 3560000 then
				req = 678000000
			end
			if mp > 3560000 and mp <= 3570000 then
				req = 680000000
			end
			if mp > 3570000 and mp <= 3580000 then
				req = 682000000
			end
			if mp > 3580000 and mp <= 3590000 then
				req = 684000000
			end
			if mp > 3590000 and mp <= 3600000 then
				req = 686000000
			end
			if mp > 3600000 and mp <= 3610000 then
				req = 688000000
			end
			if mp > 3610000 and mp <= 3620000 then
				req = 690000000
			end
			if mp > 3620000 and mp <= 3630000 then
				req = 692000000
			end
			if mp > 3630000 and mp <= 3640000 then
				req = 694000000
			end
			if mp > 3640000 and mp <= 3650000 then
				req = 696000000
			end
			if mp > 3650000 and mp <= 3660000 then
				req = 698000000
			end
			if mp > 3660000 and mp <= 3670000 then
				req = 700000000
			end
			if mp > 3670000 and mp <= 3680000 then
				req = 702000000
			end
			if mp > 3680000 and mp <= 3690000 then
				req = 704000000
			end
			if mp > 3690000 and mp <= 3700000 then
				req = 706000000
			end
			if mp > 3700000 and mp <= 3710000 then
				req = 708000000
			end
			if mp > 3710000 and mp <= 3720000 then
				req = 710000000
			end
			if mp > 3720000 and mp <= 3730000 then
				req = 712000000
			end
			if mp > 3730000 and mp <= 3740000 then
				req = 714000000
			end
			if mp > 3740000 and mp <= 3750000 then
				req = 716000000
			end
			if mp > 3750000 and mp <= 3760000 then
				req = 718000000
			end
			if mp > 3760000 and mp <= 3770000 then
				req = 720000000
			end
			if mp > 3770000 and mp <= 3780000 then
				req = 722000000
			end
			if mp > 3780000 and mp <= 3790000 then
				req = 724000000
			end
			if mp > 3790000 and mp <= 3800000 then
				req = 726000000
			end
			if mp > 3800000 and mp <= 3810000 then
				req = 728000000
			end
			if mp > 3810000 and mp <= 3820000 then
				req = 730000000
			end
			if mp > 3820000 and mp <= 3830000 then
				req = 732000000
			end
			if mp > 3830000 and mp <= 3840000 then
				req = 734000000
			end
			if mp > 3840000 and mp <= 3850000 then
				req = 736000000
			end
			if mp > 3850000 and mp <= 3860000 then
				req = 738000000
			end
			if mp > 3860000 and mp <= 3870000 then
				req = 740000000
			end
			if mp > 3870000 and mp <= 3880000 then
				req = 742000000
			end
			if mp > 3880000 and mp <= 3890000 then
				req = 744000000
			end
			if mp > 3890000 and mp <= 3900000 then
				req = 746000000
			end
			if mp > 3900000 and mp <= 3910000 then
				req = 748000000
			end
			if mp > 3910000 and mp <= 3920000 then
				req = 750000000
			end
			if mp > 3920000 and mp <= 3930000 then
				req = 752000000
			end
			if mp > 3930000 and mp <= 3940000 then
				req = 754000000
			end
			if mp > 3940000 and mp <= 3950000 then
				req = 756000000
			end
			if mp > 3950000 and mp <= 3960000 then
				req = 758000000
			end
			if mp > 3960000 and mp <= 3970000 then
				req = 760000000
			end
			if mp > 3970000 and mp <= 3980000 then
				req = 762000000
			end
			if mp > 3980000 and mp <= 3990000 then
				req = 764000000
			end
			if mp > 3990000 and mp <= 4000000 then
				req = 766000000
			end
			if mp > 4000000 and mp <= 4010000 then
				req = 768000000
			end
			if mp > 4010000 and mp <= 4020000 then
				req = 770000000
			end
			if mp > 4020000 and mp <= 4030000 then
				req = 772000000
			end
			if mp > 4030000 and mp <= 4040000 then
				req = 774000000
			end
			if mp > 4040000 and mp <= 4050000 then
				req = 776000000
			end
			if mp > 4050000 and mp <= 4060000 then
				req = 778000000
			end
			if mp > 4060000 and mp <= 4070000 then
				req = 780000000
			end
			if mp > 4070000 and mp <= 4080000 then
				req = 782000000
			end
			if mp > 4080000 and mp <= 4090000 then
				req = 784000000
			end
			if mp > 4090000 and mp <= 4100000 then
				req = 786000000
			end
			if mp > 4100000 and mp <= 4110000 then
				req = 788000000
			end
			if mp > 4110000 and mp <= 4120000 then
				req = 790000000
			end
			if mp > 4120000 and mp <= 4130000 then
				req = 792000000
			end
			if mp > 4130000 and mp <= 4140000 then
				req = 794000000
			end
			if mp > 4140000 and mp <= 4150000 then
				req = 796000000
			end
			if mp > 4150000 and mp <= 4160000 then
				req = 798000000
			end
			if mp > 4160000 and mp <= 4170000 then
				req = 800000000
			end
			if mp > 4170000 and mp <= 4180000 then
				req = 802000000
			end
			if mp > 4180000 and mp <= 4190000 then
				req = 804000000
			end
			if mp > 4190000 and mp <= 4200000 then
				req = 806000000
			end
			if mp > 4200000 and mp <= 4210000 then
				req = 808000000
			end
			if mp > 4210000 and mp <= 4220000 then
				req = 810000000
			end
			if mp > 4220000 and mp <= 4230000 then
				req = 812000000
			end
			if mp > 4230000 and mp <= 4240000 then
				req = 814000000
			end
			if mp > 4240000 and mp <= 4250000 then
				req = 816000000
			end
			if mp > 4250000 and mp <= 4260000 then
				req = 818000000
			end
			if mp > 4260000 and mp <= 4270000 then
				req = 820000000
			end
			if mp > 4270000 and mp <= 4280000 then
				req = 822000000
			end
			if mp > 4280000 and mp <= 4290000 then
				req = 824000000
			end
			if mp > 4290000 and mp <= 4300000 then
				req = 826000000
			end
			if mp > 4300000 and mp <= 4310000 then
				req = 828000000
			end
			if mp > 4310000 and mp <= 4320000 then
				req = 830000000
			end
			if mp > 4320000 and mp <= 4330000 then
				req = 832000000
			end
			if mp > 4330000 and mp <= 4340000 then
				req = 834000000
			end
			if mp > 4340000 and mp <= 4350000 then
				req = 836000000
			end
			if mp > 4350000 and mp <= 4360000 then
				req = 838000000
			end
			if mp > 4360000 and mp <= 4370000 then
				req = 840000000
			end
			if mp > 4370000 and mp <= 4380000 then
				req = 842000000
			end
			if mp > 4380000 and mp <= 4390000 then
				req = 844000000
			end
			if mp > 4390000 and mp <= 4400000 then
				req = 846000000
			end
			if mp > 4400000 and mp <= 4410000 then
				req = 848000000
			end
			if mp > 4410000 and mp <= 4420000 then
				req = 850000000
			end
			if mp > 4420000 and mp <= 4430000 then
				req = 852000000
			end
			if mp > 4430000 and mp <= 4440000 then
				req = 854000000
			end
			if mp > 4440000 and mp <= 4450000 then
				req = 856000000
			end
			if mp > 4450000 and mp <= 4460000 then
				req = 858000000
			end
			if mp > 4460000 and mp <= 4470000 then
				req = 860000000
			end
			if mp > 4470000 and mp <= 4480000 then
				req = 862000000
			end
			if mp > 4480000 and mp <= 4490000 then
				req = 864000000
			end
			if mp > 4490000 and mp <= 4500000 then
				req = 866000000
			end
			if mp > 4500000 and mp <= 4510000 then
				req = 868000000
			end
			if mp > 4510000 and mp <= 4520000 then
				req = 870000000
			end
			if mp > 4520000 and mp <= 4530000 then
				req = 872000000
			end
			if mp > 4530000 and mp <= 4540000 then
				req = 874000000
			end
			if mp > 4540000 and mp <= 4550000 then
				req = 876000000
			end
			if mp > 4550000 and mp <= 4560000 then
				req = 878000000
			end
			if mp > 4560000 and mp <= 4570000 then
				req = 880000000
			end
			if mp > 4570000 and mp <= 4580000 then
				req = 882000000
			end
			if mp > 4580000 and mp <= 4590000 then
				req = 884000000
			end
			if mp > 4590000 and mp <= 4600000 then
				req = 886000000
			end
			if mp > 4600000 and mp <= 4610000 then
				req = 888000000
			end
			if mp > 4610000 and mp <= 4620000 then
				req = 890000000
			end
			if mp > 4620000 and mp <= 4630000 then
				req = 892000000
			end
			if mp > 4630000 and mp <= 4640000 then
				req = 894000000
			end
			if mp > 4640000 and mp <= 4650000 then
				req = 896000000
			end
			if mp > 4650000 and mp <= 4660000 then
				req = 898000000
			end
			if mp > 4660000 and mp <= 4670000 then
				req = 900000000
			end
			if mp > 4670000 and mp <= 4680000 then
				req = 902000000
			end
			if mp > 4680000 and mp <= 4690000 then
				req = 904000000
			end
			if mp > 4690000 and mp <= 4700000 then
				req = 906000000
			end
			if mp > 4700000 and mp <= 4710000 then
				req = 908000000
			end
			if mp > 4710000 and mp <= 4720000 then
				req = 910000000
			end
			if mp > 4720000 and mp <= 4730000 then
				req = 912000000
			end
			if mp > 4730000 and mp <= 4740000 then
				req = 914000000
			end
			if mp > 4740000 and mp <= 4750000 then
				req = 916000000
			end
			if mp > 4750000 and mp <= 4760000 then
				req = 918000000
			end
			if mp > 4760000 and mp <= 4770000 then
				req = 920000000
			end
			if mp > 4770000 and mp <= 4780000 then
				req = 922000000
			end
			if mp > 4780000 and mp <= 4790000 then
				req = 924000000
			end
			if mp > 4790000 and mp <= 4800000 then
				req = 926000000
			end
			if mp > 4800000 and mp <= 4810000 then
				req = 928000000
			end
			if mp > 4810000 and mp <= 4820000 then
				req = 930000000
			end
			if mp > 4820000 and mp <= 4830000 then
				req = 932000000
			end
			if mp > 4830000 and mp <= 4840000 then
				req = 934000000
			end
			if mp > 4840000 and mp <= 4850000 then
				req = 936000000
			end
			if mp > 4850000 and mp <= 4860000 then
				req = 938000000
			end
			if mp > 4860000 and mp <= 4870000 then
				req = 940000000
			end
			if mp > 4870000 and mp <= 4880000 then
				req = 942000000
			end
			if mp > 4880000 and mp <= 4890000 then
				req = 944000000
			end
			if mp > 4890000 and mp <= 4900000 then
				req = 946000000
			end
			if mp > 4900000 and mp <= 4910000 then
				req = 948000000
			end
			if mp > 4910000 and mp <= 4920000 then
				req = 950000000
			end
			if mp > 4920000 and mp <= 4930000 then
				req = 952000000
			end
			if mp > 4930000 and mp <= 4940000 then
				req = 954000000
			end
			if mp > 4940000 and mp <= 4950000 then
				req = 956000000
			end
			if mp > 4950000 and mp <= 4960000 then
				req = 958000000
			end
			if mp > 4960000 and mp <= 4970000 then
				req = 960000000
			end
			if mp > 4970000 and mp <= 4980000 then
				req = 962000000
			end
			if mp > 4980000 and mp <= 4990000 then
				req = 964000000
			end
			if mp > 4990000 and mp <= 5000000 then
				req = 966000000
			end
			if mp > 5000000 and mp <= 5010000 then
				req = 968000000
			end
			if mp > 5010000 and mp <= 5020000 then
				req = 970000000
			end
			if mp > 5020000 and mp <= 5030000 then
				req = 972000000
			end
			if mp > 5030000 and mp <= 5040000 then
				req = 974000000
			end
			if mp > 5040000 and mp <= 5050000 then
				req = 976000000
			end
			if mp > 5050000 and mp <= 5060000 then
				req = 978000000
			end
			if mp > 5060000 and mp <= 5070000 then
				req = 980000000
			end
			if mp > 5070000 and mp <= 5080000 then
				req = 982000000
			end
			if mp > 5080000 and mp <= 5090000 then
				req = 984000000
			end
			if mp > 5090000 and mp <= 5100000 then
				req = 986000000
			end
			if mp > 5100000 and mp <= 5110000 then
				req = 988000000
			end
			if mp > 5110000 and mp <= 5120000 then
				req = 990000000
			end
			if mp > 5120000 and mp <= 5130000 then
				req = 992000000
			end
			if mp > 5130000 and mp <= 5140000 then
				req = 994000000
			end
			if mp > 5140000 and mp <= 5150000 then
				req = 996000000
			end
			if mp > 5150000 and mp <= 5160000 then
				req = 998000000
			end
			if mp > 5160000 and mp <= 5170000 then
				req = 1000000000
			end
			if mp > 5170000 and mp <= 5180000 then
				req = 1002000000
			end
			if mp > 5180000 and mp <= 5190000 then
				req = 1004000000
			end
			if mp > 5190000 and mp <= 5200000 then
				req = 1006000000
			end
			if mp > 5200000 and mp <= 5210000 then
				req = 1008000000
			end
			if mp > 5210000 and mp <= 5220000 then
				req = 1010000000
			end
			if mp > 5220000 and mp <= 5230000 then
				req = 1012000000
			end
			if mp > 5230000 and mp <= 5240000 then
				req = 1014000000
			end
			if mp > 5240000 and mp <= 5250000 then
				req = 1016000000
			end
			if mp > 5250000 and mp <= 5260000 then
				req = 1018000000
			end
			if mp > 5260000 and mp <= 5270000 then
				req = 1020000000
			end
			if mp > 5270000 and mp <= 5280000 then
				req = 1022000000
			end
			if mp > 5280000 and mp <= 5290000 then
				req = 1024000000
			end
			if mp > 5290000 and mp <= 5300000 then
				req = 1026000000
			end
			if mp > 5300000 and mp <= 5310000 then
				req = 1028000000
			end
			if mp > 5310000 and mp <= 5320000 then
				req = 1030000000
			end
			if mp > 5320000 and mp <= 5330000 then
				req = 1032000000
			end
			if mp > 5330000 and mp <= 5340000 then
				req = 1034000000
			end
			if mp > 5340000 and mp <= 5350000 then
				req = 1036000000
			end
			if mp > 5350000 and mp <= 5360000 then
				req = 1038000000
			end
			if mp > 5360000 and mp <= 5370000 then
				req = 1040000000
			end
			if mp > 5370000 and mp <= 5380000 then
				req = 1042000000
			end
			if mp > 5380000 and mp <= 5390000 then
				req = 1044000000
			end
			if mp > 5390000 and mp <= 5400000 then
				req = 1046000000
			end
			if mp > 5400000 and mp <= 5410000 then
				req = 1048000000
			end
			if mp > 5410000 and mp <= 5420000 then
				req = 1050000000
			end
			if mp > 5420000 and mp <= 5430000 then
				req = 1052000000
			end
			if mp > 5430000 and mp <= 5440000 then
				req = 1054000000
			end
			if mp > 5440000 and mp <= 5450000 then
				req = 1056000000
			end
			if mp > 5450000 and mp <= 5460000 then
				req = 1058000000
			end
			if mp > 5460000 and mp <= 5470000 then
				req = 1060000000
			end
			if mp > 5470000 and mp <= 5480000 then
				req = 1062000000
			end
			if mp > 5480000 and mp <= 5490000 then
				req = 1064000000
			end
			if mp > 5490000 and mp <= 5500000 then
				req = 1066000000
			end
			if mp > 5500000 and mp <= 5510000 then
				req = 1068000000
			end
			if mp > 5510000 and mp <= 5520000 then
				req = 1070000000
			end
			if mp > 5520000 and mp <= 5530000 then
				req = 1072000000
			end
			if mp > 5530000 and mp <= 5540000 then
				req = 1074000000
			end
			if mp > 5540000 and mp <= 5550000 then
				req = 1076000000
			end
			if mp > 5550000 and mp <= 5560000 then
				req = 1078000000
			end
			if mp > 5560000 and mp <= 5570000 then
				req = 1080000000
			end
			if mp > 5570000 and mp <= 5580000 then
				req = 1082000000
			end
			if mp > 5580000 and mp <= 5590000 then
				req = 1084000000
			end
			if mp > 5590000 and mp <= 5600000 then
				req = 1086000000
			end
			if mp > 5600000 and mp <= 5610000 then
				req = 1088000000
			end
			if mp > 5610000 and mp <= 5620000 then
				req = 1090000000
			end
			if mp > 5620000 and mp <= 5630000 then
				req = 1092000000
			end
			if mp > 5630000 and mp <= 5640000 then
				req = 1094000000
			end
			if mp > 5640000 and mp <= 5650000 then
				req = 1096000000
			end
			if mp > 5650000 and mp <= 5660000 then
				req = 1098000000
			end
			if mp > 5660000 and mp <= 5670000 then
				req = 1100000000
			end
			if mp > 5670000 and mp <= 5680000 then
				req = 1102000000
			end
			if mp > 5680000 and mp <= 5690000 then
				req = 1104000000
			end
			if mp > 5690000 and mp <= 5700000 then
				req = 1106000000
			end
			if mp > 5700000 and mp <= 5710000 then
				req = 1108000000
			end
			if mp > 5710000 and mp <= 5720000 then
				req = 1110000000
			end
			if mp > 5720000 and mp <= 5730000 then
				req = 1112000000
			end
			if mp > 5730000 and mp <= 5740000 then
				req = 1114000000
			end
			if mp > 5740000 and mp <= 5750000 then
				req = 1116000000
			end
			if mp > 5750000 and mp <= 5760000 then
				req = 1118000000
			end
			if mp > 5760000 and mp <= 5770000 then
				req = 1120000000
			end
			if mp > 5770000 and mp <= 5780000 then
				req = 1122000000
			end
			if mp > 5780000 and mp <= 5790000 then
				req = 1124000000
			end
			if mp > 5790000 and mp <= 5800000 then
				req = 1126000000
			end
			if mp > 5800000 and mp <= 5810000 then
				req = 1128000000
			end
			if mp > 5810000 and mp <= 5820000 then
				req = 1130000000
			end
			if mp > 5820000 and mp <= 5830000 then
				req = 1132000000
			end
			if mp > 5830000 and mp <= 5840000 then
				req = 1134000000
			end
			if mp > 5840000 and mp <= 5850000 then
				req = 1136000000
			end
			if mp > 5850000 and mp <= 5860000 then
				req = 1138000000
			end
			if mp > 5860000 and mp <= 5870000 then
				req = 1140000000
			end
			if mp > 5870000 and mp <= 5880000 then
				req = 1142000000
			end
			if mp > 5880000 and mp <= 5890000 then
				req = 1144000000
			end
			if mp > 5890000 and mp <= 5900000 then
				req = 1146000000
			end
			if mp > 5900000 and mp <= 5910000 then
				req = 1148000000
			end
			if mp > 5910000 and mp <= 5920000 then
				req = 1150000000
			end
			if mp > 5920000 and mp <= 5930000 then
				req = 1152000000
			end
			if mp > 5930000 and mp <= 5940000 then
				req = 1154000000
			end
			if mp > 5940000 and mp <= 5950000 then
				req = 1156000000
			end
			if mp > 5950000 and mp <= 5960000 then
				req = 1158000000
			end
			if mp > 5960000 and mp <= 5970000 then
				req = 1160000000
			end
			if mp > 5970000 and mp <= 5980000 then
				req = 1162000000
			end
			if mp > 5980000 and mp <= 5990000 then
				req = 1164000000
			end
			if mp > 5990000 and mp <= 6000000 then
				req = 1166000000
			end
			if mp > 6000000 and mp <= 6010000 then
				req = 1168000000
			end
			if mp > 6010000 and mp <= 6020000 then
				req = 1170000000
			end
			if mp > 6020000 and mp <= 6030000 then
				req = 1172000000
			end
			if mp > 6030000 and mp <= 6040000 then
				req = 1174000000
			end
			if mp > 6040000 and mp <= 6050000 then
				req = 1176000000
			end
			if mp > 6050000 and mp <= 6060000 then
				req = 1178000000
			end
			if mp > 6060000 and mp <= 6070000 then
				req = 1180000000
			end
			if mp > 6070000 and mp <= 6080000 then
				req = 1182000000
			end
			if mp > 6080000 and mp <= 6090000 then
				req = 1184000000
			end
			if mp > 6090000 and mp <= 6100000 then
				req = 1186000000
			end
			if mp > 6100000 and mp <= 6110000 then
				req = 1188000000
			end
			if mp > 6110000 and mp <= 6120000 then
				req = 1190000000
			end
			if mp > 6120000 and mp <= 6130000 then
				req = 1192000000
			end
			if mp > 6130000 and mp <= 6140000 then
				req = 1194000000
			end
			if mp > 6140000 and mp <= 6150000 then
				req = 1196000000
			end
			if mp > 6150000 and mp <= 6160000 then
				req = 1198000000
			end
			if mp > 6160000 and mp <= 6170000 then
				req = 1200000000
			end
			if mp > 6170000 and mp <= 6180000 then
				req = 1202000000
			end
			if mp > 6180000 and mp <= 6190000 then
				req = 1204000000
			end
			if mp > 6190000 and mp <= 6200000 then
				req = 1206000000
			end
			if mp > 6200000 and mp <= 6210000 then
				req = 1208000000
			end
			if mp > 6210000 and mp <= 6220000 then
				req = 1210000000
			end
			if mp > 6220000 and mp <= 6230000 then
				req = 1212000000
			end
			if mp > 6230000 and mp <= 6240000 then
				req = 1214000000
			end
			if mp > 6240000 and mp <= 6250000 then
				req = 1216000000
			end
			if mp > 6250000 and mp <= 6260000 then
				req = 1218000000
			end
			if mp > 6260000 and mp <= 6270000 then
				req = 1220000000
			end
			if mp > 6270000 and mp <= 6280000 then
				req = 1222000000
			end
			if mp > 6280000 and mp <= 6290000 then
				req = 1224000000
			end
			if mp > 6290000 and mp <= 6300000 then
				req = 1226000000
			end
			if mp > 6300000 and mp <= 6310000 then
				req = 1228000000
			end
			if mp > 6310000 and mp <= 6320000 then
				req = 1230000000
			end
			if mp > 6320000 and mp <= 6330000 then
				req = 1232000000
			end
			if mp > 6330000 and mp <= 6340000 then
				req = 1234000000
			end
			if mp > 6340000 and mp <= 6350000 then
				req = 1236000000
			end
			if mp > 6350000 and mp <= 6360000 then
				req = 1238000000
			end
			if mp > 6360000 and mp <= 6370000 then
				req = 1240000000
			end
			if mp > 6370000 and mp <= 6380000 then
				req = 1242000000
			end
			if mp > 6380000 and mp <= 6390000 then
				req = 1244000000
			end
			if mp > 6390000 and mp <= 6400000 then
				req = 1246000000
			end
			if mp > 6400000 and mp <= 6410000 then
				req = 1248000000
			end
			if mp > 6410000 and mp <= 6420000 then
				req = 1250000000
			end
			if mp > 6420000 and mp <= 6430000 then
				req = 1252000000
			end
			if mp > 6430000 and mp <= 6440000 then
				req = 1254000000
			end
			if mp > 6440000 and mp <= 6450000 then
				req = 1256000000
			end
			if mp > 6450000 and mp <= 6460000 then
				req = 1258000000
			end
			if mp > 6460000 and mp <= 6470000 then
				req = 1260000000
			end
			if mp > 6470000 and mp <= 6480000 then
				req = 1262000000
			end
			if mp > 6480000 and mp <= 6490000 then
				req = 1264000000
			end
			if mp > 6490000 and mp <= 6500000 then
				req = 1266000000
			end
			if mp > 6500000 and mp <= 6510000 then
				req = 1268000000
			end
			if mp > 6510000 and mp <= 6520000 then
				req = 1270000000
			end
			if mp > 6520000 and mp <= 6530000 then
				req = 1272000000
			end
			if mp > 6530000 and mp <= 6540000 then
				req = 1274000000
			end
			if mp > 6540000 and mp <= 6550000 then
				req = 1276000000
			end
			if mp > 6550000 and mp <= 6560000 then
				req = 1278000000
			end
			if mp > 6560000 and mp <= 6570000 then
				req = 1280000000
			end
			if mp > 6570000 and mp <= 6580000 then
				req = 1282000000
			end
			if mp > 6580000 and mp <= 6590000 then
				req = 1284000000
			end
			if mp > 6590000 and mp <= 6600000 then
				req = 1286000000
			end
			if mp > 6600000 and mp <= 6610000 then
				req = 1288000000
			end
			if mp > 6610000 and mp <= 6620000 then
				req = 1290000000
			end
			if mp > 6620000 and mp <= 6630000 then
				req = 1292000000
			end
			if mp > 6630000 and mp <= 6640000 then
				req = 1294000000
			end
			if mp > 6640000 and mp <= 6650000 then
				req = 1296000000
			end
			if mp > 6650000 and mp <= 6660000 then
				req = 1298000000
			end
			if mp > 6660000 and mp <= 6670000 then
				req = 1300000000
			end
			if mp > 6670000 and mp <= 6680000 then
				req = 1302000000
			end
			if mp > 6680000 and mp <= 6690000 then
				req = 1304000000
			end
			if mp > 6690000 and mp <= 6700000 then
				req = 1306000000
			end
			if mp > 6700000 and mp <= 6710000 then
				req = 1308000000
			end
			if mp > 6710000 and mp <= 6720000 then
				req = 1310000000
			end
			if mp > 6720000 and mp <= 6730000 then
				req = 1312000000
			end
			if mp > 6730000 and mp <= 6740000 then
				req = 1314000000
			end
			if mp > 6740000 and mp <= 6750000 then
				req = 1316000000
			end
			if mp > 6750000 and mp <= 6760000 then
				req = 1318000000
			end
			if mp > 6760000 and mp <= 6770000 then
				req = 1320000000
			end
			if mp > 6770000 and mp <= 6780000 then
				req = 1322000000
			end
			if mp > 6780000 and mp <= 6790000 then
				req = 1324000000
			end
			if mp > 6790000 and mp <= 6800000 then
				req = 1326000000
			end
			if mp > 6800000 and mp <= 6810000 then
				req = 1328000000
			end
			if mp > 6810000 and mp <= 6820000 then
				req = 1330000000
			end
			if mp > 6820000 and mp <= 6830000 then
				req = 1332000000
			end
			if mp > 6830000 and mp <= 6840000 then
				req = 1334000000
			end
			if mp > 6840000 and mp <= 6850000 then
				req = 1336000000
			end
			if mp > 6850000 and mp <= 6860000 then
				req = 1338000000
			end
			if mp > 6860000 and mp <= 6870000 then
				req = 1340000000
			end
			if mp > 6870000 and mp <= 6880000 then
				req = 1342000000
			end
			if mp > 6880000 and mp <= 6890000 then
				req = 1344000000
			end
			if mp > 6890000 and mp <= 6900000 then
				req = 1346000000
			end
			if mp > 6900000 and mp <= 6910000 then
				req = 1348000000
			end
			if mp > 6910000 and mp <= 6920000 then
				req = 1350000000
			end
			if mp > 6920000 and mp <= 6930000 then
				req = 1352000000
			end
			if mp > 6930000 and mp <= 6940000 then
				req = 1354000000
			end
			if mp > 6940000 and mp <= 6950000 then
				req = 1356000000
			end
			if mp > 6950000 and mp <= 6960000 then
				req = 1358000000
			end
			if mp > 6960000 and mp <= 6970000 then
				req = 1360000000
			end
			if mp > 6970000 and mp <= 6980000 then
				req = 1362000000
			end
			if mp > 6980000 and mp <= 6990000 then
				req = 1364000000
			end
			if mp > 6990000 and mp <= 7000000 then
				req = 1366000000
			end
			if mp > 7000000 and mp <= 7010000 then
				req = 1368000000
			end
			if mp > 7010000 and mp <= 7020000 then
				req = 1370000000
			end
			if mp > 7020000 and mp <= 7030000 then
				req = 1372000000
			end
			if mp > 7030000 and mp <= 7040000 then
				req = 1374000000
			end
			if mp > 7040000 and mp <= 7050000 then
				req = 1376000000
			end
			if mp > 7050000 and mp <= 7060000 then
				req = 1378000000
			end
			if mp > 7060000 and mp <= 7070000 then
				req = 1380000000
			end
			if mp > 7070000 and mp <= 7080000 then
				req = 1382000000
			end
			if mp > 7080000 and mp <= 7090000 then
				req = 1384000000
			end
			if mp > 7090000 and mp <= 7100000 then
				req = 1386000000
			end
			if mp > 7100000 and mp <= 7110000 then
				req = 1388000000
			end
			if mp > 7110000 and mp <= 7120000 then
				req = 1390000000
			end
			if mp > 7120000 and mp <= 7130000 then
				req = 1392000000
			end
			if mp > 7130000 and mp <= 7140000 then
				req = 1394000000
			end
			if mp > 7140000 and mp <= 7150000 then
				req = 1396000000
			end
			if mp > 7150000 and mp <= 7160000 then
				req = 1398000000
			end
			if mp > 7160000 and mp <= 7170000 then
				req = 1400000000
			end
			if mp > 7170000 and mp <= 7180000 then
				req = 1402000000
			end
			if mp > 7180000 and mp <= 7190000 then
				req = 1404000000
			end
			if mp > 7190000 and mp <= 7200000 then
				req = 1406000000
			end
			if mp > 7200000 and mp <= 7210000 then
				req = 1408000000
			end
			if mp > 7210000 and mp <= 7220000 then
				req = 1410000000
			end
			if mp > 7220000 and mp <= 7230000 then
				req = 1412000000
			end
			if mp > 7230000 and mp <= 7240000 then
				req = 1414000000
			end
			if mp > 7240000 and mp <= 7250000 then
				req = 1416000000
			end
			if mp > 7250000 and mp <= 7260000 then
				req = 1418000000
			end
			if mp > 7260000 and mp <= 7270000 then
				req = 1420000000
			end
			if mp > 7270000 and mp <= 7280000 then
				req = 1422000000
			end
			if mp > 7280000 and mp <= 7290000 then
				req = 1424000000
			end
			if mp > 7290000 and mp <= 7300000 then
				req = 1426000000
			end
			if mp > 7300000 and mp <= 7310000 then
				req = 1428000000
			end
			if mp > 7310000 and mp <= 7320000 then
				req = 1430000000
			end
			if mp > 7320000 and mp <= 7330000 then
				req = 1432000000
			end
			if mp > 7330000 and mp <= 7340000 then
				req = 1434000000
			end
			if mp > 7340000 and mp <= 7350000 then
				req = 1436000000
			end
			if mp > 7350000 and mp <= 7360000 then
				req = 1438000000
			end
			if mp > 7360000 and mp <= 7370000 then
				req = 1440000000
			end
			if mp > 7370000 and mp <= 7380000 then
				req = 1442000000
			end
			if mp > 7380000 and mp <= 7390000 then
				req = 1444000000
			end
			if mp > 7390000 and mp <= 7400000 then
				req = 1446000000
			end
			if mp > 7400000 and mp <= 7410000 then
				req = 1448000000
			end
			if mp > 7410000 and mp <= 7420000 then
				req = 1450000000
			end
			if mp > 7420000 and mp <= 7430000 then
				req = 1452000000
			end
			if mp > 7430000 and mp <= 7440000 then
				req = 1454000000
			end
			if mp > 7440000 and mp <= 7450000 then
				req = 1456000000
			end
			if mp > 7450000 and mp <= 7460000 then
				req = 1458000000
			end
			if mp > 7460000 and mp <= 7470000 then
				req = 1460000000
			end
			if mp > 7470000 and mp <= 7480000 then
				req = 1462000000
			end
			if mp > 7480000 and mp <= 7490000 then
				req = 1464000000
			end
			if mp > 7490000 and mp <= 7500000 then
				req = 1466000000
			end
			if mp > 7500000 and mp <= 7510000 then
				req = 1468000000
			end
			if mp > 7510000 and mp <= 7520000 then
				req = 1470000000
			end
			if mp > 7520000 and mp <= 7530000 then
				req = 1472000000
			end
			if mp > 7530000 and mp <= 7540000 then
				req = 1474000000
			end
			if mp > 7540000 and mp <= 7550000 then
				req = 1476000000
			end
			if mp > 7550000 and mp <= 7560000 then
				req = 1478000000
			end
			if mp > 7560000 and mp <= 7570000 then
				req = 1480000000
			end
			if mp > 7570000 and mp <= 7580000 then
				req = 1482000000
			end
			if mp > 7580000 and mp <= 7590000 then
				req = 1484000000
			end
			if mp > 7590000 and mp <= 7600000 then
				req = 1486000000
			end
			if mp > 7600000 and mp <= 7610000 then
				req = 1488000000
			end
			if mp > 7610000 and mp <= 7620000 then
				req = 1490000000
			end
			if mp > 7620000 and mp <= 7630000 then
				req = 1492000000
			end
			if mp > 7630000 and mp <= 7640000 then
				req = 1494000000
			end
			if mp > 7640000 and mp <= 7650000 then
				req = 1496000000
			end
			if mp > 7650000 and mp <= 7660000 then
				req = 1498000000
			end
			if mp > 7660000 and mp <= 7670000 then
				req = 1500000000
			end
			if mp > 7670000 and mp <= 7680000 then
				req = 1502000000
			end
			if mp > 7680000 and mp <= 7690000 then
				req = 1504000000
			end
			if mp > 7690000 and mp <= 7700000 then
				req = 1506000000
			end
			if mp > 7700000 and mp <= 7710000 then
				req = 1508000000
			end
			if mp > 7710000 and mp <= 7720000 then
				req = 1510000000
			end
			if mp > 7720000 and mp <= 7730000 then
				req = 1512000000
			end
			if mp > 7730000 and mp <= 7740000 then
				req = 1514000000
			end
			if mp > 7740000 and mp <= 7750000 then
				req = 1516000000
			end
			if mp > 7750000 and mp <= 7760000 then
				req = 1518000000
			end
			if mp > 7760000 and mp <= 7770000 then
				req = 1520000000
			end
			if mp > 7770000 and mp <= 7780000 then
				req = 1522000000
			end
			if mp > 7780000 and mp <= 7790000 then
				req = 1524000000
			end
			if mp > 7790000 and mp <= 7800000 then
				req = 1526000000
			end
			if mp > 7800000 and mp <= 7810000 then
				req = 1528000000
			end
			if mp > 7810000 and mp <= 7820000 then
				req = 1530000000
			end
			if mp > 7820000 and mp <= 7830000 then
				req = 1532000000
			end
			if mp > 7830000 and mp <= 7840000 then
				req = 1534000000
			end
			if mp > 7840000 and mp <= 7850000 then
				req = 1536000000
			end
			if mp > 7850000 and mp <= 7860000 then
				req = 1538000000
			end
			if mp > 7860000 and mp <= 7870000 then
				req = 1540000000
			end
			if mp > 7870000 and mp <= 7880000 then
				req = 1542000000
			end
			if mp > 7880000 and mp <= 7890000 then
				req = 1544000000
			end
			if mp > 7890000 and mp <= 7900000 then
				req = 1546000000
			end
			if mp > 7900000 and mp <= 7910000 then
				req = 1548000000
			end
			if mp > 7910000 and mp <= 7920000 then
				req = 1550000000
			end
			if mp > 7920000 and mp <= 7930000 then
				req = 1552000000
			end
			if mp > 7930000 and mp <= 7940000 then
				req = 1554000000
			end
			if mp > 7940000 and mp <= 7950000 then
				req = 1556000000
			end
			if mp > 7950000 and mp <= 7960000 then
				req = 1558000000
			end
			if mp > 7960000 and mp <= 7970000 then
				req = 1560000000
			end
			if mp > 7970000 and mp <= 7980000 then
				req = 1562000000
			end
			if mp > 7980000 and mp <= 7990000 then
				req = 1564000000
			end
			if mp > 7990000 and mp <= 8000000 then
				req = 1566000000
			end
			if mp > 8000000 and mp <= 8010000 then
				req = 1568000000
			end
			if mp > 8010000 and mp <= 8020000 then
				req = 1570000000
			end
			if mp > 8020000 and mp <= 8030000 then
				req = 1572000000
			end
			if mp > 8030000 and mp <= 8040000 then
				req = 1574000000
			end
			if mp > 8040000 and mp <= 8050000 then
				req = 1576000000
			end
			if mp > 8050000 and mp <= 8060000 then
				req = 1578000000
			end
			if mp > 8060000 and mp <= 8070000 then
				req = 1580000000
			end
			if mp > 8070000 and mp <= 8080000 then
				req = 1582000000
			end
			if mp > 8080000 and mp <= 8090000 then
				req = 1584000000
			end
			if mp > 8090000 and mp <= 8100000 then
				req = 1586000000
			end
			if mp > 8100000 and mp <= 8110000 then
				req = 1588000000
			end
			if mp > 8110000 and mp <= 8120000 then
				req = 1590000000
			end
			if mp > 8120000 and mp <= 8130000 then
				req = 1592000000
			end
			if mp > 8130000 and mp <= 8140000 then
				req = 1594000000
			end
			if mp > 8140000 and mp <= 8150000 then
				req = 1596000000
			end
			if mp > 8150000 and mp <= 8160000 then
				req = 1598000000
			end
			if mp > 8160000 and mp <= 8170000 then
				req = 1600000000
			end
			if mp > 8170000 and mp <= 8180000 then
				req = 1602000000
			end
			if mp > 8180000 and mp <= 8190000 then
				req = 1604000000
			end
			if mp > 8190000 and mp <= 8200000 then
				req = 1606000000
			end
			if mp > 8200000 and mp <= 8210000 then
				req = 1608000000
			end
			if mp > 8210000 and mp <= 8220000 then
				req = 1610000000
			end
			if mp > 8220000 and mp <= 8230000 then
				req = 1612000000
			end
			if mp > 8230000 and mp <= 8240000 then
				req = 1614000000
			end
			if mp > 8240000 and mp <= 8250000 then
				req = 1616000000
			end
			if mp > 8250000 and mp <= 8260000 then
				req = 1618000000
			end
			if mp > 8260000 and mp <= 8270000 then
				req = 1620000000
			end
			if mp > 8270000 and mp <= 8280000 then
				req = 1622000000
			end
			if mp > 8280000 and mp <= 8290000 then
				req = 1624000000
			end
			if mp > 8290000 and mp <= 8300000 then
				req = 1626000000
			end
			if mp > 8300000 and mp <= 8310000 then
				req = 1628000000
			end
			if mp > 8310000 and mp <= 8320000 then
				req = 1630000000
			end
			if mp > 8320000 and mp <= 8330000 then
				req = 1632000000
			end
			if mp > 8330000 and mp <= 8340000 then
				req = 1634000000
			end
			if mp > 8340000 and mp <= 8350000 then
				req = 1636000000
			end
			if mp > 8350000 and mp <= 8360000 then
				req = 1638000000
			end
			if mp > 8360000 and mp <= 8370000 then
				req = 1640000000
			end
			if mp > 8370000 and mp <= 8380000 then
				req = 1642000000
			end
			if mp > 8380000 and mp <= 8390000 then
				req = 1644000000
			end
			if mp > 8390000 and mp <= 8400000 then
				req = 1646000000
			end
			if mp > 8400000 and mp <= 8410000 then
				req = 1648000000
			end
			if mp > 8410000 and mp <= 8420000 then
				req = 1650000000
			end
			if mp > 8420000 and mp <= 8430000 then
				req = 1652000000
			end
			if mp > 8430000 and mp <= 8440000 then
				req = 1654000000
			end
			if mp > 8440000 and mp <= 8450000 then
				req = 1656000000
			end
			if mp > 8450000 and mp <= 8460000 then
				req = 1658000000
			end
			if mp > 8460000 and mp <= 8470000 then
				req = 1660000000
			end
			if mp > 8470000 and mp <= 8480000 then
				req = 1662000000
			end
			if mp > 8480000 and mp <= 8490000 then
				req = 1664000000
			end
			if mp > 8490000 and mp <= 8500000 then
				req = 1666000000
			end
			if mp > 8500000 and mp <= 8510000 then
				req = 1668000000
			end
			if mp > 8510000 and mp <= 8520000 then
				req = 1670000000
			end
			if mp > 8520000 and mp <= 8530000 then
				req = 1672000000
			end
			if mp > 8530000 and mp <= 8540000 then
				req = 1674000000
			end
			if mp > 8540000 and mp <= 8550000 then
				req = 1676000000
			end
			if mp > 8550000 and mp <= 8560000 then
				req = 1678000000
			end
			if mp > 8560000 and mp <= 8570000 then
				req = 1680000000
			end
			if mp > 8570000 and mp <= 8580000 then
				req = 1682000000
			end
			if mp > 8580000 and mp <= 8590000 then
				req = 1684000000
			end
			if mp > 8590000 and mp <= 8600000 then
				req = 1686000000
			end
			if mp > 8600000 and mp <= 8610000 then
				req = 1688000000
			end
			if mp > 8610000 and mp <= 8620000 then
				req = 1690000000
			end
			if mp > 8620000 and mp <= 8630000 then
				req = 1692000000
			end
			if mp > 8630000 and mp <= 8640000 then
				req = 1694000000
			end
			if mp > 8640000 and mp <= 8650000 then
				req = 1696000000
			end
			if mp > 8650000 and mp <= 8660000 then
				req = 1698000000
			end
			if mp > 8660000 and mp <= 8670000 then
				req = 1700000000
			end
			if mp > 8670000 and mp <= 8680000 then
				req = 1702000000
			end
			if mp > 8680000 and mp <= 8690000 then
				req = 1704000000
			end
			if mp > 8690000 and mp <= 8700000 then
				req = 1706000000
			end
			if mp > 8700000 and mp <= 8710000 then
				req = 1708000000
			end
			if mp > 8710000 and mp <= 8720000 then
				req = 1710000000
			end
			if mp > 8720000 and mp <= 8730000 then
				req = 1712000000
			end
			if mp > 8730000 and mp <= 8740000 then
				req = 1714000000
			end
			if mp > 8740000 and mp <= 8750000 then
				req = 1716000000
			end
			if mp > 8750000 and mp <= 8760000 then
				req = 1718000000
			end
			if mp > 8760000 and mp <= 8770000 then
				req = 1720000000
			end
			if mp > 8770000 and mp <= 8780000 then
				req = 1722000000
			end
			if mp > 8780000 and mp <= 8790000 then
				req = 1724000000
			end
			if mp > 8790000 and mp <= 8800000 then
				req = 1726000000
			end
			if mp > 8800000 and mp <= 8810000 then
				req = 1728000000
			end
			if mp > 8810000 and mp <= 8820000 then
				req = 1730000000
			end
			if mp > 8820000 and mp <= 8830000 then
				req = 1732000000
			end
			if mp > 8830000 and mp <= 8840000 then
				req = 1734000000
			end
			if mp > 8840000 and mp <= 8850000 then
				req = 1736000000
			end
			if mp > 8850000 and mp <= 8860000 then
				req = 1738000000
			end
			if mp > 8860000 and mp <= 8870000 then
				req = 1740000000
			end
			if mp > 8870000 and mp <= 8880000 then
				req = 1742000000
			end
			if mp > 8880000 and mp <= 8890000 then
				req = 1744000000
			end
			if mp > 8890000 and mp <= 8900000 then
				req = 1746000000
			end
			if mp > 8900000 and mp <= 8910000 then
				req = 1748000000
			end
			if mp > 8910000 and mp <= 8920000 then
				req = 1750000000
			end
			if mp > 8920000 and mp <= 8930000 then
				req = 1752000000
			end
			if mp > 8930000 and mp <= 8940000 then
				req = 1754000000
			end
			if mp > 8940000 and mp <= 8950000 then
				req = 1756000000
			end
			if mp > 8950000 and mp <= 8960000 then
				req = 1758000000
			end
			if mp > 8960000 and mp <= 8970000 then
				req = 1760000000
			end
			if mp > 8970000 and mp <= 8980000 then
				req = 1762000000
			end
			if mp > 8980000 and mp <= 8990000 then
				req = 1764000000
			end
			if mp > 8990000 and mp <= 9000000 then
				req = 1766000000
			end
			if mp > 9000000 and mp <= 9010000 then
				req = 1768000000
			end
			if mp > 9010000 and mp <= 9020000 then
				req = 1770000000
			end
			if mp > 9020000 and mp <= 9030000 then
				req = 1772000000
			end
			if mp > 9030000 and mp <= 9040000 then
				req = 1774000000
			end
			if mp > 9040000 and mp <= 9050000 then
				req = 1776000000
			end
			if mp > 9050000 and mp <= 9060000 then
				req = 1778000000
			end
			if mp > 9060000 and mp <= 9070000 then
				req = 1780000000
			end
			if mp > 9070000 and mp <= 9080000 then
				req = 1782000000
			end
			if mp > 9080000 and mp <= 9090000 then
				req = 1784000000
			end
			if mp > 9090000 and mp <= 9100000 then
				req = 1786000000
			end
			if mp > 9100000 and mp <= 9110000 then
				req = 1788000000
			end
			if mp > 9110000 and mp <= 9120000 then
				req = 1790000000
			end
			if mp > 9120000 and mp <= 9130000 then
				req = 1792000000
			end
			if mp > 9130000 and mp <= 9140000 then
				req = 1794000000
			end
			if mp > 9140000 and mp <= 9150000 then
				req = 1796000000
			end
			if mp > 9150000 and mp <= 9160000 then
				req = 1798000000
			end
			if mp > 9160000 and mp <= 9170000 then
				req = 1800000000
			end
			if mp > 9170000 and mp <= 9180000 then
				req = 1802000000
			end
			if mp > 9180000 and mp <= 9190000 then
				req = 1804000000
			end
			if mp > 9190000 and mp <= 9200000 then
				req = 1806000000
			end
			if mp > 9200000 and mp <= 9210000 then
				req = 1808000000
			end
			if mp > 9210000 and mp <= 9220000 then
				req = 1810000000
			end
			if mp > 9220000 and mp <= 9230000 then
				req = 1812000000
			end
			if mp > 9230000 and mp <= 9240000 then
				req = 1814000000
			end
			if mp > 9240000 and mp <= 9250000 then
				req = 1816000000
			end
			if mp > 9250000 and mp <= 9260000 then
				req = 1818000000
			end
			if mp > 9260000 and mp <= 9270000 then
				req = 1820000000
			end
			if mp > 9270000 and mp <= 9280000 then
				req = 1822000000
			end
			if mp > 9280000 and mp <= 9290000 then
				req = 1824000000
			end
			if mp > 9290000 and mp <= 9300000 then
				req = 1826000000
			end
			if mp > 9300000 and mp <= 9310000 then
				req = 1828000000
			end
			if mp > 9310000 and mp <= 9320000 then
				req = 1830000000
			end
			if mp > 9320000 and mp <= 9330000 then
				req = 1832000000
			end
			if mp > 9330000 and mp <= 9340000 then
				req = 1834000000
			end
			if mp > 9340000 and mp <= 9350000 then
				req = 1836000000
			end
			if mp > 9350000 and mp <= 9360000 then
				req = 1838000000
			end
			if mp > 9360000 and mp <= 9370000 then
				req = 1840000000
			end
			if mp > 9370000 and mp <= 9380000 then
				req = 1842000000
			end
			if mp > 9380000 and mp <= 9390000 then
				req = 1844000000
			end
			if mp > 9390000 and mp <= 9400000 then
				req = 1846000000
			end
			if mp > 9400000 and mp <= 9410000 then
				req = 1848000000
			end
			if mp > 9410000 and mp <= 9420000 then
				req = 1850000000
			end
			if mp > 9420000 and mp <= 9430000 then
				req = 1852000000
			end
			if mp > 9430000 and mp <= 9440000 then
				req = 1854000000
			end
			if mp > 9440000 and mp <= 9450000 then
				req = 1856000000
			end
			if mp > 9450000 and mp <= 9460000 then
				req = 1858000000
			end
			if mp > 9460000 and mp <= 9470000 then
				req = 1860000000
			end
			if mp > 9470000 and mp <= 9480000 then
				req = 1862000000
			end
			if mp > 9480000 and mp <= 9490000 then
				req = 1864000000
			end
			if mp > 9490000 and mp <= 9500000 then
				req = 1866000000
			end
			if mp > 9500000 and mp <= 9510000 then
				req = 1868000000
			end
			if mp > 9510000 and mp <= 9520000 then
				req = 1870000000
			end
			if mp > 9520000 and mp <= 9530000 then
				req = 1872000000
			end
			if mp > 9530000 and mp <= 9540000 then
				req = 1874000000
			end
			if mp > 9540000 and mp <= 9550000 then
				req = 1876000000
			end
			if mp > 9550000 and mp <= 9560000 then
				req = 1878000000
			end
			if mp > 9560000 and mp <= 9570000 then
				req = 1880000000
			end
			if mp > 9570000 and mp <= 9580000 then
				req = 1882000000
			end
			if mp > 9580000 and mp <= 9590000 then
				req = 1884000000
			end
			if mp > 9590000 and mp <= 9600000 then
				req = 1886000000
			end
			if mp > 9600000 and mp <= 9610000 then
				req = 1888000000
			end
			if mp > 9610000 and mp <= 9620000 then
				req = 1890000000
			end
			if mp > 9620000 and mp <= 9630000 then
				req = 1892000000
			end
			if mp > 9630000 and mp <= 9640000 then
				req = 1894000000
			end
			if mp > 9640000 and mp <= 9650000 then
				req = 1896000000
			end
			if mp > 9650000 and mp <= 9660000 then
				req = 1898000000
			end
			if mp > 9660000 and mp <= 9670000 then
				req = 1900000000
			end
			if mp > 9670000 and mp <= 9680000 then
				req = 1902000000
			end
			if mp > 9680000 and mp <= 9690000 then
				req = 1904000000
			end
			if mp > 9690000 and mp <= 9700000 then
				req = 1906000000
			end
			if mp > 9700000 and mp <= 9710000 then
				req = 1908000000
			end
			if mp > 9710000 and mp <= 9720000 then
				req = 1910000000
			end
			if mp > 9720000 and mp <= 9730000 then
				req = 1912000000
			end
			if mp > 9730000 and mp <= 9740000 then
				req = 1914000000
			end
			if mp > 9740000 and mp <= 9750000 then
				req = 1916000000
			end
			if mp > 9750000 and mp <= 9760000 then
				req = 1918000000
			end
			if mp > 9760000 and mp <= 9770000 then
				req = 1920000000
			end
			if mp > 9770000 and mp <= 9780000 then
				req = 1922000000
			end
			if mp > 9780000 and mp <= 9790000 then
				req = 1924000000
			end
			if mp > 9790000 and mp <= 9800000 then
				req = 1926000000
			end
			if mp > 9800000 and mp <= 9810000 then
				req = 1928000000
			end
			if mp > 9810000 and mp <= 9820000 then
				req = 1930000000
			end
			if mp > 9820000 and mp <= 9830000 then
				req = 1932000000
			end
			if mp > 9830000 and mp <= 9840000 then
				req = 1934000000
			end
			if mp > 9840000 and mp <= 9850000 then
				req = 1936000000
			end
			if mp > 9850000 and mp <= 9860000 then
				req = 1938000000
			end
			if mp > 9860000 and mp <= 9870000 then
				req = 1940000000
			end
			if mp > 9870000 and mp <= 9880000 then
				req = 1942000000
			end
			if mp > 9880000 and mp <= 9890000 then
				req = 1944000000
			end
			if mp > 9890000 and mp <= 9900000 then
				req = 1946000000
			end
			if mp > 9900000 and mp <= 9910000 then
				req = 1948000000
			end
			if mp > 9910000 and mp <= 9920000 then
				req = 1950000000
			end
			if mp > 9920000 and mp <= 9930000 then
				req = 1952000000
			end
			if mp > 9930000 and mp <= 9940000 then
				req = 1954000000
			end
			if mp > 9940000 and mp <= 9950000 then
				req = 1956000000
			end
			if mp > 9950000 and mp <= 9960000 then
				req = 1958000000
			end
			if mp > 9960000 and mp <= 9970000 then
				req = 1960000000
			end
			if mp > 9970000 and mp <= 9980000 then
				req = 1962000000
			end
			if mp > 9980000 and mp <= 9990000 then
				req = 1964000000
			end
			if mp > 9990000 and mp <= 10000000 then
				req = 1966000000
			end
			if mp > 10000000 and mp <= 10010000 then
				req = 1968000000
			end
		end
		return req
	end,
	checkLevelUp = function(player)
		if player.level == 99 and (player.baseHealth >= 35000 or player.baseMagic >= 35000) and player.class > 5 then
			player:maxLevelUp()
		end
		if player.level == 100 and (player.baseHealth >= 50000 or player.baseMagic >= 50000) then
			player:maxLevelUp()
		end
		if player.level == 101 and (player.baseHealth >= 65000 or player.baseMagic >= 65000) then
			player:maxLevelUp()
		end
		if player.level == 102 and (player.baseHealth >= 80000 or player.baseMagic >= 80000) then
			player:maxLevelUp()
		end
		if player.level == 103 and (player.baseHealth >= 95000 or player.baseMagic >= 95000) then
			player:maxLevelUp()
		end
		if player.level == 104 and (player.baseHealth >= 110000 or player.baseMagic >= 110000) then
			player:maxLevelUp()
		end
		if player.level == 105 and (player.baseHealth >= 125000 or player.baseMagic >= 125000) then
			player:maxLevelUp()
		end
		if player.level == 106 and (player.baseHealth >= 140000 or player.baseMagic >= 140000) then
			player:maxLevelUp()
		end
		if player.level == 107 and (player.baseHealth >= 155000 or player.baseMagic >= 155000) then
			player:maxLevelUp()
		end
		if player.level == 108 and (player.baseHealth >= 170000 or player.baseMagic >= 170000) then
			player:maxLevelUp()
		end
		if player.level == 109 and (player.baseHealth >= 185000 or player.baseMagic >= 185000) then
			player:maxLevelUp()
		end
		if (player.level == 110 and player.class >= 6) and (player.baseHealth >= 202500 or player.baseMagic >= 202500) then
			player:maxLevelUp()
		end
		if (player.level == 111 and player.class >= 6) and (player.baseHealth >= 220000 or player.baseMagic >= 220000) then
			player:maxLevelUp()
		end
		if (player.level == 112 and player.class >= 6) and (player.baseHealth >= 237500 or player.baseMagic >= 237500) then
			player:maxLevelUp()
		end
		if (player.level == 113 and player.class >= 6) and (player.baseHealth >= 255000 or player.baseMagic >= 255000) then
			player:maxLevelUp()
		end
		if (player.level == 114 and player.class >= 6) and (player.baseHealth >= 272500 or player.baseMagic >= 272500) then
			player:maxLevelUp()
		end
		if (player.level == 115 and player.class >= 6) and (player.baseHealth >= 290000 or player.baseMagic >= 290000) then
			player:maxLevelUp()
		end
		if (player.level == 116 and player.class >= 6) and (player.baseHealth >= 307500 or player.baseMagic >= 307500) then
			player:maxLevelUp()
		end
		if (player.level == 117 and player.class >= 6) and (player.baseHealth >= 325000 or player.baseMagic >= 325000) then
			player:maxLevelUp()
		end
		if (player.level == 118 and player.class >= 6) and (player.baseHealth >= 342500 or player.baseMagic >= 342500) then
			player:maxLevelUp()
		end
		if (player.level == 119 and player.class >= 6) and (player.baseHealth >= 360000 or player.baseMagic >= 360000) then
			player:maxLevelUp()
		end
		if (player.level == 120 and player.class >= 6) and (player.baseHealth >= 380000 or player.baseMagic >= 380000) then
			player:maxLevelUp()
		end
		if (player.level == 121 and player.class >= 6) and (player.baseHealth >= 400000 or player.baseMagic >= 400000) then
			player:maxLevelUp()
		end
		if (player.level == 122 and player.class >= 6) and (player.baseHealth >= 420000 or player.baseMagic >= 420000) then
			player:maxLevelUp()
		end
		if (player.level == 123 and player.class >= 6) and (player.baseHealth >= 440000 or player.baseMagic >= 440000) then
			player:maxLevelUp()
		end
		if (player.level == 124 and player.class >= 6) and (player.baseHealth >= 460000 or player.baseMagic >= 460000) then
			player:maxLevelUp()
		end
		if (player.level == 125 and player.mark >= 1) and (player.baseHealth >= 482500 or player.baseMagic >= 482500) then
			player:maxLevelUp()
		end
		if (player.level == 126 and player.mark >= 1) and (player.baseHealth >= 505000 or player.baseMagic >= 505000) then
			player:maxLevelUp()
		end
		if (player.level == 127 and player.mark >= 1) and (player.baseHealth >= 527500 or player.baseMagic >= 527500) then
			player:maxLevelUp()
		end
		if (player.level == 128 and player.mark >= 1) and (player.baseHealth >= 550000 or player.baseMagic >= 550000) then
			player:maxLevelUp()
		end
		if (player.level == 129 and player.mark >= 1) and (player.baseHealth >= 572500 or player.baseMagic >= 572500) then
			player:maxLevelUp()
		end
		if (player.level == 130 and player.mark >= 1) and (player.baseHealth >= 595000 or player.baseMagic >= 595000) then
			player:maxLevelUp()
		end
		if (player.level == 131 and player.mark >= 1) and (player.baseHealth >= 617500 or player.baseMagic >= 617500) then
			player:maxLevelUp()
		end
		if (player.level == 132 and player.mark >= 1) and (player.baseHealth >= 640000 or player.baseMagic >= 640000) then
			player:maxLevelUp()
		end
		if (player.level == 133 and player.mark >= 1) and (player.baseHealth >= 662500 or player.baseMagic >= 662500) then
			player:maxLevelUp()
		end
		if (player.level == 134 and player.mark >= 1) and (player.baseHealth >= 685000 or player.baseMagic >= 685000) then
			player:maxLevelUp()
		end
		if (player.level == 135 and player.mark >= 1) and (player.baseHealth >= 712500 or player.baseMagic >= 712500) then
			player:maxLevelUp()
		end
		if (player.level == 136 and player.mark >= 1) and (player.baseHealth >= 740000 or player.baseMagic >= 740000) then
			player:maxLevelUp()
		end
		if (player.level == 137 and player.mark >= 1) and (player.baseHealth >= 767500 or player.baseMagic >= 767500) then
			player:maxLevelUp()
		end
		if (player.level == 138 and player.mark >= 1) and (player.baseHealth >= 795000 or player.baseMagic >= 795000) then
			player:maxLevelUp()
		end
		if (player.level == 139 and player.mark >= 1) and (player.baseHealth >= 822500 or player.baseMagic >= 822500) then
			player:maxLevelUp()
		end
		if (player.level == 140 and player.mark >= 1) and (player.baseHealth >= 850000 or player.baseMagic >= 850000) then
			player:maxLevelUp()
		end
		if (player.level == 141 and player.mark >= 1) and (player.baseHealth >= 877500 or player.baseMagic >= 877500) then
			player:maxLevelUp()
		end
		if (player.level == 142 and player.mark >= 1) and (player.baseHealth >= 905000 or player.baseMagic >= 905000) then
			player:maxLevelUp()
		end
		if (player.level == 143 and player.mark >= 1) and (player.baseHealth >= 932500 or player.baseMagic >= 932500) then
			player:maxLevelUp()
		end
		if (player.level == 144 and player.mark >= 1) and (player.baseHealth >= 960000 or player.baseMagic >= 960000) then
			player:maxLevelUp()
		end
		if (player.level == 145 and player.mark >= 1) and (player.baseHealth >= 990000 or player.baseMagic >= 990000) then
			player:maxLevelUp()
		end
		if (player.level == 146 and player.mark >= 1) and (player.baseHealth >= 1020000 or player.baseMagic >= 1020000) then
			player:maxLevelUp()
		end
		if (player.level == 147 and player.mark >= 1) and (player.baseHealth >= 1050000 or player.baseMagic >= 1050000) then
			player:maxLevelUp()
		end
		if (player.level == 148 and player.mark >= 1) and (player.baseHealth >= 1080000 or player.baseMagic >= 1080000) then
			player:maxLevelUp()
		end
		if (player.level == 149 and player.mark >= 1) and (player.baseHealth >= 1110000 or player.baseMagic >= 1110000) then
			player:maxLevelUp()
		end
		if (player.level == 150 and player.mark >= 2) and (player.baseHealth >= 1142500 or player.baseMagic >= 1142500) then
			player:maxLevelUp()
		end
		if (player.level == 151 and player.mark >= 2) and (player.baseHealth >= 1175000 or player.baseMagic >= 1175000) then
			player:maxLevelUp()
		end
		if (player.level == 152 and player.mark >= 2) and (player.baseHealth >= 1207500 or player.baseMagic >= 1207500) then
			player:maxLevelUp()
		end
		if (player.level == 153 and player.mark >= 2) and (player.baseHealth >= 1240000 or player.baseMagic >= 1240000) then
			player:maxLevelUp()
		end
		if (player.level == 154 and player.mark >= 2) and (player.baseHealth >= 1272500 or player.baseMagic >= 1272500) then
			player:maxLevelUp()
		end
		if (player.level == 155 and player.mark >= 2) and (player.baseHealth >= 1305000 or player.baseMagic >= 1305000) then
			player:maxLevelUp()
		end
		if (player.level == 156 and player.mark >= 2) and (player.baseHealth >= 1337500 or player.baseMagic >= 1337500) then
			player:maxLevelUp()
		end
		if (player.level == 157 and player.mark >= 2) and (player.baseHealth >= 1370000 or player.baseMagic >= 1370000) then
			player:maxLevelUp()
		end
		if (player.level == 158 and player.mark >= 2) and (player.baseHealth >= 1402500 or player.baseMagic >= 1402500) then
			player:maxLevelUp()
		end
		if (player.level == 159 and player.mark >= 2) and (player.baseHealth >= 1435000 or player.baseMagic >= 1435000) then
			player:maxLevelUp()
		end
		if (player.level == 160 and player.mark >= 2) and (player.baseHealth >= 1470000 or player.baseMagic >= 1470000) then
			player:maxLevelUp()
		end
		if (player.level == 161 and player.mark >= 2) and (player.baseHealth >= 1505000 or player.baseMagic >= 1505000) then
			player:maxLevelUp()
		end
		if (player.level == 162 and player.mark >= 2) and (player.baseHealth >= 1540000 or player.baseMagic >= 1540000) then
			player:maxLevelUp()
		end
		if (player.level == 163 and player.mark >= 2) and (player.baseHealth >= 1575000 or player.baseMagic >= 1575000) then
			player:maxLevelUp()
		end
		if (player.level == 164 and player.mark >= 2) and (player.baseHealth >= 1610000 or player.baseMagic >= 1610000) then
			player:maxLevelUp()
		end
		if (player.level == 165 and player.mark >= 2) and (player.baseHealth >= 1645000 or player.baseMagic >= 1645000) then
			player:maxLevelUp()
		end
		if (player.level == 166 and player.mark >= 2) and (player.baseHealth >= 1680000 or player.baseMagic >= 1680000) then
			player:maxLevelUp()
		end
		if (player.level == 167 and player.mark >= 2) and (player.baseHealth >= 1715000 or player.baseMagic >= 1715000) then
			player:maxLevelUp()
		end
		if (player.level == 168 and player.mark >= 2) and (player.baseHealth >= 1750000 or player.baseMagic >= 1750000) then
			player:maxLevelUp()
		end
		if (player.level == 169 and player.mark >= 2) and (player.baseHealth >= 1785000 or player.baseMagic >= 1785000) then
			player:maxLevelUp()
		end
		if (player.level == 170 and player.mark >= 2) and (player.baseHealth >= 1822500 or player.baseMagic >= 1822500) then
			player:maxLevelUp()
		end
		if (player.level == 171 and player.mark >= 2) and (player.baseHealth >= 1860000 or player.baseMagic >= 1860000) then
			player:maxLevelUp()
		end
		if (player.level == 172 and player.mark >= 2) and (player.baseHealth >= 1897500 or player.baseMagic >= 1897500) then
			player:maxLevelUp()
		end
		if (player.level == 173 and player.mark >= 2) and (player.baseHealth >= 1935000 or player.baseMagic >= 1935000) then
			player:maxLevelUp()
		end
		if (player.level == 174 and player.mark >= 2) and (player.baseHealth >= 1972500 or player.baseMagic >= 1972500) then
			player:maxLevelUp()
		end
		if (player.level == 175 and player.mark >= 3) and (player.baseHealth >= 2012500 or player.baseMagic >= 2012500) then
			player:maxLevelUp()
		end
		if (player.level == 176 and player.mark >= 3) and (player.baseHealth >= 2052500 or player.baseMagic >= 2052500) then
			player:maxLevelUp()
		end
		if (player.level == 177 and player.mark >= 3) and (player.baseHealth >= 2092500 or player.baseMagic >= 2092500) then
			player:maxLevelUp()
		end
		if (player.level == 178 and player.mark >= 3) and (player.baseHealth >= 2132500 or player.baseMagic >= 2132500) then
			player:maxLevelUp()
		end
		if (player.level == 179 and player.mark >= 3) and (player.baseHealth >= 2172500 or player.baseMagic >= 2172500) then
			player:maxLevelUp()
		end
		if (player.level == 180 and player.mark >= 3) and (player.baseHealth >= 2212500 or player.baseMagic >= 2212500) then
			player:maxLevelUp()
		end
		if (player.level == 181 and player.mark >= 3) and (player.baseHealth >= 2252500 or player.baseMagic >= 2252500) then
			player:maxLevelUp()
		end
		if (player.level == 182 and player.mark >= 3) and (player.baseHealth >= 2292500 or player.baseMagic >= 2292500) then
			player:maxLevelUp()
		end
		if (player.level == 183 and player.mark >= 3) and (player.baseHealth >= 2332500 or player.baseMagic >= 2332500) then
			player:maxLevelUp()
		end
		if (player.level == 184 and player.mark >= 3) and (player.baseHealth >= 2372500 or player.baseMagic >= 2372500) then
			player:maxLevelUp()
		end
		if (player.level == 185 and player.mark >= 3) and (player.baseHealth >= 2415000 or player.baseMagic >= 2415000) then
			player:maxLevelUp()
		end
		if (player.level == 186 and player.mark >= 3) and (player.baseHealth >= 2457500 or player.baseMagic >= 2457500) then
			player:maxLevelUp()
		end
		if (player.level == 187 and player.mark >= 3) and (player.baseHealth >= 2500000 or player.baseMagic >= 2500000) then
			player:maxLevelUp()
		end
		if (player.level == 188 and player.mark >= 3) and (player.baseHealth >= 2542500 or player.baseMagic >= 2542500) then
			player:maxLevelUp()
		end
		if (player.level == 189 and player.mark >= 3) and (player.baseHealth >= 2585000 or player.baseMagic >= 2585000) then
			player:maxLevelUp()
		end
		if (player.level == 190 and player.mark >= 3) and (player.baseHealth >= 2627500 or player.baseMagic >= 2627500) then
			player:maxLevelUp()
		end
		if (player.level == 191 and player.mark >= 3) and (player.baseHealth >= 2670000 or player.baseMagic >= 2670000) then
			player:maxLevelUp()
		end
		if (player.level == 192 and player.mark >= 3) and (player.baseHealth >= 2712500 or player.baseMagic >= 2712500) then
			player:maxLevelUp()
		end
		if (player.level == 193 and player.mark >= 3) and (player.baseHealth >= 2755000 or player.baseMagic >= 2755000) then
			player:maxLevelUp()
		end
		if (player.level == 194 and player.mark >= 3) and (player.baseHealth >= 2797500 or player.baseMagic >= 2797500) then
			player:maxLevelUp()
		end
		if (player.level == 195 and player.mark >= 3) and (player.baseHealth >= 2842500 or player.baseMagic >= 2842500) then
			player:maxLevelUp()
		end
		if (player.level == 196 and player.mark >= 3) and (player.baseHealth >= 2887500 or player.baseMagic >= 2887500) then
			player:maxLevelUp()
		end
		if (player.level == 197 and player.mark >= 3) and (player.baseHealth >= 2932500 or player.baseMagic >= 2932500) then
			player:maxLevelUp()
		end
		if (player.level == 198 and player.mark >= 3) and (player.baseHealth >= 2977500 or player.baseMagic >= 2977500) then
			player:maxLevelUp()
		end
		if (player.level == 199 and player.mark >= 3) and (player.baseHealth >= 3022500 or player.baseMagic >= 3022500) then
			player:maxLevelUp()
		end
		if (player.level == 200 and player.mark >= 4) and (player.baseHealth >= 3070000 or player.baseMagic >= 3070000) then
			player:maxLevelUp()
		end
		if (player.level == 201 and player.mark >= 4) and (player.baseHealth >= 3117500 or player.baseMagic >= 3117500) then
			player:maxLevelUp()
		end
		if (player.level == 202 and player.mark >= 4) and (player.baseHealth >= 3165000 or player.baseMagic >= 3165000) then
			player:maxLevelUp()
		end
		if (player.level == 203 and player.mark >= 4) and (player.baseHealth >= 3212500 or player.baseMagic >= 3212500) then
			player:maxLevelUp()
		end
		if (player.level == 204 and player.mark >= 4) and (player.baseHealth >= 3260000 or player.baseMagic >= 3260000) then
			player:maxLevelUp()
		end
		if (player.level == 205 and player.mark >= 4) and (player.baseHealth >= 3307500 or player.baseMagic >= 3307500) then
			player:maxLevelUp()
		end
		if (player.level == 206 and player.mark >= 4) and (player.baseHealth >= 3355000 or player.baseMagic >= 3355000) then
			player:maxLevelUp()
		end
		if (player.level == 207 and player.mark >= 4) and (player.baseHealth >= 3402500 or player.baseMagic >= 3402500) then
			player:maxLevelUp()
		end
		if (player.level == 208 and player.mark >= 4) and (player.baseHealth >= 3450000 or player.baseMagic >= 3450000) then
			player:maxLevelUp()
		end
		if (player.level == 209 and player.mark >= 4) and (player.baseHealth >= 3497500 or player.baseMagic >= 3497500) then
			player:maxLevelUp()
		end
		if (player.level == 210 and player.mark >= 4) and (player.baseHealth >= 3547500 or player.baseMagic >= 3547500) then
			player:maxLevelUp()
		end
		if (player.level == 211 and player.mark >= 4) and (player.baseHealth >= 3597500 or player.baseMagic >= 3597500) then
			player:maxLevelUp()
		end
		if (player.level == 212 and player.mark >= 4) and (player.baseHealth >= 3647500 or player.baseMagic >= 3647500) then
			player:maxLevelUp()
		end
		if (player.level == 213 and player.mark >= 4) and (player.baseHealth >= 3697500 or player.baseMagic >= 3697500) then
			player:maxLevelUp()
		end
		if (player.level == 214 and player.mark >= 4) and (player.baseHealth >= 3747500 or player.baseMagic >= 3747500) then
			player:maxLevelUp()
		end
		if (player.level == 215 and player.mark >= 4) and (player.baseHealth >= 3797500 or player.baseMagic >= 3797500) then
			player:maxLevelUp()
		end
		if (player.level == 216 and player.mark >= 4) and (player.baseHealth >= 3847500 or player.baseMagic >= 3847500) then
			player:maxLevelUp()
		end
		if (player.level == 217 and player.mark >= 4) and (player.baseHealth >= 3897500 or player.baseMagic >= 3897500) then
			player:maxLevelUp()
		end
		if (player.level == 218 and player.mark >= 4) and (player.baseHealth >= 3947500 or player.baseMagic >= 3947500) then
			player:maxLevelUp()
		end
		if (player.level == 219 and player.mark >= 4) and (player.baseHealth >= 3997500 or player.baseMagic >= 3997500) then
			player:maxLevelUp()
		end
		if (player.level == 220 and player.mark >= 4) and (player.baseHealth >= 4050000 or player.baseMagic >= 4050000) then
			player:maxLevelUp()
		end
		if (player.level == 221 and player.mark >= 4) and (player.baseHealth >= 4102500 or player.baseMagic >= 4102500) then
			player:maxLevelUp()
		end
		if (player.level == 222 and player.mark >= 4) and (player.baseHealth >= 4155000 or player.baseMagic >= 4155000) then
			player:maxLevelUp()
		end
		if (player.level == 223 and player.mark >= 4) and (player.baseHealth >= 4207500 or player.baseMagic >= 4207500) then
			player:maxLevelUp()
		end
		if (player.level == 224 and player.mark >= 4) and (player.baseHealth >= 4260000 or player.baseMagic >= 4260000) then
			player:maxLevelUp()
		end
		if (player.level == 225 and player.mark >= 5) and (player.baseHealth >= 4315000 or player.baseMagic >= 4315000) then
			player:maxLevelUp()
		end
		if (player.level == 226 and player.mark >= 5) and (player.baseHealth >= 4370000 or player.baseMagic >= 4370000) then
			player:maxLevelUp()
		end
		if (player.level == 227 and player.mark >= 5) and (player.baseHealth >= 4425000 or player.baseMagic >= 4425000) then
			player:maxLevelUp()
		end
		if (player.level == 228 and player.mark >= 5) and (player.baseHealth >= 4480000 or player.baseMagic >= 4480000) then
			player:maxLevelUp()
		end
		if (player.level == 229 and player.mark >= 5) and (player.baseHealth >= 4535000 or player.baseMagic >= 4535000) then
			player:maxLevelUp()
		end
		if (player.level == 230 and player.mark >= 5) and (player.baseHealth >= 4590000 or player.baseMagic >= 4590000) then
			player:maxLevelUp()
		end
		if (player.level == 231 and player.mark >= 5) and (player.baseHealth >= 4645000 or player.baseMagic >= 4645000) then
			player:maxLevelUp()
		end
		if (player.level == 232 and player.mark >= 5) and (player.baseHealth >= 4700000 or player.baseMagic >= 4700000) then
			player:maxLevelUp()
		end
		if (player.level == 233 and player.mark >= 5) and (player.baseHealth >= 4755000 or player.baseMagic >= 4755000) then
			player:maxLevelUp()
		end
		if (player.level == 234 and player.mark >= 5) and (player.baseHealth >= 4810000 or player.baseMagic >= 4810000) then
			player:maxLevelUp()
		end
		if (player.level == 235 and player.mark >= 5) and (player.baseHealth >= 4867500 or player.baseMagic >= 4867500) then
			player:maxLevelUp()
		end
		if (player.level == 236 and player.mark >= 5) and (player.baseHealth >= 4925000 or player.baseMagic >= 4925000) then
			player:maxLevelUp()
		end
		if (player.level == 237 and player.mark >= 5) and (player.baseHealth >= 4982500 or player.baseMagic >= 4982500) then
			player:maxLevelUp()
		end
		if (player.level == 238 and player.mark >= 5) and (player.baseHealth >= 5040000 or player.baseMagic >= 5040000) then
			player:maxLevelUp()
		end
		if (player.level == 239 and player.mark >= 5) and (player.baseHealth >= 5097500 or player.baseMagic >= 5097500) then
			player:maxLevelUp()
		end
		if (player.level == 240 and player.mark >= 5) and (player.baseHealth >= 5155000 or player.baseMagic >= 5155000) then
			player:maxLevelUp()
		end
		if (player.level == 241 and player.mark >= 5) and (player.baseHealth >= 5212500 or player.baseMagic >= 5212500) then
			player:maxLevelUp()
		end
		if (player.level == 242 and player.mark >= 5) and (player.baseHealth >= 5270000 or player.baseMagic >= 5270000) then
			player:maxLevelUp()
		end
		if (player.level == 243 and player.mark >= 5) and (player.baseHealth >= 5327500 or player.baseMagic >= 5327500) then
			player:maxLevelUp()
		end
		if (player.level == 244 and player.mark >= 5) and (player.baseHealth >= 5385000 or player.baseMagic >= 5385000) then
			player:maxLevelUp()
		end
		if (player.level == 245 and player.mark >= 5) and (player.baseHealth >= 5445000 or player.baseMagic >= 5445000) then
			player:maxLevelUp()
		end
		if (player.level == 246 and player.mark >= 5) and (player.baseHealth >= 5505000 or player.baseMagic >= 5505000) then
			player:maxLevelUp()
		end
		if (player.level == 247 and player.mark >= 5) and (player.baseHealth >= 5565000 or player.baseMagic >= 5565000) then
			player:maxLevelUp()
		end
		if (player.level == 248 and player.mark >= 5) and (player.baseHealth >= 5625000 or player.baseMagic >= 5625000) then
			player:maxLevelUp()
		end
		if (player.level == 249 and player.mark >= 5) and (player.baseHealth >= 5685000 or player.baseMagic >= 5685000) then
			player:maxLevelUp()
		end
		if (player.level == 250 and player.mark >= 6) and (player.baseHealth >= 6500000 or player.baseMagic >= 6500000) then
			player:maxLevelUp()
		end
		if (player.level == 251 and player.mark >= 6) and (player.baseHealth >= 8000000 or player.baseMagic >= 8000000) then
			player:maxLevelUp()
		end
		if (player.level == 252 and player.mark >= 6) and (player.baseHealth >= 10000000 or player.baseMagic >= 10000000) then
			player:maxLevelUp()
		end
		if (player.level == 253 and player.mark >= 6) and (player.baseHealth >= 15000000 or player.baseMagic >= 15000000) then
			player:maxLevelUp()
		end
		if (player.level == 254 and player.mark >= 6) and (player.baseHealth >= 25000000 or player.baseMagic >= 25000000) then
			player:maxLevelUp()
		end
	end
}

dre_locs_drain = {
	--make sure cant gate or f1 while cast - gateway, gateway2,

	while_cast = function(player)
		local expLoss = 66666666
		local anim = 309
		local expToTake = 2000000000

		player.paralyzed = true
		player:sendAnimation(anim)
		if player.exp >= expLoss then
			--		player:talk(0,"exp drained: "..player.registry["exp_drained"])
			player.exp = player.exp - expLoss
			player.registry["exp_drained"] = player.registry["exp_drained"] + expLoss
		elseif player.exp < expLoss then
			player.registry["exp_maxes"] = player.registry["exp_maxes"] - 1
			player.exp = player.exp + 4000000000
			player:sendStatus()
			player.exp = player.exp - expLoss
			player.registry["exp_drained"] = player.registry["exp_drained"] + expLoss
		--		player:talk(0,"MAX EXCHANGED: exp drained: "..player.registry["exp_drained"])
		end
		player:sendStatus()
	end,
	uncast = function(player)
		--	player:talk(0,"Current exp: "..player.exp)
		--	player:talk(0,"exp drained: "..player.registry["exp_drained"])

		if player.registry["exp_drained"] < 2000000000 then
			local diff = (2000000000 - player.registry["exp_drained"])
			--		player:talk(0,"diff: "..diff)
			if player.exp - diff >= 0 then
				player.exp = player.exp - diff
			elseif player.exp - diff < 0 then
				player.exp = 0
			end
		end
		player.registry["exp_drained"] = 0
		player.registry["drained_by_dre_loc"] = 1
		player.paralyzed = false
		player:sendStatus()
	end
}
