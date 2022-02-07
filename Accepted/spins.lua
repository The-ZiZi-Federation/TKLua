spinTile = function(player)
	local m, x, y = player.m, player.x, player.y
	local obj = getObject(m, x, y)
	local tile = getTile(m, x, y)

	if obj == 7541 then --left
		player.paralyzed = true
		if player:hasDuration("spin_right") then
			player:setDuration("spin_right", 0)
		end
		if player:hasDuration("spin_down") then
			player:setDuration("spin_down", 0)
		end
		if player:hasDuration("spin_up") then
			player:setDuration("spin_up", 0)
		end
		player:setDuration("spin_left", 100000000)
	elseif obj == 7539 then --right
		player.paralyzed = true
		if player:hasDuration("spin_left") then
			player:setDuration("spin_left", 0)
		end
		if player:hasDuration("spin_down") then
			player:setDuration("spin_down", 0)
		end
		if player:hasDuration("spin_up") then
			player:setDuration("spin_up", 0)
		end
		player:setDuration("spin_right", 100000000)
	elseif obj == 7538 then --up
		player.paralyzed = true
		if player:hasDuration("spin_right") then
			player:setDuration("spin_right", 0)
		end
		if player:hasDuration("spin_down") then
			player:setDuration("spin_down", 0)
		end
		if player:hasDuration("spin_left") then
			player:setDuration("spin_left", 0)
		end
		player:setDuration("spin_up", 100000000)
	elseif obj == 7540 then --down
		player.paralyzed = true
		if player:hasDuration("spin_right") then
			player:setDuration("spin_right", 0)
		end
		if player:hasDuration("spin_up") then
			player:setDuration("spin_up", 0)
		end
		if player:hasDuration("spin_left") then
			player:setDuration("spin_left", 0)
		end
		player:setDuration("spin_down", 100000000)
	elseif obj == 7552 then
		if player:hasDuration("spin_right") then
			player:setDuration("spin_right", 0)
		end
		if player:hasDuration("spin_up") then
			player:setDuration("spin_up", 0)
		end
		if player:hasDuration("spin_left") then
			player:setDuration("spin_left", 0)
		end
		if player:hasDuration("spin_down") then
			player:setDuration("spin_down", 0)
		end
	end
end

spin_left = {
	while_cast_250 = function(player)
		spinClockwise(player)
	end,
	while_cast = function(player)
		local m, x, y = player.m, player.x, player.y

		local obj = getObject(m, x, y)

		player.paralyzed = true
		player:warp(m, x - 1, y)
		spinTile(player)
	end,
	cast = function(player)
		player.paralyzed = true
	end,
	uncast = function(player)
		player.paralyzed = false
	end
}

spin_right = {
	while_cast_250 = function(player)
		spinClockwise(player)
	end,
	while_cast = function(player)
		local obj = getObject(player.m, player.x, player.y)

		local m, x, y = player.m, player.x, player.y

		player.paralyzed = true
		player:warp(m, x + 1, y)
		spinTile(player)
	end,
	uncast = function(player)
		player.paralyzed = false
	end
}

spin_up = {
	while_cast_250 = function(player)
		spinClockwise(player)
	end,
	while_cast = function(player)
		local obj = getObject(player.m, player.x, player.y)

		local m, x, y = player.m, player.x, player.y

		player.paralyzed = true
		player:warp(m, x, y - 1)
		spinTile(player)
	end,
	uncast = function(player)
		player.paralyzed = false
	end
}

spin_down = {
	while_cast_250 = function(player)
		spinClockwise(player)
	end,
	while_cast = function(player)
		local obj = getObject(player.m, player.x, player.y)

		local m, x, y = player.m, player.x, player.y

		player.paralyzed = true
		player:warp(m, x, y + 1)
		spinTile(player)
	end,
	uncast = function(player)
		player.paralyzed = false
	end
}

spinClockwise = function(player)
	if player.side <= 2 then
		player.side = player.side + 1
		player:sendSide()
	else
		player.side = 0
		player:sendSide()
	end
end

spinCounterClockwise = function(player)
	if player.side == 0 then
		player.side = 3
		player:sendSide()
	else
		player.side = player.side - 1
		player:sendSide()
	end
end
