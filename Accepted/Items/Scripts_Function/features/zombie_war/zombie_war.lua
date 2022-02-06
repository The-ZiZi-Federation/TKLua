--zombie_war.open() - opens minigame, argument 0 = Horde, 1 = Patient Zero
--zombie_war.cancel() - cancels opened minigame before start
--zombie_war.stop() - stops game in progress, returns all players to arena with clean registry


zombie_war = {

playerCore = function(player)
	zombie_war.autoWarp(player)
	zombie_war.guiText(player)
	zombie_war.refill(player)
end,

core = function()
	zombie_war.broadcastTimer()
	zombie_war.closed()
	zombie_war.begin()
	zombie_war.endGame()
end,

open = function(mode)
	
	local style = ""
	
	core.gameRegistry["zombie_war_open"] = 1		--Registry for game open
	

	if mode == nil then
		core.gameRegistry["zombie_war_mode"] = math.random(0,1)
	elseif mode ~= nil then
		core.gameRegistry["zombie_war_mode"] = mode
	end

	if core.gameRegistry["zombie_war_mode"] == 0 then		--
		style = "Horde"
	elseif core.gameRegistry["zombie_war_mode"] == 1 then
		style = "Patient Zero"
	end
	
	
	
	core.gameRegistry["zombie_war_start_time"] = os.time()+300	--5 minute timer
	broadcast(-1, "-----------------------------------------------------------------------------------------------------")
	broadcast(-1, "                                ~"..style.."~ Zombie War is now open in Hon Arena!")
	broadcast(-1, "                                Registration will close in 5 minutes!")
	broadcast(-1, "-----------------------------------------------------------------------------------------------------")
end,

click = async(function(player, npc)
	
----------Variable Declarations-----------------------------------	
	local total = {}	
	local pc = player:getObjectsInMap(15061, BL_PC)	--waiting room map
	local n = "<b>[Zombie War]\n\n"
	local t = {g = convertGraphic(npc.look, "monster"), c = npc.lookColor}
	player.npcGraphic = t.g
	player.npcColor = t.c
	player.dialogType = 0
	
	local str = ""
	local time = zombie_war.getStartTimer()
	local goldCost = 1000
	local opts = {}
	local diff





	if player.gmLevel == 0 then
	player:popUp("Currently in development. Disabled.")
	end

	
	if #pc > 0 then		--determine how many players in waiting room
		for i = 1, #pc do
			if pc[i].registry["zombie_war_registered"] > 0 then
				table.insert(total, pc[i].ID)
			end
		end
	end
---------------Table Inserts-----------------------------
	table.insert(opts, "How To Play?")
	if player.registry["zombie_war_registered"] == 1 and core.gameRegistry["zombie_war_started"] == 0 then table.insert(opts, "Hey! Let me in!") end
	if core.gameRegistry["zombie_war_open"] == 1 then	--If the game is open
		if player.registry["zombie_war_registered"] == 0 then	--if you have not registered
			table.insert(opts, "Register For Zombie War")
		end
		
		if player.registry["zombie_war_registered"] > 0 or player.registry["zombie_war_team"] > 0 then --If you have a bad registry for some reason, get the option to fix it
			table.insert(opts, "I can't register!")
		end
	end
	table.insert(opts, "Exit")
	
	if core.gameRegistry["zombie_war_start_time"] > os.time() then --if the game is open, get timer string
		str = "Waiting time: "..zombie_war.getStartTimer()
	end
----------------------------------------------------------

	
	menu = player:menuString(n.."Hello, the game will start in few minutes.\n"..str.."\nIn the waiting room: "..#total, opts) --Display the menu

-----------------Menu Options-------------------------	
	if menu == "How To Play?" then
		player:dialogSeq({t, n.."Zombie War is a game where you use your crossbow to actively seek out the infected.", 
							n.."There are two game modes available: Horde and Patient Zero.",
							n.."Horde mode: co-op, everyone against waves of zombies.", 
							n.."Patient Zero: one person randomly selected to be the zombie and attempt to infect everyone else."}, 1)
		player:freeAsync()
		zombie_war.click(player, npc)
	
	elseif menu == "Hey! Let me in!" then
		core.gameRegistry["zombie_war_players"] = core.gameRegistry["zombie_war_players"] + 1
		player:warp(15061, math.random(2, 14), math.random(2, 12))
		player:sendAnimation(16)
		player:playSound(29)
		player:popUp("Welcome to Zombie War!\nPlease wait patiently until the game starts.")
	
	elseif menu == "Register For Zombie War" then
		if player.registry["minigame_ban_timer"] > os.time() then --Check if player is banned from minigames
			player:popUp("You are currently banned from minigames! Try again later maybe.")
			return
		end
		
		confirm = player:menuString("The cost to register is "..goldCost.." coins. Are you willing to pay to play?", {"Yes", "No"}) --Confirmation and payment
		if confirm == "Yes" then
			if player:removeGold(goldCost) == true then	--If the fee is succesfully removed
				diff = core.gameRegistry["zombie_war_start_time"] - os.time()
				player.registry["zombie_war_registered"] = 1
				if diff < 121 then --Less than 2 minutes until start, warp directly to waiting room
					zombie_war.warpToWaitingRoom(player)
				elseif diff >= 121 then --More than 2 minutes until start, just get registry
					player:dialogSeq({t, n.."Alright, your character is registered for Zombie War.\nYou will be sent to the waiting room 2 minutes before the game starts."}, 1)
				end
			else	--If you don't have enough coins
				player:popUp("Come back with some coins, ya bum!")
			end
		end
	elseif menu == "I can't register!" then
		player.registry["zombie_war_flag"] = 0
		player.registry["zombie_war_kills"] = 0
		player.registry["zombie_war_times_hit"] = 0
		player.registry["zombie_war_gun_pct"] = 0
		player.registry["zombie_war_registered"] = 0
		player.registry["zombie_war_team"] = 0
		player:dialogSeq({t, n.."Looks like a simple paperwork mixup. You should be all set to register now, have fun at the game!"}, 1)
	end
end
),

warpToWaitingRoom = function(player)

	
	core.gameRegistry["zombie_war_players"] = core.gameRegistry["zombie_war_players"] + 1
	player:warp(15061, math.random(2, 14), math.random(2, 12))
	player:sendAnimation(16)
	player:playSound(29)
	player:popUp("Welcome to Zombie War!\nPlease wait patiently until the game starts.")

end,

autoWarp = function(player)

	local diff = core.gameRegistry["zombie_war_start_time"] - os.time()
	
	if player.registry["zombie_war_registered"] == 1 then
		if diff == 120 then
			if player.m ~= 15061 and player.m ~= 15060 then
				zombie_war.warpToWaitingRoom(player)
			end
		end
	end

end,


guiText = function(player)

	local diff = core.gameRegistry["zombie_war_start_time"] - os.time()
	local diffwait = core.gameRegistry["zombie_war_wait_time"] - os.time()

	if player.registry["zombie_war_registered"] == 1 and core.gameRegistry["zombie_war_started"] == 0 then
		if diff > 0 then
			player:guitext("\nZombie War registration will close in: "..getTimerValues("zombie_war_start_time").."    ")
		
		elseif diffwait > 0 then
			player:guitext("\nZombie War will begin in: "..getTimerValues("zombie_war_wait_time").."    ")
			
		else
			player:guitext("")
		end
	elseif player.registry["zombie_war_registered"] == 1 and core.gameRegistry["zombie_war_started"] == 1 then
		if diffwait > 0 then
			player:guitext("\nZombie War will begin in: "..getTimerValues("zombie_war_wait_time").."    ")
		else

			if core.gameRegistry["zombie_war_mode"] == 0 then
			elseif core.gameRegistry["zombie_war_mode"] == 1 then
				player:guitext("\nSurvivors: "..core.gameRegistry["zombie_war_red_point"].." | Infected: "..core.gameRegistry["zombie_war_blue_point"].."  \nYour kills: "..player.registry["zombie_war_kills"])
			end


		end
	end
		
	
	
end,

broadcastTimer = function()
	
	local diff = core.gameRegistry["zombie_war_start_time"] - os.time()
	
--	if diff == 600 then
--		broadcast(-1, "Zombie War registration will close in 10 minutes")
	if diff == 300 then
		broadcast(-1, "Zombie War registration will close in 5 minutes")
	elseif diff == 60 then
		broadcast(-1, "Zombie War registration will close in 1 minute")
	end

end,

getStartTimer = function()
		
	local hour, minute, second = 0, 0, 0
	
	if core.gameRegistry["zombie_war_start_time"] < os.time() then return "00:00:00" else
		dif = core.gameRegistry["zombie_war_start_time"] - os.time()
		hour = string.format("%02.f", math.floor(dif/3600))
		minute = string.format("%02.f", math.floor(dif/60-(hour*60)))
		second = string.format("%02.f", math.floor(dif-hour*3600-minute*60))
		return hour..":"..minute..":"..second
	end
end,

closed = function()
	local diff = core.gameRegistry["zombie_war_start_time"] - os.time()
	
	if core.gameRegistry["zombie_war_open"] == 1 then
		if core.gameRegistry["zombie_war_start_time"] > 0 then
			if core.gameRegistry["zombie_war_start_time"] > os.time() then
				if diff == 10 then
					broadcast(15061, "                                Zombie War registration will close in 10 seconds!")
				elseif diff <= 3 then
					broadcast(15061, "                                Zombie War registration will close in "..diff.." seconds!")
				end
			elseif core.gameRegistry["zombie_war_start_time"] < os.time() then
				--core.gameRegistry["zombie_war_open"] = 0
				core.gameRegistry["zombie_war_start_time"] = 0
				broadcast(-1, "-----------------------------------------------------------------------------------------------------")
				broadcast(-1, "                                 Zombie War entry is closed!")
				broadcast(-1, "-----------------------------------------------------------------------------------------------------")
				zombie_war.start()
			end
		end
	end

end,

chooseMap = function()
	
	local ZombieWarMap = 0

	if core.gameRegistry["zombie_war_mode"] == 0 then
		ZombieWarMap = 15060

	elseif core.gameRegistry["zombie_war_mode"] == 1 then
		if core.gameRegistry["zombie_war_players"] <= 6 then
			ZombieWarMap = 15062
		elseif core.gameRegistry["zombie_war_players"] >= 7 then
			ZombieWarMap = 15060
		end
	end
	
	core.gameRegistry["zombie_war_current_map"] = ZombieWarMap
end,

setMapBlockers = function(mapID)

	local Blocker = 12447
	local noPass = 1

---LARGE MAP--------------------

	if mapID == 15060 then
                 -----------------Top Left Block ------------
		for i = 0, 20 do
			setObject(mapID, i, 21, Blocker)
			setPass(mapID, i, 21, noPass)
		end		
		for j = 0, 21 do
			setObject(mapID, 20, j, Blocker)
			setPass(mapID, 20, j, noPass)
		end		
		--------------Bottom Right Block------------
		for i = 41, 59 do
			setObject(mapID, i, 36, Blocker)
			setPass(mapID, i, 36, noPass)
		end		
		for j = 36, 59 do
			setObject(mapID, 41, j, Blocker)
			setPass(mapID, 41, j, noPass)
		end		
	end

----SMALL MAP------------------

	if mapID == 15062 then
                 -----------------Top Left Block ------------
		for i = 0, 16 do
			setObject(mapID, i, 13, Blocker)
			setPass(mapID, i, 13, noPass)
		end		
		for j = 0, 12 do
			setObject(mapID, 16, j, Blocker)
			setPass(mapID, 16, j, noPass)
		end		
		--------------Bottom Right Block------------
		for i = 20, 38 do
			setObject(mapID, i, 25, Blocker)
			setPass(mapID, i, 25, noPass)
		end		
		for j = 25, 39 do
			setObject(mapID, 20, j, Blocker)
			setPass(mapID, 20, j, noPass)
		end		
	end
end,

removeMapBlockers = function(mapID)

	local noBlocker = 0
	local Pass = 0


----LARGE MAP------------------
	if mapID == 15060 then
                 -----------------Top Left Block ------------
		for i = 0, 20 do
			setObject(mapID, i, 21, noBlocker)
			setPass(mapID, i, 21, Pass)
		end		
		for j = 0, 21 do
			setObject(mapID, 20, j, noBlocker)
			setPass(mapID, 20, j, Pass)
		end		
		--------------Bottom Right Block------------
		for i = 41, 59 do
			setObject(mapID, i, 36, noBlocker)
			setPass(mapID, i, 36, Pass)
		end		
		for j = 36, 59 do
			setObject(mapID, 41, j, noBlocker)
			setPass(mapID, 41, j, Pass)
		end		
	end

------SMALL MAP---------------

	if mapID == 15062 then
                 -----------------Top Left Block ------------
		for i = 0, 16 do
			setObject(mapID, i, 13, noBlocker)
			setPass(mapID, i, 13, Pass)
		end		
		for j = 0, 12 do
			setObject(mapID, 16, j, noBlocker)
			setPass(mapID, 16, j, Pass)
		end		
		--------------Bottom Right Block------------
		for i = 20, 38 do
			setObject(mapID, i, 25, noBlocker)
			setPass(mapID, i, 25, Pass)
		end		
		for j = 26, 39 do
			setObject(mapID, 20, j, noBlocker)
			setPass(mapID, 20, j, Pass)
		end		
	end


end,

start = function()
	zombie_war.chooseMap()
	zombie_war.assignTeams()
	local map = core.gameRegistry["zombie_war_current_map"]
	local waitingRoom = 15061

	local pc = core:getObjectsInMap(waitingRoom, BL_PC)


	
	if core.gameRegistry["zombie_war_players"] >= 1 then
		if #pc > 0 then	
			for i = 1, #pc do			
				if pc[i].registry["zombie_war_team"] > 0 and pc[i].state ~= 0 then 				
					pc[i].state = 0 
					pc[i].speed = 80
					pc[i].registry["mounted"] = 0
					pc[i]:updateState()
				end
				
				zombie_war.costume(pc[i])
				zombie_war.entryLegend(pc[i])


			----- Large Map Spawns -----
				if pc[i].registry["zombie_war_team"] == 1 and core.gameRegistry["zombie_war_current_map"] == 15060 then --normal player team
					pc[i]:warp(map, 4, 12)
				elseif pc[i].registry["zombie_war_team"] == 2 and core.gameRegistry["zombie_war_current_map"] == 15060 then --Infected team
					pc[i]:warp(map, 53, 52)
			----- SMall Map Spawns -----
				elseif pc[i].registry["zombie_war_team"] == 1 and core.gameRegistry["zombie_war_current_map"] == 15062 then --normal player team
					pc[i]:warp(map, 3, 1)
				elseif pc[i].registry["zombie_war_team"] == 2 and core.gameRegistry["zombie_war_current_map"] == 15062 then --Infected team
					pc[i]:warp(map, 36, 38)
				
				end
				
			end
			zombie_war.wait()
		end
	else
		broadcast(-1, "-----------------------------------------------------------------------------------------------------")
		broadcast(-1, "                             Not enough players. Zombie War cancelled!")
		broadcast(-1, "-----------------------------------------------------------------------------------------------------")
		zombie_war.cancel()
	end
		
end,

costume = function(player)
	
	local team = player.registry["zombie_war_team"]
	local dye, str = 0, ""

	if core.gameRegistry["zombie_war_mode"] == 0 then
	elseif core.gameRegistry["zombie_war_mode"] == 1 then

		if team == 1 then
			clone.gfx(player, player)
			clone.equip(player, player)
			gunColor = 30
			player.gfxWeap = 20109
			player.gfxWeapC = gunColor
			player.gfxClone = 1
			player:updateState()
		elseif team == 2 then
			player.gfx = 1
			player.state = 4
			player.disguise = math.random(1137,1138)
			player.disguiseColor = math.random(0,10)
			player:updateState()			
			player:popUp("You are Patient Zero. Your goal is to infect as many others as possible to win.")
		end	

	end

end,


assignTeams = function()
	map = 15061
	local pc = core:getObjectsInMap(map, BL_PC)
	

	if core.gameRegistry["zombie_war_mode"] == 0 then
	elseif core.gameRegistry["zombie_war_mode"] == 1 then
		local zombiePlayer = math.random(1, #pc)

		if #pc > 0 then
			for i = 1, #pc do
				if pc[i].registry["zombie_war_team"] == 0 and i ~= zombiePlayer then
					pc[i].registry["zombie_war_team"] = 1
				elseif pc[i].registry["zombie_war_team"] == 0 and i == zombiePlayer then
					 pc[i].registry["zombie_war_team"] = 2			
				end
			end
		end
	end


end,

wait = function(npc)
	
	local map = core.gameRegistry["zombie_war_current_map"]
	
	local pc = core:getObjectsInMap(map, BL_PC)
	core.gameRegistry["zombie_war_wait_time"] = os.time() + 30
	zombie_war.setMapBlockers(map)
	
	broadcast(map, "-----------------------------------------------------------------------------------------------------")
	broadcast(map, "                                    Get Ready! The round starts in 30 seconds!")
	broadcast(map, "-----------------------------------------------------------------------------------------------------")
	
end,



begin = function()

	local diff = core.gameRegistry["zombie_war_wait_time"] - os.time()
	local map = core.gameRegistry["zombie_war_current_map"]
	local pc = core:getObjectsInMap(map, BL_PC)

	if diff == 0 then
		core.gameRegistry["zombie_war_started"] = 1
		zombie_war.removeMapBlockers(map)
		broadcast(map, "-----------------------------------------------------------------------------------------------------")
		broadcast(map, "                                   The Zombie War has begun!")
		broadcast(map, "-----------------------------------------------------------------------------------------------------")
	end
end,

stop = function(type) -- 0 to return to arena, 1 to send all to loser room, 2 to send all to prizeroom

	local prizeRoom = 15992
	local loserRoom = 15982

	local map = core.gameRegistry["zombie_war_current_map"]

	local pc = core:getObjectsInMap(map, BL_PC)

	core.gameRegistry["zombie_war_end_timer"] = 0
	core.gameRegistry["zombie_war_players"] = 0
	core.gameRegistry["zombie_war_open"] = 0
	core.gameRegistry["zombie_war_winner"] = 0
	core.gameRegistry["zombie_war_started"] = 0
	core.gameRegistry["zombie_war_red_point"] = 0
	core.gameRegistry["zombie_war_blue_point"] = 0
	core.gameRegistry["zombie_war_current_map"] = 0
	core.gameRegistry["zombie_war_red_wins"] = 0
	core.gameRegistry["zombie_war_blue_wins"] = 0
	
	if #pc > 0 then
		for i = 1, #pc do
			pc[i].registry["zombie_war_times_hit"] = 0
			pc[i].registry["zombie_war_gun_pct"] = 0
			pc[i].registry["zombie_war_registered"] = 0
			pc[i].registry["zombie_war_flag"] = 0
			pc[i].registry["zombie_war_team"] = 0
			pc[i].registry["zombie_war_kills"] = 0
			
			pc[i].gfxClone = 0

			if pc[i].state == 4 then
				pc[i].state = 0
				pc[i].gfx = 0
			end		

			pc[i]:updateState()
			
			if type == 0 or type == nil then
				pc[i]:warp(1031, math.random(13,17), math.random(4, 7))
			elseif type == 1 then
				pc[i]:warp(loserRoom, 8, 10)
			elseif type == 2 then
				pc[i]:warp(prizeRoom, 8, 10)
			end
			pc[i]:sendAnimation(16)
			pc[i]:playSound(29)
			pc[i]:calcStat()

		end
	end



		broadcast(map, "-----------------------------------------------------------------------------------------------------")
		broadcast(map, "                                   The Zombie War has been stopped!")
		broadcast(map, "-----------------------------------------------------------------------------------------------------")










end,

cancel = function()

	local map = core.gameRegistry["zombie_war_current_map"]

	local pc = core:getObjectsInMap(map, BL_PC)

	core.gameRegistry["zombie_war_end_timer"] = 0
	core.gameRegistry["zombie_war_players"] = 0
	core.gameRegistry["zombie_war_open"] = 0
	core.gameRegistry["zombie_war_winner"] = 0
	core.gameRegistry["zombie_war_started"] = 0
	core.gameRegistry["zombie_war_red_point"] = 0
	core.gameRegistry["zombie_war_blue_point"] = 0
	core.gameRegistry["zombie_war_current_map"] = 0
	core.gameRegistry["zombie_war_red_wins"] = 0
	core.gameRegistry["zombie_war_blue_wins"] = 0
	
	if #pc > 0 then
		for i = 1, #pc do
			pc[i].registry["zombie_war_times_hit"] = 0
			pc[i].registry["zombie_war_gun_pct"] = 0
			pc[i].registry["zombie_war_registered"] = 0
			pc[i].registry["zombie_war_flag"] = 0
			pc[i].registry["zombie_war_team"] = 0
			pc[i].registry["zombie_war_kills"] = 0
			

			pc[i].gfxClone = 0

			if pc[i].state == 4 then
				pc[i].state = 0
				pc[i].gfx = 0
			end		



			pc[i]:updateState()
			pc[i]:warp(1031, math.random(13,17), math.random(4, 7))
			pc[i]:sendAnimation(16)
			pc[i]:playSound(29)
			pc[i]:calcStat()

		end
	end


			broadcast(map, "-----------------------------------------------------------------------------------------------------")
			broadcast(map, "                                   The Zombie War has been cancelled!")
			broadcast(map, "-----------------------------------------------------------------------------------------------------")
	




end,



shoot = function(player)
	
	local team = player.registry["zombie_war_team"]
	
	local map = core.gameRegistry["zombie_war_current_map"]
	local m, x, y, side = player.m, player.x, player.y, player.side
	local icon = 1615
	local pc
	
	if team > 0 then
		if player.m == map and player.gfxClone == 1 then
			if player.registry["zombie_war_gun_pct"] >= 10 then
				player.registry["zombie_war_gun_pct"] = player.registry["zombie_war_gun_pct"] - 10
				player:playSound(709)
			--	player:sendAction(1, 20)
				player:sendMinitext("Your water tank is at "..player.registry["zombie_war_gun_pct"].."%")
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
					if pc ~= nil and pc.registry["zombie_war_team"] > 0 then 
						if team ~= pc.registry["zombie_war_team"] then zombie_war.hit(player, pc) end
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

	
	local map = core.gameRegistry["zombie_war_current_map"]
	local team = target.registry["zombie_war_team"]
	local x, y
	
	player:playSound(739)
	player:playSound(737)
	target:sendAnimationXY(142, target.x, target.y)
	
	if core.gameRegistry["zombie_war_mode"] == 0 then
		if team == 1 then
			x = 3
			y = 2
			teamName = "Normal"
        
		elseif team == 2 then
			x = 36
			y = 47
			teamName = "Infected"

		end
		
		player.registry["total_zombie_war_hits"] = player.registry["total_zombie_war_hits"] + 1	--permanent registry for stat tracking
		player.registry["total_zombie_war_kills"] = player.registry["total_zombie_war_kills"] + 1 --permanent registry for stat tracking
		target.registry["total_zombie_war_deaths"] = target.registry["total_zombie_war_deaths"] + 1 --permanent registry for stat tracking
		target.registry["total_zombie_war_times_hit"] = 1 --permanent registry for stat tracking
		
		core.gameRegistry["zombie_war_"..teamName.."_point"] = core.gameRegistry["zombie_war_"..teamName.."_point"] + 1	--increase current game score
		player.registry["zombie_war_kills"] = player.registry["zombie_war_kills"] + 1
		
		target:setDuration("respawning", 15000)
		target:warp(map, x, y)
		
		
		broadcast(map, ""..target.name.." was SOAKED by "..player.name.."!")
		zombie_war.winnerCheck()
		
	elseif core.gameRegistry["zombie_war_mode"] == 1 then
		if target.registry["zombie_war_times_hit"] == 0 then
			player.registry["total_zombie_war_hits"] = player.registry["total_zombie_war_hits"] + 1	--permanent registry for stat tracking
			target.registry["total_zombie_war_times_hit"] = target.registry["total_zombie_war_times_hit"] +1 --permanent registry for stat tracking
			
			target:sendMinitext("You got shot by "..player.name.."! Don't get hit again!")
			target.registry["zombie_war_times_hit"] = target.registry["zombie_war_times_hit"] + 1
			
			broadcast(map, ""..target.name.." has been shot by "..player.name.."!")
			
		elseif target.registry["zombie_war_times_hit"] == 1 then
			if team == 1 then
				x = 3
				y = 2
				teamName = "Normal"
			
			elseif team == 2 then
				x = 36
				y = 47
				teamName = "Infected"
	
			end
			player.registry["total_zombie_war_hits"] = player.registry["total_zombie_war_hits"] + 1	--permanent registry for stat tracking
			player.registry["total_zombie_war_kills"] = player.registry["total_zombie_war_kills"] + 1 --permanent registry for stat tracking
			target.registry["total_zombie_war_deaths"] = target.registry["total_zombie_war_deaths"] + 1 --permanent registry for stat tracking
			target.registry["total_zombie_war_times_hit"] = 1 --permanent registry for stat tracking
			
			core.gameRegistry["zombie_war_"..teamName.."_point"] = core.gameRegistry["zombie_war_"..teamName.."_point"] + 1
			player.registry["zombie_war_kills"] = player.registry["zombie_war_kills"] + 1
			
			target:setDuration("respawning", 10000)
			target:warp(map, x, y)
			
			broadcast(map, ""..target.name.." has been SOAKED by "..player.name.."!")
			zombie_war.winnerCheck()
			
			target.registry["zombie_war_times_hit"] = 0
		end
	end
end,



refill = function(player)

	local m, x, y = player.m, player.x, player.y
	local refillTile = {28910, 28892, 28893, 28894, 28911, 28905, 28903, 28904, 28909, 28897, 28896, 28895, 28908, 28900, 28899, 28898}

	if m == 15060 or m == 15062 then
		for i = 1, #refillTile do
			if getTile(m, x, y) == refillTile[i] then
				if player.registry["zombie_war_gun_pct"] < 100 and player.registry["zombie_war_team"] > 0 and player.gfxClone == 1 then
					player.registry["zombie_war_gun_pct"] = player.registry["zombie_war_gun_pct"] + 5
					player:sendMinitext("Refilling: Your water tank is at "..player.registry["zombie_war_gun_pct"].."%")
				else
					player:sendMinitext("Your gun's water tank is full!")

				end
			end
		end
	end
end,

winnerCheck = function()

	local pointsToWin

	if core.gameRegistry["zombie_war_players"] < 4 then
		pointsToWin = 3
	elseif core.gameRegistry["zombie_war_players"] >= 4 and core.gameRegistry["zombie_war_players"] <= 9 then
		pointsToWin = 10
	elseif core.gameRegistry["zombie_war_players"] >= 10 and core.gameRegistry["zombie_war_players"] <= 15 then
		pointsToWin = 20
	elseif core.gameRegistry["zombie_war_players"] >= 16 then
		pointsToWin = 25
	end
	
	if core.gameRegistry["zombie_war_red_point"] == pointsToWin then 
		core.gameRegistry["zombie_war_red_wins"] = core.gameRegistry["zombie_war_red_wins"] + 1
		zombie_war.roundWin("red") 
		return 

	elseif core.gameRegistry["zombie_war_blue_point"] == pointsToWin then 
		core.gameRegistry["zombie_war_blue_wins"] = core.gameRegistry["zombie_war_blue_wins"] + 1
		zombie_war.roundWin("blue") 
		return 
	end

end,

roundWin = function(teamID)

	local map = core.gameRegistry["zombie_war_current_map"]
	local pc = core:getObjectsInMap(map, BL_PC)
	local teamName = ""
	
	if teamID == "red" then 
		teamName = "Red"
	elseif teamID == "blue" then
		teamName = "Blue"
	end
	
	broadcast(map, "-----------------------------------------------------------------------------------------------------")
	broadcast(map, "Round over! "..teamName.." Team has "..core.gameRegistry["zombie_war_"..teamID.."_wins"].." of 2 wins!")
	
	for i = 1, #pc do
		if pc[i].registry["zombie_war_team"] == 1 then --red team
			pc[i]:warp(map, 3, 2)
		end
		if pc[i].registry["zombie_war_team"] == 2 then --blue team
			pc[i]:warp(map, 36, 47)
		end
	end
	
	if core.gameRegistry["zombie_war_"..teamID.."_wins"] < 2 then
		zombie_war.nextRound()
	elseif core.gameRegistry["zombie_war_"..teamID.."_wins"] >= 2 then
		zombie_war.declareWinner(teamID)
	end
	
end,


nextRound = function()

	local map = core.gameRegistry["zombie_war_current_map"]
	local pc = core:getObjectsInMap(map, BL_PC)
	
	for i = 1, #pc do
		pc[i]:flushDurationNoUncast(517, 517) --flush any respawn duration
		pc[i].registry["zombie_war_times_hit"] = 0 --eliminate hit count between rounds
	end
	
	core.gameRegistry["zombie_war_red_point"] = 0
	core.gameRegistry["zombie_war_blue_point"] = 0
	zombie_war.wait()
	
end,

declareWinner = function(teamID)

	local map = core.gameRegistry["zombie_war_current_map"]
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
	core.gameRegistry["zombie_war_winner"] = teamNum
	broadcast(map, "         Game Over! "..teamName.." Team is the winner!")
	broadcast(map, "         You will exit the arena in 10 seconds!")
	
	core.gameRegistry["zombie_war_end_timer"] = os.time() + 10
	
end,

endGame = function()

	local map = core.gameRegistry["zombie_war_current_map"]
	local pc = core:getObjectsInMap(map, BL_PC)
	local arenaPC = core:getObjectsInMap(1031, BL_PC)
	local prizeRoom = 15992
	local loserRoom = 15982
	local x, y = 8, 10

	if core.gameRegistry["zombie_war_end_timer"] > 0 and core.gameRegistry["zombie_war_end_timer"] < os.time() then
		
		if #pc > 0 then
			for i =	1, #pc do
			
				if pc[i].registry["zombie_war_team"] == core.gameRegistry["zombie_war_winner"] then --if you are on the winning team
					pc[i]:warp(prizeRoom, x, y) --go to prize room	

				else --if you are not on the winning team
					pc[i]:warp(loserRoom, x, y) --go to loser room
				end
			
			
				pc[i].registry["zombie_war_times_hit"] = 0
				pc[i].registry["zombie_war_gun_pct"] = 0
				pc[i].registry["zombie_war_registered"] = 0
				pc[i].registry["zombie_war_flag"] = 0
				pc[i].registry["zombie_war_team"] = 0
				pc[i].registry["zombie_war_kills"] = 0
			
				pc[i].gfxClone = 0
				pc[i]:updateState()
				


			end
		end
		core.gameRegistry["zombie_war_end_timer"] = 0
		core.gameRegistry["zombie_war_players"] = 0
		core.gameRegistry["zombie_war_open"] = 0
		core.gameRegistry["zombie_war_winner"] = 0
		core.gameRegistry["zombie_war_started"] = 0
		core.gameRegistry["zombie_war_red_point"] = 0
		core.gameRegistry["zombie_war_blue_point"] = 0
		core.gameRegistry["zombie_war_current_map"] = 0
		core.gameRegistry["zombie_war_red_wins"] = 0
		core.gameRegistry["zombie_war_blue_wins"] = 0
		
		core.gameRegistry["zombie_war_winner"] = 0

	end
end,


entryLegend = function(player)

	local reg = player.registry["zombie_war_entries"]
	
	if player:hasLegend("zombie_war_entries") then player:removeLegendbyName("zombie_war_entries") end
	
	if reg > 0 then
		player.registry["zombie_war_entries"] = player.registry["zombie_war_entries"] + 1
		player:addLegend("Played in "..player.registry["zombie_war_entries"].." Zombie Wars", "zombie_war_entries", 198, 16)
	else
		player.registry["zombie_war_entries"] = 1
		player:addLegend("Played in 1 Zombie War", "zombie_war_entries", 198, 16)
	end
end,



victoryLegend = function(player)

	local reg = player.registry["zombie_war_wins"]


	if player:hasLegend("zombie_war_wins") then player:removeLegendbyName("zombie_war_wins") end
	
	if reg > 0 then
		player.registry["zombie_war_wins"] = player.registry["zombie_war_wins"] + 1
		player:addLegend("Won "..player.registry["zombie_war_wins"].." Beach Wars", "zombie_war_wins", 198, 16)
	else
		player.registry["zombie_war_wins"] = 1
		player:addLegend("Won 1 Beach War", "zombie_war_wins", 198, 16)
	end

	player:addMinigamePoint(player)

end

}


