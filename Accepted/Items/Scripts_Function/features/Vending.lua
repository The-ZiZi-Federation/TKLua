
vending_menu = {

click = function(player, npc)


	local t = {graphic = convertGraphic(1439, "monster"), color = 0}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0

	local vendingMsg = player.name.."'s shop"
	local max = player.registry["max_vending_slots"]
	local vending = "<b>[Vending]\n\n"
	local cape = player:getEquippedItem(EQ_MANTLE)
	local env, opts = {"vending_ransel", "vending_cart", "vending_troly"}, {}
	
	if cape == nil then player:popUp("<b>              [Vending]\n\nYou must to equip vending ransel/cart to open this menu!") return else
		for i = 1, #env do
			if not cape.yname == env[i] then player:popUp("<b>              [Vending]\n\nYou must to equip vending ransel/cart to open this menu") return end
		end
	end	
	if player.registry["v_open"] == 0 and not player:hasDuration("vending_menu") then
		if totalSaleItem(player) > 0 then
			table.insert(opts, "Open shop")
			table.insert(opts, "Show item")
		end
		if totalSaleItem(player) < max then table.insert(opts, "Add item") end
	else
		table.insert(opts, "Close shop")
	end
	
	table.insert(opts, "Set a promotion text")
	table.insert(opts, "Exit")

	menu = player:menuString(vending.."> "..vendingMsg.."\n\nTotal item on sale : ("..totalSaleItem(player).."/"..max..")", opts)


	if menu == "Add item" then
		vending_menu.addItem(player, npc)
		
	elseif menu == "Open shop" then
		vending_menu.openShop(player, npc)
	
	elseif menu == "Close shop" then
		vending_menu.closeShop(player, npc)
	
	elseif menu == "Show item" then
		vending_menu.showItem(player, npc)
	
	elseif menu == "Set a promotion text" then
		vending_menu.setPromotionText(player, npc)
		
	end
end,

click2 = async(function(player, npc)


	local t = {graphic = convertGraphic(1439, "monster"), color = 0}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0

	local vendingMsg = player.name.."'s shop"
	local max = player.registry["max_vending_slots"]
	local vending = "<b>[Vending]\n\n"
	local cape = player:getEquippedItem(EQ_MANTLE)
	local env, opts = {"vending_ransel", "vending_cart", "vending_troly"}, {}
	
	if cape == nil then player:popUp("<b>              [Vending]\n\nYou must to equip vending ransel/cart to open this menu!") return else
		for i = 1, #env do
			if not cape.yname == env[i] then player:popUp("<b>              [Vending]\n\nYou must to equip vending ransel/cart to open this menu") return end
		end
	end	
	if player.registry["v_open"] == 0 and not player:hasDuration("vending_menu") then
		if totalSaleItem(player) > 0 then
			table.insert(opts, "Open shop")
			table.insert(opts, "Show item")
		end
		if totalSaleItem(player) < max then table.insert(opts, "Add item") end
	else
		table.insert(opts, "Close shop")
	end
	
	table.insert(opts, "Set a promotion text")
	table.insert(opts, "Exit")

	menu = player:menuString(vending.."> "..vendingMsg.."\n\nTotal item on sale : ("..totalSaleItem(player).."/"..max..")", opts)


	if menu == "Add item" then
		vending_menu.addItem(player, npc)
		
	elseif menu == "Open shop" then
		vending_menu.openShop(player, npc)
	
	elseif menu == "Close shop" then
		vending_menu.closeShop(player, npc)
	
	elseif menu == "Show item" then
		vending_menu.showItem(player, npc)
	
	elseif menu == "Set a promotion text" then
		vending_menu.setPromotionText(player, npc)
		
	end
end),


---------------------------------------------------------------------------------------------------------------------------------------

setPromotionText = function(player, npc)

	local text = player:input("<b>[Vending]\n\nSet your shop's promotion text / your shop's name\n\n> "..player.vendingMsg)
	
	if text ~= nil then
		if string.len(text) < 2 or string.len(text) > 60 then
			player.vendingMsg = player.name.."'s Shop"
		else
			player.vendingMsg = text
		end
		player:sendMinitext("changed vending promotion text!")
	end
end,

---------------------------------------------------------------------------------------------------------------------------------------

while_cast = function(player)
	
	player.paralyzed = true
	player:talk(2, player.vendingMsg)
	player.registry["v_open"] = 1
	player.gfxClone = 1
end,

---------------------------------------------------------------------------------------------------------------------------------------

uncast = function(player)
	
	player:sendAnimation(251)
	player:playSound(402)
	player:calcStat()
	player.paralyzed = false
	player.registry["v_open"] = 0
	player.gfxClone = 0
	if player.state == 4 then player.disguise = 0 player.state =0 end
	player:updateState()
	player:sendMinitext("Shop closed!")
end,


---------------------------------------------------------------------------------------------------------------------------------------

openShop = function(player)
	
	if player:hasDuration("vending_menu") and player.registry["v_open"] > 0 then return else
		if totalSaleItem(player) > 0 and player.state == 0 then
			--vending_menu.randomCostume(player)
			vending_menu.randomStall(player)
			--vending_menu.vendingCostume(player)
			player.paralyzed = true
			player.registry["v_open"] = 1
			player:setDuration("vending_menu", 7200000)
			player:sendAnimation(278)
			player:playSound(371)
			player:playSound(401)
			player:sendMinitext("Shop opened!")
			--if string.len(player.vendingMsg) <= 1 then vending_menu.setPromotionText(player) end
		end
	end
end,

---------------------------------------------------------------------------------------------------------------------------------------

closeShop = function(player)

	if player.registry["v_open"] == 1 and player:hasDuration("vending_menu") then player:setDuration("vending_menu", 0) end
end,

---------------------------------------------------------------------------------------------------------------------------------------

addItem = function(player)
	
	local t = {graphic = convertGraphic(783, "monster"), color = 0}
	local max = player.registry["max_vending_slots"]
	local vending = "<b>[Vending]\n\n"
	local list, icon = {}, {}
	local amount, found = 0, 0
	
	for i = 0, player.maxInv do
		item = player:getInventoryItem(i)
		if item ~= nil and item.id > 0 then
			if item.yname ~= "engage_ring" and item.yname ~= "wedding_ring" and item.yname ~= "temporary_citizen_visa" and item.yname ~= "velotropolis_visa" then
				if #list > 0 then found = 0
					for j = 1, #list do
						if list[j] == item.id then found = 1 break end
					end
					if found == 0 then table.insert(list, item.id) end
				else
					table.insert(list, item.id)
				end
			end
		end
	end
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	add = player:sell(vending.."What item would you put on sale?\n\nCurrent items: ("..totalSaleItem(player).."/"..max..")", list)
	choice = player:getInventoryItem(add - 1)
	icon = {graphic = choice.icon, color = choice.iconC}
	if choice.customLook ~= 0 or choice.customIcon ~= 0 or choice.realName ~= "" then
					player:popUp("Sorry you cannot add engraved or skinned items to your store.")
					return
					end

	if choice.dura < choice.maxDura then player:dialogSeq({icon, vending.."Your "..choice.name.." must in perfect condition (100%) to put on sale!"}, 1)
		vending_menu.addItem(player)
	return else
		if choice.yname == "engage_ring" or choice.yname == "wedding_ring" then
			player:dialogSeq({icon, vending.."You cannot sell this item!"})
		return else
			if choice.amount > 1 and choice.maxAmount > 1 then
				amount = math.abs(tonumber(math.floor(player:input(vending.."How many "..choice.name.."?"))))
				if amount <= 0 then
					player:dialogSeq({icon, vending.."Invalid amount number!"}, 1)
					vending_menu.addItem(player)
				return else
					if player:hasItem(choice.id, amount) ~= true then
						check = player:hasItem(choice.id, amount)
						amount = check
					end
				end
			else
				amount = 1
			end
		end
	end
	
	price = math.abs(tonumber(math.floor(player:input(vending.."How much money for "..amount.." "..choice.name.." ?"))))
	if price < 0 then
		player:dialogSeq({icon, vending.."Invalid price number!"}, 1)
		vending_menu.addItem(player)
	return else
		player.npcGraphic = icon.graphic
		player.npcColor = icon.color
		player.dialogType = 0
		confirm = {"Yes", "No"}
		ok = player:menuSeq(vending.."You're about to sell "..amount.." "..choice.name.." for "..format_number(price).." coins. Confirm?", confirm, {})
		if ok == 1 and player:hasItem(choice.id, amount) == true then
			for i = 1, player.registry["max_vending_slots"] do
				if player.registry["v_item"..i] == 0 and player.registry["v_amount"..i] == 0 and player.registry["v_sellprice"..i] == 0 then
					vending_menu.edit(player, i, choice.id, amount, price)
					player:removeItem(choice.id, amount)
					player:dialogSeq({icon, vending.."This item will now removed from your inventory and put in your "..player:getEquippedItem(EQ_MANTLE).name.."."}, 1)
					vending_menu.addItem(player)
					return
				end
			end
		end
	end	
end,

---------------------------------------------------------------------------------------------------------------------------------------

showItem = function(player)
	
	local opts, icon, id, qty, cost = {}, {}, {}, {}, {}
	
	for i = 1, player.registry["max_vending_slots"] do
		if player.registry["v_item"..i] > 0 then
			table.insert(id, player.registry["v_item"..i])
			table.insert(qty, player.registry["v_amount"..i])
			table.insert(cost, player.registry["v_sellprice"..i])
			table.insert(opts, Item(player.registry["v_item"..i]).name.." ("..player.registry["v_amount"..i]..") - "..format_number(player.registry["v_sellprice"..i]).." c")
		end
	end
	
	local itemInfo, vending, dialog, d = "", "<b>[Vending]\n\n", "<b>[Vending]\n\n> \n\n\nTotal sale items : ("..totalSaleItem(player).."/"..player.registry["max_vending_slots"]..")\n"
	
	if #opts == 0 then
		player:popUp(vending.."You don't have any item in your "..player:getEquippedItem(EQ_MANTLE).name.."!")
	return else
		player.npcGraphic = convertGraphic(783, "monster")
		player.npcColor = 0
		player.dialogType = 0

		menu = player:menuString(dialog, opts)
		for i = 1, player.registry["max_vending_slots"] do
			if menu == Item(player.registry["v_item"..i]).name.." ("..player.registry["v_amount"..i]..") - "..format_number(player.registry["v_sellprice"..i]).." c" then
				slot, i, a, p = i, player.registry["v_item"..i], player.registry["v_amount"..i], player.registry["v_sellprice"..i]
				icon = {graphic = Item(i).icon, color = Item(i).iconC}
				player.npcGraphic = icon.graphic
				player.npcColor = icon.color
				player.dialogType = 0
				itemInfo = "Item Name  : "..Item(i).name.."\nQuantity   : "..a.." pcs\nSell price : "..format_number(p).." coins\n"
				choiceC = {"Remove item", "Change sell price", "Exit"}
				choice = player:menuSeq(vending..""..itemInfo, choiceC, {})
				if choice == 1 and player.registry["v_item"..slot] == i and player.registry["v_amount"..slot] == a and player.registry["v_sellprice"..slot] == p then
					if not player:hasSpace(i, a) then
						player:dialogSeq({icon, vending.."You don't have enough space in your inventory for this item!"}, 1)
						vending_menu.showItem(player)
					return else
						player:addItem(i, a)
						vending_menu.edit(player, slot, 0, 0, 0)
						player:dialogSeq({icon, vending.."Item removed from your "..player:getEquippedItem(EQ_MANTLE).name.." and added to your inventory!"}, 1)
						vending_menu.showItem(player)
					end
				elseif choice == 2 and player.registry["v_item"..slot] == i and player.registry["v_amount"..slot] == a and player.registry["v_sellprice"..slot] == p then
					cp = math.abs(tonumber(math.ceil(player:input(vending..""..itemInfo.."Change price to:"))))
					if cp > core.ID then
						player:dialogSeq({icon, "Invalid price number!"}, 1)
						vending_menu.showItem(player)
					return else
						vending_menu.edit(player, slot, i, a, cp)
						player:dialogSeq({icon, vending..""..itemInfo.."\n\nItem sell price changed!"}, 1)
						vending_menu.showItem(player)
					end
				elseif choice == 3 then
					return false
				end
			end
		end
	end
end,

edit = function(player, slot, id, amount, price)
	
	player.registry["v_item"..slot] = id
	player.registry["v_amount"..slot] = amount
	player.registry["v_sellprice"..slot] = price
	if totalSaleItem(player) == 0 then
		player:popUp("<b>[Vending]\n\nYour shop is sold out!!")
		vending_menu.closeShop(player)
	end
end,

---------------------------------------------------------------------------------------------------------------------------------------

shopClick = function(player, target)

	local npc = core

	player:freeAsync()
	vending_menu.showShop(player, target, npc)

end,


showShop = async(function(player, target, npc)


	player.dialogType = 0
	local vending, info = "<b>["..target.name.."'s shop]\n\n", ""
	local items, amount, price, icon, choice = {}, {}, {}, {}, {}
	local item, qty, sell = 0, 0, 0
	
	if target.registry["v_open"] > 0 and target:hasDuration("vending_menu") and target.state == 4 then
		if totalSaleItem(target) == 0 then
			target:setDuration("vending_menu", 0)
			target:popUp(vending.."Sorry, no item left in your "..target:getEquippedItem(EQ_MANTLE).name.." to being sold!")
		return else repeat
			for i = 1, target.registry["max_vending_slots"] do
				if target.registry["v_item"..i] > 0 and target.registry["v_amount"..i] > 0 and target.registry["v_sellprice"..i] >= 0 then
					table.insert(choice, i.." - "..Item(target.registry["v_item"..i]).name.." ("..target.registry["v_amount"..i]..") - "..format_number(target.registry["v_sellprice"..i]).." c")			
				end
			end

			menu = player:menuString(vending.."> "..target.name.."'s Shop\n\n\nTotal sale items ("..totalSaleItem(target).."/"..target.registry["max_vending_slots"]..")", choice)
			
			for x = 1, target.registry["max_vending_slots"] do
				if menu == x.." - "..Item(target.registry["v_item"..x]).name.." ("..target.registry["v_amount"..x]..") - "..format_number(target.registry["v_sellprice"..x]).." c" then
					slot, item, qty, sell = x, target.registry["v_item"..x], target.registry["v_amount"..x], target.registry["v_sellprice"..x]
					info = "Item Name  : "..Item(item).name.."\nQuantity   : "..qty.." pcs\nSell price : "..format_number(sell).." coins\n"
					icon = {g = Item(item).icon, c = Item(item).iconC}
					player.npcGraphic = icon.g
					player.npcColor = icon.c
					player.dialogType = 0
					conC = {"Buy - ("..format_number(sell).." c)", "Cancel"}
					con = player:menuSeq(vending..""..info.."\nBuy this item from "..target.name.."?", conC, {})
					if con == 1 then
						if target.registry["v_item"..slot] == item and target.registry["v_amount"..slot] == qty and target.registry["v_sellprice"..slot] == sell then
							if player.m == target.m and target.registry["v_open"] > 0 and target:hasDuration("vending_menu") then
								if not player:hasSpace(item, qty) then
									player:dialogSeq({icon, vending.."You don't have enough space in your inventory!"})
								return false else
									if player.money < sell then
										player:dialogSeq({icon, vending..""..info.."\nYou don't have enough money for this!"})
									return false else
										vending_menu.transaction(player, target, slot, item, qty, sell)
									end
								end
							end
						else
							player:dialogSeq({icon, name.."Sorry, but this item is already sold out/removed by target."}, 1)
							vending_menu.shopClick(player, target, core)
						end
					return else
						return false
					end
				end
			end until (false)
		end
	end
end),

transaction = function(player, target, s, i, a, p)

	local name, mail, info = "<b>["..target.name.."'s shop]\n\n", "", "Item Name  : "..Item(i).name.."\nQuantity   : "..a.." pcs\nSell price : "..format_number(p).." coins\n"
	local icon = {graphic = Item(i).icon, color = Item(i).iconC}
	player.npcGraphic = icon.graphic
	player.npcColor = icon.color
	player.dialogType = 0
	
	local buyerText = {"===============[ Transaction Info ]===============",
				   "Seller       : "..target.name.."",
				   "Item name    : "..Item(i).name.."",
				   "Quantity     : "..a.." pcs.",
				   "Price        : "..format_number(p).." coins.",
				   "-------------------------------------------------------"}
	local sellerText = {"[Vending] Your item has been sold!! -> "..Item(i).name.." ("..a..") - "..format_number(p).." coins",
						"[Vending] You earn "..format_number(p).." coins! Check your N-mail for details & transaction info."}
	if target.registry["v_item"..s] == 0 and target.registry["v_amount"..s] == 0 and target.registry["v_sellprice"..s] == 0 then
		player:dialogSeq({icon, name.."Sorry, but this item is already sold out/removed by target."})
	return else
		if target.registry["v_open"] > 0 and target:hasDuration("vending_menu") then
			if player.m == target.m and target.state == 4 then
				if target.registry["v_item"..s] == i and target.registry["v_amount"..s] == a and target.registry["v_sellprice"..s] == p then
					if player:removeGold(p) == true then
						player:sendMinitext("Pay "..format_number(p).." coins")
						player:addItem(i, a)
						target:addGold(p)
						for i = 1, #buyerText do player:msg(0, buyerText[i], player.ID) end
						for i = 1, #sellerText do target:msg(0, sellerText[i], target.ID) end
						mail =       "===[ Vending Transaction Info ]===\n"
						mail = mail.."==================================\n"
						mail = mail.."Item        : "..Item(i).name.."\n"
						mail = mail.."Quantity    : "..a.." pcs\n"
						mail = mail.."sell price  : "..format_number(p).." coins\n"
						mail = mail.."Buyer       : "..player.name.."\n"
						mail = mail.."==================================\n"
						mail = mail.."Location, Date & Time : \n"
						mail = mail..""..target.mapTitle.."(X: "..target.x..", y: "..target.y.."), "..os.date().."\n"
						player:sendMail(target.name, "Transaction Info", mail.."")
						vending_menu.edit(target, s, 0, 0, 0)
						player:dialogSeq({icon, name..""..info.."You've successfully purchased this item!"})
					end
				end
			end
		return else
			player:dialogSeq({icon, name.."Sorry, you cannot buy this item, the shop are closed!"})
		end
	end
end,


---------------------------------------------------------------------------------------------------------------------------------------

vendingCostume = function(player)

	local weap = player:getEquippedItem(EQ_WEAP)
	local coat = player:getEquippedItem(EQ_COAT)
	local armor = player:getEquippedItem(EQ_ARMOR)
	local helm = player:getEquippedItem(EQ_HELM)
	local crown = player:getEquippedItem(EQ_CROWN)
	local cape = player:getEquippedItem(EQ_MANTLE)
	local shield = player:getEquippedItem(EQ_SHIELD)
	local boots = player:getEquippedItem(EQ_BOOTS)
	local facea = player:getEquippedItem(EQ_FACEACC)
	local neck = player:getEquippedItem(EQ_NECKLACE)
	
	if helm ~= nil then player.gfxHelm = helm.look player.gfxHelmC = helm.lookC else player.gfxHelm = 65535 end
	if crown ~= nil then player.gfxCrown = crown.look player.gfxCrownC = crown.lookC else player.gfxCrown = 65535 end
	if facea ~= nil then player.gfxFaceA = facea.look player.gfxFaceAC = facea.lookC else player.gfxFaceA = 65535 end
	if weap ~= nil then player.gfxWeap = weap.look player.gfxWeapC = weap.lookC else player.gfxWeap = 65535 end
	if shield ~= nil then player.gfxShield = shield.look player.gfxShieldC = shield.lookC else player.gfxShield = 65535 end
	if cape ~= nil then player.gfxCape = cape.look player.gfxCapeC = cape.lookC else player.gfxCape = 65535 end
	if neck ~= nil then player.gfxNeck = neck.look player.gfxNeckC = neck.lookC else player.gfxNeck = 65535 end
	if armor ~= nil then 
		player.gfxArmor = armor.look 
	else
		player.gfxArmor = player.sex
	end
	if coat ~= nil then player.gfxArmor = coat.look player.gfxArmorC = coat.lookC end
	player.gfxName = player.title.." "..player.name
	player.gfxFace = player.face
	player.gfxFaceC = player.faceColor
	player.gfxHair = player.hair
	player.gfxHairC = player.hairColor
	player.gfxSkinC = player.skinColor
	player.gfxArmorC = player.armorColor
	player.gfxDye = player.armorColor
	--player.gfxHelm = 65535
	player.gfxFaceAT = player.faceAccessoryTwo
	player.gfxFaceATC = player.faceAccessoryTwoColor

	player.gfxClone = 1
	player:updateState()
end,

randomCostume = function(player)

	local cape = player:getEquippedItem(EQ_MANTLE)
	local boy = {171, 173, 181, 183, 185, 187, 189, 191}
	local girl = {172, 174, 182, 184, 186, 188, 190, 192}
	player.gfxFaceAT = 65535
	player.gfxFaceA = 65535
	player.gfxNeck = 65535
	player.gfxCoat = 65535
	player.gfxShield = 65535
	player.gfxCrown = 65535
	player.gfxWeap = 65535
	player.gfxFace = player.face
	player.gfxFaceC = player.faceColor
	player.gfxHair = player.hair
	player.gfxHairC = player.hairColor
	player.gfxDye = player.armorColor
	player.gfxSkinC = player.skinColor
	player.gfxHelm = 255
	if cape ~= nil then
		player.gfxCape = cape.look
		player.gfxCapeC = cape.lookC
	end
	if player.sex == 0 then
		player.gfxArmor = boy[math.random(#boy)]
	elseif player.sex == 1 then
		player.gfxArmor = girl[math.random(#girl)]
	end
	player.gfxClone = 1
	player:updateState()
end,

randomStall = function(player)
	
--	local stalls = {301} --301, 876, 877, --new client only: 1737, 1738, 1787, 1788, 1853, 1854
	
	if player.sex == 0 then 
		player.disguise = 301
	elseif player.sex == 1 then
		player.disguise = 876
	end
--	player.disguise = stalls[math.random(#stalls)]
	player.state = 4
	player:updateState()
	
end,


logout = function(player)

	player.gfxClone = 0
	player:updateState()
	player.registry["v_open"] = 0
	player:setDuration("vending_menu", 0)
end,

checkItem = function(player, item)
	
	local name, qty = {}, {}
	local check = false
	local has = false
	local capeName = {"vending_ransel", "vending_cart", "vending_troly"}
	local cape = player:getEquippedItem(EQ_MANTLE)

	for i = 1, player.registry["max_vending_slots"] do
		if player.registry["v_item"..i] > 0 then
			table.insert(name, Item(player.registry["v_item"..i]).yname)
			table.insert(qty, player.registry["v_amount"..i])
		end
	end	
	if cape ~= nil then
		for i = 1, #capeName do
			if cape.yname == capeName[i] then check = true end
		end
	end
	for i = 1, #capeName do
		if player:hasItem(capeName[i], 1) == true then check = true end
	end
	if check == true then
		if #name > 0 then
			for i = 1, #name do
				if name[i] == item then
					has = true
				end
			end
		end
	end
	return has
end,
}
	
	
	
	
totalSaleItem = function(player)
	
	local total = 0
	local items = {}
	for i = 1, player.registry["max_vending_slots"] do
		if player.registry["v_item"..i] > 0 and player.registry["v_amount"..i] > 0 and player.registry["v_sellprice"..i] >= 0 then table.insert(items, i) end
	end
	if #items > 0 then total = #items end

return total end