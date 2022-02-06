
-- OPEN: /lua ffa.open()
-- STOP: /lua ffa.stop()
-- CANCEL: /lua ffa.cancel()
ffa = {
--[[
core = function()
	
	ffa.closed()
	ffa.timer()
	ffa.begin(core)
end,

open = function()
	
	core.gameRegistry["ffa"] = 1
	core.gameRegistry["ffa_start"] = os.time()+30
	broadcast(-1, "-----------------------------------------------------------------------------------------------------")
	broadcast(-1, "                                Free For All is now open in Hon Arena!")
	broadcast(-1, "                                    Entry is closing in 5 minutes!")
	broadcast(-1, "-----------------------------------------------------------------------------------------------------")
end,

click = async(function(player, npc)
	local pc = player:getObjectsInMap(player.m, BL_PC)
	local n = "<b>[Free For All]\n\n"
	local t = {g = convertGraphic(npc.look, "monster"), c = npc.lookColor}
	player.npcGraphic = t.g
	player.npcColor = t.c
	player.dialogType = 0
	
	local str, par = "", ""
	local time = ffa.getStartTimer()
	local total = {}


	if #pc > 0 then
		for i = 1, #pc do
			if pc[i].registry["ffa_registered"] > 0 then
				table.insert(total, pc[i].ID)
			end
		end
	end

	local opts = {}

	if player.gameRegistry["ffa"] == 1 then
		if player.registry["ffa_registered"] == 0 then
			table.insert(opts, "Register for Free For All")
		else
			par = " participant."
		end
	end

	table.insert(opts, "Exit")
	
	if player.gameRegistry["ffa_start"] > os.time() then
		str = "Waiting time: "..ffa.getStartTimer()
	end
	
	if core.gameRegistry["ffa"] == 0 then
		menu = player:menuString(n.."There is no Free For All running at this time, check back later.", opts)
	elseif core.gameRegistry["ffa"] == 1 then	
		menu = player:menuString(n.."Hello,"..par.." The game will start in few minutes.\n"..str, opts)
	end


	if menu == "Register for Free For All" then
		player.registry["ffa_registered"] = 1
		core.gameRegistry["ffa_players"] = core.gameRegistry["ffa_players"] + 1
		player:warp(3065, math.random(23, 26), math.random(28, 31))
		player:dialogSeq({t, n.."You have registered for the Free For All. The game will begin shortly, please wait patiently."})
	end
end),

closed = function()
	
	local diff = core.gameRegistry["ffa_start"] - os.time()
	
	if core.gameRegistry["ffa"] == 1 then
		if core.gameRegistry["ffa_start"] > 0 then
			if core.gameRegistry["ffa_start"] > os.time() then
				if diff == 60 then 
					broadcast(-1, "-----------------------------------------------------------------------------------------------------")
					broadcast(-1, "                                 Free For All entry is closing in 1 minute!")
					broadcast(-1, "-----------------------------------------------------------------------------------------------------")

				elseif diff == 10 then
					broadcast(3065, "                                    Free For All Starts in 10 seconds!")
				elseif diff <= 3 then
					broadcast(3065, "                                    Free For All Starts in "..diff.." seconds!")
				end
			elseif core.gameRegistry["ffa_start"] < os.time() then
				--core.gameRegistry["ffa"] = 0
				core.gameRegistry["ffa_start"] = 0
				broadcast(-1, "-----------------------------------------------------------------------------------------------------")
				broadcast(-1, "                                 Free For All entry is closed!")
				broadcast(-1, "-----------------------------------------------------------------------------------------------------")
				ffa.start()
			end
		end
	end
end,


start = function()
	
	local randomTile = math.random(1, 50)

	local pc = core:getObjectsInMap(3065, BL_PC)

	if core.gameRegistry["ffa_players"] >= 2 then
		if #pc > 0 then
			for i = 1, #pc do
				pc[i].PK = 1
				pc[i].pvp = 1
				pc[i]:refresh()
				pc[i]:sendStatus()
				ffa.entryLegend(pc[i])
				if randomTile == 1 then
					pc[i]:warp(15101, 6, 3)
				elseif randomTile == 2 then
					pc[i]:warp(15101, 2, 5)
				elseif randomTile == 3 then
					pc[i]:warp(15101, 4, 6)
				elseif randomTile == 4 then
					pc[i]:warp(15101, 2, 8)
				elseif randomTile == 5 then
					pc[i]:warp(15101, 6, 8)
				elseif randomTile == 6 then
					pc[i]:warp(15101, 10, 6)
				elseif randomTile == 7 then
					pc[i]:warp(15101, 12, 4)
				elseif randomTile == 8 then
					pc[i]:warp(15101, 19, 4)
				elseif randomTile == 9 then
					pc[i]:warp(15101, 24, 3)
				elseif randomTile == 10 then
					pc[i]:warp(15101, 24, 5)
				elseif randomTile == 11 then
					pc[i]:warp(15101, 27, 5)
				elseif randomTile == 12 then
					pc[i]:warp(15101, 26, 7)
				elseif randomTile == 13 then
					pc[i]:warp(15101, 23, 8)
				elseif randomTile == 14 then
					pc[i]:warp(15101, 20, 7)
				elseif randomTile == 15 then
					pc[i]:warp(15101, 19, 10)
				elseif randomTile == 16 then
					pc[i]:warp(15101, 16, 9)
				elseif randomTile == 17 then
					pc[i]:warp(15101, 12, 9)
				elseif randomTile == 18 then
					pc[i]:warp(15101, 9, 9)
				elseif randomTile == 19 then
					pc[i]:warp(15101, 2, 10)
				elseif randomTile == 20 then
					pc[i]:warp(15101, 5, 11)
				elseif randomTile == 21 then
					pc[i]:warp(15101, 10, 12)
				elseif randomTile == 22 then
					pc[i]:warp(15101, 2, 13)
				elseif randomTile == 23 then
					pc[i]:warp(15101, 9, 14)
				elseif randomTile == 24 then
					pc[i]:warp(15101, 23, 12)
				elseif randomTile == 25 then
					pc[i]:warp(15101, 27, 12)
				elseif randomTile == 26 then
					pc[i]:warp(15101, 3, 18)
				elseif randomTile == 27 then
					pc[i]:warp(15101, 6, 17)
				elseif randomTile == 28 then
					pc[i]:warp(15101, 21, 14)
				elseif randomTile == 29 then
					pc[i]:warp(15101, 17, 18)
				elseif randomTile == 30 then
					pc[i]:warp(15101, 21, 18)
				elseif randomTile == 31 then
					pc[i]:warp(15101, 28, 18)
				elseif randomTile == 32 then
					pc[i]:warp(15101, 25, 19)
				elseif randomTile == 33 then
					pc[i]:warp(15101, 13, 20)
				elseif randomTile == 34 then
					pc[i]:warp(15101, 9, 20)
				elseif randomTile == 35 then
					pc[i]:warp(15101, 1, 22)
				elseif randomTile == 36 then
					pc[i]:warp(15101, 3, 22)
				elseif randomTile == 37 then
					pc[i]:warp(15101, 6, 22)
				elseif randomTile == 38 then
					pc[i]:warp(15101, 4, 24)
				elseif randomTile == 39 then
					pc[i]:warp(15101, 5, 26)
				elseif randomTile == 40 then
					pc[i]:warp(15101, 10, 24)
				elseif randomTile == 41 then
					pc[i]:warp(15101, 13, 23)
				elseif randomTile == 42 then
					pc[i]:warp(15101, 15, 26)
				elseif randomTile == 43 then
					pc[i]:warp(15101, 17, 23)
				elseif randomTile == 44 then
					pc[i]:warp(15101, 20, 21)
				elseif randomTile == 45 then
					pc[i]:warp(15101, 21, 24)
				elseif randomTile == 46 then
					pc[i]:warp(15101, 26, 21)
				elseif randomTile == 47 then
					pc[i]:warp(15101, 23, 22)
				elseif randomTile == 48 then
					pc[i]:warp(15101, 26, 23)
				elseif randomTile == 49 then
					pc[i]:warp(15101, 28, 23)
				elseif randomTile == 50 then
					pc[i]:warp(15101, 25, 25)
				end
			end
			ffa.wait()
		end
	else
		broadcast(-1, "-----------------------------------------------------------------------------------------------------")
		broadcast(-1, "                             Not enough players. Free For All cancelled!")
		broadcast(-1, "-----------------------------------------------------------------------------------------------------")
		ffa.cancel()
	end
		
end,

wait = function()

	core.registry["ffa_wait_time"] = os.time() + 30
	broadcast(15101, "-----------------------------------------------------------------------------------------------------")
	broadcast(15101, "                                    Get Ready! Free For All starts in 30 seconds!")
	broadcast(15101, "-----------------------------------------------------------------------------------------------------")
end,


timer = function()

	local winner = core:getObjectsInMap(15101, BL_PC)

	if core.mapRegistry["player_count"] == 1 then
		if winner.state == 0 then	
			ffa.win(winner)
			ffa.stop()
		end
	end
	

end,

getStartTimer = function()
		
	local hour, minute, second = 0, 0, 0
	
	if core.gameRegistry["ffa_start"] < os.time() then return "00:00:00" else
		dif = core.gameRegistry["ffa_start"] - os.time()
		hour = string.format("%02.f", math.floor(dif/3600))
		minute = string.format("%02.f", math.floor(dif/60-(hour*60)))
		second = string.format("%02.f", math.floor(dif-hour*3600-minute*60))
		return hour..":"..minute..":"..second
	end
end,


stop = function()

	local pc = core:getObjectsInMap(15101, BL_PC)
	
	
	core.gameRegistry["ffa_players"] = 0
	core.gameRegistry["ffa"] = 0

	if #pc > 0 then
		for i = 1, #pc do
			pc[i].PK = 0
			pc[i].pvp = 0
			pc[i]:refresh()
			pc[i]:sendStatus()
			pc[i].registry["ffa_registered"] = 0
			pc[i]:warp(3053, math.random(13,17), math.random(4, 7))
			pc[i]:sendAnimation(16)
			pc[i]:playSound(29)
		end
	end
end,


cancel = function()

	local pc = core:getObjectsInMap(3065, BL_PC)
	
	core.gameRegistry["ffa_players"] = 0
	core.gameRegistry["ffa"] = 0

	
	if #pc > 0 then
		for i = 1, #pc do
			pc[i].PK = 0
			pc[i].pvp = 0
			pc[i]:refresh()
			pc[i]:sendStatus()
			pc[i].registry["ffa_registered"] = 0
			pc[i]:warp(3053, math.random(13,17), math.random(4, 7))
			pc[i]:sendAnimation(16)
			pc[i]:playSound(29)
		end
	end
end,


entryLegend = function(player)

	local reg = player.registry["ffa_entries"]

	if player:hasLegend("ffa_entries") then player:removeLegendbyName("ffa_entries") end
	
	if reg > 0 then
		player.registry["ffa_entries"] = player.registry["ffa_entries"] + 1
		player:addLegend("Played in "..player.registry["ffa_entries"].." Free For Alls", "ffa_entries", 104, 16)
	else
		player.registry["ffa_entries"] = 1
		player:addLegend("Played in 1 Free For All", "ffa_entries", 104, 16)
	end
end,



victoryLegend = function(player)

	local reg = player.registry["ffa_wins"]


	if player:hasLegend("ffa_wins") then player:removeLegendbyName("ffa_wins") end
	
	if reg > 0 then
		player.registry["ffa_wins"] = player.registry["ffa_wins"] + 1
		player:addLegend("Won "..player.registry["ffa_wins"].." Free For Alls", "ffa_wins", 223, 16)
	else
		player.registry["ffa_wins"] = 1
		player:addLegend("Won 1 Free For All", "ffa_wins", 223, 16)
	end

--	player:sendAnimation(133) 
--	player:playSound(67)
	player:sendMinitext("You got 1 Minigame Point!")
	player.registry["minigame_points"] = player.registry["minigame_points"] + 1
end,


win = function(player)

	local pc = core:getObjectsInMap(15101, BL_PC)
	
	broadcast(15101, "-----------------------------------------------------------------------------------------------------")
	broadcast(15101, "                               "..player.name.." Wins!")
	broadcast(15101, "-----------------------------------------------------------------------------------------------------")

	ffa.victoryLegend(player)
	ffa.stop()
end
]]--
}
