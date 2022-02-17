mathRandom = function(start, stop, precision)
	return math.random(start * precision, stop * precision) / precision
end

checkProtection = function(block, target, successRate)
	local blockWill = (block.will + 1)
	local blockLevel = block.level
	local targetWill = 1
	local targetLevel = 1
	local targetProtection = 1
	local minhit = .1
	local maxhit = .95

	if (target ~= nil) then
		targetWill = (target.will + 1)
		targetLevel = target.level
		targetProtection = (target.protection + 1)
	end

	if (block.blType == BL_PC or block.blType == 1) then
		--PLAYER hitchance
		local hitchance = .1 + (blockLevel / 1000) + (blockWill / 100)

		if (target ~= nil) then
			hitchance = hitchance - (targetWill / 100) + (targetProtection / 100) + (targetLevel / 1000)
		end

		if (hitchance < minhit) then
			hitchance = minhit
		elseif (hitchance > maxhit) then
			hitchance = maxhit
		end

		if (math.random(successRate) > math.random(hitchance * 10000)) then
			return true
		else
			return false
		end
	elseif (block.blType == BL_MOB) or (block.blType == 2) then
		--MOBs hitchance
		local hitchance = .1 + (blockLevel / 1000) + (blockWill / 100)

		if (target ~= nil) then
			hitchance = hitchance - (targetWill / 100) + (targetProtection / 100) + (targetLevel / 1000)
		end

		if (hitchance < minhit) then
			hitchance = minhit
		elseif (hitchance > maxhit) then
			hitchance = maxhit
		end

		if (math.random(successRate) > math.random(hitchance * 10000)) then
			return true
		else
			return false
		end
	end
end

magicDamage = function(block, target, func)
	local baseDamage = 1 + (block.will * 4) + (block.grace * 3)
	local finalDamage

	if (printf ~= 1) then
		printf = 0
	end

	if (block.blType == BL_PC) then
		local weaponDamage =
			math.floor(
			mathRandom(block.minDam / 3, block.maxDam / 3, 1000) + mathRandom(block.minDam / 3, block.maxDam / 3, 1000) +
				mathRandom(block.minDam / 3, block.maxDam / 3, 1000)
		)

		baseDamage = baseDamage * block.fury
		weaponDamage = weaponDamage * block.enchant
		finalDamage = (baseDamage + weaponDamage) * block.rage * block.invis
	elseif (block.blType == BL_MOB) then
		local weaponDamage =
			math.floor(
			mathRandom(block.minDam / 3, block.maxDam / 3, 1000) + mathRandom(block.minDam / 3, block.maxDam / 3, 1000) +
				mathRandom(block.minDam / 3, block.maxDam / 3, 1000)
		)

		finalDamage = (baseDamage + weaponDamage) * block.invis
	end

	--ADD FOR WISDOM?

	if (finalDamage < 1) then
		finalDamage = 1
	end

	if (target ~= nil and block.critChance > 0) then
		local deduction = 1 - ((target.armor * acPerArmor) / 100)
		local targetsAround = getTargetsAround(block, BL_MOB)

		block.target = target.ID

		if (block.blType == BL_MOB) then
			targetsAround = getTargetsAround(block, BL_PC)
		end

		if (target.blType == BL_MOB) then
			target:sendAction(25, 20)
		elseif (target.blType == BL_PC) then
			target:deductArmor(block.critChance)
		end

		if (deduction > .15) then
			finalDamage = finalDamage * deduction
		else
			finalDamage = finalDamage * .15
		end

		if (finalDamage < 1) then
			finalDamage = 1
		end

		if (target.target == 0) then
			target.target = block.ID
			target.state = MOB_HIT
		end

		if (block.critChance == 2) then
			finalDamage = finalDamage * 1.75
		end

		finalDamage = finalDamage * target.sleep
		target.sleep = 1

		if (target.confused) then
			target.confused = false
			target.confuseTarget = 0
		end

		if (target.deduction > 0) then
			finalDamage = finalDamage * target.deduction
		else
			finalDamage = 0
		end

		if (target.dmgShield > 0) then
			if (target.dmgShield > finalDamage) then
				target.dmgShield = target.dmgShield - finalDamage
				finalDamage = 0
			else
				finalDamage = finalDamage - target.dmgShield
				target.dmgShield = 0
			end
		else
			finalDamage = finalDamage - target.dmgShield
			target.dmgShield = 0
		end

		if (finalDamage < 1) then
			if (target.dmgShield > 0) then
				finalDamage = 0
			else
				finalDamage = 1
			end
		end

		if ((block.blType ~= BL_MOB or (block.owner > 0 and block.owner < 1073741823)) and target.blType == BL_MOB) then
			if (block.blType == BL_PC and #block.group > 1) then
				target:setGrpDmg(block.ID, finalDamage)
			elseif (block.blType == BL_PC) then
				target:setIndDmg(block.ID, finalDamage)
			elseif (block.blType == BL_MOB and #Player(block.owner).group > 1) then
				target:setGrpDmg(block.owner, finalDamage)
			elseif (block.blType == BL_MOB) then
				target:setIndDmg(block.owner, finalDamage)
			end
		end

		if ((block.flank == true or block.backstab == true) and #targetsAround > 1) then
			local frontBlock = false
			local position = ""

			for i = 1, #targetsAround do
				if (targetsAround[i].ID == target.ID) then
					if (block.y - targetsAround[i].y > 0) then
						if (block.side == 0) then
							frontBlock = true
						end

						position = 0
					elseif (block.x - targetsAround[i].x < 0) then
						if (block.side == 1) then
							frontBlock = true
						end

						position = 1
					elseif (block.y - targetsAround[i].y < 0) then
						if (block.side == 2) then
							frontBlock = true
						end

						position = 2
					elseif (block.x - targetsAround[i].x > 0) then
						if (block.side == 3) then
							frontBlock = true
						end

						position = 3
					else
					end
				end
			end

			if (#targetsAround == 2) then
				if (block.side == 0) then
					if (block.side == position) then
						finalDamage = finalDamage * .6
					elseif (frontBlock == true) then
						finalDamage = finalDamage * .4
					else
						finalDamage = finalDamage * .5
					end
				elseif (block.side == 1) then
					if (block.side == position) then
						finalDamage = finalDamage * .6
					elseif (frontBlock == true) then
						finalDamage = finalDamage * .4
					else
						finalDamage = finalDamage * .5
					end
				elseif (block.side == 2) then
					if (block.side == position) then
						finalDamage = finalDamage * .6
					elseif (frontBlock == true) then
						finalDamage = finalDamage * .4
					else
						finalDamage = finalDamage * .5
					end
				elseif (block.side == 3) then
					if (block.side == position) then
						finalDamage = finalDamage * .6
					elseif (frontBlock == true) then
						finalDamage = finalDamage * .4
					else
						finalDamage = finalDamage * .5
					end
				end
			elseif (#targetsAround == 3) then
				if (block.side == 0) then
					if (block.side == position) then
						finalDamage = finalDamage * .5
					elseif (frontBlock == true) then
						finalDamage = finalDamage * .25
					else
						if (math.abs(block.side - position) == 2) then
							finalDamage = finalDamage * .4
						else
							finalDamage = finalDamage * .3
						end
					end
				elseif (block.side == 1) then
					if (block.side == position) then
						finalDamage = finalDamage * .5
					elseif (frontBlock == true) then
						finalDamage = finalDamage * .25
					else
						if (math.abs(block.side - position) == 2) then
							finalDamage = finalDamage * .4
						else
							finalDamage = finalDamage * .3
						end
					end
				elseif (block.side == 2) then
					if (block.side == position) then
						finalDamage = finalDamage * .5
					elseif (frontBlock == true) then
						finalDamage = finalDamage * .25
					else
						if (math.abs(block.side - position) == 2) then
							finalDamage = finalDamage * .4
						else
							finalDamage = finalDamage * .3
						end
					end
				elseif (block.side == 3) then
					if (block.side == position) then
						finalDamage = finalDamage * .5
					elseif (frontBlock == true) then
						finalDamage = finalDamage * .25
					else
						if (math.abs(block.side - position) == 2) then
							finalDamage = finalDamage * .4
						else
							finalDamage = finalDamage * .3
						end
					end
				end
			elseif (#targetsAround == 4) then
				if (block.side == 0) then
					if (block.side == position) then
						finalDamage = finalDamage * .5
					else
						if (math.abs(block.side - position) == 2) then
							finalDamage = finalDamage * .2
						else
							finalDamage = finalDamage * .15
						end
					end
				elseif (block.side == 1) then
					if (block.side == position) then
						finalDamage = finalDamage * .5
					else
						if (math.abs(block.side - position) == 2) then
							finalDamage = finalDamage * .2
						else
							finalDamage = finalDamage * .15
						end
					end
				elseif (block.side == 2) then
					if (block.side == position) then
						finalDamage = finalDamage * .5
					else
						if (math.abs(block.side - position) == 2) then
							finalDamage = finalDamage * .2
						else
							finalDamage = finalDamage * .15
						end
					end
				elseif (block.side == 3) then
					if (block.side == position) then
						finalDamage = finalDamage * .5
					else
						if (math.abs(block.side - position) == 2) then
							finalDamage = finalDamage * .2
						else
							finalDamage = finalDamage * .15
						end
					end
				end
			end
		end

		if
			(target.blType == BL_MOB or (block.blType == BL_MOB and (block.owner == 0 or block.owner >= 1073741823)) or
				(block.blType == BL_PC and block:canPK(target) == true) or
				(block.blType == BL_MOB and block.owner > 0 and block.owner < 1073741823 and
					Player(block.owner):canPK(target) == true))
		 then
			target.attacker = block.ID

			if (func ~= nil) then
				return func(block, target, finalDamage)
			else
				return finalDamage
			end
		end
	else
		if (func ~= nil) then
			return func(block, target, finalDamage)
		else
			return finalDamage
		end
	end
end
