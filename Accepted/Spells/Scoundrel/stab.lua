-------------------------------------------------------
--   Spell: Stab
--   Class: Scoundrel
--   Level: 8
--  Aether: 5 Second
--    Cost: (player.level * 10) + (player.maxMagic / 25)
-- DmgType: Physical
--  Damage: ((0.025* player.maxHealth)+ (0.1* Level)+ swingDamage)* 3.5
--    Type: Offensive
-- Targets: 1
-- Effects: N/A
-------------------------------------------------------
--    Desc: A heavy strike against a single foe.
-------------------------------------------------------
-- Script Author: John Day / John Crandell
--   Last Edited: 01/27/2017
-------------------------------------------------------
stab = {
	on_learn = function(player)
		player.registry["learned_stab"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_stab"] = 0
	end,
	cast = function(player)
		----------------------
		--Varable Declarations
		----------------------
		local magicCost = (player.level * 15)
		local aether = 5000

		local mobTarget = getTargetFacing(player, BL_MOB)
		local pcTarget = getTargetFacing(player, BL_PC)

		local threat

		local m = player.m
		local x = player.x
		local y = player.y

		local anim = 89
		local sound = 334
		---------------------------
		--- Spell Damage Formula---
		---------------------------
		local damage
		player.critChance = 1
		-------------------------------------------------------
		if not player:canCast(1, 1, 0) then
			player:sendAnimation(246)
			return
		end

		if player.magic < magicCost or player.magic - magicCost <= 0 then
			player:sendAnimation(246)
			player:sendMinitext("Not enough mana.")
			return
		end
		-------------------------------------------------------
		if mobTarget ~= nil then
			damage = math.floor(((0.025 * player.maxHealth) + (0.1 * player.level) + swingDamage(player, mobTarget, 2)) * 3.5)
			mobTarget.attacker = player.ID
			player:sendAction(1, 20)
			player:talk(2, "*Stab*")
			player.magic = player.magic - magicCost
			player:setAether("stab", aether)
			player:sendStatus()
			if player.registry["extra_spell_info"] > 0 then
				player:sendMinitext("Stab DMG: " .. damage)
			end
			player:playSound(sound)
			threat = mobTarget:removeHealthExtend(damage, 1, 1, 0, 1, 2)
			player:addThreat(mobTarget.ID, threat)
			mobTarget:sendAnimation(anim, 0)
			player:sendMinitext("You Stab your foe!")
			mobTarget:removeHealthExtend(damage, 1, 1, 0, 1, 1)
		elseif pcTarget ~= nil then
			if (player:canPK(pcTarget)) then
				damage = math.floor(((0.025 * player.maxHealth) + (0.1 * player.level) + swingDamage(player, pcTarget, 2)) * 3.5)
				pcTarget.attacker = player.ID
				player:sendAction(1, 20)
				player:talk(2, "*Stab*")
				player.magic = player.magic - magicCost
				player:setAether("stab", aether)
				player:sendStatus()
				player:sendMinitext("You Stab your foe")
				player:playSound(sound)
				pcTarget:sendAnimation(anim, 0)
				pcTarget:removeHealthExtend(damage, 1, 1, 0, 1, 1)
			end
		end
	end,
	requirements = function(player)
		local level = 8
		local item = {212}
		local amounts = {20}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"If you cannot Stab your enemy, you will be the one being Stabbed.", txt}
		return level, item, amounts, desc
	end
}
