--[[
-------------------------------------------------------
--   Spell: Take Life                        
--   Class: Blackguard
--   Level: 110
--  Aether: 25 Second
--    Cost: 35 MP per Level
-- DmgType: Physical
--    Type: Offensive
-- Targets: 1
-- Effects: Stun (4 Seconds)
-------------------------------------------------------
--    Desc: Drain HP from an enemy
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 3/25/2017
-------------------------------------------------------
take_life_old
 = {

    on_learn = function(player) player.registry["learned_take_life"] = 1 end,
    on_forget = function(player) player.registry["learned_take_life"] = 0 end,

cast = function(player)
	------------------------
	--Varable Declarations--
	------------------------
	local magicCost = player.level * 35
    local aether = 25000
	local stunDura = 4000
	local healAmount = 0
---------------------------------------------
	local weap = player:getEquippedItem(0)
	local weaponName
	local weaponBalance

	if weap == nil then
    	maxWeaponDam = 0
    	minWeaponDam = 0
    	weaponBalance = 0
    	weaponCritical = 0
	else
	    maxWeaponDam = weap.maxDmg
	    minWeaponDam = weap.minDmg
	    weaponBalance = (weap.dam*.01)
	    weaponCritical = weap.hit
	end

	local weaponSwingDamage
	local weaponDamageRange
	local finalWeaponDamage
	local avgWeaponDamage
	local finalSwingDamage

	local might = player.might
	local grace = player.grace
	local mightBonusPct
	local mightBonusPctDamage
	local mightBalanceBonus
	local graceBalanceBonus
	local totalBalancePct
	local balanceOffset

	local barehandDamage
	local buff = player.fury

	local mobTarget = getTargetFacing(player, BL_MOB)
	local pcTarget = getTargetFacing(player, BL_PC)

	local m = player.m
	local x = player.x
	local y = player.y
	local threat
--------------------------------
	mightBonusPct = ((might / (might + 50)) ^ 1.1)
	mightBalanceBonus = (might / (might + 3995))
	graceBalanceBonus = (grace / (grace + 3995))
	
	totalBalancePct = (weaponBalance + (mightBalanceBonus + graceBalanceBonus))
	weaponDamageRange = (maxWeaponDam - minWeaponDam)
	balanceOffset = (totalBalancePct * weaponDamageRange)
	
	avgWeaponDamage = (minWeaponDam + balanceOffset)
	bareHandDamage = (might + (might * (mightBonusPct)))									-- Barehanded Damage is based off of Might and the Might Bonus Damage 
	
	weaponSwingDamage = (avgWeaponDamage + (avgWeaponDamage * (mightBonusPct)))			-- Weapon Damage is the Average Damage + Bonus Damage from Might % times the FURY Mult.
	finalSwingDamage = (bareHandDamage + weaponSwingDamage)								-- Final Swing Damage is the combination of Barehanded and Weapon Damage.
---------------------------
--- Spell Damage Formula---
---------------------------
	local mightBase = might ^ 2.1
	local mightMult = might ^ .32
	
	local damCalc = (mightBase * mightMult)

	local damage = math.floor((finalSwingDamage + damCalc) * buff)
-------------------------------------------------------	
	if not player:canCast(1,1,0) then return end
-------------------------------------------------------	
	if player.magic < magicCost then notEnoughMP(player) return end
-------------------------------------------------------	
	if player.state == 1 or player.health <= 0 then return end

	local icon = 2603
	local sound = 0
	local anim = 423
	
	for i = 1, 6 do
		
		local mobTarget = getTargetFacing(player, BL_MOB, 0, i)
		local pcTarget = getTargetFacing(player, BL_PC, 0, i)
		
		if mobTarget ~= nil then
			if player.side == 0 then
				if getPass(player.m, player.x, player.y-i) == 1 then return else player:throw(player.x, player.y-i, icon, 0, 1) end
			elseif player.side == 1 then
				if getPass(player.m, player.x+i, player.y) == 1 then return else player:throw(player.x+i, player.y, icon, 0, 1) end
			elseif player.side == 2 then
				if getPass(player.m, player.x, player.y+i) == 1 then return else player:throw(player.x, player.y+i, icon, 0, 1) end
			elseif player.side == 3 then
				if getPass(player.m, player.x-i, player.y) == 1 then return else player:throw(player.x-i, player.y, icon, 0, 1) end
			end
			mobTarget.attacker = player.ID
			player:sendAction(1, 20)
			player.magic = player.magic - magicCost
			player:setAether("take_life", aether)
			player:sendStatus()
			if player.gmLevel < 1 then
				player:sendMinitext("You cast Take Life")
			end
			if player.gmLevel > 0 then
				player:sendMinitext("Take Life DMG: "..damage)
			end
			player:playSound(sound)
			threat = mobTarget:removeHealthExtend(damage, 1, 1, 1, 1, 2)
			player:addThreat(mobTarget.ID, threat)
			mobTarget:sendAnimation(anim)
			mobTarget:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			mobTarget.paralyzed = true
			mobTarget:setDuration("stun", stunDura)
			player:addHealth(healAmount)
			return
		elseif pcTarget ~= nil then
			if player:canPK(pcTarget) and pcTarget.state ~= 1 then
				if player.side == 0 then
					if getPass(player.m, player.x, player.y-i) == 1 then return else player:throw(player.x, player.y-i, icon, 0, 1) end
				elseif player.side == 1 then
					if getPass(player.m, player.x+i, player.y) == 1 then return else player:throw(player.x+i, player.y, icon, 0, 1) end
				elseif player.side == 2 then
					if getPass(player.m, player.x, player.y+i) == 1 then return else player:throw(player.x, player.y+i, icon, 0, 1) end
				elseif player.side == 3 then
					if getPass(player.m, player.x-i, player.y) == 1 then return else player:throw(player.x-i, player.y, icon, 0, 1) end
				end			
				pcTarget.attacker = player.ID
				player:sendAction(1, 20)
				player.magic = player.magic - magicCost
				player:setAether("take_life", aether)
				player:sendStatus()
				if player.gmLevel < 1 then
				player:sendMinitext("You cast Take Life")
				end
				if player.gmLevel > 0 then
					player:sendMinitext("Take Life DMG: "..damage)
				end
				player:playSound(sound)
				threat = pcTarget:removeHealthExtend(damage, 1, 1, 1, 1, 2)
				player:addThreat(pcTarget.ID, threat)
				pcTarget:sendAnimation(anim)
				pcTarget:removeHealthExtend(damage, 1, 1, 1, 1, 0)
				pcTarget.paralyzed = true
				pcTarget:setDuration("stun", stunDura)
				if player.health >= 1 then player:addHealth(healAmount) end
			end
			return
		end	
	end
end
}
]]
--
