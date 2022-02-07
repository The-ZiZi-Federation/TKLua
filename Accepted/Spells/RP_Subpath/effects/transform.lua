transform = {
    uncast = function(player)
        if player.state == 4 then
            player.disguise = 0
            player.state = 0
            player:updateState()
        end
    end
}
