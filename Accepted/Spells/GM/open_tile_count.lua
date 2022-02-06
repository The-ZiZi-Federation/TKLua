open_tile_count = {

cast = function(player)

	local map = player.m
	local xmax = player.xmax
	local ymax = player.ymax
	local tileCount = 0
	
	for x = 1, xmax do
		for y = 1, ymax do
			local npc = core:getObjectsInCell(map,x,y, BL_NPC)
			if getPass(map,x,y) == 0 then
				if not getWarp(map,x,y) then
					if getObject(map,x,y) == 0 then
						if #npc == 0 then
							tileCount = tileCount + 1
						end
					end
				end
			end
		end
	end
	player:talk(0,"Map "..map..": "..player.mapTitle.." | Number of open tiles: "..tileCount)

end

}