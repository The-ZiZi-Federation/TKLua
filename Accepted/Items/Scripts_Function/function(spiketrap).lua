warpGlow = function(player)

	local m = player.m
	local xm, ym = player.xmax, player.ymax
	
	for x = 0, xm do
		for y = 0, ym do
			if getWarp(m, x, y) == true then
				player:selfAnimationXY(player.ID, 529, x, y)
			end
		end
	end
end

spawn_a_monster = function(player, mob, amount, m, x, y)
						  -- player, "island_worm", 5, 3, 2) for example
	local is_a_number = tonumber(mob)			-- looks like data for mob must in number to spawn (need to remember all the mobId for every mob in your database. haha)

	if (is_a_number) <= 0 then               	--> if the value of id that we told to srver still not changed, its 0 (if the code we write there to check data inputed are string or number. is not working well)
		player:msg(0, "[System] Maximal monster to spawn is 50", player.ID)
	return else						--> If id now is not 0 again.. (changed by that code before)
		if tonumber(amount) <= 0 then
			player:msg(0, "[System] Minimum mob amount to spawn is 1")
		return else
			player:spawn(mob, x, y, amount)
			player:sendMinitext("Temporary Spawned!")	-- mini text at right side, appear
		end
	end
end

canClickInEmptyRoom = function(clicker)
	
	local mob = clicker:getObjectsInMap(clicker.m, BL_MOB)
	local val = false
	
	if #mob == 0 then val = true end
	return val
	
end

cspells = function(player)

	local spells = player:getSpells()
	
	if #spells > 0 then
		for i = 1, #spells do
			player:removeSpell(spells[i])
		end
		player:sendMinitext("All spells removed!")
	end
	player:sendStatus()
end

spike_trap = {

step = function(player)
	local x = player.x
	local y = player.y
	local m = player.m
	local obj = getObject(m, x, y)
	
	local dam = player.health*0.2

	if obj == 13591 then
		if m == 15100 then return end
		setObject(m, x, y, 13592)
		player:removeHealth(dam)
	end
end,

auto = function()

	local x
	local y

	for x = 1, 23 do
		for y = 1, 19 do
			if getObject(1335, x, y) == 13592 then
				setObject(1335, x, y, 13591)
			end
		end
	end
	for x = 1, 38 do
		for y = 1, 38 do
			if getObject(1334, x, y) == 13592 then
				setObject(1334, x, y, 13591)
			end
		end
	end
end
}