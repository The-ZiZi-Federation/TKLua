farming = {
	watering = function(player)
		local seedname = {"wheat_seed", "green_bean_seed", "chili_seed", "pumpkin_seed", "carrot_seed"}
		local m, x, y = player.m, player.x, player.y
		local weap = player:getEquippedItem(EQ_WEAP)
		local tile = farming.getFrontTile(player)
		local seed = getTargetFacing(player, BL_ITEM)

		if weap ~= nil and weap.yname == "watering_can" then
		end
	end,
	onDrop = function(player, item)
		local seed = {"wheat_seed", "green_bean_seed", "chili_seed", "pumpkin_seed", "carrot_seed"}
		local m, x, y = player.m, player.x, player.y
		local plant = false

		if player.m == 68 then
			for i = 1, #seed do
				if item.yname == seed[i] then
					if getTile(m, x, y) == 177 then
						player:sendAnimationXY(228, x, y)
						player:playSound(6)
					end
				end
			end
		end
	end,
	swing = function(player)
		local shovel = {"wooden_shovel", "bronze_shovel", "silver_shovel", "golden_shovel"}
		local duration = {11000, 8000, 4000, 1000}
		local weap = player:getEquippedItem(EQ_WEAP)
		local front = getTargetFacing(player, BL_MOB)
		local tile = farming.getFrontTile(player)
		local max = 10

		if player.m == 68 then
			if weap ~= nil then
				for i = 1, #shovel do
					if weap.yname == shovel[i] then
						if not player:canAction(1, 1, 1) then
							return
						else
							if not player:canCast(1, 1, 0) then
								return
							else
								--	end
								--	if player.registry["farming_energy"] >= max then
								--		player:sendAnimation(246)
								--		player:sendMinitext("You need more energy to do that")
								--	return else
								--		player.registry["farming_energy"] = player.registry["farming_energy"] + 1
								if front ~= nil then
									player:sendAnimation(246)
									return
								else
									if tile == 199 then
										if not player:hasDuration("farming") then
											if player.registry["farming_level"] == 0 then
												player.registry["farming_level"] = 1
												if player:hasLegend("beginner_farming") then
													player:removeLegendbyName("beginner_farming")
												end
												player:addLegend("Beginner on farming", "beginner_farming", 1, 108)
												player:sendMinitext("You learned & beginner on farming.")
											end
											player:setDuration("farming", duration[i])
										end
									end
								end
							end
						end
					end
				end
				if weap.yname == "watering_can" then
					if tile == 177 then
						player:playSound(370)
						farming.leveling(player, 10)
						player:sendFrontAnimation(347, player.side, 1)
						farming.setFrontTile(player, 1528)
					end
				end
			end
		end
	end,
	while_cast = function(player)
		player:sendAnimation(315)
		player:sendAction(28, 250)
	end,
	while_cast_250 = function(player)
		local tile = farming.getFrontTile(player)
		local mob = getTargetFacing(player, BL_MOB)
		local weap = player:getEquippedItem(EQ_WEAP)
		local shovel = {"wooden_shovel", "bronze_shovel", "silver_shovel", "golden_shovel"}
		local x = {2, 4, 6, 10}
		local chance = 0
		local process = player.registry["farming_process"]

		if player.m ~= 68 then
			player:sendAnimation(246)
			player:setDuration("farming", 0)
			return
		else
			if weap == nil then
				player:sendAnimation(246)
				player:setDuration("farming", 0)
				player:sendMinitext("You lack the proper tools.")
				return
			else
				for i = 1, #shovel do
					if not weap.yname == shovel[i] then
						player:sendAnimation(246)
						player:setDuration("farming", 0)
						player:sendMinitext("You seem to have misplaced your tool.")
						return
					else
						if mob ~= nil or tile ~= 199 then
							player:sendAnimation(246)
							player:setDuration("farming", 0)
							player:sendMinitext("This does not look like a good place to farm.")
						end
					end
				end
			end
		end
	end,
	walk = function(player)
		if player:hasDuration("farming") then
			player:sendAnimation(246)
			player:flushDurationNoUncast(67, 67)
		end
	end,
	uncast = function(player)
		local m, x, y = player.m, player.x, player.y
		local weap = player:getEquippedItem(EQ_WEAP)
		local chance = math.random(0, 20)
		local shovel = {"wooden_shovel", "bronze_shovel", "silver_shovel", "golden_shovel"}

		if player.m ~= 68 then
			player:sendAnimation(246)
			player.registry["farming_process"] = 0
			player:playSound(118)
			return
		else
			if player.side == 0 then
				y = y - 1
			end
			if player.side == 1 then
				x = x + 1
			end
			if player.side == 2 then
				y = y + 1
			end
			if player.side == 3 then
				x = x - 1
			end
			player:sendAction(1, 20)
			if farming.getFrontTile(player) == 199 then
				if getTargetFacing(player, BL_MOB) == nil then
					if chance <= 2 then
						player:dropItemXY(Item("ginseng").id, 1, m, x, y, player.ID)
					end
					player:sendFrontAnimation(133, player.side, 1)
					player:playSound(112)
					farming.setFrontTile(player, 177)
					farming.leveling(player, 10)
				end
			end
		end
	end,
	getFrontTile = function(player)
		if player.side == 0 then
			return getTile(player.m, player.x, player.y - 1)
		end
		if player.side == 1 then
			return getTile(player.m, player.x + 1, player.y)
		end
		if player.side == 2 then
			return getTile(player.m, player.x, player.y + 1)
		end
		if player.side == 3 then
			return getTile(player.m, player.x - 1, player.y)
		end
	end,
	setFrontTile = function(player, tile)
		if player.side == 0 then
			setTile(player.m, player.x, player.y - 1, tile)
		end
		if player.side == 1 then
			setTile(player.m, player.x + 1, player.y, tile)
		end
		if player.side == 2 then
			setTile(player.m, player.x, player.y + 1, tile)
		end
		if player.side == 3 then
			setTile(player.m, player.x - 1, player.y, tile)
		end
	end,
	getLevelName = function(player)
		if player.registry["farming_level"] == 1 then
			return "Beginner"
		end -- because of we have a class/job name "novice", maybe we'll use beginner?  Sure, and for Journeyman, change to Adept.ok
		if player.registry["farming_level"] == 2 then
			return "Experienced"
		end
		if player.registry["farming_level"] == 3 then
			return "Adept"
		end
		if player.registry["farming_level"] == 4 then
			return "Seasoned"
		end
		if player.registry["farming_level"] == 5 then
			return "Expert"
		end
		if player.registry["farming_level"] == 6 then
			return "Professional"
		end
		if player.registry["farming_level"] == 7 then
			return "Master"
		end
		if player.registry["farming_level"] == 8 then
			return "Grandmaster"
		end
		if player.registry["farming_level"] == 9 then
			return "Legendary"
		end --thx :)
	end,
	 --
	--[[
leveling = function(player)	-- this not working well.. no, it needs more exp giver, like when plant seed, when clear rock, or dead plant. yes
	
	local level = {0,1,2,3,4,5,6,7,8}
	local name = {"Beginner", "Experienced", "Adept", "Seasoned", "Expert", "Professional", "Master", "Grandmaster", "Legendary"}	--9 ok
	local tnl = {200, 6000, 22000, 220000, 750000, 2200000, 10000000, 35000000, 75000000}		-- 9
	local exp = {10, 25, 50, 100, 150, 200, 300, 400, 500}
	local x, cur = 0, player.registry["farming_exp"]
	
	for i = 1, #name do
		if farming.getLevelName(player) == name[i] and player.registry["farming_level"] == level[i] then x = i break end
	end
	if x == 0 then return false else
		if cur > tnl[x] then
			player.registry["farming_level"] = level[x+1]
			player:sendMinitext(0, "You are farming"[x+1].." on Farming now!")
			player:playSound(123)
			player:sendAnimation(254)
		return else
			player.registry["farming_exp"] = player.registry["farming_exp"] + exp[x]
			player:sendMinitext("Gained "..exp[x].." Farming exp! (Tnl: "..format_number(math.floor(tnl[x]-cur))..")")
		end
	end
end,
]] menu = function(
		player,
		npc)
		player.dialogType = 2
		local opts = {}
		table.insert(opts, "Level : " .. farming.getLevelName(player))
		table.insert(opts, "To Next Level : " .. farming.getTnl(player))
		table.insert(opts, "Energy : ")
		table.insert(opts, "Exit")

		menu = player:menuString("<b>[Character's Info]\n\n", opts)

		if menu ~= nil then
			if menu == "Exit" then
				return
			else
				farming.menu(player, npc)
			end
		end
	end,
	leveling = function(player, get)
		local level, exp = player.registry["farming_level"], player.registry["farming_exp"]
		local class = {
			"Beginner",
			"Experienced",
			"Adept",
			"Seasoned",
			"Expert",
			"Professional",
			"Master",
			"Grandmaster",
			"Legendary"
		}
		local tnltable = {200, 6000, 22000, 220000, 750000, 2200000, 10000000, 35000000, 75000000}
		local get = math.abs(tonumber(get))
		local name, icon, found = "", 0, 0

		for i = 1, #class do
			if farming.getLevelName(player) == class[i] then
				found = i
				break
			end
		end
		if found == 0 then
			return false
		else
			if exp < tnltable[found] then
				player.registry["farming_exp"] = player.registry["farming_exp"] + get
				player:sendMinitext("Get " .. get .. " farming exp (" .. format_number(tnltable[found] - exp) .. ")")
				return
			else
				player.registry["farming_level"] = player.registry["farming_level"] + 1
				if player:hasLegend(string.lower(class[found] .. "_farming")) then
					player:removeLegendbyName(string.lower(class[found] .. "_farming"))
				end
				player:addLegend(class[found + 1] .. " on farming", string.lower(class[found + 1] .. "_farming"), 1, 108)
				player.registry["farming_exp"] = 0
				finishedQuest(player)
				player:sendMinitext("You're " .. class[found] .. " on farming now!")
			end
		end
	end
}

--	   200 sp Amateur to Novice
--    6000 sp from Novice to Experienced
--    22000 sp from Experienced to Journeyman
--    270,000 sp from journeyman to Seasoned
--    900,000 sp from Seasoned to Expert
--    2.8 m sp from Expert to Professional
--    12 m sp from Professional to Master
--    49 m sp from Master to Grandmaster
--    81 m sp from Grandmaster to Legendary
