electric_barrier = {
	on_learn = function(player)
		player.registry["electric_barrier"] = 1
	end,
	on_forget = function(player)
		player.registry["electric_barrier"] = 0
	end,
	cast = function(player, target)
		if not distanceSquare(player, target, 6) then
			player:sendMinitext("Target is too far away!")
			return
		end

		local magicCost = 1000
		local duration = 30000
		local aether = 120000
		local anim = 123
		local sound = 60

		if not player:canCast(1, 1, 0) then
			return
		end
		if player.magic < magicCost then
			notEnoughMP(player)
			return
		end
		if target:hasDuration("electric_barrier") then
			alreadyCast(player)
			return
		end
		if target.blType == BL_MOB or target.state == 1 then
			invalidTarget(player)
			return
		end

		if target.blType == BL_PC then
			player:sendAction(6, 20)
			player.magic = player.magic - magicCost
			player:setAether("electric_barrier", aether)
			player:sendStatus()
			player:playSound(sound)
			player:sendMinitext("You cast Electric Barrier")
			target:sendAnimation(anim)
			target:setDuration("electric_barrier", duration)
			target:calcStat()
			target:sendMinitext(player.name .. " cast Electric Barrier on you")
		end
	end,
	on_takedamage_while_cast = function(player, attacker)
		local r = math.random(1, 1000)

		if attacker.blType == BL_MOB then
			if r <= 250 then
				if not attacker:hasDuration("shock") then
					if checkResist(player, attacker, "shock") == 1 then
						return
					end
					attacker:setDuration("shock", 7000)
					attacker:sendAnimation(52)
				end
			end
		end
	end,
	uncast = function(player)
		player:sendMinitext("Your Electric Barrier fades away")
	end,
	requirements = function(player)
		local level = 72
		local item = {0, 6050, 51}
		local amounts = {3500, 1, 1}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"This spell may shock your attackers.", txt}
		return level, item, amounts, desc
	end
}
