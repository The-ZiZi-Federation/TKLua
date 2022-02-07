feeble_mind = {
	on_learn = function(player)
		player.registry["feeble_mind"] = 1
	end,
	on_forget = function(player)
		player.registry["feeble_mind"] = 0
	end,
	cast = function(player, target)
		local magicCost = 1000

		if not player:canCast(1, 1, 0) then
			return
		end
		if player.magic < magicCost then
			notEnoughMP(player)
			return
		end

		if target.blType == BL_PC then
			if player:canPK(target) then
				player.magic = player.magic - magicCost
				if target.will >= 26 then
					target.will = target.will - 25
				else
					target.will = 0
				end
				player:sendStatus()
				player:sendAction(6, 20)
				player:sendMinitext("You cast Feeble Mind")
				target:sendAnimation(11)
				player:playSound(8)
				target:sendMinitext(player.name .. " cast Feeble Mind on you")
				target:setDuration("feeble_mind", 60000)
			else
				player:sendMinitext("PVP Only!")
			end
		else
			player:sendMinitext("Player Targets Only!")
		end
	end,
	uncast = function(player)
		player.will = target.will + 25
		player:calcStat()
	end
}
