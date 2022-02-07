cathay_gate_refugee = {
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
					name .. "We came to Cathay because we had no place else to go.",
					name .. "They wouldn't even let us inside the gates, though.",
					name .. "We're camped out here until we can find a new place to call home.",
					name .. "Curse Cathay!"
				},
				1
			)
		end
	)
}
