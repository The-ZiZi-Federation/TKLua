-------------------------------------------------------
--   Spell: Herbal Stimulant
--   Class: Scoundrel
--   Level: 79
--  Aether: 0
--    Cost: 420
-- DmgType: N/A
--    Type: Vita Recovery
-- Targets: Self
-- Effects: Heal 1400
-------------------------------------------------------
--    Desc: A Massive heal.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 07/07/2017
-------------------------------------------------------
herbal_stimulant = {
	on_learn = function(player)
		player.registry["learned_herbal_stimulant"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_herbal_stimulant"] = 0
	end,
	cast = function(player)
		local healAmount = 1400
		local magicCost = 420
		local sound = 3
		local anim = 5

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
		player:sendAction(7, 20)
		player.magic = player.magic - magicCost
		player:sendAnimation(anim)
		player:playSound(sound)
		addHealth(player, healAmount)
		player:sendMinitext("You chew an Herbal Stimulant. You heal yourself for " .. healAmount .. " Vita.")
	end,
	requirements = function(player)
		local level = 79
		local item = {0, 296, 3033}
		local amounts = {4000, 1, 30}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Herbal Stimulant recovers a lot of health.\nReplaces Chew Dry Herbs.", txt}
		return level, item, amounts, desc
	end
}
