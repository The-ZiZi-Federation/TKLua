-------------------------------------------------------
--   Spell: Cleave (Whirlwind Attack Lvl. 2)
--   Class: Fighter
--   Level: 62
--  Aether: 16 Seconds
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
-- 			cleavng anyone in the way for heavy damage.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 11/02/2016
-------------------------------------------------------
cleave = {
	on_learn = function(player)
		player.registry["learned_cleave"] = 1
		player:removeSpell("whirlwind_attack")
		player:removeSpell("great_cleave")
	end,
	on_forget = function(player)
		player.registry["learned_cleave"] = 0
	end,
	cast = function(player)
		----------------------
		--Varable Declarations
		----------------------
		local magicCost = player.maxMagic * 0.15
		local aether = 14000
		local sound = 84
		local anim = 7

		local m = player.m
		local x = player.x
		local y = player.y
		local threat

		local mobBlocks = player:getObjectsInArea(BL_MOB)
		local pcBlocks = player:getObjectsInArea(BL_PC)

		local targets = {}
		local threat

		local damage
		--------------------------------------------------------------------------------------
		if (not player:canCast(1, 1, 0)) then
			return
		end
		--------------------------------------------------------------------------------------
		if (player.magic < magicCost) then
			player:sendMinitext("Not enough mana.")
			return
		end
		--------------------------------------------------------------------------------------
		player:sendAction(1, 20)
		player:setAether("cleave", aether)
		player:playSound(sound)
		player:sendMinitext("You cast Cleave.")

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

		if (#targets > 0) then
			player.magic = player.magic - magicCost
			player:sendStatus()

			for i = 1, #targets do
				player.critChance = 1
				damage = ((0.15 * player.maxHealth) + (0.1 * player.level) + swingDamage(player, targets[i], 2)) * 7.25
				if (targets[i] ~= nil and targets[i].blType == BL_MOB) then
					targets[i].attacker = player.ID
					threat = targets[i]:removeHealthExtend(damage, 1, 1, 0, 1, 2)
					player:addThreat(targets[i].ID, threat)
					targets[i]:removeHealthExtend(damage, 1, 1, 0, 1, 1)
					targets[i]:sendAnimation(anim)
				elseif (targets[i] ~= nil and targets[i].blType == BL_PC and player:canPK(targets[i])) then
					targets[i].attacker = player.ID
					targets[i]:removeHealthExtend(damage, 1, 1, 0, 1, 1)
					targets[i]:sendMinitext(player.name .. " cleaves you.")
					targets[i]:sendAnimation(anim)
				end
			end
		end
	end,
	requirements = function(player)
		local level = 62
		local item = {0, 50, 294, 297}
		local amounts = {5000, 100, 50, 10}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {
			"Cleave is a very powerful attack that strikes every enemy around you.\nUpgrades your Whirlwind Attack.",
			txt
		}
		return level, item, amounts, desc
	end
}
