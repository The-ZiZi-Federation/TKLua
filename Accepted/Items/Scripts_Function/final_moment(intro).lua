final_moment = {

uncast = function(player)

	local m, x, y = player.m, player.x, player.y
	local r = math.random(1, 10)
	local health = player.maxHealth
	
	xmasLegendFix.removeLegend(player)
	
	if r == 1 then
		player:spawn(3001,x, y, 1)
		player:msg(4, "A monstrous ogre attacks you!", player.ID)
		player.registry["intro_death"] = r
		player:addLegend("Bashed to Death by an Ogre "..curT(), "intro_death_"..r, 210, 26)
	elseif r == 2 then
		player:spawn(2001,x, y, 1)
		player:msg(4, "A merciless brigand attacks you!", player.ID)
		player.registry["intro_death"] = r
		player:addLegend("In the Wrong Place at the Wrong Time "..curT(), "intro_death_"..r, 210, 26)
	elseif r == 3 then
		player:sendAnimation(420) --lightning
		player:sendAnimation(143)
		player:playSound(9)
		player:removeHealth(health)
		player:msg(4, "You are electrocuted by a bolt of lightning!", player.ID)
		player.registry["intro_death"] = r
		player:addLegend("Electrocuted in a Raging Storm "..curT(), "intro_death_"..r, 210, 26)
	elseif r == 4 then
		player:sendAnimation(19) --bomb
		player:playSound(9)
		player:removeHealth(health)
		player:msg(4, "You are caught in an explosion!", player.ID)
		player.registry["intro_death"] = r
		player:addLegend("Obliterated in an Explosion "..curT(), "intro_death_"..r, 210, 26)
	elseif r == 5 then
		player:sendAnimation(119) --assassin
		player:playSound(9)
		player:removeHealth(health)
		player:msg(4, "A mysterious assassin attacks from the shadows!", player.ID)
		player.registry["intro_death"] = r
		player:addLegend("Eliminated for Knowing Too Much "..curT(), "intro_death_"..r, 210, 26)
	elseif r == 6 then
		player:sendAnimation(203) --arrow
		player:playSound(9)
		player:removeHealth(health)
		player:msg(4, "You are slain by an arrow from the sky!", player.ID)
		player.registry["intro_death"] = r
		player:addLegend("Spitroasted by a Ballista Bolt "..curT(), "intro_death_"..r, 210, 26)
	elseif r == 7 then
		player:sendAnimation(202) --boulder
		player:playSound(9)
		player:removeHealth(health)
		player:msg(4, "Rocks fall. You die.", player.ID)
		player.registry["intro_death"] = r
		player:addLegend("Smashed by a Falling Boulder "..curT(), "intro_death_"..r, 210, 26)
	elseif r == 8 then
		player:sendAnimation(161) --meteor
		player:playSound(9)
		player:removeHealth(health)
		player:msg(4, "You are caught in a meteor storm!", player.ID)
		player.registry["intro_death"] = r
		player:addLegend("Astrally Incinerated "..curT(), "intro_death_"..r, 210, 26)
	elseif r == 9 then
		player:sendAnimation(400) --earthquake
		player:playSound(9)
		player:removeHealth(health)
		player:msg(4, "You are caught in an earthquake!", player.ID)
		player.registry["intro_death"] = r
		player:addLegend("Swallowed by the Abyss "..curT(), "intro_death_"..r, 210, 26)
	elseif r == 10 then
		player:sendAnimation(114) --hurricane
		player:playSound(9)
		player:removeHealth(health)
		player:msg(4, "You are caught in a hurricane!", player.ID)
		player.registry["intro_death"] = r
		player:addLegend("Torn Apart by Wind and Rain "..curT(), "intro_death_"..r, 210, 26)
	end	

	xmasLegendFix.readdLegend(player)
end,

warp = function(player)

	local m = 51
	local x = math.random(1, 78)
	local y = math.random(1, 62)

	if getPass(m,x,y) == 0 then
		player:warp(m, x, y)
		player:sendAnimation(254)
		player:playSound(105)
	else
		final_moment.warp(player)
	end
end,

autoWarp = function(player)

	pc = core:getObjectsInMap(51, BL_PC)

	for i = 1, #pc do
		if pc[i].m == 51 then
			if pc[i].state == 1 then
				if pc[i].registry["intro_death_timer"] > 0 and pc[i].registry["intro_death_timer"] < os.time() then
					pc[i]:warp(52, 8, 8)
					pc[i]:sendAnimation(254)
					pc[i]:playSound(106)
				end
			end
		end
	end
end,

firstLogin = function(player)

	local pc = core:getUsers()
	local t = {graphic = convertGraphic(1439, "monster"), color = 0}

	for i = 1, #pc do
		if pc[i].gmLevel > 0 then
			pc[i]:msg(4, "[INFO]: " ..player.name.. "'s life is flashing before their eyes", pc[i].ID)
			pc[i]:msg(4, "[LOGIN]: "..player.name.." has logged in ~ @"..player.mapTitle.."("..player.m..")", pc[i].ID)
		end
	end
	
	player.baseMagic = player.baseMagic + 50
	if player.registry["welcome_mail_1"] == 0 then
		welcome.letterone(player)
		player.registry["welcome_mail_1"] = 1
	end
	spend_sp.gain(player)
	player.registry["first_login"] = 1
	player:dialogSeq({t, "You have dreamed of today. You know that it is your last."}, 1)
end
}