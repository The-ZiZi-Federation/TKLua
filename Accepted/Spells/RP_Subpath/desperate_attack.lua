desperate_attack = {
	on_learned = function(player)
		player.registry["learned_desperate_attack"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_desperate_attack"] = 0
	end,
	cast = function(player)
		local mobTarget = getTargetFacing(player, BL_MOB)
		local pcTarget = getTargetFacing(player, BL_PC)
		local damage = ((player.health) + (player.magic))
		local threat
		local magicCost = 60
		local minHealth = 100

		if (not player:canCast(1, 1, 0)) then
			return
		end
		if player.magic < magicCost then
			notEnoughMP(player)
			return
		end

		if (mobTarget ~= nil) then
			desperate_attack.playerEffects(player)
			mobTarget.attacker = player.ID
			threat = mobTarget:removeHealthExtend(damage, 1, 1, 1, 1, 2)
			player:addThreat(mobTarget.ID, threat)
			mobTarget:sendAnimation(7)
			mobTarget:removeHealthExtend(damage, 1, 1, 1, 1, 0)
		elseif (pcTarget ~= nil) then
			desperate_attack.playerEffects(player)
			pcTarget:sendAnimation(7)
			if pcTarget.state ~= 1 then
				if (player:canPK(pcTarget)) then
					pcTarget.attacker = player.ID
					pcTarget:removeHealthExtend(damage, 1, 1, 1, 1, 0)
					pcTarget:sendMinitext(player.name .. " attack you with Desperate attack!")
				end
			end
		else
			player:sendMinitext("Nothing to attack!")
		end
	end,
	playerEffects = function(player)
		local aether = 11000
		local healthCost = player.health * .50

		player:sendAction(1, 20)
		player:setAether("desperate_attack", aether)
		player:sendMinitext("You cast Desperate Attack")
		player:talk(2, "Ka~!")
		player:playSound(35)
		player.health = player.health - healthCost
		player.magic = 0
		player:sendStatus()
	end,
	requirements = function(player)
	end
}
