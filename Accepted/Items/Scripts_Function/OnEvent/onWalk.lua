onWalk = function(player)

	local m, x, y, s = player.m, player.x, player.y, player.side
	local tile = getTile(m, x, y)

	local pc = player:getObjectsInCell(m, x, y, BL_PC)
	
	if #pc > 1 then
		if player.optFlags ~= 128 and pc[i].optFlags ~= 128 then
			pushBack(player)
			return
		end
	end	

	caveBlockerLeveled.walk(player)
--	spinTile(player)
	if player.registry["door_blocker"] > 0 then player.registry["door_blocker"] = 0 player.registry["door_blocker_warning"] = 0 end

	end_onWalk(player)
	dimension_door.walk(player)
	if player.m == 15010 then
		freeze_war.walk(player)
	elseif player.m == 15040 then
		elixir_war.walk(player)
	elseif player.m == 15050 then
		bomber_war.pickups(player)
	end
	if player.mapTitle == "Sumo Course" then
		sumo_course.finishLine(player)
	end	
	if player:hasDuration("decoy") then
		decoy.walk(player)
	end
		
	wind_walk.walk(player)	
	sumo.walk(player)


end
	