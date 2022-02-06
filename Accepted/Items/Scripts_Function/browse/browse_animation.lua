



next_animation = {

cast = function(player)
	
	if player.registry["gfx_spell"] > 427 then player:sendMinitext("Spell #: Tidak bisa lebih dari 427 pak") return end
	player.registry["gfx_spell"] = player.registry["gfx_spell"] + 1
	player:sendMinitext("Spell #: "..player.registry["gfx_spell"].."")
	player:selfAnimation(player.ID, player.registry["gfx_spell"], 0)
end
}

prev_animation = {

cast = function(player)
	
	if player.registry["gfx_spell"] < 0 then player:sendMinitext("Spell #: Tidak bisa kurang dari 0 pak") return end
	player.registry["gfx_spell"] = player.registry["gfx_spell"] - 1
	player:sendMinitext("Spell #: "..player.registry["gfx_spell"].."")
	player:selfAnimation(player.ID, player.registry["gfx_spell"], 0)
end
}























