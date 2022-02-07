ticktest = {
	while_cast_100 = function(player)
		if player.timerTick > player.registry["last_check"] then
			player.registry["timertick_checks"] = player.registry["timertick_checks"] + 1
			player:talk(0, "Check #" .. player.registry["timertick_checks"] .. ": " .. player.timerTick)
			player.registry["last_check"] = player.timerTick
		end
	end,
	uncast = function(player)
		player.registry["timertick_checks"] = 0
		player.registry["last_check"] = 0
	end
}

onLuaTest = function(player)
	--Player(4):talk(0,"Oliver's location: ["..NPC(324).mapTitle.."]("..NPC(324).m..") "..NPC(324).x.." "..NPC(324).y)
	--findClearPath(player.side, player.m, player.x, player.y, target, 1)
	--Player(4):talk(0,"findClearPath: "..findClearPath(player.side, player.m, player.x, player.y, Player("Spellswell"), 1, 279))

	--bot.check(Player("sneakypete"))

	--furnace.use(player)
	--[[	
	if player.ID == 4 then
		local animation = 599
		local dist = 5
		for x = player.x-dist, player.x+dist do
			for y = player.y-dist, player.y+dist do
				if distanceXY(player, x, y) <= dist then
					player:sendAnimationXY(animation, x, y)
				end
			end
		end
	else]]
	local pc = player:getObjectsInMap(player.m, BL_PC)
	local ipmatch = {}

	if #pc > 0 then
		for i = 1, #pc do
			for j = 1, #pc do
				if pc[i].ID ~= pc[j].ID then
					if pc[j].ipaddress == pc[i].ipaddress then
						player:sendMinitext("Same IP: " .. pc[i].name .. " and " .. pc[j].name .. " connected from " .. pc[i].ipaddress)
					end
				end
			end
		end
	end
	--	end

	--[[	
	local player = Player(4)

	local mapItems = player:getObjectsInMap(player.m, BL_ITEM)

    if #mapItems > 0 then
        for i = 1, #mapItems do
            mapItems[i]:delete()
        end

    end
--]]
	--	player:setDuration("ticktest", 10000)
end

peterTest = function(player) --
	--[[	
	local luasql = require "luasql.mysql"
	
	DBHOST = 'localhost' or '127.0.0.1'
	DBNAME = 'MornaTales'
	DBUSER = 'root'
	DBPASS = 'mr211988'
	
	env = assert(luasql.mysql())
	db_connection = env:connect(DBNAME, DBUSER, DBPASS, DBHOST)
	query = "INSERT INTO `Paper` (`PapId`, `PapText`, `PapWidth`, `PapHeight`) VALUES (5, 'Hello balbalbah', 30, 30)"
	check = db_connection:execute(query.."")
	db_connection:close()
	env:close()
]]
	--	data = getData("Paper", "PaperText", "PaperId", 5)
	--	player:talk(1, ""..data)
	-- the usage are:
	-- stripEquip([num]type, [num]how)
	-- type is the number for equipments (EQ_WEAP, EQ_ARMOR, Etc)
	-- how = 0, is just strip the equipment, 1 is for delete the equipment / make it broken
end

getData = function(tab, column, id, val)
	require "luasql.mysql"

	DBHOST = "localhost" or "127.0.0.1"
	DBNAME = "MornaTales"
	DBUSER = "root"
	DBPASS = "mr211988"
	env = assert(luasql.mysql())
	con = assert(env:connect(DBNAME, DBUSER, DBPASS, DBHOST))

	local query = ""

	if tab == nil then
		return false
	else
		if column ~= nil then
			query = "SELECT `" .. column .. "` FROM `" .. tab .. "` WHERE `" .. id .. "` = '" .. val .. "'"
		end
	end

	data = con:execute(query .. "")

	return data
end

--------------------------------------------------------------------------------------------------------------

jesusTest = function(player)
end

--------------------------------------------------------------------------------------------------------------

godTest = function(player)
end
