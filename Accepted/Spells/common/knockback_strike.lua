-------------------------------------------------------
--   Spell: Knockback Strike
--   Class: Any
--   Level: ??
--  Aether: 30 Second
--    Cost: 20% mana
-- DmgType: Physical
--    Type: Offensive
-- Targets: 1
-- Effects: Knockback 1 Tile
-- 			Stun (3 Seconds)
-------------------------------------------------------
--    Desc: A heavy strike against three foes.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 11/02/2016
-------------------------------------------------------
knockback_strike = {
	on_learn = function(player)
		player.registry["learned_knockback_strike"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_knockback_strike"] = 0
	end,
	cast = function(player)
		----------------------
		--Varable Declarations
		----------------------
		local aether = 100000
		local magicCost = math.floor(player.maxMagic * 0.2)
		local mobTarget = getTargetFacing(player, BL_MOB)
		local pcTarget = getTargetFacing(player, BL_PC)

		local nodes = {}

		local m = player.m
		local x = player.x
		local y = player.y
		local threat
		local anim = 349
		local sound = 14
		---------------------------
		--- Spell Damage Formula---
		---------------------------
		local manaMult = 1.5
		local levelMult = 150
		local willMult = 150
		local graceMult = 150
		local swingMult = 0

		local damage
		if player.baseClass == 1 then
			swingMult = 10
		elseif player.baseClass == 2 then
			swingMult = 7
		elseif player.baseClass == 3 then
			damage = (player.maxMagic * manaMult) + (player.level * levelMult)
		elseif player.baseClass == 4 then
			swingMult = 13
		end
		---------------------------------------------
		if (not player:canCast(1, 1, 0)) then
			return
		end
		player.critChance = 1

		----------------------------------------------
		if player.magic < magicCost or player.magic - magicCost <= 0 then
			player:sendAnimation(246)
			player:sendMinitext("Not Enough MP.")
			return
		end
		------------------------------------------
		-- Prevent hitting crafting mobs / nodes--
		------------------------------------------
		for i = 1, #nodes do
			if mobTarget.mobID == nodes[i] then
				player:sendMinitext("Nope!")
				return
			end
		end

		---------------------
		-- Target is Mob ----
		---------------------
		if mobTarget ~= nil then
			if player.baseClass ~= 3 then
				damage = ((0.025 * player.maxHealth) + (0.1 * player.level) + swingDamage(player, mobTarget, 2)) * swingMult
			end
			-- Set Para --
			--		mobTarget.paralyzed = 1
			mobTarget.attacker = player.ID
			-- Action, Animation, Text, Sound ---
			player:sendAction(1, 20)
			player:talk(2, "Back off!")
			player:sendMinitext("You cast Knockback Strike")
			player:sendAnimation(anim)
			player:playSound(sound)
			player:setAether("knockback_strike", aether)
			-- Agro --
			threat = mobTarget:removeHealthExtend(damage, 1, 1, 0, 1, 2)
			player:addThreat(mobTarget.ID, threat)
			-- Check Knockback
			around_push_stun.aroundCheck(player, BL_MOB, 1)
			-- Animation on Enemy --
			mobTarget:sendAnimation(332)
			-- Apply Damage --
			mobTarget:removeHealthExtend(damage, 1, 1, 0, 1, 1)
			-- End Para --
			--		mobTarget.paralyzed = 0
			-- Pay MP Cost ----
			player.magic = player.magic - magicCost
			player:sendStatus()
		elseif pcTarget ~= nil then
			if (player:canPK(pcTarget)) then
				if player.baseClass ~= 3 then
					damage = ((0.025 * player.maxHealth) + (0.1 * player.level) + swingDamage(player, mobTarget, 2)) * swingMult
				end
				around_push_stun.aroundCheck(player, BL_PC, 1)
				pcTarget.attacker = player.ID
				player:sendAction(1, 20)
				player:talk(2, "Back off!")
				player.magic = player.magic - magicCost
				player:sendStatus()
				player:sendMinitext("You cast Knockback Strike")
				player:sendAnimation(anim)
				pcTarget:sendAnimation(332, 0)
				player:playSound(sound)
				player:setAether("knockback_strike", aether)
				pcTarget:removeHealthExtend(damage, 1, 1, 0, 1, 1)
			end
		end
	end
}
