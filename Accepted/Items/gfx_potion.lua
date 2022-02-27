
gfx_potion = {

use = function(player)
	
	player:sendAction(8, 20)
	
	if player.gfxClone == 1 then
		player.gfxClone = 0
		player:updateState()
		player:sendMinitext("GFX : off")
	return else
		gfxClone(player, player)
		player.gfxClone = 1
		player:updateState()
		player:sendMinitext("GFX : on")
	end
end
}
