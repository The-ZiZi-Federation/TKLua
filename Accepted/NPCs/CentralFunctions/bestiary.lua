bestiary = {
	click = async(
		function(player, npc)
			monsterId = player:inputNumberCheck(player:input("What Monster Graphic would you like to see?"))
			if (monsterId >= 0) then
				local t = {graphic = convertGraphic(monsterId, "monster"), color = 0}
				player.npcGraphic = t.graphic
				player.npcColor = t.color
				player.dialogType = 2
				player.registry["beastiary"] = monsterId
				beastiary.browse_monster(player,npc)
			end
		end),
    browse_monster = function(player, npc)
		local name = "<b>[" .. npc.name .. "]\n\n"
		graphic = player.registry["beastiary"]
		local t = {graphic = convertGraphic(graphic, "monster"), color = npc.lookColor}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		local stop = 0
		local opts = {}
		table.insert(opts, "Next ->>")
		table.insert(opts, "<<- Previous")

		player:menuString(name .. "\nThat was Monster #" .. graphic .. ", you like that shit?", opts)
		if menu == "Next ->>" then
			player.registry["beastiary"] = player.registry["beastiary"] + 1
		elseif menu == "<<- Previous" then
			player.registry["beastiary"] = player.registry["beastiary"] - 1
		end
	end
}