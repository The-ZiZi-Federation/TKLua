xephors_aura = { cast = function(player)
    
    player:setDuration("xephors_aura", 600000)
    
end, while_cast = function(player)
    
    player:sendAnimation(452)
    
end
}
