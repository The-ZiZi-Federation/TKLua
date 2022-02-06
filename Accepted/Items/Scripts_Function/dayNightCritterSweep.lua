dayNightCritterSweep = function(map)

	local worldTime = curTime()
	local mob = core:getObjectsInMap(map, BL_MOB)

	if worldTime >= 4 and worldTime <= 18 then
		if #mob > 0 then
			for i = 1, #mob do
				if mob[i].yname == "brown_mushroom" then --if the mob is nocturnal
					--mob[i]:vanish()
					mob[i]:removeHealthWithoutDamageNumbers(mob[i].health)
				end
			end
		end
	end
	
	if worldTime < 4 or worldTime > 18 then
		if #mob > 0 then
			for i = 1, #mob do
				if mob[i].yname == "sanguine_flower" or mob[i].yname == "cobalt_flower" then --if the mob is day-only
					--mob[i]:vanish()
					mob[i]:removeHealthWithoutDamageNumbers(mob[i].health)
				end
			end
		end
	end
	

end


