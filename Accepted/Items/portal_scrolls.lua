hon_scroll = {
	use = function(player)
		local item = player:getInventoryItem(player.invSlot)
		local anim = 16

		if not player:canAction(1, 1, 1) then
			player:sendMinitext("You cannot do that right now!")
			return
		end

		if player:hasItem(item.yname, 1) == true then
			player:removeItemSlot(player.invSlot, 1)
			player:warp(1018, math.random(18, 21), math.random(6, 10))
			player:sendAnimation(anim)
			player:sendAction(6, 20)
			player:sendMinitext("You return to Hon by the Sea")
		end
	end
}

lortz_scroll = {
	use = function(player)
		local item = player:getInventoryItem(player.invSlot)
		local anim = 16

		if not player:canAction(1, 1, 1) then
			player:sendMinitext("You cannot do that right now!")
			return
		end

		if player.registry["lortz_village_eye"] == 0 then
			player:removeItemSlot(player.invSlot, 1)
			player:sendMinitext("You are unable to form a mental image of your destination")
			return
		end

		if player:hasItem(item.yname, 1) == true then
			player:removeItemSlot(player.invSlot, 1)
			player:warp(3002, math.random(2, 9), math.random(3, 10))
			player:sendAnimation(anim)
			player:sendAction(6, 20)
			player:sendMinitext("You return to Lortz")
		end
	end
}

cathay_scroll = {
	use = function(player)
		local item = player:getInventoryItem(player.invSlot)
		local anim = 16

		if not player:canAction(1, 1, 1) then
			player:sendMinitext("You cannot do that right now!")
			return
		end

		if player.registry["cathay_city_eye"] == 0 then
			player:removeItemSlot(player.invSlot, 1)
			player:sendMinitext("You are unable to form a mental image of your destination")
			return
		end

		if player:hasItem(item.yname, 1) == true then
			player:removeItemSlot(player.invSlot, 1)
			player:warp(4067, math.random(2, 7), math.random(4, 9))
			player:sendAnimation(anim)
			player:sendAction(6, 20)
			player:sendMinitext("You return to Cathay")
		end
	end
}
