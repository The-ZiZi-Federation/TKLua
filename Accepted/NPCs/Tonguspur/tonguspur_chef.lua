tonguspur_chef = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local opts = {}
			local buyitems = {
				212,
				213, --banana, little blue fish, little orange fish
				246,
				247,
				248, --dead rat, dead squirrel, dead rabbit
				249,
				250,
				53
			} --dead snake, chicken, snake meat

			local sellitems = {
				212,
				213, --banana, little blue fish, little orange fish
				246,
				247,
				248, --dead rat, dead squirrel, dead rabbit
				249,
				250,
				53
			} --dead snake, chicken, snake meat

			table.insert(opts, "Buy")
			table.insert(opts, "Sell")
			if player.level <= 79 and player.quest["chef"] == 0 then
				table.insert(opts, "I'm looking for work")
			end
			if player.level >= 80 and player.quest["chef"] == 0 then
				table.insert(opts, "I'm here to help!")
			end
			if player.quest["chef"] == 1 then
				table.insert(opts, "I brought your ingredients")
			end
			if player.quest["chef"] >= 2 then
				table.insert(sellitems, 392)
			end
			if player.quest["chef"] >= 2 then
				table.insert(sellitems, 393)
			end
			if player.level >= 80 and player.quest["chef"] == 2 then
				table.insert(opts, "Need more ingredients?")
			end
			if player.quest["chef"] == 3 then
				table.insert(opts, "I have your Frog Legs")
			end
			if player.quest["chef"] >= 4 then
				table.insert(sellitems, 406)
			end
			if player.level >= 80 and player.quest["chef"] == 4 then
				table.insert(opts, "How's business?")
			end
			if player.quest["chef"] == 5 then
				table.insert(opts, "Living Roots")
			end

			if player.quest["chef"] == 6 then
				table.insert(opts, "Daily Stew")
			end

			if player.quest["angry_guard"] == 4 then
				table.insert(opts, "A meal for Edd")
			end

			menu = player:menuString(name .. "Welcome to my kitchen! How can I help you?", opts)

			if menu == "Buy" then
				chef_shop.buy(player)
			elseif menu == "Sell" then
				chef_shop.sell(player)
			elseif menu == "I'm looking for work" then
				player:dialogSeq(
					{
						t,
						name ..
							"You'd better keep on looking. The only favor I need would be a death sentence for someone as weak as you."
					},
					1
				)
			elseif menu == "I'm here to help!" then
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
				player.quest["chef"] = 1
				player:msg(4, "[Quest Updated] Bring 100 Lobster Claw and 100 Jellyfish Tentacle to the Chef!", player.ID)
			elseif menu == "I brought your ingredients" then
				if player:hasItem("lobster_claw", 100) == true and player:hasItem("jellyfish_tentacle", 100) == true then
					if player:removeItem("lobster_claw", 100) == true and player:removeItem("jellyfish_tentacle", 100) == true then
						player.quest["chef"] = 2
						giveXP(player, 5000000)
						player:addGold(50000)
						finishedQuest(player)
						player:calcStat()
						player:sendStatus()
						player:msg(4, "[Quest Complete] You helped out a chef and got a reward!", player.ID)
						player:dialogSeq(
							{
								t,
								name .. "Oh boy, you did it! You actually hunted monsters on Tonguspur Beach?!",
								name .. "You must be really strong.",
								name .. "For doing me such a big favor, I'll pay you way more than market price on these tentacles and claws.",
								name .. "I'd be happy to buy as many extras as you have for the standard price as well."
							},
							1
						)
					else
						player:dialogSeq(
							{
								t,
								name .. "Aren't you going to bring me some Lobster Claws and Jellyfish Tentacles?",
								name .. "You can find Lobsters and Jellyfish on Tonguspur Beach, west of here."
							},
							1
						)
					end
				else
					player:dialogSeq(
						{
							t,
							name .. "Aren't you going to bring me some Lobster Claws and Jellyfish Tentacles?",
							name .. "You can find Lobsters and Jellyfish on Tonguspur Beach, west of here."
						},
						1
					)
				end
			elseif menu == "Need more ingredients?" then
				player.quest["chef"] = 3
				player:msg(4, "[Quest Updated] Bring 300 Frog Legs to the Chef!", player.ID)
				player:dialogSeq(
					{
						t,
						name .. "You certainly proved to be strong and reliable, so I'll let you do me another favor if you like.",
						name .. "I've always wanted to try cooking the frogs that live in Frog Swamp.",
						name .. "But no one has ever been able to bring them back to me while they're fresh enough to eat.",
						name .. "If you're feeling tough, go to the Frog Swamp and bring me back some Frog Legs.",
						name .. "If I'm going to make enough for everyone in town, 300 Frog Legs should be enough."
					},
					1
				)
			elseif menu == "I have your Frog Legs" then
				if player:hasItem("frog_leg", 300) == true then
					if player:removeItem("frog_leg", 300) == true then
						player.quest["chef"] = 4
						giveXP(player, 6000000)
						player:addGold(75000)
						finishedQuest(player)
						player:calcStat()
						player:sendStatus()
						player:msg(4, "[Quest Complete] You helped out a chef and got a reward! (Again!)", player.ID)
						player:dialogSeq(
							{
								t,
								name .. "Hot damn, a whole pile of Frog Legs!",
								name .. "And fresh too! I can't thank you enough. Here's some money for your trouble.",
								name .. "Oh, and if you happen to go frog hunting again, I'll buy as many Frog Legs as you can carry."
							},
							1
						)
					else
						player:dialogSeq(
							{
								t,
								name .. "Aren't you going to bring me some Frog Legs?",
								name .. "You can find Frogs in Frog Swamp, north of Tonguspur Beach."
							},
							1
						)
					end
				else
					player:dialogSeq(
						{
							t,
							name .. "Aren't you going to bring me some Frog Legs?",
							name .. "You can find Frogs in Frog Swamp, north of Tonguspur Beach."
						},
						1
					)
				end
			elseif menu == "How's business?" then
				player.quest["chef"] = 5
				player:msg(4, "[Quest Updated] Bring 10 Living Roots to the Chef!", player.ID)
				player:dialogSeq(
					{
						t,
						name .. "Business is booming!",
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
			elseif menu == "Living Roots" then
				if player:hasItem("living_root", 10) == true then
					if player:removeItem("living_root", 10) == true then
						player:addItem("tonguspur_tankard", 1)
						player.registry["daily_root_stew_timer"] = os.time() + 43200
						player.quest["chef"] = 6
						giveXP(player, 7500000)
						player:addGold(75000)
						finishedQuest(player)
						player:calcStat()
						player:sendStatus()
						player:msg(4, "[Quest Complete] You helped out a chef and got a reward! (Yet again!)", player.ID)
						tonguspur_chef.legend(player)
						player:dialogSeq(
							{
								t,
								name .. "I knew you'd come through with the roots!!",
								name .. "These are gonna make a great pot of stew for today, but it won't be enough.",
								name .. "It's never enough.",
								name ..
									"This stew is real popular. I'm gonna need a batch of these roots every day if I'm going to keep making it.",
								name .. "I'll keep paying you every day if you keep on bringing me these roots.",
								name .. "Also, since you've been such a big help, take one of these souvineer tankards on the house."
							},
							1
						)
					else
						player:dialogSeq({t, name .. "What, no roots?"}, 1)
					end
				else
					player:dialogSeq({t, name .. "What, no roots?"}, 1)
				end
			elseif menu == "Daily Stew" then
				if player.registry["daily_root_stew_timer"] >= os.time() then
					player:dialogSeq(
						{
							t,
							name ..
								"I already made today's stew, but you can bring me more roots tomorrow.\n\n(Available again in: " ..
									math.ceil(((player.registry["daily_root_stew_timer"] - os.time()) / 3600)) .. " hours)"
						},
						1
					)
				else
					if player.quest["daily_root_stew"] == 0 then
						menu = player:menuString(name .. "So you're going get me some Living Roots for my stew?", {"Yes", "No"})

						if menu == "Yes" then
							player.quest["daily_root_stew"] = 1
							player:dialogSeq({t, name .. "Great! Bring me 10 living roots."}, 1)
							player:msg(4, "[Daily Stew]: Bring the Chef 10 Living Roots", player.ID)
						elseif menu == "No" then
							player:dialogSeq({t, name .. "Ohh, Um... Maybe another time."}, 1)
						end
					elseif player.quest["daily_root_stew"] == 1 then
						if player:hasItem("living_root", 10) == true then
							if player:removeItem("living_root", 10) == true then
								player.registry["daily_root_stew_timer"] = os.time() + 43200
								player.quest["daily_root_stew"] = 0
								giveXP(player, 7500000)
								player:addGold(75000)
								finishedQuest(player)
								player:calcStat()
								player:sendStatus()
								tonguspur_chef.legend(player)
								player:dialogSeq({t, name .. "Great work! Come back tomorrow if you want to bring me more roots."}, 1)
								player:msg(4, "[Daily Stew] You helped the Chef make stew and got a reward!", player.ID)
							else
								player:dialogSeq({t, name .. "What, no roots?"}, 1)
							end
						else
							player:dialogSeq({t, name .. "What, no roots?"}, 1)
						end
					end
				end
			elseif menu == "A meal for Edd" then
				player.quest["angry_guard"] = 5
				player:addItem("handwritten_recipe", 1)
				player:dialogSeq(
					{
						t,
						name .. "Edd? Yeah, I know Edd.",
						name .. "Let me guess, his legendary temper is causing you trouble.",
						name ..
							"Last time Edd was in a bad mood, he came in here and ordered my Orcish Delight, and I tell you I've never seen anyone perk up so fast.",
						name .. "Edd's my friend, so I'd make it for him anytime, but today I'm crazy busy prepping for the Royal Feast.",
						name ..
							"I can give you a copy of the recipe, but you'll have to find a trained chef to read it. No one else will be able to, I'm afraid.",
						name .. "I'm sure you can find a chef somewhere who isn't doing anything."
					},
					1
				)
				player:msg(4, "[Quest Update] Bring the recipe to another Chef!", player.ID)
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
	end,
	legend = function(player)
		if player:hasLegend("daily_stew") then
			player:removeLegendbyName("daily_stew")
		end

		if player.registry["daily_root_stew_complete"] > 0 then
			player.registry["daily_root_stew_complete"] = player.registry["daily_root_stew_complete"] + 1
			player:addLegend(
				"Helped the Chef make " .. player.registry["daily_root_stew_complete"] .. " pots of stew",
				"daily_stew",
				158,
				16
			)
		else
			player.registry["daily_root_stew_complete"] = 1
			player:addLegend("Helped the Chef make 1 pot of stew", "daily_stew", 158, 16)
		end

		if player.registry["daily_root_stew_complete"] == 25 then
			broadcast(-1, "[TITLE]: " .. player.name .. " has just earned the title 'Stew Lover'!")
		end
		if player.registry["daily_root_stew_complete"] == 100 then
			broadcast(-1, "[TITLE]: " .. player.name .. " has just earned the title 'Stew Fanatic'!")
		end
	end,
	nearbyPlayers = function(npc)
		local pc = npc:getObjectsInArea(BL_PC)
		local m, x, y = npc.m, npc.x, npc.y

		if #pc > 0 then
			for i = 1, #pc do
				if pc[i].level >= 80 and (pc[i].quest["chef"] == 0 or pc[i].quest["chef"] == 2 or pc[i].quest["chef"] == 4) then
					pc[i]:selfAnimationXY(pc[i].ID, 248, x, y)
				end
			end
		end
	end
}
