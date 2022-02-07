-- Hon Weapon Smith (Beardy McBeardson)
hon_weapon_smith = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local options = {}
			table.insert(options, "Buy")
			table.insert(options, "Sell")
			table.insert(options, "Repair Item")
			table.insert(options, "Repair All")

			if player.quest["help_joe"] == 1 and player.quest["joes_metal"] == 0 then
				table.insert(options, "I'm here for Joe's metal")
			end

			menu = player:menuString(name .. "I am a smith, I buy and sell weapons. I can also repair your equipment.", options)

			if menu == "Buy" then
				weapon_smith.buy(player)
			elseif menu == "Sell" then
				weapon_smith.sell(player)
			elseif menu == "Repair Item" then
				player:repairExtend()
			elseif menu == "Repair All" then
				player:repairAll(player, npc)
			elseif menu == "I'm here for Joe's metal" then
				player:dialogSeq({t, name .. "Just between us, I was hoping he would forget this was here."}, 1)
				player.quest["joes_metal"] = 1
				player:msg(4, "[Quest Updated] Obtained Joe's Metal!", player.ID)
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

		if
			string.sub(speech, 1, 6) == "i buy " and string.sub(speech, 7, 23) == "spring moon blade" or
				string.sub(speech, 7, 23) == "summer moon blade" or
				string.sub(speech, 7, 23) == "winter moon blade" or
				string.sub(speech, 7, 23) == "autumn moon blade" or
				string.sub(speech, 7, 17) == "steel thorn" or
				string.sub(speech, 7, 18) == "arming sword" or
				string.sub(speech, 7, 13) == "electra" or
				string.sub(speech, 7, 21) == "blue maxcaliber" or
				string.sub(speech, 7, 19) == "paragon blade" or
				string.sub(speech, 7, 18) == "spring knife" or
				string.sub(speech, 7, 18) == "summer knife" or
				string.sub(speech, 7, 18) == "winter knife" or
				string.sub(speech, 7, 18) == "autumn knife" or
				string.sub(speech, 7, 21) == "bloody stiletto" or
				string.sub(speech, 7, 16) == "rusty dirk" or
				string.sub(speech, 7, 17) == "common dirk" or
				string.sub(speech, 7, 17) == "gilded dirk" or
				string.sub(speech, 7, 25) == "polished shortsword" or
				string.sub(speech, 7, 19) == "paragon knife" or
				string.sub(speech, 7, 17) == "spring wand" or
				string.sub(speech, 7, 17) == "summer wand" or
				string.sub(speech, 7, 17) == "winter wand" or
				string.sub(speech, 7, 17) == "autumn wand" or
				string.sub(speech, 7, 16) == "bloody rod" or
				string.sub(speech, 7, 13) == "oak rod" or
				string.sub(speech, 7, 20) == "common scepter" or
				string.sub(speech, 7, 23) == "exquisite scepter" or
				string.sub(speech, 7, 18) == "arcane staff" or
				string.sub(speech, 7, 18) == "paragon wand" or
				string.sub(speech, 7, 17) == "spring club" or
				string.sub(speech, 7, 17) == "summer club" or
				string.sub(speech, 7, 17) == "winter club" or
				string.sub(speech, 7, 17) == "autumn club" or
				string.sub(speech, 7, 17) == "bloody club" or
				string.sub(speech, 7, 26) == "run-down morningstar" or
				string.sub(speech, 7, 24) == "reused morningstar" or
				string.sub(speech, 7, 27) == "pristine morningstar" or
				string.sub(speech, 7, 23) == "spiked shillelagh" or
				string.sub(speech, 7, 18) == "paragon club"
		 then
			item = Item(string.sub(speech, 7))

			if (item == nil) then
				item = Item(string.sub(speech, 7, 23))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 23))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 23))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 17))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 18))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 13))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 21))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 19))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 18))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 18))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 18))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 18))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 21))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 16))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 17))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 17))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 25))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 19))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 17))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 17))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 17))
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

			if (item == nil) then
				item = Item(string.sub(speech, 7, 20))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 23))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 18))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 18))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 17))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 17))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 17))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 17))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 17))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 26))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 24))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 27))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 18))
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
			string.sub(speech, 1, 7) == "buy my " and string.sub(speech, 8, 24) == "spring moon blade" or
				string.sub(speech, 8, 24) == "summer moon blade" or
				string.sub(speech, 8, 24) == "winter moon blade" or
				string.sub(speech, 8, 24) == "autumn moon blade" or
				string.sub(speech, 8, 18) == "steel thorn" or
				string.sub(speech, 8, 19) == "arming sword" or
				string.sub(speech, 8, 14) == "electra" or
				string.sub(speech, 8, 22) == "blue maxcaliber" or
				string.sub(speech, 8, 20) == "paragon blade" or
				string.sub(speech, 8, 19) == "spring knife" or
				string.sub(speech, 8, 19) == "summer knife" or
				string.sub(speech, 8, 19) == "winter knife" or
				string.sub(speech, 8, 19) == "autumn knife" or
				string.sub(speech, 8, 22) == "bloody stiletto" or
				string.sub(speech, 8, 17) == "rusty dirk" or
				string.sub(speech, 8, 18) == "common dirk" or
				string.sub(speech, 8, 18) == "gilded dirk" or
				string.sub(speech, 8, 26) == "polished shortsword" or
				string.sub(speech, 8, 20) == "paragon knife" or
				string.sub(speech, 8, 18) == "spring wand" or
				string.sub(speech, 8, 18) == "summer wand" or
				string.sub(speech, 8, 18) == "winter wand" or
				string.sub(speech, 8, 18) == "autumn wand" or
				string.sub(speech, 8, 17) == "bloody rod" or
				string.sub(speech, 8, 14) == "oak rod" or
				string.sub(speech, 8, 21) == "common scepter" or
				string.sub(speech, 8, 24) == "exquisite scepter" or
				string.sub(speech, 8, 19) == "arcane staff" or
				string.sub(speech, 8, 19) == "paragon wand" or
				string.sub(speech, 8, 18) == "spring club" or
				string.sub(speech, 8, 18) == "summer club" or
				string.sub(speech, 8, 18) == "winter club" or
				string.sub(speech, 8, 18) == "autumn club" or
				string.sub(speech, 8, 18) == "bloody club" or
				string.sub(speech, 8, 27) == "run-down morningstar" or
				string.sub(speech, 8, 25) == "reused morningstar" or
				string.sub(speech, 8, 28) == "pristine morningstar" or
				string.sub(speech, 8, 24) == "spiked shillelagh" or
				string.sub(speech, 8, 19) == "paragon club"
		 then
			item = Item(string.sub(speech, 8, 24))

			if (item == nil) then
				item = Item(string.sub(speech, 8, 24))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 24))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 24))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 18))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 19))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 14))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 22))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 20))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 19))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 19))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 19))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 19))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 22))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 17))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 18))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 18))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 26))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 20))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 18))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 18))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 18))
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

			if (item == nil) then
				item = Item(string.sub(speech, 8, 21))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 24))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 19))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 19))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 18))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 18))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 18))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 18))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 18))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 27))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 25))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 28))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 19))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 24))
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
