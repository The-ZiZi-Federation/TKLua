--dis 939 color 9 // 3068, 2, 3

game_master = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local menuOption
			local menuOptionBuy
			local buyitems = {710, 711, 712, 713, 700, 701, 702, 703, 704, 705, 706, 708, 778}
			local sellitems = {710, 711, 712, 713, 700, 701, 702, 703, 704, 705, 706, 708, 778}

			local options = {}
			table.insert(options, "Buy")
			table.insert(options, "Sell")

			menu = player:menuString(name .. "I am the Game Master. I have everything you need to play some games.", options)

			if menu == "Buy" then
				player:buyExtend(name .. "What would you like to buy?.", buyitems)
			elseif menu == "Sell" then
				player:sellExtend(name .. "What do you wish to sell?", sellitems)
			--	elseif menu == "" then
			--		player:dialogSeq({t, name.."."}, 1)
			end
		end
	)
}
