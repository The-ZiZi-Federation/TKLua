lullaby = {
	on_learn = function(player)
		player.registry["learned_lullaby"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_lullaby"] = 0
	end,
	cast = function(player, target)
		if not distanceSquare(player, target, 6) then
			player:sendMinitext("Target is too far away!")
			return
		end

		local duration = 18000
		local magicCost = 500
		local hitchance
		local aether = 36000
		local anim = 2
		local sound = 71

		if (not player:canCast(1, 1, 0)) then
			return
		end
		if (player.magic < magicCost) then
			notEnoughMP(player)
			return
		end
		if (target.state == 1 or target.blType ~= BL_MOB) then
			player:sendMinitext("Invalid Target")
			return
		end
		if (target.paralyzed == true) or target:hasDuration("sleep") then
			player:sendMinitext("Spell already cast")
			player:sendAnimation(246)
			return
		end

		player:sendAction(6, 20)
		player:setAether("lullaby", aether)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:sendMinitext("You cast Lullaby")

		if checkResist(player, target, "asleep") == 1 then
			return
		end

		player:playSound(sound)
		target:sendAnimation(anim)
		target:setDuration("asleep", duration)
		target.sleep = 2.0
	end,
	requirements = function(player)
		local level = 56
		local item = {0, 400, 3042}
		local amounts = {1100, 10, 10}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Lullaby put an enemy to sleep, if if they are resistant to Stuns!", txt}
		return level, item, amounts, desc
	end
}
