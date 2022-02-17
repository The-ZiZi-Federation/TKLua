harden_armor = {
	on_learn = function(player)
		player.registry["harden_armor"] = 1
		player:removeSpell("harden_spirit")
	end,
	on_forget = function(player)
		player.registry["harden_armor"] = 0
	end,
	cast = function(player, target)
		local magicCost = (player.maxMagic * 0.08)
		local duration = 600000
		local anim = 106
		local sound = 732

		if not player:canCast(1, 1, 0) then
			return
		end
		if player.magic < magicCost then
			notEnoughMP(player)
			return
		end
		--	if target:hasDuration("harden_armor") then alreadyCast(player) return end
		if target.blType == BL_MOB or target.state == 1 then
			invalidTarget(player)
			return
		end

		if target.blType == BL_PC then
			if target:hasDuration("harden_armor") then
				target:setDuration("harden_armor", 0)
				return
			end

			player:sendAction(6, 20)
			player.magic = player.magic - magicCost
			player:sendStatus()
			target:sendAnimation(anim)
			player:playSound(sound)
			target:setDuration("harden_armor", duration)
			target:calcStat()
			player:sendMinitext("You cast Harden Armor")
			target:sendMinitext(player.name .. " cast Harden Armor on you")
		end
	end,
	recast = function(player)
		local armorBonus = (player.level * 15) + (player.maxMagic * 0.30)
		if armorBonus > 3000 then
			armorBonus = 3000
		end
		player.armor = player.armor + armorBonus
	end,
	uncast = function(player)
		player:calcStat()
		player:sendMinitext("Your armor bonus fades")
	end,
	requirements = function(player)
		local level = 18
		local item = {0, 3010, 3011, 53}
		local amounts = {500, 5, 1, 20}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"A spell that increases the target's Armor for a time.", txt}
		return level, item, amounts, desc
	end
}
