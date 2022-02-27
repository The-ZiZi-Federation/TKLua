randomChestnuts = {

spawn = function()
	local chance = math.random(100)
	local map = 1000
	local x = math.random(80, 107)
	local y = math.random(53, 75)
	local item = core:getObjectsInCell(map, x, y, BL_ITEM)
	
	if getPass(map,x,y) == 0 then
		if not getWarp(map,x,y) then
			if getObject(map,x,y) == 0 then
				
				if #item == 0 then
					if chance <= 50 then
						--Player(4):talkSelf(0,"SUCCESS! Chestnut spawned at X: "..x.." Y: "..y)
						core:dropItemXY(54, 1, map, x, y)
					else
						--Player(4):talkSelf(0,"chance roll fail")
					end
				else
					--Player(4):talkSelf(0,"#item not == 0")
				end
			else
				--Player(4):talkSelf(0,"obj in the way")
			end
		else
			--Player(4):talkSelf(0,"warp in the way")
		end
	else
		--Player(4):talkSelf(0,"not pass")
	end

end
}