being_frank = {
	cast = function(player, target)
		target.gfxFace = 223
		target.gfxFaceC = 0
		target.gfxHair = 93
		target.gfxHairC = 19
		target.gfxSkinC = target.skinColor
		target.gfxDye = target.dye
		target.gfxWeap = 10001
		target.gfxWeapC = 16
		target.gfxArmor = 210
		target.gfxArmorC = 2
		target.gfxShield = 7
		target.gfxShieldC = 24
		target.gfxHelm = 65535
		target.gfxHelmC = 0
		target.gfxCape = 65535
		target.gfxCapeC = 0
		target.gfxCrown = 65535
		target.gfxCrownC = 0
		target.gfxFaceA = 65535
		target.gfxFaceAC = 0
		target.gfxFaceAT = 65535
		target.gfxFaceATC = 0
		target.gfxBoots = 65535
		target.gfxBootsC = 0
		target.gfxNeck = 65535
		target.gfxNeckC = 0
		target.gfxName = "Frank"
		target.gfxClone = 1
		target:updateState()
		target:setDuration("being_frank", 60000)
	end,
	on_swing_while_cast = function(player)
		player:throwSpear(player)
	end,
	uncast = function(player)
		player.gfxFace = 0
		player.gfxFaceC = 0
		player.gfxHair = 0
		player.gfxHairC = 0
		player.gfxSkinC = 0
		player.gfxDye = 0
		player.gfxWeap = 0
		player.gfxWeapC = 0
		player.gfxArmor = 0
		player.gfxArmorC = 0
		player.gfxShield = 0
		player.gfxShieldC = 0
		player.gfxHelm = 0
		player.gfxHelmC = 0
		player.gfxCape = 0
		player.gfxCapeC = 0
		player.gfxCrown = 0
		player.gfxCrownC = 0
		player.gfxFaceA = 0
		player.gfxFaceAC = 0
		player.gfxFaceAT = 0
		player.gfxFaceATC = 0
		player.gfxBoots = 0
		player.gfxBootsC = 0
		player.gfxNeck = 0
		player.gfxNeckC = 0
		player.gfxName = ""

		player.gfxClone = 0
		player:updateState()
	end
}
