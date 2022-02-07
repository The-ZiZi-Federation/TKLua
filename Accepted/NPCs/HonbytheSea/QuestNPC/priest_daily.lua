priest_daily = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local opts = {}
			if player.quest["dailyq"] == 0 then
				table.insert(opts, "Start Daily Mission")
			end
			if player.quest["dailyq"] == 1 then
				table.insert(opts, "Finished Daily Mission")
			end
			if player.quest["dailyq"] == 1 then
				table.insert(opts, "Abandon Daily Mission")
			end
			table.insert(opts, "Nothing")

			if player.baseClass ~= 4 then
				player:dialogSeq({t, name .. "Sorry, I can't help you."}, 1)
			elseif player.level <= 98 then
				player:dialogSeq({t, name .. "Sorry, come back when you're stronger."}, 1)
			elseif player.registry["daily_quest_timer"] > os.time() then
				player:dialogSeq(
					{
						t,
						name ..
							"You have already done a mission today. Come back later.\n\nAvailable again in: " ..
								math.ceil(((player.registry["daily_quest_timer"] - os.time()) / 3600)) .. " hours"
					},
					1
				)
			else
				menu = player:menuString(name .. "Would you like a daily mission?", opts)
			end
			if player.registry["daily_quest_timer"] < os.time() then
				if menu == "Start Daily Mission" then
					player:dialogSeq(
						{
							t,
							name ..
								"We collect items both arcane and mundane in order to further our research and our understanding of the nature of Magic.",
							name .. "Today's mission is..."
						},
						1
					)
					dailyq = math.random(1, 9)
					if dailyq == 1 then
						player.quest["dailyq"] = 1
						player.quest["dailyq_1"] = 1
						player:dialogSeq(
							{t, name .. "Slay Man o'Wars on Tonguspur Beach and bring me 25 Jellyfish Tentacles as proof."},
							1
						)
					elseif dailyq == 2 then
						player.quest["dailyq"] = 1
						player.quest["dailyq_2"] = 1
						player:dialogSeq(
							{t, name .. "Slay Mutated Minnows in the Contaminated cave and bring me 25 Minnow Scale as proof."},
							1
						)
					elseif dailyq == 3 then
						player.quest["dailyq"] = 1
						player.quest["dailyq_3"] = 1
						player:dialogSeq(
							{t, name .. "Slay Posessed Snails on Tonguspur Beach and bring me 1 Snail Shell Fragment as proof."},
							1
						)
					elseif dailyq == 4 then
						player.quest["dailyq"] = 1
						player.quest["dailyq_4"] = 1
						player:dialogSeq(
							{t, name .. "Slay Tomb Robbers in the Disturbed Crypt and bring me 25 Stolen Swords as proof."},
							1
						)
					elseif dailyq == 5 then
						player.quest["dailyq"] = 1
						player.quest["dailyq_5"] = 1
						player:dialogSeq(
							{t, name .. "Slay Crazed Lobsters on Tonguspur Beach and bring me 25 Lobster Claws as proof."},
							1
						)
					elseif dailyq == 6 then
						player.quest["dailyq"] = 1
						player.quest["dailyq_6"] = 1
						player:dialogSeq({t, name .. "Slay Spiders in the Spider Den and bring me 25 Spider Silk as proof."}, 1)
					elseif dailyq == 7 then
						player.quest["dailyq"] = 1
						player.quest["dailyq_7"] = 1
						player:dialogSeq({t, name .. "Slay Leeches in the Leech Path and bring me 25 Leech Ooze as proof."}, 1)
					elseif dailyq == 8 then
						player.quest["dailyq"] = 1
						player.quest["dailyq_8"] = 1
						player:dialogSeq({t, name .. "Slay Queen Spiders in the Spider Den and bring me 1 Queen Venom Sac as proof."}, 1)
					elseif dailyq == 9 then
						player.quest["dailyq"] = 1
						player.quest["dailyq_9"] = 1
						player:dialogSeq(
							{t, name .. "Slay Scumbag Thieves in the Disturbed Tomb and bring me 1 Stolen Blades as proof."},
							1
						)
					end
				elseif menu == "Abandon Daily Mission" then
					abandon = player:menuString(name .. "Would you like to abandon your current mission?", {"Yes", "No"})
					if abandon == "Yes" then
						player.quest["dailyq"] = 0
						player.quest["dailyq_1"] = 0
						player.quest["dailyq_2"] = 0
						player.quest["dailyq_3"] = 0
						player.quest["dailyq_4"] = 0
						player.quest["dailyq_5"] = 0
						player.quest["dailyq_6"] = 0
						player.quest["dailyq_7"] = 0
						player.quest["dailyq_8"] = 0
						player.quest["dailyq_9"] = 0
						player.registry["daily_quest_timer"] = os.time() + 43200
						player:popUp("Mission Abandoned!")
					end
				elseif menu == "Finished Daily Mission" then
					if player.quest["dailyq_1"] == 1 then
						if player:hasItem("jellyfish_tentacle", 25) == true then
							player:removeItem("jellyfish_tentacle", 25)
							player:dialogSeq({t, name .. "You have done well."}, 1)
							player.quest["dailyq_1"] = 0
							fighter_daily.complete(player)
						else
							player:dialogSeq({t, name .. "Come back when you have the Jellyfish Tentacles."}, 1)
						end
					elseif player.quest["dailyq_2"] == 1 then
						if player:hasItem("minnow_scale", 25) == true then
							player:removeItem("minnow_scale", 25)
							player.quest["dailyq_2"] = 0
							fighter_daily.complete(player)
							player:dialogSeq({t, name .. "You have done well."}, 1)
						else
							player:dialogSeq({t, name .. "Come back when you have the Minnow Scales."}, 1)
						end
					elseif player.quest["dailyq_3"] == 1 then
						if player:hasItem("snail_shell_fragment", 1) == true then
							player:removeItem("snail_shell_fragment", 1)
							player.quest["dailyq_3"] = 0
							fighter_daily.complete(player)
							player:dialogSeq({t, name .. "You have done well."}, 1)
						else
							player:dialogSeq({t, name .. "Come back when you have the Snail Shell Fragment."}, 1)
						end
					elseif player.quest["dailyq_4"] == 1 then
						if player:hasItem("stolen_sword", 25) == true then
							player:removeItem("stolen_sword", 25)
							player.quest["dailyq_4"] = 0
							fighter_daily.complete(player)
							player:dialogSeq({t, name .. "You have done well."}, 1)
						else
							player:dialogSeq({t, name .. "Come back when you have the Stolen Swords."}, 1)
						end
					elseif player.quest["dailyq_5"] == 1 then
						if player:hasItem("lobster_claw", 25) == true then
							player:removeItem("lobster_claw", 25)
							player.quest["dailyq_5"] = 0
							fighter_daily.complete(player)
							player:dialogSeq({t, name .. "You have done well."}, 1)
						else
							player:dialogSeq({t, name .. "Come back when you have the Lobster Claws."}, 1)
						end
					elseif player.quest["dailyq_6"] == 1 then
						if player:hasItem("spider_silk", 25) == true then
							player:removeItem("spider_silk", 25)
							player.quest["dailyq_6"] = 0
							fighter_daily.complete(player)
							player:dialogSeq({t, name .. "You have done well."}, 1)
						else
							player:dialogSeq({t, name .. "Come back when you have the Spider Silk."}, 1)
						end
					elseif player.quest["dailyq_7"] == 1 then
						if player:hasItem("leech_ooze", 25) == true then
							player:removeItem("leech_ooze", 25)
							player.quest["dailyq_7"] = 0
							fighter_daily.complete(player)
							player:dialogSeq({t, name .. "You have done well."}, 1)
						else
							player:dialogSeq({t, name .. "Come back when you have the Leech Ooze."}, 1)
						end
					elseif player.quest["dailyq_8"] == 1 then
						if player:hasItem("queen_venom_sac", 1) == true then
							player:removeItem("queen_venom_sac", 1)
							player.quest["dailyq_8"] = 0
							fighter_daily.complete(player)
							player:dialogSeq({t, name .. "You have done well."}, 1)
						else
							player:dialogSeq({t, name .. "Come back when you have the Queen Venom Sacs."}, 1)
						end
					elseif player.quest["dailyq_9"] == 1 then
						if player:hasItem("stolen_blade", 1) == true then
							player:removeItem("stolen_blade", 1)
							player.quest["dailyq_9"] = 0
							fighter_daily.complete(player)
							player:dialogSeq({t, name .. "You have done well."}, 1)
						else
							player:dialogSeq({t, name .. "Come back when you have the Stolen Blades"}, 1)
						end
					end
				end
			end
		end
	),
	complete = function(player)
		player.quest["dailyq"] = 0
		player.quest["dailyq_1"] = 0
		player.quest["dailyq_2"] = 0
		player.quest["dailyq_3"] = 0
		player.quest["dailyq_4"] = 0
		player.quest["dailyq_5"] = 0
		player.quest["dailyq_6"] = 0
		player.quest["dailyq_7"] = 0
		player.quest["dailyq_8"] = 0
		player.quest["dailyq_9"] = 0

		player:leveledEXP("daily")
		player:addGold(5000)
		player:sendMinitext("You completed a quest and got 5000 coins!")
		player:status()
		player:sendStatus()
		player:msg(4, "[Daily Quest Complete]", player.ID)
		player.quest["dailyq"] = 0
		player.registry["daily_quest_timer"] = os.time() + 43200

		if player:hasLegend("dailyquest") then
			player:removeLegendbyName("dailyquest")
		end

		if player.registry["daily_quests_complete"] > 0 then
			player.registry["daily_quests_complete"] = player.registry["daily_quests_complete"] + 1
			player:addLegend(
				"Completed " .. player.registry["daily_quests_complete"] .. " guild missions",
				"dailyquest",
				122,
				16
			)
		else
			player.registry["daily_quests_complete"] = 1
			player:addLegend("Completed 1 guild mission", "dailyquest", 122, 16)
		end
		if player.registry["daily_quests_complete"] == 10 then
			broadcast(-1, "[TITLE]: " .. player.name .. " has just earned the title 'Quester'!")
		end
		if player.registry["daily_quests_complete"] == 100 then
			broadcast(-1, "[TITLE]: " .. player.name .. " has just earned the title 'Quest Master'!")
		end
	end
}
