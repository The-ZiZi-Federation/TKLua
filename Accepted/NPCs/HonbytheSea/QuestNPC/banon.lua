banon = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local opts = {}
			local buyitems = {449, 3004, 6026, 3009}
			local sellitems = {3001, 3003, 3004, 408, 6026}
			local options = {}
			table.insert(opts, "Buy")
			table.insert(opts, "Sell")

			if player.quest["dre_loc_rambles"] == 2 then
				table.insert(opts, "Crafting a weapon")
			end
			if player.quest["dre_loc_rambles"] == 3 and player.quest["improvised_spear"] == 0 then
				table.insert(opts, "One more thing?")
			end
			if player.quest["dre_loc_rambles"] == 4 and player.quest["improvised_spear"] == 1 then
				table.insert(opts, "Could you repeat the spear recipe?")
				table.insert(opts, "Can I make another Spear?")
			end

			if player.quest["crates"] == 4 and player.quest["shield_upgrade"] == 0 then
				table.insert(opts, "Your friend Jerry sent me")
			end

			if player.quest["shield_upgrade"] == 1 then
				table.insert(opts, "How to upgrade a shield")
			end
			if player.quest["shield_upgrade"] == 2 then
				table.insert(opts, "Could you repeat the shield recipe?")
			end
			if player.quest["shield_upgrade"] >= 2 then
				table.insert(buyitems, 408)
				table.insert(sellitems, 408)
			end

			if player.quest["gator_scales"] == 2 then
				table.insert(opts, "Armor upgrade?")
			end

			if player.quest["swamp_armor_upgrade"] >= 1 then
				table.insert(buyitems, 433)
				table.insert(sellitems, 433)
			end
			if player.quest["swamp_armor_upgrade"] >= 1 then
				table.insert(opts, "Could you repeat the armor recipe?")
			end

			if player.quest["fighter_favor"] == 1 and player.quest["pickup_toolbox"] == 0 then
				table.insert(opts, "Pick up toolbox")
			end

			menu = player:menuString(name .. "Hi! What can I do for you?", opts)

			if menu == "Buy" then
				player:buyExtend(name .. "What would you like to buy?", buyitems)
			elseif menu == "Sell" then
				player:sellExtend(name .. "What do you wish to sell?", sellitems)
			elseif menu == "Crafting a weapon" then
				player:dialogSeq(
					{
						t,
						name .. "Dre Loc sent you?",
						name .. "Well, if you need to arm yourself I can certainly take a look at what you've brought me."
					},
					1
				)
				if player:hasItem("sturdy_stick", 5) == true and player:hasItem("sharp_rock", 5) == true then
					if player:removeItem("sturdy_stick", 5) == true and player:removeItem("sharp_rock", 5) == true then
						player:addItem("stone_spearhead", 1)
						player:addItem("spear_shaft", 1)
						finishedQuest(player)
						player.quest["dre_loc_rambles"] = 3
						player:msg(4, "[Quest Update] Got a Spear Shaft and Stone Spearhead!", player.ID)
						player:dialogSeq(
							{
								t,
								name .. "I was able to find a couple of useful pieces in that mess.",
								name .. "I've made you a spear shaft and stone spearhead.",
								name .. "Now you only need one more thing..."
							},
							1
						)
					else
						player:dialogSeq(
							{
								t,
								name .. "None of this looks quite right..",
								name .. "Keep searching, and when you find some more materials bring them in and then I'll take a look."
							},
							1
						)
					end
				else
					player:dialogSeq(
						{
							t,
							name .. "None of this looks quite right..",
							name .. "Keep searching, and when you find some more materials bring them in and then I'll take a look."
						},
						1
					)
				end
			elseif menu == "One more thing?" then
				player:msg(4, "[Quest Update] Buy Twine from Banon and create a spear! ((Shift + 'i'))", player.ID)
				player.quest["dre_loc_rambles"] = 4
				player.quest["improvised_spear"] = 1
				player:dialogSeq(
					{
						t,
						name .. "Yeah, that isn't quite enough...",
						name .. "You have the shaft and spearhead, but you'll need to bind them together in order to make a real spear.",
						name .. "Lucky for you, I happen to sell twine here in my shop.",
						name ..
							"After you buy some twine, press Shift + 'i' to open the Creation System. Add the shaft, spearhead and twine and then click 'OK' to craft your spear."
					},
					1
				)
			elseif menu == "Could you repeat the spear recipe?" then
				player:dialogSeq(
					{
						t,
						name .. "You have the shaft and spearhead, but you'll need to bind them together in order to make a real spear.",
						name .. "Lucky for you, I happen to sell twine here in my shop.",
						name ..
							"After you buy some twine, press Shift + 'i' to open the Creation System. Add the shaft, spearhead and twine and then click 'OK' to craft your spear."
					},
					1
				)
			elseif menu == "Can I make another Spear?" then
				player:dialogSeq({t, name .. "Bring me 5 Sturdy sticks and 5 Sharp Rocks"}, 1)
				if player:hasItem("sturdy_stick", 5) == true and player:hasItem("sharp_rock", 5) == true then
					if player:removeItem("sturdy_stick", 5) == true and player:removeItem("sharp_rock", 5) == true then
						player:addItem("stone_spearhead", 1)
						player:addItem("spear_shaft", 1)
					end
				end
			elseif menu == "Your friend Jerry sent me" then
				player:dialogSeq(
					{
						t,
						name .. "You know Jerry? He's a great judge of character.",
						name .. "Any friend of Jerry's is a friend of mine.",
						name .. "Upgrading a shield? Yeah, I taught him a little about that.",
						name .. "I'd be happy to teach you how to improve your own shield.",
						name .. "Speak to me again whenever you're ready to learn."
					},
					1
				)
				player.quest["shield_upgrade"] = 1
				player:msg(4, "[Quest Update] Talk to Banon again to learn about upgrades", player.ID)
			elseif menu == "How to upgrade a shield" then
				player.quest["shield_upgrade"] = 2
				player:addLegend("Learned the secrets of the Coastal Shield Coating", "coating", 11, 16)
				giveXP(player, 10000000)
				finishedQuest(player)
				player:calcStat()
				player:sendStatus()
				player:msg(4, "[Quest Complete] Learned about upgrades!", player.ID)
				player:dialogSeq(
					{
						t,
						name .. "To upgrade a shield you will need a few different things.",
						name .. "First you must gather a large amount of fish scales to use as a base for strengthening your shield.",
						name ..
							"Press shift+i to open the Creation system, then add 100 Minnow Scales, 100 Bass Scales and 5 Goldfish Scales. Combine those to get Mashed Scales. You will need 2 bags of Mashed Scales for your shield.",
						name .. "Next you need Snail Shell Fragments to cover the surface of the shield. 5 Fragments is usually enough.",
						name .. "You'll need some Paste to hold it all together. That's easy to come by, I have it for sale in my shop.",
						name ..
							"Open the Creation System again and combine 5 Shell Fragments, 4 Paste and 2 Mashed Scales to make the Coastal Shield Coating.",
						name ..
							"Now that you have the coating, you'll need a shield to coat.  Only a very high quality shield will suffice. Why bother upgrading junk?",
						name ..
							"Once you have all of that, open the Creation System again. Combine a Shield and the Coastal Shield Coating to finish the upgrade.",
						name .. "Enjoy your new shield! You deserve it."
					},
					1
				)
			elseif menu == "Could you repeat the shield recipe?" then
				player:dialogSeq(
					{
						t,
						name .. "To upgrade a shield you will need a few different things.",
						name .. "First you must gather a large amount of fish scales to use as a base for strengthening your shield.",
						name ..
							"Press shift+i to open the Creation system, then add 100 Minnow Scales, 100 Bass Scales and 5 Goldfish Scales. Combine those to get Mashed Scales. You will need 2 bags of Mashed Scales for your shield.",
						name .. "Next you need Snail Shell Fragments to cover the surface of the shield. 5 Fragments is usually enough.",
						name .. "You'll need some Paste to hold it all together. That's easy to come by, I have it for sale in my shop.",
						name ..
							"Open the Creation System again and combine 5 Shell Fragments, 4 Paste and 2 Mashed Scales to make the Shield Coating.",
						name ..
							"Now that you have the coating, you'll need a shield to coat.  Only a very high quality shield will suffice. Why bother upgrading junk?",
						name ..
							"Once you have all of that, open the Creation System again. Combine a Shield and the Shield Coating to finish the upgrade.",
						name .. "Enjoy your new shield! You deserve it."
					},
					1
				)
			elseif menu == "Armor upgrade?" then
				player:dialogSeq(
					{
						t,
						name .. "You've been talking to Jerry I assume.",
						name .. "Yeah, I taught him about armor upgrades.",
						name .. "But really, there's not much to it.",
						name .. "Just like when you made the Coastal Coating, you're going to use the Creation System. (Shift + I)",
						name .. "To start you need a high quality piece of armor.",
						name .. "Then you layer 100 Swamp Gator Scale and 100 Blackstrike Gator Scale over it.",
						name .. "The hardest part to come by is an adhesive that will stick to the scales.",
						name .. "But as it just so happens, I got some delivered this morning.",
						name .. "I can sell you some adhesive, no problem.",
						name .. "Then you just need to stick it all together and enjoy the upgraded armor!"
					},
					1
				)
				player.quest["swamp_armor_upgrade"] = 1
				player.quest["gator_scales"] = 3
			elseif menu == "Could you repeat the armor recipe?" then
				player:dialogSeq(
					{
						t,
						name .. "There's not much to it.",
						name .. "Just like when you made the Coastal Coating, you're going to use the Creation System. (Shift + I)",
						name .. "To start you need a high quality piece of armor.",
						name .. "Then you layer 100 Swamp Gator Scale and 100 Blackstrike Gator Scale over it.",
						name .. "The hardest part to come by is an adhesive that will stick to the scales.",
						name .. "But as it just so happens, I got some delivered this morning.",
						name .. "I can sell you some adhesive, no problem.",
						name .. "Then you just need to stick it all together and enjoy the upgraded armor!"
					},
					1
				)
			elseif menu == "Pick up toolbox" then
				player.quest["pickup_toolbox"] = 1
				player:addItem("toolbox", 1)
				player:dialogSeq({t, name .. "Tools going to Cathay? I have those right here."}, 1)
			end
		end
	),
	say = function(player, npc)
		local speech = string.lower(player.speech)
		local item
		local number

		if
			string.sub(speech, 1, 6) == "i buy " and string.sub(speech, 7, 18) == "simple twine" or
				string.sub(speech, 7, 18) == "earring back"
		 then
			item = Item(string.sub(speech, 7, 18))

			if (item == nil) then
				item = Item(string.sub(speech, 7, 18))
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
			string.sub(speech, 1, 7) == "buy my " and string.sub(speech, 8, 19) == "simple twine" or
				string.sub(speech, 8, 17) == "sharp rock" or
				string.sub(speech, 8, 19) == "sturdy stick" or
				string.sub(speech, 8, 19) == "earring back"
		 then
			item = Item(string.sub(speech, 8, 19))

			if (item == nil) then
				item = Item(string.sub(speech, 8, 17))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 19))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 19))
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
				if pc[i].quest["dre_loc_rambles"] == 3 then
					pc[i]:selfAnimationXY(pc[i].ID, 248, x, y)
				elseif pc[i].quest["dre_loc_rambles"] == 3 and pc[i].quest["improvised_spear"] == 0 then
					pc[i]:selfAnimationXY(pc[i].ID, 248, x, y)
				elseif
					pc[i].quest["dre_loc_rambles"] == 2 and
						(pc[i]:hasItem("sturdy_stick", 10) == true and pc[i]:hasItem("sharp_rock", 10) == true)
				 then
					pc[i]:selfAnimationXY(pc[i].ID, 248, x, y)
				end
			end
		end
	end
}
