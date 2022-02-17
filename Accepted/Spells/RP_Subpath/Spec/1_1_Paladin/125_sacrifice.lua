sacrifice = {
	cast = function(player, target)
		local magicCost = math.floor(player.maxMagic * 0.1)
		local aether = 120000
		local duration = 15000
		local anim = 93
		local sound = 24

		if not player:canCast(1, 1, 0) then
			return
		end
		if player.magic < magicCost then
			notEnoughMP(player)
			return
		end

		if target.blType == BL_PC then
			if target.ID == player.ID then
				anim(player)
				return
			else
				if target:hasDuration("sacrifice") then
					anim(player)
					player:sendMinitext("Spell is already cast!")
					return
				else
					target.registry["sacrifice"] = player.ID
					player:sendAction(6, 20)
					player.magic = player.magic - magicCost
					player:sendStatus()
					player:sendAnimation(anim)
					target:sendAnimation(anim)
					player:playSound(sound)
					target:setDuration("sacrifice", duration)
					player:setAether("sacrifice", aether)
					player:sendMinitext("You cast Sacrifice")
					target:sendMinitext(player.name .. " cast Sacrifice on you")
				end
			end
		end
	end,
	uncast = function(player)
		player.registry["sacrifice"] = 0
		player:calcStat()
	end,
	being_hit = function(player, attacker)
		pc = Player(player.registry["sacrifice"])
		if pc ~= nil then
			if pc.m == player.m and pc.state ~= 1 then
				player:sendAnimation(300)
				pc.attacker = attacker.ID
				pc:sendHealth(attacker.damage, attacker.critChance)
			end
		end
	end,
	requirements = function(player)
		local level = 125
		local item = {0}
		local amounts = {100000}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Sacrifice is a spell that will allow you to take damage in place of another.", txt}
		return level, item, amounts, desc
	end
}
