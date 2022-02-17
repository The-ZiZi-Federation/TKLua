harden_spirit = {
	on_learn = function(player)
		player.registry["harden_spirit"] = 1
		player:removeSpell("harden_armor")
	end,
	on_forget = function(player)
		player.registry["harden_spirit"] = 0
	end,
	cast = function(player, target)
		local magicCost = (player.maxMagic * 0.15)
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
		--	if target:hasDuration("harden_spirit") then alreadyCast(player) return end
		if target.blType == BL_MOB or target.state == 1 then
			invalidTarget(player)
			return
		end

		if target.blType == BL_PC then
			if target:hasDuration("harden_spirit") then
				target:setDuration("harden_spirit", 0)
				return
			end

			player:sendAction(6, 20)
			player.magic = player.magic - magicCost
			player:sendStatus()
			target:sendAnimation(anim)
			player:playSound(sound)
			target:setDuration("harden_spirit", duration)
			target:calcStat()
			player:sendMinitext("You cast Harden Spirit")
			target:sendMinitext(player.name .. " cast Harden Spirit on you")
		end
	end,
	recast = function(player)
		local armorBonus = (player.level * 25) + (player.will * 10)

		player.armor = player.armor + armorBonus
	end,
	uncast = function(player)
		player:calcStat()
		player:sendMinitext("Your armor bonus fades")
	end,
	requirements = function(player)
		local level = 60
		local item = {0, 400, 3042}
		local amounts = {2500, 10, 10}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"A spell that increases the target's physical prowess for a time.\nReplaces Harden Armor.", txt}
		return level, item, amounts, desc
	end
}
