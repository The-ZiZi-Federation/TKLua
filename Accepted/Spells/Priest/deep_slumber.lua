deep_slumber = {
	on_learn = function(player)
		player.registry["learned_deep_slumber"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_deep_slumber"] = 0
	end,
	cast = function(player, target)
		local magicCost = (player.maxMagic / (player.level / 10))
		local duration = 6000
		local aether = 22000
		local mob = target:getObjectsInArea(BL_MOB)
		local pc = target:getObjectsInArea(BL_PC)
		local sound = 83
		if not player:canCast(1, 1, 0) then
			return
		end

		if player.magic < magicCost then
			notEnoughMP(player)
			return
		end

		if target.blType == BL_PC then
			player:sendMinitext("Invalid target!")
		end

		player.magic = player.magic - magicCost
		player:sendStatus()
		player:sendAction(6, 20)
		player:playSound(sound)
		player:sendMinitext("You cast Deep Slumber")
		player:setAether("deep_slumber", aether)

		if #mob > 0 then
			for i = 1, #mob do
				if distanceSquare(target, mob[i], 2) then
					if mob[i].sleep == 1.0 and not mob[i]:hasDuration("asleep") then
						if checkResist(player, mob[i], "sleep") == 1 then
							return
						end
						mob[i].sleep = 2.0
						mob[i]:sendAnimation(141)
						mob[i]:setDuration("asleep", duration)
					end
				end
			end
		elseif #pc > 0 then
			for i = 1, #pc do
				if distanceSquare(target, pc[i], 2) then
					if pc[i].sleep == 1.0 and not pc[i]:hasDuration("asleep") and player:canPK(pc[i]) then
						pc[i].sleep = 2.0
						pc[i]:sendAnimation(141)
						pc[i]:setDuration("asleep", duration)
					else
						player:sendMinitext("Can't cast!")
					end
				end
			end
		end
	end,
	requirements = function(player)
		local level = 87
		local item = {0, 406, 392, 393}
		local amounts = {5000, 15, 10, 15}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Stuns a hostile target, and their friends too.", txt}
		return level, item, amounts, desc
	end
}
