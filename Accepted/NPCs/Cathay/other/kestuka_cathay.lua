kestuka_cathay = {
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

			if player.m == 4000 then
				table.insert(opts, "Enter the Eye")
			end
			if player.m == 4099 then
				table.insert(opts, "Return to Cathay")
			end

			if player.m == 4000 then
				menu = player:menuString(name .. "Are you here to visit the Cathay City Eye?", opts)
			elseif player.m == 4099 then
				menu = player:menuString(name .. "Would you like to return to Cathay?", opts)
			end

			if menu == "Enter the Eye" then
				player:dialogSeq({t, name .. "Alright. I will send you inside."}, 1)
				player:sendAnimationXY(292, player.x, player.y)
				player:warp(4099, 21, 24)
				player:sendAnimation(292)
			elseif menu == "Return to Cathay" then
				player:dialogSeq({t, name .. "Alright. I will send you outide."}, 1)
				player:sendAnimationXY(292, player.x, player.y)
				player:warp(4000, 23, 94)
				player:sendAnimation(292)
			end
		end
	)
}
