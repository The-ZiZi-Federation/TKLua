
enchant_test = {

on_learn = function(player) player.registry["learned_enchant_test"] = 1 end,
on_forget = function(player) player.registry["learned_enchant_test"] = 0 end,

cast = function(player, target)
		
	local magicCost = 100
	local duration = 30000
	
	local enchantBonus
	local level = player.level

	if player:hasDuration("enchant_test") then 
		player:setDuration("enchant_test", 0) 
		return
	end
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end

	
	if level >= 1 and level < 17 then
		enchantBonus = 1
	elseif level >= 17 and level < 67 then
		enchantBonus = 2
	elseif level >= 67 and level < 84 then
		enchantBonus = 3
	elseif level >= 84 and level < 101 then
		enchantBonus = 4
	elseif level >= 101 and level < 136 then
		enchantBonus = 5
	elseif level >= 136 and level < 160 then
		enchantBonus = 6
	elseif level >= 160 and level < 194 then
		enchantBonus = 7
	elseif level >= 194 and level < 242 then
		enchantBonus = 8	
	elseif level >= 242 and level < 250 then
		enchantBonus = 9
	elseif level == 250 then
		enchantBonus = 10
	elseif level == 251 then
		enchantBonus = 11
	elseif level == 252 then
		enchantBonus = 12
	elseif level == 253 then
		enchantBonus = 13
	elseif level == 254 then
		enchantBonus = 14
	elseif level == 255 then
		enchantBonus = 15
	end
	
	player.registry["enchant_test_bonus"] = enchantBonus

	player:sendAction(6, 20)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendAnimation(21)
	player:playSound(26)
	player:setDuration("enchant_test", duration)
	player:calcStat()
	player:sendMinitext("You cast Enchant Test")

end,


recast = function(player)

	local enchantBonus = player.registry["enchant_test_bonus"]

	player.enchant = enchantBonus

end,


uncast = function(player)

	player:calcStat()
	player:sendMinitext("Your Enchant bonus fades")
end,

requirements = function(player)

	local level = 5
	local item = {0}
	local amounts = {0}
	local txt = "In order to learn this spell, you must bring me:\n\n"
	for i = 1, #item do txt = txt..""..amounts[i].." "..Item(item[i]).name.."\n" end
	
	
	local desc = {"A spell that increases your Enchant.", txt}
	return level, item, amounts, desc
end
}