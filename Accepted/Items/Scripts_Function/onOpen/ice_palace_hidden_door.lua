ice_palace_hidden_door = {

open_1 = function(player)

	local m1 = 4157
	local m2 = 4153
	
	if core.gameRegistry["ice_palace_hidden_door_1"] > 0 then player:talkSelf(0, player.name..": It's already been activated.") return end

	if core.gameRegistry["ice_palace_hidden_door_1"] == 0 then
		core.gameRegistry["ice_palace_hidden_door_1"] = os.time()+30
		player:talkSelf(0, player.name..": A secret switch! Something moved when I pressed it...")

		--opening door in fountain room
		setObject(m1, 0, 6, 0)
		setObject(m1, 0, 7, 0)
		setObject(m1, 0, 8, 0)
                   
		setObject(m1, 0, 4, 12045)
		setObject(m1, 0, 5, 12013)
		setObject(m1, 0, 8, 12047)
		setObject(m1, 0, 9, 12053)

		setPass(m1, 0, 6, 0)
		setPass(m1, 0, 7, 0)
		setPass(m1, 0, 8, 0)
		
		
		--Opening the door in main hall
		setObject(m2, 34, 11, 12044)
		setObject(m2, 35, 11, 12055)
		
		setObject(m2, 34, 12, 12014)
		setObject(m2, 35, 12, 11990)
		
		setObject(m2, 34, 13, 0)
		setObject(m2, 35, 13, 0)
		
		setObject(m2, 34, 14, 0)
		setObject(m2, 35, 14, 0)
		
		setObject(m2, 34, 15, 12046)
		setObject(m2, 35, 15, 12054)
		
		
		setPass(m2, 34, 13, 0)
		setPass(m2, 35, 13, 0)
		
		setPass(m2, 34, 14, 0)
		setPass(m2, 35, 14, 0)
		
		setPass(m2, 34, 15, 0)
		setPass(m2, 35, 15, 0)
	end
	
end,


open_2 = function(player)

	local m1 = 4176
	local m2 = 4172
	
	if core.gameRegistry["ice_palace_hidden_door_2"] > 0 then player:talkSelf(0, player.name..": It's already been activated.") return end

	if core.gameRegistry["ice_palace_hidden_door_2"] == 0 then
		core.gameRegistry["ice_palace_hidden_door_2"] = os.time()+30
		player:talkSelf(0, player.name..": A secret switch! Something moved when I pressed it...")

		--opening door in fountain room
		setObject(m1, 0, 6, 0)
		setObject(m1, 0, 7, 0)
		setObject(m1, 0, 8, 0)
                   
		setObject(m1, 0, 4, 12045)
		setObject(m1, 0, 5, 12013)
		setObject(m1, 0, 8, 12047)
		setObject(m1, 0, 9, 12053)

		setPass(m1, 0, 6, 0)
		setPass(m1, 0, 7, 0)
		setPass(m1, 0, 8, 0)
		
		
		--Opening the door in main hall
		setObject(m2, 34, 11, 12044)
		setObject(m2, 35, 11, 12055)
		
		setObject(m2, 34, 12, 12014)
		setObject(m2, 35, 12, 11990)
		
		setObject(m2, 34, 13, 0)
		setObject(m2, 35, 13, 0)
		
		setObject(m2, 34, 14, 0)
		setObject(m2, 35, 14, 0)
		
		setObject(m2, 34, 15, 12046)
		setObject(m2, 35, 15, 12054)
		
		
		setPass(m2, 34, 13, 0)
		setPass(m2, 35, 13, 0)
		
		setPass(m2, 34, 14, 0)
		setPass(m2, 35, 14, 0)
		
		setPass(m2, 34, 15, 0)
		setPass(m2, 35, 15, 0)
	end
end,

auto_1 = function()

	local m1 = 4157
	local m2 = 4153

	if core.gameRegistry["ice_palace_hidden_door_1"] > 0 and core.gameRegistry["ice_palace_hidden_door_1"] < os.time() then
	
		--closing the door in fountain room
		setPass(m1, 0, 6, 1)
		setPass(m1, 0, 7, 1)
		setPass(m1, 0, 8, 1)
		
		setObject(m1, 0, 6, 12053)
		setObject(m1, 0, 7, 12053)
		setObject(m1, 0, 8, 12053)
		
		setObject(m1, 0, 4, 12053)
		setObject(m1, 0, 5, 12053)
		setObject(m1, 0, 9, 12053)
		
		
		--closing the door in main hall
		setObject(m2, 34, 11, 12052)
		setObject(m2, 35, 11, 12078)
		
		setObject(m2, 34, 12, 12052)
		setObject(m2, 35, 12, 12078)
		
		setObject(m2, 34, 13, 12052)
		setObject(m2, 35, 13, 12078)
		
		setObject(m2, 34, 14, 12052)
		setObject(m2, 35, 14, 12078)
		
		setObject(m2, 34, 15, 12052)
		setObject(m2, 35, 15, 12078)
		
		
		setPass(m2, 34, 13, 1)
		setPass(m2, 35, 13, 1)
		
		setPass(m2, 34, 14, 1)
		setPass(m2, 35, 14, 1)
		
		setPass(m2, 34, 15, 1)
		setPass(m2, 35, 15, 1)
		
		core.gameRegistry["ice_palace_hidden_door_1"] = 0
	end
end,

auto_2 = function()

	local m1 = 4176
	local m2 = 4172

	if core.gameRegistry["ice_palace_hidden_door_2"] > 0 and core.gameRegistry["ice_palace_hidden_door_2"] < os.time() then
	
		--closing the door in fountain room
		setPass(m1, 0, 6, 1)
		setPass(m1, 0, 7, 1)
		setPass(m1, 0, 8, 1)
		
		setObject(m1, 0, 6, 12053)
		setObject(m1, 0, 7, 12053)
		setObject(m1, 0, 8, 12053)
		
		setObject(m1, 0, 4, 12053)
		setObject(m1, 0, 5, 12053)
		setObject(m1, 0, 9, 12053)
		
		
		--closing the door in main hall
		setObject(m2, 34, 11, 12052)
		setObject(m2, 35, 11, 12078)
		
		setObject(m2, 34, 12, 12052)
		setObject(m2, 35, 12, 12078)
		
		setObject(m2, 34, 13, 12052)
		setObject(m2, 35, 13, 12078)
		
		setObject(m2, 34, 14, 12052)
		setObject(m2, 35, 14, 12078)
		
		setObject(m2, 34, 15, 12052)
		setObject(m2, 35, 15, 12078)
		
		
		setPass(m2, 34, 13, 1)
		setPass(m2, 35, 13, 1)
		
		setPass(m2, 34, 14, 1)
		setPass(m2, 35, 14, 1)
		
		setPass(m2, 34, 15, 1)
		setPass(m2, 35, 15, 1)
		
		core.gameRegistry["ice_palace_hidden_door_2"] = 0
	end
end
}