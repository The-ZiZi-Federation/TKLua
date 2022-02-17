kingpin = {
	click = function(player, npc)
		player:freeAsync()
		player.lastClick = player.ID
		kingpin.showmenu(player, npc)
	end,
	showmenu = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"

			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID
			local players = npc:getObjectsInSameMap(BL_PC)

			local lender = ""
			local lendee = ""
			local sgold = ""
			local gold
			local sgold_w_interest = ""
			local gold_w_interest

			--if player.id == 7 or player.id == 348 then
			--else player:popUp(name.."I'm almost done puffing my cig. Let me chill.")
			--return
			--end

			local options = {"Loan a player some gold"}

			if player:hasDuration("choice") and player.id == npc.registry["lendee_id"] then
				table.insert(options, "Accept")
				table.insert(options, "Refuse")
			end

			if player.registry["owe_loans"] > 0 then
				table.insert(options, "Pay off a loan")
			end

			table.insert(options, "Loan Information")

			if player.gmLevel > 0 then
				table.insert(options, "Registries")
				table.insert(options, "Reset registries")
			end

			menu = player:menuString(name .. "Good day to you, " .. player.name .. "!\n\nWhat would you like to do?", options)

			if menu == "Loan a player some gold" then
				if npc.registry["lendee_id"] ~= 0 or npc.registry["lender_id"] ~= 0 then
					player:popUp(
						"Sorry " .. player.name .. ", there is currently a loan being processed. Please wait until it is complete."
					)
					return
				end

				if player.registry["extended_loans"] >= 3 then
					player:popUp("Sorry " .. player.name .. ", you may only extend up to (3) loans at a time.")
					return
				end

				if os.time() < player.registry["loan_timer"] then
					player:popUp(player.name .. ",\n\nSorry but you have extended or received a loan within the past 12 hours.")
					return
				end

				target = player:input("Who would you like to loan gold to?")
				if target == player.name then
					player:popUp("" .. player.name .. ",\n\nYou cannot loan money to yourself.")
					return
				end

				gold = tonumber(player:input("How much gold would you like to extend to " .. target .. "?"))

				if gold > player.money then
					player:popUp("" .. player.name .. ",\n\nYou have entered more gold than you currently possess.")
					return
				end

				if gold < 0 then
					return
				end

				gold_w_interest =
					tonumber(player:input("How much gold would you like to receive back (with interest) from " .. target .. "?"))

				if gold_w_interest < 0 then
					return
				end

				for i = 1, #players do -- determine if target is on same map as NPC, if so sets variable
					if players[i].name == target then
						lendee = players[i]
					end
				end

				lender = player

				if lendee ~= nil then
					kingpin.presentOffer(npc, lender, lendee, gold, gold_w_interest)
				elseif lendee == nil then
					player:popUp(
						"" .. player.name .. ",\n\nYou have either typed the player's name wrong or they are not on the same map."
					)
					kingpin.resetNPC(npc)
				end
			elseif menu == "Accept" then
				if player.registry["owe_loans"] >= 3 then
					player:popUp("" .. player.name .. ",\n\nSorry but you are unable to receive more than (3) loans at a time.")
					return
				end

				if os.time() < player.registry["loan_timer"] then
					player:popUp(player.name .. ",\n\nSorry but you have extended or received a loan within the past 12 hours.")
					return
				end

				kingpin.acceptLoan(npc, player)
			elseif menu == "Refuse" then
				Player(npc.registry["lender_id"]):popUp(
					"" ..
						Player(npc.registry["lender_id"]).name ..
							",\n\n" .. Player(npc.registry["lendee_id"]).name .. " has refused your loan."
				)
				kingpin.resetNPC(npc)
			elseif menu == "Loan Information" then
				local extended_loans = {}
				local owed_loans = {}

				if player.registry["extended_loans"] == 0 then
					table.insert(extended_loans, "No Loans.")
				elseif player.registry["extended_loans"] > 0 then
					for i = 1, 3 do
						if player.registry["loan" .. i .. "_owed_from"] ~= 0 and player.registry["loan" .. i .. "_owed_amount"] ~= 0 then
							table.insert(
								extended_loans,
								"" ..
									Player(player.registry["loan" .. i .. "_owed_from"]).name ..
										": " .. player.registry["loan" .. i .. "_owed_amount"] .. " gold."
							)
						end
					end
				end

				extended_loans_print = table.concat(extended_loans, "\n")

				if player.registry["owe_loans"] == 0 then
					table.insert(owed_loans, "No Loans.")
				elseif player.registry["owe_loans"] > 0 then
					for i = 1, 3 do
						if player.registry["loan" .. i .. "_owe_to"] ~= 0 and player.registry["loan" .. i .. "_owe_amount"] ~= 0 then
							table.insert(
								owed_loans,
								"" ..
									Player(player.registry["loan" .. i .. "_owe_to"]).name ..
										": " .. player.registry["loan" .. i .. "_owe_amount"] .. " gold."
							)
						end
					end
				end

				owed_loans_print = table.concat(owed_loans, "\n")

				player:popUp(
					"-------- " ..
						player.registry["extended_loans"] ..
							" Loans extended: ---------\n\n" ..
								extended_loans_print ..
									"\n\n-------- " .. player.registry["owe_loans"] .. " Loans owed: -------------\n\n" .. owed_loans_print
				)
			elseif menu == "Pay off a loan" then
				kingpin.payoffLoan(npc, player)
			elseif menu == "Registries" then
				player:talk(0, "Owe Loans: " .. player.registry["owe_loans"])

				for i = 1, 3 do
					player:talk(0, "Owe to: " .. player.registry["loan" .. i .. "_owe_to"])
					player:talk(0, "Owe amount: " .. player.registry["loan" .. i .. "_owe_amount"])
				end

				player:talk(0, "Total loans given: " .. player.registry["total_loans_given"])
				player:talk(0, "Extended Loans: " .. player.registry["extended_loans"])

				for i = 1, 3 do
					player:talk(0, "extended to: " .. player.registry["loan" .. i .. "_owed_from"])
					player:talk(0, "extended amount: " .. player.registry["loan" .. i .. "_owed_amount"])
				end
			elseif menu == "Reset registries" then
				for i = 1, 3 do
					player.registry["loan_timer"] = 0
					player.registry["owe_loans"] = 0
					player.registry["loan" .. i .. "_owe_to"] = 0
					player.registry["loan" .. i .. "_owe_amount"] = 0
					player.registry["total_loans_given"] = 0
					player.registry["extended_loans"] = 0
					player.registry["loan" .. i .. "_owed_from"] = 0
					player.registry["loan" .. i .. "_owed_amount"] = 0
					player:removeLegendbyName("loan" .. i .. "_in_debt")
					player:updateState()
				end
				player:talk(0, "Registries reset")
			end
		end
	),
	presentOffer = function(npc, lender, lendee, gold, gold_w_interest)
		npc.registry["resetTime"] = os.time() + 30
		Player(lendee.id):setDuration("choice", 30000)

		npc.registry["lendee_id"] = lendee.id
		npc.registry["lender_id"] = lender.id
		npc.registry["gold"] = gold
		npc.registry["gold_w_interest"] = gold_w_interest
		local interest_rate = ((gold_w_interest / gold) - 1) * 100

		lendee:popUp(
			"" ..
				lender.name ..
					" would like to let you borrow " ..
						gold ..
							" gold.\nThe amount being asked to be repaid is: " ..
								gold_w_interest ..
									" gold.\nInterest Rate: " .. interest_rate .. "%\n\nPlease Accept or Refuse this offer on the main menu."
		)
	end,
	acceptLoan = function(npc, player)
		if Player(npc.registry["lender_id"]).money < npc.registry["gold"] then
			player:popUp(
				"Unable to proceed with loan. Lender no longer possesses enough gold.\n\nThe loan process has been reset."
			)
		elseif Player(npc.registry["lender_id"]):removeGold(npc.registry["gold"]) == true then
			Player(npc.registry["lender_id"]):calcStat()
			player:addGold(npc.registry["gold"])
			Player(npc.registry["lender_id"]):popUp("" .. Player(npc.registry["lendee_id"]).name .. " has received your gold.")
			player:popUp(
				"You have just received " .. npc.registry["gold"] .. " gold from " .. Player(npc.registry["lender_id"]).name .. "."
			)

			---- Add loan info to Lendee ----
			for i = 1, 3 do
				if player.registry["loan" .. i .. "_owe_to"] == 0 and player.registry["loan" .. i .. "_owe_amount"] == 0 then
					player.registry["loan_timer"] = os.time() + 43200000 -- 12 hour loan timer
					player.registry["loan" .. i .. "_owe_to"] = npc.registry["lender_id"]
					player.registry["loan" .. i .. "_owe_amount"] = npc.registry["gold_w_interest"]
					player:addLegend(
						"Indebted to " .. Player(npc.registry["lender_id"]).name .. " for " .. npc.registry["gold_w_interest"] .. " gold.",
						"loan" .. i .. "_in_debt",
						51,
						47
					)
					player.registry["owe_loans"] = player.registry["owe_loans"] + 1
					break
				end
			end

			---- Add loan info to Lender ----
			for i = 1, 3 do
				if
					Player(npc.registry["lender_id"]).registry["loan" .. i .. "_owed_from"] == 0 and
						Player(npc.registry["lender_id"]).registry["loan" .. i .. "_owed_amount"] == 0
				 then
					Player(npc.registry["lender_id"]).registry["loan_timer"] = os.time() + 43200000 -- 12 hour loan timer
					Player(npc.registry["lender_id"]).registry["loan" .. i .. "_owed_from"] = npc.registry["lendee_id"]
					Player(npc.registry["lender_id"]).registry["loan" .. i .. "_owed_amount"] = npc.registry["gold_w_interest"]
					Player(npc.registry["lender_id"]).registry["extended_loans"] =
						Player(npc.registry["lender_id"]).registry["extended_loans"] + 1

					break
				end
			end

			--------------LOAN SHARK--------------------
			Player(npc.registry["lender_id"]).registry["total_loans_given"] =
				Player(npc.registry["lender_id"]).registry["total_loans_given"] + 1

			if Player(npc.registry["lender_id"]).registry["total_loans_given"] == 15 then
				Player(npc.registry["lender_id"]).registry["Gambling_title_loanshark"] = 1
				broadcast(-1, "[Kingpin]: " .. Player(npc.registry["lender_id"]).name .. " has just earned the title 'Loanshark'!")
			end
		end

		kingpin.resetNPC(npc)
	end,
	payoffLoan = function(npc, player)
		local name = "<b>[" .. npc.name .. "]\n\n"
		local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		player.lastClick = npc.ID

		local loans = {}
		local loanchoice
		local confirm

		for i = 1, 3 do
			if player.registry["loan" .. i .. "_owe_to"] ~= 0 and player.registry["loan" .. i .. "_owe_amount"] ~= 0 then
				table.insert(
					loans,
					"Loan " ..
						i ..
							" from " ..
								Player(player.registry["loan" .. i .. "_owe_to"]).name ..
									" Amount: " .. player.registry["loan" .. i .. "_owe_amount"]
				)
			end
		end

		local selection = player:menuString(name .. "" .. player.name .. ",\n\nWhich loan would you like to pay off?", loans)

		loanchoice = tonumber(string.sub(selection, 5, 6))

		local lender_id = player.registry["loan" .. loanchoice .. "_owe_to"]
		local lendee_id = player.id
		local gold = player.registry["loan" .. loanchoice .. "_owe_amount"]

		if loanchoice ~= nil then
			confirm =
				player:menuString(
				name ..
					"" ..
						player.name ..
							",\n\nDo you confirm to pay this loan in the amount of " ..
								player.registry["loan" .. loanchoice .. "_owe_amount"] .. " gold?",
				{"Yes", "No"}
			)
		end

		if confirm == "Yes" then
			-- Lender Online Check --
			if Player(lender_id) == nil then
				player:popUp(
					player.name .. ",\n\nSorry but " .. Player(lender_id).name .. " must be online for you to pay off the loan."
				)
				return
			end

			if player.money < player.registry["loan" .. loanchoice .. "_owe_amount"] then
				player:popUp("Unable to payoff the loan. You do not have enough gold.")
				return
			elseif player:removeGold(player.registry["loan" .. loanchoice .. "_owe_amount"]) == true then -- Has enough gold, paid
				player:calcStat()
				Player(lender_id):addGold(gold)
				Player(lender_id):calcStat()

				--- remove Loan info from player ----
				player.registry["loan" .. loanchoice .. "_owe_to"] = 0
				player.registry["loan" .. loanchoice .. "_owe_amount"] = 0
				player.registry["owe_loans"] = player.registry["owe_loans"] - 1
				player:removeLegendbyName("loan" .. loanchoice .. "_in_debt")

				--- remove Loan info from Lender ----
				for i = 1, 3 do
					if
						Player(lender_id).registry["loan" .. i .. "_owed_from"] == player.id and
							Player(lender_id).registry["loan" .. i .. "_owed_amount"] == gold
					 then
						Player(lender_id).registry["loan" .. i .. "_owed_from"] = 0
						Player(lender_id).registry["loan" .. i .. "_owed_amount"] = 0
					end
				end
				Player(lender_id).registry["extended_loans"] = Player(lender_id).registry["extended_loans"] - 1

				player:popUp(name .. "" .. player.name .. ",\n\nThe loan is now paid off in full.")
				Player(lender_id):popUp(
					name ..
						"" ..
							Player(lender_id).name ..
								",\n\n" .. player.name .. " has just paid off their loan to you in the amount of " .. gold .. " gold."
				)
			end
		end
	end,
	resetNPC = function(npc)
		npc.registry["lendee_id"] = 0
		npc.registry["lender_id"] = 0
		npc.registry["gold"] = 0
		npc.registry["resetTime"] = 0
	end,
	action = function(npc)
		if os.time() > npc.registry["resetTime"] then -- Free up loan npc if loan is incomplete or squatters
			kingpin.resetNPC(npc)
		end
	end
}
