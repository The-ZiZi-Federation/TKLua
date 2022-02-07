hitCritChance = function(block, target)
	local blockGrace = block.grace
	local blockLevel = block.level
	local blockMight = block.might
	local blockHit = block.hit
	local blockDam = block.dam
	local blockCrit = block.crit
	local blockMiss = block.miss
	local targetGrace = target.grace
	local targetLevel = target.level

	local minhit = 5
	local maxhit = 95

	local critChanceIncrease = 0

	if (math.random(10000) < blockMiss) then
		block.critChance = 0
		block.damage = 0
		--if (block.blType == BL_PC) then
		--	block:sendMinitext("You have faltered.")
		--end
		return
	end

	if (block.blType == BL_PC) or (block.blType == 1) then
		--PLAYER hitchance
		local hitchance = (55 + ((blockGrace + blockLevel) * .75) + blockHit - ((targetGrace + targetLevel) * .5))

		if (hitchance < minhit) then
			hitchance = minhit
		elseif (hitchance > maxhit) then
			critChanceIncrease = (5 * ((hitchance - 95) / 193)) + 2.5
			hitchance = maxhit
		end

		--math.randomseed(math.random(os.clock()))
		local seed = math.random(100)

		if (seed < hitchance) then
			local mincrit = 1
			local maxcrit = 30
			--PLAYER critchance
			local critchance = 10 + critChanceIncrease
			--((blockGrace*2) - (blockLevel*1.5) - (targetGrace/2) - (blockMight/3) + (blockHit*1.5) - blockDam + blockCrit)
			--local rcrit = math.random(90,100)
			--block.critMult = math.abs(block.critMult + ((math.abs(critchance) - rcrit) / rcrit))
			if (critchance < mincrit) then
				critchance = mincrit
			elseif (critchance > maxcrit) then
				critchance = maxcrit
			end

			if (seed < critchance) then
				block.critChance = 2
			else
				block.critChance = 1
			end

			if (target.blType == BL_PC and not block:canPK(target)) then
				block.critChance = 0
			end
		else
			block.critChance = 0
		end
	elseif (block.blType == BL_MOB) or (block.blType == 2) then
		--MOBs hitchance
		local hitchance = (55 + (blockGrace / 2)) - (targetGrace / 3) + (blockHit * 3) + (blockLevel - targetLevel)

		block:sendAction(1, 14)
		block:playSound(block.sound)

		if (hitchance < minhit) then
			hitchance = minhit
		elseif (hitchance > maxhit) then
			critChanceIncrease = (math.random(5)) + 2.5
			hitchance = maxhit
		end

		local seed = math.random(100)

		if (seed < hitchance) then
			--MOBs critchance
			local critchance = (block.hit / 5) + critChanceIncrease
			--local rcrit = math.random(90,100)
			--block.critMult = math.abs(block.critMult + ((math.abs(critchance) - rcrit) / rcrit))
			if (seed < critchance) then
				block.critChance = 2
				block:playSound(349)
				block:playSound(351)
			else
				block.critChance = 1
			end
		else
			block.critChance = 0
		end
	end
end
