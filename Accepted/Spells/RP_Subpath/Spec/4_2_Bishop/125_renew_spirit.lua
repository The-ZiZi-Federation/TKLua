-------------------------------------------------------
--   Spell: Renew Spirit
--   Class: Bishop
--   Level: 125
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
renew_spirit = {
	on_learn = function(player)
		player.registry["learned_renew_spirit"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_renew_spirit"] = 0
	end,
	cast = function(player, target)
		local magicCost = math.floor(player.maxMagic * 0.1)
		local aether = 5000
		local sound = 92
		local anim = 77

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
		player:sendStatus()
		player:sendMinitext("You cast Renew Spirit")

		target:sendAnimation(anim)
		target:flushAether()
		player:setAether("renew_spirit", aether)
		target:calcStat()
		target:sendMinitext(player.name .. " has Renewed your Spirit")
	end,
	requirements = function(player)
		local level = 125
		local item = {0}
		local amounts = {100000}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Renew Spirit is a spell that will remove the Aethers from an ally.", txt}
		return level, item, amounts, desc
	end
}
