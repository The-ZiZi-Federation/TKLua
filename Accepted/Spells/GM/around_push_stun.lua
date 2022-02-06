
around_push_stun = {

aroundCheck = function(block, type, cell)
	
	local m, x, y = block.m, block.x, block.y
	if cell == nil then cell = 1 end

	local blockAT = block:getObjectsInCell(m, x, y-1, type)
	local blockBW = block:getObjectsInCell(m, x, y+1, type)
	local blockKN = block:getObjectsInCell(m, x+1, y, type)
	local blockKR = block:getObjectsInCell(m, x-1, y, type)
	local blockATKN = block:getObjectsInCell(m, x+1, y-1, type)
	local blockATKR = block:getObjectsInCell(m, x-1, y-1, type)
	local blockBWKN = block:getObjectsInCell(m, x+1, y+1, type)
	local blockBWKR = block:getObjectsInCell(m, x-1, y+1, type)
	
	
	if #blockAT > 0 then
		for i = 1, #blockAT do
			if not blockAT[i]:hasDuration("stun") then 
				if checkResist(block, blockAT[i], "stun") == 0 then
					blockAT[i]:setDuration("stun",2500)
				end
			end
			check = around_push_stun.warpCheck(blockAT[i], blockAT[i].m, blockAT[i].x, blockAT[i].y-cell)
			if check == true then 
				blockAT[i]:warp(blockAT[i].m, blockAT[i].x, blockAT[i].y-cell) 
			end
		end
	end
	
	
	if #blockBW > 0 then
		for i = 1, #blockBW do
			if not blockBW[i]:hasDuration("stun") then 
				if checkResist(block, blockBW[i], "stun") == 0 then
					blockBW[i]:setDuration("stun",2500)
				end
			end
			check = around_push_stun.warpCheck(blockBW[i], blockBW[i].m, blockBW[i].x, blockBW[i].y+cell)
			if check == true then 
				blockBW[i]:warp(blockBW[i].m, blockBW[i].x, blockBW[i].y+cell) 
			
			end
		end
	end
	
	if #blockKN > 0 then
		for i = 1, #blockKN do
			if not blockKN[i]:hasDuration("stun") then 
				if checkResist(block, blockKN[i], "stun") == 0 then
					blockKN[i]:setDuration("stun",2500)
				end
			end
			check = around_push_stun.warpCheck(blockKN[i], blockKN[i].m, blockKN[i].x+cell, blockKN[i].y)
			if check == true then 
				blockKN[i]:warp(blockKN[i].m, blockKN[i].x+cell, blockKN[i].y) 
			
			end
		end
	end
	if #blockKR > 0 then
		for i = 1, #blockKR do
			if not blockKR[i]:hasDuration("stun") then 
				if checkResist(block, blockKR[i], "stun") == 0 then
					blockKR[i]:setDuration("stun",2500)
				end
			end
			check = around_push_stun.warpCheck(blockKR[i], blockKR[i].m, blockKR[i].x-cell, blockKR[i].y)
			if check == true then 
				blockKR[i]:warp(blockKR[i].m, blockKR[i].x-cell, blockKR[i].y) 
			
			end
		end
	end
	if #blockATKN > 0 then
		for i = 1, #blockATKN do
			if not blockATKN[i]:hasDuration("stun") then 
				if checkResist(block, blockATKN[i], "stun") == 0 then 
					blockATKN[i]:setDuration("stun",2500)
				end
			end
			check = around_push_stun.warpCheck(blockATKN[i], blockATKN[i].m, blockATKN[i].x+cell, blockATKN[i].y-cell)
			if check == true then 
				blockATKN[i]:warp(blockATKN[i].m, blockATKN[i].x+cell, blockATKN[i].y-cell) 
			
			end
		end
	end
	if #blockATKR > 0 then
		for i = 1, #blockATKR do
			if not blockATKR[i]:hasDuration("stun") then 
				if checkResist(block, blockATKR[i], "stun") == 0 then
					blockATKR[i]:setDuration("stun",2500)
				end
			end
			check = around_push_stun.warpCheck(blockATKR[i], blockATKR[i].m, blockATKR[i].x-cell, blockATKR[i].y-cell)
			if check == true then 
				blockATKR[i]:warp(blockATKR[i].m, blockATKR[i].x-cell, blockATKR[i].y-cell) 
			
			end
		end
	end
	if #blockBWKN > 0 then
		for i = 1, #blockBWKN do
			if not blockBWKN[i]:hasDuration("stun") then 
				if checkResist(block, blockBWKN[i], "stun") == 0 then
					blockBWKN[i]:setDuration("stun",2500)
				end
			end
			check = around_push_stun.warpCheck(blockBWKN[i], blockBWKN[i].m, blockBWKN[i].x+cell, blockBWKN[i].y+cell)
			if check == true then 
				blockBWKN[i]:warp(blockBWKN[i].m, blockBWKN[i].x+cell, blockBWKN[i].y+cell) 
			
			end
		end
	end
	if #blockBWKR > 0 then
		for i = 1, #blockBWKR do
			if not blockBWKR[i]:hasDuration("stun") then 
				if checkResist(block, blockBWKR[i], "stun") == 0 then
					blockBWKR[i]:setDuration("stun",2500)
				end
			end
			check = around_push_stun.warpCheck(blockBWKR[i], blockBWKR[i].m, blockBWKR[i].x-cell, blockBWKR[i].y+cell)
			if check == true then 
				blockBWKR[i]:warp(blockBWKR[i].m, blockBWKR[i].x-cell, blockBWKR[i].y+cell) 
			
			end
		end
	end
end,

warpCheck = function(block, m, x, y)
	
	local pass = getPass(m,x,y)
	local mob = block:getObjectsInCell(m,x,y, BL_MOB)
	local pc = block:getObjectsInCell(m,x,y, BL_PC)
	local npc = block:getObjectsInCell(m,x,y, BL_NPC)
	local nodes = {3007, 50101, 50102, 50103, 50104, 50106, 50107, 50108, 50109, 50511, 50512, 50513, 50514, 50516, 50517, 50518, 50519, 50520, 50521, 50522}



	for i = 1, #nodes do
		if block.mobID == nodes[i] then
			player:sendMinitext("Nope!")
		end
	end

	
	if pass == 0 then
		if #mob == 0 and #pc == 0 and #npc == 0 then
			return true
		end
	end
	return false
end
}