sewer_chest = {

open = function(player)
	
	local pc = core:getObjectsInMap(1103, BL_PC)
	local m, x , y, side = player.m, player.x, player.y, player.side
	local obj = getObject(1103, 25, 12)	
	
	if m == 1103 then
		if (x == 24 and y == 12) and side == 1 then
			if obj == 13583 then
				setObject(1103, 25, 12, 13584)
				player:addGold(420)
				player:talkSelf(0, "You find 420 coins in the chest!")
				core.gameRegistry["sewer_chest"] = os.time()+600
			elseif obj == 13584 then
				player:talkSelf(0, "There's no treasure left.")
			end
		end
	end
end,

auto = function()

	local player = core:getObjectsInMap(1103, BL_PC)
	if core.gameRegistry["sewer_chest"] > 0 and core.gameRegistry["sewer_chest"] < os.time() then
		setObject(1103, 25, 12, 13583)
		core.gameRegistry["sewer_chest"] = 0
	end
end
}