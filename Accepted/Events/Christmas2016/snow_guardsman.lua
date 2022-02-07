snow_guardsman = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local opts = {}

			local x = math.random(19, 27)
			local y = math.random(18, 25)
			local m

			table.insert(opts, "Who are you?")
			if player.level >= 50 then
				table.insert(opts, "Let me go inside!")
			end
			table.insert(opts, "Leave")

			menu = player:menuString(name .. "Halt! No one enters without my permission.", opts)

			if menu == "Who are you?" then
				player:dialogSeq(
					{
						t,
						name .. "I am the one who has been charged with guarding this place.",
						name .. "At this time of year the monsters inside grow restless, and try to escape.",
						name .. "Normally Santa and the power of Christmas keep them in check with no problem.",
						name .. "But I think something is different this year. The magic seems weaker.",
						name ..
							"I'm getting slow in my old age too, it seems. Some little girl ran right past me before I could stop her.",
						name .. "I sure do hope she's alright..."
					},
					1
				)
			elseif menu == "Let me go inside!" then
				player:dialogSeq(
					{
						t,
						name .. "You want to help fight the monsters?",
						name .. "Well, I guess you seem tough enough. Go on in."
					},
					1
				)
				if player.level >= 50 and player.level <= 69 then
					m = 30001
				elseif player.level >= 70 and player.level <= 89 then
					m = 30011
				elseif player.level >= 90 and player.maxHealth <= 49999 and player.maxMagic <= 49999 then
					m = 30021
				elseif player.level >= 99 and player.maxHealth <= 199999 and player.maxMagic <= 199999 then
					m = 30031
				elseif player.level >= 99 and player.maxHealth >= 200000 or player.maxMagic >= 200000 then
					m = 30041
				end
				player:warp(m, x, y)
			end
		end
	)
}
