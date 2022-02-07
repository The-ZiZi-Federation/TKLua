hon_chef = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local opts = {}
			local opts2 = {"Yes", "No"}

			local weapon = player:getEquippedItem(EQ_WEAP)

			table.insert(opts, "Buy")
			table.insert(opts, "Sell")
			if player.quest["angry_guard"] == 5 then
				table.insert(opts, "Can you cook for me?")
			end
			if player.quest["angry_guard"] >= 6 and player.quest["angry_guard"] <= 9 then
				table.insert(opts, "Repeat the recipe")
			end
			if player.quest["angry_guard"] >= 6 and player.quest["angry_guard"] <= 9 then
				table.insert(opts, "I have the ingredients")
			end
			if player.quest["angry_guard"] == 10 then
				table.insert(opts, "Is the meal ready?")
			end

			menu = player:menuString(name .. "Another boring day in Hon...", opts)

			if menu == "Buy" then
				chef_shop.buy(player)
			elseif menu == "Sell" then
				chef_shop.sell(player)
			elseif menu == "Can you cook for me?" then
				if player:hasItem("handwritten_recipe", 1) == true then
					player:removeItem("handwritten_recipe", 1)
					player.quest["angry_guard"] = 6
					player:dialogSeq(
						{
							t,
							name .. "You need a cook?",
							name .. "I can cook just about anything, what's the job?",
							name .. "*you give Salmon the recipe*",
							name .. "OH... Oh God...",
							name .. "Why would someone cook this?",
							name .. "Why would someone EAT this?",
							name .. "Personal misgivings aside, the customer IS always right.",
							name .. "I'll cook this... this dish for you, but these ingredients, well they aren't exactly standard fare.",
							name .. "These aren't things I have just lying around, understand?",
							name ..
								"But I am a Chef and you are a customer, so bring me all this garbage, and I'll cook your weird meal for you.",
							name ..
								"The recipe calls for the following:\n\n2 Brains (Behemoth)\n1 Eyeball (Gorgon)\n1 Giant Boar Carcass\n250 Boar Tail\n1 cup Dragon Saliva\n50 pieces of Charred Bark\n50 bunches of Gamagrass\n\n",
							name .. "I'll start cooking as soon as you gather that all together and bring it to me.",
							name .. "I don't even know where to begin looking for this stuff, it's all weird and gross.",
							name .. "You know who likes weird stuff? That kid Harvey. Maybe he can help you."
						},
						1
					)
					player:msg(4, "[Quest Update] Bring the ingredients to Chef Salmon!", player.ID)
				else
					player:dialogSeq({t, name .. "Do you have a recipe?"}, 1)
				end
			elseif menu == "I have the ingredients" then
				if weapon ~= nil and weapon.yname == "eclipse_torch" then
					player:dialogSeq({t, name .. "Remove that torch at once!"}, 1)
					return
				end

				if
					player:hasItem("gorgons_eye", 1) == true and player:hasItem("behemoths_brain", 2) == true and
						player:hasItem("charred_living_bark", 50) == true and
						player:hasItem("dragon_saliva", 1) == true and
						player:hasItem("boar_tail", 250) == true and
						player:hasItem("giant_boar_carcass", 1) == true and
						player:hasItem("gamagrass", 50) == true
				 then
					if
						player:removeItem("gorgons_eye", 1) == true and player:removeItem("behemoths_brain", 2) == true and
							player:removeItem("charred_living_bark", 50) == true and
							player:removeItem("dragon_saliva", 1) == true and
							player:removeItem("boar_tail", 250) == true and
							player:removeItem("giant_boar_carcass", 1) == true and
							player:removeItem("gamagrass", 50) == true
					 then
						player.quest["angry_guard"] = 10
						player:msg(4, "[Quest Update] Come back when the meal is ready!", player.ID)
						player.registry["orcish_delight_timer"] = os.time() + 43200
						player:dialogSeq(
							{
								t,
								name .. "I won't ask where you dug up all this trash, but I suppose I've already agreed to cook it for you.",
								name .. "Good food takes time, so you're going to have to come back later, when it's ready.",
								name .. "12 hours of simmering should do it, and no less.."
							},
							1
						)
					else
						player:dialogSeq(
							{
								t,
								name ..
									"The recipe calls for the following:\n\n2 Brains (Behemoth)\n1 Eyeball (Gorgon)\n1 Giant Boar Carcass\n250 Boar Tail\n1 cup Dragon Saliva\n50 pieces of Charred Bark\n50 bunches of Gamagrass\n\n",
								name .. "I'll start cooking as soon as you gather that all together and bring it to me.",
								name .. "I don't even know where to begin looking for this stuff, it's all weird and gross.",
								name .. "You know who likes weird stuff? That kid Harvey. Maybe he can help you."
							},
							1
						)
					end
				else
					player:dialogSeq(
						{
							t,
							name ..
								"The recipe calls for the following:\n\n2 Brains (Behemoth)\n1 Eyeball (Gorgon)\n1 Giant Boar Carcass\n250 Boar Tail\n1 cup Dragon Saliva\n50 pieces of Charred Bark\n50 bunches of Gamagrass\n\n",
							name .. "I'll start cooking as soon as you gather that all together and bring it to me.",
							name .. "I don't even know where to begin looking for this stuff, it's all weird and gross.",
							name .. "You know who likes weird stuff? That kid Harvey. Maybe he can help you."
						},
						1
					)
				end
			elseif menu == "Repeat the recipe" then
				player:dialogSeq(
					{
						t,
						name ..
							"The recipe calls for the following:\n\n2 Brains (Behemoth)\n1 Eyeball (Gorgon)\n1 Giant Boar Carcass\n250 Boar Tail\n1 cup Dragon Saliva\n50 pieces of Charred Bark\n50 bunches of Gamagrass\n\n",
						name .. "I'll start cooking as soon as you gather that all together and bring it to me.",
						name .. "I don't even know where to begin looking for this stuff, it's all weird and gross.",
						name .. "You know who likes weird stuff? That kid Harvey. Maybe he can help you."
					},
					1
				)
			elseif menu == "Is the meal ready?" then
				if player.registry["orcish_delight_timer"] > 0 and player.registry["orcish_delight_timer"] < os.time() then
					player:addItem("orcish_delight", 1)
					player:removeItem("eclipse_torch", 1)
					giveXP(player, 20000000)
					finishedQuest(player)
					player:calcStat()
					player:sendStatus()
					player:msg(4, "[Quest Update] Bring the Cathay guard his meal!", player.ID)
					player.quest["angry_guard"] = 11
					player:dialogSeq(
						{
							t,
							name .. "Yeah, it's ready all right.",
							name .. "This sure is a lot of effort to go to just to get into Cathay.",
							name .. "Me, I would have just offered the guard a fat bribe.",
							name .. "I've never known a city guard to turn down 500,000 coins."
						},
						1
					)
				else
					player:dialogSeq(
						{
							t,
							name .. "No, not yet.",
							name .. "Come back later."
						},
						1
					)
				end
			end
		end
	)
}
