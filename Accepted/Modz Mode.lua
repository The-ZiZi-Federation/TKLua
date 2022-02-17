modz_mode = {
	cast = function(player)
		player:freeAsync()
		modz_mode.click(player, core)
	end,
	click = async(
		function(player, npc)
			local duration = 60000
			local anim = 249
			local sound = 36
			if player:hasDuration("modz_mode") or player.state == 4 then
				player:setDuration("modz_mode", 0)
				player.disguise = 0
				player.disguiseColor = 0
				player.state = 0
				player:updateState()
				return
			else
				if player.state == 0 then
					local disguise = player:inputNumberCheck(player:input("Pick a number."))
					player.disguise = disguise
					player.disguiseColor = 0
					player.state = 4
					player:updateState()
					player:sendAnimation(anim)
					player:playSound(sound)
					player:sendMinitext("You go into Modz Mode!")
					player:setDuration("modz_mode", duration)
				end
			end
		end
	),
	uncast = function(player)
		local anim = 249
		local sound = 36

		if player.state == 4 then
			player.disguise = 0
			player.disguiseColor = 0
			player.state = 0
			player:updateState()
			player:sendAnimation(anim)
			player:playSound(sound)
		end
	end
}
