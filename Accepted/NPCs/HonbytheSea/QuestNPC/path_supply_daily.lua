path_supply_daily = {
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

			local targetItem = player.quest["dailyq_path_supply"]
			local numberItem = player.quest["dailyq_path_supply_count"]

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
			elseif map == "Seagrove Hidden Library" then
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
				menu = player:menuString(name .. "Lookin' for a runner. You lookin' to run today?", opts)
			end

			if player.registry["dailyq_path_supply_timer"] < os.time() then
				if menu == "Start Daily Supply Run" then
					randomItem = path_supply_daily.getItem(player, npc)
					targetItem = randomItem
					numberItem = math.random(20, 30)

					if targetItem == 3011 or targetItem == 3007 or targetItem == 3015 then
						numberItem = math.random(1, 3)
					end

					player.quest["dailyq_path_supply"] = targetItem
					player.quest["dailyq_path_supply_count"] = numberItem

					player:addLegend(
						"On a run to gather " .. numberItem .. " " .. Item(targetItem).name,
						"dailyq_path_supply",
						158,
						16
					)
					player:dialogSeq(
						{
							t,
							name .. "Good, good. We need more " .. getPathName(player) .. "s as enthusiastic as you.",
							name .. "Today's supply run is..."
						},
						1
					)
					player:dialogSeq(
						{
							t,
							name .. "You must gather " .. numberItem .. " " .. Item(targetItem).name .. ".",
							name .. "Return here when you are done."
						},
						1
					)
				elseif menu == "Abandon Daily Supply Run" then
					abandon = player:menuString(name .. "Would you like to abandon your current supply run?", {"Yes", "No"})
					if abandon == "Yes" then
						player.quest["dailyq_path_supply"] = 0
						player.registry["dailyq_path_supply_timer"] = os.time() + 86400
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
								path_supply_daily.complete(player)
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

		local rewardGold = 0

		rewardGold = ((player.level * 50) + (Item(targetItem).sell * numberItem))

		player:leveledEXP("daily")
		player:addGold(rewardGold)
		player:calcStat()
		player:sendStatus()
		finishedQuest(player)
		player:msg(4, "[Daily Supply Run Complete]", player.ID)
		player.quest["dailyq_path_supply"] = 0
		player.quest["dailyq_path_supply_count"] = 0
		player.registry["dailyq_path_supply_timer"] = os.time() + 86400

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
				158,
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
			table.insert(questItem, 3010) --honey
			table.insert(questItem, 246) --dead rat
			table.insert(questItem, 212) --little blue fish
		end

		if player.level >= 10 then
			table.insert(questItem, 53) --snake meat
		end

		if player.level >= 15 and player.level < 55 then
			table.insert(questItem, 3016) --black fox fur
			table.insert(questItem, 3017) --red fox fur
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

		if player.level >= 55 and (player.baseHealth < 15000 and player.baseMagic < 15000) then
			table.insert(questItem, 3041) --blue fox fur
			table.insert(questItem, 3042) --purple fox fur
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
			table.insert(questItem, 406) --frog legs
		end

		if player.level >= 85 then
		end

		if player.level >= 90 then
		end

		if player.level >= 95 then
			table.insert(questItem, 3022) --sticky slime
		end

		if player.level >= 99 then
			table.insert(questItem, 416) --ogre ear
		end

		if (player.baseHealth >= 15000 or player.baseMagic >= 15000) then
			table.insert(questItem, 3051) --swamp fox fur
			table.insert(questItem, 3052) --river fox fur
		end

		if player.level >= 100 then --Arctic Slush
		end

		if player.level >= 102 then --Rabbit Warrens
			table.insert(questItem, 8001) --Dead Wide Eyed Bunny
			table.insert(questItem, 8002) --Dead Downer Bunny
			table.insert(questItem, 8003) --Dead Chaotic Hare
		end

		if player.level >= 105 then --Critter Crawlspace
			table.insert(questItem, 8012) --Troll Hair
			table.insert(questItem, 8013) --Wallace Tusk
		end

		if player.level >= 105 then --Arctic Snow
		end

		if player.level >= 109 then --Lortz Plantation
			table.insert(questItem, 8021) --Green Leaf
			table.insert(questItem, 8022) --Fire Leaf
			table.insert(questItem, 8023) --Mud Leaf
			table.insert(questItem, 8024) --Flytrap Venom Gland
		end

		if player.level >= 110 then --Ice Palace
		end

		if player.level >= 110 then --Arctic Sleet
		end

		if player.level >= 112 then --Occupied Cave
			table.insert(questItem, 8041) --Kulu Bracelet
			table.insert(questItem, 8042) --Ape Tail
			table.insert(questItem, 8043) --Alpha Ape Horn
		end

		if player.level >= 115 then --Arctic Hail
		end

		if player.level >= 116 then --Bear Cave
			table.insert(questItem, 8051) --Baby Bear Heart
			table.insert(questItem, 8052) --Bear Liver
			table.insert(questItem, 8053) --Bear Brains
			table.insert(questItem, 8054) --Pic-a-nic Basket
		end

		if player.level >= 118 then --Robber's Lair
		end
		 --

		--[[if player.level >= 120 then --Dragon Den
		table.insert(questItem, 8061) --Fine Dragon Scale
		table.insert(questItem, 8062) --Adult Dragon Scale
		table.insert(questItem, 8063) --Mature Dragon Scale
	end]] if
			player.level >= 120
		 then --Arctic Flurry
		end

		if player.level >= 123 then --Pig Sty
			table.insert(questItem, 8071) --Dead Piglet
			table.insert(questItem, 8072) --Dead Big Pig
			table.insert(questItem, 8073) --Dead Fat Pig
			table.insert(questItem, 8074) --Ox Meat
		end

		if player.level >= 125 then --Grim Barrens
		end

		if player.level >= 125 then --Arctic Blizzard
		end

		--	if player.level >= 125 then --Ice Palace 2
		--
		--	end

		if player.level >= 130 then --Arctic Avalanche
		end

		if player.level >= 135 then --Arctic Tempest
		end

		if player.level >= 140 then --Arctic Cyclone
		end

		if player.level >= 145 then --Arctic Elders
		end

		if #questItem > 0 then
			local r = math.random(1, #questItem)
			finalQuestItem = questItem[r]
		end

		return finalQuestItem
	end,
	nearbyPlayers = function(npc)
		local pc = npc:getObjectsInArea(BL_PC)
		local m, x, y = npc.m, npc.x, npc.y

		if #pc > 0 then
			for i = 1, #pc do
				if pc[i].level >= 5 and pc[i].registry["dailyq_path_supply_timer"] < os.time() then
					if pc[i].mapTitle == "Fighter's Hall" and pc[i].baseClass == 1 then
						pc[i]:selfAnimationXY(pc[i].ID, 248, x, y)
					elseif pc[i].mapTitle == "Scoundrel's Guild" and pc[i].baseClass == 2 then
						pc[i]:selfAnimationXY(pc[i].ID, 248, x, y)
					elseif pc[i].mapTitle == "Seagrove Hidden Library" and pc[i].baseClass == 3 then
						pc[i]:selfAnimationXY(pc[i].ID, 248, x, y)
					elseif pc[i].mapTitle == "House of ASAK" and pc[i].baseClass == 4 then
						pc[i]:selfAnimationXY(pc[i].ID, 248, x, y)
					end
				end
			end
		end
	end
}
