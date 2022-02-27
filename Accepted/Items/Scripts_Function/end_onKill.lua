end_onKill = function(block, player)

	local group = player.group
	local member
	local bountyMob = 0
	local mobsNeeded = 0
	local bountyGhost = 0
	local ghostsNeeded = 0
	local bountyMobName = ""
	local bountyGhostName = ""	

	if block.blType == BL_MOB then

	--LEECH LORD----------------------------------------------------------------------------------------------------------

		if #group >= 0 then													-- if you are in group
			for i = 1, #group do
				if Player(group[i]) ~= nil then member = Player(group[i])
					if member.m == player.m then							-- if in a same map
						if member.state ~= 1 then							-- if not dead
							if member.afk == false then						-- if not afk
								if block.mobID == 1065 then leechLordCount = member:killCount(1065)
									if member.quest["leech_lord"] == 1 then 
										if leechlordCount >= 1 then
											member:msg(4, "Leech Lord ("..leechlordCount.."/1) [Quest updated] Return to your Guild.", member.ID)
										end
									end
								end
							end
						end
					end
				end
			end
		end
--MENTOK---------------------------------------------------------------------------------------------------------------

		if #group >= 0 then													-- if you are in group
			for i = 1, #group do
				if Player(group[i]) ~= nil then member = Player(group[i])
					if member.m == player.m then							-- if in a same map
						if member.state ~= 1 then							-- if not dead
							if member.afk == false then						-- if not afk
								if block.mobID == 1034 then mentokCount = member:killCount(1034)	-- if mobId mob you kill is 25
									if member.quest["haunted_house"] == 1 then					-- if haunted house value is 1 
										if mentokCount >= 1 then								-- check how many mentok you kill
											member:msg(4, "Mentok ("..mentokCount.."/1) [Quest updated] Return to Harvey.", member.ID)
										end
									end
								end
							end
						end
					end
				end
			end
		end
		
--BAT QUEST----------------------------------------------------------------------------------------------------------

		if #group >= 0 then													
			for i = 1, #group do
				if Player(group[i]) ~= nil then member = Player(group[i])
					if member.m == player.m then							
						if member.state ~= 1 then						
							if member.afk == false then					
								if block.mobID == 1041 then fatbatCount = member:killCount(1041)
									if member.quest["martin"] == 1 then				
										if fatbatCount >= 1 and fatbatCount < 51 then							
											member:sendMinitext("Smirking Bat ("..fatbatCount.."/50)", member.ID)
										end
									end
								end
							end
						end
					end
				end
			end
		end
		
		if #group >= 0 then												
			for i = 1, #group do
				if Player(group[i]) ~= nil then member = Player(group[i])
					if member.m == player.m then						
						if member.state ~= 1 then						
							if member.afk == false then					
								if block.mobID == 1042 then littlebatCount = member:killCount(1042)
									if member.quest["martin"] == 1 then					 
										if littlebatCount >= 1 and littlebatCount < 51 then							
											member:sendMinitext("Overconfident Bat ("..littlebatCount.."/50)", member.ID)
										end
									end
								end
							end
						end
					end
				end
			end
		end
		
		if #group >= 0 then												
			for i = 1, #group do
				if Player(group[i]) ~= nil then member = Player(group[i])
					if member.m == player.m then						
						if member.state ~= 1 then						
							if member.afk == false then					
								if block.mobID == 1043 then bigbatCount = member:killCount(1043)
									if member.quest["martin"] == 1 then				
										if bigbatCount >= 1 and bigbatCount < 2 then						
											member:sendMinitext("Deceitfully Cute Bat ("..bigbatCount.."/1)", member.ID)
										end
									end
								end
							end
						end
					end
				end
			end
		end
--SAVAGE TERRITORY QUEST----------------------------------------------------------------------------------------------------------

		if #group >= 0 then												
			for i = 1, #group do
				if Player(group[i]) ~= nil then member = Player(group[i])
					if member.m == player.m then						
						if member.state ~= 1 then						
							if member.afk == false then					
								if block.mobID == 1301 then savageCount1 = member:killCount(1301)
									if member.quest["front_lines"] == 1 then				
										if savageCount1 >= 1 and savageCount1 < 51 then						
											member:sendMinitext(""..block.name..": ("..savageCount1 .."/50)", member.ID)
										end
									end
								end
							end
						end
					end
				end
			end
		end
		if #group >= 0 then												
			for i = 1, #group do
				if Player(group[i]) ~= nil then member = Player(group[i])
					if member.m == player.m then						
						if member.state ~= 1 then						
							if member.afk == false then					
								if block.mobID == 1302 then savageCount2 = member:killCount(1302)
									if member.quest["front_lines"] == 1 then				
										if savageCount2 >= 1 and savageCount2 < 51 then						
											member:sendMinitext(""..block.name..": ("..savageCount2 .."/50)", member.ID)
										end
									end
								end
							end
						end
					end
				end
			end
		end
		if #group >= 0 then												
			for i = 1, #group do
				if Player(group[i]) ~= nil then member = Player(group[i])
					if member.m == player.m then						
						if member.state ~= 1 then						
							if member.afk == false then					
								if block.mobID == 1303 then savageCount3 = member:killCount(1303)
									if member.quest["front_lines"] == 1 then				
										if savageCount1 >= 3 and savageCount3 < 51 then						
											member:sendMinitext(""..block.name..": ("..savageCount3 .."/50)", member.ID)
										end
									end
								end
							end
						end
					end
				end
			end
		end
		if #group >= 0 then												
			for i = 1, #group do
				if Player(group[i]) ~= nil then member = Player(group[i])
					if member.m == player.m then						
						if member.state ~= 1 then						
							if member.afk == false then					
								if block.mobID == 1304 then savageCount4 = member:killCount(1304)
									if member.quest["front_lines"] == 1 then				
										if savageCount4 >= 1 and savageCount4 < 2 then						
											member:sendMinitext(""..block.name..": ("..savageCount4 .."/1)", member.ID)
										end
									end
								end
							end
						end
					end
				end
			end
		end
--OGRE QUEST----------------------------------------------------------------------------------------------------------

		if #group >= 0 then												
			for i = 1, #group do
				if Player(group[i]) ~= nil then member = Player(group[i])
					if member.m == player.m then						
						if member.state ~= 1 then						
							if member.afk == false then					
								if block.mobID == 3001 then ogreCount = (member:killCount(3001)	+ member:killCount(3002))	
									if member.quest["ogre_hunt"] == 1 or member.quest["daily_ogre_hunt"] == 1 then				
										if ogreCount >= 1 and ogreCount < 151 then						
											member:sendMinitext("Ogres slain: ("..ogreCount.."/150)", member.ID)
										end
									end
								end
							end
						end
					end
				end
			end
		end
		if #group >= 0 then												
			for i = 1, #group do
				if Player(group[i]) ~= nil then member = Player(group[i])
					if member.m == player.m then						
						if member.state ~= 1 then						
							if member.afk == false then					
								if block.mobID == 3002 then ogreCount = (member:killCount(3001)	+ member:killCount(3002))
									if member.quest["ogre_hunt"] == 1 or member.quest["daily_ogre_hunt"] == 1 then			
										if ogreCount >= 1 and ogreCount < 151 then						
											member:sendMinitext("Ogres slain: ("..ogreCount.."/150)", member.ID)
										end
									end
								end
							end
						end
					end
				end
			end
		end
		
--Trial of Endurance----------------------------------------------------------------------------------------------------------

		if #group >= 0 then													
			for i = 1, #group do
				if Player(group[i]) ~= nil then member = Player(group[i])
					if member.m == player.m then							
						if member.state ~= 1 then						
							if member.afk == false then					
								if block.mobID == 2065 then blackStrikeGatorCount = member:killCount(2065)
									if member.quest["level100endurance"] == 3 then				
										if blackStrikeGatorCount >= 1 and blackStrikeGatorCount < 51 then							
											member:sendMinitext("Blackstrike Gator: ("..blackStrikeGatorCount.."/50)", member.ID)
										end
									end
								end
							end
						end
					end
				end
			end
		end
		
		if #group >= 0 then												
			for i = 1, #group do
				if Player(group[i]) ~= nil then member = Player(group[i])
					if member.m == player.m then						
						if member.state ~= 1 then						
							if member.afk == false then					
								if block.mobID == 3002 then ogreChampionCount = member:killCount(3002)
									if member.quest["level100endurance"] == 1 then					 
										if ogreChampionCount >= 1 and ogreChampionCount < 101 then							
											member:sendMinitext("Ogre Champion: ("..ogreChampionCount.."/100)", member.ID)
										end
									end
								end
							end
						end
					end
				end
			end
		end
		
		if #group >= 0 then												
			for i = 1, #group do
				if Player(group[i]) ~= nil then member = Player(group[i])
					if member.m == player.m then						
						if member.state ~= 1 then						
							if member.afk == false then					
								if block.mobID == 3013 then elderGargoyleCount = member:killCount(3013)
									if member.quest["level100endurance"] == 2 then				
										if elderGargoyleCount >= 1 and elderGargoyleCount < 101 then						
											member:sendMinitext("Elder Gargoyle: ("..elderGargoyleCount.."/100)", member.ID)
										end
									end
								end
							end
						end
					end
				end
			end
		end




----PATH DAILY KILL-----------------------------------------------------------------------------------------------------------------------------------------------------------
			
		
		if #group >= 0 then												
			for i = 1, #group do
				if Player(group[i]) ~= nil then member = Player(group[i])
					bountyMob = player.quest["dailyq_path_kill"]
					mobsNeeded = player.quest["dailyq_path_kill_count"]
		
			if bounty == 1001 then bountyName = "Sewer Rat" end
			if bounty == 1002 then bountyName = "Large Sewer Rat" end
			if bounty == 1003 then bountyName = "Mutated Sewer Rat" end
			if bounty == 1004 then bountyName = "Sewer Slug" end
			if bounty == 1005 then bountyName = "Mutated Sewer Slug" end
			
			if bounty == 1011 then bountyName = "Worm" end
			if bounty == 1012 then bountyName = "Fire worm" end
			if bounty == 1013 then bountyName = "Earth snake" end
			if bounty == 1014 then bountyName = "Mud snake" end
			if bounty == 1015 then bountyName = "Bandit Initiate" end
			if bounty == 1016 then bountyName = "Bandit Veteran" end
			if bounty == 1017 then bountyName = "Bandit Elite" end
			if bounty == 1018 then bountyName = "War Thog Jr" end
			
			if bounty == 1031 then bountyName = "Girl spirit" end
			if bounty == 1032 then bountyName = "Boy spirit" end
			if bounty == 1033 then bountyName = "Faceless spirit" end
			if bounty == 1034 then bountyName = "Mentok" end
			
			if bounty == 1041 then bountyName = "Smirking Bat" end
			if bounty == 1042 then bountyName = "Overconfident Bat" end
			if bounty == 1043 then bountyName = "Deceitfully Cute bat" end
			
			if bounty == 1051 then bountyName = "Mutated Minnow" end
			if bounty == 1052 then bountyName = "Mutated Bass" end
			if bounty == 1053 then bountyName = "Mutated Goldfish" end
			
			if bounty == 2001 then bountyName = "Tomb Robber" end
			if bounty == 2002 then bountyName = "Scumbag Thief" end
			
			if bounty == 2011 then bountyName = "Young Spider" end
			if bounty == 2012 then bountyName = "Lurking Spider" end
			if bounty == 2013 then bountyName = "Guardian Spider" end
			if bounty == 2014 then bountyName = "Spider Queen" end
			
			if bounty == 1061 then bountyName = "Red Spotted Leech" end
			if bounty == 1062 then bountyName = "Green Striped Leech" end
			if bounty == 1063 then bountyName = "Violent Leech" end
			if bounty == 1064 then bountyName = "Venemous Leech" end
			if bounty == 1065 then bountyName = "Leech Lord" end
			
			if bounty == 2031 then bountyName = "Shipwreck Crate" end
			if bounty == 2032 then bountyName = "Crazed Lobster" end
			if bounty == 2033 then bountyName = "Man o'War" end
			if bounty == 2034 then bountyName = "Possessed Snail" end
						
			if bounty == 2041 then bountyName = "Green Snake" end
			if bounty == 2042 then bountyName = "Swarm of Insects" end
			if bounty == 2043 then bountyName = "Tree Frog" end
			if bounty == 2044 then bountyName = "Swamp Gator" end
			
			if bounty == 2051 then bountyName = "Giant Bug" end
			if bounty == 2052 then bountyName = "Swamp Frog" end
			if bounty == 2053 then bountyName = "Bog Frog" end
			if bounty == 2054 then bountyName = "Disturbed Tree" end
			if bounty == 2055 then bountyName = "Mud Golem" end
			
			if bounty == 2061 then bountyName = "Swamp Slime" end
			if bounty == 2062 then bountyName = "Blackstrike Swarm" end
			if bounty == 2063 then bountyName = "Blackstrike Frog" end
			if bounty == 2064 then bountyName = "Blackstrike Blue Frog" end
			if bounty == 2065 then bountyName = "Blackstrike Gator" end
			
			if bounty == 2071 then bountyName = "Mudman" end
			if bounty == 2072 then bountyName = "Mega Mudman" end

			if bounty == 3001 then bountyName = "Ogre Scout" end
			if bounty == 3002 then bountyName = "Ogre Champion" end
			if bounty == 3003 then bountyName = "Ogre Shaman" end
			
			if bounty == 3011 then bountyName = "Young Gargoyle" end
			if bounty == 3012 then bountyName = "Adult Gargoyle" end
			if bounty == 3013 then bountyName = "Elder Gargoyle" end
			if bounty == 3014 then bountyName = "Malvolia the Vicious" end
			if bounty == 3015 then bountyName = "Andrea the Terrible" end
			
			if bounty == 2021 then bountyName = "Brown Wolf" end	
			if bounty == 2022 then bountyName = "Red Wolf" end
			if bounty == 2023 then bountyName = "Black Wolf" end
			if bounty == 2024 then bountyName = "Dire Wolf" end
			
			if bounty == 1021 then bountyName = "Black Fox" end
			if bounty == 1022 then bountyName = "Red Fox" end
			if bounty == 1023 then bountyName = "Rabid Fox" end
			if bounty == 1024 then bountyName = "Rainbow Fox" end
			if bounty == 1025 then bountyName = "Kumiho" end
			
			if bounty == 1301 then bountyName = "Savage Spearmaiden" end
			if bounty == 1302 then bountyName = "Savage Highwayman" end
			if bounty == 1303 then bountyName = "Savage Stickman" end
			if bounty == 1304 then bountyName = "Savage Warchief" end

			if bounty == 1071 then bountyName = "Earth Worm" end
			if bounty == 1072 then bountyName = "Blood Worm" end
			if bounty == 1073 then bountyName = "Yellow-Bellied Snake" end
			if bounty == 1074 then bountyName = "Blue Racer Snake" end
			if bounty == 1075 then bountyName = "War Thog's Initiate" end
			if bounty == 1076 then bountyName = "War Thog's Veteran" end
			if bounty == 1077 then bountyName = "War Thog's Elite" end
			if bounty == 1078 then bountyName = "War Thog Jr" end

			if bounty == 1101 then bountyName = "Glow Worm" end
			if bounty == 1102 then bountyName = "Lava Worm" end
			if bounty == 1103 then bountyName = "Electric Snake" end
			if bounty == 1104 then bountyName = "Coral Snake" end
			if bounty == 1105 then bountyName = "War Thog's Soldier" end
			if bounty == 1106 then bountyName = "War Thog's Infiltrator" end
			if bounty == 1107 then bountyName = "War Thog's Major" end
			if bounty == 1108 then bountyName = "War Thog Jr" end
			
			if bounty == 1081 then bountyName = "Blue Fox" end
			if bounty == 1082 then bountyName = "Purple Fox" end
			if bounty == 1083 then bountyName = "White Fox" end
			if bounty == 1084 then bountyName = "Painted Fox" end
			if bounty == 1085 then bountyName = "Blue Kumiho" end
			
			if bounty == 1121 then bountyName = "Swamp Fox" end
			if bounty == 1122 then bountyName = "River Fox" end
			if bounty == 1123 then bountyName = "Mountain Fox" end
			if bounty == 1124 then bountyName = "Shadow Fox" end
			if bounty == 1125 then bountyName = "Black Kumiho" end
			
			if bounty == 1091 then bountyName = "Chilled Spirit" end
			if bounty == 1092 then bountyName = "Pale Spirit" end
			if bounty == 1093 then bountyName = "Wavering Spirit" end
			if bounty == 1094 then bountyName = "Chilled Mentok" end
			
			if bounty == 1131 then bountyName = "Frantic Spirit" end
			if bounty == 1132 then bountyName = "Anxious Spirit" end
			if bounty == 1133 then bountyName = "Tainted Spirit" end
			if bounty == 1134 then bountyName = "Mentok the Mind Taker" end
			
			if bounty == 1101 then bountyName = "Sea Bat" end
			if bounty == 1102 then bountyName = "Cave Bat" end
			if bounty == 1103 then bountyName = "Confident Bat" end
			
			if bounty == 1141 then bountyName = "Grinning Bat" end
			if bounty == 1142 then bountyName = "Luminescent Bat" end
			if bounty == 1143 then bountyName = "Dragon Bat" end

			if bounty == 1151 then bountyName = "Angry Caterpillar" end
			if bounty == 1152 then bountyName = "Giant Spider" end
			if bounty == 1153 then bountyName = "Chill Caterpillar" end
			if bounty == 1154 then bountyName = "Lazy Tick" end
			if bounty == 1155 then bountyName = "Weak Homunculus" end
			if bounty == 1156 then bountyName = "Misanthropic Wizard" end
			if bounty == 1157 then bountyName = "Evil Homunculus" end
			if bounty == 1158 then bountyName = "Evil Wizard" end
			if bounty == 1159 then bountyName = "Seer's Apprentice" end
			if bounty == 1160 then bountyName = "Faceless Seer" end
			if bounty == 1161 then bountyName = "Overseer's Student" end
			if bounty == 1162 then bountyName = "High Overseer" end
			if bounty == 1163 then bountyName = "Q" end
			if bounty == 1164 then bountyName = "Dragoon" end
			if bounty == 1165 then bountyName = "Li" end
			if bounty == 1166 then bountyName = "Fenix Dragoon" end
			if bounty == 1167 then bountyName = "Puu" end
			if bounty == 1168 then bountyName = "Annoying Construct" end
			if bounty == 1169 then bountyName = "Muckman" end
			if bounty == 1170 then bountyName = "Enraged Construct" end

			if bounty == 2081 then bountyName = "Ugly Thief" end
			if bounty == 2082 then bountyName = "Kulu Thief" end
			if bounty == 2083 then bountyName = "Brute Thief" end
			if bounty == 2084 then bountyName = "Hugo" end
			
			--if bounty == 4031 then bountyName = "Snow Rabbit" end
			--if bounty == 4032 then bountyName = "Arctic Deer" end
			--if bounty == 4033 then bountyName = "Slush Ogre" end
			--if bounty == 4034 then bountyName = "Slush King" end
			--
			--if bounty == 4035 then bountyName = "Snow Ogre" end
			--if bounty == 4036 then bountyName = "Snow King" end
			--
			--if bounty == 4037 then bountyName = "Sleet Ogre" end
			--if bounty == 4038 then bountyName = "Sleet King" end
			--
			--if bounty == 4039 then bountyName = "Hail Ogre" end
			--if bounty == 4040 then bountyName = "Hail King" end
			--
			--if bounty == 4041 then bountyName = "Flurry Ogre" end
			--if bounty == 4042 then bountyName = "Flurry King" end
			--
			--if bounty == 4043 then bountyName = "Blizzard Ogre" end
			--if bounty == 4044 then bountyName = "Blizzard King" end
			--
			--if bounty == 4045 then bountyName = "Avalanche Ogre" end
			--if bounty == 4046 then bountyName = "Avalanche King" end
			--
			--if bounty == 4047 then bountyName = "Tempest Ogre" end
			--if bounty == 4048 then bountyName = "Tempest King" end
			--
			--if bounty == 4049 then bountyName = "Cyclone Ogre" end
			--if bounty == 4050 then bountyName = "Cyclone King" end
			--
			--if bounty == 4051 then bountyName = "Elder Ogre" end
			--if bounty == 4052 then bountyName = "Elderly King" end
			
			if bounty == 3021 then bountyName = "Wide Eyed Bunny" end
			if bounty == 3022 then bountyName = "Downer Bunny" end
			if bounty == 3023 then bountyName = "Chaotic Hare" end
			if bounty == 3024 then bountyName = "Awakened Rabbit" end
			
			if bounty == 3031 then bountyName = "Barry The Giant Sea Worm" end
			if bounty == 3032 then bountyName = "Roger The Troll" end
			if bounty == 3033 then bountyName = "Wallace The Walrus" end
			if bounty == 3034 then bountyName = "Frank the Gruesome" end
			
			if bounty == 3041 then bountyName = "Leaf Sprout" end
			if bounty == 3042 then bountyName = "Fire Sprout" end
			if bounty == 3043 then bountyName = "Mud Sprout" end
			if bounty == 3044 then bountyName = "Fly Trapper" end
			if bounty == 3045 then bountyName = "Perry The Corpse Flower" end
			
			if bounty == 3051 then bountyName = "Kulu Dweller" end
			if bounty == 3052 then bountyName = "Great Ape" end
			if bounty == 3053 then bountyName = "Alpha Ape" end
			if bounty == 3054 then bountyName = "Mike Rustation" end
			
			if bounty == 3061 then bountyName = "Baby Bear" end
			if bounty == 3062 then bountyName = "Brother Bear" end
			if bounty == 3063 then bountyName = "Momma Bear" end
			if bounty == 3064 then bountyName = "Pappa bear" end
			if bounty == 3065 then bountyName = "Mor'du" end
			
			if bounty == 3071 then bountyName = "Wyrmling" end
			if bounty == 3072 then bountyName = "Adult Wyrm" end
			if bounty == 3073 then bountyName = "Mature Adult Wyrm" end
			if bounty == 3074 then bountyName = "Mighty Dragon" end
			if bounty == 3075 then bountyName = "Ancient Wyrm" end
			
			if bounty == 3081 then bountyName = "Piglet" end
			if bounty == 3082 then bountyName = "Big Pig" end
			if bounty == 3083 then bountyName = "Fat Pig" end
			if bounty == 3084 then bountyName = "Black Oxen" end
			if bounty == 3085 then bountyName = "Striped Oxen" end
			if bounty == 3086 then bountyName = "Napoleon" end
			
			if bounty == 3091 then bountyName = "Grim Ogre" end
			if bounty == 3092 then bountyName = "Southern Ogre" end
			if bounty == 3093 then bountyName = "Muck Ogre" end
			if bounty == 3094 then bountyName = "Slime Ogre" end
			if bounty == 3095 then bountyName = "Log" end
			if bounty == 3096 then bountyName = "Hill Ogre" end
			
			--if bounty == 4001 then bountyName = "Ice Wraith" end
			--if bounty == 4002 then bountyName = "Ice Archer" end
			--if bounty == 4003 then bountyName = "Ice Mage" end
			--if bounty == 4004 then bountyName = "Frozen Assassin" end
			--if bounty == 4005 then bountyName = "Frozen Fighter" end
			--if bounty == 4006 then bountyName = "Frozen Summoner" end
			--if bounty == 4007 then bountyName = "Living Armor" end
			--if bounty == 4008 then bountyName = "The Icy Duke" end
			--if bounty == 4009 then bountyName = "The Frozen Maiden" end
			--if bounty == 4010 then bountyName = "The Obsidian Guard" end
			--if bounty == 4011 then bountyName = "The Frozen King" end
				
				
					if member.m == player.m then						
						if member.state ~= 1 then						
							if member.afk == false then	
								if block.mobID == bountyMob then mobCount = member:killCount(bountyMob)
									if bountyMob > 0 then			
										if mobCount >= 1 and mobCount <= mobsNeeded then						
											member:sendMinitext(bountyMobName.." slain: ("..mobCount.."/"..mobsNeeded..")", member.ID)
										end
									end
								end
							end
						end
					end
				end
			end
		end
		
		
----HON BARTENDER DAILY KILL-----------------------------------------------------------------------------------------------------------------------------------------------------------
			
		
		if #group >= 0 then												
			for i = 1, #group do
				if Player(group[i]) ~= nil then member = Player(group[i])
					bountyMob = member.quest["dailyq_hon_bartender"]
					mobsNeeded = 1
		
					if bountyMob == 1001 then bountyMobName = "Sewer Rat" end
					if bountyMob == 1002 then bountyMobName = "Large Sewer Rat" end
					if bountyMob == 1003 then bountyMobName = "Mutated Sewer Rat" end
					if bountyMob == 1004 then bountyMobName = "Sewer Slug" end
					if bountyMob == 1005 then bountyMobName = "Mutated Sewer Slug" end
					
					if bountyMob == 1011 then bountyMobName = "Worm" end
					if bountyMob == 1012 then bountyMobName = "Fire worm" end
					if bountyMob == 1013 then bountyMobName = "Earth snake" end
					if bountyMob == 1014 then bountyMobName = "Mud snake" end
					if bountyMob == 1015 then bountyMobName = "Bandit Initiate" end
					if bountyMob == 1016 then bountyMobName = "Bandit Veteran" end
					if bountyMob == 1017 then bountyMobName = "Bandit Elite" end
					if bountyMob == 1018 then bountyMobName = "War Thog Jr" end
					
					if bountyMob == 1031 then bountyMobName = "Girl spirit" end
					if bountyMob == 1032 then bountyMobName = "Boy spirit" end
					if bountyMob == 1033 then bountyMobName = "Faceless spirit" end
					if bountyMob == 1034 then bountyMobName = "Mentok" end
					
					if bountyMob == 1041 then bountyMobName = "Smirking Bat" end
					if bountyMob == 1042 then bountyMobName = "Overconfident Bat" end
					if bountyMob == 1043 then bountyMobName = "Deceitfully Cute bat" end
					
					if bountyMob == 1051 then bountyMobName = "Mutated Minnow" end
					if bountyMob == 1052 then bountyMobName = "Mutated Bass" end
					if bountyMob == 1053 then bountyMobName = "Mutated Goldfish" end
					
					if bountyMob == 2001 then bountyMobName = "Tomb Robber" end
					if bountyMob == 2002 then bountyMobName = "Scumbag Thief" end
					
					if bountyMob == 2011 then bountyMobName = "Young Spider" end
					if bountyMob == 2012 then bountyMobName = "Lurking Spider" end
					if bountyMob == 2013 then bountyMobName = "Guardian Spider" end
					if bountyMob == 2014 then bountyMobName = "Spider Queen" end
					
					if bountyMob == 1061 then bountyMobName = "Red Spotted Leech" end
					if bountyMob == 1062 then bountyMobName = "Green Striped Leech" end
					if bountyMob == 1063 then bountyMobName = "Violent Leech" end
					if bountyMob == 1064 then bountyMobName = "Venemous Leech" end
					if bountyMob == 1065 then bountyMobName = "Leech Lord" end
					
					if bountyMob == 2031 then bountyMobName = "Shipwreck Crate" end
					if bountyMob == 2032 then bountyMobName = "Crazed Lobster" end
					if bountyMob == 2033 then bountyMobName = "Man o'War" end
					if bountyMob == 2034 then bountyMobName = "Possessed Snail" end
								
					if bountyMob == 2041 then bountyMobName = "Green Snake" end
					if bountyMob == 2042 then bountyMobName = "Swarm of Insects" end
					if bountyMob == 2043 then bountyMobName = "Tree Frog" end
					if bountyMob == 2044 then bountyMobName = "Swamp Gator" end
					
					if bountyMob == 2051 then bountyMobName = "Giant Bug" end
					if bountyMob == 2052 then bountyMobName = "Swamp Frog" end
					if bountyMob == 2053 then bountyMobName = "Bog Frog" end
					if bountyMob == 2054 then bountyMobName = "Disturbed Tree" end
					if bountyMob == 2055 then bountyMobName = "Mud Golem" end
					
					if bountyMob == 2061 then bountyMobName = "Swamp Slime" end
					if bountyMob == 2062 then bountyMobName = "Blackstrike Swarm" end
					if bountyMob == 2063 then bountyMobName = "Blackstrike Frog" end
					if bountyMob == 2064 then bountyMobName = "Blackstrike Blue Frog" end
					if bountyMob == 2065 then bountyMobName = "Blackstrike Gator" end
					
					if bountyMob == 2071 then bountyMobName = "Mudman" end
					if bountyMob == 2072 then bountyMobName = "Mega Mudman" end
		
					if bountyMob == 3001 then bountyMobName = "Ogre Scout" end
					if bountyMob == 3002 then bountyMobName = "Ogre Champion" end
					if bountyMob == 3003 then bountyMobName = "Ogre Shaman" end
					
					if bountyMob == 3011 then bountyMobName = "Young Gargoyle" end
					if bountyMob == 3012 then bountyMobName = "Adult Gargoyle" end
					if bountyMob == 3013 then bountyMobName = "Elder Gargoyle" end
					if bountyMob == 3014 then bountyMobName = "Malvolia the Vicious" end
					if bountyMob == 3015 then bountyMobName = "Andrea the Terrible" end
					
					if bountyMob == 2021 then bountyMobName = "Brown Wolf" end	
					if bountyMob == 2022 then bountyMobName = "Red Wolf" end
					if bountyMob == 2023 then bountyMobName = "Black Wolf" end
					if bountyMob == 2024 then bountyMobName = "Dire Wolf" end
					
					if bountyMob == 1021 then bountyMobName = "Black Fox" end
					if bountyMob == 1022 then bountyMobName = "Red Fox" end
					if bountyMob == 1023 then bountyMobName = "Rabid Fox" end
					if bountyMob == 1024 then bountyMobName = "Rainbow Fox" end
					if bountyMob == 1025 then bountyMobName = "Kumiho" end
					
					if bountyMob == 1301 then bountyMobName = "Savage Spearmaiden" end
					if bountyMob == 1302 then bountyMobName = "Savage Highwayman" end
					if bountyMob == 1303 then bountyMobName = "Savage Stickman" end
					if bountyMob == 1304 then bountyMobName = "Savage Warchief" end
		
					if bountyMob == 1071 then bountyMobName = "Earth Worm" end
					if bountyMob == 1072 then bountyMobName = "Blood Worm" end
					if bountyMob == 1073 then bountyMobName = "Yellow-Bellied Snake" end
					if bountyMob == 1074 then bountyMobName = "Blue Racer Snake" end
					if bountyMob == 1075 then bountyMobName = "War Thog's Initiate" end
					if bountyMob == 1076 then bountyMobName = "War Thog's Veteran" end
					if bountyMob == 1077 then bountyMobName = "War Thog's Elite" end
					if bountyMob == 1078 then bountyMobName = "War Thog Jr" end
		
					if bountyMob == 1101 then bountyMobName = "Glow Worm" end
					if bountyMob == 1102 then bountyMobName = "Lava Worm" end
					if bountyMob == 1103 then bountyMobName = "Electric Snake" end
					if bountyMob == 1104 then bountyMobName = "Coral Snake" end
					if bountyMob == 1105 then bountyMobName = "War Thog's Soldier" end
					if bountyMob == 1106 then bountyMobName = "War Thog's Infiltrator" end
					if bountyMob == 1107 then bountyMobName = "War Thog's Major" end
					if bountyMob == 1108 then bountyMobName = "War Thog Jr" end
					
					if bountyMob == 1081 then bountyMobName = "Blue Fox" end
					if bountyMob == 1082 then bountyMobName = "Purple Fox" end
					if bountyMob == 1083 then bountyMobName = "White Fox" end
					if bountyMob == 1084 then bountyMobName = "Painted Fox" end
					if bountyMob == 1085 then bountyMobName = "Blue Kumiho" end
					
					if bountyMob == 1121 then bountyMobName = "Swamp Fox" end
					if bountyMob == 1122 then bountyMobName = "River Fox" end
					if bountyMob == 1123 then bountyMobName = "Mountain Fox" end
					if bountyMob == 1124 then bountyMobName = "Shadow Fox" end
					if bountyMob == 1125 then bountyMobName = "Black Kumiho" end
					
					if bountyMob == 1091 then bountyMobName = "Chilled Spirit" end
					if bountyMob == 1092 then bountyMobName = "Pale Spirit" end
					if bountyMob == 1093 then bountyMobName = "Wavering Spirit" end
					if bountyMob == 1094 then bountyMobName = "Chilled Mentok" end
					
					if bountyMob == 1131 then bountyMobName = "Frantic Spirit" end
					if bountyMob == 1132 then bountyMobName = "Anxious Spirit" end
					if bountyMob == 1133 then bountyMobName = "Tainted Spirit" end
					if bountyMob == 1134 then bountyMobName = "Mentok the Mind Taker" end
					
					if bountyMob == 1101 then bountyMobName = "Sea Bat" end
					if bountyMob == 1102 then bountyMobName = "Cave Bat" end
					if bountyMob == 1103 then bountyMobName = "Confident Bat" end
					
					if bountyMob == 1141 then bountyMobName = "Grinning Bat" end
					if bountyMob == 1142 then bountyMobName = "Luminescent Bat" end
					if bountyMob == 1143 then bountyMobName = "Dragon Bat" end
		
					if bountyMob == 1151 then bountyMobName = "Angry Caterpillar" end
					if bountyMob == 1152 then bountyMobName = "Giant Spider" end
					if bountyMob == 1153 then bountyMobName = "Chill Caterpillar" end
					if bountyMob == 1154 then bountyMobName = "Lazy Tick" end
					if bountyMob == 1155 then bountyMobName = "Weak Homunculus" end
					if bountyMob == 1156 then bountyMobName = "Misanthropic Wizard" end
					if bountyMob == 1157 then bountyMobName = "Evil Homunculus" end
					if bountyMob == 1158 then bountyMobName = "Evil Wizard" end
					if bountyMob == 1159 then bountyMobName = "Seer's Apprentice" end
					if bountyMob == 1160 then bountyMobName = "Faceless Seer" end
					if bountyMob == 1161 then bountyMobName = "Overseer's Student" end
					if bountyMob == 1162 then bountyMobName = "High Overseer" end
					if bountyMob == 1163 then bountyMobName = "Q" end
					if bountyMob == 1164 then bountyMobName = "Dragoon" end
					if bountyMob == 1165 then bountyMobName = "Li" end
					if bountyMob == 1166 then bountyMobName = "Fenix Dragoon" end
					if bountyMob == 1167 then bountyMobName = "Puu" end
					if bountyMob == 1168 then bountyMobName = "Annoying Construct" end
					if bountyMob == 1169 then bountyMobName = "Muckman" end
					if bountyMob == 1170 then bountyMobName = "Enraged Construct" end
		
					if bountyMob == 2081 then bountyMobName = "Ugly Thief" end
					if bountyMob == 2082 then bountyMobName = "Kulu Thief" end
					if bountyMob == 2083 then bountyMobName = "Brute Thief" end
					if bountyMob == 2084 then bountyMobName = "Hugo" end
					
					--if bountyMob == 4031 then bountyMobName = "Snow Rabbit" end
					--if bountyMob == 4032 then bountyMobName = "Arctic Deer" end
					--if bountyMob == 4033 then bountyMobName = "Slush Ogre" end
					--if bountyMob == 4034 then bountyMobName = "Slush King" end
					--
					--if bountyMob == 4035 then bountyMobName = "Snow Ogre" end
					--if bountyMob == 4036 then bountyMobName = "Snow King" end
					--
					--if bountyMob == 4037 then bountyMobName = "Sleet Ogre" end
					--if bountyMob == 4038 then bountyMobName = "Sleet King" end
					--
					--if bountyMob == 4039 then bountyMobName = "Hail Ogre" end
					--if bountyMob == 4040 then bountyMobName = "Hail King" end
					--
					--if bountyMob == 4041 then bountyMobName = "Flurry Ogre" end
					--if bountyMob == 4042 then bountyMobName = "Flurry King" end
					--
					--if bountyMob == 4043 then bountyMobName = "Blizzard Ogre" end
					--if bountyMob == 4044 then bountyMobName = "Blizzard King" end
					--
					--if bountyMob == 4045 then bountyMobName = "Avalanche Ogre" end
					--if bountyMob == 4046 then bountyMobName = "Avalanche King" end
					--
					--if bountyMob == 4047 then bountyMobName = "Tempest Ogre" end
					--if bountyMob == 4048 then bountyMobName = "Tempest King" end
					--
					--if bountyMob == 4049 then bountyMobName = "Cyclone Ogre" end
					--if bountyMob == 4050 then bountyMobName = "Cyclone King" end
					--
					--if bountyMob == 4051 then bountyMobName = "Elder Ogre" end
					--if bountyMob == 4052 then bountyMobName = "Elderly King" end
					
					if bountyMob == 3021 then bountyMobName = "Wide Eyed Bunny" end
					if bountyMob == 3022 then bountyMobName = "Downer Bunny" end
					if bountyMob == 3023 then bountyMobName = "Chaotic Hare" end
					if bountyMob == 3024 then bountyMobName = "Awakened Rabbit" end
					
					if bountyMob == 3031 then bountyMobName = "Barry The Giant Sea Worm" end
					if bountyMob == 3032 then bountyMobName = "Roger The Troll" end
					if bountyMob == 3033 then bountyMobName = "Wallace The Walrus" end
					if bountyMob == 3034 then bountyMobName = "Frank the Gruesome" end
					
					if bountyMob == 3041 then bountyMobName = "Leaf Sprout" end
					if bountyMob == 3042 then bountyMobName = "Fire Sprout" end
					if bountyMob == 3043 then bountyMobName = "Mud Sprout" end
					if bountyMob == 3044 then bountyMobName = "Fly Trapper" end
					if bountyMob == 3045 then bountyMobName = "Perry The Corpse Flower" end
					
					if bountyMob == 3051 then bountyMobName = "Kulu Dweller" end
					if bountyMob == 3052 then bountyMobName = "Great Ape" end
					if bountyMob == 3053 then bountyMobName = "Alpha Ape" end
					if bountyMob == 3054 then bountyMobName = "Mike Rustation" end
					
					if bountyMob == 3061 then bountyMobName = "Baby Bear" end
					if bountyMob == 3062 then bountyMobName = "Brother Bear" end
					if bountyMob == 3063 then bountyMobName = "Momma Bear" end
					if bountyMob == 3064 then bountyMobName = "Pappa bear" end
					if bountyMob == 3065 then bountyMobName = "Mor'du" end
					
					if bountyMob == 3071 then bountyMobName = "Wyrmling" end
					if bountyMob == 3072 then bountyMobName = "Adult Wyrm" end
					if bountyMob == 3073 then bountyMobName = "Mature Adult Wyrm" end
					if bountyMob == 3074 then bountyMobName = "Mighty Dragon" end
					if bountyMob == 3075 then bountyMobName = "Ancient Wyrm" end
					
					if bountyMob == 3081 then bountyMobName = "Piglet" end
					if bountyMob == 3082 then bountyMobName = "Big Pig" end
					if bountyMob == 3083 then bountyMobName = "Fat Pig" end
					if bountyMob == 3084 then bountyMobName = "Black Oxen" end
					if bountyMob == 3085 then bountyMobName = "Striped Oxen" end
					if bountyMob == 3086 then bountyMobName = "Napoleon" end
					
					if bountyMob == 3091 then bountyMobName = "Grim Ogre" end
					if bountyMob == 3092 then bountyMobName = "Southern Ogre" end
					if bountyMob == 3093 then bountyMobName = "Muck Ogre" end
					if bountyMob == 3094 then bountyMobName = "Slime Ogre" end
					if bountyMob == 3095 then bountyMobName = "Log" end
					if bountyMob == 3096 then bountyMobName = "Hill Ogre" end
					
					--if bountyMob == 4001 then bountyMobName = "Ice Wraith" end
					--if bountyMob == 4002 then bountyMobName = "Ice Archer" end
					--if bountyMob == 4003 then bountyMobName = "Ice Mage" end
					--if bountyMob == 4004 then bountyMobName = "Frozen Assassin" end
					--if bountyMob == 4005 then bountyMobName = "Frozen Fighter" end
					--if bountyMob == 4006 then bountyMobName = "Frozen Summoner" end
					--if bountyMob == 4007 then bountyMobName = "Living Armor" end
					--if bountyMob == 4008 then bountyMobName = "The Icy Duke" end
					--if bountyMob == 4009 then bountyMobName = "The Frozen Maiden" end
					--if bountyMob == 4010 then bountyMobName = "The Obsidian Guard" end
					--if bountyMob == 4011 then bountyMobName = "The Frozen King" end
				
					if member.m == player.m then						
						if member.state ~= 1 then						
							if member.afk == false then	
								if block.mobID == bountyMob then mobCount = member:killCount(bountyMob)
									if bountyMob > 0 then			
										if mobCount >= 1 and mobCount <= mobsNeeded then						
											member:sendMinitext(bountyMobName.." slain: ("..mobCount.."/"..mobsNeeded..")", member.ID)
										end
									end
								end
							end
						end
					end
				end
			end
		end		
		
----EGONS GHOST HUNT----------------------------------------------------------------------------------------------------------------------------------		

		if #group >= 0 then												
			for i = 1, #group do
				if Player(group[i]) ~= nil then member = Player(group[i])
					bountyGhost = member.registry["ghost_target"]
					ghostsNeeded = member.registry["ghost_target_amount"]
					if bountyGhost == 1031 then bountyGhostName = "Girl spirit" end
					if bountyGhost == 1032 then bountyGhostName = "Boy spirit" end
					if bountyGhost == 1033 then bountyGhostName = "Faceless spirit" end
					if bountyGhost == 1034 then bountyGhostName = "Mentok" end
									
					if bountyGhost == 1091 then bountyGhostName = "Chilled Spirit" end
					if bountyGhost == 1092 then bountyGhostName = "Pale Spirit" end
					if bountyGhost == 1093 then bountyGhostName = "Wavering Spirit" end
					if bountyGhost == 1094 then bountyGhostName = "Chilled Mentok" end
									
					if bountyGhost == 1131 then bountyGhostName = "Frantic Spirit" end
					if bountyGhost == 1132 then bountyGhostName = "Anxious Spirit" end
					if bountyGhost == 1133 then bountyGhostName = "Tainted Spirit" end
					if bountyGhost == 1134 then bountyGhostName = "Mentok the Mind Taker" end
					
					if member.m == player.m then						
						if member.state ~= 1 then						
							if member.afk == false then	
								if block.mobID == bountyGhost then ghostCount = member:killCount(bountyGhost)
									if bountyGhost > 0 then			
										if ghostCount >= 1 and ghostCount <= ghostsNeeded then
											member:sendMinitext(bountyGhostName.." slain: ("..ghostCount.."/"..ghostsNeeded..")", member.ID)
										end
									end
								end
							end
						end
					end
				end
			end
		end
		
		
	elseif block.blType == BL_PC then -- here
		if player.m == 15100 then
			carnage.death(player, block)
		end		
	end
end
