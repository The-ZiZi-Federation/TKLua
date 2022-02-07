kane = {
	click = async(
		function(player, npc)
			local name = "<b>[" .. npc.name .. "]\n\n"
			local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID

			local weap = player:getEquippedItem(0)
			local shield = player:getEquippedItem(2)
			local helm = player:getEquippedItem(3)

			local opts = {}

			if weap ~= nil then
				if weap.customLook == 0 then
					table.insert(opts, "Skin my weapon")
				elseif weap.customLook > 0 then
					table.insert(opts, "Unskin my weapon")
				end
			end

			if shield ~= nil then
				if shield.customLook == 0 then
					table.insert(opts, "Skin my shield")
				elseif shield.customLook > 0 then
					table.insert(opts, "Unskin my shield")
				end
			end

			if helm ~= nil then
				if helm.customLook == 0 then
					table.insert(opts, "Skin my helm")
				elseif helm.customLook > 0 then
					table.insert(opts, "Unskin my helm")
				end
			end

			menu = player:menuString(name .. "What?", opts)

			if (menu == "Skin my weapon") then
				kane.weaponSkin(player, npc)
			elseif (menu == "Unskin my weapon") then
				kane.weaponUnskin(player, npc)
			elseif (menu == "Skin my shield") then
				kane.shieldSkin(player, npc)
			elseif (menu == "Unskin my shield") then
				kane.shieldUnskin(player, npc)
			elseif (menu == "Skin my helm") then
				kane.helmSkin(player, npc)
			elseif (menu == "Unskin my helm") then
				kane.helmUnskin(player, npc)
			end
		end
	),
	weaponSkin = function(player, npc)
		local name = "<b>[" .. npc.name .. "]\n\n"
		local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		player.lastClick = npc.ID

		local itemNames = {}
		local itemIDs = {}
		local opts = {}
		local weap = player:getEquippedItem(0)

		local itemLook = 0
		local itemLookC = 0
		local itemIcon = 0
		local itemIconC = 0

		for i = 0, player.maxInv do
			item = player:getInventoryItem(i)
			if item ~= nil then
				--Player(4):talk(0,"Item #"..i..": "..item.name)
				if item.skinnable == 1 and item.type == 3 then
					--Player(4):talk(0,"Skinnable #"..i..": "..item.name)
					table.insert(itemNames, item.name)
					table.insert(itemIDs, item.id)
				end
			end
		end

		menu = player:menu(name .. "Which?", itemNames)
		if menu ~= nil then
			chosenItem = Item(itemIDs[menu])

			confirm =
				player:menuString(
				name .. "Skin your " .. weap.name .. " with the look of " .. chosenItem.name .. "?",
				{"Yes", "No"}
			)
			if confirm == "Yes" then
				itemLook = chosenItem.look
				itemLookC = chosenItem.lookC
				itemIcon = chosenItem.icon - 49152
				itemIconC = chosenItem.iconC

				if player:removeItem(chosenItem.id, 1) == true then
					setWeapon(player, itemLook, itemLookC, itemIcon, itemIconC)
				end
			end
		end
	end,
	weaponUnskin = function(player, npc)
		local name = "<b>[" .. npc.name .. "]\n\n"
		local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		player.lastClick = npc.ID

		player:dialogSeq({t, name .. "This will permanently remove the skin from your weapon. You won't get it back."}, 1)

		confirm = string.lower(player:input("To remove your weapon skin, type 'unskin' below:", {"Yes", "No"}))

		if confirm == "unskin" then
			setWeapon(player, 0, 0, 0, 0)
		end
	end,
	shieldSkin = function(player, npc)
		local name = "<b>[" .. npc.name .. "]\n\n"
		local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		player.lastClick = npc.ID

		local itemNames = {}
		local itemIDs = {}
		local opts = {}

		for i = 0, player.maxInv do
			item = player:getInventoryItem(i)
			if item ~= nil then
				--Player(4):talk(0,"Item #"..i..": "..item.name)
				if item.skinnable == 1 and item.type == 5 then
					--Player(4):talk(0,"Skinnable #"..i..": "..item.name)
					table.insert(itemNames, item.name)
					table.insert(itemIDs, item.id)
				end
			end
		end

		menu = player:menu(name .. "Which?", itemNames)
		if menu ~= nil then
			chosenItem = Item(itemIDs[menu])
			if player:removeItem(chosenItem.id, 1) == true then
				setShield(player, chosenItem.look, chosenItem.lookC, chosenItem.icon - 49152, chosenItem.iconC)
			end
		end
	end,
	shieldUnskin = function(player, npc)
		local name = "<b>[" .. npc.name .. "]\n\n"
		local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		player.lastClick = npc.ID

		player:dialogSeq({t, name .. "This will permanently remove the skin from your shield. You won't get it back."}, 1)

		confirm = string.lower(player:input("To remove your shield skin, type 'unskin' below:", {"Yes", "No"}))

		if confirm == "unskin" then
			setShield(player, 0, 0, 0, 0)
		end
	end,
	helmSkin = function(player, npc)
		local name = "<b>[" .. npc.name .. "]\n\n"
		local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		player.lastClick = npc.ID

		local itemNames = {}
		local itemIDs = {}
		local opts = {}

		for i = 0, player.maxInv do
			item = player:getInventoryItem(i)
			if item ~= nil then
				--Player(4):talk(0,"Item #"..i..": "..item.name)
				if item.skinnable == 1 and (item.type == 6) then
					--Player(4):talk(0,"Skinnable #"..i..": "..item.name)
					table.insert(itemNames, item.name)
					table.insert(itemIDs, item.id)
				end
			end
		end

		menu = player:menu(name .. "Which?", itemNames)
		if menu ~= nil then
			chosenItem = Item(itemIDs[menu])
			if player:removeItem(chosenItem.id, 1) == true then
				setHelm(player, chosenItem.look, chosenItem.lookC, chosenItem.icon - 49152, chosenItem.iconC)
			end
		end
	end,
	helmUnskin = function(player, npc)
		local name = "<b>[" .. npc.name .. "]\n\n"
		local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		player.lastClick = npc.ID

		player:dialogSeq({t, name .. "This will permanently remove the skin from your helm. You won't get it back."}, 1)

		confirm = string.lower(player:input("To remove your helm skin, type 'unskin' below:", {"Yes", "No"}))

		if confirm == "unskin" then
			setHelm(player, 0, 0, 0, 0)
		end
	end
}
