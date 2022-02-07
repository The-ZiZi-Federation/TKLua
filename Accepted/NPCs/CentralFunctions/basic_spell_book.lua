basic_spell_book = {
	click = function(player, npc)
		local t = {graphic = convertGraphic(1439, "monster"), color = 0}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0

		local opts = {}

		if player.baseClass == 1 or player.baseClass == 5 then
			table.insert(opts, "Fighter Skills")
		end
		if player.baseClass == 2 or player.baseClass == 5 then
			table.insert(opts, "Scoundrel Abilities")
		end
		if player.baseClass == 3 or player.baseClass == 5 then
			table.insert(opts, "Wizards Spells")
		end
		if player.baseClass == 4 or player.baseClass == 5 then
			table.insert(opts, "Priest Prayers")
		end

		menu = player:menuString("<b>[Cave Chart]", opts)

		if menu == "Fighter Skills" then
			basic_spell_book.fighter_skills(player)
		elseif menu == "Scoundrel Abilities" then
			basic_spell_book.scoundrel_abilities(player)
		elseif menu == "Wizards Spells" then
			basic_spell_book.wizard_spells(player)
		elseif menu == "Priest Prayers" then
			basic_spell_book.priest_prayers(player)
		end
	end,
	------FIGHTER-SKILLS------------TABLE-INSERT------------------------------------------------------------------

	fighter_skills = function(player)
		----------------------
		--Varable Declarations
		----------------------
		local npc = core
		local name = ""
		local t = {graphic = convertGraphic(1439, "monster"), color = 0}
		player.dialogType = 0
		local fighterSkills = {}
		------------------------------------------
		--Build spellbook table of contents for the FIGHTER
		------------------------------------------
		if player.gmLevel > 0 then
			table.insert(fighterSkills, "    _______            ________       ")
			table.insert(fighterSkills, "   |Offense|          |Lockdown|      ")
			table.insert(fighterSkills, "--------------------------------------")
			table.insert(fighterSkills, "Lv 10: Power Attack                   ")
			table.insert(fighterSkills, "Lv 35: Wide Slash                     ")
			table.insert(fighterSkills, "                                      ")
			table.insert(fighterSkills, "       Lv 50: Whirlwind Slash         ")
			table.insert(fighterSkills, "                  |                   ")
			table.insert(fighterSkills, "       Lv 70: Cleave                  ")
			table.insert(fighterSkills, "                  |                   ")
			table.insert(fighterSkills, "       Lv 99: Greater Cleave          ")
			table.insert(fighterSkills, "                                      ")
			table.insert(fighterSkills, "Lv 60: Weapon Focus                   ")
			table.insert(fighterSkills, "Lv 85: Brutal Throw                   ")
			table.insert(fighterSkills, "                _____                 ")
			table.insert(fighterSkills, "               |Heals|                ")
			table.insert(fighterSkills, "--------------------------------------")
			table.insert(fighterSkills, "       Lv 20: Minor First Aid         ")
			table.insert(fighterSkills, "                  |                   ")
			table.insert(fighterSkills, "       Lv 80: Advanced First Aid      ")
			table.insert(fighterSkills, "                                      ")
			table.insert(fighterSkills, "       Lv 15: Second Wind             ")
			table.insert(fighterSkills, "            ____________              ")
			table.insert(fighterSkills, "           |Other Spells|             ")
			table.insert(fighterSkills, "--------------------------------------")
			table.insert(fighterSkills, "Lv 25: Intimidate                     ")
			table.insert(fighterSkills, "Lv 35: Provoke                        ")
			table.insert(fighterSkills, "Lv 85: Pommel Strike                  ")
			table.insert(fighterSkills, "Lv 99: Room Provoke                   ")
			table.insert(fighterSkills, "               ______                 ")
			table.insert(fighterSkills, "              |Furies|                ")
			table.insert(fighterSkills, "--------------------------------------")
			table.insert(fighterSkills, "       Lv 05: Combat Awareness        ")
			table.insert(fighterSkills, "                  |                   ")
			table.insert(fighterSkills, "       Lv 25: Combat Intuition        ")
			table.insert(fighterSkills, "                  |                   ")
			table.insert(fighterSkills, "       Lv 50: Combat Affinity         ")
			table.insert(fighterSkills, "                  |                   ")
			table.insert(fighterSkills, "       Lv 75: Combat Devotion         ")
			table.insert(fighterSkills, "                  |                   ")
			table.insert(fighterSkills, "       Lv 99: Combat Trance           ")
			table.insert(fighterSkills, "--------------------------------------")
		end
		 --
		--[[
	if player.registry["learned_second_wind"] == 1 or player.class == 50  then
	if player.registry["learned_power_attack"] == 1 or player.class == 50  then
	if player.registry["learned_bolster_armor"] == 1 or player.class == 50  then
	elseif player.registry["learned_minor_first_aid"] == 1 then
	elseif player.registry["learned_advanced_first_aid"] == 1 then
	if player.registry["learned_intimidate"] == 1 or player.class == 50  then
	if player.registry["learned_provoke"] == 1 or player.class == 50  then
	if player.registry["learned_wide_slash"] == 1 or player.class == 50  then
	if player.registry["learned_knockback_strike"] == 1 or player.class == 50  then
	elseif  player.registry["learned_whirlwind_attack"] == 1 then
	elseif  player.registry["learned_cleave"] == 1 then
	if player.registry["learned_weapon_focus"] == 1 or player.class == 50  then
	if player.registry["learned_defense_focus"] == 1 or player.class == 50  then
	if player.registry["learned_pommel_strike"] == 1 or player.class == 50  then
	if player.registry["learned_brutal_throw"] == 1 or player.class == 50  then
	if player.registry["learned_shield_rush"] == 1 or player.class == 50  then
	if player.registry["learned_battle_stance"] == 1 or player.class == 50  then
	if player.registry["learned_room_provoke"] == 1 or player.class == 50  then
]] ------FIGHTER-SKILLS-------SKILL-DETAILS-----------------------------------------------------------------------

		menu = player:menuString("<b>[Fighter Skills]", fighterSkills)

		if menu == "Level 05: Basic First Aid" then
			name = "<b>[Basic First Aid]\n\n"
			player:dialogSeq(
				{
					t,
					name ..
						"Required Level: 001\nSkill Type: Heal\nMana Cost: 10\nBase Heal: Will Bonus %\nTrainer: Dre Loc\nSkill Cost: Free\n Targets: Self",
					name .. "Skill Description:\nHealing base is 25 points and scales upward with your Will Bonus Percentage.",
					name .. "This skill is replaced when you upgrade and learn Minor First Aid."
				},
				1
			)
			basic_spell_book.fighter_skills(player)
		elseif menu == "Level 01: Gateway" then
			name = "<b>[Gateway]\n\n"
			player:dialogSeq(
				{
					t,
					name ..
						"Required Level: 001\nSkill Type: Teleport\nMana Cost: 0\nTrainer: Dre Loc\nSkill Cost: Free\n Targets: Self",
					name .. "Skill Description:\nTravel Quickly Around Hon by the Sea. N, E, S, or W to travel between the gates.",
					name .. "This skill is replaced what you upgade and learn Gateway Lv2."
				},
				1
			)
			if player.baseClass == 5 then
				player:dialogSeq({t, name .. "Hi Delmar."}, 1)
				basic_spell_book.fighter_skills(player)
			else
				basic_spell_book.fighter_skills(player)
			end
		elseif menu == "Level 05: Combat Awareness" then
			name = "<b>[Combat Awareness]\n\n"
			player:dialogSeq(
				{
					t,
					name ..
						"Required Level: 005\nSkill Type: Buff\nMana Cost: ?\nAethers: 0\nDuration: 10 Minutes\nTrainer: Jamlamin\nSkill Cost: Free\n Targets: Self",
					name ..
						"Skill Description:\nFighters first fury skill. This allows the caster to gain great strength in combat dealing more damage.",
					name .. "This skill is required to learn Combat Intuition and is replaced when you upgrade."
				},
				1
			)
			if player.baseClass == 5 then
				player:dialogSeq({t, name .. "Fury Multiplier: 2"}, 1)
				basic_spell_book.fighter_skills(player)
			else
				basic_spell_book.fighter_skills(player)
			end
		elseif menu == "Level 015: Second Wind" then
			name = "<b>[Second Wind]\n\n"
			player:dialogSeq(
				{
					t,
					name ..
						"Required Level: 015\nSkill Type: Mana Replenish\nMana Cost: 0\nAethers: 15 Seconds\nDuration: 2.5 Seconds\nTrainer: Jamlamin\nSkill Cost: 300 Coins\n Targets: Self",
					name .. "Skill Description:\nTake a knee and catch your breath. Restores some of your Mana."
				},
				1
			)
			if player.baseClass == 5 then
				player:dialogSeq({t, name .. "Formula\n----------\n\nplayer.magic = player.magic + (player.maxMagic*.35)"}, 1)
				basic_spell_book.fighter_skills(player)
			else
				basic_spell_book.fighter_skills(player)
			end
		elseif menu == "Level 015: Power Attack" then
			levelRequired = 15
			spellMaxTargets = 1
			currentManaCost = (level * 2.5)
			spellType = "Attack"
			damageType = "Physical"
			baseManaCost = "Level x 2.5"
			damageBase = "100"
			spellAether = "5"
			spellTrainer = "Jamlamin"

			spellCost01 = "1,000 Gold" -- Coin Cost
			spellCost02 = " "
			SpellCost03 = " "

			targetLine01 = " O X O "
			targetLine02 = " O P O "
			targetLine03 = " O O O "
			targetDescription = "This will hit one target that you are facing."
			skillDescription = "You wind back and swing with great power at your enemy."

			spellDamage = math.floor(((100 + ((finalSwingDamage * 3) + (mightBonusPctDamage) * (might ^ 0.5)) * 0.5) * buff))
			spellDamagePerTarget = math.floor(spellDamage / spellMaxTargets)
			currentSpellDPSPerTarget = math.floor((spellDamagePerTarget / spellAether))

			name = "<b>[Power Attack]\n\n"
			--(demo line) player:dialogSeq({t, name.."Required Level: "..levelRequired.."\n   Damage Type: "..damageType.."\n    Skill Type: "..spellType.."\nMana Cost Base: "..baseManaCost.."\nCur. Mana Cost: "..currentManaCost.."   Base Damage: "..damageBase.."\nCur. Dmg P/Sec: "..currentSpellDPS.."        Aether: "..spellAether.." Seconds\n       Trainer: "..spellTrainer.."\n          Cost:\n   "..spellCost01.." Coins\n   "..spellCost02.."\n   "..spellCost03.."\n",
			player:dialogSeq(
				{
					t,
					name ..
						"Required Level: " ..
							levelRequired ..
								"\n   Damage Type: " ..
									damageType ..
										"\n    Skill Type: " ..
											spellType ..
												"\nMana Cost Base: " ..
													baseManaCost ..
														"\nCur. Mana Cost: " ..
															currentManaCost ..
																"\n   Base Damage: " ..
																	damageBase ..
																		"\n Cur. Total Damage:" ..
																			spellDamage ..
																				"\n Number of Targets:" ..
																					spellMaxTargets ..
																						"\n        Aether: " ..
																							spellAether ..
																								" Seconds\n Cur. DPS p/Target: " ..
																									currentSpellDPSPerTarget ..
																										"\n       Trainer: " .. spellTrainer .. "\n          Cost:\n   " .. spellCost01 .. " Coins\n",
					name ..
						"     | Targets |\n     +---------+\n Max Number of Targets: " ..
							spellMaxTargets ..
								"\n\n       " ..
									targetLine01 ..
										"\n       " .. targetLine02 .. "\n       " .. targetLine03 .. "\n\n" .. targetDescription .. "\n",
					name .. "Skill Description:\n\n" .. skillDescription .. "\n"
				},
				1
			)

			if player.baseClass == 5 then
				player:dialogSeq(
					{
						t,
						name ..
							"Values:\n\n Swing Damage: " ..
								finalSwingDamage ..
									"\n MightBonusPc: " ..
										mightBonusPctDisplay .. "\n        Might: " .. might .. "\n Spell Damage: " .. spellDamage .. "\n",
						name ..
							"Formula:\n\n Spell Damage on Cast= " ..
								spellDamage ..
									" = (100 + (( " ..
										finalSwingDamage ..
											" * 3) + ( " ..
												finalSwingDamage ..
													" * " ..
														mightBonusPct ..
															" ) * ( " ..
																might ..
																	" ^ 0.5) * 0.5) * " ..
																		buff .. " )\n\n Cur. Mana Cost: " .. currentManaCost .. "\nCur. Dmg P/Sec: " .. currentSpellDPS .. ""
					},
					1
				)
				basic_spell_book.fighter_skills(player)
			else
				basic_spell_book.fighter_skills(player)
			end
		elseif menu == "Level 015: Bolster Armor" then
			name = "<b>[Bolster Armor]\n\n"
			player:dialogSeq({t, name .. ""}, 1)

			if player.baseClass == 5 then
				player:dialogSeq({t, name .. "Formula\n----------\n\n"}, 1)
				basic_spell_book.fighter_skills(player)
			else
				basic_spell_book.fighter_skills(player)
			end
		elseif menu == "Level 020: Minor First Aid" then
			name = "<b>[Minor First Aid]\n\n"
			player:dialogSeq({t, name .. ""}, 1)
			if player.baseClass == 5 then
				player:dialogSeq({t, name .. "Formula\n----------\n\n"}, 1)
				basic_spell_book.fighter_skills(player)
			else
				basic_spell_book.fighter_skills(player)
			end
		elseif menu == "--> Level 025: Combat Intuition" then
			name = "<b>[Combat Intuition]\n\n"
			player:dialogSeq({t, name .. ""}, 1)
			if player.baseClass == 5 then
				player:dialogSeq({t, name .. "Formula\n----------\n\n"}, 1)
				basic_spell_book.fighter_skills(player)
			else
				basic_spell_book.fighter_skills(player)
			end
		elseif menu == "Level 025: Intimidate" then
			name = "<b>[Intimidate]\n\n"
			player:dialogSeq({t, name .. ""}, 1)
			if player.baseClass == 5 then
				player:dialogSeq({t, name .. "Formula\n----------\n\n"}, 1)
				basic_spell_book.fighter_skills(player)
			else
				basic_spell_book.fighter_skills(player)
			end
		elseif menu == "Level 035: Provoke" then
			name = "<b>[Provoke]\n\n"
			player:dialogSeq({t, name .. ""}, 1)
			if player.baseClass == 5 then
				player:dialogSeq({t, name .. "Formula\n----------\n\n"}, 1)
				basic_spell_book.fighter_skills(player)
			else
				basic_spell_book.fighter_skills(player)
			end
		elseif menu == "Level 035: Wide Slash" then
			name = "<b>[Wide Slash]\n\n"
			player:dialogSeq({t, name .. ""}, 1)

			levelRequired = 35
			spellMaxTargets = 3
			currentManaCost = (level * 5.5)
			spellType = "Attack"
			damageType = "Physical"
			baseManaCost = "Level x 5.5"
			damageBase = "2000"
			spellAether = "12"
			spellTrainer = "Jamlamin"

			spellCost01 = "1,000 Gold" -- Coin Cost
			spellCost02 = " "
			SpellCost03 = " "

			targetLine01 = " X X X "
			targetLine02 = " O P O "
			targetLine03 = " O O O "
			targetDescription = "Test"
			skillDescription = "Test"

			spellDamage = math.floor((2000 + ((finalSwingDamage * 4) + (finalSwingDamage * mightBonusPct) * (might ^ 0.6))))
			currentSpellDPS = math.floor((spellDamage / spellMaxTargets))

			player:dialogSeq(
				{
					t,
					name ..
						"Required Level: " ..
							levelRequired ..
								"\n   Damage Type: " ..
									damageType ..
										"\n    Skill Type: " ..
											spellType ..
												"\nMana Cost Base: " ..
													baseManaCost ..
														"\nCur. Mana Cost: " ..
															currentManaCost ..
																"\n   Base Damage: " ..
																	damageBase ..
																		"\nCur. Dmg P/Sec: " ..
																			currentSpellDPS ..
																				"\n        Aether: " ..
																					spellAether ..
																						" Seconds\n       Trainer: " ..
																							spellTrainer .. "\n          Cost:\n   " .. spellCost01 .. " Coins\n",
					name ..
						"     | Targets |\n     +---------+\n Max Number of Targets: " ..
							spellMaxTargets ..
								"\n\n       " ..
									targetLine01 ..
										"\n       " .. targetLine02 .. "\n       " .. targetLine03 .. "\n\n" .. targetDescription .. "\n",
					name .. "Skill Description:\n\n" .. skillDescription .. "\n"
				},
				1
			)

			if player.baseClass == 5 then
				player:dialogSeq(
					{
						t,
						name ..
							"Values:\n\n Swing Damage: " ..
								finalSwingDamage ..
									"\n MightBonusPc: " ..
										mightBonusPctDisplay .. "\n        Might: " .. might .. "\n Spell Damage: " .. spellDamage .. "\n",
						name ..
							"Formula:\n\n Spell Damage on Cast= " ..
								spellDamage ..
									" = (2000 + (( " ..
										finalSwingDamage ..
											" * 4) + ( " ..
												finalSwingDamage ..
													" * " ..
														mightBonusPct ..
															" ) * ( " ..
																might ..
																	" ^ 0.6)))\n\n Cur. Mana Cost: " .. currentManaCost .. "\nCur. Dmg P/Sec: " .. currentSpellDPS .. ""
					},
					1
				)
				basic_spell_book.fighter_skills(player)
			else
				basic_spell_book.fighter_skills(player)
			end
		elseif menu == "Level 035: Knockback Strike" then
			name = "<b>[Knockback Strike]\n\n"
			player:dialogSeq({t, name .. ""}, 1)

			levelRequired = 35
			spellMaxTargets = 1
			currentManaCost = 3 * (level * 1.5)
			spellType = "Attack"
			damageType = "Physical"
			baseManaCost = "3 *(Level x 1.5)"
			damageBase = "1000"
			spellAether = "12"
			spellTrainer = "Jamlamin"

			spellCost01 = "1,000 Gold" -- Coin Cost
			spellCost02 = " "
			SpellCost03 = " "

			targetLine01 = " O X O "
			targetLine02 = " O P O "
			targetLine03 = " O O O "
			targetDescription = "Test"
			skillDescription = "Test"

			spellDamage = math.floor((1000 + ((finalSwingDamage * 3) + (finalSwingDamage * mightBonusPct) * (might ^ 0.55))))
			currentSpellDPS = math.floor((spellDamage / spellMaxTargets))
			player:dialogSeq(
				{
					t,
					name ..
						"Required Level: " ..
							levelRequired ..
								"\n   Damage Type: " ..
									damageType ..
										"\n    Skill Type: " ..
											spellType ..
												"\nMana Cost Base: " ..
													baseManaCost ..
														"\nCur. Mana Cost: " ..
															currentManaCost ..
																"\n   Base Damage: " ..
																	damageBase ..
																		"\nCur. Dmg P/Sec: " ..
																			currentSpellDPS ..
																				"\n        Aether: " ..
																					spellAether ..
																						" Seconds\n       Trainer: " ..
																							spellTrainer .. "\n          Cost:\n   " .. spellCost01 .. " Coins\n",
					name ..
						"     | Targets |\n     +---------+\n Max Number of Targets: " ..
							spellMaxTargets ..
								"\n\n       " ..
									targetLine01 ..
										"\n       " .. targetLine02 .. "\n       " .. targetLine03 .. "\n\n" .. targetDescription .. "\n",
					name .. "Skill Description:\n\n" .. skillDescription .. "\n"
				},
				1
			)

			if player.baseClass == 5 then
				player:dialogSeq(
					{
						t,
						name ..
							"Values:\n\n Swing Damage: " ..
								finalSwingDamage ..
									"\n MightBonusPc: " ..
										mightBonusPctDisplay .. "\n        Might: " .. might .. "\n Spell Damage: " .. spellDamage .. "\n",
						name ..
							"Formula:\n\n Spell Damage on Cast= " ..
								spellDamage ..
									" = (1000 + (( " ..
										finalSwingDamage ..
											" * 3) + ( " ..
												finalSwingDamage ..
													" * " ..
														mightBonusPct ..
															" ) * ( " ..
																might ..
																	" ^ 0.55)))\n\n Cur. Mana Cost: " .. currentManaCost .. "\nCur. Dmg P/Sec: " .. currentSpellDPS .. ""
					},
					1
				)
				basic_spell_book.fighter_skills(player)
			else
				basic_spell_book.fighter_skills(player)
			end
		elseif menu == " --> Level 050: Combat Affinity" then
			name = "<b>[Combat Affinity]\n\n"
			player:dialogSeq({t, name .. ""}, 1)
			if player.baseClass == 5 then
				player:dialogSeq({t, name .. "Formula\n----------\n\n"}, 1)
				basic_spell_book.fighter_skills(player)
			else
				basic_spell_book.fighter_skills(player)
			end
		elseif menu == "Level 050: Whirlwind Attack" then
			name = "<b>[Whirlwind Attack]\n\n"
			player:dialogSeq({t, name .. ""}, 1)

			levelRequired = 50
			spellMaxTargets = 18
			currentManaCost = (level * 12)
			spellType = "Attack"
			damageType = "Physical"
			baseManaCost = "(Level x 12)"
			damageBase = "4000"
			spellAether = "8"
			spellTrainer = "Jamlamin"

			spellCost01 = "1,000 Gold" -- Coin Cost
			spellCost02 = " "
			SpellCost03 = " "

			targetLine01 = " X X X "
			targetLine02 = " X P X "
			targetLine03 = " X X X "
			targetDescription = "Test"
			skillDescription = "Test"

			spellDamage = math.floor((4000 + ((finalSwingDamage * 1.5) + (finalSwingDamage * mightBonusPct) * (might ^ 0.835))))
			currentSpellDPS = math.floor((spellDamage / spellMaxTargets))
			player:dialogSeq(
				{
					t,
					name ..
						"Required Level: " ..
							levelRequired ..
								"\n   Damage Type: " ..
									damageType ..
										"\n    Skill Type: " ..
											spellType ..
												"\nMana Cost Base: " ..
													baseManaCost ..
														"\nCur. Mana Cost: " ..
															currentManaCost ..
																"\n   Base Damage: " ..
																	damageBase ..
																		"\nCur. Dmg P/Sec: " ..
																			currentSpellDPS ..
																				"\n        Aether: " ..
																					spellAether ..
																						" Seconds\n       Trainer: " ..
																							spellTrainer .. "\n          Cost:\n   " .. spellCost01 .. " Coins\n",
					name ..
						"     | Targets |\n     +---------+\n Max Number of Targets: " ..
							spellMaxTargets ..
								"\n\n       " ..
									targetLine01 ..
										"\n       " .. targetLine02 .. "\n       " .. targetLine03 .. "\n\n" .. targetDescription .. "\n",
					name .. "Skill Description:\n\n" .. skillDescription .. "\n"
				},
				1
			)

			if player.baseClass == 5 then
				player:dialogSeq(
					{
						t,
						name ..
							"Values:\n\n Swing Damage: " ..
								finalSwingDamage ..
									"\n MightBonusPc: " ..
										mightBonusPctDisplay .. "\n        Might: " .. might .. "\n Spell Damage: " .. spellDamage .. "\n",
						name ..
							"Formula:\n\n Spell Damage on Cast= " ..
								spellDamage ..
									" = (4000 + (( " ..
										finalSwingDamage ..
											" * 1.5) + ( " ..
												finalSwingDamage ..
													" * " ..
														mightBonusPct ..
															" ) * ( " ..
																might ..
																	" ^ 0.835)))\n\n Cur. Mana Cost: " .. currentManaCost .. "\nCur. Dmg P/Sec: " .. currentSpellDPS .. ""
					},
					1
				)
				basic_spell_book.fighter_skills(player)
			else
				basic_spell_book.fighter_skills(player)
			end
		elseif menu == "Level 060: Weapon Focus" then
			name = "<b>[Weapon Focus]\n\n"
			player:dialogSeq({t, name .. ""}, 1)
			if player.baseClass == 5 then
				player:dialogSeq({t, name .. "Formula\n----------\n\n"}, 1)
				basic_spell_book.fighter_skills(player)
			else
				basic_spell_book.fighter_skills(player)
			end
		elseif menu == "Level 060: Defense Focus" then
			name = "<b>[Defense Focus]\n\n"
			player:dialogSeq({t, name .. ""}, 1)
			if player.baseClass == 5 then
				player:dialogSeq({t, name .. "Formula\n----------\n\n"}, 1)
				basic_spell_book.fighter_skills(player)
			else
				basic_spell_book.fighter_skills(player)
			end
		elseif menu == "--> Level 070: Cleave" then
			name = "<b>[Cleave]\n\n"
			player:dialogSeq({t, name .. ""}, 1)

			levelRequired = 70
			spellMaxTargets = 8
			currentManaCost = (level * 18)
			spellType = "Attack"
			damageType = "Physical"
			baseManaCost = "(Level x 18)"
			damageBase = "10000"
			spellAether = "21"
			spellTrainer = "Jamlamin"

			spellCost01 = "1,000 Gold" -- Coin Cost
			spellCost02 = " "
			SpellCost03 = " "

			targetLine01 = " X X X "
			targetLine02 = " X P X "
			targetLine03 = " X X X "
			targetDescription = "Test"
			skillDescription = "Test"

			spellDamage = math.floor((10000 + ((finalSwingDamage * 1.8) + (finalSwingDamage * mightBonusPct) * (might ^ 0.835))))
			currentSpellDPS = math.floor((spellDamage / spellMaxTargets))
			player:dialogSeq(
				{
					t,
					name ..
						"Required Level: " ..
							levelRequired ..
								"\n   Damage Type: " ..
									damageType ..
										"\n    Skill Type: " ..
											spellType ..
												"\nMana Cost Base: " ..
													baseManaCost ..
														"\nCur. Mana Cost: " ..
															currentManaCost ..
																"\n   Base Damage: " ..
																	damageBase ..
																		"\nCur. Dmg P/Sec: " ..
																			currentSpellDPS ..
																				"\n        Aether: " ..
																					spellAether ..
																						" Seconds\n       Trainer: " ..
																							spellTrainer .. "\n          Cost:\n   " .. spellCost01 .. " Coins\n",
					name ..
						"     | Targets |\n     +---------+\n Max Number of Targets: " ..
							spellMaxTargets ..
								"\n\n       " ..
									targetLine01 ..
										"\n       " .. targetLine02 .. "\n       " .. targetLine03 .. "\n\n" .. targetDescription .. "\n",
					name .. "Skill Description:\n\n" .. skillDescription .. "\n"
				},
				1
			)

			if player.baseClass == 5 then
				player:dialogSeq(
					{
						t,
						name ..
							"Values:\n\n Swing Damage: " ..
								finalSwingDamage ..
									"\n MightBonusPc: " ..
										mightBonusPctDisplay .. "\n        Might: " .. might .. "\n Spell Damage: " .. spellDamage .. "\n",
						name ..
							"Formula:\n\n Spell Damage on Cast= " ..
								spellDamage ..
									" = (10000 + (( " ..
										finalSwingDamage ..
											" * 1.8) + ( " ..
												finalSwingDamage ..
													" * " ..
														mightBonusPct ..
															" ) * ( " ..
																might ..
																	" ^ 0.835)))\n\n Cur. Mana Cost: " .. currentManaCost .. "\nCur. Dmg P/Sec: " .. currentSpellDPS .. ""
					},
					1
				)
				basic_spell_book.fighter_skills(player)
			else
				basic_spell_book.fighter_skills(player)
			end
		elseif menu == "  --> Level 075: Combat Devotion" then
			name = "<b>[Combat Devotion]\n\n"
			player:dialogSeq({t, name .. ""}, 1)
			if player.baseClass == 5 then
				player:dialogSeq({t, name .. "Formula\n----------\n\n"}, 1)
				basic_spell_book.fighter_skills(player)
			else
				basic_spell_book.fighter_skills(player)
			end
		elseif menu == "--> Level 080: Advanced First Aid" then
			name = "<b>[Advanced First Aid]\n\n"
			player:dialogSeq({t, name .. ""}, 1)
			if player.baseClass == 5 then
				player:dialogSeq({t, name .. "Formula\n----------\n\n"}, 1)
				basic_spell_book.fighter_skills(player)
			else
				basic_spell_book.fighter_skills(player)
			end
		elseif menu == "Level 085: Pommel Strike" then
			name = "<b>[Pommel Strike]\n\n"
			player:dialogSeq({t, name .. ""}, 1)
			if player.baseClass == 5 then
				player:dialogSeq({t, name .. "Formula\n----------\n\n"}, 1)
				basic_spell_book.fighter_skills(player)
			else
				basic_spell_book.fighter_skills(player)
			end
		elseif menu == "Level 085: Brutal Throw" then
			name = "<b>[Brutal Throw]\n\n"
			player:dialogSeq({t, name .. ""}, 1)
			if player.baseClass == 5 then
				player:dialogSeq({t, name .. "Formula\n----------\n\n"}, 1)
				basic_spell_book.fighter_skills(player)
			else
				basic_spell_book.fighter_skills(player)
			end
		elseif menu == "Level 085: Shield Rush" then
			name = "<b>[Shield Rush]\n\n"
			player:dialogSeq({t, name .. ""}, 1)
			if player.baseClass == 5 then
				player:dialogSeq({t, name .. "Formula\n----------\n\n"}, 1)
				basic_spell_book.fighter_skills(player)
			else
				basic_spell_book.fighter_skills(player)
			end
		elseif menu == "Level 095: Battle Stance" then
			name = "<b>[Battle Stance]\n\n"
			player:dialogSeq({t, name .. ""}, 1)
			if player.baseClass == 5 then
				player:dialogSeq({t, name .. "Formula\n----------\n\n"}, 1)
				basic_spell_book.fighter_skills(player)
			else
				basic_spell_book.fighter_skills(player)
			end
		elseif menu == "Level 099: Room provoke" then
			name = "<b>[Room Provoke]\n\n"
			player:dialogSeq({t, name .. ""}, 1)
			if player.baseClass == 5 then
				player:dialogSeq({t, name .. "Formula\n----------\n\n"}, 1)
				basic_spell_book.fighter_skills(player)
			else
				basic_spell_book.fighter_skills(player)
			end
		elseif menu == "   --> Level 099: Combat Trance" then
			name = "<b>[Combat Trance]\n\n"
			player:dialogSeq({t, name .. ""}, 1)
			if player.baseClass == 5 then
				player:dialogSeq({t, name .. "Formula\n----------\n\n"}, 1)
				basic_spell_book.fighter_skills(player)
			else
				basic_spell_book.fighter_skills(player)
			end
		elseif menu == " --> Level 099: Great Cleave" then
			name = "<b>[Great Cleave]\n\n"
			player:dialogSeq({t, name .. ""}, 1)
			if player.baseClass == 5 then
				player:dialogSeq({t, name .. "Formula\n----------\n\n"}, 1)
				basic_spell_book.fighter_skills(player)
			else
				basic_spell_book.fighter_skills(player)
			end
		end
	end,
	------SCOUNDREL-ABILITIES-------------------------------------------------------------------------------

	scoundrel_abilities = function(player)
		npc = core
		local name = ""
		t = {graphic = convertGraphic(1439, "monster"), color = 0}

		local level = player.level
		local scoundrelAbilities = {}

		if level >= 5 then
			table.insert(scoundrelAbilities, "")
		end

		if level >= 15 then
			table.insert(scoundrelAbilities, "")
		end

		if level >= 25 then
			table.insert(scoundrelAbilities, "")
		end

		if level >= 35 then
			table.insert(scoundrelAbilities, "")
		end

		menu = player:menuString("<b>[Scoundrel Abilities]", scoundrelAbilities)

		if menu == "" then
			player:dialogSeq({t, name .. ""}, 1)
			if player.baseClass == 5 then
				player:dialogSeq({t, name .. "Formula\n----------\n\n"}, 1)
				basic_spell_book.scoundrel_abilities(player)
			else
				basic_spell_book.scoundrel_abilities(player)
			end
		elseif menu == "" then
			player:dialogSeq({t, name .. ""}, 1)
			if player.baseClass == 5 then
				player:dialogSeq({t, name .. "Formula\n----------\n\n"}, 1)
				basic_spell_book.scoundrel_abilities(player)
			else
				basic_spell_book.scoundrel_abilities(player)
			end
		end
	end,
	------WIZARD-SPELLS-------------------------------------------------------------------------------

	wizard_spells = function(player)
		npc = core
		name = "<b>[The Almighty]\n\n"
		t = {graphic = convertGraphic(1439, "monster"), color = 0}

		local level = player.level
		local wizardSpells = {}

		if level >= 5 then
			table.insert(wizardSpells, "")
		end

		if level >= 15 then
			table.insert(wizardSpells, "")
		end

		if level >= 25 then
			table.insert(wizardSpells, "")
		end

		if level >= 35 then
			table.insert(wizardSpells, "")
		end

		menu = player:menuString("<b>[Wizard Spells]", wizardSpells)

		if menu == "" then
			player:dialogSeq({t, name .. ""}, 1)
			if player.baseClass == 5 then
				player:dialogSeq({t, name .. "Formula\n----------\n\n"}, 1)
				basic_spell_book.scoundrel_abilities(player)
			else
				basic_spell_book.scoundrel_abilities(player)
			end
		elseif menu == "" then
			player:dialogSeq({t, name .. ""}, 1)
			if player.baseClass == 5 then
				player:dialogSeq({t, name .. "Formula\n----------\n\n"}, 1)
				basic_spell_book.wizard_spells(player)
			else
				basic_spell_book.wizard_spells(player)
			end
		end
	end,
	------PRIEST-PRAYERS-------------------------------------------------------------------------------

	priest_prayers = function(player)
		npc = core
		name = "<b>[The Almighty]\n\n"
		t = {graphic = convertGraphic(1439, "monster"), color = 0}

		local level = player.level
		local priestPrayers = {}

		if level >= 5 then
			table.insert(priestPrayers, "")
		end

		if level >= 15 then
			table.insert(priestPrayers, "")
		end

		if level >= 25 then
			table.insert(priestPrayers, "")
		end

		if level >= 35 then
			table.insert(priestPrayers, "")
		end

		menu = player:menuString("<b>[Priest Prayers]", priestPrayers)

		if menu == "" then
			player:dialogSeq({t, name .. ""}, 1)
			if player.baseClass == 5 then
				player:dialogSeq({t, name .. "Formula\n----------\n\n"}, 1)
				basic_spell_book.wizard_spells(player)
			else
				basic_spell_book.wizard_spells(player)
			end
		elseif menu == "" then
			player:dialogSeq({t, name .. ""}, 1)
			if player.baseClass == 5 then
				player:dialogSeq({t, name .. "Formula\n----------\n\n"}, 1)
				basic_spell_book.priest_prayers(player)
			else
				basic_spell_book.priest_prayers(player)
			end
		end
	end
}
