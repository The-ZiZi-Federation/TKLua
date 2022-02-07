flip_coin = {
	cast = function(player)
		local aether = 120000
		local anim = 173
		local anims = {178, 177}
		local magicCost = 1000
		local sound = 123

		local facingPC = getTargetFacing(player, BL_PC)
		local facingNPC = getTargetFacing(player, BL_NPC)
		local facingMob = getTargetFacing(player, BL_MOB)

		local r = math.random(1, 2)

		if not player:canCast(1, 1, 0) then
			return
		end
		if player.magic < magicCost then
			notEnoughMP(player)
			return
		end

		player:sendAction(6, 20)
		player.magic = player.magic - magicCost
		player:calcStat()
		player:sendStatus()
		player:sendMinitext("You cast Flip Coin")
		player:playSound(sound)
		player:sendAnimation(anims[r])
		player:setAether("flip_coin", aether)

		if r == 1 then
			player:talk(1, player.name .. " flipped a coin: HEADS!")
		elseif r == 2 then
			player:talk(1, player.name .. " flipped a coin: TAILS!")
		end
	end
}
