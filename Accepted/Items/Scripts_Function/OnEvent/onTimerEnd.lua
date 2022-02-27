startTimer = function(block, timerName, dura, type)

	if timerName == "test" then
		block:setTimer(type, dura)
	end
end

onTimerEnd = function(player)
	
	snow_ball.timerEnd(player)
end