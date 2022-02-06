gm_blink = {
cast = function(player)

	
	

	player.registry["start_point"] = player.m
	gm_blink.warp(player)
	
end,

warp = function(player)


	local m = math.random(1000, 5000)
	local x = math.random(0,20) 
	local y = math.random(0,20)


	if getPass(m,x,y) == 0 then
		player:warp(m, x, y)
		player:sendMinitext("You cast GM Blink and landed at "..player.mapTitle)
		if player.m == player.registry["start_point"] then
			return gm_blink.warp(player)
		else
			player.registry["start_point"] = 0
		end
	else
		return gm_blink.warp(player)
	end

end
}