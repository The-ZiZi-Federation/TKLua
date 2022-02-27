rockem = {

cast = function(player, target)

	if target.blType == BL_PC then
		player:sendStatus()
		player:sendAction(6, 20)
		player:sendMinitext("You cast Rockem")
		target:sendAnimation(292)
		player:playSound(89)
		target.state = 4
		target.disguise = 1002
		target.disguiseColor = target.armorColor
		--target.skinColor = 2
		target:updateState()
		target:sendMinitext(player.name.." turns you into a Rock")
		target:setDuration("rockem", 600000)
	end
end,

while_cast = function(player)

end,

while_cast_250 = function(player)

end,

uncast = function(player)

	if player.state ~= 1 then player.state = 0 end
	player:updateState()	
end
}



