hon_administration = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local opts = {}

			table.insert(opts, "What can I do here?")
			if player.registry["hon_citizen"] == 0 then
				table.insert(opts, "Make me a citizen!")
			end
			if player.registry["hon_citizen"] == 1 then
				table.insert(opts, "How goes the recordkeeping?")
			end

			menu = player:menuString(name .. "Hello! I am Chi-Fu. I keep track of the city's census here.", opts)

			if (menu == "What can I do here?") then
				player:dialogSeq(
					{
						t,
						name .. "You're new to Hon? You should register your name as a citizen if you plan on staying here.",
						name .. "If you become a citizen you will recieve a mark on your papers and a special ability."
					},
					1
				)
			elseif (menu == "Make me a citizen!") then
				choice = player:menuString("You want to become a citizen of Hon by the Sea?", {"Yes", "No"})
				if choice == "Yes" then
					player:dialogSeq(
						{
							t,
							name ..
								"Excellent! Just sign here, here, here, and here, initial here, prick your thumb and leave a bloody thumbprint HERE.",
							name .. "Now that you are a citizen, I'll teach you a simple spell that we use to communicate around here.",
							name .. "It is called Whispering Wind, and it allows you to magically enhance your voice to be heard by all.",
							name ..
								"I only know how to use the weakest version, but I hear that those more powerful than I can use the ability far more often."
						},
						1
					)

					if player.registry["citizen"] == 0 then
						player:addSpell("whispering_wind_1")
					end
					player:removeLegendbyName("citizen")
					player:addLegend("Became a citizen of Hon by the Sea " .. curT(), "citizen", 11, 1)
					player.registry["citizen"] = 1
					player.registry["hon_citizen"] = 1
					player.country = 4 -- Hon by the Sea
					player:sendStatus()
					finishedQuest(player)
				end
			elseif (menu == "How goes the recordkeeping?") then
				player:dialogSeq(
					{
						t,
						name .. "I am just fine, myself. How about you?",
						name .. "I hope you're enjoying your new life in Hon by the Sea."
					},
					1
				)
			end
		end
	)
}
