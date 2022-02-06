eat_snake_food = {

use = function(player)


local map = player.m

if map == 15010 or map == 15020 or map == 15030 or map == 15040 or map == 15050 or map == 15060 then
return
end



	local item = player:getInventoryItem(player.invSlot)
	
	if not player:canAction(1, 1, 1) then return end
	if player.health <= 0 then player:sendMinitext("You need a physical body in order to eat.") return end
	
	if player:hasItem(item.yname, 1) == true then
	--	if player:removeItemSlot(player.invSlot, 1) == true then	
	
			player:sendAction(7, 20)
			player.registry["snake_food_count"] = player.registry["snake_food_count"] + 1
			addHealth(player, item.look)
			player:playSound(22)
	--	end
end



    if player.registry["snake_food_count"] == 5  then
        player:talkSelf(0,""..player.name..": Snake meat is oh so delicious and nutritious!...")
    

	elseif player.registry["snake_food_count"] == 13  then
        player:talkSelf(0,""..player.name..": *feeling ill* Maybe I should be careful what I eat...")
        
    elseif player.registry["snake_food_count"] == 21  then
        player:talkSelf(0,""..player.name..": Your skin begins to crawl...")
    
	elseif player.registry["snake_food_count"] == 30  then
		
		player:sendMinitext("I've turned into a snake")
		player.disguise = 184
		player.disguiseColor = math.random(1,15)
		player.state = 4
		player:setDuration("transform", 300000)
		player:updateState()
		player.registry["snake_food_count"] = 0
	end


end
}


