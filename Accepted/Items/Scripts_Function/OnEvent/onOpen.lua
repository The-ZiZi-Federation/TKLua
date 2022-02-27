onOpen = function(player)

	local m, x, y, s = player.m, player.x, player.y, player.side
	local obj
	
	end_open(player)
	oKeyPickupsServer0.take(player)	
	--oKeyPickupsServer1.take(player)	

	if s == 0 then
		obj = getObject(m,x,y-1)
	elseif s == 1 then
		obj = getObject(m,x+1,y)
	elseif s == 2 then
		obj = getObject(m,x,y+1)
	elseif s == 3 then
		obj = getObject(m,x-1,y)
	end
end                 

doorOpen = function(player)
		
	player:playSound(404)
	player:sendMinitext("Doors opened!")
end

doorClose = function(player)

	player:playSound(405)
	player:sendMinitext("Doors closed!")
end