chungryong_rage = {
	cast = function(player)
		local rage1 = player:hasDuration("cr1")
		local rage2 = player:hasDuration("cr2")
		local rage3 = player:hasDuration("cr3")
		local rage4 = player:hasDuration("cr4")
		local rage5 = player:hasDuration("cr5")

		if rage5 then
			anim(player)
			player:sendMinitext("You already reach the highest Rage")
			return
		else
			if rage4 then
				cr5.cast(player)
				return
			else
				if rage3 then
					cr4.cast(player)
					return
				else
					if rage2 then
						cr3.cast(player)
						return
					else
						if rage1 then
							cr2.cast(player)
							return
						else
							cr1.cast(player)
						end
					end
				end
			end
		end
	end
}

cr1 = {
	cast = function(player)
		player:sendAction(18, 30)
		player:sendAnimation(36)
		player:setDuration("cr1", 120000)
		player:talk(2, "Chungryong rage 1")
		player:sendMinitext("You cast Chungryong rage 1")
	end,
	while_cast_250 = function(player)
		player.rage = 2
	end,
	uncast = function(player)
		player:calcStat()
	end
}

cr2 = {
	cast = function(player)
		player:sendAction(18, 30)
		player:sendAnimation(36)
		player:flushDurationNoUncast(7, 7)
		player:setDuration("cr2", 240000)
		player:talk(2, "Chungryong rage 2")
		player:sendMinitext("You cast Chungryong rage 2")
	end,
	while_cast_250 = function(player)
		player.rage = 3
	end,
	uncast = function(player)
		player:calcStat()
	end
}

cr3 = {
	cast = function(player)
		player:sendAction(18, 30)
		player:sendAnimation(36)
		player:flushDurationNoUncast(8, 8)
		player:setDuration("cr3", 360000)
		player:talk(2, "Chungryong rage 3")
		player:sendMinitext("You cast Chungryong rage 3")
	end,
	while_cast_250 = function(player)
		player.rage = 4
	end,
	uncast = function(player)
		player:calcStat()
	end
}

cr4 = {
	cast = function(player)
		player:sendAction(18, 30)
		player:sendAnimation(36)
		player:flushDurationNoUncast(9, 9)
		player:setDuration("cr4", 640000)
		player:talk(2, "Chungryong rage 4")
		player:sendMinitext("You cast Chungryong rage 4")
	end,
	while_cast_250 = function(player)
		player.rage = 5
	end,
	uncast = function(player)
		player:calcStat()
	end
}

cr5 = {
	cast = function(player)
		player:sendAction(18, 30)
		player:sendAnimation(36)
		player:flushDurationNoUncast(10, 10)
		player:setDuration("cr5", 860000)
		player:talk(2, "Chungryong rage 5")
		player:sendMinitext("You cast Chungryong rage 5")
	end,
	while_cast_250 = function(player)
		player.rage = 6
	end,
	uncast = function(player)
		player:calcStat()
	end
}
