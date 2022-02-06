
ctf = {

redWin = function(player)

	local pc = player:getObjectsInMap(15000, BL_PC)
	
	broadcast(15000, "-----------------------------------------------------------------------------------------------------")
	broadcast(15000,                                          "Red Team Wins!")
	broadcast(15000,               "You will return to the Arena in 5 seconds")
	broadcast(15000, "-----------------------------------------------------------------------------------------------------")
	core.gameRegistry["ctf_end_timer"] = os.time() + 5
	for i = 1, #pc do
		if pc[i].registry["ctf_team"] == 1 then
	--		ctf.victoryLegend(pc[i])
		end
	end
end,

blueWin = function(player)
	
	local pc = player:getObjectsInMap(15000, BL_PC)

	broadcast(15000, "-----------------------------------------------------------------------------------------------------")
	broadcast(15000,                                          "Blue Team Wins!")
	broadcast(15000,               "You will return to the Arena in 5 seconds")
	broadcast(15000, "-----------------------------------------------------------------------------------------------------")
	core.gameRegistry["ctf_end_timer"] = os.time() + 5
	for i = 1, #pc do
		if pc[i].registry["ctf_team"] == 2 then
	--		ctf.victoryLegend(pc[i])
		end
	end
end,


timer = function(player)

	local pc = player:getObjectsInMap(15000, BL_PC)

	if player.m == 15000 and player.registry["ctf_team"] > 0 then
		if player.mapRegistry["ctf_red_point"] >= 4 then
			core.gameRegistry["ctf_winner"] = 1
			core.gameRegistry["ctf_game_over"] = 1
			ctf.redWin(player)
			--ctf.stop()
		end
		if player.mapRegistry["ctf_blue_point"] >= 4 then
			core.gameRegistry["ctf_winner"] = 2
			core.gameRegistry["ctf_game_over"] = 1
			ctf.blueWin(player)
			--ctf.stop()
		end
	end
end,

getStartTimer = function()
		
	local hour, minute, second = 0, 0, 0
	
	if core.gameRegistry["ctf_start"] < os.time() then return "00:00:00" else
		dif = core.gameRegistry["ctf_start"] - os.time()
		hour = string.format("%02.f", math.floor(dif/3600))
		minute = string.format("%02.f", math.floor(dif/60-(hour*60)))
		second = string.format("%02.f", math.floor(dif-hour*3600-minute*60))
		return hour..":"..minute..":"..second
	end
end,

click = async(function(player, npc)
	
	local total = {}
	
	local pc = player:getObjectsInMap(player.m, BL_PC)
	local n = "<b>[Flag Freeze Tag]\n\n"
	local t = {g = convertGraphic(npc.look, "monster"), c = npc.lookColor}
	player.npcGraphic = t.g
	player.npcColor = t.c
	player.dialogType = 0
	
	local str, par = "", ""
	local time = ctf.getStartTimer()
	
	if #pc > 0 then
		for i = 1, #pc do
			if pc[i].registry["ctf_registered"] > 0 then
				table.insert(total, pc[i].ID)
			end
		end
	end
	local opts = {}
	table.insert(opts, "How To Play?")
	if core.gameRegistry["ctf_war"] == 1 then
		if player.registry["ctf_registered"] == 0 then
			table.insert(opts, "Register For Flag Freeze Tag")
		else
			par = " participant."
		end

		if player.registry["ctf_registered"] > 0 or player.registry["ctf_team"] > 0 then
			table.insert(opts, "I can't register!")
		end
	end
	table.insert(opts, "Exit")
	
	if player.gameRegistry["ctf_start"] > os.time() then
		str = "Waiting time: "..ctf.getStartTimer()
	end
	
	menu = player:menuString(n.."Hello,"..par.." The game will start in few minutes.\n"..str.."\nTotal players: "..#total, opts)
	
	if menu == "How To Play?" then
		player:dialogSeq({t, n.."Flag Freeze Tag is a variation on the traditional archery game.", 
							n.."Bring flags from your opponent's base to your own base to score points.",
							n.."You can shoot opponents with your bow to stun them for a short time.",
							n.."The first team to capture 4 flags is the winner!"}, 1)
		player:freeAsync()
		ctf.click(player, npc)
	elseif menu == "Register For Flag Freeze Tag" then
		if player.registry["ctf_team"]  == 0 then
			player.registry["ctf_registered"] = 1
			player.registry["ctf_team"] = math.random(1, 2)
			core.gameRegistry["ctf_players"] = core.gameRegistry["ctf_players"] + 1
			player:warp(15001, math.random(2, 14), math.random(2, 12))
			player:sendAnimation(16)
			player:playSound(29)
			player:dialogSeq({t, n.."Allright, your character is registered for Flag Freeze Tag.\nPlease wait until the game starts!"}, 1)
			ctf.click(player, npc)
		else
			player:dialogSeq({t, n.."Please be patient!\n\n<b>Waiting time: "..time..""}, 1)
			ctf.click(player, npc)
		end

	elseif menu == "I can't register!" then
		player.registry["ctf_registered"] = 0
		player.registry["ctf_flag"] = 0
		player.registry["ctf_team"] = 0
		player:dialogSeq({t, n.."Looks like a simple paperwork mixup. You should be all set to register now, have fun at the game!"}, 1)
		player:freeAsync()
		ctf.click(player, npc)
	end
end),

core = function()
	
	ctf.closed()
	ctf.balancing(core)
	ctf.begin(core)
	ctf.endGame()

end,

open = function()
	
	core.gameRegistry["ctf_war"] = 1
	core.gameRegistry["ctf_start"] = os.time()+300
	broadcast(-1, "-----------------------------------------------------------------------------------------------------")
	broadcast(-1, "                                Flag Freeze Tag is now open in Hon Arena!")
	broadcast(-1, "                                    Entry is closing in 5 minutes!")
	broadcast(-1, "-----------------------------------------------------------------------------------------------------")
end,

roundTwo = function()
	
	core.gameRegistry["ctf_war"] = 1
	core.gameRegistry["ctf_start"] = os.time()+120
	broadcast(-1, "-----------------------------------------------------------------------------------------------------")
	broadcast(-1, "                                 Another chance to play! Get ready!")
	broadcast(-1, "                                Flag Freeze Tag is now open in Hon Arena!")
	broadcast(-1, "                                    Entry is closing in 2 minutes!")
	broadcast(-1, "-----------------------------------------------------------------------------------------------------")
end,

closed = function()
	
	local diff = core.gameRegistry["ctf_start"] - os.time()
	
	if core.gameRegistry["ctf_war"] == 1 then
		if core.gameRegistry["ctf_start"] > 0 then
			if core.gameRegistry["ctf_start"] > os.time() then
				if diff == 60 then 
					broadcast(-1, "-----------------------------------------------------------------------------------------------------")
					broadcast(-1, "                                 Flag Freeze Tag entry is closing in 1 minute!")
					broadcast(-1, "-----------------------------------------------------------------------------------------------------")

				elseif diff == 10 then
					broadcast(15001, "                                    Flag Freeze Tag Starts in 10 seconds!")
				elseif diff <= 3 then
					broadcast(15001, "                                    Flag Freeze Tag Starts in "..diff.." seconds!")
				end
			elseif core.gameRegistry["ctf_start"] < os.time() then
				--core.gameRegistry["ctf_war"] = 0
				core.gameRegistry["ctf_start"] = 0
				broadcast(-1, "-----------------------------------------------------------------------------------------------------")
				broadcast(-1, "                                 Flag Freeze Tag entry is closed!")
				broadcast(-1, "-----------------------------------------------------------------------------------------------------")
				ctf.start(core)
			end
		end
	end
end,

endGame = function()

	local pc = core:getObjectsInMap(15000, BL_PC)
	local arenaPC = core:getObjectsInMap(1031, BL_PC)


	if core.gameRegistry["ctf_end_timer"] > 0 and core.gameRegistry["ctf_end_timer"] < os.time() then
		core.gameRegistry["ctf_end_timer"]  = 0
		core.gameRegistry["ctf_players"] = 0
		core.gameRegistry["ctf_war"] = 0
		core.gameRegistry["ctf_game_over"] = 0
		
		core.gameRegistry["ctf_playing"] = 0

	
		if #pc > 0 then
			for i =	1, #pc do
				
				pc[i].gfxClone = 0
				pc[i].state = 0
				pc[i]:updateState()



				if pc[i].registry["ctf_team"] == core.gameRegistry["ctf_winner"] then
					ctf.victoryLegend(pc[i])
					pc[i]:leveledEXP("win_minigame")
				else pc[i]:leveledEXP("lose_minigame")
				end
				pc[i].registry["ctf_registered"] = 0
				pc[i].registry["ctf_flag"] = 0
				pc[i].mapRegistry["ctf_red_point"] = 0
				pc[i].mapRegistry["ctf_blue_point"] = 0
				pc[i].registry["ctf_team"] = 0
								
				pc[i]:warp(1031, math.random(13,17), math.random(4, 7))
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
		core.gameRegistry["ctf_winner"] = 0

		if core.gameRegistry["ctf_round_2"] == 0 then
			core.gameRegistry["ctf_round_2"] = 1
			ctf.roundTwo()
		elseif core.gameRegistry["ctf_round_2"] == 1 then
			core.gameRegistry["ctf_round_2"] = 0
			return
		end	

	end
end,



stop = function()

	local pc = core:getObjectsInMap(15000, BL_PC)

	core.gameRegistry["ctf_end_timer"] = 0
	core.gameRegistry["ctf_winner"] = 0

	core.gameRegistry["ctf_players"] = 0
	core.gameRegistry["ctf_war"] = 0
	core.gameRegistry["ctf_game_over"] = 0
	core.gameRegistry["ctf_playing"] = 0
	
	if #pc > 0 then
		for i = 1, #pc do
			pc[i].registry["ctf_registered"] = 0
			pc[i].registry["ctf_flag"] = 0
			pc[i].registry["ctf_team"] = 0
			pc[i].mapRegistry["ctf_red_point"] = 0
			pc[i].mapRegistry["ctf_blue_point"] = 0
			pc[i].gfxClone = 0
			pc[i]:updateState()


			pc[i]:warp(1031, math.random(13,17), math.random(4, 7))
			pc[i]:sendAnimation(16)
			pc[i]:playSound(29)
		end
	end
end,

cancel = function()

	local pc = core:getObjectsInMap(15001, BL_PC)
	
	core.gameRegistry["ctf_end_timer"] = 0
	core.gameRegistry["ctf_winner"] = 0
	core.gameRegistry["ctf_players"] = 0
	core.gameRegistry["ctf_war"] = 0
	core.gameRegistry["ctf_game_over"] = 0
	
	core.gameRegistry["ctf_playing"] = 0
	
	if #pc > 0 then
		for i = 1, #pc do
			pc[i].registry["ctf_registered"] = 0
			pc[i].registry["ctf_flag"] = 0
			pc[i].mapRegistry["ctf_red_point"] = 0
			pc[i].mapRegistry["ctf_blue_point"] = 0
			pc[i].registry["ctf_team"] = 0
			pc[i].gfxClone = 0
			pc[i]:updateState()

			pc[i]:warp(1031, math.random(13,17), math.random(4, 7))
			pc[i]:sendAnimation(16)
			pc[i]:playSound(29)
		end
	end
end,


entryLegend = function(player)

	local reg = player.registry["ctf_war_entries"]

	if player:hasLegend("ctf_war_entries") then player:removeLegendbyName("ctf_war_entries") end
	
	if reg > 0 then
		player.registry["ctf_war_entries"] = player.registry["ctf_war_entries"] + 1
		player:addLegend("Played in "..player.registry["ctf_war_entries"].." Flag Freeze Tags", "ctf_war_entries", 17, 16)
	else
		player.registry["ctf_war_entries"] = 1
		player:addLegend("Played in 1 Flag Freeze Tag", "ctf_war_entries", 17, 16)
	end
end,



victoryLegend = function(player)

	local reg = player.registry["ctf_war_wins"]


	if player:hasLegend("ctf_war_wins") then player:removeLegendbyName("ctf_war_wins") end
	
	if reg > 0 then
		player.registry["ctf_war_wins"] = player.registry["ctf_war_wins"] + 1
		player:addLegend("Won "..player.registry["ctf_war_wins"].." Flag Freeze Tags", "ctf_war_wins", 17, 16)
	else
		player.registry["ctf_war_wins"] = 1
		player:addLegend("Won 1 Flag Freeze Tag", "ctf_war_wins", 17, 16)
	end

	player:addMinigamePoint(player)

end,



start = function(npc)

	ctf.balancing(npc)
	local pc = core:getObjectsInMap(15001, BL_PC)
	if core.gameRegistry["ctf_players"] >= 2 then
		if #pc > 0 then
			for i = 1, #pc do
				if pc[i].state == 3 then 
					pc[i].state = 0 
					pc[i].speed = 80
					pc[i].registry["mounted"] = 0
					pc[i]:updateState()
				end
				if pc[i].registry["ctf_team"] == 1 then
					pc[i]:warp(15000, 10, 2)
					ctf.costume(pc[i])
					
				elseif pc[i].registry["ctf_team"] == 2 then
					pc[i]:warp(15000, 22, 38)
					ctf.costume(pc[i])
				end
			end
			ctf.wait(core)
		end
	else
		--broadcast(-1, "-----------------------------------------------------------------------------------------------------")
		--broadcast(-1, "                             Not enough players. Flag Freeze Tag cancelled!")
		--broadcast(-1, "-----------------------------------------------------------------------------------------------------")
		ctf.cancel()
	end
		
end,

wait = function(npc)

	core.gameRegistry["ctf_wait_time"] = os.time() + 30
	broadcast(15000, "-----------------------------------------------------------------------------------------------------")
	broadcast(15000, "                                    Get Ready! Flag Freeze Tag starts in 30 seconds!")
	broadcast(15000, "-----------------------------------------------------------------------------------------------------")



end,

begin = function(npc)

	local pc = core:getObjectsInMap(15000, BL_PC)

	if core.gameRegistry["ctf_wait_time"] > 0 and core.gameRegistry["ctf_wait_time"] < os.time() then
		if #pc >= 2 then
			broadcast(15000, "-----------------------------------------------------------------------------------------------------")
			broadcast(15000, "                                   The Flag Freeze Tag has begun!")
			broadcast(15000, "-----------------------------------------------------------------------------------------------------")
			for i = 1, #pc do
				if pc[i].registry["ctf_team"] == 1 then
					pc[i]:warp(15000, 4, 8)
					ctf.entryLegend(pc[i])
				elseif pc[i].registry["ctf_team"] == 2 then
					pc[i]:warp(15000, 28, 32)
					ctf.entryLegend(pc[i])
				end
			end
		else
			broadcast(-1, "-----------------------------------------------------------------------------------------------------")
			broadcast(-1, "                             Not enough players. Flag Freeze Tag cancelled!")
			broadcast(-1, "-----------------------------------------------------------------------------------------------------")
			ctf.stop()
		end
		core.gameRegistry["ctf_playing"] = 1
		core.gameRegistry["ctf_wait_time"] = 0
	end
end,


balancing = function(npc)
	
	local red, blue = {}, {}
	local pc = npc:getObjectsInMap(15001, BL_PC)
	
	if #pc > 0 then
		for i = 1, #pc do
			if pc[i].registry["ctf_team"] == 1 then
				table.insert(red, pc[i].ID)
			elseif pc[i].registry["ctf_team"] == 2 then
				table.insert(blue, pc[i].ID)
			end
		end
	end
	if #pc > 0 then
		for i = 1, #pc do	
			if #red > #blue then
				if (#red-#blue) ~= 1 then pc[math.random(#pc)].registry["ctf_team"] = 2 break end
			end
			if #red < #blue then
				if #blue - #red ~= 1 then pc[math.random(#pc)].registry["ctf_team"] = 1 break end
			end
		end
	end
end,

costume = function(player)
	
	local team = player.registry["ctf_team"]
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
	player:updateState()
end,

walk = function(player)
	
	local bluetile = {583,589,584,588,586,590,585,587,591}
	local redtile = {574,580,575,579,577,581,576,578,582}
	local tile = getTile(player.m, player.x, player.y)
	local pc = player:getObjectsInMap(15000, BL_PC)
	
	if player.m == 15000 and player.registry["ctf_team"] > 0 then
		for i = 1, #bluetile do
			if player.registry["ctf_team"] == 1 then
				if tile == bluetile[i] then
					if player.registry["ctf_flag"] == 0 then
						player:sendAction(2, 20)
						player:sendAnimation(326)
						player:playSound(505)
						player.registry["ctf_flag"] = 1
						player.gfxWeap = 113
						player:updateState()
					end
				elseif tile == redtile[i] then
					if core.gameRegistry["ctf_game_over"] == 0 then
						if player.registry["ctf_flag"] == 1 and player.mapRegistry["ctf_red_point"] <= 3 then
							player.gfxWeap = 20014
							player.registry["ctf_flag"] = 0
							player.mapRegistry["ctf_red_point"] = player.mapRegistry["ctf_red_point"] + 1
							player:sendAnimation(349)
							player:playSound(112)
							broadcast(15000, "                                       "..player.name.." has captured the Blue Team's flag!")
							broadcast(15000, "                                       [Red Team = "..player.mapRegistry["ctf_red_point"].."] VS [Blue Team = "..player.mapRegistry["ctf_blue_point"].."]")
							player:updateState()
							ctf.timer(player)
						end
					end	
				end
			elseif player.registry["ctf_team"] == 2 then
				if tile == redtile[i] then
					if player.registry["ctf_flag"] == 0 then
						player:sendAction(2, 20)
						player:sendAnimation(326)
						player:playSound(505)	
						player.registry["ctf_flag"] = 1
						player.gfxWeap = 112
						player:updateState()
					end
				elseif tile == bluetile[i] then
					if core.gameRegistry["ctf_game_over"] == 0 then
						if player.registry["ctf_flag"] == 1 and player.mapRegistry["ctf_blue_point"] <= 3 then
							player.gfxWeap = 20014
							player.registry["ctf_flag"] = 0
							player.mapRegistry["ctf_blue_point"] = player.mapRegistry["ctf_blue_point"] + 1
							player:sendAnimation(349)
							player:playSound(112)
							broadcast(15000, "                                       "..player.name.." has captured the Red Team's flag!")
							broadcast(15000, "                                       [Red Team = "..player.mapRegistry["ctf_red_point"].."] VS [Blue Team = "..player.mapRegistry["ctf_blue_point"].."]")
							player:updateState()
							ctf.timer(player)
						end
					end
				end
			end
		end
	end
end,


stun = function(player, target)
		
	if target:hasDuration("ctf") then return else
		target:setDuration("ctf", 15000)
		target.paralyzed = true
		player:playSound(739)
		player:playSound(737)
		target:sendAnimation(345)
		target:sendAnimation(268)
	end
end,

rescue = function(player, target)
	
	if target:hasDuration("ctf") then 
		target:setDuration("ctf", 0)
		target.paralyzed = false
		player:playSound(724)
		target:sendAnimation(296)
	end
end,

shoot = function(player)
	
	local team = player.registry["ctf_team"]
	local m, x, y, side = player.m, player.x, player.y, player.side
	local icon = side+6
	local pc
	
	if team > 0 then
		if player.m == 15000 and player.gfxClone == 1 then
			player:playSound(709)
			player:sendAction(1, 20)
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
				if pc ~= nil and pc.registry["ctf_team"] > 0 then 
					if team == pc.registry["ctf_team"] then ctf.rescue(player, pc) else ctf.stun(player, pc) end
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
		end
	end
end,

while_cast = function(player)

	player.paralyzed = true
end,

uncast = function(player)
	
	player.paralyzed = false
end,
}
