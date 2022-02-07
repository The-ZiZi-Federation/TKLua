cathay_weaponsmith = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local buyitems = {203, 216, 223, 237, 263, 270, 284, 300, 322, 365, 301, 323, 366, 302, 324, 367}
			local sellitems = {203, 216, 223, 237, 263, 270, 284, 300, 322, 365, 301, 323, 366, 302, 324, 367}
			local options = {}
			table.insert(options, "Buy")
			table.insert(options, "Sell")
			table.insert(options, "Repair Item")
			table.insert(options, "Repair All")

			menu = player:menuString(name .. "I am a smith, I buy and sell weapons. I can also repair your equipment.", options)

			if menu == "Buy" then
				cathay_weapon_shop.buy(player)
			elseif menu == "Sell" then
				cathay_weapon_shop.sell(player)
			elseif menu == "Repair Item" then
				player:repairExtend()
			elseif menu == "Repair All" then
				player:repairAll(player, npc)
			end
		end
	),
	say = function(player, npc)
		local speech = string.lower(player.speech)
		local item
		local number

		if string.find(speech, "(.*)repair all(.*)") then
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}

			player.npcGraphic = t.graphic
			player.npcColor = t.color
			--player.dialogType = 0
			--player.lastClick = npc.ID
			player:repairAllNoConfirm(player, npc)
		end
	end
}
