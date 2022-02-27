

transformation_potion = {

use = function(player)
		
	if player.m >= 15000 and player.m < 60000 then
	
		player:sendMinitext("Can't use that here!")	
		return
	end		
		
	if not player:canCast(1,1,1) then return end
	if player:hasDuration("transformation_potion") or player.state == 4 then
		anim(player)
		player:sendMinitext("Spell is already cast!")
	return else
		if player.state == 0 then
			player.disguise = 109
			player.disguiseColor = 30			
			player.state = 4 		
			player:updateState()
			player:sendAnimation(249)
			player:playSound(36)
			player:sendMinitext("You drink Transformation Potion")
			player:setDuration("transformation_potion", 600000)
		end
	end
end,

while_cast = function(player)

	player.disguise = 109
	player.disguiseColor = 30
end,

uncast = function(player)

	player:calcStat()
	if player.state == 4 then
		player.state = 0
		player:updateState()
	end
end,
}