random_app = {
	cast = function(player)
		local pc = player:getUsers()

		if #pc > 0 then
			for i = 1, #pc do
				target = pc[math.random(#pc)]
				if target.ID ~= player.ID then
					player:warp(target.m, target.x, target.y)
					player:msg(4, "Randomly Approach to " .. target.name .. "", player.ID)
					break
				end
			end
		end
	end
}
