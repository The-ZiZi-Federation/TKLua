bomber_start = {
	cast = function(player)
		local armor = {10018, 10019, 10022, 10025, 10026, 10049, 10088, 10089}

		if player:hasDuration("bomber_start") then
			player:flushDurationNoUncast(42, 42)
			player:broadcast(player.m, "=== Bomber mania canceled !! ===")
			return
		else
			pc = player:getObjectsInMap(player.m, BL_PC)
			if #pc > 0 then
				for i = 1, #pc do
					gfxClone(pc[i], pc[i])
					pc[i].gfxWeap = 65535
					pc[i].gfxArmor = armor[math.random(#armor)]
					pc[i].gfxShield = 65535
					pc[i].gfxBoots = 65535
					pc[i].gfxClone = 1
					pc[i]:updateState()
				end
			end

			player:setDuration("bomber_start", 10000)
			player:broadcast(player.m, "=== Bomber mania will start in 10 seconds ===")
		end
	end,
	uncast = function(player)
		local around = player:getObjectsInMap(player.m, BL_PC)

		bomber_game.cast(around[math.random(#around)])
	end
}

----------------------------------------------------------------------------------------------------------------------------

respawn_game = {
	while_cast = function(player)
		player:talk(2, "Respawn in " .. player:getDuration("respawn_game") / 1000 .. " s")
	end,
	uncast = function(player)
	end
}

----------------------------------------------------------------------------------------------------------------------------

bomber_game = {
	onWalk = function(player)
		for tile = 35009, 35016 do
			if getTile(player.m, player.x, player.y) == tile or getTile(player.m, player.x, player.y) == 628 then
				if player.state == 1 then
					return
				else
					--			player:setDuration("respawn_game", 5000)
					if player:hasDuration("bomber_game") then
						anim(player)
						pushBack(player)
						return
					else
						player:playSound(73)
						player:sendAnimationXY(137, player.x, player.y)
						player:sendAnimation(142)
						player.state = 1
						player:updateState()
					end
				end
			end
		end
	end,
	cast = function(player)
		if player:hasDuration("bomber_game") then
			player:setDuration("bomber_game", 0)
			return
		else
			player:sendAnimation(248)
			player:setDuration("bomber_game", 100000)
			gfxClone(player, player)
			player.gfxWeap = 167
			player.gfxWeapC = 50
			player.gfxClone = 1
			player:updateState()
		end
	end,
	while_cast = function(player)
		local dura = player:getDuration("bomber_game")

		bomber_game.bridge(player, math.random(1, 10))
		player.gfxWeap = 167
		player.gfxWeapC = 50
		player:sendAnimation(367)
		player:playSound(109)

		player:talk(2, "" .. dura / 1000 .. " s")

		if dura == 2000 then
			player.paralyzed = true
			player:sendAction(12, 60)
			player:sendAnimation(19)
			player:sendAnimation(171)
		end
	end,
	uncast = function(player)
		player.paralyzed = false
		player.gfxClone = 0
		player:updateState()
		player.attacker = player.ID
		player:sendAnimation(172)
		player:sendAnimationXY(292, player.x, player.y)
		player:sendAnimationXY(188, player.x - 1, player.y)
		player:sendAnimationXY(188, player.x + 1, player.y)
		player:sendAnimationXY(188, player.x, player.y - 1)
		player:sendAnimationXY(188, player.x, player.y + 1)
		for i = 1, 3 do
			player:playSound(54)
			player:playSound(73)
			player:playSound(99)
		end
		player:removeHealth(player.health)
		player:sendAnimation(134)
		player:playSound(500)
		player:sendAnimation(245)
	end,
	on_swing_while_cast = function(player)
		local dura = player:getDuration("bomber_game")
		local m = player.m
		local x = player.x
		local y = player.y
		local side = player.side

		if player:hasDuration("bomber_game") then
			for i = 1, 2 do
				pc = getTargetFacing(player, BL_PC, 0, i)
				if side == 0 then
					player:throw(x, y - i, 275, 0, 1)
				elseif side == 1 then
					player:throw(x + i, y, 275, 0, 1)
				elseif side == 2 then
					player:throw(x, y + i, 275, 0, 1)
				elseif side == 3 then
					player:throw(x - i, y, 275, 0, 1)
				end
				if pc ~= nil and pc.state ~= 1 then
					player:talk(0, "Passed!")
					pc:sendAnimation(368)
					player.gfxClone = 0
					player:updateState()
					player:flushDurationNoUncast(41, 41)
					gfxClone(pc, pc)
					pc.gfxWeap = 167
					pc.gfxWeapC = 50
					pc.gfxClone = 1
					pc:setDuration("bomber_game", dura)
					pc:sendAnimation(248)
					pc:sendStatus()
					pc:updateState()
					return
				end
			end
		end
	end,
	bridge = function(player, id)
		local x
		local y
		local map = 20018

		if id == 1 or id == 2 or id == 9 or id == 10 then
			if id == 1 then
				x = 65
				y = 25
			end
			if id == 2 then
				x = 65
				y = 30
			end
			if id == 9 then
				x = 84
				y = 25
			end
			if id == 10 then
				x = 84
				y = 30
			end
			tile = getTile(map, x, y)
			if tile == 628 then
				setTile(map, x, y, 218)
				setTile(map, x, y + 1, 221)
				return
			else
				setTile(map, x, y, 628)
				setTile(map, x, y + 1, 628)
			end
			return
		elseif id == 3 then
			x = 71
			y = 23
		elseif id == 4 then
			x = 72
			y = 28
		elseif id == 5 then
			x = 71
			y = 33
		elseif id == 6 then
			x = 76
			y = 23
		elseif id == 7 then
			x = 77
			y = 28
		elseif id == 8 then
			x = 76
			y = 33
		end

		local tile = getTile(map, x, y)
		if tile == 628 then
			setTile(map, x, y, 218)
			setTile(map, x + 1, y, 218)
			setTile(map, x, y + 1, 221)
			setTile(map, x + 1, y + 1, 221)
			return
		else
			setTile(map, x, y, 628)
			setTile(map, x + 1, y, 628)
			setTile(map, x, y + 1, 628)
			setTile(map, x + 1, y + 1, 628)
		end
	end
}
