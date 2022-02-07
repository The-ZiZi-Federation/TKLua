-- Dre loc east cathay
observatory_betty = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local opts = {}

			table.insert(opts, "Yes!")
			table.insert(opts, "Not now!")

			menu = player:menuString(name .. "Welcome to the observatory. Here to hear a story?", opts)
			if (menu == "Yes!") then
				player:dialogSeq({t, name .. "Head on up to the top of the Tower"}, 1)
			elseif (menu == "Not now!") then
				player:dialogSeq({t, name .. "Maybe later sweetie. Thanks for coming!"}, 1)
			end
		end
	)
}
