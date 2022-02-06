
carnage = {
--[[

redWin = function()

	local pc = core:getObjectsInMap(15100, BL_PC)
	
	broadcast(15100, "-----------------------------------------------------------------------------------------------------")
	broadcast(15100,                                          "Red Team Wins!")
	broadcast(15100,               "You will return to the Arena in 5 seconds")
	broadcast(15100, "-----------------------------------------------------------------------------------------------------")
	core.gameRegistry["carnage_end_timer"] = os.time() + 5

end,

blueWin = function()
	
	local pc = core:getObjectsInMap(15100, BL_PC)

	broadcast(15100, "-----------------------------------------------------------------------------------------------------")
	broadcast(15100,                                          "Blue Team Wins!")
	broadcast(15100,               "You will return to the Arena in 5 seconds")
	broadcast(15100, "-----------------------------------------------------------------------------------------------------")
	core.gameRegistry["carnage_end_timer"] = os.time() + 5
end,


getStartTimer = function()
		
	local hour, minute, second = 0, 0, 0
	
	if core.gameRegistry["carnage_start"] < os.time() then return "00:00:00" else
		dif = core.gameRegistry["carnage_start"] - os.time()
		hour = string.format("%02.f", math.floor(dif/3600))
		minute = string.format("%02.f", math.floor(dif/60-(hour*60)))
		second = string.format("%02.f", math.floor(dif-hour*3600-minute*60))
		return hour..":"..minute..":"..second
	end
end,

click = async(function(player, npc)
	
	local total = {}
	
	local pc = player:getObjectsInMap(player.m, BL_PC)
	local n = "<b>[Carnage]\n\n"
	local t = {g = convertGraphic(npc.look, "monster"), c = npc.lookColor}
	player.npcGraphic = t.g
	player.npcColor = t.c
	player.dialogType = 0
	
	local str, par = "", ""
	local time = carnage.getStartTimer()
	
	if #pc > 0 then
		for i = 1, #pc do
			if pc[i].registry["carnage_registered"] > 0 then
				table.insert(total, pc[i].ID)
			end
		end
	end
	local opts = {}
	table.insert(opts, "How To Play?")
	if core.gameRegistry["carnage"] == 1 then
		if player.registry["carnage_registered"] == 0 then
			table.insert(opts, "Register For Carnage")
		else
			par = " participant."
		end

		if player.registry["carnage_registered"] > 0 or player.registry["carnage_team"] > 0 then
			table.insert(opts, "I can't register!")
		end
	end


	table.insert(opts, "Exit")
	
	if core.gameRegistry["carnage_start"] > os.time() then
		str = "Waiting time: "..carnage.getStartTimer()
	end
	
	menu = player:menuString(n.."Hello,"..par.." The game will start in few minutes.\n"..str.."\nTotal players: "..#total, opts)
	
	if menu == "How To Play?" then
		player:dialogSeq({t, n.."Blahblahblah..", n.."Blahblahlblabla..."}, 1)
		carnage.click(player, npc)
	elseif menu == "Register For Carnage" then
		if player.registry["carnage_team"]  == 0 then
			player.registry["carnage_registered"] = 1
			player.registry["carnage_team"] = math.random(1, 2)
			core.gameRegistry["carnage_players"] = core.gameRegistry["carnage_players"] + 1
			player:warp(3065, 24, 30)
			player:sendAnimation(16)
			player:playSound(29)
			player:dialogSeq({t, n.."Allright, your character is registered for Carnage.\nPlease wait until the game starts!"}, 1)
		else
			player:dialogSeq({t, n.."Please be patient!\n\n<b>Waiting time: "..time..""}, 1)
			carnage.click(player, npc)
		end
	elseif menu == "I can't register!" then

		player.registry["carnage_registered"] = 0
		player.registry["carnage_team"] = 0
		player:dialogSeq({t, n.."Looks like a simple paperwork mixup. You should be all set to register now, have fun at the game!"}, 1)
		player:freeAsync()
		carnage.click(player, npc)
	end
end),

core = function()
	
	carnage.closed()
	carnage.balancing(core)
	carnage.begin(core)
	carnage.endGame()
end,

open = function()
	
	core.gameRegistry["carnage"] = 1
	core.gameRegistry["carnage_start"] = os.time()+30
	broadcast(-1, "-----------------------------------------------------------------------------------------------------")
	broadcast(-1, "                                Carnage is now open in Hon Arena!")
	broadcast(-1, "                                    Entry is closing in 5 minutes!")
	broadcast(-1, "-----------------------------------------------------------------------------------------------------")
end,


roundTwo = function()
	
	core.gameRegistry["carnage"] = 1
	core.gameRegistry["carnage_start"] = os.time()+120
	broadcast(-1, "-----------------------------------------------------------------------------------------------------")
	broadcast(-1, "                                 Another chance to play! Get ready!")
	broadcast(-1, "                                Carnage is now open in Hon Arena!")
	broadcast(-1, "                                    Entry is closing in 2 minutes!")
	broadcast(-1, "-----------------------------------------------------------------------------------------------------")
end,

closed = function()
	
	local diff = core.gameRegistry["carnage_start"] - os.time()
	
	if core.gameRegistry["carnage"] == 1 then
		if core.gameRegistry["carnage_start"] > 0 then
			if core.gameRegistry["carnage_start"] > os.time() then
				if diff == 60 then 
					broadcast(-1, "-----------------------------------------------------------------------------------------------------")
					broadcast(-1, "                                 Carnage entry is closing in 1 minute!")
					broadcast(-1, "-----------------------------------------------------------------------------------------------------")

				elseif diff == 10 then
					broadcast(3065, "                                    Carnage Starts in 10 seconds!")
				elseif diff <= 3 then
					broadcast(3065, "                                    Carnage Starts in "..diff.." seconds!")
				end
			elseif core.gameRegistry["carnage_start"] < os.time() then
				--core.gameRegistry["carnage"] = 0
				core.gameRegistry["carnage_start"] = 0
				broadcast(-1, "-----------------------------------------------------------------------------------------------------")
				broadcast(-1, "                                 Carnage entry is closed!")
				broadcast(-1, "-----------------------------------------------------------------------------------------------------")
				carnage.start(core)
			end
		end
	end
end,

endGame = function()

	local pc = core:getObjectsInMap(15100, BL_PC)
	local arenaPC = core:getObjectsInMap(3053, BL_PC)


	if core.gameRegistry["carnage_end_timer"] > 0 and core.gameRegistry["carnage_end_timer"] < os.time() then
		core.gameRegistry["carnage_end_timer"] = 0
		core.gameRegistry["carnage_players"] = 0
		core.gameRegistry["carnage"] = 0
		carnage.mapReset()

		if #pc > 0 then
			for i =	1, #pc do
				pc[i].gfxClone = 0
				pc[i].health = pc[i].maxHealth
				pc[i].state = 0
				pc[i].PK = 0
				pc[i]:refresh()
				pc[i]:updateState()


				if pc[i].registry["carnage_team"] == core.gameRegistry["carnage_winner"] then
					carnage.victoryLegend(pc[i])
					pc[i]:leveledEXP("win_minigame")
				else pc[i]:leveledEXP("lose_minigame")
				end


				pc[i].registry["carnage_registered"] = 0
				pc[i].registry["carnage_team"] = 0
			
				
				pc[i]:warp(3053, math.random(13,17), math.random(4, 7))
				pc[i]:sendAnimation(16)
				pc[i]:playSound(29)
				pc[i]:calcStat()
			end
		end

		if #arenaPC > 0 then
			for i =	1, #arenaPC do
				arenaPC[i].gfxClone = 0
				arenaPC[i]:updateState()
			end
		end
		core.gameRegistry["carnage_winner"] = 0

		if core.gameRegistry["carnage_round_2"] == 0 then
			core.gameRegistry["carnage_round_2"] = 1
			carnage.roundTwo()
		elseif core.gameRegistry["carnage_round_2"] == 1 then
			core.gameRegistry["carnage_round_2"] = 0
			return
		end	
	end

end,

stop = function()

	local pc = core:getObjectsInMap(15100, BL_PC)

	core.gameRegistry["carnage_end_timer"] = 0
	core.gameRegistry["carnage_players"] = 0
	core.gameRegistry["carnage"] = 0
	core.gameRegistry["carnage_winner"] = 0

	
	if #pc > 0 then
		for i = 1, #pc do

			pc[i].registry["carnage_registered"] = 0

			pc[i].mapRegistry["carnage_red_point"] = 0
			pc[i].mapRegistry["carnage_blue_point"] = 0
			
			pc[i].registry["carnage_team"] = 0
			pc[i].gfxClone = 0
			pc[i].health = pc[i].maxHealth
			pc[i].state = 0
			pc[i].PK = 0
			pc[i]:refresh()
			pc[i]:updateState()
			pc[i]:warp(3053, math.random(13,17), math.random(4, 7))
			pc[i]:sendAnimation(16)
			pc[i]:playSound(29)
			pc[i]:calcStat()

		end
	end
	
	carnage.mapReset()
end,

cancel = function()

	local pc = core:getObjectsInMap(3065, BL_PC)
	
	core.gameRegistry["carnage_winner"] = 0
	core.gameRegistry["carnage_end_timer"] = 0
	core.gameRegistry["carnage_players"] = 0
	core.gameRegistry["carnage"] = 0

	if #pc > 0 then
		for i = 1, #pc do

			pc[i].registry["carnage_registered"] = 0
			
			pc[i].mapRegistry["carnage_red_point"] = 0
			pc[i].mapRegistry["carnage_blue_point"] = 0
		
			pc[i].registry["carnage_team"] = 0
			pc[i].health = pc[i].maxHealth
			pc[i].state = 0
			pc[i].PK = 0
			pc[i]:refresh()
			pc[i]:updateState()
			pc[i]:warp(3053, math.random(13,17), math.random(4, 7))
			pc[i]:sendAnimation(16)
			pc[i]:playSound(29)
			pc[i]:calcStat()

		end
	end
	carnage.mapReset()
end,


entryLegend = function(player)

	local reg = player.registry["carnage_entries"]

	if player:hasLegend("carnage_entries") then player:removeLegendbyName("carnage_entries") end
	
	if reg > 0 then
		player.registry["carnage_entries"] = player.registry["carnage_entries"] + 1
		player:addLegend("Played in "..player.registry["carnage_entries"].." Carnages", "carnage_entries", 1, 16)
	else
		player.registry["carnage_entries"] = 1
		player:addLegend("Played in 1 Carnage", "carnage_entries", 1, 16)
	end
end,



victoryLegend = function(player)

	local reg = player.registry["carnage_wins"]


	if player:hasLegend("carnage_wins") then player:removeLegendbyName("carnage_wins") end
	
	if reg > 0 then
		player.registry["carnage_wins"] = player.registry["carnage_wins"] + 1
		player:addLegend("Won "..player.registry["carnage_wins"].." Carnages", "carnage_wins", 1, 16)
	else
		player.registry["carnage_wins"] = 1
		player:addLegend("Won 1 Carnage", "carnage_wins", 1, 16)
	end

	player:addMinigamePoint(player)

end,



start = function(npc)

	livingRedCarnage = {}
	livingBlueCarnage = {}

	if #livingRedCarnage ~= 0 then rawset(livingRedCarnage, #livingRedCarnage, nil) end
	if #livingBlueCarnage ~= 0 then rawset(livingBlueCarnage, #livingBlueCarnage, nil) end


	carnage.balancing(npc)
	local pc = core:getObjectsInMap(3065, BL_PC)
	if core.gameRegistry["carnage_players"] >= 2 then
		if #pc > 0 then
			for i = 1, #pc do
				if pc[i].registry["carnage_team"] > 0 and pc[i].state ~= 0 then 
					pc[i].state = 0 
					pc[i].speed = 80
					pc[i].registry["mounted"] = 0
					pc[i]:updateState()
				end
				
				if pc[i].registry["carnage_team"] == 1 then
					table.insert(livingRedCarnage, pc[i].ID)
					carnage.costume(pc[i])
					pc[i]:warp(15100, math.random(2, 5), math.random(22, 25))
					carnage.entryLegend(pc[i])
				end

				if pc[i].registry["carnage_team"] == 2 then
					table.insert(livingBlueCarnage, pc[i].ID)
					carnage.costume(pc[i])
					pc[i]:warp(15100, math.random(24, 27), math.random(4, 7))
					carnage.entryLegend(pc[i])
				end
			end
			carnage.wait(core)
		end
	else
		broadcast(-1, "-----------------------------------------------------------------------------------------------------")
		broadcast(-1, "                             Not enough players. Carnage cancelled!")
		broadcast(-1, "-----------------------------------------------------------------------------------------------------")
		carnage.cancel()
	end
		
end,

wait = function(npc)

	core.gameRegistry["carnage_wait_time"] = os.time() + 30
	broadcast(15100, "-----------------------------------------------------------------------------------------------------")
	broadcast(15100, "                                    Get Ready! Carnage starts in 30 seconds!")
	broadcast(15100, "-----------------------------------------------------------------------------------------------------")



end,

begin = function(npc)

	local pc = core:getObjectsInMap(15100, BL_PC)

	if core.gameRegistry["carnage_wait_time"] > 0 and core.gameRegistry["carnage_wait_time"] < os.time() then
		if #pc >= 2 then
			--lower spikes, make sure everyone is pk
			for x = 1, 28 do
				for y = 3, 26 do
					if getObject(15100, x, y) == 13592 then
						setObject(15100, x, y, 13591)
						setPass(15100, x, y, 0)
					end
				end
			end
			broadcast(15100, "-----------------------------------------------------------------------------------------------------")
			broadcast(15100, "                                   The Carnage has begun!")
			broadcast(15100, "-----------------------------------------------------------------------------------------------------")
		else
			broadcast(-1, "-----------------------------------------------------------------------------------------------------")
			broadcast(-1, "                             Not enough players. Carnage cancelled!")
			broadcast(-1, "-----------------------------------------------------------------------------------------------------")
			carnage.stop()
		end
		core.gameRegistry["carnage_wait_time"] = 0
	end
end,


balancing = function(npc)
	
	local red, blue = {}, {}
	local pc = npc:getObjectsInMap(3065, BL_PC)
	
	if #pc > 0 then
		for i = 1, #pc do
			if pc[i].registry["carnage_team"] == 1 then
				table.insert(red, pc[i].ID)
			elseif pc[i].registry["carnage_team"] == 2 then
				table.insert(blue, pc[i].ID)
			end
		end
	end
	if #pc > 0 then
		for i = 1, #pc do	
			if #red > #blue then
				if (#red-#blue) ~= 1 then pc[math.random(#pc)].registry["carnage_team"] = 2 break end
			end
			if #red < #blue then
				if #blue - #red ~= 1 then pc[math.random(#pc)].registry["carnage_team"] = 1 break end
			end
		end
	end
end,

costume = function(player)

	local warrior = {boy = 210, girl = 211}
	local rogue = {boy = 2, girl = 7}
	local mage = {boy = 10, girl = 11}
	local poet = {boy = 20, girl = 18}
	
	clone.equip(player, player)

	if player.baseClass == 1 then
		if player.sex == 0 then player.gfxArmor = warrior.boy end
		if player.sex == 1 then player.gfxArmor = warrior.girl end
	elseif player.baseClass == 2 then
		if player.sex == 0 then player.gfxArmor = rogue.boy end
		if player.sex == 1 then player.gfxArmor = rogue.girl end
	elseif player.baseClass == 3 then
		if player.sex == 0 then player.gfxArmor = mage.boy end
		if player.sex == 1 then player.gfxArmor = mage.girl end
	elseif player.baseClass == 4 then
		if player.sex == 0 then player.gfxArmor = poet.boy end
		if player.sex == 1 then player.gfxArmor = poet.girl end
	end

	if player.registry["carnage_team"] == 1 then 
		player.gfxDye = 31
	elseif player.registry["carnage_team"] == 2 then
		player.gfxDye = 17
	end
	player.gfxClone = 1
	player:updateState()
end,

winnerCheck = function()
	
	if #livingRedCarnage > 0 and #livingBlueCarnage > 0 then 
		return 
	elseif #livingRedCarnage > 0 and #livingBlueCarnage == 0 then 
		core.gameRegistry["carnage_winner"] = 1
		carnage.redWin() 
		return 

	elseif #livingRedCarnage == 0 and #livingBlueCarnage > 0 then 
		core.gameRegistry["carnage_winner"] = 2
		carnage.blueWin() 
		return 
	end
end,


death = function(player, target)

	local team = target.registry["carnage_team"]
	
	--player:playSound(739)
	--player:playSound(737)
	--target:sendAnimationXY(142, target.x, target.y)
	

	if team == 1 then
		table.remove(livingRedCarnage)
		broadcast(15100, ""..target.name.." has been killed by "..player.name.."!")
		carnage.winnerCheck()


	elseif team == 2 then
		table.remove(livingBlueCarnage)
		broadcast(15100, ""..target.name.." has been killed by "..player.name.."!")
		carnage.winnerCheck()

	end
	target.registry["carnage_times_hit"] = 0

end,


mapReset = function()

	local map = 15100

	for x = 1, 28 do
		for y = 3, 26 do
			if getObject(map, x, y) == 13591 then
				setObject(map, x, y, 13592)
				setPass(map, x, y, 1)
			end
		end
	end

end
]]--
}
