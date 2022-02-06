d4 = {
    
use = function(player)
    d4.cast(player)
end,

cast = function(player)

	local r = math.random(1, 4)
    
	if player:hasDuration("d4") then
		anim(player)
		delay = player:getDuration("d4")
		player:sendMinitext("Cooldown : "..math.abs(delay/1000).." sec")	    
	else
		player:talk(1, player.name.." rolled a d4: "..r)
  		player:setDuration("d4", 4000)
	end
end
}