mysterious_table = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			local m = player.m
			local map = 1038
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local options = {}

			if player.level >= 50 and player.registry["drank_cryptivarium"] == 1 then
				table.insert(options, "Return to the Cryptivarium")
			end
			if player.level >= 99 and player.registry["drank_mystic_cryptivarium"] == 1 then
				table.insert(options, "Return to the Heart of the Crypt")
			end
			table.insert(options, "Leave it alone.")

			menu = player:menuString(name .. "What would you like to do with the " .. npc.name .. "?", options)

			if menu == "Return to the Cryptivarium" then
				player:warp(1411, 11, 10)
			elseif menu == "Return to the Heart of the Crypt" then
				player:warp(1423, 9, 4)
			end
		end
	)
}

cryptivarium = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			local m = player.m
			local map = 1038
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local options = {}

			if player.registry["drank_mystic_cryptivarium"] == 1 then
				table.insert(options, "Return to the Heart of the Crypt")
			end
			if player.registry["drank_cryptivarium"] == 1 then
				table.insert(options, "Return to the surface.")
			else
				table.insert(options, "Drink from the " .. npc.name)
			end
			table.insert(options, "Leave it alone.")

			menu = player:menuString(name .. "What would you like to do with the " .. npc.name .. "?", options)

			if menu == "Return to the Heart of the Crypt" then
				player:warp(1423, 9, 4)
			elseif menu == "Return to the surface." then
				player:warp(1401, 10, 9)
			elseif menu == "Drink from the " .. npc.name .. "" then
				player:dialogSeq(
					{
						t,
						name .. "You raise the bowl to your lips and sip the strange liquid within.",
						name .. "It tastes of death, decay, and foulness.",
						name .. "You feel your soul attune to this dark place."
					},
					1
				)
				finishedQuest(player)
				player.registry["drank_cryptivarium"] = 1
			end
		end
	)
}

mystic_cryptivarium = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			local m = player.m
			local map = 1038
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local options = {}
			if player.registry["drank_cryptivarium"] == 1 then
				table.insert(options, "Return to the Cryptivarium")
			end
			if player.registry["drank_mystic_cryptivarium"] == 1 then
				table.insert(options, "Return to the surface.")
			else
				table.insert(options, "Drink from the " .. npc.name)
			end
			table.insert(options, "Leave it alone.")

			menu = player:menuString(name .. "What would you like to do with the " .. npc.name .. "?", options)

			if menu == "Return to the Cryptivarium" then
				player:warp(1411, 11, 10)
			elseif menu == "Return to the surface." then
				player:warp(1401, 10, 9)
			elseif menu == "Drink from the " .. npc.name .. "" then
				player:dialogSeq(
					{
						t,
						name .. "You raise the bowl to your lips and sip the strange liquid within.",
						name .. "It tastes of charred grass and the final breaths of scared children.",
						name .. "This place is changing you."
					},
					1
				)
				finishedQuest(player)
				player.registry["drank_mystic_cryptivarium"] = 1
			end
		end
	)
}
