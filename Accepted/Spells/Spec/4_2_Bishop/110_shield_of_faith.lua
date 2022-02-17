-------------------------------------------------------
--   Spell: Shield of Faith
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
shield_of_faith = {
	on_learn = function(player)
		player.registry["learned_shield_of_faith"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_shield_of_faith"] = 0
	end,
	cast = function(player, target)
		local magicCost = math.floor(player.maxMagic * 0.666)
		local aether = 60000
		local sound = 80
		local anim = 87
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
		player:setAether("shield_of_faith", aether)
		player:sendStatus()
		player:sendMinitext("You cast Shield of Faith")

		target:sendAnimation(anim)
		target.dmgShield = shieldAmount
		target:sendMinitext(player.name .. " cast Shield of Faith on you")
	end,
	requirements = function(player)
		local level = 5
		local item = {0}
		local amounts = {50000}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Shield of Faith is a spell that will protect your target from damage.", txt}
		return level, item, amounts, desc
	end
}
