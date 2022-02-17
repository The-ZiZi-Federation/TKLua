benign_transposition = {
	cast = function(player, target)
		local pm, px, py = player.m, player.x, player.y
		local tm, tx, ty = target.m, target.x, target.y

		player:sendAnimationXY(292, px, py)
		player:warp(tm, tx, ty)
		target:sendAnimationXY(292, tx, ty)
		target:warp(pm, px, py)
		target:sendMinitext(player.name .. " switches places with you")
	end
}
