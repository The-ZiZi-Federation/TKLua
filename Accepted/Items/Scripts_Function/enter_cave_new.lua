caveBlockerLeveled = {

walk = function(player)

	if player.blType ~= BL_PC then
		return 
	end
	
	local m, x, y = player.m, player.x, player.y
	
	local name = ""
	local vita, mana = player.baseHealth, player.baseMagic

	local level = player.level
	local text = 4
	
	local cave = 0

	local cave2Map = 0
	local cave3Map = 0
	
	local entranceX = 0
	local entranceY = 0
	
	local cave1Req = 0
	local cave2Req = 0
	local cave3Req = 0
	

	if m == 1000 then	--Hon by the Sea
		if x >= 63 and x <= 64 then
			if y == 122 then	--earthworks
				name = "The Earthworks"
				entranceX = (x - 46)
				entranceY = 18
				
				cave2Map = 1251
				cave3Map = 1291
				
				cave1Req = 10
				cave2Req = 45
				cave3Req = 95
				cave = 1
				
			end
		elseif x >= 1 and x <= 2 then
			if y == 89 then	 --fox
				name = "Fox Hole"
				entranceX = (x + 6)
				entranceY = 38
				
				cave2Map = 1261
				cave3Map = 1301
			
				cave1Req = 15
				cave2Req = 55
				cave3Req = 15000
				cave = 1
				
			end
		elseif x >= 26 and x <= 27 then
			if y == 11 then	--bat cave
				name = "Bat Sanctum"
				entranceX = (x - 23)
				entranceY = 13
				
				cave2Map = 1281
				cave3Map = 1321
				
				cave1Req = 20
				cave2Req = 75
				cave3Req = 30000
				cave = 1
				
			end		
		end
	elseif m == 1001 then	--West Shores of Hon
	
		if x >= 13 and x <= 14 then
			if y == 32 then	--haunted house
				name = "Haunted House"
				entranceX = (x + 9)
				entranceY = 38
				
				cave2Map = 1271
				cave3Map = 1311
				
				cave1Req = 20
				cave2Req = 65
				cave3Req = 20000
				cave = 1
				
			end
		end
	elseif m == 1002 then 	--Hon Harbor
		if x >= 20 and x <= 21 then
			if y == 58 then	--bat cave
				name = "Bat Sanctum"
				entranceX = (x - 9)
				entranceY = 13
				
				cave2Map = 1283
				cave3Map = 1323
				
				cave1Req = 20
				cave2Req = 75
				cave3Req = 30000
				cave = 1
				
			end
		end
	end
	
	if cave == 0 then return end
	
	if cave1Req <= 999 then
		if level < cave1Req then
			anim(player)
			pushBack(player)
			caveBlockerLeveled.popUp(player, text, name)
		end
	elseif cave1Req >= 1000 then
		if player.level >= 99 then
			if vita < cave1Req and mana < cave1Req then
				anim(player)
				pushBack(player)
				caveBlockerLeveled.popUp(player, text, name)
			end
		end
	end

	if cave2Req <= 999 then
		if level >= cave2Req and level < cave3Req then
			pushBack(player)
			player:warp(cave2Map, entranceX, entranceY)
		end	
	elseif cave2Req >= 1000 then
		if player.level >= 99 then
			if (vita >= cave2Req  or mana >= cave2Req) and (vita < cave3Req and mana < cave3Req) then
				pushBack(player)
				player:warp(cave2Map, entranceX, entranceY)
			end
		end
	end

	if cave3Req <= 999 then
		if level >= cave3Req then
			pushBack(player)
			player:warp(cave3Map, entranceX, entranceY)
		end
	elseif cave3Req >= 1000 then
		if player.level >= 99 then			
			if vita >= cave3Req or mana >= cave3Req then		
				pushBack(player)
				player:warp(cave3Map, entranceX, entranceY)
			end
		end
	end
end,

popUp = function(player, text, name)

	cave = "<b>["..name.."]\n\n"


	if text == 0 or text == 1 then
		txt = "Nightmarish visions prevent you from moving further.\n"
	elseif text == 2 then
		txt = "You see wild animals far away. You realize you are much weaker than them.\n"
	elseif text == 3 then
		txt = "Knowing your lack of knowledge about this place, your mind prevents your body to go further.\n"
	elseif text == 4 then
		txt = "You get chills and goosebumps by just standing near the door. You know you shouldn't be here.\n"
	elseif text == 5 then
		txt = "The creatures inside make a threatening growl.\n\nThey're not intimidated by your presence. You should leave for your own safety.\n"
	elseif text == 6 then
		txt = "Your conscious gets the better of you. You know that you are too weak to face whatever is inside.\n"
	elseif text == 7 then
		txt = "A powerful force repels you. You cannot enter as you are now.\n"
	end
	player:popUp(cave..""..txt)
end
}
