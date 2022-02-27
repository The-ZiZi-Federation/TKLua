specRebirth = function(player, pathID)

	local pathAnim = 0
	local anim1 = 630
	local anim2 = 643
	local legendColor = 0
	local legendIcon = 156
	
	if pathID == 6 or pathID == 11 or pathID == 16 then
		pathAnim = 510
	elseif pathID == 7 or pathID == 12 or pathID == 17 then
		pathAnim = 512
	elseif pathID == 8 or pathID == 13 or pathID == 18 then
		pathAnim = 511
	elseif pathID == 9 or pathID == 14 or pathID == 19 then
		pathAnim = 513
	end
	
	if pathID == 6 or pathID == 7 or pathID == 8 or pathID == 9 then
		legendColor = 9
	elseif pathID == 11 or pathID == 12 or pathID == 13 or pathID == 14 then
		legendColor = 3
	elseif pathID == 16 or pathID == 17 or pathID == 18 or pathID == 19 then
		legendColor = 4
	end
	
	if player.baseMagic > 184000 and player.baseHealth > 184000 then
		player:addLegend("Achieved maximum potential as a "..getPathName(player), "specialization_max", 122, 143)
	end
	
	player:addLegend("Specialized in the path of the "..getPathName(player).." "..curT(), "specialization", legendIcon, legendColor)
	
	player:playSound(123)
	player:sendAnimation(pathAnim)
	player:sendAnimation(anim1)
	player:sendAnimation(anim2)
	player.class = pathID
	player.level = 5
	player.exp = 9000
	player.registry["exp_maxes"] = 0
	player.registry["mana_sold"] = 0
	player.registry["vita_sold"] = 0
	player.expSold = 0
	player.baseHealth = 15000
	player.baseMagic = 15000
	player:sendStatus()
	spend_sp.respec(player)
	player:sendStatus()
	player:calcStat()
	player:status()
	
end
