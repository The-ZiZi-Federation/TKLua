

disguise_potion = {

use = function(player)
	
	player:sendAction(8, 20)
	
	if player.state == 4 then
		player.state = 0
		player:sendMinitext("State : 0")
	else
		player.state = 4
		player:sendMinitext("State : 4")
	end
	player:updateState()
end
}