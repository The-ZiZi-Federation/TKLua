disguise_self = {
	cast = function(player)
		local duration = 30000
		local anim = 3

		player.gfxArmor = math.random(0, 353)
		player.gfxArmorC = math.random(0, 32)
		player.gfxDye = math.random(0, 32)
		player.gfxCrown = 65535
		player.gfxShield = math.random(0, 44)
		player.gfxWeap = math.random(0, 284)
		player.gfxWeapC = 0
		player.gfxNeck = 65535
		player.gfxFaceA = 65535
		player.gfxFaceAT = 65535
		player.gfxFaceATC = 0
		player.gfxHelm = math.random(0, 100)
		player.gfxCape = 65535
		player.gfxFace = math.random(200, 238)
		player.gfxFaceC = player.faceColor
		player.gfxHair = math.random(0, 440)
		player.gfxHairC = math.random(0, 32)
		player.gfxSkinC = player.skinColor
		player.gfxName = ""
		player.gfxClone = 1
		player:updateState()

		player:sendAnimation(anim)
		player:setDuration("disguise_self", 30000)
	end,
	uncast = function(player)
		local anim = 3

		if player.state == 4 then
			player.state = 0
			player:updateState()
		end
		clone.wipe(player)
		player:sendAnimation(anim)
	end
}
