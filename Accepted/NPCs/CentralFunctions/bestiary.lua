bestiary = {
	click = function(player, npc)
		monster_id = player:input("What Monster Graphic would you like to see?")
		if (tonumber(monster_id, 10) >= 0) then
			local t = {graphic = convertGraphic(toNumber(monster_id,10), "monster"), color = 0}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
		else
			npc:talk(1, "Get the fuck out of here you piece of shit. Thats not a number")
		end
	end
}
