make_invisible = {
	on_learn = function(player)
		player.registry["learned_make_invisible"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_make_invisible"] = 0
	end,
	cast = function(player, target)
		if not distanceSquare(player, target, 6) then
			player:sendMinitext("Target is too far away!")
			return
		end

		local aether = 300000
		local duration = 30000
		local magicCost = 1500

		local mob = player:getObjectsInMap(player.m, BL_MOB)
		local pc = player:getObjectsInMap(player.m, BL_PC)

		if not player:canCast(1, 1, 0) then
			return
		else
			if player.magic < magicCost then
				notEnoughMP(player)
				return
			else
				if target.blType == BL_PC then
					if #mob > 0 then
						for i = 1, #mob do
							--	mob[i].attacker = target.ID
							--	mob[i]:removeHealthWithoutDamageNumbers(1)
							target:setThreat(mob[i].ID, 0)
							if mob[i].target == target.ID then
								if #pc > 0 then
									if math.random(#pc) ~= target.ID then
										mob[i].target = pc[math.random(#pc)].Id
									else
										mob[i].target = 0
									end
								end
							end
						end
					end
					if target.state == 2 or target:hasDuration("make_invisible") then
						player:sendMinitext("Target is already Invisible!")
					elseif target.state == 0 then
						target:sendAnimationXY(21, target.x, target.y)
						player:sendAction(6, 20)
						player:playSound(28)
						target.state = 2
						player:updateState()
						target:updateState()
						player:refresh()
						target:refresh()
						player:setAether("make_invisible", aether)
						target:setDuration("make_invisible", duration)
						player:sendMinitext("You cast Invis on target")
						target:sendMinitext(player.name .. " cast Invisible on you")
					else
						player:sendMinitext("You cannot cast that now")
					end
				end
			end
		end
	end,
	on_swing_while_cast = function(player)
		player:setDuration("make_invisible", 0)
		player.state = 0
		player:updateState()
	end,
	while_cast = function(player)
		if player.state ~= 2 then
			player:setDuration("make_invisible", 0)
		end
	end,
	uncast = function(player)
		player:calcStat()
		if player.state == 2 then
			player.state = 0
			player:updateState()
		end
		if #mob > 0 then
			for i = 1, #mob do
				mob[i].attacker = player.ID
				mob[i]:removeHealthWithoutDamageNumbers(1)
				player:setThreat(mob[i].ID, 10000)
			end
		end
	end,
	requirements = function(player)
		local level = 85
		local item = {0, 394, 406}
		local amounts = {4500, 1, 10}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Make Invisible will make your target hidden from sight!", txt}
		return level, item, amounts, desc
	end
}
