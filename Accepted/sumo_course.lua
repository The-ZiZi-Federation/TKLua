sumo_course = {
	bridge = function(id, map)
		local x
		local y
		--	local map = 15030

		if id == 1 or id == 2 or id == 9 or id == 10 or id == 15 then
			if id == 1 then
				x = 65
				y = 25
			end
			if id == 2 then
				x = 65
				y = 30
			end
			if id == 9 then
				x = 84
				y = 25
			end
			if id == 10 then
				x = 84
				y = 30
			end
			if id == 15 then
				x = 58
				y = 13
			end
			if id == 16 then
				x = 91
				y = 33
			end
			if id == 17 then
				x = 91
				y = 13
			end
			if id == 18 then
				x = 58
				y = 33
			end

			tile = getTile(map, x, y)
			if tile == 628 then
				setTile(map, x, y, 218)
				setTile(map, x, y + 1, 221)
				setPass(map, x, y, 0)
				setPass(map, x, y + 1, 0)
				return
			else
				setTile(map, x, y, 628)
				setTile(map, x, y + 1, 628)
				setPass(map, x, y, 1)
				setPass(map, x, y + 1, 1)

				local splashPC1 = core:getObjectsInCell(map, x, y, BL_PC)
				local splashPC2 = core:getObjectsInCell(map, x, y + 1, BL_PC)

				if splashPC1 ~= nil then
					for i = 1, #splashPC1 do
						sumo_course.splash(splashPC1[i])
					end
				end
				if splashPC2 ~= nil then
					for i = 1, #splashPC2 do
						sumo_course.splash(splashPC2[i])
					end
				end
			end
			return
		elseif id == 3 then
			x = 71
			y = 23
		elseif id == 4 then
			x = 72
			y = 28
		elseif id == 5 then
			x = 71
			y = 33
		elseif id == 6 then
			x = 76
			y = 23
		elseif id == 7 then
			x = 77
			y = 28
		elseif id == 8 then
			x = 76
			y = 33
		elseif id == 11 then
			x = 84
			y = 36
		elseif id == 12 then
			x = 84
			y = 10
		elseif id == 13 then
			x = 64
			y = 10
		elseif id == 14 then
			x = 64
			y = 36
		end

		local tile = getTile(map, x, y)
		if tile == 628 then
			setTile(map, x, y, 218)
			setTile(map, x + 1, y, 218)
			setTile(map, x, y + 1, 221)
			setTile(map, x + 1, y + 1, 221)
			setPass(map, x, y, 0)
			setPass(map, x + 1, y, 0)
			setPass(map, x, y + 1, 0)
			setPass(map, x + 1, y + 1, 0)
			return
		else
			setTile(map, x, y, 628)
			setTile(map, x + 1, y, 628)
			setTile(map, x, y + 1, 628)
			setTile(map, x + 1, y + 1, 628)
			setPass(map, x, y, 1)
			setPass(map, x + 1, y, 1)
			setPass(map, x, y + 1, 1)
			setPass(map, x + 1, y + 1, 1)

			local splashPC3 = core:getObjectsInCell(map, x, y, BL_PC)
			local splashPC4 = core:getObjectsInCell(map, x + 1, y, BL_PC)
			local splashPC5 = core:getObjectsInCell(map, x, y + 1, BL_PC)
			local splashPC6 = core:getObjectsInCell(map, x + 1, y + 1, BL_PC)

			if splashPC3 ~= nil then
				for i = 1, #splashPC3 do
					sumo_course.splash(splashPC3[i])
				end
			end

			if splashPC4 ~= nil then
				for i = 1, #splashPC4 do
					sumo_course.splash(splashPC4[i])
				end
			end

			if splashPC5 ~= nil then
				for i = 1, #splashPC5 do
					sumo_course.splash(splashPC5[i])
				end
			end

			if splashPC6 ~= nil then
				for i = 1, #splashPC6 do
					sumo_course.splash(splashPC6[i])
				end
			end
		end
	end,
	guiText = function(player)
		local diff = player.registry["sumo_course_start_time"] - os.time()
		local currentTime = playerTimerValues(player, "sumo_course_start_time")

		player:guitext("\n[SUMO COURSE]\n    " .. currentTime .. "\n    Dunks: " .. player.registry["sumo_course_dunks"])
	end,
	bridgeController = function(player)
		sumo_course.bridge(math.random(1, 18), player.m)
	end,
	splash = function(player)
		--	player.health = 0
		--	player.state = 1
		player:updateState()
		player:playSound(73)
		player:sendAnimationXY(142, player.x, player.y)
		player:warp(player.m, 53, 23)
	end,
	finishLine = function(player)
		local m, x, y = player.m, player.x, player.y
		local finishTile = 3434
		local curTile = getTile(m, x, y)
		local timeTaken
		local finishTime

		if curTile == finishTile then
			player.registry["sumo_course_finish_time"] = os.time()
			timeTaken = player.registry["sumo_course_finish_time"] - player.registry["sumo_course_start_time"]
			finishTime = numTimerValues(timeTaken)
			player:sendMinitext(
				"You completed the Sumo Course in " .. finishTime .. " with " .. player.registry["sumo_course_dunks"] .. " dunks."
			)

			player:warp(1044, 8, 8)
		end

		if timeTaken <= 300 then --finish in under 5 minutes
			if player.registry["sumo_course_dunks"] >= 10 then --more than 10 dunks
				player:sendMinitext("Congratulations, you passed the Sumo Course!")
				sumo_course.legend(player)
			else
				player:sendMinitext("Sorry, you needed more dunks!")
			end
		else
			player:sendMinitext("Sorry, you took too long!")
		end
	end,
	legend = function(player)
		local reg = player.registry["sumo_course_times_complete"]
		local timeTaken = player.registry["sumo_course_finish_time"] - player.registry["sumo_course_start_time"]
		local finishTime
		local bestTime = player.registry["sumo_course_best_time"]

		if bestTime == 0 or timeTaken < bestTime then
			player.registry["sumo_course_best_time"] = timeTaken
		end

		if player:hasLegend("sumo_course_complete") then
			player:removeLegendbyName("sumo_course_complete")
		end
		if not player:hasSpell("knockback_strike") then
			player:msg(0, "SUCCESS! Talk to the Sumo Elder to receive his training!", player.ID)
		end

		finishTime = numTimerValues(player.registry["sumo_course_best_time"])

		if reg > 0 then
			player.registry["sumo_course_times_complete"] = player.registry["sumo_course_times_complete"] + 1
			player:addLegend(
				"Completed Sumo Course " .. player.registry["sumo_course_times_complete"] .. " times, record " .. finishTime,
				"sumo_course_complete",
				5,
				16
			)
		else
			player.registry["sumo_course_times_complete"] = 1
			player:addLegend("Completed Sumo Course 1 time, record " .. finishTime, "sumo_course_complete", 5, 16)
		end
	end
}
