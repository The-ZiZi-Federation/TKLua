playSoccer = function(player)
	local s = player.side
	local m = player.m
	local x = player.x
	local y = player.y
	local pc = getTargetFacing(player, BL_PC)
	local mob = getTargetFacing(player, BL_MOB)
	local kn = player:getObjectsInCell(m, x + 1, y, BL_MOB)
	local kr = player:getObjectsInCell(m, x - 1, y, BL_MOB)
	local at = player:getObjectsInCell(m, x, y - 1, BL_MOB)
	local bw = player:getObjectsInCell(m, x, y + 1, BL_MOB)
	local rate = math.random(1, 2)

	if s == 0 then
		if mob ~= nil and mob.yname == "soccer_ball" then
			if player.y == 115 then
				if player.x == 32 then
					moveRight(mob)
				elseif player.x == 46 then
					moveLeft(mob)
				else
					if rate == 1 then
						moveRight(mob)
					end
					if rate == 2 then
						moveLeft(mob)
					end
				end
			else
				block = player:getObjectsInCell(m, x, y - 2, BL_PC)
				if #block > 0 then
					if rate == 1 then
						moveRight(mob)
					end
					if rate == 2 then
						moveLeft(mob)
					end
				else
					moveUp(mob)
				end
			end
		else
			for x = 1, 1 do
				if kr[x] ~= nil and kr[x].yname == "soccer_ball" then
					if player.y == 114 then
					else
						moveUp(kr[x])
					end
				end
				if kn[x] ~= nil and kn[x].yname == "soccer_ball" then
					if player.y == 114 then
					else
						moveUp(kn[x])
					end
				end
			end
		end
	elseif s == 1 then
		if mob ~= nil and mob.yname == "soccer_ball" then
			if player.x == 45 then
				if player.y == 114 then
					moveDown(mob)
				elseif player.y == 120 then
					moveUp(mob)
				else
					if rate == 1 then
						moveDown(mob)
					end
					if rate == 2 then
						moveUp(mob)
					end
				end
			else
				block = player:getObjectsInCell(m, x + 2, y, BL_PC)
				if #block > 0 then
					if rate == 1 then
						moveUp(mob)
					end
					if rate == 2 then
						moveDown(mob)
					end
				else
					moveRight(mob)
				end
			end
		else
			for x = 1, 1 do
				if at[x] ~= nil and at[x].yname == "soccer_ball" then
					if player.x == 46 then
					else
						moveRight(at[x])
					end
				end
				if bw[x] ~= nil and bw[x].yname == "soccer_ball" then
					if player.x == 46 then
					else
						moveRight(bw[x])
					end
				end
			end
		end
	elseif s == 2 then
		if mob ~= nil and mob.yname == "soccer_ball" then
			if player.y == 119 then
				if player.x == 32 then
					moveRight(mob)
				elseif player.x == 46 then
					moveLeft(mob)
				else
					if rate == 1 then
						moveRight(mob)
					end
					if rate == 2 then
						moveLeft(mob)
					end
				end
			else
				block = player:getObjectsInCell(m, x, y + 2, BL_PC)
				if #block > 0 then
					if rate == 1 then
						moveRight(mob)
					end
					if rate == 2 then
						moveLeft(mob)
					end
				else
					moveDown(mob)
				end
			end
		else
			for x = 1, 1 do
				if kr[x] ~= nil and kr[x].yname == "soccer_ball" then
					if player.y == 120 then
					else
						moveDown(kr[x])
					end
				end
				if kn[x] ~= nil and kn[x].yname == "soccer_ball" then
					if player.y == 120 then
					else
						moveDown(kn[x])
					end
				end
			end
		end
	elseif s == 3 then
		if mob ~= nil and mob.yname == "soccer_ball" then
			if player.x == 33 then
				if player.y == 114 then
					moveDown(mob)
				elseif player.y == 120 then
					moveUp(mob)
				else
					if rate == 1 then
						moveDown(mob)
					end
					if rate == 2 then
						moveUp(mob)
					end
				end
			else
				block = player:getObjectsInCell(m, x - 2, y, BL_PC)
				if #block > 0 then
					if rate == 1 then
						moveUp(mob)
					end
					if rate == 2 then
						moveDown(mob)
					end
				else
					moveLeft(mob)
				end
			end
		else
			for x = 1, 1 do
				if at[x] ~= nil and at[x].yname == "soccer_ball" then
					if player.x == 32 then
					else
						moveLeft(at[x])
					end
				end
				if bw[x] ~= nil and bw[x].yname == "soccer_ball" then
					if player.x == 32 then
					else
						moveLeft(bw[x])
					end
				end
			end
		end
	end

	if mob ~= nil and mob.yname == "soccer_ball" then
		if mob.x == 32 or mob.x == 33 or mob.x == 45 or mob.x == 46 then
			if mob.y >= 116 and mob.y <= 118 then
				player.registry["soccer_goal"] = mob.ID
				player:setDuration("soccer_ball", 2000)
				mob:sendAnimation(121)
				mob:talk(2, "Goal~!!!")
				player:sendAction(10, 60)
			end
		end
	end
end

moveRight = function(mob)
	toXY(mob, mob.x + 1, mob.y)
end
moveUp = function(mob)
	toXY(mob, mob.x, mob.y - 1)
end
moveLeft = function(mob)
	toXY(mob, mob.x - 1, mob.y)
end
moveDown = function(mob)
	toXY(mob, mob.x, mob.y + 1)
end
