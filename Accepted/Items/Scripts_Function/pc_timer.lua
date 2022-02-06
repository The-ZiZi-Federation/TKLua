
pc_timer = {

tick = function(player)
		

--	if player.m == 3999 then player:talk(0,"test: "..player.timerTick) end
--	if player.m == 3999 then player:talk(0,"test2: "..player.timerTick%120) end

	if (player.timerTick%1 == 0) then			-- 1 sec
		pc_timer.halfsecond(player)
	end
	if (player.timerTick%2 == 0) then			-- 1 sec
		pc_timer.second(player)
	end	
	if (player.timerTick%10 == 0) then			-- 1 sec
		pc_timer.fiveSec(player)
	end
	if (player.timerTick%120 == 0) then 	-- 1 minute
		pc_timer.minute(player)
	end
	if (player.timerTick%7200 == 0) then	-- 1 hour
		pc_timer.hour(player)
	end
	

	

end,

tick_fast = function(player)            -- this is still blank when i created.. i know this must be needed by something like this. :D

end,



advice = function(player) if (player.timerTick % 1200 == 0) then player:msg(12, ""..advice[math.random(#advice)], player.ID) end end,

halfsecond = function(player)

	if (player.registry["see_warps"] == 1) then warpGlow(player) end


end,

fiveSec = function(player)

	if player.mapTitle == "Sumo Course" then
		sumo_course.bridgeController(player)
	end
end,


second = function(player)

	local currentSpells = player:getAllDurations()
	
	afkMinigameCheck(player)
	afkDoorBlockCheck(player)
	
	
--	squirt.refill(player)

	if player.health <= 0 then 
		if player.state ~= 1 then
			player.state = 1 
			player:updateState() 
		end
	end

	if player.registry["crit_increased"] == 0 then player.registry["crit_increased"] = 1 end
	if player.fury == 0 then player.fury = 1 end
	
	if player.m == 15040 then
		if player.x >= 2 and player.x <= 30 then
			if player.y >= 6 and player.y <= 34 then
				elixir_war.sideline(player)
			end
		end
	end

	

	might_essence.autoWarp(player)
	grace_essence.autoWarp(player)
	will_essence.autoWarp(player)

	--zombie_war.playerCore(player)
	beach_war.playerCore(player)
	freeze_war.playerCore(player)
	elixir_war.playerCore(player)
	




	local script = {"red_script", "blue_script", "orange_script", "yellow_script", "green_script", "pink_script"}
	for i = 1, #script do
		if player:hasItem(script[i], 1) == true then
			if player.gmLevel < 1 then
				player:removeItem(script[i], 1)
			end
		end
	end
	
	if player.mapTitle == "Sumo Course" then
		sumo_course.guiText(player)
	end



	


--	pc_timer.guitextes(player)
--	snow_ball.pc_timer(player)
end,

minute = function(player)


pc_timer.setClanVariables(player) -- cross-server fix/workaround
	
	
end,



hour = function(player)



end,

checkInven = function(player)

end,


--guitextes = function(player) -- Test Gui Text function, executes once per second


-- First arg can be -1,0, or 1. -1 means send to all players on all maps. 0 = send to players on map when function executes. 1 = Will be for specific players (not working yet).  2nd argument is the MapID. 3rd argument is string


-- This is more proof of concept more than anything useful, calling an elixir_war_score time event with the guitext function below would work for most events.
--guitext(0,1,"\n------------------Sumo Wars------------\nTotal Players: 5\n\n------------Current Scores------------\nRed: 58 || Blue: 56 || White: 45 || Black: 19   \nTop Player: Xephor" )
--guitext(-1,0," ") -- Clear shit


--end,



setClanVariables = function(player)

player.clan = getPlayerClan(player.name)
player.clanTitle = getClanTitle(player.name)
player:updateState()

end,







display_timer = function(player)
--Executes when a display timer finishes.
	--player:talk(2, "Beep beep, beep beep...")
	if (player.registry["botCheck"] == 1) then
		player.registry["botCheck"] = 0
		player.registry["botFlag"] = player.registry["botFlag"] + 1
		if (player.registry["botFlag"] > 5) then
			--player:gmMsg(""..player.name.." should be jailed with "..player.registry["botFlag"].." failed bot checks.")
			--addChatLog(player, ""..player.name.." should be jailed with "..player.registry["botFlag"].." failed bot checks.")
			player:gmMsg(""..player.name.." has been jailed with "..player.registry["botFlag"].." failed bot checks.")
			addChatLog(player, ""..player.name.." has been jailed with "..player.registry["botFlag"].." failed bot checks.")
			---------------------------------
			player.registry["botFlag"] = 0
			player.registry["jailed"] = 1
			target:warp(666, math.random(9, 10), math.random(6, 7))
			broadcast(-1, ""..target.name.." has been jailed for botting!")
			player:sendMinitext("Done!!")
			--justice.jail(player, player)
		else
			player:gmMsg(""..player.name.." failed bot check within time. ("..player.registry["botFlag"]..")")
			addChatLog(player, ""..player.name.." failed bot check within time. ("..player.registry["botFlag"]..")")
		end
	end
end
}
