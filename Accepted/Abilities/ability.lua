ability = {
	click = function(player, npc)
		local t = {graphic = convertGraphic(1439, "monster"), color = 0}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0

		local opts = {}
		if player.registry["learned_herbalism"] > 0 then
			table.insert(opts, "Herb Picking")
		end
		if player.registry["learned_pulverization"] > 0 then
			table.insert(opts, "Herb Pulverizing")
		end
		if player.registry["learned_concocting"] > 0 then
			table.insert(opts, "Potion Making")
		end
		if player.registry["learned_mining"] > 0 then
			table.insert(opts, "Miner")
		end
		if player.registry["learned_smelting"] > 0 then
			table.insert(opts, "Smelter")
		end
		if player.registry["learned_smithing"] > 0 then
			table.insert(opts, "Blacksmith")
		end

		menu = player:menuString("<b>[Ability's info]\n\nWhich ability?", opts)

		if menu == "Herb Picking" then
			ability.info(player, "herbalism")
		elseif menu == "Herb Pulverizing" then
			ability.info(player, "pulverization")
		elseif menu == "Potion Making" then
			ability.info(player, "concocting")
		elseif menu == "Miner" then
			ability.info(player, "mining")
		elseif menu == "Smelter" then
			ability.info(player, "smelting")
		elseif menu == "Blacksmith" then
			ability.info(player, "smithing")
		else
			-- Error Handler
		end
	end,
	info = function(player, ability)
		local level = player.registry[ability .. "_level"]
		local tnl = player.registry[ability .. "_tnl"]

		if level == 0 and tnl == 0 then
			return nil
		end
		local lv, txt, name, icon
		if ability == "herbalism" then
			name = "Herbalist"
			icon = 1
		end
		if ability == "pulverization" then
			name = "Herbal Pulverizer"
			icon = 1
		end
		if ability == "concocting" then
			name = "Potion Maker"
			icon = 1
		end
		if ability == "mining" then
			name = "Miner"
			icon = 125
		end
		if ability == "smelting" then
			name = "Smelter"
			icon = 1
		end
		if ability == "smithing" then
			name = "Blacksmith"
			icon = 1
		end
		if ability == "shearing" then
			name = "Shearer"
			icon = 1
		end
		if ability == "weaving" then
			name = "Weaver"
			icon = 1
		end
		if ability == "tailoring" then
			name = "Tailor"
			icon = 1
		end
		if ability == "woodcutting" then
			name = "Lumberjack"
			icon = 1
		end
		if ability == "sawyer" then
			name = "Wood Miller"
			icon = 1
		end
		if ability == "carpentry" then
			name = "Carpenter"
			icon = 1
		end
		if ability == "skinning" then
			name = "Trapper"
			icon = 1
		end
		if ability == "tanning" then
			name = "Tanner"
			icon = 1
		end
		if ability == "leatherworker" then
			name = "Leatherworker"
			icon = 1
		end
		if ability == "gemcutter" then
			name = "Gem Cutter"
			icon = 1
		end
		if ability == "gemsetter" then
			name = "Lapidary"
			icon = 1
		end
		if ability == "scribe" then
			name = "Scribe"
			icon = 1
		end
		if ability == "enchanter" then
			name = "Enchanter"
			icon = 1
		end
		if ability == "farmer" then
			name = "Farmer"
			icon = 1
		end
		if ability == "fisher" then
			name = "Waterman"
			icon = 1
		end
		if ability == "cook" then
			name = "Cook"
			icon = 1
		end

		if level == 1 then
			lv = "Beginner"
		end
		if level == 2 then
			lv = "Novice"
		end
		if level == 3 then
			lv = "Trainee"
		end
		if level == 4 then
			lv = "Apprentice"
		end
		if level == 5 then
			lv = "Greenhorn"
		end
		if level == 6 then
			lv = "Aspirant"
		end
		if level == 7 then
			lv = "Amateur"
		end
		if level == 8 then
			lv = "Journeyman"
		end
		if level == 9 then
			lv = "Adept"
		end
		if level == 10 then
			lv = "Skilled"
		end
		if level == 11 then
			lv = "Expert"
		end
		if level == 12 then
			lv = "Artisan"
		end
		if level == 13 then
			lv = "Prodigy"
		end
		if level == 14 then
			lv = "Virtuoso"
		end
		if level == 15 then
			lv = "Master"
		end
		if level == 16 then
			lv = "GrandMaster"
		end

		txt = "<b>[" .. name .. "]\n\n"
		txt = txt .. "<b>-------------------------------------\n"
		txt = txt .. "Level : " .. lv .. "\n"
		txt = txt .. "Exp to next level : " .. tnl .. " points\n\n\n"
		player:popUp(txt)
	end
}
