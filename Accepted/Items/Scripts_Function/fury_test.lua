
fury_test = {

on_learn = function(player) player.registry["learned_fury_test"] = 1 end,
on_forget = function(player) player.registry["learned_fury_test"] = 0 end,

cast = function(player, target)
		
	local magicCost = 100
	local duration = 30000
	
	local furyBonus
	local level = player.level

	if player:hasDuration("fury_test") then 
		player:setDuration("fury_test", 0) 
		return
	end
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end

	
	if level >= 1 and level < 7 then
		furyBonus = 1
	elseif level >= 7 and level < 21 then
		furyBonus = 2
	elseif level >= 21 and level < 42 then
		furyBonus = 3
	elseif level >= 42 and level < 63 then
		furyBonus = 5
	elseif level >= 63 and level < 92 then
		furyBonus = 7
	elseif level >= 92 and level < 111 then
		furyBonus = 9
	elseif level >= 111 and level < 153 then
		furyBonus = 11
	elseif level >= 153 and level < 197 then
		furyBonus = 13	
	elseif level >= 197 and level < 246 then
		furyBonus = 15
	elseif level >= 246 and level < 253 then
		furyBonus = 17
	elseif level == 253 then
		furyBonus = 18
	elseif level == 254 then
		furyBonus = 19
	elseif level == 255 then
		furyBonus = 20
	end
	
	player.registry["fury_test_bonus"] = furyBonus

	player:sendAction(6, 20)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendAnimation(21)
	player:playSound(26)
	player:setDuration("fury_test", duration)
	player:calcStat()
	player:sendMinitext("You cast Fury Test")

end,


recast = function(player)

	local furyBonus = player.registry["fury_test_bonus"]

	player.fury = furyBonus

end,


uncast = function(player)

	player:calcStat()
	player:sendMinitext("Your Fury bonus fades")
end,

requirements = function(player)

	local level = 5
	local item = {0}
	local amounts = {0}
	local txt = "In order to learn this spell, you must bring me:\n\n"
	for i = 1, #item do txt = txt..""..amounts[i].." "..Item(item[i]).name.."\n" end
	
	
	local desc = {"A spell that increases your Fury.", txt}
	return level, item, amounts, desc
end
}