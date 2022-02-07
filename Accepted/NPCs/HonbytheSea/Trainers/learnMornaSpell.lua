learnMornaSpell = function(player, npc)
	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	local spells, yname, name, name2 = {}, {}, {}, {}
	local class = string.lower(player.classNameMark)

	-- Warrior --
	if player.class == 31 then
		-- Rogue --
		if class == "fighter" then
			spells = {
				"Basic First Aid",
				"Gateway",
				"Combat Awareness",
				"Power Attack",
				"Provoke",
				"Combat Intuition",
				"Weapon Focus",
				"Minor First Aid",
				"Brutal Throw",
				"Whirlwind Attack",
				"Combat Devotion",
				"Wild Strike",
				"Taunt Over Time",
				"Cleave",
				"Combat Trance",
				"Great Cleave",
				"Room Provoke",
				"Pommel Strike",
				"Advanced First Aid",
				"Battle Stance"
			}
			yname = {
				"basic_first_aid",
				"gateway",
				"combat_awareness",
				"power_attack",
				"provoke",
				"combat_intuition",
				"weapon_focus",
				"minor_first_aid",
				"brutal_throw",
				"whirlwind_attack",
				"combat_devotion",
				"wild_strike",
				"taunt_over_time",
				"cleave",
				"combat_trance",
				"great_cleave",
				"room_provoke",
				"pommel_strike",
				"advanced_first_aid",
				"battle_stance"
			}
		end
	elseif player.class == 32 then
		-- Mage --
		if class == "scoundrel" then
			spells = {
				"Basic First Aid",
				"Gateway",
				"Stab",
				"Evade",
				"Combat Perception",
				"Hide in Shadows",
				"Chew Dry Herbs",
				"Combat Foresight",
				"Coup De Grace",
				"Blinding Dust",
				"Ocular Patdown",
				"Combat Clairvoyance",
				"Assassination",
				"Tranq Dart",
				"Flurry of Knives",
				"Combat Premonition",
				"Pierce Vitals",
				"Herbal Stimulant",
				"Dashing Slash"
			}
			yname = {
				"basic_first_aid",
				"gateway",
				"stab",
				"evade",
				"combat_perception",
				"hide_in_shadows",
				"chew_dry_herbs",
				"combat_foresight",
				"coup_de_grace",
				"blinding_dust",
				"ocular_patdown",
				"combat_clairvoyance",
				"assassination",
				"tranq_dart",
				"flurry_of_knives",
				"combat_premonition",
				"pierce_vitals",
				"herbal_stimulant",
				"dashing_slash"
			}
		end
	elseif player.class == 33 then
		-- Poet --
		if class == "wizard" then
			spells = {
				"Basic First Aid",
				"Gateway",
				"Flashbang",
				"Snowstorm",
				"Static",
				"Rest",
				"Flashbang Lv2",
				"Snowstorm Lv2",
				"Obscure Vision",
				"Hailstorm",
				"Apprentice Heal",
				"Remove Petrify",
				"Petrify",
				"Flashbang Lv3",
				"Snowstorm Lv3",
				"Static Lv2",
				"Flurry",
				"Hailstorm Lv2",
				"Make Invis",
				"Rest Lv2",
				"Flashbang Lv4",
				"Snowstorm Lv4",
				"Flurry Lv2",
				"Hailstorm Lv3",
				"Greater Petrify",
				"Freeze Solid",
				"Magus Heal",
				"Flashbang Lv5",
				"Snowstorm Lv5",
				"Hailstorm Lv4",
				"Flurry Lv3",
				"Rest Lv3",
				"Mass Petrify",
				"Tsunami",
				"Group Dot",
				"Mass invis"
			}
			yname = {
				"basic_first_aid",
				"gateway",
				"flashbang",
				"snowstorm",
				"static",
				"rest",
				"flashbang2",
				"snowstorm2",
				"obscure_vision",
				"hailstorm",
				"apprentice_heal",
				"remove_petrify",
				"petrify",
				"flashbang3",
				"snowstorm3",
				"static2",
				"flurry",
				"hailstorm2",
				"make_invis",
				"rest2",
				"flashbang4",
				"snowstorm4",
				"flurry2",
				"hailstorm3",
				"greater_petrify",
				"freeze_solid",
				"magus_heal",
				"flashbang5",
				"snowstorm5",
				"hailstorm4",
				"flurry3",
				"rest3",
				"mass_petrify",
				"tsunami",
				"group_dot",
				"mass_invis"
			}
		end
	elseif player.class == 34 then
		if class == "priest" then
			spells = {
				"Basic First Aid",
				"Gateway",
				"Hot Lv1",
				"Club Strike",
				"Minor Blessing",
				"HoT Lv2",
				"Blinding Light",
				"Pray",
				"Clear Vision",
				"Knockback Strike",
				"HoT Lv3",
				"Lunging Club Strike",
				"",
				"Raise Dead",
				"HoT Lv4",
				"Club Combo",
				"Hold Person",
				"Pray Lv2",
				"Searing Light",
				"",
				"Mass Raise Dead",
				"Hot Lv5",
				"Holy Blessing",
				"Pray Lv3",
				"Smite Evil",
				"Hold People",
				"Lullaby",
				"Self Revival"
			}
			yname = {
				"basic_first_aid",
				"gateway",
				"heal_over_time",
				"club_strike",
				"minor_blessing",
				"heal_over_time2",
				"blinding_light",
				"pray",
				"clear_vision",
				"knockback_strike",
				"heal_over_time3",
				"lunging_club_strike",
				"",
				"raise_dead",
				"heal_over_time4",
				"club_combo",
				"hold_person",
				"pray2",
				"searing_light",
				"mass_raise_dead",
				"heal_over_time5",
				"holy_blessing",
				"pray3",
				"smite_evil",
				"hold_people",
				"lullaby",
				"self_revival"
			}
		end
	end

	if #spells == 0 then
		return nil
	else
		if #yname == #spells then
			for i = 1, #yname do
				if not player:hasSpell(yname[i]) then
					table.insert(name, spells[i])
					table.insert(name2, yname[i])
				end
			end
		end
	end
	--	if #name > 0 then
	--		if #name == #name2 then
	--			subpath_master.learn(player, npc, name, name2)
	--		end
	--	else
	--		player:dialogSeq({t, "<b>[Subpath Master]\n\nThere's no spell that you can learn anymore.."})
	--	end
	--end,

	learn = function(player, npc, spell, yname)
		local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		local slot = 0

		if #spell == 0 or #yname == 0 then
			return nil
		else
			menu = player:menuSeq("<b>[Subpath Master]\n\nWhat spell do you wish to learn?", spell, {})
			for i = 1, #yname do
				if menu == i then
					slot = i
					break
				end
			end
			if slot == 0 then
				return nil
			else
				if not player:hasSpell(yname[slot]) then
					confirm =
						player:menuString(
						"<b>[Subpath Master]\n\nTo learn " .. spell[slot] .. " you need to pay 50,000 coins.",
						{"Learn " .. spell[slot], "Cancel"}
					)
					if confirm == "Learn " .. spell[slot] then
						if player:removeGold(50000) == false then
							player:dialogSeq({t, "<b>[Subpath Master]\n\nYou don't have enough money!"})
							return
						else
							player:sendMinitext("Pay 50,000 coins")
							player:addSpell(yname[slot])
							player:sendAnimation(350)
							player:playSound(112)
							player:sendMinitext("Your mind expands as you learn " .. spell[slot])
						end
					end
				end
			end
		end
	end
end
