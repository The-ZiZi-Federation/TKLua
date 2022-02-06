

dmSpawn = {
    
cast = function(player)	
	
	dmSpawn.click(player, npc)

end,


click = async(function(player, npc)


	local map = player.m
	local xmin = player.x - 5
	local xmax = player.x + 5
	local ymin = player.y - 5
	local ymax = player.y + 5
	
	mobid = tonumber(player:input("What Mob ID?"))
	number = tonumber(player:input("How many?"))
	
	dmSpawn.spawn(player, map, xmin, xmax, ymin, ymax, mobid, number)

end),


spawn = function(player, map, xmin, xmax, ymin, ymax, mobid, number)

	local allMobs
	local targetMobs = {}
    

--Player(4):talk(0,"RESPAWN: "..number)

	for i = 1, number do

		x = math.random(xmin, xmax)
		y = math.random(ymin, ymax)

		if x >= player.xmax then
			x = player.xmax - 1
		end

		if y >= player.ymax then
			y = player.ymax - 1
		end
		
		local mob = core:getObjectsInCell(map,x,y, BL_MOB)
		local pc = core:getObjectsInCell(map,x,y, BL_PC)
		if getPass(map,x,y) == 0 then
			if not getWarp(map,x,y) then
				if getObject(map,x,y) == 0 then
					if #mob == 0 then
						if #pc == 0 then
							core:spawn(mobid, x, y, 1, map)
						end
					end
				end
			end
		end
	end

	allMobs = core:getObjectsInMap(map, BL_MOB)	

	if #allMobs > 0 then
		for i = 1, #allMobs do
			if allMobs[i].mobID == mobid then
				table.insert(targetMobs, allMobs[i].mobID)
		
			end
		end
	end

	if #targetMobs < number then
--Player(4):talk(0,"RESPAWN: MIN")

		return dmSpawn.spawn(player, map, xmin, xmax, ymin, ymax, mobid, (number - #targetMobs), number)
	end
end

}