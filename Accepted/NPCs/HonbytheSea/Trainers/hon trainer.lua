hon_trainer = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local spell, class, menuOpt
			local opts = {}
			local users = player:getUsers()

			if player.baseClass == 0 then
				if player.mapTitle == "Fighter's Hall" then
					table.insert(opts, "About fighter")
				elseif player.mapTitle == "Scoundrel's Guild" then
					table.insert(opts, "About scoundrel")
				elseif player.mapTitle == "Seagrove Training Tower" then
					table.insert(opts, "About wizard")
				elseif player.mapTitle == "House of ASAK" then
					table.insert(opts, "About priest")
				end
			else
				if
					player.mapTitle == "Fighter's Hall" and player.class == 1 or
						player.mapTitle == "Scoundrel's Guild" and player.class == 2 or
						player.mapTitle == "Seagrove Training Tower" and player.class == 3 or
						player.mapTitle == "House of ASAK" and player.class == 4
				 then
					table.insert(opts, "Learn Spell")
				end
				table.insert(opts, "Forget Spell")
			end

			table.insert(opts, "Exit")

			menu = player:menuString(name .. "How may i assist you, young fledgling?", opts)

			if menu == "Exit" then
				-- Learn Spell
				return
			elseif menu == "Learn Spell" then
				if player.mapTitle == "Fighter's Hall" and player.class == 1 then
					spell = player:learnMornaSpell(1)
				elseif player.mapTitle == "Scoundrel's Guild" and player.class == 2 then
					spell = player:learnMornaSpell(2)
				elseif player.mapTitle == "Seagrove Training Tower" and player.class == 3 then
					spell = player:learnMornaSpell(3)
				elseif player.mapTitle == "House of ASAK" and player.class == 4 then
					spell = player:learnMornaSpell(4)
				end
			elseif menu == "Forget Spell" then
				player:forgetSpell()
			else
				if menu == "About fighter" then
					class = "Fighter"
					player:dialogSeq(
						{
							t,
							name ..
								"Fighters are a path of superior tankiness. They can charge into battle hitting every monster around them. Fighter can hold any enemies attention while the others do damage and support!"
						},
						1
					)
				elseif menu == "About scoundrel" then
					class = "Scoundrel"
					player:dialogSeq(
						{
							t,
							name ..
								"Scoundrels are a path able to do high amounts of single target damage and get out of danger in a flash. Scoundrels use agility and cunning to vanquish their enemies"
						},
						1
					)
				elseif menu == "About wizard" then
					class = "Wizard"
					player:dialogSeq(
						{
							t,
							name ..
								"Wizards are a path of high damage and crowd control. Their ability to manipulate the enemies around them is unrivaled and their burst unmatched."
						},
						1
					)
				elseif menu == "About priest" then
					class = "Priest"
					player:dialogSeq(
						{
							t,
							name ..
								"Priests are a path of club smashing while supporting healers. Through buffs, heals, and damage they are a necessity in all groups and can often function as impressive tanks as well."
						},
						1
					)
				end

				if player.level >= 5 then
					menuOpt = player:menu(name .. "Would you like to become a " .. class .. "?", {"Yes", "No"})
					if menuOpt == 1 then
						if class == "Fighter" then
							player.class = 1
						elseif class == "Scoundrel" then
							player.class = 2
						elseif class == "Wizard" then
							player.class = 3
						elseif class == "Priest" then
							player.class = 4
						end

						player:playSound(20)
						player:sendAnimation(2)
						player:status()
						player:sendMinitext("You have become a " .. class .. "!")
						for i = 1, #users do
							users[i]:msg(
								12,
								"-------------- " .. player.name .. " has become a " .. class .. "!! --------------",
								users[i].ID
							)
						end
					end
				end
			end
		end
	)
}
