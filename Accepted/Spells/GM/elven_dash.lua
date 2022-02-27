elven_dash = {

on_learned = function(player) player.registry["learned_elven_dash"] = 1 end,
on_forget = function(player) player.registry["learned_elven_dash"] = 0 end,

cast = function(player)
	
	local magicCost = 1000
	local m, x, y, s = player.m, player.x, player.y, player.side
	local pc, mob, npc

	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	
--	player.magic = player.magic - magicCost
	player:sendStatus()
	player:playSound(30)
	player:sendAnimationXY(279, player.x, player.y)

	if player.drunk == 1 then
		player.side = math.random(0, 3)
		player:sendSide()
	end
	if s == 0 then
		pc, mob, npc = player:getObjectsInCell(m,x,y-7, BL_PC), player:getObjectsInCell(m,x,y-7, BL_MOB), player:getObjectsInCell(m,x,y-7, BL_NPC)
		if player:objectCanMoveFrom(x,y,0) then
			if getPass(m,x,y-1) == 0 and player:objectCanMove(x,y-1, 0) then
				if getPass(m,x,y-2) == 0 and player:objectCanMove(x,y-2, 0) then
					if getPass(m,x,y-3) == 0 and player:objectCanMove(x,y-3, 0) then
						if getPass(m,x,y-4) == 0 and player:objectCanMove(x,y-4, 0) then
							if getPass(m,x,y-5) == 0 and player:objectCanMove(x,y-5, 0) then
								if getPass(m,x,y-6) == 0 and player:objectCanMove(x,y-6, 0) then
									if getPass(m,x,y-7) == 0 and player:objectCanMove(x,y-7, 0) then
										if pc[1] ~= nil or mob[1] ~= nil or npc[1] ~= nil then 
											elven_dash.warp(player, m, x, y-6) 
											return 
										else
											elven_dash.warp(player, m, x, y-7)
											return
										end
									return else
										elven_dash.warp(player, m, x, y-6)
									end
								return else
									elven_dash.warp(player, m, x, y-5)
								end
							return else
								elven_dash.warp(player, m, x, y-4)
							end
						return else
							elven_dash.warp(player, m, x, y-3)
						end
					return else
						elven_dash.warp(player, m, x, y-2)
					end
				return else
					elven_dash.warp(player, m, x, y-1)
				end
			end
		end
		
	elseif s == 1 then
		pc = player:getObjectsInCell(m,x+7,y, BL_PC)
		mob = player:getObjectsInCell(m,x+7,y, BL_MOB)
		npc = player:getObjectsInCell(m,x+7,y, BL_NPC)
		
		if player:objectCanMoveFrom(x,y,0) then
			if getPass(m,x+1,y) == 0 and player:objectCanMove(x+1,y, 0) then
				if getPass(m,x+2,y) == 0 and player:objectCanMove(x+2,y, 0) then
					if getPass(m,x+3,y) == 0 and player:objectCanMove(x+3,y, 0) then
						if getPass(m,x+4,y) == 0 and player:objectCanMove(x+4,y, 0) then
							if getPass(m,x+5,y) == 0 and player:objectCanMove(x+5,y, 0) then
								if getPass(m,x+6,y) == 0 and player:objectCanMove(x+6,y, 0) then
									if getPass(m,x+7,y) == 0 and player:objectCanMove(x+7,y, 0) then
										if pc[1] ~= nil or mob[1] ~= nil or npc[1] ~= nil then 
											elven_dash.warp(player, m, x+6, y) 
											return 
										else
											elven_dash.warp(player, m, x+7, y)
											return
										end
									return else
										elven_dash.warp(player, m, x+6, y)
									end
								return else
									elven_dash.warp(player, m, x+5, y)
								end
							return else
								elven_dash.warp(player, m, x+4, y)
							end
						return else
							elven_dash.warp(player, m, x+3, y)
						end
					return else
						elven_dash.warp(player, m, x+2, y)
					end
				return else
					elven_dash.warp(player, m, x+1, y)
				end
			end
		end
	elseif s == 2 then
		pc = player:getObjectsInCell(m,x,y+7, BL_PC)
		mob = player:getObjectsInCell(m,x,y+7, BL_MOB)
		npc = player:getObjectsInCell(m,x,y+7, BL_NPC)
		
				
		if player:objectCanMoveFrom(x,y,0) then
			if getPass(m,x,y+1) == 0 and player:objectCanMove(x,y+1, 0) then
				if getPass(m,x,y+2) == 0 and player:objectCanMove(x,y+2, 0) then
					if getPass(m,x,y+3) == 0 and player:objectCanMove(x,y+3, 0) then
						if getPass(m,x,y+4) == 0 and player:objectCanMove(x,y+4, 0) then
							if getPass(m,x,y+5) == 0 and player:objectCanMove(x,y+5, 0) then
								if getPass(m,x,y+6) == 0 and player:objectCanMove(x,y+6, 0) then
									if getPass(m,x,y+7) == 0 and player:objectCanMove(x,y+7, 0) then
										if pc[1] ~= nil or mob[1] ~= nil or npc[1] ~= nil then 
											elven_dash.warp(player, m, x, y+6) 
											return 
										else
											elven_dash.warp(player, m, x, y+7)
											return
										end
									return else
										elven_dash.warp(player, m, x, y+6)
									end
								return else
									elven_dash.warp(player, m, x, y+5)
								end
							return else
								elven_dash.warp(player, m, x, y+4)
							end
						return else
							elven_dash.warp(player, m, x, y+3)
						end
					return else
						elven_dash.warp(player, m, x, y+2)
					end
				return else
					elven_dash.warp(player, m, x, y+1)
				end
			end
		end
	elseif s == 3 then
		pc = player:getObjectsInCell(m,x-7,y, BL_PC)
		mob = player:getObjectsInCell(m,x-7,y, BL_MOB)
		npc = player:getObjectsInCell(m,x-7,y, BL_NPC)
		
		if player:objectCanMoveFrom(x,y,0) then
			if getPass(m,x-1,y) == 0 and player:objectCanMove(x-1,y, 0) then
				if getPass(m,x-2,y) == 0 and player:objectCanMove(x-2,y, 0) then
					if getPass(m,x-3,y) == 0 and player:objectCanMove(x-3,y, 0) then
						if getPass(m,x-4,y) == 0 and player:objectCanMove(x-4,y, 0) then
							if getPass(m,x-5,y) == 0 and player:objectCanMove(x-5,y, 0) then
								if getPass(m,x-6,y) == 0 and player:objectCanMove(x-6,y, 0) then
									if getPass(m,x-7,y) == 0 and player:objectCanMove(x-7,y, 0) then
										if pc[1] ~= nil or mob[1] ~= nil or npc[1] ~= nil then 
											elven_dash.warp(player, m, x-6, y) 
											return 
										else
											elven_dash.warp(player, m, x-7, y)
											return
										end
									return else
										elven_dash.warp(player, m, x-6, y)
									end
								return else
									elven_dash.warp(player, m, x-5, y)
								end
							return else
								elven_dash.warp(player, m, x-4, y)
							end
						return else
							elven_dash.warp(player, m, x-3, y)
						end
					return else
						elven_dash.warp(player, m, x-2, y)
					end
				return else
					elven_dash.warp(player, m, x-1, y)
				end
			end
		end
	end
end,

warp = function(player, m, x, y)


	player:warp(m, x, y)
	elven_dash.act(player)
end,

act = function(player)

	player:sendAction(6, 20)
	player:sendAnimation(280)
	player:sendAnimationXY(279, player.x, player.y)
	player:sendMinitext("You cast Elven Dash")
end
}








--[[
elven_dash = {

on_learned = function(player) player.registry["learned_elven_dash"] = 1 end,
on_forget = function(player) player.registry["learned_elven_dash"] = 0 end,

cast = function(player)
	
	local magicCost = 1000
	local m, x, y, s = player.m, player.x, player.y, player.side

	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:playSound(30)
	player:sendAnimationXY(279, player.x, player.y)

	if player.drunk == 1 then
		player.side = math.random(0, 3)
		player:sendSide()
	end
	if s == 0 then
		pc, mob, npc = player:getObjectsInCell(m,x,y-3, BL_PC), player:getObjectsInCell(m,x,y-3, BL_MOB), player:getObjectsInCell(m,x,y-3, BL_NPC)

		if player:objectCanMoveFrom(x,y,0) then
			if getPass(m,x,y-1) == 0 and player:objectCanMove(x,y-1, 0) then
				if getPass(m,x,y-2) == 0 and player:objectCanMove(x,y-2, 0) then
					if getPass(m,x,y-3) == 0 and player:objectCanMove(x,y-3, 0) then
						if pc[1] ~= nil or mob[1] ~= nil or npc[1] ~= nil then elven_dash.warp(player, m, x, y-2) return else
							elven_dash.warp(player, m, x, y-3)
							return
						end
					return else
						elven_dash.warp(player, m, x, y-2)
					end
				return else
					elven_dash.warp(player, m, x, y-1)
				end
			end
		end
	elseif s == 1 then
		pc = player:getObjectsInCell(m,x+3,y, BL_PC)
		mob = player:getObjectsInCell(m,x+3,y, BL_MOB)
		npc = player:getObjectsInCell(m,x+3,y, BL_NPC)
		
		if getPass(m,x+1,y) == 0 then	
			if getPass(m,x+2,y) == 0 then	
				if getPass(m,x+3,y) == 0 then
					if pc[1] ~= nil or mob[1] ~= nil or npc[1] ~= nil then elven_dash.warp(player, m, x+2, y) return else
						elven_dash.warp(player, m, x+3, y)
						return
					end
				return else	
					elven_dash.warp(player, m, x+2, y)
				end	
			return else	
				elven_dash.warp(player, m, x+1, y)	
			end	
		end	
	elseif s == 2 then
		pc = player:getObjectsInCell(m,x,y+3, BL_PC)
		mob = player:getObjectsInCell(m,x,y+3, BL_MOB)
		npc = player:getObjectsInCell(m,x,y+3, BL_NPC)
		
		if getPass(m,x,y+1) == 0 and player:objectCanMove(x,y+1,0) then
			if getPass(m,x,y+2) == 0 and player:objectCanMove(x,y+2,0) then
				if getPass(m,x,y+3) == 0 and player:objectCanMove(x,y+3,0) then
					if pc[1] ~= nil or mob[1] ~= nil or npc[1] ~= nil then elven_dash.warp(player, m, x, y+2) return else
						elven_dash.warp(player, m, x, y+3)
						return
					end
				return else
					elven_dash.warp(player, m, x, y+2)	
				end	
			return else	
				elven_dash.warp(player, m, x, y+1)
			end	
		end	
	elseif s == 3 then
		pc = player:getObjectsInCell(m,x-3,y, BL_PC)
		mob = player:getObjectsInCell(m,x-3,y, BL_MOB)
		npc = player:getObjectsInCell(m,x-3,y, BL_NPC)
		
		if getPass(m,x-1,y) == 0 then	
			if getPass(m,x-2,y) == 0 then	
				if getPass(m,x-3,y) == 0 then
					if pc[1] ~= nil or mob[1] ~= nil or npc[1] ~= nil then elven_dash.warp(player, m, x-2, y) return else
						elven_dash.warp(player, m, x-3, y)
						return
					end
				return else	
					elven_dash.warp(player, m, x-2, y)
				end	
			return else	
				elven_dash.warp(player, m, x-1, y)
			end	
		end	
	end
end,

warp = function(player, m, x, y)
	
	local obj = 0
	local xx, yy = 0, 0

	if player.m == 30028 or player.m == 30029 then
		for i = 1, 3 do
			if player.side == 0 then
				obj = getObject(player.m, player.x, player.y-i)
			elseif player.side == 1 then
				obj = getObject(player.m, player.x+i, player.y)
			elseif player.side == 2 then
				obj = getObject(player.m, player.x, player.y+i)
			elseif player.side == 3 then
				obj = getObject(player.m, player.x-i, player.y)
			end
			if obj == 11210 or obj == 11211 then
				if i == 3 then
					frontWarp(player, 2)
					elven_dash.act(player)
				elseif i == 2 then
					frontWarp(player, 1)
					elven_dash.act(player)
				end
				return
			end
		end
	end

	player:warp(m, x, y)
	elven_dash.act(player)
	sumo.walk(player)
	if m == 30028 or m == 30029 then velo_mall.walk(player) end
end,

act = function(player)

	player:sendAction(6, 20)
	player:sendAnimation(280)
	player:sendAnimationXY(279, player.x, player.y)
	player:sendMinitext("You cast Elven Dash")
end
}
]]--