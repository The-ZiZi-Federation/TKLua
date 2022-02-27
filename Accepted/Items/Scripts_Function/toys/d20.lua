d20 = {
    
use = function(player)
    d20.cast(player)
end,

cast = function(player)

	local r = math.random(1, 20)
    
	if player:hasDuration("d20") then
		anim(player)
		delay = player:getDuration("d20")
		player:sendMinitext("Cooldown : "..math.abs(delay/1000).." sec")	    
	else
		player:talk(1, player.name.." rolled a d20: "..r)
  		player:setDuration("d20", 4000)
	end
end
}