-------------------------------------------------------
--   Spell: Apprentice Heal
--   Class: Wizard
--   Level: 16
--  Aether: 0
-- MP Cost: player.maxMagic / 35
-- DmgType: N/A
--    Type: Vita Recovery
-- Targets: Self
-- Heal Formula: (player.maxHealth / 10) + 100
-------------------------------------------------------
--    Desc: A decent heal.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 07/07/2017
-------------------------------------------------------
apprentice_heal = {
	on_learn = function(player)
		player.registry["learned_apprentice_heal"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_apprentice_heal"] = 0
	end,
	cast = function(player)
		local recoverAmount = (player.maxHealth / 10) + 100
		local magicCost = (player.maxMagic / 35)
		local aether = 0

		if magicCost > 275 then
			magicCost = 275
		end
		if recoverAmount > 950 then
			recoverAmount = 950
		end

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
		player:setAether("apprentice_heal", aether)
		player:playSound(3)
		addHealth(player, recoverAmount)
		player:sendMinitext("You cast Apprentice Heal.  You heal yourself for " .. recoverAmount .. " Vita.")
	end,
	requirements = function(player)
		local level = 16
		local item = {0, 3016, 3017, 3018, 3019}
		local amounts = {3500, 5, 5, 1, 1}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Apprentice Heal is an improved healing spell.", txt}
		return level, item, amounts, desc
	end
}
