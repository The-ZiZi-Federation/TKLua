blackstrike_dragon = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local opts = {}
			local opts2 = {"Yes", "No"}

			local disposition = player.registry["good_karma"] - player.registry["bad_karma"]
			local dam = player.health * 0.9

			table.insert(opts, "What are you?")
			if player.quest["angry_guard"] == 8 then
				table.insert(opts, "Dragon saliva")
			end
			--	if player.quest[""] == 0 then table.insert(opts, "") end
			--	if player.quest[""] == 1 then table.insert(opts, "") end
			--	if player.quest[""] >= 2 then table.insert(opts, "") end
			--	if player.quest[""] >= 2 then table.insert(sellitems, 1) end
			--	if player.quest[""] == 2 then table.insert(opts, "") end
			--	if player.quest[""] == 3 then table.insert(opts, "") end
			--	if player.quest[""] == 1 then table.insert(opts, "") end

			if disposition == 0 then
				menu = player:menuString(name .. "*glares suspiciously*\n\nWhat is your purpose here?", opts)
			elseif disposition < 0 then
				menu =
					player:menuString(
					name .. "I smell evil and corruption on you, human. I would much rather smell charred meat and boiled marrow.",
					opts
				)
			elseif disposition > 0 then
				menu = player:menuString(name .. "Greetings, Hero. Have you come to seek my wisdom?", opts)
			end

			if menu == "What are you?" then
				if disposition == 0 then
					player:dialogSeq({t, name .. "I am Blackstrike, and you are in my home."}, 1)
				elseif disposition < 0 then
					player:dialogSeq(
						{
							t,
							name .. "Me? I am preparing to roast you for dinner, and rid the world of a small portion of its evil.",
							name .. "Have you anything else to say before you are eaten?"
						},
						1
					)
				elseif disposition > 0 then
					player:dialogSeq(
						{t, name .. "I am Blackstrike. Like yourself, I fight back the corruption that is eating away at Morna."},
						1
					)
				end
			elseif menu == "Dragon saliva" then
				if disposition == 0 then
					player:dialogSeq(
						{
							t,
							name .. "You are bold, as humans go.",
							name .. "I respect that, I do admit.",
							name .. "You are no shining paragon, here to aid the noble Blackstrike in his fight against evil.",
							name .. "But you are no villan, yourself.",
							name .. "You are only.. Human.",
							name ..
								"You had a goal set in your mind, and through your own wit, skill, and determination you have ended up here, face to face with me in my own tower.",
							name .. "You amuse me, and so I may be willing to allow you to leave here with your life.",
							name .. "If you want something else from me, however, I must insist that we engage in fair trade.",
							name .. "You want my saliva, and I want more gold for my hoard.",
							name .. "Bring me 100,000 coins and we will have our fair trade."
						},
						1
					)
					blackstrike_dragon.gold(player, NPC("Blackstrike"))
				elseif disposition < 0 then
					player:dialogSeq(
						{
							t,
							name .. "You come into my home.",
							name .. "You put my pets to the sword and my houseplants to the torch.",
							name .. "And now you ask for my bodily fluids?",
							name .. "YOU SHALL BURN!"
						},
						1
					)
					player:sendAnimation(112)
					player:sendAnimation(94)
					player:removeHealth(dam)
					player:sendStatus()
					player:calcStat()
					player:setDuration("dragon_fire", 3000)
					player:dialogSeq(
						{
							t,
							name .. "You didn't die? Disappointing.",
							name .. "Do you at least have any gold?",
							name ..
								"Gift me with 100,000 coins, and I will let you leave here alive today, and even grant you a vial of the saliva you desire, for taking the flames so well."
						},
						1
					)
					blackstrike_dragon.gold(player, NPC("Blackstrike"))
				elseif disposition > 0 then
					player:dialogSeq(
						{
							t,
							name .. "You are no enemy of mine, I cannot deny that.",
							name ..
								"I have spent my life aiding others like you, those who would be 'Heroes' in the great struggle between Good and Evil.",
							name .. "You humans are so short-lived, though...",
							name .. "The Heroes are disappearing more quickly then they reappear.",
							name .. "You brave few have my gratitude, for even a dragon cannot hold back the darkness alone.",
							name .. "If I do you this honor, provide what you ask, will you do me the honor of a gift of gold for my hoard?"
						},
						1
					)
					blackstrike_dragon.gold(player, NPC("Blackstrike"))
				end
			--[[
    elseif menu == "" then
        player:dialogSeq({t, name.."",
                            name.."",
                            name.."",
                            name..""}, 1)
        player.quest[""] = 3
        player:msg(4, "[Quest Updated] !", player.ID)
    elseif menu == "" then
         if player:hasItem("", 1) == true then 
            player:dialogSeq({t, name.."",
                                name.."",
                                name.."",
                                name.."",
                                name..""}, 1)
            player:removeItem("", 10)
	    player.quest[""] = 4
            player:giveXP(0)
	    player:addGold(0)
		player:status()
			player:sendStatus()
            player:msg(4, "[Quest Complete] !", player.ID)
        else
            player:dialogSeq({t, name..""}, 1)
        end
]]
			 --
			end
		end
	),
	gold = function(player, npc)
		local name = "<b>[" .. npc.name .. "]\n\n"
		local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		player.lastClick = npc.ID

		local opts2 = {"Yes", "No"}
		local disposition = player.registry["good_karma"] - player.registry["bad_karma"]

		menu = player:menuString(name .. "Are you going to give Blackstrike 100,000 coins?", opts2)

		if menu == "Yes" then
			if player:removeGold(100000) == true then
				player:addItem("dragon_saliva", 1)
				player.quest["angry_guard"] = 9
				player:addLegend("Made a deal with Blackstrike", "blackstrike", 84, 16)
				player:giveXP(20000000)
				finishedQuest(player)
				player:msg(4, "[Quest Updated] You got Dragon Saliva for the recipe!", player.ID)
				player:dialogSeq(
					{
						t,
						name .. "Thank you, human.",
						name .. "As promised, here is the item you sought.",
						name .. "Now leave this place."
					},
					1
				)
			else
				if disposition >= 0 then
					player:dialogSeq({t, name .. "Once you have what interests me, then we can make a trade."}, 1)
				else
					player:sendAnimation(112)
					player:sendAnimation(94)
					player.state = 1
					player.health = 0
					player:sendStatus()
					player:calcStat()
					player:updateState()
					player:warp(3027, 19, 17)
					player:popUp(
						"Furious at your inability to pay, the dragon quickly executes you. You find yourself dead at the House of ASAK."
					)
				end
			end
		else
			if disposition >= 0 then
				player:dialogSeq({t, name .. "Once you have what interests me, then we can make a trade."}, 1)
			else
				player:sendAnimation(112)
				player:sendAnimation(94)
				player.state = 1
				player.health = 0
				player:sendStatus()
				player:calcStat()
				player:updateState()
				player:warp(3027, 19, 17)
				player:popUp(
					"Furious at your refusal to pay, the dragon quickly executes you. You find yourself dead at the House of ASAK."
				)
			end
		end
	end
}
