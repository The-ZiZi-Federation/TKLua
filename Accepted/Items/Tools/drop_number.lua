

drop_number = {

cast = function(player)

	local input = tonumber(player.question)

	if input <= 0 or input > 100 then anim(player) player:sendMinitext("Number Allowed: (1-100)") return else
		player:dropItem(Item("num"..input).id, 1, player.ID)
		player:sendAction(6, 20)
		player:sendAnimationXY(280, player.x, player.y)
		player:playSound(29)
	end
end
}