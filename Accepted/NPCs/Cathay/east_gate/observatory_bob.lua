-- observatory Bob
observatory_bob = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local opts = {}

			table.insert(opts, "Ready to listen!")
			table.insert(opts, "Maybe later")

			menu = player:menuString(name .. "Want to hear a story about mutliple worlds?", opts)
			if (menu == "Ready to listen!") then
				player:dialogSeq(
					{
						t,
						name .. "There are many worlds. This story will only invole 3. Morna, Kine, and Mizu.",
						name .. "This world we all call home, this is called Morna. This is known as a linch pin world.",
						name .. "If something were to happen to this world it would have direct side effects on every other nearby world.",
						name .. "All Seeing All Knowing GOD Guides Us! There are different levels of Gods.",
						name .. "GOD is for the creator ASAK and his destroyer brother Skotos.",
						name .. "GOds are for the elder GOds. The first in creation.",
						name .. "Gods are gods whose followers provide them much extra stregth",
						name .. "Then you have gods. They have small followings but are a celestial race none the less.",
						name ..
							"Kine and Mizu were once one world but a powerful mage pulled all the water off the world splitting the two.",
						name .. "Kine is all deserts and lava rivers. Not many gods take residence there anymore.",
						name .. "The ones who remain watch over the fire elves and dwarves.",
						name .. "Mizu is all Water. Posiefin, an elder GOd, controls the waters there and has a footing on Morna.",
						name .. "Many civilizations reside on Mizu that were banished from the World when the world split.",
						name ..
							"Most of them were out on the sea fishing to provide for their communities but instead found their way there.",
						name .. "Here on Morna there are many Orders who follow their gods wishes without question.",
						name .. "Some people here do not even know who they are pledging their loyalty to.",
						name .. "There are several major civilizations of Morna which have risen to power.",
						name .. "Cathay, Cold Iron, Spetan, and SBrini Por Por are among the most popular.",
						name .. "Pai Kang, Hon by the Sea, Stem, San Lisban, and many more cities also try to contend.",
						name .. "Ohh I have much more to say but we will end by saying, Your actions will tell a story.",
						name .. "What kind of story will you leave behind? Take that question on the road with you."
					},
					1
				)
			elseif (menu == "Maybe later") then
				player:dialogSeq({t, name .. "Your loss."}, 1)
			end
		end
	)
}
