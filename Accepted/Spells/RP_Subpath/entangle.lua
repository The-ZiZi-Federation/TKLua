entangle = {
	cast = function(player, target)
		local dist1 = 4
		local dist2 = 5
		local m = player.m

		for x = (target.x - dist1), (target.x + dist1) do
			for y = (target.y - dist1), (target.y + dist1) do
				if distanceSquareXY(target, x, y, dist2) then
					if (x > 0 and y > 0) and (x < player.xmax and y < player.ymax) then
						player:addNPC("entangle", m, x, y, 1000, 10000, player.ID)
					end
				end
			end
		end
	end,
	on_spawn = function(npc)
		entangle.animation(npc)
		entangle.dealDamage(npc)
		entangle.slow(npc)
	end,
	action = function(npc)
		local m, x, y = npc.m, npc.x, npc.y
		local player = core:getObjectsInMap(m, BL_PC)
		local target

		entangle.animation(npc)
		entangle.dealDamage(npc)
		entangle.slow(npc)
	end,
	slow = function(npc)
		local target
		local m, x, y = npc.m, npc.x, npc.y

		target = npc:getObjectsInCell(m, x, y, BL_PC)
		if #target > 0 then
			for i = 1, #target do
				if not target[i]:hasDuration("entangle") then
					target[i]:setDuration("entangle", 2000)
				end
			end
		end
	end,
	dealDamage = function(npc)
		local target
		local m, x, y = npc.m, npc.x, npc.y

		target = npc:getObjectsInCell(m, x, y, BL_PC)
		if #target > 0 then
			for i = 1, #target do
				target[i]:removeHealth(1000)
			end
		end
	end,
	animation = function(npc)
		local x, y = npc.x, npc.y

		npc:sendAnimationXY(399, x, y)
	end,
	endAction = function(npc)
		npc:delete()
	end,
	while_cast_250 = function(player)
		player.speed = 200
		player:updateState()
	end,
	uncast = function(player)
		local m, x, y = player.m, player.x, player.y
		local npc = player:getObjectsInCell(m, x, y, BL_NPC)

		if #npc > 0 then
			for i = 1, #npc do
				if npc[i].yname == "entangle" then
					if not player:hasDuration("entangle") then
						player:setDuration("entangle", 1000)
					end
				end
			end
		end
		player:calcStat()
	end
}
