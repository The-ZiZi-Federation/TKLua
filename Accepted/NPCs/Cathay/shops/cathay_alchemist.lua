cathay_alchemist = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local serum = {graphic = convertGraphic(1303, "item"), color = 0}

			local opts = {}
			local opts2 = {}
			local sellitems = {388, 389, 390, 396, 397, 400, 401, 3300, 3301, 3302, 3303}

			table.insert(opts, "Buy")
			table.insert(opts, "Sell")

			menu = player:menuString(name .. "Can I help you?", opts)

			if menu == "Buy" then
				player:buyExtend(name .. "What can I sell you today?", {3300, 3301, 3302, 3303, 3310, 3311})
			elseif menu == "Sell" then
				player:sellExtend(name .. "What do you wish to sell?", sellitems)
			end
		end
	),
	say = function(player, npc)
		local speech = string.lower(player.speech)
		local item
		local number

		if
			string.sub(speech, 1, 6) == "i buy " and string.sub(speech, 7, 24) == "minor vita potion" or
				string.sub(speech, 7, 25) == "minor vita potion" or
				string.sub(speech, 7, 22) == "small mana potion" or
				string.sub(speech, 7, 23) == "small mana potion"
		 then
			item = Item(string.sub(speech, 7, 24))

			if (item == nil) then
				item = Item(string.sub(speech, 7, 25))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 22))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 23))
			end

			if (item ~= nil) then
				number = tonumber(string.match(speech, "i buy " .. string.lower(item.name) .. " number (%d+)"))

				if (number == nil) then
					number = 1
				end

				if (player:removeGold(item.price * number) == true) then
					player:addItem(item.yname, number)
					npc:talk(
						0,
						"" .. npc.name .. ": I sold you " .. number .. " " .. item.name .. " for " .. (item.price * number) .. " coins."
					)
				end
			end
		elseif
			string.sub(speech, 1, 7) == "buy my " and string.sub(speech, 8, 16) == "ectoplasm" or
				string.sub(speech, 8, 16) == "bat guano" or
				string.sub(speech, 8, 17) == "leech ooze"
		 then
			item = Item(string.sub(speech, 8, 16))

			if (item == nil) then
				item = Item(string.sub(speech, 8, 16))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 17))
			end

			if (item ~= nil) then
				number = tonumber(string.match(speech, "buy my " .. string.lower(item.name) .. " number (%d+)"))

				if (number == nil) then
					number = 1
				end

				if (player:removeItem(item.yname, number) == true) then
					player:addGold(item.sell * number)
					npc:talk(
						0,
						"" .. npc.name .. ": I bought your " .. number .. " " .. item.name .. " for " .. (item.sell * number) .. " coins."
					)
				end
			end
		end
	end
}
