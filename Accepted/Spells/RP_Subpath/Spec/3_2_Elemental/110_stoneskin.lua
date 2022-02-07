-------------------------------------------------------
--   Spell: Stone Skin
--   Class: Elemental
--   Level: 110
--  Aether: 5 min
--    Cost: 10% mana
-- DmgType: N/A
--    Type: Heal
-- Targets: Self
-- Effects: Protect target from damage until shield breaks!
-------------------------------------------------------
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 08/12/2017
-------------------------------------------------------
stoneskin = {
	on_learn = function(player)
		player.registry["learned_stone_skin"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_stone_skin"] = 0
	end,
	cast = function(player)
		local magicCost = math.floor(player.maxMagic * 0.5)
		local aether = 60000
		local sound = 368
		local anim = 380
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
		player:setAether("stone_skin", aether)
		player:sendStatus()
		player:sendMinitext("You cast Stone Skin")
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

		local desc = {"Stone Skin is a spell that will protect your target from damage.", txt}
		return level, item, amounts, desc
	end
}
