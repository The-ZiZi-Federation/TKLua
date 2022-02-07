-------------------------------------------------------
--   Spell: Mana Shield
--   Class: Archmage
--   Level: 110
--  Aether: 5 min
--    Cost: 50% mana
-- DmgType: N/A
--    Type: Heal
-- Targets: Self
-- Effects: Protect target from damage until shield breaks!
-------------------------------------------------------
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 08/12/2017
-------------------------------------------------------
mana_shield = {
	on_learn = function(player)
		player.registry["learned_mana_shield"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_mana_shield"] = 0
	end,
	cast = function(player)
		local magicCost = math.floor(player.maxMagic * 0.5)
		local aether = 60000
		local sound = 740
		local anim = 334

		local shieldAmount = math.floor(magicCost * 1.5)

		if not player:canCast(1, 1, 0) then
			return
		end
		if player.magic < magicCost then
			notEnoughMP(player)
			return
		end

		player:sendAction(6, 20)
		player.magic = player.magic - magicCost
		player:playSound(sound)
		player:setAether("mana_shield", aether)
		player:sendStatus()
		player:sendMinitext("You cast Mana Shield")

		player:sendAnimation(anim)
		player.dmgShield = shieldAmount
	end,
	requirements = function(player)
		local level = 5
		local item = {0}
		local amounts = {50000}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Mana Shield is a spell that will protect your target from damage.", txt}
		return level, item, amounts, desc
	end
}
