
squirt = {
--[[
redWin = function()

	local pc = core:getObjectsInMap(15020, BL_PC)
	
	broadcast(15020, "-----------------------------------------------------------------------------------------------------")
	broadcast(15020,                                          "Red Team Wins!")
	broadcast(15020,               "You will return to the Arena in 5 seconds")
	broadcast(15020, "-----------------------------------------------------------------------------------------------------")
	core.gameRegistry["squirt_end_timer"] = os.time() + 5

end,

blueWin = function()
	
	local pc = core:getObjectsInMap(15020, BL_PC)

	broadcast(15020, "-----------------------------------------------------------------------------------------------------")
	broadcast(15020,                                          "Blue Team Wins!")
	broadcast(15020,               "You will return to the Arena in 5 seconds")
	broadcast(15020, "-----------------------------------------------------------------------------------------------------")
	core.gameRegistry["squirt_end_timer"] = os.time() + 5
end,

winnerCheck = function()
	
	if #livingRedSquirt > 0 and #livingBlueSquirt > 0 then 
		return 
	elseif #livingRedSquirt > 0 and #livingBlueSquirt == 0 then 
		core.gameRegistry["squirt_winner"] = 1
		squirt.redWin() 
		return 

	elseif #livingRedSquirt == 0 and #livingBlueSquirt > 0 then 
		core.gameRegistry["squirt_winner"] = 2
		squirt.blueWin() 
		return 
	end



end,

getStartTimer = function()
		
	local hour, minute, second = 0, 0, 0
	
	if core.gameRegistry["squirt_start"] < os.time() then return "00:00:00" else
		dif = core.gameRegistry["squirt_start"] - os.time()
		hour = string.format("%02.f", math.floor(dif/3600))
		minute = string.format("%02.f", math.floor(dif/60-(hour*60)))
		second = string.format("%02.f", math.floor(dif-hour*3600-minute*60))
		return hour..":"..minute..":"..second
	end
end,

click = async(function(player, npc)
	
	local total = {}
	
	local pc = player:getObjectsInMap(player.m, BL_PC)
	local n = "<b>[Beach War]\n\n"
	local t = {g = convertGraphic(npc.look, "monster"), c = npc.lookColor}
	player.npcGraphic = t.g
	player.npcColor = t.c
	player.dialogType = 0
	
	local str, par = "", ""
	local time = squirt.getStartTimer()
	
	if #pc > 0 then
		for i = 1, #pc do
			if pc[i].registry["squirt_registered"] > 0 then
				table.insert(total, pc[i].ID)
			end
		end
	end
	local opts = {}
	table.insert(opts, "How To Play?")
	if core.gameRegistry["squirt_war"] == 1 then
		if player.registry["squirt_registered"] == 0 then
			table.insert(opts, "Register For Beach War")
		else
			par = " participant."
		end

		if player.registry["squirt_registered"] > 0 or player.registry["squirt_team"] > 0 then
			table.insert(opts, "I can't register!")
		end
	end


	table.insert(opts, "Exit")
	
	if core.gameRegistry["squirt_start"] > os.time() then
		str = "Waiting time: "..squirt.getStartTimer()
	end
	
	menu = player:menuString(n.."Hello,"..par.." The game will start in few minutes.\n"..str.."\nTotal players: "..#total, opts)
	
	if menu == "How To Play?" then
		player:dialogSeq({t, n.."Beach War is a game where you use your squirt gun to soak members of the opposing team.", 
							n.."A player can get soaked once and stay in the game, but a second shot will send you to the sidelines.",
							n.."Your gun can only hold 20 shots worth of water, but it will be slowly refilled if you stand by the pool at the center of the map.", 
							n.."The game ends when one team is completely eliminated."}, 1)
		player:freeAsync()
		squirt.click(player, npc)
	elseif menu == "Register For Beach War" then
		if player.registry["squirt_team"]  == 0 then
			player.registry["squirt_registered"] = 1
			player.registry["squirt_team"] = math.random(1, 2)
			core.gameRegistry["squirt_players"] = core.gameRegistry["squirt_players"] + 1
			player:warp(15021, math.random(2, 14), math.random(2, 12))
			player:sendAnimation(16)
			player:playSound(29)
			player:dialogSeq({t, n.."Allright, your character is registered for Beach War.\nPlease wait until the game starts!"}, 1)
		else
			player:dialogSeq({t, n.."Please be patient!\n\n<b>Waiting time: "..time..""}, 1)
			squirt.click(player, npc)
		end
	elseif menu == "I can't register!" then
		player.registry["squirt_times_hit"] = 0
		player.registry["squirt_gun_shots"] = 0
		player.registry["squirt_registered"] = 0
		player.registry["squirt_team"] = 0
		player:dialogSeq({t, n.."Looks like a simple paperwork mixup. You should be all set to register now, have fun at the game!"}, 1)
		player:freeAsync()
		squirt.click(player, npc)
	end
end),

core = function()
	
	squirt.closed()
	squirt.balancing(NPC(123))
	squirt.begin(NPC(123))
	squirt.endGame()
end,

open = function()
	
	core.gameRegistry["squirt_war"] = 1
	core.gameRegistry["squirt_start"] = os.time()+300
	broadcast(-1, "-----------------------------------------------------------------------------------------------------")
	broadcast(-1, "                                Beach War is now open in Hon Arena!")
	broadcast(-1, "                                    Entry is closing in 5 minutes!")
	broadcast(-1, "-----------------------------------------------------------------------------------------------------")
end,


roundTwo = function()
	
	core.gameRegistry["squirt_war"] = 1
	core.gameRegistry["squirt_start"] = os.time()+120
	broadcast(-1, "-----------------------------------------------------------------------------------------------------")
	broadcast(-1, "                                 Another chance to play! Get ready!")
	broadcast(-1, "                                Beach War is now open in Hon Arena!")
	broadcast(-1, "                                    Entry is closing in 2 minutes!")
	broadcast(-1, "-----------------------------------------------------------------------------------------------------")
end,

closed = function()
	
	local diff = core.gameRegistry["squirt_start"] - os.time()
	
	if core.gameRegistry["squirt_war"] == 1 then
		if core.gameRegistry["squirt_start"] > 0 then
			if core.gameRegistry["squirt_start"] > os.time() then
				if diff == 60 then 
					broadcast(-1, "-----------------------------------------------------------------------------------------------------")
					broadcast(-1, "                                 Beach War entry is closing in 1 minute!")
					broadcast(-1, "-----------------------------------------------------------------------------------------------------")

				elseif diff == 10 then
					broadcast(15021, "                                    Beach War Starts in 10 seconds!")
				elseif diff <= 3 then
					broadcast(15021, "                                    Beach War Starts in "..diff.." seconds!")
				end
			elseif core.gameRegistry["squirt_start"] < os.time() then
				--core.gameRegistry["squirt_war"] = 0
				core.gameRegistry["squirt_start"] = 0
				broadcast(-1, "-----------------------------------------------------------------------------------------------------")
				broadcast(-1, "                                 Beach War entry is closed!")
				broadcast(-1, "-----------------------------------------------------------------------------------------------------")
				squirt.start(NPC(123))
			end
		end
	end
end,

endGame = function()

	local pc = core:getObjectsInMap(15020, BL_PC)
	local arenaPC = core:getObjectsInMap(1091, BL_PC)


	if core.gameRegistry["squirt_end_timer"] > 0 and core.gameRegistry["squirt_end_timer"] < os.time() then
		core.gameRegistry["squirt_end_timer"] = 0
		core.gameRegistry["squirt_players"] = 0
		core.gameRegistry["squirt_war"] = 0
		
		core.gameRegistry["squirt_playing"] = 0
	
		if #pc > 0 then
			for i =	1, #pc do
				if pc[i].registry["squirt_team"] == core.gameRegistry["squirt_winner"] then
					squirt.victoryLegend(pc[i])
					pc[i]:leveledEXP("win_minigame") 
				else pc[i]:leveledEXP("lose_minigame") 
				end


				pc[i].registry["squirt_times_hit"] = 0
				pc[i].registry["squirt_gun_shots"] = 0
				pc[i].registry["squirt_registered"] = 0
				pc[i].registry["squirt_team"] = 0
				pc[i].gfxClone = 0
				pc[i]:updateState()
				
				pc[i]:warp(1091, math.random(13,17), math.random(4, 7))
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
		core.gameRegistry["squirt_winner"] = 0

		if core.gameRegistry["squirt_round_2"] == 0 then
			core.gameRegistry["squirt_round_2"] = 1
			squirt.roundTwo()
		elseif core.gameRegistry["squirt_round_2"] == 1 then
			core.gameRegistry["squirt_round_2"] = 0
			return
		end	

	end
end,

stop = function()

	local pc = core:getObjectsInMap(15020, BL_PC)

	core.gameRegistry["squirt_end_timer"] = 0
	core.gameRegistry["squirt_players"] = 0
	core.gameRegistry["squirt_war"] = 0
	core.gameRegistry["squirt_winner"] = 0
	
	core.gameRegistry["squirt_playing"] = 0
	
	if #pc > 0 then
		for i = 1, #pc do
			pc[i].registry["squirt_times_hit"] = 0
			pc[i].registry["squirt_gun_shots"] = 0
			pc[i].registry["squirt_registered"] = 0
			pc[i].registry["squirt_flag"] = 0
			pc[i].mapRegistry["squirt_red_point"] = 0
			pc[i].mapRegistry["squirt_blue_point"] = 0
			pc[i].registry["squirt_team"] = 0
			
			pc[i].gfxClone = 0
			pc[i]:updateState()
			pc[i]:warp(1091, math.random(13,17), math.random(4, 7))
			pc[i]:sendAnimation(16)
			pc[i]:playSound(29)
			pc[i]:calcStat()

		end
	end
end,

cancel = function()

	local pc = core:getObjectsInMap(15021, BL_PC)
	
	core.gameRegistry["squirt_winner"] = 0
	core.gameRegistry["squirt_end_timer"] = 0
	core.gameRegistry["squirt_players"] = 0
	core.gameRegistry["squirt_war"] = 0
	core.gameRegistry["squirt_playing"] = 0

	if #pc > 0 then
		for i = 1, #pc do
			pc[i].registry["squirt_times_hit"] = 0
			pc[i].registry["squirt_gun_shots"] = 0
			pc[i].registry["squirt_registered"] = 0
			pc[i].registry["squirt_flag"] = 0
			pc[i].mapRegistry["squirt_red_point"] = 0
			pc[i].mapRegistry["squirt_blue_point"] = 0
			pc[i].registry["squirt_team"] = 0
			pc[i]:warp(1091, math.random(13,17), math.random(4, 7))
			pc[i]:sendAnimation(16)
			pc[i]:playSound(29)
			pc[i]:calcStat()

		end
	end
end,


entryLegend = function(player)

	local reg = player.registry["squirt_war_entries"]

	if player:hasLegend("squirt_war_entries") then player:removeLegendbyName("squirt_war_entries") end
	
	if reg > 0 then
		player.registry["squirt_war_entries"] = player.registry["squirt_war_entries"] + 1
		player:addLegend("Played in "..player.registry["squirt_war_entries"].." Beach Wars", "squirt_war_entries", 198, 16)
	else
		player.registry["squirt_war_entries"] = 1
		player:addLegend("Played in 1 Beach War", "squirt_war_entries", 198, 16)
	end
end,



victoryLegend = function(player)

	local reg = player.registry["squirt_war_wins"]


	if player:hasLegend("squirt_war_wins") then player:removeLegendbyName("squirt_war_wins") end
	
	if reg > 0 then
		player.registry["squirt_war_wins"] = player.registry["squirt_war_wins"] + 1
		player:addLegend("Won "..player.registry["squirt_war_wins"].." Beach Wars", "squirt_war_wins", 198, 16)
	else
		player.registry["squirt_war_wins"] = 1
		player:addLegend("Won 1 Beach War", "squirt_war_wins", 198, 16)
	end

	player:addMinigamePoint(player)

end,



start = function(npc)

	livingRedSquirt = {}
	livingBlueSquirt = {}

	if #livingRedSquirt ~= 0 then rawset(livingRedSquirt, #livingRedSquirt, nil) end
	if #livingBlueSquirt ~= 0 then rawset(livingBlueSquirt, #livingBlueSquirt, nil) end


	squirt.balancing(npc)
	local pc = core:getObjectsInMap(15021, BL_PC)
	if core.gameRegistry["squirt_players"] >= 2 then
		if #pc > 0 then
			for i = 1, #pc do
				if pc[i].registry["squirt_team"] > 0 and pc[i].state ~= 0 then 
					pc[i].state = 0 
					pc[i].speed = 80
					pc[i].registry["mounted"] = 0
					pc[i]:updateState()
				end
				
				if pc[i].registry["squirt_team"] == 1 then
					table.insert(livingRedSquirt, pc[i].ID)
					squirt.costume(pc[i])
					pc[i]:warp(15020, 10, 2)
				end

				if pc[i].registry["squirt_team"] == 2 then
					table.insert(livingBlueSquirt, pc[i].ID)
					squirt.costume(pc[i])
					pc[i]:warp(15020, 22, 38)
				end
			end
			squirt.wait(NPC(123))
		end
	else
		--broadcast(-1, "-----------------------------------------------------------------------------------------------------")
		--broadcast(-1, "                             Not enough players. Beach War cancelled!")
		--broadcast(-1, "-----------------------------------------------------------------------------------------------------")
		squirt.cancel()
	end
		
end,

wait = function(npc)

	local pc = core:getObjectsInMap(15020, BL_PC)
	NPC(123).registry["squirt_wait_time"] = os.time() + 30
	
	local time = math.abs(os.time() - NPC(123).registry["squirt_wait_time"])

	for i = 1, #pc do
		pc[i]:setTimer(2, time)
	end
	
	broadcast(15020, "-----------------------------------------------------------------------------------------------------")
	broadcast(15020, "                                    Get Ready! Beach War starts in 30 seconds!")
	broadcast(15020, "-----------------------------------------------------------------------------------------------------")



end,

begin = function(npc)

	local pc = NPC(123):getObjectsInMap(15020, BL_PC)

	if NPC(123).registry["squirt_wait_time"] > 0 and NPC(123).registry["squirt_wait_time"] < os.time() then
		if #pc >= 2 then
			broadcast(15020, "-----------------------------------------------------------------------------------------------------")
			broadcast(15020, "                                   The Beach War has begun!")
			broadcast(15020, "-----------------------------------------------------------------------------------------------------")
			for i = 1, #pc do
				pc[i].registry["squirt_gun_shots"] = 20
				if pc[i].registry["squirt_team"] == 1 then
					pc[i]:warp(15020, 4, 8)
					squirt.entryLegend(pc[i])
				elseif pc[i].registry["squirt_team"] == 2 then
					pc[i]:warp(15020, 28, 32)
					squirt.entryLegend(pc[i])
				end
			end
		else
			broadcast(-1, "-----------------------------------------------------------------------------------------------------")
			broadcast(-1, "                             Not enough players. Beach War cancelled!")
			broadcast(-1, "-----------------------------------------------------------------------------------------------------")
			squirt.stop()
		end
		core.gameRegistry["squirt_playing"] = 1
		NPC(123).registry["squirt_wait_time"] = 0
	end
end,


balancing = function(npc)
	
	local red, blue = {}, {}
	local pc = npc:getObjectsInMap(15021, BL_PC)
	
	if #pc > 0 then
		for i = 1, #pc do
			if pc[i].registry["squirt_team"] == 1 then
				table.insert(red, pc[i].ID)
			elseif pc[i].registry["squirt_team"] == 2 then
				table.insert(blue, pc[i].ID)
			end
		end
	end
	if #pc > 0 then
		for i = 1, #pc do	
			if #red > #blue then
				if (#red-#blue) ~= 1 then pc[math.random(#pc)].registry["squirt_team"] = 2 break end
			end
			if #red < #blue then
				if #blue - #red ~= 1 then pc[math.random(#pc)].registry["squirt_team"] = 1 break end
			end
		end
	end
end,

costume = function(player)
	
	local team = player.registry["squirt_team"]
	local dye, str = 0, ""

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
	player.attackSpeed = 90
	player:updateState()
end,




hit = function(player, target)

	

	local team = target.registry["squirt_team"]
	
	player:playSound(739)
	player:playSound(737)
	target:sendAnimationXY(142, target.x, target.y)
	if target.registry["squirt_times_hit"] == 0 then
		target:sendMinitext("You got shot by "..player.name.."! Don't get hit again!")
		target.registry["squirt_times_hit"] = 1
	elseif target.registry["squirt_times_hit"] == 1 then
		if team == 1 then
			table.remove(livingRedSquirt)
			target:warp(15020, 16, 2)
			broadcast(15020, ""..target.name.." has been soaked by "..player.name.."!")
			squirt.winnerCheck()


		elseif team == 2 then
			table.remove(livingBlueSquirt)
			target:warp(15020, 16, 38)
			broadcast(15020, ""..target.name.." has been soaked by "..player.name.."!")
			squirt.winnerCheck()

		end
		target.registry["squirt_times_hit"] = 0
	end
end,

shoot = function(player)
	
	local team = player.registry["squirt_team"]
	local m, x, y, side = player.m, player.x, player.y, player.side
	local icon = 1615
	local pc
	
	if team > 0 then
		if player.m == 15020 and player.gfxClone == 1 then
			if player.registry["squirt_gun_shots"] >= 1 then
				player.registry["squirt_gun_shots"] = player.registry["squirt_gun_shots"] - 1
				player:playSound(709)
			--	player:sendAction(1, 20)
	
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
					if pc ~= nil and pc.registry["squirt_team"] > 0 then 
						if team ~= pc.registry["squirt_team"] then squirt.hit(player, pc) end
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
				player:sendMinitext("Your gun's water tank is at "..(player.registry["squirt_gun_shots"]*5).."%")
			else
				player:sendMinitext("Your gun is out of water!")
			end
		end
	end
end,


refill = function(player)

	local m, x, y = player.m, player.x, player.y


	if m == 15020 then
		if x >=14 and x <= 18 then
			if y >= 18 and y <= 22 then
				if player.registry["squirt_gun_shots"] < 20 and player.registry["squirt_team > 0"] and player.gfxClone == 1 then
					player.registry["squirt_gun_shots"] = player.registry["squirt_gun_shots"] + 1
					player:sendMinitext("Refilling: Your gun's water tank is at "..(player.registry["squirt_gun_shots"]*5).."%")
				else
					player:sendMinitext("Your gun's water tank is full!")

				end
			end
		end
	end
end
]]--
}
