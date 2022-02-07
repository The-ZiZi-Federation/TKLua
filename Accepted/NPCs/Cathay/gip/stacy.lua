stacy = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local opts = {}
			local sellitems = {251, 394, 404, 405, 415, 418, 6001, 6025, 6050, 6070, 8011, 8041, 8203, 15004} --torn red cape, snail shell frag, shiny necklace, ring of protection, muddy earring, gargoyle horn, basic rune, kumiho gem, bloody enchant rune, eldritch enchant rune, unidentified ring, kulu bracelet, stardrop, mentok armband

			table.insert(opts, "Hello")
			table.insert(opts, "Sell")

			menu = player:menuString(name .. "Welcome, stranger! Come on inside. Oh, you already let yourself in.", opts)

			if menu == "Hello" then
				player:dialogSeq(
					{
						t,
						name .. "Hello.",
						name .. "Sorry, it's a little bare in here.",
						name .. "I'd offer you a seat, but I've just moved in and still don't have any furniture in the place."
					},
					1
				)
			elseif menu == "Sell" then
				player:sellExtend(name .. "What do you wish to sell?", sellitems)
			end
		end
	)
}
