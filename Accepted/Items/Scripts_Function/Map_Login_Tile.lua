
--------------------- Login -----------------------------------

login = function(player)
	
	local m = player.m
	local adate = os.date("%A, %d %B %Y - %H:%M:%S")
	local curTotemTime = get_totem_time(player)	
	local logincount = player.registry["login_count"]
	local friends = player:getFriends()
	local staff = {2, 4}
	local pc = player:getUsers()
	local x, y = 0, 0
	local serverResetTimer = core.gameRegistry["server_reset_timer"] 
	local offlineTime = os.time() - player.registry["last_logout"]
	local bannedIPs = {"184.60.140.159", "184.91.39.230"}
	local usersInMap = {}
	local buggedUsers = {}
	
	if player:hasSpell("coup_de_grace") then	--added 5-24-17, people had both spells due to error
		if player:hasSpell("pierce_vitals") then
			player:removeSpell("pierce_vitals")
		end
	end


	if (player.class == 3 or player.class == 8 or player.class == 13 or player.class == 18) then
		wizardSpellCheck(player)
	end

	if (player.registry["one-time_beta_mount_box"] == 0 and player.level >= 25) then
		player:addItem(303001, 1)
		player:popUp("You've been rewarded a one-time beta mount box for appreciation. We appreciate all players here in MornaTK.")
		player.registry["one-time_beta_mount_box"] = 1
	end






	
	if player.registry["combat_update2_respec"] == 0 then
		spend_sp.respec(player)
		player.registry["combat_update2_respec"] = 1
		player.registry["combat_update1_respec"] = 0
	end
	
	--if player.registry["gold_reimburse"] < 2 and player.level >= 5 and player.ID < 1100 then
	--	newServerGoldReimburse(player)	
	--end

--[[	
	for i = 1, #buggedUsers do
		if player.ID == buggedUsers[i] then
			spend_sp.respec(player)
		end
	end
]]--	
	player.registry["session_start_time"] = os.time() --added 8-7-16 for /played

	if serverResetTimer > os.time() then
		time = math.abs(os.time() - serverResetTimer)
		player:setTimer(2, time)
	end

	if player.m == 15010 then
		if core.gameRegistry["freeze_war_started"] == 0 then
			player.registry["freeze_war_registered"] = 0
			player.registry["freeze_war_team"] = 0
			player.registry["freeze_war_flag"] = 0
			player:warp(1031, math.random(13,17), math.random(4, 7))
		end
	end
	if player.m == 15020 then
		if core.gameRegistry["beach_war_started"] == 0 then
			player.registry["beach_war_flag"] = 0
			player.registry["beach_war_kills"] = 0
			player.registry["beach_war_times_hit"] = 0
			player.registry["beach_war_gun_pct"] = 0
			player.registry["beach_war_registered"] = 0
			player.registry["beach_war_team"] = 0
			player:warp(1031, math.random(13,17), math.random(4, 7))
		end
	end
	if player.m == 15030 then
		if core.gameRegistry["sumo_war_playing"] == 0 then
			player.registry["sumo_war_registered"] = 0
			player.registry["sumo_war_team"] = 0
			player:warp(1031, math.random(13,17), math.random(4, 7))
		end
	end	
	if player.m == 15040 then
		if core.gameRegistry["elixir_playing"] == 0 then
			player.registry["elixir_registered"] = 0
			player.registry["elixir_flag"] = 0
			player.registry["elixir_team"] = 0
			player.registry["elixir_hit"] = 0
			player.registry["elixir_arrows"] = 0
			player:warp(1031, math.random(13,17), math.random(4, 7))
		end
	end
	if player.m == 15050 then
		player.registry["bomber_war_registered"] = 0
		player.registry["bomber_war_team"] = 0
		player.registry["speed_boost"] = 0
		player.registry["bomb_max"] = 0
		player.registry["bomb_distance"] = 0
		player:warp(1031, math.random(13,17), math.random(4, 7))
	end
	if player.m == 15101 then
		core.mapRegistry["player_count"] = core.mapRegistry["player_count"] + 1
	end
	
	if player.gmLevel > 0 then
		player.registry["use_gm_command"] = 1
	end
	
	player.enchant = 1
	player.gfxClone = 0
	player.faceAccessoryTwoColor = player.registry["face_accessory_two_color"]
	
	if player.registry["team"] > 0 then player.registry["team"] = 0 end
	if player:hasDuration("vending_menu") then player:setDuration("vending_menu", 0) end
	if player.state == 3 then player.state = 0 end
	player.registry["mounted"] = 0
	
	if player.registry["first_login"] == 0 then
		player.basemight = player.basemight + 1
		player.basegrace = player.basegrace + 1
		player.basewill = player.basewill + 1
		player.registry["show_helmet"] = 0
		player.registry["show_necklace"] = 0
		player.country = 0
		player:calcStat()
		player:sendStatus()
		final_moment.firstLogin(player)
	end

	player:calcStat()
	player:sendStatus()
	player:updateState()
	player:msg(4, "[System]: "..adate, player.ID)

	if (player.m <= 50 or player.m >= 52) and player.m ~= 1035 and player.m ~= 666 then
		if offlineTime >= 1800 then 
			if player.ID > 249 and player.ID ~=1723 then 
				player:warp(1018, math.random(9,14), math.random(3,7)) 
			end
		end
	end

	for i = 1, #pc do
		if pc[i].gmLevel > 0 then
			if pc[i].ID ~= player.ID then
				pc[i]:msg(4, "[LOGIN]: "..player.name.." has logged in ~ @"..player.mapTitle.."("..player.m..") | IP: "..player.ipaddress, pc[i].ID)
			end
		end
	end

--	if logincount > 0 then
--		logincount = logincount + 1
--		if player:staff() == true then
--		else
--			if #friends > 0 then
--				for i = 1, #friends do
--					player:msg(4, "[FRIEND]: "..player.name.." has logged in.", friends[i].ID)
--				end
--			end
--		end
--		player.registry["login_count"] = logincount
--	end

	if (player.gmLevel < 50) then
		if (player:staff() == true) then
		else
			local friends = player:getFriends()
			if (#friends > 0) then
				for i = 1, #friends do
					player:msg(4, "[FRIEND]: "..player.name.." has logged in.", friends[i].ID)
				end
			end
		end
	end

	if player.m > 5 then
		if player.level >= 5 then login_rewards.click(player, NPC("Login Rewards")) end
	end
	
	if player.health == 0 then player.state = 1 player:updateState() end

--[[
	if player.gmLevel > 0 then
		if player.registry["use_gm_command"] == 0 then
			player:freeAsync()
			gm_security.login(player, NPC(66))
		end
	end
	
	if (player.gmLevel > 50) then
		player:speak("/online",0)
		player:speak("/stealth",0)--Disabling stealth on login for now.
	end
]]--



	if (player.actId == 0 and player.level ~= 1) then
		player:popUp("Your character is unregistered/unactivated. You must resolve this issue to progress past level 5 or to sell EXP for stats. This can be resolved with the F1 menu -> Activate option.")
	end





	
	

	------------- PRIMO ACTIVE------------------
	if player.clan ~= 0 and getClanRank(player.name) == 5 then -- PRIMOGEN LOGINS
		core.gameRegistry["clan"..player.clan.."primo_active"] = os.date("%j")
	end
	------------- PRIMO ACTIVE END--------------

	player.clan = getPlayerClan(player.name)
	player.clanTitle = getClanTitle(player.name)
	player:updateState()


	
end


-- Logout -------------------------------------------------------------------------------


logout = function(player)
	
	local req = player.registry["summon_pet"]
	local staff = {2, 3, 4, 5, 6}
	local pc = player:getUsers()
	local mapPC = player:getObjectsInMap(player.m, BL_PC)
	local usersInMap = {}
	
	if player.m >= 60000 then
		player:warp(1018, math.random(9,14), math.random(3,7))
	end
	player.registry["session_end_time"] = os.time() --added 8-7-16 for /played, keeps causing crashes
	player.registry["session_total_time"] = os.time() - player.registry["session_start_time"] --added 8-7-16 for /played, keeps causing crashes
	player.registry["total_time_played"] = player.registry["total_time_played"] + player.registry["session_total_time"] --added 8-7-16 for /played
	player.registry["last_logout"] = os.time()
	player.registry["session_start_time"] = 0 --added 8-7-16 for /played
	player.registry["session_end_time"] = 0 --added 8-7-16 for /played
	player.registry["session_total_time"] = 0 --added 8-7-16 for /played
	player.registry["use_gm_command"] = 0

	
--	for i = 1, #staff do
--		if Player(staff[i]) ~= nil then
--			player:msg(4, "[LOGOUT]: "..player.name.." has logged out", Player(staff[i]).ID)	
--		end
--	end
	
	player.gfxClone = 0
	player.registry["summoned_mount"] = 0
	snoop.clear(player)
	
-- Gm's	
	player.registry["alter_stats_target"] = 0
	player.registry["red_script"] = 0
	player.registry["blue_script"] = 0
	player.registry["green_script"] = 0
	
	if player:hasDuration("assassin_choice_timer") then
		player:flushDuration(616, 616)
	end
	
	if player.m == 15101 then
		core.mapRegistry["player_count"] = core.mapRegistry["player_count"] - 1
	end
	
	if Mob(req) ~= nil then Mob(req):removeHealth(Mob(req).health) end
	if player.gfxClone == 1 then player.gfxClone = 0 end
	
	
	for i = 1, #pc do
		if pc[i].gmLevel > 0 then
			if pc[i].ID ~= player.ID then
				pc[i]:msg(4, "[LOGOUT]: "..player.name.." has logged out.", pc[i].ID)
			end
		end
	end	
	
	
	if (player.gmLevel < 50) then
		if (player:staff() == true) then
		else
			local friends = player:getFriends()
			if (#friends > 0) then
				for i = 1, #friends do
					player:msg(4, "[FRIEND]: "..player.name.." has logged out.", friends[i].ID)
				end
			end
		end
	end

---------------CLAN STUFF DO NOT DELETE-----------------------------------------------
	------------- PRIMO ACTIVE------------------
	if player.clan ~= 0 and getClanRank(player.name) == 5 then -- PRIMOGEN LOGINS
		core.gameRegistry["clan"..player.clan.."primo_active"] = os.date("%j")
	end
	------------- PRIMO ACTIVE END--------------

	player.clan = getPlayerClan(player.name)
	player.clanTitle = getClanTitle(player.name)
	player:updateState()

---------------------------------------------------------------------------------------



end


-- Map Weather -------------------------------------------------------------------------------


mapWeather = function()

	local x, weather
	weather = math.random(1,5)
	if(math.random(4) == 2) then
		if(weather > 3 and weather < 5 and getCurSeason() == "Spring") then
			setWeather(0,0,0)
		elseif(weather >= 2 and weather < 4 and getCurSeason() == "Summer") then
			setWeather(0,0,0)
		elseif(weather == 4 and getCurSeason() == "Fall") then
			setWeather(0,0,0)
		elseif(weather > 3 and getCurSeason() == "Winter") then
			setWeather(0,0,0)
		elseif(weather <= 3 and weather > 1 and getCurSeason() == "Spring") then
			setWeather(0,0,1)
		elseif(weather == 1 and getCurSeason() == "Summer") then
			setWeather(0,0,1)
		elseif(weather >= 2 and weather < 4 and getCurSeason() == "Fall") then
			setWeather(0,0,1)
		elseif(weather == 1 and (getCurSeason() == "Spring" or getCurSeason() == "Fall")) then
			setWeather(0,0,2)
		elseif(weather <= 3 and getCurSeason() == "Winter") then
			setWeather(0,0,2)
		elseif(weather == 5 and getCurSeason() == "Spring") then
			setWeather(0,0,3)
		elseif(weather >= 4 and getCurSeason() == "Summer") then
			setWeather(0,0,3)
		elseif(weather == 5 and getCurSeason() == "Fall") then
			setWeather(0,0,3)
		else
			setWeather(0,0,getWeather(0,0))
		end
	else
		setWeather(0,0,getWeather(0,0))
	end
end


-- Map Light --------------------------------------------------------------------------------

mapLight = function()

    local mlight = 0
    local ctime = curTime()
	
    if (ctime < 1) then
        mlight = 14
    elseif (ctime < 2) then
        mlight = 15
    elseif (ctime < 3) then
        mlight = 16
    elseif (ctime < 4) then
        mlight = 17
    elseif (ctime < 5) then
        mlight = 18
    elseif (ctime < 6) then
        mlight = 19
    elseif (ctime < 7) then
        mlight = 20
    elseif (ctime < 8) then
        mlight = 21
    elseif (ctime < 9) then
        mlight = 22
    elseif (ctime < 10) then
        mlight = 23
    elseif (ctime >= 10 and ctime < 14) then
        mlight = 24
    elseif (ctime < 15) then
        mlight = 23
    elseif (ctime < 16) then
        mlight = 22
    elseif (ctime < 17) then
        mlight = 21
    elseif (ctime < 18) then
        mlight = 20
    elseif (ctime < 19) then
        mlight = 19
    elseif (ctime < 20) then
        mlight = 18
    elseif (ctime < 21) then
        mlight = 17
    elseif (ctime < 22) then
        mlight = 16
    elseif (ctime < 23) then
        mlight = 15
    elseif (ctime < 24) then
        mlight = 14
    end
	
	if core.gameRegistry["divine_light"] == 1 then
		mlight = mlight + 2
	end
    
    --function setLight(region,indoor,lightnumber)
    --setLight(0, 0, mlight)--region 0
    setLight(1, 0, mlight)--region 1, Hon
    setLight(2, 0, mlight)--region 2, woods north of Hon
    setLight(3, 0, mlight)--region 3, Lortz
    setLight(4, 0, mlight)--region 4, Cathay	
    --mornaLight()
end


-------------- Entering Map -------------------------------------------------------------

mapEnter = function(player)

	local pc = core:getUsers()
	local m = player.m
	
	if m == 51 then
		player:setDuration("final_moment", 5000)
		player:setDuration("stun", 10000)
	elseif m == 52 then
		if player.ID > 249 and player.level == 1 then
			for i = 1, #pc do
				pc[i]:msg(4, "[NEW PLAYER]: Another soul has reached their final judgement.", pc[i].ID)
			end
		end
	elseif m == 3103 then
		player:updateState()
	elseif m == 3015 then
		player:updateState()
	
	elseif m == 15010 then
	--	if core.gameRegistry["bomb_game_nextround_timer"] > os.time() then
	--		time = math.abs(os.time() - core.gameRegistry["bomb_game_nextround_timer"])
	--		player:setTimer(2, time)
	--	end
	elseif m == 15011 then
		if core.gameRegistry["bomb_game_start"] > os.time() then
			time = math.abs(os.time() - core.gameRegistry["bomb_game_start"])
			player:setTimer(2, time)
		end
	--	if core.gameRegistry["bomb_game_wait_time"] > os.time() then
	--		time = math.abs(os.time() - core.gameRegistry["bomb_game_wait_time"])
	--		player:setTimer(2, time)
	--	end
	elseif m == 15000 then
		if core.gameRegistry["ctf_wait_time"] > os.time() then
			time = math.abs(os.time() - core.gameRegistry["ctf_wait_time"])
			player:setTimer(2, time)
		end
	elseif m == 15001 then
		if core.gameRegistry["ctf_start"] > os.time() then
			time = math.abs(os.time() - core.gameRegistry["ctf_start"])
			player:setTimer(2, time)
		end

	elseif m == 15020 then
		if core.gameRegistry["squirt_wait_time"] > os.time() then
			time = math.abs(os.time() - core.gameRegistry["squirt_wait_time"])
			player:setTimer(2, time)
		end

	elseif m == 15021 then
		if core.gameRegistry["squirt_start"] > os.time() then
			time = math.abs(os.time() - core.gameRegistry["squirt_start"])
			player:setTimer(2, time)
		end
	elseif m == 15030 then
		if core.gameRegistry["sumo_war_wait_time"] > os.time() then
			time = math.abs(os.time() - core.gameRegistry["sumo_war_wait_time"])
			player:setTimer(2, time)

		end

	elseif m == 15031 then
		if core.gameRegistry["sumo_war_start"] > os.time() then
			time = math.abs(os.time() - core.gameRegistry["sumo_war_start"])
			player:setTimer(2, time)
		end

	elseif m == 15040 then
		if core.gameRegistry["elixir_wait_time"] > os.time() then
			time = math.abs(os.time() - core.gameRegistry["elixir_wait_time"])
			player:setTimer(2, time)

		end

	elseif m == 15041 then
		if core.gameRegistry["elixir_start"] > os.time() then
			time = math.abs(os.time() - core.gameRegistry["elixir_start"])
			player:setTimer(2, time)
		end

	elseif m == 15050 then
		if core.gameRegistry["bomber_war_wait_time"] > os.time() then
			time = math.abs(os.time() - core.gameRegistry["bomber_war_wait_time"])
			player:setTimer(2, time)
		end

	elseif m == 15051 then
		if core.gameRegistry["bomber_war_start"] > os.time() then
			time = math.abs(os.time() - core.gameRegistry["bomber_war_start"])
			player:setTimer(2, time)
		end
		
	elseif m == 15100 then
		player.PK = 1
		player:refresh()
	elseif m == 15101 then
		core.mapRegistry["player_count"] = core.mapRegistry["player_count"] + 1


	elseif (m >= 60000) then
		doInstanceSpawns(player)
	end
	
	if m < 4152 or (m > 4185 and m < 60000) then
		ice_palace_keys.melt(player)
	end


	player.clan = getPlayerClan(player.name)
	player.clanTitle = getClanTitle(player.name)
	player:updateState()

	clanTrialMapLoad(player) -- added to facilitate a perspective clan enduring its clan trials on specific maps




end

---------------- Leaving Map  -----------------------------------------------------------------

mapLeave = function(player)
	
	local pc = player:getUsers()
	local mob = player:getObjectsInMap(player.m, BL_MOB)
	local mapPC = player:getObjectsInMap(player.m, BL_PC)
	local usersInMap = {}

	if player.m == 15040 then
		player.registry["elixir_war_registered"] = 0
		player.registry["elixir_war_flag"] = 0
		player.registry["elixir_war_team"] = 0
		player.registry["elixir_war_hit"] = 0
		player.registry["elixir_war_arrows"] = 0
		player.registry["elixir_war_burn_time"] = 0
		player.gfxClone = 0
		player:updateState()
		elixir_war.winnerCheck()
	elseif player.m == 15101 then
		player.PK = 0
		player.gfxClone = 0
		player:refresh()
	end

	if player.m == 1018 then
		player.state = 0
		player.gfxClone = 0
		if player.registry["mounted"] == 1 then
			player.speed = 80
			player.registry["mounted"] = 0
		end
		player:updateState()
	end
	


	if player.clan ~= getPlayerClan(player.name) then
		player.clan = getPlayerClan(player.name)
		player:updateState()
	end





end

------------- on Scripted Tile ----------------------------------------------------------------

onScriptedTile = function(player)

	onWalk(player)
end
