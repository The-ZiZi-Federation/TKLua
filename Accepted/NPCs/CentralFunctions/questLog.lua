questLog = {
	click = function(player, npc)
		--	clone.gfx(player, npc)
		local t = {graphic = convertGraphic(1439, "monster"), color = 0}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		local opts = {}

		table.insert(opts, "Available Quests")
		table.insert(opts, "Begun Quests")
		table.insert(opts, "Completed Quests")

		menu = player:menuString("<b>[QUEST LOG]", opts)

		if menu == "Available Quests" then
			questLog.available(player)
		elseif menu == "Begun Quests" then
			questLog.begun(player)
		elseif menu == "Completed Quests" then
			questLog.completed(player)
		end
	end,
	-- Available Quest Options -------------------------------------------------------------------------------------------------------------------------

	available = function(player)
		player.dialogType = 0
		local level = player.level
		local vita = player.baseHealth
		local mana = player.BaseMagic
		local availableQuests = {}
		local path = ""

		if player.baseClass == 1 then
			path = "fighter"
		elseif player.baseClass == 2 then
			path = "scoundrel"
		elseif player.baseClass == 3 then
			path = "wizard"
		elseif player.baseClass == 4 then
			path = "priest"
		end

		if level >= 1 then
			if player.quest["dre_loc_rambles"] == 0 then
				table.insert(availableQuests, "Getting Started")
			end
		end

		if level >= 5 then
			if player.quest[path .. "_path"] == 1 then
				table.insert(availableQuests, "Your First Job")
			end
		end

		if level >= 10 then
			if player.quest["drunk_mug"] == 0 then
				table.insert(availableQuests, "The Drunk's Mug")
			end
		end

		if level >= 15 then
			if player.quest["fox_fur"] == 0 then
				table.insert(availableQuests, "Fox Fur Trader")
			end
		end

		if level >= 20 then
			table.insert(availableQuests, "Ghost Hunt")

			if player.quest["help_joe"] == 0 then
				table.insert(availableQuests, "Help Armorer Joe")
			end

			if player.quest["haunted_house"] == 0 then
				table.insert(availableQuests, "The Haunted House")
			end

			if player.quest["martin"] == 0 and player:hasLegend("mentok") then
				table.insert(availableQuests, "Martin's Got Issues")
			end
		end

		if level >= 25 then
			if player.quest["tonguspur_letter"] == 0 then
				table.insert(availableQuests, "Letter to Tonguspur")
			end
		end

		if level >= 30 then
		end

		if level >= 35 then
			if player.quest["front_lines"] == 0 then
				table.insert(availableQuests, "Aiding the Front Lines")
			end
			if player.quest["supply_lines"] == 0 then
				table.insert(availableQuests, "Aiding the Supply Lines")
			end
		end

		if level >= 40 then
			if player.quest["leech"] == 0 then
				table.insert(availableQuests, "Leech Path Treasure")
			end
			if player.quest["leech_lord"] == 0 then
				table.insert(availableQuests, "Prove Your Skills")
			end
		end

		if level >= 45 then
		end

		if level >= 50 then
			if player.quest["maiden"] == 0 then
				table.insert(availableQuests, "Defend the Maiden")
			end
			if player.quest["caravan"] == 0 then
				table.insert(availableQuests, "Kramoris' Stolen Weapons")
			end
		--		if player.quest["ernest_xmas"] == 0 then
		--			table.insert(availableQuests, "A Quest to Save Christmas")
		--		end
		end

		if level >= 55 then
		end

		if level >= 60 then
			if player.quest["spidersilk"] == 0 then
				table.insert(availableQuests, "Spidersilk for Agnes")
			end
			if player.quest["spider"] == 0 then
				table.insert(availableQuests, "An Unsavory Request")
			end
		end

		if level >= 65 then
		end

		if level >= 70 then
		--		if player.quest[""] == 0 then
		--			table.insert(availableQuests, "")
		--		end
		end

		if level >= 75 then
		end

		if level >= 80 then
			if player.quest["chef"] == 0 then
				table.insert(availableQuests, "Tonguspur Feasts")
			end
			if player.quest["crates"] == 0 then
				table.insert(availableQuests, "Jerry Got Shipwrecked")
			end
		end

		if level >= 85 then
		end

		if level >= 90 then
		end

		if level >= 95 then
			if player.quest["gator_scales"] == 0 then
				table.insert(availableQuests, "Gator Scale Gathering")
			end
		end

		if level >= 99 then
		end

		if level >= 100 then
		end

		-- Available Quest Selections -------------------------------------------------------------------------------------------------------------------------

		menu = player:menuString("<b>[AVAILABLE QUESTS]", availableQuests)

		if menu == "Getting Started" then
			npc = NPC("Dre Loc")
			name = "<b>[" .. npc.name .. "]\n\n"
			map = "<b>" .. npc.mapTitle .. "\n"
			t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player:dialogSeq({t, name .. "At\n\n" .. map .. "\nLocation: Hon by the Sea\nX: 115 Y: 121"}, 1)
			questLog.click(player, npc)
		elseif menu == "Your First Job" then
			if player.baseClass == 1 then
				npc = NPC("Jamlamin")
				name = "<b>[" .. npc.name .. "]\n\n"
				map = "<b>" .. npc.mapTitle .. "\n"
				t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
				x = 89
				y = 48
			elseif player.baseClass == 2 then
				npc = NPC("Baron Rodrik")
				name = "<b>[" .. npc.name .. "]\n\n"
				map = "<b>" .. npc.mapTitle .. "\n"
				t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
				x = 113
				y = 40
			elseif player.baseClass == 3 then
				npc = NPC("Malcor")
				name = "<b>[" .. npc.name .. "]\n\n"
				map = "<b>" .. npc.mapTitle .. "\n"
				t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
				x = 111
				y = 55
			elseif player.baseClass == 4 then
				npc = NPC("Bishop Eugene")
				name = "<b>[" .. npc.name .. "]\n\n"
				map = "<b>" .. npc.mapTitle .. "\n"
				t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
				x = 31
				y = 39
			end
			player:dialogSeq({t, name .. " At\n\n" .. map .. "\nLocation: Hon by the Sea\nX: " .. x .. " Y: " .. y}, 1)
			questLog.click(player, npc)
		elseif menu == "The Drunk's Mug" then
			npc = NPC("Randall")
			name = "<b>[" .. npc.name .. "]\n\n"
			map = "<b>" .. npc.mapTitle .. "\n"
			t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player:dialogSeq({t, name .. "At\n\n" .. map .. "\nLocation: Hon by the Sea\nX: 91 Y: 128"}, 1)
			questLog.click(player, npc)
		elseif menu == "Fox Fur Trader" then
			npc = NPC("Randall")
			name = "<b>[" .. npc.name .. "]\n\n"
			map = "<b>" .. npc.mapTitle .. "\n"
			t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player:dialogSeq({t, name .. "At\n\n" .. map .. "\nLocation: Hon by the Sea\nX: 91 Y: 128"}, 1)
			questLog.click(player, npc)
		elseif menu == "Help Armorer Joe" then
			npc = NPC("Armor Joe")
			name = "<b>[" .. npc.name .. "]\n\n"
			map = "<b>" .. npc.mapTitle .. "\n"
			t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player:dialogSeq({t, name .. "At\n\n" .. map .. "\nLocation: Hon by the Sea\nX: 57 Y: 51"}, 1)
			questLog.click(player, npc)
		elseif menu == "Ghost Hunt" then
			npc = NPC("Egon")
			name = "<b>[" .. npc.name .. "]\n\n"
			map = "<b>" .. npc.mapTitle .. "\n"
			t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player:dialogSeq({t, name .. "At\n\n" .. map .. "\nLocation: West of Hon\nX: 24 Y: 11"}, 1)
			questLog.click(player, npc)
		elseif menu == "The Haunted House" then
			npc = NPC("Harvey")
			name = "<b>[" .. npc.name .. "]\n\n"
			map = "<b>" .. npc.mapTitle .. "\n"
			t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player:dialogSeq({t, name .. "At\n\n" .. map .. "\nLocation: Hon by the Sea\nX: 101 Y: 123"}, 1)
			questLog.click(player, npc)
		elseif menu == "Martin's Got Issues" then
			npc = NPC("Martin")
			name = "<b>[" .. npc.name .. "]\n\n"
			map = "<b>" .. npc.mapTitle .. "\n"
			t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player:dialogSeq({t, name .. "At\n\n" .. map .. "\nLocation: Hon Harbor\nX: 59 Y: 31"}, 1)
			questLog.click(player, npc)
		elseif menu == "Letter to Tonguspur" then
			npc = NPC("Tuleftshu")
			name = "<b>[" .. npc.name .. "]\n\n"
			map = "<b>" .. npc.mapTitle .. "\n"
			t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player:dialogSeq({t, name .. "At\n\n" .. map .. "\nLocation: Hon by the Sea\nX: 19 Y: 128"}, 1)
			questLog.click(player, npc)
		elseif menu == "Aiding the Front Lines" then
			npc = NPC("Cletus")
			name = "<b>[" .. npc.name .. "]\n\n"
			map = "<b>" .. npc.mapTitle .. "\n"
			t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player:dialogSeq({t, name .. "At\n\n" .. map .. "\nLocation: Hon by the Sea\nX: 98 Y: 5"}, 1)
			questLog.click(player, npc)
		elseif menu == "Aiding the Supply Lines" then
			npc = NPC("Cletus")
			name = "<b>[" .. npc.name .. "]\n\n"
			map = "<b>" .. npc.mapTitle .. "\n"
			t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player:dialogSeq({t, name .. "At\n\n" .. map .. "\nLocation: Hon by the Sea\nX: 98 Y: 5"}, 1)
			questLog.click(player, npc)
		elseif menu == "Leech Path Treasure" then
			npc = NPC("Hon Hermit")
			name = "<b>[" .. npc.name .. "]\n\n"
			map = "<b>" .. npc.mapTitle .. "\n"
			t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player:dialogSeq({t, name .. "At\n\n" .. map .. "\nLocation: Hon by the Sea\nX: 130 Y: 8"}, 1)
			questLog.click(player, npc)
		elseif menu == "Prove Your Skills" then
			if player.baseClass == 1 then
				npc = NPC("Jamlamin")
				name = "<b>[" .. npc.name .. "]\n\n"
				map = "<b>" .. npc.mapTitle .. "\n"
				t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
				x = 89
				y = 48
			elseif player.baseClass == 2 then
				npc = NPC("Baron Rodrik")
				name = "<b>[" .. npc.name .. "]\n\n"
				map = "<b>" .. npc.mapTitle .. "\n"
				t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
				x = 113
				y = 40
			elseif player.baseClass == 3 then
				npc = NPC("Malcor")
				name = "<b>[" .. npc.name .. "]\n\n"
				map = "<b>" .. npc.mapTitle .. "\n"
				t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
				x = 111
				y = 55
			elseif player.baseClass == 4 then
				npc = NPC("Bishop Eugene")
				name = "<b>[" .. npc.name .. "]\n\n"
				map = "<b>" .. npc.mapTitle .. "\n"
				t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
				x = 31
				y = 39
			end
			player:dialogSeq({t, name .. " At\n\n" .. map .. "\nLocation: Hon by the Sea\nX: " .. x .. " Y: " .. y}, 1)
			questLog.click(player, npc)
		elseif menu == "Defend the Maiden" then
			npc = NPC("Jules")
			name = "<b>[" .. npc.name .. "]\n\n"
			map = "<b>" .. npc.mapTitle .. "\n"
			t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player:dialogSeq({t, name .. "At\n\n" .. map .. "\nLocation: Woods North of Hon\nX: 96 Y: 131"}, 1)
			questLog.click(player, npc)
		elseif menu == "Kramoris' Stolen Weapons" then
			--	elseif menu == "A Quest to Save Christmas" then
			--		npc = NPC("Ernest")
			--		name = "<b>["..npc.name.."]\n\n"
			--		map = "<b>"..npc.mapTitle.."\n"
			--		t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			--		player:dialogSeq({t, name.."At\n\n"..map.."\nLocation: Hon City: Drunk Duck Inn\nX: 100 Y: 81"}, 1)
			--		questLog.click(player, npc)
			npc = NPC("Kramoris")
			name = "<b>[" .. npc.name .. "]\n\n"
			map = "<b>" .. npc.mapTitle .. "\n"
			t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player:dialogSeq({t, name .. "At\n\n" .. map .. "\nLocation: Woods North of Hon\nX: 73 Y: 102"}, 1)
			questLog.click(player, npc)
		elseif menu == "Spidersilk for Agnes" then
			npc = NPC("Agnes")
			name = "<b>[" .. npc.name .. "]\n\n"
			map = "<b>" .. npc.mapTitle .. "\n"
			t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player:dialogSeq({t, name .. "At\n\n" .. map .. "\nLocation: Woods North of Hon\nX: 62 Y: 101"}, 1)
			questLog.click(player, npc)
		elseif menu == "An Unsavory Request" then
			npc = NPC("Edbard")
			name = "<b>[" .. npc.name .. "]\n\n"
			map = "<b>" .. npc.mapTitle .. "\n"
			t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player:dialogSeq({t, name .. "At\n\n" .. map .. "\nLocation: Woods North of Hon\nX: 142 Y: 103"}, 1)
			questLog.click(player, npc)
		elseif menu == "Tonguspur Feasts" then
			npc = NPC("Chef Boyard")
			name = "<b>[" .. npc.name .. "]\n\n"
			map = "<b>" .. npc.mapTitle .. "\n"
			t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player:dialogSeq({t, name .. "At\n\n" .. map .. "\nLocation: Woods North of Hon\nX: 82 Y: 131"}, 1)
			questLog.click(player, npc)
		elseif menu == "Jerry Got Shipwrecked" then
			npc = NPC("Jerry")
			name = "<b>[" .. npc.name .. "]\n\n"
			map = "<b>" .. npc.mapTitle .. "\n"
			t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player:dialogSeq({t, name .. "At\n\n" .. map .. "\nLocation: Woods North of Hon\nX: 0 Y: 33"}, 1)
			questLog.click(player, npc)
		elseif menu == "Gator Scale Gathering" then
			npc = NPC("Jerry")
			name = "<b>[" .. npc.name .. "]\n\n"
			map = "<b>" .. npc.mapTitle .. "\n"
			t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player:dialogSeq({t, name .. "At\n\n" .. map .. "\nLocation: Woods North of Hon\nX: 0 Y: 33"}, 1)
			questLog.click(player, npc)
		end
	end,
	-- Begun Quest Options --------------------------------------------------------------------------------------------------------------

	begun = function(player)
		player.dialogType = 0
		local level = player.level
		local vita = player.baseHealth
		local mana = player.BaseMagic
		local begunQuests = {}
		local questStatus = {}

		local path = ""

		if player.baseClass == 1 then
			path = "fighter"
		elseif player.baseClass == 2 then
			path = "scoundrel"
		elseif player.baseClass == 3 then
			path = "wizard"
		elseif player.baseClass == 4 then
			path = "priest"
		end

		if player.quest["dre_loc_rambles"] >= 1 and player.quest["dre_loc_rambles"] <= 8 then
			table.insert(begunQuests, "Getting Started")
		end

		if player.quest[path .. "_path"] >= 2 and player.quest[path .. "_path"] <= 5 then
			table.insert(begunQuests, "Your First Job")
		end

		if player.quest["drunk_mug"] == 1 then
			table.insert(begunQuests, "The Drunk's Mug")
		end

		if player.quest["fox_fur"] == 1 then
			table.insert(begunQuests, "Fox Fur Trader")
		end

		if player.quest["help_joe"] == 1 then
			table.insert(begunQuests, "Help Armorer Joe")
		end

		if player.quest["haunted_house"] >= 1 and player.quest["haunted_house"] <= 2 then
			table.insert(begunQuests, "The Haunted House")
		end

		if player.quest["martin"] >= 1 and player.quest["martin"] <= 3 and player:hasLegend("mentok") then
			table.insert(begunQuests, "Martin's Got Issues")
		end

		if player.quest["tonguspur_letter"] >= 1 and player.quest["tonguspur_letter"] <= 2 then
			table.insert(begunQuests, "Letter to Tonguspur")
		end

		if player.quest["front_lines"] == 1 then
			table.insert(begunQuests, "Aiding the Front Lines")
		end

		if player.quest["supply_lines"] == 1 then
			table.insert(begunQuests, "Aiding the Supply Lines")
		end

		if player.quest["leech"] >= 1 and player.quest["leech"] <= 2 then
			table.insert(begunQuests, "Leech Path Treasure")
		end

		if player.quest["leech_lord"] == 1 then
			table.insert(begunQuests, "Prove Your Skills")
		end

		if player.quest["maiden"] >= 1 and player.quest["maiden"] <= 9 then
			table.insert(begunQuests, "Defend the Maiden")
		end

		if player.quest["caravan"] == 1 then
			table.insert(begunQuests, "Kramoris' Stolen Weapons")
		end

		--	if player.quest["ernest_xmas"] >= 1 and player.quest["ernest_xmas"] >= 8 then
		--		table.insert(begunQuests, "A Quest to Save Christmas")
		--	end

		if player.quest["spidersilk"] == 1 then
			table.insert(begunQuests, "Spidersilk for Agnes")
		end

		if player.quest["spider"] == 1 then
			table.insert(begunQuests, "An Unsavory Request")
		end

		if player.quest["lost_something"] >= 1 and player.quest["lost_something"] <= 3 then
			table.insert(begunQuests, "Something Lost")
		end

		if player.quest["chef"] >= 1 and player.quest["chef"] <= 5 then
			table.insert(begunQuests, "Tonguspur Feasts")
		end

		if player.quest["crates"] >= 1 and player.quest["crates"] <= 3 then
			table.insert(begunQuests, "Jerry Got Shipwrecked")
		end

		if player.quest["gator_scales"] == 1 then
			table.insert(begunQuests, "Gator Scale Gathering")
		end

		menu = player:menuString("<b>[BEGUN QUESTS]", begunQuests)

		if menu == "Getting Started" then
			npc = NPC("Dre Loc")
			name = "<b>[" .. npc.name .. "]\n\n"
			t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}

			npc2 = NPC("Banon")
			name2 = "<b>[" .. npc2.name .. "]\n\n"
			t2 = {graphic = convertGraphic(npc2.look, "monster"), color = npc2.lookColor}

			npc3 = NPC("Harvey")
			name3 = "<b>[" .. npc3.name .. "]\n\n"
			t3 = {graphic = convertGraphic(npc3.look, "monster"), color = npc3.lookColor}
			serum = {graphic = convertGraphic(1303, "item"), color = 0}

			if player.quest["dre_loc_rambles"] >= 2 then
				table.insert(questStatus, "Sticks and Stones")
			end

			if player.quest["dre_loc_rambles"] >= 3 then
				table.insert(questStatus, "Create A Weapon")
			end

			if player.quest["dre_loc_rambles"] >= 5 then
				table.insert(questStatus, "Pink Flowers")
			end

			if player.quest["dre_loc_rambles"] >= 6 then
				table.insert(questStatus, "Bouquet")
			end

			if player.quest["dre_loc_rambles"] >= 7 then
				table.insert(questStatus, "Serum from Harvey")
			end

			if player.quest["dre_loc_rambles"] == 8 then
				table.insert(questStatus, "Gather Honey")
			end

			menu = player:menuString("<b>[QUEST STATUS]", questStatus)

			if menu == "Sticks and Stones" then
				player:dialogSeq(
					{
						t,
						name .. "I don't know if you've heard of Morna before, but it is very dangerous here.",
						name .. "You'll need to arm yourself as well, but I don't have any weapons just lying around here to hand out.",
						name ..
							"You are in the city of Hon by the Sea, and you should be able to find plenty of Sturdy Sticks and Sharp Stones around the South Gate.",
						name ..
							"((You will find these near X:60, Y:100, north of South Gate. Press 'o' while facing some objects on the ground to pick them up))",
						name ..
							"Once you've gathered up about 5 of each, seek out Banon in the west of town. He can help you fashion them into something a little more formidable.",
						name .. "He might try to charge you, so take a few coins. ((Find Banon at: X:27, Y:113))",
						name ..
							"I'll even teach you some magic to help out. Use this Gateway spell to warp to one of the Hon gates\n\n((Press '1' to cast the spell, then type n, e, s, or w and press 'enter'))"
					},
					1
				)

				questLog.click(player, npc)
			elseif menu == "Create A Weapon" then
				player:dialogSeq(
					{
						t2,
						name2 .. "I was able to find a couple of useful pieces in that mess.",
						name2 .. "I've made you a spear shaft and stone spearhead.",
						name2 .. "Now you only need one more thing...",
						name2 .. "You have the shaft and spearhead, but you'll need to bind them together in order to make a real spear.",
						name2 .. "Lucky for you, I happen to sell twine here in my shop.",
						name2 ..
							"After you buy some twine, press Shift + 'i' to open the Creation System. Add the shaft, spearhead and twine and then click 'OK' to craft your spear."
					},
					1
				)

				questLog.click(player, npc)
			elseif menu == "Pink Flowers" then
				player:dialogSeq(
					{
						t,
						name .. "Good, good, at least you're no longer unarmed.",
						name .. "Did you notice the pink flowers out in the same field where you gathered your rocks and sticks?",
						name .. "Go and fetch me 6 of them, will you?"
					},
					1
				)

				questLog.click(player, npc)
			elseif menu == "Bouquet" then
				player:dialogSeq(
					{
						t,
						name .. "Oh, neat. You actually did it.",
						name .. "Here, take this ribbon and wrap them up into a bouquet.",
						name .. "Did Banon teach you how to use the Creation System?",
						name .. "Just do the same thing here. Combine 6 Pink Flowers with that Bouquet Ribbon."
					},
					1
				)

				questLog.click(player, npc)
			elseif menu == "Serum from Harvey" then
				player:dialogSeq(
					{
						t,
						name .. "Now it is time to see if you are truly ready for a life in Morna.",
						name .. "There are many caves and dungeons across the world filled with dangerous beasts.",
						name .. "There is even a small one here, near my temple.",
						name ..
							"My magical barrier prevents the creatures from escaping, but they should prove a fine test of your mettle.",
						name .. "To pass the barrier and enter the cave you will need my special Serum.",
						name .. "Most of my supply is at Harvey's Hut. He's a good kid and offered to keep it safe for me.",
						name .. "You can find Harvey's Hut just west of here, it is difficult to miss.",
						name .. "Harvey is... fond of explosions. I'd better teach you a little bit about healing, to be safe.",
						name .. "((You learned Basic First Aid! Press '2' to heal yourself))"
					},
					1
				)

				questLog.click(player, npc)
			elseif menu == "Gather Honey" then
				player:dialogSeq(
					{
						t3,
						name3 .. "Dre Loc's Serum? Yeah, I have it right here.",
						name3 .. "Let me guess, he's sending you after some honey?",
						name3 .. "Oh, he didn't even tell you?",
						name3 ..
							"That cave behind his temple is where he keeps his beehives, so he can always have fresh honey for his tea.",
						name3 .. "Did he tell you he put up a barrier to keep the creatures inside?",
						name3 .. "Well, that's sort of true. He put it up so the bees wouldn't escape.",
						name3 .. "Dre Loc likes his honey local, you see.",
						name3 .. "Either way, here's the serum. I actually took the opportunity to do some research on it..",
						name3 .. "I've made a few... improvements to the formula.",
						name3 .. "I can't wait to see if it works!",
						serum,
						"Harvey hands you the Serum, and you quickly choke it down and almost vomit.",
						"Whatever improvements he has made, flavor is certainly not one of them.",
						t3,
						name3 ..
							"Go ahead and grab 10 jars of honey if you can. That way he won't make me go down there again anytime soon..."
					},
					1
				)
				questLog.click(player, npc)
			end
		elseif menu == "Your First Job" then
			if player.baseClass == 1 then
				npc = NPC("Jamlamin")
				name = "<b>[" .. npc.name .. "]\n\n"
				t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
				b = {graphic = convertGraphic(2059, "item"), color = 11}
				g = {graphic = convertGraphic(1189, "item"), color = 24}

				npc2 = NPC("Godfrey Kerby")
				name2 = "<b>[" .. npc2.name .. "]\n\n"
				t2 = {graphic = convertGraphic(npc2.look, "monster"), color = npc2.lookColor}

				if player.quest["fighter_path"] >= 2 then
					table.insert(questStatus, "Sewer Bandit")
				end

				if player.quest["fighter_path"] >= 3 then
					table.insert(questStatus, "Return Finding")
				end

				if player.quest["fighter_path"] >= 4 then
					table.insert(questStatus, "Earthworks")
				end

				if player.quest["fighter_path"] >= 5 then
					table.insert(questStatus, "War Thog")
				end

				menu = player:menuString("<b>[QUEST STATUS]", questStatus)

				if menu == "Sewer Bandit" then
					player:dialogSeq(
						{
							t,
							name .. "One of our guards noticed a bandit creeping into the sewers last night.",
							name .. "Hon by the Sea is plagued with Scoundrels, Bandits, and Thieves.",
							name ..
								"Some of our own guards might be on the take. We know the bandits are entering the sewers somewhere near the south gate.",
							name .. "I need you to go see who you may find in the Deep Sewers.",
							name .. "Last I heard, there was a Scoundrel guild using the sewers to get in and out of the city with goods.",
							name .. "Go investigate and report back to me with whatever you find."
						},
						1
					)
				elseif menu == "Return Finding" then
					player:dialogSeq(
						{
							t,
							name ..
								"I ran away with two others, but we got seperated. There were rats everywhere, bigger than any you've ever seen.  I think there are ghosts inside the walls down here. We heard horrible grinding sounds...",
							name ..
								"I saw the rats eating Tommy, but I think Gerald got away. I didn't see it but I heard him scream 'These rats are worse than the snakes!' I just kept running until I was able to hide here.",
							name .. "I don't have any fight left in me. Just take this and leave, please.",
							g,
							"The bandit gives you some new hand items! Press 'i' to see!"
						},
						1
					)
				elseif menu == "Earthworks" then
					player:dialogSeq(
						{
							t,
							name .. "A cave full of snakes? He must have been talking about the Earthworks!",
							name .. "It's a cave located near Hon's South Gate. It was once going to be dug out and built over",
							name ..
								"Then the snakes showed up. Now it's a deserted mudhole. I thought the only person stupid enough to go in there anymore was the War Thog.",
							name ..
								"If the bandits have moved in too, they must have made a deal with him. Tread lightly, the War Thog has slain far better fighters than you.",
							name ..
								"Now, go enter the Earthworks and find out how many strong they are. If you run into War Thog, you are to tell him that we don't want these bandits running around our city.",
							b,
							"The guild leader gives you  piece of equipment! Press 'i' to see!"
						},
						1
					)
				elseif menu == "War Thog" then
					player:dialogSeq(
						{
							t,
							name .. "Jamlamin? He tried to take me on himself, twenty years ago, and I left him bleeding in the dirt.",
							name .. "Now he sends some young upstart to try and kill an old man? Pathetic.",
							name ..
								"Tell Jamlamin I no longer intend to harm anyone living in Hon. I am simply training my boy and our soldiers before we leave this place.",
							name .. "Here, take these and tell Jamlamin I said to equip his fighter more or they'll all die."
						},
						1
					)
				end
			elseif player.baseClass == 2 then
				npc = NPC("Baron Rodrik")
				name = "<b>[" .. npc.name .. "]\n\n"
				t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
				g = {graphic = convertGraphic(2490, "item"), color = 130}

				npc2 = NPC("Godfrey Kerby")
				name2 = "<b>[" .. npc2.name .. "]\n\n"
				t2 = {graphic = convertGraphic(npc2.look, "monster"), color = npc2.lookColor}

				if player.quest["scoundrel_path"] >= 2 then
					table.insert(questStatus, "Sewer Bandit")
				end

				if player.quest["scoundrel_path"] >= 3 then
					table.insert(questStatus, "Return Finding")
				end

				if player.quest["scoundrel_path"] >= 4 then
					table.insert(questStatus, "Earthworks")
				end

				if player.quest["scoundrel_path"] >= 5 then
					table.insert(questStatus, "War Thog")
				end

				menu = player:menuString("<b>[QUEST STATUS]", questStatus)

				if menu == "Sewer Bandit" then
					player:dialogSeq(
						{
							t,
							name .. "So you're eager to start putting in work for the guild?",
							name .. "I think I have just the thing for you.",
							name ..
								"Some... let's say 'former members' are still operating out of Hon, while refusing to pay the guild our dues.",
							name .. "I need you to go send them a message for me. Let these traitors see how we deal with disloyalty.",
							name ..
								"Last I heard, their group was operating out of the deep sewers in the Hon Underground. There are entrances all over the city.",
							name .. "Go investigate and report back to me with whatever you find."
						},
						1
					)
				elseif menu == "Return Finding" then
					player:dialogSeq(
						{
							t,
							name ..
								"I ran away with two others, but we got seperated. There were rats everywhere, bigger than any you've ever seen.  I think there are ghosts inside the walls down here. We heard horrible grinding sounds...",
							name ..
								"I saw the rats eating Tommy, but I think Gerald got away. I didn't see it but I heard him scream 'These rats are worse than the snakes!' I just kept running until I was able to hide here.",
							name .. "I don't have any fight left in me. Just take this and leave, please.",
							g,
							"The bandit gives you some new hand items! Press 'i' to see!"
						},
						1
					)
				elseif menu == "Earthworks" then
					player:dialogSeq(
						{
							t,
							name .. "A cave full of snakes? He must have been talking about the Earthworks!",
							name .. "It's a cave located near Hon's South Gate. It was once going to be dug out and built over",
							name ..
								"Then the snakes showed up. Now it's a deserted mudhole. I thought the only person stupid enough to go in there anymore was the War Thog.",
							name ..
								"If the bandits have moved in too, they must have made a deal with him. Tread lightly, the War Thog has slain far better scoundrels than you.",
							b,
							"The guild leader gives you  piece of equipment! Press 'i' to see!"
						},
						1
					)
				elseif menu == "War Thog" then
					player:dialogSeq(
						{
							t,
							name .. "You come here, to my home, to tell me about the Baron's Plans.",
							name .. "When Rodrik was young he came into my old home. He thought he was the shit.",
							name ..
								"I broke both his arms and then tied the lacing from his boots together and watching him waddle out crying.",
							name .. "So what does the 'Baron' want now? I bet it is about the men he lost to my command.",
							name .. "Tell Rodrik, I will compensate him for his losses as a one time courtesy. As for you though...",
							name ..
								"If you want to live long in this world. You better equip yourself better. Take these and tell Rodrik to stop being cheap with his new recruits."
						},
						1
					)
				end
			elseif player.baseClass == 3 then
				npc = NPC("Malcor")
				name = "<b>[" .. npc.name .. "]\n\n"
				t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
				b = {graphic = convertGraphic(2062, "item"), color = 29}
				g = {graphic = convertGraphic(2289, "item"), color = 26}

				if player.quest["wizard_path"] >= 2 then
					table.insert(questStatus, "Sewer Bandit")
				end

				if player.quest["wizard_path"] >= 3 then
					table.insert(questStatus, "Return Finding")
				end

				if player.quest["wizard_path"] >= 4 then
					table.insert(questStatus, "Earthworks")
				end

				if player.quest["wizard_path"] >= 5 then
					table.insert(questStatus, "War Thog")
				end

				menu = player:menuString("<b>[QUEST STATUS]", questStatus)

				if menu == "Sewer Bandit" then
					player:dialogSeq(
						{
							t,
							name .. "So you just became a wizard, and you think you are ready for a job?",
							name .. "I think I have just the thing for you.",
							name ..
								"We need you to run on into the sewers and see why the rats are leaving. Someone must be down there to have stirred them up..",
							name .. "If you find someone down there, find out who they are, and why they are there..",
							name ..
								"Unless you think this job is not good enough for you. You can find entrances to the sewers all over the city.",
							name .. "Go investigate and report back to me with whatever you find."
						},
						1
					)
				elseif menu == "Return Finding" then
					player:dialogSeq(
						{
							t,
							name ..
								"I ran away with two others, but we got seperated. There were rats everywhere, bigger than any you've ever seen.  I think there are ghosts inside the walls down here. We heard horrible grinding sounds...",
							name ..
								"I saw the rats eating Tommy, but I think Gerald got away. I didn't see it but I heard him scream 'These rats are worse than the snakes!' I just kept running until I was able to hide here.",
							name .. "I don't have any fight left in me. Just take this and leave, please.",
							g,
							"The bandit gives you some new hand items! Press 'i' to see!"
						},
						1
					)
				elseif menu == "Earthworks" then
					player:dialogSeq(
						{
							t,
							name .. "A cave full of snakes? He must have been talking about the Earthworks!",
							name .. "It's a cave located near Hon's South Gate. It was once going to be dug out and built over",
							name ..
								"Then the snakes showed up. Now it's a deserted mudhole. I thought the only person stupid enough to go in there anymore was the War Thog.",
							name ..
								"If the bandits have moved in too, they must have made a deal with him. Tread lightly, the War Thog has slain far better wizards than you.",
							name ..
								"We need to know how many there are down there. If you do find the War Thog, tell him Delta sent you. It might be the only way you leave alive.",
							b,
							"The guild leader gives you  piece of equipment! Press 'i' to see!"
						},
						1
					)
				elseif menu == "War Thog" then
					player:dialogSeq(
						{
							t,
							name .. "Ahh Delta, that old goat. You know, a long time ago, Delta was the best prankster ever.",
							name ..
								"Oh, he attracted all the ladies, and I think all the men too. I am sure you don't want to hear an old story.",
							name .. "I assume, he sent to ask whether or not I will continue to honor our agreement.",
							name .. "Luckily for you, our plans of raising an army and starting a kingdom will require Seagrove's aid.",
							name .. "You can return to Delta and tell him we will continue to take his advice.",
							name ..
								"As for you, The stingy wizards from Seagrove clearly did not prepare you well. Take these and good luck making it out of here."
						},
						1
					)
				end
			elseif player.baseClass == 4 then
				npc = NPC("Bishop Eugene")
				name = "<b>[" .. npc.name .. "]\n\n"
				t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
				b = {graphic = convertGraphic(2058, "item"), color = 23}
				g = {graphic = convertGraphic(697, "item"), color = 12}

				if player.quest["priest_path"] >= 2 then
					table.insert(questStatus, "Sewer Bandit")
				end

				if player.quest["priest_path"] >= 3 then
					table.insert(questStatus, "Return Finding")
				end

				if player.quest["priest_path"] >= 4 then
					table.insert(questStatus, "Earthworks")
				end

				if player.quest["priest_path"] >= 5 then
					table.insert(questStatus, "War Thog")
				end

				menu = player:menuString("<b>[QUEST STATUS]", questStatus)

				if menu == "Sewer Bandit" then
					player:dialogSeq(
						{
							t,
							name .. "So you think you are ready for Missionry Work?",
							name .. "I think I have just the thing for you.",
							name .. "Some of the locals have noticed rats coming from the sewers.",
							name .. "There is also a rumor that some bandits have moved in to the Deep Sewers.",
							name .. "Last I heard, this group of bandits once tried taking on the War Thog.",
							name ..
								"Go check out the sewers, I only know one of the entrances, it is close to south gate, look behind a stand of trees for an entrance.",
							name .. "Go investigate and report back to me with whatever you find."
						},
						1
					)
				elseif menu == "Return Finding" then
					player:dialogSeq(
						{
							t,
							name ..
								"I ran away with two others, but we got seperated. There were rats everywhere, bigger than any you've ever seen.  I think there are ghosts inside the walls down here. We heard horrible grinding sounds...",
							name ..
								"I saw the rats eating Tommy, but I think Gerald got away. I didn't see it but I heard him scream 'These rats are worse than the snakes!' I just kept running until I was able to hide here.",
							name .. "I don't have any fight left in me. Just take this and leave, please.",
							g,
							"The bandit gives you some new hand items! Press 'i' to see!"
						},
						1
					)
				elseif menu == "Earthworks" then
					player:dialogSeq(
						{
							t,
							name .. "A cave full of snakes? He must have been talking about the Earthworks!",
							name .. "It's a cave located near Hon's South Gate. It was once going to be dug out and built over",
							name ..
								"Then the snakes showed up. Now it's a deserted mudhole. I thought the only person brave enough to go in there anymore was the War Thog.",
							name ..
								"If the bandits have moved in too, they must have made a deal with him. Tread lightly, the War Thog has slain far better priests than you.",
							name ..
								"If you find yourself face to face with War Thog, I suggest you offer him the blessing of ASAK and hope he is feeling merciful.",
							b,
							"The guild leader gives you  piece of equipment! Press 'i' to see!"
						},
						1
					)
				elseif menu == "War Thog" then
					player:dialogSeq(
						{
							t,
							name .. "Hold your tongue, not another word. ASAK this and ASAK that. I won't be having it down here.",
							name .. "Now Trukovich, that's a God to talk about. God of Iron and War. Blood must have blood.",
							name .. "Ahhh, Trukovich, that is it. Maybe when our army is ready to travel, we will settle near Cold Iron.",
							name ..
								"All the strongest warriors of Cold Iron will join my son's kingdom by the time I finish training them. Ahhahhahaahhaa.",
							name ..
								"As for you, 'Priest of ASAK', you have no shield, your head is unprotected. Take these and get out before I sharpen my blade on your bones."
						},
						1
					)
				end
			end
			questLog.click(player, npc)
		elseif menu == "The Drunk's Mug" then
			npc = NPC("Randall")
			name = "<b>[" .. npc.name .. "]\n\n"
			t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}

			player:dialogSeq(
				{t, name .. "Yesh I shore did, I was out partying at t-the little outdoor bar southwest of here..."},
				1
			)

			questLog.click(player, npc)
		elseif menu == "Fox Fur Trader" then
			npc = NPC("Randall")
			name = "<b>[" .. npc.name .. "]\n\n"
			t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}

			player:dialogSeq(
				{
					t,
					name .. "Dirty work. N-need cash for booze, need skins to sell.",
					name ..
						"So go to the Fox Hole by west gate, get me 50 Black Fox Fur, 50 Red Fox Fur, 10 Light Fox Fur, 10 Rainbow Fox Fur, oh, and bring me Kumiho's Tails as well.",
					name .. "You wanna work, thassa work I need done..."
				},
				1
			)
			questLog.click(player, npc)
		elseif menu == "Help Armorer Joe" then
			npc = NPC("Armor Joe")
			name = "<b>[" .. npc.name .. "]\n\n"
			t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}

			player:dialogSeq(
				{
					t,
					name .. "Help? You want to help me out?",
					name .. "That's great! I've been having a crazy day.",
					name ..
						"Customers are coming in nonstop and my assistant quit on me. I heard he ran off with the Innkeeper's daughter.",
					name .. "He was supposed to pick up a bunch of things around town for me today.",
					name .. "If you can do it instead, I'll give you a free sample of my work.",
					name .. "First I need you to pick up my coat from the tailor, she said it was ready today.",
					name .. "Then head over to the weaponsmith. He has a sample of some new metal I want to try forging.",
					name .. "Also make sure you get my lunch from the butcher shop before you come back, I'm starving.",
					name .. "Thanks for being such a nice guy and offering to help me out!"
				},
				1
			)
			questLog.click(player, npc)
		elseif menu == "The Haunted House" then
			npc = NPC("Harvey")
			name = "<b>[" .. npc.name .. "]\n\n"
			t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}

			player:dialogSeq(
				{
					t,
					name .. "You met the War Thog?",
					name .. "And he didn't kill you?",
					name .. "You must be quite formidable. More than you look anyway.",
					name .. "Maybe you can help me. I need some particularly potent ghost juice for the new brew I'm concocting.",
					name .. "There are plenty of ghosts swarming around the old manor to the west of town.",
					name .. "Slay the most powerful ghost you can find and come back here with its essence fresh on your weapon.",
					name ..
						"If you're going into the haunted house, you should pick up some new equipment from the local shops. Here, take these potions too."
				},
				1
			)
			questLog.click(player, npc)
		elseif menu == "Martin's Got Issues" then
			npc = NPC("Martin")
			name = "<b>[" .. npc.name .. "]\n\n"
			t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}

			if player.quest["martin"] >= 1 then
				table.insert(questStatus, "Rats with Wings")
			end

			if player.quest["martin"] >= 2 then
				table.insert(questStatus, "Fishy Business")
			end

			menu = player:menuString("<b>[QUEST STATUS]", questStatus)

			if menu == "Rats with Wings" then
				player:dialogSeq(
					{
						t,
						name .. "Yes, I could use all the help I can get.",
						name .. "Lately there have been bats flying around at night.",
						name .. "At first, I thought it was cool. But now, I do not.",
						name .. "They have been landing on my crates, and pulling from them then flying away.",
						name .. "If someone does not clear out some of those bats, they might get me fired.",
						name .. "I saw some of them flying into a cave just off the shore X:20 Y:59 ",
						name .. "Kill 50 of each bat you find and 1 of the largest bats!"
					},
					1
				)
			elseif menu == "Fishy Business" then
				player:dialogSeq(
					{
						t,
						name .. "Well hot damn. You did it. That should teach those damn bats.",
						name .. "Now that was fast, well here's your reward.",
						name .. "I got another problem if you got some time.",
						name .. "Have you seen the mutated fish? They're terrifying.",
						name .. "No one knows the cause, either.",
						name .. "Some people call it a bad omen, or a curse from the gods.",
						name .. "Me, I think it's black magic, those damn sorcerers, you know?",
						name .. "But seeing all those beasts, armored like tanks, gave me an idea.",
						name .. "I almost have enough scales to finish making it, but I'm getting worn out.",
						name .. "I only need a few more scales. If you bring them to me, I'll give you a nice reward.",
						name .. "Collect 50 Minnow Scales, 50 Bass Scales, and 1 Goldfish Scale!"
					},
					1
				)
				questLog.click(player, npc)
			end
		elseif menu == "Letter to Tonguspur" then
			npc = NPC("Tuleftshu")
			name = "<b>[" .. npc.name .. "]\n\n"
			t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}

			if player.quest["tonguspur_letter"] >= 1 then
				table.insert(questStatus, "First Parcel")
			end

			if player.quest["tonguspur_letter"] >= 2 then
				table.insert(questStatus, "Tonguspur Delivery")
			end

			menu = player:menuString("<b>[QUEST STATUS]", questStatus)

			if menu == "First Parcel" then
				player:dialogSeq(
					{
						t,
						name .. "Most of the time, nothing.",
						name .. "But I really hate these out-of-town deliveries.",
						name .. "Hey, I have an idea.",
						name .. "How about you run this one for me?",
						name .. "I promise it'll be worth your while.",
						name .. "Just take this letter to the carpenter in Tonguspur.",
						name .. "It's a little village in the woods northwest of Hon.",
						name .. "What are you waiting for?",
						name .. "Get going!"
					},
					1
				)
				questLog.click(player, npc)
			elseif menu == "Tonguspur Delivery" then
				player:dialogSeq(
					{
						t,
						name .. "Oh. Thanks for the delivery, but I'm sure it's just more bad news.",
						name .. "Here, take something for your trouble.",
						name .. "Can you tell the carriers to deliver something good sometime!"
					},
					1
				)
				questLog.click(player, npc)
			end
		elseif menu == "Aiding the Front Lines" then
			npc = NPC("Cletus")
			name = "<b>[" .. npc.name .. "]\n\n"
			t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}

			player:dialogSeq(
				{
					t,
					name .. "Your assignment is simple: prove your mettle.",
					name .. "To do that, you're going to enter the Savage Territory and slay a whole hell of a lot of them.",
					name ..
						"Kill at least 50 each of the Savage Spearmaidens, Savage Highwaymen and Savage Stickment, and at least 1 Savage Warchief, then return here."
				},
				1
			)
			questLog.click(player, npc)
		elseif menu == "Aiding the Supply Lines" then
			npc = NPC("Cletus")
			name = "<b>[" .. npc.name .. "]\n\n"
			t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}

			player:dialogSeq(
				{
					t,
					name .. "Your assignment is simple: prove your worth.",
					name ..
						"To do that, you're going to enter the Savage Territory and recover some of the rations they've stolen from our supply lines.",
					name .. "Gather up 25 Ration Boxes, then return here."
				},
				1
			)
			questLog.click(player, npc)
		elseif menu == "Leech Path Treasure" then
			npc = NPC("Hon Hermit")
			name = "<b>[" .. npc.name .. "]\n\n"
			t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}

			if player.quest["leech"] >= 1 then
				table.insert(questStatus, "A Treasure?")
			end

			if player.quest["leech"] >= 2 then
				table.insert(questStatus, "Woot! Treasure!")
			end

			menu = player:menuString("<b>[QUEST STATUS]", questStatus)

			if menu == "A Treasure?" then
				player:dialogSeq(
					{
						t,
						name .. "Work?",
						name .. "No, I don't have any 'work' for you.",
						name .. "But if you're bored, I might have something for you to do.",
						name .. "There's a cave south of Hon that is completely overrun by vicious leeches",
						name .. "I heard a rumor that pirates hid a valuable treasure there long ago.",
						name ..
							"No one has been brave or stupid enough to go searching for it, but you look like just the right combination of the two.",
						name .. "If you manage to find any treasure, how about you come back and pay me a finder's fee?"
					},
					1
				)
				questLog.click(player, npc)
			elseif menu == "Woot! Treasure!" then
				player:dialogSeq({t, name .. "You have found a treasure! You should tell the hermit your adventure!"}, 1)
				questLog.click(player, npc)
			end
		elseif menu == "Prove Your Skills" then
			if player.baseClass == 1 then
				npc = NPC("Jamlamin")
				name = "<b>[" .. npc.name .. "]\n\n"
				t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}

				player:dialogSeq(
					{
						t,
						name .. "Venture into the Leech Cave.",
						name .. "There are entrances near the North Gate and in the Southern Shores of Hon.",
						name .. "Inside, slay the leeches and their lord.",
						name .. "Once the Leech Lord is dead, return to me with 100 Leech Ooze."
					},
					1
				)
			elseif player.baseClass == 2 then
				npc = NPC("Baron Rodrik")
				name = "<b>[" .. npc.name .. "]\n\n"
				t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}

				player:dialogSeq(
					{
						t,
						name .. "Venture into the Leech Cave.",
						name .. "There are entrances near the North Gate and in the Southern Shores of Hon.",
						name .. "Inside, slay the leeches and their lord.",
						name .. "Once the Leech Lord is dead, return to me with 100 Leech Ooze."
					},
					1
				)
			elseif player.baseClass == 3 then
				npc = NPC("Malcor")
				name = "<b>[" .. npc.name .. "]\n\n"
				t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}

				player:dialogSeq(
					{
						t,
						name .. "Venture into the Leech Cave.",
						name .. "There are entrances near the North Gate and in the Southern Shores of Hon.",
						name .. "Inside, slay the leeches and their lord.",
						name .. "Once the Leech Lord is dead, return to me with 100 Leech Ooze."
					},
					1
				)
			elseif player.baseClass == 4 then
				npc = NPC("Bishop Eugene")
				name = "<b>[" .. npc.name .. "]\n\n"
				t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}

				player:dialogSeq(
					{
						t,
						name .. "Venture into the Leech Cave.",
						name .. "There are entrances near the North Gate and in the Southern Shores of Hon.",
						name .. "Inside, slay the leeches and their lord.",
						name .. "Once the Leech Lord is dead, return to me with 100 Leech Ooze."
					},
					1
				)
			end
			questLog.click(player, npc)
		elseif menu == "Defend the Maiden" then
			npc = NPC("Jules")
			name = "<b>[" .. npc.name .. "]\n\n"
			map = "<b>" .. npc.mapTitle .. "\n"
			t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}

			npc2 = NPC("Oracle")
			name2 = "<b>[" .. npc2.name .. "]\n\n"
			t2 = {graphic = convertGraphic(npc2.look, "monster"), color = npc2.lookColor}

			if player.quest["maiden"] >= 1 then
				table.insert(questStatus, "Find the Oracle")
			end

			if player.quest["maiden"] >= 3 then
				table.insert(questStatus, "Maiden's Hair")
			end

			if player.quest["maiden"] >= 4 then
				table.insert(questStatus, "Return to Oracle")
			end

			if player.quest["maiden"] >= 6 then
				table.insert(questStatus, "Get Bat Guano")
			end

			if player.quest["maiden"] >= 7 then
				table.insert(questStatus, "Return with Potion")
			end

			if player.quest["maiden"] >= 8 then
				table.insert(questStatus, "Prepare to Fight Draco")
			end

			if player.quest["maiden"] >= 9 then
				table.insert(questStatus, "Fight Draco")
			end

			menu = player:menuString("<b>[QUEST STATUS]", questStatus)

			if menu == "Find the Oracle" then
				player:dialogSeq(
					{
						t,
						name .. "Draco is a mercenary who abandoned his post as a Hon soldier.",
						name .. "He has forced my father to pay him to live out here for many moons now.",
						name .. "Most recently, on his last extortion visit, he told my father he is taking me as his wife.",
						name .. "I don't know what to do. I do not want to be his wife. I would rather die.",
						name .. "My last trip to Hon, I asked Harvey if he could make me appear as though I was dead.",
						name .. "He tried to make a potion to help me but said that the formula was unstable and exploded.",
						name .. "I don't know what else to do. I need to consult the oracle but I have so much work to do here.",
						name .. "Maybe you can help me?",
						name .. "The Oracle has a shop in Hon by the Sea. Just East from the Northern City Gate.",
						name .. "Just tell him that I could not come myself please.",
						name .. "Then return back here and let me know what I should do!"
					},
					1
				)
				questLog.click(player, npc)
			elseif menu == "Maiden's Hair" then
				player:dialogSeq(
					{
						t2,
						name2 .. "Ahh, Jules, such a pretty little thing. I remember when she was young.",
						name2 .. "Her father used to bring her here every time he came to town.",
						name2 .. "What could I do to help you, help her?",
						name2 .. "I have a brilliant idea. though I will need your help.",
						name2 .. "I can make a syrum that will make any man run for the hills at her sight",
						name2 .. "First, you must go get a lock of her hair while I gather the ingredients.",
						name2 .. "What are you waiting for? Get going, I do have a business to run after all!"
					},
					1
				)
				questLog.click(player, npc)
			elseif menu == "Return to Oracle" then
				player:dialogSeq(
					{
						t,
						name .. "Ohh what a relief! What will it do? What do you need?",
						name .. "A lock of hair? Is that all? Sure, here you go.",
						"**Jules reaches for a knife, quickly slices off a short lock, and hands it to you**",
						name .. "Ohh boy I am so excited right now.",
						name .. "Please, tell me, what will it do? How will it work?"
					},
					1
				)
				questLog.click(player, npc)
			elseif menu == "Get Bat Guano" then
				player:dialogSeq(
					{
						t2,
						name2 .. "Great, now we can get started.",
						"**Oracle deeply inhales through his nose while holding her hair to his face**",
						name2 .. "Yes this will do nicely. Only one problem. I seem to be out of an ingredient.",
						name2 .. "Could I trouble you to go gather some Bat Guano. It is the only thing I am missing to make her syrum!",
						name2 .. " Gather 50 Bat Guano!"
					},
					1
				)
				questLog.click(player, npc)
			elseif menu == "Return with Potion" then
				player:dialogSeq(
					{
						t2,
						name2 .. "Where have you been?",
						name2 .. "Any longer and the syrum will spoil!",
						name2 .. "Let's just hope you did not ruin this by taking your sweet time.",
						"**The Oracle hands you a small bottle of glowing liquid**",
						name2 .. "Hurry! Take this to Jules before it's too late!"
					},
					1
				)
				questLog.click(player, npc)
			elseif menu == "Prepare to Fight Draco" then
				player:dialogSeq(
					{
						t,
						name .. "Ohh no, it is too late. Here he comes. Here, take these. May they protect you from his fury!",
						name .. "Prepare yourself to fight Draco!"
					},
					1
				)
				questLog.click(player, npc)
			elseif menu == "Fight Draco" then
				player:dialogSeq(
					{
						t,
						name .. "Please don't die!",
						name .. "[Quest Updated] Kill Draco to Defend the Maiden."
					},
					1
				)
				questLog.click(player, npc)
			end
		elseif menu == "Kramoris' Stolen Weapons" then
			--	elseif menu == "A Quest to Save Christmas" then
			--		npc = NPC("Ernest") -- Ernest
			--		name = "<b>["..npc.name.."]\n\n"
			--		t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			--
			--		npc2 = NPC("Harmony") -- Harmony
			--		name2 = "<b>["..npc2.name.."]\n\n"
			--		t2 = {graphic = convertGraphic(npc2.look, "monster"), color = npc2.lookColor}
			--
			--		npc3 = NPC("Santa Claus") -- Real Santa
			--		name3 = "<b>["..npc3.name.."]\n\n"
			--		t3 = {graphic = convertGraphic(npc3.look, "monster"), color = npc3.lookColor}
			--
			--		npc4 = NPC("Oliver") -- Oliver
			--		name4 = "<b>["..npc4.name.."]\n\n"
			--		t4 = {graphic = convertGraphic(npc4.look, "monster"), color = npc4.lookColor}
			--
			--		local magicBag ={graphic=convertGraphic(4855,"item"),color=0}
			--
			--		if player.quest["ernest_xmas"] >= 1 then
			--			table.insert(questStatus, "What's your story?")
			--			table.insert(questStatus, "Hello Santa!")
			--		end
			--
			--		if player.quest["ernest_xmas"] >= 2 then
			--			table.insert(questStatus, "Santa is fine!")
			--		end
			--
			--		if player.quest["ernest_xmas"] >= 3 then
			--			table.insert(questStatus, "Where's the Bag?")
			--		end
			--
			--		if player.quest["ernest_xmas"] >= 4 then
			--			table.insert(questStatus, "I have Santa's Bag!")
			--		end
			--
			--		if player.quest["ernest_xmas"] >= 5 then
			--			table.insert(questStatus, "Will You Be Santa?<G>")
			--			table.insert(questStatus, "I want this Bag!<N>")
			--			table.insert(questStatus, "Dread My Return!<E>")
			--		end
			--
			--		if player.quest["ernest_xmas"] >= 6 then
			--			table.insert(questStatus, "Christmas is Saved!")
			--			table.insert(questStatus, "Ran out of Time!")
			--			table.insert(questStatus, "Christmas is Over!")
			--		end
			--
			--		if player.quest["ernest_xmas"] >= 7 then
			--			table.insert(questStatus, "Christmas Will Happen!")
			--			table.insert(questStatus, "Some Might get Mad!")
			--			table.insert(questStatus, "You Failed Christmas!")
			--		end
			--
			--		menu = player:menuString("<b>[QUEST STATUS]", questStatus)
			--
			--		if menu == "What's your story?" then
			--			player:dialogSeq({t, name.."Santa has asked me, Ernest, to help him find a replacement Santa for this years festivities!",
			--							name.."That's right. Santa needs someone new to take over the duties of delivering presents to all the worlds.",
			--							name.."Unfortunately, a person with the right qualifications...\nIs difficult to find.",
			--							name.."But I'll tell you what, It's a smart cookie...\nThat knows when to hang up the old cleats.",
			--							name.."Anyways, I don't know where Santa wandered off to. He was being watched by Harmony.",
			--							name.."They must have gone for a walk or something. Go find Santa and I will start looking for his replacement.",
			--							name.."[Quest Update] Find Santa somewhere in Hon City Map and Buildings!"}, 1)
			--			questLog.click(player, npc)
			--
			--		elseif menu == "Hello Santa!" then
			--			player:dialogSeq({t3, name3.."Well Hello there"..player.name.."You know there was a time when I could remember...\nEvery name on all my lists.",
			--							name3.."All over the worlds...\nI knew where I was going at all time...\nNow I have trouble recalling...\nWho was Naughty and who was Nice.",
			--							magicBag,"Who asked for a toy truck, who wanted a bicycle, what world I am on, What world am I on?",
			--							name3.."I am just gonna stay here and play some Janken with Carter and Perkins.",
			--							name3.."Could you help my Dear Friend Ernest find me a replacement.",
			--							name3.."[Quest Update] Help Ernest Find santa's replacement"}, 1)
			--			questLog.click(player, npc)
			--
			--		elseif menu == "Santa is fine!" then
			--			player:dialogSeq({t, name.."That's great but we have a new problem now...\nSanta's magic sack of toys...\nIt's just feathers.",
			--							magicBag,"The real sack was taken by Harmony. Yea, yea, I know. She walked him off, and while I was talking to you, she replaced it.",
			--							name.."A guard spotted her leaving through the Cities South Gate.",
			--							name.."[Quest Update] Find Harmony. Guards say she left out South Gate Hon!"}, 1)
			--			questLog.click(player, npc)
			--
			--		elseif menu == "Where's the Bag?" then
			--			player:dialogSeq({t2, name2.."The bag? Did Santa send you? It's right here, take it, please.",
			--							magicBag,"I never meant for this all to happen, I swear. I just saw the bag, and I know how much power it has...",
			--							name2.."I thought it would make me happy, but this is truly awful.",
			--							name2.."I didn't realize that it was the power of Christmas keeping all these monsters sealed inside this place.",
			--							magicBag,"If I use up the remaining power in this bag, Christmas is doomed for sure!",
			--							name2.."Hurry back to Santa with the bag, you might still have time!",
			--							name2.."[Quest Update] Got Santa's Magic Sack from Harmony! Return to Ernest!"}, 1)
			--			questLog.click(player, npc)
			--
			--		elseif menu == "I have Santa's Bag!" then
			--			player:dialogSeq({t, name.."This is great I knew you could do it. Nope, never doubted you'd do the right thing.",
			--							name.."Well. Maybe a little bit. I just got to thinking about you and all that magic.",
			--							name.."I mean I did not consider you a prospect for a potential Santa Replacement.",
			--							name.."But let's not delay. I have found someone who would be great for a Replacement Santa.",
			--							name.."On this world, someone has already taken initiative to keep the magic of christmas alive in these dark times.",
			--							name.."His name is Oliver and has been seen handing out presents in the following areas:\nWest Shores of Hon\nHon Harbor\nCity of Hon\nTonguspur Village.",
			--							name.."If you find this guy, please let him know that we need him to become the new Santa",
			--							name.."[Quest Update] Find Oliver in East, Central, and West Hon or Tonguspur Village!"}, 1)
			--			questLog.click(player, npc)
			--
			--		elseif menu == "Will You Be Santa?<G>" then
			--			player:dialogSeq({t4, name4.."Well you don't hold back at all now do you. Where is this all coming from?",
			--							magicBag,"***The Man listens to your tale about Santa needing a replacement.***",
			--							name4.."How could I turn away from you when you look at me like that.",
			--							name4.."You can tell Santa, and your pal Ernest, that I will Accept.",
			--							name4.."I will meet them at the Game Room after I make my last deliveries around here.",
			--							name4.."[Quest Completed] Convinced Oliver to become the Official Santa"}, 1)
			--			questLog.click(player, npc)
			--
			--		elseif menu == "I want this Bag!<N>" then
			--			player:dialogSeq({t4, name4.."I can sense Magic coming from that bag. What is it for?",
			--							name4.."***The Man listens to your tale about Santa not having the strength to continue delivering.***",
			--							name4.."That is a very sad tale. I get a great deal of satifaction spending all year creating new things.",
			--							name4.."I have dedicated my life to it, but if you want to take his place, then you should.",
			--							magicBag,"I wish you luck in your Journey. Until we meet again.",
			--							name4.."[Quest Completed] Convinced Oliver to let you become the Official Santa"}, 1)
			--			questLog.click(player, npc)
			--
			--		elseif menu == "Dread My Return!<E>" then
			--			player:dialogSeq({t4, name4.."You again. Tell me, why have you returned?",
			--							name4.."***The Man listens to a tale of how Santa is quitting and the danger is not worth the effort.***",
			--							name4.."***The Man continues listening about how there are worlds with beasts that Santa must fight every year to deliver presents.***",
			--							name4.."WOW, I can not believe someone could so such things alone. I could never do that, ever.",
			--							name4.."I am sorry, but I can not become Santa. You must tell them for me.",
			--							name4.."[Quest Completed] Convinced Oliver not to become the Official Santa"}, 1)
			--			questLog.click(player, npc)
			--
			--		elseif menu == "Christmas is Saved!" then
			--			player:dialogSeq({t3, name3.."Well, it's all settled then.",
			--							name3.."Thank you for all of your help! You have done a tremendous service to all that is righteous in this dark world.",
			--							magicBag,"With the Christmas Magic strengthened through the passing to a new Santa, my mind is clear. I'll be able to enjoy my final years in a quiet retirement.",
			--							name3.."After living these past 128 years as 'Santa Claus', it will be nice to just be 'Seth' again for a while.",
			--							name3.."Have a very merry Christmas, "..player.name..", this Christmas and for all the Christmases to come.",
			--							name3.."[Quest Completed] Santa gives you a person present for your assistance."}, 1)
			--			questLog.click(player, npc)
			--
			--		elseif menu == "Ran out of Time!" then
			--			player:dialogSeq({t3, name3.."Out of time?",
			--							name3.."This is all a game to you, isn't it?",
			--							name3.."Well, I had wanted this to be my last year.",
			--							name3.."It is getting so difficult to move around in dangerous places lately.",
			--							magicBag,"Did you think that was my only bag? I am old, decrepit, senile, and dying, but I am NOT a fool.",
			--							name3.."Enjoy your trinket, little one.",
			--							name3.."I shall see you next year.",
			--							name3.."Which list are you planning to be on?",
			--							name3.."[Quest Completed] You're selfish but you got a shiny new item for it."}, 1)
			--			questLog.click(player, npc)
			--
			--		elseif menu == "Christmas is Over!" then
			--			player:dialogSeq({t3, name3.."You dare tell ME that Christmas is over?",
			--							name3.."You could kill me where I stand here today, and Christmas would not be over."
			--							name3.."As long as the tiniest fragment of a Christmas spirit still lives on in this world, it will grow.",
			--							magicBag,"It is YOUR efforts that are in vain, fool, not mine.",
			--							name3.."Christmas will live on. Do try to put up a better fight next year, eh?",
			--							name3.."[Quest Completed] You are conniving but Christmas was not Destroyed."}, 1)
			--			questLog.click(player, npc)
			--
			--		elseif menu == "Christmas Will Happen!" then
			--			player:dialogSeq({t, name.."This is Wonderful news. Ohh you are the best "..player.name..". I knew I could count on you.",
			--							name.."I knew it, What's this? I can also go for the ride on Christmas Night?",
			--							name.."I am probably the best man for the job. After all, I am Ernest P. Worrell, Thrill Driver!",
			--							name.."Do you think we could use an honorary elf. Maybe Harmony will come with us.",
			--							name.."[Quest Completed] Saved Christmas which will spread Joy to all the Worlds!"}, 1)
			--			questLog.click(player, npc)
			--
			--		elseif menu == "Some Might get Mad!" then
			--			player:dialogSeq({t, name.."Well this just wont do. There must be somethign we can do.",
			--							name.."I put my trust in you "..player.name..". You really let me down.",
			--							name.."I guess it is time for me to roll up the old sleeves and get it done like always.",
			--							name.."I will save Christmas Future or my name is not Ernest P. Worrell!",
			--							name.."[Quest Completed] Got a shiny item and caused Oliver not to get Promoted to Santa yet."}, 1)
			--			questLog.click(player, npc)
			--
			--		elseif menu == "You Failed Christmas!" then
			--			player:dialogSeq({t, name.."If I ruined Christmas it was only for putting my faith in you, "..player.name..". Such a failure.",
			--							name.."Me on the other hand. I just dive right into the deep end, you know what I mean?",
			--							name.."No shortcuts here. I'll find a way to fix this or my name is not Ernest P. Worrell!",
			--							name.."[Quest Completed] Thwarted Ernest's plans to Save Christmas for now!"}, 1)
			--			questLog.click(player, npc)
			--		end
			npc = NPC("Kramoris")
			name = "<b>[" .. npc.name .. "]\n\n"
			map = "<b>" .. npc.mapTitle .. "\n"
			t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}

			player:dialogSeq(
				{
					t,
					name .. "I'm in the shipping business.",
					name .. "My cargo this month was a huge shipment of weapons, mostly swords, bound for the Hon Militia.",
					name .. "I, uh, agreed to ship more than my caravan could carry.",
					name .. "I hid the extra crates in the woods, but when I came back for them, I saw them being stolen!",
					name .. "Those grave robbers took every last crate back to the Disturbed Tomb.",
					name .. "Normally I'd go in myself and give them hell, but my mother has fallen ill, so I'm staying here with her.",
					name .. "If you could go kick those guys asses and bring my weapons back, I would owe you a big favor.",
					name .. "There were at least a hundred of them, plus two high-quality Masterworks!"
				},
				1
			)
			questLog.click(player, npc)
		elseif menu == "Spidersilk for Agnes" then
			npc = NPC("Agnes")
			name = "<b>[" .. npc.name .. "]\n\n"
			t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}

			player:dialogSeq(
				{
					t,
					name .. "Oh, you're going to go get me some silk?",
					name .. "That Spider Den is sooo scary...",
					name .. "But I'm sure you'll be fine!",
					name .. "I need about 250 pieces of Spider Silk. That should be enough to finish my dress."
				},
				1
			)
			questLog.click(player, npc)
		elseif menu == "An Unsavory Request" then
			npc = NPC("Edbard")
			name = "<b>[" .. npc.name .. "]\n\n"
			t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}

			npc2 = NPC("Buddy")
			name2 = "<b>[" .. npc2.name .. "]\n\n"
			t2 = {graphic = convertGraphic(npc2.look, "monster"), color = npc2.lookColor}

			if player.quest["spider"] == 1 then
				table.insert(questStatus, "Shady Venom Blackmarket")
			end

			if player.quest["spider"] >= 1 then
				table.insert(questStatus, "Out an Assassin")
			end

			menu = player:menuString("<b>[QUEST STATUS]", questStatus)

			if menu == "Shady Venom Blackmarket" then
				player:dialogSeq(
					{
						t,
						name .. "The man gives you a hard stare up and down, then looks you in the eye.",
						name .. "Yeah, now that you mention it, maybe you can help me out.",
						name .. "I came to this forest looking for spider venom.",
						name .. "It's very important for... something I'm working on.",
						name .. "I tried getting it myself, but those spiders were a lot bigger than I expected.",
						name .. "You look pretty tough, I don't think you'd have any trouble getting some venom.",
						"Edbard suddenly looks off to his side",
						name .. "Wait.",
						name .. "What was that?",
						name .. "Did you hear that?",
						name .. "Get out of here before they see me!",
						name .. "Don't come back until you have that venom sac!"
					},
					1
				)

				questLog.click(player, npc)
			elseif menu == "Out an Assassin" then
				player:dialogSeq(
					{
						t2,
						name2 .. "Spider venom?",
						name2 .. "There's been a string of murders around here lately.",
						name2 .. "The victims were all poisoned with spider venom.",
						name2 .. "If you know who might be behind it, you have to tell me!",
						name2 .. "I can't just act on aany tip. Maybe if I saw the venom sac for myself.."
					},
					1
				)

				questLog.click(player, npc)
			end
		elseif menu == "Something Lost" then
			npc = NPC("Randall")

			name = "<b>[" .. npc.name .. "]\n\n"
			bookName = "<b>[The Necromon, Volume III]\n\n"

			g = {graphic = convertGraphic(2080, "item"), color = 6}
			t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}

			if player.quest["lost_something"] >= 1 then
				table.insert(questStatus, "Something Lost")
			end

			if player.quest["lost_something"] >= 2 then
				table.insert(questStatus, "The Necromon")
			end

			if player.quest["lost_something"] >= 3 then
				table.insert(questStatus, "Finish the Delivery")
			end

			menu = player:menuString("<b>[QUEST STATUS]", questStatus)

			if menu == "Something Lost" then
				player:dialogSeq({t, name .. "Yesh I losht it, and now he'sh gonna kill mee..."}, 1)
			elseif menu == "The Necromon" then
				player:dialogSeq(
					{g, bookName .. "I found this strange book while exploring the Wolf Den.\n\nCould this be what Randall has lost?"},
					1
				)
			elseif menu == "Finish the Delivery" then
				player:dialogSeq(
					{
						t,
						name ..
							"Yesh! Nechromong! Thasst the thing I lost! That was the naem, allryte.\n\nNowif I could o-(hic)-nly premember who wanted that tihng."
					},
					1
				)
			end
		elseif menu == "Tonguspur Feasts" then
			npc = NPC("Chef Boyard")
			name = "<b>[" .. npc.name .. "]\n\n"
			t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}

			if player.quest["chef"] >= 1 then
				table.insert(questStatus, "Seafood Delight")
			end

			if player.quest["chef"] >= 3 then
				table.insert(questStatus, "Frog Leg Platters")
			end

			if player.quest["chef"] >= 5 then
				table.insert(questStatus, "Living Trees!")
			end

			menu = player:menuString("<b>[QUEST STATUS]", questStatus)

			if menu == "Seafood Delight" then
				player:dialogSeq(
					{
						t,
						name .. "You want to help me make something delicious?",
						name .. "My menu this week is seafood delight, but my suppliers aren't able to bring in the quantities I need.",
						name ..
							"If you could bring me another 100 Lobster Claws and 100 Jellyfish Tentacles, I'd be in much better shape.",
						name .. "You can find the Lobsters and Jellyfish on Tonguspur Beach, west of here."
					},
					1
				)

				questLog.click(player, npc)
			elseif menu == "Frog Leg Platters" then
				player:dialogSeq(
					{
						t,
						name .. "Oh boy, you did it! You actually hunted monsters on Tonguspur Beach?!",
						name .. "You must be really strong.",
						name .. "For doing me such a big favor, I'll pay you way more than market price on these tentacles and claws.",
						name .. "I'd be happy to buy as many extras as you have for the standard price as well.",
						name .. "You certainly proved to be strong and reliable, so I'll let you do me another favor if you like.",
						name .. "I've always wanted to try cooking the frogs that live in Frog Swamp.",
						name .. "But no one has ever been able to bring them back to me while they're fresh enough to eat.",
						name .. "If you're feeling tough, go to the Frog Swamp and bring me back some Frog Legs.",
						name .. "If I'm going to make enough for everyone in town, 300 Frog Legs should be enough."
					},
					1
				)

				questLog.click(player, npc)
			elseif menu == "Living Trees!" then
				player:dialogSeq(
					{
						t,
						name .. "Hot damn, a whole pile of Frog Legs!",
						name .. "And fresh too! I can't thank you enough. Here's some money for your trouble.",
						name .. "Oh, and if you happen to go frog hunting again, I'll buy as many Frog Legs as you can carry.",
						name .. "I could never have done it without your help, either.",
						name .. "But there's a new culinary craze that I have to try in my kitchen!",
						name .. "Everyone is going wild for this Living Root Stew.",
						name .. "But to make it I need to get some Living Roots.",
						name .. "The roots can be harvested from Disturbed Trees in the swamp.",
						name .. "One root doesn't go very far, so I'll need about 10 to get a good stew going",
						name .. "Bring them to me as soon as you can! I'll start preparing my other ingredients."
					},
					1
				)

				questLog.click(player, npc)
			end
		elseif menu == "Jerry Got Shipwrecked" then
			npc = NPC("Jerry")
			name = "<b>[" .. npc.name .. "]\n\n"
			t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}

			if player.quest["crates"] >= 1 then
				table.insert(questStatus, "Lost Cargo")
			end

			if player.quest["crates"] >= 3 then
				table.insert(questStatus, "Shell Fragments")
			end

			menu = player:menuString("<b>[QUEST STATUS]", questStatus)

			if menu == "Lost Cargo" then
				player:dialogSeq(
					{
						t,
						name .. "You're gonna help? Awesome! My shipping crates are scattered all across the shoreline west of here.",
						name ..
							"They're waterlogged and rotting away by now, so just smash the crates open and bring back the supply boxes that are inside.",
						name .. "If you bring back 50 of my supply boxes, I'll be able to recover some of my losses."
					},
					1
				)

				questLog.click(player, npc)
			elseif menu == "Shell Fragments" then
				player:dialogSeq(
					{
						t,
						name .. "You got my supplies! I hope those critters on the beach didn't give you too much trouble.",
						name .. "When I tried to go get the supplies myself, I almost lost a leg to one of those lobsters.",
						name .. "I know there are more supplies out there, though.",
						name .. "If you bring back any more of my supplies I'll be happy to pay you for them.",
						name .. "I'm still saving up to buy a new boat, thanks for all your help.",
						name .. "I do have another request, if you have time.",
						name .. "My friend taught me how to make something cool. I just need a few more things to finish it.",
						name .. "I need some Snail Shell Fragments. About 5 of them should do it."
					},
					1
				)

				questLog.click(player, npc)
			end
		elseif menu == "Gator Scale Gathering" then
			npc = NPC("Jerry")
			name = "<b>[" .. npc.name .. "]\n\n"
			t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}

			player:dialogSeq(
				{
					t,
					name .. "Yes, I would love some help.",
					name .. "I'm working on another project, and boy, am I having trouble.",
					name .. "Banon taught me another secret, so I'm trying to find the materials I need.",
					name .. "The recipe calls for Gator Scales though, and those suckers are tough.",
					name ..
						"I need two kinds, too. I almost have enough already, but it'd be a big help if you can go get me another 20 Swamp Gator Scale and 20 Blackstrike Gator Scale."
				},
				1
			)

			questLog.click(player, npc)
		end
	end,
	-----------------------------------------------------------------------------------------------------------------

	completed = function(player)
		player.dialogType = 0
		local level = player.level
		local vita = player.baseHealth
		local mana = player.BaseMagic
		local completedQuests = {}

		local path = ""

		if player.baseClass == 1 then
			path = "fighter"
		elseif player.baseClass == 2 then
			path = "scoundrel"
		elseif player.baseClass == 3 then
			path = "wizard"
		elseif player.baseClass == 4 then
			path = "priest"
		end

		if player.quest["dre_loc_rambles"] == 9 then
			table.insert(completedQuests, "Getting Started")
		end

		if player.quest[path .. "_path"] == 6 then
			table.insert(completedQuests, "Your First Job")
		end

		if player.quest["drunk_mug"] == 2 then
			table.insert(completedQuests, "The Drunk's Mug")
		end

		if player.quest["fox_fur"] == 2 then
			table.insert(completedQuests, "Fox Fur Trader")
		end

		if player.quest["help_joe"] == 2 then
			table.insert(completedQuests, "Help Armorer Joe")
		end

		if player.quest["haunted_house"] == 3 then
			table.insert(completedQuests, "The Haunted House")
		end

		if player.quest["martin"] == 4 then
			table.insert(completedQuests, "Martin's Got Issues")
		end

		if player.quest["tonguspur_letter"] == 3 then
			table.insert(completedQuests, "Letter to Tonguspur")
		end

		if player.quest["front_lines"] == 2 then
			table.insert(completedQuests, "Aiding the Front Lines")
		end

		if player.quest["supply_lines"] == 2 then
			table.insert(completedQuests, "Aiding the Supply Lines")
		end

		if player.quest["leech"] == 3 then
			table.insert(completedQuests, "Leech Path Treasure")
		end

		if player.quest["leech_lord"] == 2 then
			table.insert(completedQuests, "Prove Your Skills")
		end

		if player.quest["maiden"] == 10 then
			table.insert(completedQuests, "Defend the Maiden")
		end

		if player.quest["caravan"] >= 2 then
			table.insert(completedQuests, "Kramoris' Stolen Weapons")
		end

		if player:hasLegend("xmasgood2016") or player:hasLegend("xmasneutral2016") or player:hasLegend("xmasevil2016") then
			table.insert(completedQuests, "A Quest to Save Christmas!")
		end

		if player.quest["spidersilk"] == 2 then
			table.insert(completedQuests, "Spidersilk for Agnes")
		end

		if player.quest["spider"] == 2 then
			table.insert(completedQuests, "An Unsavory Request")
		end

		if player.quest["lost_something"] == 4 then
			table.insert(completedQuests, "Something Lost")
		end

		if player.quest["chef"] == 6 then
			table.insert(completedQuests, "Tonguspur Feasts")
		end

		if player.quest["crates"] == 4 then
			table.insert(completedQuests, "Jerry Got Shipwrecked")
		end

		if player.quest["gator_scales"] == 2 then
			table.insert(completedQuests, "Gator Scale Gathering")
		end

		menu = player:menuString("<b>[COMPLETED QUESTS]", completedQuests)

		if menu == "Getting Started" then
		elseif menu == "Your First Job" then
			questLog.click(player, npc)
		elseif menu == "The Drunk's Mug" then
			questLog.click(player, npc)
		elseif menu == "Fox Fur Trader" then
			questLog.click(player, npc)
		elseif menu == "Help Armorer Joe" then
			questLog.click(player, npc)
		elseif menu == "The Haunted House" then
			questLog.click(player, npc)
		elseif menu == "Martin's Got Issues" then
			questLog.click(player, npc)
		elseif menu == "Letter to Tonguspur" then
			questLog.click(player, npc)
		elseif menu == "Aiding the Front Lines" then
			questLog.click(player, npc)
		elseif menu == "Aiding the Supply Lines" then
			questLog.click(player, npc)
		elseif menu == "Leech Path Treasure" then
			questLog.click(player, npc)
		elseif menu == "Prove Your Skills" then
			questLog.click(player, npc)
		elseif menu == "Defend the Maiden" then
			questLog.click(player, npc)
		elseif menu == "Kramoris' Stolen Weapons" then
			questLog.click(player, npc)
		elseif menu == "A Quest to Save Christmas!" then
			questLog.click(player, npc)
		elseif menu == "Spidersilk for Agnes" then
			questLog.click(player, npc)
		elseif menu == "An Unsavory Request" then
			questLog.click(player, npc)
		elseif menu == "Tonguspur Feasts" then
			questLog.click(player, npc)
		elseif menu == "Jerry Got Shipwrecked" then
			questLog.click(player, npc)
		elseif menu == "Gator Scale Gathering" then
			questLog.click(player, npc)
		end
	end
}
