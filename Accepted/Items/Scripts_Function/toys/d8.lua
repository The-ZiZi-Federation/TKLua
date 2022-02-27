d8 = {
    
use = function(player)
    d8.cast(player)
end,

cast = function(player)

	local r = math.random(1, 8)
    
	if player:hasDuration("d8") then
		anim(player)
		delay = player:getDuration("d8")
		player:sendMinitext("Cooldown : "..math.abs(delay/1000).." sec")	    
	else
		player:talk(1, player.name.." rolled a d8: "..r)
  		player:setDuration("d8", 4000)
	end
end
}