-------------------------------------------------------
--   Spell: Bolster Armor
--   Class: Fighter
--   Level: 15
--  Aether: 0 Seconds
--    Cost: (player.level * 15) + (player.maxMagic / 25)
-- DmgType: N/A
--    Type: Armor Buff
-- Targets: Self
-- Effects: (Level * 15) + (MaxMagic * 0.25)
-------------------------------------------------------
--    Desc: Boost your Armor.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 6/13/2017
-------------------------------------------------------
bolster_armor = {
	on_learn = function(player)
		player.registry["learned_bolster_armor"] = 1
		player:removeSpell("bolster_spirit")
		player:removeSpell("battle_stance")
	end,
	on_forget = function(player)
		player.registry["learned_bolster_armor"] = 0
	end,
	cast = function(player)
		local magicCost = (player.level * 15) + (player.maxMagic / 25)
		local duration = 600000

		local bolsterArmorBonus = (player.level * 15) + (player.maxMagic * 0.25)

		if not player:canCast(1, 1, 0) then
			return
		end
		if player.magic < magicCost then
			notEnoughMP(player)
			return
		end
		if player:hasDuration("bolster_armor") then
			alreadyCast(player)
			return
		end

		player.registry["bolster_armor_bonus"] = bolsterArmorBonus
		player:sendAction(6, 20)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:sendAnimation(21)
		player:playSound(26)
		player:setDuration("bolster_armor", duration)
		player:calcStat()
		player:sendMinitext("You cast Bolster Armor")
		if player.registry["extra_spell_info"] == 1 then
			player:sendMinitext("Armor Bonus: +" .. bolsterArmorBonus)
		end
	end,
	recast = function(player)
		local bolsterArmorBonus = player.registry["bolster_armor_bonus"]

		player.armor = player.armor + bolsterArmorBonus
	end,
	uncast = function(player)
		local bolsterArmorBonus = player.registry["bolster_armor_bonus"]

		player.armor = player.armor - bolsterArmorBonus

		player:calcStat()
		player:sendMinitext("Your armor bonus fades")
	end,
	requirements = function(player)
		local level = 15
		local item = {0, 246}
		local amounts = {3500, 50}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"A spell that increases your Armor.", txt}
		return level, item, amounts, desc
	end
}
