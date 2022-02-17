-------------------------------------------------------
--   Spell: Steal Essence
--   Class: Scoundrel
--   Level: 18
--  Aether: 12 Second
--    Cost: 0
-- DmgType: Physical
--    Type: Offensive
-- Targets: 1
-- Effects: Mana and Vita Recover
-------------------------------------------------------
--    Desc: Moderate damage to a single foe
--          Recover some of your missing Mana and Vita
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 07/07/2017
-------------------------------------------------------
steal_essence = {
	on_learn = function(player)
		player.registry["learned_steal_essence"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_steal_essence"] = 0
	end,
	cast = function(player)
		----------------------
		--Varable Declarations
		----------------------
		--local magicCost = (player.level * 6)
		local magicCost = 0
		local aether = 13000
		local missingHealth = player.maxHealth * 0.17
		local missingMagic = player.maxMagic * 0.21

		local mobTarget = getTargetFacing(player, BL_MOB)
		local pcTarget = getTargetFacing(player, BL_PC)

		local threat

		local m = player.m
		local x = player.x
		local y = player.y

		local anim = 89
		local anim2 = 322
		local anim3 = 304
		local sound = 67
		---------------------------
		--- Spell Damage Formula---
		---------------------------

		local damage
		player.critChance = 1
		-------------------------------------------------------
		if not player:canCast(1, 1, 0) then
			player:sendAnimation(246)
			return
		end

		if player.magic < magicCost or player.magic - magicCost <= 0 then
			player:sendAnimation(246)
			player:sendMinitext("Not enough mana.")
			return
		end
		-------------------------------------------------------
		if mobTarget ~= nil then
			damage = math.floor(((0.025 * player.maxHealth) + (0.1 * player.level) + swingDamage(player, mobTarget, 2)) * 2)
			mobTarget.attacker = player.ID
			player:sendAction(1, 20)
			player:setAether("steal_essence", aether)
			player:sendMinitext("You steal " .. mobTarget.name .. "'s essence")
			if player.registry["extra_spell_info"] > 0 then
				player:sendMinitext("Steal Essence DMG: " .. damage)
			end
			player:playSound(sound)
			player:sendAnimation(anim2)
			player:sendAnimation(anim3)
			threat = mobTarget:removeHealthExtend(damage, 1, 1, 0, 1, 2)
			player.magic = (player.magic + missingMagic)
			player.health = (player.health + missingHealth)
			player:calcStat()
			player:sendStatus()
			player:addThreat(mobTarget.ID, threat)
			mobTarget:sendAnimation(anim)
			mobTarget:removeHealthExtend(damage, 1, 1, 0, 1, 1)
		elseif pcTarget ~= nil then
			if (player:canPK(pcTarget)) then
				damage = math.floor(((0.025 * player.maxHealth) + (0.1 * player.level) + swingDamage(player, pcTarget, 2)) * 2)
				pcTarget.attacker = player.ID
				player:sendAction(1, 20)
				player:setAether("steal_essence", aether)
				player:sendStatus()
				player:sendMinitext("You steal " .. pcTarget.name .. "'s essence")
				player:playSound(sound)
				player:sendAnimation(anim2)
				pcTarget:sendAnimation(anim)
				player.magic = (player.magic + missingMagic)
				player.health = (player.health + missingHealth)
				player:sendStatus()
				pcTarget.magic = pcTarget.magic - damage
				pcTarget:calcStat()
				pcTarget:removeHealthExtend(damage, 1, 1, 0, 1, 1)
			end
		end
	end,
	requirements = function(player)
		local level = 18
		local item = {0, 3010, 3011, 53}
		local amounts = {3250, 5, 1, 20}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {
			"So you think you're a thief? Steal Essence will allow you to steal an enemy's life and magical energy and use it for yourself. Impressive, huh?",
			txt
		}
		return level, item, amounts, desc
	end
}
