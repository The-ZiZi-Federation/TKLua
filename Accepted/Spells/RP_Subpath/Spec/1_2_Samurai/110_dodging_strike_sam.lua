dodging_strike_sam = {
	on_learn = function(player)
		player.registry["learned_dodging_strike_sam"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_dodging_strike_sam"] = 0
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

		if (mobTarget ~= nil) then
			if canAmbush(player, mobTarget) then
				player:sendMinitext("You cast Dodging Strike.")

				if (player.ambushTimer < ((os.time() * 1000) + timeMS())) then
					player.ambushTimer = (((os.time() * 1000) + timeMS()) + ((player.attackSpeed * 1000) / 50))
					mobTarget:sendAnimation(257)
					player:swing()
				end
				dodging_strike_sam.finishCast(player, startingSide)
			else
				if (player.ambushTimer < ((os.time() * 1000) + timeMS())) then
					player.ambushTimer = (((os.time() * 1000) + timeMS()) + ((player.attackSpeed * 1000) / 50))
					mobTarget:sendAnimation(257)
					player:swing()
				end
			end
		elseif (pcTarget ~= nil) then
			if canAmbush(player, pcTarget) then
				player:sendMinitext("You cast Dodging Strike.")

				if (player.ambushTimer < ((os.time() * 1000) + timeMS())) then
					player.ambushTimer = (((os.time() * 1000) + timeMS()) + ((player.attackSpeed * 1000) / 50))
					pcTarget:sendAnimation(257)
					player:swing()
				end
				dodging_strike_sam.finishCast(player, startingSide)
			else
				if (player.ambushTimer < ((os.time() * 1000) + timeMS())) then
					player.ambushTimer = (((os.time() * 1000) + timeMS()) + ((player.attackSpeed * 1000) / 50))
					pcTarget:sendAnimation(257)
					player:swing()
				end
			end
		elseif (npcTarget ~= nil) then
			if canAmbush(player, npcTarget) then
				player:sendMinitext("You cast Dodging Strike.")

				if (player.ambushTimer < ((os.time() * 1000) + timeMS())) then
					player.ambushTimer = (((os.time() * 1000) + timeMS()) + ((player.attackSpeed * 1000) / 50))
					npcTarget:sendAnimation(257)
					player:swing()
				end
				dodging_strike_sam.finishCast(player, startingSide)
			else
				if (player.ambushTimer < ((os.time() * 1000) + timeMS())) then
					player.ambushTimer = (((os.time() * 1000) + timeMS()) + ((player.attackSpeed * 1000) / 50))
					npcTarget:sendAnimation(257)
					player:swing()
				end
			end
		end
	end,
	finishCast = function(player, side)
		player.side = side
		player:sendSide()
		player:sendAction(1, 20)
		player:sendAnimation(285)
		player:playSound(358)
		player:playSound(357)
	end,
	requirements = function(player)
		local level = 5
		local item = {0}
		local amounts = {50000}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"A traditional Samurai technique to dash past a foe while striking them.", txt}
		return level, item, amounts, desc
	end
}
