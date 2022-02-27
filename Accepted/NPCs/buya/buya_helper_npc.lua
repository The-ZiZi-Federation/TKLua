
buyaHelperNpc = {

    click = async(function(player, npc)

        local name = "<b>["..npc.name.."]\n\n"
        local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
        player.npcGraphic = t.graphic
        player.npcColor = t.color
        player.dialogType = 0
        player.lastClick = npc.ID

        local opts = {}
        local opts2 = {"No, just a shadowy figure saying", 
                        "something that I don't remember"}
        local opts3 = {"That's fine."}

        local killcount9010 = player:killCount(9010) --Yellow Jackets
        local killcount9012 = player:killCount(9012) --Queen Bee
        local killcount9033 = player:killCount(9033) --Rats 


        if player.registry["helper_questline"] ~= 1 then table.insert(opts, "Where the hell am I?") end
        --if player.quest["bee_quest"] == 1 and player.quest["wasp_quest"] < 1 then table.insert(opts, "What's next?") end

        if player.registry["helper_questline"] ~= 1 then
            player:dialogSeq({t, name.."Ah,you're awake! I found you stumbling naked near the south gate and brought you here"}, 1)
            menu = player:menuString(name.."Do you remember anything?", opts2)
            player:dialogSeq({t, name.."Well that's unfortunate! Memory loss sucks! But, maybe somebody",
                                name.."around town will spark your memory. The people around here are tight-lipped,",
                                name.."buy if you do something for them, they will do something for you"}, 1)
            menu = player:menuString(name.."Perhaps you should talk to some of the townsfolk.", opts3)
            player:dialogSeq({t, name.."That's the spirit! Now, first order of business.I've heard chatter",
                                name.."around town that the wasps and bees are getting out of control.",
                                name.."Please go to the wasp cave at 112,126 and kill 10 Yellow Jackets.",
                                name.."But first, take these!"}, 0)
            player.quest["helper"] = 1
            player:addItem("buyan_garb", 1)
            player:addItem("trainee_sword", 1)
            player:addItem("buyan_gown", 1)
            player:addLegend("Shadowed Roots "..curT(), "shadowed_roots", 8, 80)
            player.registry["helper_questline"] = 1
            

        elseif player.quest["helper"] == 1 and killcount9010 >= 10 then
            player:dialogSeq({t, name.."Fine job taking care of those yellow jackets!"}, 1)
            player.quest["helper"] = player.quest["helper"] + 1
            player:giveXP(750)
            player:dialogSeq({t, name.."Now, If you think you have what it takes,",
                                 name.."I need you to go back and slay the queen bee.",
                                 name.."But first, allow me to teach you a healing spell so you don't die to the queen bees sting attack",
                                }, 1)
            player:addSpell("Soothe")
            player:flushKills(9010)
            
        elseif player.quest["helper"] == 1 and killcount9010 < 10 then
            player:dialogSeq({t, name.."You need to slay ten!",
                                 name.."Please return when you've completed the task"}, 1)
        
        elseif player.quest["helper"] == 2 and killcount9012 >= 1 then
            player:dialogSeq({t, name.."Splendid job! I never doubted you for a second!"}, 1)
            player:addLegend("The bees knees"..curT(), "bees_knees", 11, 1)
            player:giveXP(4500)
            player:flushKills(9012)
            player.quest["helper"] = player.quest["helper"] + 1
            player.quest["choose_path"] = 1
        elseif player.quest["helper"] == 2 and killcount9012 < 1 then
            player:dialogSeq({t, name.."Hey! What are you doing?! Get back and kill the queen before they get out of control!"}, 1)

        elseif player.quest["choose_path"] == 1 and not player.registry["chose_path"] then
            player:dialogSeq({t, name.."The time has come! You need to choose your path. Choosing your path is your defining moment in this land.",
                                 name.."There are four paths to choose from: Warrior, Rogue, Mage, and Poet.",
                                 name.."A Warrior takes the brunt of the damage.",
                                 name.."A Rogue dishes it.",
                                 name.."Go now and speak to each of the trainers. See me after you have chosen your path."}, 1)
        --[[elseif player.quest["choose_path"] == 1 and player.registry["chose_path"] ~= 1 then
            player:dialogSeq({t, name.."Go now and speak to each of the trainers. Come back when you have chosen a path"}, 1)]]
        
        elseif player.registry["chose_path"] == 1 and player.quest["choose_path"] == 1 then
            player:dialogSeq({t, name.."Congratulations on your new path! You are no longer a simple peasant! May you keep doing good things areound here"}, 1)
            player.quest["choose_path"] = player.quest["choose_path"] - 1
        
        elseif player.registry["chose_path"] == 1 and player.quest["helper"] == 3 then
            player:dialogSeq({t, name.."Adventurer! There are reports of a large rat infestation coming from our western gates!",
                                 name.."Please, aid our townsfolk post haste! Go to the rat cave at (15,78) and slay 10 diseased rats."}, 1)
            player.quest["helper"] = player.quest["helper"] + 1
        
        elseif player.quest["helper"] == 4 and killcount9033 >= 10 then
            player:dialogSeq({t, name.."Well done! You sure are making your mark around these parts."}, 1)
            player:addLegend("A squeak easy " ..curT(), "squeak_easy", 11, 11)
            player:giveXP(6500)
            player:addGold(5000)
            player.quest["helper"] = player.quest["helper"] + 1
        
        elseif player.quest["helper"] == 4 and killcount9033 < 10 then
            player:dialogSeq({t, name.."Good start, but you've still got work to do, come back after you slay 10 diseased rats..."}, 1)
        
        else
            player:dialogSeq({t, name.."It's good to see you again, but I feel like it's time for you to move on to new adventures!"}, 0)
        end
    end
)
}