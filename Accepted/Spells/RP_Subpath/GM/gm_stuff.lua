gm_stuff = {
	cast = function(player, target, npc) --
		--[[	
	clone.gfx(target, NPC(180))
	if target.gfxClone == 0 then clone.equip(target, NPC(180)) else clone.gfx(target, NPC(180)) end
	player.lastClick = NPC(180).ID
	player:freeAsync()
	click.menu(player, target, npc)
]]
	end
}
