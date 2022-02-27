baseStatIncrease = function(player)

	local path = player.baseClass
	local level = player.level
	
	local spMight = player.registry["sp_spent_might"]
	local spGrace = player.registry["sp_spent_grace"]
	local spWill = player.registry["sp_spent_will"]
	local spArmor = player.registry["sp_spent_armor"] * 80

	local mainStat = math.ceil(((player.level) * .2))
	local secondStat = math.ceil((mainStat * .5))
	local thirdStat = math.ceil((secondStat * .6)) 
	
	if path == 1 then	--fighter paths
		player.basemight = mainStat + spMight
		player.basegrace = secondStat + spGrace
		player.basewill = thirdStat + spWill
		player.basearmor = (player.level * 100) + spArmor
		
	elseif path == 2 then  --scoundrel paths
	
		player.basemight = secondStat + spMight
		player.basegrace = mainStat + spGrace
		player.basewill = thirdStat + spWill
		player.basearmor = (player.level * 35) + spArmor
		
	elseif path == 3 then  --wizard paths
		player.basemight = thirdStat + spMight
		player.basegrace = secondStat + spGrace
		player.basewill = mainStat + spWill
		player.basearmor = (player.level * 20) + spArmor
		
	elseif path == 4 then  --priest paths
		player.basemight = secondStat + spMight
		player.basegrace = thirdStat + spGrace
		player.basewill = mainStat + spWill
		player.basearmor = (player.level * 60) + spArmor
	end

	player:calcStat()
end