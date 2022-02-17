poison = {
	while_cast = function(block)
		local anim = 1
		local dam = block.health * 0.075

		block:sendAnimation(anim)

		block:removeHealthExtend(dam, 1, 1, 0, 1, 1)
		block:sendStatus()
	end,
	uncast = function(block)
		block:calcStat()
	end
}
