asak_shout = {
	cast = function(player)
		local speech = player.question

		player:sendAction(6, 20)
		broadcast(-1, "[ASAK]: " .. speech)
	end
}
