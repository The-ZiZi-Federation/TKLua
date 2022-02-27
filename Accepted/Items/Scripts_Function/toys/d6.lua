d6 = {
    
use = function(player)
    d6.cast(player)
end,

cast = function(player)

	local r = math.random(1, 6)
    
	if player:hasDuration("d6") then
		anim(player)
		delay = player:getDuration("d6")
		player:sendMinitext("Cooldown : "..math.abs(delay/1000).." sec")	    
	else
		player:talk(1, player.name.." rolled a d6: "..r)
  		player:setDuration("d6", 4000)
	end
end
}