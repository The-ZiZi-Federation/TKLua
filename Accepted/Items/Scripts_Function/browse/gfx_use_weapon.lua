

gfx_use_weapon = {

use = function(player)

	local item = player:getInventoryItem(player.invSlot)
	
	player.gfxWeap = item.look
	player:updateState()
end
}