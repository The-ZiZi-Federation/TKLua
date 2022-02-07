--[[
-------------------------------------------------------
--   Spell: Globe of Darkness                          
--   Class: Blackguard
--   Level: 150
--  Aether: 12 Second
-- Targets: 1
-------------------------------------------------------
--   Desc.: Surrounds the foe in damaging magical darkness.  Depends more on
-- 			Will for damage.  Considered a Magic Attack for defense calculations
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 3/25/2017
-------------------------------------------------------

globe_of_darkness = {

on_learn = function(player) player.registry["learned_globe_of_darkness"] = 1 end,
on_forget = function(player) player.registry["learned_globe_of_darkness"] = 0 end,

cast = function(player, target)

	------------------------
	--Varable Declarations--
	------------------------
	local might = player.might
	local will = player.will
	local buff = player.fury
	local magicCost	= (player.level * 30)		-- calculate MP cost of spell
	local damage
	if (player.blType == BL_PC) then
		if player.gmLevel > 0 then
			aether = 0  		-- 0 second cooldown
		else
			aether = 12000  		-- 1 second cooldown
		end
	else
		aether = 12000  		-- 1 second cooldown
	end
	
	local blindDuration = 5000
	
	local mobTarget = getTargetFacing(player, BL_MOB)
	local pcTarget = getTargetFacing(player, BL_PC)

	local m = player.m
	local x = player.x
	local y = player.y

	local threat
	
	local anim = 422
	local anim2 = 424
	local sound = 71
	---------------------------
	--- Spell Damage Formula---
	---------------------------
	local mightBase = might ^ 1.0
	local mightMult = might ^ 0.12
	local willBase = will ^ 2.1
	local willMult = will ^ 0.19
----- Damage Calculation---------------------------------------
	local damCalc = (mightBase * mightMult) + (willBase * willMult)
	damage = (damCalc) * (buff / 2)					-- take damage calc and apply Fury.										

---------------------------------------------------------
	if not player:canCast(1,1,0) then 
		return 
	else
--------------------------------------------
	if player.magic < magicCost then 
		notEnoughMP(player) 
		return 
	end
------ Target is a player ----------------
		if target.blType == BL_PC then
			if not player:canPK(target) or target.state == 1 then 
				return 
			else 
				target:sendMinitext(player.name.." encases you in a Globe of Darkness") 
			end
		end
	end
---------------------------------------------	
	if (target.blType == BL_MOB) then
		target.attacker = player.ID
		player.magic = player.magic - magicCost
		
		player:sendAction(6, 20)
		player:playSound(sound)

			if (player.blType == BL_PC) then
				if player.gmLevel < 1 then
					player:sendMinitext("You cast Globe of Darkness")
				end
				if player.gmLevel > 0 then
					player:sendMinitext("Globe of Darkness DMG: "..damage)
				end
			end
		player:setAether("globe_of_darkness", aether)
		player:sendStatus()
		
		target:removeHealthExtend(damage, 1, 1, 1, 1, 1, damageType)
		
		target.registry["blind"] = player.ID
		target:setDuration("blind", blindDuration)
		target:sendAnimation(anim)
		target:sendAnimation(anim2)
	------------------mob vs player-------------------------------------------------------
	elseif (target.blType == BL_PC and player.blType == BL_MOB) then
		player.magic = player.magic - magicCost
		target:playSound(sound)
		target:sendAnimation(anim)
		target:sendAnimation(anim2)
		target.attacker = player.ID
		target.registry["blind"] = player.ID
		target:setDuration("blind", blindDuration)
		target:removeHealthExtend(damage, 1, 1, 1, 1, 0)
		target:sendMinitext(player.name.." encases you in a Globe of Darkness")
----------------player vs player-----------------------------------------------------------	
	elseif (target.blType == BL_PC and player:canPK(target)) then
		player:sendAction(6, 20)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:setAether("globe_of_darkness", aether)
		player:playSound(sound)
		target:sendAnimation(anim)
		target:sendAnimation(anim2)
		player:sendMinitext("You cast Globe of Darkness")
		target.attacker = player.ID
		target.registry["blind"] = player.ID
		target:setDuration("blind", blindDuration)
		target:removeHealthExtend(damage, 1, 1, 1, 1, 1, damageType)
		target:sendMinitext(player.name.." encases you in a Globe of Darkness")
	else
		target:sendMinitext("Something weird happened here")
	end
end
}]]
--
