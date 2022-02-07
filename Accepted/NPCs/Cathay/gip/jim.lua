jim = {
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
					name .. "Hic-UUUURP",
					name .. "They want me to quit the liqour?",
					name .. "I AM the liquor, shitbird.",
					name .. "Hic-ZZZZzzzz..."
				},
				1
			)
		end
	)
}
