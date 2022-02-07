clayven_jr = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local opts = {"Who are you?", "Horses", "Exit"}
			local cost = 5000

			menu = player:menuString("What do you want?", opts)

			if menu == "Who are you?" then
				player:dialogSeq(
					{
						t,
						name .. "I'm Clayven Jr, stupid.",
						name .. "My family owns this place. We make money sending messages and goods all over the place.",
						name .. "We do pretty well, but they still just make me clean the stable.",
						name .. "Sometimes I make extra coins by letting people borrow the horses for long journeys.",
						name .. "Or, you know, whatever you're into."
					},
					1
				)
			elseif menu == "Horses" then
				player:dialogSeq(
					{
						t,
						name .. "Are you going on a journey?",
						name .. "You can use one of our horses for only " .. cost .. " coins."
					},
					1
				)
				confirm = player:menuString("Do you want to spend " .. cost .. " coins to borrow a horse?", {"Yes", "No"})
				if confirm == "Yes" then
					if player:removeGold(cost) == true then
						player:warp(1040, 12, 6)
					else
						player:dialogSeq({t, name .. "Show me the coins, deadbeat."}, 1)
					end
				end
			end
		end
	),
	stableWarp = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local m, x, y = player.m, player.x, player.y
			local confirm

			if x >= 7 and x <= 18 then
				if y == 9 then
					if player.state == 3 then
						player:warp(1040, x, y + 3)
					else
						confirm =
							player:menuString(
							"You didn't get on a horse! Are you sure you want to exit? You won't get your coins back.",
							{"Leave", "Stay"}
						)
						if confirm == "Leave" then
							player:warp(1040, x, y + 3)
						else
							player:warp(1040, x, y - 1)
						end
					end
				end
			end
		end
	)
}
