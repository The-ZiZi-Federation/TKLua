--[[
mercenary_fury = {

on_learn = function(player) 
	player.registry["learned_mercenary_fury"] = 1 
	if (player:hasSpell("combat_premonition")) then	player:removeSpell("combat_premonition") end
end,

on_forget = function(player)
	player.registry["learned_mercenary_fury"] = 0 
end,

cast = function(player)

	local magicCost = 50
	local dura = 500000
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	if player:hasDuration("combat_clairvoyance") or player:hasDuration("combat_foresight") or player:hasDuration("combat_perception") or player:hasDuration("combat_reflexes") or player:hasDuration("mercenary_fury") then
		anim(player)
		player:sendMinitext("Spell is already cast!")
	return else
		if player.fury < 4 then
			player:setDuration("mercenary_fury", dura)
			player:sendAction(6, 20)
			player.magic = player.magic - magicCost
			player.fury = 45
			player:sendStatus()
			player:sendAnimation(279)
			player:playSound(9)
			player:sendMinitext("You cast Mercenary Fury")
		end
	end
end,

while_cast = function(player)
	

end,

on_swing_while_cast = function(player)

	if player.side == 0 then
		pcflankTargets = {player:getObjectsInCell(player.m, player.x + 1, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_PC)[1]}

		mobflankTargets = {player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_MOB)[1]}


	
	elseif player.side == 1 then
		pcflankTargets = {player:getObjectsInCell(player.m, player.x, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_PC)[1]}

		mobflankTargets = {player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_MOB)[1]}
	
	elseif player.side == 2 then
		pcflankTargets = {player:getObjectsInCell(player.m, player.x + 1, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_PC)[1]}

		mobflankTargets = {player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_MOB)[1]}


	elseif player.side == 3 then
		pcflankTargets = {player:getObjectsInCell(player.m, player.x + 1, player.y, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_PC)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_PC)[1]}

		mobflankTargets = {player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_MOB)[1],
				player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_MOB)[1]}
	end	
	


	local pcTarget =  getTargetFacing(player, BL_PC)
	local mobTarget = getTargetFacing(player, BL_MOB)
	local pass = getFacingPass(player, i)
	
	for i = 1, 7 do
		if (pcflankTargets[i] ~= nil) then
			if pcflankTargets[i].state ~= 1 and player:canPK(pcflankTargets[i]) then
				player:swingTarget(pcflankTargets[i])
			end
		end
	end


	for i = 1, 7 do
		if (mobflankTargets[i] ~= nil) then
			player:swingTarget(mobflankTargets[i])
			--mobflankTargets[i].attacker = player.ID
			--mobflankTargets[i]:setDuration("bleed", 8000)

		end
	end



	if mobTarget ~= nil then
		if not mobTarget:hasDuration("bleed") then
			mobTarget.attacker = player.ID
			mobTarget.registry["bleed"] = player.ID
			mobTarget:setDuration("bleed", 8000)
		end
	elseif pcTarget ~= nil then		
		if (player:canPK(pcTarget)) then
			pcTarget.attacker = player.ID
			pcTarget.registry["bleed"] = player.ID
			pcTarget:setDuration("bleed", 8000)
		end
	end	
end,

uncast = function(player) 
	player.fury = 1
	player:calcStat() end,



requirements = function(player)

	
	local level = 99
	local item = {} 
	local amounts = {}
	local desc = {"Attack Damage x 11 and cause target to bleed."}
	return level, item, amounts, desc
end
}]]
--
