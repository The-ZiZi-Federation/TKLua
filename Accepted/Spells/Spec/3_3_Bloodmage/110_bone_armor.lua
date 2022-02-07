-------------------------------------------------------
--   Spell: Bone Armor
--   Class: Necromancer
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
bone_armor = {
	on_learn = function(player)
		player.registry["learned_bone_armor"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_bone_armor"] = 0
	end,
	cast = function(player)
		local magicCost = math.floor(player.maxMagic * 0.5)
		local aether = 60000
		local sound = 504
		local anim = 408
		local anim2 = 482
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
		player:setAether("bone_armor", aether)
		player:sendStatus()
		player:sendMinitext("You cast Bone Armor")
		player:sendAnimation(anim)
		player:sendAnimation(anim2)
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

		local desc = {"Bone Armor is a spell that will protect your target from damage.", txt}
		return level, item, amounts, desc
	end
}
