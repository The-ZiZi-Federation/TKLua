tonguspur_carpenter = {
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

			if player.quest["tonguspur_letter"] == 1 then
				table.insert(opts, "I have a letter for you from Hon.")
			end
			if player.quest["fighter_favor"] == 1 and player.quest["pickup_carpentry_materials"] == 0 then
				table.insert(opts, "Pick up materials")
			end

			menu = player:menuString(name .. "Hey there, how can I be of assistance?", opts)

			if menu == "What is this place?" then
				player:dialogSeq({t, name .. "This is Tonguspur. We are a small village north of Hon by the Sea."}, 1)
			elseif menu == "I have a letter for you from Hon." then
				if player:hasItem("tonguspur_letter", 1) == true then
					player:dialogSeq(
						{
							t,
							name .. "Oh. Thanks for the delivery, but I'm sure it's just more bad news.",
							name .. "Here, take something for your trouble.",
							name .. "Can you tell the carriers to deliver something good sometime!"
						},
						1
					)
					player:removeItem("tonguspur_letter", 1)
					giveXP(player, 25000)
					player:addGold(2500)
					finishedQuest(player)
					player:calcStat()
					player:sendStatus()
					player.quest["tonguspur_letter"] = 2
					player:msg(4, "[Quest Complete] You got a nice reward!", player.ID)
				else
					player:dialogSeq({t, name .. "I don't see a letter. What are you trying to pull?"}, 1)
				end
			elseif menu == "Pick up materials" then
				player.quest["pickup_carpentry_materials"] = 1
				player:addItem("carpentry_materials", 1)
				player:dialogSeq(
					{t, name .. "These are the materials bound for Cathay. I promised quick delivery, so hurry it up."},
					1
				)
			end
		end
	)
}
