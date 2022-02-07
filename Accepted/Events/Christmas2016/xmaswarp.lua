xmasWarp = function(npc)
	local maps = {3015, 3057, 3058, 3103}
	local warpMap = maps[math.random(1, 4)]
	local x, y = 0, 0

	if warpMap == 3015 then
		x = math.random(6, 136)
		y = math.random(19, 145)
	elseif warpMap == 3057 then
		x = math.random(3, 23)
		y = math.random(4, 25)
	elseif warpMap == 3058 then
		x = math.random(2, 53)
		y = math.random(52, 71)
	elseif warpMap == 3103 then
		x = math.random(60, 105)
		y = math.random(95, 139)
	end

	local mob = core:getObjectsInCell(warpMap, x, y, BL_MOB)
	local pc = core:getObjectsInCell(warpMap, x, y, BL_PC)
	local mapnpc = core:getObjectsInCell(warpMap, x, y, BL_NPC)
	local pass = getPass(warpMap, x, y)
	local warptile = getWarp(warpMap, x, y)
	local object = getObject(warpMap, x, y)

	if pass == 0 then
		if not warptile then
			if object == 0 then
				if #mapnpc == 0 then
					if #mob == 0 then
						if #pc == 0 then
							--Player(4):talk(0,"Map: "..warpMap..", x: "..x..", y: "..y)
							npc:sendAnimationXY(610, npc.x, npc.y)
							npc:warp(warpMap, x, y)
							npc:sendAnimationXY(610, npc.x, npc.y)
						else
							return xmasWarp(npc)
						end
					else
						return xmasWarp(npc)
					end
				else
					return xmasWarp(npc)
				end
			else
				return xmasWarp(npc)
			end
		else
			return xmasWarp(npc)
		end
	else
		return xmasWarp(npc)
	end
end
