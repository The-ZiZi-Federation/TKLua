--[[
wider_slash = {

on_learn = function(player) player.registry["learned_wider_slash"] = 1 end,
on_forget = function(player) player.registry["learned_wider_slash"] = 0 end,


cast = function(player)
	local fury = player.fury
	local mobflankTargets = {}
	local pcflankTargets = {}
	local aether = 6000
	local damage = ((player.maxHealth*.45)+(player.might*25))*fury
	local damage2 = (((player.maxHealth*.45)+(player.might*25))*fury)*2
	local threat
	local magicCost = 50
	local counter = false
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end
	
if player.side == 0 then
		pcflankTargets = {player:getObjectsInCell(player.m, player.x, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y, BL_PC)[1]}

		mobflankTargets = {player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)[1]}
	
	elseif player.side == 1 then
		pcflankTargets = {player:getObjectsInCell(player.m, player.x + 1, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x, player.y - 1, BL_PC)[1]}

		mobflankTargets = {player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)[1]}
	
	elseif player.side == 2 then
		pcflankTargets = {player:getObjectsInCell(player.m, player.x, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y, BL_PC)[1]}

		mobflankTargets = {player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)[1]}
	elseif player.side == 3 then
		pcflankTargets = {player:getObjectsInCell(player.m, player.x - 1, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x, player.y - 1, BL_PC)[1]}

		mobflankTargets = {player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)[1]}
	end	
	


	if #mobflankTargets > 0 then
		player.magic = player.magic - magicCost
		player:sendAction(1, 20)
		player:setAether("wider_slash", aether)
		player:sendMinitext("You use Wide Slash")
		player:playSound(14)
		player:sendStatus()
	elseif #pcflankTargets > 0 then
		player:sendAction(1, 20)
		player:setAether("wider_slash", aether)
		player:sendMinitext("You use Wider Slash")
		player:playSound(14)
		player.magic = player.magic - magicCost
		player:sendStatus()
	end	

	
	
	for i = 1, 5 do
		if (mobflankTargets[i] ~= nil) then
			mobflankTargets[i].attacker = player.ID
			threat = mobflankTargets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 2)
			player:addThreat(mobflankTargets[i].ID, threat)
			mobflankTargets[i]:sendAnimation(67)
			if player.baseClass == 2 and mobflankTargets[i]:hasDuration("stun") then
				mobflankTargets[i]:removeHealthExtend(damage2, 1, 1, 1, 1, 0)
			else
				mobflankTargets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			end
		elseif (pcflankTargets[i] ~= nil) then
			if (player:canPK(pcflankTargets[i])) then
				pcflankTargets[i].attacker = player.ID
				pcflankTargets[i]:sendAnimation(67)
				if player.baseClass == 2 and pcflankTargets[i]:hasDuration("stun") then
					pcflankTargets[i]:removeHealthExtend(damage2, 1, 1, 1, 1, 0)
				else
					pcflankTargets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
				end
				pcflankTargets[i]:sendMinitext(player.name.." strikes you with a Wider Slash")
			end
		else
			
		end
	end
end
}]]
--
--[[if (player.side == 0) then
				if (i == 1) then
					player:sendAnimationXY(6, player.x, player.y - 1, 0)
				elseif (i == 2) then
					player:sendAnimationXY(6, player.x - 1, player.y - 1, 0)
				elseif (i == 3) then
					player:sendAnimationXY(6, player.x + 1, player.y - 1, 0)
				end
			elseif (player.side == 1) then
				if (i == 1) then
					player:sendAnimationXY(6, player.x + 1, player.y, 0)
				elseif (i == 2) then
					player:sendAnimationXY(6, player.x + 1, player.y - 1, 0)
				elseif (i == 3) then
					player:sendAnimationXY(6, player.x + 1, player.y + 1, 0)
				end
			elseif (player.side == 2) then
				if (i == 1) then
					player:sendAnimationXY(6, player.x, player.y + 1, 0)
				elseif (i == 2) then
					player:sendAnimationXY(6, player.x - 1, player.y + 1, 0)
				elseif (i == 3) then
					player:sendAnimationXY(6, player.x + 1, player.y + 1, 0)
				end
			elseif (player.side == 3) then
				if (i == 1) then
					player:sendAnimationXY(6, player.x - 1, player.y, 0)
				elseif (i == 2) then
					player:sendAnimationXY(6, player.x - 1, player.y - 1, 0)
				elseif (i == 3) then
					player:sendAnimationXY(6, player.x - 1, player.y + 1, 0)
				end
			end]]
--
