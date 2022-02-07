christmas = {
	on_attacked = function(mob, attacker)
		mob.attacker = 0
		mob.target = 0
	end,
	move = function(mob, target)
		local pc = mob:getObjectsInArea(BL_PC)
		local oldside = mob.side
		local checkmove = math.random(0, 10)
		local moved = true

		if checkmove >= 4 then
			mob.side = math.random(0, 3)
			mob:sendSide()
			if mob.side == oldside then
				moved = mob:move()
			end
		else
			moved = mob:move()
		end
		if math.random(0, 10) < 4 then
			christmas.throw_snow(mob)
		end
	end,
	after_death = function(mob)
		local member
		local killer = Player(mob.attacker)

		if killer ~= nil then
			killer:playSound(367)
			killer:playSound(723)
			killAction(killer, 1)

			for i = 1, #killer.group do
				member = Player(killer.group[i])
				if member ~= nil then
					if member.m == killer.m and member.state ~= 1 then
						giveXP(member, 100, "event")
					end
				end
			end
		end
	end,
	throw_snow = function(mob)
		local m, x, y = mob.m, mob.x, mob.y
		local pc

		mob:playSound(711)

		for i = 1, 7 do
			if mob.side == 0 then
				y = y + i
			end
			if mob.side == 1 then
				x = x + i
			end
			if mob.side == 2 then
				y = y - i
			end
			if mob.side == 3 then
				x = x - i
			end
			mob:throw(x, y, 1322, 0, 1)

			pc = getTargetFacing(mob, BL_PC, 0, i)
			if pc ~= nil then
				if pc.state ~= 1 then
					if pc.ID ~= 2 and pc.ID ~= 18 then
						pc:sendAnimation(331)
						pc:playSound(701)

						if not pc:hasDuration("christmas") then
							pc:setDuration("christmas", 4000)
							pc.drunk = true
							return
						else
							pc:setDuration("freeze", 5000)
							pc:sendAnimation(52)
							pc:playSound(47)
						end
					end
				end
				return
			end
		end
	end,
	while_cast = function(player)
		player:sendAnimation(34)
		player.drunk = 1
	end,
	uncast = function(player)
		player:calcStat()
		player.drunk = 0
		player:updateState()
	end,
	pick = function(player, action)
		local tile = {
			30451,
			30478,
			30474,
			30479,
			30483,
			30477,
			30475,
			30482,
			30480,
			30476,
			30481,
			30473,
			30471,
			30484,
			30472,
			30485,
			30470,
			30538,
			30380
		}

		if action == 4 or action == 5 then
			for i = 1, #tile do
				if getTile(player.m, player.x, player.y) == tile[i] then
					if player.registry["pick_snow"] == 0 then
						if player.gfxClone == 0 then
							clone.equip(player, player)
						else
							clone.gfx(player, player)
						end
						player.gfxWeap = 276
						player.gfxWeapC = 17
						player.gfxClone = 1
						player.registry["pick_snow"] = 1
						player:updateState()
					end
				end
			end
		end
	end,
	throwing = function(player)
		if player.registry["pick_snow"] > 0 and player.state == 0 then
			if player:hasDuration("swing_delay") then
				anim(player)
				return
			else
				player:playSound(711)
				player:setDuration("swing_delay", 3000)
				player.registry["pick_snow"] = 0
				player.gfxWeap = 65535
				player.gfxClone = 0
				player:updateState()
				--	player:updateState()

				for i = 1, 7 do
					if player.side == 0 then
						if getPass(player.m, player.x, player.y - i) == 1 then
							return
						else
							player:throw(player.x, player.y - i, 1322, 0, 1)
						end
					elseif player.side == 1 then
						if getPass(player.m, player.x + i, player.y) == 1 then
							return
						else
							player:throw(player.x + i, player.y, 1322, 0, 1)
						end
					elseif player.side == 2 then
						if getPass(player.m, player.x, player.y + i) == 1 then
							return
						else
							player:throw(player.x, player.y + i, 1322, 0, 1)
						end
					elseif player.side == 3 then
						if getPass(player.m, player.x - i, player.y) == 1 then
							return
						else
							player:throw(player.x - i, player.y, 1322, 0, 1)
						end
					end
					--player:sendAction(2, 30)
					local mob = getTargetFacing(player, BL_MOB, 0, i)
					local pc = getTargetFacing(player, BL_PC, 0, i)

					if mob ~= nil then
						if mob.yname == "christmas" then
							mob.attacker = player.ID
							mob:sendAnimation(52)
							mob:removeHealth(1000000)
							mob:sendAnimation(318)
							mob:sendAnimationXY(331, mob.x, mob.y)
							player:playSound(47)
						end
						return
					end
					if pc ~= nil then
						if pc.state ~= 1 then
							if player.m == 4000 and pc.m == 4000 then
								snow_ball.damaged(player, pc)
								return
							else
								pc:sendAnimation(331)
								pc:sendAnimation(318)
								pc:playSound(701)

								if pc.registry["pick_snow"] > 0 then
									pc.registry["pick_snow"] = 0
									pc.gfxWeap = 65535
									pc:updateState()
								end

								pc.side = math.random(0, 3)
								pc:sendSide()
								pc:sendAnimationXY(22, pc.x, pc.y)

								if not pc:hasDuration("christmas") then
									pc:setDuration("christmas", 3000)
								else
									pc:sendAnimation(52)
									player:playSound(47)
									pc:setDuration("freeze", 5000)
								end
							end
						end
						return
					end
				end
			end
		end
	end
}
