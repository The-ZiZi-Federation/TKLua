wirt = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local buyitems = {990}
			local sellitems = {990}

			local options = {}
			--table.insert(options, "Buy")
			table.insert(options, "Sell")

			menu = player:menuString(name .. "What?", options)

			if menu == "Buy" then
				player:buyExtend(name .. "What would you like to buy?.", buyitems)
			elseif menu == "Sell" then
				player:sellExtend(name .. "What do you wish to sell?", sellitems)
			end
		end
	)
}
