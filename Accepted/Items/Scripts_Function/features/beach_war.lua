--beach_war.open() - opens minigame
--beach_war.cancel() - cancels opened minigame before start
--beach_war.stop() - stops game in progress, returns all players to arena with clean registry


beach_war = {

playerCore = function(player)
	beach_war.autoWarp(player)
	beach_war.guiText(player)
	beach_war.refill(player)
end,

core = function()
	
	beach_war.broadcastTimer()
	beach_war.closed()
	beach_war.enterArena()
	beach_war.begin()
	beach_war.endGame()
	
end,

open = function()
	
	local style = ""
	
	core.gameRegistry["beach_war_open"] = 1		--Registry for game open
	
	if core.gameRegistry["beach_war_hits_to_kill"] == 1 then		--
		core.gameRegistry["beach_war_hits_to_kill"] = 2
		style = "Classic"
	else
		core.gameRegistry["beach_war_hits_to_kill"] = 1
		style = "Headshot"
	end
	
	if core.gameRegistry["beach_war_hits_to_kill"] == 0 then
		core.gameRegistry["beach_war_hits_to_kill"] = 2
		style = "Classic"
	end
	
	
	core.gameRegistry["beach_war_start_time"] = os.time()+600	--15 minute timer
	broadcast(-1, "-----------------------------------------------------------------------------------------------------")
	broadcast(-1, "                                "..style.." Beach War is now open in Hon Arena!")
	broadcast(-1, "                                Registration will close in 10 minutes!")
	broadcast(-1, "-----------------------------------------------------------------------------------------------------")
end,

click = async(function(player, npc)
	
----------Variable Declarations-----------------------------------	
	local total = {}	
	local pc = player:getObjectsInMap(15021, BL_PC)	--waiting room map
	local n = "<b>[Beach War]\n\n"
	local t = {g = convertGraphic(npc.look, "monster"), c = npc.lookColor}
	player.npcGraphic = t.g
	player.npcColor = t.c
	player.dialogType = 0
	
	local str = ""
	local time = beach_war.getStartTimer()
	local goldCost = 1000
	local opts = {}
	local diff
	
	if #pc > 0 then		--determine how many players in waiting room
		for i = 1, #pc do
			if pc[i].registry["beach_war_registered"] > 0 then
				table.insert(total, pc[i].ID)
			end
		end
	end
---------------Table Inserts-----------------------------
	table.insert(opts, "How To Play?")
	if player.registry["beach_war_registered"] == 1 and core.gameRegistry["beach_war_started"] == 0 then table.insert(opts, "Hey! Let me in!") end
	if core.gameRegistry["beach_war_open"] == 1 then	--If the game is open
		if player.registry["beach_war_registered"] == 0 then	--if you have not registered
			table.insert(opts, "Register For Beach War")
		end
		
		if player.registry["beach_war_registered"] > 0 or player.registry["beach_war_team"] > 0 then --If you have a bad registry for some reason, get the option to fix it
			table.insert(opts, "I can't register!")
		end
	end
	table.insert(opts, "Exit")
	
	if core.gameRegistry["beach_war_start_time"] > os.time() then --if the game is open, get timer string
		str = "Waiting time: "..beach_war.getStartTimer()
	end
----------------------------------------------------------

	
	menu = player:menuString(n.."Hello, the game will start in few minutes.\n"..str.."\nIn the waiting room: "..#total, opts) --Display the menu

-----------------Menu Options-------------------------	
	if menu == "How To Play?" then
		player:dialogSeq({t, n.."Beach War is a game where you use your water gun to soak members of the opposing team.", 
							n.."A player can get soaked once and stay in the game, but a second shot will send you to the sidelines for a short time.",
							n.."Your gun can only hold 10 shots worth of water, but it will be slowly refilled if you stand by the pool at the center of the map.", 
							n.."The game ends when one team reaches a target score, based on the number of players."}, 1)
		player:freeAsync()
		beach_war.click(player, npc)
	elseif menu == "Hey! Let me in!" then
		core.gameRegistry["beach_war_players"] = core.gameRegistry["beach_war_players"] + 1
		player:warp(15021, math.random(2, 14), math.random(2, 12))
		player:sendAnimation(16)
		player:playSound(29)
		player:popUp("Welcome to Beach War!\nPlease wait patiently until the game starts.")
	elseif menu == "Register For Beach War" then
		if player.registry["minigame_ban_timer"] > os.time() then --Check if player is banned from minigames
			player:popUp("You are currently banned from minigames! Try again later maybe.")
			return
		end
		
		confirm = player:menuString("The cost to register is "..goldCost.." coins. Are you willing to pay to play?", {"Yes", "No"}) --Confirmation and payment
		if confirm == "Yes" then
			if player:removeGold(goldCost) == true then	--If the fee is succesfully removed
				diff = core.gameRegistry["beach_war_start_time"] - os.time()
				player.registry["beach_war_registered"] = 1
				if diff < 121 then --Less than 2 minutes until start, warp directly to waiting room
					beach_war.warpToWaitingRoom(player)
				elseif diff >= 121 then --More than 2 minutes until start, just get registry
					player:dialogSeq({t, n.."Alright, your character is registered for Beach War.\nYou will be sent to the waiting room 2 minutes before the game starts."}, 1)
				end
			else	--If you don't have enough coins
				player:popUp("Come back with some coins, ya bum!")
			end
		end
	elseif menu == "I can't register!" then
		player.registry["beach_war_times_hit"] = 0
		player.registry["beach_war_gun_pct"] = 0
		player.registry["beach_war_registered"] = 0
		player.registry["beach_war_flag"] = 0
		player.registry["beach_war_team"] = 0
		player.registry["beach_war_kills"] = 0
		player:dialogSeq({t, n.."Looks like a simple paperwork mixup. You should be all set to register now, have fun at the game!"}, 1)
		player:freeAsync()
		beach_war.click(player, npc)
	end
end
),

warpToWaitingRoom = function(player)

	--player.registry["beach_war_team"] = math.random(1, 2)
	core.gameRegistry["beach_war_players"] = core.gameRegistry["beach_war_players"] + 1
	player:warp(15021, math.random(2, 14), math.random(2, 12))
	player:sendAnimation(16)
	player:playSound(29)
	player:popUp("Welcome to Beach War!\nPlease wait patiently until the game starts.")

end,

autoWarp = function(player)

	local diff = core.gameRegistry["beach_war_start_time"] - os.time()
	
	if player.registry["beach_war_registered"] == 1 then
		if diff == 120 then
			if player.m ~= 15021 and player.m ~= 15020 then
				beach_war.warpToWaitingRoom(player)
			end
		end
	end

end,


guiText = function(player)

	local diff = core.gameRegistry["beach_war_start_time"] - os.time()
	local diffwait = core.gameRegistry["beach_war_wait_time"] - os.time()

	if player.registry["beach_war_registered"] == 1 and core.gameRegistry["beach_war_started"] == 0 then
		if diff > 0 then
			player:guitext("\nBeach War registration will close in: "..getTimerValues("beach_war_start_time").."    ")
		
		elseif diffwait > 0 then
			player:guitext("\nBeach War will begin in: "..getTimerValues("beach_war_wait_time").."    ")
			
		else
			player:guitext("")
		end
	elseif player.registry["beach_war_registered"] == 1 and core.gameRegistry["beach_war_started"] == 1 then
		if diffwait > 0 then
			player:guitext("\nBeach War will begin in: "..getTimerValues("beach_war_wait_time").."    ")
		else
			player:guitext("\nRED: "..core.gameRegistry["beach_war_red_point"].." | BLUE: "..core.gameRegistry["beach_war_blue_point"].."  \nYour kills: "..player.registry["beach_war_kills"])
		end
	end
	
	if player.gmLevel > 0 and player.m == 15020 then
		player:guitext("\nRED: "..core.gameRegistry["beach_war_red_point"].." | BLUE: "..core.gameRegistry["beach_war_blue_point"].."  \nYour kills: "..player.registry["beach_war_kills"])
	end
	
	
	
end,

broadcastTimer = function()
	
	local diff = core.gameRegistry["beach_war_start_time"] - os.time()
	
--	if diff == 600 then
--		broadcast(-1, "Beach War registration will close in 10 minutes")
	if diff == 300 then
		broadcast(-1, "Beach War registration will close in 5 minutes")
	elseif diff == 60 then
		broadcast(-1, "Beach War registration will close in 1 minute")
	end

end,

getStartTimer = function()
		
	local hour, minute, second = 0, 0, 0
	
	if core.gameRegistry["beach_war_start_time"] < os.time() then return "00:00:00" else
		dif = core.gameRegistry["beach_war_start_time"] - os.time()
		hour = string.format("%02.f", math.floor(dif/3600))
		minute = string.format("%02.f", math.floor(dif/60-(hour*60)))
		second = string.format("%02.f", math.floor(dif-hour*3600-minute*60))
		return hour..":"..minute..":"..second
	end
end,

closed = function()

	local diff = core.gameRegistry["beach_war_start_time"] - os.time()
	
	if core.gameRegistry["beach_war_open"] == 1 then
		if core.gameRegistry["beach_war_start_time"] > 0 then
			if core.gameRegistry["beach_war_start_time"] > os.time() then
				if diff == 10 then
					broadcast(15021, "                                Beach War registration will close in 10 seconds!")
				elseif diff <= 3 then
					broadcast(15021, "                                Beach War registration will close in "..diff.." seconds!")
				end
			elseif core.gameRegistry["beach_war_start_time"] < os.time() then
				--core.gameRegistry["beach_war_open"] = 0
				core.gameRegistry["beach_war_start_time"] = 0
				broadcast(-1, "-----------------------------------------------------------------------------------------------------")
				broadcast(-1, "                                 Beach War entry is closed!")
				broadcast(-1, "-----------------------------------------------------------------------------------------------------")
				beach_war.start()
			end
		end
	end

end,

getRandomMap = function()

	local allBeachWarMaps = {15020}
	local randomMap = allBeachWarMaps[math.random(1, #allBeachWarMaps)]
	
	core.gameRegistry["beach_war_current_map"] = randomMap

end,

setMapBlockers = function(mapID)

	local blocker = 12447
	local noPass = 1

	if mapID == 15020 then
		setObject(mapID, 11, 9, blocker)
		setObject(mapID, 11, 10, blocker)
		setObject(mapID, 4, 16, blocker)
		setObject(mapID, 5, 16, blocker)
		setObject(mapID, 34, 33, blocker)
		setObject(mapID, 35, 33, blocker)
		setObject(mapID, 28, 39, blocker)
		setObject(mapID, 28, 40, blocker)
		
		setPass(mapID, 11, 9, noPass)
		setPass(mapID, 11, 10, noPass)		
		setPass(mapID, 4, 16, noPass)
		setPass(mapID, 5, 16, noPass)		
		setPass(mapID, 34, 33, noPass)
		setPass(mapID, 35, 33, noPass)		
		setPass(mapID, 28, 39, noPass)
		setPass(mapID, 28, 40, noPass)
	end
end,

removeMapBlockers = function(mapID)

	local noBlocker = 0
	local pass = 0

	if mapID == 15020 then
		setObject(mapID, 11, 9, noBlocker)
		setObject(mapID, 11, 10, noBlocker)
		setObject(mapID, 4, 16, noBlocker)
		setObject(mapID, 5, 16, noBlocker)
		setObject(mapID, 34, 33, noBlocker)
		setObject(mapID, 35, 33, noBlocker)
		setObject(mapID, 28, 39, noBlocker)
		setObject(mapID, 28, 40, noBlocker)
		
		setPass(mapID, 11, 9, pass)
		setPass(mapID, 11, 10, pass)		
		setPass(mapID, 4, 16, pass)
		setPass(mapID, 5, 16, pass)		
		setPass(mapID, 34, 33, pass)
		setPass(mapID, 35, 33, pass)		
		setPass(mapID, 28, 39, pass)
		setPass(mapID, 28, 40, pass)
	end


end,

start = function()


	beach_war.assignTeams()
	beach_war.getRandomMap()
	local map = core.gameRegistry["beach_war_current_map"]
	local pc = core:getObjectsInMap(15021, BL_PC)

--	
	
	if core.gameRegistry["beach_war_players"] >= 2 then
		if #pc > 0 then	
			--beach_war.assignTeams()
			for i = 1, #pc do			
				if pc[i].registry["beach_war_team"] > 0 and pc[i].state ~= 0 then 				
					pc[i].state = 0 
					pc[i].speed = 80
					pc[i].registry["mounted"] = 0
					pc[i]:updateState()
				end
				
				beach_war.costume(pc[i])
				beach_war.entryLegend(pc[i])
				if pc[i].registry["beach_war_team"] == 1 then --red team
					pc[i]:warp(map, 3, 2)
				end

				if pc[i].registry["beach_war_team"] == 2 then --blue team
					pc[i]:warp(map, 36, 47)
				end
				
			end
			beach_war.wait()
		end
	else
		broadcast(-1, "-----------------------------------------------------------------------------------------------------")
		broadcast(-1, "                             Not enough players. Beach War cancelled!")
		broadcast(-1, "-----------------------------------------------------------------------------------------------------")
		beach_war.cancel()
	end
		
end,

costume = function(player)
	
	local team = player.registry["beach_war_team"]
	local dye, str = 0, ""
	local gunColor = 0
	local armor = 0
	
	player:flushDuration()
	if team == 1 then
		dye = 31
		gunColor = 30
	elseif team == 2 then
		dye = 17
		gunColor = 16
	end

	if player.sex == 0 then
		armor = 57
	elseif player.sex == 1 then
		armor = 58
	end
	

	if player.faceAccessoryTwo > 0 then
		player.gfxFaceAT = player.faceAccessoryTwo
		player.gfxFaceATC = player.faceAccessoryTwoColor
	else
		player.gfxFaceAT = 65535
		player.gfxFaceATC = 0
	end
	
	player.gfxArmor = armor
	player.gfxArmorC = dye
	player.gfxDye = dye
	player.gfxCrown = 65535
	player.gfxShield = 65535
	player.gfxWeap = 20109
	player.gfxWeapC = gunColor
	player.gfxNeck = 65535
	player.gfxFaceA = 65535
	player.gfxHelm = 65535
	player.gfxCape = 65535
	player.gfxFace = player.face
	player.gfxFaceC = player.faceColor
	player.gfxHair = player.hair
	player.gfxHairC = player.hairColor
	player.gfxSkinC = player.skinColor
	player.gfxName = player.name
	player.gfxClone = 1
	player.attackSpeed = 50
	player:updateState()
end,


assignTeams = function()

	local red, blue = 0, 0
	local pc = core:getObjectsInMap(15021, BL_PC)
	local randomTeam
	
	if #pc > 0 then
		for i = 1, #pc do
			if pc[i].registry["beach_war_team"] == 0 then
				if red == blue then
					randomTeam = math.random(1,2)
					pc[i].registry["beach_war_team"] = randomTeam
					if randomTeam == 1 then 
						red = red + 1
					elseif randomTeam == 2 then
						blue = blue + 1
					end
				elseif blue > red then
					pc[i].registry["beach_war_team"] = 1
					red = red + 1
				elseif red > blue then
					pc[i].registry["beach_war_team"] = 2
					blue = blue + 1
				end
			
			end
		end
	end
	
	if #pc > 0 then
		for i = 1, #pc do	
			if red > blue then
				if (red-blue) ~= 1 then pc[math.random(#pc)].registry["beach_war_team"] = 2 break end
			end
			if red < blue then
				if blue - red ~= 1 then pc[math.random(#pc)].registry["beach_war_team"] = 1 break end
			end
		end
	end

end,

wait = function(npc)
	
	local map = core.gameRegistry["beach_war_current_map"]
	
	local pc = core:getObjectsInMap(map, BL_PC)
	core.gameRegistry["beach_war_wait_time"] = os.time() + 60
	beach_war.setMapBlockers(map)
	
	broadcast(map, "-----------------------------------------------------------------------------------------------------")
	broadcast(map, "                                    Get Ready! The round starts in 60 seconds!")
	broadcast(map, "-----------------------------------------------------------------------------------------------------")
	
end,

enterArena = function()

	local diff = core.gameRegistry["beach_war_wait_time"] - os.time()
	local map = core.gameRegistry["beach_war_current_map"]
	local pc = core:getObjectsInMap(map, BL_PC)
	
	if diff == 30 then
		for i = 1, #pc do
			pc[i].registry["beach_war_gun_pct"] = 100
			pc[i].registry["beach_war_kills"] = 0
			
			if pc[i].registry["beach_war_team"] == 1 then
				pc[i]:warp(map, 3, 8)
			elseif pc[i].registry["beach_war_team"] == 2 then
				pc[i]:warp(map, 36, 41)
			end
		end
		broadcast(map, "                                    Beach War starts in 30 seconds!")
	end
	
end,


begin = function()

	local diff = core.gameRegistry["beach_war_wait_time"] - os.time()
	local map = core.gameRegistry["beach_war_current_map"]
	local pc = core:getObjectsInMap(map, BL_PC)


	if diff == 0 then
		core.gameRegistry["beach_war_started"] = 1
		beach_war.removeMapBlockers(map)

		broadcast(map, "-----------------------------------------------------------------------------------------------------")
		broadcast(map, "                                   The Beach War has begun!")
		broadcast(map, "-----------------------------------------------------------------------------------------------------")
	end
end,

stop = function(type) -- 0 to return to arena, 1 to send all to loser room, 2 to send all to prizeroom

	local prizeRoom = 15992
	local loserRoom = 15982

	local map = core.gameRegistry["beach_war_current_map"]

	local pc = core:getObjectsInMap(map, BL_PC)

	core.gameRegistry["beach_war_end_timer"] = 0
	core.gameRegistry["beach_war_players"] = 0
	core.gameRegistry["beach_war_open"] = 0
	core.gameRegistry["beach_war_winner"] = 0
	core.gameRegistry["beach_war_started"] = 0
	core.gameRegistry["beach_war_red_point"] = 0
	core.gameRegistry["beach_war_blue_point"] = 0
	core.gameRegistry["beach_war_current_map"] = 0
	core.gameRegistry["beach_war_red_wins"] = 0
	core.gameRegistry["beach_war_blue_wins"] = 0
	
	if #pc > 0 then
		for i = 1, #pc do
			pc[i].registry["beach_war_times_hit"] = 0
			pc[i].registry["beach_war_gun_pct"] = 0
			pc[i].registry["beach_war_registered"] = 0
			pc[i].registry["beach_war_flag"] = 0
			pc[i].registry["beach_war_team"] = 0
			pc[i].registry["beach_war_kills"] = 0
			
			pc[i].gfxClone = 0
			pc[i].attackSpeed = 80
			pc[i]:updateState()
			pc[i]:calcStat()
			pc[i]:sendAnimation(16)
			pc[i]:playSound(29)

			if type == 0 then
				pc[i]:warp(1031, math.random(13,17), math.random(4, 7))
			elseif type == 1 then
				pc[i]:warp(loserRoom, math.random(1,16), math.random(7,14))
			elseif type == 2 then
				pc[i]:warp(prizeRoom, math.random(4,12), math.random(6,11))
			end
			
			

		end
	end
end,

cancel = function()

	local map = 15021

	local pc = core:getObjectsInMap(map, BL_PC)

	core.gameRegistry["beach_war_end_timer"] = 0
	core.gameRegistry["beach_war_players"] = 0
	core.gameRegistry["beach_war_open"] = 0
	core.gameRegistry["beach_war_winner"] = 0
	core.gameRegistry["beach_war_started"] = 0
	core.gameRegistry["beach_war_red_point"] = 0
	core.gameRegistry["beach_war_blue_point"] = 0
	core.gameRegistry["beach_war_current_map"] = 0
	core.gameRegistry["beach_war_red_wins"] = 0
	core.gameRegistry["beach_war_blue_wins"] = 0
	
	if #pc > 0 then
		for i = 1, #pc do
			pc[i].registry["beach_war_times_hit"] = 0
			pc[i].registry["beach_war_gun_pct"] = 0
			pc[i].registry["beach_war_registered"] = 0
			pc[i].registry["beach_war_flag"] = 0
			pc[i].registry["beach_war_team"] = 0
			pc[i].registry["beach_war_kills"] = 0
			
			pc[i].gfxClone = 0
			pc[i].attackSpeed = 80
			pc[i]:updateState()
			pc[i]:sendAnimation(16)
			pc[i]:playSound(29)
			pc[i]:calcStat()

			pc[i]:warp(1031, math.random(13,17), math.random(4, 7))
			
		end
	end
end,



shoot = function(player)
	
	local team = player.registry["beach_war_team"]
	
	local map = core.gameRegistry["beach_war_current_map"]
	local m, x, y, side = player.m, player.x, player.y, player.side
	local icon = 1615
	local pc
	
	if team > 0 then
		if player.m == map and player.gfxClone == 1 then
			if player.registry["beach_war_gun_pct"] >= 10 then
				player.registry["beach_war_gun_pct"] = player.registry["beach_war_gun_pct"] - 10
				player:playSound(709)
			--	player:sendAction(1, 20)
				player:sendMinitext("Your water tank is at "..player.registry["beach_war_gun_pct"].."%")
				for i = 1, 8 do
					pc = getTargetFacing(player, BL_PC, 0, i)

					if side == 0 then
						if getPass(m, x, y-i) == 1 then return end
					elseif side == 1 then
						if getPass(m, x+i, y) == 1 then return end
					elseif side == 2 then
						if getPass(m, x, y+i) == 1 then return end
					elseif side == 3 then
						if getPass(m, x-i, y) == 1 then return end
					end
					if pc ~= nil and pc.registry["beach_war_team"] > 0 then 
						if team ~= pc.registry["beach_war_team"] then beach_war.hit(player, pc) end
						return
					end
					if side == 0 then
						player:throw(x, y-i, icon, 2, 1)
					elseif side == 1 then
						player:throw(x+i, y, icon, 2, 1)
					elseif side == 2 then
						player:throw(x, y+i, icon, 2, 1)
					elseif side == 3 then
						player:throw(x-i, y, icon, 2, 1)
					end
				end
				
			else
				player:sendMinitext("Your gun is out of water!")
			end
		end
	end
end,



hit = function(player, target)

	
	local map = core.gameRegistry["beach_war_current_map"]
	local team = target.registry["beach_war_team"]
	local x, y
	
	player:playSound(739)
	player:playSound(737)
	target:sendAnimationXY(142, target.x, target.y)
	
	if core.gameRegistry["beach_war_hits_to_kill"] == 1 then
		if team == 1 then
			x = 3
			y = 2
			teamName = "blue"
        
		elseif team == 2 then
			x = 36
			y = 47
			teamName = "red"

		end
		
		player.registry["total_beach_war_hits"] = player.registry["total_beach_war_hits"] + 1	--permanent registry for stat tracking
		player.registry["total_beach_war_kills"] = player.registry["total_beach_war_kills"] + 1 --permanent registry for stat tracking
		target.registry["total_beach_war_deaths"] = target.registry["total_beach_war_deaths"] + 1 --permanent registry for stat tracking
		target.registry["total_beach_war_times_hit"] = 1 --permanent registry for stat tracking
		
		core.gameRegistry["beach_war_"..teamName.."_point"] = core.gameRegistry["beach_war_"..teamName.."_point"] + 1	--increase current game score
		player.registry["beach_war_kills"] = player.registry["beach_war_kills"] + 1
		
		target:setDuration("respawning", 15000)
		target:warp(map, x, y)
		
		
		broadcast(map, ""..target.name.." was SOAKED by "..player.name.."!")

			

		beach_war.winnerCheck()
		
	elseif core.gameRegistry["beach_war_hits_to_kill"] == 2 then
		if target.registry["beach_war_times_hit"] == 0 then
			player.registry["total_beach_war_hits"] = player.registry["total_beach_war_hits"] + 1	--permanent registry for stat tracking
			target.registry["total_beach_war_times_hit"] = target.registry["total_beach_war_times_hit"] +1 --permanent registry for stat tracking
			
			target:sendMinitext("You got shot by "..player.name.."! Don't get hit again!")
			target.registry["beach_war_times_hit"] = target.registry["beach_war_times_hit"] + 1

			
			broadcast(map, ""..target.name.." has been shot by "..player.name.."!")
			
		elseif target.registry["beach_war_times_hit"] == 1 then
			if team == 1 then
				x = 3
				y = 2
				teamName = "blue"
			
			elseif team == 2 then
				x = 36
				y = 47
				teamName = "red"
	
			end
			player.registry["total_beach_war_hits"] = player.registry["total_beach_war_hits"] + 1	--permanent registry for stat tracking
			player.registry["total_beach_war_kills"] = player.registry["total_beach_war_kills"] + 1 --permanent registry for stat tracking
			target.registry["total_beach_war_deaths"] = target.registry["total_beach_war_deaths"] + 1 --permanent registry for stat tracking
			target.registry["total_beach_war_times_hit"] = 1 --permanent registry for stat tracking
			
			core.gameRegistry["beach_war_"..teamName.."_point"] = core.gameRegistry["beach_war_"..teamName.."_point"] + 1
			player.registry["beach_war_kills"] = player.registry["beach_war_kills"] + 1
			
			target:setDuration("respawning", 10000)
			target:warp(map, x, y)
					

			broadcast(map, ""..target.name.." has been SOAKED by "..player.name.."!")
			beach_war.winnerCheck()
			
			target.registry["beach_war_times_hit"] = 0
		end
	end
end,



refill = function(player)

	local m, x, y = player.m, player.x, player.y
	local refillTile = {28910, 28892, 28893, 28894, 28911, 28905, 28903, 28904, 28909, 28897, 28896, 28895, 28908, 28900, 28899, 28898}

	if m == 15020 then
		for i = 1, #refillTile do
			if getTile(m, x, y) == refillTile[i] then
				if player.registry["beach_war_gun_pct"] < 100 and player.registry["beach_war_team"] > 0 and player.gfxClone == 1 then
					player.registry["beach_war_gun_pct"] = player.registry["beach_war_gun_pct"] + 5
					player:sendMinitext("Refilling: Your water tank is at "..player.registry["beach_war_gun_pct"].."%")
				else
					player:sendMinitext("Your gun's water tank is full!")

				end
			end
		end
	end
end,

winnerCheck = function()

	local pointsToWin

	if core.gameRegistry["beach_war_players"] < 4 then
		pointsToWin = 3
	elseif core.gameRegistry["beach_war_players"] >= 4 and core.gameRegistry["beach_war_players"] <= 9 then
		pointsToWin = 10
	elseif core.gameRegistry["beach_war_players"] >= 10 and core.gameRegistry["beach_war_players"] <= 15 then
		pointsToWin = 20
	elseif core.gameRegistry["beach_war_players"] >= 16 then
		pointsToWin = 25
	end
	
	if core.gameRegistry["beach_war_red_point"] == pointsToWin then 
		core.gameRegistry["beach_war_red_wins"] = core.gameRegistry["beach_war_red_wins"] + 1
		beach_war.roundWin("red") 
		return 

	elseif core.gameRegistry["beach_war_blue_point"] == pointsToWin then 
		core.gameRegistry["beach_war_blue_wins"] = core.gameRegistry["beach_war_blue_wins"] + 1
		beach_war.roundWin("blue") 
		return 
	end

end,

roundWin = function(teamID)

	local map = core.gameRegistry["beach_war_current_map"]
	local pc = core:getObjectsInMap(map, BL_PC)
	local teamName = ""
	
	if teamID == "red" then 
		teamName = "Red"
	elseif teamID == "blue" then
		teamName = "Blue"
	end
	
	broadcast(map, "-----------------------------------------------------------------------------------------------------")
	broadcast(map, "Round over! "..teamName.." Team has "..core.gameRegistry["beach_war_"..teamID.."_wins"].." of 2 wins!")
	
	for i = 1, #pc do
		if pc[i].registry["beach_war_team"] == 1 then --red team
			pc[i]:warp(map, 3, 2)
		end
		if pc[i].registry["beach_war_team"] == 2 then --blue team
			pc[i]:warp(map, 36, 47)
		end
	end
	
	if core.gameRegistry["beach_war_"..teamID.."_wins"] < 2 then
		beach_war.nextRound()
	elseif core.gameRegistry["beach_war_"..teamID.."_wins"] >= 2 then
		beach_war.declareWinner(teamID)
	end
	
end,


nextRound = function()

	local map = core.gameRegistry["beach_war_current_map"]
	local pc = core:getObjectsInMap(map, BL_PC)
	
	for i = 1, #pc do
		pc[i]:flushDurationNoUncast(517, 517) --flush any respawn duration
		pc[i].registry["beach_war_times_hit"] = 0 --eliminate hit count between rounds
	end
	
	core.gameRegistry["beach_war_red_point"] = 0
	core.gameRegistry["beach_war_blue_point"] = 0
	beach_war.wait()
	
end,

declareWinner = function(teamID)

	local map = core.gameRegistry["beach_war_current_map"]
	local pc = core:getObjectsInMap(map, BL_PC)
	local teamName = ""
	local teamNum = 0

	if teamID == "red" then 
		teamName = "Red"
		teamNum = 1
	elseif teamID == "blue" then
		teamName = "Blue"
		teamNum = 2
	end
	
	for i = 1, #pc do
		pc[i]:flushDurationNoUncast(517, 517) --flush any respawn duration
	end
	core.gameRegistry["beach_war_winner"] = teamNum
	broadcast(map, "         Game Over! "..teamName.." Team is the winner!")
	broadcast(map, "         You will exit the arena in 10 seconds!")
	
	core.gameRegistry["beach_war_end_timer"] = os.time() + 10
	
end,

endGame = function()

	local map = core.gameRegistry["beach_war_current_map"]
	local pc = core:getObjectsInMap(map, BL_PC)
	local arenaPC = core:getObjectsInMap(1031, BL_PC)
	local prizeRoom = 15992
	local loserRoom = 15982
	local x, y = 8, 10

	if core.gameRegistry["beach_war_end_timer"] > 0 and core.gameRegistry["beach_war_end_timer"] < os.time() then
		
		if #pc > 0 then
			for i =	1, #pc do
			
				if pc[i].registry["beach_war_team"] == core.gameRegistry["beach_war_winner"] then --if you are on the winning team
					pc[i]:warp(prizeRoom, math.random(4,12), math.random(6,11))--go to prize room	

				else --if you are not on the winning team
					pc[i]:warp(loserRoom, math.random(1,16), math.random(7,14)) --go to loser room
				end
			
			
				pc[i].registry["beach_war_times_hit"] = 0
				pc[i].registry["beach_war_gun_pct"] = 0
				pc[i].registry["beach_war_registered"] = 0
				pc[i].registry["beach_war_flag"] = 0
				pc[i].registry["beach_war_team"] = 0
				pc[i].registry["beach_war_kills"] = 0
			
				pc[i].gfxClone = 0
				pc[i].attackSpeed = 80
				pc[i]:updateState()
				pc[i]:calcStat()

				


			end
		end
		core.gameRegistry["beach_war_end_timer"] = 0
		core.gameRegistry["beach_war_players"] = 0
		core.gameRegistry["beach_war_open"] = 0
		core.gameRegistry["beach_war_winner"] = 0
		core.gameRegistry["beach_war_started"] = 0
		core.gameRegistry["beach_war_red_point"] = 0
		core.gameRegistry["beach_war_blue_point"] = 0
		core.gameRegistry["beach_war_current_map"] = 0
		core.gameRegistry["beach_war_red_wins"] = 0
		core.gameRegistry["beach_war_blue_wins"] = 0
		
		core.gameRegistry["beach_war_winner"] = 0

	end
end,


entryLegend = function(player)

	local reg = player.registry["beach_war_entries"]
	
----REMOVING LEGENDS AND REGISTRIES FROM OLD BEACH WAR
	if player:hasLegend("squirt_war_entries") then player:removeLegendbyName("squirt_war_entries") end
	if player:hasLegend("squirt_war_wins") then player:removeLegendbyName("squirt_war_wins") end
	player.registry["squirt_war_wins"] = 0
	player.registry["squirt_war_entries"] = 0
-------------------------------------------------------
	
	if player:hasLegend("beach_war_entries") then player:removeLegendbyName("beach_war_entries") end
	
	if reg > 0 then
		player.registry["beach_war_entries"] = player.registry["beach_war_entries"] + 1
		player:addLegend("Played in "..player.registry["beach_war_entries"].." Beach Wars", "beach_war_entries", 198, 16)
	else
		player.registry["beach_war_entries"] = 1
		player:addLegend("Played in 1 Beach War", "beach_war_entries", 198, 16)
	end
end,



victoryLegend = function(player)

	local reg = player.registry["beach_war_wins"]


	if player:hasLegend("beach_war_wins") then player:removeLegendbyName("beach_war_wins") end
	
	if reg > 0 then
		player.registry["beach_war_wins"] = player.registry["beach_war_wins"] + 1
		player:addLegend("Won "..player.registry["beach_war_wins"].." Beach Wars", "beach_war_wins", 198, 16)
	else
		player.registry["beach_war_wins"] = 1
		player:addLegend("Won 1 Beach War", "beach_war_wins", 198, 16)
	end

	player:addMinigamePoint(player)

end
}


respawning = {

uncast = function(player)



	if player.m == 15020 then 
		respawning.beachWarWarpIn(player, 0)
	end

end,

beachWarWarpIn = function(player, tries)
	
	local x = math.random(1, 38)
	local y = math.random(6, 43)
	local m = core.gameRegistry["beach_war_current_map"]
	local numTries
	
	numTries = tries + 1
	
	if numTries >= 20 then 
		if player.registry["beach_war_team"] == 1 then
			player:warp(m, 3, 8)
		elseif player.registry["beach_war_team"] == 2 then
			player:warp(m, 36, 41)
		end
		return
	end
	groundItem = player:getObjectsInCell(player.m, x, y, BL_ITEM)
	if getPass(player.m, x, y) == 0 then
		if not getWarp(player.m, x, y) then
			if getObject(player.m, x, y) == 0 then
				if #groundItem == 0 then
					player.registry["beach_war_gun_pct"] = 100
				    player:warp(m, x, y)
				else
					return respawning.beachWarWarpIn(player, numTries)
				end
			else
				return respawning.beachWarWarpIn(player, numTries)
			end
		else
			return respawning.beachWarWarpIn(player, numTries)
		end
	else
		return respawning.beachWarWarpIn(player, numTries)	
	end


end
}