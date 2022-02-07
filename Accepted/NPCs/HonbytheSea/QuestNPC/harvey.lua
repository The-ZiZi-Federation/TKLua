-- Hon by the Sea (Harvey)
harvey = {
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
			local itemsForSale = {3300, 3301, 3302, 3303, 3304, 3305, 3306, 3310, 3311, 3312, 3313, 3314, 3315, 3316}
			local itemsIBuy = {
				388,
				389,
				390,
				396,
				397,
				398,
				399,
				400,
				401,
				402,
				403,
				450,
				3300,
				3301,
				3302,
				3303,
				3304,
				3305,
				3306,
				3310,
				3311,
				3312,
				3313,
				3314,
				3315,
				3316
			}

			table.insert(opts, "Buy")
			table.insert(opts, "Sell")
			table.insert(opts, "What do you do here?")
			if player.quest["dre_loc_rambles"] == 8 and player.quest["tutorial_serum"] == 0 then
				table.insert(opts, "Dre Loc's Serum")
			end
			if player:hasLegend("war_thog") and player.quest["haunted_house"] == 0 and player.level >= 20 then
				table.insert(opts, "**Tell your story**")
			end
			if player.quest["haunted_house"] == 1 then
				table.insert(opts, "I fought a ghost")
			end
			if player.quest["haunted_house"] == 2 then
				table.insert(opts, "How's the brew?")
			end
			if player.quest["haunted_house"] == 3 then
				table.insert(opts, "Any more work?")
			end
			if player.quest["angry_guard"] >= 6 and player.quest["angry_guard"] <= 9 then
				table.insert(opts, "Weird ingredients")
			end
			if player.quest["wizard_favor"] == 1 and player.quest["pickup_package_harvey"] == 0 then
				table.insert(opts, "Pick up package")
			end
			if player:hasItem("strange_powder", 1) == true and player.quest["gave_strange_powder"] == 0 then
				table.insert(opts, "Do you know what this strange powder is?")
			end

			table.insert(opts2, "Gorgon's Eye")
			table.insert(opts2, "Behemoth's Brain")
			table.insert(opts2, "Charred Living Bark")
			table.insert(opts2, "Dragon Saliva")
			table.insert(opts2, "Boar Tail")
			table.insert(opts2, "Giant Boar Carcass")
			table.insert(opts2, "Gamagrass")

			menu = player:menuString(name .. "I'm trying to conduct my experiments! Why are you here?", opts)

			if menu == "Buy" then
				player:buyExtend(name .. "What can I sell you today?", itemsForSale)
			elseif menu == "Sell" then
				player:sellExtend(name .. "What do you wish to sell?", itemsIBuy)
			elseif menu == "What do you do here?" then
				player:dialogSeq({t, name .. "I live a solitary life of research and only a ...minimum... of explosions."}, 1)
			elseif menu == "Dre Loc's Serum" then
				player.quest["tutorial_serum"] = 1
				giveXP(player, 1500)
				player:calcStat()
				player:sendStatus()
				finishedQuest(player)
				player:dialogSeq(
					{
						t,
						name .. "Dre Loc's Serum? Yeah, I have it right here.",
						name .. "Let me guess, he's sending you after some honey?",
						name .. "Oh, he didn't even tell you?",
						name ..
							"That cave behind his temple is where he keeps his beehives, so he can always have fresh honey for his tea.",
						name .. "Did he tell you he put up a barrier to keep the creatures inside?",
						name .. "Well, that's sort of true. He put it up so the bees wouldn't escape.",
						name .. "Dre Loc likes his honey local, you see.",
						name .. "Either way, here's the serum. I actually took the opportunity to do some research on it..",
						name .. "I've made a few... improvements to the formula.",
						name .. "I can't wait to see if it works!",
						serum,
						"Harvey hands you the Serum, and you quickly choke it down and almost vomit.",
						"Whatever improvements he has made, flavor is certainly not one of them.",
						t,
						name ..
							"Go ahead and grab 10 jars of honey if you can. That way he won't make me go down there again anytime soon..."
					},
					1
				)
				player:msg(4, "[Quest Update] Enter Dre Loc's Honeycomb!", player.ID)
			elseif menu == "**Tell your story**" and player.quest["haunted_house"] == 0 then
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
				player:addItem("minor_vita_potion", 2)
				player:addItem("minor_mana_potion", 2)
				player.quest["haunted_house"] = 1
				player:flushKills(1034)
				player:flushKills(1094)
				player:flushKills(1134)
			elseif menu == "I fought a ghost" then
				if (player:killCount(1034) >= 1) or (player:killCount(1094) >= 1) or (player:killCount(1134) >= 1) then
					player:dialogSeq(
						{
							t,
							name .. "Wow, you killed Mentok? I was expecting maybe a faceless ghost at best. You're a badass!",
							name .. "I can do some real incredible science with this ghost essence, it's going to be awesome.",
							name .. "Come back later and I'll show you."
						},
						1
					)
					player.quest["haunted_house"] = 2
				else
					player:dialogSeq({t, name .. "What are you waiting for? Haunted House is out the west gate!"}, 1)
				end
			elseif menu == "How's the brew?" then
				player:dialogSeq(
					{
						t,
						name .. "Great work on defeating Mentok.",
						name .. "Have you been upgrading your gear as you level up?",
						name .. "Head to the shops and buy new gear once in a while, or you might find yourself in trouble!",
						name .. "The brew you assisted with is bubbling nicely.",
						name .. "I'm ready to begin adding the final ingredient now",
						name .. "It's going to be amazing, just watch!"
					},
					1
				)
				giveXP(player, 20000)
				player:addGold(7500)
				finishedQuest(player)
				player:addItem("minor_vita_potion", 1)
				player:addItem("minor_mana_potion", 1)
				player:calcStat()
				player:sendStatus()
				player:addLegend("Vanquished Mentok " .. curT(), "mentok", 1, 16)
				player:msg(4, "[Quest Completed] A Legend Mark is obtained. Keep it up!", player.ID)
				player:sendAnimationXY(188, 12, 5)
				player.quest["haunted_house"] = 3
			elseif menu == "Any more work?" then
				player:dialogSeq(
					{
						t,
						name ..
							"I don't have any work but my friend Martin, who works in the Harbor Storage, is having a problem. Go east to the harbor he will be in a shack out there."
					},
					1
				)
			elseif menu == "Weird ingredients" then
				if player.quest["angry_guard"] == 6 then
					player.quest["angry_guard"] = 7
				end

				ask = player:menuString(name .. "Weird ingredients? What kind of things are you looking for?", opts2)

				if ask == "Gorgon's Eye" then
					player:dialogSeq(
						{
							t,
							name .. "A Gorgon's Eye? That sounds dangerous.",
							name .. "If you're brave though, I have heard a legend of a Gorgon living in the Ruins of Bettay."
						},
						1
					)
				elseif ask == "Behemoth's Brain" then
					player:dialogSeq(
						{
							t,
							name ..
								"Oh, that one's easy. Everyone knows that a Behemoth took up residence in the Ruins of Bettay a few months ago. Good luck trying to fight it, though."
						},
						1
					)
				elseif ask == "Charred Living Bark" then
					player:dialogSeq(
						{
							t,
							name ..
								"Well, there are some walking trees in the Swamp, but they're too covered in muck and sap, the bark on those won't char.",
							name .. "You'll have to find some living trees somewhere a little dryer. Someplace indoors and high-up maybe."
						},
						1
					)
				elseif ask == "Dragon Saliva" then
					player:dialogSeq(
						{
							t,
							name .. "A dragon? The only dragon anyone around here has ever heard of is old Blackstrike.",
							name .. "He lives in a tower in the Swamp, but no one knows how to get inside.",
							name .. "Well, Delta might.",
							name .. "But no one else."
						},
						1
					)
				elseif ask == "Boar Tail" then
					player:dialogSeq(
						{t, name .. "Boars roam the northern roads from time to time, eating the grasses that grow there."},
						1
					)
				elseif ask == "Giant Boar Carcass" then
					player:dialogSeq(
						{t, name .. "You can probably find a giant boar in the same place as any other boar, they're just rare."},
						1
					)
				elseif ask == "Gamagrass" then
					player:dialogSeq(
						{
							t,
							name .. "Gamagrass grows along the northern roads leading to Cathay.",
							name .. "Careful though, the boars love it.",
							name .. "They might attack if they think you're taking their food."
						},
						1
					)
				end
			elseif menu == "Pick up package" then
				player.quest["pickup_package_harvey"] = 1
				player:addItem("unstable_explosives", 1)
				player:dialogSeq(
					{
						t,
						name .. "Here you go, be careful. Like, seriously, no joke, BE CAREFUL.",
						name .. "Seriously."
					},
					1
				)
			elseif menu == "Do you know what this strange powder is?" then
				player:dialogSeq(
					{
						t,
						name .. "Oh! This is certainly something.",
						name .. "You didn't touch it with your bare hands, did you?",
						name .. "This powder is the primary ingredient of a very dangerous Love Potion.",
						name .. "If I had a sample, I could reverse-engineer it and create a cure."
					},
					1
				)
				confirm = player:menuString("Will you sell me the strange powder sample?", {"Yes", "No"})
				if confirm == "Yes" then
					if player:hasItem("strange_powder", 1) == true then
						if player:removeItem("strange_powder", 1) == true then
							karma.good(player)
							player.quest["gave_strange_powder"] = 1
							player:addGold(100000)
							player:sendMinitext("You feel warm and fuzzy inside.")
							player:msg(4, "You feel good about the decisions you've been making.", player.ID)
							player:dialogSeq(
								{
									t,
									name .. "Great! Who knows what would happen if this had been found by someone with less scruples...",
									name .. "I'll let you know if I make any progress on the cure.",
									name .. "Thanks again!"
								},
								1
							)
						else
							player:dialogSeq({t, name .. "What are you trying to pull? Pick it back up!"}, 1)
						end
					else
						player:dialogSeq({t, name .. "What are you trying to pull? Bring it back!"}, 1)
					end
				end
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
	end,
	nearbyPlayers = function(npc)
		local pc = npc:getObjectsInArea(BL_PC)
		local m, x, y = npc.m, npc.x, npc.y

		if #pc > 0 then
			for i = 1, #pc do
				if pc[i]:hasLegend("war_thog") and pc[i].quest["haunted_house"] == 0 and pc[i].level >= 20 then
					pc[i]:selfAnimationXY(pc[i].ID, 248, x, y)
				end
			end
		end
	end,
	say = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local s = string.lower(player.speech)

			if string.find(s, "(.*)explosive(.*)") or string.find(s, "(.*)charge(.*)") then
				if player.quest["randoms_quest"] == 2 then
					player:dialogSeq(
						{
							t,
							name .. "Well, I probably shouldn't be just handing out charges.",
							name .. "But... *grins*",
							name .. "I like making things go boom.",
							name .. "Take it, friend."
						},
						1
					)
					player.quest["randoms_quest"] = 3
				end
			end
		end
	)
}
