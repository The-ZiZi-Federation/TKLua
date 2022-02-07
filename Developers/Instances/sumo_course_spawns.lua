sumo_course_spawns = {
	room1 = function(player)
		--Room 1
		if (player.registry["sumoCourseSpawned"] ~= 0 or #player:getObjectsInSameMap(BL_MOB) > 0) then
			return
		end

		local sumoScrub = 15001
		local sumoVet = 15002
		local sumoChamp = 15003

		player:spawn(sumoScrub, 61, 11, 1, player.m)
		player:spawn(sumoScrub, 61, 19, 1, player.m)
		player:spawn(sumoScrub, 61, 27, 1, player.m)
		player:spawn(sumoScrub, 61, 32, 1, player.m)
		player:spawn(sumoScrub, 61, 37, 1, player.m)
		player:spawn(sumoScrub, 68, 10, 1, player.m)
		player:spawn(sumoScrub, 68, 16, 1, player.m)
		player:spawn(sumoVet, 68, 21, 1, player.m)
		player:spawn(sumoScrub, 68, 26, 1, player.m)
		player:spawn(sumoScrub, 68, 31, 1, player.m)
		player:spawn(sumoScrub, 68, 37, 1, player.m)
		player:spawn(sumoScrub, 81, 10, 1, player.m)
		player:spawn(sumoVet, 81, 16, 1, player.m)
		player:spawn(sumoScrub, 81, 21, 1, player.m)
		player:spawn(sumoScrub, 81, 26, 1, player.m)
		player:spawn(sumoVet, 81, 31, 1, player.m)
		player:spawn(sumoScrub, 81, 37, 1, player.m)
		player:spawn(sumoChamp, 88, 11, 1, player.m)
		player:spawn(sumoVet, 88, 19, 1, player.m)
		player:spawn(sumoChamp, 88, 27, 1, player.m)
		player:spawn(sumoVet, 88, 32, 1, player.m)
		player:spawn(sumoChamp, 88, 37, 1, player.m)
	end
}
