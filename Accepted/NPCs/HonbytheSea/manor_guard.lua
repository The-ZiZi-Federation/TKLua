manor_guard = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			if player.baseClass ~= 2 then
				player:dialogSeq(
					{
						t,
						name .. "The Baron is a busy man. He doesn't have time to deal with the likes of you.",
						name .. "Please leave."
					},
					1
				)
			elseif player.baseClass == 2 and player.quest["leech_lord"] <= 1 then
				player:dialogSeq(
					{
						t,
						name .. "What, you think rookies get to use the front door?",
						name .. "The Baron can't have the likes of you seen going in and out of his manor.",
						name .. "Use the back entrance, through the cave next door."
					},
					1
				)
			elseif player.baseClass == 2 and player.quest["leech_lord"] == 2 then
				player:dialogSeq(
					{
						t,
						name .. "Oh, it's you!",
						name .. "Baron Rodrik is expecting you.",
						name .. "Please, let me escort you inside."
					},
					1
				)
				player:warp(1005, 10, 11)
			end
		end
	)
}
