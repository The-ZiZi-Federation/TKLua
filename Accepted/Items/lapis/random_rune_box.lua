random_rune_box = {
	use = function(player)
		local item = player:getInventoryItem(player.invSlot)

		local basicRune = 6001
		local bloodyEnchantRune = 6050
		local eldritchEnchantRune = 6070

		local rollOne = math.random(1, 100)
		local rollTwo = math.random(1, 100)
		local rollThree = math.random(1, 100)

		--player:talk(0, "Rarity Roll: "..rarityRoll)
		--player:talk(0, "Mount Roll: "..mountRoll)

		if not player:canAction(1, 1, 1) then
			player:sendMinitext("You cannot do that right now!")
			return
		end

		if player:hasItem(item.yname, 1) == true then
			if player:removeItemSlot(player.invSlot, 1) == true then
				if rollOne >= 1 and rollOne <= 65 then
					runeOne = basicRune
				elseif rollOne >= 66 and rollOne <= 89 then
					runeOne = bloodyEnchantRune
				elseif rollOne >= 90 then
					runeOne = eldritchEnchantRune
				end
				player:addItem(runeOne, 1)
				player:sendMinitext("You opened up a " .. Item(runeOne).name .. " from the box!")

				if rollTwo >= 1 and rollTwo <= 65 then
					runeTwo = basicRune
				elseif rollTwo >= 66 and rollTwo <= 89 then
					runeTwo = bloodyEnchantRune
				elseif rollTwo >= 90 then
					runeTwo = eldritchEnchantRune
				end
				player:addItem(runeTwo, 1)
				player:sendMinitext("You opened up a " .. Item(runeTwo).name .. " from the box!")

				if rollThree >= 1 and rollThree <= 65 then
					runeThree = basicRune
				elseif rollThree >= 66 and rollThree <= 89 then
					runeThree = bloodyEnchantRune
				elseif rollThree >= 90 then
					runeThree = eldritchEnchantRune
				end
				player:addItem(runeThree, 1)
				player:sendMinitext("You opened up a " .. Item(runeThree).name .. " from the box!")
			end
		end
	end
}
