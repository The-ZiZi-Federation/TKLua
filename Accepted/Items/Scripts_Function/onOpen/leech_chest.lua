--Shores of Hon Leech Cave Chest
leech_chest = {

open = function(player)
	
	local pc = core:getObjectsInMap(1003, BL_PC)
	local m, x , y, side = player.m, player.x, player.y, player.side
	local obj = getObject(1003, 127, 64)	
	
	if m == 1003 then
		if (x == 127 and y == 65) and side == 0 then
			if obj == 13583 and player.quest["leech_chest"] == 0 and player.quest["leech"] == 1 then
				core.gameRegistry["leech_chest"] = os.time()+5
				setObject(1003, 127, 64, 13584)
				player:addGold(62416)
				player:addItem(3302, 1)
				player:addItem(3312, 1)
				player.quest["leech_chest"] = 1
				player.quest["leech"] = 2
				player:msg(4, "[Quest Updated] Return to the Hermit", player.ID)
			elseif obj == 13584 and player.quest["leech_chest"] == 0 then
				setObject(1003, 127, 64, 13583)			
			elseif obj == 13584 and player.quest["leech_chest"] == 1 then
				setObject(1003, 127, 64, 13583)
				player:talkSelf(0, "I have taken what was once here.")
			elseif obj == 13583 and player.quest["leech_chest"] == 1 then
				player:talkSelf(0, "I have taken what was once here.")
			end
		end
	end
end,


auto = function()
	
	local player = core:getObjectsInMap(1003, BL_PC)
	
	if core.gameRegistry["leech_chest"] > 0 and core.gameRegistry["leech_chest"] < os.time() then
		
		if #player > 0 then
			player[1]:sendAnimationXY(285, 127, 64)
		end
		
		setObject(1003, 127, 64, 13583)
		core.gameRegistry["leech_chest"] = 0
	end
end
}