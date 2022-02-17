vending_ransel = {
	equip = function(player)
		player.registry["max_vending_slots"] = 5
		player:msg(
			0,
			"=== [Vending] Total sale items (" ..
				totalSaleItem(player) .. "/" .. player.registry["max_vending_slots"] .. ") - 'Press F1 for vending menu' ===",
			player.ID
		)
	end,
	while_equipped = function(player)
		player.registry["max_vending_slots"] = 5
	end
}

------------------------------------------------------------------------------------------------------------------------------------

vending_cart = {
	equip = function(player)
		player.registry["max_vending_slots"] = 10
		player:msg(
			0,
			"=== [Vending] Total sale items (" ..
				totalSaleItem(player) .. "/" .. player.registry["max_vending_slots"] .. ") - 'Press F1 for vending menu' ===",
			player.ID
		)
	end,
	while_equipped = function(player)
		player.registry["max_vending_slots"] = 10
	end
}

------------------------------------------------------------------------------------------------------------------------------------

vending_trolly = {
	equip = function(player)
		player.registry["max_vending_slots"] = 15
		player:msg(
			0,
			"=== [Vending] Total sale items (" ..
				totalSaleItem(player) .. "/" .. player.registry["max_vending_slots"] .. ") - 'Press F1 for vending menu' ===",
			player.ID
		)
	end,
	while_equipped = function(player)
		player.registry["max_vending_slots"] = 15
	end
}
