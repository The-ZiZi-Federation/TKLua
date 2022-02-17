-------------------------------------------------------
--   Spell: Crippling Blow
--   Class: Paladin
--   Level: 110
--  Aether: 17 Second
-- Targets: 1
-------------------------------------------------------
--   Desc.: Ranged attack spell
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 08/12/2017
-------------------------------------------------------

crippling_blow = {
	on_learn = function(player)
		player.registry["learned_crippling_blow"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_crippling_blow"] = 0
	end,
	cast = function(player, target)
		------------------------
		--Varable Declarations--
		------------------------
		local aether = 17000
		local magicCost = (player.maxMagic * 0.25)
		local levelMult = 20
		if player.level >= 200 then
			levelMult = 25
		end
		local damage = ((0.15 * player.maxHealth) + (0.1 * player.level) + swingDamage(player, target, 2)) * levelMult

		local mobTarget = getTargetFacing(player, BL_MOB)
		local pcTarget = getTargetFacing(player, BL_PC)

		local m = player.m
		local x = player.x
		local y = player.y

		local threat

		local anim = 44
		local sound = 506
		player.critChance = 1
		---------------------------------------------------------
		if not player:canCast(1, 1, 0) then
			return
		else
			--------------------------------------------
			if player.magic < magicCost then
				notEnoughMP(player)
				return
			end
			------ Target is a player ----------------
			if target.blType == BL_PC then
				if not player:canPK(target) or target.state == 1 then
					return
				else
					target:sendMinitext(player.name .. " hits you with Crippling Blow")
				end
			end
		end
		---------------------------------------------
		if (target.blType == BL_MOB) then
			----------------player vs player-----------------------------------------------------------
			target.attacker = player.ID
			player.magic = player.magic - magicCost

			threat = target:removeHealthExtend(damage, 1, 1, 0, 1, 2)
			player:addThreat(target.ID, threat)

			player:sendAction(6, 20)
			player:playSound(sound)

			player:sendMinitext("You cast Crippling Blow")

			if player.registry["extra_spell_info"] == 1 then
				player:sendMinitext("Crippling Blow DMG: " .. damage)
			end

			player:setAether("crippling_blow", aether)
			player:sendStatus()

			target:removeHealthExtend(damage, 1, 1, 0, 1, 1)

			target:sendAnimation(anim)
		elseif (target.blType == BL_PC and player:canPK(target)) then
			player:sendAction(6, 20)
			player.magic = player.magic - magicCost
			player:sendStatus()
			player:setAether("crippling_blow", aether)
			player:playSound(sound)
			target:sendAnimation(anim)
			player:sendMinitext("You cast Crippling Blow")
			target.attacker = player.ID
			target:removeHealthExtend(damage, 1, 1, 0, 1, 1)
		else
			target:sendMinitext("Something weird happened here")
		end
	end,
	requirements = function(player)
		local level = 5
		local item = {0}
		local amounts = {50000}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Crippling Blow is a spell that damages a target at range!", txt}
		return level, item, amounts, desc
	end
}
