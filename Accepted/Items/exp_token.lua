

exp_token = {

use = function(player)
		
	if not player:canCast(1,1,1) then return end
	
	if player.level == 99 then
		player:sendAnimation(383)
		player:sendAnimation(348)
		player:playSound(123)
		player:giveXP(10000000)
		player:updateState()
		player:sendStatus()
		player:updateState()

	end
end
}