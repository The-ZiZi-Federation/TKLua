
creation = {

success = function(player)
	
	player:playSound(123)
	player:sendMinitext("You were successful!")
end,

failedRecover = function(player)
	
	player:sendAnimation(246)
	player:playSound(124)
	player:sendMinitext("You were failed, but there're some items recovered!")
end,


failed = function(player)
	
	player:sendAnimation(246)
	player:playSound(124)
	player:sendMinitext("You were failed!")
end
}