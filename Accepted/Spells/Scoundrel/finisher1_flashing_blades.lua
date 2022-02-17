-------------------------------------------------------
--   Spell: Flashing Blades
--   Class: Scoundrel
--   Level: 23
--  Aether: 16 Second
--    Cost: (player.maxMagic * 0.1)
-- DmgType: Physical
--    Type: Offensive
-- Targets: 1
-- Effects: Double Damage to Stunned enemies
-------------------------------------------------------
--    Desc: Heavy damage to a single foe
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 07/05/2017
-------------------------------------------------------
flashing_blades = {
	on_learn = function(player)
		player.registry["learned_flashing_blades"] = 1
		player:removeSpell("pierce_vitals")
		player:removeSpell("coup_de_grace")
	end,
	on_forget = function(player)
		player.registry["learned_flashing_blades"] = 0
	end,
	cast = function(player)
		----------------------
		--Varable Declarations
		----------------------
		local magicCost = (player.maxMagic * 0.1)
		local aether = 16000

		local threat

		local mobTarget = getTargetFacing(player, BL_MOB)
		local pcTarget = getTargetFacing(player, BL_PC)

		local m = player.m
		local x = player.x
		local y = player.y

		local anim = 32
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
			damage = math.floor(((0.025 * player.maxHealth) + (0.1 * player.level) + swingDamage(player, mobTarget, 2)) * 4.5)
			if mobTarget:hasDuration("stun") then
				mobTarget.attacker = player.ID
				threat = mobTarget:removeHealthExtend(damage * 2, 1, 1, 0, 1, 2)
				player:addThreat(mobTarget.ID, threat)
				player:sendAction(1, 20)
				player.magic = player.magic - magicCost
				player:setAether("flashing_blades", aether)
				player:sendStatus()
				player:sendMinitext("Your enemy is Stunned!  You slash with a torrent of flashing blades!!!")
				if player.registry["extra_spell_info"] > 0 then
					player:sendMinitext("Flashing Blades DMG (2x): " .. damage * 2)
				end
				player:playSound(sound)
				mobTarget:sendAnimation(anim, 0)
				mobTarget:removeHealthExtend(damage * 2, 1, 1, 0, 1, 1)
			else
				mobTarget.attacker = player.ID
				player:sendAction(1, 20)
				player.magic = player.magic - magicCost
				player:setAether("flashing_blades", aether)
				player:sendStatus()
				player:sendMinitext("You unleash a torrent of flashing blades")
				if player.registry["extra_spell_info"] > 0 then
					player:sendMinitext("Flashing Blades DMG (2x): " .. damage * 2)
				end
				player:playSound(sound)
				threat = mobTarget:removeHealthExtend(damage, 1, 1, 0, 1, 2)
				player:addThreat(mobTarget.ID, threat)
				mobTarget:sendAnimation(anim, 0)
				mobTarget:removeHealthExtend(damage, 1, 1, 0, 1, 1)
			end
		elseif pcTarget ~= nil then
			if (player:canPK(pcTarget)) then
				damage = math.floor(((0.025 * player.maxHealth) + (0.1 * player.level) + swingDamage(player, pcTarget, 2)) * 4.5)
				pcTarget:sendAnimation(anim, 0)
				player:setAether("flashing_blades", aether)
				if pcTarget:hasDuration("stun") then
					pcTarget.attacker = player.ID
					pcTarget:removeHealthExtend(damage2, 1, 1, 0, 1, 1)
				else
					pcTarget.attacker = player.ID
					pcTarget:removeHealthExtend(damage, 1, 1, 0, 1, 1)
				end
			end
		else
			player:sendMinitext("Nothing to attack!")
		end
	end,
	requirements = function(player)
		local level = 23
		local item = {0, 6001, 388}
		local amounts = {4500, 1, 25}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Flashing Blades is a series of quick strikes at a single opponent's vitals.", txt}
		return level, item, amounts, desc
	end
}
