worldDrops = {

getItemPath = function(path)
	local randomPath = math.random(1, 100)
	local pathOfItem = 0

	if path == 1 or path == 6 or path == 11 or path == 16 then
		if randomPath <= 50 then
			pathOfItem = 1
		elseif randomPath >= 51 and randomPath <= 67 then
			pathOfItem = 2
		elseif randomPath >= 68 and randomPath <= 84 then
			pathOfItem = 3
		elseif randomPath >= 85 then
			pathOfItem = 4
		end
	elseif path == 2 or path == 12 or path == 17 then
		if randomPath <= 50 then
			pathOfItem = 2
		elseif randomPath >= 51 and randomPath <= 67 then
			pathOfItem = 3
		elseif randomPath >= 68 and randomPath <= 84 then
			pathOfItem = 4
		elseif randomPath >= 85 then
			pathOfItem = 1
		end
	elseif path == 3 or path == 13 or path == 18 then
		if randomPath <= 50 then
			pathOfItem = 3
		elseif randomPath >= 51 and randomPath <= 67 then
			pathOfItem = 4
		elseif randomPath >= 68 and randomPath <= 84 then
			pathOfItem = 1
		elseif randomPath >= 85 then
			pathOfItem = 2
		end
	elseif path == 4 or path == 14 or path == 19 then
		if randomPath <= 50 then
			pathOfItem = 4
		elseif randomPath >= 51 and randomPath <= 67 then
			pathOfItem = 1
		elseif randomPath >= 68 and randomPath <= 84 then
			pathOfItem = 2
		elseif randomPath >= 85 then
			pathOfItem = 3
		end
	elseif path == 5 then -- GM
		if randomPath <= 25 then
			pathOfItem = 1
		elseif randomPath >= 26 and randomPath <= 50 then
			pathOfItem = 2
		elseif randomPath >= 51 and randomPath <= 75 then
			pathOfItem = 3
		elseif randomPath >= 76 then
			pathOfItem = 4
		end
	end
	return pathOfItem
end,


getRandomItem = function(path, mobLevel)

	local fighterItems = 
		{16051, 16052, 16053, 16054, 16055, 16056, 16057, 16058, 16059, 16060, 16062, --weapons
		16251, 16252, 16253, 16254, 16255, 16256, 16257, 16258, 16259, 16260, 16261,  --shield
		16351, 16352, 16353, 16354, 16355, 16356, 16357, 16358, 16359, 16360, 16361,  --helm
		16451, 16452, 16453, 16454, 16455, 16456, 16457, 16458, 16459, 16460, 16461,  --hand || v Armors v
		16601, 16602, 16603, 16604, 16605, 16606, 16607, 16608, 16609, 16610, 16611, 16612, 16613, 16614, 16615, 16616, 16617, 16618, 16619, 16620, 16621, 16622, 16623, 16624, 16625, 16626, 16627, 16628, 16629, 16630, 16631, 16632, 16633, 16634, 16635, 16636,  
		16465, 16751, 16752, 16753, 16754, 16755, 16756, 16757, 16758, 16759, 16760, 16761} --boots

	local scoundrelItems = 
		{17051, 17052, 17053, 17054, 17055, 17056, 17057, 17058, 17059, 17060, 17062, 
		17251, 17252, 17253, 17254, 17255, 17256, 17257, 17258, 17259, 17260, 17261, 
		17351, 17352, 17353, 17354, 17355, 17356, 17357, 17358, 17359, 17360, 17361, 
		17451, 17452, 17453, 17454, 17455, 17456, 17457, 17458, 17459, 17460, 17461,
		17601, 17602, 17603, 17604, 17605, 17606, 17607, 17608, 17609, 17610, 17611, 17612, 17613, 17614, 17615, 17616, 17617, 17618, 17619, 17620, 17621, 17622, 17623, 17624, 17625, 17626, 17627, 17628, 17629, 17630, 17631, 17632, 17633, 17634, 17635, 17636, 
		17751, 17752, 17753, 17754, 17755, 17756, 17757, 17758, 17759, 17760, 17761}
		
	local wizardItems = 
		{18051, 18052, 18053, 18054, 18055, 18056, 18057, 18058, 18059, 18060, 18062, 
		18251, 18252, 18253, 18254, 18255, 18256, 18257, 18258, 18259, 18260, 18261, 
		18351, 18352, 18353, 18354, 18355, 18356, 18357, 18358, 18359, 18360, 18361, 
		18451, 18452, 18453, 18454, 18455, 18456, 18457, 18458, 18459, 18460, 18461, 
		18601, 18602, 18603, 18604, 18605, 18606, 18607, 18608, 18609, 18610, 18611, 18612, 18613, 18614, 18615, 18616, 18617, 18618, 18619, 18620, 18621, 18622, 18623, 18624, 18625, 18626, 18627, 18628, 18629, 18630, 18631, 18632, 18633, 18634, 18635, 18636,    
		18751, 18752, 18753, 18754, 18755, 18756, 18757, 18758, 18759, 18760, 18761}
		
	local priestItems = 
		{19051, 19052, 19053, 19054, 19055, 19056, 19057, 19058, 19059, 19060, 19062, 
		19251, 19252, 19253, 19254, 19255, 19256, 19257, 19258, 19259, 19260, 19261, 
		19351, 19352, 19353, 19354, 19355, 19356, 19357, 19358, 19359, 19360, 19361, 
		19451, 19452, 19453, 19454, 19455, 19456, 19457, 19458, 19459, 19460, 19461,  
		19601, 19602, 19603, 19604, 19605, 19606, 19607, 19608, 19609, 19610, 19611, 19612, 19613, 19614, 19615, 19616, 19617, 19618, 19619, 19620, 19621, 19622, 19623, 19624, 19625, 19626, 19627, 19628, 19629, 19630, 19631, 19632, 19633, 19634, 19635, 19636,
		19751, 19752, 19753, 19754, 19755, 19756, 19757, 19758, 19759, 19760, 19761}
	
	local r
	local chosenItem = 0


	if path == 1 or path == 6 or path == 11 or path == 16 then
		r = math.random(1, #fighterItems)
		chosenItem = fighterItems[r]
	elseif path == 2 or path == 7 or path == 12 or path == 17 then
		r = math.random(1, #scoundrelItems)
		chosenItem = scoundrelItems[r]
	elseif path == 3 or path == 8 or path == 13 or path == 18 then
		r = math.random(1, #wizardItems)
		chosenItem = wizardItems[r]
	elseif path == 4 or path == 9 or path == 14 or path == 19 then
		r = math.random(1, #priestItems)
		chosenItem = priestItems[r]
	elseif path == 5 or path == 10 or path == 15 or path == 20 then
		local l = math.random(1,4)
		
		if l == 1 then
			r = math.random(1, #fighterItems)
			chosenItem = fighterItems[r]
		elseif l == 2 then
			r = math.random(1, #scoundrelItems)
			chosenItem = scoundrelItems[r]
		elseif l == 3 then
			r = math.random(1, #wizardItems)
			chosenItem = wizardItems[r]
		elseif l == 4 then
			r = math.random(1, #priestItems)
			chosenItem = priestItems[r]
		end
	end

	if math.abs(Item(chosenItem).level - mobLevel) > 5 then
		return worldDrops.getRandomItem(path, mobLevel)
	else
		return chosenItem
	end
end,


drop = function(player, mob)

	local m, x, y = mob.m, mob.x, mob.y
	local level = mob.level
	
	local randomChance = math.random(1, 25000) - ((mob.level * mob.protection * 2) + (110 - player.level)) -- adjusted formula 5-9 to increase drops at lower levels
	local randomItem = 0
	local pathOfItem = 0


	if randomChance <= 1 or player.gmLevel > 0 then
		
		pathOfItem = worldDrops.getItemPath(player.class)
		randomItem = worldDrops.getRandomItem(pathOfItem, level)

		player:dropItemXY(randomItem, 1, m, x, y)
		
	end

end
}