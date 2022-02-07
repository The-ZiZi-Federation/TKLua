lortz_resident = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local opts = {}

			table.insert(opts, "Who are you?")
			if player.quest["lortz_letter"] == 1 then
				table.insert(opts, "I have a letter for you")
			end
			--if player.quest["lortz_letter"] == 3 then table.insert(opts, "") end

			menu = player:menuString(name .. "You look like a poor. Is this a robbery?", opts)

			if menu == "Who are you?" then
				player:dialogSeq(
					{
						t,
						name .. "Someone who made a terrible mistake.",
						name .. "I chose to marry for love instead of money.",
						name .. "I thought I would be happier without my family's manor and our servants, but now look at me.",
						name .. "My husband works as a laborer all day long, and what do I do?",
						name ..
							"I sit in here, and I wonder where my life went wrong, and I have to talk to every dirty barbarian who mistakes this tiny little house for the local brothel and wanders inside.",
						name .. "So will you leave now?"
					},
					1
				)
			elseif menu == "I have a letter for you" then
				if player:hasItem("lortz_letter", 1) == true then
					if player:removeItem("lortz_letter", 1) == true then
						player:msg(4, "[Quest Complete] Delivered the letter to Carmen!", player.ID)
						giveXP(player, 10000000)
						player:addGold(50000)
						player:sendStatus()
						finishedQuest(player)
						player.quest["lortz_letter"] = 2
						player:dialogSeq(
							{
								t,
								name .. "A letter for me? From Hon? It must be my family, wanting me to return.",
								name .. "Maybe I'll take them up on the offer this time.",
								name ..
									"Thank you for the delivery. Here's something for your trouble, maybe you could use it to buy some soap."
							},
							1
						)
					else
						player:dialogSeq({t, name .. "Where is the letter?"}, 1)
					end
				else
					player:dialogSeq({t, name .. "Where is the letter?"}, 1)
				end
			end
		end
	)
}
