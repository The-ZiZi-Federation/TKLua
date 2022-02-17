-------------------------------------------------------
--   Spell: Pierce Vitals
--   Class: Scoundrel
--   Level: 62
--  Aether: 17 Second
--    Cost: (player.maxMagic / 9.5)
-- DmgType: Physical
--    Type: Offensive
-- Targets: 1
-- Effects: Double Damage to Stunned enemies
-------------------------------------------------------
--    Desc: Heavy damage to a single foe
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 01/27/2017
-------------------------------------------------------
pierce_vitals = {
	on_learn = function(player)
		player.registry["learned_pierce_vitals"] = 1
		player:removeSpell("flashing_blades")
		player:removeSpell("coup_de_grace")
	end,
	on_forget = function(player)
		player.registry["learned_pierce_vitals"] = 0
	end,
	cast = function(player)
		----------------------
		--Varable Declarations
		----------------------
		local magicCost = (player.maxMagic * .1)
		local aether = 17000

		local threat

		local mobTarget = getTargetFacing(player, BL_MOB)
		local pcTarget = getTargetFacing(player, BL_PC)

		local m = player.m
		local x = player.x
		local y = player.y

		local anim = 31
		local sound = 14
		---------------------------
		--- Spell Damage Formula---
		---------------------------

		local damage
		player.critChance = 1
		-------------------------------------------------------------
		if not player:canCast(1, 1, 0) then
			player:sendAnimation(246)
			return
		end

		if player.magic < magicCost or player.magic - magicCost <= 0 then
			player:sendAnimation(246)
			player:sendMinitext("Not Enough MP.")
			return
		end
		-------------------------------------------------------------
		if mobTarget ~= nil then
			damage = math.floor(((0.025 * player.maxHealth) + (0.1 * player.level) + swingDamage(player, mobTarget, 2)) * 7)
			if mobTarget:hasDuration("stun") then
				mobTarget.attacker = player.ID
				player:sendAction(1, 20)
				player.magic = player.magic - magicCost
				player:setAether("pierce_vitals", aether)
				player:sendStatus()
				player:sendMinitext("Your enemy is Stunned! You stab at your enemy's vitals")
				if player.registry["extra_spell_info"] > 0 then
					player:sendMinitext("Pierce Vitals DMG (2x): " .. damage * 2)
				end
				player:playSound(sound)
				threat = mobTarget:removeHealthExtend(damage * 2, 1, 1, 0, 1, 2)
				player:addThreat(mobTarget.ID, threat)
				mobTarget:sendAnimation(anim, 0)
				mobTarget:removeHealthExtend(damage * 2, 1, 1, 0, 1, 1)
			else
				mobTarget.attacker = player.ID
				player:sendAction(1, 20)
				player.magic = player.magic - magicCost
				player:setAether("pierce_vitals", aether)
				player:sendStatus()
				player:sendMinitext("You stab at your enemy's vitals")
				if player.registry["extra_spell_info"] > 0 then
					player:sendMinitext("Pierce Vitals DMG: " .. damage)
				end
				player:playSound(sound)
				threat = mobTarget:removeHealthExtend(damage, 1, 1, 0, 1, 2)
				player:addThreat(mobTarget.ID, threat)
				mobTarget:sendAnimation(anim, 0)
				mobTarget:removeHealthExtend(damage, 1, 1, 0, 1, 1)
			end
		elseif pcTarget ~= nil then
			damage = math.floor(((0.025 * player.maxHealth) + (0.1 * player.level) + swingDamage(player, pcTarget, 2)) * 7)
			pcTarget:sendAnimation(31, 0)
			player:setAether("pierce_vitals", aether)
			if (player:canPK(pcTarget)) then
				if pcTarget:hasDuration("stun") then
					pcTarget.attacker = player.ID
					player:sendAction(1, 20)
					player.magic = player.magic - magicCost
					player:sendStatus()
					player:sendMinitext("You stab at your enemy's vitals")
					player:playSound(14)
					pcTarget:removeHealthExtend(damage * 2, 1, 1, 0, 1, 1)
				else
					pcTarget.attacker = player.ID
					player:sendAction(1, 20)
					player.magic = player.magic - magicCost
					player:sendStatus()
					player:sendMinitext("You stab at your enemy's vitals")
					player:playSound(14)
					pcTarget:removeHealthExtend(damage, 1, 1, 0, 1, 1)
				end
			end
		end
	end,
	requirements = function(player)
		local level = 62
		local item = {0, 6050, 6001}
		local amounts = {2500, 1, 2}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {
			"Pierce Vitals is a critical strike that is more effective on a stunned target./nReplaces Flashing Blades.",
			txt
		}
		return level, item, amounts, desc
	end
}
