-------------------------------------------------------
--   Spell: Mana of Heaven
--   Class: Bishop
--   Level: 110
--  Aether: 5 min
--    Cost: 10% mana
-- DmgType: N/A
--    Type: Heal
-- Targets: Self
-- Effects: Removes aethers
-------------------------------------------------------
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 08/12/2017
-------------------------------------------------------
mana_of_heaven = {
	on_learn = function(player)
		player.registry["learned_mana_of_heaven"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_mana_of_heaven"] = 0
	end,
	cast = function(player, target)
		local magicCost = math.floor(player.maxMagic * 0.025)
		local aether = 30000
		local sound = 74
		local anim = 72
		local duration = 10000

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
		player:setAether("mana_of_heaven", aether)
		player:sendStatus()
		player:sendMinitext("You cast Mana of Heaven")

		target:sendAnimation(anim)
		target:setDuration("mana_of_heaven", duration)
		target:sendMinitext(player.name .. " cast Mana of Heaven on you")
	end,
	while_cast = function(player)
		local restoreAmount = math.floor(player.maxMagic * 0.02)
		local anim = 528

		player:sendAnimation(anim)
		player.magic = player.magic + restoreAmount
		player:sendStatus()
	end,
	requirements = function(player)
		local level = 5
		local item = {0}
		local amounts = {50000}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Mana of Heaven regenerates the target's mana.", txt}
		return level, item, amounts, desc
	end
}
