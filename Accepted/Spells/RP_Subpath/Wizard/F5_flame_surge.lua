-------------------------------------------------------
--   Spell: Flame Surge
--   Class: Wizard
--   Level: 99
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
--    Desc: Fire rains on the target.
-------------------------------------------------------
-- Script Author: John Crandell / John Day / Justin Chartier
--   Last Edited: 07/05/2017
-------------------------------------------------------
flame_surge = {
	on_learn = function(player)
		player.registry["learned_flame_surge"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_flame_surge"] = 0
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
		local flameSurgeDuration = 8000

		local targets = {}
		local threat

		local m = player.m
		local x = player.x
		local y = player.y

		local anim = 172
		local sound = 508
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
				player:sendMinitext("You cast Flame Surge")
				player:playSound(sound)
				player:setAether("flame_surge", aether)
				--- What happens to the player target on cast --------------------------------------
				target:sendMinitext(player.name .. " bathes you in a surge of flames")
				target:sendAnimation(anim)
				target:playSound(sound)
				target.registry["flame_surge"] = player.ID
				target:setDuration("flame_surge", flameSurgeDuration, player.ID)
			-----------------------------------------------------------------------------
			end
		elseif player.blType == BL_MOB then
			if (target.blType == BL_PC) then
				---------------player Targetting player------------------------------
				failureAnim(Player)
			elseif (target.blType == BL_MOB) then
				target.attacker = player.ID
				player:calcStat()
				player:sendAction(6, 20)
				player:playSound(sound)
				--- What happens to the player target on cast --------------------------------------
				target:sendAnimation(anim)
				target:playSound(sound)
				target.registry["flame_surge"] = player.ID
				target:setDuration("flame_surge", flameSurgeDuration, player.ID)
			-----------------------------------------------------------------------------
			end
		end
	end,
	uncast = function(player)
		player.registry["flame_surge"] = 0
	end,
	while_cast = function(player, caster) -- The tick based cost is taken here from the casters mana.
		-- The call for damage is done in here, damage amount is actually calculated here.
		----------------------
		--Varable Declarations
		----------------------
		local user = Player(player.registry["flame_surge"])
		local mana = user.maxMagic
		local level = user.level
		local will = user.will
		local grace = user.grace

		local manaMult = 3
		local levelMult = 300
		local willMult = 300
		local graceMult = 300

		local pcflankTargets = {}
		local mobflankTargets = {}

		local m = player.m
		local x = player.x
		local y = player.y
		---------------------------
		--- Spell Damage Formula---
		---------------------------

		local damage = (mana * manaMult) + (level * levelMult) + (will * willMult) + (grace * graceMult)
		damage = math.floor(damage)

		--  Get targets around the player Flame Surge was cast upon ------------------------------------
		local mob_around = player:getObjectsInArea(BL_MOB)
		local pc_around = player:getObjectsInArea(BL_PC)

		if #mob_around > 0 then
			for i = 1, #mob_around do
				if distanceSquare(player, mob_around[i], 1) then
					if (player.blType == BL_PC) then
						if player.gmLevel > 0 then
							player:sendMinitext("Flame Surge DMG: " .. damage)
						end
					end
					flame_surge.takeDamage(player, mob_around[i], damage)
				end
			end
		end
		--  PKable Human Player is around ---------
		if #pc_around > 0 then
			for i = 1, #pc_around do
				if distanceSquare(player, pc_around[i], 1) then
					if pc_around[i].ID ~= player.ID then
						if pc_around[i].state ~= 1 and player:canPK(pc_around[i]) then
							flame_surge.takeDamage(player, pc_around[i], damage)
						end
					end
				end
			end
		end
	end,
	takeDamage = function(player, target, damage)
		local caster = Player(player.registry["flame_surge"])
		local threat
		local anim = 172
		local sound
		local duration = 2000
		local r = math.random(1, 1000)

		target.attacker = caster.ID
		if target.blType == BL_MOB then
			threat = target:removeHealthExtend(damage, 1, 1, 0, 1, 2)
			player:addThreat(target.ID, threat)
		end
		target:sendAnimation(anim)
		target:removeHealthExtend(damage, 1, 1, 0, 1, 1)
		if r <= 50 then
			if not target:hasDuration("seared") then
				if checkResist(player, target, "seared") == 1 then
					return
				end
				target:setDuration("seared", duration)
			end
		end
	end,
	requirements = function(player)
		local level = 99
		local item = {0, 424, 423}
		local amounts = {200000, 10, 10}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Flame Surge is a damage over time Area affect spell with Fire!", txt}
		return level, item, amounts, desc
	end
}
