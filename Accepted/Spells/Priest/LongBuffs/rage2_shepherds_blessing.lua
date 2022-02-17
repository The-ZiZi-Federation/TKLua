-------------------------------------------------------
--   Spell: Shepherd's Blessing
--   Class: Priest
--   Level: 19
--  Aether: 0 Second
--    Cost: 500
--    Type: Rage Bonus
-- Targets: Self
-- Effects: Rage Mult: 3x
--        : Flank
--
--					. X .
--                  X P X
--                  . . .
--
-------------------------------------------------------
--    Desc: 3x your damage output to swing and spells while cast.
--        : Gain flanking and the ability to hit up to three targets at once.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 6/5/2017
-------------------------------------------------------
shepherds_blessing = {
	on_learn = function(player)
		player.registry["learned_shepherds_blessing"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_shepherds_blessing"] = 0
	end,
	cast = function(player)
		local magicCost = 500
		local duration = 600000
		local sound = 31
		local anim = 38

		if not player:canCast(1, 1, 0) then
			return
		end
		if player:hasDuration("shepherds_blessing") then
			player:setDuration("shepherds_blessing", 0)
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
		player:setDuration("shepherds_blessing", duration)
		player:calcStat()
		player:sendMinitext("You cast Shepherd's Blessing")
	end,
	on_swing_while_cast = function(player)
		if player.side == 0 then
			pcflankTargets = {
				player:getObjectsInCell(player.m, player.x + 1, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y, BL_PC)[1]
			}

			mobflankTargets = {
				player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)[1]
			}
		elseif player.side == 1 then
			pcflankTargets = {
				player:getObjectsInCell(player.m, player.x, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x, player.y + 1, BL_PC)[1]
			}

			mobflankTargets = {
				player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)[1]
			}
		elseif player.side == 2 then
			pcflankTargets = {
				player:getObjectsInCell(player.m, player.x + 1, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y, BL_PC)[1]
			}

			mobflankTargets = {
				player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)[1]
			}
		elseif player.side == 3 then
			pcflankTargets = {
				player:getObjectsInCell(player.m, player.x, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x, player.y + 1, BL_PC)[1]
			}

			mobflankTargets = {
				player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)[1]
			}
		end

		for i = 1, 2 do
			if (mobflankTargets[i] ~= nil) then
				player:swingTarget(mobflankTargets[i])
			elseif (pcflankTargets[i] ~= nil) then
				if (player:canPK(pcflankTargets[i])) then
					pcflankTargets[i].attacker = player.ID
					player:swingTarget(pcflankTargets[i])
				end
			end
		end
	end,
	recast = function(player)
		player.rage = 4
	end,
	uncast = function(player)
		player:calcStat()
	end,
	requirements = function(player)
		local level = 19
		local item = {0}
		local amounts = {0}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Shepherd's Blessing is a stronger version of Believer's Blessing.", txt}
		return level, item, amounts, desc
	end
}
