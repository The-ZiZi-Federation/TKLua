d100 = {
    
use = function(player)
    d100.cast(player)
end,

cast = function(player)

	local r = math.random(1, 100)
    
	if player:hasDuration("d100") then
		anim(player)
		delay = player:getDuration("d100")
		player:sendMinitext("Cooldown : "..math.abs(delay/1000).." sec")	    
	else
		player:talk(1, player.name.." rolled a d100: "..r)
  		player:setDuration("d100", 4000)
	end
end
}