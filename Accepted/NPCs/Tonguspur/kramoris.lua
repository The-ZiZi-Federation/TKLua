kramoris = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local opts = {}

			table.insert(opts, "Buy")
			table.insert(opts, "Sell")
			table.insert(opts, "Repair Item")
			table.insert(opts, "Repair All")

			if player.quest["caravan"] == 0 and player.level >= 50 then
				table.insert(opts, "What kind of help?")
			end
			if player.quest["caravan"] == 1 then
				table.insert(opts, "I have your weapons")
			end
			if player.quest["caravan"] == 2 and player.quest["angry_guard"] == 0 then
				table.insert(opts, "No hurry.")
			end
			if player.quest["angry_guard"] == 1 then
				table.insert(opts, "How about today?")
			end
			if player.quest["angry_guard"] == 3 then
				table.insert(opts, "It didn't work...")
			end

			if player.quest["caravan"] == 0 and player.level <= 49 then
				menu = player:menuString(name .. "Welcome to my shop.", opts)
			elseif player.quest["caravan"] == 0 and player.level >= 50 then
				menu = player:menuString(name .. "Hey pal, can you help me out?", opts)
			elseif player.quest["caravan"] == 1 then
				menu = player:menuString(name .. "Back already? You got my stuff?", opts)
			elseif player.quest["caravan"] == 2 then
				menu = player:menuString(name .. "Thanks again! I promise I'll pay you back someday.", opts)
			elseif player.quest["caravan"] == 3 then
				menu = player:menuString(name .. "Hey friend, how goes it?", opts)
			end

			if menu == "Buy" then
				weapon_smith.buy(player)
			elseif menu == "Sell" then
				weapon_smith.sell(player)
			elseif menu == "Repair Item" then
				player:repairExtend()
			elseif menu == "Repair All" then
				player:repairAll(player, npc)
			elseif menu == "What kind of help?" then
				player:dialogSeq(
					{
						t,
						name .. "I'm in the shipping business.",
						name .. "My cargo this month was a huge shipment of weapons, mostly swords, bound for the Hon Militia.",
						name .. "I, uh, agreed to ship more than my caravan could carry.",
						name .. "I hid the extra crates in the woods, but when I came back for them, I saw them being stolen!",
						name .. "Those grave robbers took every last crate back to the Disturbed Tomb.",
						name ..
							"Normally I'd go in myself and give them hell, but my mother has fallen ill, so I'm staying here with her.",
						name .. "If you could go kick those guys asses and bring my weapons back, I would owe you a big favor.",
						name .. "There were at least a hundred of them, plus two high-quality masterworks!"
					},
					1
				)
				player.quest["caravan"] = 1
				player:msg(4, "[Quest Update] Recover the stolen weapons!", player.ID)
			elseif menu == "I have your weapons" then
				if player:hasItem("stolen_sword", 100) == true and player:hasItem("stolen_blade", 2) == true then
					if player:removeItem("stolen_sword", 100) == true and player:removeItem("stolen_blade", 2) == true then
						player.quest["caravan"] = 2
						player:dialogSeq(
							{
								t,
								name .. "You really got my swords! Now I owe you a huge favor...",
								name .. "It might take me a while, but I'll find a way to pay you back.",
								name .. "Oh! and if you find any more of my swords, I'll gladly pay you for them."
							},
							1
						)
						giveXP(player, 500000)
						player:addGold(25000)
						finishedQuest(player)
						player:calcStat()
						player:sendStatus()
						player:msg(4, "[Quest Complete] You got... an IOU?!", player.ID)
					else
						player:dialogSeq(
							{
								t,
								name ..
									"What are you waiting for? Hurry to the Disturbed Tomb and find those swords! There were at least a hundred of them, plus two high-quality masterworks!"
							},
							1
						)
					end
				else
					player:dialogSeq(
						{
							t,
							name ..
								"What are you waiting for? Hurry to the Disturbed Tomb and find those swords! There were at least a hundred of them, plus two high-quality masterworks!"
						},
						1
					)
				end
			elseif menu == "No hurry." then
				player:dialogSeq({t, name .. "You're too kind. That only makes me want to pay you back sooner!"}, 1)
			elseif menu == "How about today?" then
				player:dialogSeq(
					{
						t,
						name ..
							"Oh, you're trying to get to Cathay and Edd won't let you in? He's always troubling the visitors. What is he asking you for this time?",
						name .. "Deeds out of the goodness of your heart? For no reward? Hell, that's exactly what you did for me.",
						name .. "Er, I mean I do still owe you one. What if I write a note to Edd and tell him what you did for me?",
						name .. "Edd will see this and let you right into Cathay, I'm sure.",
						name .. "But after this we're even, got it?"
					},
					1
				)
				player:addItem("kramoris_iou", 1)
				player:msg(4, "[Quest Update] Return to Edd with the IOU from Kramoris!", player.ID)
				player.quest["angry_guard"] = 2
				player.quest["caravan"] = 3
			elseif menu == "It didn't work..." then
				player.quest["angry_guard"] = 4
				player:dialogSeq(
					{
						t,
						name .. "Edd still didn't let you through the gate?",
						name .. "Damn, he must really be having a bad day.",
						name ..
							"Normally Edd is a really nice guy, but on days like this he gets real hungry and lashes out at anyone who talks to him.",
						name .. "I bet some food will do the trick.",
						name .. "Bring him a meal from the Tonguspur Kitchen south of here, and I'm sure he perks right up."
					},
					1
				)
				player:msg(4, "[Quest Update] Go to Tonguspur Kitchen to get a meal for Edd!", player.ID)
			end
		end
	),
	say = function(player, npc)
		local speech = string.lower(player.speech)
		local item
		local number

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
	end,
	nearbyPlayers = function(npc)
		local pc = npc:getObjectsInArea(BL_PC)
		local m, x, y = npc.m, npc.x, npc.y

		if #pc > 0 then
			for i = 1, #pc do
				if pc[i].quest["caravan"] == 0 and pc[i].level >= 50 then
					pc[i]:selfAnimationXY(pc[i].ID, 248, x, y)
				end
			end
		end
	end
}
