hon_militia = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local opts = {}

			local killcount1301 = player:killCount(1301)
			local killcount1302 = player:killCount(1302)
			local killcount1303 = player:killCount(1303)
			local killcount1304 = player:killCount(1304)

			if player.quest["front_lines"] == 0 and player.level >= 35 then
				table.insert(opts, "Work on the Front Lines")
			end
			if player.quest["supply_lines"] == 0 and player.level >= 35 then
				table.insert(opts, "Work on the Supply Lines")
			end

			if player.quest["front_lines"] == 1 and player.level >= 35 then
				table.insert(opts, "I'm back from the Front Lines")
			end
			if player.quest["supply_lines"] == 1 and player.level >= 35 then
				table.insert(opts, "I'm back from the Supply Lines")
			end

			menu = player:menuString(name .. "Are you here to enlist? There's always lots of work to do.", opts)
			if menu == "Work on the Front Lines" then
				player:flushKills(1301)
				player:flushKills(1302)
				player:flushKills(1303)
				player:flushKills(1304)
				player.quest["front_lines"] = 1
				player:msg(4, "[Quest Started] Kill 50 Savage Spearmaidens, Highwayman and Stickman, and 1 Warchief", player.ID)
				player:dialogSeq(
					{
						t,
						name .. "Great news, maggot!",
						name .. "Your assignment is simple: prove your mettle.",
						name .. "To do that, you're going to enter the Savage Territory and slay a whole hell of a lot of them.",
						name ..
							"Kill at least 50 each of the Savage Spearmaidens, Savage Highwaymen and Savage Stickment, and at least 1 Savage Warchief, then return here."
					},
					1
				)
			elseif menu == "Work on the Supply Lines" then
				player.quest["supply_lines"] = 1
				player:msg(4, "[Quest Started] Recover 10 crates of Militia Rations!", player.ID)
				player:dialogSeq(
					{
						t,
						name .. "Great news, maggot!",
						name .. "Your assignment is simple: prove your worth.",
						name ..
							"To do that, you're going to enter the Savage Territory and recover some of the rations they've stolen from our supply lines.",
						name .. "Gather up 10 Ration Boxes, then return here."
					},
					1
				)
			elseif menu == "I'm back from the Front Lines" then
				if killcount1301 >= 50 and killcount1302 >= 50 and killcount1303 >= 50 and killcount1304 >= 1 then
					player.quest["front_lines"] = 2
					player:addGold(2500)
					giveXP(player, 150000)
					player:sendStatus()
					player:addLegend("Aided Hon Front Lines " .. curT(), "front_lines", 9, 16)
					finishedQuest(player)
					player:msg(4, "[Quest Complete] Aided Hon Militia on the Front Lines!", player.ID)
					player:dialogSeq({t, name .. "Great work! I wish the rest of my recruits showed as much promise..."}, 1)
				else
					player:dialogSeq({t, name .. "What are you waiting for? Get out there and kill more savages!"}, 1)
				end
			elseif menu == "I'm back from the Supply Lines" then
				if player:hasItem("militia_rations", 10) == true then
					player:removeItem("militia_rations", 10)
					player.quest["supply_lines"] = 2
					player:addGold(10000)
					giveXP(player, 100000)
					player:sendStatus()
					player:addLegend("Aided Hon Supply Lines " .. curT(), "supply_lines", 11, 16)
					finishedQuest(player)
					player:msg(4, "[Quest Complete] Aided Hon Militia on the Supply Lines!", player.ID)
					player:dialogSeq({t, name .. "Great work! I wish the rest of my recruits showed as much promise..."}, 1)
				else
					player:dialogSeq({t, name .. "What are you waiting for? Get out there and find those supplies!"}, 1)
				end
			end
		end
	),
	nearbyPlayers = function(npc)
		local pc = npc:getObjectsInArea(BL_PC)
		local m, x, y = npc.m, npc.x, npc.y

		if #pc > 0 then
			for i = 1, #pc do
				if pc[i].level >= 35 and (pc[i].quest["front_lines"] == 0 or pc[i].quest["supply_lines"] == 0) then
					pc[i]:selfAnimationXY(pc[i].ID, 248, x, y)
				end
			end
		end
	end
}
