arcane_enhancement = {
	on_learn = function(player)
		player.registry["arcane_enhancement"] = 1
	end,
	on_forget = function(player)
		player.registry["arcane_enhancement"] = 0
	end,
	cast = function(player, target)
		local magicCost = player.maxMagic * .05
		local duration = 600000
		local arcaneEnhancementMightBonus = 0
		local arcaneEnhancementWillBonus = 0
		local arcaneEnhancementGraceBonus = 0
		local anim1 = 56
		local anim2 = 57
		local anim3 = 11

		local sound = 729

		if player.level <= 60 then
			arcaneEnhancementMightBonus = 1
			arcaneEnhancementWillBonus = 1
			arcaneEnhancementGraceBonus = 1
		elseif player.level >= 61 and player.level < 100 then
			arcaneEnhancementMightBonus = 2
			arcaneEnhancementWillBonus = 2
			arcaneEnhancementGraceBonus = 2
		elseif player.level >= 100 and player.level < 125 then
			arcaneEnhancementMightBonus = 3
			arcaneEnhancementWillBonus = 3
			arcaneEnhancementGraceBonus = 3
		elseif player.level >= 125 and player.level < 150 then
			arcaneEnhancementMightBonus = 4
			arcaneEnhancementWillBonus = 4
			arcaneEnhancementGraceBonus = 4
		elseif player.level >= 150 and player.level < 175 then
			arcaneEnhancementMightBonus = 5
			arcaneEnhancementWillBonus = 5
			arcaneEnhancementGraceBonus = 5
		elseif player.level >= 175 and player.level < 200 then
			arcaneEnhancementMightBonus = 6
			arcaneEnhancementWillBonus = 6
			arcaneEnhancementGraceBonus = 6
		elseif player.level >= 200 and player.level < 225 then
			arcaneEnhancementMightBonus = 7
			arcaneEnhancementWillBonus = 7
			arcaneEnhancementGraceBonus = 7
		elseif player.level >= 225 and player.level < 250 then
			arcaneEnhancementMightBonus = 8
			arcaneEnhancementWillBonus = 8
			arcaneEnhancementGraceBonus = 8
		elseif player.level >= 250 and player.level < 253 then
			arcaneEnhancementMightBonus = 9
			arcaneEnhancementWillBonus = 9
			arcaneEnhancementGraceBonus = 9
		elseif player.level >= 253 then
			arcaneEnhancementMightBonus = 10
			arcaneEnhancementWillBonus = 10
			arcaneEnhancementGraceBonus = 10
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
			target.registry["arcane_enhancement_might_bonus"] = arcaneEnhancementMightBonus
			target.registry["arcane_enhancement_will_bonus"] = arcaneEnhancementWillBonus
			target.registry["arcane_enhancement_grace_bonus"] = arcaneEnhancementGraceBonus

			player:sendAction(6, 20)
			player.magic = player.magic - magicCost
			player:sendStatus()
			target:sendAnimation(anim1)
			target:sendAnimation(anim2)
			target:sendAnimation(anim3)
			player:playSound(sound)
			target:setDuration("arcane_enhancement", duration)
			target:calcStat()
			player:sendMinitext("You cast Arcane Enhancement")
			if target.ID ~= player.ID then
				target:sendMinitext(player.name .. " cast Arcane Enhancement on you")
			end
		end
	end,
	recast = function(player)
		local arcaneEnhancementMightBonus = player.registry["arcane_enhancement_might_bonus"]
		local arcaneEnhancementWillBonus = player.registry["arcane_enhancement_will_bonus"]
		local arcaneEnhancementGraceBonus = player.registry["arcane_enhancement_grace_bonus"]

		player.might = player.might + arcaneEnhancementMightBonus
		player.will = player.will + arcaneEnhancementWillBonus
		player.grace = player.grace + arcaneEnhancementGraceBonus
	end,
	uncast = function(player)
		local arcaneEnhancementMightBonus = player.registry["arcane_enhancement_might_bonus"]
		local arcaneEnhancementWillBonus = player.registry["arcane_enhancement_will_bonus"]
		local arcaneEnhancementGraceBonus = player.registry["arcane_enhancement_grace_bonus"]

		player.might = player.might - arcaneEnhancementMightBonus
		player.will = player.will - arcaneEnhancementWillBonus
		player.grace = player.grace - arcaneEnhancementGraceBonus
		player:calcStat()
		player.registry["arcane_enhancement_might_bonus"] = 0
		player.registry["arcane_enhancement_will_bonus"] = 0
		player.registry["arcane_enhancement_grace_bonus"] = 0
		player:sendMinitext("Your Arcane Enhancement fades away")
	end,
	requirements = function(player)
		local level = 8
		local item = {0, 50, 248}
		local amounts = {50, 10, 5}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Arcane Enhancement magically enhances your abilities!", txt}
		return level, item, amounts, desc
	end
}
