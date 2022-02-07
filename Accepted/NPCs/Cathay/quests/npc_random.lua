npc_random = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local opts = {}

			player:dialogSeq(
				{
					t,
					name .. "An unfamiliar face.",
					name .. "Did my brother send you? Tell him I won't be intimidated."
				},
				1
			)
		end
	),
	say = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local s = string.lower(player.speech)

			if string.find(s, "(.*)brother(.*)") then
				if player.quest["randoms_quest"] < 2 then
					player:dialogSeq(
						{
							t,
							name .. "So you don't actually know him?",
							name .. "Good, keep it that way.",
							name .. "He's a bastard and a thief, and is trying to take what's mine."
						},
						1
					)
					player.quest["randoms_quest"] = 1
				end
			elseif string.find(s, "(.*)gerard(.*)") then
				if player.quest["randoms_quest"] < 3 then
					player:dialogSeq(
						{
							t,
							name .. "Gerard! Just hearing that bastard's name infuriates me!",
							name .. "He actually sent his men to take over my office, can you believe that?",
							name .. "I have a way to get back at him though.",
							name ..
								"We could never come to an agreement, but now my own men are all ready to charge in and take back what is mine.",
							name .. "I just need to procure some explosives for us to create a side entrance.",
							name .. "They'll never see it coming!",
							name .. "If you can find me an Explosive Charge, I would be in your debt."
						},
						1
					)
					player.quest["randoms_quest"] = 2
				end
			elseif string.find(s, "(.*)agreement(.*)") then
				if player.quest["randoms_quest"] < 3 then
					player:dialogSeq(
						{
							t,
							name ..
								"We tried to talk out our differences, for the sake of our poor mother, but the brute just can't listen to reason!",
							name .. "If only mother still lived in Cathay, she would make him understand."
						},
						1
					)
					player.quest["brothers_peace"] = 1
				end
			elseif string.find(s, "(.*)explosive(.*)") or string.find(s, "(.*)charge(.*)") then
				if player.quest["randoms_quest"] == 3 then
					player:dialogSeq(
						{
							t,
							name .. "You brought the charges! Perfect!",
							name .. "We'll blow a hole through the wall and assault the office on two fronts.",
							name .. "You've been a big help!"
						},
						1
					)
					finishedQuest(player)
					player:addLegend("Secured Explosives to Support Random", "randoms_quest", 7, 4)
					player.quest["randoms_quest"] = 4
					player.quest["gerards_quest"] = 4
					player.quest["brothers_peace"] = 3
				end
			elseif string.find(s, "(.*)letter(.*)") or string.find(s, "(.*)mother(.*)") then
				if player.quest["brothers_peace"] == 2 then
					player:dialogSeq(
						{
							t,
							name .. "A.. a letter?",
							name .. "From mother?",
							name .. "You told her about what's been going on, didn't you?",
							name .. "This is horrible!",
							name .. "What if she actually shows up here?",
							name .. "What are we going to do?",
							name .. "We'll need to make a peace right away!"
						},
						1
					)
					finishedQuest(player)
					player:addLegend("Forged Peace Between Brothers", "brothers_peace", 145, 15)
					player.quest["brothers_peace"] = 3
					player.quest["randoms_quest"] = 4
					player.quest["gerards_quest"] = 4
				end
			end
		end
	)
}
