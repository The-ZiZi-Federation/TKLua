dailyStardrop = {
	onDrop = function(player, item)
		local pc = core:getObjectsInMap(player.m, BL_PC)

		if player.m == 4025 then
			if item.yname == "stardrop" then
				if player.y >= 9 and player.y <= 11 then
					if player.x >= 10 and player.x <= 13 then
						if player.registry["daily_stardrop_time"] > os.time() then
							player:sendMinitext("You must wait a while before you may offer another blessing")
							return
						end

						if player.registry["daily_stardrop_time"] < os.time() then
							player.registry["daily_stardrop_time"] = os.time() + 43200
							player.paralyzed = true
							player.registry["star_blessing"] = player.registry["star_blessing"] + 1
							if player:hasLegend("star_blessing") then
								player:removeLegendbyName("star_blessing")
							end

							if player.registry["star_blessing"] > 1 then
								player:addLegend(
									"Offered a Blessing to the Stars " .. player.registry["star_blessing"] .. " times",
									"star_blessing",
									127,
									15
								)
							else
								player:addLegend("Offered a Blessing to the Stars 1 time", "star_blessing", 127, 15)
							end

							player:setDuration("offering", 3000)
						end
					end
				end
			end
		end
	end,
	delete = function(player)
		local stardrop = player:getObjectsInCell(player.m, player.x, player.y, BL_ITEM)
		local pc = core:getObjectsInMap(player.m, BL_PC)

		for i = 1, #stardrop do
			stardrop[i]:delete()
		end

		for i = 1, #pc do
			pc[i]:refresh()
		end
	end
}

offering = {
	while_cast = function(player)
		player.paralyzed = true
		dailyStardrop.delete(player)
		player:sendAction(5, 400)
	end,
	uncast = function(player)
		player:sendAnimation(18)
		player:playSound(80)
		player.paralyzed = false
	end
}
