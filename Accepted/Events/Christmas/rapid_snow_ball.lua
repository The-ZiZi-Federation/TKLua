rapid_snow_ball = {
	cast = function(player) --
		--[[
	player:sendAction(6, 20)
	if player:hasDuration("rapid_snow_ball") then player:setDuration("rapid_snow_ball", 0) return else
		player:setDuration("rapid_snow_ball", 60000)
	end
end,

while_cast_250 = function(player)

	player:playSound(711)

	for i = 1, 7 do
		if player.side == 0 then
			if getPass(player.m, player.x, player.y-i) == 1 then return else player:throw(player.x, player.y-i, 1322, 0, 1) end
		elseif player.side == 1 then
			if getPass(player.m, player.x+i, player.y) == 1 then return else player:throw(player.x+i, player.y, 1322, 0, 1) end
		elseif player.side == 2 then
			if getPass(player.m, player.x, player.y+i) == 1 then return else player:throw(player.x, player.y+i, 1322, 0, 1) end
		elseif player.side == 3 then
			if getPass(player.m, player.x-i, player.y) == 1 then return else player:throw(player.x-i, player.y, 1322, 0, 1) end
		end
		
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
				if player.m == 10011 and pc.m == 10011 then snow_ball.damaged(player, pc) return else
					pc:sendAnimation(331)
					pc:sendAnimation(318)
					pc:playSound(701)
					
					if pc.registry["pick_snow"] > 0 then
						pc.registry["pick_snow"] = 0
						pc.gfxWeap = 65535
						pc:updateState()
					end
					
					pc.side = math.random(0,3)
					pc:sendSide()
					pc:sendAnimationXY(22, pc.x, pc.y)
					
					if not pc:hasDuration("christmas") then pc:setDuration("christmas", 3000) else
						pc:sendAnimation(52)
						player:playSound(47)
						pc:setDuration("freeze", 5000)
					end
				end
			end
			return
		end
	end
end,

uncast = function(player)

	player:calcStat()
]]
	end
}
