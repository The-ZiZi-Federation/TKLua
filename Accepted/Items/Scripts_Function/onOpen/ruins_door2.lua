

--Ruins of Bettay
ruins_door2 = {
	
open = function(player)
	
	local pc = core:getObjectsInMap(3000, BL_PC)
	local m, x , y, side = player.m, player.x, player.y, player.side
	local obj = getObject(3000, 39, 104)

	if (x == 39 and y == 105)  then
		if obj == 13188 or obj == 13187 then
			if obj == 13188 then
				setObject(3000, 39, 104, 13187)
				core.gameRegistry["ruins_door2"] = os.time()+120
				
			elseif obj == 13187 then
				setObject(3000, 39, 104, 13188)
					if #pc > 0 then
					for i = 1, #pc do
						ruins_door2.talk(pc[i])
					end
				end
			end
		end
	player:talkSelf(0, "It smells like death down there!")
	end
end,


auto = function()
	
	local player = core:getObjectsInMap(3000, BL_PC)

	if core.gameRegistry["ruins_door2"] > 0 and core.gameRegistry["ruins_door2"] < os.time() then
		setObject(3000, 39, 104, 13188)
		core.gameRegistry["ruins_door2"] = 0
		if #player > 0 then
			for i = 1, #player do
				ruins_door2.talk(player[i])
			end
		end
	end
end,

talk = function(player)
	
	player:talkSelf(0, "It smells like death down there!")
end
}