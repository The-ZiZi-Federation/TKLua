-- Hon top right the hermit
hon_hermit = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local opts = {}

			if player.quest["leech"] == 0 then
				table.insert(opts, "You live way out here?")
			end
			if player.level >= 40 and player.quest["leech"] == 0 then
				table.insert(opts, "I'm looking for some work.")
			end
			if player.quest["leech"] == 1 then
				table.insert(opts, "About that cave...")
			end
			if player.quest["leech"] == 2 then
				table.insert(opts, "Look what I found!")
			end
			if player.quest["leech"] == 3 then
				table.insert(opts, "Sure you don't have any work?")
			end
			if
				player.quest["blackstrike_torch"] == 1 and player:hasItem("living_root", 10) == true and
					player:hasItem("mud_clump", 5) == true
			 then
				table.insert(opts, "Isaac sent me with these")
			end

			menu = player:menuString(name .. "What is it?", opts)

			if menu == "You live way out here?" then
				player:dialogSeq(
					{
						t,
						name .. "Yes. I moved way out here because I thought I'd have less strangers barging through my door.",
						name .. "Clearly, I was wrong."
					},
					1
				)
			elseif menu == "I'm looking for some work." then
				player:dialogSeq(
					{
						t,
						name .. "Work?",
						name .. "No, I don't have any 'work' for you.",
						name .. "But if you're bored, I might have something for you to do.",
						name .. "There's a cave south of Hon that is completely overrun by vicious leeches",
						name .. "I heard a rumor that pirates hid a valuable treasure there long ago.",
						name ..
							"No one has been brave or stupid enough to go searching for it, but you look like just the right combination of the two.",
						name .. "If you manage to find any treasure, how about you come back and pay me a finder's fee?"
					},
					1
				)
				player.quest["leech"] = 1
				player:msg(4, "[Quest Updated] Find the leech cave in South Shores of Hon!", player.ID)
			elseif menu == "About that cave..." then
				player:dialogSeq(
					{
						t,
						name .. "The cave is near the shores, to the south of Hon./n/n('Shores of Hon' X: 42, Y: 63)",
						name .. "You'll never find the treasure by standing around here. Get to it!"
					},
					1
				)
			elseif menu == "Look what I found!" then
				player:dialogSeq({t, name .. "Wow! You did it!"}, 1)
				giveXP(player, 150000)
				finishedQuest(player)
				player:calcStat()
				player:sendStatus()
				player:sendMinitext("You have made a hermit happy.")
				player.quest["leech"] = 3
				player:msg(4, "[Quest Completed] Money Money Money Moneeeeyyyy!!!!", player.ID)
			elseif menu == "Sure you don't have any work?" then
				player:dialogSeq(
					{t, name .. "Not at the moment, but you have proved your capability, so I might have something for you later."},
					1
				)
			elseif menu == "Isaac sent me with these" then
				if player:removeItem("living_root", 10) == true and player:removeItem("mud_clump", 5) == true then
					player.quest["blackstrike_torch"] = 2
					player:addItem("unlit_eclipse_torch", 1)
					finishedQuest(player)
					player:msg(4, "[Quest Updated] Return to Isaac in Blackstrike Tower!", player.ID)
					player:dialogSeq(
						{
							t,
							name .. "My good friend Isaac. I have not seen him in forever.",
							name .. "Ohhh my. You are trying to make the Eclipse Torch!",
							name .. "I have a book here, let me take a look.",
							name .. "Yes, that could work.",
							name .. "Give me those ingredients",
							name .. "*Bundles the roots, covers them in mud, and pours a black fluid on one end*",
							name .. "In the name of the All Seeing All Knowing God, Form Bond!",
							name .. "Now you can return to Isaac. Please let me know if this works when you return."
						},
						1
					)
				else
					player:dialogSeq({t, name .. "Isaac sent you with what? I see nothing."}, 1)
				end
			end
		end
	)
}
