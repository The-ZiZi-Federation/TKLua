-- Seagrove Wizard Delta in Hon by the Sea
seagrove_teleport_to_mage = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local mob = player:getObjectsInMap(player.m, BL_MOB)
			local quest = player.quest["angry_guard"]
			local quest2 = player.quest["enter_blackstrike"]

			local opts = {}
			table.insert(opts, "Take me to Seagrove please")
			if quest == 7 then
				table.insert(opts, "Finding Ingredients")
			end
			if quest2 == 1 and player.level >= 99 then
				table.insert(opts, "Send me inside the Tower")
			end

			menu = player:menuString(name .. "I am Delta, I can help you travel to Seagrove, and maybe more.", opts)

			if (menu == "Take me to Seagrove please") then
				if #mob > 0 then
					for i = 1, #mob do
						if mob[i].yname == "angry_blue_chick" then
							player:dialogSeq({t, name .. "Someone must have pissed off a God. You're going to have to wait."}, 1)
							return
						end
					end
				end
				if player.class == 0 or player.baseClass == 3 then
					player:sendAnimation(364)
					player:warp(1011, 7, 4)
					player:sendAnimation(254)
				else
					player:dialogSeq({t, name .. "I see no reason for you to go there right now!"}, 1)
				end
			end
			if (menu == "Finding Ingredients") then
				player:dialogSeq(
					{
						t,
						name .. "Behemoths Brain and Gorgon's Eye can be found in Ruins of Bettay",
						name .. "Gamagrass is Boar food. Found growing wild along the road to Cathay",
						name .. "Boars tend to hide, but if they see you messing with their food they get aggressive",
						name .. "Giant Boars, those are not very common but I would still check for their food to find them",
						name .. "Charred Living Bark comes from the Eternal Trees in Blackstrike Tower",
						name .. "Blackstrike Dragon Saliva!!! You are crazy! You will have to find him at top of tower."
					},
					1
				)
				player.quest["enter_blackstrike"] = 1
				player:msg(4, "[Quest Update] Ask Delta to teleport you into Blackstrike Tower!", player.ID)
			end

			if (menu == "Send me inside the Tower") then
				if #mob > 0 then
					for i = 1, #mob do
						if mob[i].yname == "angry_blue_chick" then
							player:dialogSeq({t, name .. "Someone must have pissed off a God. You're going to have to wait."}, 1)
							return
						end
					end
				end
				if player.state ~= 1 then
					player:warp(1331, 3, 31)
					if player.quest["angry_guard"] == 7 then
						player.quest["angry_guard"] = 8
						player:msg(4, "[Quest Updated] Fight your way through the Tower!", player.ID)
					end
				else
					player:dialogSeq({t, name .. "I can not teleport the dead! Seek out the House of ASAK!"}, 1)
				end
			end
		end
	)
}
