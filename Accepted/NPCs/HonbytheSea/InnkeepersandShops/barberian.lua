barberian = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0

			local crown = player:getEquippedItem(9) -- detects presence of crown

			local facialHairOpts = {}

			--	for i = 1, 7 do
			--		if player.registry["facial_hair_"..i] > 0 then
			--			table.insert(facialHairOpts, "Style "..i)
			--		end
			--	end

			if player.registry["facial_hair_1"] > 0 then
				table.insert(facialHairOpts, "Regular Beard")
			end
			if player.registry["facial_hair_2"] > 0 then
				table.insert(facialHairOpts, "Thick Beard")
			end
			if player.registry["facial_hair_3"] > 0 then
				table.insert(facialHairOpts, "Long Beard")
			end
			if player.registry["facial_hair_4"] > 0 then
				table.insert(facialHairOpts, "Pointed Beard")
			end
			if player.registry["facial_hair_5"] > 0 then
				table.insert(facialHairOpts, "Handlebar")
			end
			if player.registry["facial_hair_6"] > 0 then
				table.insert(facialHairOpts, "Goatee")
			end
			if player.registry["facial_hair_7"] > 0 then
				table.insert(facialHairOpts, "Regular Mustache")
			end
			if player.ID == 4 then
				table.insert(facialHairOpts, "Jacob's Mustache")
			end

			local opts = {}
			table.insert(opts, "Face Surgery")
			table.insert(opts, "Eye Dye")
			table.insert(opts, "Hair Styles")
			table.insert(opts, "Hair Dye")
			table.insert(opts, "Facial Hair")
			if crown then
				table.insert(opts, "Crown Dye")
			end
			if player.faceAccessoryTwo > 0 then
				table.insert(opts, "Facial Hair Dye")
			end
			table.insert(opts, "Exit")

			menu = player:menuString(name .. "<b>[Look Shop]\n\nWe can change your look!", opts)

			if menu == "Face Surgery" then
				local model = {}
				table.insert(model, "Browse Faces")
				table.insert(model, "Leave")

				modelChoice = player:menuString(name .. "<b>[Face Surgery]\n\nThese are the available faces", model)

				if modelChoice == "Browse Faces" then
					if player.m ~= 2005 then
						player:sendMinitext("You can't browse if you leave the shop!")
						return
					end
					--if player.gfxFace > 211 then player.gfxFace = 200 end
					if player.gfxClone == 0 then
						clone.equip(player, player)
						clone.equip(player, npc)
					else
						clone.gfx(player, player)
						clone.gfx(player, npc)
					end
					player.gfxClone = 1
					player:updateState()
					player.registry["browse_face_limit"] = 238
					barberian.browseFace(player, npc)
				else
				end
			elseif menu == "Eye Dye" then
				local model = {}
				table.insert(model, "Browse Eye Dye")
				table.insert(model, "Remove Eye Dye")
				table.insert(model, "Leave")

				modelChoice = player:menuString(name .. "<b>[Eye Dye]\n\nThese are the available eye dyes", model)

				if modelChoice == "Browse Eye Dye" then
					if player.m ~= 2005 then
						player:sendMinitext("You can't browse if you leave the shop!")
						return
					end
					--if player.gfxFace > 211 then player.gfxFace = 200 end
					if player.gfxClone == 0 then
						clone.equip(player, player)
						clone.equip(player, npc)
					else
						clone.gfx(player, player)
						clone.gfx(player, npc)
					end
					player.gfxClone = 1
					player:updateState()
					player.registry["browse_eye_color_limit"] = 80
					barberian.browseEyeDye(player, npc)
				elseif modelChoice == "Remove Eye Dye" then
					confirm = player:menuString(name .. "<b>[Eye Dye]\n\nAre you sure you want to remove your dye?", {"Yes", "No"})
					if confirm == "Yes" then
						player:sendAnimation(10)
						player.gfxClone = 0
						player.faceColor = 0
						player:updateState()
					end
				end
			elseif menu == "Hair Styles" then
				local model = {}
				table.insert(model, "Browse Hair Styles")
				table.insert(model, "Leave")

				modelChoice = player:menuString(name .. "<b>[Hair Styles]\n\nThese are the available hair styles", model)
				if modelChoice == "Browse Hair Styles" then
					if player.m ~= 2005 then
						player:sendMinitext("You can't browse if you leave the shop!")
						return
					end
					--if player.gfxHair > 44 then player.gfxHair = 0 end
					if player.gfxClone == 0 then
						clone.equip(player, player)
						clone.equip(player, npc)
					else
						clone.gfx(player, player)
						clone.gfx(player, npc)
					end
					player.gfxClone = 1
					player:updateState()
					player.registry["browse_hair_limit"] = 130
					barberian.browseHair(player, npc)
				else
				end
			elseif menu == "Hair Dye" then
				local model = {}
				table.insert(model, "Browse Hair Dye")
				table.insert(model, "Remove Hair Dye")
				table.insert(model, "Leave")

				modelChoice = player:menuString(name .. "<b>[Hair Dye]\n\nThese are the available hair dyes", model)
				if modelChoice == "Browse Hair Dye" then
					if player.m ~= 2005 then
						player:sendMinitext("You can't browse if you leave the shop!")
						return
					end
					--if player.gfxHairC > 20 then player.gfxHairC = 0 end
					if player.gfxClone == 0 then
						clone.equip(player, player)
						clone.equip(player, npc)
					else
						clone.gfx(player, player)
						clone.gfx(player, npc)
					end
					player.gfxClone = 1
					player:updateState()
					player.registry["browse_hair_color_limit"] = 80
					barberian.browseHairDye(player, npc)
				elseif modelChoice == "Remove Hair Dye" then
					confirm = player:menuString(name .. "<b>[Hair Dye]\n\nAre you sure you want to remove your dye?", {"Yes", "No"})
					if confirm == "Yes" then
						player:sendAnimation(10)
						player.gfxClone = 0
						player.hairColor = 0
						player:updateState()
					end
				end
			elseif menu == "Facial Hair" then
				choice =
					player:menuString(name .. "<b>[Facial Hair]\n\nWhat would you like to do?", {"Browse Facial Hair", "Shave"})
				if choice == "Browse Facial Hair" then
					if player.m ~= 2005 then
						player:sendMinitext("You can't browse if you leave the shop!")
						return
					end
					style = player:menuString(name .. "<b>[Facial Hair]\n\nWhich style would you like?", facialHairOpts)
					if style == "Regular Beard" then
						player.faceAccessoryTwo = 1
						player:updateState()
					elseif style == "Thick Beard" then
						player.faceAccessoryTwo = 2
						player:updateState()
					elseif style == "Long Beard" then
						player.faceAccessoryTwo = 3
						player:updateState()
					elseif style == "Pointed Beard" then
						player.faceAccessoryTwo = 4
						player:updateState()
					elseif style == "Handlebar" then
						player.faceAccessoryTwo = 5
						player:updateState()
					elseif style == "Goatee" then
						player.faceAccessoryTwo = 6
						player:updateState()
					elseif style == "Regular Mustache" then
						player.faceAccessoryTwo = 7
						player:updateState()
					elseif style == "Jacob's Mustache" then
						player.faceAccessoryTwo = 21
						player:updateState()
					end
				elseif choice == "Shave" then
					player.faceAccessoryTwo = 0
					player:updateState()
				end
			elseif menu == "Facial Hair Dye" then
				local model = {}
				table.insert(model, "Browse Facial Hair Dye")
				table.insert(model, "Remove Facial Hair Dye")
				table.insert(model, "Leave")

				modelChoice = player:menuString(name .. "<b>[Facial Hair Dye]\n\nThese are the available dyes", model)
				if modelChoice == "Browse Facial Hair Dye" then
					if player.m ~= 2005 then
						player:sendMinitext("You can't browse if you leave the shop!")
						return
					end
					--if player.gfxFaceATC > 20 then player.gfxFaceATC = 0 end
					if player.gfxClone == 0 then
						clone.equip(player, player)
						clone.equip(player, npc)
					else
						clone.gfx(player, player)
						clone.gfx(player, npc)
					end
					player.gfxClone = 1
					player:updateState()
					player.registry["browse_facial_hair_color_limit"] = 80
					barberian.browseFacialHairDye(player, npc)
				elseif modelChoice == "Remove Facial Hair Dye" then
					confirm =
						player:menuString(name .. "<b>[Facial Hair Dye]\n\nAre you sure you want to remove your dye?", {"Yes", "No"})
					if confirm == "Yes" then
						player.gfxClone = 0
						player.faceAccessoryTwoColor = 0
						player.registry["face_accessory_two_color"] = 0
						player:sendAnimation(10)
						player:updateState()
					end
				end
			elseif menu == "Crown Dye" then
				local model = {}
				table.insert(model, "Browse Crown Dye")
				table.insert(model, "Remove Crown Dye")
				table.insert(model, "Leave")

				modelChoice = player:menuString(name .. "<b>[Crown Dye]\n\nThese are the available dyes", model)
				if modelChoice == "Browse Crown Dye" then
					if player.m ~= 2005 then
						player:sendMinitext("You can't browse if you leave the shop!")
						return
					end
					--if player.gfxFaceATC > 20 then player.gfxFaceATC = 0 end
					if player.gfxClone == 0 then
						clone.equip(player, player)
						clone.equip(player, npc)
					else
						clone.gfx(player, player)
						clone.gfx(player, npc)
					end
					player.gfxClone = 1
					player:updateState()
					player.registry["browse_crown_color_limit"] = 80
					barberian.browseCrownDye(player, npc)
				elseif modelChoice == "Remove Crown Dye" then
					confirm = player:menuString(name .. "<b>[Crown Dye]\n\nAre you sure you want to remove your dye?", {"Yes", "No"})
					if confirm == "Yes" then
						player.gfxClone = 0
						setCrown(player, 0, 0, 0, 0)
						player:sendAnimation(10)
						player:updateState()
					end
				end
			end
		end
	),
	say = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local s = string.lower(player.speech)

			if string.find(s, "(.*)random(.*)") or string.find(s, "(.*)gerard(.*)") or string.find(s, "(.*)brothers(.*)") then
				if player.quest["brothers_peace"] == 1 then
					player:dialogSeq(
						{
							t,
							name .. "Those boys!",
							name .. "I thought they had grown up, but it sounds like they still behave as children!",
							name ..
								"I'm going to have to send a letter to those boys in Cathay immediately and put a stop to all of this nonsense.",
							name .. "Their father wanted them to run the business together!",
							name ..
								"He knew Random was better for the front office and Gerard better for the warehouse, but they both wanted it all.",
							name .. "It sounds like each one stole his brother's half and has been seeking help to take the rest!",
							name .. "No sons of mine will behave in such a manner, not while I still draw breath.",
							name .. "Go then, tell them a letter is coming from me, and maybe a visit as well.",
							name .. "Let them quiver in fear of their dear old mother for a time. *laughs*"
						},
						1
					)
					player.quest["brothers_peace"] = 2
				end
			end
		end
	),
	browseFace = function(player, npc)
		local name = "<b>[" .. npc.name .. "]\n\n"
		local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 2

		local opts = {}
		table.insert(opts, "Next ->>")
		table.insert(opts, "I want this face")
		table.insert(opts, "<<- Previous")

		local limit = player.registry["browse_face_limit"]
		local model
		local price

		model = " Face Surgery "

		clone.gfx(player, npc)
		menu = player:menuString(name .. "<b>[" .. model .. "]\n\n    Style: " .. player.gfxFace, opts)
		--menu = player:menuString(name.."<b>[".. model .."]", opts)

		if menu == "Next ->>" then
			if player.gfxFace >= limit then
				player.gfxFace = 200
			else
				player.gfxFace = player.gfxFace + 1
			end
			player:updateState()
			return barberian.browseFace(player, npc)
		elseif menu == "I want this face" then
			local buy = {"Buy"}
			ok = player:menuString(name .. "<b>[" .. model .. "]\n\nPay 2500 coins for this face?", buy)
			if ok == "Buy" then
				if player:removeGold(2500) == true then
					player.face = player.gfxFace
					player.gfxClone = 0
					player:updateState()
					player:sendMinitext("You changed your face!")
				else
					player:popUp("Not Enough gold!")
					player.gfxClone = 0
					player:updateState()
				end
			else
				player.gfxClone = 0
				player:updateState()
			end
		elseif menu == "<<- Previous" then
			if player.gfxFace <= 200 then
				player.gfxFace = limit
			else
				player.gfxFace = player.gfxFace - 1
			end

			player:updateState()
			return barberian.browseFace(player, npc)
		else
			player.gfxClone = 0
			player:updateState()
		end
	end,
	browseEyeDye = function(player, npc)
		local name = "<b>[" .. npc.name .. "]\n\n"
		local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 2

		local opts = {}
		table.insert(opts, "Next ->>")
		table.insert(opts, "I want this color")
		table.insert(opts, "<<- Previous")

		local limit = player.registry["browse_eye_color_limit"]
		local model
		local price

		model = " Eye Dye "

		clone.gfx(player, npc)
		menu = player:menuString(name .. "<b>[" .. model .. "]\n\n    Color: " .. player.gfxFaceC, opts)
		if menu == "Next ->>" then
			if player.gfxFaceC >= limit then
				player.gfxFaceC = 0
			else
				player.gfxFaceC = player.gfxFaceC + 1
			end
			player:updateState()
			return barberian.browseEyeDye(player, npc)
		elseif menu == "I want this color" then
			local buy = {"Buy"}
			ok = player:menuString(name .. "<b>[" .. model .. "]\n\nPay 2500 coins for this color?", buy)
			if ok == "Buy" then
				if player:removeGold(2500) == true then
					player.faceColor = player.gfxFaceC
					player.gfxClone = 0
					player:updateState()
					player:sendMinitext("You changed your eye color!")
				else
					player:popUp("Not Enough gold!")
					player.gfxClone = 0
					player:updateState()
				end
			else
				player.gfxClone = 0
				player:updateState()
			end
		elseif menu == "<<- Previous" then
			if player.gfxFaceC <= 0 then
				player.gfxFaceC = limit
			else
				player.gfxFaceC = player.gfxFaceC - 1
			end

			player:updateState()
			return barberian.browseEyeDye(player, npc)
		else
			player.gfxClone = 0
			player:updateState()
		end
	end,
	browseHair = function(player, npc)
		local name = "<b>[" .. npc.name .. "]\n\n"
		local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 2

		local opts = {}
		table.insert(opts, "Next ->>")
		table.insert(opts, "I want this hair")
		table.insert(opts, "<<- Previous")

		local limit = player.registry["browse_hair_limit"]
		local model
		local price

		model = " Hair Style "

		clone.gfx(player, npc)
		menu = player:menuString(name .. "<b>[" .. model .. "]\n\n    Style: " .. player.gfxHair, opts)
		--menu = player:menuString(name.."<b>[".. model .."]", opts)

		if menu == "Next ->>" then
			if player.gfxHair >= limit then
				player.gfxHair = 0
			else
				player.gfxHair = player.gfxHair + 1
			end
			player:updateState()
			return barberian.browseHair(player, npc)
		elseif menu == "I want this hair" then
			local buy = {"Buy"}
			ok = player:menuString(name .. "<b>[" .. model .. "]\n\nPay 2500 coins for this hair?", buy)
			if ok == "Buy" then
				if player:removeGold(2500) == true then
					player.hair = player.gfxHair
					player.gfxClone = 0
					player:updateState()
					player:sendMinitext("You changed your hair style!")
				else
					player:popUp("Not Enough gold!")
					player.gfxClone = 0
					player:updateState()
				end
			else
				player.gfxClone = 0
				player:updateState()
			end
		elseif menu == "<<- Previous" then
			if player.gfxHair <= 0 then
				player.gfxHair = limit
			else
				player.gfxHair = player.gfxHair - 1
			end

			player:updateState()
			return barberian.browseHair(player, npc)
		else
			player.gfxClone = 0
			player:updateState()
		end
	end,
	browseHairDye = function(player, npc)
		local name = "<b>[" .. npc.name .. "]\n\n"
		local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 2

		local opts = {}
		table.insert(opts, "Next ->>")
		table.insert(opts, "I want this color")
		table.insert(opts, "<<- Previous")

		local limit = player.registry["browse_hair_color_limit"]
		local model
		local price

		model = " Hair Dye "

		clone.gfx(player, npc)
		menu = player:menuString(name .. "<b>[" .. model .. "]\n\n    Color: " .. player.gfxHairC, opts)
		--menu = player:menuString(name.."<b>[".. model .."]", opts)
		if menu == "Next ->>" then
			if player.gfxHairC >= limit then
				player.gfxHairC = 0
			else
				player.gfxHairC = player.gfxHairC + 1
			end
			player:updateState()
			return barberian.browseHairDye(player, npc)
		elseif menu == "I want this color" then
			local buy = {"Buy"}
			ok = player:menuString(name .. "<b>[" .. model .. "]\n\nPay 2500 coins for this color?", buy)
			if ok == "Buy" then
				if player:removeGold(2500) == true then
					player.hairColor = player.gfxHairC
					player.gfxClone = 0
					player:updateState()
					player:sendMinitext("You changed your hair color!")
				else
					player:popUp("Not Enough gold!")
					player.gfxClone = 0
					player:updateState()
				end
			else
				player.gfxClone = 0
				player:updateState()
			end
		elseif menu == "<<- Previous" then
			if player.gfxHairC <= 0 then
				player.gfxHairC = limit
			else
				player.gfxHairC = player.gfxHairC - 1
			end

			player:updateState()
			return barberian.browseHairDye(player, npc)
		else
			player.gfxClone = 0
			player:updateState()
		end
	end,
	browseCrownDye = function(player, npc)
		local name = "<b>[" .. npc.name .. "]\n\n"
		local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 2

		local opts = {}
		table.insert(opts, "Next ->>")
		table.insert(opts, "I want this color")
		table.insert(opts, "<<- Previous")

		local limit = player.registry["browse_crown_color_limit"]
		local model
		local price

		local crown = player:getEquippedItem(9) -- detects presence of crown

		model = " Crown Dye "

		clone.gfx(player, npc)
		menu = player:menuString(name .. "<b>[" .. model .. "]\n\n    Color: " .. player.gfxHairC, opts)
		--menu = player:menuString(name.."<b>[".. model .."]", opts)
		if menu == "Next ->>" then
			if player.gfxCrownC >= limit then
				player.gfxCrownC = 0
			else
				player.gfxCrownC = player.gfxCrownC + 1
			end
			player:updateState()
			return barberian.browseCrownDye(player, npc)
		elseif menu == "I want this color" then
			local buy = {"Buy"}
			ok =
				player:menuString(
				name ..
					"<b>[" ..
						model ..
							"]\n\nDISCLAIMER: Applying a DYE makes this crown a skinned item, therefore unbankable/depositable.\n\nPay 2500 coins for this color?",
				buy
			)
			if ok == "Buy" then
				if player:removeGold(2500) == true then
					--if crown then
					--player:talk(0,"ID: "..crown.id.." Look: "..crown.look.." Look Color: "..crown.lookC.." Icon: "..crown.icon.." Icon Color: "..crown.iconC)
					--end

					setCrown(player, crown.look, player.gfxCrownC, crown.icon - 49152, player.gfxCrownC)
					player.gfxClone = 0
					player:updateState()
					player:sendMinitext("You changed your crown color!")
				else
					player:popUp("Not Enough gold!")
					player.gfxClone = 0
					player:updateState()
				end
			else
				player.gfxClone = 0
				player:updateState()
			end
		elseif menu == "<<- Previous" then
			if player.gfxCrownC <= 0 then
				player.gfxCrownC = limit
			else
				player.gfxCrownC = player.gfxCrownC - 1
			end

			player:updateState()
			return barberian.browseCrownDye(player, npc)
		else
			player.gfxClone = 0
			player:updateState()
		end
	end,
	browseFacialHairDye = function(player, npc)
		local name = "<b>[" .. npc.name .. "]\n\n"
		local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 2

		local opts = {}
		table.insert(opts, "Next ->>")
		table.insert(opts, "I want this color")
		table.insert(opts, "<<- Previous")

		local limit = player.registry["browse_facial_hair_color_limit"]
		local model
		local price

		model = " Facial Hair Dye "

		clone.gfx(player, npc)
		menu = player:menuString(name .. "<b>[" .. model .. "]\n\n    Color: " .. player.gfxFaceATC, opts)
		--menu = player:menuString(name.."<b>[".. model .."]", opts)
		if menu == "Next ->>" then
			if player.gfxFaceATC >= limit then
				player.gfxFaceATC = 0
			else
				player.gfxFaceATC = player.gfxFaceATC + 1
			end
			player:updateState()
			return barberian.browseFacialHairDye(player, npc)
		elseif menu == "I want this color" then
			local buy = {"Buy"}
			ok = player:menuString(name .. "<b>[" .. model .. "]\n\nPay 2500 coins for this color?", buy)
			if ok == "Buy" then
				if player:removeGold(2500) == true then
					player.faceAccessoryTwoColor = player.gfxFaceATC
					player.registry["face_accessory_two_color"] = player.gfxFaceATC
					player.gfxClone = 0
					player:updateState()
					player:sendMinitext("You changed your facial hair color!")
				else
					player:popUp("Not Enough gold!")
					player.gfxClone = 0
					player:updateState()
				end
			else
				player.gfxClone = 0
				player:updateState()
			end
		elseif menu == "<<- Previous" then
			if player.gfxFaceATC <= 0 then
				player.gfxFaceATC = limit
			else
				player.gfxFaceATC = player.gfxFaceATC - 1
			end

			player:updateState()
			return barberian.browseFacialHairDye(player, npc)
		else
			player.gfxClone = 0
			player:updateState()
		end
	end
}
