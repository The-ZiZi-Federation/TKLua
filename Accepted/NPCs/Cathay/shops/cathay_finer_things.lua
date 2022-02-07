cathay_clothes = {
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
			local buyitems = {
				230,
				231,
				232,
				233,
				234,
				235,
				236,
				224,
				225,
				226,
				227,
				228,
				229,
				277,
				278,
				279,
				280,
				281,
				282,
				283,
				271,
				272,
				273,
				274,
				275,
				276,
				343,
				346,
				349,
				352,
				355,
				359,
				362,
				325,
				328,
				331,
				334,
				337,
				340,
				344,
				347,
				350,
				353,
				356,
				360,
				363,
				326,
				329,
				332,
				335,
				338,
				341,
				345,
				348,
				351,
				354,
				357,
				361,
				364,
				327,
				330,
				333,
				336,
				339,
				342
			}
			local sellitems = {
				230,
				231,
				232,
				233,
				234,
				235,
				236,
				277,
				278,
				279,
				280,
				281,
				282,
				283,
				297,
				271,
				272,
				273,
				274,
				275,
				276,
				343,
				346,
				349,
				352,
				355,
				359,
				362,
				325,
				328,
				331,
				334,
				337,
				340,
				344,
				347,
				350,
				353,
				356,
				360,
				363,
				326,
				329,
				332,
				335,
				338,
				341,
				345,
				348,
				351,
				354,
				357,
				361,
				364,
				327,
				330,
				333,
				336,
				339,
				342
			}

			local options = {}
			table.insert(options, "Buy")
			table.insert(options, "Sell")
			table.insert(options, "Repair Item")
			table.insert(options, "Repair All")

			menu = player:menuString(name .. "Hi! I buy and sell finery.", options)

			if menu == "Buy" then
				cathay_finery_shop.buy(player)
			elseif menu == "Sell" then
				cathay_finery_shop.sell(player)
			elseif menu == "Repair Item" then
				player:repairExtend()
			elseif menu == "Repair All" then
				player:repairAll(player, npc)
			end
		end
	)
}
