ray_of_enfeeblement = {
	on_learn = function(player)
		player.registry["learned_ray_of_enfeeblement"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_ray_of_enfeeblement"] = 0
	end,
	cast = function(player, target)
		local slowDuration = 5000
		local weakenDuration = 10000
		local magicCost = 200 + player.level * 2
		local hitchance
		local aether = 10000
		local anim = 294
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
		if (target.paralyzed == true) or target:hasDuration("ray_of_enfeeblement") then
			player:sendMinitext("Spell already cast")
			player:sendAnimation(246)
			return
		end

		player:sendAction(6, 20)
		player:playSound(sound)
		player:setAether("ray_of_enfeeblement", aether)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:sendMinitext("You cast Ray of Enfeeblement")
		target:sendAnimation(anim)
		target:setDuration("slow", slowDuration)
		target:setDuration("ray_of_enfeeblement", weakenDuration)
	end
}
