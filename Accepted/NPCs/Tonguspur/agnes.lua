tonguspur_seamstress = {
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

			if player.quest["spidersilk"] == 0 then
				table.insert(opts, "Silk?")
			end
			if player.quest["spidersilk"] == 1 then
				table.insert(opts, "Yep, got it!")
			end
			if player.quest["spidersilk"] == 1 then
				table.insert(opts, "No, not yet.")
			end
			if player.quest["spidersilk"] == 2 then
				table.insert(opts, "How are you, Agnes?")
			end

			if player.quest["spidersilk"] == 0 and player.level <= 59 then
				menu = player:menuString(name .. "Hello! I'm Agnes, welcome to my shop.", opts)
			end
			if player.quest["spidersilk"] == 0 and player.level >= 60 then
				menu =
					player:menuString(
					name .. "How awful! I'm trying to make a new dress, but this fabric is trash. What I need is silk.",
					opts
				)
			end
			if player.quest["spidersilk"] == 1 then
				menu = player:menuString(name .. "Back already? Do you have the silk?", opts)
			end
			if player.quest["spidersilk"] == 2 then
				menu = player:menuString(name .. "Oh, it's you! I missed you!", opts)
			end

			if menu == "Silk?" then
				if player.level >= 60 then
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
					player.quest["spidersilk"] = 1
					player:msg(4, "[Quest Updated] Go get 250 Spider Silk for Agnes!", player.ID)
				else
					player:dialogSeq(
						{t, name .. "It's made by the spiders in the Spider Den, but I think you'd die in there, you look weak."},
						1
					)
				end
			elseif menu == "Yep, got it!" then
				if player:hasItem("spider_silk", 250) == true then
					if player:removeItem("spider_silk", 250) == true then
						player:addItem("spider_silk_cape", 1)
						giveXP(player, 1000000)
						player:addGold(50000)
						finishedQuest(player)
						player:calcStat()
						player:sendStatus()
						player.quest["spidersilk"] = 2
						player:msg(4, "[Quest Complete] Agnes gave you a Spider Silk Cape!", player.ID)
						player:dialogSeq(
							{
								t,
								name .. "You did it!",
								name .. "You really did it!",
								name .. "I have to admit something...",
								name .. "You weren't the only person who offered to get me some spider silk",
								name .. "I'm actually pretty popular!",
								name .. "I ended up with way more silk than I needed, so I made something for you with the extra silk.",
								name .. "It's a Spider Silk Cape! Enjoy, you deserve it!"
							},
							1
						)
					else
						player:dialogSeq({t, name .. "I thought you said you were bringing me some silk?"}, 1)
					end
				else
					player:dialogSeq({t, name .. "I thought you said you were bringing me some silk?"}, 1)
				end
			elseif menu == "How are you, Agnes?" then
				player:dialogSeq({t, name .. "I'm doing great!"}, 1)
			elseif menu == "Buy" then
				finery_shop.buy(player)
			elseif menu == "Sell" then
				finery_shop.sell(player)
			end
		end
	),
	say = function(player, npc)
		local speech = string.lower(player.speech)
		local item
		local number

		if
			string.sub(speech, 1, 6) == "i buy " and string.sub(speech, 7, 24) == "beginner tunic (m)" or
				string.sub(speech, 7, 24) == "beginner tunic (f)" or
				string.sub(speech, 7, 27) == "beginner leathers (m)" or
				string.sub(speech, 7, 27) == "beginner leathers (f)" or
				string.sub(speech, 7, 23) == "trainee tunic (m)" or
				string.sub(speech, 7, 23) == "trainee tunic (f)" or
				string.sub(speech, 7, 26) == "trainee leathers (m)" or
				string.sub(speech, 7, 26) == "trainee leathers (f)" or
				string.sub(speech, 7, 22) == "novice tunic (m)" or
				string.sub(speech, 7, 22) == "novice tunic (f)" or
				string.sub(speech, 7, 25) == "novice leathers (m)" or
				string.sub(speech, 7, 25) == "novice leathers (f)" or
				string.sub(speech, 7, 24) == "initiate tunic (m)" or
				string.sub(speech, 7, 24) == "initiate tunic (f)" or
				string.sub(speech, 7, 27) == "initiate leathers (m)" or
				string.sub(speech, 7, 27) == "initiate leathers (f)" or
				string.sub(speech, 7, 26) == "apprentice tunic (m)" or
				string.sub(speech, 7, 26) == "apprentice tunic (f)" or
				string.sub(speech, 7, 29) == "apprentice leathers (m)" or
				string.sub(speech, 7, 29) == "apprentice leathers (f)" or
				string.sub(speech, 7, 26) == "journeyman tunic (m)" or
				string.sub(speech, 7, 26) == "journeyman tunic (f)" or
				string.sub(speech, 7, 29) == "journeyman leathers (m)" or
				string.sub(speech, 7, 29) == "journeyman leathers (f)" or
				string.sub(speech, 7, 26) == "adventurer tunic (m)" or
				string.sub(speech, 7, 26) == "adventurer tunic (f)" or
				string.sub(speech, 7, 29) == "adventurer leathers (m)" or
				string.sub(speech, 7, 29) == "adventurer leathers (f)" or
				string.sub(speech, 7, 20) == "hero tunic (m)" or
				string.sub(speech, 7, 20) == "hero tunic (f)" or
				string.sub(speech, 7, 23) == "hero leathers (m)" or
				string.sub(speech, 7, 23) == "hero leathers (f)" or
				string.sub(speech, 7, 22) == "master tunic (m)" or
				string.sub(speech, 7, 22) == "master tunic (f)" or
				string.sub(speech, 7, 25) == "master leathers (m)" or
				string.sub(speech, 7, 25) == "master leathers (f)" or
				string.sub(speech, 7, 22) == "beginner buckler" or
				string.sub(speech, 7, 21) == "trainee buckler" or
				string.sub(speech, 7, 20) == "novice buckler" or
				string.sub(speech, 7, 22) == "initiate buckler" or
				string.sub(speech, 7, 24) == "apprentice buckler" or
				string.sub(speech, 7, 24) == "journeyman buckler" or
				string.sub(speech, 7, 24) == "adventurer buckler" or
				string.sub(speech, 7, 18) == "hero buckler" or
				string.sub(speech, 7, 20) == "master buckler" or
				string.sub(speech, 7, 21) == "paragon buckler" or
				string.sub(speech, 7, 23) == "beginner headband" or
				string.sub(speech, 7, 22) == "trainee headband" or
				string.sub(speech, 7, 21) == "novice headband" or
				string.sub(speech, 7, 23) == "initiate headband" or
				string.sub(speech, 7, 25) == "apprentice headband" or
				string.sub(speech, 7, 25) == "journeyman headband" or
				string.sub(speech, 7, 25) == "adventurer headband" or
				string.sub(speech, 7, 19) == "hero headband" or
				string.sub(speech, 7, 21) == "master headband" or
				string.sub(speech, 7, 22) == "paragon headband" or
				string.sub(speech, 7, 20) == "beginner glove" or
				string.sub(speech, 7, 19) == "trainee glove" or
				string.sub(speech, 7, 18) == "novice glove" or
				string.sub(speech, 7, 20) == "initiate glove" or
				string.sub(speech, 7, 22) == "apprentice glove" or
				string.sub(speech, 7, 22) == "journeyman glove" or
				string.sub(speech, 7, 22) == "adventurer glove" or
				string.sub(speech, 7, 16) == "hero glove" or
				string.sub(speech, 7, 18) == "master glove" or
				string.sub(speech, 7, 19) == "paragon glove" or
				string.sub(speech, 7, 20) == "beginner boots" or
				string.sub(speech, 7, 19) == "trainee boots" or
				string.sub(speech, 7, 18) == "novice boots" or
				string.sub(speech, 7, 20) == "initiate boots" or
				string.sub(speech, 7, 22) == "apprentice boots" or
				string.sub(speech, 7, 22) == "journeyman boots" or
				string.sub(speech, 7, 22) == "adventurer boots" or
				string.sub(speech, 7, 16) == "hero boots" or
				string.sub(speech, 7, 18) == "master boots" or
				string.sub(speech, 7, 19) == "paragon boots" or
				string.sub(speech, 7, 25) == "beginner shroud (m)" or
				string.sub(speech, 7, 25) == "beginner shroud (f)" or
				string.sub(speech, 7, 23) == "beginner robe (m)" or
				string.sub(speech, 7, 23) == "beginner robe (f)" or
				string.sub(speech, 7, 24) == "trainee shroud (m)" or
				string.sub(speech, 7, 24) == "trainee shroud (f)" or
				string.sub(speech, 7, 22) == "trainee robe (m)" or
				string.sub(speech, 7, 22) == "trainee robe (f)" or
				string.sub(speech, 7, 23) == "novice shroud (m)" or
				string.sub(speech, 7, 23) == "novice shroud (f)" or
				string.sub(speech, 7, 21) == "novice robe (m)" or
				string.sub(speech, 7, 21) == "novice robe (f)" or
				string.sub(speech, 7, 25) == "initiate shroud (m)" or
				string.sub(speech, 7, 25) == "initiate shroud (f)" or
				string.sub(speech, 7, 23) == "initiate robe (m)" or
				string.sub(speech, 7, 23) == "initiate robe (f)" or
				string.sub(speech, 7, 27) == "apprentice shroud (m)" or
				string.sub(speech, 7, 27) == "apprentice shroud (f)" or
				string.sub(speech, 7, 25) == "apprentice robe (m)" or
				string.sub(speech, 7, 25) == "apprentice robe (f)" or
				string.sub(speech, 7, 27) == "journeyman shroud (m)" or
				string.sub(speech, 7, 27) == "journeyman shroud (f)" or
				string.sub(speech, 7, 25) == "journeyman robe (m)" or
				string.sub(speech, 7, 25) == "journeyman robe (f)" or
				string.sub(speech, 7, 27) == "adventurer shroud (m)" or
				string.sub(speech, 7, 27) == "adventurer shroud (f)" or
				string.sub(speech, 7, 25) == "adventurer robe (m)" or
				string.sub(speech, 7, 25) == "adventurer robe (f)" or
				string.sub(speech, 7, 21) == "hero shroud (m)" or
				string.sub(speech, 7, 21) == "hero shroud (f)" or
				string.sub(speech, 7, 19) == "hero robe (m)" or
				string.sub(speech, 7, 19) == "hero robe (f)" or
				string.sub(speech, 7, 23) == "master shroud (m)" or
				string.sub(speech, 7, 23) == "master shroud (f)" or
				string.sub(speech, 7, 21) == "master robe (m)" or
				string.sub(speech, 7, 21) == "master robe (f)" or
				string.sub(speech, 7, 19) == "beginner ward" or
				string.sub(speech, 7, 18) == "trainee ward" or
				string.sub(speech, 7, 17) == "novice ward" or
				string.sub(speech, 7, 19) == "initiate ward" or
				string.sub(speech, 7, 21) == "apprentice ward" or
				string.sub(speech, 7, 21) == "journeyman ward" or
				string.sub(speech, 7, 21) == "adventurer ward" or
				string.sub(speech, 7, 15) == "hero ward" or
				string.sub(speech, 7, 17) == "master ward" or
				string.sub(speech, 7, 18) == "paragon ward" or
				string.sub(speech, 7, 18) == "beginner cap" or
				string.sub(speech, 7, 17) == "trainee cap" or
				string.sub(speech, 7, 16) == "novice cap" or
				string.sub(speech, 7, 18) == "initiate cap" or
				string.sub(speech, 7, 20) == "apprentice cap" or
				string.sub(speech, 7, 20) == "journeyman cap" or
				string.sub(speech, 7, 20) == "adventurer cap" or
				string.sub(speech, 7, 14) == "hero cap" or
				string.sub(speech, 7, 16) == "master cap" or
				string.sub(speech, 7, 17) == "paragon cap" or
				string.sub(speech, 7, 19) == "beginner ring" or
				string.sub(speech, 7, 18) == "trainee ring" or
				string.sub(speech, 7, 17) == "novice ring" or
				string.sub(speech, 7, 19) == "initiate ring" or
				string.sub(speech, 7, 21) == "apprentice ring" or
				string.sub(speech, 7, 21) == "journeyman ring" or
				string.sub(speech, 7, 21) == "adventurer ring" or
				string.sub(speech, 7, 15) == "hero ring" or
				string.sub(speech, 7, 17) == "master ring" or
				string.sub(speech, 7, 18) == "paragon ring" or
				string.sub(speech, 7, 20) == "beginner shoes" or
				string.sub(speech, 7, 19) == "trainee shoes" or
				string.sub(speech, 7, 18) == "novice shoes" or
				string.sub(speech, 7, 20) == "initiate shoes" or
				string.sub(speech, 7, 22) == "apprentice shoes" or
				string.sub(speech, 7, 22) == "journeyman shoes" or
				string.sub(speech, 7, 22) == "adventurer shoes" or
				string.sub(speech, 7, 16) == "hero shoes" or
				string.sub(speech, 7, 18) == "master shoes" or
				string.sub(speech, 7, 19) == "paragon shoes"
		 then
			item = Item(string.sub(speech, 7, 24))

			if (item == nil) then
				item = Item(string.sub(speech, 7, 24))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 27))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 27))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 23))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 23))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 26))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 26))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 22))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 22))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 25))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 25))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 24))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 24))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 27))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 27))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 26))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 26))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 29))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 29))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 26))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 26))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 29))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 29))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 26))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 26))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 29))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 29))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 20))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 20))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 23))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 23))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 22))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 22))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 25))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 25))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 22))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 21))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 20))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 22))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 24))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 24))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 24))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 24))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 18))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 20))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 21))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 23))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 22))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 21))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 23))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 25))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 25))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 25))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 19))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 21))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 22))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 20))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 19))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 18))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 20))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 22))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 22))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 22))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 16))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 18))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 19))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 20))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 19))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 18))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 20))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 22))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 22))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 22))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 16))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 18))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 19))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 25))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 25))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 23))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 23))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 24))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 24))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 22))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 22))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 23))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 23))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 21))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 21))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 25))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 25))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 23))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 23))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 27))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 27))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 25))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 25))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 27))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 27))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 25))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 25))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 27))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 27))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 25))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 25))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 21))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 21))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 19))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 19))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 23))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 23))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 21))
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
				item = Item(string.sub(speech, 7, 17))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 19))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 21))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 21))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 21))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 15))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 17))
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
				item = Item(string.sub(speech, 7, 16))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 18))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 20))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 20))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 20))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 14))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 16))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 17))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 19))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 18))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 17))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 19))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 21))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 21))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 21))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 15))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 17))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 18))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 20))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 19))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 18))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 20))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 22))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 22))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 22))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 16))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 18))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 19))
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
			string.sub(speech, 1, 7) == "buy my " and string.sub(speech, 8, 25) == "beginner tunic (m)" or
				string.sub(speech, 8, 25) == "beginner tunic (f)" or
				string.sub(speech, 8, 28) == "beginner leathers (m)" or
				string.sub(speech, 8, 28) == "beginner leathers (f)" or
				string.sub(speech, 8, 24) == "trainee tunic (m)" or
				string.sub(speech, 8, 24) == "trainee tunic (f)" or
				string.sub(speech, 8, 27) == "trainee leathers (m)" or
				string.sub(speech, 8, 27) == "trainee leathers (f)" or
				string.sub(speech, 8, 23) == "novice tunic (m)" or
				string.sub(speech, 8, 23) == "novice tunic (f)" or
				string.sub(speech, 8, 26) == "novice leathers (m)" or
				string.sub(speech, 8, 26) == "novice leathers (f)" or
				string.sub(speech, 8, 25) == "initiate tunic (m)" or
				string.sub(speech, 8, 25) == "initiate tunic (f)" or
				string.sub(speech, 8, 28) == "initiate leathers (m)" or
				string.sub(speech, 8, 28) == "initiate leathers (f)" or
				string.sub(speech, 8, 27) == "apprentice tunic (m)" or
				string.sub(speech, 8, 27) == "apprentice tunic (f)" or
				string.sub(speech, 8, 30) == "apprentice leathers (m)" or
				string.sub(speech, 8, 30) == "apprentice leathers (f)" or
				string.sub(speech, 8, 27) == "journeyman tunic (m)" or
				string.sub(speech, 8, 27) == "journeyman tunic (f)" or
				string.sub(speech, 8, 30) == "journeyman leathers (m)" or
				string.sub(speech, 8, 30) == "journeyman leathers (f)" or
				string.sub(speech, 8, 27) == "adventurer tunic (m)" or
				string.sub(speech, 8, 27) == "adventurer tunic (f)" or
				string.sub(speech, 8, 30) == "adventurer leathers (m)" or
				string.sub(speech, 8, 30) == "adventurer leathers (f)" or
				string.sub(speech, 8, 21) == "hero tunic (m)" or
				string.sub(speech, 8, 21) == "hero tunic (f)" or
				string.sub(speech, 8, 24) == "hero leathers (m)" or
				string.sub(speech, 8, 24) == "hero leathers (f)" or
				string.sub(speech, 8, 23) == "master tunic (m)" or
				string.sub(speech, 8, 23) == "master tunic (f)" or
				string.sub(speech, 8, 26) == "master leathers (m)" or
				string.sub(speech, 8, 26) == "master leathers (f)" or
				string.sub(speech, 8, 23) == "beginner buckler" or
				string.sub(speech, 8, 22) == "trainee buckler" or
				string.sub(speech, 8, 21) == "novice buckler" or
				string.sub(speech, 8, 23) == "initiate buckler" or
				string.sub(speech, 8, 25) == "apprentice buckler" or
				string.sub(speech, 8, 25) == "journeyman buckler" or
				string.sub(speech, 8, 25) == "adventurer buckler" or
				string.sub(speech, 8, 19) == "hero buckler" or
				string.sub(speech, 8, 21) == "master buckler" or
				string.sub(speech, 8, 22) == "paragon buckler" or
				string.sub(speech, 8, 24) == "beginner headband" or
				string.sub(speech, 8, 23) == "trainee headband" or
				string.sub(speech, 8, 22) == "novice headband" or
				string.sub(speech, 8, 24) == "initiate headband" or
				string.sub(speech, 8, 26) == "apprentice headband" or
				string.sub(speech, 8, 26) == "journeyman headband" or
				string.sub(speech, 8, 26) == "adventurer headband" or
				string.sub(speech, 8, 20) == "hero headband" or
				string.sub(speech, 8, 22) == "master headband" or
				string.sub(speech, 8, 23) == "paragon headband" or
				string.sub(speech, 8, 21) == "beginner glove" or
				string.sub(speech, 8, 20) == "trainee glove" or
				string.sub(speech, 8, 19) == "novice glove" or
				string.sub(speech, 8, 21) == "initiate glove" or
				string.sub(speech, 8, 23) == "apprentice glove" or
				string.sub(speech, 8, 23) == "journeyman glove" or
				string.sub(speech, 8, 23) == "adventurer glove" or
				string.sub(speech, 8, 17) == "hero glove" or
				string.sub(speech, 8, 19) == "master glove" or
				string.sub(speech, 8, 20) == "paragon glove" or
				string.sub(speech, 8, 21) == "beginner boots" or
				string.sub(speech, 8, 20) == "trainee boots" or
				string.sub(speech, 8, 19) == "novice boots" or
				string.sub(speech, 8, 21) == "initiate boots" or
				string.sub(speech, 8, 23) == "apprentice boots" or
				string.sub(speech, 8, 23) == "journeyman boots" or
				string.sub(speech, 8, 23) == "adventurer boots" or
				string.sub(speech, 8, 17) == "hero boots" or
				string.sub(speech, 8, 19) == "master boots" or
				string.sub(speech, 8, 20) == "paragon boots" or
				string.sub(speech, 8, 26) == "beginner shroud (m)" or
				string.sub(speech, 8, 26) == "beginner shroud (f)" or
				string.sub(speech, 8, 24) == "beginner robe (m)" or
				string.sub(speech, 8, 24) == "beginner robe (f)" or
				string.sub(speech, 8, 25) == "trainee shroud (m)" or
				string.sub(speech, 8, 25) == "trainee shroud (f)" or
				string.sub(speech, 8, 23) == "trainee robe (m)" or
				string.sub(speech, 8, 23) == "trainee robe (f)" or
				string.sub(speech, 8, 24) == "novice shroud (m)" or
				string.sub(speech, 8, 24) == "novice shroud (f)" or
				string.sub(speech, 8, 22) == "novice robe (m)" or
				string.sub(speech, 8, 22) == "novice robe (f)" or
				string.sub(speech, 8, 26) == "initiate shroud (m)" or
				string.sub(speech, 8, 26) == "initiate shroud (f)" or
				string.sub(speech, 8, 24) == "initiate robe (m)" or
				string.sub(speech, 8, 24) == "initiate robe (f)" or
				string.sub(speech, 8, 28) == "apprentice shroud (m)" or
				string.sub(speech, 8, 28) == "apprentice shroud (f)" or
				string.sub(speech, 8, 26) == "apprentice robe (m)" or
				string.sub(speech, 8, 26) == "apprentice robe (f)" or
				string.sub(speech, 8, 28) == "journeyman shroud (m)" or
				string.sub(speech, 8, 28) == "journeyman shroud (f)" or
				string.sub(speech, 8, 26) == "journeyman robe (m)" or
				string.sub(speech, 8, 26) == "journeyman robe (f)" or
				string.sub(speech, 8, 28) == "adventurer shroud (m)" or
				string.sub(speech, 8, 28) == "adventurer shroud (f)" or
				string.sub(speech, 8, 26) == "adventurer robe (m)" or
				string.sub(speech, 8, 26) == "adventurer robe (f)" or
				string.sub(speech, 8, 22) == "hero shroud (m)" or
				string.sub(speech, 8, 22) == "hero shroud (f)" or
				string.sub(speech, 8, 20) == "hero robe (m)" or
				string.sub(speech, 8, 20) == "hero robe (f)" or
				string.sub(speech, 8, 24) == "master shroud (m)" or
				string.sub(speech, 8, 24) == "master shroud (f)" or
				string.sub(speech, 8, 22) == "master robe (m)" or
				string.sub(speech, 8, 22) == "master robe (f)" or
				string.sub(speech, 8, 20) == "beginner ward" or
				string.sub(speech, 8, 19) == "trainee ward" or
				string.sub(speech, 8, 18) == "novice ward" or
				string.sub(speech, 8, 20) == "initiate ward" or
				string.sub(speech, 8, 22) == "apprentice ward" or
				string.sub(speech, 8, 22) == "journeyman ward" or
				string.sub(speech, 8, 22) == "adventurer ward" or
				string.sub(speech, 8, 16) == "hero ward" or
				string.sub(speech, 8, 18) == "master ward" or
				string.sub(speech, 8, 19) == "paragon ward" or
				string.sub(speech, 8, 19) == "beginner cap" or
				string.sub(speech, 8, 18) == "trainee cap" or
				string.sub(speech, 8, 17) == "novice cap" or
				string.sub(speech, 8, 19) == "initiate cap" or
				string.sub(speech, 8, 21) == "apprentice cap" or
				string.sub(speech, 8, 21) == "journeyman cap" or
				string.sub(speech, 8, 21) == "adventurer cap" or
				string.sub(speech, 8, 15) == "hero cap" or
				string.sub(speech, 8, 17) == "master cap" or
				string.sub(speech, 8, 18) == "paragon cap" or
				string.sub(speech, 8, 20) == "beginner ring" or
				string.sub(speech, 8, 19) == "trainee ring" or
				string.sub(speech, 8, 18) == "novice ring" or
				string.sub(speech, 8, 20) == "initiate ring" or
				string.sub(speech, 8, 22) == "apprentice ring" or
				string.sub(speech, 8, 22) == "journeyman ring" or
				string.sub(speech, 8, 22) == "adventurer ring" or
				string.sub(speech, 8, 16) == "hero ring" or
				string.sub(speech, 8, 18) == "master ring" or
				string.sub(speech, 8, 19) == "paragon ring" or
				string.sub(speech, 8, 21) == "beginner shoes" or
				string.sub(speech, 8, 20) == "trainee shoes" or
				string.sub(speech, 8, 19) == "novice shoes" or
				string.sub(speech, 8, 21) == "initiate shoes" or
				string.sub(speech, 8, 23) == "apprentice shoes" or
				string.sub(speech, 8, 23) == "journeyman shoes" or
				string.sub(speech, 8, 23) == "adventurer shoes" or
				string.sub(speech, 8, 17) == "hero shoes" or
				string.sub(speech, 8, 19) == "master shoes" or
				string.sub(speech, 8, 20) == "paragon shoes"
		 then
			item = Item(string.sub(speech, 8, 25))

			if (item == nil) then
				item = Item(string.sub(speech, 8, 25))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 28))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 28))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 24))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 24))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 27))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 27))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 23))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 23))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 26))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 26))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 25))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 25))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 28))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 28))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 27))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 27))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 30))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 30))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 27))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 27))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 30))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 30))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 27))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 27))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 30))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 30))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 21))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 21))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 24))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 24))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 23))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 23))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 26))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 26))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 23))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 22))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 21))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 23))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 25))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 25))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 25))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 25))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 19))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 21))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 22))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 24))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 23))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 22))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 24))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 26))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 26))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 26))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 20))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 22))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 23))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 21))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 20))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 19))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 21))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 23))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 23))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 23))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 17))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 19))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 20))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 21))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 20))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 19))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 21))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 23))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 23))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 23))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 17))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 19))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 20))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 26))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 26))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 24))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 24))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 25))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 25))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 23))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 23))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 24))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 24))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 22))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 22))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 26))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 26))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 24))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 24))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 28))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 28))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 26))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 26))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 28))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 28))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 26))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 26))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 28))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 28))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 26))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 26))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 22))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 22))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 20))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 20))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 24))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 24))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 22))
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
				item = Item(string.sub(speech, 8, 18))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 18))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 22))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 22))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 22))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 16))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 18))
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
				item = Item(string.sub(speech, 8, 17))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 19))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 21))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 21))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 21))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 15))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 17))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 18))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 20))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 19))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 18))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 20))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 22))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 22))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 22))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 16))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 18))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 19))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 21))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 20))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 19))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 21))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 23))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 23))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 23))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 17))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 19))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 20))
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
				if pc[i].level >= 60 and pc[i].quest["spidersilk"] == 0 then
					pc[i]:selfAnimationXY(pc[i].ID, 248, x, y)
				end
			end
		end
	end
}
