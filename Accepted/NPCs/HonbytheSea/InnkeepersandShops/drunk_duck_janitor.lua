drunk_duck_janitor = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local opts = {}
			local sellitems = {3011, 3012, 3013, 3014}
			local buyitems = {3011, 3012, 3013, 3014}

			table.insert(opts, "Buy")
			table.insert(opts, "Sell")

			menu = player:menuString(name .. "What do you want?", opts)

			if menu == "Buy" then
				player:buyExtend(name .. "What can I sell you today?", buyitems)
			elseif menu == "Sell" then
				player:sellExtend(name .. "What do you wish to sell?", sellitems)
			end
		end
	)
}
