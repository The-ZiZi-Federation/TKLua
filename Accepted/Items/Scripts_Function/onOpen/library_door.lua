--Seagrove Library Door Hidden Path
library_door = {
	
open = function(player)
	
	local pc = core:getObjectsInMap(1011, BL_PC)
	local m, x , y, side = player.m, player.x, player.y, player.side
	local obj = getObject(1011, 16, 2)

	if (x == 16 and y == 3) then
		if obj == 730 or obj == 0 then
			if obj == 730 then
				setObject(1011, 16, 2, 0)
				core.gameRegistry["library_door"] = os.time()+10
				
			elseif obj == 0 then
				setObject(1011, 16, 2,730)
					if #pc > 0 then
					for i = 1, #pc do
						library_door.talk(pc[i])
					end
				end
			end
		end
	player:talkSelf(0, player.name..": Scoundrels could use a lesson from Wizards when it comes to hiding paths.")
	end
end,


auto = function()
	
	local player = core:getObjectsInMap(1011, BL_PC)

	if core.gameRegistry["library_door"] > 0 and core.gameRegistry["library_door"] < os.time() then
		setObject(1011, 16, 2, 730)
		core.gameRegistry["library_door"] = 0
		if #player > 0 then
			for i = 1, #player do
				library_door.talk(player[i])
			end
		end
	end
end,

talk = function(player)
	
	player:talkSelf(0, player.name..": I bet they have a lot to teach me.")
end
}