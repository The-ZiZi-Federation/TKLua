three_tree_boss = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			local options = {}
			local confirm

			if player.quest["child_skull_for_mage"] == 0 then
				player:dialogSeq(
					{
						t,
						name .. "I could really use a... we will say... something hard to come across",
						name .. "Well, let me have a look to see if you have one."
					},
					1
				)
				player.quest["child_skull_for_mage"] = 1
			end

			if player.quest["child_skull_for_mage"] == 1 and player:hasItem("child_skull", 1) == true then
				table.insert(options, "Do you want a skull?")
			end
			if player.quest["child_skull_for_mage"] == 2 then
				table.insert(options, "What was that about?")
			end

			if player:hasItem("basic_rune", 1) == true and (player.registry["basic_rune_donation_time"] < os.time()) then
				table.insert(options, "Rune Donation")
			end

			menu = player:menuString(name .. "Why are you bothering me? I'm very busy.", options)

			if menu == "Do you want a skull?" then
				if player:hasItem("child_skull", 1) == true then
					if player:removeItem("child_skull", 1) == true then
						player:dialogSeq(
							{
								t,
								name .. "Ahh, it is fate you came here today.",
								name .. "I have a ...customer... who has been waiting on this a long time.",
								name .. "Here take a few coins, and get out. I have a business to run."
							},
							1
						)
						player.quest["child_skull_for_mage"] = 2
						player:addGold(1000)
						giveXP(player, 100)
						finishedQuest(player)
						player:calcStat()
						player:sendStatus()
						player:msg(4, "[Quest Completed] Do you think that was a good idea?", player.ID)
						three_tree_boss.addLegend(player)
					else
						player:dialogSeq(
							{
								t,
								name .. "Yeah, I didn't expect you would have one based on your outfit.",
								name .. "Now get going, I have a business to run!"
							},
							1
						)
					end
				else
					player:dialogSeq(
						{
							t,
							name .. "Yeah, I didn't expect you would have one based on your outfit.",
							name .. "Now get going, I have a business to run!"
						},
						1
					)
				end
			elseif menu == "What was that about?" then
				player:dialogSeq({t, name .. "We don't all get to be heroes. Thanks for not being a hero."}, 1)
			elseif menu == "Rune Donation" then
				player:dialogSeq(
					{
						t,
						name .. "I see you have a Basic Rune with you. How did I know? Don't ask.",
						name .. "The important thing is not you, but my need for that Rune. You simply must give it to me."
					},
					1
				)
				confirm = player:menuString("Well? Are you going to give me the Basic Rune?", {"Yes", "No"})
				if confirm == "Yes" then
					if player:removeItem("basic_rune", 1) == true then
						three_tree_boss.runeDonation(player, npc)
						player:dialogSeq(
							{
								t,
								name .. "Good, good! You have done a great service to... certain forces.",
								name .. "Bring me another one tomorrow, will you?"
							},
							1
						)
					else
						player:dialogSeq({t, name .. "Not going to give it up? Cherewoot will feast on your bones!"}, 1)
					end
				else
					player:dialogSeq({t, name .. "Bah! Get out of here, then. You'll be the first to die when Cherewoot returns."}, 1)
				end
			end
		end
	),
	runeDonation = function(player)
		local reg = player.registry["rune_donation_stanley"]

		player.registry["basic_rune_donation_time"] = os.time() + 86400
		finishedQuest(player)
		player:leveledEXP("donation")
		if player:hasLegend("rune_donation_stanley") then
			player:removeLegendbyName("rune_donation_stanley")
		end

		if reg > 0 then
			player.registry["rune_donation_stanley"] = player.registry["rune_donation_stanley"] + 1
			player:addLegend(
				"Offered " .. player.registry["rune_donation_stanley"] .. " Runes to a Dark Force",
				"rune_donation_stanley",
				143,
				16
			)
		else
			player.registry["rune_donation_stanley"] = 1
			player:addLegend("Offered 1 Rune to a Dark Force", "rune_donation_stanley", 143, 16)
		end

		if player.registry["rune_donation_stanley"] % 10 == 0 then
			three_tree_boss.addLegend(player)
		end
	end,
	addLegend = function(player)
		local reg = player.registry["bad_karma"]

		finishedQuest(player)
		if player:hasLegend("dishonor") then
			player:removeLegendbyName("dishonor")
		end

		if reg > 0 then
			player.registry["bad_karma"] = player.registry["bad_karma"] + 1
			player:addLegend("Committed " .. player.registry["bad_karma"] .. " evil acts", "dishonor", 26, 144)
		else
			player.registry["bad_karma"] = 1
			player:addLegend("Committed 1 evil act", "dishonor", 26, 144)
		end
	end,
	say = function(player, npc)
		local s = string.lower(player.speech)

		if string.find(s, "(.*)necromon(.*)") then
			if player.quest["lost_something"] == 3 then
				player:freeAsync()
				async(three_tree_boss.necromon(player, npc))
			end
		end
	end,
	necromon = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID
			local expReward = 2500000
			local goldReward = 75000

			player:dialogSeq(
				{
					t,
					name .. "You have The Necromon?!",
					name .. "You must give it to me now!"
				},
				1
			)
			choice = player:menuString("Give him the book?", {"Yes", "No"})
			if choice == "Yes" then
				if player:hasItem("necromon_vol3", 1) == true then
					if player:removeItem("necromon_vol3", 1) == true then
						player.quest["lost_something"] = 4
						finishedQuest(player)
						player:calcStat()
						player:sendStatus()
						player:msg(4, "[Quest Completed] You delivered the Necromon to Stanley", player.ID)
						giveXP(player, expReward)
						player:addGold(goldReward)
						player:addLegend("Delivered the Necromon " .. curT(), "necromon", 205, 4)
						player:addSpell("spiritual_transformation")
						player:sendMinitext("You learn Spiritual Transformation")
						three_tree_boss.addLegend(player)
						player:dialogSeq(
							{
								t,
								name .. "I am most grateful.",
								name .. "Now my dark work may continue. You are a strong ally to the darkness. Let it fill your soul."
							},
							1
						)
					else
						player:dialogSeq({t, name .. "The book is gone! Where are you hiding it?"}, 1)
					end
				else
					player:dialogSeq({t, name .. "The book is gone! Where are you hiding it?"}, 1)
				end
			elseif choice == "No" then
				player:dialogSeq({t, name .. "*scowls*\n\nLeave. Now."}, 1)
			end
		end
	),
	nearbyPlayers = function(npc)
		local pc = npc:getObjectsInArea(BL_PC)
		local m, x, y = npc.m, npc.x, npc.y

		if #pc > 0 then
			for i = 1, #pc do
				if pc[i].quest["child_skull_for_mage"] < 2 and pc[i]:hasItem("child_skull", 1) == true then
					pc[i]:selfAnimationXY(pc[i].ID, 248, x, y)
				end
			end
		end
	end
}
