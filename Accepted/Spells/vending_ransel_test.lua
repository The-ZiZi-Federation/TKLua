vending_ransel_test = {
	cast = function(player)
		--	player:talk(0,"1")
		player:freeAsync()
		--	clone.gfx(target, NPC(180))
		--	if target.gfxClone == 0 then clone.equip(target, NPC(180)) else clone.gfx(target, NPC(180)) end
		--	player.lastClick = NPC(180).ID
		--player:talk(0,"2")
		vending_menu.click(player, npc)
	end
}
