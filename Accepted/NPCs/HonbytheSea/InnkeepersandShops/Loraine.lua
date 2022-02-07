-- Hon Butcher (Loraine)
hon_butcher = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local buyitems = {212, 213, 246, 247, 248, 249, 250}
			local sellitems = {212, 213, 246, 247, 248, 249, 250, 50, 51, 52, 53}

			local options = {}
			table.insert(options, "Buy")
			table.insert(options, "Sell")
			if player.quest["help_joe"] == 1 and player.quest["joes_food"] == 0 then
				table.insert(options, "I'm here for Joe's food")
			end

			menu =
				player:menuString(
				name .. "I am Loraine, the heartless butcher. I slaughter cute little animals and I buy and sell food.",
				options
			)

			if menu == "Buy" then
				player:buyExtend(name .. "What would you like to buy?.", buyitems)
			elseif menu == "Sell" then
				player:sellExtend(name .. "What do you wish to sell?", sellitems)
			elseif menu == "I'm here for Joe's food" then
				player:dialogSeq({t, name .. "You might want to get this to him quickly, I have had it out too long."}, 1)
				player.quest["joes_food"] = 1
				player:msg(4, "[Quest Updated] Obtained Joe's Food!", player.ID)
			end
		end
	),
	say = function(player, npc)
		local speech = string.lower(player.speech)
		local item
		local number

		if
			string.sub(speech, 1, 6) == "i buy " and string.sub(speech, 7, 21) == "tropical banana" or
				string.sub(speech, 7, 22) == "little blue fish" or
				string.sub(speech, 7, 24) == "little orange fish" or
				string.sub(speech, 7, 14) == "dead rat" or
				string.sub(speech, 7, 19) == "dead squirrel" or
				string.sub(speech, 7, 17) == "dead rabbit" or
				string.sub(speech, 7, 16) == "dead snake" or
				string.sub(speech, 7, 13) == "chicken" or
				string.sub(speech, 7, 16) == "snake meat"
		 then
			item = Item(string.sub(speech, 7, 21))

			if (item == nil) then
				item = Item(string.sub(speech, 7, 22))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 24))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 14))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 19))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 17))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 16))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 13))
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
			string.sub(speech, 1, 7) == "buy my " and string.sub(speech, 8, 22) == "tropical banana" or
				string.sub(speech, 8, 23) == "little blue fish" or
				string.sub(speech, 8, 25) == "little orange fish" or
				string.sub(speech, 8, 15) == "dead rat" or
				string.sub(speech, 8, 20) == "dead squirrel" or
				string.sub(speech, 8, 18) == "dead rabbit" or
				string.sub(speech, 8, 17) == "dead snake" or
				string.sub(speech, 8, 14) == "chicken" or
				string.sub(speech, 8, 17) == "snake meat"
		 then
			item = Item(string.sub(speech, 8, 22))

			if (item == nil) then
				item = Item(string.sub(speech, 8, 23))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 25))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 15))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 20))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 18))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 17))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 14))
			end

			if (item ~= nil) then
				number = tonumber(string.match(speech, "buy my " .. string.lower(item.name) .. " number (%d+)"))

				if (number == nil) then
					number = 1
				end

				if (player:removeItem(item.yname, number)) == true then
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
