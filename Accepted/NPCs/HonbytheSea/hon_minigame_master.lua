hon_minigame_master = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			local options = {}
			local availableMinigames = {}
			local goldCost = 200000

			if core.gameRegistry["last_minigame_rental"] ~= 1 and core.gameRegistry["beach_war"] == 0 then
				table.insert(availableMinigames, "Beach War")
			end

			if core.gameRegistry["last_minigame_rental"] ~= 2 and core.gameRegistry["bomber_war"] == 0 then
			--table.insert(availableMinigames, "Bomber War")
			end

			if core.gameRegistry["last_minigame_rental"] ~= 3 and core.gameRegistry["elixir_war"] == 0 then
				table.insert(availableMinigames, "Elixir War")
			end

			if core.gameRegistry["last_minigame_rental"] ~= 4 and core.gameRegistry["freeze_war"] == 0 then
				table.insert(availableMinigames, "Freeze War")
			end

			if core.gameRegistry["last_minigame_rental"] ~= 5 and core.gameRegistry["sumo_war"] == 0 then
				table.insert(availableMinigames, "Sumo War")
			end

			table.insert(options, "Rent a Minigame")
			table.insert(options, "Exit")

			menu = player:menuString(name .. "I'm the Minigame Master. How can I help you?", options)

			if menu == "Rent a Minigame" then
				if minigame_running_check() == true then
					player:popUp("There is currently a minigame in progress or accepting registrations/about to start.")
					return
				end

				--		player:popUp("Too many minigames have been rented. Please try again soon.")
				--		return
				--	end

				choice = player:menuString(name .. "Which Minigame?", availableMinigames)
				if choice == "Beach War" then
					confirm = player:menuString(name .. "The cost is " .. goldCost .. " coins. Is this acceptable?", {"Yes", "No"})
					if confirm == "Yes" then
						if player:removeGold(goldCost) == true then
							broadcast(-1, "[RENTAL]: " .. player.name .. " has rented Beach War!")
							--broadcast(-1, "Beach War has been rented by "..player.name.."!")
							core.gameRegistry["last_minigame_rental"] = 1
							core.gameRegistry["beach_war_completed"] = 1
							beach_war.open()
						else
							player:popUp("Not enough coins!")
						end
					end
				elseif choice == "Bomber War" then
					confirm = player:menuString(name .. "The cost is " .. goldCost .. " coins. Is this acceptable?", {"Yes", "No"})
					if confirm == "Yes" then
						if player:removeGold(goldCost) == true then
							broadcast(-1, "[RENTAL]: " .. player.name .. " has rented Bomber War!")
							--broadcast(-1, "Bomber War has been rented by "..player.name.."!")
							core.gameRegistry["last_minigame_rental"] = 2
							core.gameRegistry["bomber_war_completed"] = 1
							bomber_war.open()
						else
							player:popUp("Not enough coins!")
						end
					end
				elseif choice == "Elixir War" then
					confirm = player:menuString(name .. "The cost is " .. goldCost .. " coins. Is this acceptable?", {"Yes", "No"})
					if confirm == "Yes" then
						if player:removeGold(goldCost) == true then
							broadcast(-1, "[RENTAL]: " .. player.name .. " has rented Elixir War!")
							--broadcast(-1, "Elixir War has been rented by "..player.name.."!")
							core.gameRegistry["last_minigame_rental"] = 3
							core.gameRegistry["elixir_war_completed"] = 1
							elixir_war.open()
						else
							player:popUp("Not enough coins!")
						end
					end
				elseif choice == "Freeze War" then
					confirm = player:menuString(name .. "The cost is " .. goldCost .. " coins. Is this acceptable?", {"Yes", "No"})
					if confirm == "Yes" then
						if player:removeGold(goldCost) == true then
							broadcast(-1, "[RENTAL]: " .. player.name .. " has rented Freeze War!")
							--broadcast(-1, "Flag Freeze Tag has been rented by "..player.name.."!")
							core.gameRegistry["last_minigame_rental"] = 4
							core.gameRegistry["freeze_war_completed"] = 1
							freeze_war.open()
						else
							player:popUp("Not enough coins!")
						end
					end
				elseif choice == "Sumo War" then
					confirm = player:menuString(name .. "The cost is " .. goldCost .. " coins. Is this acceptable?", {"Yes", "No"})
					if confirm == "Yes" then
						if player:removeGold(goldCost) == true then
							broadcast(-1, "[RENTAL]: " .. player.name .. " has rented Sumo War!")
							--broadcast(-1, "Sumo War has been rented by "..player.name.."!")
							core.gameRegistry["last_minigame_rental"] = 5
							core.gameRegistry["sumo_war_completed"] = 1
							sumo_war.open()
						else
							player:popUp("Not enough coins!")
						end
					end
				end
			end
		end
	)
}
