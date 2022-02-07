clanGroupCheck = function(player)
	local count = 0
	local groupedPlayer

	-- Group check to see if player has the *right* group members, or those they originally grouped with.------

	if #player.group ~= 4 then -- this checks to make sure your group contains 4 people, including yourself
		return false
	end

	for i = 1, #player.group do -- this check's the group leader (future primogen's) registries and compares current group members against that. only by having the original group members will this check return true.
		groupedPlayer = Player(player.group[i])

		for j = 1, #player.group do
			if (groupedPlayer.ID == player.registry["clan_create_member_" .. j]) then
				count = count + 1
				break
			end
		end
	end

	if count == 4 then
		return true
	else
		return false
	end
end

clanGroupCheckWarp = function(player, destMap, destX, destY)
	local groupCheck = clanGroupCheck(player)
	local count = 0

	if groupCheck == true then -- checks to make sure leader is with original group members
		for i = 1, #player.group do
			groupedPlayer = Player(player.group[i])

			if groupedPlayer.m == player.m then -- checks to make sure all group members are on same map
				count = count + 1
			end
		end

		if count == 4 then -- this means all 4 original group members are present on the map
			for i = 1, #player.group do
				Player(player.group[i]):warp(destMap, destX, destY)
			end
		end
	end
end
