spiritual_transformation = {
	cast = function(player)
		local goodKarma = player.registry["good_karma"]
		local badKarma = player.registry["bad_karma"]
		local goodTransform = math.random(1317, 1321)
		local badTransform = math.random(1310, 1314)
		local r = math.random(1, 2)

		local duration = 60000
		local anim = 249
		local sound = 36

		if goodKarma > badKarma then
			randomDisguise = goodTransform
		elseif badKarma > goodKarma then
			randomDisguise = badTransform
		elseif goodKarma == badKarma then
			if r == 1 then
				randomDisguise = goodTransform
			elseif r == 2 then
				randomDisguise = badTransform
			end
		end

		if not player:canCast(1, 1, 0) then
			return
		end

		if player:hasDuration("spiritual_transformation") or player.state == 4 then
			anim(player)
			player:sendMinitext("You are already transformed!")
			return
		else
			if player.state == 0 then
				player.disguise = randomDisguise
				player.disguiseColor = 0
				player.state = 4
				player:updateState()
				player:sendAnimation(anim)
				player:playSound(sound)
				player:sendMinitext("You cast Spiritual Transformation")
				player:setDuration("spiritual_transformation", duration)
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
