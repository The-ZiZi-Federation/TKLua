-------------------------------------------------------
--   Spell: Candycane Cleave
--   Class: Event
--   Level: Item
--  Aether: 15 Second
--    Cost: 1x Green Candycane
-- DmgType: Physical
--    Type: Offensive
-- Targets: 8
--			X X X
--			x P X
--			X X X
-- Effects: N/A
-------------------------------------------------------
--    Desc: You heft your blade and spin a full 360
-- 			cleavng anyone in the way for heavy damage.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 12/12/2016
-------------------------------------------------------
candycane_cleave = {
	on_learn = function(player)
		player.registry["learned_candycane_cleave"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_candycane_cleave"] = 0
	end,
	cast = function(player)
		----------------------
		--Varable Declarations
		----------------------

		local magicCost = player.level * 40
		local aether = 26000

		local weap = player:getEquippedItem(0)
		local weaponName
		local maxWeaponDam
		local minWeaponDam
		local weaponBalance

		if weap == nil then
			maxWeaponDam = 0
			minWeaponDam = 0
			weaponBalance = 0
			weaponCritical = 0 -- Set default values for unequipped player.
		else
			maxWeaponDam = weap.maxDmg
			minWeaponDam = weap.minDmg
			weaponBalance = (weap.dam * .01)
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

		local mobBlocks = player:getObjectsInArea(BL_MOB)
		local pcBlocks = player:getObjectsInArea(BL_PC)
		local targets = {}

		local threat
		--------------------------------
		mightBonusPct = ((might / (might + 50)) ^ 1.1)
		mightBalanceBonus = (might / (might + 3995))
		graceBalanceBonus = (grace / (grace + 3995))

		totalBalancePct = (weaponBalance + (mightBalanceBonus + graceBalanceBonus))
		weaponDamageRange = (maxWeaponDam - minWeaponDam)
		balanceOffset = (totalBalancePct * weaponDamageRange)

		avgWeaponDamage = (minWeaponDam + balanceOffset)
		bareHandDamage = (might + (might * (mightBonusPct))) -- Barehanded Damage is based off of Might and the Might Bonus Damage

		weaponSwingDamage = (avgWeaponDamage + (avgWeaponDamage * (mightBonusPct))) -- Weapon Damage is the Average Damage + Bonus Damage from Might % times the FURY Mult.
		finalSwingDamage = (bareHandDamage + weaponSwingDamage) -- Final Swing Damage is the combination of Barehanded and Weapon Damage.
		---------------------------
		--- Spell Damage Formula---
		---------------------------
		local mightBase = might ^ 1.95
		local mightMult = might ^ 0.32
		local damCalc = (mightBase * mightMult)

		local ninetyPctHealth = player.maxHealth * .90
		local fiftyPctHealth = player.maxHealth * .50
		local tenPctHealth = player.maxHealth * .10

		local damage = ((finalSwingDamage + damCalc) * buff) + (ninetyPctHealth * 2)
		local damage2 = (((finalSwingDamage + damCalc) * buff) + (ninetyPctHealth * 3)) * 2

		if (not player:canCast(1, 1, 0)) then
			return
		end

		if (player.health < fiftyPctHealth) then
			player:sendMinitext("Not enough vita!")
			return
		end

		player:sendAction(1, 20)
		player:playSound(84)
		player:sendMinitext("You cast Candycane Cleave")
		player.health = tenPctHealth
		player:sendStatus()

		pcflankTargets = {
			player:getObjectsInCell(player.m, player.x + 1, player.y, BL_PC)[1],
			player:getObjectsInCell(player.m, player.x - 1, player.y, BL_PC)[1],
			player:getObjectsInCell(player.m, player.x, player.y - 1, BL_PC)[1],
			player:getObjectsInCell(player.m, player.x, player.y + 1, BL_PC)[1],
			player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_PC)[1],
			player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_PC)[1],
			player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_PC)[1],
			player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_PC)[1],
			player:getObjectsInCell(player.m, player.x, player.y - 2, BL_PC)[1],
			player:getObjectsInCell(player.m, player.x, player.y + 2, BL_PC)[1],
			player:getObjectsInCell(player.m, player.x - 2, player.y, BL_PC)[1],
			player:getObjectsInCell(player.m, player.x + 2, player.y, BL_PC)[1]
		}

		mobflankTargets = {
			player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)[1],
			player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)[1],
			player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)[1],
			player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)[1],
			player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_MOB)[1],
			player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_MOB)[1],
			player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_MOB)[1],
			player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_MOB)[1],
			player:getObjectsInCell(player.m, player.x, player.y - 2, BL_MOB)[1],
			player:getObjectsInCell(player.m, player.x, player.y + 2, BL_MOB)[1],
			player:getObjectsInCell(player.m, player.x - 2, player.y, BL_MOB)[1],
			player:getObjectsInCell(player.m, player.x + 2, player.y, BL_MOB)[1]
		}

		for i = 1, 12 do
			if (mobflankTargets[i] ~= nil) then
				mobflankTargets[i].attacker = player.ID
				threat = mobflankTargets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 2)
				player:addThreat(mobflankTargets[i].ID, threat)
				if player.baseClass == 2 and mobflankTargets[i]:hasDuration("stun") then
					mobflankTargets[i]:removeHealthExtend(damage2, 1, 1, 1, 1, 0)
				else
					mobflankTargets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
				end
				mobflankTargets[i]:sendAnimation(6)
			end
		end
	end
}
