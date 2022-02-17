-------------------------------------------------------
--   Spell: Advanced First Aid
--   Class: Fighter
--   Level: 80
--  Aether: 0
--  Magic Cost:420
-- DmgType: N/A
--    Type: Vita Recovery
-- Targets: Self
-- Effects: Heal Formula: 1200
-------------------------------------------------------
--    Desc: A Massive heal.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 06/06/2017
-------------------------------------------------------
advanced_first_aid = {
	on_learn = function(player)
		player.registry["learned_advanced_first_aid"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_advanced_first_aid"] = 0
	end,
	cast = function(player)
		local recoverAmount = 1200
		local level = player.level
		local anim = 5
		local sound = 3

		local magicCost = 420
		local aether = 0

		if not player:canCast(1, 1, 0) then
			return
		end
		if player.state == 1 or player.health <= 0 then
			return
		end
		if player.magic < magicCost then
			notEnoughMP(player)
			return
		end
		if player.health == player.maxHealth then
			player:sendMinitext("You are at Max Vita!!")
			return
		end
		player:sendAction(6, 20)
		player.magic = player.magic - magicCost
		player:sendAnimation(anim)
		player:playSound(sound)
		player:setAether("advanced_first_aid", aether)
		addHealth(player, recoverAmount)
		player:sendMinitext("You cast Advanced First Aid.  You heal yourself for " .. recoverAmount .. " Vita.")
	end,
	requirements = function(player)
		local level = 80
		local item = {0, 3068}
		local amounts = {4000, 10}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Advanced First Aid is a stronger healing spell.\nThis replaces your Minor First Aid.", txt}
		return level, item, amounts, desc
	end
}
