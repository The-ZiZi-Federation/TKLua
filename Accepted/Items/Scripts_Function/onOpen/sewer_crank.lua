sewer_crank = {

open = function(player)

	local pc = core:getObjectsInMap(1102, BL_PC)
	local m, x , y, side = player.m, player.x, player.y, player.side
	local obj = getObject(1102, 20, 4)
	
	if ((x == 6 and y == 5 ) or (x == 6 and y == 6) and side == 3) then	
		if obj == 12528 or obj == 12584 then
			if obj == 12528 then
				setObject(1102, 20, 4, 12584)
				setObject(1102, 21, 4, 0)
				setObject(1102, 22, 4, 0)
				setObject(1102, 23, 4, 12583)
				core.gameRegistry["sewer_crank"] = os.time()+180
				player:talkSelf(2, "**loosens crank**")
				
			elseif obj == 12584 then
				setObject(1102, 20, 4, 12528)
				setObject(1102, 21, 4, 12529)
				setObject(1102, 22, 4, 12530)
				setObject(1102, 23, 4, 12528)
				player:talkSelf(2, "**tightens crank**")
				if #pc > 0 then
					for i = 1, #pc do
						sewer_crank.talk(pc[i])
					end
				end
			end
		end
		for i = 1102, 1104 do
			broadcast(i, "You hear the creak of ancient machinery stirring to life.")
		end
	end
end,


auto = function()

	if core.gameRegistry["sewer_crank"] > 0 and core.gameRegistry["sewer_crank"] < os.time() then
		setObject(1102, 20, 4, 12528)
		setObject(1102, 21, 4, 12529)
		setObject(1102, 22, 4, 12530)
		setObject(1102, 23, 4, 12528)	

		core.gameRegistry["sewer_crank"] = 0
		for i = 1102, 1104 do
			broadcast(i, "You hear the grinding of stone against stone.")
		end
	end
end,

talk = function(player)
	
	player:talkSelf(0, "You hear the grinding of stone against stone.")
end
}