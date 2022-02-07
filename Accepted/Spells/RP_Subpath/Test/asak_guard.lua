asak_guard = {
	cast = function(player, target)
		local magicCost = player.magic * .5
		local aether, duration = 30000, 300000
		local animation, sound = 0, 0

		if not player:canCast(1, 1, 0) then
			return
		else
			if player.magic - magicCost < 0 then
				return
			else
				if target.blType ~= BL_PC then
					invalidTarget(player)
					return
				else
					if target.state == 1 then
						anim(player, "Target is already dead!")
						return
					else
						if target:hasDuration("asak_guard") then
							anim(player, "You are too late, target is guarded!")
							return
						else
							if target.registry["asak_guard"] == 0 then
								player:sendAction(6, 20)
								player.magic = player.magic - magicCost
								player:sendStatus()
								player:setAether("asak_guard", aether)
								target:sendAnimation(animation)
								player:playSound(sound)
								target.registry["asak_guard"] = magicCost
								target:setDuration("asak_guard", duration, player.ID)
								player:sendMinitext("You cast Asak Guard")
							end
						end
					end
				end
			end
		end
	end,
	takedamage = function(player, attacker)
		local guard = player.registry["asak_guard"]
		local damage = math.abs(math.floor(attacker.damage))

		if player:hasDuration("asak_guard") then
			player.attacker = attacker.ID
			player:sendAnimation(300)

			if guard <= 0 then
				player:setDuration("asak_guard", 0)
				return
			else
				if damage > guard then
					finaldamage = damage - guard
					player:removeHealthExtend(finaldamage, 1, 1, 1, 1, 0)
					player:talk(
						1,
						"attacker damage = " .. damage .. ", armor = " .. guard .. ", damage taken = " .. damage - guard .. ""
					)
					return
				else
					player.registry["asak_guard"] = player.registry["asak_guard"] - damage
					player:sendAction(3, 40)
				end
			end
		end
	end,
	while_cast = function(player, caster)
		player:talk(2, "Guard: " .. format_number(player.registry["asak_guard"]))
	end,
	uncast = function(player)
		player.registry["asak_guard"] = 0
		player:calcStat()
	end
}
