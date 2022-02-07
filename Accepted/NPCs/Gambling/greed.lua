greed = {
	click = function(player, npc)
		player:freeAsync()
		player.lastClick = player.ID
		greed.gamble(player, npc)
	end,
	gamble = async(
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

			local options = {"Buy Chips", "Sell Chips", "Odds", "Wins/Losses"}
			local items = {6956, 6957, 6958, 6959, 6960, 6961, 6962, 6963, 6964, 6965}

			local cost

			if player.registry["Gambling_claimchips"] == 0 then
				table.insert(options, "Free Starter Chips")
			end

			menu = player:menuString(name .. "Good day to you, " .. player.name .. "! \n\nWhat would you like to do?", options)

			if menu == "Buy Chips" then
				player:buyExtend(name .. "What chips would you like to buy?", items)
			elseif (menu == "Sell Chips") then
				player:sellExtend(name .. "What chips would you like to buy?", items)
			elseif (menu == "Odds") then
				player:popUp("=====Odds of Winning=====\n1:25\n\nWinning Amount: Chip Value * 20")
			elseif (menu == "Wins/Losses") then
				player:popUp(
					"=====Gambling Statistics=====\n\nTotal Games Played: " ..
						player.registry["Gambling_plays"] ..
							"\nTotal Gold Spent: " ..
								player.registry["Gambling_spent"] ..
									"\n\nWins: " ..
										player.registry["Gambling_wins"] ..
											" Losses: " .. player.registry["Gambling_losses"] .. "\nWin " .. win_pct .. "%"
				)
			elseif (menu == "Free Starter Chips") then
				claim = player:menuString(name .. "Would you like to claim your free chips?", {"Yes", "No"})

				if claim == "Yes" then
					player:popUp(
						"" ..
							player.name .. ",\nThank you for your interest in the casino games. Here are some free chips to get you started."
					)
					player:addItem(6957, 10)
					player.registry["Gambling_claimchips"] = 1
				end
			end
		end
	),
	action = function(npc) --action based off timer
		local betTime = 60
		local selectTime = 71

		core.gameRegistry["roulette_timer"] = core.gameRegistry["roulette_timer"] + 1

		if core.gameRegistry["roulette_timer"] < betTime then
			npc:talk(2, "Bets closing in: " .. (betTime - core.gameRegistry["roulette_timer"]) .. " seconds")
		elseif core.gameRegistry["roulette_timer"] == betTime then
			if core.gameRegistry["roulette_table_1_locked"] == 0 then
				greed.endBetting(npc)
			end
		elseif core.gameRegistry["roulette_timer"] >= betTime and core.gameRegistry["roulette_timer"] <= selectTime then
			npc:talk(2, "Betting is closed! Selection time: " .. selectTime - core.gameRegistry["roulette_timer"])
			greed.randomRoulette(npc)
		elseif core.gameRegistry["roulette_timer"] == selectTime + 1 then
			greed.selectWinner(npc)
			core.gameRegistry["roulette_timer"] = 0
		end
	end,
	endBetting = function(npc)
		local m = npc.m
		local pc = npc:getObjectsInMap(m, BL_PC)

		for i = 1, #pc do
			if (pc[i].x >= 6 and pc[i].x <= 11 and pc[i].y >= 17 and pc[i].y <= 21) then
				pc[i]:warp(m, 14, 17)
			end
		end

		core.gameRegistry["roulette_table_1_locked"] = 1
		greed.closeTable(1)
	end,
	closeTable = function(tableNum)
		local m = 1041
		local noPass = 1

		if tableNum == 1 then
			setObject(m, 11, 17, 682)
			setObject(m, 11, 18, 682)
			setObject(m, 11, 19, 682)
			setPass(m, 11, 17, noPass)
			setPass(m, 11, 18, noPass)
			setPass(m, 11, 19, noPass)
		end
	end,
	openTable = function(tableNum)
		local m = 1041
		local pass = 0

		if tableNum == 1 then
			setObject(m, 11, 17, 0)
			setObject(m, 11, 18, 0)
			setObject(m, 11, 19, 0)
			setPass(m, 11, 17, pass)
			setPass(m, 11, 18, pass)
			setPass(m, 11, 19, pass)
		end
	end,
	randomRoulette = function(npc)
		local m = npc.m
		local x = math.random(6, 10)
		local y = math.random(17, 21)
		local anim = 599
		local sound = 72

		npc:sendAnimationXY(anim, x, y)
		npc:playSound(sound)
	end,
	selectWinner = function(npc)
		local npcs = npc:getObjectsInMap(npc.m, BL_NPC)
		local bets = {}
		local randomNPC
		local randomX = math.random(6, 10)
		local randomY = math.random(17, 21)

		local winner = npc:getObjectsInCell(npc.m, randomX, randomY, BL_NPC)

		for i = 1, #npcs do
			if (npcs[i].x >= 6 and npcs[i].x <= 10 and npcs[i].y >= 17 and npcs[i].y <= 21) then
				table.insert(bets, npcs[i].ID)
			end
		end

		npc:sendAnimationXY(599, randomX, randomY)

		if #winner == 0 then
			npc:talk(0, "Greed: [LOW STAKES] There were no winners.")
			npc:talk(0, "Greed: [LOW STAKES] Winning Tile: X: " .. randomX .. " Y: " .. randomY)
		else
			winningPlayer = npc:getBlock(winner[1].owner)
			greed.showWinner(npc, winningPlayer)
			greed.declareWinner(npc, randomX, randomY, winningPlayer)
		end
		greed.resetGame(npc, winningPlayer)
	end,
	showWinner = function(npc, winningPlayer)
		local npc = core:getObjectsInMap(npc.m, BL_NPC)

		for i = 1, #npc do
			if (npc[i].x >= 6 and npc[i].x <= 10 and npc[i].y >= 17 and npc[i].y <= 21) then
				if npc.owner == winningPlayer.ID then
					npc:sendAnimation(599)
				end
			end
		end
	end,
	resetGame = function(npc, winningPlayer)
		local npcs = npc:getObjectsInMap(npc.m, BL_NPC)
		local items = npc:getObjectsInMap(npc.m, BL_ITEM)
		local players = npc:getObjectsInMap(npc.m, BL_PC)

		for i = 1, #npcs do
			if (npcs[i].x >= 6 and npcs[i].x <= 10 and npcs[i].y >= 17 and npcs[i].y <= 21) then
				npcs[i]:delete()
			end
		end

		for i = 1, #items do
			if (items[i].x >= 6 and items[i].x <= 10 and items[i].y >= 17 and items[i].y <= 21) then
				items[i]:delete()
			end
		end

		if (#players > 0) then
			for i = 1, #players do
				if (players[i].registry["Gamble_Table1"] == 1) then
					players[i].registry["Gambling_plays"] = players[i].registry["Gambling_plays"] + 1
					players[i].registry["Gambling_losses"] =
						players[i].registry["Gambling_plays"] - players[i].registry["Gambling_wins"]
					players[i].registry["Gamble_Table1"] = 0
					if math.random(1, 20) == 1 then
						players[i]:popUp("Well, aren't you lucky?!\n\nYou have been rewarded (5) Gambling Chip (1k)")
						players[i]:addItem(6958, 5)
					end
				end
			end
		end

		greed.openTable(1)
		core.gameRegistry["roulette_timer"] = 0
		core.gameRegistry["roulette_table_1_locked"] = 0
	end,
	declareWinner = function(npc, x, y, winningPlayer)
		local items = npc:getObjectsInCell(npc.m, x, y, BL_ITEM)

		if #items ~= 0 then
			local id = items[1].id
			amount = 20

			local total_amount = items[1].price * amount

			Player(winningPlayer.id):addItem(id, amount)
			Player(winningPlayer.id):sendAnimation(2)
			Player(winningPlayer.id):playSound(123)
			Player(winningPlayer.id).registry["Gambling_wins"] = Player(winningPlayer.id).registry["Gambling_wins"] + 1

			npc:talk(
				0,
				"Greed: [LOW STAKES] Congratulations " ..
					winningPlayer.name .. "! You have won (" .. amount .. ") " .. items[1].name
			)
			npc:talk(0, "Greed: [LOW STAKES] The Winning tile was X: " .. x .. " Y: " .. y)

			if items[1].price == 10000 then
				broadcast(
					-1,
					"[Greed]: Congratulations to " ..
						winningPlayer.name .. " for winning the Small Stakes jackpot! Amount won: 200,000 Gold"
				)
			end

			gambling_titles.grantTitle(winningPlayer)
		end
	end
}

--123 winsound
--selecting = 72
