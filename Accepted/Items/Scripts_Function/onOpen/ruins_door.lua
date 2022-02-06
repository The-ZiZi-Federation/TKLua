

--Ruins of Bettay
ruins_door = {
	
open = function(player)
	
	local pc = core:getObjectsInMap(3000, BL_PC)
	local m, x , y, side = player.m, player.x, player.y, player.side
	local obj = getObject(3000, 49, 102)

	if (x == 49 and y == 103) then
		if obj == 13188 or obj == 13187 then
			if obj == 13188 then
				setObject(3000, 49, 102, 13187)
				core.gameRegistry["ruins_door"] = os.time()+120
				
			elseif obj == 13187 then
				setObject(3000, 49, 102, 13188)
					if #pc > 0 then
					for i = 1, #pc do
						ruins_door.talk(pc[i])
					end
				end
			end
		end
	player:talkSelf(0, "It smells like death down there!")
	end
end,


auto = function()
	
	local player = core:getObjectsInMap(3000, BL_PC)

	if core.gameRegistry["ruins_door"] > 0 and core.gameRegistry["ruins_door"] < os.time() then
		setObject(3000, 49, 102, 13188)
		core.gameRegistry["ruins_door"] = 0
		if #player > 0 then
			for i = 1, #player do
				ruins_door.talk(player[i])
			end
		end
	end
end,

talk = function(player)
	
	player:talkSelf(0, "It smells like death down there!")
end
}