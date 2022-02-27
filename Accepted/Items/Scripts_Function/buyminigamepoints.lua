function Player.buyMinigamePoints(player,dialog,items,prices,maxamounts)

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
		player:dialog("Sorry, but I only can sell "..maxamounts[x].." more "..Item(choice).name.." to you.", t)
	end

	if(player.registry["minigame_points"]<(prices[x]*amount)) then
		player:dialog("You don't have enough Minigame Points!",{})
		return nil
	end

	local newChoice=player:menuString("The price of " .. amount .. " " .. Item(choice).name .. " is " .. format_number(prices[x]*amount) .. " Minigame Points. Do we have a deal?",{"Yes","No"})
	if(newChoice=="Yes") then
		if(player:hasSpace(Item(choice).name,amount) and (player.registry["minigame_points"]>=(prices[x]*amount))) then
			local buytable = {Item(choice).id, amount}
			player:addItem(Item(choice).name,amount)
			player.registry["minigame_points"]=player.registry["minigame_points"]-(prices[x]*amount)
			player:sendMinitext("You pay "..format_number(prices[x]*amount).." Minigame Points.")
			player:sendStatus()
			return buytable
		else
			player:sendMinitext("Your inventory is full!")
		end
	end
end