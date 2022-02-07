-------------------------------------------------------
--   Spell: Magus Heal
--   Class: Wizard
--   Level: 80
--  Aether: 0
--    Cost: 420
-- DmgType: N/A
--    Type: Heal
-- Targets: Self
-- Effects: Heal Formula: 1600
-------------------------------------------------------
--    Desc: A Massive heal.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 07/07/2017
-------------------------------------------------------
magus_heal = {
	on_learn = function(player)
		player.registry["learned_magus_heal"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_magus_heal"] = 0
	end,
	cast = function(player)
		local magicCost = 420
		local heal = 1600
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
		player:sendStatus()
		player:sendAnimation(5)
		player:setAether("magus_heal", aether)
		player:playSound(3)
		addHealth(player, heal)
		player:sendMinitext("You cast Magus Heal.  You heal yourself for " .. heal .. " Vita.")
	end,
	requirements = function(player)
		local level = 80
		local item = {0, 3068, 6001, 50}
		local amounts = {5000, 10, 1, 50}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Magus Heal is a spell that uses powerful magic to heal a large amount of health!", txt}
		return level, item, amounts, desc
	end
}
