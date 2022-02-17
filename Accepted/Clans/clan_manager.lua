clan_manager = {
	click = async(
		function(player, npc)
			local t = {graphic = convertGraphic(552, "monster"), color = 0}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			local promotionopts = {}
			local clanfeatures = {}

			local opts = {}
			local clannumber = player.clan

			table.insert(promotionopts, "Level 1 - No Special Priviledges")
			table.insert(promotionopts, "Level 2 - Withdraw Item")
			table.insert(promotionopts, "Level 3 - Withdraw Money")
			table.insert(promotionopts, "Level 4 - Clan Administration")

			if player.clan == 0 then
				player:dialogSeq({t, "You have no business here."})
				return
			end

			local rank = getClanRank(player.name)

			if (rank >= 1) then
				table.insert(opts, "Leave this clan")
				table.insert(opts, "Add item to clan bank")
				table.insert(opts, "Add money to clan bank")
			end
			if (rank >= 2) then
				table.insert(opts, "Withdraw item from clan bank")
			end
			if (rank >= 3) then
				table.insert(opts, "Withdraw money from clan bank")
			end
			if (rank >= 4) then -- Council
				table.insert(opts, "[Clan Administration]")

				if math.abs(os.date("%j") - core.gameRegistry["clan" .. clannumber .. "primo_active"]) > 7 then
					table.insert(opts, "Mutiny")
				end
			end
			if (rank >= 5) then --Primogen
				table.insert(opts, "Step down")
			end

			local menuOption = player:menuString("How may I help you?", opts)

			if (menuOption == "Leave this clan") then
				if (rank >= 5) then
					player:dialogSeq({t, "As the clan's Primogen, you must step down before you may leave the clan."})
					return
				end
				player:dialogSeq(
					{t, "This tool allows you to leave this clan. Only proceed if you are certain of your decision."},
					1
				)
				local choice = player:menuString2("Are you certain you wish to leave the clan?", {"Yes", "No"})
				if (choice == "Yes") then
					player.clan = 0
					player.clanTitle = ""
					removeOfflineClanMember(player.name) -- just updates the sql stuff faster
					player:sendMinitext("Farewell, then.")
				else
					player:dialogSeq({"Good choice."})
				end
			elseif (menuOption == "View clan bank") then
				player:clanViewBank("List of items :")
			elseif (menuOption == "Add item to clan bank") then
				---- Cool counter shit to give a true count of clan items currently deposited.-------------
				local counter = 0
				local clanitems = player:getClanItems()
				for i = 1, #clanitems do
					if (clanitems[i] == 0) then
						counter = #clanitems
						for j = i, counter do
							table.remove(clanitems, i)
						end
						break
					end
				end
				--------------------------------------------------------------------------------------------
				player:msg(
					0,
					"Your clan is using " .. #clanitems .. " out of " .. getClanBankSlots(clannumber) .. " maximum bank slots.",
					player.ID
				)

				if #clanitems >= getClanBankSlots(clannumber) then
					player:dialogSeq(
						{
							t,
							"Clan bank is full. Unable to deposit more items to the clan bank unless some items are withdrawn first or more slots bought."
						}
					)
					return
				end

				player:showClanBankAdd()
			elseif (menuOption == "Add money to clan bank") then
				player:clanBankAddMoney(clannumber)
			elseif (menuOption == "Withdraw item from clan bank") then
				player:showClanBank("List of items: ")
			elseif (menuOption == "Withdraw money from clan bank") then
				player:clanBankWithdrawMoney(clannumber)
			elseif (menuOption == "[Clan Administration]") then
				local choice =
					player:menuString2(
					"Which feature are you interested in?",
					{
						"View Clan Roster",
						"Add Member",
						"Change Member's Rank",
						"Remove Member",
						"Grant Clan Title",
						"",
						"",
						"Clan Bank Slots",
						"Clan Level Upgrade"
					}
				)

				local members = getClanRoster(clannumber)
				local members2 = {}
				for i = 1, #members do
					table.insert(members2, members[i])
					members2[i] = table.concat({members[i], "            ", "Rank: " .. getClanRank(members[i])})
				end

				if (choice == "View Clan Roster") then
					player:menuString("------- CLAN ROSTER --------", members2)
				elseif (choice == "Add Member") then
					player:dialogSeq(
						{
							t,
							"This tool allows you to add a member to your clan. The selected player must not be currently part of any clan."
						},
						1
					)
					name = player:input("Whom do you wish to add to the clan?")

					if (name ~= player.name) then
						if (Player(name).clan == 0) then
							Player(name).registry["rankinviter"] = player.ID
							Player(name).registry["claninvitenumber"] = clannumber
							clan_manager.addmember(Player(name), npc, player.clanName)
						elseif (Player(name).clan == clannumber) then
							player:dialogSeq({t, "" .. name .. " is already part of your clan!"})
						else
							player:dialogSeq({t, "" .. name .. " is already part of another clan!"})
						end
					else
						player:dialogSeq({"You can not invite yourself!"})
					end
				elseif (choice == "Remove Member") then
					player:dialogSeq(
						{t, "This tool allows you to terminate a member. Only proceed if you are certain of your decision."},
						1
					)

					local removeMember_num = player:menu("------- REMOVE CLAN MEMBER --------", members2)
					local removeMember = members[removeMember_num]

					if player.name == removeMember then
						player:dialogSeq({t, "You may not terminate yourself this way."})
						return
					end

					if getClanRank(removeMember) >= getClanRank(player.name) then
						player:dialogSeq({t, "You may not terminate an equal or higher ranking officer."})
						return
					end

					removeOfflineClanMember(removeMember)
					setPlayerClan(removeMember, 0)
					setClanTitle(removeMember, "")
					player:sendMinitext(removeMember .. " has been removed from the Clan.")

					if Player(removeMember) ~= nil then
						Player(removeMember).clanTitle = ""
						Player(removeMember).clan = 0
						Player(removeMember):updateState()
						Player(removeMember):dialogSeq({t, "You have been expelled from the clan."})
					end
				elseif (choice == "Grant Clan Title") then
					player:dialogSeq(
						{
							t,
							"This tool allows you to Grant a Clan Title to one of your members. The maximal length allowed is 18 characters. Click next to proceed."
						},
						1
					)

					local removeMember_num = player:menu("Who shall you grant a title to?", members2)
					local name = members[removeMember_num]

					local title = player:input("What shall be the new title?")

					if (string.len(title) > 18) then
						player:dialogSeq({t, "This title is too long."})
						return
					end
					--if(string.find(string.lower(title),"'")) then
					--player:dialogSeq({t,"You may not use ' in your titles."})
					--return
					--end

					setClanTitle(name, title)

					if Player(name) ~= nil then
						Player(name).clanTitle = title
						Player(name):updateState()
						Player(name):dialogSeq({t, "You have been granted the clan title " .. title .. " by " .. player.name .. "."})
					end
				elseif (choice == "Change Member's Rank") then
					player:dialogSeq(
						{t, "This tool allows you to set/change the level of a member who has a lower rank than you within your clan."},
						1
					)

					local removeMember_num = player:menu("Who needs their rank adjusted?", members2)
					local name = members[removeMember_num]

					if (name == player.name) then
						player:dialogSeq({t, "You may not adjust your own rank level."}, 1)
						return
					end

					if getClanRank(name) >= getClanRank(player.name) then
						player:dialogSeq({t, "You may not alter the rank of an equal or higher ranking officer."}, 1)
						return
					end

					local choice2 =
						player:menuString2(
						"Which level shall " ..
							name .. " be? ((All levels inherits the previous level powers. Only the new powers are indicated))",
						promotionopts
					)

					if (choice2 == "Level 1 - No Special Priviledges") then
						setClanRank(name, 1)
						player:sendMinitext(name .. " is now a level 1 rank.")
						if Player(name) ~= nil then
							Player(name):dialogSeq({t, "CLAN RANK UPDATE\n\nYou are now a level 1 rank"})
						end
					elseif (choice2 == "Level 2 - Withdraw Item") then
						setClanRank(name, 2)
						player:sendMinitext(name .. " is now a level 2 rank.")
						if Player(name) ~= nil then
							Player(name):dialogSeq({t, "CLAN RANK UPDATE\n\nYou are now a level 2 rank"})
						end
					elseif (choice2 == "Level 3 - Withdraw Money") then
						setClanRank(name, 3)
						player:sendMinitext(name .. " is now a level 3 rank.")
						if Player(name) ~= nil then
							Player(name):dialogSeq({t, "CLAN RANK UPDATE\n\nYou are now a level 3 rank"})
						end
					elseif (choice2 == "Level 4 - Clan Administration") then
						setClanRank(name, 4)
						player:sendMinitext(name .. " is now a level 4 rank.")
						if Player(name) ~= nil then
							Player(name):dialogSeq({t, "CLAN RANK UPDATE\n\nYou are now a level 4 rank"})
						end
					end
				elseif (choice == "Clan Bank Slots") then
					local bankSlots = getClanBankSlots(clannumber)
					local clanTribute = getClanTribute(clannumber)

					player:dialogSeq(
						{
							t,
							"Your clan is currently equipped with " ..
								bankSlots ..
									" bank slots. Each additional slot costs 2,000 tribute and you may purchase up to a maximum of 500 slots."
						},
						1
					)
					local clanbankslots =
						player:menuString2("Would you like to purchase one clan bank slot for 2,000 Tribute?", {"Yes", "No"})
					if (clanbankslots == "Yes") then
						if (clanTribute >= 2000) then
							setClanBankSlots(clannumber, bankSlots + 1)
							setClanTribute(clannumber, clanTribute - 2000)
							player:dialogSeq(
								{t, "Your clan is now equipped with a total of " .. getClanBankSlots(clannumber) .. " bank slots."}
							)
						else
							player:dialogSeq({t, "Your clan does not have enough tribute."})
						end
					end
				elseif (choice == "Clan Level Upgrade") then
					local clanLevel = getClanLevel(clannumber)
					local clanTribute = getClanTribute(clannumber)

					if clanLevel >= 5 then
						player:dialogSeq({t, "No further upgrade possible. Your clan is already at maximum level."}, 1)
						return
					end

					local tributeRequired = {0, 5000, 12000, 25000, 50000}

					player:dialogSeq(
						{
							t,
							"Your clan is Level: " ..
								clanLevel ..
									"\n\nEach of the following levels requires Tribute to advance:\n\nLevel 2: 5000 Tribute\nLevel 3: 12000 Tribute\nLevel 4: 25000 Tribute\nLevel 5: 50000 Tribute"
						},
						1
					)

					local clanupgrade =
						player:menuString2(
						"Current Tribute Balance: " ..
							getClanTribute(clannumber) .. "\n\nWould you like to upgrade your clan to level " .. (clanLevel + 1) .. "?",
						{"Yes", "No"}
					)
					if (clanupgrade == "Yes") then
						if (clanTribute >= tributeRequired[clanLevel + 1]) then
							setClanLevel(clannumber, clanLevel + 1)
							setClanTribute(clannumber, clanTribute - tributeRequired[clanLevel + 1])
							broadcast(
								-1,
								"Congratulations to " .. player.clanName .. " for reaching level: " .. getClanLevel(clannumber) .. "!"
							)
							player:dialogSeq({t, "Congratulations!\n\nYour clan is now Level: " .. getClanLevel(clannumber)}, 1)
							player:dialogSeq({t, "Your Tribute balance is now: " .. getClanTribute(clannumber)}, 1)
						else
							player:dialogSeq({t, "Your clan does not have enough tribute."})
						end
					end
				end
			elseif (menuOption == "Step down") then
				player:dialogSeq(
					{
						t,
						"Primogen, this tool allows you to step down from your position. Only proceed if you are -ABSOLUTELY- certain of your decision."
					},
					1
				)

				local nuisance = {}
				local w = 0
				local nameofPlayer = player:input("Who shall become the new Primogen?")
				if (nameofPlayer ~= player.name) then
					for x = -20, 20 do
						for y = -20, 20 do
							nuisance = player:getObjectsInCell(player.m, player.x + x, player.y + y, BL_PC)
							if (#nuisance > 0) then
								for z = 1, #nuisance do
									if (nuisance[z].name == nameofPlayer and nuisance[z].clan == clannumber) then
										Player(nameofPlayer):sendMinitext("" .. player.name .. " has made you the new Primogen. Congratulations.")
										player:sendMinitext(nameofPlayer .. " is now the new Primogen")
										Player(nameofPlayer):addLegend(
											"Primogen of " .. player.clanName .. " since Year " .. (curYear()) .. ", " .. (getCurSeason()),
											"primogen",
											7,
											128
										)

										player:removeLegendbyName("primogen")
										player:addLegend(
											"Served as Primogen of " .. player.clanName .. " Until Year " .. (curYear()) .. ", " .. (getCurSeason()),
											"primogen_served",
											7,
											128
										)

										setClanRank(nameofPlayer, 5)
										setClanRank(player.name, 1)
										w = 1
									end
								end
							end
						end
					end
				else
					player:dialogSeq({t, "You can not do that."})
				end
				if (w == 0) then
					player:dialogSeq({t, "" .. nameofPlayer .. " isn't around or isn't a part of your clan!"})
				end
			end
		end
	),
	addmember = async(
		function(player, npc, clanName)
			local t = {graphic = convertGraphic(0, "monster"), color = 0}
			local opts = {}
			local check = {}
			table.insert(opts, "Yes")
			table.insert(opts, "No")
			player.npcGraphic = t.graphic
			player.npcColor = t.color

			local choice =
				player:menuString2(
				"" ..
					Player(player.registry["rankinviter"]).name .. " Wishes to make you a member of " .. clanName .. ", do you accept?",
				opts
			)
			if (choice == "No") then
				Player(player.registry["rankinviter"]):dialogSeq({"" .. player.name " has refused your offer."})
			elseif (choice == "Yes") then
				player.clan = player.registry["claninvitenumber"]
				setPlayerClan(player.name, player.registry["claninvitenumber"])
				setClanRank(player.name, 1)
				player:updateState()
				Player(player.registry["rankinviter"]):sendMinitext(
					"" .. player.name .. " has accepted your offer and is now a rank of this clan."
				)
				player:sendMinitext("You are now a regular member of " .. clanName)
			end
		end
	),
	createClan = function(player, npc)
		local t = {graphic = convertGraphic(552, "monster"), color = 0}

		player:dialogSeq(
			{
				"Clans are a big deal in the Land of Morna and as such, clan names are subject to GM approval.\n\nThe fee to even be considered for a clan is 5 million gold and you must have at least four (4) members including yourself to start.\n\nPlease consult with a GM for further assistance."
			}
		)
	end
}
