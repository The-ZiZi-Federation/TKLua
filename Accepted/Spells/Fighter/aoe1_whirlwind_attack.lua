-------------------------------------------------------
--   Spell: Whirlwind Attack
--   Class: Fighter
--   Level: 50
--  Aether: 14 Second
--    Cost: (player.maxMagic * 0.35)
-- DmgType: Physical
--    Type: Offensive
-- Targets: 8
--			X X X
--			x P X
--			X X X
-- Effects: N/A
-------------------------------------------------------
--    Desc: You heft your blade and spin a full 360
-- 			cleaving anyone in the way for heavy damage.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 07/07/2017
-------------------------------------------------------
whirlwind_attack = {
	on_learn = function(player)
		player.registry["learned_whirlwind_attack"] = 1
		player:removeSpell("cleave")
		player:removeSpell("great_cleave")
	end,
	on_forget = function(player)
		player.registry["learned_whirlwind_attack"] = 0
	end,
	cast = function(player)
		----------------------
		--Varable Declarations
		----------------------
		local magicCost = (player.maxMagic * 0.15)
		--local aether = 12000
		local aether = 14000
		local sound = 84
		local anim = 7

		local mobBlocks = player:getObjectsInArea(BL_MOB)
		local pcBlocks = player:getObjectsInArea(BL_PC)

		local targets = {}

		local threat

		local m = player.m
		local x = player.x
		local y = player.y

		---------------------------
		--- Spell Damage Formula---
		---------------------------

		local damage
		-------------------------------------------
		if (not player:canCast(1, 1, 0)) then
			return
		end
		--------------------------------------------
		if (player.magic < magicCost) then
			player:sendMinitext("Not enough mana.")
			return
		end
		---------------------------------------------
		for i = 1, #mobBlocks do
			if (distanceSquare(player, mobBlocks[i], 1) and mobBlocks[i].ID ~= player.ID) then
				table.insert(targets, mobBlocks[i])
			end
		end

		for i = 1, #pcBlocks do
			if (distanceSquare(player, pcBlocks[i], 1) and pcBlocks[i].ID ~= player.ID) then
				table.insert(targets, pcBlocks[i])
			end
		end

		if #targets > 0 then
			player.magic = player.magic - magicCost
			player:sendMinitext("You cast Whirlwind Attack.")
			player:sendStatus()
			player:sendAction(1, 20)
			player:setAether("whirlwind_attack", aether)
			player:playSound(sound)
		end

		for i = 1, #targets do
			player.critChance = 1
			damage = ((0.03 * player.maxHealth) + (0.1 * player.level) + swingDamage(player, targets[i], 2)) * 4.5
			if (targets[i] ~= nil and targets[i].blType == BL_MOB) then
				targets[i].attacker = player.ID
				threat = targets[i]:removeHealthExtend(damage, 1, 1, 0, 1, 2)
				player:addThreat(targets[i].ID, threat)
				targets[i]:removeHealthExtend(damage, 1, 1, 0, 1, 1)
				targets[i]:sendAnimation(anim)
			elseif (targets[i] ~= nil and targets[i].blType == BL_PC and player:canPK(targets[i])) then
				targets[i].attacker = player.ID
				targets[i]:removeHealthExtend(damage, 1, 1, 0, 1, 1)
				targets[i]:sendMinitext(player.name .. " slashes wildly at you.")
				targets[i]:sendAnimation(anim)
			end
		end
	end,
	requirements = function(player)
		local level = 38
		local item = {0, 50, 6032}
		local amounts = {1500, 50, 5}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Whirlwind Attack is a sweeping slash that strikes enemies all around you.", txt}
		return level, item, amounts, desc
	end
}
