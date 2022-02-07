script_tester_2 = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID
			local bountyName
			local numberKills = 0
			local map = npc.mapTitle

			local opts = {}
			local bounty = 0
			if player.quest["dailyq_path_supply"] == 0 then
				table.insert(opts, "Start Daily Supply Run")
			end
			if player.quest["dailyq_path_supply"] >= 1 then
				table.insert(opts, "Finished Daily Supply Run")
			end
			if player.quest["dailyq_path_supply"] >= 1 then
				table.insert(opts, "Abandon Daily Supply Run")
			end
			table.insert(opts, "Nothing")

			if map == "Fighter's Hall" then
				if player.baseClass ~= 1 then
					player:dialogSeq({t, name .. "I cannot help you. Please look elsewhere."}, 1)
					return
				end
			elseif map == "Scoundrel's Guild" then
				if player.baseClass ~= 2 then
					player:dialogSeq({t, name .. "I cannot help you. Please look elsewhere."}, 1)
					return
				end
			elseif map == "Seagrove Library" then
				if player.baseClass ~= 3 then
					player:dialogSeq({t, name .. "I cannot help you. Please look elsewhere."}, 1)
					return
				end
			elseif map == "House of ASAK" then
				if player.baseClass ~= 4 then
					player:dialogSeq({t, name .. "I cannot help you. Please look elsewhere."}, 1)
					return
				end
			end

			if player.registry["dailyq_path_supply_timer"] > os.time() then
				player:dialogSeq(
					{
						t,
						name ..
							"You have already done a supply run today. Come back later.\n\nAvailable again in: " ..
								math.ceil(((player.registry["dailyq_path_supply_timer"] - os.time()) / 3600)) .. " hours"
					},
					1
				)
			else
				menu =
					player:menuString(name .. "Are you here for a supply run? We have many tasks for enterprising recruits.", opts)
			end

			if player.registry["dailyq_path_supply_timer"] < os.time() then
				if menu == "Start Daily Supply Run" then
					player:dialogSeq(
						{
							t,
							name .. "Want to prove yourself? Then shut up and do what I say.",
							name .. "Today's supply run is..."
						},
						1
					)
					randomItem = script_tester_2.getItem(player, npc)
					targetItem = randomItem
					numberItem = math.random(25, 75)

					if targetItem == 3011 or targetItem == 3007 or targetItem == 3015 then
						numberItem = math.random(5, 10)
					end

					player.quest["dailyq_path_supply"] = targetItem
					player.quest["dailyq_path_supply_count"] = numberItem
					player:dialogSeq(
						{
							t,
							name .. "You must gather " .. numberItem .. " " .. Item(targetItem).name .. ".",
							name .. "Return here when you are done."
						},
						1
					)
					player:addLegend("On a run to gather " .. numberItem .. " " .. Item(targetItem).name, "dailyq_path_supply", 1, 16)
				elseif menu == "Abandon Daily Supply Run" then
					abandon = player:menuString(name .. "Would you like to abandon your current supply run?", {"Yes", "No"})
					if abandon == "Yes" then
						player.quest["dailyq_path_supply"] = 0
						player.registry["dailyq_path_supply_timer"] = os.time() + 43200
						if player:hasLegend("dailyq_path_supply") then
							player:removeLegendbyName("dailyq_path_supply")
						end
						player:popUp("Supply Run Abandoned!")
					end
				elseif menu == "Finished Daily Supply Run" then
					bounty = player.quest["dailyq_path_supply"]
					if player.quest["dailyq_path_supply"] > 0 then
						if player:hasItem(targetItem, numberItem) == true then
							if player:removeItem(targetItem, numberItem) == true then
								script_tester_2.complete(player)
								player:dialogSeq({t, name .. "Great Job!"}, 1)
							else
								player:dialogSeq({t, name .. "What are you waiting for? Go out there and gather some supplies!"}, 1)
							end
						else
							player:dialogSeq({t, name .. "What are you waiting for? Go out there and gather some supplies!"}, 1)
						end
					else
						player:dialogSeq({t, name .. "You haven't finished the run yet! You're not chicken, are you?"}, 1)
					end
				end
			end
		end
	),
	complete = function(player)
		local targetItem = player.quest["dailyq_path_supply"]
		local numberItem = player.quest["dailyq_path_supply_count"]

		local rewardEXP = 0
		local rewardGold = 0

		rewardGold = ((player.level * 50) + (Item(targetItem).sell * numberItem))

		if player.level <= 98 then
			rewardEXP = player:getTotalTNL(player) * .2
		elseif player.level >= 99 then
			rewardEXP = 25000000
		end

		player:giveXP(rewardEXP)
		player:addGold(rewardGold)
		player:calcStat()
		player:sendStatus()
		finishedQuest(player)
		player:msg(4, "[Daily Supply Run Complete]", player.ID)
		player.quest["dailyq_path_supply"] = 0
		player.quest["dailyq_path_supply_count"] = 0
		player.registry["dailyq_path_supply_timer"] = os.time() + 43200

		if player:hasLegend("dailyq_path_supply_total") then
			player:removeLegendbyName("dailyq_path_supply_total")
		end

		if player:hasLegend("dailyq_path_supply") then
			player:removeLegendbyName("dailyq_path_supply")
		end

		if player.registry["dailyq_path_supply_complete"] > 0 then
			player.registry["dailyq_path_supply_complete"] = player.registry["dailyq_path_supply_complete"] + 1
			player:addLegend(
				"Completed " .. player.registry["dailyq_path_supply_complete"] .. " Guild Supply Runs",
				"dailyq_path_supply_total",
				1,
				16
			)
		else
			player.registry["dailyq_path_supply_complete"] = 1
			player:addLegend("Completed 1 Guild Supply Run", "dailyq_path_supply_total", 1, 16)
		end
		if player.registry["dailyq_path_supply_complete"] == 10 then
			broadcast(-1, "[TITLE]: " .. player.name .. " has just earned the title 'Gatherer'!")
		end
		if player.registry["dailyq_path_supply_complete"] == 100 then
			broadcast(-1, "[TITLE]: " .. player.name .. " has just earned the title 'Runner'!")
		end
	end,
	getItem = function(player, npc)
		local questItem = {}
		local targetName = ""

		if player.level >= 5 then
			table.insert(questItem, 3007) --improvised spear
			table.insert(questItem, 3010) --honey
			table.insert(questItem, 3011) --candle
		end

		if player.level >= 10 then
			table.insert(questItem, 53) --snake meat
			table.insert(questItem, 3015) --drunk mug
		end

		if player.level >= 15 then
			table.insert(questItem, 3016) --black fox fur
			table.insert(questItem, 3017) --red fox fur
			table.insert(questItem, 3018) --light fox fur
			table.insert(questItem, 3019) --rainbow fox fur
		end

		if player.level >= 20 then
		end

		if player.level >= 25 then
		--table.insert(questItem, )
		end

		if player.level >= 30 then
			table.insert(questItem, 291) --minnow scales
			table.insert(questItem, 292) --bass scales
		end

		if player.level >= 35 then
			table.insert(questItem, 6031) --lima bean
			table.insert(questItem, 6033) --egg
		end

		if player.level >= 40 then
		end

		if player.level >= 45 then
		--table.insert(questItem, )
		end

		if player.level >= 50 then
			table.insert(questItem, 294) --stolen sword
		end

		if player.level >= 55 then
		--table.insert(questItem, )
		end

		if player.level >= 60 then
			table.insert(questItem, 297) --spider silk
		end

		if player.level >= 65 then
		--table.insert(questItem, )
		end

		if player.level >= 70 then
			table.insert(questItem, 3033) --brown wolf fur
			table.insert(questItem, 3032) --red wolf fur
			table.insert(questItem, 3031) --black wolf fur
		end

		if player.level >= 75 then
		--table.insert(questItem, )
		end

		if player.level >= 80 then
			table.insert(questItem, 392) --lobster claw
			table.insert(questItem, 393) --jellyfish tentacle
			table.insert(questItem, 407) --frog legs
			table.insert(questItem, 423) --swamp gator scale
		end

		if player.level >= 85 then
		end

		if player.level >= 90 then
			table.insert(questItem, 424) --blackstrike gator scale
		end

		if player.level >= 95 then
			table.insert(questItem, 3022) --sticky slime
		end

		if player.level >= 99 then
			table.insert(questItem, 416) --ogre ear
		end

		if #questItem > 0 then
			r = math.random(1, #questItem)
			finalQuestItem = questItem[r]
		end

		return finalQuestItem
	end
}
