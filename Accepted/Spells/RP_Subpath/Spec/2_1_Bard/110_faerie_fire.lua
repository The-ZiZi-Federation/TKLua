faerie_fire = {
	on_learn = function(player)
		player.registry["learned_faerie_fire"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_faerie_fire"] = 0
	end,
	cast = function(player, target)
		if not distanceSquare(player, target, 9) then
			player:sendMinitext("Target is too far away!")
			return
		end

		local aether = 30000
		local duration = 15000
		local magicCost = player.maxMagic * 0.1
		local aether = 1000
		local anim = 589
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
		if target:hasDuration("faerie_fire") then
			player:sendMinitext("Spell already cast")
			player:sendAnimation(246)
			return
		end

		player:sendAction(6, 20)
		player:setAether("faerie_fire", aether)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:sendMinitext("You cast Faerie Fire")
		if checkResist(player, target, "faerie_fire") == 1 then
			return
		end
		player:playSound(sound)
		target:sendAnimation(anim)
		target:setDuration("faerie_fire", duration)
	end,
	while_cast = function(player)
		player:sendAnimation(21)
	end,
	recast = function(player)
		player.armor = player.armor - (player.armor * 0.1)
	end,
	uncast = function(player)
		player:calcStat()
	end,
	requirements = function(player)
		local level = 5
		local item = {0}
		local amounts = {50000}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Faerie Fire will lower a foe's defense and reveal the invisible.", txt}
		return level, item, amounts, desc
	end
}
