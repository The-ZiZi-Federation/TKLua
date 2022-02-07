ogre_hunter = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local killcount3001 = player:killCount(3001)
			local killcount3002 = player:killCount(3002)
			local totalkills = killcount3001 + killcount3002
			local opts = {}
			--local timer = player.registry["daily_ogre_hunt_timer"]

			if (player.baseHealth <= 14999 and player.baseMagic <= 14999) and player.quest["ogre_hunt"] == 0 then
				table.insert(opts, "What kind of help?")
			end
			if (player.baseHealth >= 15000 or player.baseMagic >= 15000) and player.quest["ogre_hunt"] == 0 then
				table.insert(opts, "Sure I'll help!")
			end
			if player.quest["ogre_hunt"] == 1 then
				table.insert(opts, "About that bounty...")
			end
			if player.quest["ogre_hunt"] == 2 then
				table.insert(opts, "Today's bounty")
			end

			menu = player:menuString(name .. "Hey! You, down there! Can you help me?", opts)

			if menu == "What kind of help?" then
				player:dialogSeq(
					{
						t,
						name ..
							"I'm a bounty hunter, but...\n\nWell, don't take offense, but I don't think you'd be any match for my prey.",
						name .. "I'm always hunting in these parts, so come back if you live long enough to get a little stronger."
					},
					1
				)
			elseif menu == "Sure I'll help!" then
				player:dialogSeq(
					{
						t,
						name .. "Yeah, you look tough enough. I'll tell you the deal.",
						name .. "Trade between Hon by the Sea and Lortz has been disrupted by the ogres in Lortz Pass for years now.",
						name .. "They trash our caravans and kill our merchants. It's a real problem.",
						name ..
							"So the city of Hon has a standing bounty on ogres for a long while now, and it's my job to recruit more hunters.",
						name .. "If you slay 150 ogres and bring me their ears, I'll pay you a nice bounty.",
						name ..
							"If you do well, you can come back every day. There's plenty of work available, these ogres breed like damn rabbits."
					},
					1
				)
				player.quest["ogre_hunt"] = 1
				player:flushKills(3001, 3002)
				player:msg(4, "[Quest Updated] Bring 150 Ogre Ears to Bob!", player.ID)
			elseif menu == "About that bounty..." then
				if totalkills >= 150 then
					if player:hasItem("ogre_ear", 150) == true then
						if player:removeItem("ogre_ear", 150) == true then
							player:flushKills(3001, 3002)
							player.quest["ogre_hunt"] = 2
							giveXP(player, 25000000)
							player:addGold(75000)
							finishedQuest(player)
							player.registry["daily_ogre_hunt_timer"] = os.time() + 43200
							player:calcStat()
							player:sendStatus()
							ogre_hunter.legend(player)
							player:msg(4, "[Quest Complete] You got a reward!", player.ID)
							player:dialogSeq(
								{t, name .. "Great work! That meets my quota for today, but if you come back tomorrow you can collect again."},
								1
							)
						else
							player:dialogSeq({t, name .. "If you killed the ogres, then where are their ears?"}, 1)
						end
					else
						player:dialogSeq({t, name .. "If you killed the ogres, then where are their ears?"}, 1)
					end
				else
					player:dialogSeq({t, name .. "Go to Lortz Pass and kill some ogres!"}, 1)
				end
			elseif menu == "Today's bounty" then
				if player.registry["daily_ogre_hunt_timer"] >= os.time() then
					player:dialogSeq(
						{
							t,
							name ..
								"That meets my quota for today, but if you come back tomorrow you can collect again.\n\n(Available again in: " ..
									math.ceil(((player.registry["daily_ogre_hunt_timer"] - os.time()) / 3600)) .. " hours)"
						},
						1
					)
				else
					if player.quest["daily_ogre_hunt"] == 0 then
						menu = player:menuString(name .. "So you're here to collect the daily bounty on ogres?", {"Yes", "No"})

						if menu == "Yes" then
							player:flushKills(3001)
							player:flushKills(3002)
							player.quest["daily_ogre_hunt"] = 1
							player:dialogSeq({t, name .. "Go kill 150 ogres and come back when you have their ears."}, 1)
							player:msg(4, "[Daily Bounty]: Slay 150 ogres and collect their ears!", player.ID)
						end
					elseif player.quest["daily_ogre_hunt"] == 1 then
						if totalkills >= 150 then
							if player:hasItem("ogre_ear", 150) == true then
								if player:removeItem("ogre_ear", 150) == true then
									player:flushKills(3001)
									player:flushKills(3002)
									player.registry["daily_ogre_hunt_timer"] = os.time() + 43200
									player.quest["daily_ogre_hunt"] = 0
									giveXP(player, 20000000)
									player:addGold(75000)
									player:calcStat()
									player:sendStatus()
									ogre_hunter.legend(player)
									player:dialogSeq({t, name .. "Great work! Come back tomorrow if you want to hunt some more."}, 1)
									player:msg(4, "[Daily Bounty] You hunted ogres and got a reward!", player.ID)
								else
									player:dialogSeq({t, name .. "If you killed the ogres, then where are their ears?"}, 1)
								end
							else
								player:dialogSeq({t, name .. "If you killed the ogres, then where are their ears?"}, 1)
							end
						else
							player:dialogSeq({t, name .. "Go to Lortz Pass and kill some ogres!"}, 1)
						end
					end
				end
			end
		end
	),
	legend = function(player)
		if player:hasLegend("ogre_hunt") then
			player:removeLegendbyName("ogre_hunt")
		end

		if player.registry["daily_ogre_hunts_complete"] > 0 then
			player.registry["daily_ogre_hunts_complete"] = player.registry["daily_ogre_hunts_complete"] + 1
			player:addLegend(
				"Collected " .. player.registry["daily_ogre_hunts_complete"] .. " ogre bounties",
				"ogre_hunt",
				20,
				16
			)
		else
			player.registry["daily_ogre_hunts_complete"] = 1
			player:addLegend("Collected 1 ogre bounty", "ogre_hunt", 20, 16)
		end
		if player.registry["daily_ogre_hunts_complete"] == 10 then
			broadcast(-1, "[TITLE]: " .. player.name .. " has just earned the title 'Ogre Hunter'!")
		end
		if player.registry["daily_ogre_hunts_complete"] == 100 then
			broadcast(-1, "[TITLE]: " .. player.name .. " has just earned the title 'Ogre Slayer'!")
		end
	end
}
