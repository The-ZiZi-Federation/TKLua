-- Hon Armor (Armorer Joe)
hon_armor_smith = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local offenseName
			local defenseName

			local options = {}

			table.insert(options, "Buy")
			table.insert(options, "Sell")
			table.insert(options, "Repair Item")
			table.insert(options, "Repair All")

			if player.level >= 20 and player.quest["help_joe"] == 0 then
				table.insert(options, "Need any help around here?")
			end
			if player.quest["help_joe"] == 1 then
				table.insert(options, "I'm back!")
			end

			if player.baseClass == 1 then
				offenseName = "Chainmail"
				defenseName = "Platemail"
			end
			if player.baseClass == 2 then
				offenseName = "Tunic"
				defenseName = "Leathers"
			end
			if player.baseClass == 3 then
				offenseName = "Shroud"
				defenseName = "Robe"
			end
			if player.baseClass == 4 then
				offenseName = "Hauberk"
				defenseName = "Hide"
			end

			menu =
				player:menuString(
				name .. "I am smith, I buy and sell armor. I can also repair your equipment if it is not FUBAR.",
				options
			)

			if menu == "Buy" then
				armor_smith.buy(player)
			elseif menu == "Sell" then
				armor_smith.sell(player)
			elseif menu == "Repair Item" then
				player:repairExtend()
			elseif menu == "Repair All" then
				player:repairAll(player, npc)
			elseif menu == "Need any help around here?" then
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
				player.quest["help_joe"] = 1
				player:msg(4, "[Quest Updated] Go fetch Joe's Coat, Metal Sample, and Lunch!", player.ID)
			elseif menu == "I'm back!" then
				if player.quest["joes_food"] == 1 and player.quest["joes_metal"] == 1 and player.quest["joes_clothes"] == 1 then
					player:dialogSeq(
						{
							t,
							name .. "You're back!",
							name .. "And you've got all my stuff!",
							name .. "I thought you were joking when you offered to help me, but you're a lifesaver!",
							name .. "Here, have a sample of my armor, on the house!"
						},
						1
					)

					armorchoice =
						player:menuString(
						name .. "What style do you prefer?",
						{"" .. offenseName .. " (Offense)", "" .. defenseName .. " (Defense)"}
					)

					if armorchoice == "" .. offenseName .. " (Offense)" then
						if player.sex == 0 then
							if player.baseClass == 1 then
								player:addItem("trainee_chainmail_m", 1)
							end
							if player.baseClass == 2 then
								player:addItem("trainee_tunic_m", 1)
							end
							if player.baseClass == 3 then
								player:addItem("trainee_shroud_m", 1)
							end
							if player.baseClass == 4 then
								player:addItem("trainee_hauberk_m", 1)
							end
						elseif player.sex == 1 then
							if player.baseClass == 1 then
								player:addItem("trainee_chainmail_f", 1)
							end
							if player.baseClass == 2 then
								player:addItem("trainee_tunic_f", 1)
							end
							if player.baseClass == 3 then
								player:addItem("trainee_shroud_f", 1)
							end
							if player.baseClass == 4 then
								player:addItem("trainee_hauberk_f", 1)
							end
						end
					elseif armorchoice == "" .. defenseName .. " (Defense)" then
						if player.sex == 0 then
							if player.baseClass == 1 then
								player:addItem("trainee_platemail_m", 1)
							end
							if player.baseClass == 2 then
								player:addItem("trainee_leathers_m", 1)
							end
							if player.baseClass == 3 then
								player:addItem("trainee_robe_m", 1)
							end
							if player.baseClass == 4 then
								player:addItem("trainee_hide_m", 1)
							end
						elseif player.sex == 1 then
							if player.baseClass == 1 then
								player:addItem("trainee_platemail_f", 1)
							end
							if player.baseClass == 2 then
								player:addItem("trainee_leathers_f", 1)
							end
							if player.baseClass == 3 then
								player:addItem("trainee_robe_f", 1)
							end
							if player.baseClass == 4 then
								player:addItem("trainee_hide_f", 1)
							end
						end
					end
					giveXP(player, 10000)
					finishedQuest(player)
					player:calcStat()
					player:sendStatus()
					player:msg(4, "[Quest Complete] You did Joe a favor and got a reward!", player.ID)
					player.quest["help_joe"] = 2
				end
			else
				player:dialogSeq(
					{
						t,
						name .. "Is this a joke? You don't have all my stuff. You said you'd bring me my coat, my lunch, and my metal!"
					},
					1
				)
			end
		end
	),
	say = function(player, npc)
		local speech = string.lower(player.speech)
		local item
		local number

		if
			string.sub(speech, 1, 6) == "i buy " and string.sub(speech, 7, 28) == "beginner chainmail (m)" or
				string.sub(speech, 7, 28) == "beginner chainmail (f)" or
				string.sub(speech, 7, 28) == "beginner platemail (m)" or
				string.sub(speech, 7, 28) == "beginner platemail (f)" or
				string.sub(speech, 7, 27) == "trainee chainmail (m)" or
				string.sub(speech, 7, 27) == "trainee chainmail (f)" or
				string.sub(speech, 7, 27) == "trainee platemail (m)" or
				string.sub(speech, 7, 27) == "trainee platemail (m)" or
				string.sub(speech, 7, 26) == "novice chainmail (m)" or
				string.sub(speech, 7, 26) == "novice chainmail (f)" or
				string.sub(speech, 7, 26) == "novice platemail (m)" or
				string.sub(speech, 7, 26) == "novice platemail (f)" or
				string.sub(speech, 7, 28) == "initiate chainmail (m)" or
				string.sub(speech, 7, 28) == "initiate chainmail (f)" or
				string.sub(speech, 7, 28) == "initiate platemail (m)" or
				string.sub(speech, 7, 28) == "initiate platemail (f)" or
				string.sub(speech, 7, 30) == "apprentice chainmail (m)" or
				string.sub(speech, 7, 30) == "apprentice chainmail (f)" or
				string.sub(speech, 7, 30) == "apprentice platemail (m)" or
				string.sub(speech, 7, 30) == "apprentice platemail (f)" or
				string.sub(speech, 7, 30) == "journeyman chainmail (m)" or
				string.sub(speech, 7, 30) == "journeyman chainmail (f)" or
				string.sub(speech, 7, 30) == "journeyman platemail (m)" or
				string.sub(speech, 7, 30) == "journeyman platemail (f)" or
				string.sub(speech, 7, 30) == "adventurer chainmail (m)" or
				string.sub(speech, 7, 30) == "adventurer chainmail (f)" or
				string.sub(speech, 7, 30) == "adventurer platemail (m)" or
				string.sub(speech, 7, 30) == "adventurer platemail (f)" or
				string.sub(speech, 7, 24) == "hero chainmail (m)" or
				string.sub(speech, 7, 24) == "hero chainmail (f)" or
				string.sub(speech, 7, 24) == "hero platemail (m)" or
				string.sub(speech, 7, 24) == "hero platemail (f)" or
				string.sub(speech, 7, 26) == "master chainmail (m)" or
				string.sub(speech, 7, 26) == "master chainmail (f)" or
				string.sub(speech, 7, 26) == "master platemail (m)" or
				string.sub(speech, 7, 26) == "master platemail (f)" or
				string.sub(speech, 7, 21) == "beginner shield" or
				string.sub(speech, 7, 20) == "trainee shield" or
				string.sub(speech, 7, 19) == "novice shield" or
				string.sub(speech, 7, 21) == "initiate shield" or
				string.sub(speech, 7, 23) == "apprentice shield" or
				string.sub(speech, 7, 23) == "journeyman shield" or
				string.sub(speech, 7, 23) == "adventurer shield" or
				string.sub(speech, 7, 17) == "hero shield" or
				string.sub(speech, 7, 19) == "master shield" or
				string.sub(speech, 7, 20) == "paragon shield" or
				string.sub(speech, 7, 19) == "beginner helm" or
				string.sub(speech, 7, 18) == "trainee helm" or
				string.sub(speech, 7, 17) == "novice helm" or
				string.sub(speech, 7, 19) == "initiate helm" or
				string.sub(speech, 7, 21) == "apprentice helm" or
				string.sub(speech, 7, 21) == "journeyman helm" or
				string.sub(speech, 7, 21) == "adventurer helm" or
				string.sub(speech, 7, 15) == "hero helm" or
				string.sub(speech, 7, 17) == "master helm" or
				string.sub(speech, 7, 18) == "paragon helm" or
				string.sub(speech, 7, 23) == "beginner gauntlet" or
				string.sub(speech, 7, 22) == "trainee gauntlet" or
				string.sub(speech, 7, 21) == "novice gauntlet" or
				string.sub(speech, 7, 23) == "initiate gauntlet" or
				string.sub(speech, 7, 25) == "apprentice gauntlet" or
				string.sub(speech, 7, 25) == "journeyman gauntlet" or
				string.sub(speech, 7, 25) == "adventurer gauntlet" or
				string.sub(speech, 7, 19) == "hero gauntlet" or
				string.sub(speech, 7, 21) == "master gauntlet" or
				string.sub(speech, 7, 22) == "paragon gauntlet" or
				string.sub(speech, 7, 22) == "beginner greaves" or
				string.sub(speech, 7, 21) == "trainee greaves" or
				string.sub(speech, 7, 20) == "novice greaves" or
				string.sub(speech, 7, 22) == "initiate greaves" or
				string.sub(speech, 7, 24) == "apprentice greaves" or
				string.sub(speech, 7, 24) == "journeyman greaves" or
				string.sub(speech, 7, 24) == "adventurer greaves" or
				string.sub(speech, 7, 18) == "hero greaves" or
				string.sub(speech, 7, 20) == "master greaves" or
				string.sub(speech, 7, 21) == "paragon greaves" or
				string.sub(speech, 7, 26) == "beginner hauberk (m)" or
				string.sub(speech, 7, 26) == "beginner hauberk (f)" or
				string.sub(speech, 7, 23) == "beginner hide (m)" or
				string.sub(speech, 7, 23) == "beginner hide (f)" or
				string.sub(speech, 7, 25) == "trainee hauberk (m)" or
				string.sub(speech, 7, 25) == "trainee hauberk (f)" or
				string.sub(speech, 7, 22) == "trainee hide (m)" or
				string.sub(speech, 7, 22) == "trainee hide (f)" or
				string.sub(speech, 7, 24) == "novice hauberk (m)" or
				string.sub(speech, 7, 24) == "novice hauberk (f)" or
				string.sub(speech, 7, 21) == "novice hide (m)" or
				string.sub(speech, 7, 21) == "novice hide (f)" or
				string.sub(speech, 7, 26) == "initiate hauberk (m)" or
				string.sub(speech, 7, 26) == "initiate hauberk (f)" or
				string.sub(speech, 7, 23) == "initiate hide (m)" or
				string.sub(speech, 7, 23) == "initiate hide (f)" or
				string.sub(speech, 7, 28) == "apprentice hauberk (m)" or
				string.sub(speech, 7, 28) == "apprentice hauberk (f)" or
				string.sub(speech, 7, 25) == "apprentice hide (m)" or
				string.sub(speech, 7, 25) == "apprentice hide (f)" or
				string.sub(speech, 7, 28) == "journeyman hauberk (m)" or
				string.sub(speech, 7, 28) == "journeyman hauberk (f)" or
				string.sub(speech, 7, 25) == "journeyman hide (m)" or
				string.sub(speech, 7, 25) == "journeyman hide (f)" or
				string.sub(speech, 7, 28) == "adventurer hauberk (m)" or
				string.sub(speech, 7, 28) == "adventurer hauberk (f)" or
				string.sub(speech, 7, 25) == "adventurer hide (m)" or
				string.sub(speech, 7, 25) == "adventurer hide (f)" or
				string.sub(speech, 7, 22) == "hero hauberk (m)" or
				string.sub(speech, 7, 22) == "hero hauberk (f)" or
				string.sub(speech, 7, 19) == "hero hide (m)" or
				string.sub(speech, 7, 19) == "hero hide (f)" or
				string.sub(speech, 7, 24) == "master hauberk (m)" or
				string.sub(speech, 7, 24) == "master hauberk (f)" or
				string.sub(speech, 7, 21) == "master hide (m)" or
				string.sub(speech, 7, 21) == "master hide (f)" or
				string.sub(speech, 7, 20) == "beginner guard" or
				string.sub(speech, 7, 19) == "trainee guard" or
				string.sub(speech, 7, 18) == "novice guard" or
				string.sub(speech, 7, 20) == "initiate guard" or
				string.sub(speech, 7, 22) == "apprentice guard" or
				string.sub(speech, 7, 22) == "journeyman guard" or
				string.sub(speech, 7, 22) == "adventurer guard" or
				string.sub(speech, 7, 16) == "hero guard" or
				string.sub(speech, 7, 18) == "master guard" or
				string.sub(speech, 7, 19) == "paragon guard" or
				string.sub(speech, 7, 21) == "beginner sallet" or
				string.sub(speech, 7, 20) == "trainee sallet" or
				string.sub(speech, 7, 19) == "novice sallet" or
				string.sub(speech, 7, 21) == "initiate sallet" or
				string.sub(speech, 7, 23) == "apprentice sallet" or
				string.sub(speech, 7, 23) == "journeyman sallet" or
				string.sub(speech, 7, 23) == "adventurer sallet" or
				string.sub(speech, 7, 17) == "hero sallet" or
				string.sub(speech, 7, 19) == "master sallet" or
				string.sub(speech, 7, 20) == "paragon sallet" or
				string.sub(speech, 7, 19) == "beginner wrap" or
				string.sub(speech, 7, 18) == "trainee wrap" or
				string.sub(speech, 7, 17) == "novice wrap" or
				string.sub(speech, 7, 19) == "initiate wrap" or
				string.sub(speech, 7, 21) == "apprentice wrap" or
				string.sub(speech, 7, 21) == "journeyman wrap" or
				string.sub(speech, 7, 21) == "adventurer wrap" or
				string.sub(speech, 7, 15) == "hero wrap" or
				string.sub(speech, 7, 17) == "master wrap" or
				string.sub(speech, 7, 18) == "paragon wrap" or
				string.sub(speech, 7, 20) == "beginner boteu" or
				string.sub(speech, 7, 19) == "trainee boteu" or
				string.sub(speech, 7, 18) == "novice boteu" or
				string.sub(speech, 7, 20) == "initiate boteu" or
				string.sub(speech, 7, 22) == "apprentice boteu" or
				string.sub(speech, 7, 22) == "journeyman boteu" or
				string.sub(speech, 7, 22) == "adventurer boteu" or
				string.sub(speech, 7, 16) == "hero boteu" or
				string.sub(speech, 7, 18) == "master boteu" or
				string.sub(speech, 7, 19) == "paragon boteu"
		 then
			item = Item(string.sub(speech, 7, 28))

			if (item == nil) then
				item = Item(string.sub(speech, 7, 28))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 28))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 28))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 27))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 27))
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
				item = Item(string.sub(speech, 7, 26))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 26))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 28))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 28))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 28))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 28))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 30))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 30))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 30))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 30))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 30))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 30))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 30))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 30))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 30))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 30))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 30))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 30))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 30))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 30))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 30))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 30))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 21))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 20))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 19))
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
				item = Item(string.sub(speech, 7, 23))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 17))
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
				item = Item(string.sub(speech, 7, 18))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 20))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 21))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 26))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 26))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 23))
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
				item = Item(string.sub(speech, 7, 22))
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
				item = Item(string.sub(speech, 7, 21))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 21))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 26))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 26))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 23))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 23))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 28))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 28))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 25))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 25))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 28))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 28))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 25))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 25))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 28))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 28))
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
				item = Item(string.sub(speech, 7, 22))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 19))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 19))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 24))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 24))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 21))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 21))
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
				item = Item(string.sub(speech, 7, 21))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 20))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 19))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 7, 21))
			end

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
			string.sub(speech, 1, 7) == "buy my " and string.sub(speech, 8, 29) == "beginner chainmail (m)" or
				string.sub(speech, 8, 29) == "beginner chainmail (f)" or
				string.sub(speech, 8, 29) == "beginner platemail (m)" or
				string.sub(speech, 8, 29) == "beginner platemail (f)" or
				string.sub(speech, 8, 28) == "trainee chainmail (m)" or
				string.sub(speech, 8, 28) == "trainee chainmail (f)" or
				string.sub(speech, 8, 28) == "trainee platemail (m)" or
				string.sub(speech, 8, 28) == "trainee platemail (m)" or
				string.sub(speech, 8, 27) == "novice chainmail (m)" or
				string.sub(speech, 8, 27) == "novice chainmail (f)" or
				string.sub(speech, 8, 27) == "novice platemail (m)" or
				string.sub(speech, 8, 27) == "novice platemail (f)" or
				string.sub(speech, 8, 29) == "initiate chainmail (m)" or
				string.sub(speech, 8, 29) == "initiate chainmail (f)" or
				string.sub(speech, 8, 29) == "initiate platemail (m)" or
				string.sub(speech, 8, 29) == "initiate platemail (f)" or
				string.sub(speech, 8, 31) == "apprentice chainmail (m)" or
				string.sub(speech, 8, 31) == "apprentice chainmail (f)" or
				string.sub(speech, 8, 31) == "apprentice platemail (m)" or
				string.sub(speech, 8, 31) == "apprentice platemail (f)" or
				string.sub(speech, 8, 31) == "journeyman chainmail (m)" or
				string.sub(speech, 8, 31) == "journeyman chainmail (f)" or
				string.sub(speech, 8, 31) == "journeyman platemail (m)" or
				string.sub(speech, 8, 31) == "journeyman platemail (f)" or
				string.sub(speech, 8, 31) == "adventurer chainmail (m)" or
				string.sub(speech, 8, 31) == "adventurer chainmail (f)" or
				string.sub(speech, 8, 31) == "adventurer platemail (m)" or
				string.sub(speech, 8, 31) == "adventurer platemail (f)" or
				string.sub(speech, 8, 25) == "hero chainmail (m)" or
				string.sub(speech, 8, 25) == "hero chainmail (f)" or
				string.sub(speech, 8, 25) == "hero platemail (m)" or
				string.sub(speech, 8, 25) == "hero platemail (f)" or
				string.sub(speech, 8, 27) == "master chainmail (m)" or
				string.sub(speech, 8, 27) == "master chainmail (f)" or
				string.sub(speech, 8, 27) == "master platemail (m)" or
				string.sub(speech, 8, 27) == "master platemail (f)" or
				string.sub(speech, 8, 22) == "beginner shield" or
				string.sub(speech, 8, 21) == "trainee shield" or
				string.sub(speech, 8, 20) == "novice shield" or
				string.sub(speech, 8, 22) == "initiate shield" or
				string.sub(speech, 78, 24) == "apprentice shield" or
				string.sub(speech, 8, 24) == "journeyman shield" or
				string.sub(speech, 8, 24) == "adventurer shield" or
				string.sub(speech, 8, 18) == "hero shield" or
				string.sub(speech, 8, 20) == "master shield" or
				string.sub(speech, 8, 21) == "paragon shield" or
				string.sub(speech, 8, 20) == "beginner helm" or
				string.sub(speech, 8, 19) == "trainee helm" or
				string.sub(speech, 8, 18) == "novice helm" or
				string.sub(speech, 8, 20) == "initiate helm" or
				string.sub(speech, 8, 22) == "apprentice helm" or
				string.sub(speech, 8, 22) == "journeyman helm" or
				string.sub(speech, 8, 22) == "adventurer helm" or
				string.sub(speech, 8, 16) == "hero helm" or
				string.sub(speech, 8, 18) == "master helm" or
				string.sub(speech, 8, 19) == "paragon helm" or
				string.sub(speech, 8, 24) == "beginner gauntlet" or
				string.sub(speech, 8, 23) == "trainee gauntlet" or
				string.sub(speech, 8, 22) == "novice gauntlet" or
				string.sub(speech, 8, 24) == "initiate gauntlet" or
				string.sub(speech, 8, 26) == "apprentice gauntlet" or
				string.sub(speech, 8, 26) == "journeyman gauntlet" or
				string.sub(speech, 8, 26) == "adventurer gauntlet" or
				string.sub(speech, 8, 20) == "hero gauntlet" or
				string.sub(speech, 8, 22) == "master gauntlet" or
				string.sub(speech, 8, 23) == "paragon gauntlet" or
				string.sub(speech, 8, 23) == "beginner greaves" or
				string.sub(speech, 8, 22) == "trainee greaves" or
				string.sub(speech, 8, 21) == "novice greaves" or
				string.sub(speech, 8, 23) == "initiate greaves" or
				string.sub(speech, 8, 25) == "apprentice greaves" or
				string.sub(speech, 8, 25) == "journeyman greaves" or
				string.sub(speech, 8, 25) == "adventurer greaves" or
				string.sub(speech, 8, 19) == "hero greaves" or
				string.sub(speech, 8, 21) == "master greaves" or
				string.sub(speech, 8, 22) == "paragon greaves" or
				string.sub(speech, 8, 27) == "beginner hauberk (m)" or
				string.sub(speech, 8, 27) == "beginner hauberk (f)" or
				string.sub(speech, 8, 24) == "beginner hide (m)" or
				string.sub(speech, 8, 24) == "beginner hide (f)" or
				string.sub(speech, 8, 26) == "trainee hauberk (m)" or
				string.sub(speech, 8, 26) == "trainee hauberk (f)" or
				string.sub(speech, 8, 23) == "trainee hide (m)" or
				string.sub(speech, 8, 23) == "trainee hide (f)" or
				string.sub(speech, 8, 25) == "novice hauberk (m)" or
				string.sub(speech, 8, 25) == "novice hauberk (f)" or
				string.sub(speech, 8, 22) == "novice hide (m)" or
				string.sub(speech, 8, 22) == "novice hide (f)" or
				string.sub(speech, 8, 27) == "initiate hauberk (m)" or
				string.sub(speech, 8, 27) == "initiate hauberk (f)" or
				string.sub(speech, 8, 24) == "initiate hide (m)" or
				string.sub(speech, 8, 24) == "initiate hide (f)" or
				string.sub(speech, 8, 29) == "apprentice hauberk (m)" or
				string.sub(speech, 8, 29) == "apprentice hauberk (f)" or
				string.sub(speech, 8, 26) == "apprentice hide (m)" or
				string.sub(speech, 8, 26) == "apprentice hide (f)" or
				string.sub(speech, 8, 29) == "journeyman hauberk (m)" or
				string.sub(speech, 8, 29) == "journeyman hauberk (f)" or
				string.sub(speech, 8, 26) == "journeyman hide (m)" or
				string.sub(speech, 8, 26) == "journeyman hide (f)" or
				string.sub(speech, 8, 29) == "adventurer hauberk (m)" or
				string.sub(speech, 8, 29) == "adventurer hauberk (f)" or
				string.sub(speech, 8, 26) == "adventurer hide (m)" or
				string.sub(speech, 8, 26) == "adventurer hide (f)" or
				string.sub(speech, 8, 23) == "hero hauberk (m)" or
				string.sub(speech, 8, 23) == "hero hauberk (f)" or
				string.sub(speech, 8, 20) == "hero hide (m)" or
				string.sub(speech, 8, 20) == "hero hide (f)" or
				string.sub(speech, 8, 25) == "master hauberk (m)" or
				string.sub(speech, 8, 25) == "master hauberk (f)" or
				string.sub(speech, 8, 22) == "master hide (m)" or
				string.sub(speech, 8, 22) == "master hide (f)" or
				string.sub(speech, 8, 21) == "beginner guard" or
				string.sub(speech, 8, 20) == "trainee guard" or
				string.sub(speech, 8, 19) == "novice guard" or
				string.sub(speech, 8, 21) == "initiate guard" or
				string.sub(speech, 8, 23) == "apprentice guard" or
				string.sub(speech, 8, 23) == "journeyman guard" or
				string.sub(speech, 8, 23) == "adventurer guard" or
				string.sub(speech, 8, 17) == "hero guard" or
				string.sub(speech, 8, 19) == "master guard" or
				string.sub(speech, 8, 20) == "paragon guard" or
				string.sub(speech, 8, 22) == "beginner sallet" or
				string.sub(speech, 8, 21) == "trainee sallet" or
				string.sub(speech, 8, 20) == "novice sallet" or
				string.sub(speech, 8, 22) == "initiate sallet" or
				string.sub(speech, 8, 24) == "apprentice sallet" or
				string.sub(speech, 8, 24) == "journeyman sallet" or
				string.sub(speech, 8, 24) == "adventurer sallet" or
				string.sub(speech, 8, 18) == "hero sallet" or
				string.sub(speech, 8, 20) == "master sallet" or
				string.sub(speech, 8, 21) == "paragon sallet" or
				string.sub(speech, 8, 20) == "beginner wrap" or
				string.sub(speech, 8, 19) == "trainee wrap" or
				string.sub(speech, 8, 18) == "novice wrap" or
				string.sub(speech, 8, 20) == "initiate wrap" or
				string.sub(speech, 8, 22) == "apprentice wrap" or
				string.sub(speech, 8, 22) == "journeyman wrap" or
				string.sub(speech, 8, 22) == "adventurer wrap" or
				string.sub(speech, 8, 16) == "hero wrap" or
				string.sub(speech, 8, 18) == "master wrap" or
				string.sub(speech, 8, 19) == "paragon wrap" or
				string.sub(speech, 8, 21) == "beginner boteu" or
				string.sub(speech, 8, 20) == "trainee boteu" or
				string.sub(speech, 8, 19) == "novice boteu" or
				string.sub(speech, 8, 21) == "initiate boteu" or
				string.sub(speech, 8, 23) == "apprentice boteu" or
				string.sub(speech, 8, 23) == "journeyman boteu" or
				string.sub(speech, 8, 23) == "adventurer boteu" or
				string.sub(speech, 8, 17) == "hero boteu" or
				string.sub(speech, 8, 19) == "master boteu" or
				string.sub(speech, 8, 20) == "paragon boteu"
		 then
			item = Item(string.sub(speech, 8, 29))

			if (item == nil) then
				item = Item(string.sub(speech, 8, 29))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 29))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 29))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 28))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 28))
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
				item = Item(string.sub(speech, 8, 27))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 27))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 29))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 29))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 29))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 29))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 31))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 31))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 31))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 31))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 31))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 31))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 31))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 31))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 31))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 31))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 31))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 31))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 31))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 31))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 31))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 31))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 22))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 21))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 20))
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
				item = Item(string.sub(speech, 8, 24))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 18))
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
				item = Item(string.sub(speech, 8, 23))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 22))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 21))
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
				item = Item(string.sub(speech, 8, 27))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 27))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 24))
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
				item = Item(string.sub(speech, 8, 23))
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
				item = Item(string.sub(speech, 8, 22))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 22))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 27))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 27))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 24))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 24))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 29))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 29))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 9, 26))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 26))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 29))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 29))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 26))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 26))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 29))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 29))
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
				item = Item(string.sub(speech, 8, 23))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 20))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 20))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 25))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 25))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 22))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 22))
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
				item = Item(string.sub(speech, 8, 22))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 21))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 20))
			end

			if (item == nil) then
				item = Item(string.sub(speech, 8, 22))
			end

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
				if pc[i].level >= 20 and pc[i].quest["help_joe"] == 0 then
					pc[i]:selfAnimationXY(pc[i].ID, 248, x, y)
				end
			end
		end
	end
}
