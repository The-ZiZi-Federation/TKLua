elixir = {

redWin = function()

	local pc = core:getObjectsInMap(15040, BL_PC)
	
	broadcast(15040, "-----------------------------------------------------------------------------------------------------")
	broadcast(15040,                                          "Red Team Wins!")
	broadcast(15040,               "You will return to the Arena in 5 seconds")
	broadcast(15040, "-----------------------------------------------------------------------------------------------------")
	core.gameRegistry["elixir_end_timer"] = os.time() + 5
end,

blueWin = function()
	
	local pc = core:getObjectsInMap(15040, BL_PC)

	broadcast(15040, "-----------------------------------------------------------------------------------------------------")
	broadcast(15040,                                          "Blue Team Wins!")
	broadcast(15040,               "You will return to the Arena in 5 seconds")
	broadcast(15040, "-----------------------------------------------------------------------------------------------------")
	core.gameRegistry["elixir_end_timer"] = os.time() + 5
end,


winnerCheck = function()

	core.gameRegistry["elixir_playing"] = 0

	if core.gameRegistry["elixir_red_point"] >= 2 then
		core.gameRegistry["elixir_winner"] = 1
		core.gameRegistry["elixir_game_over"] = 1
		elixir.redWin()
		return

	elseif core.gameRegistry["elixir_blue_point"] >= 2 then
		core.gameRegistry["elixir_winner"] = 2
		core.gameRegistry["elixir_game_over"] = 1
		elixir.blueWin()
		return
	else
		elixir.nextRound()
		return
	end

end,

getStartTimer = function()
		
	local hour, minute, second = 0, 0, 0
	
	if core.gameRegistry["elixir_start"] < os.time() then return "00:00:00" else
		dif = core.gameRegistry["elixir_start"] - os.time()
		hour = string.format("%02.f", math.floor(dif/3600))
		minute = string.format("%02.f", math.floor(dif/60-(hour*60)))
		second = string.format("%02.f", math.floor(dif-hour*3600-minute*60))
		return hour..":"..minute..":"..second
	end
end,

click = async(function(player, npc)
	
	local total = {}
	
	local pc = player:getObjectsInMap(player.m, BL_PC)
	local n = "<b>[Elixir War]\n\n"
	local t = {g = convertGraphic(npc.look, "monster"), c = npc.lookColor}
	player.npcGraphic = t.g
	player.npcColor = t.c
	player.dialogType = 0
	
	local str, par = "", ""
	local time = elixir.getStartTimer()
	
	if #pc > 0 then
		for i = 1, #pc do
			if pc[i].registry["elixir_registered"] > 0 then
				table.insert(total, pc[i].ID)
			end
		end
	end
	local opts = {}
	table.insert(opts, "How To Play?")
	if core.gameRegistry["elixir_war"] == 1 then
		if player.registry["elixir_registered"] == 0 then
			table.insert(opts, "Register For Elixir War")
		else
			par = " participant."
		end

		if player.registry["elixir_registered"] > 0 or player.registry["elixir_team"] > 0 then
			table.insert(opts, "I can't register!")
		end
	end
	table.insert(opts, "Exit")
	
	if player.gameRegistry["elixir_start"] > os.time() then
		str = "Waiting time: "..elixir.getStartTimer()
	end
	
	menu = player:menuString(n.."Hello,"..par.." The game will start in few minutes.\n"..str.."\nTotal players: "..#total, opts)
	
	if menu == "How To Play?" then
		player:dialogSeq({t, n.."Elixir War is a team-based game of strategy and marksmanship.", 
							n.."The objective is to retrieve the flag from your opponent's base and return it to your team's base.",
							n.."Every player is armed with a bow, and your arrows are specially made to dye your uniforms.",
							n.."If a player is hit by an arrow from a member of the opposing team, they will be dyed.",
							n.."If a dyed player is hit by an arrow from their own team, they will be dyed back.",
							n.."Any player who takes a step while dyed is sidelined. In addition, you will also be sidelined if you stand around for too long without moving.",
							n.."The first team to win 2 rounds is the victor!"}, 1)
		player:freeAsync()
		elixir.click(player, npc)
	elseif menu == "Register For Elixir War" then
		if player.registry["minigame_ban_timer"] > os.time() then --Check if player is banned from minigames
			player:popUp("You are currently banned from minigames! Try again later maybe.")
			return

		end
		if player.registry["elixir_team"]  == 0 then
			player.registry["elixir_registered"] = 1
			player.registry["elixir_flag"] = 0
			player.registry["elixir_team"] = math.random(1, 2)
			player.gfxDye = 0
			core.gameRegistry["elixir_players"] = core.gameRegistry["elixir_players"] + 1
			player:warp(15041, math.random(2, 14), math.random(2, 12))
			player:sendAnimation(16)
			player:playSound(29)
			player:dialogSeq({t, n.."Allright, your character is registered for Elixir War.\nPlease wait until the game starts!"}, 1)
			elixir.click(player, npc)
		else
			player:dialogSeq({t, n.."Please be patient!\n\n<b>Waiting time: "..time..""}, 1)
			elixir.click(player, npc)
		end

	elseif menu == "I can't register!" then
		player.registry["elixir_registered"] = 0
		player.registry["elixir_flag"] = 0
		player.registry["elixir_team"] = 0
		player.gfxDye = 0
		player:dialogSeq({t, n.."Looks like a simple paperwork mixup. You should be all set to register now, have fun at the game!"}, 1)
		player:freeAsync()
		elixir.click(player, npc)
	end
end),




banPlayer = function(player)
	player.registry["elixir_registered"] = 0
	player.registry["elixir_flag"] = 0
	player.registry["elixir_team"] = 0
	player.registry["elixir_hit"] = 0
	player.registry["elixir_arrows"] = 0
	player.registry["elixir_burn_time"] = 0
	player.gfxDye = 0
	player.gfxClone = 0
	player:updateState()
	player.registry["minigame_ban_timer"] = os.time() + 3600
	player:popUp(player.name..",\nGood job trying to cheat. You just received a minigame ban. Congratulations!")
	player:warp(1031, 12, 11) -- warps player out of arena


	core.gameRegistry["elixir_players"] = core.gameRegistry["elixir_players"] - 1

	if core.gameRegistry["elixir_players"] < 2 then
	elixir.endGame()
	end



end,











core = function()
	
	elixir.closed()
	elixir.balancing(core)
	elixir.begin(core)
	elixir.endGame()
	elixir.beginRoundTwo(core)


end,

open = function()
	
	core.gameRegistry["elixir_war"] = 1
	core.gameRegistry["elixir_start"] = os.time()+300
	broadcast(-1, "-----------------------------------------------------------------------------------------------------")
	broadcast(-1, "                                Elixir War is now open in Hon Arena!")
	broadcast(-1, "                                    Entry is closing in 5 minutes!")
	broadcast(-1, "-----------------------------------------------------------------------------------------------------")
end,

closed = function()
	
	local diff = core.gameRegistry["elixir_start"] - os.time()
	
	if core.gameRegistry["elixir_war"] == 1 then
		if core.gameRegistry["elixir_start"] > 0 then
			if core.gameRegistry["elixir_start"] > os.time() then
				if diff == 60 then 
					broadcast(-1, "-----------------------------------------------------------------------------------------------------")
					broadcast(-1, "                                 Elixir War entry is closing in 1 minute!")
					broadcast(-1, "-----------------------------------------------------------------------------------------------------")

				elseif diff == 10 then
					broadcast(15041, "                                    Elixir War Starts in 10 seconds!")
				elseif diff <= 3 then
					broadcast(15041, "                                    Elixir War Starts in "..diff.." seconds!")
				end
			elseif core.gameRegistry["elixir_start"] < os.time() then
				--core.gameRegistry["elixir_war"] = 0
				core.gameRegistry["elixir_start"] = 0
				broadcast(-1, "-----------------------------------------------------------------------------------------------------")
				broadcast(-1, "                                 Elixir War entry is closed!")
				broadcast(-1, "-----------------------------------------------------------------------------------------------------")
				elixir.start(core)
			end
		end
	end
end,

endGame = function()

	local pc = core:getObjectsInMap(15040, BL_PC)
	local arenaPC = core:getObjectsInMap(1031, BL_PC)


	if core.gameRegistry["elixir_end_timer"] > 0 and core.gameRegistry["elixir_end_timer"] < os.time() then
		core.gameRegistry["elixir_end_timer"]  = 0
		core.gameRegistry["elixir_players"] = 0
		core.gameRegistry["elixir_war"] = 0
		core.gameRegistry["elixir_game_over"] = 0
		core.gameRegistry["elixir_red_point"] = 0
		core.gameRegistry["elixir_blue_point"] = 0
		core.gameRegistry["elixir_playing"] = 0

	
		if #pc > 0 then
			for i =	1, #pc do

				if pc[i].registry["elixir_team"] == core.gameRegistry["elixir_winner"] then
					elixir.victoryLegend(pc[i])
					pc[i]:leveledEXP("win_minigame")
				else pc[i]:leveledEXP("lose_minigame")
				end
				pc[i].registry["elixir_registered"] = 0
				pc[i].registry["elixir_flag"] = 0
				pc[i].registry["elixir_team"] = 0
				pc[i].registry["elixir_hit"] = 0
				pc[i].registry["elixir_arrows"] = 0
				
				pc[i].gfxDye = 0
				pc[i].gfxClone = 0
				pc[i]:updateState()
				pc[i]:calcStat()
				pc[i]:sendAnimation(16)
				pc[i]:playSound(29)
				pc[i]:warp(1031, math.random(13,17), math.random(4, 7))
				
				
			end
		end

		if #arenaPC > 0 then
			for i =	1, #arenaPC do
				arenaPC[i].gfxClone = 0
				arenaPC[i]:updateState()
			end
		end
		core.gameRegistry["elixir_winner"] = 0
	end
end,



stop = function()

	local pc = core:getObjectsInMap(15040, BL_PC)

	core.gameRegistry["elixir_end_timer"] = 0
	core.gameRegistry["elixir_winner"] = 0

	core.gameRegistry["elixir_players"] = 0
	core.gameRegistry["elixir_war"] = 0
	core.gameRegistry["elixir_game_over"] = 0
	core.gameRegistry["elixir_red_point"] = 0
	core.gameRegistry["elixir_blue_point"] = 0
	core.gameRegistry["elixir_playing"] = 0

	
	if #pc > 0 then
		for i = 1, #pc do
			pc[i].registry["elixir_registered"] = 0
			pc[i].registry["elixir_flag"] = 0
			pc[i].registry["elixir_team"] = 0
			pc[i].registry["elixir_hit"] = 0
			pc[i].registry["elixir_arrows"] = 0

			pc[i].gfxDye = 0
			pc[i].gfxClone = 0
			pc[i]:updateState()

			pc[i]:warp(1031, math.random(13,17), math.random(4, 7))
			pc[i]:sendAnimation(16)
			pc[i]:playSound(29)
		end
	end
end,

stopTest = function()

	local pc = core:getObjectsInMap(15040, BL_PC)

	core.gameRegistry["elixir_end_timer"] = 0
	core.gameRegistry["elixir_winner"] = 0

	core.gameRegistry["elixir_players"] = 0
	core.gameRegistry["elixir_war"] = 0
	core.gameRegistry["elixir_game_over"] = 0

	core.gameRegistry["elixir_red_point"] = 0
	core.gameRegistry["elixir_blue_point"] = 0
	core.gameRegistry["elixir_playing"] = 0

	
	if #pc > 0 then
		for i = 1, #pc do
			pc[i].registry["elixir_registered"] = 0
			pc[i].registry["elixir_flag"] = 0
			pc[i].registry["elixir_team"] = 0
			pc[i].registry["elixir_hit"] = 0
			pc[i].registry["elixir_arrows"] = 0
			pc[i].registry["elixir_burn_time"] = 0


			pc[i].gfxDye = 0
			pc[i].gfxClone = 0
			pc[i]:updateState()

			pc[i]:warp(1, 3, 4)
			pc[i]:sendAnimation(16)
			pc[i]:playSound(29)
		end
	end
end,

cancel = function()

	local pc = core:getObjectsInMap(15041, BL_PC)
	
	core.gameRegistry["elixir_end_timer"] = 0
	core.gameRegistry["elixir_winner"] = 0
	core.gameRegistry["elixir_players"] = 0
	core.gameRegistry["elixir_war"] = 0
	core.gameRegistry["elixir_game_over"] = 0
	core.gameRegistry["elixir_playing"] = 0

	
	if #pc > 0 then
		for i = 1, #pc do
			pc[i].registry["elixir_registered"] = 0
			pc[i].registry["elixir_flag"] = 0

			pc[i].registry["elixir_team"] = 0
			pc[i].registry["elixir_hit"] = 0
			pc[i].registry["elixir_arrows"] = 0
			pc[i].registry["elixir_burn_time"] = 0

			pc[i].gfxDye = 0
			pc[i].gfxClone = 0
			pc[i]:updateState()


			pc[i]:warp(1031, math.random(13,17), math.random(4, 7))
			pc[i]:sendAnimation(16)
			pc[i]:playSound(29)
		end
	end
end,

cancelTest = function()

	local pc = core:getObjectsInMap(15041, BL_PC)
	
	core.gameRegistry["elixir_end_timer"] = 0
	core.gameRegistry["elixir_winner"] = 0
	core.gameRegistry["elixir_players"] = 0
	core.gameRegistry["elixir_war"] = 0
	core.gameRegistry["elixir_game_over"] = 0
	core.gameRegistry["elixir_playing"] = 0

	
	if #pc > 0 then
		for i = 1, #pc do
			pc[i].registry["elixir_registered"] = 0
			pc[i].registry["elixir_flag"] = 0
			pc[i].registry["elixir_team"] = 0
			pc[i].registry["elixir_hit"] = 0
			pc[i].registry["elixir_arrows"] = 0
			pc[i].registry["elixir_burn_time"] = 0

			pc[i].gfxDye = 0
			pc[i].gfxClone = 0
			pc[i]:updateState()


			pc[i]:warp(1, 3, 4)
			pc[i]:sendAnimation(16)
			pc[i]:playSound(29)
		end
	end
end,

entryLegend = function(player)

	local reg = player.registry["elixir_war_entries"]

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
		player:addLegend("Won "..player.registry["elixir_war_wins"].." Elixir Wars", "elixir_war_wins", 69, 16)
	else
		player.registry["elixir_war_wins"] = 1
		player:addLegend("Won 1 Elixir War", "elixir_war_wins", 69, 16)
	end

	player:addMinigamePoint(player)

end,


nextRound = function()

	local pc = core:getObjectsInMap(15040, BL_PC)
	local time = 0	

	if core.gameRegistry["elixir_players"] >= 2 then
		core.gameRegistry["elixir_wait_time2"] = os.time() + 30
			time = math.abs(os.time() - core.gameRegistry["elixir_wait_time2"])
		if #pc > 0 then
			for i = 1, #pc do
				if pc[i].state == 3 then 
					pc[i].state = 0 
					pc[i].speed = 80
					pc[i].registry["mounted"] = 0
					pc[i]:updateState()

				end
				if pc[i].registry["elixir_team"] == 1 then
					elixir.costume(pc[i])
					pc[i]:warp(15040, 10, 2)
					
				elseif pc[i].registry["elixir_team"] == 2 then
					pc[i]:warp(15040, 22, 38)
				end
			
				pc[i].registry["elixir_flag"] = 0
				pc[i].registry["elixir_hit"] = 0
				pc[i].registry["elixir_burn_time"] = 0
				pc[i].registry["elixir_arrows"] = 0
				pc[i]:setTimer(2, time)

			end

			broadcast(15040, "-----------------------------------------------------------------------------------------------------")
			broadcast(15040, "                                    Get Ready! The next round starts in 30 seconds!")
			broadcast(15040, "-----------------------------------------------------------------------------------------------------")		
		end
	else
		--broadcast(-1, "-----------------------------------------------------------------------------------------------------")
		--broadcast(-1, "                             Not enough players. Elixir War cancelled!")
		--broadcast(-1, "-----------------------------------------------------------------------------------------------------")
		elixir.cancel()
	end


end,


start = function(npc)

	elixir.balancing(npc)
	local pc = core:getObjectsInMap(15041, BL_PC)
	if core.gameRegistry["elixir_players"] >= 2 then
		elixir.wait(core)
		if #pc > 0 then
			for i = 1, #pc do
				if pc[i].state == 3 then 
					pc[i].state = 0 
					pc[i].speed = 80
					pc[i].registry["mounted"] = 0
					pc[i]:updateState()
				end
				if pc[i].registry["elixir_team"] == 1 then
					pc[i]:warp(15040, 10, 2)
					elixir.costume(pc[i])
					
				elseif pc[i].registry["elixir_team"] == 2 then
					pc[i]:warp(15040, 22, 38)
					elixir.costume(pc[i])
				end
				pc[i].registry["elixir_arrows"] = 0

			end
		end
	else
		--broadcast(-1, "-----------------------------------------------------------------------------------------------------")
		--broadcast(-1, "                             Not enough players. Elixir War cancelled!")
		--broadcast(-1, "-----------------------------------------------------------------------------------------------------")
		elixir.cancel()
	end
		
end,

wait = function(npc)

	core.gameRegistry["elixir_wait_time"] = os.time() + 30
	broadcast(15040, "-----------------------------------------------------------------------------------------------------")
	broadcast(15040, "                                    Get Ready! Elixir War starts in 30 seconds!")
	broadcast(15040, "-----------------------------------------------------------------------------------------------------")



end,

begin = function(npc)

	local pc = core:getObjectsInMap(15040, BL_PC)

	if core.gameRegistry["elixir_wait_time"] > 0 and core.gameRegistry["elixir_wait_time"] < os.time() then
		if #pc >= 2 then
			broadcast(15040, "-----------------------------------------------------------------------------------------------------")
			broadcast(15040, "                                   The Elixir War has begun!")
			broadcast(15040, "-----------------------------------------------------------------------------------------------------")
			for i = 1, #pc do
				if pc[i].registry["elixir_team"] == 1 then
					pc[i]:warp(15040, 4, 9)
					elixir.entryLegend(pc[i])
				elseif pc[i].registry["elixir_team"] == 2 then
					pc[i]:warp(15040, 28, 31)
					elixir.entryLegend(pc[i])
				end
				pc[i].registry["elixir_flag"] = 0
				pc[i].registry["elixir_arrows"] = 22
				pc[i]:sendMinitext("You have 22 arrows")
			end
		else
			--broadcast(-1, "-----------------------------------------------------------------------------------------------------")
			--broadcast(-1, "                             Not enough players. Elixir War cancelled!")
			--broadcast(-1, "-----------------------------------------------------------------------------------------------------")
			elixir.stop()
		end
		core.gameRegistry["elixir_wait_time"] = 0
		core.gameRegistry["elixir_playing"] = 1
	end
end,

beginRoundTwo = function(npc)

	local pc = core:getObjectsInMap(15040, BL_PC)

	if core.gameRegistry["elixir_wait_time2"] > 0 and core.gameRegistry["elixir_wait_time2"] < os.time() then
		if #pc >= 2 then
			broadcast(15040, "-----------------------------------------------------------------------------------------------------")
			broadcast(15040, "                                   The Elixir War has begun!")
			broadcast(15040, "-----------------------------------------------------------------------------------------------------")
			for i = 1, #pc do
				if pc[i].registry["elixir_team"] == 1 then
					pc[i]:warp(15040, 4, 9)
				elseif pc[i].registry["elixir_team"] == 2 then
					pc[i]:warp(15040, 28, 31)
				end
				pc[i].registry["elixir_arrows"] = 22
				pc[i]:sendMinitext("You have 22 arrows")
			end
		else
			--broadcast(-1, "-----------------------------------------------------------------------------------------------------")
			--broadcast(-1, "                             Not enough players. Elixir War cancelled!")
			--broadcast(-1, "-----------------------------------------------------------------------------------------------------")
			elixir.stop()
		end
		core.gameRegistry["elixir_wait_time2"] = 0
		core.gameRegistry["elixir_playing"] = 1
	end
end,

balancing = function(npc)
	
	local red, blue = {}, {}
	local pc = npc:getObjectsInMap(15041, BL_PC)
	
	if #pc > 0 then
		for i = 1, #pc do
			if pc[i].registry["elixir_team"] == 1 then
				table.insert(red, pc[i].ID)
			elseif pc[i].registry["elixir_team"] == 2 then
				table.insert(blue, pc[i].ID)
			end
		end
	end
	if #pc > 0 then
		for i = 1, #pc do	
			if #red > #blue then
				if (#red-#blue) ~= 1 then pc[math.random(#pc)].registry["elixir_team"] = 2 break end
			end
			if #red < #blue then
				if #blue - #red ~= 1 then pc[math.random(#pc)].registry["elixir_team"] = 1 break end
			end
		end
	end
end,

costume = function(player)
	
	local team = player.registry["elixir_team"]
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
	player.attackSpeed = 90
	player:updateState()
end,

walk = function(player)
	
	local blueFlag = {18086}
	local redFlag = {37578}
	local tile = getTile(player.m, player.x, player.y)
	local pc = player:getObjectsInMap(15040, BL_PC)
	
	if player.m == 15040 and player.registry["elixir_team"] > 0 then
		player.registry["elixir_burn_time"] = 0
		if player.gfxDye == 2 or player.gfxDye == 4 then elixir.out(player) return end

	
		for i = 1, #blueFlag do
			if player.registry["elixir_team"] == 1 then
				if tile == blueFlag[i] then
					if player.registry["elixir_flag"] == 0 then
						if player.state == 1 then -- Minigame Bans for those trying the dead trick
								elixir.banPlayer(player)
								return
							end
						player:sendAction(2, 20)
						--player:sendAnimation(326)
						--player:playSound(505)
						player.registry["elixir_flag"] = 1
						player.gfxCape = 46
						player.gfxCapeC = 26
						player:updateState()
						
						
					end
				elseif tile == redFlag[i] then
					if core.gameRegistry["elixir_game_over"] == 0 then
						if player.registry["elixir_flag"] == 1 then						
		
		  					player.gfxCape = 65535
							player.gfxCapeC = 0
							player.registry["elixir_flag"] = 0
							core.gameRegistry["elixir_red_point"] = core.gameRegistry["elixir_red_point"] + 1
							--player:sendAnimation(349)
							--player:playSound(112)
							broadcast(15040, "                                       "..player.name.." has captured the Blue Team's flag!")
							broadcast(15040, "                                       [Red Team = "..core.gameRegistry["elixir_red_point"].."] VS [Blue Team = "..core.gameRegistry["elixir_blue_point"].."]")
							player:updateState()
							elixir.winnerCheck()
						else
							elixir.out(player)
						end
					end	
				end
				
			elseif player.registry["elixir_team"] == 2 then
				if tile == redFlag[i] then
					if player.registry["elixir_flag"] == 0 then
							if player.state == 1 then -- minigame bans for those trying the dead trick
								elixir.banPlayer(player)
								return
							end
						player:sendAction(2, 20)
						--player:sendAnimation(326)
						--player:playSound(505)	
						player.registry["elixir_flag"] = 1
						player.gfxCape = 46
						player.gfxCapeC = 22
						player:updateState()
						
						
					end
				elseif tile == blueFlag[i] then
					if core.gameRegistry["elixir_game_over"] == 0 then
						if player.registry["elixir_flag"] == 1 then
							player.gfxCape = 65535
							player.gfxCapeC = 0
							player.registry["elixir_flag"] = 0
							core.gameRegistry["elixir_blue_point"] = core.gameRegistry["elixir_blue_point"] + 1
							--player:sendAnimation(349)
							--player:playSound(112)
							broadcast(15040, "                                       "..player.name.." has captured the Red Team's flag!")
							broadcast(15040, "                                       [Red Team = "..core.gameRegistry["elixir_red_point"].."] VS [Blue Team = "..core.gameRegistry["elixir_blue_point"].."]")
							player:updateState()
							elixir.winnerCheck()
						else
							elixir.out(player)
						end
					end
				end
			end
		end
	end
end,

hit = function(player, target)
		
	if target.registry["elixir_hit"] == 1 then return else
		if player.registry["elixir_team"] == 1 then
			target.gfxDye = 2
		elseif player.registry["elixir_team"] == 2 then
			target.gfxDye = 4
		end
		target.registry["elixir_hit"] = 1
		target:updateState()
	end
end,

rescue = function(player, target)
	
	if target.registry["elixir_hit"] == 1 then 
		if player.registry["elixir_team"] == 1 then
			target.gfxDye = 31
		elseif player.registry["elixir_team"] == 2 then
			target.gfxDye = 17
		end
		target.registry["elixir_hit"] = 0
		target:updateState()
	end
end,

shoot = function(player)
	
	local team = player.registry["elixir_team"]
	local m, x, y, side = player.m, player.x, player.y, player.side
	local icon = side+6
	local pc
	
	if team > 0 then
		if player.m == 15040 and player.gfxClone == 1 then
			if player.registry["elixir_arrows"] > 0 then

				player:playSound(709)
				player:sendAction(1, 20)
				player.registry["elixir_arrows"] = player.registry["elixir_arrows"] - 1
				player:sendMinitext("Arrows remaining: "..player.registry["elixir_arrows"])
		
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
					if pc ~= nil and pc.registry["elixir_team"] > 0 then 
						if team == pc.registry["elixir_team"] then elixir.rescue(player, pc) else elixir.hit(player, pc) end
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

	player.registry["elixir_burn_time"] = 0
	player.registry["elixir_hit"] = 0
	player.registry["elixir_arrows"] = 0
	player.registry["elixir_flag"] = 0




	if player.registry["elixir_team"] == 1 then
		player.gfxDye = 31
		player:updateState()
		player:warp(15040, 9, 2)

	elseif player.registry["elixir_team"] == 2 then
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
		elixir.nextRound()
	end

end,

sideline = function(player)

	local timer = 0

	if core.gameRegistry["elixir_playing"] == 1 then
		player.registry["elixir_burn_time"] = player.registry["elixir_burn_time"] + 1
	end
	if player.registry["elixir_burn_time"] == 30 then player:sendMinitext("You will be sidelined if you don't move in 30 seconds!") end
	for i = 1, 10 do
		timer = i
		if player.registry["elixir_burn_time"] == 60 - timer then
			player:sendMinitext("You will be sidelined if you don't move in "..timer.." seconds!") 
		end
	end
	if player.registry["elixir_burn_time"] >= 60 then player:sendMinitext("You have been sidelined for standing still!") elixir.out(player) end

end
}
