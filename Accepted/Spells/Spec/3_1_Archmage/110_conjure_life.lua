-------------------------------------------------------
--   Spell: Conjure Life
--   Class: Archmage
--   Level: 110
--  Aether: 0 seconds
-- MP Cost: 650
-- DmgType: N/A
--    Type: Vita Recovery
-- Targets: Self
-- Heal Formula: 2500
-------------------------------------------------------
--    Desc: A Significant heal.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 08/12/2017
-------------------------------------------------------
conjure_life = {
	on_learn = function(player)
		player.registry["learned_conjure_life"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_conjure_life"] = 0
	end,
	cast = function(player)
		local anim = 66
		local sound = 63
		local aether = 0

		local recoverAmount = 2500
		local magicCost = 650

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
		player:setAether("conjure_life", aether)
		addHealth(player, recoverAmount)
		player:sendMinitext("You cast Conjure Life.  You heal yourself for " .. recoverAmount .. " Vita.")
	end,
	requirements = function(player)
		local level = 5
		local item = {0}
		local amounts = {50000}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Conjure Life is an Archmage's self-healing spell.", txt}
		return level, item, amounts, desc
	end
}
