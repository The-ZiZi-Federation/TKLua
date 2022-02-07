lortz_extortionist = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local opts = {}
			local opts2 = {"Yes", "No"}

			if player.quest["spec_extortion"] == 0 then
				table.insert(opts, "What's in Cathay?")
			end
			if player.quest["spec_extortion"] == 0 then
				table.insert(opts, "I want to go to Cathay")
			end
			if player.quest["spec_extortion"] == 1 then
				table.insert(opts, "Repeat that?")
			end

			menu = player:menuString(name .. "Psst.. Hey, you. You interested in going to Cathay?", opts)

			if menu == "What's in Cathay?" then
				player:dialogSeq(
					{
						t,
						name .. "What's in Cathay? Are you an idiot? Cathay is the greatest city in the world!",
						name .. "But I suppose only one thing matters to someone like you...",
						name .. "Cathay is the home of many skilled adventurers who teach their unique skills to new blood.",
						name .. "If you go there, you might be able to get one of them to teach you something cool."
					},
					1
				)
			elseif menu == "I want to go to Cathay" then
				player:dialogSeq(
					{
						t,
						name .. "You really want to go to Cathay? They don't really like visitors, so it can be tough to get in.",
						name ..
							"I have a good way in though. Guaranteed. You pay my fee and I will make absolutely sure that you get in to Cathay.",
						name .. "It's a bargain, really. Only 100,000 coins!"
					},
					1
				)
				choice = player:menuString(name .. "So, how about it? Are you going to Cathay?", opts2)
				if choice == "Yes" then
					if player:removeGold(100000) == true then
						player.quest["spec_extortion"] = 1
						player:msg(4, "[Quest Updated] Head to Cathay!", player.ID)
						player:dialogSeq(
							{
								t,
								name .. "Holy cow! You actually paid!",
								name .. "Er.. I mean.. You made the right choice! The only choice, really.",
								name .. "Getting to Cathay is easy, go back to Tonguspur, north of Hon by the Sea.",
								name .. "From there, keep heading north until you reach the Road to Cathay.",
								name .. "Most people would get stuck at the gates, but tell the guard I sent you and he'll let you in.",
								name .. "Easy peasy."
							},
							1
						)
					else
						player:dialogSeq({t, name .. "Come back when you have some money!"}, 1)
					end
				end
			elseif menu == "Repeat that?" then
				player:dialogSeq(
					{
						t,
						name .. "Getting to Cathay is easy, go back to Tonguspur, north of Hon by the Sea.",
						name .. "From there, keep heading north until you reach Cathay Road.",
						name .. "Most people would get stuck at the gates, but tell the guard I sent you and he'll let you in.",
						name .. "Easy peasy."
					},
					1
				)
			end
		end
	)
}
