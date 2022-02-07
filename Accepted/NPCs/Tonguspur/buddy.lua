-- guard in woods, (edbard is a criminal)
hon_guard_buddy = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local opts = {}
			local locs = {}

			if player.quest["spider"] == 1 then
				table.insert(opts, "A weird guy asked me for spider venom")
			end
			table.insert(opts, "I'm lost! Can you help me?")
			table.insert(opts, "*Leave*")
			table.insert(locs, "Tonguspur Shops")
			table.insert(locs, "Tonguspur Carpenter")
			table.insert(locs, "Tonguspur Beach")
			table.insert(locs, "The Wilderness")
			table.insert(locs, "Road to Cathay")

			menu = player:menuString(name .. "It sure is boring being a guard out here.", opts)

			if menu == "A weird guy asked me for spider venom" then
				if player:hasItem("queen_venom_sac", 1) == true then
					if player:removeItem("queen_venom_sac", 1) == true then
						player.quest["spider"] = 3
						giveXP(player, 1000000)
						player:addGold(50000)
						finishedQuest(player)
						player:calcStat()
						player:sendStatus()
						hon_guard_buddy.addLegend(player)
						player:dialogSeq(
							{
								t,
								name .. "Spider venom?",
								name .. "There's been a string of murders around here lately.",
								name .. "The victims were all poisoned with spider venom.",
								name .. "If you know who might be behind it, you have to tell me!",
								"You tell the guard about the suspicous man named Edbard",
								name .. "Yeah, I think I've seen that guy loitering around here.",
								name .. "I knew he was up to no good.",
								name .. "I'm going to go have a chat with this 'Edbard'.",
								name .. "Thanks for the tip! We need more upstanding citizens like you."
							},
							1
						)
					else
						player:dialogSeq(
							{
								t,
								name .. "Spider venom?",
								name .. "That's a bold claim.",
								name .. "I can't act on a tip like that. Maybe if I saw the venom sac for myself.."
							},
							1
						)
					end
				else
					player:dialogSeq(
						{
							t,
							name .. "Spider venom?",
							name .. "That's a bold claim.",
							name .. "I can't act on a tip like that. Maybe if I saw the venom sac for myself.."
						},
						1
					)
				end
			elseif menu == "I'm lost! Can you help me?" then
				warp = player:menuString(name .. "Where would you like to go?", locs)
				if warp == "Tonguspur Shops" then
					player:dialogSeq(
						{
							t,
							name ..
								"In Tonguspur, there's a weapon smith named Kramoris and a seamstress named Agnes. I'll show you where there shops are."
						},
						1
					)
					player:warp(2000, 67, 104)
				elseif warp == "Tonguspur Carpenter" then
					player:dialogSeq({t, name .. "That Carpenter is a great guy. Tell him Buddy says hello!"}, 1)
					player:warp(2000, 89, 133)
				elseif warp == "Tonguspur Beach" then
					player:dialogSeq({t, name .. "The beach is northwest of here. I'll show you."}, 1)
					player:warp(2000, 2, 35)
				elseif warp == "The Wilderness" then
					player:dialogSeq(
						{
							t,
							name .. "If you're looking for the wilderness, you'll need to pass through Harvest Grove. I'll show you the way."
						},
						1
					)
					player:warp(2000, 143, 17)
				elseif warp == "Road to Cathay" then
					player:dialogSeq(
						{
							t,
							name ..
								"Cathay is far north of here. You probably won't ever get past the gate, but I can show you the road to take."
						},
						1
					)
					player:warp(2000, 14, 7)
				end
			end
		end
	),
	addLegend = function(player)
		local reg = player.registry["good_karma"]

		finishedQuest(player)
		if player:hasLegend("honor") then
			player:removeLegendbyName("honor")
		end

		if reg > 0 then
			player.registry["good_karma"] = player.registry["good_karma"] + 1
			player:addLegend("Did the right thing " .. player.registry["good_karma"] .. " times", "honor", 35, 144)
		else
			player.registry["good_karma"] = 1
			player:addLegend("Did the right thing 1 time", "honor", 35, 144)
		end
	end
}
