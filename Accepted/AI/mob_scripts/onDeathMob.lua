onDeathMob = function(mob)
end

onDeathMob2 = function(mob)
	local killer = mob:getBlock(mob.attacker)
	local users = killer:getUsers()

	if mob.aiType == 3 then
		if killer ~= nil then
			if #users > 0 then
				for i = 1, #users[i] do
					if users[i].aiType == 3 then
						user[i]:msg(12, "===>> [MvP] " .. mob.name .. " vanquished by " .. killer.name .. " <<===", user[i].ID)
					end
				end
			end
		end
	end
end

dropCoins = function(mob, amount, attacker)
	if math.abs(tonumber(amount)) == nil then
		return nil
	end
	mob:dropItem(0, math.abs(tonumber(amount)), attacker)
end
