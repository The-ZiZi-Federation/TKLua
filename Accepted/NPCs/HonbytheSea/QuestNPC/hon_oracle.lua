hon_oracle = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local opts = {}
			local sellitems = {407, 3002}
			local buyitems = {407}

			table.insert(opts, "Buy")
			table.insert(opts, "Sell")
			table.insert(opts, "What's your story?")
			if player.quest["maiden"] == 1 then
				table.insert(opts, "Jules sent me to you for your guidance.")
			end
			if player.quest["maiden"] == 2 then
				table.insert(opts, "She needs to make a man not want her!")
			end
			if player.quest["maiden"] >= 4 and player.quest["maiden"] <= 5 then
				table.insert(opts, "I have some of Jules' hair.")
			end
			if player.quest["maiden"] == 6 then
				table.insert(opts, "I have returned with the Bat Guano")
			end
			if player.quest["maiden"] == 10 then
				table.insert(opts, "Jules is safe now.")
			end
			if player.quest["maiden"] == 11 then
				table.insert(opts, "Can I have another potion?")
			end
			if player.quest["maiden"] == 12 then
				table.insert(opts, "Transformation Potion")
			end
			if player.quest["wizard_favor"] == 1 and player.quest["pickup_package_oracle"] == 0 then
				table.insert(opts, "Pick up package")
			end
			if player:hasItem("strange_powder", 1) == true and player.quest["gave_strange_powder"] == 0 then
				table.insert(opts, "Do you know what this strange powder is?")
			end

			menu = player:menuString(name .. "I have seen the fates of many, and more. Yours is... cloudy.", opts)

			if menu == "Buy" then
				player:buyExtend(name .. "What can I sell you today?", buyitems)
			elseif menu == "Sell" then
				player:sellExtend(name .. "What do you wish to sell?", sellitems)
			elseif menu == "What's your story?" then
				player:dialogSeq(
					{
						t,
						name .. "My story is the story of all stories.",
						name .. "Your story, however, is just beginning.",
						name .. "Do try to make it one that people will tell."
					},
					1
				)
			elseif menu == "Jules sent me to you for your guidance." then
				player:dialogSeq(
					{
						t,
						name .. "Ahh, Jules, such a pretty little thing. I remember when she was young.",
						name .. "Her father used to bring her here every time he came to town.",
						name .. "What could I do to help you, help her?"
					},
					1
				)
				player:msg(4, "[Quest Updated] Found Oracle. Enlist his help!", player.ID)
				player.quest["maiden"] = 2
			elseif menu == "She needs to make a man not want her!" then
				player:dialogSeq(
					{
						t,
						name .. "I have a brilliant idea. though I will need your help.",
						name .. "I can make a syrum that will make any man run for the hills at her sight",
						name .. "First, you must go get a lock of her hair while I gather the ingredients.",
						name .. "What are you waiting for? Get going, I do have a business to run after all!"
					},
					1
				)
				player:msg(4, "[Quest Updated] Return to Jules for some hair!", player.ID)
				player.quest["maiden"] = 3
			elseif menu == "I have some of Jules' hair." then
				player:dialogSeq(
					{
						t,
						name .. "Great, now we can get started.",
						"**Oracle deeply inhales through his nose while holding her hair to his face**",
						name .. "Yes this will do nicely. Only one problem. I seem to be out of an ingredient.",
						name .. "Could I trouble you to go gather some Bat Guano. It is the only thing I am missing to make her syrum!",
						name .. " Gather 50 Bat Guano!"
					},
					1
				)
				giveXP(player, 50000)
				player:calcStat()
				player:sendStatus()
				finishedQuest(player)
				player:msg(4, "[Quest Updated] Gather 50 Bat Guano!", player.ID)
				player.quest["maiden"] = 6
			elseif menu == "I have returned with the Bat Guano" then
				if player:hasItem("bat_guano", 50) == true then
					if player:removeItem("bat_guano", 50) == true then
						giveXP(player, 50000)
						finishedQuest(player)
						player.quest["maiden"] = 7
						player:msg(4, "[Quest Updated] Return to Jules with Syrum.", player.ID)
						player:dialogSeq(
							{
								t,
								name .. "Where have you been?",
								name .. "Any longer and the syrum will spoil!",
								name .. "Let's just hope you did not ruin this by taking your sweet time.",
								"**The Oracle hands you a small bottle of glowing liquid**",
								name .. "Hurry! Take this to Jules before it's too late!"
							},
							1
						)
					else
						player:dialogSeq({t, name .. "Hurry up and find that guano!"}, 1)
					end
				else
					player:dialogSeq({t, name .. "Hurry up and find that guano!"}, 1)
				end
			elseif menu == "Jules is safe now." then
				player:dialogSeq({t, name .. "Thank you for helping her."}, 1)
				player.quest["maiden"] = 11
			elseif menu == "Can I have another potion?" then
				player:dialogSeq(
					{
						t,
						name .. "If you want another one of those potions for yourself, it's no trouble.",
						name .. "You just need a vial of water, which I happen to have for sale. Glassware ain't free, kid.",
						name .. "Bring me back 50 bat guano and I'll use your vial to brew up another potion.",
						name .. "What? The hair? No, you don't need that for the potion. That was just for me."
					},
					1
				)
				player.quest["maiden"] = 12
			elseif menu == "Transformation Potion" then
				if player:hasItem("bat_guano", 50) == true and player:hasItem("vial_of_water", 1) == true then
					if player:removeItem("bat_guano", 50) == true and player:removeItem("vial_of_water", 1) == true then
						player:addItem("transformation_potion", 1)
						player:dialogSeq({t, name .. "Here you go... Have fun."}, 1)
					else
						player:dialogSeq({t, name .. "Where are the ingredients?"}, 1)
					end
				else
					player:dialogSeq({t, name .. "Where are the ingredients?"}, 1)
				end
			elseif menu == "Pick up package" then
				player.quest["pickup_package_oracle"] = 1
				player:addItem("dripping_bundle", 1)
				player:dialogSeq(
					{
						t,
						name .. "Get this to Cathay quickly, while it's still.. Fresh..",
						name .. "*Grins*"
					},
					1
				)
			elseif menu == "Do you know what this strange powder is?" then
				player:dialogSeq(
					{
						t,
						name ..
							"Yess.. This powder! Where did it come from? Well no matter, if I have this, she won't ever even see me, until it's too late...",
						name .. "*cackles*"
					},
					1
				)
				confirm = player:menuString("You must give it to me!", {"Yes", "No"})
				if confirm == "Yes" then
					if player:hasItem("strange_powder", 1) == true then
						if player:removeItem("strange_powder", 1) == true then
							karma.bad(player)
							player.quest["gave_strange_powder"] = 1
							giveXP(player, 100000)
							player:sendMinitext("Your heart darkens.")
							player:msg(4, "You feel a pang of conscience, but quickly force it back.", player.ID)
							player:dialogSeq(
								{
									t,
									name .. "This.. This is going to be fun..",
									name .. "What's that look? You think I'm going to hurt someone?",
									name .. "She'll still be whole, I promise. But not the same, of course. Never the same again.",
									name .. "*cackles*"
								},
								1
							)
						else
							player:dialogSeq({t, name .. "What are you trying to pull? Pick it back up!"}, 1)
						end
					else
						player:dialogSeq({t, name .. "What are you trying to pull? Bring it back!"}, 1)
					end
				end
			end
		end
	),
	say = function(player, npc)
		local speech = string.lower(player.speech)
		local item
		local number

		if string.sub(speech, 1, 6) == "i buy " and string.sub(speech, 7, 19) == "vial of water" then
			item = Item(string.sub(speech, 7, 19))

			if (item ~= nil) then
				number = tonumber(string.match(speech, "i buy " .. string.lower(item.name) .. " number (%d+)"))

				if (number == nil) then
					number = 1
				end

				if (player:removeGold(item.price * number) == true) then
					player:addItem(item.yname, number)
					npc:talk(
						0,
						"" .. npc.name .. ": I sold you " .. number .. " " .. item.name .. " for " .. (item.price * number) .. " coins."
					)
				end
			end
		elseif
			string.sub(speech, 1, 7) == "buy my " and string.sub(speech, 8, 20) == "vial of water" or
				string.sub(speech, 8, 18) == "pink flower"
		 then
			item = Item(string.sub(speech, 8, 20))

			if (item == nil) then
				item = Item(string.sub(speech, 8, 18))
			end

			if (item ~= nil) then
				number = tonumber(string.match(speech, "buy my " .. string.lower(item.name) .. " number (%d+)"))

				if (number == nil) then
					number = 1
				end

				if (player:removeItem(item.yname, number) == true) then
					player:addGold(item.sell * number)
					npc:talk(
						0,
						"" .. npc.name .. ": I bought your " .. number .. " " .. item.name .. " for " .. (item.sell * number) .. " coins."
					)
				end
			end
		end
	end
}
