skin_dye_red = {
	use = function(player)
		local item = player:getInventoryItem(player.invSlot)
		local dyeColor = item.look

		if not player:canAction(1, 1, 1) then
			player:sendMinitext("You cannot do that right now!")
			return
		end

		if player:hasItem(item.yname, 1) == true then
			if player:removeItemSlot(player.invSlot, 1) == true then
				player:sendAction(10, 20)
				player:sendAnimation(2)
				player.skinColor = dyeColor
				player:updateState()
				player:sendMinitext("You have dyed your skin red!")
			end
		end
	end
}

skin_dye_green = {
	use = function(player)
		local item = player:getInventoryItem(player.invSlot)
		local dyeColor = item.look

		if not player:canAction(1, 1, 1) then
			player:sendMinitext("You cannot do that right now!")
			return
		end

		if player:hasItem(item.yname, 1) == true then
			if player:removeItemSlot(player.invSlot, 1) == true then
				player:sendAction(10, 20)
				player:sendAnimation(2)
				player.skinColor = dyeColor
				player:updateState()
				player:sendMinitext("You have dyed your skin green!")
			end
		end
	end
}

skin_dye_darkgreen = {
	use = function(player)
		local item = player:getInventoryItem(player.invSlot)
		local dyeColor = item.look

		if not player:canAction(1, 1, 1) then
			player:sendMinitext("You cannot do that right now!")
			return
		end

		if player:hasItem(item.yname, 1) == true then
			if player:removeItemSlot(player.invSlot, 1) == true then
				player:sendAction(10, 20)
				player:sendAnimation(2)
				player.skinColor = dyeColor
				player:updateState()
				player:sendMinitext("You have dyed your skin dark green!")
			end
		end
	end
}

skin_dye_blue = {
	use = function(player)
		local item = player:getInventoryItem(player.invSlot)
		local dyeColor = item.look

		if not player:canAction(1, 1, 1) then
			player:sendMinitext("You cannot do that right now!")
			return
		end

		if player:hasItem(item.yname, 1) == true then
			if player:removeItemSlot(player.invSlot, 1) == true then
				player:sendAction(10, 20)
				player:sendAnimation(2)
				player.skinColor = dyeColor
				player:updateState()
				player:sendMinitext("You have dyed your skin blue!")
			end
		end
	end
}

skin_dye_ancient = {
	use = function(player)
		local item = player:getInventoryItem(player.invSlot)
		local dyeColor = item.look

		if not player:canAction(1, 1, 1) then
			player:sendMinitext("You cannot do that right now!")
			return
		end

		if player:hasItem(item.yname, 1) == true then
			if player:removeItemSlot(player.invSlot, 1) == true then
				player:sendAction(10, 20)
				player:sendAnimation(2)
				player.skinColor = dyeColor
				player:updateState()
				player:sendMinitext("You have dyed your skin ancient!")
			end
		end
	end
}

skin_dye_blood = {
	use = function(player)
		local item = player:getInventoryItem(player.invSlot)
		local dyeColor = item.look

		if not player:canAction(1, 1, 1) then
			player:sendMinitext("You cannot do that right now!")
			return
		end

		if player:hasItem(item.yname, 1) == true then
			if player:removeItemSlot(player.invSlot, 1) == true then
				player:sendAction(10, 20)
				player:sendAnimation(2)
				player.skinColor = dyeColor
				player:updateState()
				player:sendMinitext("You have dyed your skin blood!")
			end
		end
	end
}

skin_dye_tan = {
	use = function(player)
		local item = player:getInventoryItem(player.invSlot)
		local dyeColor = item.look

		if not player:canAction(1, 1, 1) then
			player:sendMinitext("You cannot do that right now!")
			return
		end

		if player:hasItem(item.yname, 1) == true then
			if player:removeItemSlot(player.invSlot, 1) == true then
				player:sendAction(10, 20)
				player:sendAnimation(2)
				player.skinColor = dyeColor
				player:updateState()
				player:sendMinitext("You have dyed your skin tan!")
			end
		end
	end
}

skin_dye_earth = {
	use = function(player)
		local item = player:getInventoryItem(player.invSlot)
		local dyeColor = item.look

		if not player:canAction(1, 1, 1) then
			player:sendMinitext("You cannot do that right now!")
			return
		end

		if player:hasItem(item.yname, 1) == true then
			if player:removeItemSlot(player.invSlot, 1) == true then
				player:sendAction(10, 20)
				player:sendAnimation(2)
				player.skinColor = dyeColor
				player:updateState()
				player:sendMinitext("You have dyed your skin earth!")
			end
		end
	end
}
skin_dye_purple = {
	use = function(player)
		local item = player:getInventoryItem(player.invSlot)
		local dyeColor = item.look

		if not player:canAction(1, 1, 1) then
			player:sendMinitext("You cannot do that right now!")
			return
		end

		if player:hasItem(item.yname, 1) == true then
			if player:removeItemSlot(player.invSlot, 1) == true then
				player:sendAction(10, 20)
				player:sendAnimation(2)
				player.skinColor = dyeColor
				player:updateState()
				player:sendMinitext("You have dyed your skin purple!")
			end
		end
	end
}

skin_dye_murphy_blue = {
	use = function(player)
		local item = player:getInventoryItem(player.invSlot)
		local dyeColor = item.look

		if not player:canAction(1, 1, 1) then
			player:sendMinitext("You cannot do that right now!")
			return
		end

		if player:hasItem(item.yname, 1) == true then
			if player:removeItemSlot(player.invSlot, 1) == true then
				player:sendAction(10, 20)
				player:sendAnimation(2)
				player.skinColor = dyeColor
				player:updateState()
				player:sendMinitext("You have dyed your skin Murphy blue!")
			end
		end
	end
}

skin_dye_bronze = {
	use = function(player)
		local item = player:getInventoryItem(player.invSlot)
		local dyeColor = item.look

		if not player:canAction(1, 1, 1) then
			player:sendMinitext("You cannot do that right now!")
			return
		end

		if player:hasItem(item.yname, 1) == true then
			if player:removeItemSlot(player.invSlot, 1) == true then
				player:sendAction(10, 20)
				player:sendAnimation(2)
				player.skinColor = dyeColor
				player:updateState()
				player:sendMinitext("You have dyed your skin bronze!")
			end
		end
	end
}

skin_dye_black = {
	use = function(player)
		local item = player:getInventoryItem(player.invSlot)
		local dyeColor = item.look

		if not player:canAction(1, 1, 1) then
			player:sendMinitext("You cannot do that right now!")
			return
		end

		if player:hasItem(item.yname, 1) == true then
			if player:removeItemSlot(player.invSlot, 1) == true then
				player:sendAction(10, 20)
				player:sendAnimation(2)
				player.skinColor = dyeColor
				player:updateState()
				player:sendMinitext("You have dyed your skin black!")
			end
		end
	end
}

skin_dye_white = {
	use = function(player)
		local item = player:getInventoryItem(player.invSlot)
		local dyeColor = item.look

		if not player:canAction(1, 1, 1) then
			player:sendMinitext("You cannot do that right now!")
			return
		end

		if player:hasItem(item.yname, 1) == true then
			if player:removeItemSlot(player.invSlot, 1) == true then
				player:sendAction(10, 20)
				player:sendAnimation(2)
				player.skinColor = dyeColor
				player:updateState()
				player:sendMinitext("You have dyed your skin white!")
			end
		end
	end
}

skin_dye_dark_brown = {
	use = function(player)
		local item = player:getInventoryItem(player.invSlot)
		local dyeColor = item.look

		if not player:canAction(1, 1, 1) then
			player:sendMinitext("You cannot do that right now!")
			return
		end

		if player:hasItem(item.yname, 1) == true then
			if player:removeItemSlot(player.invSlot, 1) == true then
				player:sendAction(10, 20)
				player:sendAnimation(2)
				player.skinColor = dyeColor
				player:updateState()
				player:sendMinitext("You have dyed your skin dark brown!")
			end
		end
	end
}

skin_dye_fake_tan = {
	use = function(player)
		local item = player:getInventoryItem(player.invSlot)
		local dyeColor = item.look

		if not player:canAction(1, 1, 1) then
			player:sendMinitext("You cannot do that right now!")
			return
		end

		if player:hasItem(item.yname, 1) == true then
			if player:removeItemSlot(player.invSlot, 1) == true then
				player:sendAction(10, 20)
				player:sendAnimation(2)
				player.skinColor = dyeColor
				player:updateState()
				player:sendMinitext("You have dyed your skin fake tan!")
			end
		end
	end
}

skin_dye_wasabi = {
	use = function(player)
		local item = player:getInventoryItem(player.invSlot)
		local dyeColor = item.look

		if not player:canAction(1, 1, 1) then
			player:sendMinitext("You cannot do that right now!")
			return
		end

		if player:hasItem(item.yname, 1) == true then
			if player:removeItemSlot(player.invSlot, 1) == true then
				player:sendAction(10, 20)
				player:sendAnimation(2)
				player.skinColor = dyeColor
				player:updateState()
				player:sendMinitext("You have dyed your skin wasabi!")
			end
		end
	end
}

skin_dye_sickly_green = {
	use = function(player)
		local item = player:getInventoryItem(player.invSlot)
		local dyeColor = item.look

		if not player:canAction(1, 1, 1) then
			player:sendMinitext("You cannot do that right now!")
			return
		end

		if player:hasItem(item.yname, 1) == true then
			if player:removeItemSlot(player.invSlot, 1) == true then
				player:sendAction(10, 20)
				player:sendAnimation(2)
				player.skinColor = dyeColor
				player:updateState()
				player:sendMinitext("You have dyed your skin sickly green!")
			end
		end
	end
}

skin_dye_hon = {
	use = function(player)
		local item = player:getInventoryItem(player.invSlot)
		local dyeColor = item.look

		if not player:canAction(1, 1, 1) then
			player:sendMinitext("You cannot do that right now!")
			return
		end

		if player:hasItem(item.yname, 1) == true then
			if player:removeItemSlot(player.invSlot, 1) == true then
				player:sendAction(10, 20)
				player:sendAnimation(2)
				player.skinColor = dyeColor
				player:updateState()
				player:sendMinitext("You have dyed your skin the Hon Flag's color!")
			end
		end
	end
}
