revolver = {
    
use = function(player)

	if ((player.m == 1018 or player.m == 2005 or player.m == 2002) or (player.m >= 15000 and player.m < 16000)) then
		player:sendMinitext("You can't use that here.")
		return
	end

	player:freeAsync()
	player.lastClick = player.ID
	revolver.click(player)
end,

trigger = function(player)
	local r = math.random(1, 6)
	local reg = player.registry["revolver"]
	
	if r + reg >= 6 or player.registry["revolver"] == 5 then
		player:talk(1, player.name.." pulled the trigger: BANG")
		player.health = 0
		player.state = 1
		player:calcStat()
		player:sendStatus()
		player:sendAnimation(13)
		player:playSound(12)
		player:removeItem("revolver", 1)
		player.registry["revolver"] = 0
		
	else
		player:talk(1, player.name.." pulled the trigger: CLICK")
		player:playSound(408)
		player:sendAction(10, 40)
		player.registry["revolver"] = player.registry["revolver"] + 1
	end
end,

cylinder = function(player)

	if player.sex == 0 then
		p = "his"
	elseif player.sex == 1 then
		p = "her"
	end
	if not player:hasDuration("revolver") then

		player:talk(1, player.name.." spins the cylinder of "..p.." revolver")
		player.registry["revolver"] = 0
		player:setDuration("revolver", 10000)
	else
		player:sendMinitext("Your cylinder is still spinning!")
	end
end,

click = async(function(player, npc)
	player.dialogType = 0
	local opts = {"Pull the trigger", "Spin the cylinder"}    
	menu = player:menuString("You are holding a revolver. What do you want to do?", opts)

	if menu == "Pull the trigger" then
		revolver.trigger(player)
	elseif menu == "Spin the cylinder" then
		revolver.cylinder(player)
	end
end
)
}