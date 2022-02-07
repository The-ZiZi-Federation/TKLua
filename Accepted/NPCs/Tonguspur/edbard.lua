-- rogue edbard in woods (spider cave)
edbard = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local opts = {}

			if player.level >= 60 and player.quest["spider"] == 0 then
				table.insert(opts, "Need any help?")
			end
			if player.quest["spider"] == 1 then
				table.insert(opts, "I got your venom sac.")
			end
			if player.quest["spider"] == 3 then
				table.insert(opts, "I told the guard on you!")
			end

			menu = player:menuString(name .. "I'm not doing anything illegal, so scram!", opts)

			if menu == "Need any help?" then
				player:dialogSeq(
					{
						t,
						name .. "The man gives you a hard stare up and down, then looks you in the eye.",
						name .. "Yeah, now that you mention it, maybe you can help me out.",
						name .. "I came to this forest looking for spider venom.",
						name .. "It's very important for... something I'm working on.",
						name .. "I tried getting it myself, but those spiders were a lot bigger than I expected.",
						name .. "You look pretty tough, I don't think you'd have any trouble getting some venom.",
						"Edbard suddenly looks off to his side",
						name .. "Wait.",
						name .. "What was that?",
						name .. "Did you hear that?",
						name .. "Get out of here before they see me!",
						name .. "Don't come back until you have that venom sac!"
					},
					1
				)
				player.quest["spider"] = 1
				player:msg(4, "[Quest Started] Bring Edbard a Venom Sac from the Spider Den", player.ID)
			elseif menu == "I got your venom sac." then
				if player:hasItem("queen_venom_sac", 1) == true then
					if player:removeItem("queen_venom_sac", 1) == true then
						player.quest["spider"] = 2
						giveXP(player, 1000000)
						player:addGold(50000)
						finishedQuest(player)
						player:calcStat()
						player:sendStatus()
						edbard.addLegend(player)
						player:msg(4, "[Quest Completed] Should you have done that?", player.ID)
						player:dialogSeq(
							{
								t,
								name .. "Hot damn, you actually got it!",
								name .. "I thought you'd just die like all the others...",
								name .. "Uh, I mean, what's that over there?!",
								name .. "Oh I guess it was nothing.",
								name .. "You really helped me out, so take this as a thank you."
							},
							1
						)
					else
						player:dialogSeq({t, name .. "Don't come back here without that Venom Sac!"}, 1)
					end
				else
					player:dialogSeq({t, name .. "Don't come back here without that Venom Sac!"}, 1)
				end
			elseif menu == "I told the guard on you!" then
				player:dialogSeq(
					{
						t,
						name .. "That was you?! They couldn't prove I did anything, but I still had to pay a huge bribe!",
						name .. "You're lucky I'm not in the mood to kill you."
					},
					1
				)
			end
		end
	),
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
	nearbyPlayers = function(npc)
		local pc = npc:getObjectsInArea(BL_PC)
		local m, x, y = npc.m, npc.x, npc.y

		if #pc > 0 then
			for i = 1, #pc do
				if pc[i].level >= 60 and pc[i].quest["spider"] == 0 then
					pc[i]:selfAnimationXY(pc[i].ID, 248, x, y)
				end
			end
		end
	end
}
