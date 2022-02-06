serverTransitionWarps = function(player)

	local m, x, y, s = player.m, player.x, player.y, player.side


	if m == 4003 then	--Cathay road - Woods north of Hon
		if x >= 22 and x <= 27 then
			if y == 249 then
				player:warp(2000, (x-11), 1)
			end
	    end
    elseif m == 2000 then	--Woods north of Hon 
    	if x >= 11 and x <= 16 then -- Cathay Road
			if y == 0 then
				if player.level >= 25 then
					player:warp(4003, (x+11), 248)
				else
					pushBack(player)
					player:popUp("You are still too weak to proceed further.")
				end
			end
		elseif x == 145 then --harvest grove
			if y >= 15 and y <= 19 then
				if player.level >= 50 then
					player:warp(4006, 1, (y+5))
				else
					pushBack(player)
					player:popUp("You are still too weak to proceed further.")			
				end
			end
	    end
	elseif m == 4006 then -- harvest grove to woods
		if x == 0 then
			if y >= 20 and y <= 24 then
				player:warp(2000, 144, (y-5))
			end
		end
	
    elseif m == 4012 and player.level >= 90 then       --Melin to Blackstrike Swamp
        if x == 0 then
			if y >= 24 and y <=27 then
				player:warp(2153, 48, (y-15))
			end
		end

   elseif m == 2153 then       --Blackstrike Swamp to Melin
        if x == 49 then
			if y >= 9 and y <=12 then
				player:warp(4012, 1, (y+15))
			end
		end
	end
end
