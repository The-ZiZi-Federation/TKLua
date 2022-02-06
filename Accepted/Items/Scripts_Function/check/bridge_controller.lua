

bridge_controller = {

cast = function(player)


	player:sendAction(6, 20)


	bomber_game.bridge(player, math.random(1, 10))

	
end
}