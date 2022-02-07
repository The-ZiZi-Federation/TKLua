follow = {
	cast = function(player)
		local target = string.lower(player.question)

		if player:hasDuration("follow") then
			player:setDuration("follow", 0)
			player.registry["follow_target"] = 0
			return
		else
			if target ~= nil then
				if Player(target) ~= nil then
					player.registry["follow_target"] = Player(target).ID
					player:setDuration("follow", 60000)
				else
					anim(player)
					player:sendMinitext("user not found!")
				end
			end
		end
	end,
	while_cast_fast = function(player)
		local target = player.registry["follow_target"]

		if target > 0 then
			if Player(target) ~= nil then
				player:warp(Player(target).m, Player(target).x, Player(target).y)
			else
				player:setDuration("follow", 0)
			end
		end
	end,
	uncast = function(player)
		player.registry["follow_target"] = 0
		player:calcStat()
	end
}
