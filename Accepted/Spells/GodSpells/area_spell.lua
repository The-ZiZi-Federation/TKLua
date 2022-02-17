area_spell = {
	cast = function(player)
		local pc = player:getObjectsInArea(BL_ITEM) --
		local map = player:getObjectsInMap(player.m, BL_PC)

		if #pc > 0 then
			for i = 1, #pc do
				player:sendAnimationXY(235, pc[i].x, pc[i].y)
			end
		end

		if #map > 0 then
			for x = 1, #map do
				map[x]:talk(0, "Im here")
			end
		end
	end
}
