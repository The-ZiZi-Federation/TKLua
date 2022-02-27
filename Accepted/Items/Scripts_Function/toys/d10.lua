d10 = {
    
use = function(player)
    d10.cast(player)
end,

cast = function(player)

	local r = math.random(1, 10)
    
	if player:hasDuration("d10") then
		anim(player)
		delay = player:getDuration("d10")
		player:sendMinitext("Cooldown : "..math.abs(delay/1000).." sec")	    
	else
		player:talk(1, player.name.." rolled a d10: "..r)
  		player:setDuration("d10", 4000)
	end
end
}