hon_parcel_boy = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local opts = {}
			local txt = ""

			-- Table Inserts -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

			table.insert(opts, "Mailbox")

			if player.level >= 25 and player.quest["tonguspur_letter"] == 0 then
				table.insert(opts, "What's so bad about working here?")
			end
			if player.quest["tonguspur_letter"] == 1 then
				table.insert(opts, "About that letter...")
			end
			if player.quest["tonguspur_letter"] == 2 then
				table.insert(opts, "He wants good mail next time!")
			end

			if player.level >= 99 and player.quest["lortz_letter"] == 0 then
				table.insert(opts, "You need more help?")
			end
			if player.quest["lortz_letter"] == 1 then
				table.insert(opts, "Where was this going?")
			end
			if player.quest["lortz_letter"] == 2 then
				table.insert(opts, "I delivered the letter")
			end
			table.insert(opts, "Leave")

			-- Menu String Inserts ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

			if player.quest["tonguspur_letter"] >= 0 and player.quest["tonguspur_letter"] <= 2 then
				menu = player:menuString(name .. "I hate my job.", opts)
			elseif player.level < 99 and player.quest["lortz_letter"] == 0 then
				menu = player:menuString(name .. "I am telling you, this job SUCKS!", opts)
			elseif player.level >= 99 and (player.quest["lortz_letter"] >= 0 and player.quest["lortz_letter"] <= 2) then
				menu = player:menuString(name .. "This is bad! This is real bad. You have to help me!", opts)
			elseif player.quest["lortz_letter"] == 3 then
				menu = player:menuString(name .. "I am telling you, this job SUCKS!", opts)
			end

			-- Menu Selections -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
			-- Tonguspur Letter
			if menu == "Mailbox" then
				local item = player:getParcel()
				local optsPO = {"Send Parcel"}
				if item ~= false then
					txt = "What would you like to do?\n\nYou have a new parcel"
					table.insert(optsPO, "Receive Parcel")
				else
					txt = "What would you like to do?\n\nYou have no new parcels"
				end
				choice = player:menuString(name .. "" .. txt .. "", optsPO)
				if choice == "Send Parcel" then
					player:sendParcelTo(npc)
				elseif choice == "Receive Parcel" then
					player:receiveParcelFrom(npc)
				end
			elseif menu == "What's so bad about working here?" then
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
				player.quest["tonguspur_letter"] = 1
				player:addItem("tonguspur_letter", 1)
				player:msg(4, "[Quest Update] Deliver a letter to the carpenter in Tonguspur", player.ID)
			elseif menu == "About that letter..." then
				player:dialogSeq(
					{
						t,
						name .. "Yes, the letter for the Carpenter.",
						name .. "You're taking it to Tonguspur, northwest of Hon."
					},
					1
				)
			elseif menu == "He wants good mail next time!" then
				-- Lortz Letter
				player.quest["tonguspur_letter"] = 3
				onGetExp2(player, 20000)
				player:addGold(5000)
				player:calcStat()
				player:sendStatus()
				finishedQuest(player)
				player:dialogSeq(
					{
						t,
						name .. "Great! You just saved me a ton of work!",
						name .. "We don't pick the mail we deliver, well... I do, but that's what you're for right?",
						name .. "Here, have something for your trouble."
					},
					1
				)
			elseif menu == "You need more help?" then
				player:dialogSeq(
					{
						t,
						name .. "Yeah, this latest delivery is completely insane.",
						name .. "My boss gave me this letter to deliver to Lortz.",
						name .. "Have you tried to go to Lortz? The road is completely swarming with vicious ogres.",
						name .. "I think my boss just wants me dead.",
						name .. "Do I look like I can fight ogres?",
						name .. "Because I can't fight ogres.",
						name .. "I am super lucky that you're here. You're a strong person, right?",
						name .. "So you'll take this letter to Lortz for me?",
						name .. "I mean, there aren't THAT many ogres..."
					},
					1
				)
				player:msg(4, "[Quest Update] Deliver a letter to Carmen in Lortz", player.ID)
				player.quest["lortz_letter"] = 1
				player:addItem("lortz_letter", 1)
			elseif menu == "Where was this going?" then
				player:dialogSeq(
					{
						t,
						name .. "Weren't you paying attention? The letter is going to a woman named Carmen, in Lortz.",
						name .. "It's west of Tonguspur, past the beach and through the mountains.",
						name .. "Now hurry up!"
					},
					1
				)
			elseif menu == "I delivered the letter" then
				player:dialogSeq({t, name .. "Thanks!"}, 1)
				onGetExp2(player, 25000000)
				player:addGold(50000)
				player:calcStat()
				player:sendStatus()
				finishedQuest(player)
				player.quest["lortz_letter"] = 3
			end
		end
	),
	nearbyPlayers = function(npc)
		local pc = npc:getObjectsInArea(BL_PC)
		local m, x, y = npc.m, npc.x, npc.y

		if #pc > 0 then
			for i = 1, #pc do
				if pc[i].level >= 25 and pc[i].quest["tonguspur_letter"] == 0 then
					pc[i]:selfAnimationXY(pc[i].ID, 248, x, y)
				elseif pc[i].level >= 99 and pc[i].quest["lortz_letter"] == 0 then
					pc[i]:selfAnimationXY(pc[i].ID, 248, x, y)
				end
			end
		end
	end
}
