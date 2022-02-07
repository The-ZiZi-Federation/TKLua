santas_sack = {
	use = function(player)
		player:freeAsync()
		player.lastClick = player.ID
		santas_sack.click(player)
	end,
	lookInside = function(player, npc)
	end,
	click = async(
		function(player, npc)
			local sack = {graphic = convertGraphic(1192, "monster"), color = 0}
			player.npcGraphic = sack.graphic
			player.npcColor = 0
			player.dialogType = 0

			local opts = {"Look inside", "Leave it alone"}
			local opts2 = {"Take it!", "Close the bag"}
			local opts3 = {"I'm sure! Take it!", "I'd better not"}

			menu = player:menuString("You are holding Santa's Magic Sack. What are you going to do?", opts)

			if menu == "Look inside" then
				choice =
					player:menuString(
					"It's mostly empty inside, despite the size. You notice there is one thing, at the bottom. It's beautiful, and seems to call to you. What do you do?",
					opts2
				)
				if choice == "Take it!" then
					confirm =
						player:menuString(
						"If you remove the last item, all the magic from Santa's Sack will be gone, and your quest will end here, with you a thief. Are you sure?",
						opts3
					)
					if confirm == "I'm sure! Take it!" then
						if player:hasItem("santas_sack", 1) == true then
							if player:removeItem("santas_sack", 1) == true then
								player:addItem("gold_necklace", 1) -- Level 75 Neutral Reward Christmas 2016
								player:msg(4, "You have received an item.", player.ID)
								karma.neutral(player)
								player:addLegend("Stole a Present from Santa's Magic Sack " .. curT(), "xmasneutral2016", 211, 9)
								player:msg(4, "You have received a new Legend Mark.", player.ID)
							else
							end
						else
						end
					else
					end
				else
				end
			else
			end
		end
	)
}
