development_board = {
	check = function(player)
		if player.gmLevel > 50 then
			player.boardWrite = 1
			player.boardDel = 1
		end
	end,
	delete = function(player)
		local user = player:getUsers()

		if player.gmLevel > 50 then
			if #user > 0 then
				for i = 1, #user do
					if user[i].gmLevel > 50 then
						user[i]:msg(4, "[Development Board]  Post deleted by: " .. player.name .. "", user[i].ID)
					end
				end
			end
		end
	end,
	post = function(player)
		local user = player:getUsers()
		local id = core.gameRegistry["dev_board_id"]

		if player.gmLevel > 50 then
			core.gameRegistry["dev_board_id"] = core.gameRegistry["dev_board_id"] + 1
			setPostColor(16, id, 1)
			if #user > 0 then
				for i = 1, #user do
					if user[i].gmLevel > 50 then
						user[i]:msg(4, "[Development Board]  New topic posted by: " .. player.name .. "", user[i].ID)
					end
				end
			end
		end
	end
}
