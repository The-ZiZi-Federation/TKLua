-------------------------------------------------------
--   Spell: Divine Weapon
--   Class: Priest
--   Level: 242
--  Aether: 0 Second
--    Cost: (player.level * 10) + (player.maxMagic / 25)
--    Type: Enchant Bonus
-- Targets: Self
-- Effects: Enchant Mult: 16-18x
--        : Flank: N/A
-------------------------------------------------------
--    Desc: Multiply your weapon's damage 16-18x.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 6/6/2017
-------------------------------------------------------
divine_weapon = {
	on_learn = function(player)
		player.registry["learned_divine_weapon"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_divine_weapon"] = 0
	end,
	cast = function(player)
		local magicCost = (player.maxMagic / 15)
		local duration = 600000
		local sound = 31
		local anim = 80

		if not player:canCast(1, 1, 0) then
			return
		end
		if player:hasDuration("divine_weapon") then
			player:setDuration("divine_weapon", 0)
			return
		end
		if player.magic < magicCost then
			notEnoughMP(player)
			return
		end

		player:sendAction(6, 20)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:sendAnimation(anim)
		player:playSound(sound)
		player:setDuration("divine_weapon", duration)
		player:calcStat()
		player:sendMinitext("You cast Divine Weapon")
	end,
	recast = function(player)
		if player.level < 246 then
			player.enchant = 18
		elseif player.level >= 246 then
			player.enchant = 20
		end
	end,
	uncast = function(player)
		player:calcStat()
		player:sendMinitext("You have lost focus on your Divine Weapon")
	end,
	requirements = function(player)
		local level = 242
		local item = {0}
		local amounts = {0}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Divine Weapon is a spell that enhances your skill and improves weapon damage!", txt}
		return level, item, amounts, desc
	end
}
