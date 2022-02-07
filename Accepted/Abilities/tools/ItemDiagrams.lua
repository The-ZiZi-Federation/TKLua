pickaxe_diagram = {
	use = function(player)
		player:freeAsync()
		player.lastClick = player.ID
		player.npcGraphic = 0
		player.dialogType = 0
		pickaxe_diagram.readDiagram(player)
	end,
	readDiagram = async(
		function(player, npc)
			local smithingLevel = player.registry["smithing_level"]
			local makePickAxe = player.registry["smith_pickaxe_knowledge"]

			local name
			local optsToolSelectMenu = {}
			local toolDiagraMenuOption

			name = "<b>[Pickaxe Diagram]<b>\n\n"

			if not player:canAction(1, 1, 1) then
				player:sendMinitext("You cannot do that right now!")
				return
			end

			if makePickAxe ~= 1 then
				player.registry["smith_pickaxe_knowledge"] = 1
				player:dialogSeq({name .. "You have read over the diagram and learned the basics steps for making a pickaxe!!"}, 1)
			end

			if smithingLevel ~= nil then
				if smithingLevel > 0 then
					table.insert(optsToolSelectMenu, "Copper Pickaxe")
				end

				--	if smithingLevel > 1 then
				--	end

				--	if smithingLevel > 2 then
				--	end

				--	if smithingLevel > 3 then
				--	end

				if smithingLevel > 4 then
					table.insert(optsToolSelectMenu, "Iron Pickaxe")
				end

				--	if smithingLevel > 5 then
				--	end

				--	if smithingLevel > 6 then
				--	end

				--	if smithingLevel > 7 then
				--	end

				--	if smithingLevel > 8 then
				--	end

				--	if smithingLevel > 9 then
				--	end

				--	if smithingLevel > 10 then
				--	end

				if smithingLevel > 11 then
					table.insert(optsToolSelectMenu, "Admantium Pickaxe")
				end

				--	if smithingLevel > 12 then
				--	end

				--	if smithingLevel > 13 then
				--	end

				--	if smithingLevel > 14 then
				--	end

				--	if smithingLevel > 15 then
				--	end

				--	if smithingLevel > 16 then
				--	end

				if player.gmLevel > 0 then
					table.insert(optsToolSelectMenu, "Copper Pickaxe")
					table.insert(optsToolSelectMenu, "Iron Pickaxe")
					table.insert(optsToolSelectMenu, "Admantium Pickaxe")
				end

				table.insert(optsToolSelectMenu, "Finished Reading")

				itemDiagramMenuOption = player:menuString("Diagrams", optsToolSelectMenu)
				if itemDiagramMenuOption == "Copper Pickaxe" then
					popup = "<b>          | " .. itemDiagramMenuOption .. " |\n"
					popup = popup .. "+=====================================+\n"
					popup = popup .. "             | Components  |            \n"
					popup = popup .. "             +=============+            \n "
					popup = popup .. "\n"
					popup = popup .. "\n"
					popup = popup .. "2 Copper Ingots\n"
					popup = popup .. "\n"

					player:popUp(popup)

					return
				elseif itemDiagramMenuOption == "Iron Pickaxe" then
					popup = "<b>          | " .. itemDiagramMenuOption .. " |\n"
					popup = popup .. "+=====================================+\n"
					popup = popup .. "             | Components  |            \n"
					popup = popup .. "             +=============+            \n "
					popup = popup .. "\n"
					popup = popup .. "\n"
					popup = popup .. "2 Iron Ingots\n"
					popup = popup .. "\n"

					player:popUp(popup)

					return
				elseif itemDiagramMenuOption == "Admantium Pickaxe" then
					popup = "<b>          | " .. itemDiagramMenuOption .. " |\n"
					popup = popup .. "+=====================================+\n"
					popup = popup .. "             | Components  |            \n"
					popup = popup .. "             +=============+            \n "
					popup = popup .. "\n"
					popup = popup .. "\n"
					popup = popup .. "\n"
					popup = popup .. "2 Admantium Ingots\n"
					popup = popup .. "\n"

					player:popUp(popup)

					return
				elseif itemDiagramMenuOption == "Finished Reading" then
					return
				else
					return
				end
			end
		end
	)
}
