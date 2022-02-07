alpha_rewards_register = {
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
					name .. "Hello, my name is Die.",
					name .. "Come check out the 1 Year Anniversary Launch April 11th!"
				},
				1
			)
		end
	)
}
