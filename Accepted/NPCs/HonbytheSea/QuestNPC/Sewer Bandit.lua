-- Sewer Bandit
sewer_bandit = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local f = {graphic = convertGraphic(1189, "item"), color = 24}
			local s = {graphic = convertGraphic(490, "item"), color = 30}
			local w = {graphic = convertGraphic(2288, "item"), color = 26}
			local p = {graphic = convertGraphic(697, "item"), color = 12}

			local quest1 = player.quest["fighter_path"]
			local quest2 = player.quest["scoundrel_path"]
			local quest3 = player.quest["wizard_path"]
			local quest4 = player.quest["priest_path"]
			local opts = {}

			if quest1 == 1 then
				table.insert(opts, "What are you doing down here?")
			end
			if quest1 == 2 then
				table.insert(opts, "Where are the rest of your men?")
			end
			if quest1 >= 3 then
				table.insert(opts, "So what are you going to do then?")
			end

			if quest2 == 1 then
				table.insert(opts, "What are you doing down here?")
			end
			if quest2 == 2 then
				table.insert(opts, "Where are the rest of the traitors?")
			end
			if quest2 >= 3 then
				table.insert(opts, "So what are you going to do then?")
			end

			if quest3 == 1 then
				table.insert(opts, "What are you doing down here?")
			end
			if quest3 == 2 then
				table.insert(opts, "Is there anyone else down here?")
			end
			if quest3 >= 3 then
				table.insert(opts, "So what are you going to do then?")
			end

			if quest4 == 1 then
				table.insert(opts, "What are you doing down here?")
			end
			if quest4 == 2 then
				table.insert(opts, "Is there anyone else down here?")
			end
			if quest4 >= 3 then
				table.insert(opts, "So what are you going to do then?")
			end

			menu = player:menuString(name .. "How did you make it past all those rats?", opts)
			----------------------------------------------------------------------------------------------------------

			if menu == "What are you doing down here?" and quest1 <= 1 and player.class == 1 then
				player:dialogSeq({t, name .. "Rats... Snakes... Rats... Snakes... WHHHHYYYYYY?!?!?!?!?!?!?!"}, 1)
			elseif menu == "Where are the rest of your men?" and quest1 == 2 and player.class == 1 then
				player:dialogSeq(
					{
						t,
						name ..
							"I ran away with two others, but we got seperated. There were rats everywhere, bigger than any you've ever seen.  I think there are ghosts inside the walls down here. We heard horrible grinding sounds...",
						name ..
							"I saw the rats eating Tommy, but I think Gerald got away. I didn't see it but I heard him scream 'These rats are worse than the snakes!' I just kept running until I was able to hide here.",
						name .. "I don't have any fight left in me. Just take this and leave, please.",
						f,
						"The bandit gives you some new hand items! Press 'i' to see!"
					},
					1
				)
				player.quest["fighter_path"] = 3
				player:addItem(16401, 2)
				player:msg(
					4,
					"[Quest Updated] Return to the Fighter's Guild in Hon at X:89 Y:49 for further instruction!  ",
					player.ID
				)
			elseif menu == "So what are you going to do then?" and quest1 >= 3 and player.class == 1 then
				------------------------------------------------
				player:dialogSeq(
					{
						t,
						name ..
							"I am going to find a moment when the rats are sleeping, and get out of this life style and sewer for good.."
					},
					1
				)
			elseif menu == "What are you doing down here?" and quest2 <= 1 and player.class == 2 then
				player:dialogSeq({t, name .. "Rats... Snakes... Rats... Snakes... WHHHHYYYYYY?!?!?!?!?!?!?!"}, 1)
			elseif menu == "Where are the rest of the traitors?" and quest2 == 2 and player.class == 2 then
				player:dialogSeq(
					{
						t,
						name ..
							"I ran away with two others, but we got seperated. There were rats everywhere, bigger than any you've ever seen.  I think there are ghosts inside the walls down here. We heard horrible grinding sounds...",
						name ..
							"I saw the rats eating Tommy, but I think Gerald got away. I didn't see it but I heard him scream 'These rats are worse than the snakes!' I just kept running until I was able to hide here.",
						name .. "I don't have any fight left in me. Just take this and leave, please.",
						s,
						"The bandit gives you some new hand items! Press 'i' to see!"
					},
					1
				)
				player.quest["scoundrel_path"] = 3
				player:addItem(17401, 2)
				player:msg(
					4,
					"[Quest Updated] Return to the Scoundrel's Guild in Hon at X:125 Y:35 for further instruction! ",
					player.ID
				)
			elseif menu == "So what are you going to do then?" and quest2 >= 3 and player.class == 2 then
				------------------------------------------------------
				player:dialogSeq(
					{
						t,
						name ..
							"I am going to find a moment when the rats are sleeping, and get out of this life style and sewer for good.."
					},
					1
				)
			elseif menu == "What are you doing down here?" and quest3 <= 1 and player.class == 3 then
				player:dialogSeq({t, name .. "Rats... Snakes... Rats... Snakes... WHHHHYYYYYY?!?!?!?!?!?!?!"}, 1)
			elseif menu == "Is there anyone else down here?" and quest3 == 2 and player.class == 3 then
				player:dialogSeq(
					{
						t,
						name ..
							"I ran away with two others, but we got seperated. There were rats everywhere, bigger than any you've ever seen.  I think there are ghosts inside the walls down here. We heard horrible grinding sounds...",
						name ..
							"I saw the rats eating Tommy, but I think Gerald got away. I didn't see it but I heard him scream 'These rats are worse than the snakes!' I just kept running until I was able to hide here.",
						name .. "I don't have any fight left in me. Just take this and leave, please.",
						w,
						"The bandit gives you some new hand items! Press 'i' to see!"
					},
					1
				)
				player.quest["wizard_path"] = 3
				player:addItem(18401, 2)
				player:msg(
					4,
					"[Quest Updated] Go See Delta in Hon at X:111 Y:52 to return to Seagrove for further instruction! ",
					player.ID
				)
			elseif menu == "So what are you going to do then?" and quest3 >= 3 and player.class == 3 then
				--------------------------------------------------------------
				player:dialogSeq(
					{
						t,
						name ..
							"I am going to find a moment when the rats are sleeping, and get out of this life style and sewer for good.."
					},
					1
				)
			elseif menu == "What are you doing down here?" and quest4 <= 1 and player.class == 4 then
				player:dialogSeq({t, name .. "Rats... Snakes... Rats... Snakes... WHHHHYYYYYY?!?!?!?!?!?!?!"}, 1)
			elseif menu == "Is there anyone else down here?" and quest4 == 2 and player.class == 4 then
				player:dialogSeq(
					{
						t,
						name ..
							"I ran away with two others, but we got seperated. There were rats everywhere, bigger than any you've ever seen.  I think there are ghosts inside the walls down here. We heard horrible grinding sounds...",
						name ..
							"I saw the rats eating Tommy, but I think Gerald got away. I didn't see it but I heard him scream 'These rats are worse than the snakes!' I just kept running until I was able to hide here.",
						name .. "I don't have any fight left in me. Just take this and leave, please.",
						p,
						"The bandit gives you some new hand items! Press 'i' to see!"
					},
					1
				)
				player.quest["priest_path"] = 3
				player:addItem(19401, 2)
				player:msg(4, "[Quest Updated] Return to House of ASAK in Hon at X:31 Y:38 for further instruction!", player.ID)
			elseif menu == "So what are you going to do then?" and quest4 >= 3 and player.class == 4 then
				player:dialogSeq(
					{
						t,
						name ..
							"I am going to find a moment when the rats are sleeping, and get out of this life style and sewer for good.."
					},
					1
				)
			else
				player:dialogSeq({t, name .. "Rats... Snakes... Rats... Snakes... WHHHHYYYYYY?!?!?!?!?!?!?!"}, 1)
			end
		end
	),
	nearbyPlayers = function(npc)
		local pc = npc:getObjectsInArea(BL_PC)
		local m, x, y = npc.m, npc.x, npc.y

		if #pc > 0 then
			for i = 1, #pc do
				if
					pc[i].quest["fighter_path"] == 2 or pc[i].quest["scoundrel_path"] == 2 or pc[i].quest["wizard_path"] == 2 or
						pc[i].quest["priest_path"] == 2
				 then
					pc[i]:selfAnimationXY(pc[i].ID, 248, x, y)
				end
			end
		end
	end
}
