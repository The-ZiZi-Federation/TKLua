skill = {
	leveling = function(player, get, ability)
		local level = player.registry[ability .. "_level"]
		local tnl = player.registry[ability .. "_tnl"]

		local name, icon
		local skillEXP = get

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

		----------------------------
		-- Currently a Beginner ----
		----------------------------
		if level == 1 then
			---------------------------------
			-- Currently an Novice ------
			---------------------------------
			if tnl > 0 then
				----------------------
				-- Gain crafting XP --
				----------------------
				player.registry[ability .. "_tnl"] = player.registry[ability .. "_tnl"] - skillEXP
				player:sendMinitext(name .. " experience gained " .. skillEXP .. " points (" .. tnl - skillEXP .. ")")
				return
			else
				-----------------------------
				-- Rank Beginner -> Novice --
				-----------------------------
				if player:hasLegend("beginner_" .. ability) then
					player:removeLegendbyName("beginner_" .. ability)
				end
				player:addLegend("Novice " .. name, "novice" .. ability, icon, 108)
				player.registry[ability .. "_level"] = player.registry[ability .. "_level"] + 1

				-- Base Gathering abilities have one TNL
				if
					ability == "herbalism" or ability == "mining" or ability == "shearing" or ability == "woodcutting" or "skinning" or
						"farmer" or
						"fisher"
				 then
					-- Refining abilities have another TNL
					player.registry[ability .. "_tnl"] = 6000
				elseif
					ability == "pulverization" or ability == "smelting" or ability == "weaving" or ability == "sawyer" or
						ability == "tanning" or
						ability == "gemcutter" or
						ability == "scribe" or
						ability == "cook"
				 then
					-- Crafting abilities have yet another TNL
					player.registry[ability .. "_tnl"] = 9000
				elseif
					ability == "concocting" or ability == "smithing" or ability == "tailoring" or ability == "woodcutting" or
						ability == "leatherworker" or
						ability == "gemsetter" or
						ability == "enchanter"
				 then
					player.registry[ability .. "_tnl"] = 13500
				else
					-- Default value, should not be used.
					player.registry[ability .. "_tnl"] = 6000
				end

				finishedQuest(player)
				player:sendMinitext("You're an Novice at " .. name .. " now!")
			end
		elseif level == 2 then
			---------------------------------
			-- Currently an Trainee----------
			---------------------------------
			if tnl > 0 then
				----------------------
				-- Gain crafting XP --
				----------------------
				player.registry[ability .. "_tnl"] = player.registry[ability .. "_tnl"] - get
				player:sendMinitext(name .. " experience gained " .. get .. " points (" .. tnl - get .. ")")
				return
			else
				----------------------------
				-- Rank Novice -> Trainee---
				----------------------------
				if player:hasLegend("novice_" .. ability) then
					player:removeLegendbyName("novice_" .. ability)
				end
				player:addLegend("Trainee " .. name, "trainee_" .. ability, icon, 108)
				player.registry[ability .. "_level"] = player.registry[ability .. "_level"] + 1

				-- Base Gathering abilities have one TNL
				if
					ability == "herbalism" or ability == "mining" or ability == "shearing" or ability == "woodcutting" or "skinning" or
						"farmer" or
						"fisher"
				 then
					-- Refining abilities have another TNL
					player.registry[ability .. "_tnl"] = 12000
				elseif
					ability == "pulverization" or ability == "smelting" or ability == "weaving" or ability == "sawyer" or
						ability == "tanning" or
						ability == "gemcutter" or
						ability == "scribe" or
						ability == "cook"
				 then
					-- Crafting abilities have yet another TNL
					player.registry[ability .. "_tnl"] = 18000
				elseif
					ability == "concocting" or ability == "smithing" or ability == "tailoring" or ability == "carpentry" or
						ability == "leatherworker" or
						ability == "gemsetter" or
						ability == "enchanter"
				 then
					player.registry[ability .. "_tnl"] = 27000
				else
					-- Default value, should not be used.
					player.registry[ability .. "_tnl"] = 12000
				end

				finishedQuest(player)
				player:sendMinitext("You're Trainee in " .. name .. " now!")
			end
		elseif level == 3 then
			------------------------------------
			-- Currently an Apprentice ----------
			------------------------------------
			if tnl > 0 then
				----------------------
				-- Gain crafting XP --
				----------------------
				player.registry[ability .. "_tnl"] = player.registry[ability .. "_tnl"] - get
				player:sendMinitext(name .. " experience gained " .. get .. " points (" .. tnl - get .. ")")
				return
			else
				--------------------------------
				-- Rank Trainee -> Apprentice---
				--------------------------------
				if player:hasLegend("trainee_" .. ability) then
					player:removeLegendbyName("trainee_" .. ability)
				end

				player:addLegend("Apprentice " .. name, "apprentice_" .. ability, icon, 108)
				player.registry[ability .. "_level"] = player.registry[ability .. "_level"] + 1

				-- Base Gathering abilities have one TNL
				if
					ability == "herbalism" or ability == "mining" or ability == "shearing" or ability == "woodcutting" or "skinning" or
						"farmer" or
						"fisher"
				 then
					-- Refining abilities have another TNL
					player.registry[ability .. "_tnl"] = 64000
				elseif
					ability == "pulverization" or ability == "smelting" or ability == "weaving" or ability == "sawyer" or
						ability == "tanning" or
						ability == "gemcutter" or
						ability == "scribe" or
						ability == "cook"
				 then
					-- Crafting abilities have yet another TNL
					player.registry[ability .. "_tnl"] = 96000
				elseif
					ability == "concocting" or ability == "smithing" or ability == "tailoring" or ability == "woodcutting" or
						ability == "leatherworker" or
						ability == "gemsetter" or
						ability == "enchanter"
				 then
					player.registry[ability .. "_tnl"] = 144000
				else
					-- Default value, should not be used.
					player.registry[ability .. "_tnl"] = 64000
				end

				finishedQuest(player)
				player:sendMinitext("You're Apprentice in " .. name .. " now!")
			end
		elseif level == 4 then
			-------------------------------------
			-- Currently a Greenhorn----------
			-------------------------------------
			if tnl > 0 then
				----------------------
				-- Gain crafting XP --
				----------------------
				player.registry[ability .. "_tnl"] = player.registry[ability .. "_tnl"] - get
				player:sendMinitext(name .. " experience gained " .. get .. " points (" .. tnl - get .. ")")
				return
			else
				--------------------------------------
				-- Rank Apprentice -> Greenhorn   ----
				--------------------------------------
				if player:hasLegend("apprentice_" .. ability) then
					player:removeLegendbyName("apprentice_" .. ability)
				end

				player:addLegend("Greenhorn " .. name, "greenhorn_" .. ability, icon, 108)
				player.registry[ability .. "_level"] = player.registry[ability .. "_level"] + 1

				-- Base Gathering abilities have one TNL
				if
					ability == "herbalism" or ability == "mining" or ability == "shearing" or ability == "woodcutting" or "skinning" or
						"farmer" or
						"fisher"
				 then
					-- Refining abilities have another TNL
					player.registry[ability .. "_tnl"] = 150000
				elseif
					ability == "pulverization" or ability == "smelting" or ability == "weaving" or ability == "sawyer" or
						ability == "tanning" or
						ability == "gemcutter" or
						ability == "scribe" or
						ability == "cook"
				 then
					-- Crafting abilities have yet another TNL
					player.registry[ability .. "_tnl"] = 225000
				elseif
					ability == "concocting" or ability == "smithing" or ability == "tailoring" or ability == "woodcutting" or
						ability == "leatherworker" or
						ability == "gemsetter" or
						ability == "enchanter"
				 then
					player.registry[ability .. "_tnl"] = 337500
				else
					-- Default value, should not be used.
					player.registry[ability .. "_tnl"] = 150000
				end

				finishedQuest(player)
				player:sendMinitext(ability .. "You're Greenhorn in " .. name .. " now!")
			end
		elseif level == 5 then
			-------------------------------------
			-- Currently an Aspirant----------
			-------------------------------------
			if tnl > 0 then
				----------------------
				-- Gain crafting XP --
				----------------------
				player.registry[ability .. "_tnl"] = player.registry[ability .. "_tnl"] - get
				player:sendMinitext(name .. " experience gained " .. get .. " points (" .. tnl - get .. ")")

				return
			else
				--------------------------------------
				-- Rank Greenhorn -> Aspirant--------
				--------------------------------------
				if player:hasLegend("greenhorn_" .. ability) then
					player:removeLegendbyName("greenhorn_" .. ability)
				end

				player:addLegend("Aspirant " .. name, "aspirant_" .. ability, icon, 108)
				player.registry[ability .. "_level"] = player.registry[ability .. "_level"] + 1

				-- Base Gathering abilities have one TNL
				if
					ability == "herbalism" or ability == "mining" or ability == "shearing" or ability == "woodcutting" or "skinning" or
						"farmer" or
						"fisher"
				 then
					-- Refining abilities have another TNL
					player.registry[ability .. "_tnl"] = 350000
				elseif
					ability == "pulverization" or ability == "smelting" or ability == "weaving" or ability == "sawyer" or
						ability == "tanning" or
						ability == "gemcutter" or
						ability == "scribe" or
						ability == "cook"
				 then
					-- Crafting abilities have yet another TNL
					player.registry[ability .. "_tnl"] = 525000
				elseif
					ability == "concocting" or ability == "smithing" or ability == "tailoring" or ability == "woodcutting" or
						ability == "leatherworker" or
						ability == "gemsetter" or
						ability == "enchanter"
				 then
					player.registry[ability .. "_tnl"] = 787500
				else
					-- Default value, should not be used.
					player.registry[ability .. "_tnl"] = 350000
				end

				finishedQuest(player)
				player:sendMinitext("You're an Aspirant at " .. name .. " now!")
			end
		elseif level == 6 then
			------------------------------------
			-- Currently an Amateur----------
			-------------------------------------
			if tnl > 0 then
				player.registry[ability .. "_tnl"] = player.registry[ability .. "_tnl"] - get
				player:sendMinitext(name .. " experience gained " .. get .. " points (" .. tnl - get .. ")")

				return
			else
				--------------------------------------
				-- Rank Aspirant -> Amateur--------
				--------------------------------------
				if player:hasLegend("aspirant_" .. ability) then
					player:removeLegendbyName("aspirant_" .. ability)
				end

				player:addLegend("Amateur " .. name, "amateur_" .. ability, icon, 108)
				player.registry[ability .. "_level"] = player.registry[ability .. "_level"] + 1

				-- Base Gathering abilities have one TNL
				if
					ability == "herbalism" or ability == "mining" or ability == "shearing" or ability == "woodcutting" or "skinning" or
						"farmer" or
						"fisher"
				 then
					-- Refining abilities have another TNL
					player.registry[ability .. "_tnl"] = 500000
				elseif
					ability == "pulverization" or ability == "smelting" or ability == "weaving" or ability == "sawyer" or
						ability == "tanning" or
						ability == "gemcutter" or
						ability == "scribe" or
						ability == "cook"
				 then
					-- Crafting abilities have yet another TNL
					player.registry[ability .. "_tnl"] = 750000
				elseif
					ability == "concocting" or ability == "smithing" or ability == "tailoring" or ability == "woodcutting" or
						ability == "leatherworker" or
						ability == "gemsetter" or
						ability == "enchanter"
				 then
					player.registry[ability .. "_tnl"] = 1125000
				else
					-- Default value, should not be used.
					player.registry[ability .. "_tnl"] = 500000
				end

				finishedQuest(player)
				player:sendMinitext("You're an Amateur in " .. name .. " now!")
			end
		elseif level == 7 then
			-------------------------------------
			-- Currently a Journeyman ----------
			-------------------------------------
			if tnl > 0 then
				player.registry[ability .. "_tnl"] = player.registry[ability .. "_tnl"] - get
				player:sendMinitext(name .. " experience gained " .. get .. " points (" .. tnl - get .. ")")
				return
			else
				--------------------------------------
				-- Rank Amateur -> Journeyman --------
				--------------------------------------
				if player:hasLegend("amateur_" .. ability) then
					player:removeLegendbyName("amateur_" .. ability)
				end

				player:addLegend("Journeyman " .. name, "journeyman_" .. ability, icon, 108)
				player.registry[ability .. "_level"] = player.registry[ability .. "_level"] + 1

				-- Base Gathering abilities have one TNL
				if
					ability == "herbalism" or ability == "mining" or ability == "shearing" or ability == "woodcutting" or "skinning" or
						"farmer" or
						"fisher"
				 then
					-- Refining abilities have another TNL
					player.registry[ability .. "_tnl"] = 1200000
				elseif
					ability == "pulverization" or ability == "smelting" or ability == "weaving" or ability == "sawyer" or
						ability == "tanning" or
						ability == "gemcutter" or
						ability == "scribe" or
						ability == "cook"
				 then
					-- Crafting abilities have yet another TNL
					player.registry[ability .. "_tnl"] = 1800000
				elseif
					ability == "concocting" or ability == "smithing" or ability == "tailoring" or ability == "woodcutting" or
						ability == "leatherworker" or
						ability == "gemsetter" or
						ability == "enchanter"
				 then
					player.registry[ability .. "_tnl"] = 2700000
				else
					-- Default value, should not be used.
					player.registry[ability .. "_tnl"] = 1200000
				end

				finishedQuest(player)
				player:sendMinitext("You're a Journeyman at " .. name .. " now!")
			end
		elseif level == 8 then
			-------------------------------------
			-- Currently a Adept       ----------
			-------------------------------------
			if tnl > 0 then
				player.registry[ability .. "_tnl"] = player.registry[ability .. "_tnl"] - get
				player:sendMinitext(name .. " experience gained " .. get .. " points (" .. tnl - get .. ")")
				return
			else
				--------------------------------------
				-- Rank Journeyman -> Adept --------
				--------------------------------------
				if player:hasLegend("journeyman_" .. ability) then
					player:removeLegendbyName("journeyman_" .. ability)
				end

				player:addLegend("Adept " .. name, "adept_" .. ability, icon, 108)
				player.registry[ability .. "_level"] = player.registry[ability .. "_level"] + 1

				-- Base Gathering abilities have one TNL
				if
					ability == "herbalism" or ability == "mining" or ability == "shearing" or ability == "woodcutting" or "skinning" or
						"farmer" or
						"fisher"
				 then
					-- Refining abilities have another TNL
					player.registry[ability .. "_tnl"] = 3000000
				elseif
					ability == "pulverization" or ability == "smelting" or ability == "weaving" or ability == "sawyer" or
						ability == "tanning" or
						ability == "gemcutter" or
						ability == "scribe" or
						ability == "cook"
				 then
					-- Crafting abilities have yet another TNL
					player.registry[ability .. "_tnl"] = 4500000
				elseif
					ability == "concocting" or ability == "smithing" or ability == "tailoring" or ability == "woodcutting" or
						ability == "leatherworker" or
						ability == "gemsetter" or
						ability == "enchanter"
				 then
					player.registry[ability .. "_tnl"] = 6750000
				else
					-- Default value, should not be used.
					player.registry[ability .. "_tnl"] = 3000000
				end

				finishedQuest(player)
				player:sendMinitext("You're a Adept at " .. name .. " now!")
			end
		elseif level == 9 then
			-------------------------------------
			-- Currently a Skilled     ----------
			-------------------------------------
			if tnl > 0 then
				player.registry[ability .. "_tnl"] = player.registry[ability .. "_tnl"] - get
				player:sendMinitext(name .. " experience gained " .. get .. " points (" .. tnl - get .. ")")
				return
			else
				--------------------------------------
				-- Rank Adept -> Skilled       -------
				--------------------------------------
				if player:hasLegend("adept_" .. ability) then
					player:removeLegendbyName("adept_" .. ability)
				end

				player:addLegend("Skilled " .. name, "skilled_" .. ability, icon, 108)
				player.registry[ability .. "_level"] = player.registry[ability .. "_level"] + 1

				-- Base Gathering abilities have one TNL
				if
					ability == "herbalism" or ability == "mining" or ability == "shearing" or ability == "woodcutting" or "skinning" or
						"farmer" or
						"fisher"
				 then
					-- Refining abilities have another TNL
					player.registry[ability .. "_tnl"] = 9000000
				elseif
					ability == "pulverization" or ability == "smelting" or ability == "weaving" or ability == "sawyer" or
						ability == "tanning" or
						ability == "gemcutter" or
						ability == "scribe" or
						ability == "cook"
				 then
					-- Crafting abilities have yet another TNL
					player.registry[ability .. "_tnl"] = 13500000
				elseif
					ability == "concocting" or ability == "smithing" or ability == "tailoring" or ability == "woodcutting" or
						ability == "leatherworker" or
						ability == "gemsetter" or
						ability == "enchanter"
				 then
					player.registry[ability .. "_tnl"] = 20250000
				else
					-- Default value, should not be used.
					player.registry[ability .. "_tnl"] = 9000000
				end

				finishedQuest(player)
				player:sendMinitext("You're a Skilled at " .. name .. " now!")
			end
		elseif level == 10 then
			-------------------------------------
			-- Currently a Expert      ----------
			-------------------------------------
			if tnl > 0 then
				player.registry[ability .. "_tnl"] = player.registry[ability .. "_tnl"] - get
				player:sendMinitext(name .. " experience gained " .. get .. " points (" .. tnl - get .. ")")
				return
			else
				--------------------------------------
				-- Rank Skilled -> Expert       -------
				--------------------------------------
				if player:hasLegend("skilled_" .. ability) then
					player:removeLegendbyName("skilled_" .. ability)
				end

				player:addLegend("Expert " .. name, "expert_" .. ability, icon, 108)
				player.registry[ability .. "_level"] = player.registry[ability .. "_level"] + 1

				-- Base Gathering abilities have one TNL
				if
					ability == "herbalism" or ability == "mining" or ability == "shearing" or ability == "woodcutting" or "skinning" or
						"farmer" or
						"fisher"
				 then
					-- Refining abilities have another TNL
					player.registry[ability .. "_tnl"] = 20000000
				elseif
					ability == "pulverization" or ability == "smelting" or ability == "weaving" or ability == "sawyer" or
						ability == "tanning" or
						ability == "gemcutter" or
						ability == "scribe" or
						ability == "cook"
				 then
					-- Crafting abilities have yet another TNL
					player.registry[ability .. "_tnl"] = 30000000
				elseif
					ability == "concocting" or ability == "smithing" or ability == "tailoring" or ability == "woodcutting" or
						ability == "leatherworker" or
						ability == "gemsetter" or
						ability == "enchanter"
				 then
					player.registry[ability .. "_tnl"] = 45000000
				else
					-- Default value, should not be used.
					player.registry[ability .. "_tnl"] = 20000000
				end

				finishedQuest(player)
				player:sendMinitext("You're a Expert at " .. name .. " now!")
			end
		elseif level == 11 then
			-------------------------------------
			-- Currently a Artisan     ----------
			-------------------------------------
			if tnl > 0 then
				player.registry[ability .. "_tnl"] = player.registry[ability .. "_tnl"] - get
				player:sendMinitext(name .. " experience gained " .. get .. " points (" .. tnl - get .. ")")
				return
			else
				--------------------------------------
				-- Rank Expert -> Artisan      -------
				--------------------------------------
				if player:hasLegend("expert_" .. ability) then
					player:removeLegendbyName("expert_" .. ability)
				end

				player:addLegend("Artisan " .. name, "artisan_" .. ability, icon, 108)
				player.registry[ability .. "_level"] = player.registry[ability .. "_level"] + 1

				-- Base Gathering abilities have one TNL
				if
					ability == "herbalism" or ability == "mining" or ability == "shearing" or ability == "woodcutting" or "skinning" or
						"farmer" or
						"fisher"
				 then
					-- Refining abilities have another TNL
					player.registry[ability .. "_tnl"] = 40000000
				elseif
					ability == "pulverization" or ability == "smelting" or ability == "weaving" or ability == "sawyer" or
						ability == "tanning" or
						ability == "gemcutter" or
						ability == "scribe" or
						ability == "cook"
				 then
					-- Crafting abilities have yet another TNL
					player.registry[ability .. "_tnl"] = 60000000
				elseif
					ability == "concocting" or ability == "smithing" or ability == "tailoring" or ability == "woodcutting" or
						ability == "leatherworker" or
						ability == "gemsetter" or
						ability == "enchanter"
				 then
					player.registry[ability .. "_tnl"] = 90000000
				else
					-- Default value, should not be used.
					player.registry[ability .. "_tnl"] = 40000000
				end

				finishedQuest(player)
				player:sendMinitext("You're a Artisan at " .. name .. " now!")
			end
		elseif level == 12 then
			-------------------------------------
			-- Currently a Prodigy     ----------
			-------------------------------------
			if tnl > 0 then
				player.registry[ability .. "_tnl"] = player.registry[ability .. "_tnl"] - get
				player:sendMinitext(name .. " experience gained " .. get .. " points (" .. tnl - get .. ")")
				return
			else
				--------------------------------------
				-- Rank Artisan -> Prodigy     -------
				--------------------------------------
				if player:hasLegend("artisan_" .. ability) then
					player:removeLegendbyName("artisan_" .. ability)
				end

				player:addLegend("Prodigy " .. name, "prodigy_" .. ability, icon, 108)
				player.registry[ability .. "_level"] = player.registry[ability .. "_level"] + 1

				-- Base Gathering abilities have one TNL
				if
					ability == "herbalism" or ability == "mining" or ability == "shearing" or ability == "woodcutting" or "skinning" or
						"farmer" or
						"fisher"
				 then
					-- Refining abilities have another TNL
					player.registry[ability .. "_tnl"] = 75000000
				elseif
					ability == "pulverization" or ability == "smelting" or ability == "weaving" or ability == "sawyer" or
						ability == "tanning" or
						ability == "gemcutter" or
						ability == "scribe" or
						ability == "cook"
				 then
					-- Crafting abilities have yet another TNL
					player.registry[ability .. "_tnl"] = 112500000
				elseif
					ability == "concocting" or ability == "smithing" or ability == "tailoring" or ability == "woodcutting" or
						ability == "leatherworker" or
						ability == "gemsetter" or
						ability == "enchanter"
				 then
					player.registry[ability .. "_tnl"] = 168750000
				else
					-- Default value, should not be used.
					player.registry[ability .. "_tnl"] = 75000000
				end

				finishedQuest(player)
				player:sendMinitext("You're a Prodigy at " .. name .. " now!")
			end
		elseif level == 13 then
			-------------------------------------
			-- Currently a Virtuoso     ----------
			-------------------------------------
			if tnl > 0 then
				player.registry[ability .. "_tnl"] = player.registry[ability .. "_tnl"] - get
				player:sendMinitext(name .. " experience gained " .. get .. " points (" .. tnl - get .. ")")
				return
			else
				--------------------------------------
				-- Rank Prodigy -> Virtuoso    -------
				--------------------------------------
				if player:hasLegend("prodigy_" .. ability) then
					player:removeLegendbyName("prodigy_" .. ability)
				end

				player:addLegend("Virtuoso " .. name, "virtuoso_" .. ability, icon, 108)
				player.registry[ability .. "_level"] = player.registry[ability .. "_level"] + 1

				-- Base Gathering abilities have one TNL
				if
					ability == "herbalism" or ability == "mining" or ability == "shearing" or ability == "woodcutting" or "skinning" or
						"farmer" or
						"fisher"
				 then
					-- Refining abilities have another TNL
					player.registry[ability .. "_tnl"] = 150000000
				elseif
					ability == "pulverization" or ability == "smelting" or ability == "weaving" or ability == "sawyer" or
						ability == "tanning" or
						ability == "gemcutter" or
						ability == "scribe" or
						ability == "cook"
				 then
					-- Crafting abilities have yet another TNL
					player.registry[ability .. "_tnl"] = 225000000
				elseif
					ability == "concocting" or ability == "smithing" or ability == "tailoring" or ability == "woodcutting" or
						ability == "leatherworker" or
						ability == "gemsetter" or
						ability == "enchanter"
				 then
					player.registry[ability .. "_tnl"] = 337500000
				else
					-- Default value, should not be used.
					player.registry[ability .. "_tnl"] = 150000000
				end

				finishedQuest(player)
				player:sendMinitext("You're a Virtuoso at " .. name .. " now!")
			end
		elseif level == 14 then
			-------------------------------------
			-- Currently a Master      ----------
			-------------------------------------
			if tnl > 0 then
				player.registry[ability .. "_tnl"] = player.registry[ability .. "_tnl"] - get
				player:sendMinitext(name .. " experience gained " .. get .. " points (" .. tnl - get .. ")")
				return
			else
				--------------------------------------
				-- Rank Virtuoso -> Master    -------
				--------------------------------------
				if player:hasLegend("virtuoso_" .. ability) then
					player:removeLegendbyName("virtuoso_" .. ability)
				end

				player:addLegend("Master " .. name, "master_" .. ability, icon, 108)
				player.registry[ability .. "_level"] = player.registry[ability .. "_level"] + 1

				-- Base Gathering abilities have one TNL
				if
					ability == "herbalism" or ability == "mining" or ability == "shearing" or ability == "woodcutting" or "skinning" or
						"farmer" or
						"fisher"
				 then
					-- Refining abilities have another TNL
					player.registry[ability .. "_tnl"] = 400000000
				elseif
					ability == "pulverization" or ability == "smelting" or ability == "weaving" or ability == "sawyer" or
						ability == "tanning" or
						ability == "gemcutter" or
						ability == "scribe" or
						ability == "cook"
				 then
					-- Crafting abilities have yet another TNL
					player.registry[ability .. "_tnl"] = 600000000
				elseif
					ability == "concocting" or ability == "smithing" or ability == "tailoring" or ability == "woodcutting" or
						ability == "leatherworker" or
						ability == "gemsetter" or
						ability == "enchanter"
				 then
					player.registry[ability .. "_tnl"] = 900000000
				else
					-- Default value, should not be used.
					player.registry[ability .. "_tnl"] = 400000000
				end

				finishedQuest(player)
				player:sendMinitext("You're a Master at " .. name .. " now!")
			end
		elseif level == 15 then
			--[[
  ------------------------------------- 
  -- Currently a Grand Master----------
  -------------------------------------
	elseif level == 16 then
		if tnl > 0 then
			player.registry[ability.."_tnl"] = player.registry[ability.."_tnl"] - get
			player:sendMinitext(name.." experience gained "..get.." points ("..tnl-get..")")
		return else
			--------------------------------------
			-- Rank Grand Master ->        -------
			--------------------------------------
			if player:hasLegend("grandmaster_"..ability) then player:removeLegendbyName("grandmaster_"..ability) end

			player:addLegend("Grandmaster "..name, "master_"..ability, icon, 108)
			player.registry[ability.."_level"] = player.registry[ability.."_level"]+1

			-- Base Gathering abilities have one TNL
			if ability == "herbalism" or ability == "mining" or ability == "shearing" or ability == "woodcutting" or "skinning" or "farmer" or "fisher" then
				player.registry[ability.."_tnl"] = 20000000000
			-- Refining abilities have another TNL
			elseif ability == "pulverization" or ability == "smelting" or ability == "weaving" or ability == "sawyer" or ability == "tanning" or ability == "gemcutter" or ability == "scribe" or ability == "cook" then
				player.registry[ability.."_tnl"] = 30000000000
			-- Crafting abilities have yet another TNL
			elseif	ability == "concocting" or ability == "smithing" or ability == "tailoring" or ability == "woodcutting" or ability == "leatherworker" or ability == "gemsetter" or ability == "enchanter" then
				player.registry[ability.."_tnl"] = 45000000000
			else
			-- Default value, should not be used.
				player.registry[ability.."_tnl"] = 20000000000
			end

			finishedQuest(player)
			player:sendMinitext("You're a Grandmaster at "..name.." now!")

		end
     ]]
			if tnl > 0 then
				player.registry[ability .. "_tnl"] = player.registry[ability .. "_tnl"] - get
				player:sendMinitext(name .. " experience gained " .. get .. " points (" .. tnl - get .. ")")
				return
			else
				--------------------------------------
				-- Rank Master -> Grand Master -------
				--------------------------------------
				if player:hasLegend("master_" .. ability) then
					player:removeLegendbyName("master_" .. ability)
				end

				player:addLegend("Grandmaster " .. name, "grandmaster_" .. ability, icon, 108)
				player.registry[ability .. "_level"] = player.registry[ability .. "_level"] + 1

				-- Base Gathering abilities have one TNL
				if
					ability == "herbalism" or ability == "mining" or ability == "shearing" or ability == "woodcutting" or "skinning" or
						"farmer" or
						"fisher"
				 then
					-- Refining abilities have another TNL
					player.registry[ability .. "_tnl"] = 2000000000
				elseif
					ability == "pulverization" or ability == "smelting" or ability == "weaving" or ability == "sawyer" or
						ability == "tanning" or
						ability == "gemcutter" or
						ability == "scribe" or
						ability == "cook"
				 then
					-- Crafting abilities have yet another TNL
					player.registry[ability .. "_tnl"] = 3000000000
				elseif
					ability == "concocting" or ability == "smithing" or ability == "tailoring" or ability == "woodcutting" or
						ability == "leatherworker" or
						ability == "gemsetter" or
						ability == "enchanter"
				 then
					player.registry[ability .. "_tnl"] = 4500000000
				else
					-- Default value, should not be used.
					player.registry[ability .. "_tnl"] = 2000000000
				end

				finishedQuest(player)
				player:sendMinitext("You're a Master at " .. name .. " now!")
			end
		else
			return
		end
	end
}
