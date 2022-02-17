enhance_competence = {
	on_learn = function(player)
		player.registry["enhance_competence"] = 1
	end,
	on_forget = function(player)
		player.registry["enhance_competence"] = 0
	end,
	cast = function(player, target)
		local magicCost = player.maxMagic * .05
		local duration = 600000
		local enhanceCompetanceMightBonus = 0
		local enhanceCompetanceWillBonus = 0
		local enhanceCompetanceGraceBonus = 0
		local anim1 = 630
		--local anim2 = 57
		--local anim3 = 11

		local sound = 78

		if player.level <= 60 then
			enhanceCompetanceMightBonus = 1
			enhanceCompetanceWillBonus = 1
			enhanceCompetanceGraceBonus = 1
		elseif player.level >= 61 and player.level < 100 then
			enhanceCompetanceMightBonus = 2
			enhanceCompetanceWillBonus = 2
			enhanceCompetanceGraceBonus = 2
		elseif player.level >= 100 and player.level < 125 then
			enhanceCompetanceMightBonus = 3
			enhanceCompetanceWillBonus = 3
			enhanceCompetanceGraceBonus = 3
		elseif player.level >= 125 and player.level < 150 then
			enhanceCompetanceMightBonus = 5
			enhanceCompetanceWillBonus = 5
			enhanceCompetanceGraceBonus = 5
		elseif player.level >= 150 and player.level < 175 then
			enhanceCompetanceMightBonus = 7
			enhanceCompetanceWillBonus = 7
			enhanceCompetanceGraceBonus = 7
		elseif player.level >= 175 and player.level < 200 then
			enhanceCompetanceMightBonus = 8
			enhanceCompetanceWillBonus = 8
			enhanceCompetanceGraceBonus = 8
		elseif player.level >= 200 and player.level < 225 then
			enhanceCompetanceMightBonus = 9
			enhanceCompetanceWillBonus = 9
			enhanceCompetanceGraceBonus = 9
		elseif player.level >= 225 and player.level <= 250 then
			enhanceCompetanceMightBonus = 10
			enhanceCompetanceWillBonus = 10
			enhanceCompetanceGraceBonus = 10
		elseif player.level == 251 then
			enhanceCompetanceMightBonus = 11
			enhanceCompetanceWillBonus = 11
			enhanceCompetanceGraceBonus = 11
		elseif player.level == 252 then
			enhanceCompetanceMightBonus = 12
			enhanceCompetanceWillBonus = 12
			enhanceCompetanceGraceBonus = 12
		elseif player.level >= 253 then
			enhanceCompetanceMightBonus = 13
			enhanceCompetanceWillBonus = 13
			enhanceCompetanceGraceBonus = 13
		elseif player.level == 254 then
			enhanceCompetanceMightBonus = 14
			enhanceCompetanceWillBonus = 14
			enhanceCompetanceGraceBonus = 14
		elseif player.level == 255 then
			enhanceCompetanceMightBonus = 15
			enhanceCompetanceWillBonus = 15
			enhanceCompetanceGraceBonus = 15
		end

		if not player:canCast(1, 1, 0) then
			return
		end
		if player.magic < magicCost then
			notEnoughMP(player)
			return
		end
		if target:hasDuration("arcane_enhancement") then
			target:setDuration("arcane_enhancement", 0)
			return
		end
		if target:hasDuration("enhance_competence") then
			alreadyCast(player)
			return
		end
		if target:hasDuration("natural_enhancement") then
			alreadyCast(player)
			return
		end
		if target:hasDuration("necrotic_enhancement") then
			alreadyCast(player)
			return
		end
		if target.blType == BL_MOB or target.state == 1 then
			invalidTarget(player)
			return
		end

		if target.blType == BL_PC then
			target.registry["enhance_competence_might_bonus"] = enhanceCompetanceMightBonus
			target.registry["enhance_competence_will_bonus"] = enhanceCompetanceWillBonus
			target.registry["enhance_competence_grace_bonus"] = enhanceCompetanceGraceBonus

			player:sendAction(6, 20)
			player.magic = player.magic - magicCost
			player:sendStatus()
			target:sendAnimation(anim1)
			--target:sendAnimation(anim2)
			--target:sendAnimation(anim3)
			player:playSound(sound)
			target:setDuration("enhance_competence", duration)
			target:calcStat()
			player:sendMinitext("You cast Enhance Competance")
			if target.ID ~= player.ID then
				target:sendMinitext(player.name .. " cast Enhance Competance on you")
			end
		end
	end,
	recast = function(player)
		local enhanceCompetanceMightBonus = player.registry["enhance_competence_might_bonus"]
		local enhanceCompetanceWillBonus = player.registry["enhance_competence_will_bonus"]
		local enhanceCompetanceGraceBonus = player.registry["enhance_competence_grace_bonus"]

		player.might = player.might + enhanceCompetanceMightBonus
		player.will = player.will + enhanceCompetanceWillBonus
		player.grace = player.grace + enhanceCompetanceGraceBonus
	end,
	uncast = function(player)
		local enhanceCompetanceMightBonus = player.registry["enhance_competence_might_bonus"]
		local enhanceCompetanceWillBonus = player.registry["enhance_competence_will_bonus"]
		local enhanceCompetanceGraceBonus = player.registry["enhance_competence_grace_bonus"]

		player.might = player.might - enhanceCompetanceMightBonus
		player.will = player.will - enhanceCompetanceWillBonus
		player.grace = player.grace - enhanceCompetanceGraceBonus
		player:calcStat()
		player.registry["enhance_competence_might_bonus"] = 0
		player.registry["enhance_competence_will_bonus"] = 0
		player.registry["enhance_competence_grace_bonus"] = 0
		player:sendMinitext("Your Enhance Competance fades away")
	end,
	requirements = function(player)
		local level = 125
		local item = {0}
		local amounts = {100000}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Enhance Competance magically enhances your abilities!", txt}
		return level, item, amounts, desc
	end
}
