necromon = {

pickup = function(player)

	local obj = getObjFacing(player, player.side)
	local barrel = 7891
	
	local m, x, y = player.m, player.x, player.y
	local crateNumber = player.registry["necromon_crate"]
	
	if obj == barrel then
		if crateNumber == 1 then
			if (m == 2129 and (x >= 22 and x <= 24) and (y >= 14 and y <= 16)) then
				player:addItem("necromon_vol3", 1)
				player.quest["lost_something"] = 2
				player:sendMinitext("You find a strange book inside the barrel!")
			else
				player:sendMinitext("It's an empty barrel.")
			end	
		elseif crateNumber == 2 then
			if (m == 2130 and (x >= 10 and x <= 12) and (y >= 3 and y <= 4)) then
				player:addItem("necromon_vol3", 1)
				player.quest["lost_something"] = 2
				player:sendMinitext("You find a strange book inside the barrel!")
			else
				player:sendMinitext("It's an empty barrel.")
			end	
		
		elseif crateNumber == 3 then
			if (m == 2128 and (x >= 14 and x <= 16) and (y >= 10 and y <= 12)) then
				player:addItem("necromon_vol3", 1)
				player.quest["lost_something"] = 2
				player:sendMinitext("You find a strange book inside the barrel!")
			else
				player:sendMinitext("It's an empty barrel.")
			end	
		
		elseif crateNumber == 4 then
			if (m == 2127 and (x >= 6 and x <= 8) and (y >= 15 and y <= 16)) then
				player:addItem("necromon_vol3", 1)
				player.quest["lost_something"] = 2
				player:sendMinitext("You find a strange book inside the barrel!")
			else
				player:sendMinitext("It's an empty barrel.")
			end	
		
		elseif crateNumber == 5 then
			if (m == 2126 and (x >= 22 and x <= 23) and (y >= 16 and y <= 17)) then
				player:addItem("necromon_vol3", 1)
				player.quest["lost_something"] = 2
				player:sendMinitext("You find a strange book inside the barrel!")
			else
				player:sendMinitext("It's an empty barrel.")
			end	
		end
	end
end
}