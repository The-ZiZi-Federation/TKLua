loaded_dice = {
    
use = function(player)
    local r = math.random(1, 100)
    local r2 = math.random(90, 100)
    
	if player.ID == 2 or player.ID == 4 then
		player:talk(1, player.name.." rolled a d100: "..r2)
	else
		player:talk(1, player.name.." rolled a d100: "..r)
	end
end
}