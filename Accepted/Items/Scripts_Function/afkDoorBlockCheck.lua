afkDoorBlockCheck = function(player)

	local isNearWarp
	local m = player.m
	local sound = 200
	local anim = 247
	
	for x = player.x - 2, player.x + 2 do
		for y = player.y - 2, player.y + 2 do
			if getWarp(m, x, y) then
				isNearWarp = 1
			end
		end
	end

	if isNearWarp == 1 then
		if player.afkTime == 2 then
			if player.registry["door_block_warning"] == 0 then
				player:playSound(sound)
				player:sendAnimation(anim)
				player:sendMinitext("You are blocking a path. Please move or you will be moved in 20 seconds.")
				player.registry["door_block_warning"] = 1
			end
			
		elseif player.afkTime == 3 then
			if player.registry["door_block_warning"] == 1 then
				player:playSound(sound)
				player:sendAnimation(anim)
				player:sendMinitext("You are blocking a path. Please move or you will be moved in 10 seconds.")
				player.registry["door_block_warning"] = 2
			end
			
		elseif player.afkTime == 4 then
			if player.registry["door_block_warning"] == 2 then
				player:playSound(29)
				--player:sendAnimation(anim)
				player:sendMinitext("You were too close to a warp and have been moved to the Inn.")
				player:sendAnimation(292)
				player:sendAnimationXY(292, player.x, player.y)
				player:warp(1018, 10, 4)
				player.registry["door_block_warning"] = 0
			end
		
		elseif player.afkTime == 0 then
			player.registry["door_block_warning"] = 0
		end
	end
end