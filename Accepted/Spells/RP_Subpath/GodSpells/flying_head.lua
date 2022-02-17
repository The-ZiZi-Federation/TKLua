flying_head = {
	cast = function(player, target)
		if target.blType == BL_PC and target.state ~= 1 then
			if target:hasDuration("flying_head") then
				target:setDuration("flying_head", 0)
				target:sendAnimation(292)
				return
			else
				target.gfxCrown = 410
				target.gfxCrownC = 25
				target.gfxHelm = 255
				target.gfxWeap = 65535
				target.gfxCape = 65535
				target.gfxArmor = 65535
				target.gfxShield = 65535
				target.gfxBoots = 65535
				target.gfxNeck = 65535
				target.gfxName = ""
				target.gfxClone = 1
				target:updateState()
				target:sendAnimationXY(285, target.x, target.y - 1)
				target:sendAnimation(292)
				player:playSound(73)
				for i = 1, 2 do
					player:playSound(70)
				end
				target:setDuration("flying_head", 60000)
			end
		end
	end,
	while_cast_250 = function(player)
		player:sendAnimation(115)

		player.gfxCrown = 410
		player.gfxCrownC = 25
		player.gfxHelm = 255
		player.gfxArmor = 65535
		player.gfxShield = 65535
		player.gfxBoots = 65535
		player.gfxNeck = 65535
		if player.gfxClone == 0 then
			player.gfxClone = 1
			player:updateState()
		end
	end,
	uncast = function(player)
		player.gfxClone = 0
		player:calcStat()
		player:updateState()
	end
}
