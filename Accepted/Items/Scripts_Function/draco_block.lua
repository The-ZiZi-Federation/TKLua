draco_block = function(player)

	local mob = player:getObjectsInMap(player.m, BL_MOB)
	local x = player.x
	local y = player.y
	local m = player.m
	
	if (m == 2001) then
		if (x >= 7 and x <= 8) and (y >= 11 and y <= 12) then
			if (#mob > 0) then
				for i = 1, #mob do
					if mob[i].yname == "draco" then
						player:warp (m, 7, 10)
						player:talkSelf(0, player.name.. ": I can't leave Jules alone with Draco!")
						player:sendMinitext("You must defeat Draco to leave!")
						return
					end
				end
			end
		end
	end	
end