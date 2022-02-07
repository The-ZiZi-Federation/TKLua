illusionist = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			local m = player.m
			local map = 1038
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local options = {}
			local spell

			table.insert(options, "See a spell")
			table.insert(options, "Browse spells")
			table.insert(options, "What numbers are valid?")
			table.insert(options, "No thanks")
			local stop = 0
			local notAllowed = {
				85,
				118,
				134,
				160,
				161,
				162,
				338,
				545,
				546,
				555,
				556,
				557,
				558,
				559,
				560,
				561,
				562,
				563,
				564,
				565,
				566,
				567,
				568,
				569,
				570,
				571,
				582,
				598,
				600,
				601,
				602,
				603,
				604,
				606,
				611,
				613,
				620,
				621,
				622,
				623,
				624
			}

			menu = player:menuString(name .. "Hey, I'm a magic man. Wanna see some magical shit, kid?", options)

			if menu == "See a spell" then
				spell = math.abs(tonumber(math.floor(player:input("Please Enter a spell number."))))
				for i = 1, #notAllowed do
					if spell == notAllowed[i] or spell > 644 then
						stop = 1
					end
				end
				if stop == 0 then
					player.registry["illusionist"] = spell
					player:sendAnimation(spell)
				else
					player:popUp("Invalid number!")
					return
				end
			elseif menu == "Browse spells" then
				if player.m ~= map then
					player:sendMinitext("You can't browse if you leave the shop!")
					return
				end

				illusionist.browsespells(player, npc)
			elseif menu == "What numbers are valid?" then
				player:dialogSeq(
					{
						t,
						name ..
							"All numbers up to 644, with the following exceptions: 85, 118, 134, 160, 161, 162, 338, 545, 546, 555-571, 582, 598, 600-604, 606, 611, 613, 620-624"
					},
					1
				)
			end
		end
	),
	browsespells = function(player, npc)
		local name = "<b>[" .. npc.name .. "]\n\n"
		local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		local stop = 0
		local opts = {}
		table.insert(opts, "Next ->>")
		table.insert(opts, "Play Again")
		table.insert(opts, "<<- Previous")
		local map = 1038

		local spell = player.registry["illusionist"]
		local title = " Spell GFX Browser "
		local price
		local notAllowed = {
			85,
			118,
			134,
			160,
			161,
			162,
			338,
			545,
			546,
			555,
			556,
			557,
			558,
			559,
			560,
			561,
			562,
			563,
			564,
			565,
			566,
			567,
			568,
			569,
			570,
			571,
			582,
			598,
			600,
			601,
			602,
			603,
			604,
			606,
			611,
			613,
			620,
			621,
			622,
			623,
			624
		}

		for i = 1, #notAllowed do
			if spell == notAllowed[i] then
				stop = 1
			end
		end
		if player.m ~= map then
			player:sendMinitext("You can't browse if you leave the shop!")
			return
		end
		if stop == 0 then
			player:sendAnimation(spell)
		end
		menu = player:menuString(name .. "\nThat was Spell #" .. spell .. ", you like that shit?", opts)
		--menu = player:menuString(name.."<b>[".. title .."]", opts)

		--{85, 118, 134, 160-162, 338, 545-546, 555-571, 582, 598, 600-604, 606, 611, 613, 620-624, 645-648}

		if menu == "Next ->>" then
			player.registry["illusionist"] = player.registry["illusionist"] + 1

			if player.registry["illusionist"] == 85 then
				player.registry["illusionist"] = 86
			elseif player.registry["illusionist"] == 118 then
				player.registry["illusionist"] = 119
			elseif player.registry["illusionist"] == 134 then
				player.registry["illusionist"] = 135
			elseif player.registry["illusionist"] >= 160 and player.registry["illusionist"] <= 162 then
				player.registry["illusionist"] = 163
			elseif player.registry["illusionist"] == 338 then
				player.registry["illusionist"] = 339
			elseif player.registry["illusionist"] >= 545 and player.registry["illusionist"] <= 546 then
				player.registry["illusionist"] = 547
			elseif player.registry["illusionist"] >= 555 and player.registry["illusionist"] <= 571 then
				player.registry["illusionist"] = 572
			elseif player.registry["illusionist"] == 582 then
				player.registry["illusionist"] = 583
			elseif player.registry["illusionist"] == 598 then
				player.registry["illusionist"] = 599
			elseif player.registry["illusionist"] >= 600 and player.registry["illusionist"] <= 604 then
				player.registry["illusionist"] = 605
			elseif player.registry["illusionist"] == 606 then
				player.registry["illusionist"] = 607
			elseif player.registry["illusionist"] == 611 then
				player.registry["illusionist"] = 612
			elseif player.registry["illusionist"] == 613 then
				player.registry["illusionist"] = 614
			elseif player.registry["illusionist"] >= 620 and player.registry["illusionist"] <= 624 then
				player.registry["illusionist"] = 625
			elseif player.registry["illusionist"] >= 645 then
				player.registry["illusionist"] = 644
			end

			return illusionist.browsespells(player, npc)
		elseif menu == "Play Again" then
			return illusionist.browsespells(player, npc)
		elseif menu == "<<- Previous" then
			player.registry["illusionist"] = player.registry["illusionist"] - 1

			if player.registry["illusionist"] <= 624 and player.registry["illusionist"] >= 620 then
				player.registry["illusionist"] = 619
			elseif player.registry["illusionist"] == 613 then
				player.registry["illusionist"] = 612
			elseif player.registry["illusionist"] == 611 then
				player.registry["illusionist"] = 610
			elseif player.registry["illusionist"] == 606 then
				player.registry["illusionist"] = 605
			elseif player.registry["illusionist"] <= 604 and player.registry["illusionist"] >= 600 then
				player.registry["illusionist"] = 599
			elseif player.registry["illusionist"] == 598 then
				player.registry["illusionist"] = 597
			elseif player.registry["illusionist"] == 582 then
				player.registry["illusionist"] = 581
			elseif player.registry["illusionist"] <= 571 and player.registry["illusionist"] >= 555 then
				player.registry["illusionist"] = 554
			elseif player.registry["illusionist"] <= 546 and player.registry["illusionist"] >= 545 then
				player.registry["illusionist"] = 544
			elseif player.registry["illusionist"] == 338 then
				player.registry["illusionist"] = 337
			elseif player.registry["illusionist"] <= 162 and player.registry["illusionist"] >= 160 then
				player.registry["illusionist"] = 159
			elseif player.registry["illusionist"] == 134 then
				player.registry["illusionist"] = 133
			elseif player.registry["illusionist"] == 118 then
				player.registry["illusionist"] = 117
			elseif player.registry["illusionist"] == 85 then
				player.registry["illusionist"] = 84
			end

			return illusionist.browsespells(player, npc)
		else
		end
	end
}
