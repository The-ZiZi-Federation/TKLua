medusas_gaze = {
	cast = function(player, target)
		local damage = math.random(2100, 3340)

		if mob.sleep ~= 1 then
			return
		end

		target.attacker = player.ID
		target:sendAnimation(316)
		target:playSound(24)
		target:sendMinitext(player.name .. " attacks you with Medusa's Gaze!")
		target.paralyzed = true
		target:setDuration("medusas_gaze", 3000)
		target:removeHealthExtend(damage, 1, 1, 1, 1, 3)
		target:sendStatus()
	end,
	while_cast = function(player)
		player:sendAnimation(316)
		player.paralyzed = true
	end,
	uncast = function(player)
		player.paralyzed = false
		player:calcStat()
	end
}

medusas_darkness = {
	cast = function(player, target)
		local damage = math.random(1050, 1670)

		if mob.sleep ~= 1 then
			return
		end

		target.attacker = player.ID
		target:sendAnimation(393)
		target:playSound(28)
		target:sendMinitext(player.name .. " attacks you with Medusa's Darkness!")
		target.blind = 1
		target:setDuration("medusas_darkness", 5000)
		target:removeHealthExtend(damage, 1, 1, 1, 1, 3)
		target:sendStatus()
	end,
	while_cast = function(player)
		player:sendAnimation(393)
		--player.blind = 1
	end,
	uncast = function(player)
		player.blind = 0
		player:calcStat()
	end
}
