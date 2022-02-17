-------------------------------------------------------
--   Spell: Exhausted Blow
--   Class: Fighter
--   Level: 99
--  Aether: 45 Second
--  MagicCost: player.maxMagic * 0.5
--  HealthCost: player.maxHealth * 0.25
-- DmgType: Physical
--    Type: Offensive
-- Targets: 1
--          . X .
--          . P .
--          . . .
-- Effects: N/A
-------------------------------------------------------
--    Desc: Sacrifice your strength for a massive strike against a single foe.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 07/07/2017
-------------------------------------------------------
exhausted_blow = {
	on_learn = function(player)
		player.registry["learned_exhausted_blow"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_exhausted_blow"] = 0
	end,
	cast = function(player)
		----------------------
		--Varable Declarations
		----------------------
		local mobTarget = getTargetFacing(player, BL_MOB)
		local pcTarget = getTargetFacing(player, BL_PC)
		local threat

		local aether = 45000
		local magicCost = player.maxMagic * 0.2
		local healthCost = player.maxHealth * 0.35

		local anim = 576 --410?
		local sound = 14

		local damage
		player.critChance = 1

		-------------------------------------------------------
		if (not player:canCast(1, 1, 0)) then
			return
		end

		-------------------------------------------------------
		if player.health < healthCost or player.health - healthCost <= 0 then
			player:sendAnimation(246)
			player:sendMinitext("Not Enough HP.")
			return
		end
		if player.magic < magicCost or player.magic - magicCost <= 0 then
			player:sendAnimation(246)
			player:sendMinitext("Not Enough MP.")
			return
		end
		------------------------------------
		if mobTarget ~= nil then
			damage = ((0.15 * player.maxHealth) + (0.1 * player.level) + swingDamage(player, mobTarget, 2)) * 20
			mobTarget.attacker = player.ID
			player:sendAction(1, 20)
			player:talk(2, "~Smash~")
			player:sendMinitext("You cast Exhausted Blow")

			if player.registry["extra_spell_info"] > 0 then
				player:sendMinitext("Exhausted Blow DMG: " .. damage)
			end

			player:setAether("exhausted_blow", aether)
			player:playSound(sound)
			mobTarget:sendAnimation(6, 0)
			threat = mobTarget:removeHealthExtend(damage, 1, 1, 0, 1, 2)
			player:addThreat(mobTarget.ID, threat)
			player.magic = player.magic - magicCost
			player.health = player.health - healthCost
			player:sendStatus()
			mobTarget:removeHealthExtend(damage, 1, 1, 0, 1, 1)
		elseif pcTarget ~= nil then
			if (player:canPK(pcTarget)) then
				damage = ((0.15 * player.maxHealth) + (0.1 * player.level) + swingDamage(player, pcTarget, 2)) * 20
				pcTarget.attacker = player.ID
				-- Action, Animation, Text, Sound ---
				player:sendAction(1, 20)
				player:talk(2, "YOU'RE DEAD!")
				player:sendMinitext("You cast Exhausted Blow")
				player:setAether("exhausted_blow", aether)
				player:playSound(14)
				pcTarget:sendAnimation(6, 0)
				-- Apply Damage, pay MP Cost ----
				player.magic = player.magic - magicCost
				player.health = player.health - healthCost
				player:sendStatus()
				pcTarget:removeHealthExtend(damage, 1, 1, 0, 1, 1)
			end
		end
	end,
	requirements = function(player)
		local level = 99
		local item = {0, 434, 50}
		local amounts = {250000, 1, 175}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Sacrifice your strength for a massive strike against a single foe.", txt}
		return level, item, amounts, desc
	end
}
