modz_mode = {
	cast = function(player)
		local disguise = player:inputNumberCheck(player:input("Pick a number."))

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
	end,
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
			player:sendMinitext("Your Spiritual Transformation ends")
		end
	end
}
