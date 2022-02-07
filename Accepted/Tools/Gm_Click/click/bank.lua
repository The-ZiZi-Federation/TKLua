bank = {
	click = function(player, target, npc)
		local name = "<b>[" .. target.name .. "'s Bank]\n\n"
		player.dialogType = 2

		menu = player:menuString(name .. "What to do with target's bank?", {"Show Bank", "Add item to bank", "<< Back"})

		if menu == "Show Bank" then
			bank.show(player, target, npc)
		elseif menu == "Add item to bank" then
			bank.add(player, target, npc)
		elseif menu == "<< Back" then
			player:freeAsync()
			click.menu(player, target, npc)
		end
	end,
	show = function(player, target, npc)
		local item, amount, owner, en =
			target:checkBankItems(),
			target:checkBankAmounts(),
			target:checkBankOwners(),
			target:checkBankEngraves()
		local found, amount, counter, next = 0, 0, 0, next

		for i = 1, #item do
			if item[i] == 0 then
				counter = #item
				for x = i, counter do
					table.remove(item, i)
					table.remove(amount, i)
					table.remove(owner, i)
					table.remove(en, i)
				end
				break
			end
		end
		if next(item) == 0 then
			player:dialogSeq({name .. "Target's bank is currently empty!"})
			return
		else
			take = player:buy(name .. "Total items : " .. #item .. "\nWhat to do with target's bank item?", item, amount, {}, {})
			for i = 1, target.maxSlots do
				if item[i] == take then
					found = i
					break
				end
			end
			if found == 0 then
				return nil
			else
				icon = {graphic = Item(item[found]).icon, color = Item(item[found]).iconC}
				player.npcGraphic = icon.graphic
				player.npcColor = icon.color
				player.dialogType = 0
				text = "Item : " .. Item(item[found]).name .. "\n"
				text = text .. "Qty  : " .. amount[found] .. " pcs\n"
				opts = {"Take", "Delete", "<< Back"}
				choice = player:menuSeq(name .. "" .. text .. "\nWhat to do with this item?", opts, {})
				if choice == 3 then
					bank.show(player, target, npc)
				elseif choice == 2 then
				elseif choice == 1 then
					if Item(item[found]).maxAmount > 1 then
						q = math.abs(tonumber(math.ceil(player:input("" .. text .. "\nHow many shall you withdraw?"))))
						if q > amount[found] then
							q = amount[found]
						end
					else
						q = 1
					end
					if q <= 0 then
						return false
					else
						if player:hasSpace(item[found], q, owner[found], en[found]) ~= true then
							player:dialogSeq({name .. "You don't have enough space in your inventory for that!"}, 1)
							bank.show(player, target, npc)
							return
						else
							local worked = player:addItem(item[found], q, 0, owner[found], en[found])

							if (worked == true) then
								bank.withdraw(item[found], q, 0, owner[found], en[found])
							else
								player:dialogSeq({name .. "Cannot take " .. q .. " " .. Item(item[found]).name .. " from target!"}, 1)
								bank.show(player, target, npc)
							end
						end
					end
				end
			end
		end
	end
}
