setFacingPass = {
	cast = function(player)
		if player.side == 0 then
			if getPass(player.m, player.x, player.y - 1) == 1 then
				setPass(player.m, player.x, player.y - 1, 0)
				player:sendAnimationXY(228, player.x, player.y - 1)
			else
				setPass(player.m, player.x, player.y - 1, 1)
				player:sendAnimationXY(235, player.x, player.y - 1)
			end
		elseif player.side == 1 then
			if getPass(player.m, player.x + 1, player.y) == 1 then
				setPass(player.m, player.x + 1, player.y, 0)
				player:sendAnimationXY(228, player.x + 1, player.y)
			else
				setPass(player.m, player.x + 1, player.y, 1)
				player:sendAnimationXY(235, player.x + 1, player.y)
			end
		elseif player.side == 2 then
			if getPass(player.m, player.x, player.y + 1) == 1 then
				setPass(player.m, player.x, player.y + 1, 0)
				player:sendAnimationXY(228, player.x, player.y + 1)
			else
				setPass(player.m, player.x, player.y + 1, 1)
				player:sendAnimationXY(235, player.x, player.y + 1)
			end
		elseif player.side == 3 then
			if getPass(player.m, player.x - 1, player.y) == 1 then
				setPass(player.m, player.x - 1, player.y, 0)
				player:sendAnimationXY(228, player.x - 1, player.y)
			else
				setPass(player.m, player.x - 1, player.y, 1)
				player:sendAnimationXY(235, player.x - 1, player.y)
			end
		end
	end
}
