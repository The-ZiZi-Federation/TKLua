--dis 939 color 9 // 3068, 2, 3
lortz_lapis_nagger = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local buyitems = {774, 775, 776}
			local sellitems = {774, 775, 776}

			local options = {}
			table.insert(options, "Buy")
			table.insert(options, "Sell")

			menu = player:menuString(name .. "Would you like to buy a horse?", options)

			if menu == "Buy" then
				player:buyExtend(name .. "Which do you want?", buyitems)
			elseif menu == "Sell" then
				player:sellExtend(name .. "What do you wish to sell?", sellitems)
			--	elseif menu == "" then
			--		player:dialogSeq({t, name.."."}, 1)
			end
		end
	)
}
