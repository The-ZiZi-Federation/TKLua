filch = {
	on_learn = function(player)
		player.registry["learned_filch"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_filch"] = 0
	end,
	cast = function(player)
		local magicCost = 30
		local sound = 708
		local curseCheck = 0

		if not player:canCast(1, 1, 0) then
			return
		end

		player.magic = player.magic - magicCost
		player:playSound(sound)
		player:sendAction(6, 20)
		player:sendStatus()
		player:talk(2, "I'll take that!")

		local items = {}
		if (player.side == 0) then
			items = player:getObjectsInCell(player.m, player.x, player.y - 1, BL_ITEM)
		elseif (player.side == 1) then
			items = player:getObjectsInCell(player.m, player.x + 1, player.y, BL_ITEM)
		elseif (player.side == 2) then
			items = player:getObjectsInCell(player.m, player.x, player.y + 1, BL_ITEM)
		elseif (player.side == 3) then
			items = player:getObjectsInCell(player.m, player.x - 1, player.y, BL_ITEM)
		end

		if #items > 0 then
			for i = 1, #items do
				if items[i].id <= 12 then --If it is coins
					if items[i].cursed == 0 or items[i].cursed == player.ID then
						player:sendAction(6, 20)
						items[i]:delete()
						player:addGold(items[i].amount)
					elseif items[i].cursed > 0 and items[i].cursed ~= player.ID then
						curseCheck = items[i].cursed
					end
				elseif items[i].id > 12 then --If it is not coins
					if items[i].cursed == 0 or items[i].cursed == player.ID then
						player:sendAction(6, 20)
						player:pickUp(items[i].ID)
					elseif items[i].cursed > 0 and items[i].cursed ~= player.ID then
						curseCheck = items[i].cursed
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
