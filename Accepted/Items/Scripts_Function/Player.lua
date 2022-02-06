
mathRandom = function(start, stop, precision) return math.random(start * precision, stop * precision) / precision end

--Damage formulas
function Player.addHealthExtend(player, amount, sleep, deduction, ac, ds, print)
	local healer
	local ded = 0
	
	if (player.state == 1) then return end
	if (player.attacker >= 1073741823) then
		healer = Mob(player.attacker)
	elseif (player.attacker > 0) then
		healer = Player(player.attacker)
	end
	
	ded = 1 * string.format("%.2f", player.armor / (player.armor + 400 + 95 * (healer.level + healer.tier^2 + healer.mark^3)))
	
	if (sleep > 0 and print == 2) then
		amount = amount * player.sleep
	elseif (sleep == 1) then
		amount = amount * player.sleep
		player.sleep = 1
		player:updateState()
	elseif (sleep == 2) then
		amount = amount * player.sleep
	end
	
	if (deduction == 1) then
		if (player.deduction < 0) then
			amount = 0
		elseif (player.deduction > 0) then
			amount = amount * player.deduction
		end
	end
	
	if (ac == 1) then
		if (ded < .85) then
			amount = amount * (1 - ded)
		else
			amount = amount * .15
		end
	end
	
	if (ds > 0 and print == 2) then
		amount = amount - player.dmgShield
	elseif (ds == 1) then
		if (player.dmgShield > 0) then
			if (player.dmgShield > amount) then
				player.dmgShield = player.dmgShield - amount
				amount = 0
			else
				amount = amount - player.dmgShield
				player.dmgShield = 0
			end
		else
			amount = amount - player.dmgShield
			player.dmgShield = 0
		end
	elseif (ds == 2) then
		player.dmgShield = player.dmgShield - amount
	end
	
	amount = -amount
	
	if (healer ~= nil) then
		healer.damage = amount
		healer.critChance = 0
	else
		player.damage = amount
		player.critChance = 0
	end
	
	if (print == 1) then
		if (player.health - amount > player.maxHealth) then
			player.health = player.maxHealth
			player:updateState()
		else
			player.health = player.health - amount
			player:sendStatus()
		end
	elseif (print == 2) then
		return amount
	else
		player_combat.on_healed(player, healer)
		player:sendStatus()
	end
end

powerBoard = function(player,target)
	if((player.m ~= 1 and player.gmLevel < 50) or (player.m == 7001 and player.registry["arenaHost"] == 0 and player.gmLevel < 50)) then
		player:sendMinitext("You may not call for powerboards on this map.")
		return
	end
	if(target~=nil) then
		if(player.pbColor==60 or player.pbColor==61 or player.pbColor==63 or player.pbColor==65 or player.pbColor==0 or player.gmLevel==99) then
			target.armorColor=player.pbColor
			target:updateState()
		end
	end
	player:powerBoard()
	--use player.pbColor for the color to change
	--also, set the armorColor yourself, and udpate their state
end


function Player.heal(player, amount)

	amount = math.abs(math.ceil(tonumber(amount)))
	if player.state == 1 then return false end
	if player.health + amount > player.maxHealth then
		player.health = player.maxHealth
	end
	
return end	



function Player.removeHealthWithoutDamageNumbers(player, amount, type)
	
	local temp_health = 0
	
	temp_health=player.health-amount
	if temp_health <= 0 then temp_health = 0 end
	player.health = temp_health
	
	if (player.attacker >= 1073741823) then
		Mob(player.attacker).damage = amount
		Mob(player.attacker).critChance = type
	elseif (player.attacker > 0) then
		Player(player.attacker).damage = amount
		Player(player.attacker).critChance = type
	else
		player.damage = amount
		player.critChance = type
	end
	if (player.health == 0) then onDeathPlayer(player) else player:sendStatus() end
end

function Player.addHealth2(player, amount,type)

	local temp_health, temp_amount, change_health
	change_health = player.health
	temp_health = player.health+amount

	if temp_health > player.maxHealth then player.health = player.maxHealth else player.health = temp_health end
	if temp_health > (math.pow(256, 4) -1) then player.health = player.maxHealth end
	if player.health == change_health then return false end

	player:sendStatus()
end



function Player.removeHealthExtend(player, amount, sleep, deduction, ac, ds, print)
	local attacker
	local ded = 0
	
	if (player.attacker >= 1073741823) then
		attacker = Mob(player.attacker)
	elseif (player.attacker > 0) then
		attacker = Player(player.attacker)
	end
	
	ded = 1 - ((player.armor * acPerArmor) / 100)
	
	
	if (sleep > 0 and print == 2) then
		amount = amount * player.sleep
	elseif (sleep == 1) then
		amount = amount * player.sleep
		player.sleep = 1
		player.updateState()
	elseif (sleep == 2) then
		amount = amount * player.sleep
	end
	
	if (deduction == 1) then
		if (player.deduction < 0) then
			amount = 0
		elseif (player.deduction > 0) then
			amount = amount * player.deduction
		end
	end
	
	if (ac == 1) then
		if (ded > .15) then
			amount = amount * ded
		else
			amount = amount * .15
		end
	end
	
	if (ds > 0 and print == 2) then
		amount = amount - player.dmgShield
	elseif (ds == 1) then
		if (player.dmgShield > 0) then
			if (player.dmgShield > amount) then
				player.dmgShield = player.dmgShield - amount
				amount = 0
			else
				amount = amount - player.dmgShield
				player.dmgShield = 0
			end
		else
			amount = amount - player.dmgShield
			player.dmgShield = 0
		end
	elseif (ds == 2) then
		player.dmgShield = player.dmgShield - amount
	end
	
	if (attacker ~= nil) then
		attacker.damage = amount
		attacker.critChance = 0
	else
		player.damage = amount
		player.critChance = 0
	end
	
	if (print == 1) then
		player:removeHealth(amount)
		--if (player.health - amount <= 0) then
		--	player.health = 0
		--	player.state = 1
		--	player:updateState()
		--else
		--	player.health = player.health - amount
		--	player:sendStatus()
		--end
	elseif (print == 2) then
		return amount
	else
		player_combat.on_attacked(player, attacker)
		player:sendStatus()
	end
end

function Player.addMagic(player, amount)
	
	local magic = player.magic + amount
	if (amount < 0) then player:sendMinitext("This is using a wrong function. Please ticket our staff!") return end
	if (magic > player.maxMagic) then player.magic = player.maxMagic else player.magic = magic end
	player:sendStatus()
end

function Player.removeMagic(player, amount)
	
	local magic = player.magic - amount
	if (amount < 0) then player:sendMinitext("This is using a wrong function! Please ticket our staff!") return end
	if (magic < 0) then player.magic = 0 else player.magic = magic end
	player:sendStatus()
end

function Player.addMagicExtend(player, amount)
	
	local temp_magic
	local ded = 0
	
	ded = 1 * string.format("%.2f", player.armor / (player.armor + 400 + 95 * (attacker.level + attacker.tier^2 + attacker.mark^3)))

	if(player.sleep ~= nil) then amount = amount * player.sleep end
	if(player.deduction > 0) then amount = amount * player.deduction end
	if (ded < .85) then amount = amount * (1 - ded) else amount = amount * .15 end
	
	temp_magic = player.magic + amount
	if(player.magic < amount or temp_magic <= 0) then player.magic = 0 end
	if temp_magic > player.maxMagic then player.magic = player.maxMagic else player.magic = temp_magic end
	if temp_magic > (math.pow(256, 4) -1) then player.magic = player.maxMagic end
	player:sendStatus()
end

function Player.addShield(player, shielding, maxShield)
	
	local shield = player.dmgShield
	
	if (maxShield == nil or maxShield > player.maxHealth * .5) then maxShield = player.maxHealth * .5 end
	if (shield + shielding > maxShield) then player.dmgShield = maxShield else player.dmgShield = shield + shielding end
end

function Player.removeShield(player, unshielding, negative)
	
	local shield = player.dmgShield
	
	if (negative == nil and shield - unshielding < 0) then player.dmgShield = 0 else player.dmgShield = shield - unshielding end
end

--Dialogs and menus
function Player.dialogSeq(player, commands, continue)
	
	local pos = 1
	local messages, state, options = { }, {graphic = player.npcGraphic, color = player.npcColor}, {}
	
	for _, command in pairs(commands) do
		if type(command) == "table" then
			state.graphic = command.graphic
			state.color = command.color
		elseif type(command) == "string" then
			table.insert(messages, {graphic = state.graphic, color = state.color, text = command})
		end
	end

	
	while pos <= #messages do
		if pos ~= 1 then table.insert(options, "previous") end
		if pos ~= #messages then table.insert(options, "next") end
		if pos == #messages and continue == 1 then table.insert(options, "next") end
		


		
		player.npcGraphic = messages[pos].graphic
		player.npcColor = messages[pos].color
		

		
		if ((messages[pos].graphic == 0 or messages[pos].graphic == 32768) and messages[pos].color == 0) then player.dialogType = 1  else player.dialogType = 0 end


		
		local choice = player:dialog(messages[pos].text, options)
		
		if(choice == "next") then pos = pos + 1 end
		if(choice == "previous") then pos = pos - 1 end
		if(choice == "quit") then return false end
	end
	return true
end

function Player.menuString(player, message, options)
	
	if (options == nil) then options = {} end
	selection = player:menu(message, options)
	
	return options[selection]
end

function Player.menuString2(player, message, options)
	
	if (options == nil) then options = {} end
	selection = player:menu(message, options)
	
	return options[selection]
end

function Player.buyDialog(player, dialog, items)
	
	local amount={}
	for x=1,#items do table.insert(amount,Item(items[x]).price) end
	local temp=player:buy(dialog,items,amount,{},{})

	return temp, Item(temp).price
end

function Player.showClanBank(player, dialog)
	
	local name = "<b>[CLAN BANK]\n\n"
	local bankItemTable = player:getClanItems()
	local bankCountTable = player:getClanAmounts()

	local found, amount, counter = 0, 0, 0
	local next = next
	
	for i = 1, #bankItemTable do
		if (bankItemTable[i] == 0) then
			counter = #bankItemTable
			for j = i, counter do
				table.remove(bankItemTable, i)
				table.remove(bankCountTable, i)
			end
			break
		end
	end
	
	if (next(bankItemTable) == 0) then player:dialogSeq({name.."Your Clan Bank is empty!"}) return false end
	
	local temp = player:buy(name..""..dialog, bankItemTable, bankCountTable, {}, {})

	for i = 1, 255 do
		if (bankItemTable[i] == temp) then found = i break end
	end
	if (found == 0) then return nil end
	if (Item(bankItemTable[found]).maxAmount > 1) then
		amount = tonumber(player:input(name.."How many you want to take?"))
		amount = math.ceil(math.abs(amount))
		if (amount > bankCountTable[found]) then amount = bankCountTable[found] end
	else
		amount = 1
	end
	if (amount <= 0) then return false end
	if (player:hasSpace(bankItemTable[found], amount) ~= true) then
		player:dialogSeq({name.."You do not have enough inventory slots for that"})
		return false
	end

	local worked = player:addItem(bankItemTable[found], amount, 0)
	if worked == true then
		player:clanBankWithdraw(bankItemTable[found], amount)
		player:showClanBank(dialog)
	return elseif worked == false then
		player:dialogSeq({name.."You cannot withdraw "..amount.." "..Item(bankItemTable[found]).name.."."})
	end
	
return true end

function Player.showClanBankAdd(player)
	
	local name = "<b>[CLAN BANK]\n\n"
	local amountCheck, amount, found = 0, 0, 0
	local itemTable = {}
	
	for i = 0, player.maxInv do
		local nItem = player:getInventoryItem(i)
		
		if (nItem ~= nil and nItem.id > 0) then
			if (#itemTable > 0) then found = 0
				for j = 1, #itemTable do
					if (itemTable[j] == nItem.id) then found = 1 break end
				end
				if (found == 0) then table.insert(itemTable, nItem.id) end
			else
				table.insert(itemTable, nItem.id)
			end
		end
	end
	
	local choice = player:sell(name.."What do you want to deposit?", itemTable)
	local dItem = player:getInventoryItem(choice - 1)
	
	if (dItem == nil) then return end
	if (dItem.depositable) then player:dialogSeq({name.."You cannot deposit that item"}) return false end
	
	if (dItem.realName ~= "" or dItem.customLook ~= 0 or dItem.customIcon ~= 0) then
	player:popUp("Sorry you cannot deposit engraved or skinned items.")
	return
	end
	

	for i = 11, 16 do
		if dItem.type ~= 14 and dItem.type ~= 15 then
			if dItem.type == i then
				player:dialogSeq({name.."You cannot deposit that item. Please put it in your wardrobe."})
				return
			end
		end
	end

	if (dItem.maxAmount > 1 and dItem.amount > 1) then
		amount = math.abs(tonumber(math.floor(player:input(name.."How many you want to deposit?"))))

		if (player:hasItem(dItem.id, amount) ~= true) then
			amountCheck = player:hasItem(dItem.id, amount)
			amount = amountCheck
		end
	else
		amount = 1
	end
	if (amount == 0) then player:dialogSeq({name.."?????"}) return false end
	if (dItem.dura == dItem.maxDura) then
		local moneyAmount = 0
		local moneyChoice = ""
				
		if amount > 1 then
			moneyChoice = player:menuString(name.."You want me to hold your "..amount.." "..dItem.name.."?", {"Yes", "No"})

		else
			moneyChoice = player:menuString(name.."You want me to hold your "..dItem.name.."?", {"Yes", "No"})

		end		
		if (moneyChoice == "Yes") then
			if (player:hasItem(dItem.id, amount) == true) then
				if (player.money >= moneyAmount) then
					player.money = player.money - moneyAmount
					player:clanBankDeposit(dItem.id, amount)
					if (amount == 1) then player:removeItemSlot((choice - 1), amount, 2) else player:removeItem(dItem.id, amount, 2) end	
					player:sendStatus()
					player:showClanBankAdd()
				else
					player:dialogSeq({name.."You don't have enough money"})
					return false
				end
			else
				player:dialogSeq({name.."You don't have that many!"})
				return false
			end
		else
			return false
		end
	else
		player:dialogSeq({name.."Item must in perfect condition (100%)"})
		player:showClanBankAdd()
		return
	end
	
	return true
end

function Player.showBank(player, dialog)
	
	local name = "<b>[Storage]\n\n"
	local bankItemTable = player:checkBankItems()
	local bankCountTable = player:checkBankAmounts()
	local bankOwnerTable = player:checkBankOwners()
	local bankEngraveTable = player:checkBankEngraves()
	local bankLooksTable = player:checkBankLooks()	
	local bankLookColorsTable = player:checkBankLookColors()
	local bankIconsTable = player:checkBankIcons()
	local bankIconColorsTable = player:checkBankIconColors()



	local found, amount, counter = 0, 0, 0
	local next = next
	
	for i = 1, #bankItemTable do
		if (bankItemTable[i] == 0) then
			counter = #bankItemTable
			for j = i, counter do
				table.remove(bankItemTable, i)
				table.remove(bankCountTable, i)
				table.remove(bankOwnerTable, i)
				table.remove(bankEngraveTable, i)
				table.remove(bankLooksTable, i)
				table.remove(bankLookColorsTable, i)
				table.remove(bankIconsTable, i)
				table.remove(bankIconColorsTable, i)					

				end
			break
		end
	end
	


	if (next(bankItemTable) == 0) then player:dialogSeq({name.."Your Storage is empty!"}) return false end
	
	local temp = player:buy(name..""..dialog, bankItemTable, bankCountTable, bankEngraveTable, bankLooksTable, bankLookColorsTable, bankIconsTable, bankIconColorsTable)
	
	for i = 1, 255 do
		if (bankItemTable[i] == temp) then found = i break end
	end
	if (found == 0) then return nil end

	
	if (Item(bankItemTable[found]).maxAmount > 1) then
		amount = tonumber(player:input(name.."How many you want to take?"))
		amount = math.ceil(math.abs(amount))
		if (amount > bankCountTable[found]) then amount = bankCountTable[found] end
	else
		amount = 1
	end
	
	if (amount <= 0) then return false end
	if (player:hasSpace(bankItemTable[found], amount, bankOwnerTable[found], bankEngraveTable[found]) ~= true) then
		player:dialogSeq({name.."You do not have enough inventory slots for that"})
		return false
	end
	
	
	local worked = player:addItem(bankItemTable[found], amount, 0, bankOwnerTable[found], bankEngraveTable[found])
	
	if worked == true then
		player:bankWithdraw(bankItemTable[found], amount, bankOwnerTable[found], bankEngraveTable[found])
		player:showBank(dialog)
	return elseif worked == false then
		player:dialogSeq({name.."You cannot withdraw "..amount.." "..Item(bankItemTable[found]).name.."."})
	end
	
return true end

function Player.showBankAdd(player)
	
	local name = "<b>[Storage]\n\n"
	local amountCheck, amount, found = 0, 0, 0
	local itemTable = {}
	
	for i = 0, player.maxInv do
		local nItem = player:getInventoryItem(i)
		
		if (nItem ~= nil and nItem.id > 0) then
			if (#itemTable > 0) then found = 0
				for j = 1, #itemTable do
					if (itemTable[j] == nItem.id) then found = 1 break end
				end
				if (found == 0) then table.insert(itemTable, nItem.id) end
			else
				table.insert(itemTable, nItem.id)
			end
		end
	end
	

	local choice = player:sell(name.."What do you want to deposit?", itemTable)
	local dItem = player:getInventoryItem(choice - 1)
		

	if (dItem == nil) then return end
	
	if dItem.realName ~= "" or dItem.customLook ~= 0 or dItem.customIcon ~= 0 then
		player:dialogSeq({name.."You cannot deposit engraved or skinned items"}) return end
	

	if (dItem.depositable) then player:dialogSeq({name.."You cannot deposit that item"}) return false end
	
	
--	for i = 11, 16 do
--		if dItem.type ~= 14 and dItem.type ~= 15 then
--			if dItem.type == i then
--				player:dialogSeq({name.."You cannot deposit that item. Please put it in your wardrobe."})
--				return
--			end
--		end
--	end

	if (dItem.maxAmount > 1 and dItem.amount > 1) then
		amount = math.abs(tonumber(math.floor(player:input(name.."How many you want to deposit?"))))

		if (player:hasItem(dItem.id, amount) ~= true) then
			amountCheck = player:hasItem(dItem.id, amount)
			amount = amountCheck
		end
	else
		amount = 1
	end
	if (amount == 0) then player:dialogSeq({name.."?????"}) return false end
	if (dItem.dura == dItem.maxDura) then
		local moneyAmount = 0
		local moneyChoice = ""
		
		if amount > 1 then
			moneyChoice = player:menuString(name.."You want me to hold your "..amount.." "..dItem.name.."?", {"Yes", "No"})

		else
			moneyChoice = player:menuString(name.."You want me to hold your "..dItem.name.."?", {"Yes", "No"})

		end
		
		if (moneyChoice == "Yes") then
			if (player:hasItem(dItem.id, amount, dItem.owner, dItem.realName) == true) then
				if (player.money >= moneyAmount) then
					player.money = player.money - moneyAmount
					player:bankDeposit(dItem.id, amount, dItem.owner, dItem.realName)
					if (amount == 1) then player:removeItemSlot((choice - 1), amount, 2) else player:removeItem(dItem.id, amount, 2) end	
					player:sendStatus()
					player:showBankAdd()
				else
					player:dialogSeq({name.."You don't have enough money"})
					return false
				end
			else
				player:dialogSeq({name.."You don't have that many!"})
				return false
			end
		else
			return false
		end
	else
		player:dialogSeq({name.."Item must in perfect condition (100%)"})
		player:showBankAdd()
		return
	end
	
	return true
end

function Player.bankAddMoney(player)

	local name = "<b>[Bank]\n\n"
	local maxamount=(2^32) - 1
	local amount = player:input(name.."How much do you want to deposit?\n\nCurrent balance: "..player.bankMoney)
	amount=tonumber(math.ceil(math.abs(amount)))
	if(amount==0) then return false end
	if(amount>player.money) then amount = player.money end
	if(amount>maxamount) then amount = maxamount end
	if(player.bankMoney + amount > maxamount) then amount=maxamount-player.bankMoney end
	if(player.bankMoney == maxamount) then player:dialogSeq({name.."You don't have enough space in your bank!"}) end

	player.money=player.money-amount
	player.bankMoney=player.bankMoney+amount
	player:sendStatus()
	player:dialogSeq({name.."You have added "..amount.." coins to your account. Your new balance is "..player.bankMoney})
	return true
end

function Player.bankWithdrawMoney(player)
	
	local name = "<b>[Bank]\n\n"
	local inBank=player.bankMoney
	if(inBank<=0) then player:dialogSeq({name.."Sorry, but you don't have any money in your bank!"}) return end
	local amount = player:input(name.."How much do you want to withdraw?\n\nCurrent balance: "..player.bankMoney)
	amount=tonumber(math.ceil(math.abs(amount)))
	if (amount<=0) then return end
	if(amount>inBank) then amount=inBank end

	player.money=player.money+amount
	player.bankMoney=player.bankMoney-amount
	player:sendStatus()
	player:dialogSeq({name.."You have removed "..amount.." coins from your account. Your new balance is "..player.bankMoney})
end

function Player.sellExtend(player,dialog,items)

	local amount=1
	local choice=player:sell(dialog,items)

	local sell = player:getInventoryItem(choice-1)
	local sell_item = {id = sell.id, dura = sell.dura, maxDura = sell.maxDura, sell = sell.sell, name = sell.name, amount = sell.amount}
	if(sell_item.amount>1) then
		amount=math.abs(tonumber(math.ceil(player:input("How many do you want to sell?"))))

		if(amount>4000000000 or player:hasItem(sell_item.id,amount) ~= true) then player:sendMinitext("You can't do that.") return end
	else
		amount=1
	end
	if (sell.owner > 0 or sell.realName ~= "") then
		player:dialogSeq({"Sorry, but I won't buy that."})
		return
	end
	

	local duracheck=1
	if(sell_item.maxDura~=0) then
		local duraPct = (sell_item.dura / sell_item.maxDura)
		duracheck = duraPct
	end


	local choice=player:menuString("I will buy your " .. amount .. " " .. sell_item.name .. " for " .. format_number(math.floor(sell_item.sell*amount*duracheck)) .. " coins.  Deal?", {"Yes","No"})
	if(choice=="Yes") then
		if player:hasItem(sell_item.id, amount) == true then
			if player:removeItem(sell_item.id, amount) == true then

				player:logBuySell(sell_item.id,amount,sell_item.sell*amount,0)
				player.money = player.money + math.floor(sell_item.sell*amount*duracheck)
				local selltable = {sell_item.id, amount}
				player:sendMinitext("You earn "..format_number(math.floor(sell_item.sell*amount*duracheck)).." coins.")
	  			player:sendStatus()
				return selltable
			else
				player:popUp("Where did it go?")
			end
		else
			player:popUp("Where did it go?")
		end
	end
end

function Player.buyExtend(player,dialog,items,prices,maxamounts)

	if(items==nil) then items={ } end
	if(prices==nil) then prices={ } end
	local x=0
	local amount=1
	local t = {graphics = player.npcGraphic, color = player.npcColor}
	if #prices==0 then
		for i=1,#items do
			table.insert(prices,Item(items[i]).price)
		end
	end

	local choice=player:buy(dialog,items,prices,{},{})
	
	for i=1,#items do
		if(Item(items[i]).id==choice) then
			x=i
			break
		end
	end
	if(x==0) then return nil end
	amount=player:input("How many do you wish to buy?")
	amount = math.floor(amount * 1)
	
	if amount < 1 then
		player:popUp("Try using a real number!")
		return
	end
	
	if (maxamounts ~= nil and maxamounts[x] ~= nil and maxamounts[x] < amount) then
		player:dialog("Sorry, but i only can sell "..maxamounts[x].." more "..Item(choice).name.." to you.", t)
	end

	if(player.money<(prices[x]*amount)) then
		player:dialog("You don't have enough money!",{})
		return nil
	end
	--amount=math.abs(amount)
	local newChoice=player:menuString("The price of " .. amount .. " " .. Item(choice).name .. " is " .. format_number(prices[x]*amount) .. " coins. Do we have a deal?",{"Yes","No"})
	if(newChoice=="Yes") then
		if(player:hasSpace(Item(choice).name,amount) and (player.money>=(prices[x]*amount))) then
			player:logBuySell(Item(choice).id,amount,prices[x]*amount,1)
			player.money=player.money-(prices[x]*amount)
			local buytable = {Item(choice).id, amount}
			player:addItem(Item(choice).name,amount)
			player:sendMinitext("You pay "..format_number(prices[x]*amount).." coins.")
			player:sendStatus()
			return buytable
		else
			player:sendMinitext("Your inventory is full!")
		end
	end
end

function Player.repairExtend(player)

	local choice = 0
	local chosenItem = 0
	local chosenItemDura = 0

	local list = {}
	for i = 0, player.maxInv do
		item = player:getInventoryItem(i)
		if item ~= nil then
			if item.type >= 3 and item.type <= 15 then
				if item.dura < item.maxDura then
					table.insert(list, item.id)
				end
			end
		end
	end
	ask = player:sell("<b>[Repair]\n\nWhat item shall I repair?", list)
	choice = player:getInventoryItem(ask - 1)
	chosenItem = choice.id
	chosenItemDura = choice.dura
--player:talk(0,""..chosenItem)
	if choice ~= nil and choice.dura < choice.maxDura then
		icon = {graphic = choice.icon, color = choice.iconC}
		if choice.repairable == true then
			player:dialogSeq({icon, "<b>[Repair]\n\nSorry kid, but this item cannot be repaired!"})
			return
		end
		cost=math.ceil(((choice.price/choice.maxDura)*(choice.maxDura-choice.dura))*0.5)
		txt = "<b>[Repair]\n\n"
		txt = txt.."Item       : "..choice.name.."\n"
		txt = txt.."Durability : "..math.floor((choice.dura/choice.maxDura)*100).."%\n"
		txt = txt.."Cost       : "..math.floor(cost).." coins.\n\n"		
		player:dialogSeq({icon, txt}, 1)
		confirm = player:menuString("<b>[Repair]\n\nShall I fix it?", {"Yes", "No"})
		if confirm == "Yes" then
			if choice.id == chosenItem and choice.dura == chosenItemDura then
				if player:removeGold(cost) == true then
					choice.dura = choice.maxDura
					player:updateInv()
					player:sendMinitext("Finish repair and paid "..format_number(cost).." coins.")
				else
					player:dialogSeq({icon, txt.."Oh, you don't have enough money kid. Come back later."})
				end
			else
				player:dialogSeq({icon, txt.."Wait, that isn't right. Come back later."})
			end
		end
	end
end


function Player.repairAll(player,npc)

	--player:freeAsync()
	local cost=0
	local total=0
	
	local name = "<b>[Repair All]\n\n"

	local playerFaceAcc = player:getEquippedItem(EQ_FACEACC)
	local playerHelm = player:getEquippedItem(EQ_HELM)
	local playerCrown = player:getEquippedItem(EQ_CROWN)
	local playerWeapon = player:getEquippedItem(EQ_WEAP)
	local playerArmor = player:getEquippedItem(EQ_ARMOR)
	local playerShield = player:getEquippedItem(EQ_SHIELD)
	local playerLeft = player:getEquippedItem(EQ_LEFT)
	local playerRight = player:getEquippedItem(EQ_RIGHT)
	local playerMantle = player:getEquippedItem(EQ_MANTLE)
	local playerSubLeft = player:getEquippedItem(EQ_SUBLEFT)
	local playerSubRight = player:getEquippedItem(EQ_SUBRIGHT)
	local playerNecklace = player:getEquippedItem(EQ_NECKLACE)
	local playerBoots = player:getEquippedItem(EQ_BOOTS)
	local playerCoat = player:getEquippedItem(EQ_COAT)

	local playerFaceAccCost = 0
	local playerHelmCost = 0
	local playerCrownCost = 0
	local playerWeaponCost = 0
	local playerArmorCost = 0
	local playerShieldCost = 0
	local playerLeftCost = 0
	local playerRightCost = 0
	local playerMantleCost = 0
	local playerSubLeftCost = 0
	local playerSubRightCost = 0
	local playerNecklaceCost = 0
	local playerBootsCost = 0
	local playerCoatCost = 0
	local inventoryItemsCost = 0
	local inventoryCost=0
	local totalCost = 0


	local inventoryItems = {}

	
	if(playerFaceAcc~=nil) then
		if(playerFaceAcc.price~=0) then
			if(playerFaceAcc.dura<playerFaceAcc.maxDura) then
				if(playerFaceAcc.dura<playerFaceAcc.maxDura) then
					playerFaceAccCost=math.ceil(((playerFaceAcc.price/playerFaceAcc.maxDura)*(playerFaceAcc.maxDura-playerFaceAcc.dura))*0.5)
				end
			end
		else
			player:sendMinitext(""..playerFaceAcc.name.." is not a repairable item.")
		end
	end
	
	if(playerHelm~=nil) then
		if(playerHelm.price~=0) then
			if(playerHelm.dura<playerHelm.maxDura) then
				if(playerHelm.dura<playerHelm.maxDura) then
					playerHelmCost=math.ceil(((playerHelm.price/playerHelm.maxDura)*(playerHelm.maxDura-playerHelm.dura))*0.5)
					
				end
			end
		else
			player:sendMinitext(""..playerHelm.name.." is not a repairable item.")
		end
	end
	
	if(playerCrown~=nil) then
		if(playerCrown.price~=0) then
			if(playerCrown.dura<playerCrown.maxDura) then
				if(playerCrown.dura<playerCrown.maxDura) then
					playerCrownCost=math.ceil(((playerCrown.price/playerCrown.maxDura)*(playerCrown.maxDura-playerCrown.dura))*0.5)
					
				end
			end
		else
			player:sendMinitext(""..playerCrown.name.." is not a repairable item.")
		end
	end
	if(playerWeapon~=nil) then
		if(playerWeapon.price~=0) then
			if(playerWeapon.dura<playerWeapon.maxDura) then
				if(playerWeapon.dura<playerWeapon.maxDura) then
					playerWeaponCost=math.ceil(((playerWeapon.price/playerWeapon.maxDura)*(playerWeapon.maxDura-playerWeapon.dura))*0.5)
					
				end
			end
		else
			player:sendMinitext(""..playerWeapon.name.." is not a repairable item.")
		end
	end
	
	if(playerArmor~=nil) then
		if(playerArmor.price~=0) then
			if(playerArmor.dura<playerArmor.maxDura) then
				if(playerArmor.dura<playerArmor.maxDura) then
					playerArmorCost=math.ceil(((playerArmor.price/playerArmor.maxDura)*(playerArmor.maxDura-playerArmor.dura))*0.5)
					
				end
			end
		else
			player:sendMinitext(""..playerArmor.name.." is not a repairable item.")
		end
	end

	if(playerShield~=nil) then
		if(playerShield.price~=0) then
			if(playerShield.dura<playerShield.maxDura) then
				if(playerShield.dura<playerShield.maxDura) then
					playerShieldCost=math.ceil(((playerShield.price/playerShield.maxDura)*(playerShield.maxDura-playerShield.dura))*0.5)
					
				end
			end
		else
			player:sendMinitext(""..playerShield.name.." is not a repairable item.")
		end
	end
	
	if(playerLeft~=nil) then
		if(playerLeft.price~=0) then
			if(playerLeft.dura<playerLeft.maxDura) then
				if(playerLeft.dura<playerLeft.maxDura) then
					playerLeftCost=math.ceil(((playerLeft.price/playerLeft.maxDura)*(playerLeft.maxDura-playerLeft.dura))*0.5)
					
				end
			end
		else
			player:sendMinitext(""..playerLeft.name.." is not a repairable item.")
		end
	end

	if(playerRight~=nil) then
		if(playerRight.price~=0) then
			if(playerRight.dura<playerRight.maxDura) then
				if(playerRight.dura<playerRight.maxDura) then
					playerRightCost=math.ceil(((playerRight.price/playerRight.maxDura)*(playerRight.maxDura-playerRight.dura))*0.5)
					
				end
			end
		else
			player:sendMinitext(""..playerRight.name.." is not a repairable item.")
		end
	end	

	if(playerMantle~=nil) then
		if(playerMantle.price~=0) then
			if(playerMantle.dura<playerMantle.maxDura) then
				if(playerMantle.dura<playerMantle.maxDura) then
					playerMantleCost=math.ceil(((playerMantle.price/playerMantle.maxDura)*(playerMantle.maxDura-playerMantle.dura))*0.5)
					
				end
			end
		else
			player:sendMinitext(""..playerMantle.name.." is not a repairable item.")
		end
	end

	if(playerSubLeft~=nil) then
		if(playerSubLeft.price~=0) then
			if(playerSubLeft.dura<playerSubLeft.maxDura) then
				if(playerSubLeft.dura<playerSubLeft.maxDura) then
					playerSubLeftCost=math.ceil(((playerSubLeft.price/playerSubLeft.maxDura)*(playerSubLeft.maxDura-playerSubLeft.dura))*0.5)
					
				end
			end
		else
			player:sendMinitext(""..playerSubLeft.name.." is not a repairable item.")
		end
	end
	
	if(playerSubRight~=nil) then
		if(playerSubRight.price~=0) then
			if(playerSubRight.dura<playerSubRight.maxDura) then
				if(playerSubRight.dura<playerSubRight.maxDura) then
					playerSubRightCost=math.ceil(((playerSubRight.price/playerSubRight.maxDura)*(playerSubRight.maxDura-playerSubRight.dura))*0.5)
					
				end
			end
		else
			player:sendMinitext(""..playerSubRight.name.." is not a repairable item.")
		end
	end
	
	if(playerNecklace~=nil) then
		if(playerNecklace.price~=0) then
			if(playerNecklace.dura<playerNecklace.maxDura) then
				if(playerNecklace.dura<playerNecklace.maxDura) then
					playerNecklaceCost=math.ceil(((playerNecklace.price/playerNecklace.maxDura)*(playerNecklace.maxDura-playerNecklace.dura))*0.5)
				end	
			end
		else
			player:sendMinitext(""..playerNecklace.name.." is not a repairable item.")
		end
	end

	if(playerBoots~=nil) then
		if(playerBoots.price~=0) then
			if(playerBoots.dura<playerBoots.maxDura) then
				if(playerBoots.dura<playerBoots.maxDura) then
					playerBootsCost=math.ceil(((playerBoots.price/playerBoots.maxDura)*(playerBoots.maxDura-playerBoots.dura))*0.5)
					
				end
			end
		else
			player:sendMinitext(""..playerBoots.name.." is not a repairable item.")
		end
	end

	if(playerCoat~=nil) then
		if(playerCoat.price~=0) then
			if(playerCoat.dura<playerCoat.maxDura) then
				if(playerCoat.dura<playerCoat.maxDura) then
					playerCoatCost=math.ceil(((playerCoat.price/playerCoat.maxDura)*(playerCoat.maxDura-playerCoat.dura))*0.5)
					
				end
			end
		else
			player:sendMinitext(""..playerCoat.name.." is not a repairable item.")
		end
	end	

	for x=0,25 do
		invItems = player:getInventoryItem(x)
		if invItems ~= nil then
			if(invItems ~=nil and invItems.type>2 and invItems.type<17) then
				if(invItems.price~=0) then
					if(invItems.dura<invItems.maxDura) then
						if(invItems.dura<invItems.maxDura) then
							table.insert(inventoryItems, invItems)
						end
					end
				else
					player:sendMinitext(""..invItems.name.." is not a repairable item.")
				end
			end
		end
	end
	
	if #inventoryItems > 0 then
		for i = 1, #inventoryItems do
			inventoryItemsCost = inventoryItemsCost + math.ceil(((inventoryItems[i].price/inventoryItems[i].maxDura)*(inventoryItems[i].maxDura-inventoryItems[i].dura))*0.5)
		end
	end
	
	totalCost = (playerFaceAccCost + playerHelmCost + playerCrownCost + playerWeaponCost + playerArmorCost + playerShieldCost + playerLeftCost 
	+ playerRightCost + playerMantleCost + playerSubLeftCost + playerSubRightCost + playerNecklaceCost + playerBootsCost + playerCoatCost + inventoryItemsCost)
	
	
	menu = player:menuString(name.."Total cost to repair is: "..totalCost.."\n\nIs that OK?", {"Yes", "No"})
	
	if menu == "Yes" then
		if player:removeGold(totalCost) == true then

			if playerFaceAcc ~= nil then
				playerFaceAcc.dura=playerFaceAcc.maxDura
				player:sendMinitext(""..playerFaceAcc.name.." repaired for "..playerFaceAccCost.." coins.")
				playerFaceAcc.repairCheck = 0
			end
			
			if playerHelm ~= nil then			
				playerHelm.dura=playerHelm.maxDura
				player:sendMinitext(""..playerHelm.name.." repaired for "..playerHelmCost.." coins.")
				playerHelm.repairCheck = 0
			end
			
			if playerCrown ~= nil then			
				playerCrown.dura=playerCrown.maxDura
				player:sendMinitext(""..playerCrown.name.." repaired for "..playerCrownCost.." coins.")
				playerCrown.repairCheck = 0
			end
				
			if playerWeapon ~= nil then			
				playerWeapon.dura=playerWeapon.maxDura
				player:sendMinitext(""..playerWeapon.name.." repaired for "..playerWeaponCost.." coins.")
				playerWeapon.repairCheck = 0
			end	
			
			if playerArmor ~= nil then			
				playerArmor.dura=playerArmor.maxDura
				player:sendMinitext(""..playerArmor.name.." repaired for "..playerArmorCost.." coins.")
				playerArmor.repairCheck = 0
			end	
			
			if playerShield ~= nil then			
				playerShield.dura=playerShield.maxDura
				player:sendMinitext(""..playerShield.name.." repaired for "..playerShieldCost.." coins.")
				playerShield.repairCheck = 0
			end	
			
			if playerLeft ~= nil then			
				playerLeft.dura=playerLeft.maxDura
				player:sendMinitext(""..playerLeft.name.." repaired for "..playerLeftCost.." coins.")
				playerLeft.repairCheck = 0
			end	
			
			if playerRight ~= nil then			
				playerRight.dura=playerRight.maxDura
				player:sendMinitext(""..playerRight.name.." repaired for "..playerRightCost.." coins.")
				playerRight.repairCheck = 0
			end	
			
			if playerMantle ~= nil then			
				playerMantle.dura=playerMantle.maxDura
				player:sendMinitext(""..playerMantle.name.." repaired for "..playerMantleCost.." coins.")
				playerMantle.repairCheck = 0
			end	
			
			if playerSubLeft ~= nil then			
				playerSubLeft.dura=playerSubLeft.maxDura
				player:sendMinitext(""..playerSubLeft.name.." repaired for "..playerSubLeftCost.." coins.")
				playerSubLeft.repairCheck = 0
			end	
			
			if playerSubRight ~= nil then			
				playerSubRight.dura=playerSubRight.maxDura
				player:sendMinitext(""..playerSubRight.name.." repaired for "..playerSubRightCost.." coins.")
				playerSubRight.repairCheck = 0
			end	
			
			if playerNecklace ~= nil then			
				playerNecklace.dura=playerNecklace.maxDura
				player:sendMinitext(""..playerNecklace.name.." repaired for "..playerNecklaceCost.." coins.")
				playerNecklace.repairCheck = 0
			end	
			
			if playerBoots ~= nil then			
				playerBoots.dura=playerBoots.maxDura
				player:sendMinitext(""..playerBoots.name.." repaired for "..playerBootsCost.." coins.")
				playerBoots.repairCheck = 0
			end	
			
			if playerCoat ~= nil then			
				playerCoat.dura=playerCoat.maxDura
				player:sendMinitext(""..playerCoat.name.." repaired for "..playerCoatCost.." coins.")
				playerCoat.repairCheck = 0
			end	
			
			if #inventoryItems > 0 then
				for i = 1, #inventoryItems do
					inventoryCost = math.ceil(((inventoryItems[i].price/inventoryItems[i].maxDura)*(inventoryItems[i].maxDura-inventoryItems[i].dura))*0.5)
					inventoryItems[i].dura=inventoryItems[i].maxDura
				
					player:sendMinitext(""..inventoryItems[i].name.." repaired for "..inventoryCost.." coins.")
					inventoryItems.repairCheck = 0
				end
			end
		else
			player:popUp("You don't have enough coins!")
		end
	        
		--player:updateInv()
		player:sendStatus()
		player:updateState()
		player:sendMinitext("Total spent repairing: "..totalCost.." coins.")
	else
	end
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function Player.repairAllNoConfirm(player,npc)

	player:freeAsync()
	local cost=0
	local total=0
	
	local name = "<b>[Repair All]\n\n"

	local playerFaceAcc = player:getEquippedItem(EQ_FACEACC)
	local playerHelm = player:getEquippedItem(EQ_HELM)
	local playerCrown = player:getEquippedItem(EQ_CROWN)
	local playerWeapon = player:getEquippedItem(EQ_WEAP)
	local playerArmor = player:getEquippedItem(EQ_ARMOR)
	local playerShield = player:getEquippedItem(EQ_SHIELD)
	local playerLeft = player:getEquippedItem(EQ_LEFT)
	local playerRight = player:getEquippedItem(EQ_RIGHT)
	local playerMantle = player:getEquippedItem(EQ_MANTLE)
	local playerSubLeft = player:getEquippedItem(EQ_SUBLEFT)
	local playerSubRight = player:getEquippedItem(EQ_SUBRIGHT)
	local playerNecklace = player:getEquippedItem(EQ_NECKLACE)
	local playerBoots = player:getEquippedItem(EQ_BOOTS)
	local playerCoat = player:getEquippedItem(EQ_COAT)

	local playerFaceAccCost = 0
	local playerHelmCost = 0
	local playerCrownCost = 0
	local playerWeaponCost = 0
	local playerArmorCost = 0
	local playerShieldCost = 0
	local playerLeftCost = 0
	local playerRightCost = 0
	local playerMantleCost = 0
	local playerSubLeftCost = 0
	local playerSubRightCost = 0
	local playerNecklaceCost = 0
	local playerBootsCost = 0
	local playerCoatCost = 0
	local inventoryCost=0
	local inventoryItemsCost = 0
	local totalCost = 0


	local inventoryItems = {}

	
	if(playerFaceAcc~=nil) then
		if(playerFaceAcc.price~=0) then
			if(playerFaceAcc.dura<playerFaceAcc.maxDura) then
				if(playerFaceAcc.dura<playerFaceAcc.maxDura) then
					playerFaceAccCost=math.ceil(((playerFaceAcc.price/playerFaceAcc.maxDura)*(playerFaceAcc.maxDura-playerFaceAcc.dura))*0.5)
				end
			end
		else
			player:sendMinitext(""..playerFaceAcc.name.." is not a repairable item.")
		end
	end
	
	if(playerHelm~=nil) then
		if(playerHelm.price~=0) then
			if(playerHelm.dura<playerHelm.maxDura) then
				if(playerHelm.dura<playerHelm.maxDura) then
					playerHelmCost=math.ceil(((playerHelm.price/playerHelm.maxDura)*(playerHelm.maxDura-playerHelm.dura))*0.5)
					
				end
			end
		else
			player:sendMinitext(""..playerHelm.name.." is not a repairable item.")
		end
	end
	
	if(playerCrown~=nil) then
		if(playerCrown.price~=0) then
			if(playerCrown.dura<playerCrown.maxDura) then
				if(playerCrown.dura<playerCrown.maxDura) then
					playerCrownCost=math.ceil(((playerCrown.price/playerCrown.maxDura)*(playerCrown.maxDura-playerCrown.dura))*0.5)
					
				end
			end
		else
			player:sendMinitext(""..playerCrown.name.." is not a repairable item.")
		end
	end
	if(playerWeapon~=nil) then
		if(playerWeapon.price~=0) then
			if(playerWeapon.dura<playerWeapon.maxDura) then
				if(playerWeapon.dura<playerWeapon.maxDura) then
					playerWeaponCost=math.ceil(((playerWeapon.price/playerWeapon.maxDura)*(playerWeapon.maxDura-playerWeapon.dura))*0.5)
					
				end
			end
		else
			player:sendMinitext(""..playerWeapon.name.." is not a repairable item.")
		end
	end
	
	if(playerArmor~=nil) then
		if(playerArmor.price~=0) then
			if(playerArmor.dura<playerArmor.maxDura) then
				if(playerArmor.dura<playerArmor.maxDura) then
					playerArmorCost=math.ceil(((playerArmor.price/playerArmor.maxDura)*(playerArmor.maxDura-playerArmor.dura))*0.5)
					
				end
			end
		else
			player:sendMinitext(""..playerArmor.name.." is not a repairable item.")
		end
	end

	if(playerShield~=nil) then
		if(playerShield.price~=0) then
			if(playerShield.dura<playerShield.maxDura) then
				if(playerShield.dura<playerShield.maxDura) then
					playerShieldCost=math.ceil(((playerShield.price/playerShield.maxDura)*(playerShield.maxDura-playerShield.dura))*0.5)
					
				end
			end
		else
			player:sendMinitext(""..playerShield.name.." is not a repairable item.")
		end
	end
	
	if(playerLeft~=nil) then
		if(playerLeft.price~=0) then
			if(playerLeft.dura<playerLeft.maxDura) then
				if(playerLeft.dura<playerLeft.maxDura) then
					playerLeftCost=math.ceil(((playerLeft.price/playerLeft.maxDura)*(playerLeft.maxDura-playerLeft.dura))*0.5)
					
				end
			end
		else
			player:sendMinitext(""..playerLeft.name.." is not a repairable item.")
		end
	end

	if(playerRight~=nil) then
		if(playerRight.price~=0) then
			if(playerRight.dura<playerRight.maxDura) then
				if(playerRight.dura<playerRight.maxDura) then
					playerRightCost=math.ceil(((playerRight.price/playerRight.maxDura)*(playerRight.maxDura-playerRight.dura))*0.5)
					
				end
			end
		else
			player:sendMinitext(""..playerRight.name.." is not a repairable item.")
		end
	end	

	if(playerMantle~=nil) then
		if(playerMantle.price~=0) then
			if(playerMantle.dura<playerMantle.maxDura) then
				if(playerMantle.dura<playerMantle.maxDura) then
					playerMantleCost=math.ceil(((playerMantle.price/playerMantle.maxDura)*(playerMantle.maxDura-playerMantle.dura))*0.5)
					
				end
			end
		else
			player:sendMinitext(""..playerMantle.name.." is not a repairable item.")
		end
	end

	if(playerSubLeft~=nil) then
		if(playerSubLeft.price~=0) then
			if(playerSubLeft.dura<playerSubLeft.maxDura) then
				if(playerSubLeft.dura<playerSubLeft.maxDura) then
					playerSubLeftCost=math.ceil(((playerSubLeft.price/playerSubLeft.maxDura)*(playerSubLeft.maxDura-playerSubLeft.dura))*0.5)
					
				end
			end
		else
			player:sendMinitext(""..playerSubLeft.name.." is not a repairable item.")
		end
	end
	
	if(playerSubRight~=nil) then
		if(playerSubRight.price~=0) then
			if(playerSubRight.dura<playerSubRight.maxDura) then
				if(playerSubRight.dura<playerSubRight.maxDura) then
					playerSubRightCost=math.ceil(((playerSubRight.price/playerSubRight.maxDura)*(playerSubRight.maxDura-playerSubRight.dura))*0.5)
					
				end
			end
		else
			player:sendMinitext(""..playerSubRight.name.." is not a repairable item.")
		end
	end
	
	if(playerNecklace~=nil) then
		if(playerNecklace.price~=0) then
			if(playerNecklace.dura<playerNecklace.maxDura) then
				if(playerNecklace.dura<playerNecklace.maxDura) then
					playerNecklaceCost=math.ceil(((playerNecklace.price/playerNecklace.maxDura)*(playerNecklace.maxDura-playerNecklace.dura))*0.5)
				end	
			end
		else
			player:sendMinitext(""..playerNecklace.name.." is not a repairable item.")
		end
	end

	if(playerBoots~=nil) then
		if(playerBoots.price~=0) then
			if(playerBoots.dura<playerBoots.maxDura) then
				if(playerBoots.dura<playerBoots.maxDura) then
					playerBootsCost=math.ceil(((playerBoots.price/playerBoots.maxDura)*(playerBoots.maxDura-playerBoots.dura))*0.5)
					
				end
			end
		else
			player:sendMinitext(""..playerBoots.name.." is not a repairable item.")
		end
	end

	if(playerCoat~=nil) then
		if(playerCoat.price~=0) then
			if(playerCoat.dura<playerCoat.maxDura) then
				if(playerCoat.dura<playerCoat.maxDura) then
					playerCoatCost=math.ceil(((playerCoat.price/playerCoat.maxDura)*(playerCoat.maxDura-playerCoat.dura))*0.5)
					
				end
			end
		else
			player:sendMinitext(""..playerCoat.name.." is not a repairable item.")
		end
	end	

	for x=0,25 do
		invItems = player:getInventoryItem(x)
		if invItems ~= nil then
			if(invItems ~=nil and invItems.type>2 and invItems.type<17) then
				if(invItems.price~=0) then
					if(invItems.dura<invItems.maxDura) then
						if(invItems.dura<invItems.maxDura) then
							table.insert(inventoryItems, invItems)
						end
					end
				else
					player:sendMinitext(""..invItems.name.." is not a repairable item.")
				end
			end
		end
	end
	
	if #inventoryItems > 0 then
		for i = 1, #inventoryItems do
			inventoryItemsCost = inventoryItemsCost + math.ceil(((inventoryItems[i].price/inventoryItems[i].maxDura)*(inventoryItems[i].maxDura-inventoryItems[i].dura))*0.5)
		end
	end
	
	totalCost = (playerFaceAccCost + playerHelmCost + playerCrownCost + playerWeaponCost + playerArmorCost + playerShieldCost + playerLeftCost 
	+ playerRightCost + playerMantleCost + playerSubLeftCost + playerSubRightCost + playerNecklaceCost + playerBootsCost + playerCoatCost + inventoryItemsCost)
	
	if totalCost > 0 then
		if player:removeGold(totalCost) == true then
		
			if playerFaceAcc ~= nil then
				playerFaceAcc.dura=playerFaceAcc.maxDura
				player:sendMinitext(""..playerFaceAcc.name.." repaired for "..playerFaceAccCost.." coins.")
				playerFaceAcc.repairCheck = 0
			end
			
			if playerHelm ~= nil then			
				playerHelm.dura=playerHelm.maxDura
				player:sendMinitext(""..playerHelm.name.." repaired for "..playerHelmCost.." coins.")
				playerHelm.repairCheck = 0
			end
			
			if playerCrown ~= nil then			
				playerCrown.dura=playerCrown.maxDura
				player:sendMinitext(""..playerCrown.name.." repaired for "..playerCrownCost.." coins.")
				playerCrown.repairCheck = 0
			end
				
			if playerWeapon ~= nil then			
				playerWeapon.dura=playerWeapon.maxDura
				player:sendMinitext(""..playerWeapon.name.." repaired for "..playerWeaponCost.." coins.")
				playerWeapon.repairCheck = 0
			end	
			
			if playerArmor ~= nil then			
				playerArmor.dura=playerArmor.maxDura
				player:sendMinitext(""..playerArmor.name.." repaired for "..playerArmorCost.." coins.")
				playerArmor.repairCheck = 0
			end	
			
			if playerShield ~= nil then			
				playerShield.dura=playerShield.maxDura
				player:sendMinitext(""..playerShield.name.." repaired for "..playerShieldCost.." coins.")
				playerShield.repairCheck = 0
			end	
			
			if playerLeft ~= nil then			
				playerLeft.dura=playerLeft.maxDura
				player:sendMinitext(""..playerLeft.name.." repaired for "..playerLeftCost.." coins.")
				playerLeft.repairCheck = 0
			end	
			
			if playerRight ~= nil then			
				playerRight.dura=playerRight.maxDura
				player:sendMinitext(""..playerRight.name.." repaired for "..playerRightCost.." coins.")
				playerRight.repairCheck = 0
			end	
			
			if playerMantle ~= nil then			
				playerMantle.dura=playerMantle.maxDura
				player:sendMinitext(""..playerMantle.name.." repaired for "..playerMantleCost.." coins.")
				playerMantle.repairCheck = 0
			end	
			
			if playerSubLeft ~= nil then			
				playerSubLeft.dura=playerSubLeft.maxDura
				player:sendMinitext(""..playerSubLeft.name.." repaired for "..playerSubLeftCost.." coins.")
				playerSubLeft.repairCheck = 0
			end	
			
			if playerSubRight ~= nil then			
				playerSubRight.dura=playerSubRight.maxDura
				player:sendMinitext(""..playerSubRight.name.." repaired for "..playerSubRightCost.." coins.")
				playerSubRight.repairCheck = 0
			end	
			
			if playerNecklace ~= nil then			
				playerNecklace.dura=playerNecklace.maxDura
				player:sendMinitext(""..playerNecklace.name.." repaired for "..playerNecklaceCost.." coins.")
				playerNecklace.repairCheck = 0
			end	
			
			if playerBoots ~= nil then			
				playerBoots.dura=playerBoots.maxDura
				player:sendMinitext(""..playerBoots.name.." repaired for "..playerBootsCost.." coins.")
				playerBoots.repairCheck = 0
			end	
			
			if playerCoat ~= nil then			
				playerCoat.dura=playerCoat.maxDura
				player:sendMinitext(""..playerCoat.name.." repaired for "..playerCoatCost.." coins.")
				playerCoat.repairCheck = 0
			end	
			
			if #inventoryItems > 0 then
				for i = 1, #inventoryItems do
					inventoryCost = math.ceil(((inventoryItems[i].price/inventoryItems[i].maxDura)*(inventoryItems[i].maxDura-inventoryItems[i].dura))*0.5)
					inventoryItems[i].dura=inventoryItems[i].maxDura
				
					player:sendMinitext(""..inventoryItems[i].name.." repaired for "..inventoryCost.." coins.")
					inventoryItems.repairCheck = 0
				end
			end
			player:sendMinitext("Total spent repairing: "..totalCost.." coins.")
		else
			player:popUp("You don't have enough coins!")
		end
	else
		player:popUp("You don't have anything to repair!")
	end
	--player:updateInv()
	player:sendStatus()
	player:updateState()
end


function Player.clanBankAddMoney(player,clannumber)


	local amount=player:input("How much would you like to deposit to your clan Bank ?")
	amount=tonumber(math.ceil(math.abs(amount)))
	if(amount==0) then return false end
	if(amount>player.money) then
		amount=player.money
	end

	player.money=player.money-amount
	core.gameRegistry["clan"..clannumber.."bankmoney"]=core.gameRegistry["clan"..clannumber.."bankmoney"]+amount
	player:sendStatus()
	return true
end

function Player.clanBankWithdrawMoney(player,clannumber)


	local inBank=core.gameRegistry["clan"..clannumber.."bankmoney"]
	local amount=player:input("Your clan bank currently holds " .. inBank .. " coins.  How much would you like to withdraw?")
	amount=tonumber(math.ceil(math.abs(amount)))
	if(amount>inBank) then
		amount=inBank
	end

		player.money=player.money+amount
		core.gameRegistry["clan"..clannumber.."bankmoney"] = core.gameRegistry["clan"..clannumber.."bankmoney"]-amount
		player:sendStatus()
end

function Player.clanViewBank(player,dialog)




	local maxslots=player.mapRegistry["clanbankmaxslots"]
	local max=player.mapRegistry["clanbankcount"]
	local bank_item_table={}
	local bank_count_table={}
	local regname
	local found
	local amount=0
	if max==0 then
		player:dialogSeq({"Your clan bank is currently empty."})
		return false
	end

	for x=1,max do
		regname="clanbank" .. x
		table.insert(bank_item_table,player.mapRegistry[regname])
		regname="clanbank" .. x .. "count"
		table.insert(bank_count_table,player.mapRegistry[regname])
	end
	local temp=player:buy("This tool allows you to see the contents of your Clan Bank. You may not withdraw anything from this window. You are currently using "..max.." bank slots over a maximum of "..maxslots..".",bank_item_table,bank_count_table)
end


--Player actions and spells
function Player.addItemExtend(player,id,amount,engrave)

	local worked=player:addItem(id,amount,0,engrave)

	if(not worked) then
		player:drop(id,amount)
	end
end

function Player.calcThrow(player)
	local side=player.side
	local temp = {}
	local tempfinal = {}
	tempfinal = nil
	local bowrange=player.mapRegistry["bowrange"]
	if(bowrange==0) then
		bowrange=1
	end

	if(side==0) then
		for y=(player.y-bowrange),(player.y-1) do
			temp=player:getObjectsInCell(player.m,player.x,y,BL_NPC)
			if(#temp>0) then
				tempfinal=temp
			end
			temp=player:getObjectsInCell(player.m,player.x,y,BL_MOB)
			if(#temp>0) then
				tempfinal=temp
			end
			temp=player:getObjectsInCell(player.m,player.x,y,BL_PC)
			if(#temp>0 and temp[1].armorColor~=15) then
				tempfinal=temp
			end
			if(getPass(player.m,player.x,y)~=0) then
				tempfinal=nil
			end
			if(player:objectCanMove(player.x,y,0)==false) then
				tempfinal=nil
			end
		end
	elseif(side==1) then
		for x=(player.x+bowrange),(player.x+1),-1 do
			temp=player:getObjectsInCell(player.m,x,player.y,BL_NPC)
			if(#temp>0) then
				tempfinal=temp
			end
			temp=player:getObjectsInCell(player.m,x,player.y,BL_MOB)
			if(#temp>0) then
				tempfinal=temp
			end
			temp=player:getObjectsInCell(player.m,x,player.y,BL_PC)
			if(#temp>0 and temp[1].armorColor~=15) then
				tempfinal=temp
			end
			if(getPass(player.m,x,player.y)~=0) then
				tempfinal=nil
			end
			if(player:objectCanMove(x,player.y,1)==false) then
				tempfinal=nil
			end
		end
	elseif(side==2) then
		for y=(player.y+bowrange),(player.y+1),-1 do
			temp=player:getObjectsInCell(player.m,player.x,y,BL_NPC)
			if(#temp>0) then
				tempfinal=temp
			end
			temp=player:getObjectsInCell(player.m,player.x,y,BL_MOB)
			if(#temp>0) then
				tempfinal=temp
			end
			temp=player:getObjectsInCell(player.m,player.x,y,BL_PC)
			if(#temp>0 and temp[1].armorColor~=15) then
				tempfinal=temp
			end
			if(getPass(player.m,player.x,y)~=0) then
				tempfinal=nil
			end
			if(player:objectCanMove(player.x,y,2)==false) then
				tempfinal=nil
			end
		end
	elseif(side==3) then
		for x=(player.x-bowrange),(player.x-1) do
			temp=player:getObjectsInCell(player.m,x,player.y,BL_NPC)
			if(#temp>0) then
				tempfinal=temp
			end
			temp=player:getObjectsInCell(player.m,x,player.y,BL_MOB)
			if(#temp>0) then
				tempfinal=temp
			end
			temp=player:getObjectsInCell(player.m,x,player.y,BL_PC)
			if(#temp>0 and temp[1].armorColor~=15) then
				tempfinal=temp
			end
			if(getPass(player.m,x,player.y)~=0) then
				tempfinal=nil
			end
			if(player:objectCanMove(x,player.y,3)==false) then
				tempfinal=nil
			end
		end
	end
	return tempfinal
end

function Player.calcRangedDamage(player,target)
	local mindamage=0
	local maxdamage=0
	local finaldamage=0
	local enchant=0

	

	local item=player:getEquippedItem(EQ_FACEACC)
	if(item~=nil) then
		mindamage=mindamage+item.minDmg
		maxdamage=maxdamage+item.maxDmg
	end
	item=player:getEquippedItem(EQ_HELM)
	if(item~=nil) then
		mindamage=mindamage+item.minDmg
		maxdamage=maxdamage+item.maxDmg
	end
	item=player:getEquippedItem(EQ_CROWN)
	if(item~=nil) then
		mindamage=mindamage+item.minDmg
		maxdamage=maxdamage+item.maxDmg
	end
	item=player:getEquippedItem(EQ_WEAP)
	if(item~=nil) then
		mindamage=mindamage+item.minDmg
		maxdamage=maxdamage+item.maxDmg
	end
	item=player:getEquippedItem(EQ_ARMOR)
	if(item~=nil) then
		mindamage=mindamage+item.minDmg
		maxdamage=maxdamage+item.maxDmg
	end
	item=player:getEquippedItem(EQ_SHIELD)
	if(item~=nil) then
		mindamage=mindamage+item.minDmg
		maxdamage=maxdamage+item.maxDmg
	end
	item=player:getEquippedItem(EQ_LEFT)
	if(item~=nil) then
		mindamage=mindamage+item.minDmg
		maxdamage=maxdamage+item.maxDmg
	end
	item=player:getEquippedItem(EQ_MANTLE)
	if(item~=nil) then
		mindamage=mindamage+item.minDmg
		maxdamage=maxdamage+item.maxDmg
	end
	item=player:getEquippedItem(EQ_RIGHT)
	if(item~=nil) then
		mindamage=mindamage+item.minDmg
		maxdamage=maxdamage+item.maxDmg
	end
	item=player:getEquippedItem(EQ_SUBLEFT)
	if(item~=nil) then
		mindamage=mindamage+item.minDmg
		maxdamage=maxdamage+item.maxDmg
	end
	item=player:getEquippedItem(EQ_SUBRIGHT)
	if(item~=nil) then
		mindamage=mindamage+item.minDmg
		maxdamage=maxdamage+item.maxDmg
	end
	item=player:getEquippedItem(EQ_COAT)
	if(item~=nil) then
		mindamage=mindamage+item.minDmg
		maxdamage=maxdamage+item.maxDmg
	end
	item=player:getEquippedItem(EQ_NECKLACE)
	if(item~=nil) then
		mindamage=mindamage+item.minDmg
		maxdamage=maxdamage+item.maxDmg
	end
	item=player:getEquippedItem(EQ_BOOTS)
	if(item~=nil) then
		mindamage=mindamage+item.minDmg
		maxdamage=maxdamage+item.maxDmg
	end

	
	local calcrange

	
	if(player.level < 99) then
		calcrange=10+(player.level/6)/2
	elseif(player.level >= 99) then
		calcrange=(40+(player.maxMagic/2500)+(player.maxHealth/2500))/2
		
	end

	enchant = calcrange * 1.2

	finaldamage=math.random(mindamage,maxdamage)
	finaldamage=finaldamage*enchant

	return finaldamage

end

function Player.calcRangedHit(player,bullshit,target)
	
	local hitcalc=0
	local critcalc=0
	local hitchance=0
	local result=0

	hitcalc=55+(player.grace/2)-(target.grace/2)+(player.hit*1.5)+(player.level)-(target.level)

	if hitcalc<=5 then hitcalc=5 end
	if hitcalc>=95 then hitcalc=95 end

	hitchance=math.random(1,100)
	critcalc=player.hit/3

	if critcalc<=1 then critcalc=1 end
	if critcalc>=99 then critcalc=99 end

	if hitchance>hitcalc then result=0 end
	if hitchance<hitcalc then result=1 end
	
	if(result==1 and hitchance<critcalc) then result=3 end

	return result
end

function Player.activeSpells(player,spells)
	local isActive=false
	for _,spell in pairs(spells) do
		if(isActive~=true) then
			isActive=player:hasDuration(spell)
		end
	end
	return isActive
end

function Player.addGold(player, amount)
	if (amount > 0) then
		player.money = player.money + amount
		player:sendStatus()
		player:sendMinitext("You got "..amount.." coins")
		characterLog.addGoldWrite(player, amount)
		return true
	elseif (amount < 0) then
		player:sendMinitext("Contact a GM, I'm sure they will be happy to see what you tried to do.")
		return false
	end
end


------------------------------------------------------------------------------------------




function Player.removeGold(player, amount)
	if (amount > 0 and player.money < amount) then
		player:sendMinitext("You don't have enough money!.")
		player:sendStatus()
		return false
	elseif (amount > 0 and player.money >= amount) then
		player.money = player.money - amount
		characterLog.removeGoldWrite(player, amount)
		player:sendMinitext("Removed "..math.floor(amount).." coins")
		player:sendStatus()
		return true
	elseif (amount < 0) then
		player:sendMinitext("Contact a GM, I'm sure they will be happy to see what you tried to do.")
		return false
	end
end

function Player.getEquippedDura(player, id, slot)
	local item
	
	if (slot ~= nil) then
		item = player:getEquippedItem(slot)
		
		if (item ~= nil and item.id == id) then
			return item.dura
		end
	else
		for i = 0, 13 do
			item = player:getEquippedItem(i)
			
			if (item ~= nil and item.id == id) then
				return item.dura
			end
		end
	end
	
	return nil
end

function Player.calcDPS(player, times)
	local iterations = ((times * 1000) / ((player.attackSpeed * 1000) / 50))
	local hits = 0
	local damage = 0
	local target = getTargetFacing(player, BL_MOB)
	
	if (target == nil) then
		target = getTargetFacing(player, BL_PC)
	end
	
	if (target == nil) then
		return
	end
	
	for i = 1, iterations do
		hitCritChance(player, target)
		
		if (player.critChance > 0) then
			hits = hits + 1
			swingDamage(player)
			swingDamage(player, target)
			damage = damage + player.damage
		end
	end
	
	player:msg(0, "Total damage: "..damage.." Speed : "..(times / 60).." timex per minute.", player.ID)
	player:msg(0, "Damage per second: "..(damage / times).." Hits: "..hits, player.ID)
end




function Player.canAction(player, dead, mount, disguise)

	if (player.state == -1) then
		player:sendMinitext("Cannot do that right now!")
		return false
	end
	
	if (dead == 1 and player.state == 1) then
		player:sendMinitext("Cannot do that right now!")
		return false
	end
	
	if (mount == 1 and player.state == 3) then
		player:sendMinitext("Cannot do that right now!")
		return false
	end
	
	if (disguise == 1 and player.state == 4) then
		player:sendMinitext("Cannot do that right now!")
		return false
	elseif (disguise == 2 and (player.state == 4 or player.gfxClone == 1)) then
		player:sendMinitext("Cannot do that right now!")
		return false
	end
	
	return true
end	

function Player.canCast(player, dead, mount, disguise)

	local minitext = "Cannot do that right now!"
	
	if (player.state == -1) then
		anim(player)
		player:sendMinitext(minitext)
		return false
	end
	
	if (dead == 1 and player.state == 1) then
		anim(player)
		player:sendMinitext(minitext)
		return false
	end
	
	if (mount == 1 and player.state == 3) then
		anim(player)
		player:sendMinitext(minitext)
		return false
	end
	
	if (disguise == 1 and player.state == 4) then
		anim(player)
		player:sendMinitext(minitext)
		return false
	end

	return true
end

function Player.canPK(player, target)
	
	if target.state == 1 then
		--player:sendMinitext("Target is already dead!")
		return
	end
	
	--if target.registry["carnage_team"] == player.registry["carnage_team"] then return end
	
	if (target.pvp == 0 and target.PK > 0 and not player:getPK(target.ID)) then
		target:setPK(player.ID)
		player:sendMinitext(""..target.name.." attack you in non PvP map!!")
	elseif (target.pvp == 2 and target.PK == 0 and not player:getPK(target.ID)) then
		target:setPK(player.ID)
		player:sendMinitext(""..target.name.." attack you!!")
	end
	
	if (target.pvp > 0 or target.PK > 0 or player:getPK(target.ID)) then
		if (#player.group > 1) then
			for i = 1, #player.group do
				if (target.id == player.group[i] and target.sleep == 1) then
					return false
				end
			end
		end
		
		return true
	end
	
	return false
end


function Player.calculateIncrease(player, full)
	local currentExperience = player.exp
	local level = player.level + (player.mark*98) -- initial value 250
	local results = {vitaMana = 0, experience = 0, level = 0}
	local increase = 100
	local totalSells = math.floor((player.baseHealth + player.baseMagic)/100)
	local costAtLevel = expCostAtLevel(level)
	
	--if the stats you have exceed the amount of sales that are supposed to be at your san*250 + level, then there
	-- is probably a san glitch do not sell
	if (totalSells > totalSellsAtLevel(level+1)) then
		return results
	end
	
	while ((currentExperience - (results.experience + costAtLevel)) >= 0 and (player.level + results.level) <= 98) do -- nilai awal 250
		
		costAtLevel = expCostAtLevel(level)
		results.vitaMana = results.vitaMana + increase
		results.experience = results.experience + costAtLevel
		
		totalSells = totalSells + 1
		
		if (totalSells >= totalSellsAtLevel(level)) then
			results.level = results.level + 1
			level = level + 1
		end
				
		if (full == false) then
			break
		end			
	end

	return results
end




----------------------------------------------------------------------------------------------
function Player.buyDivineLightWithLapis(player)

	local status
	local multiplier = 0
	local timeRemaining = (os.time() - core.gameRegistry["divine_light_timer"])
	local lapisAmount = 0
	
	if core.gameRegistry["divine_light"] == 0 then
		status = "OFF"
		multiplier = 1
		timeRemaining = 0
	else
		status = "ON"
		if core.gameRegistry["divine_light_multiplier"] == 1 then
			multiplier = 1.5
		elseif core.gameRegistry["divine_light_multiplier"] == 2 then
			multiplier = 1.75
		elseif core.gameRegistry["divine_light_multiplier"] == 3 then
			multiplier = 2
		elseif core.gameRegistry["divine_light_multiplier"] == 4 then
			multiplier = 3
		end
	end
	
	
	local opts = {"What's all this about?", "Contribute 100 Lapis", "Contribute 500 Lapis", "Contribute 1000 Lapis", "Contribute 2500 Lapis", "Contribute 5000 Lapis", "Contribute 10000 Lapis"}
	
	choice = player:menuString("<b>[DIVINE LIGHT]\n\nStatus: "..status.." | "..multiplier.."x EXP\n\nTime remaining: "..getTimerValues("divine_light_timer").."\n\nCurrent Daily Total: "..format_number(core.gameRegistry["divine_light_lapis_daily"]), opts)
	
	if choice == "What's all this about?" then
		player:dialogSeq({"<b>[BUYING DIVINE LIGHT MANUAL]\n\n\nYou can use your Lapis to create a global experience increase throughout the entire game. Let me explain how",
			"<b>[BUYING DIVINE LIGHT MANUAL]\n\n\nEvery 100 Lapis Lazuli will add 12 minutes to the Divine Light timer. So, 500 Lapis will add 1 hour of Divine Light.",
			"<b>[BUYING DIVINE LIGHT MANUAL]\n\nEvery day at 12:00 noon, Eastern Time, the daily donation total is tallied and reset. This does not end any Light that is left at midnight.",
			"<b>[BUYING DIVINE LIGHT MANUAL]\n\nLapis added to Divine Light can increase the multiplier in 3 tiers. 1.5, 1.75, and 2.0. These bonuses are obtained at 100 Lapis, 5000 Lapis, and 10000 Lapis respectively.",
			"<b>[BUYING DIVINE LIGHT MANUAL]\n\nSo in one day if the donations reaches the max 2.0 multiplier it will provide a total of 20 hours of benefit.",
			"<b>[BUYING DIVINE LIGHT MANUAL]\n\nThe multiplier will not decrease until the timer reaches 0. So you can continue to extend the multiplier for as long as you would like.",
			"<b>[BUYING DIVINE LIGHT MANUAL]\n\nIf you have more questions ask Peter."}, 1)
			return
	elseif choice == "Contribute 100 Lapis" then
		lapisAmount = 100
	elseif choice == "Contribute 500 Lapis" then
		lapisAmount = 500
	elseif choice == "Contribute 1000 Lapis" then
		lapisAmount = 1000
	elseif choice == "Contribute 2500 Lapis" then
		lapisAmount = 2500
	elseif choice == "Contribute 5000 Lapis" then
		lapisAmount = 5000
	elseif choice == "Contribute 10000 Lapis" then
		lapisAmount = 10000
	end
	
	
	confirm = player:menuString("Are you sure you want to spend "..lapisAmount.." Lapis Lazuli?", {"Yes", "No"})
	if confirm == "Yes" then
		if player.lapis >= lapisAmount then
			player:removeLapis(lapisAmount)
			player:sendStatus()
			player:sendMinitext("You spent "..lapisAmount.." Lapis Lazuli on Divine Light")
			broadcast(-1, ""..player.name.." has contributed "..lapisAmount.." Lapis Lazuli toward the Divine Light!")
			characterLog.divineLight(player, lapisAmount)
			divine_light.checkIfOn()
			
			divine_light.setPurchase(lapisAmount)
			
			divine_light.setMultiplier()
			
		elseif player.lapis < lapisAmount then
			player:popUp("You don't have enough Lapis Lazuli to do that!")
		
		end
	end	
end


function Player.buyLapis(player,dialog,items,prices,maxamounts)

	

	if(items==nil) then items={ } end
	if(prices==nil) then prices={ } end
	local x=0
	local amount=1
	local t = {graphics = player.npcGraphic, color = player.npcColor}
	if #prices==0 then
		for i=1,#items do
			table.insert(prices,Item(items[i]).price)
		end
	end

	local choice=player:buy(dialog,items,prices,{},{})
	
	for i=1,#items do
		if(Item(items[i]).id==choice) then
			x=i
			break
		end
	end
	if(x==0) then return nil end
	
	menu = player:menuString("You are interested in "..Item(choice).name.."?", {"Preview", "Purchase", "Exit"})

	if menu == "Preview" then
		if player.m == 1018 then
			previewMode(player, choice)
		else 
			player:sendMinitext("You can't use preview mode here!")
		end

	elseif menu == "Purchase" then

		amount=player:input("How many do you wish to buy?")
		amount = math.floor(amount * 1)
	
		if amount < 1 then
			player:popUp("Try using a real number!")
			return
		end
	
		if (maxamounts ~= nil and maxamounts[x] ~= nil and maxamounts[x] < amount) then
			player:dialog("Sorry, but I only can sell "..maxamounts[x].." more "..Item(choice).name.." to you.", t)
		end
	
		if player.lapis < (prices[x]*amount) then
			player:dialog("You don't have enough Lapis Lazuli!",{})
			return nil
		end
		local newChoice=player:menuString("The price of " .. amount .. " " .. Item(choice).name .. " is " .. format_number(prices[x]*amount) .. " Lapis Lazuli.\n\nYou currently have:\n"..format_number(player.lapis).." Lapis Lazuli.\n\nDo we have a deal?",{"Yes","No"})
		if(newChoice=="Yes") then
			if(player:hasSpace(Item(choice).name,amount) and (player.lapis >=(prices[x]*amount))) then
				player.registry["last_lapis"] = player.lapis
				player:removeLapis((prices[x]*amount))
				local buytable = {Item(choice).id, amount}
				player:addItem(Item(choice).name,amount)
				player:sendMinitext("You pay "..format_number(prices[x]*amount).." Lapis Lazuli.")
				player:sendStatus()
				characterLog.lapisLogs(player, Item(choice), amount)
				player.registry["last_lapis"] = 0
				return buytable

			else
				player:sendMinitext("Your inventory is full!")
			end
		end
	end
end


function Player.buyLapisNoPreview(player,dialog,items,prices,maxamounts)

	

	if(items==nil) then items={ } end
	if(prices==nil) then prices={ } end
	local x=0
	local amount=1
	local t = {graphics = player.npcGraphic, color = player.npcColor}
	if #prices==0 then
		for i=1,#items do
			table.insert(prices,Item(items[i]).price)
		end
	end

	local choice=player:buy(dialog,items,prices,{},{})
	
	for i=1,#items do
		if(Item(items[i]).id==choice) then
			x=i
			break
		end
	end
	if(x==0) then return nil end
	
	menu = player:menuString("You are interested in "..Item(choice).name.."?", {"Purchase", "Exit"})

	if menu == "Purchase" then

		amount=player:input("How many do you wish to buy?")
		amount = math.floor(amount * 1)
	
		if amount < 1 then
			player:popUp("Try using a real number!")
			return
		end
	
		if (maxamounts ~= nil and maxamounts[x] ~= nil and maxamounts[x] < amount) then
			player:dialog("Sorry, but I only can sell "..maxamounts[x].." more "..Item(choice).name.." to you.", t)
		end
	
		if player.lapis < (prices[x]*amount) then
			player:dialog("You don't have enough Lapis Lazuli!",{})
			return nil
		end
		local newChoice=player:menuString("The price of " .. amount .. " " .. Item(choice).name .. " is " .. format_number(prices[x]*amount) .. " Lapis Lazuli.\n\nYou currently have:\n"..format_number(player.lapis).." Lapis Lazuli.\n\nDo we have a deal?",{"Yes","No"})
		if(newChoice=="Yes") then
			if(player:hasSpace(Item(choice).name,amount) and (player.lapis >=(prices[x]*amount))) then
				player.registry["last_lapis"] = player.lapis
				player:removeLapis((prices[x]*amount))
				local buytable = {Item(choice).id, amount}
				player:addItem(Item(choice).name,amount)
				player:sendMinitext("You pay "..format_number(prices[x]*amount).." Lapis Lazuli.")
				player:sendStatus()
				characterLog.lapisLogs(player, Item(choice), amount)
				player.registry["last_lapis"] = 0
				return buytable
			else
				player:sendMinitext("Your inventory is full!")
			end
		end
	end
end


------------------------------------------------------------------------------------------------------------
--GM functions
function Player.gmMsg(player, msg, level)
	local online = {}
	online = player:getUsers()

	if (level == nil) then
		level = 0
	end
	
	if (msg == nil) then
		return
	end
	
	for i = 1, #online do
		if (online[i].gmLevel > level) then
			player:msg(12, msg, online[i].ID)
		end
	end
end

------------------------------------------------------------------------------------------------------------

-----------------BOD ITEM BREAK-------------

function Player.breakOnDeathItem(player) 

	local weap = player:getEquippedItem(EQ_WEAP)
	local armor = player:getEquippedItem(EQ_ARMOR)
	local shield = player:getEquippedItem(EQ_SHIELD)
	local helm = player:getEquippedItem(EQ_HELM)
	local left = player:getEquippedItem(EQ_LEFT)
	local right = player:getEquippedItem(EQ_RIGHT)
	local subLeft = player:getEquippedItem(EQ_SUBLEFT)
	local subRight = player:getEquippedItem(EQ_SUBRIGHT)
	local neck = player:getEquippedItem(EQ_NECKLACE)
	

	if weap ~= nil then
 		protectedItem = "weapon"
        	if player.registry[""..protectedItem.."_protected"] > 0 then
			player.registry[""..protectedItem.."_protected"] = player.registry[""..protectedItem.."_protected"] - 1
			player:sendMinitext("Your "..protectedItem.." was protected from breaking on death!")
			player:sendMinitext("Remaining protections on "..protectedItem.." slot: "..player.registry[""..protectedItem.."_protected"])
		else
			if weap.resist == 1 then
				player:deductDura(EQ_WEAP, weap.dura)
			end
		end
	end


	if armor ~= nil then
 		protectedItem = "armor"
        	if player.registry[""..protectedItem.."_protected"] > 0 then
			player.registry[""..protectedItem.."_protected"] = player.registry[""..protectedItem.."_protected"] - 1
			player:sendMinitext("Your "..protectedItem.." was protected from breaking on death!")
			player:sendMinitext("Remaining protections on "..protectedItem.." slot: "..player.registry[""..protectedItem.."_protected"])
		else
			if armor.resist == 1 then
				player:deductDura(EQ_ARMOR, armor.dura)
			end
		end
	end


	if shield ~= nil then
 		protectedItem = "shield"
        	if player.registry[""..protectedItem.."_protected"] > 0 then
			player.registry[""..protectedItem.."_protected"] = player.registry[""..protectedItem.."_protected"] - 1
			player:sendMinitext("Your "..protectedItem.." was protected from breaking on death!")
			player:sendMinitext("Remaining protections on "..protectedItem.." slot: "..player.registry[""..protectedItem.."_protected"])
		else
			if shield.resist == 1 then
				player:deductDura(EQ_SHIELD, shield.dura)
			end	
		end
	end


	if helm ~= nil then
 		protectedItem = "helm"
        	if player.registry[""..protectedItem.."_protected"] > 0 then
			player.registry[""..protectedItem.."_protected"] = player.registry[""..protectedItem.."_protected"] - 1
			player:sendMinitext("Your "..protectedItem.." was protected from breaking on death!")
			player:sendMinitext("Remaining protections on "..protectedItem.." slot: "..player.registry[""..protectedItem.."_protected"])
		else
			if helm.resist == 1 then
				player:deductDura(EQ_HELM, helm.dura)
			end
		end
	end


	if left ~= nil then
 		protectedItem = "left hand"
        	if player.registry[""..protectedItem.."_protected"] > 0 then
			player.registry[""..protectedItem.."_protected"] = player.registry[""..protectedItem.."_protected"] - 1
			player:sendMinitext("Your "..protectedItem.." was protected from breaking on death!")
			player:sendMinitext("Remaining protections on "..protectedItem.." slot: "..player.registry[""..protectedItem.."_protected"])
		else
			if left.resist == 1 then
				player:deductDura(EQ_LEFT, left.dura)
			end
		end
	end


	if right ~= nil then
 		protectedItem = "right hand"
        	if player.registry[""..protectedItem.."_protected"] > 0 then
			player.registry[""..protectedItem.."_protected"] = player.registry[""..protectedItem.."_protected"] - 1
			player:sendMinitext("Your "..protectedItem.." was protected from breaking on death!")
			player:sendMinitext("Remaining protections on "..protectedItem.." slot: "..player.registry[""..protectedItem.."_protected"])
		else
			if right.resist == 1 then
				player:deductDura(EQ_RIGHT, right.dura)
			end
		end
	end


	if subLeft ~= nil then
 		protectedItem = "left accessory"
        	if player.registry[""..protectedItem.."_protected"] > 0 then
			player.registry[""..protectedItem.."_protected"] = player.registry[""..protectedItem.."_protected"] - 1
			player:sendMinitext("Your "..protectedItem.." was protected from breaking on death!")
			player:sendMinitext("Remaining protections on "..protectedItem.." slot: "..player.registry[""..protectedItem.."_protected"])
		else
			if subLeft.resist == 1 then
				player:deductDura(EQ_SUBLEFT, subLeft.dura)
			end
		end
	end


	if subRight ~= nil then
 		protectedItem = "right accessory"
        	if player.registry[""..protectedItem.."_protected"] > 0 then
			player.registry[""..protectedItem.."_protected"] = player.registry[""..protectedItem.."_protected"] - 1
			player:sendMinitext("Your "..protectedItem.." was protected from breaking on death!")
			player:sendMinitext("Remaining protections on "..protectedItem.." slot: "..player.registry[""..protectedItem.."_protected"])
		else
			if subRight.resist == 1 then
				player:deductDura(EQ_SUBRIGHT, subRight.dura)
			end
		end
	end


	if neck ~= nil then
 		protectedItem = "necklace"
        	if player.registry[""..protectedItem.."_protected"] > 0 then
			player.registry[""..protectedItem.."_protected"] = player.registry[""..protectedItem.."_protected"] - 1
			player:sendMinitext("Your "..protectedItem.." was protected from breaking on death!")
			player:sendMinitext("Remaining protections on "..protectedItem.." slot: "..player.registry[""..protectedItem.."_protected"])
		else
			if neck.resist == 1 then
				player:deductDura(EQ_NECKLACE, neck.dura)
			end
		end
	end


end


----------Drop gold on death--------------

function Player.deathDropGold(player) 
	
	local gold = player.money
	local r = math.random(5, 35)*0.01
	local amount = player.money*r
	local item = 0
	
	if player.mapTitle == "Trial of Strength and Wits" then return end
	
	if amount == 1 then
		item  = 0
	elseif amount >= 2 and amount <= 999 then
		item  = 1
	elseif amount >= 1000 and amount <= 9999 then
		item  = 2
	elseif amount == 10000 then
		item  = 3
	elseif amount >= 10001 and amount <= 99999 then
		item  = 4
	elseif amount >= 100000 and amount <= 999999 then
		item  = 5
	elseif amount == 1000000 then
		item  = 6
	elseif amount >= 1000001 and amount <= 4999999 then
		item  = 7
	elseif amount >= 5000000 and amount <= 9999999 then
		item  = 8
	elseif amount >= 10000000 and amount <= 99999999 then
		item  = 9
	elseif amount == 100000000 then
		item  = 10
	elseif amount >= 100000001 and amount <= 249999999 then
		item  = 11
	elseif amount >= 250000000 then
		item  = 12
	end
	
	player:removeGold(amount)
	player:dropItem(item, amount)
end

----------Player Death Pile Item Drop------------------------------
function Player.deathPileDrop(player) --added 4/2017

	local r = math.random(1, 5)
	local m, x, y = player.m, player.x, player.y
	local maxInv = player.maxInv
	local currentItem

	local currentInventory = {}
	local totalInventory
	local groundItemsToCurse = {}
	
	if player.mapTitle == "Trial of Strength and Wits" then return end
	if player.m == 51 then return end
	
	for i = 0, maxInv do
		currentItem = player:getInventoryItem(i)
		if currentItem ~= nil then
			if currentItem.id < 300000 then
				table.insert(currentInventory, currentItem.id)
			end
		end
	end

	totalInventory = #currentInventory

	if r > totalInventory then
		r = totalInventory
	end
	--Player(4):talk(0,"number to drop: "..r)
	for i = 1, r do
		deathPileCheck(player)
	end
	groundItemsToCurse = player:getObjectsInCell(m, x, y, BL_ITEM)
	if #groundItemsToCurse > 0 then
		--Player(4):talk(0,"to curse: "..#groundItemsToCurse)
		for i = 1, #groundItemsToCurse do
			--Player(4):talk(0,"item "..i.." is "..groundItemsToCurse[i].name)	
			--Player(4):talk(0,""..groundItemsToCurse[i].name.." cursed to: "..groundItemsToCurse[i].cursed)		
			if groundItemsToCurse[i].cursed == 0 then
				--Player(4):talk(0,"Need to curse to: "..player.ID)
				groundItemsToCurse[i].cursed = player.ID
				--Player(4):talk(0,"cursing: "..groundItemsToCurse[i].name.." to "..groundItemsToCurse[i].cursed)					
				--Player(4):talk(0,"dropped: "..groundItemsToCurse[i].name)
			end
		end

	characterLog.deathPileLog(player)
	end

end



deathPileCheck = function(player)

	local maxInv = player.maxInv
	local itemToDrop
	local item
	local amountToDrop

	
	itemToDrop = math.random(0, maxInv)
	item = player:getInventoryItem(itemToDrop)
	--Player(4):talk(0,"checking slot "..itemToDrop)
	
	if item ~= nil then
		--Player(4):talk(0,"found in slot "..itemToDrop..": "..item.name)
		amountToDrop = math.random(1, item.amount)
		if not item.droppable then
			if item.id < 300000 then
				--Player(4):talk(0,"dropping: "..amountToDrop.." "..item.name)		
				for i = 1, amountToDrop do	
					player:forceDrop(itemToDrop)
				end
			else
				--Player(4):talk(0,"Lapis item: reseting")
				return deathPileCheck(player)
			end
		else
			--Player(4):talk(0,"reset")
			return deathPileCheck(player)
		end
	else
		--Player(4):talk(0,"reset")
		return deathPileCheck(player)
	end

end

function Player.findDeathPile(player)

	local deathPile = player:getObjectsInArea(BL_ITEM)   --added 4/2/17 for death pile recovery
	
	if #deathPile > 0 then
		for i = 1, #deathPile do
			if distanceSquare(player, deathPile[i], 3) then
				if deathPile[i].cursed == player.ID then
					return 1 
				elseif deathPile[i].cursed > 0 and player.gmLevel > 0 then
					return 1 
				end
			end
		end
	end

end


----------Lose EXP on death--------------

function Player.deathExpLoss(player) 
	
	local lost = 0
	local expFloor = getTotalEXP(player.level - 1)
	
	if player.level < 6 then return end
	
	if player.level <= 98 then
		lost = math.ceil(player.exp*.025)
	elseif player.level >= 99 then
		lost = math.ceil(player.exp*.50)
	end
	
	
	
	
	if player.level <= 98 then
		if player.exp - lost < expFloor then
			lost = player.exp - expFloor
		end
	end
	
	if player.exp - lost <= 0 then
		player.exp = 0
	else
		player.exp = player.exp - lost
	end
	
	
	player:sendMinitext("You've lost "..format_number(lost).." exp!")
end


----------Items take damage on death--------------

function Player.deathDuraLoss(player)

	local weap = player:getEquippedItem(EQ_WEAP)
	local armor = player:getEquippedItem(EQ_ARMOR)
	local shield = player:getEquippedItem(EQ_SHIELD)
	local helm = player:getEquippedItem(EQ_HELM)
	local left = player:getEquippedItem(EQ_LEFT)
	local right = player:getEquippedItem(EQ_RIGHT)
	local subleft = player:getEquippedItem(EQ_SUBLEFT)
	local subright = player:getEquippedItem(EQ_SUBRIGHT)
	local necklace = player:getEquippedItem(EQ_NECKLACE)
--	local cape = player:getEquippedItem(EQ_MANTLE)
	local boots = player:getEquippedItem(EQ_BOOTS)
	
	local durability = {}
	local durability_msg = ""
	local amount = 0
	
	if weap ~= nil then
		amount = weap.maxDura*(math.random(10, 20)*0.01)
		player:deductDura(0, amount)
		table.insert(durability, "Weap "..round((weap.dura/weap.maxDura)*100).."%  ")
	end
	
	if armor ~= nil then
		amount = armor.maxDura*(math.random(10, 20)*0.01)
		player:deductDura(1, amount)
		table.insert(durability, "Armor "..round((armor.dura/armor.maxDura)*100).."%  ")

	end
	
	if shield ~= nil then
		amount = shield.maxDura*(math.random(10, 20)*0.01)
		player:deductDura(2, amount)
		table.insert(durability, "Shield "..round((shield.dura/shield.maxDura)*100).."%  ")
	end
	
	if helm ~= nil then
		amount = helm.maxDura*(math.random(10, 20)*0.01)
		player:deductDura(3, amount)
		table.insert(durability, "Helm "..round((helm.dura/helm.maxDura)*100).."%  ")

	end
	
	if left ~= nil then
		amount = left.maxDura*(math.random(10, 20)*0.01)
		player:deductDura(4, amount)
		table.insert(durability, "Left "..round((left.dura/left.maxDura)*100).."%  ")
	end
	
	if right ~= nil then
		amount = right.maxDura*(math.random(10, 20)*0.01)
		player:deductDura(5, amount)
		table.insert(durability, "Right "..round((right.dura/right.maxDura)*100).."%  ")

	end
	
	if subleft ~= nil then
		amount = subleft.maxDura*(math.random(10, 20)*0.01)
		player:deductDura(6, amount)
		table.insert(durability, "Subleft "..round((subleft.dura/subleft.maxDura)*100).."%  ")

	end
	
	if subright ~= nil then
		amount = subright.maxDura*(math.random(10, 20)*0.01)
		player:deductDura(7, amount)
		table.insert(durability, "Subright "..round((subright.dura/subright.maxDura)*100).."%  ")

	end

	if necklace ~= nil then
		amount = necklace.maxDura*(math.random(10, 20)*0.01)
		player:deductDura(11, amount)
		table.insert(durability, "Necklace "..round((necklace.dura/necklace.maxDura)*100).."%  ")

	end
	
--	if cape ~= nil then
--		amount = cape.maxDura*(math.random(10, 20)*0.01)
--		player:deductDura(EQ_MANTLE, amount)
--		table.insert(durability, "Cape "..round((cape.dura/cape.maxDura)*100).."%  ")

--	end
	
	if boots ~= nil then
		amount = boots.maxDura*(math.random(10, 20)*0.01)
		player:deductDura(EQ_BOOTS, amount)
		table.insert(durability, "Boots "..round((boots.dura/boots.maxDura)*100).."%  ")

	end

	for i = 1, #durability do
		durability_msg = durability_msg .. durability[i]
	end
	
	if #durability > 0 then
		player:msg(0,"---- Durability Loss -----",player.ID)
		player:msg(0,durability_msg,player.ID)
	end
	

end


----------------------------------------------------------------------------------------

function Player.maxLevelUp(player)


	player.baseHealth = player.baseHealth + 100
	player.baseMagic = player.baseMagic + 100
	player:calcStat()
	spend_sp.gain(player)

	player.level = player.level + 1
	player.baseAC = 0
	player.health = player.maxHealth
	player.magic = player.maxMagic
	player:sendStatus()
	player:sendAnimation(253)
	player:playSound(123)
	player:talkSelf(2, "Level up!!")

end
------Failed death item drop----------
--[[
function Player.deathDropItem(player)

	for i = 0, player.maxInv do
		item = player:getInventoryItem(i)
		if item ~= nil then
			player:removeItemSlot(i, 1, 8)
		end
	end


end

]]--

--------------------------------------

function Player.addMinigamePoint(player)
	finishedQuest(player)
	player:sendMinitext("You got 1 Minigame Point!")
	player.registry["minigame_points"] = player.registry["minigame_points"] + 1

end


previewMode = function(player, choice)


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

	if helm ~= nil then 
		if player.registry["show_helmet"] == 1 then
			player.gfxHelm = helm.look 
			player.gfxHelmC = helm.lookC
		else
			player.gfxHelm = 65535 
		end
	else 
		player.gfxHelm = 65535 
	end
	
	if crown ~= nil then 
		player.gfxCrown = crown.look 
		player.gfxCrownC = crown.lookC 
	else 
		player.gfxCrown = 65535 
	end
	
	if facea ~= nil then 
		player.gfxFaceA = facea.look 
		player.gfxFaceAC = facea.lookC 
	else 
		player.gfxFaceA = 65535 
	end
	
	if weap ~= nil then 
		player.gfxWeap = weap.look 
		player.gfxWeapC = weap.lookC 
	else 
		player.gfxWeap = 65535 
	end
	
	if shield ~= nil then 
		player.gfxShield = shield.look 
		player.gfxShieldC = shield.lookC 
	else 
		player.gfxShield = 65535 
	end
	
	if cape ~= nil then 
		player.gfxCape = cape.look 
		player.gfxCapeC = cape.lookC 
	else 
		player.gfxCape = 65535 
	end
	
	if neck ~= nil then 
		player.gfxNeck = neck.look 
		player.gfxNeckC = neck.lookC 
	else 
		player.gfxNeck = 65535 
	end
	
	if armor ~= nil then 
		player.gfxArmor = armor.look 
		player.gfxArmorC = armor.lookC 
	else
		player.gfxArmor = player.sex
	end
	
	if coat ~= nil then 
		player.gfxArmor = coat.look 
		player.gfxArmorC = coat.lookC 
	end
	
	if player.armorColor > 0 then
		player.gfxArmorC = player.armorColor
		player.gfxDye = player.armorColor
	end
	
	player.gfxName = player.title.." "..player.name
	player.gfxFace = player.face
	player.gfxFaceC = player.faceColor
	player.gfxHair = player.hair
	player.gfxHairC = player.hairColor
	player.gfxSkinC = player.skinColor
	
	--player.gfxHelm = 65535
	if player.faceAccessoryTwo > 0 then
		player.gfxFaceAT = player.faceAccessoryTwo
	else
		player.gfxFaceAT = 65535
	end
	player.gfxFaceATC = player.faceAccessoryTwoColor
	
	player.gfxClone = 1

	if player.state == 0 then
		if Item(choice).type == 18 then 
			if Item(choice).lookC == 999 then
				player.state = 3
				player.disguise = Item(choice).look
				player:updateState()
			elseif Item(choice).lookC == 998 then
				player.gfxSkinC = Item(choice).look 
			elseif Item(choice).lookC == 997 then

				player.gfxFaceAT = Item(choice).look 
			end
		elseif Item(choice).type == 16 then 
			player.gfxArmor = Item(choice).look 
			--player.gfxDye = Item(choice).lookC
			player.gfxArmorC = Item(choice).lookC
	
		elseif Item(choice).type == 12 then 
			player.gfxCrown = Item(choice).look 
			player.gfxCrownC = Item(choice).lookC 
			
		elseif Item(choice).type == 11 then 
			player.gfxFaceA = Item(choice).look 
			player.gfxFaceAC = Item(choice).lookC 
	
		elseif Item(choice).type == 3 then 
			player.gfxWeap = Item(choice).look 
			player.gfxWeapC = Item(choice).lookC 
		
		elseif Item(choice).type == 13 then
			player.gfxCape = Item(choice).look 
			player.gfxCapeC = Item(choice).lookC 
			
		end	
		player:updateState()
	else
		player:sendMinitext("You can't do that right now!")
	end
end




function Player.leveledEXP(player, type)

	local rewardEXP = 0
	
	local divineLightMultiplier = 1

	if player:hasDuration("divine_light") then
		if core.gameRegistry["divine_light_multiplier"] == 1 then
			divineLightMultiplier = 1.5
		elseif core.gameRegistry["divine_light_multiplier"] == 2 then
			divineLightMultiplier = 1.75
		elseif core.gameRegistry["divine_light_multiplier"] == 3 then
			divineLightMultiplier = 2
		elseif core.gameRegistry["divine_light_multiplier"] == 4 then
			divineLightMultiplier = 3
		end
	end
	
	if player.gmLevel > 0 then
		rewardEXP = 1000000
	else
		if player.level <= 98 then
			rewardEXP = getTotalTNL(player.level)*.15
		elseif player.level >= 99 then
			
			if player.baseHealth >= player.baseMagic then
				rewardEXP = (changeXP2.getReqXPhealth2(player, player.baseClass) * 3)
			elseif player.baseMagic > player.baseHealth then
				rewardEXP = (changeXP2.getReqXPmagic2(player, player.baseClass) * 3)
			end
		end
	end

	rewardEXP = rewardEXP * divineLightMultiplier
	
	if type == "daily" or type == "donation" then

		giveXP(player, rewardEXP)

	elseif type == "win_minigame" or "lose_minigame" then
	
		if type == "win_minigame" then
		giveXP(player, rewardEXP)
		elseif type == "lose_minigame" then
		giveXP(player, math.floor(0.5*rewardEXP))
		end

	elseif type == "quest" then
		onGetExp2(player, rewardEXP)
	end

end

function Player.throwSpear(player)

	local northIcon = 0
	local eastIcon = 0
	local southIcon = 0
	local westIcon = 0	

	local weap = player:getEquippedItem(EQ_WEAP)
	local color = 0
	
	if weap ~= nil then
		northIcon = weap.icon - 49152
		eastIcon = weap.icon - 49151
		southIcon = weap.icon - 49150
		westIcon = weap.icon - 49149
		color = weap.color
	
	else
		if player:hasDuration("being_frank") then
			--Player(4):talk(0,""..weap.icon)
			northIcon = 53
			eastIcon = 54
			southIcon = 55
			westIcon = 56
			color = 9
		else
			northIcon = 49
			eastIcon = 50
			southIcon = 51
			westIcon = 52
			color = 0
		end
	
	end
	
	for i = 1, 6 do
		if player.side == 0 then
			player:throw(player.x, player.y-i, northIcon, color, 1)
		elseif player.side == 1 then
			player:throw(player.x+i, player.y, eastIcon, color, 1)
		elseif player.side == 2 then
			player:throw(player.x, player.y+i, southIcon, color, 1)
		elseif player.side == 3 then
			player:throw(player.x-i, player.y, westIcon, color, 1)
		end
	end
end

logWrite = function(player)
	
	local dir, text = "../rtklua/History/"..player.name.."_log.txt", ""
	local file = io.open(dir, "a+")
	
	text =       "==== [LOG] ==================================================================\n"
	text = text.."Player          : "..player.name.."\n"
	text = text.."Gold		: "..format_number(player.money).."\n"
	text = text.."EXP		: "..format_number(player.exp).."\n"
	text = text.."Date & Time     : "..os.date().."\n\n"
	
	file:write(text.."")
	file:flush()
	print ([[  ========================= [Character Log Test] =========================]])
	print ([[  =                                                                         =]])
	print ([[  =           Added changed status information and details to :             =]])
	print ([[  =        ('rtklua/History/log_test.txt')             =]])
	print ([[  =                                                                         =]])
	print ([[  ===========================================================================]])
	player:sendMinitext("Done!!")
end

function Player.recoverDeathPile(player)

	local dptable = {}

	local deathPile = player:getObjectsInArea(BL_ITEM)
	if #deathPile > 0 then
		for i = 1, #deathPile do
			if distanceSquare(player, deathPile[i], 3) then
				if deathPile[i].cursed == player.ID then
					table.insert(dptable, deathPile[i])
				elseif deathPile[i].cursed > 0 and player.gmLevel > 0 then
					table.insert(dptable, deathPile[i])
				end
			end
		end
	end

	if #dptable > 0 then
		for i = 1, #dptable do
			if dptable[i].id <=12 then  --If it is coins
				if dptable[i].cursed == player.ID then
					dptable[i]:delete()
					player:addGold(dptable[i].amount)
				elseif deathPile[i].cursed > 0 and player.gmLevel > 0 then
					dptable[i]:delete()
					player:addGold(dptable[i].amount)
				end
			elseif dptable[i].id > 12 then  --If it is not coins
				if dptable[i].cursed == player.ID then
					characterLog.pickUpWrite(player, dptable[i], dptable[i].amount)
					player:pickUp(dptable[i].ID)
				elseif deathPile[i].cursed > 0 and player.gmLevel > 0 then
					characterLog.pickUpWrite(player, dptable[i], dptable[i].amount)
					player:pickUp(dptable[i].ID)
				end
			end
		end
		player:sendAction(6, 20)
		player:talk(2,"I'll take that.")
	end
end

--[[
	if facing == north then
		deathPile = player:getObjectsInCell(player.m, player.x, player.y-1, BL_ITEM)
	elseif facing == east then
		deathPile = player:getObjectsInCell(player.m, player.x+1, player.y, BL_ITEM)
	elseif facing == south then
		deathPile = player:getObjectsInCell(player.m, player.x, player.y+1, BL_ITEM)
	elseif facing == west then
		deathPile = player:getObjectsInCell(player.m, player.x-1, player.y, BL_ITEM)
	end



	if deathPile ~= nil then
		for i = 1, #deathPile do
			if deathPile[i].id <=12 then  --If it is coins
				if deathPile[i].cursed == player.ID then
					deathPile[i]:delete()
					player:addGold(deathPile[i].amount)
				end
			elseif deathPile[i].id > 12 then  --If it is not coins
				if deathPile[i].cursed == player.ID then
					characterLog.pickUpWrite(player, deathPile[i], deathPile[i].amount)
					player:pickUp(deathPile[i].ID)
				end
			end
		end
		player:sendAction(6, 20)
		player:talk(2,"I'll take that.")
	end



]]--



function Player.bossSpellDamage(player, amount, sleep, deduction, ac, ds, print, type)

	local attacker
	local armor = player.armor
	local armorPhysicalReduction = (armor / (armor + 510))
	local armorPhysicalReductionPct = (armorPhysicalReduction * 100)
	
	local will = player.will
	local armorMagicReduction = (will/(will + 1000))
	local armorMagicReductionPct = (armorMagicReduction * 100)
	

		attacker = Mob(player.attacker)
		
------------------------------------
  if (sleep > 0 and print == 2) then
		amount = amount * player.sleep
		amount = math.floor(amount)
	elseif (sleep == 1) then
		amount = amount * player.sleep
		player.sleep = 1 
		amount = math.floor(amount)
	elseif (sleep == 2) then
		amount = amount * player.sleep
		amount = math.floor(amount)
  end
----------------------------------
----------------------------------
	if (deduction == 1) then
		if (player.deduction < 0) then
			amount = 0
		elseif (player.deduction > 0) then
			amount = amount * player.deduction
			amount = math.floor(amount)
		end
	end
----------------------------------
----------------------------------
	if (ac == 1) then
	end
----------------------------------
----------------------------------

----------------------------------
----------------------------------
	if type == "magical" then
---		attacker:sendMinitext("player Mag. Abs%: "..armorMagicReductionPct.." %")			
--		attacker:sendMinitext("Dmg Before Mag Def.: "..amount.." DMG")
--		amount = amount - (amount * armorMagicReduction)
--		attacker:sendMinitext("Dmg After Mag Def.: "..amount.." DMG")
	end
--------------------------------
	if (attacker ~= nil) then
	amount = math.floor(amount)
		attacker.damage = amount
		attacker.critChance = 0
	else
	amount = math.floor(amount)
		player.damage = amount
		player.critChance = 0
	end

--------------------------------
	if (print == 1) then		-- CAUSE DAMAGE, USED IN SPELL FLAGS
		player:sendHealth(amount,0)
----------------------------------
----------------------------------
	elseif (print == 2) then  	-- THREAT CALCULATION
		return amount
----------------------------------
----------------------------------
		
	else						-- SWING DAMAGE, let AI script do the damage application
		player_combat.on_attacked(player, attacker)
	end

--	if player.m == 1 then characterLog.spellDamageLog(attacker, player, amount) end

end
