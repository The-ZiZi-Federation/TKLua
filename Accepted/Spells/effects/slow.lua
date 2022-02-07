slow = {
	while_cast = function(block)
		if block.blType == BL_MOB then
			block.newMove = block.baseMove + 250
			block.newAttack = block.baseAttack + 250
		elseif block.blType == BL_PC then
			block.speed = 160
			--block.attackSpeed = 40
			block:updateState()
		end
		block:sendAnimation(258)
	end,
	uncast = function(block)
		if block.blType == BL_MOB then
			block.newMove = block.baseMove
			block.newAttack = block.baseAttack
		elseif block.blType == BL_PC then
			block.speed = 80
			--block.attackSpeed = 20
			block:updateState()
		end
	end
}
