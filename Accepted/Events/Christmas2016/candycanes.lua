red_candycane = {
	use = function(player)
		local item = player:getInventoryItem(player.invSlot)
		local deadPC = getTargetFacing(player, BL_PC, 1)
		local duration = 15000
		local anim = 542
		local itemName = item.name
		if not player:canAction(1, 1, 1) then
			player:sendMinitext("You cannot do that right now!")
			return
		end
		if player:hasDuration("candycane") then
			failureAnim(player)
			delay = player:getDuration("candycane")

			player:sendMinitext("You need to wait " .. math.abs(delay / 1000) .. " seconds before eating another candycane")
			return
		end
		if player:hasItem(item.yname, 1) == true then
			if player:removeItemSlot(player.invSlot, 1) == true then
				player:sendAction(8, 20)
				player:sendAnimation(anim)
				player:sendAnimation(251)
				player:addHealth(player.maxHealth)
				player:sendMinitext("You ate a " .. itemName .. ". Yum!")
				player:setDuration("candycane", duration)
			end
		end
	end
}

blue_candycane = {
	use = function(player)
		local item = player:getInventoryItem(player.invSlot)
		local deadPC = getTargetFacing(player, BL_PC, 1)
		local duration = 15000
		local anim = 543
		local itemName = item.name
		if not player:canAction(1, 1, 1) then
			player:sendMinitext("You cannot do that right now!")
			return
		end
		if player:hasDuration("candycane") then
			failureAnim(player)
			delay = player:getDuration("candycane")

			player:sendMinitext("You need to wait " .. math.abs(delay / 1000) .. " seconds before eating another candycane")
			return
		end
		if player:hasItem(item.yname, 1) == true then
			if player:removeItemSlot(player.invSlot, 1) == true then
				player:sendAction(8, 20)
				player:sendAnimation(anim)
				player:sendAnimation(251)
				player:addMagic(player.maxMagic)
				player:sendMinitext("You ate a " .. itemName .. ". Yum!")
				player:setDuration("candycane", duration)
			end
		end
	end
}

green_candycane = {
	use = function(player)
		local item = player:getInventoryItem(player.invSlot)
		local deadPC = getTargetFacing(player, BL_PC, 1)
		local duration = 15000
		local anim = 540
		local itemName = item.name
		if not player:canAction(1, 1, 1) then
			player:sendMinitext("You cannot do that right now!")
			return
		end
		if player:hasDuration("candycane") then
			failureAnim(player)
			delay = player:getDuration("candycane")

			player:sendMinitext("You need to wait " .. math.abs(delay / 1000) .. " seconds before eating another candycane")
			return
		end
		if player:hasItem(item.yname, 1) == true then
			if player:removeItemSlot(player.invSlot, 1) == true then
				player:sendAction(8, 20)
				player:sendAnimation(anim)
				player:sendAnimation(251)
				player:sendMinitext("You ate a " .. itemName .. ". Yum!")
				candycane_cleave.cast(player)
				player:setDuration("candycane", duration)
			end
		end
	end
}
