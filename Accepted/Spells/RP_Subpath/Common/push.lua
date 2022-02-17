push = {
	cast = function(player)
		local pc = getTargetFacing(player, BL_PC)
		local mob = getTargetFacing(player, BL_MOB)
		local magicCost = 500

		if not player:canCast(1, 1, 0) then
			return
		else
			if player.magic < magicCost then
				notEnoughMP(player)
				return
			else
				if pc ~= nil then
					canPush(player, pc)
					pc:sendMinitext(player.name .. " is pushing you.")
				elseif mob ~= nil then
					canPush(player, mob)
				else
					player:sendMinitext("There's nothing to Push!")
					return
				end
				player.magic = player.magic - magicCost
				player:sendStatus()
				player:sendAction(1, 20)
				player:playSound(10)
				player:sendFrontAnimation(10, player.side, 1)
				player:setAether("push", 1000)
			end
		end
	end
}
