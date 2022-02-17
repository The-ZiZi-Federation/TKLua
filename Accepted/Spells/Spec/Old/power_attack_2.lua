--[[
-------------------------------------------------------
--   Spell: Power Attack Lv2                          
--   Class: Various
--   Level: 125-200
--  Aether: 5 Second
--    Cost: (10 * Level) MP
-- DmgType: Physical
--    Type: Offensive
-- Targets: 1
--          . X . 
--          . P .
--          . . .
-- Effects: N/A
-------------------------------------------------------
--    Desc: A heavy strike against a single foe.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 3/25/2017
-------------------------------------------------------
power_attack_2 = {
on_learned = function(player) player.registry["power_attack_2"]=1 end,
on_forget = function(player) player.registry["power_attack_2"]=0 end,

cast = function(player)
----------------------
--Varable Declarations
----------------------
	local weap = player:getEquippedItem(0)
	local damageType = ""
	local buff = player.fury
	local might = player.might
	local grace = player.grace
	local mightBonusPct = ((might / (might + 50)) ^ 1.1)
	local mightBalanceBonus = (might / (might + 3995))
	local graceBalanceBonus = (grace / (grace + 3995))
	local maxWeaponDam
	local minWeaponDam
	local weaponBalance
	local weaponCritical

	if weap == nil then
    	maxWeaponDam = 0
        minWeaponDam = 0
        weaponBalance = 0
        weaponCritical = 0												-- Set default values for unequipped player.
	else
	    maxWeaponDam = weap.maxDmg
        minWeaponDam = weap.minDmg
        weaponBalance = (weap.dam * .01)
        weaponCritical = weap.hit	
	end

	local weaponDamageRange = (maxWeaponDam - minWeaponDam)
		
	local totalBalancePct = (weaponBalance + (mightBalanceBonus + graceBalanceBonus))
	local balanceOffset = (totalBalancePct * weaponDamageRange)
	local avgWeaponDamage = (minWeaponDam + balanceOffset)

	local barehandDamage = (might + (might * (mightBonusPct)))  -- Barehanded Damage is based off of Might and the Might Bonus Damage
	local weaponSwingDamage = (avgWeaponDamage + (avgWeaponDamage * (mightBonusPct)))	-- Weapon Damage is the Average Damage + Bonus Damage from Might % times the FURY Mult.

	local finalSwingDamage = (bareHandDamage + weaponSwingDamage)	-- Final Swing Damage is the combination of Barehanded and Weapon Damage.
	
	local mobTarget = getTargetFacing(player, BL_MOB)
	local pcTarget = getTargetFacing(player, BL_PC)
	
	local m = player.m
	local x = player.x
	local y = player.y
	local threat

	local vitaDamageBonus

	local aether
	local magicCost = (player.level * 10)
	if (player.blType == BL_PC) then
		if player.gmLevel > 0 then
			aether = 0  		-- 0 second cooldown
			magicCost = 0
		else
			aether = 7000  		-- 7 second cooldown
		end
	else
		aether = 7000  		-- 7 second cooldown
	end

	local anim = 246
	local sound = 14
---------------------------
--- Spell Damage Formula---
---------------------------
	local mightBase = might ^ 1.95
	local mightMult = might ^ 0.3

	local damCalc = (mightBase * mightMult)
	
	local damage = (finalSwingDamage + damCalc)
	damage = math.floor(damage)
-------------------------------------------------------	
	if (not player:canCast(1, 1, 0)) then
		return
	end
-------------------------------------------------------	
	if player.magic < magicCost or player.magic-magicCost <= 0 then
		player:sendAnimation(246)
		player:sendMinitext("Not Enough MP.")
		return
	end
------------------------------------	
	if mobTarget ~= nil then
		mobTarget.attacker = player.ID
		player:sendAction(1, 20)
		player:talk(2, "~Smash~")
		if player.gmLevel < 1 then
			player:sendMinitext("You use the Power Attack technique!")
		end
		if player.gmLevel > 0 then
			player:sendMinitext("Power Attack DMG: "..damage)
		end
		player:setAether("power_attack_2", aether)
		player:playSound(sound)

		mobTarget:sendAnimation(6, 0)		
		threat = mobTarget:removeHealthExtend(damage, 1, 1, 1, 1, 2)
		player:addThreat(mobTarget.ID, threat)
		player.magic = player.magic - magicCost
		mobTarget:removeHealthExtend(damage, 1, 1, 1, 1, 0)
	
	elseif pcTarget ~= nil then
		if (player:canPK(pcTarget)) then
			pcTarget.attacker = player.ID
			-- Action, Animation, Text, Sound ---
			player:sendAction(1, 20)
			player:talk(2, "~Smash~")
			player:sendMinitext("You use the Power Attack technique!")
			player:setAether("power_attack_2", aether)
			player:sendStatus()
			player:playSound(14)
			pcTarget:sendAnimation(6, 0)
			-- Apply Damage, pay MP Cost ----
			player.magic = player.magic - magicCost
			pcTarget:removeHealthExtend(damage, 1, 1, 1, 1, 0)
		end
	end
end
}]]
--
