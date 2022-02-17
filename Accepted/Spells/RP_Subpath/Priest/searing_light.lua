-------------------------------------------------------
--   Spell: Searing Light
--   Class: Priest
--   Level: 50
--  Aether: 23 Second
-- Targets: 1
-------------------------------------------------------
--   Desc.: A holy light douses the foe.  Depends more on
-- 			Will for damage.  Considered a Magic Attack for defense calculations
-------------------------------------------------------
-- Script Author: John Day / John Crandell
--   Last Edited: 07/07/2017
-------------------------------------------------------

searing_light = {
	on_learn = function(player)
		player.registry["learned_searing_light"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_searing_light"] = 0
	end,
	cast = function(player, target)
		------------------------
		--Varable Declarations--
		------------------------
		local aether = 23000
		local magicCost = (player.level * 25) + (player.maxMagic / 3.5)
		local damage = ((0.03 * player.maxHealth) + (0.1 * player.level) + swingDamage(player, target, 2)) * 20
		local searDuration = 5000

		local mobTarget = getTargetFacing(player, BL_MOB)
		local pcTarget = getTargetFacing(player, BL_PC)

		local m = player.m
		local x = player.x
		local y = player.y

		local threat

		local anim = 422
		local anim2 = 424
		local sound = 71
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
					target:sendMinitext(player.name .. " burns you with Searing Light")
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

			player:sendMinitext("You cast Searing Light")

			if player.registry["extra_spell_info"] == 1 then
				player:sendMinitext("Searing Light DMG: " .. damage)
			end

			player:setAether("searing_light", aether)
			player:sendStatus()

			target:removeHealthExtend(damage, 1, 1, 0, 1, 1)

			target:sendAnimation(anim)
			target:sendAnimation(anim2)
			if not target:hasDuration("seared") then
				if checkResist(player, target, "seared") == 1 then
					return
				end
				target:setDuration("seared", searDuration)
			end
		elseif (target.blType == BL_PC and player:canPK(target)) then
			player:sendAction(6, 20)
			player.magic = player.magic - magicCost
			player:sendStatus()
			player:setAether("searing_light", aether)
			player:playSound(sound)
			target:sendAnimation(anim)
			target:sendAnimation(anim2)
			player:sendMinitext("You cast Searing Light")
			target.attacker = player.ID
			target:removeHealthExtend(damage, 1, 1, 0, 1, 1)
			target:sendMinitext(player.name .. " burns you with a Searing Light!!")
		else
			target:sendMinitext("Something weird happened here")
		end
	end,
	requirements = function(player)
		local level = 52
		local item = {0, 3011, 293, 291, 292}
		local amounts = {1250, 2, 1, 10, 10}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Searing Light is a spell that calls on the sun from your God to burn your enemies!", txt}
		return level, item, amounts, desc
	end
}
