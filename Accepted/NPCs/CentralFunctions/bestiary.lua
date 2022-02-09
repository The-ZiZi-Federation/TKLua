bestiary = {
	click = async(
		function(player, npc)
			monsterId = math.abs(tonumber(math.floor(player:input("What Monster Graphic would you like to see?"))))
			if (monsterId >= 0) then
				local t = {graphic = convertGraphic(monsterId, "monster"), color = 0}
				player.npcGraphic = t.graphic
				player.npcColor = t.color
				player.dialogType = 0
				npc.look = monsterId
				player.registry["beastiary"] = monsterId
				player:sendMinitext("Set monster# " .. monsterId)
				beastiary.browse_monster(player,npc)
			end
		end),
    browse_monster = function(player, npc)
		graphic = player.registry["beastiary"]
		player:sendMinitext("Made it to browse ".. graphic)
		local t = {graphic = convertGraphic(graphic, "monster"), color = npc.lookColor}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		local stop = 0
		local opts = {}
		player:sendMinitext("Made it to opts")
		table.insert(opts, "Next ->>")
		table.insert(opts, "<<- Previous")

		menu = player:menuSeq("\nThat was Monster #" .. graphic .. ", you like that shit?", opts)
		if menu == "Next ->>" then
			player.registry["beastiary"] = player.registry["beastiary"] + 1
			return beastiary.browse_monster(player,npc)
		elseif menu == "<<- Previous" then
			player.registry["beastiary"] = player.registry["beastiary"] - 1
			return beastiary.browse_monster(player,npc)
		end
	end
}