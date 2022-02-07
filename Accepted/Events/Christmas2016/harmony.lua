harmony = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID
			local gender = ""

			if player.sex == 0 then
				gender = "man"
			elseif player.sex == 1 then
				gender = "woman"
			end

			local magicBag = {graphic = convertGraphic(4855, "item"), color = 0}

			local opts = {}

			if player.level >= 50 and player.quest["ernest_xmas"] < 3 then
				table.insert(opts, "Who are you?")
			end
			if player.level >= 50 and player.quest["ernest_xmas"] == 3 then
				table.insert(opts, "Where's the Bag?")
			end
			if player.level >= 50 and player.quest["ernest_xmas"] >= 4 and player.quest["ernest_xmas"] <= 5 then
				table.insert(opts, "What?")
			end

			if player.level >= 50 and player.quest["ernest_xmas"] > 5 and player.quest["good_xmas"] == 1 then
				table.insert(opts, "Christmas is Saved!")
			end -- Good
			if player.level >= 50 and player.quest["ernest_xmas"] > 5 and player.quest["neutral_xmas"] == 1 then
				table.insert(opts, "Ran Out of Time!")
			end -- Neutral
			if player.level >= 50 and player.quest["ernest_xmas"] > 5 and player.quest["evil_xmas"] == 1 then
				table.insert(opts, "You Ruined Christmas!")
			end -- Evil

			if player.level >= 50 and player.quest["ernest_xmas"] < 3 then
				words = "Do I take it all for myself, or do I accept that which is impossible to believe???"
			elseif player.level >= 50 and player.quest["ernest_xmas"] >= 3 and player.quest["ernest_xmas"] <= 4 then
				words = "Oh, me, oh, my, what have I done. I must return this before it is too late!"
			elseif player.level >= 50 and player.quest["good_xmas"] == 1 then
				words = "Thank you, " .. player.name .. ", I am so happy now!!"
			elseif player.level >= 50 and player.quest["neutral_xmas"] == 1 then
				words = "Ohh, Noo!!! " .. player.name .. ", This is all my fault!!!"
			elseif player.level >= 50 and player.quest["evil_xmas"] == 1 then
				words = "I thought I was bad, " .. player.name .. ", but you are the worst!"
			end

			menu = player:menuString(name .. "" .. words, opts)

			if menu == "Who are you?" then
				player:dialogSeq(
					{
						t,
						name .. "I am Harmony. I have something that I shouldn't have but I don't know if I care yet.",
						name .. "Please leave me alone so I can think about my actions and what will come of them."
					},
					1
				)
			elseif menu == "Where's the Bag?" then
				player:dialogSeq(
					{
						t,
						name .. "The bag? Did Santa send you? It's right here, take it, please.",
						magicBag,
						"I never meant for this all to happen, I swear. I just saw the bag, and I know how much power it has...",
						t,
						name .. "I thought it would make me happy, but this is truly awful.",
						name .. "I didn't realize that it was the power of Christmas keeping all these monsters sealed inside this place.",
						magicBag,
						"If I use up the remaining power in this bag, Christmas is doomed for sure!",
						t,
						name .. "Hurry back to Santa with the bag, you might still have time!"
					},
					1
				)
				player.quest["ernest_xmas"] = 4
				player:msg(4, "[Quest Update] Got Santa's Magic Sack from Harmony! Return to Ernest!", player.ID)
				finishedQuest(player)
			elseif menu == "What?" then
				player:dialogSeq(
					{
						t,
						name .. "The bag? Did Santa send you? It's right here, take it, please.",
						magicBag,
						"I never meant for this all to happen, I swear. I just saw the bag, and I know how much power it has...",
						t,
						name .. "I thought it would make me happy, but this is truly awful.",
						name .. "I didn't realize that it was the power of Christmas keeping all these monsters sealed inside this place.",
						magicBag,
						"If I use up the remaining power in this bag, Christmas is doomed for sure!",
						t,
						name .. "Hurry back to Santa with the bag, you might still have time!"
					},
					1
				)
			elseif menu == "Christmas is Saved!" then
				player:dialogSeq(
					{
						t,
						name .. "You did it! I knew you would!",
						name .. "Looks like this will be a magical Christmas after all!",
						name .. "Do you think it's going to snow in Hon by the Sea this year?"
					},
					1
				)
			elseif menu == "Ran Out of Time!" then
				player:dialogSeq(
					{
						t,
						name .. "If theres no Santa...",
						name .. "Will there still be a Christmas this year?",
						name .. "*cries*"
					},
					1
				)
			elseif menu == "You Ruined Christmas!" then
				player:dialogSeq(
					{
						t,
						name .. "You're the worst person I've ever met, " .. player.name .. "!",
						name .. "I hate you!",
						name .. "Santa wouldn't let an evil " .. gender .. " like you stop him, you'll see!"
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
				if pc[i].quest["ernest_xmas"] == 3 then
					pc[i]:selfAnimationXY(pc[i].ID, 248, x, y)
				end
			end
		end
	end
}

harmony_cave2 = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID
			local gender = ""

			if player.sex == 0 then
				gender = "man"
			elseif player.sex == 1 then
				gender = "woman"
			end

			local magicBag = {graphic = convertGraphic(4855, "item"), color = 0}

			local opts = {}

			if player.level >= 50 and player.quest["ernest_xmas"] < 3 then
				table.insert(opts, "Who are you?")
			end
			if player.level >= 50 and player.quest["ernest_xmas"] == 3 then
				table.insert(opts, "Where's the Bag?")
			end
			if player.level >= 50 and player.quest["ernest_xmas"] >= 4 and player.quest["ernest_xmas"] <= 5 then
				table.insert(opts, "What?")
			end

			if player.level >= 50 and player.quest["ernest_xmas"] > 5 and player.quest["good_xmas"] == 1 then
				table.insert(opts, "Christmas is Saved!")
			end -- Good
			if player.level >= 50 and player.quest["ernest_xmas"] > 5 and player.quest["neutral_xmas"] == 1 then
				table.insert(opts, "Ran Out of Time!")
			end -- Neutral
			if player.level >= 50 and player.quest["ernest_xmas"] > 5 and player.quest["evil_xmas"] == 1 then
				table.insert(opts, "You Ruined Christmas!")
			end -- Evil

			if player.level >= 50 and player.quest["ernest_xmas"] < 3 then
				words = "Do I take it all for myself, or do I accept that which is impossible to believe???"
			elseif player.level >= 50 and player.quest["ernest_xmas"] >= 3 and player.quest["ernest_xmas"] <= 4 then
				words = "Oh, me, oh, my, what have I done. I must return this before it is too late!"
			elseif player.level >= 50 and player.quest["good_xmas"] == 1 then
				words = "Thank you, " .. player.name .. ", I am so happy now!!"
			elseif player.level >= 50 and player.quest["neutral_xmas"] == 1 then
				words = "Ohh, Noo!!! " .. player.name .. ", This is all my fault!!!"
			elseif player.level >= 50 and player.quest["evil_xmas"] == 1 then
				words = "I thought I was bad, " .. player.name .. ", but you are the worst!"
			end

			menu = player:menuString(name .. "" .. words, opts)

			if menu == "Who are you?" then
				player:dialogSeq(
					{
						t,
						name .. "I am Harmony. I have something that I shouldn't have but I don't know if I care yet.",
						name .. "Please leave me alone so I can think about my actions and what will come of them."
					},
					1
				)
			elseif menu == "Where's the Bag?" then
				player:dialogSeq(
					{
						t,
						name .. "The bag? Did Santa send you? It's right here, take it, please.",
						magicBag,
						"I never meant for this all to happen, I swear. I just saw the bag, and I know how much power it has...",
						t,
						name .. "I thought it would make me happy, but this is truly awful.",
						name .. "I didn't realize that it was the power of Christmas keeping all these monsters sealed inside this place.",
						magicBag,
						"If I use up the remaining power in this bag, Christmas is doomed for sure!",
						t,
						name .. "Hurry back to Santa with the bag, you might still have time!"
					},
					1
				)
				player.quest["ernest_xmas"] = 4
				player:msg(4, "[Quest Update] Got Santa's Magic Sack from Harmony! Return to Ernest!", player.ID)
				finishedQuest(player)
			elseif menu == "What?" then
				player:dialogSeq(
					{
						t,
						name .. "The bag? Did Santa send you? It's right here, take it, please.",
						magicBag,
						"I never meant for this all to happen, I swear. I just saw the bag, and I know how much power it has...",
						t,
						name .. "I thought it would make me happy, but this is truly awful.",
						name .. "I didn't realize that it was the power of Christmas keeping all these monsters sealed inside this place.",
						magicBag,
						"If I use up the remaining power in this bag, Christmas is doomed for sure!",
						t,
						name .. "Hurry back to Santa with the bag, you might still have time!"
					},
					1
				)
			elseif menu == "Christmas is Saved!" then
				player:dialogSeq(
					{
						t,
						name .. "You did it! I knew you would!",
						name .. "Looks like this will be a magical Christmas after all!",
						name .. "Do you think it's going to snow in Hon by the Sea this year?"
					},
					1
				)
			elseif menu == "Ran Out of Time!" then
				player:dialogSeq(
					{
						t,
						name .. "If theres no Santa...",
						name .. "Will there still be a Christmas this year?",
						name .. "*cries*"
					},
					1
				)
			elseif menu == "You Ruined Christmas!" then
				player:dialogSeq(
					{
						t,
						name .. "You're the worst person I've ever met, " .. player.name .. "!",
						name .. "I hate you!",
						name .. "Santa wouldn't let an evil " .. gender .. " like you stop him, you'll see!"
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
				if pc[i].quest["ernest_xmas"] == 3 then
					pc[i]:selfAnimationXY(pc[i].ID, 248, x, y)
				end
			end
		end
	end
}

harmony_cave3 = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID
			local gender = ""

			if player.sex == 0 then
				gender = "man"
			elseif player.sex == 1 then
				gender = "woman"
			end

			local magicBag = {graphic = convertGraphic(4855, "item"), color = 0}

			local opts = {}

			if player.level >= 50 and player.quest["ernest_xmas"] < 3 then
				table.insert(opts, "Who are you?")
			end
			if player.level >= 50 and player.quest["ernest_xmas"] == 3 then
				table.insert(opts, "Where's the Bag?")
			end
			if player.level >= 50 and player.quest["ernest_xmas"] >= 4 and player.quest["ernest_xmas"] <= 5 then
				table.insert(opts, "What?")
			end

			if player.level >= 50 and player.quest["ernest_xmas"] > 5 and player.quest["good_xmas"] == 1 then
				table.insert(opts, "Christmas is Saved!")
			end -- Good
			if player.level >= 50 and player.quest["ernest_xmas"] > 5 and player.quest["neutral_xmas"] == 1 then
				table.insert(opts, "Ran Out of Time!")
			end -- Neutral
			if player.level >= 50 and player.quest["ernest_xmas"] > 5 and player.quest["evil_xmas"] == 1 then
				table.insert(opts, "You Ruined Christmas!")
			end -- Evil

			if player.level >= 50 and player.quest["ernest_xmas"] < 3 then
				words = "Do I take it all for myself, or do I accept that which is impossible to believe???"
			elseif player.level >= 50 and player.quest["ernest_xmas"] >= 3 and player.quest["ernest_xmas"] <= 4 then
				words = "Oh, me, oh, my, what have I done. I must return this before it is too late!"
			elseif player.level >= 50 and player.quest["good_xmas"] == 1 then
				words = "Thank you, " .. player.name .. ", I am so happy now!!"
			elseif player.level >= 50 and player.quest["neutral_xmas"] == 1 then
				words = "Ohh, Noo!!! " .. player.name .. ", This is all my fault!!!"
			elseif player.level >= 50 and player.quest["evil_xmas"] == 1 then
				words = "I thought I was bad, " .. player.name .. ", but you are the worst!"
			end

			menu = player:menuString(name .. "" .. words, opts)

			if menu == "Who are you?" then
				player:dialogSeq(
					{
						t,
						name .. "I am Harmony. I have something that I shouldn't have but I don't know if I care yet.",
						name .. "Please leave me alone so I can think about my actions and what will come of them."
					},
					1
				)
			elseif menu == "Where's the Bag?" then
				player:dialogSeq(
					{
						t,
						name .. "The bag? Did Santa send you? It's right here, take it, please.",
						magicBag,
						"I never meant for this all to happen, I swear. I just saw the bag, and I know how much power it has...",
						t,
						name .. "I thought it would make me happy, but this is truly awful.",
						name .. "I didn't realize that it was the power of Christmas keeping all these monsters sealed inside this place.",
						magicBag,
						"If I use up the remaining power in this bag, Christmas is doomed for sure!",
						t,
						name .. "Hurry back to Santa with the bag, you might still have time!"
					},
					1
				)
				player.quest["ernest_xmas"] = 4
				player:msg(4, "[Quest Update] Got Santa's Magic Sack from Harmony! Return to Ernest!", player.ID)
				finishedQuest(player)
			elseif menu == "What?" then
				player:dialogSeq(
					{
						t,
						name .. "The bag? Did Santa send you? It's right here, take it, please.",
						magicBag,
						"I never meant for this all to happen, I swear. I just saw the bag, and I know how much power it has...",
						t,
						name .. "I thought it would make me happy, but this is truly awful.",
						name .. "I didn't realize that it was the power of Christmas keeping all these monsters sealed inside this place.",
						magicBag,
						"If I use up the remaining power in this bag, Christmas is doomed for sure!",
						t,
						name .. "Hurry back to Santa with the bag, you might still have time!"
					},
					1
				)
			elseif menu == "Christmas is Saved!" then
				player:dialogSeq(
					{
						t,
						name .. "You did it! I knew you would!",
						name .. "Looks like this will be a magical Christmas after all!",
						name .. "Do you think it's going to snow in Hon by the Sea this year?"
					},
					1
				)
			elseif menu == "Ran Out of Time!" then
				player:dialogSeq(
					{
						t,
						name .. "If theres no Santa...",
						name .. "Will there still be a Christmas this year?",
						name .. "*cries*"
					},
					1
				)
			elseif menu == "You Ruined Christmas!" then
				player:dialogSeq(
					{
						t,
						name .. "You're the worst person I've ever met, " .. player.name .. "!",
						name .. "I hate you!",
						name .. "Santa wouldn't let an evil " .. gender .. " like you stop him, you'll see!"
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
				if pc[i].quest["ernest_xmas"] == 3 then
					pc[i]:selfAnimationXY(pc[i].ID, 248, x, y)
				end
			end
		end
	end
}

harmony_cave4 = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID
			local gender = ""

			if player.sex == 0 then
				gender = "man"
			elseif player.sex == 1 then
				gender = "woman"
			end

			local magicBag = {graphic = convertGraphic(4855, "item"), color = 0}

			local opts = {}

			if player.level >= 50 and player.quest["ernest_xmas"] < 3 then
				table.insert(opts, "Who are you?")
			end
			if player.level >= 50 and player.quest["ernest_xmas"] == 3 then
				table.insert(opts, "Where's the Bag?")
			end
			if player.level >= 50 and player.quest["ernest_xmas"] >= 4 and player.quest["ernest_xmas"] <= 5 then
				table.insert(opts, "What?")
			end

			if player.level >= 50 and player.quest["ernest_xmas"] > 5 and player.quest["good_xmas"] == 1 then
				table.insert(opts, "Christmas is Saved!")
			end -- Good
			if player.level >= 50 and player.quest["ernest_xmas"] > 5 and player.quest["neutral_xmas"] == 1 then
				table.insert(opts, "Ran Out of Time!")
			end -- Neutral
			if player.level >= 50 and player.quest["ernest_xmas"] > 5 and player.quest["evil_xmas"] == 1 then
				table.insert(opts, "You Ruined Christmas!")
			end -- Evil

			if player.level >= 50 and player.quest["ernest_xmas"] < 3 then
				words = "Do I take it all for myself, or do I accept that which is impossible to believe???"
			elseif player.level >= 50 and player.quest["ernest_xmas"] >= 3 and player.quest["ernest_xmas"] <= 4 then
				words = "Oh, me, oh, my, what have I done. I must return this before it is too late!"
			elseif player.level >= 50 and player.quest["good_xmas"] == 1 then
				words = "Thank you, " .. player.name .. ", I am so happy now!!"
			elseif player.level >= 50 and player.quest["neutral_xmas"] == 1 then
				words = "Ohh, Noo!!! " .. player.name .. ", This is all my fault!!!"
			elseif player.level >= 50 and player.quest["evil_xmas"] == 1 then
				words = "I thought I was bad, " .. player.name .. ", but you are the worst!"
			end

			menu = player:menuString(name .. "" .. words, opts)

			if menu == "Who are you?" then
				player:dialogSeq(
					{
						t,
						name .. "I am Harmony. I have something that I shouldn't have but I don't know if I care yet.",
						name .. "Please leave me alone so I can think about my actions and what will come of them."
					},
					1
				)
			elseif menu == "Where's the Bag?" then
				player:dialogSeq(
					{
						t,
						name .. "The bag? Did Santa send you? It's right here, take it, please.",
						magicBag,
						"I never meant for this all to happen, I swear. I just saw the bag, and I know how much power it has...",
						t,
						name .. "I thought it would make me happy, but this is truly awful.",
						name .. "I didn't realize that it was the power of Christmas keeping all these monsters sealed inside this place.",
						magicBag,
						"If I use up the remaining power in this bag, Christmas is doomed for sure!",
						t,
						name .. "Hurry back to Santa with the bag, you might still have time!"
					},
					1
				)
				player.quest["ernest_xmas"] = 4
				player:msg(4, "[Quest Update] Got Santa's Magic Sack from Harmony! Return to Ernest!", player.ID)
				finishedQuest(player)
			elseif menu == "What?" then
				player:dialogSeq(
					{
						t,
						name .. "The bag? Did Santa send you? It's right here, take it, please.",
						magicBag,
						"I never meant for this all to happen, I swear. I just saw the bag, and I know how much power it has...",
						t,
						name .. "I thought it would make me happy, but this is truly awful.",
						name .. "I didn't realize that it was the power of Christmas keeping all these monsters sealed inside this place.",
						magicBag,
						"If I use up the remaining power in this bag, Christmas is doomed for sure!",
						t,
						name .. "Hurry back to Santa with the bag, you might still have time!"
					},
					1
				)
			elseif menu == "Christmas is Saved!" then
				player:dialogSeq(
					{
						t,
						name .. "You did it! I knew you would!",
						name .. "Looks like this will be a magical Christmas after all!",
						name .. "Do you think it's going to snow in Hon by the Sea this year?"
					},
					1
				)
			elseif menu == "Ran Out of Time!" then
				player:dialogSeq(
					{
						t,
						name .. "If theres no Santa...",
						name .. "Will there still be a Christmas this year?",
						name .. "*cries*"
					},
					1
				)
			elseif menu == "You Ruined Christmas!" then
				player:dialogSeq(
					{
						t,
						name .. "You're the worst person I've ever met, " .. player.name .. "!",
						name .. "I hate you!",
						name .. "Santa wouldn't let an evil " .. gender .. " like you stop him, you'll see!"
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
				if pc[i].quest["ernest_xmas"] == 3 then
					pc[i]:selfAnimationXY(pc[i].ID, 248, x, y)
				end
			end
		end
	end
}

harmony_cave5 = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID
			local gender = ""

			if player.sex == 0 then
				gender = "man"
			elseif player.sex == 1 then
				gender = "woman"
			end

			local magicBag = {graphic = convertGraphic(4855, "item"), color = 0}

			local opts = {}

			if player.level >= 50 and player.quest["ernest_xmas"] < 3 then
				table.insert(opts, "Who are you?")
			end
			if player.level >= 50 and player.quest["ernest_xmas"] == 3 then
				table.insert(opts, "Where's the Bag?")
			end
			if player.level >= 50 and player.quest["ernest_xmas"] >= 4 and player.quest["ernest_xmas"] <= 5 then
				table.insert(opts, "What?")
			end

			if player.level >= 50 and player.quest["ernest_xmas"] > 5 and player.quest["good_xmas"] == 1 then
				table.insert(opts, "Christmas is Saved!")
			end -- Good
			if player.level >= 50 and player.quest["ernest_xmas"] > 5 and player.quest["neutral_xmas"] == 1 then
				table.insert(opts, "Ran Out of Time!")
			end -- Neutral
			if player.level >= 50 and player.quest["ernest_xmas"] > 5 and player.quest["evil_xmas"] == 1 then
				table.insert(opts, "You Ruined Christmas!")
			end -- Evil

			if player.level >= 50 and player.quest["ernest_xmas"] < 3 then
				words = "Do I take it all for myself, or do I accept that which is impossible to believe???"
			elseif player.level >= 50 and player.quest["ernest_xmas"] >= 3 and player.quest["ernest_xmas"] <= 4 then
				words = "Oh, me, oh, my, what have I done. I must return this before it is too late!"
			elseif player.level >= 50 and player.quest["good_xmas"] == 1 then
				words = "Thank you, " .. player.name .. ", I am so happy now!!"
			elseif player.level >= 50 and player.quest["neutral_xmas"] == 1 then
				words = "Ohh, Noo!!! " .. player.name .. ", This is all my fault!!!"
			elseif player.level >= 50 and player.quest["evil_xmas"] == 1 then
				words = "I thought I was bad, " .. player.name .. ", but you are the worst!"
			end

			menu = player:menuString(name .. "" .. words, opts)

			if menu == "Who are you?" then
				player:dialogSeq(
					{
						t,
						name .. "I am Harmony. I have something that I shouldn't have but I don't know if I care yet.",
						name .. "Please leave me alone so I can think about my actions and what will come of them."
					},
					1
				)
			elseif menu == "Where's the Bag?" then
				player:dialogSeq(
					{
						t,
						name .. "The bag? Did Santa send you? It's right here, take it, please.",
						magicBag,
						"I never meant for this all to happen, I swear. I just saw the bag, and I know how much power it has...",
						t,
						name .. "I thought it would make me happy, but this is truly awful.",
						name .. "I didn't realize that it was the power of Christmas keeping all these monsters sealed inside this place.",
						magicBag,
						"If I use up the remaining power in this bag, Christmas is doomed for sure!",
						t,
						name .. "Hurry back to Santa with the bag, you might still have time!"
					},
					1
				)
				player.quest["ernest_xmas"] = 4
				player:msg(4, "[Quest Update] Got Santa's Magic Sack from Harmony! Return to Ernest!", player.ID)
				finishedQuest(player)
			elseif menu == "What?" then
				player:dialogSeq(
					{
						t,
						name .. "The bag? Did Santa send you? It's right here, take it, please.",
						magicBag,
						"I never meant for this all to happen, I swear. I just saw the bag, and I know how much power it has...",
						t,
						name .. "I thought it would make me happy, but this is truly awful.",
						name .. "I didn't realize that it was the power of Christmas keeping all these monsters sealed inside this place.",
						magicBag,
						"If I use up the remaining power in this bag, Christmas is doomed for sure!",
						t,
						name .. "Hurry back to Santa with the bag, you might still have time!"
					},
					1
				)
			elseif menu == "Christmas is Saved!" then
				player:dialogSeq(
					{
						t,
						name .. "You did it! I knew you would!",
						name .. "Looks like this will be a magical Christmas after all!",
						name .. "Do you think it's going to snow in Hon by the Sea this year?"
					},
					1
				)
			elseif menu == "Ran Out of Time!" then
				player:dialogSeq(
					{
						t,
						name .. "If theres no Santa...",
						name .. "Will there still be a Christmas this year?",
						name .. "*cries*"
					},
					1
				)
			elseif menu == "You Ruined Christmas!" then
				player:dialogSeq(
					{
						t,
						name .. "You're the worst person I've ever met, " .. player.name .. "!",
						name .. "I hate you!",
						name .. "Santa wouldn't let an evil " .. gender .. " like you stop him, you'll see!"
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
				if pc[i].quest["ernest_xmas"] == 3 then
					pc[i]:selfAnimationXY(pc[i].ID, 248, x, y)
				end
			end
		end
	end
}
