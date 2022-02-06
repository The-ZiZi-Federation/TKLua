ogre_mine_walls = {

mineWallExplode1 = function()

	local m = 3201
	local player = core:getObjectsInMap(m, BL_PC)

	if core.gameRegistry["mine_hidden_door_1"] == 0 then
		core.gameRegistry["mine_hidden_door_1"] = 1
		
		setTile(m, 17, 2, 31000)
		setTile(m, 18, 2, 30851)
		setTile(m, 19, 2, 30851)
		setTile(m, 20, 2, 30851)
		setTile(m, 21, 2, 30851)
		setTile(m, 22, 2, 31004)
		
		setTile(m, 17, 3, 31000)
		setTile(m, 18, 3, 30851)
		setTile(m, 19, 3, 30851)
		setTile(m, 20, 3, 30851)
		setTile(m, 21, 3, 30851)
		setTile(m, 22, 3, 31004)
		
		setTile(m, 17, 4, 31000)
		setTile(m, 18, 4, 30851)
		setTile(m, 19, 4, 30851)
		setTile(m, 20, 4, 30851)
		setTile(m, 21, 4, 30851)
		setTile(m, 22, 4, 31004)
		
		setTile(m, 17, 5, 31000)
		setTile(m, 18, 5, 30851)
		setTile(m, 19, 5, 30851)
		setTile(m, 20, 5, 30851)
		setTile(m, 21, 5, 30851)
		setTile(m, 22, 5, 31004)
		
		setTile(m, 18, 6, 30851)
		setTile(m, 19, 6, 30851)
		setTile(m, 20, 6, 30851)
		setTile(m, 21, 6, 30851)
		setTile(m, 22, 6, 31004)
	
	
		setObject(m, 18, 4, 0)
		setObject(m, 18, 5, 0)
		setObject(m, 19, 5, 0)
		setObject(m, 20, 5, 0)
		setObject(m, 18, 6, 0)

		
		setPass(m, 18, 4, 0)
		setPass(m, 19, 4, 0)
		setPass(m, 20, 4, 0)
		setPass(m, 21, 4, 0)
		
		if #player > 0 then
			player[1]:sendAnimationXY(188, 18, 7)
			player[1]:sendAnimationXY(188, 19, 7)
			player[1]:sendAnimationXY(188, 20, 7)
			player[1]:sendAnimationXY(188, 21, 7)
			player[1]:sendAnimationXY(188, 18, 6)
			player[1]:sendAnimationXY(188, 19, 6)
			player[1]:sendAnimationXY(188, 20, 6)
			player[1]:sendAnimationXY(188, 21, 6)
			player[1]:sendAnimationXY(188, 18, 5)
			player[1]:sendAnimationXY(188, 19, 5)
			player[1]:sendAnimationXY(188, 20, 5)
			player[1]:sendAnimationXY(188, 21, 5)
			player[1]:sendAnimationXY(188, 18, 4)
			player[1]:sendAnimationXY(188, 19, 4)
			player[1]:sendAnimationXY(188, 20, 4)
			player[1]:sendAnimationXY(188, 21, 4)
			player[1]:sendAnimationXY(188, 18, 3)
			player[1]:sendAnimationXY(188, 19, 3)
			player[1]:sendAnimationXY(188, 20, 3)
			player[1]:sendAnimationXY(188, 21, 3)
		end
	end
end,

mineWallRegen1 = function()

	local m = 3201
	

	if core.gameRegistry["mine_hidden_door_1"] == 1 then
		core.gameRegistry["mine_hidden_door_1"] = 0
		setTile(m, 17, 2, 30902)
		setTile(m, 18, 2, 30924)
		setTile(m, 19, 2, 30918)
		setTile(m, 20, 2, 30921)
		setTile(m, 21, 2, 30927)
		setTile(m, 22, 2, 30906)
		
		setTile(m, 17, 3, 30903)
		setTile(m, 18, 3, 30925)
		setTile(m, 19, 3, 30919)
		setTile(m, 20, 3, 30922)
		setTile(m, 21, 3, 30928)
		setTile(m, 22, 3, 30907)
		
		setTile(m, 17, 4, 30904)
		setTile(m, 18, 4, 30925)
		setTile(m, 19, 4, 30920)
		setTile(m, 20, 4, 30923)
		setTile(m, 21, 4, 30929)
		setTile(m, 22, 4, 30908)
		
		setTile(m, 17, 5, 36213)
		setTile(m, 18, 5, 30850)
		setTile(m, 19, 5, 30850)
		setTile(m, 20, 5, 30850)
		setTile(m, 21, 5, 30850)
		setTile(m, 22, 5, 36214)
		
		setTile(m, 18, 6, 30850)
		setTile(m, 19, 6, 30850)
		setTile(m, 20, 6, 30850)
		setTile(m, 21, 6, 30850)
		setTile(m, 22, 6, 31004)
	
		
		setObject(m, 18, 4, 16929)
		setObject(m, 18, 5, 16929)
		setObject(m, 19, 5, 13501)
		setObject(m, 20, 5, 13502)
		setObject(m, 18, 6, 16931)

		
		setPass(m, 18, 4, 1)
		setPass(m, 19, 4, 1)
		setPass(m, 20, 4, 1)
		setPass(m, 21, 4, 1)
	end
end,


mineWallExplode2 = function()

	local m = 3201
	local player = core:getObjectsInMap(m, BL_PC)
	
	if core.gameRegistry["mine_hidden_door_2"] == 0 then
		core.gameRegistry["mine_hidden_door_2"] = 1
		
		setTile(m, 59, 42, 31072)
		setTile(m, 59, 43, 31073)
		setTile(m, 59, 44, 31074)
		setTile(m, 59, 45, 30851)
		setTile(m, 59, 46, 30851)
		setTile(m, 59, 47, 30851)
		setTile(m, 59, 48, 30851)
		setTile(m, 59, 49, 0)
		
		setTile(m, 58, 42, 31072)
		setTile(m, 58, 43, 31073)
		setTile(m, 58, 44, 31074)
		setTile(m, 58, 45, 30851)
		setTile(m, 58, 46, 30851)
		setTile(m, 58, 47, 30851)
		setTile(m, 58, 48, 30851)
		setTile(m, 58, 49, 31005)
		
		setTile(m, 57, 42, 31072)
		setTile(m, 57, 43, 31073)
		setTile(m, 57, 44, 31074)
		setTile(m, 57, 45, 30851)
		setTile(m, 57, 46, 30851)
		setTile(m, 57, 47, 30851)
		setTile(m, 57, 48, 30851)
		setTile(m, 57, 49, 31008)
	
		
		setObject(m, 57, 43, 0)
		setObject(m, 57, 45, 0)
		setObject(m, 57, 46, 0)
		setObject(m, 57, 48, 0)

		
		setPass(m, 59, 45, 0)
		setPass(m, 59, 46, 0)
		setPass(m, 59, 47, 0)
		setPass(m, 59, 48, 0)
		
		setPass(m, 58, 45, 0)
		setPass(m, 58, 46, 0)
		setPass(m, 58, 47, 0)
		setPass(m, 58, 48, 0)
		if #player > 0 then
			player[1]:sendAnimationXY(188, 59, 42)
			player[1]:sendAnimationXY(188, 59, 43)
			player[1]:sendAnimationXY(188, 59, 44)
			player[1]:sendAnimationXY(188, 59, 45)
			player[1]:sendAnimationXY(188, 59, 46)
			player[1]:sendAnimationXY(188, 59, 47)
			player[1]:sendAnimationXY(188, 59, 48)
			player[1]:sendAnimationXY(188, 58, 42)
			player[1]:sendAnimationXY(188, 58, 43)
			player[1]:sendAnimationXY(188, 58, 44)
			player[1]:sendAnimationXY(188, 58, 45)
			player[1]:sendAnimationXY(188, 58, 46)
			player[1]:sendAnimationXY(188, 58, 47)
			player[1]:sendAnimationXY(188, 58, 48)
			player[1]:sendAnimationXY(188, 57, 42)
			player[1]:sendAnimationXY(188, 57, 43)
			player[1]:sendAnimationXY(188, 57, 44)
			player[1]:sendAnimationXY(188, 57, 45)
			player[1]:sendAnimationXY(188, 57, 46)
			player[1]:sendAnimationXY(188, 57, 47)
			player[1]:sendAnimationXY(188, 57, 48)
		end	
	end
end,

mineWallRegen2 = function()

	local m = 3201

	if core.gameRegistry["mine_hidden_door_2"] == 1 then
		core.gameRegistry["mine_hidden_door_2"] = 0
		
		setTile(m, 59, 42, 0)
		setTile(m, 59, 43, 0)
		setTile(m, 59, 44, 0)
		setTile(m, 59, 45, 0)
		setTile(m, 59, 46, 0)
		setTile(m, 59, 47, 0)
		setTile(m, 59, 48, 0)
		setTile(m, 59, 49, 0)
		
		setTile(m, 58, 42, 30906)
		setTile(m, 58, 43, 30907)
		setTile(m, 58, 44, 30908)
		setTile(m, 58, 45, 30909)
		setTile(m, 58, 46, 31002)
		setTile(m, 58, 47, 31003)
		setTile(m, 58, 48, 31004)
		
		setTile(m, 57, 42, 30927)
		setTile(m, 57, 43, 30928)
		setTile(m, 57, 44, 30929)
	
		
		setObject(m, 57, 43, 16929)
		setObject(m, 57, 45, 16931)
		setObject(m, 57, 46, 13511)
		setObject(m, 57, 48, 13506)

		
		setPass(m, 59, 45, 1)
		setPass(m, 59, 46, 1)
		setPass(m, 59, 47, 1)
		setPass(m, 59, 48, 1)
		
		setPass(m, 58, 45, 1)
		setPass(m, 58, 46, 1)
		setPass(m, 58, 47, 1)
		setPass(m, 58, 48, 1)
		
	end
end,


mineWallExplode3 = function()

	local m = 3202
	local player = core:getObjectsInMap(m, BL_PC)

	if core.gameRegistry["mine_hidden_door_3"] == 0 then
		core.gameRegistry["mine_hidden_door_3"] = 1
		
		setTile(m, 34, 4, 31072)
		setTile(m, 34, 5, 31073)
		setTile(m, 34, 6, 31074)
		setTile(m, 34, 7, 30851)
		setTile(m, 34, 8, 30851)
		setTile(m, 34, 9, 30851)
		
		setTile(m, 33, 4, 31072)
		setTile(m, 33, 5, 31073)
		setTile(m, 33, 6, 31074)
		
		setTile(m, 32, 4, 31072)
		setTile(m, 32, 5, 31073)
		setTile(m, 32, 6, 31074)

	
		setObject(m, 32, 7, 0)
		setObject(m, 32, 8, 0)
		setObject(m, 33, 7, 0)
		setObject(m, 33, 9, 0)

		
		setPass(m, 33, 7, 0)
		setPass(m, 33, 8, 0)
		setPass(m, 33, 9, 0)
		
		setPass(m, 34, 7, 0)
		setPass(m, 34, 8, 0)
		setPass(m, 34, 9, 0)
		
		player:sendAnimationXY(188, 34, 4)
		player:sendAnimationXY(188, 34, 5)
		player:sendAnimationXY(188, 34, 6)
		player:sendAnimationXY(188, 34, 7)
		player:sendAnimationXY(188, 34, 8)
		player:sendAnimationXY(188, 34, 9)
		player:sendAnimationXY(188, 34, 10)
		
		player:sendAnimationXY(188, 33, 4)
		player:sendAnimationXY(188, 33, 5)
		player:sendAnimationXY(188, 33, 6)
		player:sendAnimationXY(188, 33, 7)
		player:sendAnimationXY(188, 33, 8)
		player:sendAnimationXY(188, 33, 9)
		player:sendAnimationXY(188, 33, 10)
		
		player:sendAnimationXY(188, 32, 4)
		player:sendAnimationXY(188, 32, 5)
		player:sendAnimationXY(188, 32, 6)
		player:sendAnimationXY(188, 32, 7)
		player:sendAnimationXY(188, 32, 8)
		player:sendAnimationXY(188, 32, 9)
		player:sendAnimationXY(188, 32, 10)
	end
end,



mineWallRegen3 = function()

	local m = 3202

	if core.gameRegistry["mine_hidden_door_3"] == 1 then
		core.gameRegistry["mine_hidden_door_3"] = 0
		
		setTile(m, 34, 4, 30906)
		setTile(m, 34, 5, 30907)
		setTile(m, 34, 6, 30908)
		setTile(m, 34, 7, 30909)
		setTile(m, 34, 8, 31003)
		setTile(m, 34, 9, 31004)
		
		setTile(m, 33, 4, 30927)
		setTile(m, 33, 5, 30928)
		setTile(m, 33, 6, 30929)

		setTile(m, 32, 4, 30921)
		setTile(m, 32, 5, 30922)
		setTile(m, 32, 6, 30923)

		
		setObject(m, 32, 7, 16937)
		setObject(m, 32, 8, 16942)
		setObject(m, 33, 7, 16938)
		setObject(m, 33, 9, 16935)

		
		setPass(m, 33, 7, 1)
		setPass(m, 33, 8, 1)
		setPass(m, 33, 9, 1)
		
		setPass(m, 34, 7, 1)
		setPass(m, 34, 8, 1)
		setPass(m, 34, 9, 1)
		
		
	end
end,


mineWallExplode4 = function()

	local m = 3205
	local player = core:getObjectsInMap(m, BL_PC)

	if core.gameRegistry["mine_hidden_door_4"] == 0 then
		core.gameRegistry["mine_hidden_door_4"] = 1

		setTile(m, 29, 15, 30851)
		setTile(m, 29, 16, 30851)
		setTile(m, 29, 17, 30851)
		setTile(m, 29, 18, 30851)

		setObject(m, 28, 16, 0)
		setObject(m, 28, 17, 0)
		setObject(m, 28, 18, 0)
		
		setPass(m, 29, 15, 0)
		setPass(m, 29, 16, 0)
		setPass(m, 29, 17, 0)
		setPass(m, 29, 18, 0)
		
		player:sendAnimationXY(188, 29, 15)
		player:sendAnimationXY(188, 29, 16)
		player:sendAnimationXY(188, 29, 17)
		player:sendAnimationXY(188, 29, 18)
		player:sendAnimationXY(188, 29, 19)

		player:sendAnimationXY(188, 28, 15)
		player:sendAnimationXY(188, 28, 16)
		player:sendAnimationXY(188, 28, 17)
		player:sendAnimationXY(188, 28, 18)
		player:sendAnimationXY(188, 28, 19)
		
		player:sendAnimationXY(188, 27, 15)
		player:sendAnimationXY(188, 27, 16)
		player:sendAnimationXY(188, 27, 17)
		player:sendAnimationXY(188, 27, 18)
		player:sendAnimationXY(188, 27, 19)
		
	end
end,



mineWallRegen4 = function()

	local m = 3205

	if core.gameRegistry["mine_hidden_door_4"] == 1 then
		core.gameRegistry["mine_hidden_door_4"] = 0
		
		setTile(m, 29, 15, 30909)
		setTile(m, 29, 16, 31002)
		setTile(m, 29, 17, 31003)
		setTile(m, 29, 18, 31004)

		setObject(m, 28, 16, 16920)
		setObject(m, 28, 17, 16939)
		setObject(m, 28, 18, 16941)
		
		setPass(m, 29, 15, 1)
		setPass(m, 29, 16, 1)
		setPass(m, 29, 17, 1)
		setPass(m, 29, 18, 1)
		
		
	end
end,

regenWalls = function()

	ogre_mine_walls.mineWallRegen1()
	ogre_mine_walls.mineWallRegen2()
	ogre_mine_walls.mineWallRegen3()
	ogre_mine_walls.mineWallRegen4()

end,

randomizeRooms = function()

	--Player(4):talk(0,"cron: "..realHour())

	core.gameRegistry["mine_hidden1_boss"] = math.random(0, 2)
	core.gameRegistry["mine_hidden2_boss"] = math.random(0, 2)
	core.gameRegistry["mine_hidden3_boss"] = math.random(0, 2)
	core.gameRegistry["mine_hidden4_boss"] = math.random(0, 2)
	
	if core.gameRegistry["mine_hidden1_boss"] < 2 and core.gameRegistry["mine_hidden2_boss"] < 2 and core.gameRegistry["mine_hidden3_boss"] < 2 and core.gameRegistry["mine_hidden4_boss"] < 2 then
		--Player(4):talk(0,"all zeros")
		core.gameRegistry["mine_hidden4_boss"] = 2
	end
	
	--Player(4):talk(0,"room1: "..core.gameRegistry["mine_hidden1_boss"])
	--Player(4):talk(0,"room2: "..core.gameRegistry["mine_hidden2_boss"])
	--Player(4):talk(0,"room3: "..core.gameRegistry["mine_hidden3_boss"])
	--Player(4):talk(0,"room4: "..core.gameRegistry["mine_hidden4_boss"])
end
}

--[[
Room1
		Before:									After:
17, 0 	 Obj 0 Tile 0 Pass FALSE                  Obj 0 Tile 31000 PASS FALSE
18, 0 	 Obj 0 Tile 0 Pass FALSE                  Obj 0 Tile 30851 PASS TRUE
19, 0 	 Obj 0 Tile 0 Pass FALSE                  Obj 0 Tile 30851 PASS TRUE
20, 0 	 Obj 0 Tile 0 Pass FALSE                  Obj 0 Tile 30851 PASS TRUE
21, 0 	 Obj 0 Tile 0 Pass FALSE                  Obj 0 Tile 30851 PASS TRUE
22, 0 	 Obj 0 Tile 0 Pass FALSE                  Obj 0 Tile 31004 PASS FALSE

17, 1 	 Obj 0 Tile 0 Pass FALSE                  Obj 0 Tile 31000 PASS FALSE
18, 1 	 Obj 0 Tile 0 Pass FALSE                  Obj 0 Tile 30851 PASS TRUE
19, 1 	 Obj 0 Tile 0 Pass FALSE                  Obj 0 Tile 30851 PASS TRUE
20, 1 	 Obj 0 Tile 0 Pass FALSE                  Obj 0 Tile 30851 PASS TRUE
21, 1 	 Obj 0 Tile 0 Pass FALSE                  Obj 0 Tile 30851 PASS TRUE
22, 1 	 Obj 0 Tile 0 Pass FALSE                  Obj 0 Tile 31004 PASS FALSE

17, 2 	 Obj 0 Tile 30902 Pass FALSE              Obj 0 Tile 31000 PASS FALSE
18, 2 	 Obj 0 Tile 30924 Pass FALSE              Obj 0 Tile 30851 PASS TRUE
19, 2 	 Obj 0 Tile 30918 Pass FALSE              Obj 0 Tile 30851 PASS TRUE
20, 2 	 Obj 0 Tile 30921 Pass FALSE              Obj 0 Tile 30851 PASS TRUE
21, 2 	 Obj 0 Tile 30927 Pass FALSE              Obj 0 Tile 30851 PASS TRUE
22, 2 	 Obj 0 Tile 30906 Pass FALSE              Obj 0 Tile 31004 PASS FALSE

17, 3 	 Obj 0 Tile 30903 Pass FALSE              Obj 0 Tile 31000 PASS FALSE
18, 3 	 Obj 0 Tile 30925 Pass FALSE              Obj 0 Tile 30851 PASS TRUE
19, 3 	 Obj 0 Tile 30919 Pass FALSE              Obj 0 Tile 30851 PASS TRUE
20, 3 	 Obj 0 Tile 30922 Pass FALSE              Obj 0 Tile 30851 PASS TRUE
21, 3 	 Obj 0 Tile 30928 Pass FALSE              Obj 0 Tile 30851 PASS TRUE
22, 3 	 Obj 0 Tile 30907 Pass FALSE              Obj 0 Tile 31004 PASS FALSE

17, 4 	 Obj 0 Tile 30904 Pass FALSE              Obj 0 Tile 31000 PASS FALSE
18, 4 	 Obj 16929 Tile 30925 Pass FALSE          Obj 0 Tile 30851 PASS TRUE
19, 4 	 Obj 0 Tile 30920 Pass FALSE              Obj 0 Tile 30851 PASS TRUE
20, 4 	 Obj 0 Tile 30923 Pass FALSE              Obj 0 Tile 30851 PASS TRUE
21, 4 	 Obj 0 Tile 30929 Pass FALSE              Obj 0 Tile 30851 PASS TRUE
22, 4 	 Obj 0 Tile 30908 Pass FALSE              Obj 0 Tile 31004 PASS FALSE

17, 5 	 Obj 0 Tile 36213 Pass FALSE              Obj 0 Tile 31000 PASS FALSE
18, 5 	 Obj 16929 Tile 30850 Pass FALSE          Obj 0 Tile 30851 PASS TRUE
19, 5 	 Obj 13501 Tile 30850 Pass FALSE          Obj 0 Tile 30851 PASS TRUE
20, 5 	 Obj 13502 Tile 30850 Pass FALSE          Obj 0 Tile 30851 PASS TRUE
21, 5 	 Obj 0 Tile 30850 Pass FALSE              Obj 0 Tile 30851 PASS TRUE
22, 5 	 Obj 0 Tile 36214 Pass FALSE              Obj 0 Tile 31004 PASS FALSE

17, 6 	 Obj 0 Tile 30991 Pass FALSE              Obj 0 Tile 31000 PASS FALSE
18, 6 	 Obj 16931 Tile 30850 Pass FALSE          Obj 0 Tile 30851 PASS TRUE
19, 6 	 Obj 0 Tile 30850 Pass FALSE              Obj 0 Tile 30851 PASS TRUE
20, 6 	 Obj 0 Tile 30850 Pass FALSE              Obj 0 Tile 30851 PASS TRUE
21, 6 	 Obj 0 Tile 30850 Pass FALSE              Obj 0 Tile 30851 PASS TRUE
22, 6 	 Obj 0 Tile 31004 Pass FALSE              Obj 0 Tile 31004 PASS FALSE





Room2
			Before:									After:
59, 42       Obj 0 	   Tile 0 Pass FALSE			 Obj 0 	   Tile 30172 Pass FALSE
59, 43       Obj 0     Tile 0 Pass FALSE             Obj 0     Tile 30173 Pass FALSE
59, 44       Obj 0     Tile 0 Pass FALSE             Obj 0     Tile 30174 Pass FALSE
59, 45       Obj 0     Tile 0 Pass FALSE             Obj 0     Tile 30851 Pass TRUE
59, 46       Obj 0     Tile 0 Pass FALSE             Obj 0     Tile 30851 Pass TRUE
59, 47       Obj 0     Tile 0 Pass FALSE             Obj 0     Tile 30851 Pass TRUE
59, 48       Obj 0     Tile 0 Pass FALSE             Obj 0     Tile 30851 Pass TRUE
59, 49       Obj 0     Tile 0 Pass FALSE             Obj 0     Tile 0 Pass FALSE

58, 42       Obj 0 	   Tile 30906 Pass FALSE			 Obj 0 	   Tile 30172 Pass FALSE
58, 43       Obj 0     Tile 30907 Pass FALSE             Obj 0     Tile 30173 Pass FALSE
58, 44       Obj 0     Tile 30908 Pass FALSE             Obj 0     Tile 30174 Pass FALSE
58, 45       Obj 0     Tile 30909 Pass FALSE             Obj 0     Tile 30851 Pass TRUE
58, 46       Obj 0     Tile 31002 Pass FALSE             Obj 0     Tile 30851 Pass TRUE
58, 47       Obj 0     Tile 31003 Pass FALSE             Obj 0     Tile 30851 Pass TRUE
58, 48       Obj 0     Tile 31004 Pass FALSE             Obj 0     Tile 30851 Pass TRUE
58, 49       Obj 0     Tile 31005 Pass FALSE             Obj 0     Tile 31005 Pass FALSE

57, 42       Obj 0 	   Tile 30927 Pass FALSE			 Obj 0 	   Tile 30172 Pass FALSE
57, 43       Obj 16929 Tile 30928 Pass FALSE             Obj 0     Tile 30173 Pass FALSE
57, 44       Obj 0     Tile 30929 Pass FALSE             Obj 0     Tile 30174 Pass FALSE
57, 45       Obj 16931 Tile 30851 Pass TRUE              Obj 0     Tile 30851 Pass TRUE
57, 46       Obj 13511 Tile 30851 Pass TRUE              Obj 0     Tile 30851 Pass TRUE
57, 47       Obj 0     Tile 30851 Pass TRUE              Obj 0     Tile 30851 Pass TRUE
57, 48       Obj 13506 Tile 30851 Pass TRUE              Obj 0     Tile 30851 Pass TRUE
57, 49       Obj 0     Tile 31008 Pass FALSE             Obj 0     Tile 31008 Pass FALSE



Room3

			Before:									After:
34, 4        Obj 0 	   Tile 30906 Pass FALSE			 Obj 0 	   Tile 30172 Pass FALSE
34, 5        Obj 0     Tile 30907 Pass FALSE             Obj 0     Tile 30173 Pass FALSE
34, 6        Obj 0     Tile 30908 Pass FALSE             Obj 0     Tile 30174 Pass FALSE
34, 7        Obj 0     Tile 30909 Pass FALSE             Obj 0     Tile 30851 Pass TRUE
34, 8        Obj 0     Tile 31003 Pass FALSE             Obj 0     Tile 30851 Pass TRUE
34, 9        Obj 0     Tile 31004 Pass FALSE             Obj 0     Tile 30851 Pass TRUE
34, 10       Obj 0     Tile 31005 Pass FALSE             Obj 0     Tile 31005 Pass FALSE


33, 4        Obj 0 	   Tile 30927 Pass FALSE			 Obj 0 	   Tile 30172 Pass FALSE
33, 5        Obj 0     Tile 30928 Pass FALSE             Obj 0     Tile 30173 Pass FALSE
33, 6        Obj 0     Tile 30929 Pass FALSE             Obj 0     Tile 30174 Pass FALSE
33, 7        Obj 16938 Tile 30851 Pass TRUE              Obj 0     Tile 30851 Pass TRUE
33, 8        Obj 0     Tile 30851 Pass TRUE              Obj 0     Tile 30851 Pass TRUE
33, 9        Obj 16935 Tile 30851 Pass TRUE              Obj 0     Tile 30851 Pass TRUE
33, 10       Obj 0     Tile 31006 Pass FALSE             Obj 0     Tile 31005 Pass FALSE


32, 4        Obj 0 	   Tile 30921 Pass FALSE			 Obj 0 	   Tile 30172 Pass FALSE
32, 5        Obj 0     Tile 30922 Pass FALSE             Obj 0     Tile 30173 Pass FALSE
32, 6        Obj 0     Tile 30923 Pass FALSE             Obj 0     Tile 30174 Pass FALSE
32, 7        Obj 16937 Tile 30851 Pass TRUE              Obj 0     Tile 30851 Pass TRUE
32, 8        Obj 16942 Tile 30851 Pass TRUE              Obj 0     Tile 30851 Pass TRUE
32, 9        Obj 0     Tile 30851 Pass TRUE              Obj 0     Tile 30851 Pass TRUE
32, 10       Obj 0     Tile 30851 Pass TRUE              Obj 0     Tile 30851 Pass TRUE



Room4
			Before:								After:
29, 15     Obj 0 Tile 30909 Pass FALSE			   Obj 0 Tile 30851 Pass TRUE
29, 16     Obj 0 Tile 31002 Pass FALSE             Obj 0 Tile 30851 Pass TRUE
29, 17     Obj 0 Tile 31003 Pass FALSE             Obj 0 Tile 30851 Pass TRUE
29, 18     Obj 0 Tile 31004 Pass FALSE             Obj 0 Tile 30851 Pass TRUE

28, 15     Obj 0     Tile 30851 Pass TRUE			   Obj 0 Tile 30851 Pass TRUE
28, 16     Obj 16920 Tile 30851 Pass TRUE             Obj 0 Tile 30851 Pass TRUE
28, 17     Obj 16939 Tile 30851 Pass TRUE             Obj 0 Tile 30851 Pass TRUE
28, 18     Obj 16941 Tile 30851 Pass TRUE             Obj 0 Tile 30851 Pass TRUE
]]--