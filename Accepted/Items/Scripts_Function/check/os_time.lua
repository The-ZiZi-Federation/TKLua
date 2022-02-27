os_time = {

cast = function(player)

	if player:hasDuration("os_time") then
		player:setDuration("os_time", 0)
	else
		player:setDuration("os_time", 60000)
	end
end,

while_cast_250 = function(player)

	player:talk(2, ""..os.time().."")
end
}