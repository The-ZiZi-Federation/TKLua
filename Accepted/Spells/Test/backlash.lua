backlash = {
	on_learn = function(player)
		player.registry["learned_backlash"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_backlash"] = 0
	end,
	cast = function(player)
		local magicCost = 1000
		if not player:canCast(1, 1, 0) then
			return
		end
		if player.magic < magicCost then
			notEnoughMP(player)
			return
		end

		if player:hasDuration("backlash") then
			anim(player)
			player:sendMinitext("Spell already cast!")
			return
		else
			player:sendAction(6, 20)
			player.magic = player.magic - magicCost
			player:sendStatus()
			player:setDuration("backlash", 5000)
			player:sendAnimation(249)
			player:playSound(0)
			player:sendMinitext("You cast Backlash")
			player.registry["backlash"] = player.health
			player.registry["backlash2"] = 0
		end
	end,
	on_takedamage_while_cast = function(player, mob)
		--player.registry["backlash2"] = player.health
		player.registry["backlash2"] = player.registry["backlash2"] + mob.damage
	end,
	uncast = function(player)
		local reg1 = player.registry["backlash"]
		local reg2 = player.registry["backlash2"]
		--local damage = (reg1 - reg2)*10
		local damage = reg2 * 10
		local mobTarget = getTargetFacing(player, BL_MOB)
		local pcTarget = getTargetFacing(player, BL_PC)

		player.registry["backlash2"] = player.health

		if mobTarget ~= nil then
			mobTarget.attacker = player.ID
			mobTarget:sendAnimation(6, 0)
			mobTarget:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			player:sendAction(1, 20)
			player:sendMinitext("Your anger explodes!")
			reg1 = 0
			reg2 = 0
		elseif pcTarget ~= nil then
			pcTarget:sendAnimation(6, 0)
			if (player:canPK(pcTarget)) then
				pcTarget.attacker = player.ID
				pcTarget:removeHealthExtend(damage, 1, 1, 1, 1, 0)
				player:sendAction(1, 20)
				player:sendMinitext("Your anger explodes!")
				reg1 = 0
				reg2 = 0
			end
		end
		player:calcStat()
	end
}
