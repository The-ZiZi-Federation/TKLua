attack_order = {
	cast = function(player, target)
		local mob = player:getObjectsInArea(BL_MOB)
		local skeleton = 80
		local skeletonsFound = {}

		for i = 1, #mob do
			if mob[i].mobID == skeleton then
				if mob[i].owner == player.ID then
					table.insert(skeletonsFound, mob[i])
				end
			end
		end

		local heal = 250
		local magicCost = 50

		if not player:canCast(1, 1, 0) then
			return
		end
		if player.magic < magicCost then
			notEnoughMP(player)
			return
		end

		player:sendAction(6, 20)
		player.magic = player.magic - magicCost
		player:sendStatus()
		--	player:sendAnimation(5)
		--	player:playSound(3)
		player:talk(2, "Go get 'em, Bobby Bones!")
		player:sendMinitext("You cast Attack Order!")

		if #skeletonsFound > 0 then
			for i = 1, #skeletonsFound do
				skeletonsFound[i].target = target.ID
			end
		end
	end
}
