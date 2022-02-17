dodging_strike_test = {
	on_learn = function(player)
		player.registry["learned_dodging_strike"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_dodging_strike"] = 0
	end,
	cast = function(player)
		local mobTarget = getTargetFacing(player, BL_MOB)
		local pcTarget = getTargetFacing(player, BL_PC)
		local npcTarget = getTargetFacing(player, BL_NPC)
		local weapon = player:getEquippedItem(EQ_WEAP)
		local startingSide
		startingSide = player.side

		if (not player:canCast(1, 1, 0)) then
			return
		end

		if (mobTarget ~= nil and canAmbush(player, mobTarget)) then
			player:sendMinitext("You cast Dodging Strike.")

			if (player.ambushTimer < ((os.time() * 1000) + timeMS())) then
				player.ambushTimer = (((os.time() * 1000) + timeMS()) + ((player.attackSpeed * 1000) / 50))
				mobTarget:sendAnimation(257)
				player:swing()
			end
			dodging_strike_test.finishCast(player, startingSide)
		elseif (pcTarget ~= nil and canAmbush(player, pcTarget)) then
			player:sendMinitext("You cast Dodging Strike.")

			if (player.ambushTimer < ((os.time() * 1000) + timeMS())) then
				player.ambushTimer = (((os.time() * 1000) + timeMS()) + ((player.attackSpeed * 1000) / 50))
				pcTarget:sendAnimation(257)
				player:swing()
			end
			dodging_strike_test.finishCast(player, startingSide)
		elseif (npcTarget ~= nil and canAmbush(player, npcTarget)) then
			player:sendMinitext("You cast Dodging Strike.")

			if (player.ambushTimer < ((os.time() * 1000) + timeMS())) then
				player.ambushTimer = (((os.time() * 1000) + timeMS()) + ((player.attackSpeed * 1000) / 50))
				npcTarget:sendAnimation(257)
				player:swing()
			end
			dodging_strike_test.finishCast(player, startingSide)
		end
	end,
	finishCast = function(player, side)
		player.side = side
		player:sendSide()
		player:sendAction(1, 20)
		player:sendAnimation(285)
		player:playSound(358)
		player:playSound(357)
	end
}
