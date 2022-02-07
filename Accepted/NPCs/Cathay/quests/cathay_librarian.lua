cathay_librarian = {
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
					name .. "Welcome to the Library of Cathay!",
					name .. "There are many tomes of knowledge here, great and small.",
					name .. "Please, have a look around."
				},
				1
			)
		end
	)
}
