--utility script
--http://lua-users.org/wiki/FormattingNumbers

--------------------------------------------------------------------------------------------------------
local gameClock = os.clock

function capitalizeFirst(str)
	return (str:gsub("^%l", string.upper))
end

function sleep(seconds)
	local start = os.time()
	repeat
	until os.time() > start + seconds
end

function sleep2(seconds) -- seconds
	local startTime = gameClock()
	while gameClock() - startTime <= seconds do
	end
end

function sleep1(seconds)
	local endTime = os.time() + seconds
	repeat
	until os.time() >= endTime
end

function round(num, idp)
	local mult = 10 ^ (idp or 0)
	return math.floor(num * mult + 0.5) / mult
end

function format_number(amount)
	local formatted = amount

	while true do
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", "%1,%2")
		if k == 0 then
			break
		end
	end

	return formatted
end

--------------------------------------------------------------------------------------------------------

numTimerValues = function(num)
	local hour, minute, second = 0, 0, 0

	hour = string.format("%02.f", math.floor(num / 3600))
	minute = string.format("%02.f", math.floor(num / 60 - (hour * 60)))
	second = string.format("%02.f", math.floor(num - hour * 3600 - minute * 60))

	return hour .. ":" .. minute .. ":" .. second
end

getTimerValues = function(registry)
	local hour, minute, second = 0, 0, 0

	if core.gameRegistry[registry] < os.time() then
		return "00:00:00"
	else
		dif = core.gameRegistry[registry] - os.time()
		hour = string.format("%02.f", math.floor(dif / 3600))

		minute = string.format("%02.f", math.floor(dif / 60 - (hour * 60)))

		second = string.format("%02.f", math.floor(dif - hour * 3600 - minute * 60))

		return hour .. ":" .. minute .. ":" .. second
	end
end

playerTimerValues = function(player, registry)
	local hour, minute, second = 0, 0, 0

	if player.registry[registry] > os.time() then
		return "00:00:00"
	else
		dif = os.time() - player.registry[registry]
		hour = string.format("%02.f", math.floor(dif / 3600))

		minute = string.format("%02.f", math.floor(dif / 60 - (hour * 60)))

		second = string.format("%02.f", math.floor(dif - hour * 3600 - minute * 60))

		return hour .. ":" .. minute .. ":" .. second
	end
end

staff = function(player)
	for i = 1, 20 do
		if player.gameRegistry["morna" .. i] == player.ID then
			return true
		else
			return false
		end
	end
end

--------------------------------------------------------------------------------------------------------
function get_totem_time(player)
	local totems = {"JuJak", "Baekho", "Hyun Moo", "Chung Ryong"} --
	local curTotem = ""
	local time = curTime()
	local curTotemID = 0

	if (time <= 0) then
		curTotemID = 3
	elseif (time <= 3) then
		curTotemID = 2
	elseif (time <= 6) then
		curTotemID = 1
	elseif (time <= 9) then
		curTotemID = 0
	elseif (time <= 12) then
		curTotemID = 3
	elseif (time <= 15) then
		curTotemID = 2
	elseif (time <= 18) then
		curTotemID = 1
	elseif (time <= 21) then
		curTotemID = 0
	end

	player.gameRegistry["current_totem_time"] = curTotemID

	return totems[curTotemID + 1]
end

-------------------------------------------------------------------------------------------------------

function getPathName(player)
	local pathName = player.className
	 --

	--[[if player.class == 0 then
			pathName = "Peasant"
		elseif player.class == 1 then
			pathName = "Fighter"
		elseif player.class == 2 then
			pathName = "Scoundrel"
		elseif player.class == 3 then
			pathName = "Wizard"
		elseif player.class == 4 then
			pathName = "Priest"
		elseif player.class == 31 then
			pathName = "Fighter"
		elseif player.class == 32 then
			pathName = "Scoundrel"
		elseif player.class == 33 then
			pathName = "Wizard"
		elseif player.class == 34 then
			pathName = "Priest"
		elseif player.class == 36 then
			pathName = "Squire"
		elseif player.class == 37 then
			pathName = "Buccaneer"
		elseif player.class == 38 then
			pathName = "Magus"
		elseif player.class == 39 then
			pathName = "Zealot"
		elseif player.class == 41 then
			pathName = "Ronin"
		elseif player.class == 42 then
			pathName = "Thug"
		elseif player.class == 43 then
			pathName = "Enchanter"
		elseif player.class == 44 then
			pathName = "Pastor"
		elseif player.class == 46 then
			pathName = "Knave"
		elseif player.class == 47 then
			pathName = "Killer"
		elseif player.class == 48 then
			pathName = "Occultist"
		elseif player.class == 49 then
			pathName = "Devotee"
		elseif player.class == 51 then
			pathName = "Knight"
		elseif player.class == 52 then
			pathName = "Pirate"
		elseif player.class == 53 then
			pathName = "Warlock"
		elseif player.class == 54 then
			pathName = "Inquisitor"
		elseif player.class == 56 then
			pathName = "Samurai"
		elseif player.class == 57 then
			pathName = "Sellsword"
		elseif player.class == 58 then
			pathName = "Shaman"
		elseif player.class == 59 then
			pathName = "Cleric"
		elseif player.class == 61 then
			pathName = "Dark Knight"
		elseif player.class == 62 then
			pathName = "Hitman"
		elseif player.class == 63 then
			pathName = "Diabolist"
		elseif player.class == 64 then
			pathName = "Fanatic"
		elseif player.class == 66 then
			pathName = "Paladin"
		elseif player.class == 67 then
			pathName = "Swashbuckler"
		elseif player.class == 68 then
			pathName = "Sorcerer"
		elseif player.class == 69 then
			pathName = "Crusader"
		elseif player.class == 71 then
			pathName = "Daimyo"
		elseif player.class == 72 then
			pathName = "Mercenary"
		elseif player.class == 73 then
			pathName = "Elementalist"
		elseif player.class == 74 then
			pathName = "Bishop"
		elseif player.class == 76 then
			pathName = "Blackguard"
		elseif player.class == 77 then
			pathName = "Assassin"
		elseif player.class == 78 then
			pathName = "Necromancer"
		elseif player.class == 79 then
			pathName = "Fallen"
		elseif player.baseClass == 5 then
			pathName = "GM"
		end]] return pathName
end

getTotalTNL = function(level)
	local totalTNL = 0
	if level == 1 then
		totalTNL = 2500
	end
	if level == 2 then
		totalTNL = 2500
	end
	if level == 3 then
		totalTNL = 2500
	end
	if level == 4 then
		totalTNL = 1500
	end
	if level == 5 then
		totalTNL = 125
	end
	if level == 6 then
		totalTNL = 225
	end
	if level == 7 then
		totalTNL = 306
	end
	if level == 8 then
		totalTNL = 400
	end
	if level == 9 then
		totalTNL = 506
	end
	if level == 10 then
		totalTNL = 1875
	end
	if level == 11 then
		totalTNL = 2269
	end
	if level == 12 then
		totalTNL = 2700
	end
	if level == 13 then
		totalTNL = 3169
	end
	if level == 14 then
		totalTNL = 3675
	end
	if level == 15 then
		totalTNL = 4219
	end
	if level == 16 then
		totalTNL = 4800
	end
	if level == 17 then
		totalTNL = 5419
	end
	if level == 18 then
		totalTNL = 6075
	end
	if level == 19 then
		totalTNL = 6769
	end
	if level == 20 then
		totalTNL = 20000
	end
	if level == 21 then
		totalTNL = 22050
	end
	if level == 22 then
		totalTNL = 24200
	end
	if level == 23 then
		totalTNL = 26450
	end
	if level == 24 then
		totalTNL = 28800
	end
	if level == 25 then
		totalTNL = 166667
	end
	if level == 26 then
		totalTNL = 172917
	end
	if level == 27 then
		totalTNL = 179167
	end
	if level == 28 then
		totalTNL = 185417
	end
	if level == 29 then
		totalTNL = 191667
	end
	if level == 30 then
		totalTNL = 333333
	end
	if level == 31 then
		totalTNL = 354167
	end
	if level == 32 then
		totalTNL = 375000
	end
	if level == 33 then
		totalTNL = 395833
	end
	if level == 34 then
		totalTNL = 416667
	end
	if level == 35 then
		totalTNL = 583333
	end
	if level == 36 then
		totalTNL = 620000
	end
	if level == 37 then
		totalTNL = 750000
	end
	if level == 38 then
		totalTNL = 840000
	end
	if level == 39 then
		totalTNL = 900000
	end
	if level == 40 then
		totalTNL = 1000000
	end
	if level == 41 then
		totalTNL = 1050000
	end
	if level == 42 then
		totalTNL = 1100000
	end
	if level == 43 then
		totalTNL = 1150000
	end
	if level == 44 then
		totalTNL = 1200000
	end
	if level == 45 then
		totalTNL = 1250000
	end
	if level == 46 then
		totalTNL = 1400000
	end
	if level == 47 then
		totalTNL = 1500000
	end
	if level == 48 then
		totalTNL = 1600000
	end
	if level == 49 then
		totalTNL = 1700000
	end
	if level == 50 then
		totalTNL = 1833333
	end
	if level == 51 then
		totalTNL = 2100000
	end
	if level == 52 then
		totalTNL = 2300000
	end
	if level == 53 then
		totalTNL = 2500000
	end
	if level == 54 then
		totalTNL = 2700000
	end
	if level == 55 then
		totalTNL = 2916667
	end
	if level == 56 then
		totalTNL = 3000000
	end
	if level == 57 then
		totalTNL = 3050000
	end
	if level == 58 then
		totalTNL = 3100000
	end
	if level == 59 then
		totalTNL = 3200000
	end
	if level == 60 then
		totalTNL = 3500000
	end
	if level == 61 then
		totalTNL = 3700000
	end
	if level == 62 then
		totalTNL = 3900000
	end
	if level == 63 then
		totalTNL = 4100000
	end
	if level == 64 then
		totalTNL = 4300000
	end
	if level == 65 then
		totalTNL = 4583333
	end
	if level == 66 then
		totalTNL = 4800000
	end
	if level == 67 then
		totalTNL = 5200000
	end
	if level == 68 then
		totalTNL = 5600000
	end
	if level == 69 then
		totalTNL = 5800000
	end
	if level == 70 then
		totalTNL = 6250000
	end
	if level == 71 then
		totalTNL = 6600000
	end
	if level == 72 then
		totalTNL = 7500000
	end
	if level == 73 then
		totalTNL = 8500000
	end
	if level == 74 then
		totalTNL = 10000000
	end
	if level == 75 then
		totalTNL = 25000000
	end
	if level == 76 then
		totalTNL = 30000000
	end
	if level == 77 then
		totalTNL = 35000000
	end
	if level == 78 then
		totalTNL = 40000000
	end
	if level == 79 then
		totalTNL = 50000000
	end
	if level == 80 then
		totalTNL = 65000000
	end
	if level == 81 then
		totalTNL = 75000000
	end
	if level == 82 then
		totalTNL = 85000000
	end
	if level == 83 then
		totalTNL = 100000000
	end
	if level == 84 then
		totalTNL = 110000000
	end
	if level == 85 then
		totalTNL = 120000000
	end
	if level == 86 then
		totalTNL = 130000000
	end
	if level == 87 then
		totalTNL = 140000000
	end
	if level == 88 then
		totalTNL = 150000000
	end
	if level == 89 then
		totalTNL = 160000000
	end
	if level == 90 then
		totalTNL = 200000000
	end
	if level == 91 then
		totalTNL = 210000000
	end
	if level == 92 then
		totalTNL = 220000000
	end
	if level == 93 then
		totalTNL = 230000000
	end
	if level == 94 then
		totalTNL = 240000000
	end
	if level == 95 then
		totalTNL = 300000000
	end
	if level == 96 then
		totalTNL = 310000000
	end
	if level == 97 then
		totalTNL = 320000000
	end
	if level == 98 then
		totalTNL = 330000000
	end
	return totalTNL
end

getTotalEXP = function(level)
	local totalEXP = 0

	if level == 1 then
		totalEXP = 0
	end
	if level == 2 then
		totalEXP = 2500
	end
	if level == 3 then
		totalEXP = 5000
	end
	if level == 4 then
		totalEXP = 7500
	end
	if level == 5 then
		totalEXP = 9000
	end
	if level == 6 then
		totalEXP = 9125
	end
	if level == 7 then
		totalEXP = 9350
	end
	if level == 8 then
		totalEXP = 9656
	end
	if level == 9 then
		totalEXP = 10056
	end
	if level == 10 then
		totalEXP = 10562
	end
	if level == 11 then
		totalEXP = 12437
	end
	if level == 12 then
		totalEXP = 14706
	end
	if level == 13 then
		totalEXP = 17406
	end
	if level == 14 then
		totalEXP = 20575
	end
	if level == 15 then
		totalEXP = 24250
	end
	if level == 16 then
		totalEXP = 28469
	end
	if level == 17 then
		totalEXP = 33269
	end
	if level == 18 then
		totalEXP = 38688
	end
	if level == 19 then
		totalEXP = 44763
	end
	if level == 20 then
		totalEXP = 51532
	end
	if level == 21 then
		totalEXP = 71532
	end
	if level == 22 then
		totalEXP = 93582
	end
	if level == 23 then
		totalEXP = 117782
	end
	if level == 24 then
		totalEXP = 144232
	end
	if level == 25 then
		totalEXP = 173032
	end
	if level == 26 then
		totalEXP = 339699
	end
	if level == 27 then
		totalEXP = 512616
	end
	if level == 28 then
		totalEXP = 691783
	end
	if level == 29 then
		totalEXP = 877200
	end
	if level == 30 then
		totalEXP = 1068867
	end
	if level == 31 then
		totalEXP = 1402200
	end
	if level == 32 then
		totalEXP = 1756367
	end
	if level == 33 then
		totalEXP = 2131367
	end
	if level == 34 then
		totalEXP = 2527200
	end
	if level == 35 then
		totalEXP = 2943867
	end
	if level == 36 then
		totalEXP = 3527200
	end
	if level == 37 then
		totalEXP = 4147200
	end
	if level == 38 then
		totalEXP = 4897200
	end
	if level == 39 then
		totalEXP = 5737200
	end
	if level == 40 then
		totalEXP = 6637200
	end
	if level == 41 then
		totalEXP = 7637200
	end
	if level == 42 then
		totalEXP = 8687200
	end
	if level == 43 then
		totalEXP = 9787200
	end
	if level == 44 then
		totalEXP = 10937200
	end
	if level == 45 then
		totalEXP = 12137200
	end
	if level == 46 then
		totalEXP = 13387200
	end
	if level == 47 then
		totalEXP = 14787200
	end
	if level == 48 then
		totalEXP = 16287200
	end
	if level == 49 then
		totalEXP = 17887200
	end
	if level == 50 then
		totalEXP = 19587200
	end
	if level == 51 then
		totalEXP = 21420533
	end
	if level == 52 then
		totalEXP = 23520533
	end
	if level == 53 then
		totalEXP = 25820533
	end
	if level == 54 then
		totalEXP = 28320533
	end
	if level == 55 then
		totalEXP = 31020533
	end
	if level == 56 then
		totalEXP = 33937200
	end
	if level == 57 then
		totalEXP = 36937200
	end
	if level == 58 then
		totalEXP = 39987200
	end
	if level == 59 then
		totalEXP = 43087200
	end
	if level == 60 then
		totalEXP = 46287200
	end
	if level == 61 then
		totalEXP = 49787200
	end
	if level == 62 then
		totalEXP = 53487200
	end
	if level == 63 then
		totalEXP = 57387200
	end
	if level == 64 then
		totalEXP = 61487200
	end
	if level == 65 then
		totalEXP = 65787200
	end
	if level == 66 then
		totalEXP = 70370533
	end
	if level == 67 then
		totalEXP = 75170533
	end
	if level == 68 then
		totalEXP = 80370533
	end
	if level == 69 then
		totalEXP = 85970533
	end
	if level == 70 then
		totalEXP = 91770533
	end
	if level == 71 then
		totalEXP = 98020533
	end
	if level == 72 then
		totalEXP = 104620533
	end
	if level == 73 then
		totalEXP = 112120533
	end
	if level == 74 then
		totalEXP = 120620533
	end
	if level == 75 then
		totalEXP = 130620533
	end
	if level == 76 then
		totalEXP = 155620533
	end
	if level == 77 then
		totalEXP = 185620533
	end
	if level == 78 then
		totalEXP = 220620533
	end
	if level == 79 then
		totalEXP = 260620533
	end
	if level == 80 then
		totalEXP = 310620533
	end
	if level == 81 then
		totalEXP = 375620533
	end
	if level == 82 then
		totalEXP = 450620533
	end
	if level == 83 then
		totalEXP = 535620533
	end
	if level == 84 then
		totalEXP = 635620533
	end
	if level == 85 then
		totalEXP = 745620533
	end
	if level == 86 then
		totalEXP = 865620533
	end
	if level == 87 then
		totalEXP = 995620533
	end
	if level == 88 then
		totalEXP = 1135620533
	end
	if level == 89 then
		totalEXP = 1285620533
	end
	if level == 90 then
		totalEXP = 1445620533
	end
	if level == 91 then
		totalEXP = 1645620533
	end
	if level == 92 then
		totalEXP = 1855620533
	end
	if level == 93 then
		totalEXP = 2075620533
	end
	if level == 94 then
		totalEXP = 2305620533
	end
	if level == 95 then
		totalEXP = 2545620533
	end
	if level == 96 then
		totalEXP = 2845620533
	end
	if level == 97 then
		totalEXP = 3155620533
	end
	if level == 98 then
		totalEXP = 3475620533
	end

	return totalEXP
end

getTotalTimePlayed = function(player) --added 8-7-16 for /played
	local hour, minute, second = 0, 0, 0

	local currentTime = (os.time() - player.registry["session_start_time"])

	if player.registry["total_time_played"] > 0 then
		dif = player.registry["total_time_played"] + currentTime
		hour = string.format("%04.f", math.floor(dif / 3600))
		minute = string.format("%02.f", math.floor(dif / 60 - (hour * 60)))
		second = string.format("%02.f", math.floor(dif - hour * 3600 - minute * 60))

		return hour .. ":" .. minute .. ":" .. second
	else
		dif = currentTime
		hour = string.format("%04.f", math.floor(dif / 3600))
		minute = string.format("%02.f", math.floor(dif / 60 - (hour * 60)))
		second = string.format("%02.f", math.floor(dif - hour * 3600 - minute * 60))
		return hour .. ":" .. minute .. ":" .. second
	end
end

getSessionTimePlayed = function(player) --added 8-7-16 for /played
	local hour, minute, second = 0, 0, 0
	local sessionStartTime = player.registry["session_start_time"]

	if sessionStartTime > 0 then
		dif = os.time() - sessionStartTime
		hour = string.format("%03.f", math.floor(dif / 3600))
		minute = string.format("%02.f", math.floor(dif / 60 - (hour * 60)))
		second = string.format("%02.f", math.floor(dif - hour * 3600 - minute * 60))

		return hour .. ":" .. minute .. ":" .. second
	else
		return "00:00:00"
	end
end

--setDisposition = function(player, npc, repCheckFlag, dispReward)
--
--	local npcID = npc
--	local reward = dispReward
--	local dispo = player.registry["disposition_"..npcID]
--	local repCheck = repCheckFlag
--
--	local deltaTalkTime
--	local deltaRepCheck
--	local talkTime = player.registry["last_talk_time_"..npcID]
--	local repCheckTime = player.registry["last_repcheck_time_"..npcID]
--	local timeSinceLastDispInc = player.registry["last_disp_inc_time_"..npcID]
--	local dispoOffsetFromNeutral = 302400 - dispo
--
--	deltaRepCheck = (os.time() - repCheckTime)
--	deltaTalkTime = (os.time() - talkTime)
--
--	if repCheck == 2 then
--		if timeSinceLastDispInc > 86400 then
--			dispo = dispo + reward
--			if player.gmLevel > 0 then
--				player:sendMinitext("Disposition Increased: "..reward)
--			end
--			player.registry["last_disp_inc_time_"..npcID] = os.time()
--
--		else
--			dispo = dispo
--			if player.gmLevel > 0 then
--				player:sendMinitext("No Change, Come back after 24 Hours")
--				player:sendMinitext("Time Since Last Disp Inc (SEC): "..timeSinceLastDispInc)
--				player:sendMinitext("Time Since Last Disp Inc (HOURS): "..round((timeSinceLastDispInc / 3600),2))
--			end
--		end
--		return dispo
--	end
--
--	if talkTime ~= 0 then
--        -----------------------------
--		-- Bad Terms with the NPC ---
--		-----------------------------
--		if dispoOffsetFromNeutral > 0 then
--			if repCheck == 0 then
--				dispo = dispo + deltaTalkTime
--			elseif repCheck == 1 then
--				dispo = dispo + deltaRepCheck
--			else
--				player:talkSelf(0,"Error: Invalid RepCheck Flag"..repCheck)
--			end
--
--			if dispo >= 302400 then		-- If the change would push you over Neutral
--				dispo = 302400			-- set it to neutral`
--			else
--				dispo = dispo			-- otherwise leave it alone.
--			end
--        -----------------------------
--		-- Neutral with the NPC    --
--		-----------------------------
--        elseif dispoOffsetFromNeutral == 0 then
--			dispo = dispo				-- leave it alone
--	    -----------------------------
--		-- Good Terms with the NPC --
--		-----------------------------
--		elseif dispoOffsetFromNeutral < 0 then
--
--			if deltaTalkTime > 86400 then -- stop a deduction from your disposition if you have talked to him in the  last day.
--
--				if repCheck == 0 then
--					dispo = dispo - (deltaTalkTime - 86400)
--
--				elseif repCheck == 1 then
--					dispo = dispo - deltaRepCheck
--
--				else
--					player:talkSelf(0,"Error: Invalid RepCheck Flag"..repCheck)
--				end
--
--				if dispo <= 302400 then  -- If the change would drop below neutral
--					dispo = 302400		 -- Set it to neutral
--				else
--					dispo = dispo		 -- otherwise leave it as is.
--				end
--
--    	    end
--
--		end
--
--    end
--
--	if talkTime == 0 then
--    end
--
--    return dispo
--end

randomMinigame = function()
	local availableMiniGames = {}

	if core.gameRegistry["freeze_war_completed"] == 0 then
		table.insert(availableMiniGames, "freeze_war")
	end

	if core.gameRegistry["beach_war_completed"] == 0 then
		table.insert(availableMiniGames, "beach_war")
	end

	if core.gameRegistry["sumo_war_completed"] == 0 then
		table.insert(availableMiniGames, "sumo_war")
	end

	if core.gameRegistry["elixir_completed"] == 0 then
	--table.insert(availableMiniGames, "elixir_war")
	end

	if core.gameRegistry["bomber_war_completed"] == 0 then
		table.insert(availableMiniGames, "bomber_war")
	end

	if
		core.gameRegistry["freeze_war_completed"] == 1 and core.gameRegistry["bomber_war_completed"] == 1 and
			core.gameRegistry["beach_war_completed"] == 1 and
			core.gameRegistry["sumo_war_completed"] == 1 --[[and core.gameRegistry["elixir_war_completed"] == 1]]
	 then
		core.gameRegistry["freeze_war_completed"] = 0
		core.gameRegistry["bomber_war_completed"] = 0
		core.gameRegistry["beach_war_completed"] = 0
		core.gameRegistry["sumo_war_completed"] = 0
		core.gameRegistry["elixir_war_completed"] = 0
		table.insert(availableMiniGames, "freeze_war")
		table.insert(availableMiniGames, "bomber_war")
		table.insert(availableMiniGames, "beach_war")
		table.insert(availableMiniGames, "sumo_war")
	--table.insert(availableMiniGames, "elixir_war")
	end

	local chosenMiniGame = availableMiniGames[math.random(1, #availableMiniGames)]

	if chosenMiniGame == "freeze_war" then
		core.gameRegistry["freeze_war_completed"] = 1
		freeze_war.open()
	elseif chosenMiniGame == "bomber_war" then
		core.gameRegistry["bomber_war_completed"] = 1
		bomber_war.open()
	elseif chosenMiniGame == "beach_war" then
		core.gameRegistry["beach_war_completed"] = 1
		beach_war.open()
	elseif chosenMiniGame == "sumo_war" then
		core.gameRegistry["sumo_war_completed"] = 1
		sumo_war.open()
	elseif chosenMiniGame == "elixir_war" then
		core.gameRegistry["elixir_war_completed"] = 1
		elixir_war.open()
	end
end

stattest = {
	on_attacked = function(mob, attacker)
		mob:talk(0, "Helper: my Might is " .. mob.might)
		mob:talk(0, "Helper: my Grace is " .. mob.grace)
		mob:talk(0, "Helper: my will is " .. mob.will)
		mob:talk(0, "Helper: my Wisdom is " .. mob.wisdom)
		mob:talk(0, "Helper: my Con is " .. mob.con)
	end
}

mobCount = function(player)
	local mob = player:getObjectsInMap(player.m, BL_MOB)
	local mobs = {}

	player:talk(0, "" .. player.mapTitle .. ": ")
	player:talk(0, "Total mobs: " .. #mob)

	for i = 1, #mob do
		table.insert(mobs, mob[i].mobID)
	end
	for i = 1, #mob do
		if core.gameRegistry["printed_" .. mob[i].mobID] == 0 then
			player:talk(0, "Number of " .. mob[i].name .. ": " .. countInList(mobs, mob[i].mobID))
			core.gameRegistry["printed_" .. mob[i].mobID] = 1
		end
	end
	mobCountClear(player)
end

mobCountClear = function(player)
	local mob = player:getObjectsInMap(player.m, BL_MOB)

	for i = 1, #mob do
		core.gameRegistry["printed_" .. mob[i].mobID] = 0
	end
end

countInList = function(list, value)
	count = 0

	for i = 1, #list do
		if list[i] == value then
			count = count + 1
		end
	end
	return count
end

sendGUItext = function(string)
	guitext(-1, string)

	-- USAGE in functions         sendguiText("Test String")
end

sort_relative = function(ref, t, cmp)
	local n = #ref
	assert(#t == n)
	local r = {}
	for i = 1, n do
		r[i] = i
	end
	if not cmp then
		cmp = function(a, b)
			return a < b
		end
	end
	table.sort(
		r,
		function(a, b)
			return cmp(ref[a], ref[b])
		end
	)
	for i = 1, n do
		r[i] = t[r[i]]
	end
	return r
end
