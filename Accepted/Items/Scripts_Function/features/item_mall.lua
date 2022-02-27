

item_mall = {

dialog = function(player, text)
	
	local d
	d = "What "..text.." would you like to wear today?\n\n"
	d = d.."Event points : "..format_number(player.ep).." EP\n"
	d = d.."Lapis  : "..format_number(player.lapis).." Lapis\n"
	d = d.."Fame points  : "..format_number(player.fp).." FP\n"
return d end,


browse = function(player, item, amount)

	local amount = tonumber(amount - 1)
	local id = Item(item).id
	local items = {}
	local opts = {}
	
	for found = id, id + amount do
		table.insert(items, found)
		table.insert(opts, Item(found).name.." [PP: "..format_number(Item(found).price).."] | Fame: +"..math.abs(math.ceil(Item(found).price/1000)).."]")
	end
	if Item(items[1]).type == 16 then
		text = "Clothes"
	elseif Item(items[1]).type == 18 then
		text = "Hand accessory"
	end
	dialog = item_mall.dialog(player, text)
	menu = player:menuSeq(dialog, opts, {})
	
	for i = 1, #items do
		if menu == i then
			item_mall.choice(player, items[i])
		end
	end
end,

choice = function(player, id)

	local text, look, color

	if Item(id).type == 16 then
		text = "Clothes"
		look = player.gfxArmor
		color = player.gfxArmorC
	elseif Item(id).type == 18 then
		text = "Hand accessory"
		look = player.gfxWeap
		color = player.gfxWeapC
	end
	local dialog = item_mall.dialog(player, text)
	local opts = {"Try it (Free)", "Buy permanent [PP: "..format_number(Item(id).price).." | Fame: +"..math.abs(math.ceil(Item(id).price/1000)).."]", "Exit"}

	menu = player:menuSeq(dialog, opts, {})
	
	if menu == 1 then
		if player.gfxClone == 0 then clone.equip(player, player) else clone.gfx(player, player) end
		if Item(id).type == 16 then
			player.gfxArmor = Item(id).look
			player.gfxArmorC = Item(id).lookC
		elseif Item(id).type == 18 then
			player.gfxWeap = Item(id).look
			player.gfxWeapC = Item(id).lookC
		end
		if Item(id).id >= 300015 and Item(id).id <= 300027 then
			player.registry["use_scythe"] = 1
		end
		player.gfxClone = 1
		player:updateState()
		player:popUp("You got 5 minutes to try")
		
	elseif menu == 2 then
		if player.lapis < Item(id).price then
			player:popUp("You don't have enough Lapis")
		return else
			howC = {"Just buy, it's for my self", "As a gift for someone", "Cancel"}
			how = player:menuSeq("How do you want to buy "..Item(id).name.."?", howC, {})
			if how == 1 then
				local fp = math.abs(math.ceil(Item(id).price/1000))
				item_mall.info(player,Item(id).name, Item(id).price, fp)
				player.lapis = player.lapis - Item(id).price
				player.fp = player.fp + fp
				player:addItem(id, 1)

			elseif how == 2 then
				target = player:input("Enter the name of target : ")
				if Player(target) ~= nil then
					local fp = Item(id).price/1000
					confirmC = {"Give the item to "..Player(target).name.." but Fame for my self!", "Give both (Item & Fame) to "..Player(target).name, "Cancel"}
					confirm = player:menuSeq("Do you really want to give "..Item(id).name.." with price "..format_number(Item(id).price).." PP, and give "..fp.." FP to "..Player(target).name.."?\n\n<b>NOTE:\nThere's no refund no matter what!", confirmC, {})
					if Player(target).m ~= player.m then
						player:popUp(Player(target).name.." is not here..")
					return else
						if confirm ~= 3 then
							item_mall.info(player,Item(id).name, Item(id).price, fp, Player(target))
							player.lapis = player.lapis - Item(id).price
							if confirm == 1 then
								player.fp = player.fp + fp
							elseif confirm == 2 then
								Player(target).fp = Player(target).fp + fp
							end
							Player(target):addItem(id, 1)
							Player(target):sendAnimation(348)
						end
					end
				return else
					player:popUp("User not found!")
				end
			end	
		end
	elseif menu == 3 then
		return
	end
end,

info = function(player, item, price, fame, target)

	if player.lapis < price then return end
	local text
	text =         "<b>            [mYnexia Mall]\n\n"
	text = text.."----------------------------------------\n\n"
	if target == nil then
		text = text.."Item cost   : "..format_number(price).." ( Fame: +"..fame..")\n"
	else
		text = text.."Item cost   : "..format_number(price).." ( Fame: +"..fame.." for "..target.name..")\n"
	end	
	text = text.."Play Point  : "..format_number(player.lapis).."\n"
	text = text.."Event Point : "..format_number(player.ep).."\n\n"
	text = text.."Pay With Play Point  ("..format_number(player.lapis).." - "..format_number(price)..")\n"
	text = text.."Current Play Point  = "..format_number(player.lapis - price).."\n\n"
	text = text.."----------------------------------------\n\n"
	text = text.."        Thank You for shopping\n"
	
	player:sendAnimation(348)
	player:playSound(67)
	player:popUp(text)
end,

deposit = function(player, npc)
	
	local inven, items = {}, {}
	local max = player.registry["max_wardrobe"]
	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	
	for i = 1, max do
		if player.registry["wardrobe"..i] > 0 then table.insert(items, i) end
	end
	
--	if total >= max then player:dialogSeq({t, "<b>[Wardrobe]\n\nSorry, your wardrobe is full!\n\n\nWardrobe space: "..total.."/"..max}) return end
	for i = 0, player.maxInv do
		id = player:getInventoryItem(i)
		if id ~= nil then
			if id.type >= 12 and id.type <= 16 then
				table.insert(inven, id.id)
			end
		end
	end
	if #inven == 0 then
		player:dialogSeq({t, "<b>[Wardrobe]\n\nYou don't have any item mall to deposit!"})
		return
	end
	
	local ask = player:sell("<b>[Wardrobe]\n\nWhat item do you want to deposit?\n\nWardrobe space: "..#items.."/"..max, inven)
	local choice = player:getInventoryItem(ask - 1)
	if choice == nil then return false end
	if amount == 0 then return false end
	if choice.maxAmount > 1 and choice.amount > 1 then return false end
	if choice.depositable then player:dialogSeq({t, "<b>[Wardrobe]\n\nYou cannot deposit this item!"}) return false end
	
	for i = 1, max do
		if player.registry["wardrobe"..i] == 0 then
			if player:hasItem(choice.id, 1) == true then
				player.registry["wardrobe"..i] = choice.id
				player:removeItem(choice.id, 1)
				item_mall.deposit(player, npc)
				return
			end
		end
	end
end,
			
withdraw = function(player, npc)

	local item
	local amount, stuff = {}, {}
	local max = player.registry["max_wardrobe"]
	local t = {graphic = player.npcGraphic, color = player.npcColor}
	player.dialogType = 0

	for i = 1, max do
		if player.registry["wardrobe"..i] > 10 then
			item = Item(player.registry["wardrobe"..i])
			if item.type >= 12 and item.type <= 14 or item.type == 16 then
				table.insert(stuff, item.id)
			end
		end
	end
	if #stuff > 0 then
		for i = 1, #stuff do
			table.insert(amount, 1)
		end
	end
	local ask = player:buy("<b>[Wardrobe]\n\nWhat item would you withdraw?\n\nWardrobe space: "..#stuff.."/"..max, stuff, amount, {}, {})
	for i = 1, #stuff do
		if stuff[i] == ask then x = i break end
	end
	if x == 0 then return nil end
	for i = 1, max do
		if Item(stuff[x]).id == player.registry["wardrobe"..i] then
			if player:hasSpace(Item(stuff[x]).id, 1) == true then
				player.registry["wardrobe"..i] = 0
				player:addItem(Item(stuff[x]).id, 1)
				item_mall.withdraw(player, npc)
			return else
				player:dialogSeq({t, "<b>[Wardrobe]\n\nYou don't have enough space in your inventory!"})
			end
		end
	end
end
}


-- Garnet		- brown red
-- Amethyst		- purple
-- Aquamarine	- light blue
-- Diamond		- white
-- Emerald		- green
-- Alexandrite	- light purple
-- Ruby			- red
-- Peridot		- light green
-- Sapphire		- blue
-- Tourmaline	- pink magenta
-- Topaz		- yellow
-- Turquiose 	- blue green
-- 
-- Onyx			- black
-- Indigo		- dark purple
-- Amber		- yellow orange gold




























