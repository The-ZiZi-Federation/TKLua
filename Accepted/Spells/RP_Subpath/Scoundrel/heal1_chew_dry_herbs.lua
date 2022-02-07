-------------------------------------------------------
--   Spell: Chew Dry Herbs
--   Class: Scoundrel
--   Level: 20
--  Aether: 0
-- MP Cost: player.maxMagic / 35
-- DmgType: N/A
--    Type: Vita Recovery
-- Targets: Self
-- Heal Formula: (maxHealth / 13) + 100
-------------------------------------------------------
--    Desc: A Signifigent heal.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 07/07/2017
-------------------------------------------------------
chew_dry_herbs = {
	on_learn = function(player)
		player.registry["learned_chew_dry_herbs"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_chew_dry_herbs"] = 0
	end,
	cast = function(player)
		local recoverAmount = (player.maxHealth / 13) + 100
		local magicCost = (player.maxMagic / 35)

		if recoverAmount > 800 then
			recoverAmount = 800
		end
		if magicCost > 250 then
			magicCost = 250
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
		player:sendAction(7, 20)
		player.magic = player.magic - magicCost
		player:sendAnimation(5)
		player:playSound(3)
		addHealth(player, recoverAmount)
		player:sendMinitext("You chew some herbs. You heal yourself for " .. recoverAmount .. " Vita.")
	end,
	requirements = function(player)
		local level = 20
		local item = {0, 3016, 3018, 3019}
		local amounts = {500, 10, 1, 1}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Chew Dry Herbs restores a moderate amount of health.", txt}
		return level, item, amounts, desc
	end
}
