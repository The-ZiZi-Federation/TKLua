cathay_armorsmith = {
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
				202,
				207,
				217,
				218,
				219,
				220,
				221,
				222,
				238,
				239,
				240,
				241,
				242,
				243,
				264,
				265,
				266,
				267,
				268,
				269,
				285,
				286,
				287,
				288,
				289,
				290,
				303,
				306,
				309,
				312,
				315,
				319,
				368,
				371,
				374,
				377,
				380,
				383,
				304,
				307,
				310,
				313,
				316,
				320,
				369,
				372,
				375,
				378,
				381,
				384,
				305,
				308,
				311,
				314,
				317,
				321,
				370,
				373,
				376,
				379,
				382,
				385
			} --
			local sellitems = {
				202,
				207,
				217,
				218,
				219,
				220,
				221,
				222,
				238,
				239,
				240,
				241,
				242,
				243,
				264,
				265,
				266,
				267,
				268,
				269,
				285,
				286,
				287,
				288,
				289,
				290,
				291,
				292,
				293,
				394,
				303,
				306,
				309,
				312,
				315,
				319,
				368,
				371,
				374,
				377,
				380,
				383,
				304,
				307,
				310,
				313,
				316,
				320,
				369,
				372,
				375,
				378,
				381,
				384,
				305,
				308,
				311,
				314,
				317,
				321,
				370,
				373,
				376,
				379,
				382,
				385
			}

			local options = {}
			table.insert(options, "Buy")
			table.insert(options, "Sell")
			table.insert(options, "Repair Item")
			table.insert(options, "Repair All")

			menu =
				player:menuString(
				name .. "I am smith, I buy and sell armor. I can also repair your equipment if it is not FUBAR.",
				options
			)

			if menu == "Buy" then
				cathay_armor_shop.buy(player)
			elseif menu == "Sell" then
				cathay_armor_shop.sell(player)
			elseif menu == "Repair Item" then
				player:repairExtend()
			elseif menu == "Repair All" then
				player:repairAll(player, npc)
			end
		end
	)
}
