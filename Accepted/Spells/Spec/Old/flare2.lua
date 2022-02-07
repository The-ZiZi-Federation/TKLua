-- level 6 mage F1 flare2 single target zap Lv1
--[[
flare2 = {

    on_learn = function(player) player.registry["learned_flare2"] = 1 end,
    on_forget = function(player) player.registry["learned_flare2"] = 0 end,

cast = function(player, target)

	local weaponDamage = math.random(player.minDam, player.maxDam)
	local will = player.will
	local willBonusPct = (will/(will+50)^1.1)
	local add = 1
	local fury = 1	

	local aether = 1000

	local threat

	local anim = 414
	local sound = 58

	local mobTargetNorth = player:getObjectsInCell(target.m, target.x, target.y - 1, BL_MOB)
	local mobTargetSouth = player:getObjectsInCell(target.m, target.x, target.y + 1, BL_MOB)
	local mobTargetEast = player:getObjectsInCell(target.m, target.x + 1, target.y, BL_MOB)
	local mobTargetWest = player:getObjectsInCell(target.m, target.x - 1, target.y, BL_MOB)

	fury = 12
	add = 6
	wildCard = 125

	local magicCost = wildCard * fury

	local damage = (((weaponDamage + (weaponDamage * willBonusPct))*fury)*add)
	
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

	
	if (target.blType == BL_MOB) then
		player.magic = player.magic - magicCost
		player:sendAction(6, 20)
		player:sendStatus()
		player:setAether("flare2", aether)
		player:playSound(sound)
		target:sendAnimation(anim)
		player:sendMinitext("You cast Flare Lv2")
		target.attacker = player.ID
		if player:hasDuration("flame_surge") then target:setDuration("seared", 2000) end
		threat = target:removeHealthExtend(damage, 1, 1, 1, 1, 2)
		player:addThreat(target.ID, threat)
		target:removeHealthExtend(damage, 1, 1, 1, 1, 0)
	elseif (target.blType == BL_PC and player:canPK(target)) then
		player:sendAction(6, 20)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:setAether("flare2", aether)
		player:playSound(sound)
		target:sendAnimation(anim)
		player:sendMinitext("You cast Flare Lv2")
		target.attacker = player.ID
		target:removeHealthExtend(damage, 1, 1, 1, 1, 0)
		target:sendMinitext(player.name.." burns you with Flare Lv2")
	end
	
	if mobTargetNorth ~= nil then
		mobTargetNorth[1]:sendAnimation(anim)
		mobTargetNorth[1].attacker = player.ID
		if player:hasDuration("flame_surge") then mobTargetNorth[1]:setDuration("seared", 1000) end
		threat = mobTargetNorth[1]:removeHealthExtend(damage, 1, 1, 1, 1, 2)
		player:addThreat(mobTargetNorth[1].ID, threat)
		mobTargetNorth[1]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
		
	end
	
	if mobTargetSouth ~= nil then
		mobTargetSouth[1]:sendAnimation(anim)
		mobTargetSouth[1].attacker = player.ID
		if player:hasDuration("flame_surge") then mobTargetSouth[1]:setDuration("seared", 1000) end
		threat = mobTargetSouth[1]:removeHealthExtend(damage, 1, 1, 1, 1, 2)
		player:addThreat(mobTargetSouth[1].ID, threat)
		mobTargetSouth[1]:removeHealthExtend(damage, 1, 1, 1, 1, 0)	
	end
	
	if mobTargetEast ~= nil then
		mobTargetEast[1]:sendAnimation(anim)
		mobTargetEast[1].attacker = player.ID
		if player:hasDuration("flame_surge") then mobTargetEast[1]:setDuration("seared", 1000) end
		threat = mobTargetEast[1]:removeHealthExtend(damage, 1, 1, 1, 1, 2)
		player:addThreat(mobTargetEast[1].ID, threat)
		mobTargetEast[1]:removeHealthExtend(damage, 1, 1, 1, 1, 0)	
	end
	
	if mobTargetWest ~= nil then
		mobTargetWest[1]:sendAnimation(anim)
		mobTargetWest[1].attacker = player.ID
		if player:hasDuration("flame_surge") then mobTargetWest[1]:setDuration("seared", 1000) end
		threat = mobTargetWest[1]:removeHealthExtend(damage, 1, 1, 1, 1, 2)
		player:addThreat(mobTargetWest[1].ID, threat)
		mobTargetWest[1]:removeHealthExtend(damage, 1, 1, 1, 1, 0)	
	end
end
}
]]
--
