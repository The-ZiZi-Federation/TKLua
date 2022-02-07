health_potion = {
    -------------------------------
    -- A Health Potion was used------
    -------------------------------
    use = function(player)
        ------------------------------
        -- Set Local Variables -------
        ------------------------------
        local recoverAmount
        local potDura
        local potionName

        local item = player:getInventoryItem(player.invSlot)
        local missingHealth = player.maxHealth - player.health

        -----------------------------------------------
        -- Something prevents the player from acting --
        -----------------------------------------------
        if player.health < 1 then
            player:sendMinitext("Ghosts can't drink potions")
            return
        end

        if not player:canAction(1, 1, 1) then
            player:sendMinitext("You cannot do that right now!")
            return
        else
            ----------------------------------------------
            -- Player not missing any health -------------
            ----------------------------------------------
            if missingHealth == 0 then
                player:sendMinitext("Health is already full!")
                return
            else
                ----------------------------------------------
                -- Player has the item drank in inventory  ---
                ----------------------------------------------
                if player:hasItem(item.yname, 1) == true then
                    -----------------------------------------
                    -- Potion is on cooldown still  ---------
                    -----------------------------------------
                    if player:hasDuration("health_potion") then
                        anim(player)
                        delay = player:getDuration("health_potion")
                        player:sendMinitext("Vita Potion Cooldown : " .. math.abs(delay / 1000) .. " sec")
                        return
                    end
                    -----------------------------------------------------------------------
                    -- Everything else checks out, set parameters based on item "Drank"----
                    -----------------------------------------------------------------------
                    -- make potions more effective based on the potion concocting level of the user.
                    if item.yname == "small_vita_potion" then
                        potDura = 2000 -- 2 seconds ua
                        recoverAmount = 500 -- + 500 HP
                    elseif item.yname == "minor_vita_potion" then
                        potDura = 3000 -- 3 seconds
                        recoverAmount = 2500 -- + 2,500 HP
                    elseif item.yname == "reg_vita_potion" then
                        potDura = 4000 -- 4 seconds
                        recoverAmount = 7500 -- + 7,500 HP
                    elseif item.yname == "strong_vita_potion" then
                        potDura = 5000 -- 5 seconds
                        recoverAmount = 25000 -- 25,000 HP
                    elseif item.yname == "greater_vita_potion" then
                        potDura = 8000 -- 8 seconds
                        recoverAmount = 50000 -- 50,000 HP
                    elseif item.yname == "superior_vita_potion" then
                        potDura = 10000 -- 10 Seconds
                        recoverAmount = 100000 -- 100,000 HP
                    else
                        return
                    end
                    ------------------------------------
                    -- Remove item from inventory ------
                    -- Adjust target stats and update --
                    ------------------------------------
                    local itemName = item.name
                    player.health = player.health + recoverAmount
                    player:sendMinitext("You used a " .. itemName)
                    player:removeItemSlot(player.invSlot, 1)
                    player:calcStat()
                    player:sendStatus()
                    --------------------------------------
                    -- Play animation, Send Message ------
                    --------------------------------------
                    player:playSound(3)
                    player:sendAnimation(422)
                    player:setDuration("health_potion", potDura)
                    player:sendMinitext("You recovered " .. recoverAmount .. " Vita.")
                end
            end
        end
    end
}

master_health_potion = {
    --------------------------------------
    -- A Full Health Potion was used------
    --------------------------------------
    drink = function(player)
        ------------------------------
        -- Set Local Variables -------
        ------------------------------
        local recoverAmount
        local potDura
        local potionName

        local item = player:getInventoryItem(player.invSlot)
        local missingHealth = player.maxHealth - player.health
        -----------------------------------------------
        -- Something prevents the player from acting --
        -----------------------------------------------
        if not player:canAction(1, 1, 1) then
            player:sendMinitext("You cannot do that right now!")
            return
        else
            ----------------------------------------------
            -- Player not missing any health -------------
            ----------------------------------------------
            if missingHealth == 0 then
                player:sendMinitext("Health is already full!")
                return
            else
                ----------------------------------------------
                -- Player has the item drank in inventory  ---
                ----------------------------------------------
                if player:hasItem(item.yname, 1) == true then
                    -----------------------------------------
                    -- Potion is on cooldown still  ---------
                    -----------------------------------------
                    if player:hasDuration("master_health_potion") then
                        anim(player)
                        delay = player:getDuration("master_health_potion")
                        player:sendMinitext("Full Vita Potion Cooldown : " .. math.abs(delay / 1000) .. " sec")
                        return
                    end
                    -----------------------------------------------------------------------
                    -- Everything else checks out, set parameters based on item "Drank"----
                    -----------------------------------------------------------------------
                    if item.yname == "master_vita_potion" then
                        potDura = 300000 -- 300 seconds
                    end
                    ------------------------------------
                    -- Remove item from inventory ------
                    -- Adjust target stats and update --
                    ------------------------------------
                    local itemName = item.name
                    player.health = player.maxHealth
                    player:sendMinitext("You used a " .. itemName)
                    player:removeItemSlot(player.invSlot, 1)
                    player:calcStat()
                    player:sendStatus()
                    --------------------------------------
                    -- Play animation, Send Message ------
                    --------------------------------------
                    player:playSound(3)
                    player:sendAnimation(422)
                    player:setDuration("master_health_potion", potDura)
                    player:sendMinitext("You recovered " .. recoverAmount .. " Vita.")
                end
            end
        end
    end
}

mana_potion = {
    use = function(player)
        local recoverAmount
        local potDura

        local item = player:getInventoryItem(player.invSlot)
        local missingMagic = player.maxMagic - player.magic

        if not player:canAction(1, 1, 1) then
            player:sendMinitext("You cannot do that right now!")
            return
        else
            if missingMagic == 0 then
                player:sendMinitext("Mana is already full!")
                return
            else
                if player:hasItem(item.yname, 1) == true then
                    if player:hasDuration("mana_potion") then
                        anim(player)
                        delay = player:getDuration("mana_potion")
                        player:sendMinitext("Mana Potion Cooldown : " .. math.abs(delay / 1000) .. " sec")
                        return
                    end

                    if item.yname == "small_mana_potion" then
                        potDura = 2000
                        recoverAmount = 500
                    elseif item.yname == "minor_mana_potion" then
                        potDura = 3000
                        recoverAmount = 2500
                    elseif item.yname == "reg_mana_potion" then
                        potDura = 4000
                        recoverAmount = 7500
                    elseif item.yname == "strong_mana_potion" then
                        potDura = 5000
                        recoverAmount = 25000
                    elseif item.yname == "greater_mana_potion" then
                        potDura = 8000
                        recoverAmount = 50000
                    elseif item.yname == "superior_mana_potion" then
                        potDura = 10000
                        recoverAmount = 100000
                    else
                        return
                    end
                    ------------------------------------
                    -- Remove item from inventory ------
                    -- Adjust target stats and update --
                    ------------------------------------

                    player.magic = player.magic + recoverAmount
                    player:sendMinitext("You used a " .. item.name)
                    player:removeItemSlot(player.invSlot, 1)
                    player:calcStat()
                    player:sendStatus()
                    --------------------------------------
                    -- Play animation, Send Message ------
                    --------------------------------------
                    player:sendAction(8, 20)
                    player:playSound(6)
                    player:sendAnimation(335) -- others could be 249, 249, 117
                    player:setDuration("mana_potion", potDura)
                    player:sendMinitext("You recovered " .. recoverAmount .. " Mana.")
                end
            end
        end
    end
}

master_mana_potion = {
    use = function(player)
        local potDura

        local item = player:getInventoryItem(player.invSlot)
        local missingMagic = player.maxMagic - player.magic

        if not player:canAction(1, 1, 1) then
            player:sendMinitext("You cannot do that right now!")
            return
        else
            if missingMagic == 0 then
                player:sendMinitext("Mana is already full!")
                return
            else
                if player:hasItem(item.yname, 1) == true then
                    if player:hasDuration("master_mana_potion") then
                        anim(player)
                        local delay = player:getDuration("mana_potion")
                        player:sendMinitext("Full Mana Potion Cooldown : " .. math.abs(delay / 1000) .. " sec")
                        return
                    end

                    if item.yname == "master_mana_potion" then
                        potDura = 300000
                    else
                        return
                    end
                    ------------------------------------
                    -- Remove item from inventory ------
                    -- Adjust target stats and update --
                    ------------------------------------

                    player.magic = player.maxMagic
                    player:sendMinitext("You used a " .. item.name)
                    player:removeItemSlot(player.invSlot, 1)
                    player:calcStat()
                    player:sendStatus()
                    --------------------------------------
                    -- Play animation, Send Message ------
                    --------------------------------------
                    player:sendAction(8, 20)
                    player:playSound(6)
                    player:sendAnimation(335) -- others could be 249, 249, 117
                    player:setDuration("master_mana_potion", potDura)
                    player:sendMinitext("You recovered " .. recoverAmount .. " Mana.")
                end
            end
        end
    end
}
 --

--[[        OLD VERSION / TARGETED SPELL ATTEMPT
shattering_potion = {
-------------------------------
-- Shattering Potion was used--
-------------------------------
cast = function(player, target)
------------------------------
-- Set Local Variables -------
------------------------------
	local item = player:getInventoryItem(player.invSlot)
    local armorLossAmt
    local potDura
    local actionText
    -----------------------------------------------
    -- Something prevents the player from acting --
    -----------------------------------------------
	if not player:canAction(1, 1, 1) then
		player:sendMinitext("You cannot do that right now!")
	    return 
    else
        ----------------------------------------------
        -- Player has the item thrown in inventory ---
        ----------------------------------------------
	    if player:hasItem(item.yname, 1) == true then
            if player:hasDuration("shatter_potion") then
                anim(player)
                delay = player:getDuration("shatter_potion")
                player:sendMinitext("Cooldown : "..math.abs(delay/1000).." sec")
                return 
            end
            ---------------------------------------------
            -- The target cannot be a Player (for now) --
            ---------------------------------------------
            if target.bltype == BL_PC  then
                player:sendMinitext("Invalid Target!") 
                return 
            end
            -----------------------------------------------------------------------
            -- Everything else checks out, set parameters based on item "Thrown"---
            -----------------------------------------------------------------------
            if item.yname == "small_shattering_potion" then
                potDura = 30000                                                -- Cooldown of potion
                armorLossAmt = 10                                           -- Amount to reduce armor
                actionText = "The enemies armor was slightly lowered."      -- Special text for message box
            elseif item.yname == "minor_shattering_potion" then
                potDura = 60000
                armorLossAmt = 50
                actionText = "The enemies armor was slightly lowered."
            elseif item.yname == "shattering_potion" then
                potDura = 120000
                armorLossAmt = 150
                actionText = "The enemies armor was lowered."
            elseif item.yname == "strong_shattering_potion" then
                potDura = 240000
                armorLossAmt = 300
                actionText = "The enemies armor was lowered."
            elseif item.yname == "greater_shattering_potion" then
                potDura = 360000
                armorLossAmt = 600
                actionText = "The enemies armor was considerably lowered."
            elseif item.yname == "superior_shattering_potion" then
                potDura = 600000
                armorLossAmt = 999
                actionText = "The enemies armor was considerably lowered."
            elseif item.yname == "master_shattering_potion" then
                potDura = 3600000
                armorLossAmt = 2000
                actionText = "The enemies armor was obliterated."
            else
                -- Somehow an error occured
                return
            end
            ------------------------------------
            -- Remove item from inventory ------
            -- Adjust target stats and update --
            ------------------------------------
            player:removeItemSlot(player.invSlot, 1)
            target.armor = target.armor - armorLossAmt
            target:calcStat()
            target:sendStatus()
            --------------------------------------
            -- Play animation, Send Message ------
            --------------------------------------
            player:sendAction(2, 20)
            -- show splash on target / effect icon
            player:setDuration("shatter_potion", potDura)
            player:sendMinitext("You used a "..item.name)
            player:sendMinitext(actionText)  
        end
	end
end
}
]] shattering_potion = {
    --New version, 2/4/17

    cast = function(player)
        ----------------------
        --Varable Declarations
        ----------------------
        local delay, potDura, icon, color

        local m = player.m
        local x = player.x
        local y = player.y

        local anim = 13
        local sound = 341

        local item = player:getInventoryItem(player.invSlot)

        if item.yname == "small_shattering_potion" then
            icon = 2121
            color = 0
            potDura = 30000
            actionText = "The enemies armor was slightly lowered." -- Special text for message box
            spellEffectIdentifer = "small_shatter"
            effectDuration = 3000
        elseif item.yname == "minor_shattering_potion" then
            icon = 3487
            color = 0
            potDura = 60000
            actionText = "The enemies armor was slightly lowered."
            spellEffectIdentifer = "minor_shatter"
            effectDuration = 3000
        elseif item.yname == "reg_shattering_potion" then
            icon = 3561
            color = 22
            potDura = 120000
            actionText = "The enemies armor was lowered."
            spellEffectIdentifer = "reg_shatter"
            effectDuration = 3000
        elseif item.yname == "strong_shattering_potion" then
            icon = 1895
            color = 7
            potDura = 240000
            actionText = "The enemies armor was lowered."
            spellEffectIdentifer = "strong_shatter"
            effectDuration = 4000
        elseif item.yname == "greater_shattering_potion" then
            icon = 256
            color = 6
            potDura = 360000
            actionText = "The enemies armor was considerably lowered."
            spellEffectIdentifer = "greater_shatter"
            effectDuration = 6000
        elseif item.yname == "superior_shattering_potion" then
            icon = 1905
            color = 3
            potDura = 600000
            actionText = "The enemies armor was considerably lowered."
            spellEffectIdentifer = "superior_shatter"
            effectDuration = 8000
        elseif item.yname == "master_shattering_potion" then
            icon = 1916
            color = 6
            potDura = 3600000
            actionText = "The enemies armor was obliterated."
            spellEffectIdentifer = "master_shatter"
            effectDuration = 10000
        else
            -- Somehow an error occured
            return
        end

        if player:hasDuration("shattering_potion") then
            player:sendAnimation(246)
            delay = player:getDuration("shattering_potion")
            player:sendMinitext("Cooldown : " .. math.abs(delay / 1000) .. " sec")
            return
        end

        for i = 1, 6 do
            local mobTarget = getTargetFacing(player, BL_MOB, 0, i)
            local pcTarget = getTargetFacing(player, BL_PC, 0, i)

            if mobTarget ~= nil then
                if player:hasItem(item.yname, 1) == true then
                    player:removeItemSlot(player.invSlot, 1)
                    player:sendAction(2, 20)
                    if player.side == 0 then
                        if getPass(player.m, player.x, player.y - i) == 1 then
                            return
                        else
                            player:throw(player.x, player.y - i, icon, color, 1)
                        end
                    elseif player.side == 1 then
                        if getPass(player.m, player.x + i, player.y) == 1 then
                            return
                        else
                            player:throw(player.x + i, player.y, icon, color, 1)
                        end
                    elseif player.side == 2 then
                        if getPass(player.m, player.x, player.y + i) == 1 then
                            return
                        else
                            player:throw(player.x, player.y + i, icon, color, 1)
                        end
                    elseif player.side == 3 then
                        if getPass(player.m, player.x - i, player.y) == 1 then
                            return
                        else
                            player:throw(player.x - i, player.y, icon, color, 1)
                        end
                    end
                    mobTarget.attacker = player.ID
                    player:sendStatus()
                    player:playSound(sound)
                    mobTarget:sendAnimation(anim)
                    mobTarget.paralyzed = true
                    mobTarget:setDuration(spellEffectIdentifer, effectDuration)
                    player:setDuration("shattering_potion", potDura)
                    player:sendMinitext("You used a " .. item.name)
                    player:sendMinitext(actionText)
                    return
                end
            elseif pcTarget ~= nil then
            -- you can go ahead and add in the efects for player PK too.
            -- the spells were added to the DB and affect the armor value only in the script calculation.
            -- playerCombat.lua has been updated to take this into consideratoin, just needs uncommented.
            end
        end
    end
}

--------------------------------------------
-- Use the vita potions --------------------
--------------------------------------------
small_vita_potion = {
    use = function(player)
        health_potion.drink(player)
    end
}

minor_vita_potion = {
    use = function(player)
        health_potion.drink(player)
    end
}

reg_vita_potion = {
    use = function(player)
        health_potion.drink(player)
    end
}

strong_vita_potion = {
    use = function(player)
        health_potion.drink(player)
    end
}

greater_vita_potion = {
    use = function(player)
        health_potion.drink(player)
    end
}

superior_vita_potion = {
    use = function(player)
        health_potion.drink(player)
    end
}

master_vita_potion = {
    use = function(player)
        master_health_potion.drink(player)
    end
}
--------------------------------------------
-- Use the man potions --------------------
--------------------------------------------
small_mana_potion = {
    use = function(player)
        mana_potion.drink(player)
    end
}

minor_mana_potion = {
    use = function(player)
        mana_potion.drink(player)
    end
}

reg_mana_potion = {
    use = function(player)
        mana_potion.drink(player)
    end
}

strong_mana_potion = {
    use = function(player)
        mana_potion.drink(player)
    end
}

greater_mana_potion = {
    use = function(player)
        mana_potion.drink(player)
    end
}

superior_mana_potion = {
    use = function(player)
        mana_potion.drink(player)
    end
}

--   master_mana_potion = {
--
--    use = function(player)
--        master_mana_potion.drink(player)
--    end
--}
--------------------------------------------
-- Throw the shattering potions ------------
-- (Lower Enemy Armor) ---------------------
--------------------------------------------
small_shattering_potion = {
    use = function(player)
        shattering_potion.cast(player)
    end
}

minor_shattering_potion = {
    use = function(player)
        shattering_potion.cast(player)
    end
}

reg_shattering_potion = {
    use = function(player)
        shattering_potion.cast(player)
    end
}

strong_shattering_potion = {
    use = function(player)
        shattering_potion.cast(player)
    end
}

greater_shattering_potion = {
    use = function(player)
        shattering_potion.cast(player)
    end
}

superior_shattering_potion = {
    use = function(player)
        shattering_potion.cast(player)
    end
}

master_shattering_potion = {
    use = function(player)
        shattering_potion.cast(player)
    end
}
--------------------------------------------
-- Throw the sophoric potions --------------
-- (Lower Grace)       ---------------------
--------------------------------------------
