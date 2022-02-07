deaupuo = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local opts = {}
			local menuOpts = {"Learn Spell", "Leave"}
			local you = player.level
			local job = player.class
			local quest = player.quest["wizard_path"]

			if player.class ~= 3 then
				player:dialogSeq({t, name .. "You shouldn't be here."}, 1)
				return
			end
			if player.registry["wizard_element_choice"] == 0 then
				player:dialogSeq({t, name .. "I can't help you yet."}, 1)
				return
			end
			menu = player:menuString(name .. "What can I do for you?", menuOpts)

			if menu == "Learn Spell" then
				if player.registry["wizard_element_choice"] == 1 then --Ice
					--if you >= 5 and job == 3 and quest >= 1 and player.registry["learned_snowstorm"] == 0 then table.insert(opts, "Snowstorm") end
					--if you >= 35 and job == 3 and quest >= 1 and player.registry["learned_cone_of_cold"] == 0 then table.insert(opts, "Cone of Cold") end
					--if you >= 60 and job == 3 and quest >= 1 and player.registry["learned_hailstorm"] == 0 then table.insert(opts, "Hailstorm") end
					--if you >= 75 and job == 3 and quest >= 1 and player.registry["learned_ice_armor"] == 0 then table.insert(opts, "Ice Armor") end
					--if you >= 99 and job == 3 and quest >= 1 and player.registry["learned_flurry"] == 0 then table.insert(opts, "Flurry") end
					if player.registry["learned_snowstorm_lv1"] == 0 then
						table.insert(opts, "Snowstorm Lv1")
					end
					if player.registry["learned_snowstorm_lv2"] == 0 then
						table.insert(opts, "Snowstorm Lv2")
					end
					if player.registry["learned_snowstorm_lv3"] == 0 then
						table.insert(opts, "Snowstorm Lv3")
					end
					if player.registry["learned_snowstorm_lv4"] == 0 then
						table.insert(opts, "Snowstorm Lv4")
					end
					if player.registry["learned_snowstorm_lv5"] == 0 then
						table.insert(opts, "Snowstorm Lv5")
					end

					if player.registry["learned_cone_of_cold_lv1"] == 0 then
						table.insert(opts, "Cone of Cold Lv1")
					end
					if player.registry["learned_cone_of_cold_lv2"] == 0 then
						table.insert(opts, "Cone of Cold Lv2")
					end
					if player.registry["learned_cone_of_cold_lv3"] == 0 then
						table.insert(opts, "Cone of Cold Lv3")
					end
					if player.registry["learned_cone_of_cold_lv4"] == 0 then
						table.insert(opts, "Cone of Cold Lv4")
					end

					if player.registry["learned_hailstorm_lv1"] == 0 then
						table.insert(opts, "Hailstorm Lv1")
					end
					if player.registry["learned_hailstorm_lv2"] == 0 then
						table.insert(opts, "Hailstorm Lv2")
					end

					if player.registry["learned_ice_armor"] == 0 then
						table.insert(opts, "Ice Armor")
					end
					if player.registry["learned_flurry"] == 0 then
						table.insert(opts, "Flurry")
					end
				elseif player.registry["wizard_element_choice"] == 2 then --Fire
					--if you >= 5 and job == 3 and quest >= 1 and player.registry["learned_flare"] == 0 then table.insert(opts, "Flare") end
					--if you >= 35 and job == 3 and quest >= 1 and player.registry["learned_burning_hands"] == 0 then table.insert(opts, "Burning Hands") end
					--if you >= 60 and job == 3 and quest >= 1 and player.registry["learned_fireball"] == 0 then table.insert(opts, "Fireball") end
					--if you >= 75 and job == 3 and quest >= 1 and player.registry["learned_flame_shield"] == 0 then table.insert(opts, "Flame Shield") end
					--if you >= 99 and job == 3 and quest >= 1 and player.registry["learned_flame_surge"] == 0 then table.insert(opts, "Flame Surge") end
					if player.registry["learned_flare_lv1"] == 0 then
						table.insert(opts, "Flare Lv1")
					end
					if player.registry["learned_flare_lv2"] == 0 then
						table.insert(opts, "Flare Lv2")
					end
					if player.registry["learned_flare_lv3"] == 0 then
						table.insert(opts, "Flare Lv3")
					end
					if player.registry["learned_flare_lv4"] == 0 then
						table.insert(opts, "Flare Lv4")
					end
					if player.registry["learned_flare_lv5"] == 0 then
						table.insert(opts, "Flare Lv5")
					end

					if player.registry["learned_burning_hands_lv1"] == 0 then
						table.insert(opts, "Burning Hands Lv1")
					end
					if player.registry["learned_burning_hands_lv2"] == 0 then
						table.insert(opts, "Burning Hands Lv2")
					end
					if player.registry["learned_burning_hands_lv3"] == 0 then
						table.insert(opts, "Burning Hands Lv3")
					end
					if player.registry["learned_burning_hands_lv4"] == 0 then
						table.insert(opts, "Burning Hands Lv4")
					end

					if player.registry["learned_fireball_lv1"] == 0 then
						table.insert(opts, "Fireball Lv1")
					end
					if player.registry["learned_fireball_lv2"] == 0 then
						table.insert(opts, "Fireball Lv2")
					end

					if player.registry["learned_flame_shield"] == 0 then
						table.insert(opts, "Flame Shield")
					end
					if player.registry["learned_flame_surge"] == 0 then
						table.insert(opts, "Flame Surge")
					end
				elseif player.registry["wizard_element_choice"] == 3 then --Lightning
					--if you >= 5 and job == 3 and quest >= 1 and player.registry["learned_zap"] == 0 then table.insert(opts, "Zap") end
					--if you >= 35 and job == 3 and quest >= 1 and player.registry["learned_shockwave"] == 0 then table.insert(opts, "Shockwave") end
					--if you >= 60 and job == 3 and quest >= 1 and player.registry["learned_call_lightning"] == 0 then table.insert(opts, "Call Lightning") end
					--if you >= 75 and job == 3 and quest >= 1 and player.registry["learned_electric_barrier"] == 0 then table.insert(opts, "Electric Barrier") end
					--if you >= 99 and job == 3 and quest >= 1 and player.registry["learned_thunderstorm"] == 0 then table.insert(opts, "Thunderstorm") end
					if player.registry["learned_zap_lv1"] == 0 then
						table.insert(opts, "Zap Lv1")
					end
					if player.registry["learned_zap_lv2"] == 0 then
						table.insert(opts, "Zap Lv2")
					end
					if player.registry["learned_zap_lv3"] == 0 then
						table.insert(opts, "Zap Lv3")
					end
					if player.registry["learned_zap_lv4"] == 0 then
						table.insert(opts, "Zap Lv4")
					end
					if player.registry["learned_zap_lv5"] == 0 then
						table.insert(opts, "Zap Lv5")
					end

					if player.registry["learned_shockwave_lv1"] == 0 then
						table.insert(opts, "Shockwave Lv1")
					end
					if player.registry["learned_shockwave_lv2"] == 0 then
						table.insert(opts, "Shockwave Lv2")
					end
					if player.registry["learned_shockwave_lv3"] == 0 then
						table.insert(opts, "Shockwave Lv3")
					end
					if player.registry["learned_shockwave_lv4"] == 0 then
						table.insert(opts, "Shockwave Lv4")
					end

					if player.registry["learned_call_lightning_lv1"] == 0 then
						table.insert(opts, "Call Lightning Lv1")
					end
					if player.registry["learned_call_lightning_lv2"] == 0 then
						table.insert(opts, "Call Lightning Lv2")
					end

					if player.registry["learned_electric_barrier"] == 0 then
						table.insert(opts, "Electric Barrier")
					end
					if player.registry["learned_thunderstorm"] == 0 then
						table.insert(opts, "Thunderstorm")
					end
				end
				player:learnSpell2(npc, opts)
			end
		end
	)
}
