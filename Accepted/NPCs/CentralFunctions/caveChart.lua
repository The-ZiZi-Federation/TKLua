cave_chart = {
	click = function(player, npc)
		local t = {graphic = convertGraphic(1439, "monster"), color = 0}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0

		local opts = {}

		table.insert(opts, "Conquered Caves")
		table.insert(opts, "Current Caves")
		table.insert(opts, "Coming Up Caves")

		menu = player:menuString("<b>[Cave Chart]", opts)

		if menu == "Conquered Caves" then
			cave_chart.conquered(player)
		elseif menu == "Current Caves" then
			cave_chart.current(player)
		elseif menu == "Coming Up Caves" then
			cave_chart.coming(player)
		end
	end,
	-- Conquered Cave Options -------------------------------------------------------------------------------------------------------------------------

	conquered = function(player)
		player.dialogType = 0
		local level = player.level
		local vita = player.baseHealth
		local mana = player.baseMagic
		local conqueredCave = {}

		if level >= 45 then
			table.insert(conqueredCave, "Earthworks 1")
		end

		if level >= 55 then
			table.insert(conqueredCave, "Fox Hole 1")
		end

		if level >= 65 then
			table.insert(conqueredCave, "Haunted House 1")
		end

		if level >= 75 then
			table.insert(conqueredCave, "Bat Sanctum 1")
		end

		if level >= 95 then
			table.insert(conqueredCave, "Earthworks 2")
		end

		if level >= 99 and (vita >= 15000 or mana >= 15000) then
			table.insert(conqueredCave, "Fox Hole 2")
		end

		if level >= 99 and (vita >= 20000 or mana >= 20000) then
			table.insert(conqueredCave, "Haunted House 2")
		end

		if level >= 99 and (vita >= 30000 or mana >= 30000) then
			table.insert(conqueredCave, "Bat Sanctum 2")
		end

		-- Current Cave Selections -------------------------------------------------------------------------------------------------------------------------
		menu = player:menuString("<b>[Conquered Caves]", conqueredCave)

		if menu == "Earthworks 1" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. "You have shown great skill. You can no longer enter Earthworks 1. Level 10 - 44"}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Fox Hole 1" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. "You have shown great skill. You can no longer enter Fox Hole 1. Level 15 - 55"}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Haunted House 1" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq(
				{t, name .. "You have shown great skill. You can no longer enter Haunted House 1. Level 20 - 65"},
				1
			)
			cave_chart.click(player, npc)
		elseif menu == "Bat Sanctum 1" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. "You have shown great skill. You can no longer enter Bat Sanctum 1. Level 20 - 75"}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Earthworks 2" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. "You have shown great skill. You can no longer enter Earthworks 2. Level 45 - 94"}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Fox Hole 2" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq(
				{
					t,
					name .. "You have shown great skill. You can no longer enter Fox Hole 2. Level 55 - 15,000 Base Stat Vita or Mana."
				},
				1
			)
			cave_chart.click(player, npc)
		elseif menu == "Haunted House 2" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq(
				{
					t,
					name ..
						"You have shown great skill. You can no longer enter Haunted House 2. Level 65 - 20,000 Base Stat Vita or Mana."
				},
				1
			)
		elseif menu == "Bat Sanctum 2" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq(
				{
					t,
					name ..
						"You have shown great skill. You can no longer enter Bat Sanctum 2. Level 75 - 30,000 Base Stat Vita or Mana."
				},
				1
			)
			cave_chart.click(player, npc)
		end
	end,
	-- Current Cave Options --------------------------------------------------------------------------------------------------------------

	current = function(player)
		player.dialogType = 0
		local level = player.level
		local vita = player.baseHealth
		local mana = player.baseMagic
		local currentCave = {}

		if level >= 1 then
			table.insert(currentCave, "Honey Comb")
		end

		if level >= 5 then
			table.insert(currentCave, "Sewer Rats")
		end

		if level >= 10 and level <= 44 then
			table.insert(currentCave, "Earthworks 1")
		elseif level >= 45 and level <= 94 then
			table.insert(currentCave, "Earthworks 2")
		elseif level >= 95 then
			table.insert(currentCave, "Earthworks 3")
		end

		if level >= 15 and level <= 54 then
			table.insert(currentCave, "Fox Hole 1")
		elseif level >= 55 and level <= 99 and (vita <= 14999 and mana <= 14999) then
			table.insert(currentCave, "Fox Hole 2")
		elseif level >= 99 and (vita >= 15000 or mana >= 15000) then
			table.insert(currentCave, "Fox Hole 3")
		end

		if level >= 20 and level <= 64 then
			table.insert(currentCave, "Haunted House 1")
		elseif level >= 65 and level <= 99 and (vita <= 19999 and mana <= 19999) then
			table.insert(currentCave, "Haunted House 2")
		elseif level >= 99 and (vita >= 20000 or mana >= 20000) then
			table.insert(currentCave, "Haunted House 3")
		end

		if level >= 20 and level <= 74 then
			table.insert(currentCave, "Bat Sanctum 1")
		elseif level >= 75 and level <= 99 and (vita <= 29999 and mana <= 29999) then
			table.insert(currentCave, "Bat Sanctum 2")
		elseif level >= 99 and (vita >= 30000 or mana >= 30000) then
			table.insert(currentCave, "Bat Sanctum 3")
		end

		if level >= 30 then
			table.insert(currentCave, "Contaminated Cove")
		end

		if level >= 35 then
			table.insert(currentCave, "Savage Territory")
		end

		if level >= 40 then
			table.insert(currentCave, "Leech Pass")
		end

		if level >= 45 and level <= 49 then
			table.insert(currentCave, "Subterranean Cavern 1")
		elseif level >= 50 and level <= 54 then
			table.insert(currentCave, "Subterranean Cavern 2")
		elseif level >= 55 and level <= 59 then
			table.insert(currentCave, "Subterranean Cavern 3")
		elseif level >= 60 and level <= 64 then
			table.insert(currentCave, "Subterranean Cavern 4")
		elseif level >= 65 and level <= 69 then
			table.insert(currentCave, "Subterranean Cavern 5")
		elseif level >= 70 and level <= 74 then
			table.insert(currentCave, "Subterranean Cavern 6")
		elseif level >= 75 and level <= 79 then
			table.insert(currentCave, "Subterranean Cavern 7")
		elseif level >= 80 and level <= 84 then
			table.insert(currentCave, "Subterranean Cavern 8")
		elseif level >= 85 and level <= 89 then
			table.insert(currentCave, "Subterranean Cavern 9")
		elseif level >= 90 then
			table.insert(currentCave, "Subterranean Cavern 10")
		end

		if level >= 50 then
			table.insert(currentCave, "Disturbed Tomb")
		end

		if level >= 60 then
			table.insert(currentCave, "Spider Pit")
		end

		if level >= 70 then
			table.insert(currentCave, "Wolf Den")
		end

		if level >= 80 then
			table.insert(currentCave, "Tonguspur Beach")
			table.insert(currentCave, "Frog Swamp")
		end

		if level >= 85 then
			table.insert(currentCave, "Frog Bog")
		end

		if level >= 90 then
			table.insert(currentCave, "Blackstrike Swamp")
		end

		if level >= 99 then
			table.insert(currentCave, "Lortz Path")
			table.insert(currentCave, "Lortz Mine")
		end

		if level >= 99 and (vita >= 35000 or mana >= 35000) then
			table.insert(currentCave, "Ruins of Bettay")
		end

		if level >= 100 then
			table.insert(currentCave, "Blackstrike Tower")
		end

		if level >= 100 and level <= 104 then
			table.insert(currentCave, "Arctic Ogres 1")
		elseif level >= 105 and level <= 109 then
			table.insert(currentCave, "Arctic Ogres 2")
		elseif level >= 110 and level <= 114 then
			table.insert(currentCave, "Arctic Ogres 3")
		elseif level >= 115 and level <= 119 then
			table.insert(currentCave, "Arctic Ogres 4")
		elseif level >= 120 and level <= 124 then
			table.insert(currentCave, "Arctic Ogres 5")
		elseif level >= 125 and level <= 129 then
			table.insert(currentCave, "Arctic Ogres 6")
		elseif level >= 130 and level <= 134 then
			table.insert(currentCave, "Arctic Ogres 7")
		elseif level >= 135 and level <= 139 then
			table.insert(currentCave, "Arctic Ogres 8")
		elseif level >= 140 and level <= 144 then
			table.insert(currentCave, "Arctic Ogres 9")
		elseif level >= 145 then
			table.insert(currentCave, "Arctic Ogres 10")
		end

		if level >= 102 then
			table.insert(currentCave, "Rabbit Warrens")
		end

		if level >= 105 then
			table.insert(currentCave, "Critter Crawlspace")
		end

		if level >= 109 then
			table.insert(currentCave, "Lortz Plantation")
		end

		if level >= 110 and level <= 124 then
			table.insert(currentCave, "Ice Palace 1")
		elseif level >= 125 then
			table.insert(currentCave, "Ice Palace 2")
		end

		if level >= 112 then
			table.insert(currentCave, "Occupied Cave")
		end

		if level >= 116 then
			table.insert(currentCave, "Bear Cave")
		end

		if level >= 118 then
			table.insert(currentCave, "Robber's Lair")
		end

		if level >= 120 then
			table.insert(currentCave, "Dragon Den")
		end

		if level >= 123 then
			table.insert(currentCave, "Pig Sty")
		end

		if level >= 125 then
			table.insert(currentCave, "Grim Barrens")
		end

		menu = player:menuString("<b>[Current Caves]", currentCave)

		if menu == "Honey Comb" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 1. Hon by the Sea (120, 109)"}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Sewer Rats" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 5. Hon Underground (12,16)"}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Earthworks 1" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq(
				{t, name .. " This cave opens at Level 10. You will Level out at level 45. Hon by the Sea (63, 123)"},
				1
			)
			cave_chart.click(player, npc)
		elseif menu == "Earthworks 2" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq(
				{t, name .. " This cave opens at Level 45. You will Level out at level 95. Hon by the Sea (63, 123)"},
				1
			)
			cave_chart.click(player, npc)
		elseif menu == "Earthworks 3" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 95.  Hon by the Sea (63, 123)"}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Fox Hole 1" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq(
				{t, name .. " This cave opens at Level 15. You will Level out at level 55. Hon by the Sea (2, 90)"},
				1
			)
			cave_chart.click(player, npc)
		elseif menu == "Fox Hole 2" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq(
				{
					t,
					name ..
						" This cave opens at Level 55. You will Level out at level 99. \nSTAT CAP: 14,999 Base Vita or Mana. \nHon by the Sea (2, 90)"
				},
				1
			)
			cave_chart.click(player, npc)
		elseif menu == "Fox Hole 3" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq(
				{t, name .. " This cave opens at Level 99. \nSTAT REQUIREMENTS: 15,000 Base Vita or Mana. \nHon by the Sea (2, 90)"},
				1
			)
			cave_chart.click(player, npc)
		elseif menu == "Haunted House 1" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq(
				{t, name .. " This cave opens at Level 20. You will Level out at level 65. West shores of Hon (18,17)"},
				1
			)
			cave_chart.click(player, npc)
		elseif menu == "Haunted House 2" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq(
				{
					t,
					name ..
						" This cave opens at Level 65. You will Level out at level 99. \nSTAT CAP: 19,999 Base Vita or Mana. \nWest shores of Hon (18,17)"
				},
				1
			)
			cave_chart.click(player, npc)
		elseif menu == "Haunted House 3" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq(
				{
					t,
					name .. " This cave opens at Level 99. \nSTAT REQUIREMENTS: 20,000 Base Vita or Mana. \nWest shores of Hon (18,17)"
				},
				1
			)
			cave_chart.click(player, npc)
		elseif menu == "Bat Sanctum 1" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq(
				{
					t,
					name ..
						" This cave opens at Level 20. You will Level out at level 75. Hon Harbor (20,59) or Hon by the Sea (27,12)"
				},
				1
			)
			cave_chart.click(player, npc)
		elseif menu == "Bat Sanctum 2" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq(
				{
					t,
					name ..
						" This cave opens at Level 75. You will Level out at level 99. \nSTAT CAP: 29,999 Base Vita or Mana. \nHon Harbor (20,59) or Hon by the Sea (27,12)"
				},
				1
			)
			cave_chart.click(player, npc)
		elseif menu == "Bat Sanctum 3" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq(
				{
					t,
					name ..
						" This cave opens at Level 99. \nSTAT REQUIREMENTS: 30,000 Base Vita or Mana. \nHon Harbor (20,59) or Hon by the Sea (27,12)"
				},
				1
			)
			cave_chart.click(player, npc)
		elseif menu == "Contaminated Cove" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 30. Hon Harbor (34,37)"}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Savage Territory" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 35. Hon by the Sea (88,1)"}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Leech Pass" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 40. Shores of Hon (42,64) or Hon by the Sea (54,2)"}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Subterranean Cavern 1" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq(
				{
					t,
					name ..
						" This cave opens at Level 45. This is a progressive cave. \nEvery 5 levels will unlock the next room for the first 10 rooms. \nShores of Hon (56,15)"
				},
				1
			)
			cave_chart.click(player, npc)
		elseif menu == "Subterranean Cavern 2" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq(
				{
					t,
					name ..
						" This cave opens at Level 50. This is a progressive cave. \nEvery 5 levels will unlock the next room for the first 10 rooms. \nShores of Hon (56,15)"
				},
				1
			)
			cave_chart.click(player, npc)
		elseif menu == "Subterranean Cavern 3" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq(
				{
					t,
					name ..
						" This cave opens at Level 55. This is a progressive cave. \nEvery 5 levels will unlock the next room for the first 10 rooms. \nShores of Hon (56,15)"
				},
				1
			)
			cave_chart.click(player, npc)
		elseif menu == "Subterranean Cavern 4" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq(
				{
					t,
					name ..
						" This cave opens at Level 60. This is a progressive cave. \nEvery 5 levels will unlock the next room for the first 10 rooms. \nShores of Hon (56,15)"
				},
				1
			)
			cave_chart.click(player, npc)
		elseif menu == "Subterranean Cavern 5" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq(
				{
					t,
					name ..
						" This cave opens at Level 65. This is a progressive cave. \nEvery 5 levels will unlock the next room for the first 10 rooms. \nShores of Hon (56,15)"
				},
				1
			)
			cave_chart.click(player, npc)
		elseif menu == "Subterranean Cavern 6" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq(
				{
					t,
					name ..
						" This cave opens at Level 70. This is a progressive cave. \nEvery 5 levels will unlock the next room for the first 10 rooms. \nShores of Hon (56,15)"
				},
				1
			)
			cave_chart.click(player, npc)
		elseif menu == "Subterranean Cavern 7" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq(
				{
					t,
					name ..
						" This cave opens at Level 75. This is a progressive cave. \nEvery 5 levels will unlock the next room for the first 10 rooms. \nShores of Hon (56,15)"
				},
				1
			)
			cave_chart.click(player, npc)
		elseif menu == "Subterranean Cavern 8" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq(
				{
					t,
					name ..
						" This cave opens at Level 80. This is a progressive cave. \nEvery 5 levels will unlock the next room for the first 10 rooms. \nShores of Hon (56,15)"
				},
				1
			)
			cave_chart.click(player, npc)
		elseif menu == "Subterranean Cavern 9" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq(
				{
					t,
					name ..
						" This cave opens at Level 85. This is a progressive cave. \nEvery 5 levels will unlock the next room for the first 10 rooms. \nShores of Hon (56,15)"
				},
				1
			)
			cave_chart.click(player, npc)
		elseif menu == "Subterranean Cavern 10" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq(
				{
					t,
					name ..
						" This cave opens at Level 90. This is a progressive cave. \nEvery 5 levels will unlock the next room for the first 10 rooms. \nShores of Hon (56,15)"
				},
				1
			)
			cave_chart.click(player, npc)
		elseif menu == "Disturbed Tomb" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 50. Woods North of Hon (88,79)"}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Spider Pit" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 60. Woods North of Hon (130,91)"}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Wolf Den" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 70. Woods North of Hon (28,52)"}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Tonguspur Beach" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 80. Woods North of Hon (1,33) to Beach Way (1,6)"}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Frog Swamp" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 80. Tonguspur Beach (9,1)"}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Frog Bog" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 85. Frog Swamp (118,37)"}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Blackstrike Swamp" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 90. Frog Bog (58,61) or Melin (1,25)"}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Lortz Path" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 99. Tonguspur Beach (1,19)"}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Lortz Mine" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 99. Lortz Hills (7,55)"}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Ruins of Bettay" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 99. Lortz Territory (49,104 or 39,106)"}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Blackstrike Tower" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 100. Speak to Delta for more info!"}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Arctic Ogre 1" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 100. North of Cathay (6,3)"}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Arctic Ogre 2" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 105. North of Cathay (6,3)"}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Arctic Ogre 3" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 110. North of Cathay (6,3)"}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Arctic Ogre 4" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 115. North of Cathay (6,3)"}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Arctic Ogre 5" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 120. North of Cathay (6,3)"}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Arctic Ogre 6" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 125. North of Cathay (6,3)"}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Arctic Ogre 7" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 130. North of Cathay (6,3)"}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Arctic Ogre 8" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 135. North of Cathay (6,3)"}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Arctic Ogre 9" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 140. North of Cathay (6,3)"}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Arctic Ogre 10" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 145. North of Cathay (6,3)"}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Rabbit Warrens" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 102. Lortz territory (43,120)"}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Critter Crawlspace" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 105. Lortz territory (43,138)"}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Lortz Plantation" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 109. Lortz territory (42,149)"}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Ice Palace 1" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 110. North of Cathay (12,0)"}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Ice Palace 2" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 125. North of Cathay (12,0)"}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Occupied Cave" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 112. Lortz territory (25,140)"}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Bear Cave" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 116. Lortz territory (43,129)"}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Robber's Lair" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 118. Lortz territory (118,6)"}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Dragon Den" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 120. Lortz territory (35,120)"}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Pig Sty" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 123. Lortz territory (29,149)"}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Grim Barrens" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 125. Lortz territory (26,0)"}, 1)
			cave_chart.click(player, npc)
		end
	end,
	-----Coming Up Caves------------------------------------------------------------------------------------------------------------

	coming = function(player)
		player.dialogType = 0
		local level = player.level
		local vita = player.baseHealth
		local mana = player.baseMagic
		local comingCave = {}

		if level <= 4 then
			table.insert(comingCave, "Sewer Rats")
		end

		if level <= 9 then
			table.insert(comingCave, "Earthworks 1")
		elseif level >= 35 and level <= 44 then
			table.insert(comingCave, "Earthworks 2")
		elseif level >= 85 and level <= 94 then
			table.insert(comingCave, "Earthworks 3")
		end

		if level >= 5 and level <= 14 then
			table.insert(comingCave, "Fox Hole 1")
		elseif level >= 45 and level <= 54 then
			table.insert(comingCave, "Fox Hole 2")
		elseif level >= 99 and (vita <= 14999 or mana <= 14999) then
			table.insert(comingCave, "Fox Hole 3")
		end

		if level >= 10 and level <= 19 then
			table.insert(comingCave, "Haunted House 1")
		elseif level >= 55 and level <= 64 then
			table.insert(comingCave, "Haunted House 2")
		elseif level >= 99 and (vita <= 19999 and mana <= 19999) then
			table.insert(comingCave, "Haunted House 3")
		end

		if level >= 10 and level <= 19 then
			table.insert(comingCave, "Bat Sanctum 1")
		elseif level >= 65 and level <= 74 then
			table.insert(comingCave, "Bat Sanctum 2")
		elseif level >= 99 and (vita <= 29999 and mana <= 29999) then
			table.insert(comingCave, "Bat Sanctum 3")
		end

		if level >= 20 and level <= 29 then
			table.insert(comingCave, "Contaminated Cove")
		end

		if level >= 25 and level <= 34 then
			table.insert(comingCave, "Savage Territory")
		end

		if level >= 30 and level <= 39 then
			table.insert(comingCave, "Leech Pass")
		end

		if level >= 35 and level <= 44 then
			table.insert(comingCave, "Subterranean Cavern 1")
		elseif level >= 45 and level <= 49 then
			table.insert(comingCave, "Subterranean Cavern 2")
		elseif level >= 50 and level <= 54 then
			table.insert(comingCave, "Subterranean Cavern 3")
		elseif level >= 55 and level <= 59 then
			table.insert(comingCave, "Subterranean Cavern 4")
		elseif level >= 60 and level <= 64 then
			table.insert(comingCave, "Subterranean Cavern 5")
		elseif level >= 65 and level <= 69 then
			table.insert(comingCave, "Subterranean Cavern 6")
		elseif level >= 70 and level <= 74 then
			table.insert(comingCave, "Subterranean Cavern 7")
		elseif level >= 75 and level <= 79 then
			table.insert(comingCave, "Subterranean Cavern 8")
		elseif level >= 80 and level <= 84 then
			table.insert(comingCave, "Subterranean Cavern 9")
		elseif level >= 85 and level <= 89 then
			table.insert(comingCave, "Subterranean Cavern 10")
		end

		if level >= 40 and level <= 49 then
			table.insert(comingCave, "Disturbed Tomb")
		end

		if level >= 50 and level <= 59 then
			table.insert(comingCave, "Spider Pit")
		end

		if level >= 60 and level <= 69 then
			table.insert(comingCave, "Wolf Den")
		end

		if level >= 70 and level <= 79 then
			table.insert(comingCave, "Tonguspur Beach")
			table.insert(comingCave, "Frog Swamp")
		end

		if level >= 75 and level <= 84 then
			table.insert(comingCave, "Frog Bog")
		end

		if level >= 80 and level <= 89 then
			table.insert(comingCave, "Blackstrike Swamp")
		end

		if level >= 89 and level <= 98 then
			table.insert(comingCave, "Lortz Path")
			table.insert(comingCave, "Lortz Mine")
		end

		if level >= 90 and level <= 99 and (vita <= 34999 and mana <= 34999) then
			table.insert(comingCave, "Ruins of Bettay")
		end
		if level >= 90 and level <= 99 then
			table.insert(comingCave, "Blackstrike Tower")
		end

		if level >= 95 and level <= 99 then
			table.insert(comingCave, "Arctic Ogres 1")
		elseif level >= 100 and level <= 104 then
			table.insert(comingCave, "Arctic Ogres 2")
		elseif level >= 105 and level <= 109 then
			table.insert(comingCave, "Arctic Ogres 3")
		elseif level >= 110 and level <= 114 then
			table.insert(comingCave, "Arctic Ogres 4")
		elseif level >= 115 and level <= 119 then
			table.insert(comingCave, "Arctic Ogres 5")
		elseif level >= 120 and level <= 124 then
			table.insert(comingCave, "Arctic Ogres 6")
		elseif level >= 125 and level <= 129 then
			table.insert(comingCave, "Arctic Ogres 7")
		elseif level >= 130 and level <= 134 then
			table.insert(comingCave, "Arctic Ogres 8")
		elseif level >= 135 and level <= 139 then
			table.insert(comingCave, "Arctic Ogres 9")
		elseif level >= 140 and level <= 144 then
			table.insert(comingCave, "Arctic Ogres 10")
		end

		if level >= 95 and level <= 101 then
			table.insert(comingCave, "Rabbit Warren")
		end

		if level >= 99 and level <= 104 then
			table.insert(comingCave, "Critter Crawlspace")
		end

		if level >= 100 and level <= 108 then
			table.insert(comingCave, "Lortz Plantation")
		end

		if level >= 100 and level <= 109 then
			table.insert(comingCave, "Ice Palace")
		elseif level >= 115 and level <= 124 then
			table.insert(comingCave, "Ice Palace 2")
		end

		if level >= 102 and level <= 111 then
			table.insert(comingCave, "Occupied Cave")
		end

		if level >= 106 and level <= 115 then
			table.insert(comingCave, "Bear Cave")
		end

		if level >= 108 and level <= 117 then
			table.insert(comingCave, "Robber's Lair")
		end

		if level >= 110 and level <= 119 then
			table.insert(comingCave, "Dragon Den")
		end

		if level >= 113 and level <= 122 then
			table.insert(comingCave, "Pig Sty")
		end

		if level >= 115 and level <= 124 then
			table.insert(comingCave, "Grim Barrens")
		end

		menu = player:menuString("<b>[Coming Up Caves]", comingCave)

		if menu == "Sewer Rats" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 5."}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Earthworks 1" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 10."}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Earthworks 2" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 45."}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Earthworks 3" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 95."}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Fox Hole 1" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 15."}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Fox Hole 2" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 55."}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Fox Hole 3" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 99. \nSTAT REQUIREMENT: 15,000 Base Vita or Mana."}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Haunted House 1" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 20."}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Haunted House 2" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 65."}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Haunted House 3" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 99.\nSTAT REQUIREMENT: 20,000 Base Vita or Mana."}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Bat Sanctum 1" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 20."}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Bat Sanctum 2" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 75."}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Bat Sanctum 3" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 99.\nSTAT REQUIREMENT: 30,000 Base Vita or Mana."}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Contaminated Cove" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 30."}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Savage Territory" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 35."}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Leech Pass" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 40."}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Subterranean Cavern 1" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 45."}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Subterranean Cavern 2" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 50."}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Subterranean Cavern 3" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 55."}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Subterranean Cavern 4" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 60."}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Subterranean Cavern 5" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 65."}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Subterranean Cavern 6" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 70."}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Subterranean Cavern 7" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 75."}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Subterranean Cavern 8" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 80."}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Subterranean Cavern 9" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 85."}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Subterranean Cavern 10" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 90."}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Disturbed Tomb" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 50."}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Spider Pit" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 60."}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Wolf Den" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 70."}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Tonguspur Beach" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 80."}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Frog Swamp" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 80."}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Frog Bog" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 85."}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Blackstrike Swamp" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 90."}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Lortz Path" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 99."}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Lortz Mine" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 99."}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Ruins of Bettay" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 99.\nSTAT REQUIREMENT: 35,000 Base Vita or Mana."}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Blackstrike Tower" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 100."}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Arctic Ogre 1" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 100."}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Arctic Ogre 2" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 105."}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Arctic Ogre 3" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 110."}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Arctic Ogre 4" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 115."}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Arctic Ogre 5" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 120."}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Arctic Ogre 6" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 125."}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Arctic Ogre 7" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 130."}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Arctic Ogre 8" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 135."}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Arctic Ogre 9" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 140."}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Arctic Ogre 10" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 145."}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Rabbit Warrens" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 102."}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Critter Crawlspace" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 105."}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Lortz Plantation" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 109."}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Ice Palace" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 110."}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Ice Palace 2" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 125."}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Occupied Cave" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 112."}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Bear Cave" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 116."}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Robber's Lair" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 118."}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Dragon Den" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 120."}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Pig Sty" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 123."}, 1)
			cave_chart.click(player, npc)
		elseif menu == "Grim Barrens" then
			npc = core
			name = "<b>[The Almighty]\n\n"
			t = {graphic = convertGraphic(1439, "monster"), color = 0}
			player:dialogSeq({t, name .. " This cave opens at Level 125."}, 1)
			cave_chart.click(player, npc)
		end
	end
}
