cathay_palace_guard2 = {
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

			if player.class >= 5 then
				if player.registry["learned_gateway2"] == 0 then
					player:dialogSeq(
						{
							t,
							name .. "Sorry, I can't let you in.",
							name .. "The Administrator is busy right now, what do you want?",
							name .. "Oh, you're just having trouble getting around?",
							name .. "I'll teach you where the Cathay city gates are."
						},
						1
					)
					player:removeSpell("gateway")
					player:addSpell("gateway2")
				else
					player:dialogSeq(
						{
							t,
							name .. "Sorry, I can't let you in.",
							name .. "The Administrator is still very busy.",
							name .. "Maybe some other time."
						},
						1
					)
				end
			else
				player:dialogSeq(
					{
						t,
						name .. "I don't like your face.",
						name .. "Leave me alone, seriously.",
						name .. "And don't come back."
					},
					1
				)
			end
		end
	)
}
