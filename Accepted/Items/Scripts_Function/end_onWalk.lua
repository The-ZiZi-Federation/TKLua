end_onWalk = function(player)

	local x = player.x
	local y = player.y
	local m = player.m
	local level = player.level
	local obj = getObject(m, x, y)
	local confirm

	serverTransitionWarps(player)
	clanTrialTileChecks(player)
	publicBoards(player)
	spike_trap.step(player)


	if m == 1000 then
		water_sumo.walk(player)
--	elseif m == 68 then
--		farming.walk(player)
		if y == 143 then --rosebush
			if x >= 56 and x <= 62 then 
				rosebush.walk(player)
			end
		end
		if obj == 920 or obj == 921 then --sunflower patch
			sunflower_patch.walk(player)
		end
	elseif m == 2001 then
		draco_block(player)
--	elseif m == 15015 then
--		lode_runner.walk(player)
	elseif m == 50 then
		final_moment.warp(player)
	elseif m == 1035 then
		quiet_temple.block(player)
	end

	if player.m == 2002 or player.m == 1018 or player.m == 2005 then
		--if player.state == 3 then player.state = 0 end

		player.gfxClone = 0
		player:updateState()
	end
	
	if m == 1000 and x == 120 and y == 108 then
		if player.quest["tutorial_serum"] == 1 then
			player:warp(1100, 10, 18)
		else
			pushBack(player)
			player:sendMinitext("A powerful force repels you")
		end
	end
	
	-- Palace Hon warp back
	if (m == 1000) and (x > 20 and x < 24) and (y == 31) then		--- this?
		player:warp(1000, 22, 35)
	end
	
	-- Scoundrel guild
	if (m == 1000) and (x > 112 and x < 115) and (y > 36 and y < 39) then
		player:warp(1000, 113, 42)
	end
	
	if m == 3201 or m == 3202 or m == 3205 then
		crusty_dynamite.walk(player)
	end
	
	if m == 1040 then
		if x >= 7 and x <= 18 then
			if y == 9 then
				player:freeAsync()
				clayven_jr.stableWarp(player, NPC(395))
			end
		end
	end
	
	if m == 4003 then
		if x == 99 and player.level < 50 then
			if (y >= 151 and y <= 154) or (y >= 25 and y <= 28) then --wilderness/grove entrance level block.
				pushBack(player)
				player:popUp("You are still too weak to proceed further.")
				
			end
		end
	end
	
	
	-----------------------CHEREWOOT EVENT-------------
	--if m == 1000 then
	--	if x >= 60 and x <= 110 then
	--		if y >= 120 and y <= 145 then
	--			assassinCheck.check(player)
	--		end
	--	end
	--end
end