--printf:
--0: regular, used for all swings, includes side mult
--1: returns regular damage, used for spells and abilities where facing matters
--2: returns damage without side mult, used for spells and abilities where facing shouldn't matter

swingDamage = function(block, target, printf)
	--	Player(4):talk(0,"might: "..block.might)
	--	Player(4):talk(0,"grace: "..block.grace)
	local dam

	if block.blType == BL_PC then
		dam = block.dam
	else
		dam = 0
	end

	local baseDamage = 1 + (dam * 5) + (block.might * 4) + (block.grace * 3)
	--	Player(4):talk(0,"basedamage = 1 + "..dam.." + "..(block.might * 4).." + "..(block.grace * 3))
	local finalDamage

	--	Player(4):talk(0,"baseDamage: "..baseDamage)

	--	if (printf > 2) then
	--		printf = 0
	---	end

	if (block.blType == BL_PC) then
		--	Player(4):talk(0,"finalDamage = ("..baseDamage.." + "..weaponDamage..") * "..block.rage * block.invis)
		--	Player(4):talk(0,"finalDamage: "..finalDamage)
		local weaponDamage =
			math.floor(
			mathRandom(block.minDam / 2, block.maxDam / 2, 1000) + mathRandom(block.minDam / 2, block.maxDam / 2, 1000)
		)
		--	Player(4):talk(0,"weaponDamage: "..weaponDamage)
		--	Player(4):talk(0,"fury: "..block.fury)
		--	Player(4):talk(0,"enchant: "..block.enchant)
		--	Player(4):talk(0,"rage: "..block.rage)
		--	Player(4):talk(0,"invis: "..block.invis)

		baseDamage = baseDamage * block.fury
		--	Player(4):talk(0,"baseDamage2: "..baseDamage)
		weaponDamage = weaponDamage * block.enchant
		--	Player(4):talk(0,"weaponDamage2: "..weaponDamage)
		finalDamage = (baseDamage + weaponDamage) * block.rage * block.invis
	elseif (block.blType == BL_MOB) then
		local weaponDamage =
			math.floor(
			mathRandom(block.minDam / 3, block.maxDam / 3, 1000) + mathRandom(block.minDam / 3, block.maxDam / 3, 1000) +
				mathRandom(block.minDam / 3, block.maxDam / 3, 1000)
		)
		baseDamage = 1
		finalDamage = (baseDamage + weaponDamage) * block.invis
	end

	if (finalDamage < 1) then
		finalDamage = 1
	end

	if (target ~= nil and block.critChance > 0) then
		--if block.m == 1 then Player(4):talk(0,"swingdamage 4") end
		local deduction = 1 - ((target.armor * acPerArmor) / 100)
		local targetsAround = getTargetsAround(block, BL_MOB)
		--if block.m == 1 then Player(4):talk(0,"deduction: "..deduction)	end
		block.target = target.ID
		if (block.blType == BL_MOB) then
			targetsAround = getTargetsAround(block, BL_PC)
		end

		if (target.blType == BL_MOB) then
			target:sendAction(25, 20)
		end

		--		if block.m == 1 then block:talk(0,"before deduction, damage = "..finalDamage) end
		--		if block.m == 1 then block:talk(0,"deduction = "..deduction) end
		if (deduction > .15) then
			--		Player(4):talk(0,"deduction > .15, finalDamage = "..finalDamage)
			finalDamage = finalDamage * deduction
		else
			--		Player(4):talk(0,"else, finalDamage = "..finalDamage)
			finalDamage = finalDamage * .15
		end
		--		if block.m == 1 then block:talk(0,"after deduction, damage = "..finalDamage) end

		if (finalDamage < 1) then
			finalDamage = 1
		end

		if (target.target == 0 and target.blType == BL_MOB) then
			target.target = block.ID
			target.state = MOB_HIT
		end

		if (block.critChance == 2) then
			finalDamage = finalDamage * 1.75
		--		Player(4):talk(0,"Crit, finalDamage :"..finalDamage)
		end

		if printf ~= 2 then
			finalDamage = finalDamage * target.sleep
			--			Player(4):talk(0,"sleep: "..target.sleep..", finalDamage = "..finalDamage)
			target.sleep = 1
		end

		if (target.confused) then
			target.confused = false
			target.confuseTarget = 0
		end

		if (target.deduction > 0) then
			--		Player(4):talk(0,"deduction > 0, finalDamage = "..finalDamage)
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

		if target:hasDuration("called_shot") then
			finalDamage = finalDamage * 2
		--target:setDuration("called_shot", 0)
		end

		if (printf == 2) then
			return finalDamage
		end
		finalDamage = finalDamage * sideDamageMultiplier.check(block, target) --Added 4/1/17 Comment out to disable players taking side/back multiplier damage

		if (printf == 1) then
			return finalDamage
		end
		if
			(target.blType == BL_MOB or (block.blType == BL_MOB and (block.owner == 0 or block.owner >= 1073741823)) or
				(block.blType == BL_PC and block:canPK(target) == true) or
				(block.blType == BL_MOB and block.owner > 0 and block.owner < 1073741823 and
					Player(block.owner):canPK(target) == true))
		 then
			target.attacker = block.ID
			block.damage = finalDamage
		end
	elseif (printf == 1) then
		return finalDamage
	end
end
