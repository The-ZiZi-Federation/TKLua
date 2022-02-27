
next_dis = {

cast = function(player)

	local state = player.state
	
	if player.disguise >= 1508 then
		player:sendMinitext("You may not go over 1508 on disguise.")
	return else
		player.state = 0
		player:updateState()
		if player.disguise >= 1341 or player.disguise >= 1393 then
			player.disguise = player.disguise + 2
		else
			player.disguise = player.disguise + 1
		end
		player.state = state
		player:updateState()
		player:sendMinitext("Disguise #: "..player.disguise)
	end
end
}

prev_dis = {

cast = function(player)

	local state = player.state
	
	if player.disguise <= 0 then
		player:sendMinitext("You may not have negatife disguise.")
	return else
		player.state = 0
		player:updateState()
		if player.disguise <= 1343 or player.disguise <= 1395 then
			player.disguise = player.disguise - 2
		else
			player.disguise = player.disguise - 1
		end
		player.state = state
		player:updateState()
		player:sendMinitext("Disguise #: "..player.disguise)	
	end
end
}