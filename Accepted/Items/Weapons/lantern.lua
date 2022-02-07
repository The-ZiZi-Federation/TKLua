lantern = {
	equip = function(player)
		player.registry["equipped_lantern"] = 1
		player:sendAnimation(135, 50)
	end,
	unequip = function(player)
		player.registry["equipped_lantern"] = 0
	end
}
