ice_palace_keys = {
	melt = function(player)
		local m = player.m

		if player:hasItem("ice_palace_key_armory", 1) == true then
			player:removeItem("ice_palace_key_armory", 52)
			player:sendMinitext("Your Armory Key melted!")
		end

		if player:hasItem("ice_palace_key_treasury", 1) == true then
			player:removeItem("ice_palace_key_treasury", 52)
			player:sendMinitext("Your Treasury Key melted!")
		end

		if player:hasItem("ice_palace_key_throne_hall", 1) == true then
			player:removeItem("ice_palace_key_throne_hall", 52)
			player:sendMinitext("Your Throne Hall Key melted!")
		end
	end
}

ice_palace_key_armory = {
	--KEY A

	use = function(player)
		local m = player.m
		local x = player.x
		local y = player.y
		local s = player.side
		local item = player:getInventoryItem(player.invSlot)

		if m == 4153 then
			if ((x == 26 or x == 27) and y == 7 and s == 0) then --facing Door A
				player:sendMinitext("You unlock the door using the " .. item.name .. ".")
				setObject(m, 26, 6, 753) --753 = left door open
				setObject(m, 27, 6, 754) --754 = right door open
				setPass(m, 26, 6, 0)
				setPass(m, 27, 6, 0)
				core.gameRegistry["ice_palace_key_armory_1"] = os.time() + 30
			elseif ((x == 5 or x == 6) and y == 3 and s == 0) then --facing Door C
				player:sendMinitext("It doesn't fit.")
			elseif ((x == 8 or x == 9) and y == 7 and s == 0) then --facing Door D
				player:sendMinitext("It doesn't fit.")
			else
				player:talkSelf(0, player.name .. ": I can't use this here.a")
			end
		elseif m == 4172 then
			if ((x == 26 or x == 27) and y == 7 and s == 0) then --facing Door A
				player:sendMinitext("You unlock the door using the " .. item.name .. ".")
				setObject(m, 26, 6, 753) --753 = left door open
				setObject(m, 27, 6, 754) --754 = right door open
				setPass(m, 26, 6, 0)
				setPass(m, 27, 6, 0)
				core.gameRegistry["ice_palace_key_armory_2"] = os.time() + 30
			elseif ((x == 5 or x == 6) and y == 3 and s == 0) then --facing Door C
				player:sendMinitext("It doesn't fit.")
			elseif ((x == 8 or x == 9) and y == 7 and s == 0) then --facing Door D
				player:sendMinitext("It doesn't fit.")
			else
				player:talkSelf(0, player.name .. ": I can't use this here.c")
			end
		else
			player:talkSelf(0, player.name .. ": I can't use this here.d")
		end
	end,
	auto_1 = function()
		local m = 4153

		if core.gameRegistry["ice_palace_key_armory_1"] > 0 and core.gameRegistry["ice_palace_key_armory_1"] < os.time() then
			setObject(m, 26, 6, 338) --338 = left door closed
			setObject(m, 27, 6, 339) --339 = right door closed
			setPass(m, 26, 6, 1)
			setPass(m, 27, 6, 1)
			core.gameRegistry["ice_palace_key_armory_1"] = 0
		end
	end,
	auto_2 = function()
		local m = 4172

		if core.gameRegistry["ice_palace_key_armory_2"] > 0 and core.gameRegistry["ice_palace_key_armory_2"] < os.time() then
			setObject(m, 26, 6, 338) --338 = left door closed
			setObject(m, 27, 6, 339) --339 = right door closed
			setPass(m, 26, 6, 1)
			setPass(m, 27, 6, 1)
			core.gameRegistry["ice_palace_key_armory_2"] = 0
		end
	end
}

ice_palace_key_treasury = {
	--KEY C
	use = function(player)
		local m = player.m
		local x = player.x
		local y = player.y
		local s = player.side
		local item = player:getInventoryItem(player.invSlot)

		if m == 4153 then
			if ((x == 26 or x == 27) and y == 7 and s == 0) then --facing Door A
				player:sendMinitext("It doesn't fit.")
			elseif ((x == 5 or x == 6) and y == 3 and s == 0) then --facing Door C
				player:sendMinitext("You unlock the door using the " .. item.name .. ".")
				setObject(m, 5, 2, 753) --753 = left door open
				setObject(m, 6, 2, 754) --754 = right door open
				setPass(m, 5, 2, 0)
				setPass(m, 6, 2, 0)
				core.gameRegistry["ice_palace_key_treasury_1"] = os.time() + 30
			elseif ((x == 8 or x == 9) and y == 7 and s == 0) then --facing Door D
				player:sendMinitext("It doesn't fit.")
			else
				player:talkSelf(0, player.name .. ": I can't use this here.")
			end
		elseif m == 4172 then
			if ((x == 26 or x == 27) and y == 7 and s == 0) then --facing Door A
				player:sendMinitext("It doesn't fit.")
			elseif ((x == 5 or x == 6) and y == 3 and s == 0) then --facing Door C
				player:sendMinitext("You unlock the door using the " .. item.name .. ".")
				setObject(m, 5, 2, 753) --753 = left door open
				setObject(m, 6, 2, 754) --754 = right door open
				setPass(m, 5, 2, 0)
				setPass(m, 6, 2, 0)
				core.gameRegistry["ice_palace_key_treasury_2"] = os.time() + 30
			elseif ((x == 8 or x == 9) and y == 7 and s == 0) then --facing Door D
				player:sendMinitext("It doesn't fit.")
			else
				player:talkSelf(0, player.name .. ": I can't use this here.")
			end
		else
			player:talkSelf(0, player.name .. ": I can't use this here.")
		end
	end,
	auto_1 = function()
		local m = 4153

		if core.gameRegistry["ice_palace_key_treasury_1"] > 0 and core.gameRegistry["ice_palace_key_treasury_1"] < os.time() then
			setObject(m, 5, 2, 338) --338 = left door closed
			setObject(m, 6, 2, 339) --339 = right door closed
			setPass(m, 5, 2, 1)
			setPass(m, 6, 2, 1)
			core.gameRegistry["ice_palace_key_treasury_1"] = 0
		end
	end,
	auto_2 = function()
		local m = 4172

		if core.gameRegistry["ice_palace_key_treasury_2"] > 0 and core.gameRegistry["ice_palace_key_treasury_2"] < os.time() then
			setObject(m, 5, 2, 338) --338 = left door closed
			setObject(m, 6, 2, 339) --339 = right door closed
			setPass(m, 5, 2, 1)
			setPass(m, 6, 2, 1)
			core.gameRegistry["ice_palace_key_treasury_2"] = 0
		end
	end
}

ice_palace_key_throne_hall = {
	--KEY D

	use = function(player)
		local m = player.m
		local x = player.x
		local y = player.y
		local s = player.side
		local item = player:getInventoryItem(player.invSlot)

		if m == 4153 then
			if ((x == 26 or x == 27) and y == 7 and s == 0) then --facing Door A
				player:sendMinitext("It doesn't fit.")
			elseif ((x == 5 or x == 6) and y == 3 and s == 0) then --facing Door C
				player:sendMinitext("It doesn't fit.")
			elseif ((x == 8 or x == 9) and y == 7 and s == 0) then --facing Door D
				player:sendMinitext("You unlock the door using the " .. item.name .. ".")
				setObject(m, 8, 6, 753) --753 = left door open
				setObject(m, 9, 6, 754) --754 = right door open
				setPass(m, 8, 6, 0)
				setPass(m, 9, 6, 0)
				core.gameRegistry["ice_palace_key_throne_hall_1"] = os.time() + 30
			else
				player:talkSelf(0, player.name .. ": I can't use this here.")
			end
		elseif m == 4172 then
			if ((x == 26 or x == 27) and y == 7 and s == 0) then --facing Door A
				player:sendMinitext("It doesn't fit.")
			elseif ((x == 5 or x == 6) and y == 3 and s == 0) then --facing Door C
				player:sendMinitext("It doesn't fit.")
			elseif ((x == 8 or x == 9) and y == 7 and s == 0) then --facing Door D
				player:sendMinitext("You unlock the door using the " .. item.name .. ".")
				setObject(m, 8, 6, 753) --753 = left door open
				setObject(m, 9, 6, 754) --754 = right door open
				setPass(m, 8, 6, 0)
				setPass(m, 9, 6, 0)
				core.gameRegistry["ice_palace_key_throne_hall_2"] = os.time() + 30
			else
				player:talkSelf(0, player.name .. ": I can't use this here.")
			end
		else
			player:talkSelf(0, player.name .. ": I can't use this here.")
		end
	end,
	auto_1 = function()
		local m = 4153

		if
			core.gameRegistry["ice_palace_key_throne_hall_1"] > 0 and
				core.gameRegistry["ice_palace_key_throne_hall_1"] < os.time()
		 then
			setObject(m, 8, 6, 338) --338 = left door closed
			setObject(m, 9, 6, 339) --339 = right door closed
			setPass(m, 8, 6, 1)
			setPass(m, 9, 6, 1)
			core.gameRegistry["ice_palace_key_throne_hall_1"] = 0
		end
	end,
	auto_2 = function()
		local m = 4172

		if
			core.gameRegistry["ice_palace_key_throne_hall_2"] > 0 and
				core.gameRegistry["ice_palace_key_throne_hall_2"] < os.time()
		 then
			setObject(m, 8, 6, 338) --338 = left door closed
			setObject(m, 9, 6, 339) --339 = right door closed
			setPass(m, 8, 6, 1)
			setPass(m, 9, 6, 1)
			core.gameRegistry["ice_palace_key_throne_hall_2"] = 0
		end
	end
}
