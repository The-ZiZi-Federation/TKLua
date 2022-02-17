necrotic_enhancement = {
	on_learn = function(player)
		player.registry["necrotic_enhancement"] = 1
	end,
	on_forget = function(player)
		player.registry["necrotic_enhancement"] = 0
	end,
	cast = function(player, target)
		local magicCost = player.maxMagic * .05
		local duration = 600000
		local necroticEnhancementMightBonus = 0
		local necroticEnhancementWillBonus = 0
		local necroticEnhancementGraceBonus = 0
		local anim1 = 551
		--local anim2 = 57
		--local anim3 = 11

		local sound = 500

		if player.level <= 60 then
			necroticEnhancementMightBonus = 1
			necroticEnhancementWillBonus = 1
			necroticEnhancementGraceBonus = 1
		elseif player.level >= 61 and player.level < 100 then
			necroticEnhancementMightBonus = 2
			necroticEnhancementWillBonus = 2
			necroticEnhancementGraceBonus = 2
		elseif player.level >= 100 and player.level < 125 then
			necroticEnhancementMightBonus = 3
			necroticEnhancementWillBonus = 3
			necroticEnhancementGraceBonus = 3
		elseif player.level >= 125 and player.level < 150 then
			necroticEnhancementMightBonus = 5
			necroticEnhancementWillBonus = 5
			necroticEnhancementGraceBonus = 5
		elseif player.level >= 150 and player.level < 175 then
			necroticEnhancementMightBonus = 7
			necroticEnhancementWillBonus = 7
			necroticEnhancementGraceBonus = 7
		elseif player.level >= 175 and player.level < 200 then
			necroticEnhancementMightBonus = 8
			necroticEnhancementWillBonus = 8
			necroticEnhancementGraceBonus = 8
		elseif player.level >= 200 and player.level < 225 then
			necroticEnhancementMightBonus = 9
			necroticEnhancementWillBonus = 9
			necroticEnhancementGraceBonus = 9
		elseif player.level >= 225 and player.level <= 250 then
			necroticEnhancementMightBonus = 10
			necroticEnhancementWillBonus = 10
			necroticEnhancementGraceBonus = 10
		elseif player.level == 251 then
			necroticEnhancementMightBonus = 11
			necroticEnhancementWillBonus = 11
			necroticEnhancementGraceBonus = 11
		elseif player.level == 252 then
			necroticEnhancementMightBonus = 12
			necroticEnhancementWillBonus = 12
			necroticEnhancementGraceBonus = 12
		elseif player.level >= 253 then
			necroticEnhancementMightBonus = 13
			necroticEnhancementWillBonus = 13
			necroticEnhancementGraceBonus = 13
		elseif player.level == 254 then
			necroticEnhancementMightBonus = 14
			necroticEnhancementWillBonus = 14
			necroticEnhancementGraceBonus = 14
		elseif player.level == 255 then
			necroticEnhancementMightBonus = 15
			necroticEnhancementWillBonus = 15
			necroticEnhancementGraceBonus = 15
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
		if target:hasDuration("enhance_competance") then
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
			target.registry["necrotic_enhancement_might_bonus"] = necroticEnhancementMightBonus
			target.registry["necrotic_enhancement_will_bonus"] = necroticEnhancementWillBonus
			target.registry["necrotic_enhancement_grace_bonus"] = necroticEnhancementGraceBonus

			player:sendAction(6, 20)
			player.magic = player.magic - magicCost
			player:sendStatus()
			target:sendAnimation(anim1)
			--target:sendAnimation(anim2)
			--target:sendAnimation(anim3)
			player:playSound(sound)
			target:setDuration("necrotic_enhancement", duration)
			target:calcStat()
			player:sendMinitext("You cast Necrotic Enhancement")
			if target.ID ~= player.ID then
				target:sendMinitext(player.name .. " cast Necrotic Enhancement on you")
			end
		end
	end,
	recast = function(player)
		local necroticEnhancementMightBonus = player.registry["necrotic_enhancement_might_bonus"]
		local necroticEnhancementWillBonus = player.registry["necrotic_enhancement_will_bonus"]
		local necroticEnhancementGraceBonus = player.registry["necrotic_enhancement_grace_bonus"]

		player.might = player.might + necroticEnhancementMightBonus
		player.will = player.will + necroticEnhancementWillBonus
		player.grace = player.grace + necroticEnhancementGraceBonus
	end,
	uncast = function(player)
		local necroticEnhancementMightBonus = player.registry["necrotic_enhancement_might_bonus"]
		local necroticEnhancementWillBonus = player.registry["necrotic_enhancement_will_bonus"]
		local necroticEnhancementGraceBonus = player.registry["necrotic_enhancement_grace_bonus"]

		player.might = player.might - necroticEnhancementMightBonus
		player.will = player.will - necroticEnhancementWillBonus
		player.grace = player.grace - necroticEnhancementGraceBonus
		player:calcStat()
		player.registry["necrotic_enhancement_might_bonus"] = 0
		player.registry["necrotic_enhancement_will_bonus"] = 0
		player.registry["necrotic_enhancement_grace_bonus"] = 0
		player:sendMinitext("Your Necrotic Enhancement fades away")
	end,
	requirements = function(player)
		local level = 125
		local item = {0}
		local amounts = {100000}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Necrotic Enhancement magically enhances your abilities!", txt}
		return level, item, amounts, desc
	end
}
