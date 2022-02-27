kiss_me = {

cast = function(player)

	pc = getTargetFacing(player, BL_PC)
	
	if pc ~= nil then
         if pc.registry["can_be_push"] > 0 then
			anim(player)
			pushBack(player)
			player:popUp("Sorry you are not my type")
			player:sendAction(12, 30)
			return
		end
		if not pc:hasDuration("kiss_me") and not player:hasDuration("kiss_me") then
			if pc.ID == 2 then
				player.state = 1
				player:updateState()
			return else
				pc:lock()
				player:lock()
				if player.side == 0 then
					pc.side = 2
				elseif player.side == 1 then
					pc.side = 3
				elseif player.side == 2 then
					pc.side = 0
				elseif player.side == 3 then
					pc.side = 1
				end
				pc:sendSide()
				pc:setDuration("kiss_me", 5000)
				player:setDuration("kiss_me", 5000)
			end
		end
	end
end,


while_cast_250 = function(player)

	player:sendAnimationXY(331, math.random(player.x-2, player.x+2), math.random(player.y-2, player.y+2))
	player:sendAction(24, 30)
	
end,

uncast = function(player)

	player:unlock()
	player:calcStat()
end
}
