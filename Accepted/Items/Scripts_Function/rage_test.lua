
rage_test = {

on_learn = function(player) player.registry["learned_rage_test"] = 1 end,
on_forget = function(player) player.registry["learned_rage_test"] = 0 end,

cast = function(player, target)
		
	local magicCost = 100
	local duration = 30000
	
	local rageBonus
	local level = player.level

	if player:hasDuration("rage_test") then 
		player:setDuration("rage_test", 0) 
		return
	end
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end

	
	if level >= 1 and level < 5 then
		rageBonus = 1
	elseif level >= 5 and level < 19 then
		rageBonus = 3              
	elseif level >= 19 and level < 40 then
		rageBonus = 7             
	elseif level >= 40 and level < 69 then
		rageBonus = 12              
	elseif level >= 69 and level < 99 then
		rageBonus = 18             
	elseif level >= 99 and level < 110 then
		rageBonus = 23             
	elseif level >= 110 and level <	125 then
		rageBonus = 30             	
	elseif level >= 125 and level <	138  then
		rageBonus = 38             	
	elseif level >= 138 and level <	150  then
		rageBonus = 54             	
	elseif level >= 150 and level <	162  then
		rageBonus = 75             	
	elseif level >= 162 and level <	175  then
		rageBonus = 100             	
	elseif level >= 175 and level <	188  then
		rageBonus = 125            	
	elseif level >= 188 and level <	200  then
		rageBonus = 154            	
	elseif level >= 200 and level <	207  then
		rageBonus = 173            	
	elseif level >= 207 and level <	214  then
		rageBonus = 188            	
	elseif level >= 214 and level <	220  then
		rageBonus = 194            	
	elseif level >= 220 and level <	225  then
		rageBonus = 206            	
	elseif level >= 225 and level <	232  then
		rageBonus = 223            	
	elseif level >= 232 and level <	238  then
		rageBonus = 238            	
	elseif level >= 238 and level <	245  then
		rageBonus = 245            		
	elseif level >= 245 and level <	250  then
		rageBonus =	261 
	elseif level == 250 then     
		rageBonus = 275               
	elseif level == 251 then       
		rageBonus = 280            
	elseif level == 252 then       
		rageBonus = 285            
	elseif level == 253 then       
		rageBonus = 290            
	elseif level == 254 then       
		rageBonus = 295
	elseif level == 255 then
		rageBonus = 300
	end
	
	player.registry["rage_test_bonus"] = rageBonus

	player:sendAction(6, 20)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendAnimation(21)
	player:playSound(26)
	player:setDuration("rage_test", duration)
	player:calcStat()
	player:sendMinitext("You cast Rage Test")

end,


recast = function(player)

	local rageBonus = player.registry["rage_test_bonus"]

	player.enchant = rageBonus

end,


uncast = function(player)

	player:calcStat()
	player:sendMinitext("Your Rage bonus fades")
end,

requirements = function(player)

	local level = 5
	local item = {0}
	local amounts = {0}
	local txt = "In order to learn this spell, you must bring me:\n\n"
	for i = 1, #item do txt = txt..""..amounts[i].." "..Item(item[i]).name.."\n" end
	
	
	local desc = {"A spell that increases your Rage.", txt}
	return level, item, amounts, desc
end
}