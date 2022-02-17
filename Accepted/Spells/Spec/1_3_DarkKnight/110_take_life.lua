-------------------------------------------------------
--   Spell: Take Life
--   Class: DarkKnight
--   Level: 110
--  Aether: 19 Second
-- DmgType: Physical
--    Type: Offensive
-- Targets: 1
--          . X .
--          . P .
--          . . .
-- Effects: N/A
-------------------------------------------------------
--    Desc:
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 07/07/2017
-------------------------------------------------------
take_life = {
	on_learn = function(player)
		player.registry["learned_take_life"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_take_life"] = 0
	end,
	cast = function(player)
		----------------------
		--Varable Declarations
		----------------------
		local mobTarget = getTargetFacing(player, BL_MOB)
		local pcTarget = getTargetFacing(player, BL_PC)
		local threat
		local aether = 30000
		local magicCost = 5000
		local healAmount = 50000
		local damage = 100000

		local anim = 183 --410?
		local anim2 = 240
		local sound = 507

		player.critChance = 1

		-------------------------------------------------------
		if (not player:canCast(1, 1, 0)) then
			return
		end

		-------------------------------------------------------
		if player.magic < magicCost or player.magic - magicCost <= 0 then
			player:sendAnimation(246)
			player:sendMinitext("Not Enough MP.")
			return
		end
		------------------------------------
		if mobTarget ~= nil then
			mobTarget.attacker = player.ID
			player:sendAction(1, 20)
			player:talk(2, "Your soul is mine!")
			player:sendMinitext("You cast Take Life")
			if player.registry["extra_spell_info"] > 0 then
				player:sendMinitext("Take Life DMG: " .. damage)
			end
			player:setAether("take_life", aether)
			player:playSound(sound)
			mobTarget:sendAnimation(anim)
			player:sendAnimation(anim2)
			player.magic = player.magic - magicCost
			threat = mobTarget:removeHealthExtend(damage, 1, 1, 0, 1, 2)
			player:addThreat(mobTarget.ID, threat)
			player:addHealth(healAmount)
			player:sendStatus()
			mobTarget:removeHealthExtend(damage, 1, 1, 0, 1, 1)
		elseif pcTarget ~= nil then
			if (player:canPK(pcTarget)) then
				pcTarget.attacker = player.ID
				-- Action, Animation, Text, Sound ---
				player:sendAction(1, 20)
				player:talk(2, "YOU'RE DEAD!")
				player:sendMinitext("You cast Take Life")
				player:setAether("take_life", aether)
				player:playSound(sound)
				pcTarget:sendAnimation(anim)
				player:sendAnimation(anim2)
				-- Apply Damage, pay MP Cost ----
				player.magic = player.magic - magicCost
				player:addHealth(healAmount)
				player:sendStatus()
				pcTarget:removeHealthExtend(damage, 1, 1, 0, 1, 1)
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

		local desc = {"Drain another's life force and use it as your own.", txt}
		return level, item, amounts, desc
	end
}
