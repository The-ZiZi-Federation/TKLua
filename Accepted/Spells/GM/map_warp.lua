map_warp = {

cast = function(player)

	local input = tonumber(player.question)
	
	if (not input) then anim(player, "Number only!") return else
		if input > 4000 then anim(player, "Can't go over 4000!") return else
			player:warp(input, 0, 0)
		end
	end

end
}