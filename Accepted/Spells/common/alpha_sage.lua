alpha_sage = {
	on_learn = function(player)
		player.registry["learned_alpha_sage"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_alpha_sage"] = 0
	end,
	cast = function(player)
		local magicCost, delay = 100, 60000
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
							player:setAether("alpha_sage", delay)
							alpha_sage.casted(player)
							broadcast(-1, "[" .. player.name .. "]: " .. text)
						end
					end
					return
				else
					broadcast(-1, "[" .. player.name .. "]: " .. text)
					alpha_sage.casted(player)
				end
			end
		end
	end,
	casted = function(player)
		player:sendAction(6, 20)
		player:playSound(20)
	end
}
