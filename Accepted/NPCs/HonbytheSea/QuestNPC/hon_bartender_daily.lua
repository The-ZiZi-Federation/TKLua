hon_bartender_daily = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID
			local bountyName

			local opts = {}
			local bounty = 0
			if player.quest["dailyq_hon_bartender"] == 0 then
				table.insert(opts, "Start Daily Bounty")
			end
			if player.quest["dailyq_hon_bartender"] >= 1 then
				table.insert(opts, "Finished Daily Bounty")
			end
			if player.quest["dailyq_hon_bartender"] >= 1 then
				table.insert(opts, "Abandon Daily Bounty")
			end
			table.insert(opts, "Nothing")

			if player.level < 5 then
				player:dialogSeq({t, name .. "Come back when you're a little stronger."}, 1)
				return
			end

			if player.registry["dailyq_hon_bartender_timer"] > os.time() then
				player:dialogSeq(
					{
						t,
						name ..
							"You have already done a mission today. Come back later.\n\nAvailable again in: " ..
								math.ceil(((player.registry["dailyq_hon_bartender_timer"] - os.time()) / 3600)) .. " hours"
					},
					1
				)
			else
				menu = player:menuString(name .. "Are you here about the bounties? There's lots of jobs available.", opts)
			end

			if player.registry["dailyq_hon_bartender_timer"] < os.time() then
				if menu == "Start Daily Bounty" then
					player:dialogSeq(
						{
							t,
							name .. "We collect bounties that have been placed by community members.",
							name .. "Today's mission is..."
						},
						1
					)
					randomBounty = hon_bartender_daily.getTarget(player, npc)
					bounty = randomBounty
					bountyName = getMobName(bounty)
					player.quest["dailyq_hon_bartender"] = bounty
					player:flushKills(bounty)

					player:addLegend("Accepted a bounty on the " .. bountyName, "current_bounty", 88, 16)
					player:dialogSeq(
						{
							t,
							name .. "You must slay a " .. bountyName .. ".",
							name .. "Return here when you are done."
						},
						1
					)
				elseif menu == "Abandon Daily Bounty" then
					abandon = player:menuString(name .. "Would you like to abandon your current mission?", {"Yes", "No"})
					if abandon == "Yes" then
						player.quest["dailyq_hon_bartender"] = 0
						player.registry["dailyq_hon_bartender_timer"] = os.time() + 86400
						if player:hasLegend("current_bounty") then
							player:removeLegendbyName("current_bounty")
						end
						player:popUp("Bounty Abandoned!")
					end
				elseif menu == "Finished Daily Bounty" then
					bounty = player.quest["dailyq_hon_bartender"]
					if player.quest["dailyq_hon_bartender"] > 0 then
						if player:killCount(bounty) > 0 then
							player.quest["dailyq_hon_bartender"] = 0
							hon_bartender_daily.complete(player)
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
		player:msg(4, "[Daily Bounty Complete]", player.ID)
		player.quest["dailyq_hon_bartender"] = 0
		player.registry["dailyq_hon_bartender_timer"] = os.time() + 86400

		if player:hasLegend("dailyq_hon_bartender") then
			player:removeLegendbyName("dailyq_hon_bartender")
		end

		if player:hasLegend("current_bounty") then
			player:removeLegendbyName("current_bounty")
		end

		if player.registry["dailyq_hon_bartender_complete"] > 0 then
			player.registry["dailyq_hon_bartender_complete"] = player.registry["dailyq_hon_bartender_complete"] + 1
			player:addLegend(
				"Completed " .. player.registry["dailyq_hon_bartender_complete"] .. " Barkeeper Bounties",
				"dailyq_hon_bartender",
				1,
				16
			)
		else
			player.registry["dailyq_hon_bartender_complete"] = 1
			player:addLegend("Completed 1 Barkeeper Bounty", "dailyq_hon_bartender", 88, 16)
		end
		if player.registry["dailyq_hon_bartender_complete"] == 10 then
			broadcast(-1, "[TITLE]: " .. player.name .. " has just earned the title 'Barfly'!")
		end
		if player.registry["dailyq_hon_bartender_complete"] == 100 then
			broadcast(-1, "[TITLE]: " .. player.name .. " has just earned the title 'Bounty Hunter'!")
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
			table.insert(questTargets, 1005) --  Mutated Sewer Slug
			table.insert(questTargets, 1401) --  Crypt Mouse
			table.insert(questTargets, 1402) --  Crypt Rat
		end
		if player.level >= 10 then --Crypt 2
			table.insert(questTargets, 1403) --  Plagued Rat
			table.insert(questTargets, 1404) --  Ravenous Deer

			if player.level <= 44 then --Earthworks 1
				table.insert(questTargets, 1011) -- Worm
				table.insert(questTargets, 1012) -- Fire worm
				table.insert(questTargets, 1013) -- Earth snake
				table.insert(questTargets, 1014) -- Mud snake
				table.insert(questTargets, 1015) -- Bandit Initiate
				table.insert(questTargets, 1016) -- Bandit Veteran
				table.insert(questTargets, 1017) -- Bandit Elite
				table.insert(questTargets, 1018) -- War Thog Jr
			end
		end
		if player.level >= 15 then --Crypt 3
			table.insert(questTargets, 1405) --  Ravenous Rat
			table.insert(questTargets, 1406) --  Ursus

			if player.level <= 54 then --Fox Cave 1
				table.insert(questTargets, 1021) -- Black Fox
				table.insert(questTargets, 1022) -- Red Fox
				table.insert(questTargets, 1023) -- Rabid Fox
				table.insert(questTargets, 1024) -- Rainbow Fox
				table.insert(questTargets, 1025) -- Kumiho
			end
		end
		if player.level >= 20 then -- Crypt 4
			table.insert(questTargets, 1407) -- Possessed Deer
			table.insert(questTargets, 1408) -- Burning Remains
			if player.level <= 64 then --Haunted House 1
				table.insert(questTargets, 1031) -- Girl spirit
				table.insert(questTargets, 1032) -- Boy spirit
				table.insert(questTargets, 1033) -- Faceless spirit
				table.insert(questTargets, 1034) -- Mentok
			end
			if player.level <= 74 then --Bat Cave 1
				table.insert(questTargets, 1041) --Smirking Bat
				table.insert(questTargets, 1042) --Overconfident Bat
				table.insert(questTargets, 1043) --Deceitfully Cute bat
			end
		end

		if player.level >= 25 then -- Crypt 5/6
			table.insert(questTargets, 1409) -- Skeleton
			table.insert(questTargets, 1410) -- Skeletal Minion
			table.insert(questTargets, 1411) -- Skeletal Magician
			table.insert(questTargets, 1412) -- Skeletal Wizard
		end

		if player.level >= 30 then --Contaminated Cove / Crypt 7
			table.insert(questTargets, 1051) --Mutated Minnow
			table.insert(questTargets, 1052) --Mutated Bass
			table.insert(questTargets, 1053) --Mutated Goldfish

			table.insert(questTargets, 1413) -- Skeletal Warrior
			table.insert(questTargets, 1414) -- Skeletal Blademaster
		end

		if player.level >= 35 then --Savage Territory / Crypt 8
			table.insert(questTargets, 1301) --Savage Spearmaiden
			table.insert(questTargets, 1302) --Savage Highwayman
			table.insert(questTargets, 1303) --Savage Stickman
			table.insert(questTargets, 1304) --Savage Warchief

			table.insert(questTargets, 1415) -- Undead Brute
			table.insert(questTargets, 1416) -- Demon Witch
		end
		if player.level >= 40 then --Leech Cave / Crypt 9
			table.insert(questTargets, 1061) --Red Spotted Leech
			table.insert(questTargets, 1062) --Green Striped Leech
			table.insert(questTargets, 1063) --Violent Leech
			table.insert(questTargets, 1064) --Venemous Leech
			table.insert(questTargets, 1065) --Leech Lord

			table.insert(questTargets, 1417) -- Failed Experiment
			table.insert(questTargets, 1418) -- Gloth
		end

		if player.level >= 45 then -- Subterranean 1
			table.insert(questTargets, 1151) --Angry Caterpillar
			table.insert(questTargets, 1152) --Giant Spider
		end

		if player.level >= 45 and player.level <= 94 then --Earthworks 2
			table.insert(questTargets, 1071) -- Earth Worm
			table.insert(questTargets, 1072) -- Blood Worm
			table.insert(questTargets, 1073) -- Yellow-Bellied Snake
			table.insert(questTargets, 1074) -- Blue Racer Snake
			table.insert(questTargets, 1075) -- War Thog's Initiate
			table.insert(questTargets, 1076) -- War Thog's Veteran
			table.insert(questTargets, 1077) -- War Thog's Elite
			table.insert(questTargets, 1078) -- War Thog Jr
		end
		if player.level >= 50 then --Disturbed Tomb / Subterranean 2
			table.insert(questTargets, 2001) --Tomb Robber
			table.insert(questTargets, 2002) --Scumbag Thief

			table.insert(questTargets, 1153) --Chill Caterpillar
			table.insert(questTargets, 1154) --Lazy Tick
		end

		if player.level >= 55 then -- Subterranean 3 / Crypt 11
			table.insert(questTargets, 1155) --Weak Homunculus
			table.insert(questTargets, 1156) --Misanthropic Wizard

			table.insert(questTargets, 1419) -- Crypt Raider
			table.insert(questTargets, 1420) -- Raider Guardian
		end

		if player.level >= 55 and (player.baseHealth <= 14999 and player.baseMagic <= 14999) then --Fox Cave 2
			table.insert(questTargets, 1081) --Blue Fox
			table.insert(questTargets, 1082) --Purple Fox
			table.insert(questTargets, 1083) --White Fox
			table.insert(questTargets, 1084) --Painted Fox
			table.insert(questTargets, 1085) --Blue Kumiho
		end
		if player.level >= 60 then --Spider Pit / Subterranean 4 / Crypt 12
			table.insert(questTargets, 2011) --Young Spider
			table.insert(questTargets, 2012) --Lurking Spider
			table.insert(questTargets, 2013) --Guardian Spider
			table.insert(questTargets, 2014) --Spider Queen

			table.insert(questTargets, 1157) --Evil Homunculus
			table.insert(questTargets, 1158) --Evil Wizard

			table.insert(questTargets, 1421) -- Bandit Defender
		end

		if player.level >= 65 then -- Subterranean 5 / Crypt 13
			table.insert(questTargets, 1159) --Seer's Apprentice
			table.insert(questTargets, 1160) --Faceless Seer

			table.insert(questTargets, 1422) -- Bandit Thug
		end

		if player.level >= 65 and (player.baseHealth <= 19999 and player.baseMagic <= 19999) then --Haunted House 2
			table.insert(questTargets, 1091) --Chilled Spirit
			table.insert(questTargets, 1092) --Pale Spirit
			table.insert(questTargets, 1093) --Wavering Spirit
			table.insert(questTargets, 1094) --Chilled Mentok
		end
		if player.level >= 70 then --Wolf Den / Subterranean 6 / Crypt 14
			table.insert(questTargets, 2021) --Brown Wolf
			table.insert(questTargets, 2022) --Red Wolf
			table.insert(questTargets, 2023) --Black Wolf
			table.insert(questTargets, 2024) --Dire Wolf

			table.insert(questTargets, 1161) --Overseer's Student
			table.insert(questTargets, 1162) --High Overseer

			table.insert(questTargets, 1423) --Bandit Captain
		end

		if player.level >= 75 then -- Subterranean 7 / Crypt 15
			table.insert(questTargets, 1163) --Q
			table.insert(questTargets, 1164) --Dragoon

			table.insert(questTargets, 1424) --Bandit Commander
			table.insert(questTargets, 1425) --Bandit King
		end

		if player.level >= 75 and (player.baseHealth <= 29999 and player.baseMagic <= 29999) then --Bat Cave 2
			table.insert(questTargets, 1101) --Sea Bat
			table.insert(questTargets, 1102) --Cave Bat
			table.insert(questTargets, 1103) --Confident Bat
		end

		if player.level >= 80 then --Tonguspur Beach / Frog Swamp / Subterranean 8 / Crypt 16
			table.insert(questTargets, 2032) --Crazed Lobster
			table.insert(questTargets, 2033) --Man o'War
			table.insert(questTargets, 2034) --Possessed Snail
			table.insert(questTargets, 2041) --Green Snake
			table.insert(questTargets, 2042) --Swarm of Insects
			table.insert(questTargets, 2043) --Tree Frog
			table.insert(questTargets, 2044) --Swamp Gator

			table.insert(questTargets, 1165) --Li
			table.insert(questTargets, 1166) --Fenix Dragoon

			table.insert(questTargets, 1426) --Awakened Elemental
			table.insert(questTargets, 1427) --Elemental Guardian
		end
		if player.level >= 85 then --Frog Bog / Subterranean 9 / Crypt 17
			table.insert(questTargets, 2051) --Swamp Frog
			table.insert(questTargets, 2052) --Giant Bug
			table.insert(questTargets, 2053) --Bog Frog

			table.insert(questTargets, 1167) --Puu
			table.insert(questTargets, 1168) --Annoying Construct

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
			table.insert(questTargets, 1170) --Enraged Construct

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
			table.insert(questTargets, 1118) --War Thog Jr (lv 3)

			table.insert(questTargets, 1431) --Elemental Warrior
		end

		if player.level >= 99 then --Lortz Ogre / Crypt 20
			table.insert(questTargets, 3001) --Ogre Scout
			table.insert(questTargets, 3002) --Ogre Champion
			table.insert(questTargets, 3003) --Ogre Shaman

			table.insert(questTargets, 1432) --Elemental Champion
			table.insert(questTargets, 1433) --Bloth
		end

		if player.level >= 99 then
			if (player.baseHealth >= 15000 or player.baseMagic >= 15000) then --Fox Cave 3
				table.insert(questTargets, 1121) --Swamp Fox
				table.insert(questTargets, 1122) --River Fox
				table.insert(questTargets, 1123) --Mountain Fox
				table.insert(questTargets, 1124) --Shadow Fox
				table.insert(questTargets, 1125) --Black Kumiho
			end
		end

		if player.level >= 99 then
			if (player.baseHealth >= 20000 or player.baseMagic >= 20000) then --Haunted House 3
				table.insert(questTargets, 1131) --Frantic Spirit
				table.insert(questTargets, 1132) --Anxious Spirit
				table.insert(questTargets, 1133) --Tainted Spirit
				table.insert(questTargets, 1134) --Mentok the Mind Taker
			end
		end

		if player.level >= 99 then
			if (player.baseHealth >= 30000 or player.baseMagic >= 30000) then --Bat Cave 3
				table.insert(questTargets, 1141) --Grinning Bat
				table.insert(questTargets, 1142) --Luminescent Bat
				table.insert(questTargets, 1143) --Dragon Bat
			end
		end

		if player.level >= 99 then
			if (player.baseHealth >= 35000 or player.baseMagic >= 35000) then --Ruins of Bettay
				table.insert(questTargets, 3011) --Young Gargoyle
				table.insert(questTargets, 3012) --Adult Gargoyle
				table.insert(questTargets, 3013) --Elder Gargoyle
				table.insert(questTargets, 3014) --Malvolia the Vicious
				table.insert(questTargets, 3015) --Andrea the Terrible
			end
		end

		if player.level >= 100 then --Arctic Slush
			table.insert(questTargets, 4031) --Snow Rabbit
			table.insert(questTargets, 4032) --Arctic Deer
			table.insert(questTargets, 4033) --Slush Ogre
			table.insert(questTargets, 4034) --Slush King
		end

		if player.level >= 101 then --Crypt 21
			table.insert(questTargets, 1434) --Cave Dweller
		end

		if player.level >= 102 then --Rabbit Warrens
			table.insert(questTargets, 3021) --Wide Eyed Bunny
			table.insert(questTargets, 3022) --Downer Bunny
			table.insert(questTargets, 3023) --Chaotic Hare
			table.insert(questTargets, 3024) --Awakened Rabbit
		end

		if player.level >= 103 then --Crypt 22
			table.insert(questTargets, 1436) --Enraged Hermit
		end

		if player.level >= 105 then --Critter Crawlspace / Crypt 23 / Arctic Snow
			table.insert(questTargets, 3031) --Barry The Giant Sea Worm
			table.insert(questTargets, 3032) --Roger The Troll
			table.insert(questTargets, 3033) --Wallace The Walrus
			table.insert(questTargets, 3034) --Frank the Gruesome

			table.insert(questTargets, 1437) --Lost Tribesman

			table.insert(questTargets, 4035) --Snow Ogre
			table.insert(questTargets, 4036) --Snow King
		end

		if player.level >= 107 then --Crypt 24
			table.insert(questTargets, 1438) --Deep Hunter
		end

		if player.level >= 109 then --Lortz Plantation / Crypt 25
			table.insert(questTargets, 3041) --Leaf Sprout
			table.insert(questTargets, 3042) --Fire Sprout
			table.insert(questTargets, 3043) --Mud Sprout
			table.insert(questTargets, 3044) --Fly Trapper
			table.insert(questTargets, 3045) --Perry The Corpse Flower

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
		table.insert(questTargets, 4007) --Living Armor
		table.insert(questTargets, 4008) --The Icy Duke
		table.insert(questTargets, 4009) --The Frozen Maiden
		table.insert(questTargets, 4010) --The Obsidian Guard
		table.insert(questTargets, 4011) --The Frozen King
	end]] if
			player.level >= 110
		 then --Arctic Sleet
			table.insert(questTargets, 4035) --Sleet Ogre
			table.insert(questTargets, 4036) --Sleet King
		end

		if player.level >= 112 then --Occupied Cave
			table.insert(questTargets, 3051) --Kulu Dweller
			table.insert(questTargets, 3052) --Great Ape
			table.insert(questTargets, 3053) --Alpha Ape
			table.insert(questTargets, 3054) --Mike Rustation
		end

		if player.level >= 115 then --Arctic Hail
			table.insert(questTargets, 4039) --Hail Ogre
			table.insert(questTargets, 4040) --Hail King
		end

		if player.level >= 116 then --Bear Cave
			table.insert(questTargets, 3061) --Baby Bear
			table.insert(questTargets, 3062) --Brother Bear
			table.insert(questTargets, 3063) --Momma Bear
			table.insert(questTargets, 3064) --Pappa bear
			table.insert(questTargets, 3065) --Mor'du
		end

		if player.level >= 118 then --Robber's Lair
			table.insert(questTargets, 2081) --Ugly Thief
			table.insert(questTargets, 2082) --Kulu Thief
			table.insert(questTargets, 2083) --Brute Thief
			table.insert(questTargets, 2084) --Hugo
		end
		 --

		--[[if player.level >= 120 then --Dragon Den
		table.insert(questTargets, 3071) --Wyrmling
		table.insert(questTargets, 3072) --Adult Wyrm
		table.insert(questTargets, 3073) --Mature Adult Wyrm
		table.insert(questTargets, 3074) --Mighty Dragon
		table.insert(questTargets, 3075) --Ancient Wyrm
	end]] if
			player.level >= 120
		 then --Arctic Flurry
			table.insert(questTargets, 4041) --Flurry Ogre
			table.insert(questTargets, 4042) --Flurry King
		end

		if player.level >= 123 then --Pig Sty
			table.insert(questTargets, 3081) --Piglet
			table.insert(questTargets, 3082) --Big Pig
			table.insert(questTargets, 3083) --Fat Pig
			table.insert(questTargets, 3084) --Black Oxen
			table.insert(questTargets, 3085) --Striped Oxen
			table.insert(questTargets, 3086) --Napoleon
		end

		if player.level >= 125 then --Grim Barrens
			table.insert(questTargets, 3091) --Grim Ogre
			table.insert(questTargets, 3092) --Southern Ogre
			table.insert(questTargets, 3093) --Muck Ogre
			table.insert(questTargets, 3094) --Slime Ogre
			table.insert(questTargets, 3095) --Log
			table.insert(questTargets, 3096) --Hill Ogre
		end

		if player.level >= 125 then --Arctic Blizzard
			table.insert(questTargets, 4043) --Blizzard Ogre
			table.insert(questTargets, 4044) --Blizzard King
		end

		--	if player.level >= 125 then --Ice Palace 2
		--		table.insert(questTargets, ) --
		--		table.insert(questTargets, ) --
		--		table.insert(questTargets, ) --
		--	end

		if player.level >= 130 then --Arctic Avalanche
			table.insert(questTargets, 4045) --Avalanche Ogre
			table.insert(questTargets, 4046) --Avalanche King
		end

		if player.level >= 135 then --Arctic Tempest
			table.insert(questTargets, 4047) --Tempest Ogre
			table.insert(questTargets, 4048) --Tempest King
		end

		if player.level >= 140 then --Arctic Cyclone
			table.insert(questTargets, 4049) --Cyclone Ogre
			table.insert(questTargets, 4050) --Cyclone King
		end

		if player.level >= 145 then --Arctic Elders
			table.insert(questTargets, 4051) --Elder Ogre
			table.insert(questTargets, 4052) --Elderly King
		end

		if #questTargets > 0 then
			local r = math.random(1, #questTargets)
			finalQuestTarget = questTargets[r]
		end
		 --

		--FORCE A TARGET FOR GM TESTING
		--[[	
	if player.ID == 4 then 
		finalQuestTarget =  
	end
]] return finalQuestTarget
	end,
	nearbyPlayers = function(npc)
		local pc = npc:getObjectsInArea(BL_PC)
		local m, x, y = npc.m, npc.x, npc.y

		if #pc > 0 then
			for i = 1, #pc do
				if pc[i].level >= 5 and pc[i].registry["dailyq_hon_bartender_timer"] < os.time() then
					pc[i]:selfAnimationXY(pc[i].ID, 248, x, y)
				end
			end
		end
	end
}
