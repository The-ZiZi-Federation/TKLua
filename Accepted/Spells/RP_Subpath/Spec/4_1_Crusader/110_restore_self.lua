-------------------------------------------------------
--   Spell: Restore Self
--   Class: Crusader
--   Level: 110
--  Aether: 0 seconds
-- MP Cost: 5000
-- DmgType: N/A
--    Type: Vita Recovery
-- Targets: Self
-- Heal Formula: 50000
-------------------------------------------------------
--    Desc: A Significant heal.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 08/12/2017
-------------------------------------------------------
restore_self = {
	on_learn = function(player)
		player.registry["learned_restore_self"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_restore_self"] = 0
	end,
	cast = function(player)
		local anim = 340
		local sound = 125
		local aether = 30000

		local recoverAmount = 50000
		local magicCost = 5000

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
			player:sendMinitext("You are at Max Vita!")
			return
		end
		player:sendAction(6, 20)
		player.magic = player.magic - magicCost
		player:sendAnimation(anim)
		player:playSound(sound)
		player:setAether("restore_self", aether)
		addHealth(player, recoverAmount)
		player:sendMinitext("You cast Restore Self.")
	end,
	requirements = function(player)
		local level = 5
		local item = {0}
		local amounts = {50000}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Restore Self is a Crusader's self-healing spell.", txt}
		return level, item, amounts, desc
	end
}
