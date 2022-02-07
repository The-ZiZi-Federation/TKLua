gambling_chip = {
	use = function(player)
		local m, x, y = player.m, player.x, player.y
		local sound = 513

		local item = player:getInventoryItem(player.invSlot)
		local objects = player:getObjectsInCell(m, x, y, BL_ITEM)
		local oldspent = player.registry["Gambling_spent"]

		--if not player:canAction(1, 1, 1) then
		--	player:sendMinitext("You cannot do that right now!")
		--	return
		--end

		if not player.mapTitle == "Roulette" and not player.mapTitle == "Racetrack" then
			player:talkSelf(0, "Please visit either the Roulette room or the Racetrack to use your gambling chips.")
			return
		end

		if #objects > 0 then
			player:talkSelf(0, "You are not allowed to stack a chip onto another player's. Please choose a different spot.")
			return
		end

		if (player.x >= 4 and player.x <= 10 and player.y >= 6 and player.y <= 12 and player.m == 1041) then -- ROULETTE HIGH STAKES TABLE
			if player:hasItem(item.yname, 1) then
				if item.price < 25000 then
					player:talkSelf(0, "You must place at least a 25k or higher bet on this table. Min bet = 25k")
					return
				end

				if (player.registry["Gamble_Table2"] == 1 and player.gmLevel == 0) then
					player:talkSelf(0, "You have already placed the maximum number of bets for this table")
					return
				end

				if item.price == 250000 then
					if not player:hasLegend("Hi_Roller") then
						player:addLegend("High roller", "Hi_Roller", 20, 14)
					end
				end

				player:playSound(sound)
				player:addNPC("gambling_chip", m, x, y, 1000, 120000, player.ID)
				player.registry["Gambling_spent"] = player.registry["Gambling_spent"] + item.price
				player:dropItemXY(item.id, 1, m, x, y, player.ID)
				player:removeItemSlot(player.invSlot, 1)
				player.registry["Gamble_Table2"] = 1

				player:talkSelf(0, "You have placed your chip at X: " .. player.x .. " Y: " .. player.y)

				gambling_chip.vip_check(player)
				gambling_titles.grantTitle(player)
			end
		elseif (player.x >= 6 and player.x <= 10 and player.y >= 17 and player.y <= 21 and player.m == 1041) then -- ROULETTE LOW STAKES TABLE
			if player:hasItem(item.yname, 1) == true then
				if item.price > 10000 then
					player:talkSelf(0, "You cannot place higher than a 10k bet on this table. Max bet = 10k")
					return
				end

				if (player.registry["Gamble_Table1"] == 1 and player.gmLevel == 0) then
					player:talkSelf(0, "You have already placed the maximum number of bets for this table")
					return
				end

				player:playSound(sound)
				player:addNPC("gambling_chip", m, x, y, 1000, 120000, player.ID)
				player.registry["Gambling_spent"] = player.registry["Gambling_spent"] + item.price
				player:dropItemXY(item.id, 1, m, x, y, player.ID)
				player:removeItemSlot(player.invSlot, 1)
				player.registry["Gamble_Table1"] = 1

				player:talkSelf(0, "You have placed your chip at X: " .. player.x .. " Y: " .. player.y)

				gambling_chip.vip_check(player)
				gambling_titles.grantTitle(player)
			end
		elseif player.m == 1042 then ----  on Racetrack MAP
			player:talkSelf(0, "You must place your bet via the NPC at the racetrack.")
		else
			player:talkSelf(0, "You cannot place your bets outside the bounds of the Table")
			return
		end
	end,
	vip_check = function(player)
		if player.registry["Gambling_spent"] >= 3000000 and player.registry["vip_status_notification"] == 0 then
			player:popUp(
				"Congratulations " ..
					player.name ..
						"! You have just attained VIP Status.\nThis status allows you to enter the VIP club at the top of the room, as well as being granted an exclusive casino teleportation spell."
			)
			player.registry["vip_status_notification"] = 1
			player.registry["Gambling_VIP"] = 1

			if not player:hasLegend("Gambling_VIP") then
				player:addLegend("Casino VIP", "Gambling_VIP", 30, 2)
			end
		end
	end,
	on_spawn = function(npc)
		local m, x, y = npc.m, npc.x, npc.y
		local player = core:getObjectsInMap(m, BL_PC)

		if #player > 0 then
			player[1]:sendAnimationXY(599, x, y)
		end
	end
}
