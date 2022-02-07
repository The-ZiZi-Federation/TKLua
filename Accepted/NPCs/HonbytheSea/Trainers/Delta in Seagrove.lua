-- Seagrove Wizard Delta in Seagrove
seagrove_teleport_to_hon = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local opts = {}
			table.insert(opts, "Take me to Hon please")
			if player.baseClass == 3 then
				table.insert(opts, "Can you teach me magic?")
			end

			menu = player:menuString(name .. "I am Delta, Would you like to go back to Hon by the Sea?", opts)

			if menu == "Take me to Hon please" then
				player:warp(1000, 111, 55)
				player:sendAnimation(254)
			elseif menu == "Can you teach me magic?" then
				player:dialogSeq(
					{
						t,
						name .. "Teach you? No, I am not a teacher.",
						name .. "If you are worthy, then Malcor will teach you the ways of magic.",
						name .. "Just make your way to the higher levels of the tower, behind the trick bookshelf.",
						name .. "It's the one without any books on it. Just face it and press 'o' to open the way."
					},
					1
				)
			end
		end
	)
}
