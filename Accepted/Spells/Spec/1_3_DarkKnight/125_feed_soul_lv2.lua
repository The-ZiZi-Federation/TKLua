-------------------------------------------------------
--   Spell: Feed Soul Lv2
--   Class: DarkKnight
--   Level: 125
--  Aether: 0 seconds
-- MP Cost: 1000
-- DmgType: N/A
--    Type: Vita Recovery
-- Targets: Self
-- Heal Formula: 5000
-------------------------------------------------------
--    Desc: A Significant heal.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 08/12/2017
-------------------------------------------------------
feed_soul_lv2 = {
	on_learn = function(player)
		player.registry["learned_feed_soul_lv2"] = 1
		player:removeSpell("feed_soul")
	end,
	on_forget = function(player)
		player.registry["learned_feed_soul_lv2"] = 0
	end,
	cast = function(player)
		local anim = 141
		local sound = 512
		local aether = 0

		local recoverAmount = 5000
		local magicCost = 1000

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
		player:setAether("feed_soul_lv2", aether)
		addHealth(player, recoverAmount)
		player:sendMinitext("You cast Feed Soul Lv2.  You heal yourself for " .. recoverAmount .. " Vita.")
	end,
	requirements = function(player)
		local level = 125
		local item = {0}
		local amounts = {100000}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Feed Soul Lv2 is an improved version of Feed Soul.", txt}
		return level, item, amounts, desc
	end
}
