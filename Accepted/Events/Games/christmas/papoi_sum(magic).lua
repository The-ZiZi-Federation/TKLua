papoi_sum = {
	cast = function(player)
		local papoi = {}
		local mob = player:getObjectsInMap(player.m, BL_MOB)

		if #mob > 0 then
			for i = 1, #mob do
				if mob[i].mobID == 2000010 then
					mob[i]:warp(player.m, player.x, player.y)
				end
			end
		end
	end
}
