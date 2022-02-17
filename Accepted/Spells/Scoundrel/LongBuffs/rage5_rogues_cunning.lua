-------------------------------------------------------
--   Spell: Rogue's Cunning
--   Class: Scoundrel
--   Level: 69
--  Aether: 0 Second
--    Cost: 2200
--    Type: Rage Bonus
-- Targets: Self
-- Effects: Rage Mult: 17x
--        : Flank
--                  . X .
--					. X .
--                  X P X
--                  . . .
-------------------------------------------------------
--    Desc: 9x your damage output to swing and spells while cast.
--        : Gain flanking and the ability to hit up to eight targets at once.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 6/5/2017
-------------------------------------------------------
rogues_cunning = {
	on_learn = function(player)
		player.registry["learned_rogues_cunning"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_rogues_cunning"] = 0
	end,
	cast = function(player)
		local magicCost = 2200
		local duration = 600000
		local sound = 31
		local anim = 35

		if not player:canCast(1, 1, 0) then
			return
		end
		if player:hasDuration("rogues_cunning") then
			player:setDuration("rogues_cunning", 0)
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
		player:setDuration("rogues_cunning", duration)
		player:calcStat()
		player:sendMinitext("You cast Rogue's Cunning")
	end,
	on_swing_while_cast = function(player)
		if player.side == 0 then
			pcflankTargets = {
				player:getObjectsInCell(player.m, player.x, player.y - 2, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y, BL_PC)[1]
			}
			mobflankTargets = {
				player:getObjectsInCell(player.m, player.x, player.y - 2, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)[1]
			}
		elseif player.side == 1 then
			pcflankTargets = {
				player:getObjectsInCell(player.m, player.x + 2, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x, player.y - 1, BL_PC)[1]
			}
			mobflankTargets = {
				player:getObjectsInCell(player.m, player.x + 2, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)[1]
			}
		elseif player.side == 2 then
			pcflankTargets = {
				player:getObjectsInCell(player.m, player.x, player.y + 2, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y, BL_PC)[1]
			}
			mobflankTargets = {
				player:getObjectsInCell(player.m, player.x, player.y + 2, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)[1]
			}
		elseif player.side == 3 then
			pcflankTargets = {
				player:getObjectsInCell(player.m, player.x - 2, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x, player.y - 1, BL_PC)[1]
			}
			mobflankTargets = {
				player:getObjectsInCell(player.m, player.x - 2, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)[1]
			}
		end

		local pcTarget = getTargetFacing(player, BL_PC)
		local mobTarget = getTargetFacing(player, BL_MOB)
		local pass = getFacingPass(player, i)

		for i = 1, 3 do
			if (pcflankTargets[i] ~= nil) then
				if pcflankTargets[i].state ~= 1 and player:canPK(pcflankTargets[i]) then
					player:swingTarget(pcflankTargets[i])
				end
			end
		end

		for i = 1, 3 do
			if (mobflankTargets[i] ~= nil) then
				player:swingTarget(mobflankTargets[i])
				mobflankTargets[i].attacker = player.ID
				if not mobflankTargets[i]:hasDuration("bleed") then
					mobflankTargets[i].registry["bleed"] = player.ID
					if not mobflankTargets[i]:hasDuration("bleed") then
						mobflankTargets[i]:setDuration("bleed", 4000)
					end
				end
			end
		end

		if mobTarget ~= nil then
			if not mobTarget:hasDuration("bleed") then
				mobTarget.attacker = player.ID
				mobTarget.registry["bleed"] = player.ID
				mobTarget:setDuration("bleed", 4000)
			end
		elseif pcTarget ~= nil then
			if (player:canPK(pcTarget)) then
				pcTarget.attacker = player.ID
				pcTarget.registry["bleed"] = player.ID
				pcTarget:setDuration("bleed", 4000)
			end
		end
	end,
	recast = function(player)
		player.rage = 20
	end,
	uncast = function(player)
		player:calcStat()
	end,
	requirements = function(player)
		local level = 69
		local item = {0}
		local amounts = {35000}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Rogue's Cunning is a stronger version of Vagabond's Cunning.", txt}
		return level, item, amounts, desc
	end
}
