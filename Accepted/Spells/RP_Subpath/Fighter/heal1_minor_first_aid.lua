-------------------------------------------------------
--   Spell: Minor First Aid
--   Class: Fighter
--   Level: 20
--  Aether: 0 seconds
-- MP Cost: Total Mana / 35                 No more than 250 Mana Cost.
-- DmgType: N/A
--    Type: Vita Recovery
-- Targets: Self
-- Heal Formula: (Target Vita / 20) + 50    No more than 510 HP Gained.
-------------------------------------------------------
--    Desc: A Significant heal.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 07/07/2017
-------------------------------------------------------
minor_first_aid = {
	on_learn = function(player)
		player.registry["learned_minor_first_aid"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_minor_first_aid"] = 0
	end,
	cast = function(player)
		local anim = 5
		local sound = 3
		local aether = 0

		local manaLost = (player.maxMagic / 35)
		if manaLost > 250 then
			manaLost = 250
		end

		local recoverAmount = (player.maxHealth / 20) + 50
		if recoverAmount > 510 then
			recoverAmount = 510
		end

		local magicCost = manaLost

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
		player:setAether("minor_first_aid", aether)
		addHealth(player, recoverAmount)
		player:sendMinitext("You cast Minor First Aid.  You heal yourself for " .. recoverAmount .. " Vita.")
	end,
	requirements = function(player)
		local level = 20
		local item = {0, 53, 50, 248}
		local amounts = {4000, 50, 35, 3}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Minor First Aid is an intermediate healing spell.", txt}
		return level, item, amounts, desc
	end
}
