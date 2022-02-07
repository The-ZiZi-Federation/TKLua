race_better = {
	click = function(player, npc)
		player:freeAsync()
		player.lastClick = player.ID
		race_better.bet(player, npc)
	end,
	bet = async(
		function(player, npc)
			local mobs = npc:getObjectsInMap(npc.m, BL_MOB)
			local npcblocks = npc:getObjectsInMap(npc.m, BL_NPC)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID
			local sub_menu
			local color_name
			local look_num
			local look_name

			--if player.id ~= 7 then
			--player:popUp(player.name..", I am on my lunch break. I will be available again sometime soon.")
			--return
			--end

			if player.registry["Gambling_plays"] == 0 then
				win_pct = 0
			else
				win_pct = (player.registry["Gambling_wins"] / player.registry["Gambling_plays"]) * 100
			end

			local items = {6956, 6957, 6958, 6959, 6960, 6961, 6962, 6963, 6964, 6965}

			local options = {"Buy Chips", "Sell Chips", "Info", "Odds", "Wins/Losses"}

			local racers = {}
			--if player.registry["Gambling_VIP"] == 0 then return end

			if player.gmLevel > 0 then
				table.insert(options, "Generate Mob")
				table.insert(options, "Start race")
				table.insert(options, "RESET")
			end

			if player.registry["race_bet"] == 0 or player.gmLevel > 0 then
				table.insert(options, "Place Bet")
			end

			menu =
				player:menuString(name .. "Good day to you, VIP " .. player.name .. "! \n\nWhat would you like to do?", options)

			if menu == "Generate Mob" then
				race_better.generateMob(npc)
			elseif menu == "RESET" then
				race_better.resetGame(npc)
			elseif menu == "Buy Chips" then
				player:buyExtend(name .. "What chips would you like to buy?", items)
			elseif (menu == "Sell Chips") then
				player:sellExtend(name .. "What chips would you like to buy?", items)
			elseif (menu == "Odds") then
				player:popUp(
					"=====Odds of Winning=====\n1:Total Racers\n\n3 Racers: Bet Chip * 2\n4 Racers: Bet Chip * 3\n5 Racers: Bet Chip * 4"
				)
			elseif (menu == "Info") then
				player:popUp(
					"======Game Information=====\n\nDuring bet window, player places bet with NPC on a selected lane. Player may choose up to a maximum of (4) four chips of a denomination (mixing and matching not currently supported.)\n\nAt end of race, players with winning lane bet will receive their payout in accordance with Odds."
				)
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
			elseif (menu == "Start race") then
				core.gameRegistry["race_timer"] = 39
			elseif (menu == "Place Bet") then
				race_better.placeBet(player)
			end
		end
	),
	placeBet = function(player)
		if player.registry["race_bet"] == 1 and player.gmLevel == 0 then
			player:popUp("Sorry " .. player.name .. ", you have already placed your bet.")
			return
		end

		if core.gameRegistry["bets_closed"] == 1 and player.gmLevel == 0 then
			player:popUp("Sorry " .. player.name .. ", you have missed the opportunity to bet. Please wait until the next race.")
			return
		end

		local lane_num
		local lane
		local racer
		local racers = {}
		local items = {6956, 6957, 6958, 6959, 6960, 6961, 6962, 6963, 6964, 6965}

		for i = 1, core.gameRegistry["number_racers"] do
			color_name = race_better.colorMap(core.gameRegistry["lane" .. i .. "color"])
			look_num = core.gameRegistry["lane" .. i .. "look"]
			table.insert(racers, "Lane " .. i .. " Color: " .. color_name .. " " .. race_better.getLookName(look_num))
		end

		racer = player:menuString("Please choose a racer", racers)

		if racer ~= nil then
			lane = string.sub(racer, 1, 7)
			lane_num = tonumber(string.sub(racer, 6, 7))
			--npc:talk(0, "You have selected "..racer)
			tradeTable = race_better.trade(player, "Please choose a chip", items)
		end

		if tradeTable ~= nil then
			player.registry["race_bet"] = 1
			player.registry["lane_num"] = lane_num
			player.registry["race_bet_amount"] = tradeTable[3]
			player.registry["race_bet_itemid"] = tradeTable[1]

			player:msg(0, "Bet confirmed: " .. tradeTable[3] .. " " .. tradeTable[2] .. " on " .. lane, player.ID)
		end
	end,
	action = function(npc) --action based off timer
		local players = npc:getObjectsInSameMap(BL_PC)

		if #players == 0 then
			return
		end

		local betTime = 30
		local raceTime = 40

		local restartTime = raceTime + 40 -- failsafe incase game doenst auto reset

		core.gameRegistry["race_timer"] = core.gameRegistry["race_timer"] + 1

		if core.gameRegistry["race_timer"] == 1 then
			race_better.generateMob(npc)
		elseif core.gameRegistry["race_timer"] >= restartTime then
			race_better.resetGame(npc)
		end

		if core.gameRegistry["number_racers"] > 0 then
			if core.gameRegistry["race_timer"] < betTime then
				npc:talk(
					2,
					"Breggart: Please place your bets. Bets closing in: " .. (betTime - core.gameRegistry["race_timer"]) .. " seconds"
				)
			elseif core.gameRegistry["race_timer"] == betTime then
				core.gameRegistry["bets_closed"] = 1
			elseif core.gameRegistry["race_timer"] > betTime and core.gameRegistry["race_timer"] <= raceTime then
				npc:talk(
					2,
					"Breggart: Bets have been placed. The race will begin in: " ..
						(raceTime - core.gameRegistry["race_timer"]) .. " seconds!"
				)
			elseif core.gameRegistry["race_timer"] == raceTime + 1 then
				race_better.startRace(npc)
			elseif core.gameRegistry["race_finished"] == 1 and core.gameRegistry["race_timer"] < restartTime then
				npc:talk(
					2,
					"Race intermission. Next round of betting in " .. (restartTime - core.gameRegistry["race_timer"]) .. " seconds."
				)
			elseif core.gameRegistry["race_timer"] >= restartTime then
				race_better.resetGame(npc)
			end
		end
	end,
	startRace = function(npc)
		npc:talk(2, "~*BANG*~ and THEY'RE OFF!")
		core.gameRegistry["race_started"] = 1 -- Begin mob movement
	end,
	announceRaceWinners = function(npc)
		local players = npc:getObjectsInSameMap(BL_PC)
		local winningLaneNum = core.gameRegistry["winning_lane"]
		local winningColorNum = core.gameRegistry["lane" .. winningLaneNum .. "color"]
		local winningLookNum = core.gameRegistry["lane" .. winningLaneNum .. "look"]
		local won_itemId
		local won_itemAmount
		local winners = {}

		local winningColorName = race_better.colorMap(winningColorNum)
		local winningLookName = race_better.getLookName(winningLookNum)

		broadcast(
			npc.m,
			"Breggart: The Winning Racer was Lane " .. winningLaneNum .. ": " .. winningColorName .. " " .. winningLookName
		)

		for i = 1, #players do
			if players[i].registry["race_bet"] == 1 then
				if players[i].registry["lane_num"] == winningLaneNum then
					table.insert(winners, players[i].name)
					players[i]:sendAnimation(2)
					players[i]:playSound(123)
					players[i]:popUp(
						"Congratulations " ..
							players[i].name ..
								", your selected mob has won the race!\n\nYou have been rewarded (" ..
									(players[i].registry["race_bet_amount"] * core.gameRegistry["race_bet_multiplier"]) ..
										") " .. Item(players[i].registry["race_bet_itemid"]).name .. " chips."
					)
					players[i]:addItem(
						players[i].registry["race_bet_itemid"],
						(players[i].registry["race_bet_amount"] * core.gameRegistry["race_bet_multiplier"])
					)
					players[i].registry["Gambling_wins"] = players[i].registry["Gambling_wins"] + 1
				end

				players[i].registry["Gambling_plays"] = players[i].registry["Gambling_plays"] + 1
				players[i].registry["Gambling_losses"] =
					players[i].registry["Gambling_plays"] - players[i].registry["Gambling_wins"]
				gambling_titles.grantTitle(players[i])
				players[i].registry["race_bet"] = 0
				players[i].registry["race_bet_itemid"] = 0
				players[i].registry["race_bet_amount"] = 0
			end
		end

		if #winners == 0 then
			broadcast(npc.m, "Breggart: There were no winning bets.")
		elseif #winners > 0 then
			local winners_string = table.concat(winners, " ")
			broadcast(npc.m, "Breggart: Winning bets: " .. winners_string)
		end
	end,
	resetGame = function(npc)
		local mobs = npc:getObjectsInSameMap(BL_MOB)
		local npcblocks = npc:getObjectsInSameMap(BL_NPC)
		local players = npc:getObjectsInSameMap(BL_PC)

		if #mobs > 0 then
			for i = 1, #mobs do
				mobs[i]:delete()
			end
		end
		if #npcblocks > 0 then
			for i = 1, #npcblocks do
				if npcblocks[i].yname == "finish_line" then
					npcblocks[i]:delete()
				end
			end
		end

		for i = 1, #players do
			players[i].registry["race_bet"] = 0
			players[i].registry["race_bet_itemid"] = 0
			players[i].registry["race_bet_amount"] = 0
		end

		core.gameRegistry["winning_lane"] = 0
		core.gameRegistry["race_started"] = 0
		core.gameRegistry["race_bet_multiplier"] = 0
		core.gameRegistry["bets_closed"] = 0
		core.gameRegistry["number_racers"] = 0
		core.gameRegistry["racers_finished"] = 0
		core.gameRegistry["race_finished"] = 0
		core.gameRegistry["race_timer"] = 0
	end,
	calcPayout = function(npc)
		if core.gameRegistry["number_racers"] == 3 then
			core.gameRegistry["race_bet_multiplier"] = 2
		elseif core.gameRegistry["number_racers"] == 4 then
			core.gameRegistry["race_bet_multiplier"] = 3
		elseif core.gameRegistry["number_racers"] == 5 then
			core.gameRegistry["race_bet_multiplier"] = 4
		end

		npc:talk(0, "Breggart: Payout = initial bet * " .. core.gameRegistry["race_bet_multiplier"])
	end,
	generateMob = function(npc)
		local racers = math.random(3, 5)
		local racer_looks = {17, 18, 125, 28, 98, 27} -- 27 ox 28 rooster 17 horse 21 rabbit 98 mantis
		local mob
		local pc
		local random_racer_look = 0
		local chosen_racer_look = 0
		local yvalues = {8, 9, 10, 11, 12}
		local colors = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
		local randomColor = 0
		local chosenColor = 0

		for i = 1, racers do
			random_racer_look = math.random(1, 6)
			chosen_racer_look = racer_looks[random_racer_look]
			randomColor = math.random(1, 11)

			chosenColor = colors[randomColor]
			table.remove(colors, randomColor)

			core.gameRegistry["lane" .. i .. "color"] = chosenColor
			core.gameRegistry["lane" .. i .. "look"] = chosen_racer_look
			--npc:talk(0, "Racer "..i.." Look: "..chosen_racer_look.." Color: "..core.gameRegistry["lane"..i.."color"])
		end

		npc:talk(0, "Breggart: " .. racers .. " Racers have approached the starting line.")
		core.gameRegistry["number_racers"] = racers
		race_better.calcPayout(npc)

		for i = 1, core.gameRegistry["number_racers"] do
			npc:spawn(200, 7, yvalues[i], 1)
			npc:addNPC("finish_line", npc.m, 22, yvalues[i], 100, 10000, npc.ID)
			--npc:talk(0,"Racer "..i.." Spawned")
		end

		pc = npc:getObjectsInMap(npc.m, BL_PC)

		if #pc > 0 then
			for i = 1, #pc do
				pc[i]:refresh()
			end
		end
	end,
	colorMap = function(color_num)
		local color_name

		if color_num == 0 then
			color_name = "Light Green"
		elseif color_num == 1 then
			color_name = "Dark Green"
		elseif color_num == 2 then
			color_name = "Sky"
		elseif color_num == 3 then
			color_name = "Tan"
		elseif color_num == 4 then
			color_name = "Red"
		elseif color_num == 5 then
			color_name = "Sun"
		elseif color_num == 6 then
			color_name = "Earth"
		elseif color_num == 7 then
			color_name = "Royal"
		elseif color_num == 8 then
			color_name = "Moon"
		elseif color_num == 9 then
			color_name = "Brown"
		elseif color_num == 10 then
			color_name = "Black"
		end

		return color_name
	end,
	getLookName = function(mobLook)
		local look_name

		if mobLook == 17 then
			look_name = "Horse"
		elseif mobLook == 18 then
			look_name = "Dog"
		elseif mobLook == 27 then
			look_name = "Ox"
		elseif mobLook == 28 then
			look_name = "Rooster"
		elseif mobLook == 98 then
			look_name = "Mantis"
		elseif mobLook == 125 then
			look_name = "Rabbit"
		end

		return look_name
	end,
	trade = function(player, dialog, items)
		local amount = 1
		local choice = player:sell(dialog, items)

		local sell = player:getInventoryItem(choice - 1)
		local sell_price = sell.price
		local sell_item = {id = sell.id, sell = sell.sell, name = sell.name, amount = sell.amount, price = sell.price}

		if (sell_item.amount > 1) then
			amount = math.abs(tonumber(math.ceil(player:input("How many chips would you like to bet?"))))

			if (amount > 4000000000 or player:hasItem(sell_item.id, amount) ~= true) then
				player:sendMinitext("You can't do that.")
				return
			end
		else
			amount = 1
		end

		if amount > 4 then
			player:popUp("Sorry " .. player.name .. " the max number of chips you may bet at a time is (4)")
			return
		end

		local choice =
			player:menuString("Are you sure you would like to bet " .. amount .. " " .. sell_item.name .. "?", {"Yes", "No"})
		if (choice == "Yes") then
			if core.gameRegistry["bets_closed"] == 1 then
				player:popUp("Nice attempt trying to cheat :)")
				return
			end
			if player:hasItem(sell_item.id, amount) == true then
				player.registry["Gambling_spent"] = player.registry["Gambling_spent"] + (sell_price * amount)

				if player:removeItem(sell_item.id, amount) == true then
					local tradetable = {sell_item.id, sell_item.name, amount}
					player:sendStatus()
					return tradetable
				else
					player:popUp("Where did it go?")
				end
			else
				player:popUp("Where did it go?")
			end
		end
	end
}

finish_line = {
	on_spawn = function(npc)
	end,
	action = function(npc)
		local m, x, y = npc.m, npc.x, npc.y
		local mob = npc:getObjectsInCell(npc.m, npc.x, npc.y, BL_MOB)

		if #mob > 0 and npc.registry["finished"] == 0 then
			--mob[1]:talk(0,"MOB REACHED FINISH LINE")
			core.gameRegistry["racers_finished"] = core.gameRegistry["racers_finished"] + 1 -- this registry value used to tell game when all racers cross finish line

			if core.gameRegistry["racers_finished"] == core.gameRegistry["number_racers"] then
				broadcast(npc.m, "Breggart: The race has finished!")
				core.gameRegistry["race_finished"] = 1
				race_better.announceRaceWinners(npc)
			end

			if core.gameRegistry["winning_lane"] == 0 then
				core.gameRegistry["winning_lane"] = mob[1].y - 7
				broadcast(npc.m, "Breggart: a Racer has crossed the finish line!")
			end

			npc.registry["finished"] = 1
		end
	end,
	endAction = function(npc)
		--npc:delete()
	end
}

racer = {
	move = function(mob)
		local randomMove = math.random(1, 10000)

		if core.gameRegistry["race_started"] == 1 then
			if randomMove <= 700 then
				mob:move()
			end
		end
	end,
	on_spawn = function(mob)
		local i = mob.y - 7

		mob.look = core.gameRegistry["lane" .. i .. "look"]
		mob.lookColor = core.gameRegistry["lane" .. i .. "color"]
		mob.side = 1
		mob:sendSide()
	end
}
