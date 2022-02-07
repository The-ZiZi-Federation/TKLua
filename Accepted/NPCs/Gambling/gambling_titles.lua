gambling_titles = {
        grantTitle = function(player)
                -- GAMBLING TITLE BROADCASTS--
                -- Participation title rewards--

                if player.registry["Gambling_plays"] == 10 and player.registry["Gambling_title_gambler"] == 0 then
                        broadcast(-1, "[TITLE]: " .. player.name .. " has just earned the title 'Gambler'!")
                        player.registry["Gambling_title_gambler"] = 1
                elseif player.registry["Gambling_plays"] == 50 and player.registry["Gambling_title_easymark"] == 0 then
                        broadcast(-1, "[TITLE]: " .. player.name .. " has just earned the title 'Easy Mark'!")
                        player.registry["Gambling_title_easymark"] = 1
                elseif player.registry["Gambling_plays"] == 125 and player.registry["Gambling_title_fish"] == 0 then
                        broadcast(-1, "[TITLE]: " .. player.name .. " has just earned the title 'Fish'!")
                        player.registry["Gambling_title_fish"] = 1
                elseif player.registry["Gambling_plays"] == 250 and player.registry["Gambling_title_sucker"] == 0 then
                        broadcast(-1, "[TITLE]: " .. player.name .. " has just earned the title 'Sucker!")
                        player.registry["Gambling_title_sucker"] = 1
                elseif player.registry["Gambling_plays"] == 500 and player.registry["Gambling_title_junkie"] == 0 then
                        -- Gambling Specialty titles --
                        broadcast(-1, "[TITLE]: " .. player.name .. " has just earned the title 'Junkie'!")
                        player.registry["Gambling_title_junkie"] = 1
                elseif player.registry["Gambling_plays"] == 100 and player.registry["Gambling_spent"] <= 50000 then
                        broadcast(-1, "[TITLE]: " .. player.name .. " has just earned the title 'Nit'!")
                elseif player.registry["Gambling_plays"] == 200 and player.registry["Gambling_spent"] >= 300000 then
                        broadcast(-1, "[TITLE]: " .. player.name .. " has just earned the title 'Regular'!")
                elseif player.registry["Gambling_plays"] == 20 and player.registry["Gambling_spent"] >= 1000000 then
                        -- Winner Gambling Titles --
                        broadcast(-1, "[TITLE]: " .. player.name .. " has just earned the title 'Whale'!")
                elseif player.registry["Gambling_wins"] == 5 and player.registry["Gambling_title_lucky"] == 0 then
                        broadcast(-1, "[TITLE]: " .. player.name .. " has just earned the title 'Lucky'!")
                        player.registry["Gambling_title_lucky"] = 1
                elseif player.registry["Gambling_wins"] == 25 and player.registry["Gambling_title_runninghot"] == 0 then
                        broadcast(-1, "[TITLE]: " .. player.name .. " has just earned the title 'Running Hot'!")
                        player.registry["Gambling_title_runninghot"] = 1
                elseif player.registry["Gambling_wins"] == 50 and player.registry["Gambling_title_hotshot"] == 0 then
                        broadcast(-1, "[TITLE]: " .. player.name .. " has just earned the title 'Hot Shot'!")
                        player.registry["Gambling_title_hotshot"] = 1
                elseif player.registry["Gambling_wins"] == 150 and player.registry["Gambling_title_toohot"] == 0 then
                        broadcast(-1, "[TITLE]: " .. player.name .. " has just earned the title 'Too Hot'!")
                        player.registry["Gambling_title_toohot"] = 1
                elseif player.registry["Gambling_wins"] == 250 and player.registry["Gambling_title_maverick"] == 0 then
                        broadcast(-1, "[TITLE]: " .. player.name .. " has just earned the title 'Maverick'!")
                        player.registry["Gambling_title_maverick"] = 1
                elseif player.registry["Gambling_wins"] == 500 and player.registry["Gambling_title_legendary"] == 0 then
                        broadcast(-1, "[TITLE]: " .. player.name .. " has just earned the title 'Legendary'!")
                        player.registry["Gambling_title_legendary"] = 1
                end
        end
}
