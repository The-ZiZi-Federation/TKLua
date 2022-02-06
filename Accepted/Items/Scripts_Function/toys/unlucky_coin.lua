unlucky_coin = {

use = function(player)
	local r = math.random(0, 100)
	
	if r > 50 then
		player:talk(1, player.name.." flipped a coin: HEADS!")
	elseif r < 50 then
		player:talk(1, player.name.." flipped a coin: TAILS!")
	elseif r == 50 then 
		player:talk(1, player.name.." flipped a coin: IT LANDED ON ITS SIDE!")
	end
end
}