--Hon Harbor Storage Master (Martin)
hon_storage_master = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID
			local opts = {}

			local killcount1041 = player:killCount(1041)
			local killcount1042 = player:killCount(1042)
			local killcount1043 = player:killCount(1043)

			local killcount1101 = player:killCount(1101)
			local killcount1102 = player:killCount(1102)
			local killcount1103 = player:killCount(1103)

			local killcount1141 = player:killCount(1141)
			local killcount1142 = player:killCount(1142)
			local killcount1143 = player:killCount(1143)

			if player:hasLegend("mentok") and player.quest["martin"] < 2 then
				table.insert(opts, "Harvey says you need help")
			end
			if player:hasLegend("martin") and player.quest["martin"] < 3 then
				table.insert(opts, "What is the other job?")
			end
			if player.quest["martin"] < 4 then
				table.insert(opts, "What's your story?")
			end
			if player.quest["martin"] == 3 then
				table.insert(opts, "About those scales...")
			end
			if player.quest["martin"] == 4 then
				table.insert(opts, "How are you, Martin?")
			end

			menu = player:menuString(name .. "No, No, No, where has it gone?", opts)

			if menu == "What's your story?" then
				player:dialogSeq(
					{t, name .. "My story? I have no time right now. Please, just leave, I have to start counting all over again now."},
					1
				)
			elseif menu == "Harvey says you need help" and player.quest["martin"] == 0 then
				player:dialogSeq(
					{
						t,
						name .. "Yes, I could use all the help I can get.",
						name .. "Lately there have been bats flying around at night.",
						name .. "At first, I thought it was cool. But now, I do not.",
						name .. "They have been landing on my crates, and pulling from them then flying away.",
						name .. "If someone does not clear out some of those bats, they might get me fired.",
						name .. "I saw some of them flying into a cave just off the shore X:20 Y:59 ",
						name .. "Kill 50 of each bat you find and 1 of the largest bats!"
					},
					1
				)
				player:msg(4, "[Quest Started] Kill 50 of each bat you find and 1 of the largest bats.", player.ID)
				player.quest["martin"] = 1
				if player.level <= 74 then
					player:flushKills(1041)
					player:flushKills(1042)
					player:flushKills(1043)
				elseif player.level >= 75 and player.level <= 99 and (player.baseHealth <= 29999 and player.baseMagic <= 29999) then
					player:flushKills(1101)
					player:flushKills(1102)
					player:flushKills(1103)
				elseif player.level >= 99 and (player.baseHealth >= 30000 or player.baseMagic >= 30000) then
					player:flushKills(1141)
					player:flushKills(1142)
					player:flushKills(1143)
				end
			elseif menu == "Harvey says you need help" and player.quest["martin"] == 1 then
				if player.level <= 74 then
					if killcount1041 >= 50 and killcount1042 >= 50 and killcount1043 >= 1 then
					end
				elseif player.level >= 75 and player.level <= 99 and (player.baseHealth <= 29999 and player.baseMagic <= 29999) then
					if killcount1101 >= 50 and killcount1102 >= 50 and killcount1103 >= 1 then
					end
				elseif player.level >= 99 and (player.baseHealth >= 30000 or player.baseMagic >= 30000) then
					if killcount1141 >= 50 and killcount1142 >= 50 and killcount1143 >= 1 then
					end
				else
					player:dialogSeq({t, name .. "What are you waiting for? Go kill some bats for me."}, 1)
					return
				end

				player:dialogSeq(
					{
						t,
						name .. "Well hot damn. You did it. That should teach those damn bats.",
						name .. "Now that was fast, well here's your reward.",
						name .. "I got another problem if you got some time."
					},
					1
				)
				giveXP(player, 20000)
				player:addGold(7500)
				finishedQuest(player)
				player:calcStat()
				player:sendStatus()
				player:addLegend("Bat Slayer " .. curT(), "martin", 1, 16)
				player:msg(4, "[Quest Completed] A Legend Mark is obtained. Keep it up!", player.ID)
				player:sendMinitext("You are breaking the game you are so good.")
				player.quest["martin"] = 2
				player.quest["haunted_house"] = 4 --just need to change harvey's last dialog to trigger if player.quest["haunted_house"] >=3 instead of == 3
			elseif menu == "Harvey says you need help" and player.quest["martin"] == 2 then
				player:dialogSeq({t, name .. "Thanks for helping me with my bat problem. check back for more work."}, 1)
			elseif menu == "What is the other job?" and player.quest["martin"] == 2 then
				if player.level >= 30 then
					player:dialogSeq(
						{
							t,
							name .. "Have you seen the mutated fish? They're terrifying.",
							name .. "No one knows the cause, either.",
							name .. "Some people call it a bad omen, or a curse from the gods.",
							name .. "Me, I think it's black magic, those damn sorcerers, you know?",
							name .. "But seeing all those beasts, armored like tanks, gave me an idea.",
							name .. "I almost have enough scales to finish making it, but I'm getting worn out.",
							name .. "I only need a few more scales. If you bring them to me, I'll give you a nice reward.",
							name .. "Collect 50 Minnow Scales, 50 Bass Scales, and 1 Goldfish Scale!"
						},
						1
					)
					player:msg(4, "[Quest Update] Collect 50 Minnow Scales, 50 Bass Scales, and 1 Goldfish Scale", player.ID)
					player.quest["martin"] = 3
				else
					player:dialogSeq({t, name .. "Come back when you're a little stronger and we'll talk."}, 1)
				end
			elseif menu == "About those scales..." then
				if player:hasItem(291, 50) == true and player:hasItem(292, 50) == true and player:hasItem(293, 1) == true then
					if player:removeItem(291, 50) == true and player:removeItem(292, 50) == true and player:removeItem(293, 1) == true then
						giveXP(player, 100000)
						player:addGold(10000)
						finishedQuest(player)
						player:dialogSeq({t, name .. "Just what I was looking for! Now I can finish my project..."}, 1)
						player:sendStatus()
						player:addLegend("Brought Martin some fishy scales " .. curT(), "scales", 31, 16)
						player:msg(4, "[Quest Completed] A Legend Mark is obtained. Keep it up!", player.ID)
						player:sendMinitext("You are just an incredible person all around.")
						player.quest["martin"] = 4
					else
						player:dialogSeq({t, name .. "What are you waiting for? Go kill some mutants for me."}, 1)
					end
				else
					player:dialogSeq({t, name .. "What are you waiting for? Go kill some mutants for me."}, 1)
				end
			elseif menu == "How are you, Martin?" then
				if player.quest["leech"] < 3 then
					player:dialogSeq(
						{
							t,
							name .. "I'm doing alright, myself.",
							name .. "But if you want to do me a favor, go visit my friend the hermit.",
							name .. "He lives all alone on that little island in the northeast area of Hon",
							name .. "You'll need to go through the Hon Underground to get there.",
							name .. "He's a good guy but I hear he's having some real trouble these days."
						},
						1
					)
				else
					player:dialogSeq({t, name .. "Keeping busy with my work, like everyone else."}, 1)
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
					(pc[i]:hasLegend("mentok") and (pc[i].quest["martin"] == 0) or (pc[i].quest["martin"] == 2) and pc[i].level >= 30)
				 then
					pc[i]:selfAnimationXY(pc[i].ID, 248, x, y)
				end
			end
		end
	end
}
