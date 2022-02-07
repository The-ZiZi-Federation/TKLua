isaac_hon = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local opts = {}

			table.insert(opts, "What is this place?")
			if player.registry["hon_city_eye"] == 0 then
				table.insert(opts, "How can I use this eye?")
			end
			if player.registry["hon_city_eye"] == 1 then
				table.insert(opts, "See you around!")
			end

			menu = player:menuString(name .. "Well look who we have here!", opts)

			if menu == "What is this place?" then
				player:dialogSeq(
					{
						t,
						name .. "This is an Eye of Teleportation. You will find them all over the world.",
						name .. "If you have unlocked your mind to know a destination then you can travel there from here.",
						name .. "If you go stand on the Eye itself and say out loud where you wish to go...",
						name .. "And you have that mental image clear enough to travel...",
						name .. "Then it will take you to where you desire.",
						name .. "But if you don't know where you are going. You will just look like a fool."
					},
					1
				)
			elseif menu == "How can I use this eye?" then
				player:dialogSeq(
					{
						t,
						name .. "First you must hold your hands together, Pray with me.",
						name .. "In the name of the All Seeing All Knowing God!",
						name .. "Grant me the power to Use the Eye of Teleportation!"
					},
					1
				)
				player:sendAnimation(194)
				player.registry["hon_city_eye"] = 1
				player:addLegend("Found the Eye of Teleportation for Hon by the Sea " .. curT(), "hon_eye_open", 202, 202)
				player:msg(4, "[Unlocked Hon City Eye of Teleportation]", player.ID)
			elseif menu == "See you around!" then
				player:dialogSeq({t, name .. "If you live long enough!"}, 1)
			end
		end
	)
}

hon_eye_fix = function(player)
	if player:hasLegend("hon_eye_open") == true then
		player:removeLegendbyName("hon_eye_open")
		player:addLegend("Found the Eye of Teleportation for Hon by the Sea " .. curT(), "hon_eye_open", 202, 202)
	end
end
