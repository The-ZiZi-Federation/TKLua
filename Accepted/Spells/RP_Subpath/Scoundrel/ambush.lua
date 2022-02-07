ambush = {
	on_learn = function(player)
		player.registry["learned_ambush"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_ambush"] = 0
	end,
	cast = function(player)
		local mobTarget = getTargetFacing(player, BL_MOB)
		local pcTarget = getTargetFacing(player, BL_PC)
		local npcTarget = getTargetFacing(player, BL_NPC)
		local weapon = player:getEquippedItem(EQ_WEAP)

		if player.blType == BL_PC then
			if (not player:canCast(1, 1, 0)) then
				return
			end

			if (mobTarget ~= nil) then
				if canAmbush(player, mobTarget) then
					player:sendMinitext("You cast Ambush.")

					if (player.ambushTimer < ((os.time() * 1000) + timeMS())) then
						player.ambushTimer = (((os.time() * 1000) + timeMS()) + ((player.attackSpeed * 1000) / 50))
						player:swing()
					end
				else
					if (player.ambushTimer < ((os.time() * 1000) + timeMS())) then
						player.ambushTimer = (((os.time() * 1000) + timeMS()) + ((player.attackSpeed * 1000) / 50))
						player:swing()
					end
				end
			elseif (pcTarget ~= nil) then
				if canAmbush(player, pcTarget) then
					player:sendMinitext("You cast Ambush.")

					if (player.ambushTimer < ((os.time() * 1000) + timeMS())) then
						player.ambushTimer = (((os.time() * 1000) + timeMS()) + ((player.attackSpeed * 1000) / 50))
						player:swing()
					end
				else
					if (player.ambushTimer < ((os.time() * 1000) + timeMS())) then
						player.ambushTimer = (((os.time() * 1000) + timeMS()) + ((player.attackSpeed * 1000) / 50))
						player:swing()
					end
				end
			elseif (npcTarget ~= nil) then
				if canAmbush(player, npcTarget) then
					player:sendMinitext("You cast Ambush.")

					if (player.ambushTimer < ((os.time() * 1000) + timeMS())) then
						player.ambushTimer = (((os.time() * 1000) + timeMS()) + ((player.attackSpeed * 1000) / 50))
						player:swing()
					end
				else
					if (player.ambushTimer < ((os.time() * 1000) + timeMS())) then
						player.ambushTimer = (((os.time() * 1000) + timeMS()) + ((player.attackSpeed * 1000) / 50))
						player:swing()
					end
				end
			end
		elseif player.blType == BL_MOB then
			if (mobTarget ~= nil and canAmbush(player, mobTarget)) then
				player:talk(2, "Ambush~~~!")
				player:attack(mobTarget.ID)
			elseif (pcTarget ~= nil and canAmbush(player, pcTarget)) then
				player:talk(2, "Ambush~~~!")
				player:attack(pcTarget.ID)
			elseif (npcTarget ~= nil and canAmbush(player, npcTarget)) then
				player:talk(2, "Ambush~~~!")
				player:attack(npcTarget.ID)
			end
		end
	end,
	requirements = function(player)
		local level = 10
		local item = {0, 246}
		local amounts = {500, 10}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Leap over your enemy to face their back while attacking.", txt}
		return level, item, amounts, desc
	end
}
