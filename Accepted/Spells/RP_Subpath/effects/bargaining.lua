bargaining = {
	cast = function(player)
	end,
	while_cast = function(player)
		--	player:sendAnimation(94)
	end,
	uncast = function(player)
		blackstrike_dragon.gold(player, NPC("Blackstrike"))
	end
}
