-------------------------------------------------------
--   Spell: Wither
--   Class: Archmage
--   Level: 110
--  Aether: 16 Sec
--Duration: 8 Sec
--    Cost: (player.maxMagic * 0.25)
-- DmgType: Magical
--    Type: Darkness
-- Targets: Adjacent to Player Target, 12 Targets.
--			Target CANNOT be a Mob.
--            X
--          X X X
--        X X T X X
--          X X X
--            X
-------------------------------------------------------
--    Desc: Death and Decay surround target
-------------------------------------------------------
-- Script Author: John Crandell / John Day / Justin Chartier
--   Last Edited: 07/05/2017
-------------------------------------------------------
wither = {
	on_learn = function(player)
		player.registry["learned_wither"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_wither"] = 0
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
		local magicCost = (player.maxMagic * 0.25)
		local duration = 8000

		local targets = {}
		local threat

		local m = player.m
		local x = player.x
		local y = player.y

		--local anim = 617
		local anim = 551
		local sound = 120

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
				player:sendMinitext("You cast Wither")
				player:playSound(sound)
				player:setAether("wither", aether)
				--- What happens to the player target on cast --------------------------------------
				target:sendMinitext(player.name .. " surrounds you with Wither!")
				target:sendAnimation(anim)
				target:playSound(sound)
				target.registry["wither"] = player.ID
				target:setDuration("wither", duration, player.ID)
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
				target.registry["wither"] = player.ID
				target:setDuration("wither", duration, player.ID)
			-----------------------------------------------------------------------------
			end
		end
	end,
	uncast = function(player)
		player.registry["wither"] = 0
	end,
	while_cast = function(player, caster) -- The tick based cost is taken here from the casters mana.
		-- The call for damage is done in here, damage amount is actually calculated here.
		----------------------
		--Varable Declarations
		----------------------
		local user = Player(player.registry["wither"])
		local mana = user.maxMagic
		local level = user.level
		local will = user.will
		local grace = user.grace

		local manaMult = 3.25
		local levelMult = 325
		local willMult = 325
		local graceMult = 325

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

		--  Get targets around the player Wither was cast upon ------------------------------------
		local mob_around = player:getObjectsInArea(BL_MOB)
		local pc_around = player:getObjectsInArea(BL_PC)

		if #mob_around > 0 then
			for i = 1, #mob_around do
				if distance(player, mob_around[i]) <= 2 then
					if (player.blType == BL_PC) then
						if player.gmLevel > 0 then
							player:sendMinitext("Wither DMG: " .. damage)
						end
					end
					wither.takeDamage(player, mob_around[i], damage)
				end
			end
		end
		--  PKable Human Player is around ---------
		if #pc_around > 0 then
			for i = 1, #pc_around do
				if distance(player, pc_around[i]) <= 2 then
					if pc_around[i].ID ~= player.ID then
						if pc_around[i].state ~= 1 and player:canPK(pc_around[i]) then
							wither.takeDamage(player, pc_around[i], damage)
						end
					end
				end
			end
		end
	end,
	takeDamage = function(player, target, damage)
		local caster = Player(player.registry["wither"])
		local threat
		local anim = 421
		local sound
		local duration = 4000
		local r = math.random(1, 1000)

		target.attacker = caster.ID
		if target.blType == BL_MOB then
			threat = target:removeHealthExtend(damage, 1, 1, 0, 1, 2)
			player:addThreat(target.ID, threat)
		end
		target:sendAnimation(anim)
		target:removeHealthExtend(damage, 1, 1, 0, 1, 1)
	end,
	requirements = function(player)
		local level = 5
		local item = {0}
		local amounts = {50000}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Wither is a damage over time Area affect spell!!", txt}
		return level, item, amounts, desc
	end
}
