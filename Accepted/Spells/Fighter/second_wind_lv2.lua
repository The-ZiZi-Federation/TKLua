-------------------------------------------------------
--   Spell: Second Wind Lv2
--   Class: Fighter
--   Level: 110
--  Aether: 16 Seconds
--    Cost: 0 MP per Level
-- DmgType: N/A
--    Type: Mana Recovery
-- Targets: Self
-- Effects: Mana +55%
--        : Self Para for 2.5 Sec
-------------------------------------------------------
--    Desc: You take a moment to catch a second wind.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 6/13/2017
-------------------------------------------------------
second_wind_lv2 = {
	on_learn = function(player)
		player.registry["learned_second_wind_lv2"] = 1
		player:removeSpell("second_wind_lv1")
	end,
	on_forget = function(player)
		player.registry["learned_second_wind_lv2"] = 0
	end,
	cast = function(player)
		----------------------
		--Varable Declarations
		----------------------
		local aether = 16000
		local duration = 2500

		if (not player:canCast(1, 1, 0)) then
			return
		end

		if player.state ~= 1 then
			-- Action, Animation, Text, Sound ---
			player:setAether("second_wind_lv2", aether)
			player:playSound(84)
			player:sendMinitext("You start to get your Second Wind")
			player:setDuration("second_wind_lv2", duration)
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
		local manaReturned = player.maxMagic * .55
		-- Allow player to move --
		player.paralyzed = false
		-- Return Mana --
		player.magic = player.magic + manaReturned
		player:sendStatus()
		player:updateState()
		player:calcStat()
		-- Action, Animation, Text, Sound ---
		player:sendAction(10, 60)
		player:sendAnimation(295)
		player:playSound(67)
		player:sendMinitext("You feel refreshed and ready to fight!")
		player:sendMinitext("You have recovered " .. manaReturned .. " Mana!")
	end,
	requirements = function(player)
		local level = 110
		local item = {0}
		local amounts = {100000}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Take a break and get a more refreshing Second Wind to stay in the fight.\nReplaces Second Wind", txt}
		return level, item, amounts, desc
	end
}
