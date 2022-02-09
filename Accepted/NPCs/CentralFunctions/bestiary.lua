bestiary = {
	click = function(player, npc)
		monsterId = player:inputNumberCheck(player:input("What Monster Graphic would you like to see?"))
		if (monsterId >= 0) then
			local t = {graphic = convertGraphic(monster_id, "monster"), color = 0}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 2
			local opts = {"Next >>", "Options", "<< Previous"}
			menu = player:menuSeq("Make your choice", opts, {})
		end
	end
}
