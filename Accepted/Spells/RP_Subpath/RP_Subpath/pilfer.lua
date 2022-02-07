pilfer = {
	on_learn = function(player)
		player.registry["learned_pilfer"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_pilfer"] = 0
	end,
	cast = function(player)
		local magicCost = 100
		local sound = 708
		local curseCheck = 0

		if not player:canCast(1, 1, 0) then
			return
		end

		player.magic = player.magic - magicCost
		player:playSound(sound)
		player:sendAction(6, 20)
		player:sendStatus()
		player:talk(2, "That's mine!")

		local allItems = {}
		local items = {}
		local count = 0
		local pc
		local npc

		for i = 1, 2 do
			if (player.side == 0) then
				items = player:getObjectsInCell(player.m, player.x, player.y - i, BL_ITEM)
				pc = player:getObjectsInCell(player.m, player.x, player.y - i, BL_PC)
				npc = player:getObjectsInCell(player.m, player.x, player.y - i, BL_NPC)
			elseif (player.side == 1) then
				items = player:getObjectsInCell(player.m, player.x + i, player.y, BL_ITEM)
				pc = player:getObjectsInCell(player.m, player.x + i, player.y, BL_PC)
				npc = player:getObjectsInCell(player.m, player.x + i, player.y, BL_NPC)
			elseif (player.side == 2) then
				items = player:getObjectsInCell(player.m, player.x, player.y + i, BL_ITEM)
				pc = player:getObjectsInCell(player.m, player.x, player.y + i, BL_PC)
				npc = player:getObjectsInCell(player.m, player.x, player.y + i, BL_NPC)
			elseif (player.side == 3) then
				items = player:getObjectsInCell(player.m, player.x - i, player.y, BL_ITEM)
				pc = player:getObjectsInCell(player.m, player.x - i, player.y, BL_PC)
				npc = player:getObjectsInCell(player.m, player.x - i, player.y, BL_NPC)
			end

			if #items > 0 then
				for i = 1, #items do
					if items[i].id <= 12 then --If it is coins
						if items[i].cursed == 0 then --if it is not cursed
							if #pc == 0 and #npc == 0 then --if no one is standing on it
								items[i]:delete()
								player:addGold(items[i].amount)
							end
						elseif items[i].cursed == player.ID then --if it is cursed to the player
							items[i]:delete()
							player:addGold(items[i].amount)
						elseif items[i].cursed > 0 and items[i].cursed ~= player.ID then --if it is cursed to someone else
							curseCheck = items[i].cursed
						end
					elseif items[i].id > 12 then --If it is an item
						if items[i].cursed == 0 then --if it is not cursed
							if #pc == 0 and #npc == 0 then --if no one is standing on it
								player:pickUp(items[i].ID)
							end
						elseif items[i].cursed == player.ID then --if it is cursed to the player
							player:pickUp(items[i].ID)
						elseif items[i].cursed > 0 and items[i].cursed ~= player.ID then --if it is cursed to someone else
							curseCheck = items[i].cursed
						end
					end
				end
			end
		end

		if curseCheck > 0 then
			player:sendMinitext("This is cursed to " .. getOfflineID(curseCheck))
		end
	end,
	requirements = function(player)
	end
}
