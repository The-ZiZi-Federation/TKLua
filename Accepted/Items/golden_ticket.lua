golden_ticket = {

use = function(player)

	local item = player:getInventoryItem(player.invSlot)
	local goldMin = 50000
	local goldMax = 150000
	local goldAmount = math.random(goldMin, goldMax)
	
	local maxGoldReward = {2, 4, 279, 300, 265, 301, 251, 263, 277, 250, 262, 252, 266, 273, 257, 259, 305, 343, 347, 351, 408, 458}
	
	for i = 1, #maxGoldReward do
		if player.ID == maxGoldReward[i] then
			goldAmount = 150000
		end
	end
	
	if player.level <= 98 then
		failureAnim(player)
		player:sendMinitext("You must be level 99 or above to redeem a Golden Ticket")
		return
	end
	
	if not player:canAction(1, 1, 1) then
		player:sendMinitext("You cannot do that right now!")
	return end
	
	if player:hasItem(item.yname, 1) == true then
		if player:removeItemSlot(player.invSlot, 1) == true then	
			player:sendAction(10, 20)
			player:sendAnimation(2)
			player:addGold(goldAmount)
			player:updateState()
			player:sendStatus()
			player:talk(0,""..player.name..": Gold! My favorite!")
		end
	end
end
}
