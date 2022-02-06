publicBoards = function(player)

	local m, x, y = player.m, player.x, player.y
	
	if m == 1000 then
		if (x >= 6 and x <= 7) then
			if y == 95 then
				if player.side == 0 then
					player:showBoard(201)
				end
			end
		elseif (x >= 119 and x <= 120) then
			if y == 59 then
				if player.side == 0 then
					player:showBoard(33)
				end
			end
		elseif (x >= 33 and x <= 34) then
			if y == 40 then
				if player.side == 0 then
					player:showBoard(37)
				end
			end
		end
	elseif m == 1004 then
		if (x >= 23 and x <= 24) then
			if y == 4 then
				if player.side == 0 then
					player:showBoard(25)
				end
			end
		end
	elseif m == 1007 then
		if (x >= 11 and x <= 12) then
			if y == 4 then
				if player.side == 0 then
					player:showBoard(29)
				end
			end
		end
	end
end