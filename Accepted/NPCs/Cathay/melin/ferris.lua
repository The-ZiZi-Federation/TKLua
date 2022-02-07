ferris = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local opts = {}

			player:dialogSeq(
				{
					t,
					name .. "Are you on you on your way to Cathay, or just going to the Observatory?",
					name .. "You look brave, anyway.",
					name ..
						"Brave men and women who have found a piece of the fallen stars in their travels sometimes go to the observatory to offer it as a blessing.",
					name .. "Some say it brings good luck to make such an offering, but I say it's all superstition."
				},
				1
			)
		end
	)
}
