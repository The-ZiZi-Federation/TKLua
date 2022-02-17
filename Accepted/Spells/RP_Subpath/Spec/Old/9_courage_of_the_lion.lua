--[[
-------------------------------------------------------
--   Spell: Courage of the Lion 
--   Class: Fighter
--   Level: 150
--  Aether: 0 Second
--    Cost: ? MP
--    Type: Fury
-- Targets: Self
-- Effects: Fury Mult: 6x
--        : Flank
--                 . . X . .					
--                 . X X X .
--                 X X P X X
--                 . X X X . 
--                 . . X . .
-------------------------------------------------------
--    Desc: Hextuple your damage output to swing and spells while cast.
--        : Gain flanking and the ability to hit up to eight targets at once.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 3/25/2017
-------------------------------------------------------
courage_of_the_lion = {

on_learn = function(player) player.registry["learned_courage_of_the_lion"] = 1 end,
on_forget = function(player) player.registry["learned_courage_of_the_lion"] = 0 end,

cast = function(player)

	local magicCost = 7500
	local duration = 600000
	local lionBuffBonus = 5
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end

	if player:hasDuration("combat_intuition") then
		player:setDuration("combat_intuition", 0)
		return
	end
	
	if player:hasDuration("combat_affinity") then
		player:setDuration("combat_affinity", 0)
		return
	end

	if player:hasDuration("combat_devotion") then
		player:setDuration("combat_devotion", 0) 
		return
	end

	if player:hasDuration("combat_trance") then
		player:setDuration("combat_trance", 0)
		return
	end

	if player:hasDuration("combat_awareness") then
		player:setDuration("combat_awareness", 0)
		return
	end
	
	if player:hasDuration("courage_of_the_lion") then
		player:setDuration("courage_of_the_lion", 0)
		return
	end
	
	if player:hasDuration("rhino_rage") then
		player:setDuration("rhino_rage", 0)
		return
	end
	
	if player:hasDuration("moose_fury") then
		player:setDuration("moose_fury", 0)
		return
	end
	
	if player:hasDuration("strength_of_the_lion") then
		player:setDuration("strength_of_the_lion", 0)
		return
	end
	
	player.registry["lion_buff_bonus"] = lionBuffBonus
	player:sendAction(6, 20)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendAnimation(70)
	player:playSound(9)
	player:setDuration("courage_of_the_lion", duration)
	player:calcStat()
	player:sendMinitext("You cast Courage of the Lion")

--Player(4):talk(0,"set: "..player.registry["trance_buff_bonus"])

end,

on_swing_while_cast = function(player)
	

	if player.side == 0 then
	pcflankTargets = {player:getObjectsInCell(player.m, player.x + 1, player.y, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x - 1, player.y, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x, player.y + 1, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x, player.y - 2, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x, player.y + 2, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x - 2, player.y, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x + 2, player.y, BL_PC)[1]}

	mobflankTargets = {player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x, player.y - 2, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x, player.y + 2, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x - 2, player.y, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x + 2, player.y, BL_MOB)[1]}

	elseif player.side == 1 then
		pcflankTargets = {player:getObjectsInCell(player.m, player.x, player.y - 1, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x - 1, player.y, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x, player.y + 1, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x, player.y - 2, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x, player.y + 2, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x - 2, player.y, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x + 2, player.y, BL_PC)[1]}

	mobflankTargets = {player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x, player.y - 2, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x, player.y + 2, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x - 2, player.y, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x + 2, player.y, BL_MOB)[1]}
	
	elseif player.side == 2 then
		pcflankTargets = {player:getObjectsInCell(player.m, player.x + 1, player.y, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x - 1, player.y, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x, player.y - 1, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x, player.y - 2, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x, player.y + 2, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x - 2, player.y, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x + 2, player.y, BL_PC)[1]}

	mobflankTargets = {player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x, player.y - 2, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x, player.y + 2, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x - 2, player.y, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x + 2, player.y, BL_MOB)[1]}

	elseif player.side == 3 then
		pcflankTargets = {player:getObjectsInCell(player.m, player.x + 1, player.y, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x, player.y - 1, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x, player.y + 1, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x, player.y - 2, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x, player.y + 2, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x - 2, player.y, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x + 2, player.y, BL_PC)[1]}

	mobflankTargets = {player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x, player.y - 2, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x, player.y + 2, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x - 2, player.y, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x + 2, player.y, BL_MOB)[1]}
	end	

	for i = 1, 11 do
		if (pcflankTargets[i] ~= nil) then
			if pcflankTargets[i].state ~= 1 and player:canPK(pcflankTargets[i]) then
				player:swingTarget(pcflankTargets[i])
			end
		end
	end


	for i = 1, 11 do
		if (mobflankTargets[i] ~= nil) then
			player:swingTarget(mobflankTargets[i])

		end
	end
end,

recast = function(player)
--Player(4):talk(0,""..player.registry["trance_buff_bonus"])

	local lionBuffBonus = player.registry["lion_buff_bonus"]
--Player(4):talk(0,""..tranceBuffBonus)

	player.fury = player.fury + lionBuffBonus
--Player(4):talk(0,""..player.fury)


end,

uncast = function(player) 

	local lionBuffBonus = player.registry["lion_buff_bonus"]

	player.fury = player.fury - lionBuffBonus
	player:calcStat() 
	player.registry["lion_buff_bonus"] = 0
	player:sendMinitext("Your Courage of the Lion fades away")

end
}]]
--
