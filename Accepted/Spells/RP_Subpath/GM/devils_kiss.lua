devils_kiss = {
	cast = function(player)
		local pc = player:getObjectsInArea(BL_PC)
		local mob = player:getObjectsInArea(BL_MOB)
		local anim = 51
		local remainingHealth = 10
		local sound = 1

		if #pc > 0 then
			for i = 1, #pc do
				if pc[i].ID ~= player.ID then
					pc[i]:sendAnimation(anim)
					pc[i]:playSound(sound)
					pc[i].health = remainingHealth
					pc[i]:sendStatus()
				end

				if pc[i].ID == player.ID then
					pc[i].health = pc[i].maxHealth
					pc[i]:sendAnimation(5)
					pc[i]:sendStatus()
				end
			end
		end

		if #mob > 0 then
			for i = 1, #mob do
				damage = mob[i].health - 10

				mob[i]:sendAnimation(anim)
				mob[i]:removeHealth(damage)
				--mob[i].health = remainingHealth
				--mob[i]:sendStatus()
			end
			player:playSound(sound)
		end
	end
}
