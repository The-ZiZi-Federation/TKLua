-------------------------------------------------------
--   Spell: Coup De Grace
--   Class: Scoundrel
--   Level: 100
--  Aether: 35 Second
--    Cost: health and mana
-- DmgType: Physical
--    Type: Offensive
-- Targets: 1
-- Effects: Double Damage to Stunned enemies
-------------------------------------------------------
--    Desc: Very Heavy damage to a single foe
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 07/07/2017
-------------------------------------------------------
coup_de_grace = {
	on_learn = function(player)
		player.registry["learned_coup_de_grace"] = 1
		player:removeSpell("flashing_blades")
		player:removeSpell("pierce_vitals")
	end,
	on_forget = function(player)
		player.registry["learned_coup_de_grace"] = 0
	end,
	cast = function(player)
		----------------------
		--Varable Declarations
		----------------------
		local magicCost = (player.level * 50) + (player.maxMagic * .1)
		local healthCost = (player.level * 50) + (player.maxHealth * .23)
		local aether = 35000

		if not player:canCast(1, 1, 0) then
			player:sendAnimation(246)
			return
		end

		if player.magic < magicCost or player.magic - magicCost <= 0 then
			player:sendAnimation(246)
			player:sendMinitext("Not Enough MP.")
			return
		end

		if player.health < healthCost or player.health - healthCost <= 0 then
			player:sendAnimation(246)
			player:sendMinitext("Not Enough HP.")
			return
		end

		local threat

		local mobTarget = getTargetFacing(player, BL_MOB)
		local pcTarget = getTargetFacing(player, BL_PC)

		local m = player.m
		local x = player.x
		local y = player.y

		local anim = 128
		local sound = 14
		---------------------------
		--- Spell Damage Formula---
		---------------------------
		local damage
		player.critChance = 1
		-------------------------------------------------------------
		if mobTarget ~= nil then
			damage = math.floor(((0.025 * player.maxHealth) + (0.1 * player.level) + swingDamage(player, mobTarget, 2)) * 15)
			if mobTarget:hasDuration("stun") then
				mobTarget.attacker = player.ID
				player:sendAction(1, 20)
				player:talk(2, "*Now you die!*")
				player.magic = player.magic - magicCost
				player.health = player.health - healthCost
				player:setAether("coup_de_grace", aether)
				player:sendStatus()
				player:sendMinitext("Your enemy is Stunned! You perform a Coup de Grace")
				if player.registry["extra_spell_info"] > 0 then
					player:sendMinitext("Coup de Grace DMG (2x): " .. (damage * 2))
				end
				player:playSound(sound)
				threat = mobTarget:removeHealthExtend((damage * 2), 1, 1, 0, 1, 2)
				player:addThreat(mobTarget.ID, threat)
				mobTarget:sendAnimation(anim, 0)
				mobTarget:removeHealthExtend((damage * 2), 1, 1, 0, 1, 1)
			else
				mobTarget.attacker = player.ID
				player:sendAction(1, 20)
				player:talk(2, "*Now you die!*")
				player.magic = player.magic - magicCost
				player.health = player.health - healthCost
				player:setAether("coup_de_grace", aether)
				player:sendStatus()
				player:sendMinitext("You perform a Coup de Grace")
				if player.registry["extra_spell_info"] > 0 then
					player:sendMinitext("Coup de Grace DMG: " .. damage)
				end
				player:playSound(sound)
				threat = mobTarget:removeHealthExtend(damage, 1, 1, 0, 1, 2)
				player:addThreat(mobTarget.ID, threat)
				mobTarget:sendAnimation(anim, 0)
				mobTarget:removeHealthExtend(damage, 1, 1, 0, 1, 1)
			end
		elseif pcTarget ~= nil then
			damage = math.floor(((0.025 * player.maxHealth) + (0.1 * player.level) + swingDamage(player, pcTarget, 2)) * 15)
			player:sendAction(1, 20)
			player:talk(2, "*Now you die!*")
			pcTarget:sendAnimation(128, 0)
			player:setAether("coup_de_grace", aether)
			if (player:canPK(pcTarget)) then
				if pcTarget:hasDuration("stun") then
					pcTarget.attacker = player.ID
					player.magic = player.magic - magicCost
					player.health = player.health - healthCost
					player:sendStatus()
					player:sendMinitext("You perform a Coup de Grace")
					player:playSound(sound)
					pcTarget:removeHealthExtend((damage * 2), 1, 1, 0, 1, 1)
				else
					pcTarget.attacker = player.ID
					player.magic = player.magic - magicCost
					player:sendStatus()
					player:sendMinitext("You perform a Coup de Grace")
					player:playSound(sound)
					pcTarget:removeHealthExtend(damage, 1, 1, 0, 1, 1)
				end
			end
		end
	end,
	requirements = function(player)
		local level = 100
		local item = {0, 435}
		local amounts = {250000, 1}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Coup De Grace is a powerful finishing blow for stunned opponents.\nReplaces Pierce Vitals.", txt}
		return level, item, amounts, desc
	end
}
