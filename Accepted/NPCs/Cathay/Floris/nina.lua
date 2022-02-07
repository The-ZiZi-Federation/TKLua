nina = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local opts = {}

			if player.registry["dailyq_flowergirl_timer"] < os.time() then
				table.insert(opts, "Give her a Bouquet")
			end

			menu = player:menuString(name .. "...what...?", opts)

			if menu == "Give her a Bouquet" then
				if player:hasItem("pink_flower_bouquet", 1) == true then
					if player:removeItem("pink_flower_bouquet", 1) == true then
						nina.complete(player)
						player:dialogSeq({t, name .. "Wow, thanks!"}, 1)
					end
				else
					player:dialogSeq({t, name .. "What are you trying to give me?"}, 1)
				end
			end
		end
	),
	complete = function(player)
		player:calcStat()
		player:sendStatus()
		finishedQuest(player)
		player:msg(4, "[Daily Gift Given]", player.ID)
		player.quest["dailyq_flowergirl"] = 0
		player.registry["dailyq_flowergirl_timer"] = os.time() + 43200

		if player:hasLegend("dailyq_flowergirl") then
			player:removeLegendbyName("dailyq_flowergirl")
		end

		if player.registry["dailyq_flowergirl_complete"] > 0 then
			player.registry["dailyq_flowergirl_complete"] = player.registry["dailyq_flowergirl_complete"] + 1
			player:addLegend(
				"Gave " .. player.registry["dailyq_flowergirl_complete"] .. " bouquets to the Flower Girl",
				"dailyq_flowergirl",
				169,
				16
			)
		else
			player.registry["dailyq_flowergirl_complete"] = 1
			player:addLegend("Gave 1 bouquet to the Flower Girl", "dailyq_flowergirl", 169, 16)
		end

		if player.registry["dailyq_flowergirl_complete"] == 50 then
			broadcast(-1, "[TITLE]: " .. player.name .. " has just earned the title 'Flower Fan'!")
		end
		if player.registry["dailyq_flowergirl_complete"] == 250 then
			broadcast(-1, "[TITLE]: " .. player.name .. " has just earned the title 'Florist'!")
		end
	end,
	nearbyPlayers = function(npc)
		local pc = npc:getObjectsInArea(BL_PC)
		local m, x, y = npc.m, npc.x, npc.y

		if #pc > 0 then
			for i = 1, #pc do
				if pc[i].level >= 5 and pc[i].registry["dailyq_flowergirl_timer"] < os.time() then
					pc[i]:selfAnimationXY(pc[i].ID, 248, x, y)
				end
			end
		end
	end
}
