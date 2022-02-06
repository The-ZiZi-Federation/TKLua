karma = {

good = function(player)

	local reg = player.registry["good_karma"]

	finishedQuest(player)
	if player:hasLegend("honor") then player:removeLegendbyName("honor") end
	
	if reg > 0 then
		player.registry["good_karma"] = player.registry["good_karma"] + 1
		player:addLegend("Did the right thing "..player.registry["good_karma"].." times", "honor", 35, 144)
	else
		player.registry["good_karma"] = 1
		player:addLegend("Did the right thing 1 time", "honor", 35, 144)
	end
end,

bad = function(player)

	local reg = player.registry["bad_karma"]

	finishedQuest(player)
	if player:hasLegend("dishonor") then player:removeLegendbyName("dishonor") end
	
	if reg > 0 then
		player.registry["bad_karma"] = player.registry["bad_karma"] + 1
		player:addLegend("Committed "..player.registry["bad_karma"].." evil acts", "dishonor", 26, 144)
	else
		player.registry["bad_karma"] = 1
		player:addLegend("Committed 1 evil act", "dishonor", 26, 144)
	end
end,

neutral = function(player)

	local reg = player.registry["neutral_karma"]

	finishedQuest(player)
	if player:hasLegend("neutralkarma") then player:removeLegendbyName("neutralkarma") end
	
	if reg > 0 then
		player.registry["neutral_karma"] = player.registry["neutral_karma"] + 1
		player:addLegend("Chose self-interest "..player.registry["neutral_karma"].." times", "neutralkarma", 89, 144)
	else
		player.registry["neutral_karma"] = 1
		player:addLegend("Chose self-interest 1 time", "neutralkarma", 89, 144)
	end
end

}