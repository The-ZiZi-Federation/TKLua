danny = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local opts = {}

			table.insert(opts, "What are you doing here?")
			if player.level >= 25 and player:hasSpell("whispering_wind_1") then
				table.insert(opts, "Teach me your ways!")
			end
			if player.level >= 50 and player:hasSpell("whispering_wind_2") then
				table.insert(opts, "I think I can get louder!")
			end
			if player.level >= 75 and player:hasSpell("whispering_wind_3") then
				table.insert(opts, "I know I can get louder!")
			end
			if player.level >= 100 and player:hasSpell("whispering_wind_4") then
				table.insert(opts, "How can I get as loud as you?")
			end

			menu =
				player:menuString(
				name .. "Hello! I am Daniel, Danny for short. I am louder and more important than anyone you will ever meet.",
				opts
			)

			if (menu == "What are you doing here?") then
				player:dialogSeq(
					{
						t,
						name .. "I am drinking! What does it look like?",
						name .. "What are you doing here? Here to pay my bar tab?"
					},
					1
				)
			elseif (menu == "Teach me your ways!") then
				choice = player:menuString(name .. "You want to speak louder?", {"Yes", "No"})
				if choice == "Yes" then
					player:dialogSeq(
						{
							t,
							name .. "Excellent! Just drink this. Yes. Yes. Now raise your head like this.",
							name .. "Now envision everyone in the world must hear your important words.",
							name ..
								"Wonderful, now pay my bar tab. We will just say I have not paid in many Moons. What? Didn't think I'd teach your ass for free did you?"
						},
						1
					)
					if player:removeGold(100000) == true then
						player:removeSpell("whispering_wind_1")
						player:addSpell("whispering_wind_2")
						finishedQuest(player)
					end
				end
			elseif (menu == "I think I can get louder!") then
				choice =
					player:menuString(
					name .. "HAHA! Just in time! I just lost a lot of money to Dre Loc. Ready to get louder?",
					{"Yes", "No"}
				)
				if choice == "Yes" then
					player:dialogSeq(
						{
							t,
							name .. "So you have your posture down, but you are still too shy!",
							name .. "See I never got this loud being shy! I just say what I want, even if I don't think first!",
							name ..
								"Like when I told Dre Loc I could beat him in a race. Now I owe him 250,000 coins. Pay my debt and I will show you!"
						},
						1
					)
					if player:removeGold(250000) == true then
						player:removeSpell("whispering_wind_2")
						player:addSpell("whispering_wind_3")
						finishedQuest(player)
					end
				end
			elseif (menu == "I know I can get louder!") then
				choice =
					player:menuString(
					name .. "Great Timing! I have some... Outstanding debts! So you want to get louder?",
					{"Yes", "No"}
				)
				if choice == "Yes" then
					player:dialogSeq(
						{
							t,
							name .. "Most people have to train over a year to get louder. But I like you.",
							name ..
								"How about we get started, first you will need to lose all shame. Just think everyone else is stupid outta do.",
							name ..
								"You know, when you're right, your right! And that makes everyone else a moron. So just use that, and give me money!"
						},
						1
					)
					if player:removeGold(500000) == true then
						player:removeSpell("whispering_wind_3")
						player:addSpell("whispering_wind_4")
						finishedQuest(player)
					end
				end
			elseif (menu == "How can I get as loud as you?") then
				choice =
					player:menuString(
					name .. "What a relief, I thought you were one of War Thog's Men. You want to be as loud as me?",
					{"Yes", "No"}
				)
				if choice == "Yes" then
					player:dialogSeq(
						{
							t,
							name .. "Just a head's up kid. Never bet against the War Thog. Clever and wicked. Now I owe him 1,000,000 coins.",
							name .. "If you want to get as loud as me, you have to be willing to make an ass of yourself.",
							name ..
								"I got an idea, pay my debt and I will teach you how to think you are the most essential form of life that has ever existed!"
						},
						1
					)
					if player:removeGold(1000000) == true then
						player:removeSpell("whispering_wind_4")
						player:addSpell("whispering_wind_5")
						finishedQuest(player)
					end
				end
			end
		end
	)
}
