clanTrialTileChecks = function(player)
	local m, x, y, s = player.m, player.x, player.y, player.side

	if m == 4007 then --Melin Grove
		if x == 59 then
			if y == 4 or y == 5 then
				clanGroupCheckWarp(player, 1, 5, 5) -- this function used to check clan member's group (for original members) and also make sure all on same map. if true warps.
			end
		end
	end
end
