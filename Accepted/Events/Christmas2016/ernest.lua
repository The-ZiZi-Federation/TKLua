ernest = {
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
				table.insert(opts, "Looking for Something?")
			end
			if player.level >= 50 and player.quest["ernest_xmas"] == 0 then
				table.insert(opts, "What's your story?")
			end
			if player.level >= 50 and player.quest["ernest_xmas"] == 1 then
				table.insert(opts, "What should I do?")
			end
			if player.level >= 50 and player.quest["ernest_xmas"] == 2 then
				table.insert(opts, "Santa is fine!")
			end
			if player.level >= 50 and player.quest["ernest_xmas"] == 3 then
				table.insert(opts, "Where was she seen?")
			end
			if player.level >= 50 and player.quest["ernest_xmas"] == 4 then
				table.insert(opts, "I have Santa's Bag!")
			end
			if player.level >= 50 and player.quest["ernest_xmas"] == 5 then
				table.insert(opts, "Where can I find him?")
			end

			if
				player.level >= 50 and player.quest["ernest_xmas"] >= 6 and player.quest["ernest_xmas"] <= 8 and
					player.quest["good_xmas"] == 1
			 then
				table.insert(opts, "Christmas Will Happen!")
			end -- Good
			if
				player.level >= 50 and player.quest["ernest_xmas"] >= 6 and player.quest["ernest_xmas"] <= 8 and
					player.quest["neutral_xmas"] == 1
			 then
				table.insert(opts, "Some Might get Mad!")
			end -- Neutral
			if
				player.level >= 50 and player.quest["ernest_xmas"] >= 6 and player.quest["ernest_xmas"] <= 8 and
					player.quest["evil_xmas"] == 1
			 then
				table.insert(opts, "You Failed Christmas!")
			end -- Evil

			if player.level >= 50 and player.quest["ernest_xmas"] == 9 and player.quest["good_xmas"] == 1 then
				table.insert(opts, "Happy New Year!")
			end -- Good
			if player.level >= 50 and player.quest["ernest_xmas"] == 9 and player.quest["neutral_xmas"] == 1 then
				table.insert(opts, "See ya Around!")
			end -- Neutral
			if player.level >= 50 and player.quest["ernest_xmas"] == 9 and player.quest["evil_xmas"] == 1 then
				table.insert(opts, "Good Riddance!")
			end -- Evil

			if player.level < 50 then
				words = "Seen any adults around here kid? Time is running out!"
			elseif player.level >= 50 and player.quest["ernest_xmas"] >= 0 and player.quest["ernest_xmas"] <= 5 then
				words = "Hello There, I am Ernest, Santa needs our help!"
			elseif player.level >= 50 and player.quest["good_xmas"] == 1 then
				words = "" .. player.name .. ", You did it! How could the worlds ever thank you enough!"
			elseif player.level >= 50 and player.quest["neutral_xmas"] == 1 then
				words = "" .. player.name .. ", How could this happen. What will come of Christmas?"
			elseif player.level >= 50 and player.quest["evil_xmas"] == 1 then
				words = "" .. player.name .. ", You are a disgrace. How could you do something so cruel!"
			end

			menu = player:menuString(name .. "" .. words, opts)

			if menu == "Looking for Something?" then
				player:dialogSeq(
					{t, name .. "I don't think you can help me, but maybe you can point me towards someone more qualified!"},
					1
				)
			elseif menu == "What's your story?" then
				player:dialogSeq(
					{
						t,
						name .. "Santa has asked me, Ernest, to help him find a replacement Santa for this years festivities!",
						name .. "That's right. Santa needs someone new to take over the duties of delivering presents to all the worlds.",
						name .. "Unfortunately, a person with the right qualifications...\nIs difficult to find.",
						name .. "But I'll tell you what, It's a smart cookie...\nThat knows when to hang up the old cleats.",
						name .. "Anyways, I don't know where Santa wandered off to. He was being watched by Harmony.",
						name .. "They must have gone for a walk or something. Go find Santa and I will start looking for his replacement."
					},
					1
				)
				player.quest["ernest_xmas"] = 1
				finishedQuest(player)
				player:msg(4, "[Quest Update] Find Santa somewhere in Hon City Map and Buildings!", player.ID)
			elseif menu == "What should I do?" then
				player:dialogSeq(
					{t, name .. "You go find Santa. He can't have gone too far. Guards say he did not leave the City Gates."},
					1
				)
			elseif menu == "Santa is fine!" then
				player:dialogSeq(
					{
						t,
						name .. "That's great but we have a new problem now...\nSanta's magic sack of toys...\nIt's just feathers.",
						magicBag,
						"The real sack was taken by Harmony. Yea, yea, I know. She walked him off, and while I was talking to you, she replaced it.",
						t,
						name .. "A guard spotted her leaving through the Cities South Gate."
					},
					1
				)
				player.quest["ernest_xmas"] = 3
				finishedQuest(player)
				player:msg(4, "[Quest Update] Find Harmony. Guards say she left out South Gate Hon!", player.ID)
			elseif menu == "Where was she seen?" then
				player:dialogSeq(
					{
						t,
						name .. "A guard spotted her leaving through the Cities South Gate.",
						name .. "You have to find her quick. Christmas may very well depend on it!"
					},
					1
				)
			elseif menu == "I have Santa's Bag!" then
				player:dialogSeq(
					{
						t,
						name .. "This is great I knew you could do it. Nope, never doubted you'd do the right thing.",
						name .. "Well. Maybe a little bit. I just got to thinking about you and all that magic.",
						name .. "I mean I did not consider you a prospect for a potential Santa Replacement.",
						name .. "But let's not delay. I have found someone who would be great for a Replacement Santa.",
						name ..
							"On this world, someone has already taken initiative to keep the magic of christmas alive in these dark times.",
						name ..
							"His name is Oliver and has been seen handing out presents in the following areas:\nWest Shores of Hon\nHon Harbor\nCity of Hon\nTonguspur Village.",
						name .. "If you find this guy, please let him know that we need him to become the new Santa"
					},
					1
				)
				player.quest["ernest_xmas"] = 5
				finishedQuest(player)
				player:msg(4, "[Quest Update] Find Oliver in East, Central, or West Hon, or Tonguspur Village!", player.ID)
			elseif menu == "Where can I find him?" then
				player:dialogSeq(
					{
						t,
						name ..
							"On this world, someone has already taken initiative to keep the magic of christmas alive in these dark times.",
						name ..
							"He has been seen handing out presents in the following areas:\nWest Shores of Hon\nHon Harbor\nCity of Hon\nTonguspur Village.",
						name .. "If you find this guy, please let him know that we need him to become the new Santa"
					},
					1
				)
			elseif menu == "Christmas Will Happen!" then
				player:dialogSeq(
					{
						t,
						name .. "This is Wonderful news. Ohh you are the best " .. player.name .. ". I knew I could count on you.",
						name .. "I knew it, What's this? I can also go for the ride on Christmas Night?",
						name .. "I am probably the best man for the job. After all, I am Ernest P. Worrell, Thrill Driver!",
						name .. "Do you think we could use an honorary elf. Maybe Harmony will come with us."
					},
					1
				)
				if player.quest["ernest_xmas"] >= 7 then
					player.quest["ernest_xmas"] = 9
				end
				finishedQuest(player)
				player:msg(4, "[Quest Completed] Saved Christmas which will spread Joy to all the Worlds!", player.ID)
			elseif menu == "Some Might get Mad!" then
				player:dialogSeq(
					{
						t,
						name .. "Well this just wont do. There must be somethign we can do.",
						name .. "I put my trust in you " .. player.name .. ". You really let me down.",
						name .. "I guess it is time for me to roll up the old sleeves and get it done like always.",
						name .. "I will save Christmas Future or my name is not Ernest P. Worrell!"
					},
					1
				)
				if player.quest["ernest_xmas"] >= 7 then
					player.quest["ernest_xmas"] = 9
				end
				finishedQuest(player)
				player:msg(4, "[Quest Completed] Got a shiny item and caused Oliver not to get Promoted to Santa yet.", player.ID)
			elseif menu == "You Failed Christmas!" then
				player:dialogSeq(
					{
						t,
						name .. "If I ruined Christmas it was only for putting my faith in you, " .. player.name .. ". Such a failure.",
						name .. "Me on the other hand. I just dive right into the deep end, you know what I mean?",
						name .. "No shortcuts here. I'll find a way to fix this or my name is not Ernest P. Worrell!"
					},
					1
				)
				if player.quest["ernest_xmas"] >= 7 then
					player.quest["ernest_xmas"] = 9
				end
				finishedQuest(player)
				player:msg(4, "[Quest Completed] Thwarted Ernest's plans to Save Christmas for now!", player.ID)
			elseif menu == "Happy New Year!" then
				player:dialogSeq({t, name .. "Happy New Year " .. player.name .. ", Hope to see you again soon!"}, 1)
			elseif menu == "See ya Around!" then
				player:dialogSeq({t, name .. "Maybe next time you wont be so selfish."}, 1)
			elseif menu == "Good Riddance!" then
				player:dialogSeq(
					{
						t,
						name ..
							"Ya know, " .. player.name .. ", I reckon you got beat a lot as a child, and if you didn't then you should have."
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
				if
					pc[i].level >= 50 and
						(pc[i].quest["ernest_xmas"] == 0 or pc[i].quest["ernest_xmas"] == 2 or pc[i].quest["ernest_xmas"] == 4 or
							pc[i].quest["ernest_xmas"] == 7)
				 then
					pc[i]:selfAnimationXY(pc[i].ID, 248, x, y)
				end
			end
		end
	end
}

--magicBag, "Words in a dialog Seqeunce to display santas magic bag!",

--player.quest["ernest_xmas"] = 1
--finishedQuest(player)
--player:msg(4, "[Quest Update] Words", player.ID)
