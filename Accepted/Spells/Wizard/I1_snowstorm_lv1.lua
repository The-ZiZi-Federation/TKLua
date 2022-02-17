-------------------------------------------------------
--   Spell: Snowstorm Lv1
--   Class: Wizard
--   Level: 5
--  Aether: 0
--    Cost: (player.maxMagic * 0.025)
--	Damage: (player.maxMagic * manaMult) + (player.level * levelMult)
-- DmgType: Magical
--    Type: Ice
-- Targets: Single, Ranged
--  Effect: Chance to Slow on Hit for 5 seconds.
-------------------------------------------------------
--    Desc: Pelts the target with snow.
-------------------------------------------------------
-- Script Author: John Crandell, John Day, Justin Chartier
--   Last Edited: 07/02/2017
-------------------------------------------------------
snowstorm_lv1 = {
	on_learn = function(player)
		player.registry["learned_snowstorm_lv1"] = 1

		player:removeSpell("snowstorm_lv2")
		player:removeSpell("snowstorm_lv3")
		player:removeSpell("snowstorm_lv4")
		player:removeSpell("snowstorm_lv5")
	end,
	on_forget = function(player)
		player.registry["learned_snowstorm_lv1"] = 0
	end,
	cast = function(player, target)
		----------------------
		--Varable Declarations
		----------------------
		if not distanceSquare(player, target, 9) then
			player:sendMinitext("Target is too far away!")
			return
		end

		local magicCost = (player.maxMagic * 0.01)
		local slowDuration = 5000
		local r = math.random(1, 1000)

		local threat

		local m = player.m
		local x = player.x
		local y = player.y

		local anim = 23
		local sound = 46

		---------------------------
		--- Spell Damage Formula---
		---------------------------
		local manaMult = 0
		local levelMult = 0
		local willMult = 0
		local graceMult = 0

		if player.level < 17 then
			manaMult = 0.15
			levelMult = 15
		elseif player.level >= 17 then
			manaMult = 0.25
			levelMult = 25
		end

		local damage = (player.maxMagic * manaMult) + (player.level * levelMult)
		damage = math.floor(damage)
		---------------------------------
		-- Cast Checks ------------------
		---------------------------------
		if (player.blType == BL_PC) then
			if (not player:canCast(1, 1, 0)) then
				return
			end
		end

		if (player.magic < magicCost) then
			player:sendAnimation(246)
			player:sendMinitext("Not enough mana.")
			return
		end

		if (target.state == 1) then
			player:sendMinitext("That is no longer useful.")
			return
		end

		-----------------player vs mob-------------------------------
		if (target.blType == BL_MOB) then
			----------------player vs player-----------------------------------------------------------
			player.magic = player.magic - magicCost
			player:sendAction(6, 20)
			player:sendStatus()
			player:playSound(sound)
			target:sendAnimation(anim)
			player:sendMinitext("You cast Snowstorm Lv1")

			if player.registry["extra_spell_info"] == 1 then
				player:sendMinitext("Snowstorm Lv1 DMG: " .. damage)
			end

			target.attacker = player.ID

			threat = target:removeHealthExtend(damage, 1, 1, 0, 1, 2)
			player:addThreat(target.ID, threat)
			target:removeHealthExtend(damage, 1, 1, 0, 1, 1)
			if r <= 50 then
				if not target:hasDuration("slow") then
					if checkResist(player, target, "slow") == 1 then
						return
					end
					target:setDuration("slow", slowDuration)
				end
			end
		elseif (target.blType == BL_PC and player:canPK(target)) then
			player:sendAction(6, 20)
			player.magic = player.magic - magicCost
			player:sendStatus()
			player:playSound(sound)
			target:sendAnimation(anim)
			player:sendMinitext("You cast Snowstorm Lv1")
			target.attacker = player.ID
			target:removeHealthExtend(damage, 1, 1, 0, 1, 1)
			target:sendMinitext(player.name .. " burns you with Snowstorm Lv1")
			if r <= 50 then
				if not target:hasDuration("slow") then
					target:setDuration("slow", slowDuration)
				end
			end
		end
	end,
	requirements = function(player)
		local level = 5
		local item = {0, 50, 248}
		local amounts = {5, 10, 5}

		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Snowstorm Lv1 pelts an opponent with snow!", txt}
		return level, item, amounts, desc
	end
}
