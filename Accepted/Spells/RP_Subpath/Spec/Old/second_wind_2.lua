--[[
-------------------------------------------------------
--   Spell: Second Wind Lv2                   
--   Class: Fighter
--   Level: 125
--  Aether: 20 Seconds
--    Cost: 0 MP per Level
-- DmgType: N/A
--    Type: Mana Recovery
-- Targets: Self
-- Effects: Mana +30% + Will Bonus %
--        : Self Para for 3.5 Sec
-------------------------------------------------------
--    Desc: You take a moment to catch a second wind.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 12/11/2016
-------------------------------------------------------
second_wind_2 = {
	
    on_learn = function(player) 
		player.registry["learned_second_wind_2"] = 1
		if player:hasSpell("second_wind") then player:removeSpell("second_wind") end
	end,
	
    on_forget = function(player) player.registry["learned_second_wind_2"] = 0 end,	

cast = function(player)
	----------------------
	--Varable Declarations
	----------------------	
	local aether = 20000
	local duration = 3500

	if (not player:canCast(1, 1, 0)) then
		return
	end

	if player.state ~= 1 then
		-- Action, Animation, Text, Sound ---
		player:setAether("second_wind_2", aether)
		player:playSound(84)
		player:sendMinitext("You start to get your Second Wind")
		player:setDuration("second_wind_2", duration)
		-- Freeze the player --
		player.paralyzed = true
	else
		-- Player is Dead --
		player:sendMinitext("You can't catch a second wind if you're dead")
	end
end,

while_cast = function(player)
	-- Keep player still and play animations.
	player.paralyzed = true
	player:sendAction(5, 400)
	player:sendAnimation(367)
	
end,

uncast = function(player)
	----------------------
	--Varable Declarations
	----------------------
	local manaReturnedBase = .3
	local manaReturnAmount
	local willBonusPct
	local will = player.will
	
	willBonusPct = math.floor((((will/(will+50))^1.1)))
	------------------------------
	-- Calculate Mana to Return --
	------------------------------
	manaReturnTotPct = manaReturnedBase + willBonusPct
	manaReturnAmount = math.floor(player.maxMagic * manaReturnTotPct)
	
	
	-- Allow player to move --
	player.paralyzed = false
	-- Return Mana --
	player.magic = player.magic + manaReturnAmount
	player:sendStatus()
	player:updateState()
	player:calcStat()
	-- Action, Animation, Text, Sound ---
	player:sendAction(10, 60)
	player:sendAnimation(295)
	player:playSound(67)
	player:sendMinitext("You feel refreshed and ready to fight!")
	player:sendMinitext("You have recovered "..manaReturnAmount.." Mana!")
end
}]]
--
