-------------------------------------------------------
--   Spell: Pommel Strike
--   Class: Fighter
--   Level: 49
--  Aether: 28 Second
--  MagicCost: (Mana * 0.05) + (Level*50)
-- DmgType: Physical
--    Type: Offensive
-- Targets: 1
-- Effects: Sleep (10 Seconds)
-------------------------------------------------------
--    Desc: You heft your blade and spin a full 360
-- 			cleavng anyone in the way for heavy damage.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 07/07/2017
-------------------------------------------------------
pommel_strike = {
	on_learn = function(player)
		player.registry["learned_pommel_strike"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_pommel_strike"] = 0
	end,
	cast = function(player)
		----------------------
		--Varable Declarations
		----------------------
		local magicCost = (player.maxMagic * 0.05) + (player.level * 30)
		local aether = 28000
		local duration = 10000
		---------------------------------------------

		local sound = 14
		local anim1 = 423
		local anim2 = 424

		local mobTarget = getTargetFacing(player, BL_MOB)
		local pcTarget = getTargetFacing(player, BL_PC)

		local m = player.m
		local x = player.x
		local y = player.y
		local threat
		--------------------------------

		--- Spell Damage Formula---
		---------------------------

		local damage
		player.critChance = 1
		-------------------------------------------------------
		if player.magic < magicCost or player.magic - magicCost <= 0 then
			player:sendAnimation(246)
			player:sendMinitext("Not Enough MP.")
			return
		end
		-------------------------------------------------------
		if mobTarget ~= nil then
			damage = ((0.03 * player.health) + (0.1 * player.level) + swingDamage(player, mobTarget, 2)) * 2
			mobTarget.attacker = player.ID
			player:sendAction(1, 20)
			player.magic = player.magic - magicCost
			player:sendStatus()
			player:sendMinitext("You strike your foe with the pommel of your weapon!!!")
			if player.registry["extra_spell_info"] > 0 then
				player:sendMinitext("Pommel Strike DMG: " .. damage)
			end
			player:playSound(sound)
			player:setAether("pommel_strike", aether)
			threat = mobTarget:removeHealthExtend(damage, 1, 1, 0, 1, 2)
			player:addThreat(mobTarget.ID, threat)
			mobTarget:sendAnimation(anim1)
			mobTarget:sendAnimation(anim2)
			mobTarget:removeHealthExtend(damage, 1, 1, 0, 1, 1)
			if checkResist(player, mobTarget, "asleep") == 1 then
				return
			end
			mobTarget.sleep = 2.0
			mobTarget:setDuration("asleep", duration)
		elseif pcTarget ~= nil then
			if (player:canPK(pcTarget)) then
				damage = ((0.03 * player.health) + (0.1 * player.level) + swingDamage(player, pcTarget, 1)) * 2
				pcTarget:sendAnimation(anim1)
				pcTarget:sendAnimation(anim2)
				pcTarget.attacker = player.ID
				player:sendAction(1, 20)
				player.magic = player.magic - magicCost
				player:sendStatus()
				player:sendMinitext("You strike your foe with the pommel of your weapon!!!")
				player:playSound(sound)
				player:setAether("pommel_strike", aether)
				pcTarget:removeHealthExtend(damage, 1, 1, 0, 1, 1)
				if checkResist(player, pcTarget, "asleep") == 1 then
					return
				end
				pcTarget.sleep = 2.0
				pcTarget:setDuration("asleep", duration)
			end
		end
	end,
	requirements = function(player)
		local level = 49
		local item = {0, 50}
		local amounts = {7500, 80}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Pommel Strike is a blow to the head that stuns an enemy.", txt}
		return level, item, amounts, desc
	end
}
