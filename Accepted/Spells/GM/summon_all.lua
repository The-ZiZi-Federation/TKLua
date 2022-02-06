mass_summon = {
cast=function(player,target)
        local list = player:getUsers()
        if(#list > 0) then
                for i = 1, #list do
                        if(list[i].m ~= 134 and list[i].m ~= 135 and list[i].ID ~= 2 and list[i].ID ~= 18) then
                                list[i]:warp(player.m, player.x, player.y)
                        end
                end
        end
end
}

