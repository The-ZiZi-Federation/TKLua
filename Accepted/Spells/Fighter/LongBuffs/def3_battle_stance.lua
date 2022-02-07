-------------------------------------------------------
--   Spell: Battle Stance
--   Class: Fighter
--   Level: 86
--  Aether: 0 Seconds
--  MagicCost: (player.maxMagic * 0.05) + (player.level * 2.5)
-- DmgType: N/A
--    Type: Physical Buff
-- Targets: Self
-- Effects: Armor * 0.25
-------------------------------------------------------
--    Desc: Boost your Armor.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 06/13/2017
-------------------------------------------------------
battle_stance = {
	on_learn = function(player)
		player.registry["learned_battle_stance"] = 1
		player:removeSpell("bolster_armor")
		player:removeSpell("bolster_spirit")
	end,
	on_forget = function(player)
		player.registry["learned_battle_stance"] = 0
	end,
	cast = function(player)
		local magicCost = (player.maxMagic * 0.05) + (player.level * 2.5)
		local duration = 600000

		if not player:canCast(1, 1, 0) then
			return
		end
		if player:hasDuration("battle_stance") then
			player:setDuration("battle_stance", 0)
			return
		end
		if player.magic < magicCost then
			notEnoughMP(player)
			return
		end

		player:sendAction(6, 20)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:sendAnimation(326)
		player:playSound(37)
		player:setDuration("battle_stance", duration)
		player:calcStat()
		player:sendMinitext("You take a Battle Stance")
	end,
	recast = function(player)
		player.might = player.might + (player.level / 15)
		player.armor = player.armor + (player.armor * 0.25)
	end,
	uncast = function(player)
		player:calcStat()
		player:sendMinitext("Your stance has been broken")
	end,
	requirements = function(player)
		local level = 86
		local item = {0, 423, 392}
		local amounts = {100000, 30, 20}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Take a stance that increases your offensive and defensive capabilities.\nReplaces Bolster Spirit", txt}
		return level, item, amounts, desc
	end
}
