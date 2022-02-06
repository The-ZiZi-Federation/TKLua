end_onSay = function(player)

	local printf = 1
	local caps = 0
	local speech = player.speech
	local p = player
	
	if (speech == "") then return end
	local lspeech = string.lower(player.speech)
	local length = string.len(lspeech)
	local online = {}
	local talkType = player.talkType
	online = player:getUsers()

	if player:hasDuration("frog") == true then
		printf = 0
		local r = math.random(1,3)
		if r == 1 then
			player:talk(0, player.name..": I'm a frog person! Crrroak!")
		elseif r == 2 then
			player:talk(0, player.name..": Rriibbit!")
		elseif r == 3 then
			player:talk(0, player.name..": I swear I'm a prince! Kiss me!")
		end
	end
end

mornaLight = function()
	
	local light
	
	if curTime() < 1 then light = 6 end
	if curTime() < 2 then light = 7 end
	if curTime() < 3 then light = 8 end
	if curTime() < 4 then light = 9 end
	if curTime() < 5 then light = 10 end
	if curTime() < 6 then light = 11 end
	if curTime() < 7 then light = 12 end
	if curTime() < 8 then light = 13 end
	if curTime() < 9 then light = 14 end
	if curTime() < 10 then light = 15 end
	if curTime() >= 10 and curTime() < 14 then light = 16 end
	if curTime() < 15 then light = 15 end
	if curTime() < 16 then light = 14 end
	if curTime() < 17 then light = 13 end
	if curTime() < 18 then light = 12 end
	if curTime() < 19 then light = 11 end
	if curTime() < 20 then light = 10 end
	if curTime() < 21 then light = 9 end
	if curTime() < 22 then light = 8 end
	if curTime() < 23 then light = 7 end
	if curTime() < 24 then light = 6 end
	
	setLight(201, 0, light)
end

function Player.buyPP(player,dialog,items,prices,maxamounts)

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
	amount = amount * 1

	if (maxamounts ~= nil and maxamounts[x] ~= nil and maxamounts[x] < amount) then
		player:dialog("Sorry, but I only can sell "..maxamounts[x].." more "..Item(choice).name.." to you.", t)
	end

	if(player.lapis<(prices[x]*amount)) then
		player:dialog("You don't have enough PP!",{})
		return nil
	end
	amount=math.abs(amount)
	local newChoice=player:menuString("The price of " .. amount .. " " .. Item(choice).name .. " is " .. format_number(prices[x]*amount) .. " PP. Do we have a deal?",{"Yes","No"})
	if(newChoice=="Yes") then
		if(player:hasSpace(Item(choice).name,amount) and (player.lapis>=(prices[x]*amount))) then
			local buytable = {Item(choice).id, amount}
			player:addItem(Item(choice).name,amount)
			player.lapis=player.lapis-(prices[x]*amount)
			player:sendMinitext("You pay "..format_number(prices[x]*amount).." PP.")
			player:sendStatus()
			return buytable
		else
			player:sendMinitext("Your inventory is full!")
		end
	end
end

function Player.addGMSpells(player)

	player:addSpell("alpha_sage")	--1 
	player:addSpell("gateway2")		--2
	player:addSpell("gm_res")		--3
	player:addSpell("engrave_item") --4
	player:addSpell("test_zone")	--5
	player:addSpell("gm_dispell")	--6
	player:addSpell("map_editor")	--7
	player:addSpell("devils_kiss")	--8
	player:addSpell("random_app")	--9
	player:addSpell("gm_blink")		--0
	player:addSpell("benign_transposition")
	player:addSpell("spawn_tool")
	player:addSpell("random_spawn_scrolls")
	player:addSpell("minigame_remove_spell")
	player:addSpell("dnd")
	player:addSpell("gm_kick")
	player:addSpell("super_saiyan")
	player:addSpell("ninja_swap")
	player:addSpell("ninja_disguise")
	player:addSpell("room_hellfire")
	player:addSpell("kiss_me")	
	player:addSpell("open_tile_count")
	player:addSpell("frog")
	player:addSpell("follow")
	player:addSpell("being_frank")
	player:addSpell("wind_walk")
end

failureAnim = function(player)
	
	player:sendAnimation(246)
end

checkOpenCell = function(map, x, y)
    
	local mob = core:getObjectsInCell(map,x,y, BL_MOB)
	local pc = core:getObjectsInCell(map,x,y, BL_PC)
	local npc = core:getObjectsInCell(map,x,y, BL_NPC)

	if getPass(map,x,y) == 0 then
		if not getWarp(map,x,y) then
			if getObject(map,x,y) == 0 then
				if #npc == 0 then
					if #mob == 0 then
						if #pc == 0 then
							return 1
						else
							return 0
						end
					else
						return 0
					end
				else
					return 0
				end
			else
				return 0
			end
		else
			return 0
		end
	else
		return 0
	end

end

checkOpenCellFacing = function(player)

	local map, x, y = player.m, player.x, player.y
	local side = player.side
	local check
	
	if side == 0 then
		check = checkOpenCell(map, x, y-1)
	
	elseif side == 1 then
		check = checkOpenCell(map, x+1, y)

	elseif side == 2 then
		check = checkOpenCell(map, x, y+1)

	elseif side == 3 then
		check = checkOpenCell(map, x-1, y)

	end
	
	return check
end

sideDamageMultiplier = { --Added 3/11/17 for side/back damage multiplier on swing damage

check = function(block1, block2) --attacker, defender

	local frontMultiplier = 1
	local sideMultiplier = 1.5
	local backMultiplier = 2

	if block1.side == 0 then
		if block2.side == 0 then
			if block2.y < block1.y then
				return backMultiplier
			elseif block2.y == block1.y then
				return sideMultiplier
			elseif block2.y > block1.y then
				return frontMultiplier
			end
			
		elseif block2.side == 1 then
			if block2.y < block1.y then
				if block2.x <= block1.x then
					return sideMultiplier
				elseif block2.x > block1.x then
					return frontMultiplier
				end
			elseif block2.y == block1.y then
				if block2.x < block1.x then
					return frontMultiplier
				elseif block2.x > block1.x then
					return backMultiplier
				end
			elseif block2.y > block1.y then
				if block2.x >= block1.x then
					return sideMultiplier
				elseif block2.x < block1.x then
					return frontMultiplier
				end
			end
			
		elseif block2.side == 2 then
			if block2.y > block1.y then
				return backMultiplier
			elseif block2.y < block1.y then
				return frontMultiplier
			elseif block2.y == block1.y then
				return sideMultiplier
			end
			
		elseif block2.side == 3 then
			if block2.y > block1.y then
				if block2.x <= block1.x then
					return sideMultiplier
				elseif block2.x > block1.x then
					return frontMultiplier
				end
			elseif block2.y < block1.y then
				if block2.x <= block1.x then
					return sideMultiplier
				elseif block2.x > block1.x then
					return frontMultiplier
				end 
			elseif block2.y == block1.y then
				if block2.x < block1.x then
					return backMultiplier
				elseif block2.x > block1.x then
					return frontMultiplier
				end
			end
		end
		
	elseif block1.side == 1 then
		if block2.side == 0 then
			if block2.y < block1.y then
				return backMultiplier
			elseif block2.y == block1.y then
				return sideMultiplier
			elseif block2.y > block1.y then
				return frontMultiplier
			end
			
		elseif block2.side == 1 then
			if block2.y < block1.y then
				if block2.x >= block1.x then
					return sideMultiplier
				elseif block2.x < block1.x then
					return frontMultiplier
				end
			elseif block2.y == block1.y then
				if block2.x < block1.x then
					return frontMultiplier
				elseif block2.x > block1.x then
					return backMultiplier
				end
			elseif block2.y > block1.y then
				if block2.x >= block1.x then
					return sideMultiplier
				elseif block2.x < block1.x then
					return frontMultiplier
				end
			end
			
		elseif block2.side == 2 then
			if block2.y > block1.y then
				return backMultiplier
			elseif block2.y < block1.y then
				return frontMultiplier
			elseif block2.y == block1.y then
				return sideMultiplier
			end
			
		elseif block2.side == 3 then
			if block2.y > block1.y then
				if block2.x <= block1.x then
					return sideMultiplier
				elseif block2.x > block1.x then
					return frontMultiplier
				end
			elseif block2.y < block1.y then
				if block2.x <= block1.x then
					return sideMultiplier
				elseif block2.x > block1.x then
					return frontMultiplier
				end 
			elseif block2.y == block1.y then
				if block2.x < block1.x then
					return backMultiplier
				elseif block2.x > block1.x then
					return frontMultiplier
				end
			end
		end
		
	elseif block1.side == 2 then
		if block2.side == 0 then
			if block2.y < block1.y then
				return backMultiplier
			elseif block2.y == block1.y then
				return sideMultiplier
			elseif block2.y > block1.y then
				return frontMultiplier
			end
			
		elseif block2.side == 1 then
			if block2.y < block1.y then
				if block2.x >= block1.x then
					return sideMultiplier
				elseif block2.x < block1.x then
					return frontMultiplier
				end
			elseif block2.y == block1.y then
				if block2.x < block1.x then
					return frontMultiplier
				elseif block2.x > block1.x then
					return backMultiplier
				end
			elseif block2.y > block1.y then
				if block2.x >= block1.x then
					return sideMultiplier
				elseif block2.x < block1.x then
					return frontMultiplier
				end
			end
			
		elseif block2.side == 2 then
			if block2.y > block1.y then
				return backMultiplier
			elseif block2.y < block1.y then
				return frontMultiplier
			elseif block2.y == block1.y then
				return sideMultiplier
			end
			
		elseif block2.side == 3 then
			if block2.y > block1.y then
				if block2.x <= block1.x then
					return sideMultiplier
				elseif block2.x > block1.x then
					return frontMultiplier
				end
			elseif block2.y < block1.y then
				if block2.x <= block1.x then
					return sideMultiplier
				elseif block2.x > block1.x then
					return frontMultiplier
				end 
			elseif block2.y == block1.y then
				if block2.x < block1.x then
					return backMultiplier
				elseif block2.x > block1.x then
					return frontMultiplier
				end
			end
		end
		
	elseif block1.side == 3 then
		if block2.side == 0 then
			if block2.y < block1.y then
				return backMultiplier
			elseif block2.y == block1.y then
				return sideMultiplier
			elseif block2.y > block1.y then
				return frontMultiplier
			end
			
		elseif block2.side == 1 then
			if block2.y < block1.y then
				if block2.x >= block1.x then
					return sideMultiplier
				elseif block2.x < block1.x then
					return frontMultiplier
				end
			elseif block2.y == block1.y then
				if block2.x < block1.x then
					return frontMultiplier
				elseif block2.x > block1.x then
					return backMultiplier
				end
			elseif block2.y > block1.y then
				if block2.x >= block1.x then
					return sideMultiplier
				elseif block2.x < block1.x then
					return frontMultiplier
				end
			end
			
		elseif block2.side == 2 then
			if block2.y > block1.y then
				return backMultiplier
			elseif block2.y < block1.y then
				return frontMultiplier
			elseif block2.y == block1.y then
				return sideMultiplier
			end
			
		elseif block2.side == 3 then
			if block2.y > block1.y then
				if block2.x <= block1.x then
					return sideMultiplier
				elseif block2.x > block1.x then
					return frontMultiplier
				end
			elseif block2.y < block1.y then
				if block2.x <= block1.x then
					return sideMultiplier
				elseif block2.x > block1.x then
					return frontMultiplier
				end 
			elseif block2.y == block1.y then
				if block2.x < block1.x then
					return backMultiplier
				elseif block2.x > block1.x then
					return frontMultiplier
				end
			end
		end
	end
end
}

findOpenTileAround = function(player)

	local m, x, y = player.m, player.x, player.y
	
	local tileS =  checkOpenCell(m,x,y+1)
	local tileSW = checkOpenCell(m,x-1,y+1)
	local tileW =  checkOpenCell(m,x-1,y)
	local tileNW = checkOpenCell(m,x-1,y-1)
	local tileN =  checkOpenCell(m,x,y-1)
	local tileNE = checkOpenCell(m,x+1,y-1)
	local tileE =  checkOpenCell(m,x+1,y)
	local tileSE = checkOpenCell(m,x+1,y+1)
	
	if tileS == 1 then 
		return x, y+1 
	end
	
	if tileSW == 1 then 
		return x-1, y+1 
	end
	
	if tileW == 1 then 
		return x-1, y 
	end
	
	if tileNW == 1 then 
		return x-1, y-1 
	end
	
	if tileN == 1 then 
		return x, y-1 
	end
	
	if tileNE== 1 then 
		return x+1, y-1 
	end
	
	if tileE == 1 then 
		return x+1, y 
	end
	
	if tileSE == 1 then 
		return x+1, y+1 
	end

end

findOpenTileSide = function(player)

	local m, x, y = player.m, player.x, player.y
	
	local tileS =  checkOpenCell(m,x,y+1)
	local tileSW = checkOpenCell(m,x-1,y+1)
	local tileW =  checkOpenCell(m,x-1,y)
	local tileNW = checkOpenCell(m,x-1,y-1)
	local tileN =  checkOpenCell(m,x,y-1)
	local tileNE = checkOpenCell(m,x+1,y-1)
	local tileE =  checkOpenCell(m,x+1,y)
	local tileSE = checkOpenCell(m,x+1,y+1)
	
	if tileS == 1 then 
		return x, y+1 
	end
	
	if tileW == 1 then 
		return x-1, y 
	end
	
	if tileN == 1 then 
		return x, y-1 
	end
	
	if tileE == 1 then 
		return x+1, y 
	end
	
	if tileSW == 1 then 
		return x-1, y+1 
	end
	
	if tileNW == 1 then 
		return x-1, y-1 
	end
	
	if tileNE== 1 then 
		return x+1, y-1 
	end
	
	if tileSE == 1 then 
		return x+1, y+1 
	end

end