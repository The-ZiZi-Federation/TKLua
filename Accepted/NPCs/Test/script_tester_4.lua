script_tester_4 = {
	click = async(
		function(player, npc)
			local options = {}
			local choice = ""
			local check = 0

			local npcG = {graphic = 0, color = 0}
			player.npcGraphic = npcG.graphic
			player.npcColor = npcG.color
			player.dialogType = 1
			player.lastClick = npc.ID

			options = {"Yes", "No"}
			choice = player:menuString("Would you like to help me complete my research where canidae dwell?", options)

			if (choice == "Yes") then
				if (#player.group > 8) then
					player:dialog(
						"Your group is too big!\n\nIf all of you go in you will scare the fox away and my research won't be possible!",
						{}
					)
				elseif (#player.group <= 1) then
					player:dialog("You're going to need a party for this trip, I won't trust my research to just one person.", {})
				else
					local mapStart = getFreeInstance(6)
					if (mapStart ~= false) then
						if (loadInstance(mapStart, "canidae") == true) then
							for i = 1, #player.group do
								groupedPlayer = Player(player.group[i])

								if (groupedPlayer.m == 3999 and groupedPlayer.level >= 1) then
									groupedPlayer.registry["canidae1Spawned"] = 0
									groupedPlayer.registry["canidae2Spawned"] = 0
									groupedPlayer.registry["canidae3Spawned"] = 0
									groupedPlayer.registry["canidae4Spawned"] = 0
									groupedPlayer.registry["canidae5Spawned"] = 0
									groupedPlayer.registry["canidae6Spawned"] = 0
									groupedPlayer:warp(mapStart, math.random(1, 2), math.random(6, 8))
								end
							end
						else
							unloadInstance(mapStart, 6)
						end
					end
				end
			end
		end
	)
}
