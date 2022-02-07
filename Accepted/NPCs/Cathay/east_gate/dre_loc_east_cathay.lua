-- Dre loc east cathay
dre_loc_east_cathay = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local opts = {}

			if player.quest["dre_loc_east_cathay"] == 0 then
				--	table.insert(opts, "What story sir?")
				--	table.insert(opts, "Was there food?")
				--	table.insert(opts, "Sounds boring!")
				menu = player:menuString(name .. "That story in the Observatory is spectacular!", opts)
				if (menu == "What story sir?") then
					player:dialogSeq(
						{
							t,
							name .. "As you must know I have travelled all over multiple worlds.",
							name .. "I am no stranger to listening to an old mans lecture.",
							name .. "So I suggest you head over to the Observatory. East of Here.",
							name .. "There is much to learn about the worlds. Just head east when you leave here",
							name .. "Then head up the tower to the top for a great story."
						},
						1
					)
					player:sendAnimation(116)
					player:sendAnimation(117)
					onGetExp2(player, 1000000)
					player.quest["dre_loc_east_cathay"] = 1
				elseif (menu == "Was there food?") then
					player:dialogSeq(
						{
							t,
							name .. "No, there was not food. Now that you mention it, I guess it could have been better.",
							name .. "I will have to recommend such a thing next time I go listen to an old man's story.",
							name .. "The observatory is east of here, head up the tower and enjoy a great story."
						},
						1
					)
					player:sendAnimation(117)
					onGetExp2(player, 500000)
					player.quest["dre_loc_east_cathay"] = 1
				elseif (menu == "Sounds boring!") then
					player:dialogSeq(
						{
							t,
							name .. "Well aren't you just rude. Your family must be so proud.",
							name .. "Listen or don't I don't care. Your choice to miss out on a great story.",
							name .. "The observatory east of here, up at the top of the tower.",
							name .. "While you're at it, you might want to find a personality vendor too. Putz."
						},
						1
					)
					player:sendAnimation(102)
					player.quest["dre_loc_east_cathay"] = 1
				end
			else
				player:dialogSeq({t, name .. "The Observatory is East of here. A story awaits the top of the tower."}, 1)
			end
		end
	)
}
