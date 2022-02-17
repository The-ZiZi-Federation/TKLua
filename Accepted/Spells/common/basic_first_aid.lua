-------------------------------------------------------
--   Spell: Basic First Aid
--   Class: All
--   Level: 1
--  Aether: 0 Second
--    Cost: Total MP / 25
-- DmgType: N/A
--    Type: Heal
-- Targets: Self
-- Heal Formula: (Total Vita / 20 ) + 25
-------------------------------------------------------
--    Desc: Self Heal
-------------------------------------------------------
-- Script Author: John Day / John Crandell
--   Last Edited: 06/06/2017
-------------------------------------------------------
basic_first_aid = {
	on_learn = function(player)
		player.registry["learned_basic_first_aid"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_basic_first_aid"] = 0
	end,
	cast = function(player)
		local anim = 5
		local sound = 708

		local magicCost = (player.maxMagic / 35)
		if magicCost > 75 then
			magicCost = 75
		end

		local recoverAmount = (player.maxHealth / 20) + 10
		if recoverAmount > 150 then
			recoverAmount = 150
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
		player:sendAnimation(anim)
		player:playSound(sound)
		addHealth(player, recoverAmount)
		player:sendMinitext("You cast Basic First Aid.  You heal yourself for " .. recoverAmount .. " Vita.")
	end
}
