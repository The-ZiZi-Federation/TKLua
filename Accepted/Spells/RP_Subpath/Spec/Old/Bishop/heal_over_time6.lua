--[[
heal_over_time6 = {

on_learn = function(player) player.registry["learned_heal_over_time6"] = 1 end,
on_forget = function(player) player.registry["learned_heal_over_time6"] = 0 end,

cast = function(player)

	local duration = 240000
	local magicCost = 3000
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end
	


	
		for i = 1, #player.group do
		if (Player(player.group[i]).state ~= 1 and Player(player.group[i]).m == player.m) then
			if Player(player.group[i]):hasDuration("heal_over_time6") == true then
				Player(player.group[i]):setDuration("heal_over_time6", 0, player.ID)
				player.magic = player.magic - magicCost	
				Player(player.group[i]):sendAnimation(132, 0)
				Player(player.group[i]):setDuration("heal_over_time6", duration, player.ID)
				Player(player.group[i]):calcStat()
				Player(player.group[i]):sendMinitext(player.name.." is in a healing aura.")

			else
				player.magic = player.magic - magicCost	
				Player(player.group[i]):sendAnimation(132, 0)
				Player(player.group[i]):setDuration("heal_over_time6", duration, player.ID)
				Player(player.group[i]):calcStat()
				Player(player.group[i]):sendMinitext(player.name.." is in a healing aura.")
			end
		end
	end
end,

while_cast = function(player)
	player:sendAnimation(132, 0)
	player:addHealth2(1800)
	player:sendStatus()
	
end,

uncast = function(player)
	player:calcStat()
end
}]]
--
