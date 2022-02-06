end_open = function(player)

	-- yes, this is it.

	local side = player.side
	local m = player.m
	local x = player.x
	local y = player.y

	publicBoards(player)

	if (side == 0) then
		y = y - 1
	elseif (side == 1) then
		x = x + 1
	elseif (side == 2) then
		y = y + 1
	elseif (side == 3) then
		x = x - 1
	else
		broadcast(-1,""..player.name.." is hacking.")
	end

	local obj = getObject(m, x, y)
	local pass = getPass(m, x, y)

	local facingObj = getObjFacing(player,player.side)


	--By Coords
	water_sumo.ressurect(player)

	if m == 4153 then
		if obj == 338 or obj == 339 then
			player:talkSelf(0, player.name..": This door is locked. I probably need a key.")
			return
		end
	return
	end
	
	if m == 4172 then
		if obj == 338 or obj == 339 then
			player:talkSelf(0, player.name..": This door is locked. I probably need a key.")
			return
		end
	return
	end
	
	if m == 4157 then
		if facingObj == 12118 or facingObj == 12119 or facingObj == 12120 then
			ice_palace_hidden_door.open_1(player)
		end
	end
	
	if m == 4176 then
		if facingObj == 12118 or facingObj == 12119 or facingObj == 12120 then
			ice_palace_hidden_door.open_2(player)
		end
	end
	
	if obj == 16667 then
		player:addItem("tiny_health_potion", 1)
		player:talk(0, player.name.. ": A health potion! That will be useful.")
		setObject(m, x, y, 0)
	end


	-- Fruit Basket1
	if (obj == 680) then
		if player.registry["took_fruit1"] < os.time() then
			player:addItem(206, 1)
			player.registry["took_fruit1"] = os.time()+43200000
			player:talk(0, player.name.. ": This banana looks good!")
		else
			player:msg(4, player.name.. ": I already took one. Timer("..player.registry["took_fruit"]-os.time().." sec)", player.ID)
		end
	end
	
	-- Fruit Basket2
	if (obj == 15278) then
		if player.registry["took_fruit2"] < os.time() then
			player:addItem(206, 1)
			player.registry["took_fruit2"] = os.time()+43200000
			player:talk(0, player.name.. ": This banana looks good!")
		else
			player:msg(4, player.name.. ": I already took one. Timer("..player.registry["took_fruit"]-os.time().." sec)", player.ID)
		end
	end

	-- Mystery Meat1
	if (obj == 679) then
		if player.registry["took_mystery_meat1"] < os.time() then
			player:addItem(211, 1)
			player.registry["took_mystery_meat1"] = os.time()+43200000
			player:talk(0, player.name.. ": This looks delicious. I wonder what it is!")
		else
			player:msg(4, player.name.. ": I already took one. Timer("..player.registry["took_mystery_meat"]-os.time().." sec)", player.ID)
		end
	end
	
	-- Mystery Meat2
	if (obj == 15277) then
		if player.registry["took_mystery_meat2"] < os.time() then
			player:addItem(211, 1)
			player.registry["took_mystery_meat2"] = os.time()+43200000
			player:talk(0, player.name.. ": This looks delicious. I wonder what it is!")
		else
			player:msg(4, player.name.. ": I already took one. Timer("..player.registry["took_mystery_meat"]-os.time().." sec)", player.ID)
		end
	end

	-- Little Orange Fish
	if (obj == 12439) or (obj == 12440) then
		if player.registry["took_little_orange_fish_table"] < os.time() then
			player:addItem(213, 1)
			player.registry["took_little_orange_fish_table"] = os.time()+43200000
			player:talk(0, player.name.. ": Woah, free fish by pressing o, I should try this all over!")
		else
			player:msg(4, player.name.. ": I already took one. Timer("..player.registry["took_little_orange_fish_table"]-os.time().." sec)", player.ID)
		end
	end

	-- Little Blue Fish on Table
	if (obj == 12442) or (obj == 12443) or (obj == 12444) then
		if player.registry["took_little_blue_fish_table"] < os.time() then
			player:addItem(212, 1)
			player.registry["took_little_blue_fish_table"] = os.time()+43200000
			player:talk(0, player.name.. ": Woah, free fish by pressing o, I should try this all over!")
		else
			player:msg(4, player.name.. ": I already took one. Timer("..player.registry["took_little_blue_fish_table"]-os.time().." sec)", player.ID)
		end
	end

	-- Little Blue Fish in Barrel
	if (obj == 12445) then
		if player.registry["took_little_blue_fish_barrel"] < os.time() then
			player:addItem(212, 1)
			player.registry["took_little_blue_fish_barrel"] = os.time()+43200000
			player:talk(0, player.name.. ": Woah, free fish by pressing o, I should try this all over!")
		else
			player:msg(4, player.name.. ": I already took one. Timer("..player.registry["took_little_blue_fish_barrel"]-os.time().." sec)", player.ID)
		end
	end

	-- Little Blue Fish in crate
	if (obj == 15799) then
		if player.registry["took_little_blue_fish_crate"] < os.time() then
			player:addItem(212, 1)
			player.registry["took_little_blue_fish_crate"] = os.time()+43200000
			player:talk(0, player.name.. ": Woah, free fish by pressing o, I should try this all over!")
		else
			player:msg(4, player.name.. ": I already took one. Timer("..player.registry["took_little_blue_fish_barrel"]-os.time().." sec)", player.ID)
		end
	end

	-- Island Shaman Child Skull
	if (m == 1104) then
		if  (obj == 13909) or (obj == 13910) or (obj == 13911) or (obj == 13912) then
			if player.registry["took_child_skull"] == 0 then
				player:addItem(214, 1)
				player.registry["took_child_skull"] = 1
				player:talk(0, player.name.. ": You never know when a human skull will come in handy.")
			else
				player:talk(0, player.name.. ": One skull is probably enough.")
			end
		end
	end
-------------------DOORS-----BELOW-----------------------------------------------


	-- Hon Harbor Storage
	if (obj == 15670) then
		setObject(m, x, y, 15651)
		setObject(m, x + 1, y, 15652)
		player:playSound(404)
	elseif (obj == 15671) then
		setObject(m, x, y, 15652)
		setObject(m, x - 1, y, 15651)
	end

	if (obj == 15651) then
		setObject(m, x, y, 15670)
		setObject(m, x + 1, y, 15671)
		player:playSound(404)
	elseif (obj == 15652) then
		setObject(m, x, y, 15671)
		setObject(m, x - 1, y, 15670)
	end

	-- 3 tile inn door
	if (obj == 17412) then
		setObject(m, x - 1, y, 17419)
		setObject(m, x, y, 17420)
		setObject(m, x + 1, y, 17421)
		player:playSound(404)
	elseif (obj == 17420) then
		setObject(m, x - 1, y, 17411)
		setObject(m, x, y, 17412)
		setObject(m, x + 1, y, 17413)
		player:playSound(405)
	end

	-- 3 tile inn doors
	if (obj == 17408) then
		setObject(m, x - 1, y, 17416)
		setObject(m, x, y, 17417)
		setObject(m, x + 1, y, 17418)
		player:playSound(404)
	elseif (obj == 17417) then
		setObject(m, x - 1, y, 17407)
		setObject(m, x, y, 17408)
		setObject(m, x + 1, y, 17409)
		player:playSound(405)
	end

	-- 3 tile door
	if (obj == 17380) then
		setObject(m, x -1, y, 17383)
		setObject(m, x, y, 17384)
		setObject(m, x + 1, y, 17385)
	elseif (obj == 17384) then
		setObject(m, x-1, y, 17379)
		setObject(m, x, y, 17380)
		setObject(m, x + 1, y, 17381)
	end


	-- Yin Yang Doors
	if (obj == 783) then
		setObject(m, x, y, 790)
		setObject(m, x + 1, y, 791)
	elseif (obj == 790) then
		setObject(m, x, y, 783)
		setObject(m, x + 1, y, 784)
	end

	if (obj == 784) then
		setObject(m, x - 1, y, 790)
		setObject(m, x, y, 791)
	elseif (obj == 791) then
		setObject(m, x - 1, y, 783)
		setObject(m, x, y, 784)
	end

	--  Innkeeper Doors
	if (obj == 374) then
		setObject(m, x, y, 352)
		setObject(m, x + 1, y, 353)
	elseif (obj == 352) then
		setObject(m, x, y, 374)
		setObject(m, x + 1, y, 375)
	end

	if (obj == 375) then
		setObject(m, x - 1, y, 352)
		setObject(m, x, y, 353)
	elseif (obj == 353) then
		setObject(m, x -1, y, 374)
		setObject(m, x, y, 375)
	end

	-- Arena Doors
	if (obj == 14619) then
		setObject(m, x, y, 14497)
		setObject(m, x + 1, y, 14498)
		setObject(m, x + 2, y, 14499)
	elseif (obj == 14620) then
		setObject(m, x, y, 14498)
		setObject(m, x - 1, y, 14497)
		setObject(m, x + 1, y, 14499)
	elseif (obj == 14621) then
		setObject(m, x, y, 14499)
		setObject(m, x - 1, y, 14498)
		setObject(m, x - 2, y, 14497)
	end


	if (obj == 14497) then
		setObject(m, x, y, 14619)
		setObject(m, x + 1, y, 14620)
		setObject(m, x + 2, y, 14621)
	elseif (obj == 14498) then
		setObject(m, x, y, 14620)
		setObject(m, x - 1, y, 14619)
		setObject(m, x + 1, y, 14621)
	elseif (obj == 14499) then
		setObject(m, x, y, 14621)
		setObject(m, x - 1, y, 14620)
		setObject(m, x - 2, y, 14619)
	end

	-- North and South Gate
	if (obj == 16) then
		setObject(m, x - 1, y, 5)
		setObject(m, x, y, 6)
		setObject(m, x + 1, y, 7)
		setObject(m, x + 2, y, 8)
	elseif (obj == 17) then
		setObject(m, x - 2, y, 5)
		setObject(m, x - 1, y, 6)
		setObject(m, x, y, 7)
		setObject(m, x + 1, y, 8)
	end


	if (obj == 6) then
		setObject(m, x - 1, y, 15)
		setObject(m, x, y, 16)
		setObject(m, x + 1, y, 17)
		setObject(m, x + 2, y, 18)
	elseif (obj == 7) then
		setObject(m, x - 2, y, 15)
		setObject(m, x - 1, y, 16)
		setObject(m, x, y, 17)
		setObject(m, x + 1, y, 18)
	end

	--purple top shack
	if (obj == 14613) then
		setObject(m, x, y, 14472)
		setObject(m, x + 1, y, 14473)
	elseif (obj == 14614) then
		setObject(m, x, y, 14473)
		setObject(m, x - 1, y, 14472)
	end

	if (obj == 14472) then
		setObject(m, x, y, 14613)
		setObject(m, x + 1, y, 14614)
	elseif (obj == 14473) then
		setObject(m, x, y, 14614)
		setObject(m, x - 1, y, 14613)
	end

	-- Three Tree Office Door
	if (obj == 14605) then
		setObject(m, x, y, 14438)
	elseif (obj == 14438) then
		setObject(m, x, y, 14605)
	end

	-- 2 tile inn door
	if (obj == 17636) then
		setObject(m, x, y, 17640)
		setObject(m, x + 1, y, 17641)
	elseif (obj == 17637) then
		setObject(m, x, y, 17641)
		setObject(m, x - 1, y, 17640)
	end

	if (obj == 17640) then
		setObject(m, x, y, 17636)
		setObject(m, x + 1, y, 17637)
	elseif (obj == 17641) then
		setObject(m, x, y, 17637)
		setObject(m, x - 1, y, 17636)
	end

	-- Armorsmith
	if (obj == 6728) then
		setObject(m, x, y, 6645)
		setObject(m, x + 1, y, 6646)
	elseif (obj == 6729) then
		setObject(m, x, y, 6646)
		setObject(m, x - 1, y, 6645)
	end

	if (obj == 6645) then
		setObject(m, x, y, 6728)
		setObject(m, x + 1, y, 6729)
	elseif (obj == 6646) then
		setObject(m, x, y, 6729)
		setObject(m, x - 1, y, 6728)
	end

	-- Finer things
	if (obj == 6730) then
		setObject(m, x, y, 6659)
		setObject(m, x + 1, y, 6660)
	elseif (obj == 6731) then
		setObject(m, x, y, 6660)
		setObject(m, x - 1, y, 6659)
	end

	if (obj == 6659) then
		setObject(m, x, y, 6730)
		setObject(m, x + 1, y, 6731)
	elseif (obj == 6660) then
		setObject(m, x, y, 6731)
		setObject(m, x - 1, y, 6730)
	end

	-- Fancy Door
	if (obj == 10000) then
		setObject(m, x, y, 10002)
		setObject(m, x + 1, y, 10003)
	elseif (obj == 10001) then
		setObject(m, x, y, 10003)
		setObject(m, x - 1, y, 10002)
	end

	if (obj == 10002) then
		setObject(m, x, y, 10000)
		setObject(m, x + 1, y, 10001)
	elseif (obj == 10003) then
		setObject(m, x, y, 10001)
		setObject(m, x - 1, y, 10000)
	end


	--Parcel doors
	if (obj == 364) then
		setObject(m, x, y, 358)
		setObject(m, x + 1, y, 359)
	elseif (obj == 365) then
		setObject(m, x, y, 359)
		setObject(m, x - 1, y, 358)
	end

	if (obj == 358) then
		setObject(m, x, y, 364)
		setObject(m, x + 1, y, 365)
	elseif (obj == 359) then
		setObject(m, x, y, 365)
		setObject(m, x - 1, y, 364)
	end

	--Next to Priest doors
	if (obj == 14606) then
		setObject(m, x, y, 14443)
		setObject(m, x + 1, y, 14444)
	elseif (obj == 14607) then
		setObject(m, x, y, 14444)
		setObject(m, x - 1, y, 14443)
	end

	if (obj == 14443) then
		setObject(m, x, y, 14606)
		setObject(m, x + 1, y, 14607)
	elseif (obj == 14444) then
		setObject(m, x, y, 14607)
		setObject(m, x - 1, y, 14606)
	end

	-- Priest doors
	if (obj == 14616) then
		setObject(m, x, y, 14488)
		setObject(m, x + 1, y, 14489)
		setObject(m, x + 2, y, 14490)
	elseif (obj == 14617) then
		setObject(m, x - 1, y, 14488)
		setObject(m, x, y, 14489)
		setObject(m, x + 1, y, 14490)
	elseif (obj == 14618) then
		setObject(m, x, y, 14490)
		setObject(m, x - 1, y, 14489)
		setObject(m, x - 2, y, 14488)
	end

	if (obj == 14488) then
		setObject(m, x, y, 14616)
		setObject(m, x + 1, y, 14617)
		setObject(m, x + 2, y, 14618)
	elseif (obj == 14489) then
		setObject(m, x - 1, y, 14616)
		setObject(m, x, y, 14617)
		setObject(m, x + 1, y, 14618)
	elseif (obj == 14490) then
		setObject(m, x, y, 14618)
		setObject(m, x - 1, y, 14617)
		setObject(m, x - 2, y, 14616)
	end

	--festive building
		if (obj == 285) then
		setObject(m, x, y, 283)
		setObject(m, x + 1, y, 284)
	elseif (obj == 286) then
		setObject(m, x, y, 284)
		setObject(m, x - 1, y, 283)
	end
	if (obj == 283) then
		setObject(m, x, y, 285)
		setObject(m, x + 1, y, 286)
	elseif (obj == 284) then
		setObject(m, x, y, 286)
		setObject(m, x - 1, y, 285)
	end

	-- alchemy

	if (obj == 362) then
		setObject(m, x, y, 344)
		setObject(m, x + 1, y, 345)
	elseif (obj == 363) then
		setObject(m, x, y, 345)
		setObject(m, x - 1, y, 344)
	end

	if (obj == 344) then
		setObject(m, x, y, 362)
		setObject(m, x + 1, y, 363)
	elseif (obj == 345) then
		setObject(m, x, y, 363)
		setObject(m, x - 1, y, 362)
	end

	-- houseboat
		if (obj == 372) then
		setObject(m, x, y, 394)
		setObject(m, x + 1, y, 395)
	elseif (obj == 373) then
		setObject(m, x, y, 395)
		setObject(m, x - 1, y, 394)
	end

	if (obj == 394) then
		setObject(m, x, y, 372)
		setObject(m, x + 1, y, 373)
	elseif (obj == 395) then
		setObject(m, x, y, 373)
		setObject(m, x - 1, y, 372)
	end

	-- top right
	if (obj == 14601) then
		setObject(m, x, y, 14416)
	elseif (obj == 14416) then
		setObject(m, x, y, 14601)
	end


	-- top left
		if (obj == 14612) then
		setObject(m, x, y, 14467)
	elseif (obj == 14467) then
		setObject(m, x, y, 14612)
	end

	-- weaponsmith doors with xxx

	if (obj == 366) then
		setObject(m, x, y, 346)
		setObject(m, x + 1, y, 347)
	elseif (obj == 367) then
		setObject(m, x, y, 347)
		setObject(m, x - 1, y, 346)
	end

	if (obj == 346) then
		setObject(m, x, y, 366)
		setObject(m, x + 1, y, 367)
	elseif (obj == 347) then
		setObject(m, x, y, 367)
		setObject(m, x - 1, y, 366)
	end

	-- butcher  doors with xxx
	if (obj == 773) then
		setObject(m, x, y, 350)
		setObject(m, x + 1, y, 351)
	elseif (obj == 774) then
		setObject(m, x, y, 351)
		setObject(m, x - 1, y, 350)
	end

	if (obj == 350) then
		setObject(m, x, y, 773)
		setObject(m, x + 1, y, 774)
	elseif (obj == 351) then
		setObject(m, x, y, 774)
		setObject(m, x - 1, y, 773)
	end

	-- rogue guild
	if (obj == 14615) then
		setObject(m, x, y, 14481)
	elseif (obj == 14481) then
		setObject(m, x, y, 14615)
	end

	-- boat shack
	if (obj == 14591) then
		setObject(m, x, y, 14377)
	elseif (obj == 14377) then
		setObject(m, x, y, 14591)
	end

	-- cathay top left blue top 2 story stop sign doors
	if (obj == 3189) then
		setObject(m, x, y, 3187)
		setObject(m, x + 1, y, 3188)
	elseif (obj ==3190) then
		setObject(m, x, y, 3188)
		setObject(m, x - 1, y, 3187)
	end

	if (obj == 3187) then
		setObject(m, x, y, 3189)
		setObject(m, x + 1, y, 3190)
	elseif (obj == 3188) then
		setObject(m, x, y, 3190)
		setObject(m, x - 1, y, 3189)
	end

	-- cathay shop doors
	if (obj == 354) then
		setObject(m, x, y, 368)
		setObject(m, x + 1, y, 369)
	elseif (obj == 355) then
		setObject(m, x, y, 369)
		setObject(m, x - 1, y, 368)
	end

	if (obj == 368) then
		setObject(m, x, y, 354)
		setObject(m, x + 1, y, 355)
	elseif (obj == 369) then
		setObject(m, x, y, 355)
		setObject(m, x - 1, y, 354)
	end

	-- cathay stairs up wood doors
	if (obj == 14077) then
		setObject(m, x, y, 14079)
		setObject(m, x + 1, y, 14080)
	elseif (obj ==14078) then
		setObject(m, x, y, 14080)
		setObject(m, x - 1, y, 14079)
	end

	if (obj == 14079) then
		setObject(m, x, y, 14077)
		setObject(m, x + 1, y, 14078)
	elseif (obj == 14080) then
		setObject(m, x, y, 14078)
		setObject(m, x - 1, y, 14077)
	end

	-- cathay clothes shop doors
	if (obj == 348) then
		setObject(m, x, y, 376)
		setObject(m, x + 1, y, 377)
	elseif (obj == 349) then
		setObject(m, x, y, 377)
		setObject(m, x - 1, y, 376)
	end

	if (obj == 376) then
		setObject(m, x, y, 348)
		setObject(m, x + 1, y, 349)
	elseif (obj == 377) then
		setObject(m, x, y, 349)
		setObject(m, x - 1, y, 348)
	end

	-- cathay armor shop doors
	if (obj == 356) then
		setObject(m, x, y, 370)
		setObject(m, x + 1, y, 371)
	elseif (obj == 356) then
		setObject(m, x, y, 371)
		setObject(m, x - 1, y, 370)
	end

	if (obj == 370) then
		setObject(m, x, y, 356)
		setObject(m, x + 1, y, 357)
	elseif (obj == 371) then
		setObject(m, x, y, 357)
		setObject(m, x - 1, y, 356)
	end

	-- cathay inns
	if (obj == 342) then
		setObject(m, x, y, 378)
		setObject(m, x + 1, y, 379)
	elseif (obj == 343) then
		setObject(m, x, y, 379)
		setObject(m, x - 1, y, 378)
	end

	if (obj == 378) then
		setObject(m, x, y, 342)
		setObject(m, x + 1, y, 343)
	elseif (obj == 379) then
		setObject(m, x, y, 343)
		setObject(m, x - 1, y, 342)
	end

	-- cathay e gate building
	if (obj == 1852) then
		if player.m == 4000 then
			if player.mapRegistry["arena_door"] == 0 then
				setObject(m, x, y-1, 338)
				setObject(m, x + 1, y-1, 339)
				player.mapRegistry["arena_door"] = 1
			elseif player.mapRegistry["arena_door"] == 1 then
				setObject(m, x, y-1, 360)
			    setObject(m, x + 1, y-1, 361)
				player.mapRegistry["arena_door"] = 0
			end
		end
	elseif (obj == 1853) then
		if player.m == 4000 then
			if player.mapRegistry["arena_door"] == 0 then
				setObject(m, x - 1, y-1, 338)
				setObject(m, x , y-1, 339)
				player.mapRegistry["arena_door"] = 1
			elseif player.mapRegistry["arena_door"] == 1 then
				setObject(m, x - 1, y-1, 360)
			    setObject(m, x, y-1, 361)
				player.mapRegistry["arena_door"] = 0
			end
		end
	end
	
	
	-- cathay house of the owl
	
	if obj == 9926 or obj == 9927 or obj == 9928 then
		if player.m == 4069 then
			setObject(m, 7, 3, 9940)
			setObject(m, 8, 3, 9945)
			setObject(m, 9, 3, 9942)
		end
	elseif obj == 9940 or obj == 9945 or obj == 9942 then
		if player.m == 4069 then
			setObject(m, 7, 3, 9926)
			setObject(m, 8, 3, 9927)
			setObject(m, 9, 3, 9928)
		end
	
	end
	
	--Dharma Clan door
	
	
	if obj == 340 then
		setObject(m, x, y, 753)
		setObject(m, x + 1, y, 754)
	
	elseif obj == 341 then
		setObject(m, x-1, y, 753)
		setObject(m, x, y, 754)
	end
	
	if obj == 753 then
		setObject(m, x, y, 340)
		setObject(m, x + 1, y, 341)
	
	elseif obj == 754 then
		setObject(m, x-1, y, 340)
		setObject(m, x, y, 341)
	end
	
--[[
	if (getObject(m, x, y) == 338 then
		setObject(m, x, y, 1852)
		setObject(m, x + 1, y, 1853)
	elseif (getObject(m, x, y) == 339 then
		setObject(m, x, y-1, 1853)
		setObject(m, x - 1, y-1, 1852)
	end
]]--

	-- cathay blue top gates
		if (obj == 51) then
		setObject(m, x, y, 114)
	elseif (obj == 114) then
		setObject(m, x, y, 51)
	end

	if (obj == 57) then
		setObject(m, x, y, 115)
	elseif (obj == 115) then
		setObject(m, x, y, 57)
	end

	if (obj == 97) then
		setObject(m, x + 1, y, 110)
		setObject(m, x, y, 109)
		setObject(m, x - 1, y, 108)
	elseif (obj == 109) then
		setObject(m, x + 1, y, 98)
		setObject(m, x, y, 97)
		setObject(m, x - 1, y, 96)
	end

	if (obj == 53) then
		setObject(m, x, y, 102)
		setObject(m, x + 1, y, 103)
		setObject(m, x + 2, y, 104)
	elseif (obj == 54) then
		setObject(m, x - 1, y, 102)
		setObject(m, x, y, 103)
		setObject(m, x + 1, y, 104)
	elseif (obj == 55) then
		setObject(m, x - 2, y, 102)
		setObject(m, x - 1, y, 103)
		setObject(m, x, y, 104)
	end

	if (obj == 102) then
		setObject(m, x, y, 53)
		setObject(m, x + 1, y, 54)
		setObject(m, x + 2, y, 55)
	elseif (obj == 103) then
		setObject(m, x - 1, y, 53)
		setObject(m, x, y, 54)
		setObject(m, x + 1, y, 55)
	elseif (obj == 104) then
		setObject(m, x - 2, y, 53)
		setObject(m, x - 1, y, 54)
		setObject(m, x, y, 55)
	end

	-- unknown red gates top gates
		if (obj == 76) then
		setObject(m, x, y, 116)
	elseif (obj == 116) then
		setObject(m, x, y, 76)
	end

	if (obj == 82) then
		setObject(m, x, y, 117)
	elseif (obj == 117) then
		setObject(m, x, y, 82)
	end

	if (obj == 100) then
		setObject(m, x + 1, y, 113)
		setObject(m, x, y, 112)
		setObject(m, x - 1, y, 111)
	elseif (obj == 112) then
		setObject(m, x + 1, y, 101)
		setObject(m, x, y, 100)
		setObject(m, x - 1, y, 99)
	end

	if (obj == 78) then
		setObject(m, x, y, 105)
		setObject(m, x + 1, y, 106)
		setObject(m, x + 2, y, 107)
	elseif (obj == 79) then
		setObject(m, x - 1, y, 105)
		setObject(m, x, y, 106)
		setObject(m, x + 1, y, 107)
	elseif (obj == 80) then
		setObject(m, x - 2, y, 105)
		setObject(m, x - 1, y, 106)
		setObject(m, x, y, 107)
	end

	if (obj == 105) then
		setObject(m, x, y, 78)
		setObject(m, x + 1, y, 79)
		setObject(m, x + 2, y, 80)
	elseif (obj == 106) then
		setObject(m, x - 1, y, 78)
		setObject(m, x, y, 79)
		setObject(m, x + 1, y, 80)
	elseif (obj == 107) then
		setObject(m, x - 2, y, 78)
		setObject(m, x - 1, y, 79)
		setObject(m, x, y, 80)
	end

	-- evil doors
	if (obj == 16300) then
		setObject(m, x, y, 16303)
		setObject(m, x + 1, y, 16304)
		setObject(m, x + 2, y, 16305)
	elseif (obj == 16301) then
		setObject(m, x - 1, y, 16303)
		setObject(m, x, y, 16304)
		setObject(m, x + 1, y, 16305)
	elseif (obj == 16302) then
		setObject(m, x - 2, y, 16303)
		setObject(m, x - 1, y, 16304)
		setObject(m, x, y, 16305)
	end

	if (obj == 16303) then
		setObject(m, x, y, 16300)
		setObject(m, x + 1, y, 16301)
		setObject(m, x + 2, y, 16302)
	elseif (obj == 16304) then
		setObject(m, x - 1, y, 16300)
		setObject(m, x, y, 16301)
		setObject(m, x + 1, y, 16302)
	elseif (obj == 16305) then
		setObject(m, x - 2, y, 16300)
		setObject(m, x - 1, y, 16301)
		setObject(m, x, y, 16302)
	end

	-- cathay scary main doors
	if (obj == 16247) then
		setObject(m, x, y, 16251)
		setObject(m, x + 1, y, 16252)
		setObject(m, x + 2, y, 16253)
		setObject(m, x + 3, y, 16254)
	elseif (obj == 16248) then
		setObject(m, x - 1, y, 16251)
		setObject(m, x, y, 16252)
		setObject(m, x + 1, y, 16253)
		setObject(m, x + 2, y, 16254)
	elseif (obj == 16249) then
		setObject(m, x - 2, y, 16251)
		setObject(m, x - 1, y, 16252)
		setObject(m, x, y, 16253)
		setObject(m, x + 1, y, 16254)
	elseif (obj == 16250) then
		setObject(m, x - 3, y, 16251)
		setObject(m, x - 2, y, 16252)
		setObject(m, x - 1, y, 16253)
		setObject(m, x, y, 16254)
	end

	if (obj == 16251) then
		setObject(m, x, y, 16247)
		setObject(m, x + 1, y, 16248)
		setObject(m, x + 2, y, 16249)
		setObject(m, x + 3, y, 16250)
	elseif (obj == 16252) then
		setObject(m, x - 1, y, 16247)
		setObject(m, x, y, 16248)
		setObject(m, x + 1, y, 16249)
		setObject(m, x + 2, y, 16250)
	elseif (obj == 16253) then
		setObject(m, x - 2, y, 16247)
		setObject(m, x - 1, y, 16248)
		setObject(m, x, y, 16249)
		setObject(m, x + 1, y, 16250)
	elseif (obj == 16254) then
		setObject(m, x - 3, y, 16247)
		setObject(m, x - 2, y, 16248)
		setObject(m, x - 1, y, 16249)
		setObject(m, x, y, 16250)
	end

	-- cathay church doors
	if (obj == 128) then
		setObject(m, x, y, 130)
		setObject(m, x + 1, y, 131)
	elseif (obj == 129) then
		setObject(m, x, y, 131)
		setObject(m, x - 1, y, 130)
	end

	if (obj == 130) then
		setObject(m, x, y, 128)
		setObject(m, x + 1, y, 129)
	elseif (obj == 131) then
		setObject(m, x, y, 129)
		setObject(m, x - 1, y, 128)
	end
---------------------------END---OF---DOORS-------------------------------------
---------------------RANDOM--------NO----------ITEM---------OBJECTS-------------
	-- hon recipe bartender (Rune Weapon Recipes)
	if (m == 1000) then
		if (x == 14) and (y == 139) then
			if (obj == 15270) then
				player:popUp("             Rune Recipes:\n---------------------------------------\n\n          Basic Rune Weapons:\n\n1 Basic Rune\n1 of any Training Weapon\n---------------------------------------\n\n          Bloody Rune Weapons:\n\n1 Bloody Enchant Rune\n1 of any Level 50 Bloody Weapon\n---------------------------------------\n\n          Eldritch Rune Weapons:\n\n1 Eldritch Enchant Rune\n5 Basic Runes\n1 of any Level 99 Enchanted Weapons\n---------------------------------------\n")
			end
		end
	end
	
	-- hon recipe parcel shop (Cooking Recipe I)
	if (m == 1026) then
		if (x == 13) and (y == 11) then
			if (obj == 16550) then
				player:popUp("             Cooking Recipes:\n---------------------------------------\n\n          Meatloaf:\n\n1 Goldfish Chunk\n1 Browned Beef\n1 Empty Bowl\nRumor has it you can taint this meal somehow.\n---------------------------------------\n\n          Omelet and Loaf:\n\n1 Empty Bowl\n25 Lima beans\n1 Loaf of Bread\n12 Eggs\n---------------------------------------\n")
			end
		end
	end
	
	-- hon recipe harveys shop (Kumiho Earring)
	if (m == 1034) then
		if (x == 11) and (y == 6) then
			if (obj == 15270) then
				player:popUp("             New Earring Recipe:\n---------------------------------------\n\n          Kumiho Earring:\n\n1 Kumiho gem\n1 Earring Back\nYou will need to do this two seperate times to get a pair of matching Earrings.\n---------------------------------------\n")
			end
		end
	end
	
	-- hon recipe oracle shop (Spider Necklace)
	if (m == 1025) then
		if (x == 11) and (y == 6) then
			if (obj == 15270) then
				player:popUp("          New Necklace Recipe:\n---------------------------------------\n\n         Spider Queen Necklace:\n\n1 Simple Twine\n5 Spider Queen Pincers\nThe Pincers are not easy to come by.\n---------------------------------------\n")
			end
		end
	end
	
	-- hon recipe fur shop (Fur Armors)
	if (m == 1020) then
		if (x == 5) and (y == 6) then
			if (obj == 15270) then
				player:popUp("          New Armor Recipe:\n---------------------------------------\n\n         Fur Patch:\n\n50 Black Wolf Furs\n50 Red Wolf Furs\n50 Brown Wolf Furs\n1 Dire Wolf Fur\n5 Simple Twine\nYou will need 5 of these patches if you want to make this new armor.\n---------------------------------------\n\nFur Hide Armor:\n\n5 Fur Patches\n1 Leather Straps\n1 of any of the following Armors:\nMaster Platemail, Leathers, Robes, or Hide.\nUse the one that your gender can equip or you will need to start all over again on a new armor.\n---------------------------------------\n")
			end
		end
	end
	
	-- West Hon Headstone - Carrie Fischer
	if (m == 1001) then
		if (x == 17) and (y == 35) then
			if (obj == 7952) then
				player:popUp("Rest in Peace: Carrie Fischer")
			end
		end
	end
	
	-- West Hon Headstone - Gene Wilder
	if (m == 1001) then
		if (x == 18 or x == 19) and (y == 32) then
			if (obj == 7945) or (obj == 7946) then
				player:popUp("Rest in Peace: Gene Wilder")
			end
		end
	end
	
	-- West Hon Headstone - Kurt Cobain
	if (m == 1001) then
		if (x == 17 or x == 18) and (y == 29) then
			if (obj == 7948) or (obj == 7949)then
				player:popUp("Rest in Peace: Kurt Cobain")
			end
		end
	end
	
	-- West Hon Headstone - Janis Joplin
	if (m == 1001) then
		if (x == 22) and (y == 29) then
			if (obj == 7952) then
				player:popUp("Rest in Peace: Janis Joplin")
			end
		end
	end
	
	-- West Hon Headstone - Dale Earnhardt
	if (m == 1001) then
		if (x == 21) and (y == 26) then
			if (obj == 7952) then
				player:popUp("Rest in Peace: Dale Earnhardt")
			end
		end
	end
	
	-- West Hon Headstone - John Candy
	if (m == 1001) then
		if (x == 17 or x == 18) and (y == 20) then
			if (obj == 7945) or (obj == 7946) then
				player:popUp("Rest in Peace: John Candy")
			end
		end
	end
	
	-- West Hon Headstone - Chris Farley
	if (m == 1001) then
		if (x == 20 or x == 21) and (y == 20) then
			if (obj == 7945) or (obj == 7946) then
				player:popUp("Rest in Peace: Chris Farley")
			end
		end
	end
	
	-- West Hon Headstone - Richard Pryor
	if (m == 1001) then
		if (x == 22) and (y == 17) then
			if (obj == 7973) then
				player:popUp("Rest in Peace: Richard Pryor")
			end
		end
	end
	
	-- West Hon Headstone - Dean Michael Scott Lewis
	if (m == 1001) then
		if (x == 18) and (y == 17) then
			if (obj == 7973) then
				player:popUp("Rest in Peace: Dean Michael Scott Lewis")
			end
		end
	end
	
	-- West Hon Headstone - Michael Jackson
	if (m == 1001) then
		if (x == 14 or x == 15) and (y == 17) then
			if (obj == 7945) or (obj == 7946) then
				player:popUp("Rest in Peace: Michael Jackson")
			end
		end
	end
	
	-- West Hon Headstone - Dimebag Darrel
	if (m == 1001) then
		if (x == 10 or x == 11) and (y == 17) then
			if (obj == 7945) or (obj == 7946) then
				player:popUp("Rest in Peace: Dimebag Darrel")
			end
		end
	end
	
	-- West Hon Headstone - Jimi Hendrix
	if (m == 1001) then
		if (x == 13) and (y == 15) then
			if (obj == 7973) then
				player:popUp("Rest in Peace: Jimi Hendrix")
			end
		end
	end
	
	-- South Hon Boat - Illusive Captain
	if (m == 1003) then
		if (x == 127) and (y == 27) then
			if (obj == 17180) then
				player:talkSelf(0, player.name.. ": Where's the Captain?")
			end
		end
	end
	
	-- South Hon Boat - Illusive Captain
	if (m == 1003) then
		if (x == 128) and (y == 27) then
			if (obj == 17181) then
				player:talkSelf(0, player.name.. ": I would need to find the Captain to use this!")
			end
		end
	end
	
	-- Random Fortune Telling
	if (facingObj == 15273) then
		if player.registry["had_fortune_told"] < os.time() then
		
			randomFortune = math.random(1,5)
		
			if randomFortune == 1 then
				player.registry["had_fortune_told"] = os.time()+43200000
				player:talk(0, player.name.. ": I see a Treasure chest far South from here!")
			elseif randomFortune == 2 then
				player.registry["had_fortune_told"] = os.time()+43200000
				player:talk(0, player.name.. ": What kind of monster is that? Some sort of Guardian!")
			elseif randomFortune == 3 then
				player.registry["had_fortune_told"] = os.time()+43200000
				player:talk(0, player.name.. ": Such a beautiful young lady far North from here. All she wants is some Pink Flower Boquets!")
			elseif randomFortune == 4 then
				player.registry["had_fortune_told"] = os.time()+43200000
				player:talk(0, player.name.. ": I see an observatory where someone is Offering a Blessing to the Gods!")
			elseif randomFortune == 5 then
				player.registry["had_fortune_told"] = os.time()+43200000
				player:talk(0, player.name.. ": Hey it's Egon as a young man! What is he... no... what is that!!! RUNNNN!")
			end
		else
			player:msg(4, player.name.. ": I already had your fortune told. Timer("..player.registry["had_fortune_told"]-os.time().." sec)", player.ID)
		end
	end
	
	-- Potion Racks
	if (obj == 17484) or (obj == 17485)then
		player:talkSelf(0, player.name.. ": Various potions are on display!")
	end
	
	-- Live Fire Cooking Stew
	if (obj == 12918) or (obj == 12919)then
		player:talkSelf(0, player.name.. ": I better not get too close to that fire!")
	end
	
	-- Parcel Post
	if (m == 1000) then
		if (obj == 7299) or (obj == 7300)then
			player:talkSelf(0, player.name.. ": Hon Parcel Shop!")
		end
	end
	
	-- 4 wine bottles in crate
	if (obj == 7911) then
		player:talkSelf(0, player.name.. ": That swill wine is gross.")
	end
	
	-- Bookshelf
	if (obj == 12317) then
		player:talkSelf(0, player.name.. ": Book Title: So you think you're a Fighter?")
	end
	
	-- Bookshelf
	if (obj == 12318) then
		player:talkSelf(0, player.name.. ": Book Title: Spetan, The Nation that Gold Built!")
	end
	
	-- floor papers
	if (obj == 16588) then
		player:talkSelf(0, player.name.. ": Floor trash.")
	end
	
	-- Portable Hammer and Anvil Table
	if (obj == 17516) then
		player:talkSelf(0, player.name.. ": A Portable Hammer and Anvil!")
	end
	
	-- 6 Chef Knives Table
	if (obj == 15835) then
		player:talkSelf(0, player.name.. ": Some nice and sharp Chef Knives!")
	end
	
	-- Garden Hoes Table
	if (obj == 15838) then
		player:talkSelf(0, player.name.. ": Some sturdy Gardening tools!")
	end
	
	-- Axe in Stump Table
	if (obj == 17517) then
		player:talkSelf(0, player.name.. ": Portable Axe for Firewood!")
	end
	
	-- Wheat Bags Table
	if (obj == 15834) then
		player:talkSelf(0, player.name.. ": These are some fine imported wheat sacks!")
	end
	
	-- Coal Bags
	if (obj == 16920) then
		player:talkSelf(0, player.name.. ": Someone pissed off Santa!")
	end
	
	-- Coal Boxes
	if (obj == 16924) then
		player:talkSelf(0, player.name.. ": Chunks of coal ready to be delivered!")
	end
	
	-- Skeleton Arm
	if (obj == 15529) then
		player:talkSelf(0, player.name.. ": The arm of a dead human!")
	end
	
	-- Skeleton Rib Cage
	if (obj == 15528) then
		player:talkSelf(0, player.name.. ": The rib cage of a dead human!")
	end
	
	-- Skeleton dark head
	if (obj == 15527) then
		player:talkSelf(0, player.name.. ": The dark skull of a dead human!")
	end
	
	-- Skeleton Jawbone
	if (obj == 15526) then
		player:talkSelf(0, player.name.. ": The jawbone of a dead human!")
	end
	
	-- Skeleton femurs
	if (obj == 5827) then
		player:talkSelf(0, player.name.. ": Two femurs of a dead human!")
	end
	
	-- Skeleton white skull
	if (obj == 5815) then
		player:talkSelf(0, player.name.. ": This looks like a fresh skull of a dead human!")
	end
	
	-- Skeleton Stack of Heads
	if (obj == 5808) or (ob == 5809) or (obj == 5810) then
		player:talkSelf(0, player.name.. ": What happened here? So much death and no one is around!")
	end
	
	-- Death Well
	if (obj == 15493) or (obj == 15494) then
		player:talkSelf(0, player.name.. ": This thing is packed full of dead bodies!")
	end
	
	-- Saki and Cups
	if (obj == 12884) then
		player:setDuration("drunk", 30000)
		player:talkSelf(0, player.name.. ": That's strong!")
	end
	
	-- Saki Sampler
	if (obj == 15272) then
		player:setDuration("drunk", 30000)
		player:talkSelf(0, player.name.. ": That's strong!")
	end
	
	if (obj == 16896) then
		player:talkSelf(0, player.name.. ": It's a dented old helmet.")
	end

	if (obj == 14921) then
		player:talkSelf(0, player.name.. ": What a nice gown.")
	end

	if (obj == 14920) then
		player:talkSelf(0, player.name.. ": Now that is some real fancy clothes.")
	end

	if (obj == 14918) then
		player:talkSelf(0, player.name.. ": Now that looks like some nice armor.")
	end

	if (obj == 14925) or (obj == 14926) then
		player:talkSelf(0, player.name.. ": Novelty sword. This would break in battle.")
	end

	if (obj == 12804) then
		player:talkSelf(0, player.name.. ": Looks fresh.")
	end

	if (obj == 12805) then
		player:talkSelf(0, player.name.. ": Such a small fish.")
	end

	if (obj == 12803) then
		player:talkSelf(0, player.name.. ": Damn, what animal did that come from.")
	end

	if (obj == 12324) then
		player:popUp("The Three Tree Inn Resort. Come check out our new location in Hon by the Sea.")
	end

	if (obj == 12449) or (obj == 12450) then
		player:talkSelf(0, player.name.. ": This barrel is sealed too tight to check inside.")
	end


	if (obj == 12800) or (obj == 12801) or (obj == 12802) then
		player:talkSelf(0, player.name.. ": Those fish smell terrible.")
	end

	if (obj == 15795) then
		player:talkSelf(0, player.name.. ": It's a bag of grain.")
	end

	if (obj == 16882) then
		player:talkSelf(0, player.name.. ": These swords don't even look sharp.")
	end

	if (obj == 14919) then
		player:talkSelf(0, player.name.. ": There sure are a lot of dents in this armor.")
	end

	if (obj == 15757) then
		player:talkSelf(0, player.name.. ": Wow, someone hit a bullseye!")
	end

	if (obj == 15831) then
		player:talkSelf(0, player.name.. ": I hope they don't fall and crush me!")
	end

	if (obj == 15833) then
		player:talkSelf(0, player.name.. ": I wonder whats in the box.")
	end

	if (obj == 15838) then
		player:talkSelf(0, player.name.. ": These are tools. Where are the weapons?")
	end

	if (obj == 15679) or (obj == 15680) then
		player:talkSelf(0, player.name.. ": I could use a drink.")
	end

	if (obj == 15685) or (obj == 15686) then
		player:talkSelf(0, player.name.. ": Just another sword.")
	end

	if (obj == 15687) or (obj == 15688) then
		player:talkSelf(0, player.name.. ": What a crappy sword.")
	end

	if (obj == 15692) then
        player:talkSelf(0, player.name.. ": That looks sharp.")
    end

	if (obj == 8450) then
        player:talkSelf(0, player.name.. ": That is a lot of bird food.")
    end

	if (obj == 8457) then
        player:talkSelf(0, player.name.. ": Carpet dye. So much carpet dye.")
    end

	if (obj == 7935) then
        player:talkSelf(0, player.name.. ": This wine smells spoiled.")
    end

    --Forge tools
	if (obj == 12909) or (obj == 12910)then
        player:talkSelf(0, player.name.. ": Water for cooling molten steel.")
    end

	if (obj == 12911) then
        player:talkSelf(0, player.name.. ": A smith's Anvil.")
    end

	if (obj == 12912) then
        player:talkSelf(0, player.name.. ": Some smith tools.")
    end

	if (obj == 13505) then
        player:talkSelf(0, player.name.. ": A smith's Hammer.")
    end

	if (obj == 12875) or (obj == 12876) then
        player:talkSelf(0, player.name.. ": That skin looks very warm.")
    end

	if (obj == 12873) or (obj == 12874)then
        player:talkSelf(0, player.name.. ": Poor Tiger. Though it does look very warm.")
    end

	if (obj == 12922) then
        player:talkSelf(0, player.name.. ": Some green linens. Those could make nice socks!")
    end

	if (obj == 12921) then
        player:talkSelf(0, player.name.. ": Multi-colored linens. They're super, thanks for asking!")
    end

	if (obj == 12927) or (obj == 12928) or (obj == 12929)then
        player:talkSelf(0, player.name.. ": These linens are fit for royalty.")
    end

	if (obj == 12924) or (obj == 12925) or (obj == 12926) then
        player:talkSelf(0, player.name.. ": These linens are clearly for poor people.")
    end

	if (obj == 13502) or (obj == 13501) then
        player:talkSelf(0, player.name.. ": A wagon of coal. Was someone was naughty their whole life?")
    end

	if (obj == 10876) or (obj == 10877) then
        player:talkSelf(0, player.name.. ": This forge could use a cleaning.")
    end

	if (obj == 7901) or (obj == 7902) or (obj == 7903) then
        player:talkSelf(0, player.name.. ": Seagrove Island holds the greatest tresure of all. Knowledge!")
    end

	if (obj == 8365) or (obj == 7481) then
        player:talkSelf(0, player.name.. ": It is a table... Why did I look at this again?")
    end

	if (obj == 13795) then
		player:talkSelf(0, player.name.. ": A boring tale for boring people. *snores*")
    end

	if (m == 1098 and obj == 16367) then
		if player.quest["blackstrike_torch"] == 2 then
			if player:hasItem("unlit_eclipse_torch", 1) == true then
				player:removeItem("unlit_eclipse_torch", 1)
				player:addItem("eclipse_torch", 1, 999999, player.ID)
				player.registry["blackstrike_torch"] = 3
				player:talkSelf(0, player.name.. ": This torch burns so hot!")
			else
				player:talkSelf(0, player.name.. ":I must remember this Eternal Flame is here!")
			end
		else
			player:talkSelf(0, player.name.. ": An Eternally Burning Flame!")
		end
	end

	if (m == 1003) then
		leech_chest.open(player)
	end

	if (m == 1011) then
		library_door.open(player)
	end

	if (m == 1103) then
		sewer_crank.open(player)
	end

	if (m == 1103) then
		sewer_chest.open(player)
	end

	if (m == 3000) then
		ruins_door.open(player)
	end

	if (m == 3000) then
		ruins_door2.open(player)
	end
	if (m == 15015) then
		lode_runner.jump(player)
	end
	if m == 3115 then
		ruinsBossChest.open(player)
	end
	if m == 3116 then
		if player.x == 14 then
			if player.y == 5 then
				if player.side == 0 then
					if player.registry["took_strange_powder"] == 0 then
						player:addItem("strange_powder", 1)
						player.registry["took_strange_powder"] = 1
						player:sendMinitext("You find a strange powder pressed between the mortar and pestle.")
					else
						player:sendMinitext("There's nothing left here.")
					end
				end
			end
		end
	end

	if player.quest["lost_something"] == 1 then
		necromon.pickup(player)
	end

	if facingObj == 13593 or facingObj == 13523 then
		potionStand.use(player, npc)
	end

	if facingObj == 7606 or facingObj == 17509 or facingObj == 17510 or facingObj == 19209  or facingObj == 18551 or facingObj == 13964 then
		mortar.use(player, npc)
	end
	
	if facingObj == 697 or facingObj == 696 then
		furnace.use(player, npc)
	end
	
	if facingObj == 693 or facingObj == 693 then
		anvil.use(player, npc)
	end
	
	if m >= 3201 and m <= 3205 then
		if facingObj == 15801 or facingObj == 15802 or facingObj == 15803 then
			crusty_dynamite.pickUp(player)
	
		elseif facingObj == 16938 then
			player:talk(0,""..player.name..": This pickaxe is destroyed and useless.")
		end
	end
	
	if m == 2100 then
		if facingObj == 16605 or facingObj == 16609 then
			if player.side == 0 then
				disturbed_tomb_hidden_stairs.flipSwitches(player)
			else
				player:talkSelf(0,""..player.name..": There's something there, but I can't reach it...")
			end
		end
	end
	
	
	
	
	
end
