oliver = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			local t2 = {graphic = convertGraphic(npc.look, "monster"), color = 0}

			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local magicBag = {graphic = convertGraphic(4855, "item"), color = 0}

			local opts = {}

			if player.level < 50 then
				table.insert(opts, "Who Are You!")
			end

			if
				player.level >= 50 and player.quest["christmas_gift"] == 0 and
					(player.quest["ernest_xmas"] < 5 or player.quest["ernest_xmas"] > 5)
			 then
				table.insert(opts, "Who are you supposed to be?")
			end
			if player.level >= 50 and player.quest["christmas_gift"] == 1 and player.quest["ernest_xmas"] < 5 then
				table.insert(opts, "Thank you.")
			end

			if player.level >= 50 and player.quest["ernest_xmas"] == 5 and player.quest["christmas_gift"] == 0 then
				table.insert(opts, "Merry Christmas!<G>")
			end -- Good
			if player.level >= 50 and player.quest["ernest_xmas"] == 5 and player.quest["christmas_gift"] == 1 then
				table.insert(opts, "Will You Be Santa?<G>")
			end -- Good
			if player.level >= 50 and player.quest["ernest_xmas"] == 5 and player.quest["christmas_gift"] == 0 then
				table.insert(opts, "What do you have there?<N>")
			end -- Neutral
			if player.level >= 50 and player.quest["ernest_xmas"] == 5 and player.quest["christmas_gift"] == 1 then
				table.insert(opts, "I want this Bag!<N>")
			end -- Neutral
			if player.level >= 50 and player.quest["ernest_xmas"] == 5 and player.quest["christmas_gift"] == 0 then
				table.insert(opts, "Give me one NOW!<E>")
			end -- Evil
			if player.level >= 50 and player.quest["ernest_xmas"] == 5 and player.quest["christmas_gift"] == 1 then
				table.insert(opts, "Dread My Return!<E>")
			end -- Evil

			if
				player.level >= 50 and player.quest["ernest_xmas"] >= 6 and player.quest["ernest_xmas"] <= 8 and
					player.quest["good_xmas"] == 1
			 then
				table.insert(opts, "Good Luck!!!<G>")
			end -- Good
			if
				player.level >= 50 and player.quest["ernest_xmas"] >= 6 and player.quest["ernest_xmas"] <= 8 and
					player.quest["neutral_xmas"] == 1
			 then
				table.insert(opts, "Thanks Again!<N>")
			end -- Neutral
			if
				player.level >= 50 and player.quest["ernest_xmas"] >= 6 and player.quest["ernest_xmas"] <= 8 and
					player.quest["evil_xmas"] == 1
			 then
				table.insert(opts, "Good Choice!<E>")
			end -- Evil

			if
				player.level >= 50 and player.quest["ernest_xmas"] >= 9 and player.quest["christmas_gift"] == 1 and
					player.quest["good_xmas"] == 1
			 then
				table.insert(opts, "Christmas is Saved!<G>")
			end -- Good
			if
				player.level >= 50 and player.quest["ernest_xmas"] >= 9 and player.quest["christmas_gift"] == 1 and
					player.quest["neutral_xmas"] == 1
			 then
				table.insert(opts, "Enjoy the Holiday!<N>")
			end -- Neutral
			if
				player.level >= 50 and player.quest["ernest_xmas"] >= 9 and player.quest["christmas_gift"] == 1 and
					player.quest["evil_xmas"] == 1
			 then
				table.insert(opts, "You Ended Christmas!<E>")
			end -- Evil

			if player.level < 50 then
				words = "" .. player.name .. ", Return when your mind is more developed."
			elseif
				player.level >= 50 and player.quest["ernest_xmas"] >= 0 and player.quest["ernest_xmas"] < 5 and
					player.quest["christmas_gift"] == 0
			 then
				words = "Hello There, " .. player.name .. ", I have a present for you!"
			elseif
				player.level >= 50 and player.quest["ernest_xmas"] >= 0 and player.quest["ernest_xmas"] < 5 and
					player.quest["christmas_gift"] == 1
			 then
				words = "Hello Again, " .. player.name .. ", I do not have another present for you!"
			elseif player.level >= 50 and player.quest["ernest_xmas"] == 5 and player.quest["christmas_gift"] == 0 then
				words = "Hello There, " .. player.name .. ", I have a present for you!"
			elseif player.level >= 50 and player.quest["ernest_xmas"] == 5 and player.quest["christmas_gift"] == 1 then
				words = "Hello Again, " .. player.name .. ", I do not have another present for you!"
			elseif player.level >= 50 and player.quest["good_xmas"] == 1 then
				words = "" .. player.name .. ", I will do my best to bring Joy to the Worlds!"
			elseif player.level >= 50 and player.quest["neutral_xmas"] == 1 then
				words = "" .. player.name .. ", I will still do what I can to bring Joy to this World."
			elseif player.level >= 50 and player.quest["evil_xmas"] == 1 then
				words = "" .. player.name .. ", I, I, I am just going to do my rounds here and go home!"
			end

			menu = player:menuString(name .. "" .. words, opts)

			if menu == "Who Are You!" then
				player:dialogSeq(
					{
						t,
						name ..
							"I am just a guy out here delivering happiness and joy to those strong enough to utilize the power I possess."
					},
					1
				)
			elseif menu == "Who are you supposed to be?" then
				player:dialogSeq(
					{
						t,
						name ..
							"I am just a guy out here delivering happiness and joy to those strong enough to utilize the power I possess.",
						name .. "You look like you have potential. Why don't you take this. May it assist you on your journey!"
					},
					1
				)
				player.quest["christmas_gift"] = 1

				local sub_acc_rand = math.random(1, 100)

				if sub_acc_rand >= 1 and sub_acc_rand <= 50 then
					player:addItem("festive_bracer", 1) -- Fighter Sub Accessory Beta Event
				elseif sub_acc_rand >= 51 and sub_acc_rand <= 100 then
					player:addItem("festive_ring", 1) -- Caster  Sub Accessory Beta Event
				end
				player:msg(4, "You have received an item.", player.ID)
				xmasWarp(npc) --(used to send npc after gift given)
			elseif menu == "Thank you." then
				player:dialogSeq({t, name .. "You're welcome! Have a Merry Christmas, " .. player.name .. "!"}, 1)
			elseif menu == "Merry Christmas!<G>" then
				player:dialogSeq(
					{
						t,
						name ..
							"Hello, " ..
								player.name .. ", I have a little something here for you. You should take this, then you can talk to me.",
						name .. "I can tell you have something you would like to talk about but first you must take your present!"
					},
					1
				)
				player.quest["christmas_gift"] = 1

				local sub_acc_rand = math.random(1, 100)

				if sub_acc_rand >= 1 and sub_acc_rand <= 50 then
					player:addItem("festive_bracer", 1) -- Fighter Sub Accessory Beta Event
				elseif sub_acc_rand >= 51 and sub_acc_rand <= 100 then
					player:addItem("festive_ring", 1) -- Caster  Sub Accessory Beta Event
				end
				player:msg(4, "You have received an item.", player.ID)
				karma.good(player)
			elseif menu == "Will You Be Santa?<G>" then
				player:dialogSeq(
					{
						t,
						name .. "Well you don't hold back at all now do you. Where is this all coming from?",
						magicBag,
						"***The Man listens to your tale about Santa needing a replacement.***",
						t,
						name .. "How could I turn away from you when you look at me like that.",
						t,
						name .. "You can tell Santa, and your pal Ernest, that I will Accept.",
						name .. "I will meet them at the Game Room after I make my last deliveries around here."
					},
					1
				)
				player.quest["ernest_xmas"] = 6
				player.quest["good_xmas"] = 1
				player:msg(4, "[Quest Completed] Tell Santa you convinced Oliver to become the Official Santa", player.ID)
				finishedQuest(player)
				xmasWarp(npc) --(used to send npc after gift given)
			elseif menu == "What do you have there?<N>" then
				player:dialogSeq(
					{
						t,
						name .. "Quite the ambitious one aren't you, " .. player.name .. ", no worries though.",
						name .. "Here take this, let it serve you well."
					},
					1
				)
				player.quest["christmas_gift"] = 1

				local sub_acc_rand = math.random(1, 100)

				if sub_acc_rand >= 1 and sub_acc_rand <= 50 then
					player:addItem("festive_bracer", 1) -- Fighter Sub Accessory Beta Event
				elseif sub_acc_rand >= 51 and sub_acc_rand <= 100 then
					player:addItem("festive_ring", 1) -- Caster  Sub Accessory Beta Event
				end
				player:msg(4, "You have received an item.", player.ID)
				karma.neutral(player)
			elseif menu == "I want this Bag!<N>" then
				player:dialogSeq(
					{
						t,
						name .. "I can sense Magic coming from that bag. What is it for?",
						name .. "***The Man listens to your tale about Santa not having the strength to continue delivering.***",
						name .. "That is a very sad tale. I get a great deal of satifaction spending all year creating new things.",
						name .. "I have dedicated my life to it, but if you want to take his place, then you should.",
						magicBag,
						"I wish you luck in your Journey. Until we meet again."
					},
					1
				)
				player.quest["ernest_xmas"] = 6
				player.quest["neutral_xmas"] = 1
				player:msg(4, "[Quest Completed] Convinced Oliver to let you become the Official Santa", player.ID)
				player:addItem("santas_sack", 1) -- Santa Sack for Neutral 2016 Christmas
				player:msg(4, "You have received an item.", player.ID)
				finishedQuest(player)
				xmasWarp(npc) --(used to send npc after gift given)
			elseif menu == "Give me one NOW!<E>" then
				player:dialogSeq(
					{
						t,
						name .. "Well Look, " .. player.name .. " is a tough guy. Fine. Take one. Now take your attitude somewhere else."
					},
					1
				)
				player.quest["christmas_gift"] = 1

				local sub_acc_rand = math.random(1, 100)

				if sub_acc_rand >= 1 and sub_acc_rand <= 50 then
					player:addItem("festive_bracer", 1) -- Fighter Sub Accessory Beta Event
				elseif sub_acc_rand >= 51 and sub_acc_rand <= 100 then
					player:addItem("festive_ring", 1) -- Caster  Sub Accessory Beta Event
				end
				player:msg(4, "You have received an item.", player.ID)
				karma.bad(player)
			elseif menu == "Dread My Return!<E>" then
				player:dialogSeq(
					{
						t,
						name .. "You again. Tell me, why have you returned?",
						name .. "***The Man listens to a tale of how Santa is quitting and the danger is not worth the effort.***",
						name ..
							"***The Man continues listening about how there are worlds with beasts that Santa must fight every year to deliver presents.***",
						name .. "WOW, I can not believe someone could so such things alone. I could never do that, ever.",
						name .. "I am sorry, but I can not become Santa. You must tell them for me."
					},
					1
				)
				player.quest["ernest_xmas"] = 6
				player.quest["evil_xmas"] = 1
				player:msg(4, "[Quest Completed] Convinced Oliver not to become the Official Santa", player.ID)
				player:addItem("coal_necklace", 1)
				player:msg(4, "You have received an item.", player.ID)
				player:addLegend("Worked Against Ernest to Snuff Out the Magic of Christmas " .. curT(), "xmasevil2016", 211, 12)
				player:msg(4, "You have received a new Legend Mark.", player.ID)
				karma.bad(player)
				finishedQuest(player)
				xmasWarp(npc) --(used to send npc after gift given)
			elseif menu == "Good Luck!!!<G>" then
				player:dialogSeq(
					{
						t,
						name .. "Thank you, " .. player.name .. ", Merry Christmas.",
						name .. "Be sure to let Santa and Ernest know I accept the Duties of Santa!",
						name .. "You can also see if Ernest wants to ride in my sleigh for the big night!"
					},
					1
				)
			elseif menu == "Thanks Again!<N>" then
				player:dialogSeq(
					{
						t,
						name .. "I am a little relieved that you are taking on those responsibilities.",
						name .. "Taking santa's place is huge. Almost unimaginable. So Humbling. You are going to do great things.",
						name .. "Sure would have been nice to have invited someone along for the ride that night! Good luck!"
					},
					1
				)
			elseif menu == "Good Choice!<E>" then
				player:dialogSeq(
					{
						t,
						name .. "I can't believe anyone would every want to have to try and perform those duties.",
						name .. "Thank you for saving me from that damnation!",
						name .. "Poor Ernest will be heartbroken but maybe he can do it himself!"
					},
					1
				)
			elseif menu == "Christmas is Saved!<G>" then
				player:dialogSeq(
					{
						t,
						name .. "I will be delivering presents to everyone this year.",
						name .. "All the worlds owe you a debt of gratitude!"
					},
					1
				)
			elseif menu == "Enjoy the Holiday!<N>" then
				player:dialogSeq(
					{
						t,
						name .. "You used the bag for your own purposes!",
						name .. "I will go find Santa and see if there is any other way.",
						name .. "You are selfish!"
					},
					1
				)
			elseif menu == "You Ended Christmas!<E>" then
				player:dialogSeq(
					{
						t,
						name .. "No, I didn't. You are a liar and a scumbag.",
						name .. "I will talk with santa and see if there is anything that can be done.",
						name .. "You are on my Naughty List! Now leave before I make your Naughty List Permenant!!!"
					},
					1
				)
			end
		end
	),
	nearbyPlayers = function(npc)
		local pc = npc:getObjectsInArea(BL_PC)
		local m, x, y = npc.m, npc.x, npc.y

		if #pc > 0 then
			for i = 1, #pc do
				if pc[i].level >= 50 and (pc[i].quest["christmas_gift"] == 0 or pc[i].quest["ernest_xmas"] == 5) then
					pc[i]:selfAnimationXY(pc[i].ID, 248, x, y)
				end
			end
		end
	end
}
