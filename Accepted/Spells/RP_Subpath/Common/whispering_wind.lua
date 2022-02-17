whispering_wind_1 = {
	--level 5

	on_learn = function(player)
		player.registry["learned_whispering_wind_1"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_whispering_wind_1"] = 0
	end,
	cast = function(player)
		local magicCost, delay = 100, 900000
		local user = player:getUsers()
		local text = player.question

		if text ~= nil then
			if #user > 0 then
				if player.gmLevel == 0 then
					if not player:canCast(1, 1, 0) then
						return
					else
						if player.magic < magicCost then
							notEnoughMP(player)
							return
						else
							if player.ID == 943 or player.ID == 1086 or player.ID == 1369 then
								player:setAether("whispering_wind_1", 120000)
							else
								player:setAether("whispering_wind_1", delay)
							end
							whispering_wind_1.casted(player)
							broadcast(-1, "[" .. player.name .. "]: " .. text)
						end
					end
					return
				else
					broadcast(-1, "[" .. player.name .. "]: " .. text)
					whispering_wind_1.casted(player)
				end
			end
		end
	end,
	casted = function(player)
		player:sendAction(6, 20)
		player:playSound(112)
	end
}

whispering_wind_2 = {
	--level 25

	on_learn = function(player)
		player.registry["learned_whispering_wind_2"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_whispering_wind_2"] = 0
	end,
	cast = function(player)
		local magicCost, delay = 100, 720000
		local user = player:getUsers()
		local text = player.question

		if text ~= nil then
			if #user > 0 then
				if player.gmLevel == 0 then
					if not player:canCast(1, 1, 0) then
						return
					else
						if player.magic < magicCost then
							notEnoughMP(player)
							return
						else
							if player.ID == 943 or player.ID == 1086 or player.ID == 1369 then
								player:setAether("whispering_wind_2", 90000)
							else
								player:setAether("whispering_wind_2", delay)
							end
							whispering_wind_2.casted(player)
							broadcast(-1, "[" .. player.name .. "]: " .. text)
						end
					end
					return
				else
					broadcast(-1, "[" .. player.name .. "]: " .. text)
					whispering_wind_2.casted(player)
				end
			end
		end
	end,
	casted = function(player)
		player:sendAction(6, 20)
		player:playSound(112)
	end
}

whispering_wind_3 = {
	--level 50

	on_learn = function(player)
		player.registry["learned_whispering_wind_3"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_whispering_wind_3"] = 0
	end,
	cast = function(player)
		local magicCost, delay = 100, 540000
		local user = player:getUsers()
		local text = player.question

		if text ~= nil then
			if #user > 0 then
				if player.gmLevel == 0 then
					if not player:canCast(1, 1, 0) then
						return
					else
						if player.magic < magicCost then
							notEnoughMP(player)
							return
						else
							if player.ID == 943 or player.ID == 1086 or player.ID == 1369 then
								player:setAether("whispering_wind_3", 75000)
							else
								player:setAether("whispering_wind_3", delay)
							end
							whispering_wind_3.casted(player)
							broadcast(-1, "[" .. player.name .. "]: " .. text)
						end
					end
					return
				else
					broadcast(-1, "[" .. player.name .. "]: " .. text)
					whispering_wind_3.casted(player)
				end
			end
		end
	end,
	casted = function(player)
		player:sendAction(6, 20)
		player:playSound(112)
	end
}

whispering_wind_4 = {
	--level 75

	on_learn = function(player)
		player.registry["learned_whispering_wind_4"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_whispering_wind_4"] = 0
	end,
	cast = function(player)
		local magicCost, delay = 100, 360000
		local user = player:getUsers()
		local text = player.question

		if text ~= nil then
			if #user > 0 then
				if player.gmLevel == 0 then
					if not player:canCast(1, 1, 0) then
						return
					else
						if player.magic < magicCost then
							notEnoughMP(player)
							return
						else
							if player.ID == 943 or player.ID == 1086 or player.ID == 1369 then
								player:setAether("whispering_wind_4", 1000)
							else
								player:setAether("whispering_wind_4", delay)
							end
							whispering_wind_4.casted(player)
							broadcast(-1, "[" .. player.name .. "]: " .. text)
						end
					end
					return
				else
					broadcast(-1, "[" .. player.name .. "]: " .. text)
					whispering_wind_4.casted(player)
				end
			end
		end
	end,
	casted = function(player)
		player:sendAction(6, 20)
		player:playSound(112)
	end
}

whispering_wind_5 = {
	--level 100

	on_learn = function(player)
		player.registry["learned_whispering_wind_5"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_whispering_wind_5"] = 0
	end,
	cast = function(player)
		local magicCost, delay = 100, 180000
		local user = player:getUsers()
		local text = player.question
		local text2 = string.lower(player.question)

		if text ~= nil then
			if #user > 0 then
				if player.gmLevel == 0 then
					if not player:canCast(1, 1, 0) then
						return
					else
						if player.magic < magicCost then
							notEnoughMP(player)
							return
						else
							if player.ID == 943 or player.ID == 1086 or player.ID == 1369 then
								player:setAether("whispering_wind_5", 30000)
							else
								player:setAether("whispering_wind_5", delay)
							end
							whispering_wind_5.casted(player)
							broadcast(-1, "[" .. player.name .. "]: " .. text)
						end
					end
					return
				else
					broadcast(-1, "[" .. player.name .. "]: " .. text)
					whispering_wind_5.casted(player)
				end
			end
		end

		if player.quest["spec_shout"] == 1 then
			if text2 == "my sklemactochip 15a needs to be replaced" then
				player.quest["spec_shout"] = 2
				script_tester_3.shout(player, NPC(189))
			else
				script_tester_3.shoutFail(player, NPC(189))
			end
		end
	end,
	casted = function(player)
		player:sendAction(6, 20)
		player:playSound(112)
	end
}
