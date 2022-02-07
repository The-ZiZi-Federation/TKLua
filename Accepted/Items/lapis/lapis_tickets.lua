lapis_ticket_100 = {
	use = function(player)
		local item = player:getInventoryItem(player.invSlot)
		local r = math.random(1, 400)
		local speech = ""

		if not player:canAction(1, 1, 1) then
			player:sendMinitext("You cannot do that right now!")
			return
		end

		if r >= 1 and r <= 100 then
			speech = "I love the GMs!"
		elseif r >= 101 and r <= 200 then
			if player.registry["good_karma"] > player.registry["bad_karma"] then
				speech = "All hail ASAK!"
			elseif player.registry["bad_karma"] > player.registry["good_karma"] then
				speech = "All hail SKOTOS!"
			else
				speech = "All hail The Almighty Dollar!"
			end
		elseif r >= 201 and r <= 300 then
			speech = "Shh... someone is watching..."
		elseif r >= 301 and r <= 400 then
			speech = "I wonder what the GMs are doing with my money..."
		end

		if player:hasItem(item.yname, 1) == true then
			if player:removeItemSlot(player.invSlot, 1) == true then
				player:sendAction(10, 20)
				player:sendAnimation(2)
				player:addLapis(100)
				player:sendMinitext("You gain 100 Lapis Lazuli!")
				player:talk(0, "" .. player.name .. ": " .. speech)
			end
		end
	end
}

lapis_ticket_500 = {
	use = function(player)
		local item = player:getInventoryItem(player.invSlot)
		local r = math.random(1, 4)
		local speech = ""

		if not player:canAction(1, 1, 1) then
			player:sendMinitext("You cannot do that right now!")
			return
		end

		if r == 1 then
			speech = "I love the GMs!"
		elseif r == 2 then
			if player.registry["good_karma"] > player.registry["bad_karma"] then
				speech = "All hail ASAK!"
			elseif player.registry["bad_karma"] > player.registry["good_karma"] then
				speech = "All hail SKOTOS!"
			else
				speech = "All hail The Almighty Dollar!"
			end
		elseif r == 3 then
			speech = "Shh... someone is watching..."
		elseif r == 4 then
			speech = "I wonder what the GMs are doing with my money..."
		end

		if player:hasItem(item.yname, 1) == true then
			if player:removeItemSlot(player.invSlot, 1) == true then
				player:sendAction(10, 20)
				player:sendAnimation(2)
				player:addLapis(500)
				player:sendMinitext("You gain 500 Lapis Lazuli!")
				player:talk(0, "" .. player.name .. ": " .. speech)
			end
		end
	end
}

lapis_ticket_1000 = {
	use = function(player)
		local item = player:getInventoryItem(player.invSlot)
		local r = math.random(1, 4)
		local speech = ""

		if not player:canAction(1, 1, 1) then
			player:sendMinitext("You cannot do that right now!")
			return
		end

		if r == 1 then
			speech = "I love the GMs!"
		elseif r == 2 then
			if player.registry["good_karma"] > player.registry["bad_karma"] then
				speech = "All hail ASAK!"
			elseif player.registry["bad_karma"] > player.registry["good_karma"] then
				speech = "All hail SKOTOS!"
			else
				speech = "All hail The Almighty Dollar!"
			end
		elseif r == 3 then
			speech = "Shh... someone is watching..."
		elseif r == 4 then
			speech = "I wonder what the GMs are doing with my money..."
		end

		if player:hasItem(item.yname, 1) == true then
			if player:removeItemSlot(player.invSlot, 1) == true then
				player:sendAction(10, 20)
				player:sendAnimation(2)
				player:addLapis(1000)
				player:sendMinitext("You gain 1000 Lapis Lazuli!")
				player:talk(0, "" .. player.name .. ": " .. speech)
			end
		end
	end
}

lapis_ticket_2500 = {
	use = function(player)
		local item = player:getInventoryItem(player.invSlot)
		local r = math.random(1, 4)
		local speech = ""

		if not player:canAction(1, 1, 1) then
			player:sendMinitext("You cannot do that right now!")
			return
		end

		if r == 1 then
			speech = "I love the GMs!"
		elseif r == 2 then
			if player.registry["good_karma"] > player.registry["bad_karma"] then
				speech = "All hail ASAK!"
			elseif player.registry["bad_karma"] > player.registry["good_karma"] then
				speech = "All hail SKOTOS!"
			else
				speech = "All hail The Almighty Dollar!"
			end
		elseif r == 3 then
			speech = "Shh... someone is watching..."
		elseif r == 4 then
			speech = "I wonder what the GMs are doing with my money..."
		end

		if player:hasItem(item.yname, 1) == true then
			if player:removeItemSlot(player.invSlot, 1) == true then
				player:sendAction(10, 20)
				player:sendAnimation(2)
				player:addLapis(2500)
				player:sendMinitext("You gain 2500 Lapis Lazuli!")
				player:talk(0, "" .. player.name .. ": " .. speech)
			end
		end
	end
}

lapis_ticket_10000 = {
	use = function(player)
		local item = player:getInventoryItem(player.invSlot)
		local r = math.random(1, 4)
		local speech = ""

		if not player:canAction(1, 1, 1) then
			player:sendMinitext("You cannot do that right now!")
			return
		end

		if r == 1 then
			speech = "I love the GMs!"
		elseif r == 2 then
			if player.registry["good_karma"] > player.registry["bad_karma"] then
				speech = "All hail ASAK!"
			elseif player.registry["bad_karma"] > player.registry["good_karma"] then
				speech = "All hail SKOTOS!"
			else
				speech = "All hail The Almighty Dollar!"
			end
		elseif r == 3 then
			speech = "Shh... someone is watching..."
		elseif r == 4 then
			speech = "I wonder what the GMs are doing with my money..."
		end

		if player:hasItem(item.yname, 1) == true then
			if player:removeItemSlot(player.invSlot, 1) == true then
				player:sendAction(10, 20)
				player:sendAnimation(2)
				player:addLapis(10000)
				player:sendMinitext("You gain 10000 Lapis Lazuli!")
				player:talk(0, "" .. player.name .. ": " .. speech)
			end
		end
	end
}
