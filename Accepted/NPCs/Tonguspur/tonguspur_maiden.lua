-- maidens quest
tonguspur_maiden = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local opts = {}
			local offenseName
			local defenseName

			if player.baseClass == 1 then
				offenseName = "Chainmail (Offense)"
				defenseName = "Platemail (Defense)"
			end
			if player.baseClass == 2 then
				offenseName = "Tunic (Offense)"
				defenseName = "Leathers (Defense)"
			end
			if player.baseClass == 3 then
				offenseName = "Shroud"
				defenseName = "Robe"
			end
			if player.baseClass == 4 then
				offenseName = "Hauberk (Armor)"
				defenseName = "Hide (Magic)"
			end

			table.insert(opts, "What's your story?")
			if player.quest["maiden"] == 0 and player.level >= 50 then
				table.insert(opts, "Who is this Draco? What is wrong?")
			end
			if player.quest["maiden"] >= 1 and player.quest["maiden"] <= 2 then
				table.insert(opts, "Where can I find this Oracle?")
			end
			if player.quest["maiden"] == 3 then
				table.insert(opts, "The Oracle in Hon says he can make a potion for you!")
			end
			if player.quest["maiden"] == 4 then
				table.insert(opts, "It will temporarily make you look hideous!")
			end
			if player.quest["maiden"] == 7 then
				table.insert(opts, "I have the Oracle's potion!")
			end
			if player.quest["maiden"] == 8 then
				table.insert(opts, "Let him come. I will defend you.")
			end
			if player.quest["maiden"] == 9 then
				table.insert(opts, "You are safe now!")
			end
			if player:hasLegend("maiden") == true then
				table.insert(opts, "How are you now?")
			end

			menu = player:menuString(name .. "Did Draco send you? I don't want to go!", opts)

			if menu == "What's your story?" then
				player:dialogSeq(
					{
						t,
						name ..
							"I am just a carpenters daughter. Though I really want to move inside the city and away from all the ruffians."
					},
					1
				)
			elseif menu == "Who is this Draco? What is wrong?" then
				player:dialogSeq(
					{
						t,
						name .. "Draco is a mercenary who abandoned his post as a Hon soldier.",
						name .. "He has forced my father to pay him to live out here for many moons now.",
						name .. "Most recently, on his last extortion visit, he told my father he is taking me as his wife.",
						name .. "I don't know what to do. I do not want to be his wife. I would rather die.",
						name .. "My last trip to Hon, I asked Harvey if he could make me appear as though I was dead.",
						name .. "He tried to make a potion to help me but said that the formula was unstable and exploded.",
						name .. "I don't know what else to do. I need to consult the oracle but I have so much work to do here.",
						name .. "Maybe you can help me?"
					},
					1
				)
				player.quest["maiden"] = 1
				player:msg(4, "[Quest Updated] Find the Oracle!", player.ID)
			elseif menu == "Where can I find this Oracle?" then
				player:dialogSeq(
					{
						t,
						name .. "The Oracle has a shop in Hon by the Sea. Just East from the Northern City Gate.",
						name .. "Just tell him that I could not come myself please.",
						name .. "Then return back here and let me know what I should do!"
					},
					1
				)
			elseif menu == "The Oracle in Hon says he can make a potion for you!" then
				player:dialogSeq(
					{
						t,
						name .. "Ohh what a relief! What will it do? What do you need?",
						name .. "A lock of hair? Is that all? Sure, here you go.",
						"**Jules reaches for a knife, quickly slices off a short lock, and hands it to you**",
						name .. "Ohh boy I am so excited right now.",
						name .. "Please, tell me, what will it do? How will it work?"
					},
					1
				)
				player.quest["maiden"] = 4
				player:msg(4, "[Quest Updated] Take Jules' hair back to the oracle!", player.ID)
			elseif menu == "It will temporarily make you so hideous so no one would want you!" then
				player:dialogSeq(
					{
						t,
						name .. "I pray this works. Thank you soo much for helping me.",
						name .. "If there is anything I can do to repay you just ask.",
						name .. "My father has been given many pieces of armor and weapons over time.",
						name .. "Most of us out here trade items, food and clothing for help!"
					},
					1
				)
				player.quest["maiden"] = 5
			elseif menu == "I have the Oracle's potion!" then
				player:dialogSeq(
					{t, name .. "Ohh no, it is too late. Here he comes. Here, take these. May they protect you from his fury!"},
					1
				)
				armorchoice = player:menuString(name .. "What style do you prefer?", {offenseName .. "", defenseName .. ""})
				if armorchoice == offenseName .. "" then
					if player.sex == 0 then
						if player.baseClass == 1 then
							player:addItem("apprentice_chainmail_m", 1)
						end
						if player.baseClass == 2 then
							player:addItem("apprentice_tunic_m", 1)
						end
						if player.baseClass == 3 then
							player:addItem("apprentice_shroud_m", 1)
						end
						if player.baseClass == 4 then
							player:addItem("apprentice_hauberk_m", 1)
						end
					elseif player.sex == 1 then
						if player.baseClass == 1 then
							player:addItem("apprentice_chainmail_f", 1)
						end
						if player.baseClass == 2 then
							player:addItem("apprentice_tunic_f", 1)
						end
						if player.baseClass == 3 then
							player:addItem("apprentice_shroud_f", 1)
						end
						if player.baseClass == 4 then
							player:addItem("apprentice_hauberk_f", 1)
						end
					end
				elseif armorchoice == defenseName .. "" then
					if player.sex == 0 then
						if player.baseClass == 1 then
							player:addItem("apprentice_platemail_m", 1)
						end
						if player.baseClass == 2 then
							player:addItem("apprentice_leathers_m", 1)
						end
						if player.baseClass == 3 then
							player:addItem("apprentice_robe_m", 1)
						end
						if player.baseClass == 4 then
							player:addItem("apprentice_hide_m", 1)
						end
					elseif player.sex == 1 then
						if player.baseClass == 1 then
							player:addItem("apprentice_platemail_f", 1)
						end
						if player.baseClass == 2 then
							player:addItem("apprentice_leathers_f", 1)
						end
						if player.baseClass == 3 then
							player:addItem("apprentice_robe_f", 1)
						end
						if player.baseClass == 4 then
							player:addItem("apprentice_hide_f", 1)
						end
					end
				end
				if player.baseClass == 1 then
					player:addItem(16006, 1)
				end --weapon
				if player.baseClass == 1 then
					player:addItem(16304, 1)
				end --helm
				if player.baseClass == 1 then
					player:addItem(16703, 1)
				end --boots
				if player.baseClass == 2 then
					player:addItem(17006, 1)
				end --weapon
				if player.baseClass == 2 then
					player:addItem(17304, 1)
				end --helm
				if player.baseClass == 2 then
					player:addItem(17703, 1)
				end --boots
				if player.baseClass == 3 then
					player:addItem(18006, 1)
				end --weapon
				if player.baseClass == 3 then
					player:addItem(18304, 1)
				end --helm
				if player.baseClass == 3 then
					player:addItem(18703, 1)
				end --boots
				if player.baseClass == 4 then
					player:addItem(19006, 1)
				end --weapon
				if player.baseClass == 4 then
					player:addItem(19304, 1)
				end --helm
				if player.baseClass == 4 then
					player:addItem(19703, 1)
				end --boots
				player:sendStatus()
				player:msg(4, "[Quest Updated] Prepare yourself to fight Draco!", player.ID)
				player.quest["maiden"] = 8
			elseif menu == "Let him come. I will defend you." then
				player:dialogSeq({t, name .. "Please don't die!"}, 1)
				player:msg(4, "[Quest Updated] Kill Draco to Defend the Maiden.", player.ID)
				player:spawn(2000, 7, 12, 1)
				player.quest["maiden"] = 9
			elseif menu == "You are safe now!" then
				giveXP(player, 500000)
				player:addGold(10000)
				finishedQuest(player)
				player:calcStat()
				player:sendStatus()
				player:dialogSeq(
					{
						t,
						name .. "You are my hero!",
						name .. "Oh, by the way, I guess I don't need this potion after all, so you can keep it."
					},
					1
				)
				player:addLegend("Defended the Maiden " .. curT(), "maiden", 1, 16)
				player:addItem(395, 1)
				player:msg(4, "[Quest Completed] A Legend Mark is obtained!", player.ID)
				player.quest["maiden"] = 10
			elseif menu == "How are you now?" then
				player:dialogSeq({t, name .. "I am doing great. Thank you soo much for all your help!"}, 1)
			end
		end
	),
	nearbyPlayers = function(npc)
		local pc = npc:getObjectsInArea(BL_PC)
		local m, x, y = npc.m, npc.x, npc.y

		if #pc > 0 then
			for i = 1, #pc do
				if pc[i].quest["maiden"] == 0 and pc[i].level >= 50 then
					pc[i]:selfAnimationXY(pc[i].ID, 248, x, y)
				end
			end
		end
	end
}
