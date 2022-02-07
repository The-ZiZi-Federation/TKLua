santa = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local magicBag = {graphic = convertGraphic(4855, "item"), color = 0}

			local opts = {}

			if player.level < 50 then
				table.insert(opts, "You Look Lost!")
			end
			if player.level >= 50 and player.quest["ernest_xmas"] == 1 then
				table.insert(opts, "Hello Santa!")
			end
			if player.level >= 50 and player.quest["ernest_xmas"] >= 2 and player.quest["ernest_xmas"] <= 5 then
				table.insert(opts, "Please tell me again!")
			end

			if player.level >= 50 and player.quest["ernest_xmas"] == 6 and player.quest["good_xmas"] == 1 then
				table.insert(opts, "Christmas is Saved!")
			end -- Good
			if player.level >= 50 and player.quest["ernest_xmas"] == 6 and player.quest["neutral_xmas"] == 1 then
				table.insert(opts, "Ran out of Time!")
			end -- Neutral
			if player.level >= 50 and player.quest["ernest_xmas"] == 6 and player.quest["evil_xmas"] == 1 then
				table.insert(opts, "Christmas is Over!")
			end -- Evil

			if
				player.level >= 50 and player.quest["ernest_xmas"] >= 7 and player.quest["ernest_xmas"] <= 8 and
					player.quest["good_xmas"] == 1
			 then
				table.insert(opts, "Ernest will be Happy!")
			end -- Good
			if
				player.level >= 50 and player.quest["ernest_xmas"] >= 7 and player.quest["ernest_xmas"] <= 8 and
					player.quest["neutral_xmas"] == 1
			 then
				table.insert(opts, "Maybe Next Time!")
			end -- Neutral
			if
				player.level >= 50 and player.quest["ernest_xmas"] >= 7 and player.quest["ernest_xmas"] <= 8 and
					player.quest["evil_xmas"] == 1
			 then
				table.insert(opts, "Get a Job ya Bum!")
			end -- Evil

			if player.level >= 50 and player.quest["ernest_xmas"] >= 9 and player.quest["good_xmas"] == 1 then
				table.insert(opts, "Happy New Years!")
			end -- Good
			if player.level >= 50 and player.quest["ernest_xmas"] >= 9 and player.quest["neutral_xmas"] == 1 then
				table.insert(opts, "It will all work out!")
			end -- Neutral
			if player.level >= 50 and player.quest["ernest_xmas"] >= 9 and player.quest["evil_xmas"] == 1 then
				table.insert(opts, "I will ruin you!")
			end -- Evil

			if player.level < 50 then
				words = "The cats are brown now! 14 Elves are needed. No not 15. Hey, a brown cat, cool!"
			elseif player.level >= 50 and player.quest["ernest_xmas"] >= 0 and player.quest["ernest_xmas"] <= 5 then
				words = "Woah, " .. player.name .. ", This bag is not right, I can't help you."
			elseif player.level >= 50 and player.quest["good_xmas"] == 1 then
				words = "Thank you, " .. player.name .. ", I can feel the Magic of Christmas Strengthening!"
			elseif player.level >= 50 and player.quest["neutral_xmas"] == 1 then
				words = "This is Terrible, " .. player.name .. ", Good thing there are contingencies to save Christmas!"
			elseif player.level >= 50 and player.quest["evil_xmas"] == 1 then
				words = "Naughty, " .. player.name .. ", But your efforts were all in vain!"
			end

			menu = player:menuString(name .. "" .. words, opts)

			if menu == "You Look Lost!" then
				player:dialogSeq(
					{t, name .. "I don't think I have enough magic left for another trip.\nNow that is a pretty brown cat."},
					1
				)
			elseif menu == "Hello Santa!" then
				player:dialogSeq(
					{
						t,
						name ..
							"Well Hello there, " ..
								player.name .. ". You know there was a time when I could remember...\nEvery name on all my lists.",
						name ..
							"All over the worlds...\nI knew where I was going at all time...\nNow I have trouble recalling...\nWho was Naughty and who was Nice.",
						magicBag,
						"Who asked for a toy truck, who wanted a bicycle, what world I am on, What world am I on?",
						t,
						name .. "I am just gonna stay here and play some Janken with Carter and Perkins.",
						name .. "Could you help my Dear Friend Ernest find me a replacement."
					},
					1
				)
				player.quest["ernest_xmas"] = 2
				finishedQuest(player)
				player:msg(4, "[Quest Update] Help Ernest Find santa's replacement", player.ID)
			elseif menu == "Please tell me again!" then
				player:dialogSeq(
					{
						t,
						name .. "I don't really remember what I said. Where is that sweet little girl who was with me?",
						name .. "Please help my Dear friend Ernest find my replacement before it is too late!"
					},
					1
				)
			elseif menu == "Christmas is Saved!" then
				player:dialogSeq(
					{
						t,
						name .. "Well, it's all settled then.",
						name ..
							"Thank you for all of your help! You have done a tremendous service to all that is righteous in this dark world.",
						magicBag,
						"With the Christmas Magic strengthened through the passing to a new Santa, my mind is clear. I'll be able to enjoy my final years in a quiet retirement.",
						t,
						name .. "After living these past 128 years as 'Santa Claus', it will be nice to just be 'Seth' again for a while.",
						name .. "Have a very merry Christmas, " .. player.name .. ", this Christmas and for all the Christmases to come."
					},
					1
				)
				player.quest["ernest_xmas"] = 7
				player:addItem("heros_necklace", 1) -- Level 99 Good Align Beta Christmas Necklace 2016
				player:msg(4, "You have received an item.", player.ID)
				player:addLegend("Helped Ernest Save Christmas " .. curT(), "xmasgood2016", 211, 15)
				player:msg(4, "You have received a new Legend Mark.", player.ID)
				karma.good(player)
				finishedQuest(player)
				player:msg(4, "[Quest Completed] Santa gives you a person present for your assistance.", player.ID)
			elseif menu == "Ran out of Time!" then
				player:dialogSeq(
					{
						t,
						name .. "Out of time?",
						name .. "This is all a game to you, isn't it?",
						name .. "Well, I had wanted this to be my last year.",
						name .. "It is getting so difficult to move around in dangerous places lately.",
						magicBag,
						"Did you think that was my only bag? I am old, decrepit, senile, and dying, but I am NOT a fool.",
						t,
						name .. "Enjoy your trinket, little one.",
						name .. "I shall see you next year.",
						name .. "Which list are you planning to be on?"
					},
					1
				)
				player.quest["ernest_xmas"] = 7
				finishedQuest(player)
				player:msg(4, "[Quest Completed] You're selfish but you got a shiny new item for it.", player.ID)
			elseif menu == "Christmas is Over!" then
				player:dialogSeq(
					{
						t,
						name .. "You dare tell ME that Christmas is over?",
						name .. "You could kill me where I stand here today, and Christmas would not be over.",
						name .. "As long as the tiniest fragment of a Christmas spirit still lives on in this world, it will grow.",
						magicBag,
						"It is YOUR efforts that are in vain, fool, not mine.",
						t,
						name .. "Christmas will live on. Do try to put up a better fight next year, eh?"
					},
					1
				)
				player.quest["ernest_xmas"] = 7
				finishedQuest(player)
				player:msg(4, "[Quest Completed] You are conniving but Christmas was not Destroyed.", player.ID)
			elseif menu == "Ernest will be Happy!" then
				player:dialogSeq(
					{
						t,
						name .. "Well, they do say ignorance is bliss...",
						name .. "Do tell him I said Merry Christmas, will you?"
					},
					1
				)
			elseif menu == "Maybe Next Time!" then
				player:dialogSeq(
					{
						t,
						name ..
							"You'd have an easier time getting treasures out of my sack if you tried to get on the 'nice' list rather than skirt the system entirely.",
						name .. "But your type doesn't want to hear that I suppose.",
						name .. "Just think about it. You have an entire year to change your ways before next Christmas."
					},
					1
				)
			elseif menu == "Get a Job ya Bum!" then
				player:dialogSeq(
					{
						t,
						name .. "Get away from me.",
						name .. "My powers may be fading, but I still have more then enough to destroy you."
					},
					1
				)
			elseif menu == "Happy New Years!" then
				player:dialogSeq(
					{
						t,
						name .. "To you as well,",
						name .. "And many more to come, for you and your kin."
					},
					1
				)
			elseif menu == "It will all work out!" then
				player:dialogSeq(
					{
						t,
						name .. "Things like this always have a way of working out for me.",
						name .. "You, though, you are on a bad road. Please think about your decisions carefully."
					},
					1
				)
			elseif menu == "I will ruin you!" then
				player:dialogSeq(
					{
						t,
						name .. "Try again next year, if you think you can.",
						name ..
							"Santa will be waiting for you, " .. player.name .. ". Your name is the first one on next year's 'naughty' list."
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
				if pc[i].level >= 50 and (pc[i].quest["ernest_xmas"] == 1 or pc[i].quest["ernest_xmas"] == 6) then
					pc[i]:selfAnimationXY(pc[i].ID, 248, x, y)
				end
			end
		end
	end
}
