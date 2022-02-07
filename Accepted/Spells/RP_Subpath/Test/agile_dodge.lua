agile_dodge = {
	on_learn = function(player)
		player.registry["learned_agile_dodge"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_agile_dodge"] = 0
	end,
	cast = function(player)
		local magicCost = 500
		local dura = 30000
		local aether = 45000

		if not player:canCast(1, 1, 0) then
			return
		end
		if player.magic < magicCost then
			notEnoughMP(player)
			return
		end

		if player:hasDuration("agile_dodge") then
			anim(player)
			player:sendMinitext("Spell is already cast!")
			return
		else
			player.magic = player.magic - magicCost
			player:setDuration("agile_dodge", dura)
			player:setAether("agile_dodge", aether)
			player:sendAction(6, 20)
			player:sendStatus()
			player:sendAnimation(279)
			player:playSound(9)
			player:sendMinitext("You cast Agile Dodge")
		end
	end
}
