-------------------------------------------------------
--   Spell: Rain of the Nether
--   Class: Wizard
--   Level: 92
--  Aether: 25 Sec
--    Cost: player.maxMagic * 0.65
-- DmgType: Magical
--  Damage: (player.maxMagic * manaMult) + (player.level * levelMult) + (player.will * willMult) + (player.grace * graceMult)
--    Type: Random Mult
-- Targets: Single
-------------------------------------------------------
--    Desc: Call forth an elemental blast from the nether.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 07/05/2017
-------------------------------------------------------
rain_of_the_nether = {
	on_learn = function(player)
		player.registry["learned_rain_of_the_nether"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_rain_of_the_nether"] = 0
	end,
	cast = function(player, target)
		----------------------
		--Varable Declarations
		----------------------

		if not distanceSquare(player, target, 6) then
			player:sendMinitext("Target is too far away!")
			return
		end

		local aether = 30000
		local magicCost = player.maxMagic * 0.65
		local searDuration = 0
		local stunDuration = 0
		local slowDuration = 0

		local manaMult = 0
		local levelMult = 0
		local willMult = 0
		local graceMult = 0

		if player.level < 200 then
			manaMult = 15
			levelMult = 1500
			willMult = 1500
			graceMult = 1500
		elseif player.level >= 200 and player.level < 250 then
			manaMult = 30
			levelMult = 3000
			willMult = 3000
			graceMult = 3000
		elseif player.level >= 250 then
			manaMult = 75
			levelMult = 7500
			willMult = 7500
			graceMult = 7500
		end

		local r = math.random(1, 6)
		--r = 4
		local spellName

		local mobBlocks = target:getObjectsInArea(BL_MOB)
		local pcBlocks = target:getObjectsInArea(BL_PC)
		local mobTargets = {}
		local pcTargets = {}
		local targets = {}
		local threat

		local m = player.m
		local x = player.x
		local y = player.y

		local anim
		local sound
		---------------------------------
		-- Cast Checks ------------------
		---------------------------------
		------------------------
		-- Enough MP ? ---
		------------------------
		if player.magic < magicCost then
			player:talkSelf(2, "I don't have enough Mana!!!")
			notEnoughMP(player)
			return
		end
		------------------------
		-- Player can cast ? ---
		------------------------
		if not player:canCast(1, 1, 0) then
			player:talkSelf(2, "I cannot cast right now!")
			return
		else
			----------------------------------
			-- Target is a player character --
			----------------------------------
			if target.blType == BL_PC then
				------------------------------------
				-- If the player is NOT PK Status --
				-- Then break ----------------------
				if not player:canPK(target) or target.state == 1 then
					player:talkSelf(2, "Target is NOT PK Status")
					return
				else
					if player.gmLevel < 1 then
						target:sendMinitext(player.name .. " engulfs you in the Rain of the Nether")
					end
				end
			end
		end
		-------------------------------------------
		if r == 1 then
			-------------------------------------------
			anim = 406
			sound = 42
			searDuration = 0
			stunDuration = 0
			slowDuration = 0
			spellName = "Waterspout"
		elseif r == 2 then
			-------------------------------------------
			anim = 400
			sound = 36
			searDuration = 0
			stunDuration = 5000
			slowDuration = 0
			spellName = "Sinkhole"
		elseif r == 3 then
			-------------------------------------------
			anim = 200
			sound = 43
			searDuration = 0
			stunDuration = 0
			slowDuration = 0
			spellName = "Twister"
		elseif r == 4 then
			-------------------------------------------
			anim = 419
			sound = 52
			searDuration = 8000
			stunDuration = 0
			slowDuration = 0
			spellName = "Fireball"
		elseif r == 5 then
			-------------------------------------------
			anim = 420
			sound = 73
			searDuration = 0
			stunDuration = 3000
			slowDuration = 0
			spellName = "Lightning Bolt"
		elseif r == 6 then
			anim = 187
			sound = 73
			searDuration = 0
			stunDuration = 0
			slowDuration = 10000
			spellName = "Icy Mass"
		-------------------------------------------
		end
		---------------------------
		--- Spell Damage Formula---
		---------------------------

		local damage =
			(player.maxMagic * manaMult) + (player.level * levelMult) + (player.will * willMult) + (player.grace * graceMult)
		damage = math.floor(damage)
		-----------------------------------
		player.magic = (player.magic - magicCost)
		target.attacker = player.ID

		player:talk(2, "From the Nether I summon the power of a " .. spellName)
		threat = target:removeHealthExtend(damage, 1, 1, 0, 1, 2)
		player:addThreat(target.ID, threat)
		player:sendAction(6, 20)
		player:playSound(sound)
		player:setAether("rain_of_the_nether", aether)
		player:sendMinitext("You cast Rain of the Nether: " .. spellName)

		if player.registry["extra_spell_info"] > 0 then
			player:sendMinitext("RN " .. spellName .. " DMG: " .. damage)
		end

		player:sendStatus()
		target:sendAnimation(anim)
		target:removeHealthExtend(damage, 1, 1, 0, 1, 1)

		if anim == 400 or anim == 420 then
			if not target:hasDuration("stun") then
				if checkResist(player, target, "stun") == 1 then
					return
				end
				target:setDuration("stun", stunDuration) -- apply "Stun" when "Earthquake" or "Lightning" are cast
			end
		elseif anim == 419 then
			if not target:hasDuration("seared") then
				if checkResist(player, target, "seared") == 1 then
					return
				end
				target:setDuration("seared", searDuration) -- apply "Sear" when "Hellfire" is cast.
			end
		elseif anim == 187 then
			if not target:hasDuration("slow") then
				if checkResist(player, target, "slow") == 1 then
					return
				end
				target:setDuration("slow", slowDuration) -- Apply "Slow" when "Icey Mass" is cast.
			end
		end
	end,
	requirements = function(player)
		local level = 92
		local item = {0, 436, 51}
		local amounts = {150000, 1, 1}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Rain of the Nether is a wild magic spell that causes random destruction on a target!", txt}
		return level, item, amounts, desc
	end
}
