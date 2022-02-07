fuddle = {
	cast = function(player, target)
		local magicCost = 500
		if not player:canCast(1, 1, 0) then
			return
		end
		if player.magic < magicCost then
			notEnoughMP(player)
			return
		end
		local randomAction = math.random(9, 24)
		target:sendAction(randomAction, 78)

		player:sendAction(6, 20)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:sendMinitext("You cast Fuddle on " .. target.name)
	end
}
