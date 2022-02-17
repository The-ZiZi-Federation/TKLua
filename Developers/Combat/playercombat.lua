player_combat = {
	on_healed = function(player, healer)
		--	player.attacker = healer.ID
		--	player:sendHealth(healer.damage, healer.critChance)
	end,
	on_attacked = function(player, attacker)
		if player:hasDuration("sacrifice") then
			sacrifice.being_hit(player, attacker)
			return
		end
		if player:hasDuration("ethereal_presence") then
			return
		end

		player.attacker = attacker.ID
		player:sendHealth(attacker.damage, attacker.critChance)
	end
}
