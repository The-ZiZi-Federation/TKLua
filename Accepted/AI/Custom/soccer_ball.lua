soccer_ball = {
	move = function(mob)
		if mob.m == 1000 then
			if mob.y >= 116 and mob.y <= 118 then
				if mob.x == 45 or mob.x == 46 then
					--			mob:sendAnimation(121)
					mob:talk(2, "Goal~!!!")
				elseif mob.x == 32 or mob.x == 33 then
					--			mob:sendAnimation(121)
					mob:talk(2, "Goal~!!!")
				end
			end
		end
	end,
	while_cast = function(mob, caster)
		if caster ~= nil then
			mob:talk(2, "Goal by : " .. caster.name)
		end
	end,
	uncast = function(player)
		local mob = Mob(player.registry["soccer_goal"])

		player:sendAction(10, 60)
		player:playSound(80)
		if mob ~= nil then
			mob:warp(1000, 39, 117)
			mob:sendAnimationXY(121, mob.x, mob.y)
		end
	end,
	shoot = function(player)
		local target = getTargetFacing(player, BL_MOB)

		if target ~= nil then
			if target.yname == "soccer_ball" then
				if target:hasDuration("soccer_ball") then
					return
				else
					target.registry["gm_push" .. player.side] = 1
					player:sendAction(28, 40)
					player:talk(2, "Shoot~!!!")
					target:setDuration("soccer_ball", 3000)
				end
			end
		end
	end,
	while_cast_fast = function(player)
		player:playSound(94)

		if player.registry["gm_push0"] == 1 then
			if getPass(player.m, player.x, player.y - 1) == 1 then
				player:setDuration("soccer_ball", 0)
				return
			else
				player:warp(player.m, player.x, player.y - 1)
			end
		elseif player.registry["gm_push1"] == 1 then
			if getPass(player.m, player.x + 1, player.y) == 1 then
				player:setDuration("soccer_ball", 0)
				return
			else
				player:warp(player.m, player.x + 1, player.y)
			end
		elseif player.registry["gm_push2"] == 1 then
			if getPass(player.m, player.x, player.y + 1) == 1 then
				player:setDuration("soccer_ball", 0)
				return
			else
				player:warp(player.m, player.x, player.y + 1)
			end
		elseif player.registry["gm_push3"] == 1 then
			if getPass(player.m, player.x - 1, player.y) == 1 then
				player:setDuration("soccer_ball", 0)
				return
			else
				player:warp(player.m, player.x - 1, player.y)
			end
		end
	end,
	uncast = function(player)
		for i = 0, 3 do
			player.registry["gm_push" .. i] = 0
		end
	end
}
