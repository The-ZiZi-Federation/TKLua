-------------------------------------------------------
--   Spell: Decay Area
--   Class: Fallen
--   Level: 110
--  Aether: 16 Sec
--Duration: 8 Sec
--    Cost: (player.maxMagic * 0.35)
-- DmgType: Magical
--    Type: Fire
-- Targets: Adjacent to Player Target, 8 Targets.
--			Target CANNOT be a Mob.
--
--          X X X
--          X T X
--          X X X
--
-------------------------------------------------------
--    Desc: Death surrounds the caster, damaging enemies.
-------------------------------------------------------
-- Script Author: John Crandell / John Day / Justin Chartier
--   Last Edited: 07/05/2017
-------------------------------------------------------
decay_area = {
	on_learn = function(player)
		player.registry["learned_decay_area"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_decay_area"] = 0
	end,
	cast = function(player, target)
		----------------------
		--Varable Declarations
		----------------------
		if not distanceSquare(player, target, 6) then
			player:sendMinitext("Target is too far away!")
			return
		end

		local aether = 16000
		local magicCost = (player.maxMagic * 0.35)
		local duration = 8000

		local targets = {}
		local threat

		local m = player.m
		local x = player.x
		local y = player.y

		local anim = 116
		local sound = 50
		-- Cast Checks ------------------
		if player.blType == BL_PC then
			if (not player:canCast(1, 1, 0)) then
				return
			end

			if (player.magic < magicCost) then
				player:sendMinitext("Not enough mana.")
				return
			end

			if (target.state == 1) then
				player:sendMinitext("That is no longer useful.")
				return
			end
		end

		--------------------------PLAYER-----------------------------------
		if player.blType == BL_PC then
			-----------------player Targetting mob-------------------------------
			if (target.blType == BL_MOB) then
				---------------player Targetting player------------------------------
				failureAnim(Player)
				player:sendMinitext("Invalid Target.")
			elseif (target.blType == BL_PC) then
				target.attacker = player.ID
				player:calcStat()
				player:sendStatus()
				player:sendAction(6, 20)
				player:sendMinitext("You cast Decay Area")
				player:playSound(sound)
				player:setAether("decay_area", aether)
				--- What happens to the player target on cast --------------------------------------
				target:sendMinitext(player.name .. " surrounds you with a deathly aura")
				target:sendAnimation(anim)
				target:playSound(sound)
				target.registry["decay_area"] = player.ID
				target:setDuration("decay_area", duration, player.ID)
			-----------------------------------------------------------------------------
			end
		end
	end,
	uncast = function(player)
		player.registry["decay_area"] = 0
	end,
	while_cast = function(player, caster) -- The tick based cost is taken here from the casters mana.
		-- The call for damage is done in here, damage amount is actually calculated here.
		----------------------
		--Varable Declarations
		----------------------
		local user = Player(player.registry["decay_area"])
		local mana = user.maxMagic
		local level = user.level
		local will = user.will
		local grace = user.grace

		local manaMult = 3.5
		local levelMult = 350
		local willMult = 350
		local graceMult = 350

		local pcflankTargets = {}
		local mobflankTargets = {}

		local m = player.m
		local x = player.x
		local y = player.y
		---------------------------
		--- Spell Damage Formula---
		---------------------------

		local damage

		--  Get targets around the player Decay Area was cast upon ------------------------------------
		local mob_around = player:getObjectsInArea(BL_MOB)
		local pc_around = player:getObjectsInArea(BL_PC)

		if #mob_around > 0 then
			for i = 1, #mob_around do
				if distanceSquare(player, mob_around[i], 1) then
					player.critChance = 1
					damage = ((0.025 * player.maxHealth) + (0.1 * player.level) + swingDamage(player, mob_around[i], 2)) * 10
					decay_area.takeDamage(player, mob_around[i], damage)
				end
			end
		end
		--  PKable Human Player is around ---------
		if #pc_around > 0 then
			for i = 1, #pc_around do
				if distanceSquare(player, pc_around[i], 1) then
					if pc_around[i].ID ~= player.ID then
						if pc_around[i].state ~= 1 and player:canPK(pc_around[i]) then
							player.critChance = 1
							damage = ((0.025 * player.maxHealth) + (0.1 * player.level) + swingDamage(player, pc_around[i], 2)) * 10
							decay_area.takeDamage(player, pc_around[i], damage)
						end
					end
				end
			end
		end
	end,
	takeDamage = function(player, target, damage)
		local caster = Player(player.registry["decay_area"])
		local threat
		local anim = 293
		local sound
		local duration = 3000
		local r = math.random(1, 1000)

		target.attacker = caster.ID
		if target.blType == BL_MOB then
			threat = target:removeHealthExtend(damage, 1, 1, 0, 1, 2)
			player:addThreat(target.ID, threat)
		end
		target:sendAnimation(anim)
		target:removeHealthExtend(damage, 1, 1, 0, 1, 1)
		if r <= 50 then
			if not target:hasDuration("poison") then
				if checkResist(player, target, "poison") == 1 then
					return
				end
				target:setDuration("poison", duration)
			end
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

		local desc = {"Decay Area is a damage over time Area affect spell with Fire!", txt}
		return level, item, amounts, desc
	end
}
