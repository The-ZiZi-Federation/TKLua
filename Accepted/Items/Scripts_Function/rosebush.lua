rosebush = {

walk = function(player)

	local chance = math.random(100)
	
	if chance <= 5 then
		player:sendMinitext("You found a Red Rose!")
		player:addItem("red_rose", 1)
	end

end
}

sunflower_patch = {

walk = function(player)

	local chance = math.random(100)
	
	if chance <= 5 then
		player:sendMinitext("You found a Sunflower!")
		player:addItem("sunflower", 1)
	end

end
}