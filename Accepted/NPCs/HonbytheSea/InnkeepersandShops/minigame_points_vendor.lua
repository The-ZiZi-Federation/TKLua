minigame_points_vendor = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			--1011, 1012, 1013,
			local items = {8203, 301523, 1014, 1015, 1016, 1017, 301520, 301521, 301522}

			local options = {}
			table.insert(options, "Buy")
			table.insert(options, "Check my Points")

			--if player.level == 99 then table.insert(items, 1010) end

			menu = player:menuString(name .. "Hi! I run the Points Shop. I sell things for Minigame Points.", options)

			if menu == "Buy" then
				player:buyMinigamePoints("Buy what?", items)
			elseif menu == "Check my Points" then
				player:dialogSeq(
					{t, name .. "You currently have: " .. player.registry["minigame_points"] .. " Minigame Points available."},
					1
				)
			--	elseif menu == "" then
			--		player:dialogSeq({t, name..""}, 1)
			end
		end
	)
}
