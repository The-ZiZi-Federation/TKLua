spellChoice = {
--[[
	
pick = function(player)

	local choiceOne
	local choiceTwo
	local opts = {}

	if player.baseClass ~= 3 then
		if player.registry["spell_choice_1"] == 1 then
			if player.level >= 15 then
				if player.baseClass == 1 then
					choiceOne = "War Cry"
					choiceTwo = "Bolster Armor"
				elseif player.baseClass == 2 then
					choiceOne = "Languish"
					choiceTwo = "Evade"
				elseif player.baseClass == 4 then
					choiceOne = "Eschew Defense"
					choiceTwo = "Harden Armor"
				end
			end
	
		elseif player.registry["spell_choice_2"] == 1 then
			if player.level >= 35 then
				if player.baseClass == 1 then
					choiceOne = "Wide Slash"
					choiceTwo = "Knockback Strike"
				--elseif player.baseClass == 2 then
					--choiceOne = "Flurry of Knives"
					--choiceTwo = "Drain Vitality"
				--elseif player.baseClass == 4 then
					--choiceOne = "Knockback Strike"
					--choiceTwo = "Healing Aura"
				end
			end
		elseif player.registry["spell_choice_3"] == 1 then
			if player.level >= 60 then
				if player.baseClass == 1 then
					choiceOne = "Weapon Focus"
					choiceTwo = "Defense Focus"
				elseif player.baseClass == 2 then
					choiceOne = "Sneak Attack"
					choiceTwo = "Uncanny Dodge"	
				elseif player.baseClass == 4 then
					choiceOne = "Bless Weapon"
					choiceTwo = "Bless Armor"
				end
			end
		elseif player.registry["spell_choice_4"] == 1 then
			if player.level >= 85 then
				if player.baseClass == 1 then
					choiceOne = "Brutal Throw"
					choiceTwo = "Shield Rush"
				elseif player.baseClass == 2 then
					choiceOne = "Assassinate"
					choiceTwo = "Dashing Slash"	
				elseif player.baseClass == 4 then
					choiceOne = "Hold People"
					choiceTwo = "Shield Others"
				end
			end
		elseif player.registry["spell_choice_mobility"] == 1 then
			if player.level >= 10 then
				if player.baseClass == 2 then
					choiceOne = "Ambush"
					choiceTwo = "Dodging Strike"
				end
			end
		elseif player.registry["spell_choice_raise"] == 1 then
			if player.level >= 99 then
				if player.baseClass == 4 then
					choiceOne = "Self Raise"
					choiceTwo = "Mass Raise"
				end
			end
		end
	elseif player.baseClass == 3 then
		if player.registry["spell_choice_1"] == 1 then
			if player.level >= 5 then
				choiceOne = "Flare"
				choiceTwo = "Snowstorm"
			end
		elseif player.registry["spell_choice_2"] == 1 then
			if player.level >= 50 then
				choiceOne = "Burning Hands"
				choiceTwo = "Cone of Cold"
			end
		elseif player.registry["spell_choice_3"] == 1 then
			if player.level >= 60 then
				choiceOne = "Fireball"
				choiceTwo = "Hailstorm"
			end
		elseif player.registry["spell_choice_4"] == 1 then
			if player.level >= 99 then
				choiceOne = "Flame Surge"
				choiceTwo = "Flurry"
			end
		elseif player.registry["spell_choice_para"] == 1 then
			if player.level >= 35 then
				choiceOne = "Static"
				choiceTwo = "Petrify"
			end
		elseif player.registry["spell_choice_armor"] == 1 then
			if player.level >= 75 then
				choiceOne = "Flame Shield"
				choiceTwo = "Ice Armor"
			end
		elseif player.registry["spell_choice_utility"] == 1 then
			if player.level >= 85 then
				choiceOne = "Fear"
				choiceTwo = "Make Invisible"
			end
		end
	end

	table.insert(opts, ""..choiceOne)
	table.insert(opts, ""..choiceTwo)

	menu = player:menuString("Which spell would you like to learn?\n\n((THIS CHOICE IS PERMANENT))", opts)
	if menu == choiceOne then
---------------------------Fighter--------------------------------
		if choiceOne == "War Cry" then
			player:dialogSeq({"<b>"..choiceOne..":\n\Let out a fearsome cry to lower the Grace of nearby foes",
						"This spell costs 1000 coins."}, 1)
			confirm = player:menuString("Do you wish to learn "..choiceOne.."? This will preclude you from ever learning "..choiceTwo..".", {"Yes (Pay 1000 coins)", "No"})
			if confirm == "Yes (Pay 1000 coins)" then
				if player:removeGold(1000) == true then
					player:addSpell("war_cry")
					player:sendMinitext("You learned War Cry!")
					player.registry["spell_choice_1"] = 2
				else
					player:dialogSeq({"Not enough coins!"}, 1)
					spellChoice.pick(player)
				end
			else
				spellChoice.pick(player)
			end

		elseif choiceOne == "Wide Slash" then
			player:dialogSeq({"<b>"..choiceOne..":\n\nA wide attack that strikes 3 foes in front of you.",
						"This spell costs 6000 coins."}, 1)
			confirm = player:menuString("Do you wish to learn "..choiceOne.."? This will preclude you from ever learning "..choiceTwo..".", {"Yes (Pay 6000 coins)", "No"})
			if confirm == "Yes (Pay 6000 coins)" then
				if player:removeGold(6000) == true then
					player:addSpell("wide_slash")
					player:sendMinitext("You learned Wide Slash!")
					player.registry["spell_choice_2"] = 2
				else
					player:dialogSeq({"Not enough coins!"}, 1)
					spellChoice.pick(player)
				end
			else
				spellChoice.pick(player)
			end

		elseif choiceOne == "Weapon Focus" then
			player:dialogSeq({"<b>"..choiceOne..":\n\nIncreases damage and provides a slight bonus to Armor and Might.",
						"This spell costs 50000 coins."}, 1)
			confirm = player:menuString("Do you wish to learn "..choiceOne.."? This will preclude you from ever learning "..choiceTwo..".", {"Yes (Pay 50000 coins)", "No"})
			if confirm == "Yes (Pay 50000 coins)" then
				if player:removeGold(50000) == true then
					player:addSpell("weapon_focus")
					player:sendMinitext("You learned Weapon Focus!")
					player.registry["spell_choice_3"] = 2
				else
					player:dialogSeq({"Not enough coins!"}, 1)
					spellChoice.pick(player)
				end	
			else
				spellChoice.pick(player)
			end

		elseif choiceOne == "Brutal Throw" then
			player:dialogSeq({"<b>"..choiceOne..":\n\nThrows weapon to stun 1 target at a distance.",
						"This spell costs 100000 coins."}, 1)
			confirm = player:menuString("Do you wish to learn "..choiceOne.."? This will preclude you from ever learning "..choiceTwo..".", {"Yes (Pay 100000 coins)", "No"})
			if confirm == "Yes (Pay 100000 coins)" then
				if player:removeGold(100000) == true then
					player:addSpell("brutal_throw")
					player:sendMinitext("You learned Brutal Throw!")
					player.registry["spell_choice_4"] = 2
				else
					player:dialogSeq({"Not enough coins!"}, 1)
					spellChoice.pick(player)
				end		
			else
				spellChoice.pick(player)
			end

----------------------------------Scoundrel--------------------------------
		elseif choiceOne == "Languish" then
			player:dialogSeq({"<b>"..choiceOne..":\n\nThrow poisoned darts to lower the Might of nearby foes",
						"This spell costs 1000 coins."}, 1)
			confirm = player:menuString("Do you wish to learn "..choiceOne.."? This will preclude you from ever learning "..choiceTwo..".", {"Yes (Pay 1000 coins)", "No"})
			if confirm == "Yes (Pay 1000 coins)" then
				if player:removeGold(1000) == true then
					player:addSpell("languish")
					player:sendMinitext("You learned Languish!")
					player.registry["spell_choice_1"] = 2
				else
					player:dialogSeq({"Not enough coins!"}, 1)
					spellChoice.pick(player)
				end	
			else
				spellChoice.pick(player)
			end

		elseif choiceOne == "Flurry of Knives" then
			player:dialogSeq({"<b>"..choiceOne..":\n\nA rapid series of attacks that strikes 3 targets.",
						"This spell costs 5000 coins."}, 1)
			confirm = player:menuString("Do you wish to learn "..choiceOne.."? This will preclude you from ever learning "..choiceTwo..".", {"Yes (Pay 5000 coins)", "No"})	
		if confirm == "Yes (Pay 5000 coins)" then
			if player:removeGold(5000) == true then
				player:addSpell("flurry_of_knives")
				player:sendMinitext("You learned Flurry of Knives!")
				player.registry["spell_choice_2"] = 2
			else
				player:dialogSeq({"Not enough coins!"}, 1)
				spellChoice.pick(player)
			end		
		else
			spellChoice.pick(player)
		end

		elseif choiceOne == "Sneak Attack" then
			player:dialogSeq({"<b>"..choiceOne..":\n\nIncreases your damage and provides slight bonus to Might and Grace.",
						"This spell costs 50000 coins."}, 1)
			confirm = player:menuString("Do you wish to learn "..choiceOne.."? This will preclude you from ever learning "..choiceTwo..".", {"Yes (Pay 50000 coins)", "No"})
			if confirm == "Yes (Pay 50000 coins)" then
				if player:removeGold(50000) == true then
					player:addSpell("sneak_attack")
					player:sendMinitext("You learned Sneak Attack!")
					player.registry["spell_choice_3"] = 2
				else
					player:dialogSeq({"Not enough coins!"}, 1)
					spellChoice.pick(player)
				end			
			else
				spellChoice.pick(player)
			end

		elseif choiceOne == "Assassinate" then
			player:dialogSeq({"<b>"..choiceOne..":\n\nVanish from a distance and appear behind your target with a stunning attack.",
						"This spell costs 100000 coins."}, 1)
			confirm = player:menuString("Do you wish to learn "..choiceOne.."? This will preclude you from ever learning "..choiceTwo..".", {"Yes (Pay 100000 coins)", "No"})
			if confirm == "Yes (Pay 100000 coins)" then
				if player:removeGold(100000) == true then
					player:addSpell("assassinate")
					player:sendMinitext("You learned Assassinate!")
					player.registry["spell_choice_4"] = 2
				else
					player:dialogSeq({"Not enough coins!"}, 1)
					spellChoice.pick(player)
				end				
			else
				spellChoice.pick(player)
			end

		elseif choiceOne == "Ambush" then
			player:dialogSeq({"<b>"..choiceOne..":\n\nLeap over your enemy to face their back and strike.",
						"This spell costs 500 coins."}, 1)
			confirm = player:menuString("Do you wish to learn "..choiceOne.."? This will preclude you from ever learning "..choiceTwo..".", {"Yes (Pay 500 coins)", "No"})
			if confirm == "Yes (Pay 500 coins)" then
				if player:removeGold(500) == true then
					player:addSpell("ambush")
					player:sendMinitext("You learned Ambush!")
					player.registry["spell_choice_mobility"] = 2
				else
					player:dialogSeq({"Not enough coins!"}, 1)
					spellChoice.pick(player)
				end					
			else
				spellChoice.pick(player)
			end

----------------------------------Priest--------------------------------
		elseif choiceOne == "Eschew Defense" then
			player:dialogSeq({"<b>"..choiceOne..":\n\nA spell that lowers the Armor of nearby foes",
						"This spell costs 1000 coins."}, 1)
			confirm = player:menuString("Do you wish to learn "..choiceOne.."? This will preclude you from ever learning "..choiceTwo..".", {"Yes (Pay 1000 coins)", "No"})
			if confirm == "Yes (Pay 1000 coins)" then
				if player:removeGold(1000) == true then
					player:addSpell("eschew_defense")
					player:sendMinitext("You learned Eschew Defense!")
					player.registry["spell_choice_1"] = 2
				else
					player:dialogSeq({"Not enough coins!"}, 1)
					spellChoice.pick(player)
				end			
			else
				spellChoice.pick(player)
			end
	]]--
--[[
		elseif choiceOne == "Knockback Strike" then
			player:dialogSeq({"<b>"..choiceOne..":\n\nDamages one enemy, stuns and knocks back surrounding foes.",
						"This spell costs 25000 coins."}, 1)
			confirm = player:menuString("Do you wish to learn "..choiceOne.."? This will preclude you from ever learning "..choiceTwo..".", {"Yes (Pay 25000 coins)", "No"})
			if confirm == "Yes (Pay 25000 coins)" then
				if player:removeGold(25000) == true then
					player:addSpell("knockback_strike")
					player:sendMinitext("You learned Knockback Strike!")
					player.registry["spell_choice_2"] = 2
				else
					player:dialogSeq({"Not enough coins!"}, 1)
					spellChoice.pick(player)
				end	
			else
				spellChoice.pick(player)
			end
]]--
--[[
		elseif choiceOne == "Bless Weapon" then
			player:dialogSeq({"<b>"..choiceOne..":\n\nIncreases target's damage and Might.",
						"This spell costs 50000 coins."}, 1)
			confirm = player:menuString("Do you wish to learn "..choiceOne.."? This will preclude you from ever learning "..choiceTwo..".", {"Yes (Pay 50000 coins)", "No"})
			if confirm == "Yes (Pay 50000 coins)" then
				if player:removeGold(50000) == true then
					player:addSpell("bless_weapon")
					player:sendMinitext("You learned Bless Weapon!")
					player.registry["spell_choice_3"] = 2
				else
					player:dialogSeq({"Not enough coins!"}, 1)
					spellChoice.pick(player)
				end	
			else
				spellChoice.pick(player)
			end

		elseif choiceOne == "Hold People" then
			player:dialogSeq({"<b>"..choiceOne..":\n\nStuns hostile targets and surrounding foes in targetted area.",
						"This spell costs 75000 coins."}, 1)
			confirm = player:menuString("Do you wish to learn "..choiceOne.."? This will preclude you from ever learning "..choiceTwo..".", {"Yes (Pay 75000 coins)", "No"})
			if confirm == "Yes (Pay 75000 coins)" then
				if player:removeGold(75000) == true then
					player:addSpell("hold_people")
					player:sendMinitext("You learned Hold People!")
					player.registry["spell_choice_4"] = 2
				else
					player:dialogSeq({"Not enough coins!"}, 1)
					spellChoice.pick(player)
				end
			else
				spellChoice.pick(player)
			end

		elseif choiceOne == "Self Raise" then
			player:dialogSeq({"<b>"..choiceOne..":\n\nBring yourself back to the land of the living.",
						"This spell costs 100000 coins."}, 1)
			confirm = player:menuString("Do you wish to learn "..choiceOne.."? This will preclude you from ever learning "..choiceTwo..".", {"Yes (Pay 100000 coins)", "No"})	
		if confirm == "Yes (Pay 100000 coins)" then
			if player:removeGold(100000) == true then
				player:addSpell("self_raise")
				player:sendMinitext("You learned Self Raise!")
				player.registry["spell_choice_raise"] = 2
			else
				player:dialogSeq({"Not enough coins!"}, 1)
				spellChoice.pick(player)
			end	
		else
			spellChoice.pick(player)
		end

----------------------------------Wizard--------------------------------
		elseif choiceOne == "Flare" then
			player:dialogSeq({"<b>"..choiceOne..":\n\nAttack a single foe with magical fire.",
						"This spell costs 50 coins."}, 1)
			confirm = player:menuString("Do you wish to learn "..choiceOne.."? This will preclude you from ever learning "..choiceTwo..".", {"Yes (Pay 50 coins)", "No"})
			if confirm == "Yes (Pay 50 coins)" then
				if player:removeGold(50) == true then
					player:addSpell("flare")
					player:sendMinitext("You learned Flare!")
					player.registry["spell_choice_1"] = 2
				else
					player:dialogSeq({"Not enough coins!"}, 1)
					spellChoice.pick(player)
				end
			else
				spellChoice.pick(player)
			end

		elseif choiceOne == "Burning Hands" then
			player:dialogSeq({"<b>"..choiceOne..":\n\nA fan of flames damages foes in a wide area.",
						"This spell costs 5000 coins."}, 1)
			confirm = player:menuString("Do you wish to learn "..choiceOne.."? This will preclude you from ever learning "..choiceTwo..".", {"Yes (Pay 5000 coins)", "No"})
			if confirm == "Yes (Pay 5000 coins)" then
				if player:removeGold(5000) == true then
					player:addSpell("burning_hands")
					player:sendMinitext("You learned Burning Hands!")
					player.registry["spell_choice_2"] = 2
				else
					player:dialogSeq({"Not enough coins!"}, 1)
					spellChoice.pick(player)
				end
			else
				spellChoice.pick(player)
			end

		elseif choiceOne == "Fireball" then
			player:dialogSeq({"<b>"..choiceOne..":\n\nA large fireball damages target and surrounding foes.",
						"This spell costs 50000 coins."}, 1)
			confirm = player:menuString("Do you wish to learn "..choiceOne.."? This will preclude you from ever learning "..choiceTwo..".", {"Yes (Pay 50000 coins)", "No"})
			if confirm == "Yes (Pay 50000 coins)" then
				if player:removeGold(50000) == true then
					player:addSpell("fireball")
					player:sendMinitext("You learned Fireball!")
					player.registry["spell_choice_3"] = 2
				else
					player:dialogSeq({"Not enough coins!"}, 1)
					spellChoice.pick(player)
				end
			else
				spellChoice.pick(player)
			end

		elseif choiceOne == "Flame Surge" then
			player:dialogSeq({"<b>"..choiceOne..":\n\nSurrounds the target with flames that damage all nearby foes for a short time.",
						"This spell costs 100000 coins."}, 1)
			confirm = player:menuString("Do you wish to learn "..choiceOne.."? This will preclude you from ever learning "..choiceTwo..".", {"Yes (Pay 100000 coins)", "No"})
			if confirm == "Yes (Pay 100000 coins)" then
				if player:removeGold(100000) == true then
					player:addSpell("flame_surge")
					player:sendMinitext("You learned Flame Surge!")
					player.registry["spell_choice_4"] = 2
				else
					player:dialogSeq({"Not enough coins!"}, 1)
					spellChoice.pick(player)
				end
			else
				spellChoice.pick(player)
			end

		elseif choiceOne == "Static" then
			player:dialogSeq({"<b>"..choiceOne..":\n\nStuns enemies around the caster with a blast of electricity.",
						"This spell costs 25000 coins."}, 1)
			confirm = player:menuString("Do you wish to learn "..choiceOne.."? This will preclude you from ever learning "..choiceTwo..".", {"Yes (Pay 25000 coins)", "No"})
			if confirm == "Yes (Pay 25000 coins)" then
				if player:removeGold(25000) == true then
					player:addSpell("static")
					player:sendMinitext("You learned Static!")
					player.registry["spell_choice_para"] = 2
				else
					player:dialogSeq({"Not enough coins!"}, 1)
					spellChoice.pick(player)
				end
			else
				spellChoice.pick(player)
			end

		elseif choiceOne == "Flame Shield" then
			player:dialogSeq({"<b>"..choiceOne..":\n\nA flaming barrier that protects a target and damages attacking foes.",
						"This spell costs 75000 coins."}, 1)
			confirm = player:menuString("Do you wish to learn "..choiceOne.."? This will preclude you from ever learning "..choiceTwo..".", {"Yes (Pay 75000 coins)", "No"})
			if confirm == "Yes (Pay 75000 coins)" then
				if player:removeGold(75000) == true then
					player:addSpell("flame_shield")
					player:sendMinitext("You learned Flame Shield!")
					player.registry["spell_choice_armor"] = 2
				else
					player:dialogSeq({"Not enough coins!"}, 1)
					spellChoice.pick(player)
				end
			else
				spellChoice.pick(player)
			end

		elseif choiceOne == "Fear" then
			player:dialogSeq({"<b>"..choiceOne..":\n\nMake your foes run away in terror.",
						"This spell costs 75000 coins."}, 1)
			confirm = player:menuString("Do you wish to learn "..choiceOne.."? This will preclude you from ever learning "..choiceTwo..".", {"Yes (Pay 75000 coins)", "No"})
			if confirm == "Yes (Pay 75000 coins)" then
				if player:removeGold(75000) == true then
					player:addSpell("fear")
					player:sendMinitext("You learned !")
					player.registry["spell_choice_utility"] = 2
				else
					player:dialogSeq({"Not enough coins!"}, 1)
					spellChoice.pick(player)
				end
			else
				spellChoice.pick(player)
			end
		end

	elseif menu == choiceTwo then
----------------------------------Fighter--------------------------------
		if choiceTwo == "Bolster Armor" then
			player:dialogSeq({"<b>"..choiceTwo..":\n\nIncreases your Armor temporarily.",
						"This spell costs 1000 coins."}, 1)
			confirm = player:menuString("Do you wish to learn "..choiceTwo.."? This will preclude you from ever learning "..choiceOne..".", {"Yes (Pay 1000 coins)", "No"})			
			if confirm == "Yes (Pay 1000 coins)" then
				if player:removeGold(1000) == true then
					player:addSpell("bolster_armor")
					player:sendMinitext("You learned Bolster Armor!")
					player.registry["spell_choice_1"] = 2
				else
					player:dialogSeq({"Not enough coins!"}, 1)
					spellChoice.pick(player)
				end
			else
				spellChoice.pick(player)
			end

		elseif choiceTwo == "Knockback Strike" then
			player:dialogSeq({"<b>"..choiceTwo..":\n\nDamages one enemy, stuns and knocks back surrounding foes.",
						"This spell costs 6000 coins."}, 1)
			confirm = player:menuString("Do you wish to learn "..choiceTwo.."? This will preclude you from ever learning "..choiceOne..".", {"Yes (Pay 6000 coins)", "No"})
			if confirm == "Yes (Pay 6000 coins)" then
				if player:removeGold(6000) == true then
					player:addSpell("knockback_strike")
					player:sendMinitext("You learned Knockback Strike!")
					player.registry["spell_choice_2"] = 2
				else
					player:dialogSeq({"Not enough coins!"}, 1)
					spellChoice.pick(player)
				end
			else
				spellChoice.pick(player)
			end

		elseif choiceTwo == "Defense Focus" then
			player:dialogSeq({"<b>"..choiceTwo..":\n\nFocus on your defense to block incoming attacks and increase Armor and Will.",
						"This spell costs 50000 coins."}, 1)
			confirm = player:menuString("Do you wish to learn "..choiceTwo.."? This will preclude you from ever learning "..choiceOne..".", {"Yes (Pay 50000 coins)", "No"})
			if confirm == "Yes (Pay 50000 coins)" then
				if player:removeGold(50000) == true then
					player:addSpell("defense_focus")
					player:sendMinitext("You learned Defense Focus!")
					player.registry["spell_choice_3"] = 2
				else
					player:dialogSeq({"Not enough coins!"}, 1)
					spellChoice.pick(player)
				end
			else
				spellChoice.pick(player)
			end

		elseif choiceTwo == "Shield Rush" then
			player:dialogSeq({"<b>"..choiceTwo..":\n\nLeap forward at a foe to stun them, deal damage, and push them away.",
						"This spell costs 100000 coins."}, 1)
			confirm = player:menuString("Do you wish to learn "..choiceTwo.."? This will preclude you from ever learning "..choiceOne..".", {"Yes (Pay 100000 coins)", "No"})
			if confirm == "Yes (Pay 100000 coins)" then
				if player:removeGold(100000) == true then
					player:addSpell("shield_rush")
					player:sendMinitext("You learned Shield Rush!")
					player.registry["spell_choice_4"] = 2
				else
					player:dialogSeq({"Not enough coins!"}, 1)
					spellChoice.pick(player)
				end
			else
				spellChoice.pick(player)
			end

----------------------------------Scoundrel--------------------------------
		elseif choiceTwo == "Evade" then
			player:dialogSeq({"<b>"..choiceTwo..":\n\nIncrease your defenses for a short time.",
						"This spell costs 1000 coins."}, 1)
			confirm = player:menuString("Do you wish to learn "..choiceTwo.."? This will preclude you from ever learning "..choiceOne..".", {"Yes (Pay 1000 coins)", "No"})
			if confirm == "Yes (Pay 1000 coins)" then
				if player:removeGold(1000) == true then
					player:addSpell("evade")
					player:sendMinitext("You learned Evade!")
					player.registry["spell_choice_1"] = 2
				else
					player:dialogSeq({"Not enough coins!"}, 1)
					spellChoice.pick(player)
				end
			else
				spellChoice.pick(player)
			end

		elseif choiceTwo == "Drain Vitality" then
			player:dialogSeq({"<b>"..choiceTwo..":\n\nA vampiric strike that drains health from a foe.",
						"This spell costs 5000 coins."}, 1)
			confirm = player:menuString("Do you wish to learn "..choiceTwo.."? This will preclude you from ever learning "..choiceOne..".", {"Yes (Pay 5000 coins)", "No"})
			if confirm == "Yes (Pay 5000 coins)" then
				if player:removeGold(5000) == true then
					player:addSpell("drain_vitality")
					player:sendMinitext("You learned Drain Vitality!")
					player.registry["spell_choice_2"] = 2
				else
					player:dialogSeq({"Not enough coins!"}, 1)
					spellChoice.pick(player)
				end
			else
				spellChoice.pick(player)
			end

		elseif choiceTwo == "Uncanny Dodge" then
			player:dialogSeq({"<b>"..choiceTwo..":\n\nFocus on defense to dodge enemy attacks and restore vita or mana over time (based on previous selections).",
						"This spell costs 50000 coins."}, 1)
			confirm = player:menuString("Do you wish to learn "..choiceTwo.."? This will preclude you from ever learning "..choiceOne..".", {"Yes (Pay 50000 coins)", "No"})
			if confirm == "Yes (Pay 50000 coins)" then
				if player:removeGold(50000) == true then
					player:addSpell("uncanny_dodge")
					player:sendMinitext("You learned Uncanny Dodge!")
					player.registry["spell_choice_3"] = 2
				else
					player:dialogSeq({"Not enough coins!"}, 1)
					spellChoice.pick(player)
				end
			else
				spellChoice.pick(player)
			end

		elseif choiceTwo == "Dashing Slash" then
			player:dialogSeq({"<b>"..choiceTwo..":\n\nDash past 3 foes and strike at all of them.",
						"This spell costs 100000 coins."}, 1)
			confirm = player:menuString("Do you wish to learn "..choiceTwo.."? This will preclude you from ever learning "..choiceOne..".", {"Yes (Pay 100000 coins)", "No"})
			if confirm == "Yes (Pay 100000 coins)" then
				if player:removeGold(100000) == true then
					player:addSpell("dashing_slash")
					player:sendMinitext("You learned Dashing Slash!")
					player.registry["spell_choice_4"] = 2
				else
					player:dialogSeq({"Not enough coins!"}, 1)
					spellChoice.pick(player)
				end
			else
				spellChoice.pick(player)
			end

		elseif choiceTwo == "Dodging Strike" then
			player:dialogSeq({"<b>"..choiceTwo..":\n\nDash past a foe and strike at them on your way.",
						"This spell costs 500 coins."}, 1)
			confirm = player:menuString("Do you wish to learn "..choiceTwo.."? This will preclude you from ever learning "..choiceOne..".", {"Yes (Pay 500 coins)", "No"})
			if confirm == "Yes (Pay 500 coins)" then
				if player:removeGold(500) == true then
					player:addSpell("dodging_strike")
					player:sendMinitext("You learned Dodging Strike!")
					player.registry["spell_choice_mobility"] = 2
				else
					player:dialogSeq({"Not enough coins!"}, 1)
					spellChoice.pick(player)
				end
			else
				spellChoice.pick(player)
			end

----------------------------------Priest--------------------------------
		elseif choiceTwo == "Harden Armor" then
			player:dialogSeq({"<b>"..choiceTwo..":\n\nIncreases the target's armor for a time.",
						"This spell costs 1000 coins."}, 1)
			confirm = player:menuString("Do you wish to learn "..choiceTwo.."? This will preclude you from ever learning "..choiceOne..".", {"Yes (Pay 1000 coins)", "No"})
			if confirm == "Yes (Pay 1000 coins)" then
				if player:removeGold(1000) == true then
					player:addSpell("harden_armor")
					player:sendMinitext("You learned Harden Armor!")
					player.registry["spell_choice_1"] = 2
				else
					player:dialogSeq({"Not enough coins!"}, 1)
					spellChoice.pick(player)
				end
			else
				spellChoice.pick(player)
			end
]]--
--[[
		elseif choiceTwo == "Healing Aura" then
			player:dialogSeq({"<b>"..choiceTwo..":\n\nRestores health over time to all group members.",
						"This spell costs 25000 coins."}, 1)
			confirm = player:menuString("Do you wish to learn "..choiceTwo.."? This will preclude you from ever learning "..choiceOne..".", {"Yes (Pay 25000 coins)", "No"})
			if confirm == "Yes (Pay 25000 coins)" then
				if player:removeGold(25000) == true then
					player:addSpell("healing_aura")
					player:sendMinitext("You learned Healing Aura!")
					player.registry["spell_choice_2"] = 2
				else
					player:dialogSeq({"Not enough coins!"}, 1)
					spellChoice.pick(player)
				end
			else
				spellChoice.pick(player)
			end
]]--
--[[
		elseif choiceTwo == "Bless Armor" then
			player:dialogSeq({"<b>"..choiceTwo..":\n\nIncreases target's Armor",
						"This spell costs 50000 coins."}, 1)
			confirm = player:menuString("Do you wish to learn "..choiceTwo.."? This will preclude you from ever learning "..choiceOne..".", {"Yes (Pay 50000 coins)", "No"})
			if confirm == "Yes (Pay 50000 coins)" then
				if player:removeGold(50000) == true then
					player:addSpell("bless_armor")
					player:sendMinitext("You learned Bless Armor!")
					player.registry["spell_choice_3"] = 2
				else
					player:dialogSeq({"Not enough coins!"}, 1)
					spellChoice.pick(player)
				end
			else
				spellChoice.pick(player)
			end

		elseif choiceTwo == "Shield Others" then
			player:dialogSeq({"<b>"..choiceTwo..":\n\nSignificantly reduces damage dealt to target for a short time.",
						"This spell costs 75000 coins."}, 1)
			confirm = player:menuString("Do you wish to learn "..choiceTwo.."? This will preclude you from ever learning "..choiceOne..".", {"Yes (Pay 75000 coins)", "No"})
			if confirm == "Yes (Pay 75000 coins)" then
				if player:removeGold(75000) == true then
					player:addSpell("shield_others")
					player:sendMinitext("You learned Shield Others!")
					player.registry["spell_choice_4"] = 2
				else
					player:dialogSeq({"Not enough coins!"}, 1)
					spellChoice.pick(player)
				end
			else
				spellChoice.pick(player)
			end

		elseif choiceTwo == "Mass Raise" then
			player:dialogSeq({"<b>"..choiceTwo..":\n\nRaise all group members in the area.",
						"This spell costs 100000 coins."}, 1)
			confirm = player:menuString("Do you wish to learn "..choiceTwo.."? This will preclude you from ever learning "..choiceOne..".", {"Yes (Pay 100000 coins)", "No"})
			if confirm == "Yes (Pay 100000 coins)" then
				if player:removeGold(100000) == true then
					player:addSpell("mass_raise")
					player:sendMinitext("You learned Mass Raise!")
					player.registry["spell_choice_raise"] = 2
				else
					player:dialogSeq({"Not enough coins!"}, 1)
					spellChoice.pick(player)
				end
			else
				spellChoice.pick(player)
			end

----------------------------------Wizard--------------------------------
		elseif choiceTwo == "Snowstorm" then
			player:dialogSeq({"<b>"..choiceTwo..":\n\nAttack a single foe with magical frost.",
						"This spell costs 50 coins."}, 1)
			confirm = player:menuString("Do you wish to learn "..choiceTwo.."? This will preclude you from ever learning "..choiceOne..".", {"Yes (Pay 50 coins)", "No"})
			if confirm == "Yes (Pay 50 coins)" then
				if player:removeGold(50) == true then
					player:addSpell("snowstorm")
					player:sendMinitext("You learned Snowstorm!")
					player.registry["spell_choice_1"] = 2
				else
					player:dialogSeq({"Not enough coins!"}, 1)
					spellChoice.pick(player)
				end
			else
				spellChoice.pick(player)
			end

		elseif choiceTwo == "Cone of Cold" then
			player:dialogSeq({"<b>"..choiceTwo..":\n\nA cone of frigid energy damages foes in an area.",
						"This spell costs 5000 coins."}, 1)
			confirm = player:menuString("Do you wish to learn "..choiceTwo.."? This will preclude you from ever learning "..choiceOne..".", {"Yes (Pay 5000 coins)", "No"})
			if confirm == "Yes (Pay 5000 coins)" then
				if player:removeGold(5000) == true then
					player:addSpell("cone_of_cold")
					player:sendMinitext("You learned Cone of Cold!")
					player.registry["spell_choice_2"] = 2
				else
					player:dialogSeq({"Not enough coins!"}, 1)
					spellChoice.pick(player)
				end
			else
				spellChoice.pick(player)
			end

		elseif choiceTwo == "Hailstorm" then
			player:dialogSeq({"<b>"..choiceTwo..":\n\nSummons a hailstorm to damage all enemies in an area.",
						"This spell costs 50000 coins."}, 1)
			confirm = player:menuString("Do you wish to learn "..choiceTwo.."? This will preclude you from ever learning "..choiceOne..".", {"Yes (Pay 50000 coins)", "No"})
			if confirm == "Yes (Pay 50000 coins)" then
				if player:removeGold(50000) == true then
					player:addSpell("hailstorm")
					player:sendMinitext("You learned Hailstorm!")
					player.registry["spell_choice_3"] = 2
				else
					player:dialogSeq({"Not enough coins!"}, 1)
					spellChoice.pick(player)
				end
			else
				spellChoice.pick(player)
			end

		elseif choiceTwo == "Flurry" then
			player:dialogSeq({"<b>"..choiceTwo..":\n\nSurrounds the target in a magic storm of ice and wind that damages nearby foes over time.",
						"This spell costs 100000 coins."}, 1)
			confirm = player:menuString("Do you wish to learn "..choiceTwo.."? This will preclude you from ever learning "..choiceOne..".", {"Yes (Pay 100000 coins)", "No"})
			if confirm == "Yes (Pay 100000 coins)" then
				if player:removeGold(100000) == true then
					player:addSpell("flurry")
					player:sendMinitext("You learned Flurry!")
					player.registry["spell_choice_4"] = 2
				else
					player:dialogSeq({"Not enough coins!"}, 1)
					spellChoice.pick(player)
				end
			else
				spellChoice.pick(player)
			end

		elseif choiceTwo == "Petrify" then
			player:dialogSeq({"<b>"..choiceTwo..":\n\nSolidify an enemy in stone temporarily.",
						"This spell costs 25000 coins."}, 1)
			confirm = player:menuString("Do you wish to learn "..choiceTwo.."? This will preclude you from ever learning "..choiceOne..".", {"Yes (Pay 25000 coins)", "No"})
			if confirm == "Yes (Pay 25000 coins)" then
				if player:removeGold(25000) == true then
					player:addSpell("petrify")
					player:sendMinitext("You learned Petrify!")
					player.registry["spell_choice_para"] = 2
				else
					player:dialogSeq({"Not enough coins!"}, 1)
					spellChoice.pick(player)
				end
			else
				spellChoice.pick(player)
			end

		elseif choiceTwo == "Ice Armor" then
			player:dialogSeq({"<b>"..choiceTwo..":\n\nArmor the target in ice, increasing armor and granting a chance to freeze attackers.",
						"This spell costs 75000 coins."}, 1)
			confirm = player:menuString("Do you wish to learn "..choiceTwo.."? This will preclude you from ever learning "..choiceOne..".", {"Yes (Pay 75000 coins)", "No"})
			if confirm == "Yes (Pay 75000 coins)" then
				if player:removeGold(75000) == true then
					player:addSpell("ice_armor")
					player:sendMinitext("You learned Ice Armor!")
					player.registry["spell_choice_armor"] = 2
				else
					player:dialogSeq({"Not enough coins!"}, 1)
					spellChoice.pick(player)
				end
			else
				spellChoice.pick(player)
			end

		elseif choiceTwo == "Make Invisible" then
			player:dialogSeq({"<b>"..choiceTwo..":\n\nMakes the target disappear from sight for a short time.",
						"This spell costs 75000 coins."}, 1)
			confirm = player:menuString("Do you wish to learn "..choiceTwo.."? This will preclude you from ever learning "..choiceOne..".", {"Yes (Pay 75000 coins)", "No"})
			if confirm == "Yes (Pay 75000 coins)" then
				if player:removeGold(75000) == true then
					player:addSpell("make_invis")
					player:sendMinitext("You learned Make Invisible!")
					player.registry["spell_choice_utility"] = 2
				else
					player:dialogSeq({"Not enough coins!"}, 1)
					spellChoice.pick(player)
				end
			else
				spellChoice.pick(player)
			end
		end
	end
end
]]--
}