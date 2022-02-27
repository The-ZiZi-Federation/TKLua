onSwing = function(player)
	
	local sound = 0
	local weap = player:getEquippedItem(EQ_WEAP)
	local pc, mob = getTargetFacing(player, BL_PC), getTargetFacing(player, BL_MOB)
	local playerX, playerY = player.x, player.y
	
	if mob ~= nil then
		if mob.owner == player.ID then
			player:warp(mob.m, mob.x, mob.y)
			mob:warp(player.m, playerX, playerY)
			player:sendAction(1, 20)
		end
	end
	if player.m == 15010 then
		if player.registry["freeze_war_team"] > 0 then
			freeze_war.onSwing(player)
		end
		return 
		
	elseif player.m == 15020 then 
		if player.registry["beach_war_team"] > 0 and player.gfxWeap == 20109 then
			beach_war.shoot(player)
		end
		return 
	elseif player.m == 15030 then 
		if player.registry["sumo_war_team"] > 0 and player.gfxWeap == 65535 then
			sumo_war.push(player)
		end
		return 
	elseif player.m == 15031 then
		sumo_war.push(player)
		return 
	elseif player.m == 15040 then
		if player.registry["elixir_war_team"] > 0 and player.gfxWeap == 20014 then
			elixir_war.shoot(player)
		end
		return 
	elseif player.m == 15050 then
		bomber_war.bomb(player)
	elseif player.m == 15060 or player.m == 15062 then
		zombie_war.shoot(player)

	elseif player.m >= 60000 then
		if player.mapTitle == "Sumo Course" then
			water_sumo.push(player)
			return
		end

--	elseif player.m == 50004 then return else
--		if player.registry["pick_snow"] == 0 then
--			if weap == nil then sound = 710 else sound = weap.sound end
--			if player.m ~= 15010 then player:playSound(sound) end
--		end
--		player:sendAction(1, 20)
		return 
	end
	
	christmas.throwing(player)
	end_onSwing(player)
	
--	throwIcon(player)
	wind_walk.swing(player)
	decoy.swing(player)
end