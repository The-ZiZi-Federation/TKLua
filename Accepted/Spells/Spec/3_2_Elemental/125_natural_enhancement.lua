natural_enhancement = {
	on_learn = function(player)
		player.registry["natural_enhancement"] = 1
	end,
	on_forget = function(player)
		player.registry["natural_enhancement"] = 0
	end,
	cast = function(player, target)
		local magicCost = player.maxMagic * .05
		local duration = 600000
		local naturalEnhancementMightBonus = 0
		local naturalEnhancementWillBonus = 0
		local naturalEnhancementGraceBonus = 0
		local anim1 = 173
		--local anim2 = 57
		--local anim3 = 11

		local sound = 731

		if player.level <= 60 then
			naturalEnhancementMightBonus = 1
			naturalEnhancementWillBonus = 1
			naturalEnhancementGraceBonus = 1
		elseif player.level >= 61 and player.level < 100 then
			naturalEnhancementMightBonus = 2
			naturalEnhancementWillBonus = 2
			naturalEnhancementGraceBonus = 2
		elseif player.level >= 100 and player.level < 125 then
			naturalEnhancementMightBonus = 3
			naturalEnhancementWillBonus = 3
			naturalEnhancementGraceBonus = 3
		elseif player.level >= 125 and player.level < 150 then
			naturalEnhancementMightBonus = 5
			naturalEnhancementWillBonus = 5
			naturalEnhancementGraceBonus = 5
		elseif player.level >= 150 and player.level < 175 then
			naturalEnhancementMightBonus = 7
			naturalEnhancementWillBonus = 7
			naturalEnhancementGraceBonus = 7
		elseif player.level >= 175 and player.level < 200 then
			naturalEnhancementMightBonus = 8
			naturalEnhancementWillBonus = 8
			naturalEnhancementGraceBonus = 8
		elseif player.level >= 200 and player.level < 225 then
			naturalEnhancementMightBonus = 9
			naturalEnhancementWillBonus = 9
			naturalEnhancementGraceBonus = 9
		elseif player.level >= 225 and player.level <= 250 then
			naturalEnhancementMightBonus = 10
			naturalEnhancementWillBonus = 10
			naturalEnhancementGraceBonus = 10
		elseif player.level == 251 then
			naturalEnhancementMightBonus = 11
			naturalEnhancementWillBonus = 11
			naturalEnhancementGraceBonus = 11
		elseif player.level == 252 then
			naturalEnhancementMightBonus = 12
			naturalEnhancementWillBonus = 12
			naturalEnhancementGraceBonus = 12
		elseif player.level >= 253 then
			naturalEnhancementMightBonus = 13
			naturalEnhancementWillBonus = 13
			naturalEnhancementGraceBonus = 13
		elseif player.level == 254 then
			naturalEnhancementMightBonus = 14
			naturalEnhancementWillBonus = 14
			naturalEnhancementGraceBonus = 14
		elseif player.level == 255 then
			naturalEnhancementMightBonus = 15
			naturalEnhancementWillBonus = 15
			naturalEnhancementGraceBonus = 15
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
			target.registry["natural_enhancement_might_bonus"] = naturalEnhancementMightBonus
			target.registry["natural_enhancement_will_bonus"] = naturalEnhancementWillBonus
			target.registry["natural_enhancement_grace_bonus"] = naturalEnhancementGraceBonus

			player:sendAction(6, 20)
			player.magic = player.magic - magicCost
			player:sendStatus()
			target:sendAnimation(anim1)
			--target:sendAnimation(anim2)
			--target:sendAnimation(anim3)
			player:playSound(sound)
			target:setDuration("natural_enhancement", duration)
			target:calcStat()
			player:sendMinitext("You cast Natural Enhancement")
			if target.ID ~= player.ID then
				target:sendMinitext(player.name .. " cast Natural Enhancement on you")
			end
		end
	end,
	recast = function(player)
		local naturalEnhancementMightBonus = player.registry["natural_enhancement_might_bonus"]
		local naturalEnhancementWillBonus = player.registry["natural_enhancement_will_bonus"]
		local naturalEnhancementGraceBonus = player.registry["natural_enhancement_grace_bonus"]

		player.might = player.might + naturalEnhancementMightBonus
		player.will = player.will + naturalEnhancementWillBonus
		player.grace = player.grace + naturalEnhancementGraceBonus
	end,
	uncast = function(player)
		local naturalEnhancementMightBonus = player.registry["natural_enhancement_might_bonus"]
		local naturalEnhancementWillBonus = player.registry["natural_enhancement_will_bonus"]
		local naturalEnhancementGraceBonus = player.registry["natural_enhancement_grace_bonus"]

		player.might = player.might - naturalEnhancementMightBonus
		player.will = player.will - naturalEnhancementWillBonus
		player.grace = player.grace - naturalEnhancementGraceBonus
		player:calcStat()
		player.registry["natural_enhancement_might_bonus"] = 0
		player.registry["natural_enhancement_will_bonus"] = 0
		player.registry["natural_enhancement_grace_bonus"] = 0
		player:sendMinitext("Your Natural Enhancement fades away")
	end,
	requirements = function(player)
		local level = 125
		local item = {0}
		local amounts = {100000}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Natural Enhancement magically enhances your abilities!", txt}
		return level, item, amounts, desc
	end
}
