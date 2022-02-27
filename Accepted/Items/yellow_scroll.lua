yellow_scroll = {

use = function(player)

	local item = player:getInventoryItem(player.invSlot)
	
	if not player:canAction(1, 1, 1) then
		player:sendMinitext("You cannot do that right now!")
	    return 
	end
	
	if player:hasItem(item.yname, 1) == true then
		if player.m >= 60000 then
			player:removeItem(item.yname, 1)
			player:warp(1018, 4, 10)
		else
			player:sendMinitext("That won't work here.")
		end
	end
end}