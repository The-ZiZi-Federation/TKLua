-------------------------------------------------------
--   Spell: Vagabond's Cunning
--   Class: Scoundrel
--   Level: 55
--  Aether: 0 Second
--    Cost: 1000
--    Type: Rage Bonus
-- Targets: Self
-- Effects: Rage Mult: 12x
--        : Flank
--
--                  . X .
--					. X .
--                  . P .
--                  . . .
--
-------------------------------------------------------
--    Desc: 12x your damage output to swing and spells while cast.
--        : Gain flanking and the ability to hit up to eight targets at once.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 07/07/2017
-------------------------------------------------------
vagabonds_cunning = {
	on_learn = function(player)
		player.registry["learned_vagabonds_cunning"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_vagabonds_cunning"] = 0
	end,
	cast = function(player)
		local magicCost = 1000
		local duration = 600000
		local sound = 31
		local anim = 35

		if not player:canCast(1, 1, 0) then
			return
		end
		if player:hasDuration("vagabonds_cunning") then
			player:setDuration("vagabonds_cunning", 0)
			return
		end
		if player.magic < magicCost then
			notEnoughMP(player)
			return
		end

		player:sendAction(6, 20)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:sendAnimation(anim)
		player:playSound(sound)
		player:setDuration("vagabonds_cunning", duration)
		player:calcStat()
		player:sendMinitext("You cast Vagabond's Cunning")
	end,
	on_swing_while_cast = function(player)
		if player.side == 0 then
			pcflankTargets = {player:getObjectsInCell(player.m, player.x, player.y - 2, BL_PC)[1]}
			mobflankTargets = {player:getObjectsInCell(player.m, player.x, player.y - 2, BL_MOB)[1]}
		elseif player.side == 1 then
			pcflankTargets = {player:getObjectsInCell(player.m, player.x + 2, player.y, BL_PC)[1]}
			mobflankTargets = {player:getObjectsInCell(player.m, player.x + 2, player.y, BL_MOB)[1]}
		elseif player.side == 2 then
			pcflankTargets = {player:getObjectsInCell(player.m, player.x, player.y + 2, BL_PC)[1]}
			mobflankTargets = {player:getObjectsInCell(player.m, player.x, player.y + 2, BL_MOB)[1]}
		elseif player.side == 3 then
			pcflankTargets = {player:getObjectsInCell(player.m, player.x - 2, player.y, BL_PC)[1]}
			mobflankTargets = {player:getObjectsInCell(player.m, player.x - 2, player.y, BL_MOB)[1]}
		end

		local pcTarget = getTargetFacing(player, BL_PC)
		local mobTarget = getTargetFacing(player, BL_MOB)
		local pass = getFacingPass(player, i)

		for i = 1, 1 do
			if (pcflankTargets[i] ~= nil) then
				if pcflankTargets[i].state ~= 1 and player:canPK(pcflankTargets[i]) then
					player:swingTarget(pcflankTargets[i])
				end
			end
		end

		for i = 1, 1 do
			if (mobflankTargets[i] ~= nil) then
				player:swingTarget(mobflankTargets[i])
				mobflankTargets[i].attacker = player.ID
				if not mobflankTargets[i]:hasDuration("bleed") then
					mobflankTargets[i]:setDuration("bleed", 3000)
				end
			end
		end

		if mobTarget ~= nil then
			if not mobTarget:hasDuration("bleed") then
				mobTarget.attacker = player.ID
				mobTarget:setDuration("bleed", 3000)
			end
		elseif pcTarget ~= nil then
			if (player:canPK(pcTarget)) then
				pcTarget.attacker = player.ID
				pcTarget:setDuration("bleed", 3000)
			end
		end
	end,
	recast = function(player)
		player.rage = 15
	end,
	uncast = function(player)
		player:calcStat()
	end,
	requirements = function(player)
		local level = 55
		local item = {0}
		local amounts = {35000}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Vagabond's Cunning is a stronger version of Catspaw's Cunning.", txt}
		return level, item, amounts, desc
	end
}
