frog = {

cast = function(player, target)

	if target.blType == BL_PC then
		player:sendStatus()
		player:sendAction(6, 20)
		player:sendMinitext("You cast Frog")
		target:sendAnimation(292)
		player:playSound(89)
		target.state = 4
		target.disguise = 286
		target.disguiseColor = target.armorColor
		--target.skinColor = 2
		target:updateState()
		target:sendMinitext(player.name.." turns you into a Frog")
		target.drunk = 1
		target:setDuration("frog", 60000)
	end
end,

while_cast = function(player)

--player.skinColor = 2
target.drunk = 1

end,

while_cast_250 = function(player)

	if player.side <= 2 then 
		player.side = player.side + 1
		player:sendSide()
	else
		player.side = 0
		player:sendSide()
	end


end,

uncast = function(player)

--	player.skinColor = 0
	player.drunk = 0
	if player.state ~= 1 then player.state = 0 end
	player:updateState()	
	

end
}



