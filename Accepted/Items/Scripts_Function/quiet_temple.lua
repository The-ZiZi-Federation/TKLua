quiet_temple = {

block = function(player)
	
	local m, x, y = player.m, player.x, player.y

	if m == 1035 then
		if x >= 10 and x <= 12 then
			if y == 21 then
				if player.quest["dre_loc_rambles"] == 0 then
					player:talkSelf(0,""..player.name..": I can't leave yet...")
					pushBack(player)
					anim(player)
				end
			end
		end
	end
end
}