raffle = {
	click = function(player, npc)
		player:freeAsync()
		player.lastClick = player.ID
		raffle.showmenu(player, npc)
	end,
	showmenu = async(
		function(player, npc)
			local win_pct

			if player.registry["Gambling_plays"] == 0 then
				win_pct = 0
			else
				win_pct = (player.registry["Gambling_wins"] / player.registry["Gambling_plays"]) * 100
			end

			local name = "<b>[" .. npc.name .. "]\n\n"

			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local gold
			local maxEntries = 100

			for i = 1, maxEntries do
				if npc.registry["raffle_entry" .. i] == player.id then
					player.registry["raffle_bet"] = 1
					break
				else
					player.registry["raffle_bet"] = 0
				end
			end

			local options = {"Info", "Wins/Losses"}

			if player.registry["raffle_bet"] == 0 and player.gmLevel == 0 then
				table.insert(options, "Enter an entry into raffle")
			elseif player.gmLevel > 0 then
				table.insert(options, "Enter an entry into raffle")
				table.insert(options, "Draw winner")
				table.insert(options, "Reset raffle")
				table.insert(options, "View entries")
			end

			menu = player:menuString(name .. "Good day to you, " .. player.name .. "!\n\nWhat would you like to do?", options)

			if menu == "Enter an entry into raffle" then
				if npc.registry["raffle_entries"] == maxEntries then
					player:popUp(
						"Sorry " ..
							player.name .. ", the number of maximum entries has been reached. Please place your bet after the drawing."
					)
					return
				end

				if player.registry["raffle_bet"] == 1 and player.gmLevel == 0 then
					player:popUp("Sorry " .. player.name .. ", but you may only have one entry in the drawing.")
					return
				end

				gold = 50000

				local confirm = player:menuString("Would you like to enter into the drawing for 50k gold?", {"Yes", "No"})

				if confirm == "Yes" then
					if gold > player.money then
						player:popUp("Sorry " .. player.name .. ", but that is more gold than you currently have.")
						return
					end

					if player:removeGold(gold) == true then
						for i = 1, maxEntries do
							if npc.registry["raffle_entry" .. i] == 0 then
								npc.registry["raffle_entry" .. i] = player.id
								npc.registry["raffle_entry" .. i .. "_amount"] = gold
								npc.registry["raffle_entries"] = npc.registry["raffle_entries"] + 1
								npc.registry["raffle_total_gold"] = npc.registry["raffle_total_gold"] + gold
								player.registry["Gambling_spent"] = player.registry["Gambling_spent"] + gold
								break
							end
						end
						player.registry["raffle_bet"] = 1
						player:popUp(
							"Thank you for your entry, " .. player.name .. "\n\nPlease check back in 10 minutes to see if you've won!"
						)
					end
				end
			elseif menu == "Info" then
				player:popUp(
					"===== Raffle Information ======\n\nHouse collects 10%\nPlayer gives 50k gold to NPC for one entry into the raffle drawing. Each player currently allowed one maximum entry. Every 10 minutes, a random entry is chosen and the winner takes the pot, minus a 10% house fee.\n\n----DISCLAIMER----\nBeing logged out or in Cathay at time of drawing will forfeit the win."
				)
			elseif menu == "Wins/Losses" then
				player:popUp(
					"=====Gambling Statistics=====\n\nHouse fees collected: " ..
						core.gameRegistry["raffle_house_fees"] ..
							"\n\nTotal Games Played: " ..
								player.registry["Gambling_plays"] ..
									"\nTotal Gold Spent: " ..
										player.registry["Gambling_spent"] ..
											"\n\nWins: " ..
												player.registry["Gambling_wins"] ..
													" Losses: " .. player.registry["Gambling_losses"] .. "\nWin " .. win_pct .. "%"
				)
			elseif menu == "Draw winner" then
				raffle.drawWinner(npc)
			elseif menu == "View entries" then
				for i = 1, maxEntries do
					if npc.registry["raffle_entry" .. i] ~= 0 then
						player:talkSelf(
							0,
							"Entry " ..
								i ..
									": " ..
										Player(npc.registry["raffle_entry" .. i]).name ..
											" Amount: " .. npc.registry["raffle_entry" .. i .. "_amount"] .. " gold."
						)
					end
				end
			elseif menu == "Reset raffle" then
				raffle.resetRaffle(npc)
			end
		end
	),
	resetRaffle = function(npc)
		local maxEntries = 100

		--- Now clear NPC bet registries ---

		for i = 1, maxEntries do
			npc.registry["raffle_entry" .. i] = 0
			npc.registry["raffle_entry" .. i .. "_amount"] = 0
		end

		npc.registry["raffle_entries"] = 0
		npc.registry["raffle_total_gold"] = 0
		--npc:talk(0,"Raffle entries reset")
		npc.registry["warning_announce"] = 0
		npc.registry["timer"] = 0
	end,
	drawWinner = function(npc)
		local winningPlayer
		local winningNumber

		if npc.registry["raffle_entries"] == 0 then
			raffle.resetRaffle(npc)
		end

		winningNumber = math.random(1, npc.registry["raffle_entries"])
		winningPlayer = Player(npc.registry["raffle_entry" .. winningNumber])

		while winningPlayer == nil do -- handles if player logged, redraws
			npc:talk(0, "redrawing...")
			raffle.drawWinner(npc)
		end

		local amount_won = round(npc.registry["raffle_total_gold"] * 0.90)
		core.gameRegistry["raffle_house_fees"] =
			core.gameRegistry["raffle_house_fees"] + round(npc.registry["raffle_total_gold"] * 0.10)

		if winningPlayer ~= nil then
			winningPlayer.registry["Gambling_wins"] = winningPlayer.registry["Gambling_wins"] + 1
			winningPlayer:addGold(amount_won)
			winningPlayer:popUp(
				"Congratulations " ..
					winningPlayer.name .. ",\n\nYou have won the raffle drawing and " .. amount_won .. " gold has been awarded to you."
			)
		end

		for i = 1, npc.registry["raffle_entries"] do
			if Player(npc.registry["raffle_entry" .. i]) ~= nil then
				Player(npc.registry["raffle_entry" .. i]).registry["Gambling_plays"] =
					Player(npc.registry["raffle_entry" .. i]).registry["Gambling_plays"] + 1
				Player(npc.registry["raffle_entry" .. i]).registry["Gambling_losses"] =
					Player(npc.registry["raffle_entry" .. i]).registry["Gambling_plays"] -
					Player(npc.registry["raffle_entry" .. i]).registry["Gambling_wins"]
			end
		end

		--npc:talk(0,"[Lars]: Congratulations to Winning Raffle Entry #"..winningNumber..". "..winningPlayer.name..", you have just won "..amount_won.." gold!")

		broadcast(
			-1,
			"[Lars]: Congratulations to Winning Raffle Entry #" ..
				winningNumber .. ". " .. winningPlayer.name .. ", you have just won " .. amount_won .. " gold!"
		)

		raffle.resetRaffle(npc)
	end,
	action = function(npc)
		npc.registry["timer"] = npc.registry["timer"] + 1

		if npc.registry["timer"] == 20 then
			broadcast(-1, "[Lars]: Feeling lucky? Head to the Hon Casino and place your name in a raffle drawing!")
		end

		local drawTime = 72000
		local betWarningTime = drawTime - 300

		if npc.registry["timer"] == drawTime then
			if (npc.registry["raffle_entries"] > 1) then
				raffle.drawWinner(npc)
			elseif (npc.registry["raffle_entries"] == 0) then
				raffle.resetRaffle(npc)
			end
		elseif (npc.registry["timer"] == betWarningTime) then
			broadcast(-1, "[Lars]: 5 minute warning to Raffle drawing. Please submit your entries.")
		elseif (npc.registry["timer"] == drawTime + 60) then -- failsafe reset
			raffle.resetRaffle(npc)
		end
	end
}
