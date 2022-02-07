strength_trial_spawns = {
	room1 = function(player)
		local monster = 0

		if player.baseClass == 1 or player.baseClass == 4 then
			monster = 501
		elseif player.baseClass == 2 then
			monster = 502
		elseif player.baseClass == 3 then
			monster = 503
		end

		if (player.registry["strengthTrialSpawned"] == 0 and #player:getObjectsInSameMap(BL_MOB) == 0 and player.y > 10) then
			player:spawn(monster, 9, 5, 1, player.m)
		end
	end
}
