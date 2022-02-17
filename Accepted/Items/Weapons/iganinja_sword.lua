iganinja_sword = {
	on_swing = function(player)
		local pc = player:getObjectsInArea(BL_PC)
		local mob = player:getObjectsInArea(BL_MOB)

		if player:hasDuration("iganinja_sword") then
			return
		else
			if #pc > 0 then
				for i = 1, #pc do
					if distanceSquare(player, pc[i], 2) and player:canPK(pc[i]) and pc[i].ID ~= player.ID then
						if pc[i].state ~= 1 then
							omnislash.cast(player)
							player:setDuration("iganinja_sword", 30000)
						end
					end
				end
			end
			if #mob > 0 then
				for i = 1, #mob do
					if mob[i].owner ~= player.ID then
						if distanceSquare(player, mob[i], 2) then
							omnislash.cast(player)
							player:setDuration("iganinja_sword", 30000)
						end
					end
				end
			end
		end
	end
}

omnislash = {
	cast = function(player)
		if not player:canCast(1, 1, 0) then
			return
		end

		if player:hasDuration("omnislash") then
			return
		else
			player:setDuration("omnislash", 7000)
		end
	end,
	while_cast_250 = function(player)
		local mob = player:getObjectsInArea(BL_MOB)
		local pc = player:getObjectsInArea(BL_PC)
		local target

		if #mob > 0 then
			for i = 1, #mob do
				target = mob[math.random(#mob)]
				if target ~= nil and target.owner == 0 then
					if distanceSquare(player, target, 2) then
						player:sendAnimation(285, player.x, player.y)
						omnislash.randomWarp(player, target)
						break
					end
				end
			end
		end

		if #pc > 0 then
			for i = 1, #pc do
				target = pc[math.random(#pc)]
				if target ~= nil and target.state ~= 1 then
					if distanceSquare(player, target, 2) and player:canPK(target) then
						if target.ID ~= player.ID then
							player:sendAnimationXY(285, player.x, player.y)
							omnislash.randomWarp(player, target)
							break
						end
					end
				end
			end
		end
		player:swing()
	end,
	------------------------------------------------------------------------------------------------------------

	randomWarp = function(player, target)
		local tick = math.random(1, 4)

		if target ~= nil and target.state ~= 1 then
			if distanceSquare(player, target, 2) then
				target:sendAnimation(math.random(305, 307))

				player:sendAnimationXY(120, math.random(player.x - 1, player.x + 1), math.random(player.y - 1, player.y + 1))
				player:playSound(358)
				if tick == 1 then
					omnislash.up(player, target)
				end
				if tick == 2 then
					omnislash.right(player, target)
				end
				if tick == 3 then
					omnislash.down(player, target)
				end
				if tick == 4 then
					omnislash.left(player, target)
				end
			end
		end
	end,
	-- Atas ----------------------------------------------------------------------------------------------------

	up = function(player, target)
		if getPass(target.m, target.x, target.y - 1) == 1 then
			omnislash.right(player, target)
			return
		else
			player:warp(target.m, target.x, target.y - 1)
			player.side = 2
			player:sendSide()
			player:sendAnimationXY(279, player.x, player.y)
			player:sendAction(1, 20)
		end
	end,
	-- Kanan ----------------------------------------------------------------------------------------------------

	right = function(player, target)
		if getPass(target.m, target.x + 1, target.y) == 1 then
			omnislash.down(player, target)
			return
		else
			player:warp(target.m, target.x + 1, target.y)
			player.side = 3
			player:sendSide()
			player:sendAnimationXY(279, player.x, player.y)
			player:sendAction(1, 20)
		end
	end,
	-- Bawah ----------------------------------------------------------------------------------------------------

	down = function(player, target)
		if getPass(target.m, target.x, target.y + 1) == 1 then
			omnislash.left(player, target)
			return
		else
			player:warp(target.m, target.x, target.y + 1)
			player.side = 0
			player:sendSide()
			player:sendAnimationXY(279, player.x, player.y)
			player:sendAction(1, 20)
		end
	end,
	-- Kiri ----------------------------------------------------------------------------------------------------

	left = function(player, target)
		if getPass(target.m, target.x - 1, target.y) == 1 then
			omnislash.up(player, target)
			return
		else
			player:warp(target.m, target.x - 1, target.y)
			player.side = 1
			player:sendSide()
			player:sendAnimationXY(279, player.x, player.y)
			player:sendAction(1, 20)
		end
	end
}
