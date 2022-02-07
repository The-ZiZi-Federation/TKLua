might = {
    on_learn = function(player)
        player.registry["learned_might"] = 1
    end,
    on_forget = function(player)
        player.registry["learned_might"] = 0
    end,
    cast = function(player)
        local magicCost = 1000
        local anim = 10
        local sound = 10

        if not player:canCast(1, 1, 0) then
            return
        end
        if player.magic < magicCost then
            notEnoughMP(player)
            return
        end

        if player:hasDuration("might") then
            anim(player)
            player:sendMinitext("Spell already cast!")
            return
        else
            player:sendAction(6, 20)
            player.magic = player.magic - magicCost
            player:sendStatus()
            player:sendAnimation(anim)
            player:playSound(sound)
            player:setDuration("might", 60000)
            player:calcStat()
            player:sendMinitext("You cast Might")
        end
    end,
    recast = function(player)
        player.might = player.might + 3
    end,
    uncast = function(player)
        player.might = player.might - 3
        player:calcStat()
    end,
    requirements = function(player)
        local txt
        txt = "- 50 Chesnut \n"
        txt = txt .. "- 20 Snake meat \n"
        txt = txt .. "- 200 Gold\n"

        local level = 15
        local item = {43, 49, 0}
        local amounts = {50, 20, 200}
        local desc = {"Might +3", "To learn this spell you must to sacriface\n" .. txt .. ""}
        return level, item, amounts, desc
    end
}
