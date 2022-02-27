quest = {

dailyCheck = function(player, name)
	
	local val = false
	local day, month, year = player.registry[name.."_d"], player.registry[name.."_m"], player.registry[name.."_y"]
	local curDay, curMonth, curYear = math.abs(os.date("%d")), math.abs(os.date("%m")), math.abs(os.date("%y"))
	
	if day == 0 and month == 0 and year == 0 then return true end
	
	if year > curYear then
		val = true
	else
		if month > curMonth then 
			val = true
		else
			if day > curDay then val = true end
		end
	end
	return val
end,

dailyMark = function(player, name)
	
	if name ~= nil then
		player.registry[name.."_d"] = math.abs(os.date("%d"))
		player.registry[name.."_m"] = math.abs(os.date("%m"))
		player.registry[name.."_y"] = math.abs(os.date("%y"))
		finishedQuest(player)
	end
end,

reset = function(player, name)
	
	if name ~= nil then
		player.registry[name.."_d"] = 0
		player.registry[name.."_m"] = 0
		player.registry[name.."_y"] = 0
	end
end,

pickUp = function(player, item)
	
end,

onDrop = function(player, item)
	
end,

timer = function(player, tick)
	
	local r = math.random(10)

	if tick == "second" then

	end
end
}