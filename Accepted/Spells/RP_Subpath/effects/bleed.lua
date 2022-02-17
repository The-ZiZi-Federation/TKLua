bleed = {
	while_cast = function(block)
		local anim = 102
		local dam = block.health * 0.023

		block:sendAnimation(anim)

		block:removeHealthExtend(dam, 1, 1, 0, 1, 1)
		block:sendStatus()
	end,
	uncast = function(block)
		block:calcStat()
	end
}

--[[
bleed = {
	
while_cast = function(player)
	
local dam = player.maxHealth*.02

	player:removeHealthExtend(dam, 1,1,1,1,0)
	player:sendAnimation(233)
	player:calcStat()
	player:updateSatus()
	player:sendStatus()
end,

uncast = function(player)

	player:calcStat()
end
}
]] --
