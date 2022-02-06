wizardSpellCheck = function(player)



		if player.registry["wizard_element_choice"] == 1 then --Ice



			player.registry["learned_flare_lv1"] = 0 
			player:removeSpell("flare_lv1")
			player.registry["learned_flare_lv2"] = 0 
			player:removeSpell("flare_lv2")
			player.registry["learned_flare_lv3"] = 0 
			player:removeSpell("flare_lv3")
			player.registry["learned_flare_lv4"] = 0 
			player:removeSpell("flare_lv4")
			player.registry["learned_flare_lv5"] = 0 
			player:removeSpell("flare_lv5")
			
			player.registry["learned_burning_hands_lv1"] = 0 player:removeSpell("burning_hands_lv1")
			player.registry["learned_burning_hands_lv2"] = 0 player:removeSpell("burning_hands_lv2")
			player.registry["learned_burning_hands_lv3"] = 0 player:removeSpell("burning_hands_lv3")
			player.registry["learned_burning_hands_lv4"] = 0 player:removeSpell("burning_hands_lv4")
			
			player.registry["learned_fireball_lv1"] = 0 player:removeSpell("fireball_lv1")
			player.registry["learned_fireball_lv2"] = 0 player:removeSpell("fireball_lv2")
			
			player.registry["learned_flame_shield"] = 0 player:removeSpell("flame_shield")
			player.registry["learned_flame_surge"] = 0 player:removeSpell("flame_surge")


			player.registry["learned_zap_lv1"] = 0 player:removeSpell("zap_lv1")
			player.registry["learned_zap_lv2"] = 0 player:removeSpell("zap_lv2")
			player.registry["learned_zap_lv3"] = 0 player:removeSpell("zap_lv3")
			player.registry["learned_zap_lv4"] = 0 player:removeSpell("zap_lv4")
			player.registry["learned_zap_lv5"] = 0 player:removeSpell("zap_lv5")
			
			player.registry["learned_shockwave_lv1"] = 0 player:removeSpell("shockwave_lv1")
			player.registry["learned_shockwave_lv2"] = 0 player:removeSpell("shockwave_lv2")
			player.registry["learned_shockwave_lv3"] = 0 player:removeSpell("shockwave_lv3")
			player.registry["learned_shockwave_lv4"] = 0 player:removeSpell("shockwave_lv4")
			
			player.registry["learned_call_lightning_lv1"] = 0 player:removeSpell("call_lightning_lv1")
			player.registry["learned_call_lightning_lv2"] = 0 player:removeSpell("call_lightning_lv1")
			
			player.registry["learned_electric_barrier"] = 0 player:removeSpell("electric_barrier")
			player.registry["learned_thunderstorm"] = 0 player:removeSpell("thunderstorm")

			
		elseif player.registry["wizard_element_choice"] == 2 then --Fire
			

			player.registry["learned_snowstorm_lv1"] = 0 player:removeSpell("snowstorm_lv1")
			player.registry["learned_snowstorm_lv2"] = 0 player:removeSpell("snowstorm_lv2")
			player.registry["learned_snowstorm_lv3"] = 0 player:removeSpell("snowstorm_lv3")
			player.registry["learned_snowstorm_lv4"] = 0 player:removeSpell("snowstorm_lv4")
			player.registry["learned_snowstorm_lv5"] = 0 player:removeSpell("snowstorm_lv5")
			
			player.registry["learned_cone_of_cold_lv1"] = 0 player:removeSpell("cone_of_cold_lv1")
			player.registry["learned_cone_of_cold_lv2"] = 0 player:removeSpell("cone_of_cold_lv2")
			player.registry["learned_cone_of_cold_lv3"] = 0 player:removeSpell("cone_of_cold_lv3")
			player.registry["learned_cone_of_cold_lv4"] = 0 player:removeSpell("cone_of_cold_lv4")
			
			player.registry["learned_hailstorm_lv1"] = 0 player:removeSpell("hailstorm_lv1")
			player.registry["learned_hailstorm_lv2"] = 0 player:removeSpell("hailstorm_lv2")
			
			player.registry["learned_ice_armor"] = 0 player:removeSpell("ice_armor")
			player.registry["learned_flurry"] = 0 player:removeSpell("flurry")

			player.registry["learned_zap_lv1"] = 0 player:removeSpell("zap_lv1")
			player.registry["learned_zap_lv2"] = 0 player:removeSpell("zap_lv2")
			player.registry["learned_zap_lv3"] = 0 player:removeSpell("zap_lv3")
			player.registry["learned_zap_lv4"] = 0 player:removeSpell("zap_lv4")
			player.registry["learned_zap_lv5"] = 0 player:removeSpell("zap_lv5")
			
			player.registry["learned_shockwave_lv1"] = 0 player:removeSpell("shockwave_lv1")
			player.registry["learned_shockwave_lv2"] = 0 player:removeSpell("shockwave_lv2")
			player.registry["learned_shockwave_lv3"] = 0 player:removeSpell("shockwave_lv3")
			player.registry["learned_shockwave_lv4"] = 0 player:removeSpell("shockwave_lv4")
			
			player.registry["learned_call_lightning_lv1"] = 0 player:removeSpell("call_lightning_lv1")
			player.registry["learned_call_lightning_lv2"] = 0 player:removeSpell("call_lightning_lv1")
			
			player.registry["learned_electric_barrier"] = 0 player:removeSpell("electric_barrier")
			player.registry["learned_thunderstorm"] = 0 player:removeSpell("thunderstorm")


			
		elseif player.registry["wizard_element_choice"] == 3 then --Lightning
					
			player.registry["learned_snowstorm_lv1"] = 0 player:removeSpell("snowstorm_lv1")
			player.registry["learned_snowstorm_lv2"] = 0 player:removeSpell("snowstorm_lv2")
			player.registry["learned_snowstorm_lv3"] = 0 player:removeSpell("snowstorm_lv3")
			player.registry["learned_snowstorm_lv4"] = 0 player:removeSpell("snowstorm_lv4")
			player.registry["learned_snowstorm_lv5"] = 0 player:removeSpell("snowstorm_lv5")
			
			player.registry["learned_cone_of_cold_lv1"] = 0 player:removeSpell("cone_of_cold_lv1")
			player.registry["learned_cone_of_cold_lv2"] = 0 player:removeSpell("cone_of_cold_lv2")
			player.registry["learned_cone_of_cold_lv3"] = 0 player:removeSpell("cone_of_cold_lv3")
			player.registry["learned_cone_of_cold_lv4"] = 0 player:removeSpell("cone_of_cold_lv4")
			
			player.registry["learned_hailstorm_lv1"] = 0 player:removeSpell("hailstorm_lv1")
			player.registry["learned_hailstorm_lv2"] = 0 player:removeSpell("hailstorm_lv2")
			
			player.registry["learned_ice_armor"] = 0 player:removeSpell("ice_armor")
			player.registry["learned_flurry"] = 0 player:removeSpell("flurry")


			player.registry["learned_flare_lv1"] = 0 
			player:removeSpell("flare_lv1")
			player.registry["learned_flare_lv2"] = 0 
			player:removeSpell("flare_lv2")
			player.registry["learned_flare_lv3"] = 0 
			player:removeSpell("flare_lv3")
			player.registry["learned_flare_lv4"] = 0 
			player:removeSpell("flare_lv4")
			player.registry["learned_flare_lv5"] = 0 
			player:removeSpell("flare_lv5")
			
			player.registry["learned_burning_hands_lv1"] = 0 player:removeSpell("burning_hands_lv1")
			player.registry["learned_burning_hands_lv2"] = 0 player:removeSpell("burning_hands_lv2")
			player.registry["learned_burning_hands_lv3"] = 0 player:removeSpell("burning_hands_lv3")
			player.registry["learned_burning_hands_lv4"] = 0 player:removeSpell("burning_hands_lv4")
			
			player.registry["learned_fireball_lv1"] = 0 player:removeSpell("fireball_lv1")
			player.registry["learned_fireball_lv2"] = 0 player:removeSpell("fireball_lv2")
			
			player.registry["learned_flame_shield"] = 0 player:removeSpell("flame_shield")
			player.registry["learned_flame_surge"] = 0 player:removeSpell("flame_surge")

			
		end

end