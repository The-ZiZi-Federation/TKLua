cathay_butcher = {
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
			local buyitems = {206, 212, 213, 246, 247, 248, 249, 250} --
			local sellitems = {206, 212, 213, 246, 247, 248, 249, 250, 53} --

			local options = {}
			table.insert(options, "Buy")
			table.insert(options, "Sell")

			menu = player:menuString(name .. "I am the butcher. I sell meat.", options)

			if menu == "Buy" then
				player:buyExtend("What would you like to buy?", buyitems)
			elseif menu == "Sell" then
				player:sellExtend("What do you wish to sell?", sellitems)
			end
		end
	)
}
