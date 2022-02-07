stranded_sailor = {
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
			local sellitems = {}

			if player.level <= 79 and player.quest["crates"] == 0 then
				table.insert(opts, "You look pretty down")
			end
			if player.level >= 80 and player.quest["crates"] == 0 then
				table.insert(opts, "Can I help out?")
			end
			if player.quest["crates"] == 1 then
				table.insert(opts, "I'm back!")
			end
			if player.quest["crates"] >= 2 then
				table.insert(opts, "Sell")
			end
			if player.quest["crates"] >= 2 then
				table.insert(sellitems, 391)
			end
			if player.quest["crates"] == 2 then
				table.insert(opts, "Need anything else?")
			end
			if player.quest["crates"] == 3 then
				table.insert(opts, "I brought some Shell Fragments")
			end
			if player.quest["crates"] == 4 and player.quest["gator_scales"] == 0 and player.level >= 99 then
				table.insert(opts, "Need another favor?")
			end
			if player.quest["gator_scales"] == 1 then
				table.insert(opts, "I brought some Gator Scales")
			end

			menu = player:menuString(name .. "The sailor's life is a hard life.", opts)

			if menu == "Sell" then
				player:sellExtend("What do you wish to sell?", sellitems)
			elseif menu == "You look pretty down" then
				player:dialogSeq(
					{t, name .. "Yeah, no kidding! My boat wrecked on the shore and my cargo is scattered all over the beach."},
					1
				)
			elseif menu == "Can I help out?" then
				player:dialogSeq(
					{
						t,
						name .. "I need help, that's for sure. My boat wrecked on the shore and my cargo is scattered all over the beach."
					},
					1
				)

				menu2 = player:menuString(name .. "Will you help me recover my lost cargo?", opts2)

				if menu2 == "Yes" then
					player:dialogSeq(
						{
							t,
							name .. "You're gonna help? Awesome! My shipping crates are scattered all across the shoreline west of here.",
							name ..
								"They're waterlogged and rotting away by now, so just smash the crates open and bring back the supply boxes that are inside.",
							name .. "If you bring back 50 of my supply boxes, I'll be able to recover some of my losses."
						},
						1
					)
					player.quest["crates"] = 1
					player:msg(4, "[Quest Updated] Recover 50 Lost Supplies!", player.ID)
				end
			elseif menu == "I'm back!" then
				if player:hasItem("lost_supplies", 50) == true then
					player:dialogSeq(
						{
							t,
							name .. "You got my supplies! I hope those critters on the beach didn't give you too much trouble.",
							name .. "When I tried to go get the supplies myself, I almost lost a leg to one of those lobsters.",
							name .. "I know there are more supplies out there, though.",
							name .. "If you bring back any more of my supplies I'll be happy to pay you for them."
						},
						1
					)
					player:removeItem("lost_supplies", 50)
					player.quest["crates"] = 2
					giveXP(player, 2500000)
					player:addGold(25000)
					finishedQuest(player)
					player:calcStat()
					player:sendStatus()
					player:msg(4, "[Quest Complete] Recovered the Lost Supplies", player.ID)
				else
					player:dialogSeq(
						{
							t,
							name .. "Aren't you going to find my supplies? They're all over the beach to the west.",
							name .. "Oh well, maybe someone else will help me..."
						},
						1
					)
				end
			elseif menu == "Need anything else?" then
				player:dialogSeq(
					{
						t,
						name .. "I'm still saving up to buy a new boat, thanks for all your help.",
						name .. "I do have another request, if you have time.",
						name .. "My friend taught me how to make something cool. I just need a few more things to finish it.",
						name .. "I need some Snail Shell Fragments. About 5 of them should do it."
					},
					1
				)
				player.quest["crates"] = 3
				player:msg(4, "[Quest Updated] Find 5 Snail Shell Fragments!", player.ID)
			elseif menu == "I brought some Shell Fragments" then
				if player:hasItem("snail_shell_fragment", 5) == true then
					player:dialogSeq(
						{
							t,
							name .. "You brought them? Great! Now I can finish upgrading my brother's shield for him.",
							name .. "My friend Banon taught me how to do it. He's great at making things.",
							name .. "Banon is a really nice guy, I'm sure he'd teach you to do it if you ask.",
							name .. "He lives in Hon by the Sea. His house is hard to miss, it's south of West gate and has a green roof.",
							name .. "Thanks again for helping me out!"
						},
						1
					)
					player:removeItem("snail_shell_fragment", 5)
					player.quest["crates"] = 4
					giveXP(player, 5000000)
					player:addGold(50000)
					finishedQuest(player)
					player:calcStat()
					player:sendStatus()
					player:msg(4, "[Quest Complete] Brought the sailor some Shell Fragments!", player.ID)
				else
					player:dialogSeq(
						{t, name .. "Those Posessed Snails sure are tough aren't they? Come back when you have 5 Snail Shell Fragments."},
						1
					)
				end
			elseif menu == "Need another favor?" then
				player:dialogSeq(
					{
						t,
						name .. "Yes, I would love some help.",
						name .. "I'm working on another project, and boy, am I having trouble.",
						name .. "Banon taught me another secret, so I'm trying to find the materials I need.",
						name .. "The recipe calls for Gator Scales though, and those suckers are tough.",
						name ..
							"I need two kinds, too. I almost have enough already, but it'd be a big help if you can go get me another 20 Swamp Gator Scale and 20 Blackstrike Gator Scale."
					},
					1
				)
				player.quest["gator_scales"] = 1
				player:msg(4, "[Quest Updated] Bring Jerry 20 Swamp Gator Scale and 20 Blackstrike Gator Scale!", player.ID)
			elseif menu == "I brought some Gator Scales" then
				if player:hasItem("swamp_gator_scale", 20) == true and player:hasItem("blackstrike_gator_scale", 20) == true then
					if player:removeItem("swamp_gator_scale", 20) == true and player:removeItem("blackstrike_gator_scale", 20) == true then
						player.quest["gator_scales"] = 2
						giveXP(player, 75000000)
						player:addGold(100000)
						finishedQuest(player)
						player:calcStat()
						player:sendStatus()
						player:msg(4, "[Quest Complete] Brought the sailor some Gator Scales!", player.ID)
						player:dialogSeq(
							{
								t,
								name .. "Excellent! You're a true pal.",
								name .. "With this I can finally finish my Armor Upgrade.",
								name .. "What, you want to upgrade your own armor too?",
								name .. "Just ask Banon, he'll tell you what to do."
							},
							1
						)
					else
						player:dialogSeq({t, name .. "That's not enough scales..."}, 1)
					end
				else
					player:dialogSeq({t, name .. "That's not enough scales..."}, 1)
				end
			end
		end
	),
	nearbyPlayers = function(npc)
		local pc = npc:getObjectsInArea(BL_PC)
		local m, x, y = npc.m, npc.x, npc.y

		if #pc > 0 then
			for i = 1, #pc do
				if pc[i].level >= 80 and (pc[i].quest["crates"] == 0 or pc[i].quest["crates"] == 2) then
					pc[i]:selfAnimationXY(pc[i].ID, 248, x, y)
				elseif pc[i].quest["crates"] == 4 and pc[i].quest["gator_scales"] == 0 and pc[i].level >= 99 then
					pc[i]:selfAnimationXY(pc[i].ID, 248, x, y)
				end
			end
		end
	end
}
