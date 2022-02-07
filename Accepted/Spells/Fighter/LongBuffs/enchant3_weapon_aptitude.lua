-------------------------------------------------------
--   Spell: Weapon Aptitude
--   Class: Fighter
--   Level: 84
--  Aether: 0 Second
--    Cost: 1100
--    Type: Enchant Bonus
-- Targets: Self
-- Effects: Enchant Mult: 4x
--        : Flank: N/A
-------------------------------------------------------
--    Desc: Multiply your weapon's damage 4x.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 6/13/2017
-------------------------------------------------------
weapon_aptitude = {
	on_learn = function(player)
		player.registry["learned_weapon_aptitude"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_weapon_aptitude"] = 0
	end,
	cast = function(player)
		local magicCost = 1100
		local duration = 600000
		local sound = 31
		local anim = 83

		if not player:canCast(1, 1, 0) then
			return
		end
		if player:hasDuration("weapon_aptitude") then
			player:setDuration("weapon_aptitude", 0)
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
		player:setDuration("weapon_aptitude", duration)
		player:calcStat()
		player:sendMinitext("You cast Weapon Aptitude")
	end,
	recast = function(player)
		player.enchant = 5
	end,
	uncast = function(player)
		player:calcStat()
		player:sendMinitext("You have lost focus of your Weapon Proficiency")
	end,
	requirements = function(player)
		local level = 84
		local item = {6001}
		local amounts = {3}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Weapon Aptitude is a spell that enhances your skill and improves weapon damage!", txt}
		return level, item, amounts, desc
	end
}
