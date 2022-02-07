beach_war_molly = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			player:dialogSeq(
				{
					t,
					name .. "Congratulations on winning the Beach War!",
					name .. "Enjoy your prize, I hope to see you again soon!"
				},
				1
			)
			player:leveledEXP("win_minigame")
			beach_war.victoryLegend(player)
			player:warp(1031, math.random(13, 17), math.random(4, 7))
			player:sendAnimation(16)
			player:playSound(29)
		end
	)
}

freeze_war_molly = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			player:dialogSeq(
				{
					t,
					name .. "Congratulations on winning the Freeze War!",
					name .. "Enjoy your prize, I hope to see you again soon!"
				},
				1
			)
			player:leveledEXP("win_minigame")
			freeze_war.victoryLegend(player)
			player:warp(1031, math.random(13, 17), math.random(4, 7))
			player:sendAnimation(16)
			player:playSound(29)
		end
	)
}

elixir_war_molly = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			player:dialogSeq(
				{
					t,
					name .. "Congratulations on winning the Elixir War!",
					name .. "Enjoy your prize, I hope to see you again soon!"
				},
				1
			)
			player:leveledEXP("win_minigame")
			elixir_war.victoryLegend(player)
			player:warp(1031, math.random(13, 17), math.random(4, 7))
			player:sendAnimation(16)
			player:playSound(29)
		end
	)
}
