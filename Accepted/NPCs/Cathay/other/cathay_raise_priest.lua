cathay_raise_priest = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local anything = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = anything.graphic
			player.npcColor = anything.color
			player.dialogType = 0
			local options = {}

			table.insert(options, "Can you resurrect me?")

			menu = player:menuString(name .. "May the All Seeing All Knowing GOD, Bless You.", options)

			if menu == "Can you resurrect me?" then
				if (player.state == 1) then
					player.speed = 80
					player.state = 0
					player:updateState()
					player:sendAnimation(96)
					player:playSound(112)
					npc:talk(0, "" .. npc.name .. ": We shall meet again, " .. player.name .. ".")
					player:addHealth2(10000000)
					player:addMagic(1000000)
					player.registry["lastrez"] = os.time()
				else
					player:dialogSeq({anything, name .. "I can't resurrect you until you die."}, 1)
				end
			end
		end
	)
}
