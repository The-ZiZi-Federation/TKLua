d12 = {
    
use = function(player)
    d12.cast(player)
end,

cast = function(player)

	local r = math.random(1, 12)
    
	if player:hasDuration("d12") then
		anim(player)
		delay = player:getDuration("d12")
		player:sendMinitext("Cooldown : "..math.abs(delay/1000).." sec")	    
	else
		player:talk(1, player.name.." rolled a d12: "..r)
  		player:setDuration("d12", 4000)
	end
end
}