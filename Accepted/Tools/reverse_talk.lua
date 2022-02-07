reverse_talk = {
	cast = function(player, target)
		if target.blType == BL_PC then
			if target:hasDuration("reverse_talk") then
				target:setDuration("reverse_talk", 0)
			else
				target:setDuration("reverse_talk", 60000)
			end
		end
	end
}
