--elixir_war.open() - opens minigame
--elixir_war.cancel() - cancels opened minigame before start
--elixir_war.stop() - stops game in progress, returns all players to arena with clean registry


elixir_war = {

playerCore = function(player)
	elixir_war.autoWarp(player)
	elixir_war.guiText(player)
end,

core = function()
	
	elixir_war.broadcastTimer()
	elixir_war.closed()
	elixir_war.enterArena()
	elixir_war.begin()
	elixir_war.endGame()
	
end,

open = function()
	
	local style = ""
	
	core.gameRegistry["elixir_war_open"] = 1		--Registry for game open
	
	core.gameRegistry["elixir_war_start_time"] = os.time()+600	--10 minute timer
	broadcast(-1, "-----------------------------------------------------------------------------------------------------")
	broadcast(-1, "                                Elixir War is now open in Hon Arena!")
	broadcast(-1, "                                Registration will close in 10 minutes!")
	broadcast(-1, "-----------------------------------------------------------------------------------------------------")
end,

click = async(function(player, npc)
	
----------Variable Declarations-----------------------------------	
	local total = {}	
	local pc = player:getObjectsInMap(15041, BL_PC)	--waiting room map
	local n = "<b>[Elixir War]\n\n"
	local t = {g = convertGraphic(npc.look, "monster"), c = npc.lookColor}
	player.npcGraphic = t.g
	player.npcColor = t.c
	player.dialogType = 0
	
	local str = ""
	local time = elixir_war.getStartTimer()
	local goldCost = 5000
	local opts = {}
	local diff
	
	if #pc > 0 then		--determine how many players in waiting room
		for i = 1, #pc do
			if pc[i].registry["elixir_war_registered"] > 0 then
				table.insert(total, pc[i].ID)
			end
		end
	end
---------------Table Inserts-----------------------------
	table.insert(opts, "How To Play?")
	if player.registry["elixir_war_registered"] == 1 and core.gameRegistry["elixir_war_started"] == 0 then table.insert(opts, "Hey! Let me in!") end
	if core.gameRegistry["elixir_war_open"] == 1 then	--If the game is open
		if player.registry["elixir_war_registered"] == 0 then	--if you have not registered
			table.insert(opts, "Register For Elixir War")
		end
		
		if player.registry["elixir_war_registered"] > 0 or player.registry["elixir_war_team"] > 0 then --If you have a bad registry for some reason, get the option to fix it
			table.insert(opts, "I can't register!")
		end
	end
	table.insert(opts, "Exit")
	
	if core.gameRegistry["elixir_war_start_time"] > os.time() then --if the game is open, get timer string
		str = "Waiting time: "..elixir_war.getStartTimer()
	end
----------------------------------------------------------

	
	menu = player:menuString(n.."Hello, the game will start in few minutes.\n"..str.."\nIn the waiting room: "..#total, opts) --Display the menu

-----------------Menu Options-------------------------	
	if menu == "How To Play?" then
		player:dialogSeq({t, n.."Elixir War is a variation on the traditional archery game.", 
							n.."Bring flags from your opponent's base to your own base to score points.",
							n.."You can shoot opponents with your bow to stun them for a short time.",
							n.."The first team to capture 3 flags wins the round!"}, 1)
		player:freeAsync()
		elixir_war.click(player, npc)
	elseif menu == "Hey! Let me in!" then
		core.gameRegistry["elixir_war_players"] = core.gameRegistry["elixir_war_players"] + 1
		player:warp(15041, math.random(2, 14), math.random(2, 12))
		player:sendAnimation(16)
		player:playSound(29)
		player:popUp("Welcome to Elixir War!\nPlease wait patiently until the game starts.")
		
	elseif menu == "Register For Elixir War" then
		if player.registry["minigame_ban_timer"] > os.time() then --Check if player is banned from minigames
			player:popUp("You are currently banned from minigames! Try again later maybe.")
			return
		end
		
		confirm = player:menuString("The cost to register is "..goldCost.." coins. Are you willing to pay to play?", {"Yes", "No"}) --Confirmation and payment
		if confirm == "Yes" then
			if player:removeGold(goldCost) == true then	--If the fee is succesfully removed
				diff = core.gameRegistry["elixir_war_start_time"] - os.time()
				player.registry["elixir_war_registered"] = 1
				if diff < 121 then --Less than 2 minutes until start, warp directly to waiting room
					elixir_war.warpToWaitingRoom(player)
				elseif diff >= 121 then --More than 2 minutes until start, just get registry
					player:dialogSeq({t, n.."Alright, your character is registered for Elixir War.\nYou will be sent to the waiting room 2 minutes before the game starts."}, 1)
				end
			else	--If you don't have enough coins
				player:popUp("Come back with some coins, ya bum!")
			end
		end
	elseif menu == "I can't register!" then
		player.registry["elixir_war_registered"] = 0
		player.registry["elixir_war_team"] = 0
		player.registry["elixir_war_flag"] = 0
		player:dialogSeq({t, n.."Looks like a simple paperwork mixup. You should be all set to register now, have fun at the game!"}, 1)
	end
end
),

warpToWaitingRoom = function(player)

	--player.registry["elixir_war_team"] = math.random(1, 2)
	core.gameRegistry["elixir_war_players"] = core.gameRegistry["elixir_war_players"] + 1
	player:warp(15041, math.random(2, 14), math.random(2, 12))
	player:sendAnimation(16)
	player:playSound(29)
	player:popUp("Welcome to Elixir War!\nPlease wait patiently until the game starts.")

end,

autoWarp = function(player)

	local diff = core.gameRegistry["elixir_war_start_time"] - os.time()
	
	if player.registry["elixir_war_registered"] == 1 then
		if diff == 120 then
			if player.m ~= 15041 and player.m ~= 15040 then
				elixir_war.warpToWaitingRoom(player)
			end
		end
	end

end,


guiText = function(player)

	local diff = core.gameRegistry["elixir_war_start_time"] - os.time()
	local diffwait = core.gameRegistry["elixir_war_wait_time"] - os.time()
--Player(4):talkSelf(0,"d1: "..diff)
--Player(4):talkSelf(0,"d2: "..diffwait)
	if diffwait == 0 then diffwait = 0 end
	
	if player.registry["elixir_war_registered"] == 1 and core.gameRegistry["elixir_war_started"] == 0 then
		if diff > 0 then
			player:guitext("\nElixir War registration will close in: "..getTimerValues("elixir_war_start_time").."    ")
		
		elseif diffwait > 0 then
			player:guitext("\nElixir War will begin in: "..getTimerValues("elixir_war_wait_time").."    ")
			
		else
			player:guitext("")
		end
	elseif player.registry["elixir_war_registered"] == 1 and core.gameRegistry["elixir_war_started"] == 1 then
		if diffwait > 0 then
			player:guitext("\nElixir War will begin in: "..getTimerValues("elixir_war_wait_time").."    ")
		else
			player:guitext("\nRED: "..core.gameRegistry["elixir_war_red_point"].." | BLUE: "..core.gameRegistry["elixir_war_blue_point"])
		end
	end
	
	if player.gmLevel > 0 and player.m == 15040 then
		player:guitext("\nRED: "..core.gameRegistry["elixir_war_red_point"].." | BLUE: "..core.gameRegistry["elixir_war_blue_point"])
	end
	
	
	
end,

broadcastTimer = function()
	
	local diff = core.gameRegistry["elixir_war_start_time"] - os.time()
	
--	if diff == 600 then
--		--broadcast(-1, "Elixir War registration will close in 10 minutes")
	if diff == 300 then
		broadcast(-1, "Elixir War registration will close in 5 minutes")
	elseif diff == 60 then
		broadcast(-1, "Elixir War registration will close in 1 minute")
	end

end,

getStartTimer = function()
		
	local hour, minute, second = 0, 0, 0
	
	if core.gameRegistry["elixir_war_start_time"] < os.time() then return "00:00:00" else
		dif = core.gameRegistry["elixir_war_start_time"] - os.time()
		hour = string.format("%02.f", math.floor(dif/3600))
		minute = string.format("%02.f", math.floor(dif/60-(hour*60)))
		second = string.format("%02.f", math.floor(dif-hour*3600-minute*60))
		return hour..":"..minute..":"..second
	end
end,

closed = function()

	local diff = core.gameRegistry["elixir_war_start_time"] - os.time()
	
	if core.gameRegistry["elixir_war_open"] == 1 then
		if core.gameRegistry["elixir_war_start_time"] > 0 then
			if core.gameRegistry["elixir_war_start_time"] > os.time() then
				if diff == 10 then
					broadcast(15041, "                                Elixir War registration will close in 10 seconds!")
				elseif diff <= 3 then
					broadcast(15041, "                                Elixir War registration will close in "..diff.." seconds!")
				end
			elseif core.gameRegistry["elixir_war_start_time"] < os.time() then
				core.gameRegistry["elixir_war_open"] = 0
				core.gameRegistry["elixir_war_start_time"] = 0
				broadcast(-1, "-----------------------------------------------------------------------------------------------------")
				broadcast(-1, "                                 Elixir War entry is closed!")
				broadcast(-1, "-----------------------------------------------------------------------------------------------------")
				elixir_war.start()
			end
		end
	end

end,

getRandomMap = function()

	local allElixirWarMaps = {15040}
	local randomMap = allElixirWarMaps[math.random(1, #allElixirWarMaps)]
	
	core.gameRegistry["elixir_war_current_map"] = randomMap

end,

setMapBlockers = function(mapID)

	local blocker = 1581
	local noPass = 1

	if mapID == 15040 then
	
		--red blocker objects
		setObject(mapID, 9, 6, blocker)
		setObject(mapID, 9, 7, blocker)
		setObject(mapID, 9, 8, blocker)
		setObject(mapID, 9, 9, blocker)
		setObject(mapID, 9, 10, blocker)
		setObject(mapID, 9, 11, blocker)
		setObject(mapID, 9, 12, blocker)
		setObject(mapID, 9, 13, blocker)
		setObject(mapID, 2, 13, blocker)
		setObject(mapID, 3, 13, blocker)		
		setObject(mapID, 4, 13, blocker)
		setObject(mapID, 5, 13, blocker)		
		setObject(mapID, 6, 13, blocker)
		setObject(mapID, 7, 13, blocker)		
		setObject(mapID, 8, 13, blocker)
		
		--red blocker pass
		setPass(mapID, 9, 6, noPass)
		setPass(mapID, 9, 7, noPass)
		setPass(mapID, 9, 8, noPass)
		setPass(mapID, 9, 9, noPass)
		setPass(mapID, 9, 10, noPass)
		setPass(mapID, 9, 11, noPass)
		setPass(mapID, 9, 12, noPass)
		setPass(mapID, 9, 13, noPass)
		setPass(mapID, 2, 13, noPass)
		setPass(mapID, 3, 13, noPass)		
		setPass(mapID, 4, 13, noPass)
		setPass(mapID, 5, 13, noPass)		
		setPass(mapID, 6, 13, noPass)
		setPass(mapID, 7, 13, noPass)		
		setPass(mapID, 8, 13, noPass)
		
		--blue blocker objects
		setObject(mapID, 23, 27, blocker)
		setObject(mapID, 23, 28, blocker)
		setObject(mapID, 23, 29, blocker)
		setObject(mapID, 23, 30, blocker)
		setObject(mapID, 23, 31, blocker)
		setObject(mapID, 23, 32, blocker)
		setObject(mapID, 23, 33, blocker)
		setObject(mapID, 23, 34, blocker)
		setObject(mapID, 24, 27, blocker)
		setObject(mapID, 25, 27, blocker)
		setObject(mapID, 26, 27, blocker)
		setObject(mapID, 27, 27, blocker)
		setObject(mapID, 28, 27, blocker)
		setObject(mapID, 29, 27, blocker)
		setObject(mapID, 30, 27, blocker)
		
		--blue blocker pass
		setPass(mapID, 23, 27, noPass)
		setPass(mapID, 23, 28, noPass)
		setPass(mapID, 23, 29, noPass)
		setPass(mapID, 23, 30, noPass)
		setPass(mapID, 23, 31, noPass)
		setPass(mapID, 23, 32, noPass)
		setPass(mapID, 23, 33, noPass)
		setPass(mapID, 23, 34, noPass)
		setPass(mapID, 24, 27, noPass)
		setPass(mapID, 25, 27, noPass)
		setPass(mapID, 26, 27, noPass)
		setPass(mapID, 27, 27, noPass)
		setPass(mapID, 28, 27, noPass)
		setPass(mapID, 29, 27, noPass)
		setPass(mapID, 30, 27, noPass)		
		
	end
end,

removeMapBlockers = function(mapID)

	local noBlocker = 0
	local pass = 0

	if mapID == 15040 then
		--red blocker objects
		setObject(mapID, 9, 6, noBlocker)
		setObject(mapID, 9, 7, noBlocker)
		setObject(mapID, 9, 8, noBlocker)
		setObject(mapID, 9, 9, noBlocker)
		setObject(mapID, 9, 10, noBlocker)
		setObject(mapID, 9, 11, noBlocker)
		setObject(mapID, 9, 12, noBlocker)
		setObject(mapID, 9, 13, noBlocker)
		setObject(mapID, 2, 13, noBlocker)
		setObject(mapID, 3, 13, noBlocker)		
		setObject(mapID, 4, 13, noBlocker)
		setObject(mapID, 5, 13, noBlocker)		
		setObject(mapID, 6, 13, noBlocker)
		setObject(mapID, 7, 13, noBlocker)		
		setObject(mapID, 8, 13, noBlocker)
		
		--red blocker pass
		setPass(mapID, 9, 6, pass)
		setPass(mapID, 9, 7, pass)
		setPass(mapID, 9, 8, pass)
		setPass(mapID, 9, 9, pass)
		setPass(mapID, 9, 10, pass)
		setPass(mapID, 9, 11, pass)
		setPass(mapID, 9, 12, pass)
		setPass(mapID, 9, 13, pass)
		setPass(mapID, 2, 13, pass)
		setPass(mapID, 3, 13, pass)		
		setPass(mapID, 4, 13, pass)
		setPass(mapID, 5, 13, pass)		
		setPass(mapID, 6, 13, pass)
		setPass(mapID, 7, 13, pass)		
		setPass(mapID, 8, 13, pass)
		
		--blue blocker objects
		setObject(mapID, 23, 27, noBlocker)
		setObject(mapID, 23, 28, noBlocker)
		setObject(mapID, 23, 29, noBlocker)
		setObject(mapID, 23, 30, noBlocker)
		setObject(mapID, 23, 31, noBlocker)
		setObject(mapID, 23, 32, noBlocker)
		setObject(mapID, 23, 33, noBlocker)
		setObject(mapID, 23, 34, noBlocker)
		setObject(mapID, 24, 27, noBlocker)
		setObject(mapID, 25, 27, noBlocker)
		setObject(mapID, 26, 27, noBlocker)
		setObject(mapID, 27, 27, noBlocker)
		setObject(mapID, 28, 27, noBlocker)
		setObject(mapID, 29, 27, noBlocker)
		setObject(mapID, 30, 27, noBlocker)
		
		--blue blocker pass
		setPass(mapID, 23, 27, pass)
		setPass(mapID, 23, 28, pass)
		setPass(mapID, 23, 29, pass)
		setPass(mapID, 23, 30, pass)
		setPass(mapID, 23, 31, pass)
		setPass(mapID, 23, 32, pass)
		setPass(mapID, 23, 33, pass)
		setPass(mapID, 23, 34, pass)
		setPass(mapID, 24, 27, pass)
		setPass(mapID, 25, 27, pass)
		setPass(mapID, 26, 27, pass)
		setPass(mapID, 27, 27, pass)
		setPass(mapID, 28, 27, pass)
		setPass(mapID, 29, 27, pass)
		setPass(mapID, 30, 27, pass)	
	end


end,

start = function()


	elixir_war.assignTeams()
	elixir_war.getRandomMap()
	local map = core.gameRegistry["elixir_war_current_map"]
	local pc = core:getObjectsInMap(15041, BL_PC)

--	
	
	if core.gameRegistry["elixir_war_players"] >= 2 then
		if #pc > 0 then	
			--elixir_war.assignTeams()
			for i = 1, #pc do			
				if pc[i].registry["elixir_war_team"] > 0 and pc[i].state ~= 0 then 				
					pc[i].state = 0 
					pc[i].speed = 80
					pc[i].registry["mounted"] = 0
					pc[i]:updateState()
				end
				
				elixir_war.costume(pc[i])
				elixir_war.entryLegend(pc[i])
				if pc[i].registry["elixir_war_team"] == 1 then --red team
					pc[i]:warp(map, 4, 2)
				end

				if pc[i].registry["elixir_war_team"] == 2 then --blue team
					pc[i]:warp(map, 28, 38)
				end
			end
			elixir_war.wait()
		end
	else
		broadcast(-1, "-----------------------------------------------------------------------------------------------------")
		broadcast(-1, "                             Not enough players. Elixir War cancelled!")
		broadcast(-1, "-----------------------------------------------------------------------------------------------------")
		elixir_war.cancel()
	end
		
end,

costume = function(player)
	
	local team = player.registry["elixir_war_team"]
	local dye, str = 0, ""

	if team == 1 then
		dye = 31
	elseif team == 2 then
		dye = 17
	end
	if player.sex == 0 then
		armor = 4
	elseif player.sex == 1 then
		armor = 8
	end
	
	if player.faceAccessoryTwo > 0 then
		player.gfxFaceAT = player.faceAccessoryTwo
		player.gfxFaceATC = player.faceAccessoryTwoColor
	else
		player.gfxFaceAT = 65535
		player.gfxFaceATC = 0
	end
	
	player.gfxArmor = armor
	player.gfxDye = dye
	player.gfxCrown = 65535
	player.gfxShield = 65535
	player.gfxWeap = 20014
	player.gfxWeapC = 0
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
	player.registry["elixir_war_flag"] = 0
	player:updateState()




end,


assignTeams = function()

	local red, blue = 0, 0
	local pc = core:getObjectsInMap(15041, BL_PC)
	local randomTeam
	
	if #pc > 0 then
		for i = 1, #pc do
			if pc[i].registry["elixir_war_team"] == 0 then
				if red == blue then
					randomTeam = math.random(1,2)
					pc[i].registry["elixir_war_team"] = randomTeam
					if randomTeam == 1 then 
						red = red + 1
					elseif randomTeam == 2 then
						blue = blue + 1
					end
				elseif blue > red then
					pc[i].registry["elixir_war_team"] = 1
					red = red + 1
				elseif red > blue then
					pc[i].registry["elixir_war_team"] = 2
					blue = blue + 1
				end
			
			end
		end
	end
	
	if #pc > 0 then
		for i = 1, #pc do	
			if red > blue then
				if (red-blue) ~= 1 then pc[math.random(#pc)].registry["elixir_war_team"] = 2 break end
			end
			if red < blue then
				if blue - red ~= 1 then pc[math.random(#pc)].registry["elixir_war_team"] = 1 break end
			end
		end
	end

end,

wait = function(npc)
	
	local map = core.gameRegistry["elixir_war_current_map"]
	
	local pc = core:getObjectsInMap(map, BL_PC)
	core.gameRegistry["elixir_war_wait_time"] = os.time() + 60
	elixir_war.setMapBlockers(map)
	

	--- remove everyone's flags if carrying -----
	for i = 1, #pc do
		pc[i].registry["elixir_war_flag"] = 0
		pc[i].gfxCape = 65535
		pc[i]:updateState()
	end





	broadcast(map, "-----------------------------------------------------------------------------------------------------")
	broadcast(map, "                                    Get Ready! The round starts in 60 seconds!")
	broadcast(map, "-----------------------------------------------------------------------------------------------------")
	
end,

enterArena = function()

	local diff = core.gameRegistry["elixir_war_wait_time"] - os.time()
	local map = core.gameRegistry["elixir_war_current_map"]
	local pc = core:getObjectsInMap(map, BL_PC)
	
	if diff == 30 then
		for i = 1, #pc do
			
			if pc[i].registry["elixir_war_team"] == 1 then
				pc[i]:warp(map, 4, 9)
			elseif pc[i].registry["elixir_war_team"] == 2 then
				pc[i]:warp(map, 28, 33)
			end
			pc[i].registry["elixir_war_flag"] = 0
			pc[i].registry["elixir_war_hit"] = 0
			pc[i].registry["elixir_war_burn_time"] = 0
			
			pc[i].registry["elixir_war_arrows"] = 22
			pc[i]:sendMinitext("You have 22 arrows")
		end
		broadcast(map, "                                    Elixir War starts in 30 seconds!")
	end
	
end,


begin = function()

	local diff = core.gameRegistry["elixir_war_wait_time"] - os.time()
	local map = core.gameRegistry["elixir_war_current_map"]
	local pc = core:getObjectsInMap(map, BL_PC)


	if diff == 0 then
		core.gameRegistry["elixir_war_started"] = 1
		elixir_war.removeMapBlockers(map)

		broadcast(map, "-----------------------------------------------------------------------------------------------------")
		broadcast(map, "                                   The Elixir War has begun!")
		broadcast(map, "-----------------------------------------------------------------------------------------------------")
	end
end,

stop = function(type) -- 0 to return to arena, 1 to send all to loser room, 2 to send all to prizeroom

	local prizeRoom = 15994
	local loserRoom = 15984

	local map = core.gameRegistry["elixir_war_current_map"]

	local pc = core:getObjectsInMap(map, BL_PC)

	core.gameRegistry["elixir_war_end_timer"] = 0
	core.gameRegistry["elixir_war_players"] = 0
	core.gameRegistry["elixir_war_open"] = 0
	core.gameRegistry["elixir_war_winner"] = 0
	core.gameRegistry["elixir_war_started"] = 0
	core.gameRegistry["elixir_war_red_point"] = 0
	core.gameRegistry["elixir_war_blue_point"] = 0
	core.gameRegistry["elixir_war_current_map"] = 0
	core.gameRegistry["elixir_war_red_wins"] = 0
	core.gameRegistry["elixir_war_blue_wins"] = 0
	
	if #pc > 0 then
		for i = 1, #pc do
			pc[i].registry["elixir_war_registered"] = 0
			pc[i].registry["elixir_war_flag"] = 0
			pc[i].registry["elixir_war_team"] = 0
			pc[i].registry["elixir_war_hit"] = 0
			pc[i].registry["elixir_war_arrows"] = 0
			pc[i].registry["elixir_war_burn_time"] = 0
			pc[i].gfxClone = 0
			pc[i]:updateState()
			if type == 0 then
				pc[i]:warp(1031, math.random(13,17), math.random(4, 7))
			elseif type == 1 then
				pc[i]:warp(loserRoom, math.random(1,16), math.random(7,14))
			elseif type == 2 then
				pc[i]:warp(prizeRoom, math.random(4,12), math.random(6,11))
			else
				pc[i]:warp(1031, math.random(13,17), math.random(4, 7))
			end
			pc[i]:sendAnimation(16)
			pc[i]:playSound(29)
			pc[i]:calcStat()

		end
	end
end,

cancel = function()

	local map = 15041

	local pc = core:getObjectsInMap(map, BL_PC)

	core.gameRegistry["elixir_war_start_time"] = 0
	core.gameRegistry["elixir_war_end_timer"] = 0
	core.gameRegistry["elixir_war_players"] = 0
	core.gameRegistry["elixir_war_open"] = 0
	core.gameRegistry["elixir_war_winner"] = 0
	core.gameRegistry["elixir_war_started"] = 0
	core.gameRegistry["elixir_war_red_point"] = 0
	core.gameRegistry["elixir_war_blue_point"] = 0
	core.gameRegistry["elixir_war_current_map"] = 0
	core.gameRegistry["elixir_war_red_wins"] = 0
	core.gameRegistry["elixir_war_blue_wins"] = 0
	
	if #pc > 0 then
		for i = 1, #pc do
			pc[i].registry["elixir_war_registered"] = 0
			pc[i].registry["elixir_war_flag"] = 0
			pc[i].registry["elixir_war_team"] = 0
			pc[i].registry["elixir_war_hit"] = 0
			pc[i].registry["elixir_war_arrows"] = 0
			pc[i].registry["elixir_war_burn_time"] = 0
			
			pc[i].attackSpeed = 20
			pc[i].gfxClone = 0
			pc[i]:updateState()
			pc[i]:warp(1031, math.random(13,17), math.random(4, 7))
			pc[i]:sendAnimation(16)
			pc[i]:playSound(29)
			pc[i]:calcStat()

		end
	end
end,




hit = function(player, target)
		
	if target.registry["elixir_war_hit"] == 1 then return else
		if player.registry["elixir_war_team"] == 1 then
			target.gfxDye = 2
		elseif player.registry["elixir_war_team"] == 2 then
			target.gfxDye = 4
		end
		target.registry["elixir_war_hit"] = 1
		target:updateState()
	end
end,

rescue = function(player, target)
	
	if target.registry["elixir_war_hit"] == 1 then 
		if player.registry["elixir_war_team"] == 1 then
			target.gfxDye = 31
		elseif player.registry["elixir_war_team"] == 2 then
			target.gfxDye = 17
		end
		target.registry["elixir_war_hit"] = 0
		target:updateState()
	end
end,

shoot = function(player)
	
	local team = player.registry["elixir_war_team"]
	local m, x, y, side = player.m, player.x, player.y, player.side
	local icon = side+6
	local pc
	
	if team > 0 then
		if player.m == 15040 and player.gfxClone == 1 then
			if player.registry["elixir_war_arrows"] > 0 then

				player:playSound(709)
				player:sendAction(1, 20)
				player.registry["elixir_war_arrows"] = player.registry["elixir_war_arrows"] - 1
				player:sendMinitext("Arrows remaining: "..player.registry["elixir_war_arrows"])
		
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
					if pc ~= nil and pc.registry["elixir_war_team"] > 0 then 
						if team == pc.registry["elixir_war_team"] then elixir_war.rescue(player, pc) else elixir_war.hit(player, pc) end
						return
					end
					if side == 0 then
						player:throw(x, y-i, icon, 0, 1)
					elseif side == 1 then
						player:throw(x+i, y, icon, 0, 1)
					elseif side == 2 then
						player:throw(x, y+i, icon, 0, 1)
					elseif side == 3 then
						player:throw(x-i, y, icon, 0, 1)
					end
				end
			else
				player:sendMinitext("You are out of arrows!")
			end
		end
	end
end,

out = function(player)

	local pc = core:getObjectsInMap(15040, BL_PC)
	local onField = {}

	player.registry["elixir_war_burn_time"] = 0
	player.registry["elixir_war_hit"] = 0
	player.registry["elixir_war_arrows"] = 0
	player.registry["elixir_war_flag"] = 0




	if player.registry["elixir_war_team"] == 1 then
		player.gfxDye = 31
		player:updateState()
		player:warp(15040, 9, 2)

	elseif player.registry["elixir_war_team"] == 2 then
		player.gfxDye = 17
		player:updateState()
		player:warp(15040, 23, 38)
	end

	for i = 1, #pc do
		if pc[i].x >= 2 and pc[i].x <= 30 then
			if pc[i].y >= 6 and pc[i].y <= 34 then
				table.insert(onField, pc[i].ID)
			end
		end
	end

	if #onField == 0 then
		broadcast(15040, "-----------------------------------------------------------------------------------------------------")
		broadcast(15040, "                          NO WINNER! What happened?")
		elixir_war.nextRound()
	end

end,

sideline = function(player)

	local timer = 0
	
	if core.gameRegistry["elixir_war_started"] == 1 then
		player.registry["elixir_war_burn_time"] = player.registry["elixir_war_burn_time"] + 1
	end

	if player.registry["elixir_war_burn_time"] == 30 then player:sendMinitext("You will be sidelined if you don't move in 30 seconds!") end
	for i = 1, 10 do
		timer = i
		if player.registry["elixir_war_burn_time"] == 60 - timer then
			player:sendMinitext("You will be sidelined if you don't move in "..timer.." seconds!") 
		end
	end
	if player.registry["elixir_war_burn_time"] >= 60 then player:sendMinitext("You have been sidelined for standing still!") elixir_war.out(player) end

end,




walk = function(player)
	
	local blueFlag = {18086}
	local redFlag = {37578}
	local tile = getTile(player.m, player.x, player.y)
	local pc = player:getObjectsInMap(15040, BL_PC)
	
	if player.m == 15040 and player.registry["elixir_war_team"] > 0 then
		player.registry["elixir_war_burn_time"] = 0
		if player.gfxDye == 2 or player.gfxDye == 4 then elixir_war.out(player) return end

	
		for i = 1, #blueFlag do
			if player.registry["elixir_war_team"] == 1 then
				if tile == blueFlag[i] then
					if player.registry["elixir_war_flag"] == 0 then
						if player.state == 1 then -- Minigame Bans for those trying the dead trick
								elixir_war.banPlayer(player)
								return
							end
						player:sendAction(2, 20)
						--player:sendAnimation(326)
						--player:playSound(505)
						player.registry["elixir_war_flag"] = 1
						player.gfxCape = 46
						player.gfxCapeC = 26
						player:updateState()
						broadcast(15040, "                                       "..player.name.." has taken the Blue Team's flag!")
						
					end
				elseif tile == redFlag[i] then
					if core.gameRegistry["elixir_war_game_over"] == 0 then
						if player.registry["elixir_war_flag"] == 1 then						
								if player.state == 1 then -- minigame bans for those trying the dead trick
								elixir_war.banPlayer(player)
								return
								end

		  					player.gfxCape = 65535
							player.gfxCapeC = 0
							player.registry["elixir_war_flag"] = 0
							core.gameRegistry["elixir_war_red_point"] = core.gameRegistry["elixir_war_red_point"] + 1
							--player:sendAnimation(349)
							--player:playSound(112)
							broadcast(15040, "                                       "..player.name.." has captured the Blue Team's flag!")
							broadcast(15040, "                                       [Red Team = "..core.gameRegistry["elixir_war_red_point"].."] VS [Blue Team = "..core.gameRegistry["elixir_war_blue_point"].."]")
							player.registry["total_elixir_war_captures"] = player.registry["total_elixir_war_captures"] + 1 --permancent registry for stat tracking
							player:updateState()
							elixir_war.winnerCheck()
						else
							elixir_war.out(player)
						end
					end	
				end
				
			elseif player.registry["elixir_war_team"] == 2 then
				if tile == redFlag[i] then
					if player.registry["elixir_war_flag"] == 0 then
							if player.state == 1 then -- minigame bans for those trying the dead trick
								elixir_war.banPlayer(player)
								return
							end
						player:sendAction(2, 20)
						--player:sendAnimation(326)
						--player:playSound(505)	
						player.registry["elixir_war_flag"] = 1
						player.gfxCape = 46
						player.gfxCapeC = 22
						player:updateState()
						broadcast(15040, "                                       "..player.name.." has taken the Red Team's flag!")
						
					end
				elseif tile == blueFlag[i] then
					if core.gameRegistry["elixir_war_game_over"] == 0 then
						if player.registry["elixir_war_flag"] == 1 then
							if player.state == 1 then -- minigame bans for those trying the dead trick
								elixir_war.banPlayer(player)
								return
							end
							player.gfxCape = 65535
							player.gfxCapeC = 0
							player.registry["elixir_war_flag"] = 0
							core.gameRegistry["elixir_war_blue_point"] = core.gameRegistry["elixir_war_blue_point"] + 1
							--player:sendAnimation(349)
							--player:playSound(112)
							broadcast(15040, "                                       "..player.name.." has captured the Red Team's flag!")
							broadcast(15040, "                                       [Red Team = "..core.gameRegistry["elixir_war_red_point"].."] VS [Blue Team = "..core.gameRegistry["elixir_war_blue_point"].."]")
							player.registry["total_elixir_war_captures"] = player.registry["total_elixir_war_captures"] + 1 --permancent registry for stat tracking
							player:updateState()
							elixir_war.winnerCheck()
						else
							elixir_war.out(player)
						end
					end
				end
			end
		end
	end
end,


winnerCheck = function()

	local pointsToWin = 1
	local map = core.gameRegistry["elixir_war_current_map"]
	local pc = core:getObjectsInMap(map, BL_PC)
	local red, blue = {}, {}
	
	for i = 1, #pc do
		if pc[i].registry["elixir_war_team"] == 1 then --red team
			table.insert(red, pc[i])
		end
		if pc[i].registry["elixir_war_team"] == 2 then --blue team
			table.insert(blue, pc[i])
		end
	end
	
	if core.gameRegistry["elixir_war_red_point"] >= pointsToWin then 
		core.gameRegistry["elixir_war_red_wins"] = core.gameRegistry["elixir_war_red_wins"] + 1
		elixir_war.roundWin("red") 
		return 

	elseif core.gameRegistry["elixir_war_blue_point"] >= pointsToWin then 
		core.gameRegistry["elixir_war_blue_wins"] = core.gameRegistry["elixir_war_blue_wins"] + 1
		elixir_war.roundWin("blue") 
		return 
	else
		if (#red > 0 and #blue == 0) or (#blue > 0 and #red == 0) then
			broadcast(15040, "-----------------------------------------------------------------------------------------------------")
			broadcast(15040, "                          NO WINNER! What had happened?")
			elixir_war.stop(0)
		end
	end

end,

roundWin = function(teamID)

	local map = core.gameRegistry["elixir_war_current_map"]
	local pc = core:getObjectsInMap(map, BL_PC)
	local teamName = ""
	
	if teamID == "red" then 
		teamName = "Red"
	elseif teamID == "blue" then
		teamName = "Blue"
	end
	core.gameRegistry["elixir_war_red_point"] = 0
	core.gameRegistry["elixir_war_blue_point"] = 0
	
	



	if core.gameRegistry["elixir_war_winner"] == 0 then
	
		broadcast(map, "-----------------------------------------------------------------------------------------------------")
		broadcast(map, "Round over! "..teamName.." Team has "..core.gameRegistry["elixir_war_"..teamID.."_wins"].." of 2 wins!")
		
		for i = 1, #pc do
			if pc[i].registry["elixir_war_team"] == 1 then --red team
				elixir_war.costume(pc[i])
				pc[i]:warp(map, 4, 2)
			end
			if pc[i].registry["elixir_war_team"] == 2 then --blue team
				elixir_war.costume(pc[i])
				pc[i]:warp(map, 28, 38)
			end
		end
	
	local red_team_wins = core.gameRegistry["elixir_war_red_wins"] 
	local blue_team_wins = core.gameRegistry["elixir_war_blue_wins"]

	
	if teamID == "red" then
		if red_team_wins - blue_team_wins >= 2 then
			elixir_war.declareWinner("red")
		else elixir_war.nextRound()
		end	
	end

	if teamID == "blue" then
		if blue_team_wins - red_team_wins >= 2 then
			elixir_war.declareWinner("blue")
		else elixir_war.nextRound()
		end	
	end






		--if core.gameRegistry["elixir_war_"..teamID.."_wins"] < 2 then
		--	elixir_war.nextRound()
		--elseif core.gameRegistry["elixir_war_"..teamID.."_wins"] >= 2 then
		--	elixir_war.declareWinner(teamID)
		--end
	



end
	
end,


nextRound = function()

	local map = core.gameRegistry["elixir_war_current_map"]
	local pc = core:getObjectsInMap(map, BL_PC)

	elixir_war.wait()
	
end,

declareWinner = function(teamID)

	local map = core.gameRegistry["elixir_war_current_map"]
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
	
	core.gameRegistry["elixir_war_winner"] = teamNum
	broadcast(map, "         Game Over! "..teamName.." Team is the winner!")
	broadcast(map, "         You will exit the arena in 10 seconds!")
	
	core.gameRegistry["elixir_war_end_timer"] = os.time() + 10
	
end,

endGame = function()

	local map = core.gameRegistry["elixir_war_current_map"]
	local pc = core:getObjectsInMap(map, BL_PC)
	local arenaPC = core:getObjectsInMap(1031, BL_PC)
	local prizeRoom = 15994
	local loserRoom = 15984
	local x, y = 8, 10

	if core.gameRegistry["elixir_war_end_timer"] > 0 and core.gameRegistry["elixir_war_end_timer"] < os.time() then
		
		if #pc > 0 then
			for i =	1, #pc do
			
				if pc[i].registry["elixir_war_team"] == core.gameRegistry["elixir_war_winner"] then --if you are on the winning team
					pc[i]:warp(prizeRoom, math.random(4,12), math.random(6,11)) --go to prize room	

				else --if you are not on the winning team
					pc[i]:warp(loserRoom, math.random(1,16), math.random(7,14)) --go to loser room
				end

				pc[i].registry["elixir_war_registered"] = 0
				pc[i].registry["elixir_war_flag"] = 0
				pc[i].registry["elixir_war_team"] = 0
				pc[i].registry["elixir_war_hit"] = 0
				pc[i].registry["elixir_war_arrows"] = 0
				pc[i].registry["elixir_war_burn_time"] = 0
				pc[i].gfxClone = 0
				pc[i]:updateState()
				


			end
		end
		core.gameRegistry["elixir_war_end_timer"] = 0
		core.gameRegistry["elixir_war_players"] = 0
		core.gameRegistry["elixir_war_open"] = 0
		core.gameRegistry["elixir_war_winner"] = 0
		core.gameRegistry["elixir_war_started"] = 0
		core.gameRegistry["elixir_war_red_point"] = 0
		core.gameRegistry["elixir_war_blue_point"] = 0
		core.gameRegistry["elixir_war_current_map"] = 0
		core.gameRegistry["elixir_war_red_wins"] = 0
		core.gameRegistry["elixir_war_blue_wins"] = 0

	end
end,


entryLegend = function(player)

	local reg = player.registry["elixir_war_entries"]
	
----REMOVING LEGENDS AND REGISTRIES FROM OLD elixir
	if player:hasLegend("elixir_entries") then player:removeLegendbyName("elixir_entries") end
	if player:hasLegend("elixir_wins") then player:removeLegendbyName("elixir_wins") end
	player.registry["elixir_wins"] = 0
	player.registry["elixir_entries"] = 0
-------------------------------------------------------
	
	if player:hasLegend("elixir_war_entries") then player:removeLegendbyName("elixir_war_entries") end
	
	if reg > 0 then
		player.registry["elixir_war_entries"] = player.registry["elixir_war_entries"] + 1
		player:addLegend("Played in "..player.registry["elixir_war_entries"].." Elixir Wars", "elixir_war_entries", 104, 16)
	else
		player.registry["elixir_war_entries"] = 1
		player:addLegend("Played in 1 Elixir War", "elixir_war_entries", 104, 16)
	end
end,



victoryLegend = function(player)

	local reg = player.registry["elixir_war_wins"]


	if player:hasLegend("elixir_war_wins") then player:removeLegendbyName("elixir_war_wins") end
	
	if reg > 0 then
		player.registry["elixir_war_wins"] = player.registry["elixir_war_wins"] + 1
		player:addLegend("Won "..player.registry["elixir_war_wins"].." Elixir Wars", "elixir_war_wins", 17, 16)
	else
		player.registry["elixir_war_wins"] = 1
		player:addLegend("Won 1 Elixir War", "elixir_war_wins", 17, 16)
	end

	player:addMinigamePoint(player)

end,

while_cast = function(player)

	player.paralyzed = true
end,

uncast = function(player)
	
	player.paralyzed = false
end
}