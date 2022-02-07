beta_mount_box_ii = {
	use = function(player)
		local item = player:getInventoryItem(player.invSlot)

		local commonMount = {
			303102,
			303103,
			303104,
			303105,
			303106,
			303107,
			303108,
			303109,
			303110,
			303111,
			303112,
			303113,
			303114,
			303115
		} --doe, pink snake, brown ox, red ox, zebra, pig, brown bear
		local uncommonMount = {
			304102,
			304103,
			304104,
			304105,
			304106,
			304107,
			304108,
			304109,
			304110,
			304111,
			304112,
			304113,
			304114,
			304115
		} --panther, demon zebra, polar bear, yellow gama, red wolf, snow dog, rhino
		local rareMount = {
			305102,
			305103,
			305104,
			305105,
			305106,
			305107,
			305108,
			305109,
			305110,
			305111,
			305112,
			305113,
			305114,
			305115,
			305116,
			305117,
			305118,
			305119,
			305120,
			305121,
			305122
		} --purple goat, unitiger, b+w gama, bluerooster, lavascorpion, bat, charizard
		local epicMount = {305602, 305603} --nightmare tiger

		local rarityRoll = math.random(1, 100)
		local mountRoll = 0

		if not player:canAction(1, 1, 1) then
			player:sendMinitext("You cannot do that right now!")
			return
		end

		local rarity = ""

		if player:hasItem(item.yname, 1) == true then
			if player:removeItemSlot(player.invSlot, 1) == true then
				if rarityRoll <= 1 then
					mountRoll = math.random(1, #epicMount)
					mount = epicMount[mountRoll]
					broadcast(-1, "[INFO]: " .. player.name .. " has just opened an Epic Mount!")
					rarity = "[EPIC]"
					epicMountLegend(player)
					player.registry["epic_mount"] = player.registry["epic_mount"] + 1
				elseif rarityRoll >= 2 and rarityRoll <= 9 then
					mountRoll = math.random(1, #rareMount)
					mount = rareMount[mountRoll]
					rarity = "[RARE]"
				elseif rarityRoll >= 10 and rarityRoll <= 25 then
					mountRoll = math.random(1, #uncommonMount)
					mount = uncommonMount[mountRoll]
					rarity = "[UNCOMMON]"
				elseif rarityRoll >= 26 then
					mountRoll = math.random(1, #commonMount)
					mount = commonMount[mountRoll]
					rarity = "[COMMON]"
				end

				player:addItem(mount, 1)
				player:talk(0, "" .. player.name .. ": I got a " .. Item(mount).name .. " " .. rarity .. " !")
				player:sendMinitext("You opened up a " .. Item(mount).name .. " from the box!")
			end
		end
	end
}

beta_mount_box_three_ii = {
	use = function(player)
		local item = player:getInventoryItem(player.invSlot)

		if not player:canAction(1, 1, 1) then
			player:sendMinitext("You cannot do that right now!")
			return
		end
		if player:hasItem(item.yname, 1) == true then
			if player:removeItemSlot(player.invSlot, 1) == true then
				player:addItem(303004, 3)
				player:sendMinitext("You open the package and find 3 Beta Mount Boxes II!")
				finishedQuest(player)
			end
		end
	end
}

beta_mount_box_five_ii = {
	use = function(player)
		local item = player:getInventoryItem(player.invSlot)

		if not player:canAction(1, 1, 1) then
			player:sendMinitext("You cannot do that right now!")
			return
		end
		if player:hasItem(item.yname, 1) == true then
			if player:removeItemSlot(player.invSlot, 1) == true then
				player:addItem(303004, 5)
				player:sendMinitext("You open the package and find 5 Beta Mount Boxes II!")
				finishedQuest(player)
			end
		end
	end
}
