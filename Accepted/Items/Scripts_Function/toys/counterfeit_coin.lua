counterfeit_coin = {

use = function(player)
	local r = math.random(0, 10)
	
	if r >= 1 and r <= 6 then
		player:talk(1, player.name.." flipped a coin: HEADS!")
	elseif r >= 6 then
		player:talk(1, player.name.." flipped a coin: TAILS!")
	elseif r == 0 then 
		player:talk(1, player.name.." flipped a coin: IT GOT LOST ON THE GROUND!")
		player:removeItem("counterfeit_coin", 1)
	end
end
}