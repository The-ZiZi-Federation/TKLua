--freeze_war.open() - opens minigame
--freeze_war.cancel() - cancels opened minigame before start
--freeze_war.stop() - stops game in progress, returns all players to arena with clean registry


freeze_war = {

playerCore = function(player)
	freeze_war.autoWarp(player)
	freeze_war.guiText(player)
end,

core = function()
	
	freeze_war.broadcastTimer()
	freeze_war.closed()
	freeze_war.enterArena()
	freeze_war.begin()
	freeze_war.endGame()
	
end,

open = function()
	
	local style = ""
	
	core.gameRegistry["freeze_war_open"] = 1		--Registry for game open
	
	if core.gameRegistry["freeze_war_shot_speed"] == 1 then		--
		core.gameRegistry["freeze_war_shot_speed"] = 2
		style = "Rapid-Fire"
	else
		core.gameRegistry["freeze_war_shot_speed"] = 1
		style = "Tactical"
	end
	
	if core.gameRegistry["freeze_war_shot_speed"] == 0 then
		core.gameRegistry["freeze_war_shot_speed"] = 2
		style = "Rapid-Fire"
	end
	
	
	core.gameRegistry["freeze_war_start_time"] = os.time()+600	--15 minute timer
	broadcast(-1, "-----------------------------------------------------------------------------------------------------")
	broadcast(-1, "                                "..style.." Freeze War is now open in Hon Arena!")
	broadcast(-1, "                                Registration will close in 10 minutes!")
	broadcast(-1, "-----------------------------------------------------------------------------------------------------")
end,

click = async(function(player, npc)
	
----------Variable Declarations-----------------------------------	
	local total = {}	
	local pc = player:getObjectsInMap(15011, BL_PC)	--waiting room map
	local n = "<b>[Freeze War]\n\n"
	local t = {g = convertGraphic(npc.look, "monster"), c = npc.lookColor}
	player.npcGraphic = t.g
	player.npcColor = t.c
	player.dialogType = 0
	
	local str = ""
	local time = freeze_war.getStartTimer()
	local goldCost = 5000
	local opts = {}
	local diff
	
	if #pc > 0 then		--determine how many players in waiting room
		for i = 1, #pc do
			if pc[i].registry["freeze_war_registered"] > 0 then
				table.insert(total, pc[i].ID)
			end
		end
	end
---------------Table Inserts-----------------------------
	table.insert(opts, "How To Play?")
	if player.registry["freeze_war_registered"] == 1 and core.gameRegistry["freeze_war_started"] == 0 then table.insert(opts, "Hey! Let me in!") end
	if core.gameRegistry["freeze_war_open"] == 1 then	--If the game is open
		if player.registry["freeze_war_registered"] == 0 then	--if you have not registered
			table.insert(opts, "Register For Freeze War")
		end
		
		if player.registry["freeze_war_registered"] > 0 or player.registry["freeze_war_team"] > 0 then --If you have a bad registry for some reason, get the option to fix it
			table.insert(opts, "I can't register!")
		end
	end
	table.insert(opts, "Exit")
	
	if core.gameRegistry["freeze_war_start_time"] > os.time() then --if the game is open, get timer string
		str = "Waiting time: "..freeze_war.getStartTimer()
	end
----------------------------------------------------------

	
	menu = player:menuString(n.."Hello, the game will start in few minutes.\n"..str.."\nIn the waiting room: "..#total, opts) --Display the menu

-----------------Menu Options-------------------------	
	if menu == "How To Play?" then
		player:dialogSeq({t, n.."Freeze War is a variation on the traditional archery game.", 
							n.."Bring flags from your opponent's base to your own base to score points.",
							n.."You can shoot opponents with your bow to stun them for a short time.",
							n.."The first team to capture 3 flags wins the round!"}, 1)
		player:freeAsync()
		freeze_war.click(player, npc)
	elseif menu == "Hey! Let me in!" then
		core.gameRegistry["freeze_war_players"] = core.gameRegistry["freeze_war_players"] + 1
		player:warp(15011, math.random(2, 14), math.random(2, 12))
		player:sendAnimation(16)
		player:playSound(29)
		player:popUp("Welcome to Freeze War!\nPlease wait patiently until the game starts.")
		
	elseif menu == "Register For Freeze War" then
		if player.registry["minigame_ban_timer"] > os.time() then --Check if player is banned from minigames
			player:popUp("You are currently banned from minigames! Try again later maybe.")
			return
		end
		
		confirm = player:menuString("The cost to register is "..goldCost.." coins. Are you willing to pay to play?", {"Yes", "No"}) --Confirmation and payment
		if confirm == "Yes" then
			if player:removeGold(goldCost) == true then	--If the fee is succesfully removed
				diff = core.gameRegistry["freeze_war_start_time"] - os.time()
				player.registry["freeze_war_registered"] = 1
				if diff < 121 then --Less than 2 minutes until start, warp directly to waiting room
					freeze_war.warpToWaitingRoom(player)
				elseif diff >= 121 then --More than 2 minutes until start, just get registry
					player:dialogSeq({t, n.."Alright, your character is registered for Freeze War.\nYou will be sent to the waiting room 2 minutes before the game starts."}, 1)
				end
			else	--If you don't have enough coins
				player:popUp("Come back with some coins, ya bum!")
			end
		end
	elseif menu == "I can't register!" then
		player.registry["freeze_war_registered"] = 0
		player.registry["freeze_war_team"] = 0
		player.registry["freeze_war_flag"] = 0
		player:dialogSeq({t, n.."Looks like a simple paperwork mixup. You should be all set to register now, have fun at the game!"}, 1)
	end
end
),

warpToWaitingRoom = function(player)

	--player.registry["freeze_war_team"] = math.random(1, 2)
	core.gameRegistry["freeze_war_players"] = core.gameRegistry["freeze_war_players"] + 1
	player:warp(15011, math.random(2, 14), math.random(2, 12))
	player:sendAnimation(16)
	player:playSound(29)
	player:popUp("Welcome to Freeze War!\nPlease wait patiently until the game starts.")

end,

autoWarp = function(player)

	local diff = core.gameRegistry["freeze_war_start_time"] - os.time()
	
	if player.registry["freeze_war_registered"] == 1 then
		if diff == 120 then
			if player.m ~= 15011 and player.m ~= 15010 then
				freeze_war.warpToWaitingRoom(player)
			end
		end
	end

end,


guiText = function(player)

	local diff = core.gameRegistry["freeze_war_start_time"] - os.time()
	local diffwait = core.gameRegistry["freeze_war_wait_time"] - os.time()
--Player(4):talkSelf(0,"d1: "..diff)
--Player(4):talkSelf(0,"d2: "..diffwait)
	if diffwait == 0 then diffwait = 0 end
	
	if player.registry["freeze_war_registered"] == 1 and core.gameRegistry["freeze_war_started"] == 0 then
		if diff > 0 then
			player:guitext("\nFreeze War registration will close in: "..getTimerValues("freeze_war_start_time").."    ")
		
		elseif diffwait > 0 then
			player:guitext("\nFreeze War will begin in: "..getTimerValues("freeze_war_wait_time").."    ")
			
		else
			player:guitext("")
		end
	elseif player.registry["freeze_war_registered"] == 1 and core.gameRegistry["freeze_war_started"] == 1 then
		if diffwait > 0 then
			player:guitext("\nFreeze War will begin in: "..getTimerValues("freeze_war_wait_time").."    ")
		else
			player:guitext("\nRED: "..core.gameRegistry["freeze_war_red_point"].." | BLUE: "..core.gameRegistry["freeze_war_blue_point"])
		end
	end
	
	if player.gmLevel > 0 and player.m == 15010 then
		player:guitext("\nRED: "..core.gameRegistry["freeze_war_red_point"].." | BLUE: "..core.gameRegistry["freeze_war_blue_point"])
	end
	
	
	
end,

broadcastTimer = function()
	
	local diff = core.gameRegistry["freeze_war_start_time"] - os.time()
	
--	if diff == 600 then
--		broadcast(-1, "Freeze War registration will close in 10 minutes")
	if diff == 300 then
		broadcast(-1, "Freeze War registration will close in 5 minutes")
	elseif diff == 60 then
		broadcast(-1, "Freeze War registration will close in 1 minute")
	end

end,

getStartTimer = function()
		
	local hour, minute, second = 0, 0, 0
	
	if core.gameRegistry["freeze_war_start_time"] < os.time() then return "00:00:00" else
		dif = core.gameRegistry["freeze_war_start_time"] - os.time()
		hour = string.format("%02.f", math.floor(dif/3600))
		minute = string.format("%02.f", math.floor(dif/60-(hour*60)))
		second = string.format("%02.f", math.floor(dif-hour*3600-minute*60))
		return hour..":"..minute..":"..second
	end
end,

closed = function()

	local diff = core.gameRegistry["freeze_war_start_time"] - os.time()
	
	if core.gameRegistry["freeze_war_open"] == 1 then
		if core.gameRegistry["freeze_war_start_time"] > 0 then
			if core.gameRegistry["freeze_war_start_time"] > os.time() then
				if diff == 10 then
					broadcast(15011, "                                Freeze War registration will close in 10 seconds!")
				elseif diff <= 3 then
					broadcast(15011, "                                Freeze War registration will close in "..diff.." seconds!")
				end
			elseif core.gameRegistry["freeze_war_start_time"] < os.time() then
				--core.gameRegistry["freeze_war_open"] = 0
				core.gameRegistry["freeze_war_start_time"] = 0
				broadcast(-1, "-----------------------------------------------------------------------------------------------------")
				broadcast(-1, "                                 Freeze War entry is closed!")
				broadcast(-1, "-----------------------------------------------------------------------------------------------------")
				freeze_war.start()
			end
		end
	end

end,

getRandomMap = function()

	local allFreezeWarMaps = {15010}
	local randomMap = allFreezeWarMaps[math.random(1, #allFreezeWarMaps)]
	
	core.gameRegistry["freeze_war_current_map"] = randomMap

end,

setMapBlockers = function(mapID)

	local blocker = 1581
	local noPass = 1

	if mapID == 15010 then
	
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

	if mapID == 15010 then
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


	freeze_war.assignTeams()
	freeze_war.getRandomMap()
	local map = core.gameRegistry["freeze_war_current_map"]
	local pc = core:getObjectsInMap(15011, BL_PC)

--	
	
	if core.gameRegistry["freeze_war_players"] >= 2 then
		if #pc > 0 then	
			--freeze_war.assignTeams()
			for i = 1, #pc do			
				if pc[i].registry["freeze_war_team"] > 0 and pc[i].state ~= 0 then 				
					pc[i].state = 0 
					pc[i].speed = 80
					pc[i].registry["mounted"] = 0
					pc[i]:updateState()
				end
				
				freeze_war.costume(pc[i])
				freeze_war.entryLegend(pc[i])
				if pc[i].registry["freeze_war_team"] == 1 then --red team
					pc[i]:warp(map, 4, 2)
				end

				if pc[i].registry["freeze_war_team"] == 2 then --blue team
					pc[i]:warp(map, 28, 38)
				end
				
			end
			freeze_war.wait()
		end
	else
		broadcast(-1, "-----------------------------------------------------------------------------------------------------")
		broadcast(-1, "                             Not enough players. Freeze War cancelled!")
		broadcast(-1, "-----------------------------------------------------------------------------------------------------")
		freeze_war.cancel()
	end
		
end,

costume = function(player)
	
	local team = player.registry["freeze_war_team"]
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
	if core.gameRegistry["freeze_war_shot_speed"] == 1 then
		player.attackSpeed = 60
	end
	player.registry["freeze_war_flag"] = 0
	player:updateState()
end,


assignTeams = function()

	local red, blue = 0, 0
	local pc = core:getObjectsInMap(15011, BL_PC)
	local randomTeam
	
	if #pc > 0 then
		for i = 1, #pc do
			if pc[i].registry["freeze_war_team"] == 0 then
				if red == blue then
					randomTeam = math.random(1,2)
					pc[i].registry["freeze_war_team"] = randomTeam
					if randomTeam == 1 then 
						red = red + 1
					elseif randomTeam == 2 then
						blue = blue + 1
					end
				elseif blue > red then
					pc[i].registry["freeze_war_team"] = 1
					red = red + 1
				elseif red > blue then
					pc[i].registry["freeze_war_team"] = 2
					blue = blue + 1
				end
			
			end
		end
	end
	
	if #pc > 0 then
		for i = 1, #pc do	
			if red > blue then
				if (red-blue) ~= 1 then pc[math.random(#pc)].registry["freeze_war_team"] = 2 break end
			end
			if red < blue then
				if blue - red ~= 1 then pc[math.random(#pc)].registry["freeze_war_team"] = 1 break end
			end
		end
	end

end,

wait = function(npc)
	
	local map = core.gameRegistry["freeze_war_current_map"]
	
	local pc = core:getObjectsInMap(map, BL_PC)
	core.gameRegistry["freeze_war_wait_time"] = os.time() + 60
	freeze_war.setMapBlockers(map)
	
	broadcast(map, "-----------------------------------------------------------------------------------------------------")
	broadcast(map, "                                    Get Ready! The round starts in 60 seconds!")
	broadcast(map, "-----------------------------------------------------------------------------------------------------")
	
end,

enterArena = function()

	local diff = core.gameRegistry["freeze_war_wait_time"] - os.time()
	local map = core.gameRegistry["freeze_war_current_map"]
	local pc = core:getObjectsInMap(map, BL_PC)
	
	if diff == 30 then
		for i = 1, #pc do
			
			if pc[i].registry["freeze_war_team"] == 1 then
				pc[i]:warp(map, 4, 8)
			elseif pc[i].registry["freeze_war_team"] == 2 then
				pc[i]:warp(map, 28, 32)
			end
		end
		broadcast(map, "                                    Freeze War starts in 30 seconds!")
	end
	
end,


begin = function()

	local diff = core.gameRegistry["freeze_war_wait_time"] - os.time()
	local map = core.gameRegistry["freeze_war_current_map"]
	local pc = core:getObjectsInMap(map, BL_PC)


	if diff == 0 then
		core.gameRegistry["freeze_war_started"] = 1
		freeze_war.removeMapBlockers(map)

		broadcast(map, "-----------------------------------------------------------------------------------------------------")
		broadcast(map, "                                   The Freeze War has begun!")
		broadcast(map, "-----------------------------------------------------------------------------------------------------")
	end
end,

stop = function(type) -- 0 to return to arena, 1 to send all to loser room, 2 to send all to prizeroom

	local prizeRoom = 15991
	local loserRoom = 15981

	local map = core.gameRegistry["freeze_war_current_map"]

	local pc = core:getObjectsInMap(map, BL_PC)

	core.gameRegistry["freeze_war_end_timer"] = 0
	core.gameRegistry["freeze_war_players"] = 0
	core.gameRegistry["freeze_war_open"] = 0
	core.gameRegistry["freeze_war_winner"] = 0
	core.gameRegistry["freeze_war_started"] = 0
	core.gameRegistry["freeze_war_red_point"] = 0
	core.gameRegistry["freeze_war_blue_point"] = 0
	core.gameRegistry["freeze_war_current_map"] = 0
	core.gameRegistry["freeze_war_red_wins"] = 0
	core.gameRegistry["freeze_war_blue_wins"] = 0
	
	if #pc > 0 then
		for i = 1, #pc do
			pc[i].registry["freeze_war_registered"] = 0
			pc[i].registry["freeze_war_flag"] = 0
			pc[i].registry["freeze_war_team"] = 0
			pc[i].attackSpeed = 20
			pc[i].gfxClone = 0
			pc[i]:updateState()
			if type == 0 then
				pc[i]:warp(1031, math.random(13,17), math.random(4, 7))
			elseif type == 1 then
				pc[i]:warp(loserRoom, math.random(1,16), math.random(7,14))
			elseif type == 2 then
				pc[i]:warp(prizeRoom, math.random(4,12), math.random(6,11))
			end
			pc[i]:sendAnimation(16)
			pc[i]:playSound(29)
			pc[i]:calcStat()

		end
	end
end,

cancel = function()

	local map = 15011

	local pc = core:getObjectsInMap(map, BL_PC)

	core.gameRegistry["freeze_war_start_time"] = 0
	core.gameRegistry["freeze_war_end_timer"] = 0
	core.gameRegistry["freeze_war_players"] = 0
	core.gameRegistry["freeze_war_open"] = 0
	core.gameRegistry["freeze_war_winner"] = 0
	core.gameRegistry["freeze_war_started"] = 0
	core.gameRegistry["freeze_war_red_point"] = 0
	core.gameRegistry["freeze_war_blue_point"] = 0
	core.gameRegistry["freeze_war_current_map"] = 0
	core.gameRegistry["freeze_war_red_wins"] = 0
	core.gameRegistry["freeze_war_blue_wins"] = 0
	
	if #pc > 0 then
		for i = 1, #pc do
			pc[i].registry["freeze_war_registered"] = 0
			pc[i].registry["freeze_war_flag"] = 0
			pc[i].registry["freeze_war_team"] = 0
			
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



onSwing = function(player)
	
	local team = player.registry["freeze_war_team"]
	local m, x, y, side = player.m, player.x, player.y, player.side
	local icon = side+6
	local pc
	
	if team > 0 then
		if player.m == 15010 and player.gfxClone == 1 then
			if core.gameRegistry["freeze_war_shot_speed"] == 1 then
				player.attackSpeed = 60
			end
			player:playSound(709)
			player:sendAction(1, 20)
			if player.gfxWeap == 20014 then
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
					if pc ~= nil and pc.registry["freeze_war_team"] > 0 then 
						if team == pc.registry["freeze_war_team"] then freeze_war.rescue(player, pc) else freeze_war.stun(player, pc) end
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
				pc = getTargetFacing(player, BL_PC, 0, 1)
				if pc ~= nil and pc.registry["freeze_war_team"] > 0 then 
					if team == pc.registry["freeze_war_team"] then freeze_war.rescue(player, pc) else freeze_war.stun(player, pc) end
					return
				end
			end
		end
	end
end,

stun = function(player, target)
		
	if target:hasDuration("freeze_war") then return else
		target:setDuration("freeze_war", 10000)
		target.paralyzed = true
		player:playSound(739)
		player:playSound(737)
		target:sendAnimation(345)
		target:sendAnimation(268)
		player.registry["total_freeze_war_stuns"] = player.registry["total_freeze_war_stuns"] + 1	--permanent registry for stat tracking
		target.registry["total_freeze_war_stunned"] = target.registry["total_freeze_war_stunned"] + 1 --permanent registry for stat tracking
	end
end,

rescue = function(player, target)
	
	if target:hasDuration("freeze_war") then 
		target:setDuration("freeze_war", 0)
		target.paralyzed = false
		player:playSound(724)
		target:sendAnimation(296)
		player.registry["total_freeze_war_rescues"] = player.registry["total_freeze_war_rescues"] + 1	--permanent registry for stat tracking
		target.registry["total_freeze_war_rescued"] = target.registry["total_freeze_war_rescued"] + 1 --permanent registry for stat tracking
	end
end,


walk = function(player)
	
	local bluetile = {1238,1239,1240,1241,1242,1243,1244,1245,1246}
	local redtile = {574,580,575,579,577,581,576,578,582}
	local tile = getTile(player.m, player.x, player.y)
	local pc = player:getObjectsInMap(15010, BL_PC)

	if player.m == 15010 and player.registry["freeze_war_team"] > 0 then
		for i = 1, #bluetile do
			if player.registry["freeze_war_team"] == 1 then
				if tile == bluetile[i] then
					if player.registry["freeze_war_flag"] == 0 then
						player:sendAction(2, 20)
						player:sendAnimation(326)
						player:playSound(505)
						player.registry["freeze_war_flag"] = 1
						player.gfxWeap = 113
						player:updateState()
					end
				elseif tile == redtile[i] then
					if core.gameRegistry["freeze_war_game_over"] == 0 then
						if player.registry["freeze_war_flag"] == 1 and core.gameRegistry["freeze_war_red_point"] <= 2 then
							player.gfxWeap = 20014
							player.registry["freeze_war_flag"] = 0
							core.gameRegistry["freeze_war_red_point"] = core.gameRegistry["freeze_war_red_point"] + 1
							player:sendAnimation(349)
							player:playSound(112)
							broadcast(15010, "                                       "..player.name.." has captured the Blue Team's flag!")
							--broadcast(15010, "                                       [Red Team = "..core.gameRegistry["freeze_war_red_point"].."] VS [Blue Team = "..core.gameRegistry["freeze_war_blue_point"].."]")
							player:updateState()
							freeze_war.winnerCheck()
						end
					end	
				end
			elseif player.registry["freeze_war_team"] == 2 then
				if tile == redtile[i] then
					if player.registry["freeze_war_flag"] == 0 then
						player:sendAction(2, 20)
						player:sendAnimation(326)
						player:playSound(505)	
						player.registry["freeze_war_flag"] = 1
						player.gfxWeap = 112
						player:updateState()
					end
				elseif tile == bluetile[i] then
					if core.gameRegistry["freeze_war_game_over"] == 0 then
						if player.registry["freeze_war_flag"] == 1 and core.gameRegistry["freeze_war_blue_point"] <= 2 then
							player.gfxWeap = 20014
							player.registry["freeze_war_flag"] = 0
							core.gameRegistry["freeze_war_blue_point"] = core.gameRegistry["freeze_war_blue_point"] + 1
							player:sendAnimation(349)
							player:playSound(112)
							broadcast(15010, "                                       "..player.name.." has captured the Red Team's flag!")
							--broadcast(15010, "                                       [Red Team = "..core.gameRegistry["freeze_war_red_point"].."] VS [Blue Team = "..core.gameRegistry["freeze_war_blue_point"].."]")
							player:updateState()
							freeze_war.winnerCheck()
						end
					end
				end
			end
		end
	end
end,

winnerCheck = function()

	local pointsToWin = 3
--Player(4):talk(0,"red: "..core.gameRegistry["freeze_war_red_point"])
--Player(4):talk(0,"blue: "..core.gameRegistry["freeze_war_blue_point"])
	if core.gameRegistry["freeze_war_red_point"] == pointsToWin then 
--Player(4):talk(0,"win score")	
		core.gameRegistry["freeze_war_red_wins"] = core.gameRegistry["freeze_war_red_wins"] + 1
		
		freeze_war.roundWin("red") 
--Player(4):talk(0,"win end")		
		return 

	elseif core.gameRegistry["freeze_war_blue_point"] == pointsToWin then 
		core.gameRegistry["freeze_war_blue_wins"] = core.gameRegistry["freeze_war_blue_wins"] + 1
		freeze_war.roundWin("blue") 
		return 
	end

end,

roundWin = function(teamID)
--Player(4):talk(0,"round win")
	local map = core.gameRegistry["freeze_war_current_map"]
	local pc = core:getObjectsInMap(map, BL_PC)
	local teamName = ""
	
	if teamID == "red" then 
		teamName = "Red"
	elseif teamID == "blue" then
		teamName = "Blue"
	end
	
	core.gameRegistry["freeze_war_red_point"] = 0
	core.gameRegistry["freeze_war_blue_point"] = 0
	
	broadcast(map, "-----------------------------------------------------------------------------------------------------")
	broadcast(map, "Round over! "..teamName.." Team has "..core.gameRegistry["freeze_war_"..teamID.."_wins"].." of 2 wins!")
	
	for i = 1, #pc do
		if pc[i].registry["freeze_war_team"] == 1 then --red team
			freeze_war.costume(pc[i])
			pc[i]:warp(map, 4, 2)
		end
		if pc[i].registry["freeze_war_team"] == 2 then --blue team
			freeze_war.costume(pc[i])
			pc[i]:warp(map, 28, 38)
		end
	end
	
	if core.gameRegistry["freeze_war_"..teamID.."_wins"] < 2 then
		freeze_war.nextRound()
	elseif core.gameRegistry["freeze_war_"..teamID.."_wins"] >= 2 then
		freeze_war.declareWinner(teamID)
	end
	
end,


nextRound = function()

	local map = core.gameRegistry["freeze_war_current_map"]
	local pc = core:getObjectsInMap(map, BL_PC)
	
	for i = 1, #pc do
		pc[i]:flushDuration(518, 518) --flush any frozen duration
	end
	
	core.gameRegistry["freeze_war_red_point"] = 0
	core.gameRegistry["freeze_war_blue_point"] = 0
	freeze_war.wait()
	
end,

declareWinner = function(teamID)

	local map = core.gameRegistry["freeze_war_current_map"]
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
		pc[i]:flushDuration(518, 518) --flush any respawn duration
	end
	core.gameRegistry["freeze_war_winner"] = teamNum
	broadcast(map, "         Game Over! "..teamName.." Team is the winner!")
	broadcast(map, "         You will exit the arena in 10 seconds!")
	
	core.gameRegistry["freeze_war_end_timer"] = os.time() + 10
	
end,

endGame = function()

	local map = core.gameRegistry["freeze_war_current_map"]
	local pc = core:getObjectsInMap(map, BL_PC)
	local arenaPC = core:getObjectsInMap(1031, BL_PC)
	local prizeRoom = 15991
	local loserRoom = 15981
	local x, y = 8, 10

	if core.gameRegistry["freeze_war_end_timer"] > 0 and core.gameRegistry["freeze_war_end_timer"] < os.time() then
		
		if #pc > 0 then
			for i =	1, #pc do
			
				if pc[i].registry["freeze_war_team"] == core.gameRegistry["freeze_war_winner"] then --if you are on the winning team
					pc[i]:warp(prizeRoom, math.random(4,12), math.random(6,11)) --go to prize room	

				else --if you are not on the winning team
					pc[i]:warp(loserRoom, math.random(1,16), math.random(7,14)) --go to loser room
				end

				pc[i].registry["freeze_war_registered"] = 0
				pc[i].registry["freeze_war_flag"] = 0
				pc[i].registry["freeze_war_team"] = 0
				pc[i].attackSpeed = 20
				pc[i].gfxClone = 0
				pc[i]:updateState()
				


			end
		end
		core.gameRegistry["freeze_war_end_timer"] = 0
		core.gameRegistry["freeze_war_players"] = 0
		core.gameRegistry["freeze_war_open"] = 0
		core.gameRegistry["freeze_war_winner"] = 0
		core.gameRegistry["freeze_war_started"] = 0
		core.gameRegistry["freeze_war_red_point"] = 0
		core.gameRegistry["freeze_war_blue_point"] = 0
		core.gameRegistry["freeze_war_current_map"] = 0
		core.gameRegistry["freeze_war_red_wins"] = 0
		core.gameRegistry["freeze_war_blue_wins"] = 0
		core.gameRegistry["freeze_war_winner"] = 0

	end
end,


entryLegend = function(player)

	local reg = player.registry["freeze_war_entries"]
	
----REMOVING LEGENDS AND REGISTRIES FROM OLD CTF
	if player:hasLegend("ctf_war_entries") then player:removeLegendbyName("ctf_war_entries") end
	if player:hasLegend("ctf_war_wins") then player:removeLegendbyName("ctf_war_wins") end
	player.registry["ctf_war_wins"] = 0
	player.registry["ctf_war_entries"] = 0
-------------------------------------------------------
	
	if player:hasLegend("freeze_war_entries") then player:removeLegendbyName("freeze_war_entries") end
	
	if reg > 0 then
		player.registry["freeze_war_entries"] = player.registry["freeze_war_entries"] + 1
		player:addLegend("Played in "..player.registry["freeze_war_entries"].." Freeze Wars", "freeze_war_entries", 17, 16)
	else
		player.registry["freeze_war_entries"] = 1
		player:addLegend("Played in 1 Freeze War", "freeze_war_entries", 17, 16)
	end
end,



victoryLegend = function(player)

	local reg = player.registry["freeze_war_wins"]


	if player:hasLegend("freeze_war_wins") then player:removeLegendbyName("freeze_war_wins") end
	
	if reg > 0 then
		player.registry["freeze_war_wins"] = player.registry["freeze_war_wins"] + 1
		player:addLegend("Won "..player.registry["freeze_war_wins"].." Freeze Wars", "freeze_war_wins", 17, 16)
	else
		player.registry["freeze_war_wins"] = 1
		player:addLegend("Won 1 Freeze War", "freeze_war_wins", 17, 16)
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