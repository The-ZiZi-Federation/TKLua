gerard = {
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
					name .. "Who are you?",
					name .. "If you're working for my brother, get out now."
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
				if player.quest["gerards_quest"] < 2 then
					player:dialogSeq(
						{
							t,
							name .. "You say you aren't working for him?",
							name .. "Careful that you never make his acquaintance.",
							name .. "He is a snake and a backstabber, and cares nothing for the bonds of family and honor."
						},
						1
					)
					player.quest["gerards_quest"] = 1
				end
			elseif string.find(s, "(.*)random(.*)") then
				if player.quest["gerards_quest"] < 3 then
					player:dialogSeq(
						{
							t,
							name .. "That snake Random hired some thugs to strong-arm me out of my own warehouse.",
							name .. "It was all I had to my name and now my livelihood is ruined!",
							name .. "Negotiations were completely impossible, but I have a plan to take it back.",
							name .. "All I need is more men.",
							name ..
								"I can't take my eyes off of the situation here, so I've had trouble finding foreign mercenaries to hire.",
							name .. "If you could find me a decent company to hire from Lortz or Hon, I would be forever grateful to you."
						},
						1
					)
					player.quest["gerards_quest"] = 2
				end
			elseif string.find(s, "(.*)compromise(.*)") then
				if player.quest["gerards_quest"] < 3 then
					player:dialogSeq(
						{
							t,
							name .. "HA! Unfortunately compromise was never the boy's strong suit.",
							name ..
								"I tried until the end of my patience, but only our mother could never talk any sense into the selfish fool.",
							name ..
								"Frankly I am glad she is not in Cathay to witness this disgrace, she has her own business to worry about."
						},
						1
					)
					player.quest["brothers_peace"] = 1
				end
			elseif string.find(s, "(.*)mercenaries(.*)") then
				if player.quest["gerards_quest"] == 3 then
					player:dialogSeq(
						{
							t,
							name .. "Excellent!",
							name .. "Once the soldiers arrive, I'll be able to take back my warehouse and make my brother pay!"
						},
						1
					)
					finishedQuest(player)
					player:addLegend("Found Soldiers to Support Gerard", "gerards_quest", 7, 4)
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
