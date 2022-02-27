luckyFind = function(player)

	local randomGrade = math.random(1, 1000)
	local randomType = math.random(1, 1000)
	
	local potionGrade 
	local potionType 
	local r = math.random(1, 1000)
--player:talk(0,""..r)
	if r == 1 then
		if randomGrade >= 1 and randomGrade <= 400 then
			potionGrade = "small"
		elseif randomGrade >= 401 and randomGrade <= 600 then
			potionGrade = "minor"
		elseif randomGrade >= 601 and randomGrade <= 700 then
			potionGrade = "reg"
		elseif randomGrade >= 701 and randomGrade <= 800 then
			potionGrade = "strong"
		elseif randomGrade >= 801 and randomGrade <= 900 then
			potionGrade = "greater"
		elseif randomGrade >= 901 and randomGrade <= 950 then
			potionGrade = "superior"
		elseif randomGrade >= 951 and randomGrade <= 1000 then	
			potionGrade = "master"
		end
		
		if randomType >= 1 and randomType <= 500 then
		
			potionType = "vita"
		elseif randomType >= 501 and randomType <= 1000 then
		
			potionType = "mana"
		end
		player:talkSelf(0,"Wow! I found a "..capitalizeFirst(potionGrade).." "..capitalizeFirst(potionType).." Potion!")
		player:sendMinitext("Wow! You found a "..capitalizeFirst(potionGrade).." "..capitalizeFirst(potionType).." Potion!")
		player:addItem(potionGrade.."_"..potionType.."_potion", 1)
	end
end
