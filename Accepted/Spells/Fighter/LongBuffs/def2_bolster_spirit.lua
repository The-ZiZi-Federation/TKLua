-------------------------------------------------------
--   Spell: Bolster Spirit
--   Class: Fighter
--   Level: 60
--  Aether: 0 Seconds
--  MagicCost: (level * 15) + (maxMagic / 30)
-- DmgType: N/A
--    Type: Physical Buff
-- Targets: Self
-- Effects: (Level * 15) + (maxMagic * 0.3)
-------------------------------------------------------
--    Desc: Boost your Armor.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 07/07/2017
-------------------------------------------------------
bolster_spirit = {
	on_learn = function(player)
		player.registry["learned_bolster_spirit"] = 1
		player:removeSpell("bolster_armor")
		player:removeSpell("battle_stance")
	end,
	on_forget = function(player)
		player.registry["learned_bolster_spirit"] = 0
	end,
	cast = function(player, target)
		local magicCost = (player.level * 15) + (player.maxMagic / 30)
		local duration = 600000

		if not player:canCast(1, 1, 0) then
			return
		end
		if player:hasDuration("bolster_spirit") then
			player:setDuration("bolster_spirit", 0)
			return
		end
		if player.magic < magicCost then
			notEnoughMP(player)
			return
		end
		player:sendAction(6, 20)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:sendAnimation(21)
		player:playSound(26)
		player:setDuration("bolster_spirit", duration)

		player:calcStat()
		player:sendMinitext("You cast Bolster Spirit")
		if player.registry["extra_spell_info"] > 0 then
			player:sendMinitext("Total Armor Bonus: +" .. armorBonus)
		end
	end,
	recast = function(player)
		local armorBonus = (player.level * 15) + (player.maxMagic * 0.3)
		player.armor = player.armor + armorBonus
	end,
	uncast = function(player)
		player:calcStat()
		player:sendMinitext("Your armor bonus fades")
	end,
	requirements = function(player)
		local level = 60
		local item = {0, 294}
		local amounts = {50000, 45}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"A spell that focuses your spirit to further bolster your armor.\nReplaces Bolster Armor.", txt}
		return level, item, amounts, desc
	end
}
