nightmare_epic_mount_box = {
	use = function(player)
		local item = player:getInventoryItem(player.invSlot)

		local mount = 305602 -- Nightmare Tiger

		if not player:canAction(1, 1, 1) then
			player:sendMinitext("You cannot do that right now!")
			return
		end

		if player:hasItem(item.yname, 1) == true then
			if player:removeItemSlot(player.invSlot, 1) == true then
				broadcast(-1, "[INFO]: " .. player.name .. " has just opened an Epic Mount!")
				epicMountLegend(player)
				player.registry["epic_mount"] = player.registry["epic_mount"] + 1
				player:addItem(mount, 1)
				player:talk(0, "" .. player.name .. ": I got a " .. Item(mount).name .. "!")
				player:sendMinitext("You opened up a " .. Item(mount).name .. " from the box!")
			end
		end
	end
}
