path_kill_daily = {
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
			if player.quest["dailyq_path_kill"] == 0 then
				table.insert(opts, "Start Daily Quest")
			end
			if player.quest["dailyq_path_kill"] >= 1 then
				table.insert(opts, "Finished Daily Quest")
			end
			if player.quest["dailyq_path_kill"] >= 1 then
				table.insert(opts, "Abandon Daily Quest")
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

			if player.registry["dailyq_path_kill_timer"] > os.time() then
				player:dialogSeq(
					{
						t,
						name ..
							"You have already done a quest today. Come back later.\n\nAvailable again in: " ..
								math.ceil(((player.registry["dailyq_path_kill_timer"] - os.time()) / 3600)) .. " hours"
					},
					1
				)
			else
				menu = player:menuString(name .. "Are you here for a quest? We have many tasks for enterprising recruits.", opts)
			end

			if player.registry["dailyq_path_kill_timer"] < os.time() then
				if menu == "Start Daily Quest" then
					player:dialogSeq(
						{
							t,
							name .. "Want to prove yourself? Then shut up and do what I say.",
							name .. "Today's quest is..."
						},
						1
					)
					randomBounty = path_kill_daily.getTarget(player, npc)
					bounty = randomBounty
					numberKills = math.random(1, 5)
					bountyName = getMobName(bounty)

					player.quest["dailyq_path_kill"] = bounty
					player.quest["dailyq_path_kill_count"] = numberKills
					player:flushKills(bounty)
					player:dialogSeq(
						{
							t,
							name .. "You must slay " .. numberKills .. " " .. bountyName .. ".",
							name .. "Return here when you are done."
						},
						1
					)
					player:addLegend("On a quest to slay " .. numberKills .. " " .. bountyName, "dailyq_path_kill", 1, 16)
				elseif menu == "Abandon Daily Quest" then
					abandon = player:menuString(name .. "Would you like to abandon your current quest?", {"Yes", "No"})
					if abandon == "Yes" then
						player.quest["dailyq_path_kill"] = 0
						player.registry["dailyq_path_kill_timer"] = os.time() + 86400
						if player:hasLegend("dailyq_path_kill") then
							player:removeLegendbyName("dailyq_path_kill")
						end
						player:popUp("Quest Abandoned!")
					end
				elseif menu == "Finished Daily Quest" then
					bounty = player.quest["dailyq_path_kill"]
					if player.quest["dailyq_path_kill"] > 0 then
						if player:killCount(bounty) >= player.quest["dailyq_path_kill_count"] then
							player.quest["dailyq_path_kill"] = 0
							path_kill_daily.complete(player)
							player:dialogSeq({t, name .. "Great Job!"}, 1)
						end
					else
						player:dialogSeq({t, name .. "You haven't finished the job yet! You're not chicken, are you?"}, 1)
					end
				end
			end
		end
	),
	complete = function(player)
		local rewardGold = player.level * 50

		player:leveledEXP("daily")
		player:addGold(rewardGold)
		player:calcStat()
		player:sendStatus()
		finishedQuest(player)
		player:msg(4, "[Daily Quest Complete]", player.ID)
		player.quest["dailyq_path_kill"] = 0
		player.quest["dailyq_path_kill_count"] = 0
		player.registry["dailyq_path_kill_timer"] = os.time() + 86400

		if player:hasLegend("dailyq_path_total") then
			player:removeLegendbyName("dailyq_path_total")
		end

		if player:hasLegend("dailyq_path_kill") then
			player:removeLegendbyName("dailyq_path_kill")
		end

		if player.registry["dailyq_path_kill_complete"] > 0 then
			player.registry["dailyq_path_kill_complete"] = player.registry["dailyq_path_kill_complete"] + 1
			player:addLegend(
				"Completed " .. player.registry["dailyq_path_kill_complete"] .. " Minor Guild Quests",
				"dailyq_path_total",
				1,
				16
			)
		else
			player.registry["dailyq_path_kill_complete"] = 1
			player:addLegend("Completed 1 Minor Guild Quest", "dailyq_path_total", 1, 16)
		end
		if player.registry["dailyq_path_kill_complete"] == 10 then
			broadcast(-1, "[TITLE]: " .. player.name .. " has just earned the title 'Recruit'!")
		end
		if player.registry["dailyq_path_kill_complete"] == 100 then
			broadcast(-1, "[TITLE]: " .. player.name .. " has just earned the title 'Veteran'!")
		end
	end,
	getTarget = function(player, npc)
		local questTargets = {}
		local targetName = ""

		if player.level >= 5 then --Sewer / Crypt 1
			table.insert(questTargets, 1001) --  Sewer Rat
			table.insert(questTargets, 1002) --  Large Sewer Rat
			table.insert(questTargets, 1003) --  Mutated Sewer Rat
			table.insert(questTargets, 1004) --  Sewer Slug
			table.insert(questTargets, 1401) --  Crypt Mouse
		end
		if player.level >= 10 then --Crypt 2
			table.insert(questTargets, 1403) --  Plagued Rat

			if player.level <= 44 then --Earthworks 1
				table.insert(questTargets, 1011) -- Worm
				table.insert(questTargets, 1012) -- Fire worm
				table.insert(questTargets, 1013) -- Earth snake
				table.insert(questTargets, 1014) -- Mud snake
				table.insert(questTargets, 1015) -- Bandit Initiate
				table.insert(questTargets, 1016) -- Bandit Veteran
				table.insert(questTargets, 1017) -- Bandit Elite
			end
		end
		if player.level >= 15 then --Crypt 3
			table.insert(questTargets, 1405) --  Ravenous Rat

			if player.level <= 54 then --Fox Cave 1
				table.insert(questTargets, 1021) -- Black Fox
				table.insert(questTargets, 1022) -- Red Fox
				table.insert(questTargets, 1023) -- Rabid Fox
				table.insert(questTargets, 1024) -- Rainbow Fox
			end
		end
		if player.level >= 20 then -- Crypt 4
			table.insert(questTargets, 1407) -- Possessed Deer
			if player.level <= 64 then --Haunted House 1
				table.insert(questTargets, 1031) -- Girl spirit
				table.insert(questTargets, 1032) -- Boy spirit
				table.insert(questTargets, 1033) -- Faceless spirit
			end
			if player.level <= 74 then --Bat Cave 1
				table.insert(questTargets, 1041) --Smirking Bat
				table.insert(questTargets, 1042) --Overconfident Bat
			end
		end

		if player.level >= 25 then -- Crypt 5/6
			table.insert(questTargets, 1409) -- Skeleton
			table.insert(questTargets, 1411) -- Skeletal Magician
		end

		if player.level >= 30 then --Contaminated Cove / Crypt 7
			table.insert(questTargets, 1051) --Mutated Minnow
			table.insert(questTargets, 1052) --Mutated Bass

			table.insert(questTargets, 1413) -- Skeletal Warrior
		end

		if player.level >= 35 then --Savage Territory / Crypt 8
			table.insert(questTargets, 1301) --Savage Spearmaiden
			table.insert(questTargets, 1302) --Savage Highwayman
			table.insert(questTargets, 1303) --Savage Stickman

			table.insert(questTargets, 1415) -- Undead Brute
		end
		if player.level >= 40 then --Leech Cave / Crypt 9
			table.insert(questTargets, 1061) --Red Spotted Leech
			table.insert(questTargets, 1062) --Green Striped Leech
			table.insert(questTargets, 1063) --Violent Leech
			table.insert(questTargets, 1064) --Venemous Leech

			table.insert(questTargets, 1417) -- Failed Experiment
		end

		if player.level >= 45 then -- Subterranean 1
			table.insert(questTargets, 1151) --Angry Caterpillar
		end

		if player.level >= 45 and player.level <= 94 then --Earthworks 2
			table.insert(questTargets, 1071) -- Earth Worm
			table.insert(questTargets, 1072) -- Blood Worm
			table.insert(questTargets, 1073) -- Yellow-Bellied Snake
			table.insert(questTargets, 1074) -- Blue Racer Snake
			table.insert(questTargets, 1075) -- War Thog's Initiate
			table.insert(questTargets, 1076) -- War Thog's Veteran
			table.insert(questTargets, 1077) -- War Thog's Elite
		end
		if player.level >= 50 then --Disturbed Tomb / Subterranean 2
			table.insert(questTargets, 2001) --Tomb Robber

			table.insert(questTargets, 1153) --Chill Caterpillar
		end

		if player.level >= 55 then -- Subterranean 3 / Crypt 11
			table.insert(questTargets, 1155) --Weak Homunculus

			table.insert(questTargets, 1419) -- Crypt Raider
		end

		if player.level >= 55 and (player.baseHealth <= 14999 and player.baseMagic <= 14999) then --Fox Cave 2
			table.insert(questTargets, 1081) --Blue Fox
			table.insert(questTargets, 1082) --Purple Fox
			table.insert(questTargets, 1083) --White Fox
			table.insert(questTargets, 1084) --Painted Fox
		end
		if player.level >= 60 then --Spider Pit / Subterranean 4 / Crypt 12
			table.insert(questTargets, 2011) --Young Spider
			table.insert(questTargets, 2012) --Lurking Spider
			table.insert(questTargets, 2013) --Guardian Spider

			table.insert(questTargets, 1157) --Evil Homunculus

			table.insert(questTargets, 1421) -- Bandit Defender
		end

		if player.level >= 65 then -- Subterranean 5 / Crypt 13
			table.insert(questTargets, 1159) --Seer's Apprentice

			table.insert(questTargets, 1422) -- Bandit Thug
		end

		if player.level >= 65 and (player.baseHealth <= 19999 and player.baseMagic <= 19999) then --Haunted House 2
			table.insert(questTargets, 1091) --Chilled Spirit
			table.insert(questTargets, 1092) --Pale Spirit
			table.insert(questTargets, 1093) --Wavering Spirit
		end
		if player.level >= 70 then --Wolf Den / Subterranean 6 / Crypt 14
			table.insert(questTargets, 2021) --Brown Wolf
			table.insert(questTargets, 2022) --Red Wolf
			table.insert(questTargets, 2023) --Black Wolf

			table.insert(questTargets, 1161) --Overseer's Student

			table.insert(questTargets, 1423) --Bandit Captain
		end

		if player.level >= 75 then -- Subterranean 7 / Crypt 15
			table.insert(questTargets, 1163) --Q

			table.insert(questTargets, 1424) --Bandit Commander
		end

		if player.level >= 75 and (player.baseHealth <= 29999 and player.baseMagic <= 29999) then --Bat Cave 2
			table.insert(questTargets, 1101) --Sea Bat
			table.insert(questTargets, 1102) --Cave Bat
		end

		if player.level >= 80 then --Tonguspur Beach / Frog Swamp / Subterranean 8 / Crypt 16
			table.insert(questTargets, 2032) --Crazed Lobster
			table.insert(questTargets, 2033) --Man o'War
			table.insert(questTargets, 2041) --Green Snake
			table.insert(questTargets, 2042) --Swarm of Insects
			table.insert(questTargets, 2043) --Tree Frog
			table.insert(questTargets, 2044) --Swamp Gator

			table.insert(questTargets, 1165) --Li

			table.insert(questTargets, 1426) --Awakened Elemental
		end
		if player.level >= 85 then --Frog Bog / Subterranean 9 / Crypt 17
			table.insert(questTargets, 2051) --Swamp Frog
			table.insert(questTargets, 2052) --Giant Bug
			table.insert(questTargets, 2053) --Bog Frog

			table.insert(questTargets, 1167) --Puu

			table.insert(questTargets, 1428) --Cursed Elemental
			table.insert(questTargets, 1429) --Elemental Seer
		end
		if player.level >= 90 then --Blackstrike Swamp / Subterranean 10 / Crypt 18
			table.insert(questTargets, 2061) --Swamp Slime
			table.insert(questTargets, 2062) --Blackstrike Swarm
			table.insert(questTargets, 2063) --Blackstrike Frog
			table.insert(questTargets, 2064) --Blackstrike Blue Frog
			table.insert(questTargets, 2065) --Blackstrike Gator

			table.insert(questTargets, 1169) --Muckman

			table.insert(questTargets, 1430) --Angered Spirit
		end
		if player.level >= 95 then --Earthworks 3 / Crypt 19
			table.insert(questTargets, 1111) --Glow Worm
			table.insert(questTargets, 1112) --Lava Worm
			table.insert(questTargets, 1113) --Electric Snake
			table.insert(questTargets, 1114) --Coral Snake
			table.insert(questTargets, 1115) --War Thog's Soldier
			table.insert(questTargets, 1116) --War Thog's Infiltrator
			table.insert(questTargets, 1117) --War Thog's Major

			table.insert(questTargets, 1431) --Elemental Warrior
		end

		if player.level >= 99 then --Lortz Ogre / Crypt 20
			table.insert(questTargets, 3001) --Ogre Scout
			table.insert(questTargets, 3002) --Ogre Champion

			table.insert(questTargets, 1432) --Elemental Champion
		end

		if (player.baseHealth >= 15000 or player.baseMagic >= 15000) then --Fox Cave 3
			table.insert(questTargets, 1121) --Swamp Fox
			table.insert(questTargets, 1122) --River Fox
			table.insert(questTargets, 1123) --Mountain Fox
			table.insert(questTargets, 1124) --Shadow Fox
		end

		if (player.baseHealth >= 20000 or player.baseMagic >= 20000) then --Haunted House 3
			table.insert(questTargets, 1131) --Frantic Spirit
			table.insert(questTargets, 1132) --Anxious Spirit
			table.insert(questTargets, 1133) --Tainted Spirit
		end

		if (player.baseHealth >= 30000 or player.baseMagic >= 30000) then --Bat Cave 3
			table.insert(questTargets, 1141) --Grinning Bat
			table.insert(questTargets, 1142) --Luminescent Bat
		end

		if (player.baseHealth >= 35000 or player.baseMagic >= 35000) then --Ruins of Bettay
			table.insert(questTargets, 3011) --Young Gargoyle
			table.insert(questTargets, 3012) --Adult Gargoyle
			table.insert(questTargets, 3013) --Elder Gargoyle
		end

		if player.level >= 100 then --Arctic Slush
			table.insert(questTargets, 4031) --Snow Rabbit
			table.insert(questTargets, 4032) --Arctic Deer
			table.insert(questTargets, 4033) --Slush Ogre
		end

		if player.level >= 101 then --Crypt 21
			table.insert(questTargets, 1434) --Cave Dweller
		end

		if player.level >= 102 then --Rabbit Warrens
			table.insert(questTargets, 3021) --Wide Eyed Bunny
			table.insert(questTargets, 3022) --Downer Bunny
			table.insert(questTargets, 3023) --Chaotic Hare
		end

		if player.level >= 103 then --Crypt 22
			table.insert(questTargets, 1436) --Enraged Hermit
		end

		if player.level >= 105 then --Critter Crawlspace / Crypt 23 / Arctic Snow
			table.insert(questTargets, 3031) --Barry The Giant Sea Worm
			table.insert(questTargets, 3032) --Roger The Troll
			table.insert(questTargets, 3033) --Wallace The Walrus

			table.insert(questTargets, 1437) --Lost Tribesman

			table.insert(questTargets, 4035) --Snow Ogre
		end

		if player.level >= 107 then --Crypt 24
			table.insert(questTargets, 1438) --Deep Hunter
		end

		if player.level >= 109 then --Lortz Plantation / Crypt 25
			table.insert(questTargets, 3041) --Leaf Sprout
			table.insert(questTargets, 3042) --Fire Sprout
			table.insert(questTargets, 3043) --Mud Sprout
			table.insert(questTargets, 3044) --Fly Trapper

			table.insert(questTargets, 1439) --Cloud Rider
		end
		 --

		--[[if player.level >= 110 then --Ice Palace
		table.insert(questTargets, 4001) --Ice Wraith
		table.insert(questTargets, 4002) --Ice Archer
		table.insert(questTargets, 4003) --Ice Mage
		table.insert(questTargets, 4004) --Frozen Assassin
		table.insert(questTargets, 4005) --Frozen Fighter
		table.insert(questTargets, 4006) --Frozen Summoner
	end]] if
			player.level >= 110
		 then --Arctic Sleet
			table.insert(questTargets, 4035) --Sleet Ogre
		end

		if player.level >= 112 then --Occupied Cave
			table.insert(questTargets, 3051) --Kulu Dweller
			table.insert(questTargets, 3052) --Great Ape
			table.insert(questTargets, 3053) --Alpha Ape
		end

		if player.level >= 115 then --Arctic Hail
			table.insert(questTargets, 4039) --Hail Ogre
		end

		if player.level >= 116 then --Bear Cave
			table.insert(questTargets, 3061) --Baby Bear
			table.insert(questTargets, 3062) --Brother Bear
			table.insert(questTargets, 3063) --Momma Bear
			table.insert(questTargets, 3064) --Pappa bear
		end

		if player.level >= 118 then --Robber's Lair
			table.insert(questTargets, 2081) --Ugly Thief
			table.insert(questTargets, 2082) --Kulu Thief
			table.insert(questTargets, 2083) --Brute Thief
		end
		 --

		--[[if player.level >= 120 then --Dragon Den
		table.insert(questTargets, 3071) --Wyrmling
		table.insert(questTargets, 3072) --Adult Wyrm
		table.insert(questTargets, 3073) --Mature Adult Wyrm

	end]] if
			player.level >= 120
		 then --Arctic Flurry
			table.insert(questTargets, 4041) --Flurry Ogre
		end

		if player.level >= 123 then --Pig Sty
			table.insert(questTargets, 3081) --Piglet
			table.insert(questTargets, 3082) --Big Pig
			table.insert(questTargets, 3083) --Fat Pig
			table.insert(questTargets, 3084) --Black Oxen
			table.insert(questTargets, 3085) --Striped Oxen
		end

		if player.level >= 125 then --Grim Barrens
			table.insert(questTargets, 3091) --Grim Ogre
			table.insert(questTargets, 3092) --Southern Ogre
		end

		if player.level >= 125 then --Arctic Blizzard
			table.insert(questTargets, 4043) --Blizzard Ogre
		end
		 --

		--[[if player.level >= 125 then --Ice Palace 2
		table.insert(questTargets, ) 
		table.insert(questTargets, ) 
		table.insert(questTargets, ) 
	end]] if
			player.level >= 130
		 then --Arctic Avalanche
			table.insert(questTargets, 4045) --Avalanche Ogre
		end

		if player.level >= 135 then --Arctic Tempest
			table.insert(questTargets, 4047) --Tempest Ogre
		end

		if player.level >= 140 then --Arctic Cyclone
			table.insert(questTargets, 4049) --Cyclone Ogre
		end

		if player.level >= 145 then --Arctic Elders
			table.insert(questTargets, 4051) --Elder Ogre
		end

		if #questTargets > 0 then
			local r = math.random(1, #questTargets)
			finalQuestTarget = questTargets[r]
		end
		return finalQuestTarget
	end,
	nearbyPlayers = function(npc)
		local pc = npc:getObjectsInArea(BL_PC)
		local m, x, y = npc.m, npc.x, npc.y

		if #pc > 0 then
			for i = 1, #pc do
				if pc[i].level >= 5 and pc[i].registry["dailyq_path_kill_timer"] < os.time() then
					if pc[i].mapTitle == "Fighter's Hall" and pc[i].baseClass == 1 then
						pc[i]:selfAnimationXY(pc[i].ID, 248, x, y)
					elseif pc[i].mapTitle == "Scoundrel's Guild" and pc[i].baseClass == 2 then
						pc[i]:selfAnimationXY(pc[i].ID, 248, x, y)
					elseif pc[i].mapTitle == "Seagrove Library" and pc[i].baseClass == 3 then
						pc[i]:selfAnimationXY(pc[i].ID, 248, x, y)
					elseif pc[i].mapTitle == "House of ASAK" and pc[i].baseClass == 4 then
						pc[i]:selfAnimationXY(pc[i].ID, 248, x, y)
					end
				end
			end
		end
	end
}
