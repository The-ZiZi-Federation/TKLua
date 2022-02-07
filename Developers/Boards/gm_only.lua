gm_only = {
	check = function(player)
		local user = player:getUsers()

		if player.gmLevel > 0 then
			player.boardWrite = 1
			player.boardDel = 1
		end
	end
}

team_morna_meeting = {
	check = function(player)
		if player.gmLevel > 0 then
			player.boardWrite = 1
			player.boardDel = 1
		end

		if player.registry["team_morna"] > 0 then
			player.boardWrite = 1
			player.boardDel = 0
		end
	end
}

team_morna_dev = {
	check = function(player)
		if player.gmLevel > 0 then
			player.boardWrite = 1
			player.boardDel = 1
		end

		if player.registry["team_morna"] > 0 then
			player.boardWrite = 1
			player.boardDel = 0
		end
	end
}
