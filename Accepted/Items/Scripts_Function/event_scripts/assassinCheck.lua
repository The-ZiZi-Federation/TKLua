assassinCheck = {


check = async(function(player)

	local delayTime = math.random(5400,10800)
	local t = {graphic = convertGraphic(996, "monster"), color = 0}	
	player.npcGraphic = t.graphic													 
	player.npcColor = t.color														
	player.dialogType = 0
	player.lastClick = player.ID
	
	
	if player.registry["cherewoots_assassins"] >= 1 then return end
	
	if core.gameRegistry["cherewoot_assassin_timer"] > 0 and core.gameRegistry["cherewoot_assassin_timer"] < os.time() then
		core.gameRegistry["cherewoot_assassin_timer"] = os.time() + delayTime
		player.paralyzed = true
		player:sendAnimation(373)
		player:setDuration("cornered", 2000)
	end
	
	
end
)
,

showMenu = async(function(player)

	local t = {graphic = convertGraphic(996, "monster"), color = 0}	
	player.npcGraphic = t.graphic													 
	player.npcColor = t.color														
	player.dialogType = 0
	player.lastClick = player.ID

	local x, y = player.x, player.y
	local mobID = 20001
	player:spawn(mobID, x+1, y, 1)
	player:spawn(mobID, x-1, y, 1)
	player:spawn(mobID, x, y+1, 1)
	player:spawn(mobID, x, y-1, 1)
	
	local opts = {"I'm not ready.", "Yes, I will serve.", "No, I'd rather die!"}
	
	local mob
	local found = {}
	

	
	player:setDuration("assassin_choice_timer", 10000)
	menu = player:menuString("You have only one chance. Will you serve Cherewoot?", opts)
	
	
	if menu == "I'm not ready." then
		mob = player:getObjectsInArea(BL_MOB)
		if #mob > 0 then
			for i = 1, #mob do
				if mob[i].mobID == 20001 then
					table.insert(found, mob[i].mobID)
				end
			end
		end
		if #found == 0 then return end
		player:sendAnimation(6)
		player:sendAnimation(7)
		player:sendAnimation(89)
		player:removeHealth(player.maxHealth)
		player:sendMinitext("You feel your life's blood drip away as the cultist's blades pierce your flesh countless times.")
		player:msg(0, 'Cultist(Assassin)" You join and serve us, or you die and serve us.', player.ID)
	elseif menu == "Yes, I will serve." then
		mob = player:getObjectsInArea(BL_MOB)
		if #mob > 0 then
			for i = 1, #mob do
				if mob[i].mobID == 20001 then
					table.insert(found, mob[i].mobID)
				end
			end
		end
		if #found == 0 then return end
		karma.bad(player)			
		player.paralyzed = false
		player:msg(0, 'Cultist(Assassin)" Good. We will send word when the time is right.', player.ID)
		player.registry["cherewoots_assassins"] = 1
		player.registry["cherewoots_revival_e"] = 1
	elseif menu == "No, I'd rather die!" then
		mob = player:getObjectsInArea(BL_MOB)
		if #mob > 0 then
			for i = 1, #mob do
				if mob[i].mobID == 20001 then
					table.insert(found, mob[i].mobID)
				end
			end
		end
		if #found == 0 then return end		
		karma.good(player)
		player:sendAnimation(6)
		player:sendAnimation(7)
		player:sendAnimation(89)
		player:removeHealth(player.maxHealth)			
		player:sendMinitext("You feel your life's blood drip away as the cultist's blades pierce your flesh countless times. You have made an enemy of Cherewoot.")
		player:msg(0, 'Cultist(Assassin)" Your death serves us just as well.', player.ID)
		player.registry["cherewoots_assassins"] = 1
		player.registry["cherewoots_revival_g"] = 1
	end
	player:flushDurationNoUncast(616, 616)
	
	if #mob > 0 then
		for i = 1, #mob do
			if mob[i].mobID == 20001 then
				mob[i]:sendAnimationXY(13, mob[i].x, mob[i].y)
				mob[i]:vanish()
			end
		end
	end
end
)
}

assassin_choice_timer = {

uncast = function(player)


	player:sendAnimation(6)
	player:sendAnimation(7)
	player:sendAnimation(89)
	player:removeHealth(player.maxHealth)
	player:sendMinitext("You feel your life's blood drip away as the cultist's blades pierce your flesh countless times.")
	player:msg(0, 'Cultist(Assassin)" You join and serve us, or you die and serve us.', player.ID)
	
	local mob = player:getObjectsInArea(BL_MOB)
	
	if #mob > 0 then
		for i = 1, #mob do
			if mob[i].mobID == 20001 then
				mob[i]:sendAnimationXY(13, mob[i].x, mob[i].y)
				mob[i]:vanish()
			end
		end
	end
	player:freeAscync()
end
}

cornered = {

uncast = function(player)

	assassinCheck.showMenu(player)

end
}

cherewoots_assassin = {

on_spawn = function(mob)

	mob.side = 2
	mob:sendSide()
end
}