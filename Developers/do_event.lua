----------[[ Player 'Do' event ]]---------------------------------------------------
	
	--> setBarricade(block)						 --> canPush(block, target, push)
	--> cinv(player)                             --> canAmbush(block, target, ambush)
	--> toStart                                  --> fourPush(block, blockType)
	--> toStart(mob, x, y)                       --> roomExpTotal(block, room, minutes)
	--> toObject(mob, object)                    --> asyncDialog(player, definer)
	--> toXY(block, x, y)            
	--> faceAway(block1, thirdparam) 
	--> addSpotTrap(block, map, x, y)
	--> removeTrap(npc)              
	--> pushBack(player)             
	
---------------------------------------------------------------------------------------

remount = function(player)
	
	player:updateState()
end
	
setBarricade = function(block)
	setObject(block.m, block.x, block.y, 16545)
end

cspells = function(player)

	local yname = player:getSpells()
	local list = {}
	
	if #yname > 0 then
		for i = 1, #yname do
			player:removeSpell(yname[i])
		end
		player:sendMinitext("Done!!")
		player:sendStatus()
	else
		anim(player)
		player:sendMinitext("You don't have any spell to delete.")
	end
end
		
	
cfloor = function(m, x, y, block)

	local itemBlocks = block:getObjectsInCell(m, x, y, BL_ITEM)
	local itemReturns = {}
	
	if (#itemBlocks > 0) then
		for i = 1,#itemBlocks do
			table.insert(itemReturns, itemBlocks[i].id)
			itemBlocks[i]:delete()
		end
	end
	return itemReturns
end

cinv = function(player)

    local item
    for i = 0, player.maxInv do
        item = player:getInventoryItem( i )
        if (item ~= nil) then
            player:removeItem(item.id, item.amount)
			player:sendMinitext("Done!!")
        end
    end
end

toStart = function(mob, x, y)

	local canmove = 0
	local found = 0
	local checkmove = math.random(0,2)
	
	if(checkmove >= 1) then
		if(mob.y < y) then
			mob.side = 2
			mob:sendSide()
			canmove = mob:move()
		end
		if(mob.y > y and canmove == 0) then
			mob.side = 0
			mob:sendSide()
			canmove = mob:move()
		end
		if(mob.x < x and canmove == 0) then
			mob.side = 1
			mob:sendSide()
			canmove = mob:move()
		end
		if(mob.x > x and canmove == 0) then
			mob.side = 3
			mob:sendSide()
			canmove = mob:move()
		end
	else
		if(mob.x < x) then
			mob.side = 1
			mob:sendSide()
			canmove = mob:move()
		end
		if(mob.x > x and canmove == 0) then
			mob.side = 3
			mob:sendSide()
			canmove = mob:move()
		end
		if(mob.y < y and canmove == 0) then
			mob.side = 2
			mob:sendSide()
			canmove = mob:move()
		end
		if(mob.y > y and canmove == 0) then
			mob.side = 0
			mob:sendSide()
			canmove = mob:move()
		end
	end
	
	if(mob.x == x and mob.y == y) then
		return true
	elseif(canmove == 0) then
		for i=0,10 do
			if(found == 0) then
				mob.side=math.random(0,3)
				mob:sendSide()
				found=mob:move()
			end
		end
	end
end

toObject = function(mob, object)

	local canmove = 0
	local found = 0
	local checkmove = math.random(0,2)
	
	if(checkmove >= 1) then
		if(mob.y < object.y) then
			mob.side = 2
			mob:sendSide()
			canmove = mob:move()
		end
		if(mob.y > object.y and canmove == 0) then
			mob.side = 0
			mob:sendSide()
			canmove = mob:move()
		end
		if(mob.x < object.x and canmove == 0) then
			mob.side = 1
			mob:sendSide()
			canmove = mob:move()
		end
		if(mob.x > object.x and canmove == 0) then
			mob.side = 3
			mob:sendSide()
			canmove = mob:move()
		end
	else
		if(mob.x < object.x) then
			mob.side = 1
			mob:sendSide()
			canmove = mob:move()
		end
		if(mob.x > object.x and canmove == 0) then
			mob.side = 3
			mob:sendSide()
			canmove = mob:move()
		end
		if(mob.y < object.y and canmove == 0) then
			mob.side = 2
			mob:sendSide()
			canmove = mob:move()
		end
		if(mob.y > object.y and canmove == 0) then
			mob.side = 0
			mob:sendSide()
			canmove = mob:move()
		end
	end
	
	if(mob.x == object.x and mob.y == object.y) then
		return true
	elseif(canmove == 0) then
		for i=0,10 do
			if(found == 0) then
				mob.side=math.random(0,3)
				mob:sendSide()
				found=mob:move()
			end
		end
	end
end

toXY = function(block, x, y)
	
	local canmove = 0
	local found = 0
	local checkmove = math.random(0,2)
	
	if (checkmove >= 1) then
		if (block.y < y) then
			block.side = 2
			block:sendSide()
			canmove = block:move()
		end
		if (block.y > y and canmove == 0) then
			block.side = 0
			block:sendSide()
			canmove = block:move()
		end
		if (block.x < x and canmove == 0) then
			block.side = 1
			block:sendSide()
			canmove = block:move()
		end
		if (block.x > x and canmove == 0) then
			block.side = 3
			block:sendSide()
			canmove = block:move()
		end
	else
		if (block.x < x) then
			block.side = 1
			block:sendSide()
			canmove = block:move()
		end
		if(block.x > x and canmove == 0) then
			block.side = 3
			block:sendSide()
			canmove = block:move()
		end
		if (block.y < y and canmove == 0) then
			block.side = 2
			block:sendSide()
			canmove = block:move()
		end
		if (block.y > y and canmove == 0) then
			block.side = 0
			block:sendSide()
			canmove = block:move()
		end
	end
	
	if (block.x == x and block.y == y) then
		return true
	elseif (canmove == 0) then
		for i = 0, 10 do
			if (found == 0) then
				block.side = math.random(0,3)
				block:sendSide()
				found = block:move()
			end
		end
	end
end

faceAway=function(block1,thirdparam)

	local side1 = block1.side
	--local side2 = block2.side
	local block2tab = {}
		
	if (thirdparam ~= nil) then
		local block2 = {}
		if (side1 == 0) then--up
			block2tab = block1:getObjectsInCell(block1.m, block1.x, block1.y - 1, BL_PC)
			if (#block2tab > 0) then
				block2 = block2tab[#block2tab]
			else
				return
			end
			block2.side = 0
		elseif (side1 == 1) then--right
			block2tab = block1:getObjectsInCell(block1.m, block1.x + 1, block1.y, BL_PC)
			if (#block2tab > 0) then
				block2 = block2tab[#block2tab]
			else
				return
			end
			block2.side = 1
		elseif (side1 == 2) then--down
			block2tab = block1:getObjectsInCell(block1.m, block1.x, block1.y + 1, BL_PC)
			if (#block2tab > 0) then
				block2 = block2tab[#block2tab]
			else
				return
			end
			block2.side = 2
		elseif (side1 == 3) then--left
			block2tab = block1:getObjectsInCell(block1.m, block1.x - 1, block1.y, BL_PC)
			if (#block2tab > 0) then
				block2 = block2tab[#block2tab]
			else
				return
			end
			block2.side = 3
		end
	else
	
	end
	block2:sendSide()
end



pushBack = function(player)
	
	if (player.side == 0) then
		player:warp(player.m, player.x, player.y + 1)
	elseif (player.side == 1) then
		player:warp(player.m, player.x - 1, player.y)
	elseif (player.side == 2) then
		player:warp(player.m, player.x, player.y - 1)
	elseif (player.side == 3) then
		player:warp(player.m, player.x + 1, player.y)
	end
end

canPush = function(block, target, push)
	
	if block.registry["v_open"] > 0 then return false end
	
	if (target == nil) then
		return nil
	elseif (target.blType == BL_NPC and (target.subType == 2 or target.subType == 3)) then
		return false
	elseif (target.blType == BL_ITEM) then
		return false
	elseif (target:getObjectsInCell(target.m, target.x, target.y, BL_ITEM)[1] ~= nil) then
		return false
	end
	
	if (block.side == 0) then
		local checkPCNorth = block:getObjectsInCell(block.m, block.x, block.y - 2, BL_PC)
		local checkMobNorth = block:getObjectsInCell(block.m, block.x, block.y - 2, BL_MOB)
		local checkNPCNorth = block:getObjectsInCell(block.m, block.x, block.y - 2, BL_NPC)
		
		local checkPCEast = block:getObjectsInCell(block.m, block.x + 1, block.y - 1, BL_PC)
		local checkMobEast = block:getObjectsInCell(block.m, block.x + 1, block.y - 1, BL_MOB)
		local checkNPCEast = block:getObjectsInCell(block.m, block.x + 1, block.y - 1, BL_NPC)
		
		local checkPCWest = block:getObjectsInCell(block.m, block.x - 1, block.y - 1, BL_PC)
		local checkMobWest = block:getObjectsInCell(block.m, block.x - 1, block.y - 1, BL_MOB)
		local checkNPCWest = block:getObjectsInCell(block.m, block.x - 1, block.y - 1, BL_NPC)

		if (#checkNPCNorth > 0) then i = 0
			repeat
				i = i + 1
				if (checkNPCNorth[i].subType == 2 or checkNPCNorth[i].subType == 3) then
					table.remove(checkNPCNorth, i)
					i = i - 1
				end
			until (i == #checkNPCNorth)
		end
		
		if (#checkNPCEast > 0) then
			i = 0
			
			repeat
				i = i + 1
				
				if (checkNPCEast[i].subType == 2 or checkNPCEast[i].subType == 3) then
					table.remove(checkNPCEast, i)
					i = i - 1
				end
			until (i == #checkNPCEast)
		end
		
		if (#checkNPCWest > 0) then
			i = 0
			
			repeat
				i = i + 1
				
				if (checkNPCWest[i].subType == 2 or checkNPCWest[i].subType == 3) then
					table.remove(checkNPCWest, i)
					i = i - 1
				end
			until (i == #checkNPCWest)
		end
		
		if (block.showGhosts == 1) then
			if (#checkPCNorth > 0) then
				i = 0
				
				repeat
					i = i + 1
					
					if (checkPCNorth[i].state == 1) then
						table.remove(checkPCNorth, i)
						i = i - 1
					end
				until (i == #checkPCNorth)
			end
			
			if (#checkPCEast > 0) then
				i = 0
				
				repeat
					i = i + 1
					
					if (checkPCEast[i].state == 1) then
						table.remove(checkPCEast, i)
						i = i - 1
					end
				until (i == #checkPCEast)
			end
			
			if (#checkPCWest > 0) then
				i = 0
				
				repeat
					i = i + 1
					
					if (checkPCWest[i].state == 1) then
						table.remove(checkPCWest, i)
						i = i - 1
					end
				until (i == #checkPCWest)
			end
		end
		
		if (block.y - 2 > 0 and #checkPCNorth + #checkMobNorth + #checkNPCNorth == 0 and block:objectCanMove(block.x, block.y - 2, 0) == true and getPass(block.m, block.x, block.y - 2) == 0 and  not getWarp(block.m, block.x, block.y -2 )) then
			if (push == nil) then
				target:warp(block.m, block.x, block.y - 2)
			else
				return true
			end
		elseif (block.x + 1 <= block.xmax and #checkPCEast + #checkMobEast + #checkNPCEast == 0 and block:objectCanMove(block.x + 1, block.y - 1, 1) == true and getPass(block.m, block.x + 1, block.y - 1) == 0 and not getWarp(block.m, block.x + 1, block.y - 1)) then
			if (push == nil) then
				target:warp(block.m, block.x + 1, block.y - 1)
			else
				return true
			end
		elseif (block.x - 1 > 0 and #checkPCWest + #checkMobWest + #checkNPCWest == 0 and block:objectCanMove(block.x - 1, block.y - 1, 3) == true and getPass(block.m, block.x - 1, block.y - 1) == 0 and not getWarp(block.m, block.x - 1, block.y - 1)) then
			if (push == nil) then
				target:warp(block.m, block.x - 1, block.y - 1)
			else
				return true
			end
		else
			return false
		end
	elseif (block.side == 1) then
		local checkPCEast = block:getObjectsInCell(block.m, block.x + 2, block.y, BL_PC)
		local checkMobEast = block:getObjectsInCell(block.m, block.x + 2, block.y, BL_MOB)
		local checkNPCEast = block:getObjectsInCell(block.m, block.x + 2, block.y, BL_NPC)

		local checkPCNorth = block:getObjectsInCell(block.m, block.x + 1, block.y - 1, BL_PC)
		local checkMobNorth = block:getObjectsInCell(block.m, block.x + 1, block.y - 1, BL_MOB)
		local checkNPCNorth = block:getObjectsInCell(block.m, block.x + 1, block.y - 1, BL_NPC)

		local checkPCSouth = block:getObjectsInCell(block.m, block.x + 1, block.y + 1, BL_PC)
		local checkMobSouth = block:getObjectsInCell(block.m, block.x + 1, block.y + 1, BL_MOB)
		local checkNPCSouth = block:getObjectsInCell(block.m, block.x + 1, block.y + 1, BL_NPC)

		if (#checkNPCNorth > 0) then
			i = 0
			
			repeat
				i = i + 1
				
				if (checkNPCNorth[i].subType == 2 or checkNPCNorth[i].subType == 3) then
					table.remove(checkNPCNorth, i)
					i = i - 1
				end
			until (i == #checkNPCNorth)
		end
		
		if (#checkNPCEast > 0) then
			i = 0
			
			repeat
				i = i + 1
				
				if (checkNPCEast[i].subType == 2 or checkNPCEast[i].subType == 3) then
					table.remove(checkNPCEast, i)
					i = i - 1
				end
			until (i == #checkNPCEast)
		end
		
		if (#checkNPCSouth > 0) then
			i = 0
			
			repeat
				i = i + 1
				
				if (checkNPCSouth[i].subType == 2 or checkNPCSouth[i].subType == 3) then
					table.remove(checkNPCSouth, i)
					i = i - 1
				end
			until (i == #checkNPCSouth)
		end
		
		if (block.showGhosts == 1) then
			if (#checkPCNorth > 0) then
				i = 0
				
				repeat
					i = i + 1
					
					if (checkPCNorth[i].state == 1) then
						table.remove(checkPCNorth, i)
						i = i - 1
					end
				until (i == #checkPCNorth)
			end
			
			if (#checkPCSouth > 0) then
				i = 0
				
				repeat
					i = i + 1
					
					if (checkPCSouth[i].state == 1) then
						table.remove(checkPCSouth, i)
						i = i - 1
					end
				until (i == #checkPCSouth)
			end
			
			if (#checkPCEast > 0) then
				i = 0
				
				repeat
					i = i + 1
					
					if (checkPCEast[i].state == 1) then
						table.remove(checkPCEast, i)
						i = i - 1
					end
				until (i == #checkPCEast)
			end
		end
		
		if (block.x + 2 <= block.xmax and #checkPCEast + #checkMobEast + #checkNPCEast == 0 and block:objectCanMove(block.x + 2, block.y, 1) == true and getPass(block.m, block.x + 2, block.y) == 0 and not getWarp(block.m, block.x + 2, block.y)) then
			if (push == nil) then
				target:warp(block.m, block.x + 2, block.y)
			else
				return true
			end
		elseif (block.y - 1 > 0 and #checkPCNorth + #checkMobNorth + #checkNPCNorth == 0 and block:objectCanMove(block.x + 1, block.y - 1, 0) == true and getPass(block.m, block.x + 1, block.y - 1) == 0 and not getWarp(block.m, block.x + 1, block.y - 1)) then
			if (push == nil) then
				target:warp(block.m, block.x + 1, block.y - 1)
			else
				return true
			end
		elseif (block.y + 1 <= block.ymax and #checkPCSouth + #checkMobSouth + #checkNPCSouth == 0 and block:objectCanMove(block.x + 1, block.y + 1, 2) == true and getPass(block.m, block.x + 1, block.y + 1) == 0 and not getWarp(block.m, block.x + 1, block.y + 1)) then
			if (push == nil) then
				target:warp(block.m, block.x + 1, block.y + 1)
			else
				return true
			end
		else
			return false
		end
	elseif (block.side == 2) then
		local checkPCSouth = block:getObjectsInCell(block.m, block.x, block.y + 2, BL_PC)
		local checkMobSouth = block:getObjectsInCell(block.m, block.x, block.y + 2, BL_MOB)
		local checkNPCSouth = block:getObjectsInCell(block.m, block.x, block.y + 2, BL_NPC)

		local checkPCEast = block:getObjectsInCell(block.m, block.x + 1, block.y + 1, BL_PC)
		local checkMobEast = block:getObjectsInCell(block.m, block.x + 1, block.y + 1, BL_MOB)
		local checkNPCEast = block:getObjectsInCell(block.m, block.x + 1, block.y + 1, BL_NPC)

		local checkPCWest = block:getObjectsInCell(block.m, block.x - 1, block.y + 1, BL_PC)
		local checkMobWest = block:getObjectsInCell(block.m, block.x - 1, block.y + 1, BL_MOB)
		local checkNPCWest = block:getObjectsInCell(block.m, block.x - 1, block.y + 1, BL_NPC)

		if (#checkNPCSouth > 0) then
			i = 0
			
			repeat
				i = i + 1
				
				if (checkNPCSouth[i].subType == 2 or checkNPCSouth[i].subType == 3) then
					table.remove(checkNPCSouth, i)
					i = i - 1
				end
			until (i == #checkNPCSouth)
		end
		
		if (#checkNPCEast > 0) then
			i = 0
			
			repeat
				i = i + 1
				
				if (checkNPCEast[i].subType == 2 or checkNPCEast[i].subType == 3) then
					table.remove(checkNPCEast, i)
					i = i - 1
				end
			until (i == #checkNPCEast)
		end
		
		if (#checkNPCWest > 0) then
			i = 0
			
			repeat
				i = i + 1
				
				if (checkNPCWest[i].subType == 2 or checkNPCWest[i].subType == 3) then
					table.remove(checkNPCWest, i)
					i = i - 1
				end
			until (i == #checkNPCWest)
		end
		
		if (block.showGhosts == 1) then
			if (#checkPCEast > 0) then
				i = 0
				
				repeat
					i = i + 1
					
					if (checkPCEast[i].state == 1) then
						table.remove(checkPCEast, i)
						i = i - 1
					end
				until (i == #checkPCEast)
			end
			
			if (#checkPCSouth > 0) then
				i = 0
				
				repeat
					i = i + 1
					
					if (checkPCSouth[i].state == 1) then
						table.remove(checkPCSouth, i)
						i = i - 1
					end
				until (i == #checkPCSouth)
			end
			
			if (#checkPCWest > 0) then
				i = 0
				
				repeat
					i = i + 1
					
					if (checkPCWest[i].state == 1) then
						table.remove(checkPCWest, i)
						i = i - 1
					end
				until (i == #checkPCWest)
			end
		end
		
		if (block.y + 2 <= block.ymax and #checkPCSouth + #checkMobSouth + #checkNPCSouth == 0 and block:objectCanMove(block.x, block.y + 2, 2) == true and getPass(block.m, block.x, block.y + 2) == 0 and not getWarp(block.m, block.x, block.y + 2)) then
			if (push == nil) then
				target:warp(block.m, block.x, block.y + 2)
			else
				return true
			end
		elseif (block.x + 1 <= block.xmax and #checkPCEast + #checkMobEast + #checkNPCEast == 0 and block:objectCanMove(block.x + 1, block.y + 1, 1) == true and getPass(block.m, block.x + 1, block.y + 1) == 0 and not getWarp(block.m, block.x + 1, block.y + 1)) then
			if (push == nil) then
				target:warp(block.m, block.x + 1, block.y + 1)
			else
				return true
			end
		elseif (block.x - 1 > 0 and #checkPCWest + #checkMobWest + #checkNPCWest == 0 and block:objectCanMove(block.x - 1, block.y + 1, 3) == true and getPass(block.m, block.x - 1, block.y + 1) == 0 and not getWarp(block.m, block.x - 1, block.y + 1)) then
			if (push == nil) then
				target:warp(block.m, block.x - 1, block.y + 1)
			else
				return true
			end
		else
			return false
		end
	elseif (block.side == 3) then
		local checkPCWest = block:getObjectsInCell(block.m, block.x - 2, block.y, BL_PC)
		local checkMobWest = block:getObjectsInCell(block.m, block.x - 2, block.y, BL_MOB)
		local checkNPCWest = block:getObjectsInCell(block.m, block.x - 2, block.y, BL_NPC)
		
		local checkPCNorth = block:getObjectsInCell(block.m, block.x - 1, block.y - 1, BL_PC)
		local checkMobNorth = block:getObjectsInCell(block.m, block.x - 1, block.y - 1, BL_MOB)
		local checkNPCNorth = block:getObjectsInCell(block.m, block.x - 1, block.y - 1, BL_NPC)
		
		local checkPCSouth = block:getObjectsInCell(block.m, block.x - 1, block.y + 1, BL_PC)
		local checkMobSouth = block:getObjectsInCell(block.m, block.x - 1, block.y + 1, BL_MOB)
		local checkNPCSouth = block:getObjectsInCell(block.m, block.x - 1, block.y + 1, BL_NPC)

		if (#checkNPCNorth > 0) then
			i = 0
			
			repeat
				i = i + 1
				
				if (checkNPCNorth[i].subType == 2 or checkNPCNorth[i].subType == 3) then
					table.remove(checkNPCNorth, i)
					i = i - 1
				end
			until (i == #checkNPCNorth)
		end
		
		if (#checkNPCSouth > 0) then
			i = 0
			
			repeat
				i = i + 1
				
				if (checkNPCSouth[i].subType == 2 or checkNPCSouth[i].subType == 3) then
					table.remove(checkNPCSouth, i)
					i = i - 1
				end
			until (i == #checkNPCSouth)
		end
		
		if (#checkNPCWest > 0) then
			i = 0
			
			repeat
				i = i + 1
				
				if (checkNPCWest[i].subType == 2 or checkNPCWest[i].subType == 3) then
					table.remove(checkNPCWest, i)
					i = i - 1
				end
			until (i == #checkNPCWest)
		end
		
		if (block.showGhosts == 1) then
			if (#checkPCNorth > 0) then
				i = 0
				
				repeat
					i = i + 1
					
					if (checkPCNorth[i].state == 1) then
						table.remove(checkPCNorth, i)
						i = i - 1
					end
				until (i == #checkPCNorth)
			end
			
			if (#checkPCSouth > 0) then
				i = 0
				
				repeat
					i = i + 1
					
					if (checkPCSouth[i].state == 1) then
						table.remove(checkPCSouth, i)
						i = i - 1
					end
				until (i == #checkPCSouth)
			end
			
			if (#checkPCWest > 0) then
				i = 0
				
				repeat
					i = i + 1
					
					if (checkPCWest[i].state == 1) then
						table.remove(checkPCWest, i)
						i = i - 1
					end
				until (i == #checkPCWest)
			end
		end
		
		if(block.x - 2 > 0 and #checkPCWest + #checkMobWest + #checkNPCWest == 0 and block:objectCanMove(block.x - 2, block.y, 3) == true and getPass(block.m, block.x - 2, block.y) == 0 and not getWarp(block.m, block.x - 2, block.y)) then
			if (push == nil) then
				target:warp(block.m, block.x - 2, block.y)
			else
				return true
			end
		elseif (block.y - 1 > 0 and #checkPCNorth + #checkMobNorth + #checkNPCNorth == 0 and block:objectCanMove(block.x - 1, block.y - 1, 0) == true and getPass(block.m, block.x - 1, block.y - 1) == 0 and not getWarp(block.m, block.x - 1, block.y - 1)) then
			if (push == nil) then
				target:warp(block.m, block.x - 1, block.y - 1)
			else
				return true
			end
		elseif (block.y + 1 <= block.ymax and #checkPCSouth + #checkMobSouth + #checkNPCSouth == 0 and block:objectCanMove(block.x - 1, block.y + 1, 2) == true and getPass(block.m, block.x - 1, block.y + 1) == 0 and not getWarp(block.m, block.x - 1, block.y + 1)) then
			if (push == nil) then
				target:warp(block.m, block.x - 1, block.y + 1)
			else
				return true
			end
		else
			return false
		end
	end	
	
	return false
end

canAmbush = function(block, target, ambush)
	
	if (target == nil) then
		return nil
	elseif (target.blType == BL_NPC and (target.subType == 2 or target.subType == 3)) then
		return false
	elseif (target.blType == BL_ITEM) then
		return false
	end
	



	if (block.side == 0) then
		local checkPCNorth = target:getObjectsInCell(target.m, target.x, target.y - 1, BL_PC)
		local checkMobNorth = target:getObjectsInCell(target.m, target.x, target.y - 1, BL_MOB)
		local checkNPCNorth = target:getObjectsInCell(target.m, target.x, target.y - 1, BL_NPC)
		
		local checkPCEast = target:getObjectsInCell(target.m, target.x + 1, target.y, BL_PC)
		local checkMobEast = target:getObjectsInCell(target.m, target.x + 1, target.y, BL_MOB)
		local checkNPCEast = target:getObjectsInCell(target.m, target.x + 1, target.y, BL_NPC)
		
		local checkPCWest = target:getObjectsInCell(target.m, target.x - 1, target.y, BL_PC)
		local checkMobWest = target:getObjectsInCell(target.m, target.x - 1, target.y, BL_MOB)
		local checkNPCWest = target:getObjectsInCell(target.m, target.x - 1, target.y, BL_NPC)

		if (#checkNPCNorth > 0) then
			i = 0
			
			repeat
				i = i + 1
				
				if (checkNPCNorth[i].subType == 2 or checkNPCNorth[i].subType == 3) then
					table.remove(checkNPCNorth, i)
					i = i - 1
				end
			until (i == #checkNPCNorth)
		end
		
		if (#checkNPCEast > 0) then
			i = 0
			
			repeat
				i = i + 1
				
				if (checkNPCEast[i].subType == 2 or checkNPCEast[i].subType == 3) then
					table.remove(checkNPCEast, i)
					i = i - 1
				end
			until (i == #checkNPCEast)
		end
		
		if (#checkNPCWest > 0) then
			i = 0
			
			repeat
				i = i + 1
				
				if (checkNPCWest[i].subType == 2 or checkNPCWest[i].subType == 3) then
					table.remove(checkNPCWest, i)
					i = i - 1
				end
			until (i == #checkNPCWest)
		end
		
		if (block.showGhosts == 1) then
			if (#checkPCNorth > 0) then
				i = 0
				
				repeat
					i = i + 1
					
					if (checkPCNorth[i].state == 1) then
						table.remove(checkPCNorth, i)
						i = i - 1
					end
				until (i == #checkPCNorth)
			end
			
			if (#checkPCEast > 0) then
				i = 0
				
				repeat
					i = i + 1
					
					if (checkPCEast[i].state == 1) then
						table.remove(checkPCEast, i)
						i = i - 1
					end
				until (i == #checkPCEast)
			end
			
			if (#checkPCWest > 0) then
				i = 0
				
				repeat
					i = i + 1
					
					if (checkPCWest[i].state == 1) then
						table.remove(checkPCWest, i)
						i = i - 1
					end
				until (i == #checkPCWest)
			end
		end
		
		if (target.y - 1 > 0 and #checkPCNorth + #checkMobNorth + #checkNPCNorth == 0 and target:objectCanMove(target.x, target.y - 1, 0) and target:objectCanMoveFrom(target.x, target.y, 0) and getPass(target.m, target.x, target.y - 1) == 0 and not getWarp(target.m, target.x, target.y - 1)) then
			if (ambush == nil) then
				block.side = 2
				block:sendSide()
				block:warp(target.m, target.x, target.y - 1)
				return true
			else
				return true
			end
		elseif (target.x + 1 <= block.xmax and #checkPCEast + #checkMobEast + #checkNPCEast == 0 and target:objectCanMove(target.x + 1, target.y, 1) and target:objectCanMoveFrom(target.x, target.y, 1) and getPass(target.m, target.x + 1, target.y) == 0 and not getWarp(target.m, target.x + 1, target.y)) then
			if (ambush == nil) then
				block.side = 3
				block:sendSide()
				block:warp(target.m, target.x + 1, target.y)
				return true
			else
				return true
			end
		elseif (target.x - 1 > 0 and #checkPCWest + #checkMobWest + #checkNPCWest == 0 and target:objectCanMove(target.x - 1, target.y, 3) and target:objectCanMoveFrom(target.x, target.y, 3) and getPass(target.m, target.x - 1, target.y) == 0 and not getWarp(target.m, target.x - 1, target.y)) then
			if (ambush == nil) then
				block.side = 1
				block:sendSide()
				block:warp(target.m, target.x - 1, target.y)
				return true
			else
				return true
			end
		else
			return false
		end
	elseif (block.side == 1) then
		local checkPCEast = target:getObjectsInCell(target.m, target.x + 1, target.y, BL_PC)
		local checkMobEast = target:getObjectsInCell(target.m, target.x + 1, target.y, BL_MOB)
		local checkNPCEast = target:getObjectsInCell(target.m, target.x + 1, target.y, BL_NPC)

		local checkPCNorth = target:getObjectsInCell(target.m, target.x, target.y - 1, BL_PC)
		local checkMobNorth = target:getObjectsInCell(target.m, target.x, target.y - 1, BL_MOB)
		local checkNPCNorth = target:getObjectsInCell(target.m, target.x, target.y - 1, BL_NPC)

		local checkPCSouth = target:getObjectsInCell(target.m, target.x, target.y + 1, BL_PC)
		local checkMobSouth = target:getObjectsInCell(target.m, target.x, target.y + 1, BL_MOB)
		local checkNPCSouth = target:getObjectsInCell(target.m, target.x, target.y + 1, BL_NPC)

		if (#checkNPCNorth > 0) then
			i = 0
			
			repeat
				i = i + 1
				
				if (checkNPCNorth[i].subType == 2 or checkNPCNorth[i].subType == 3) then
					table.remove(checkNPCNorth, i)
					i = i - 1
				end
			until (i == #checkNPCNorth)
		end
		
		if (#checkNPCEast > 0) then
			i = 0
			
			repeat
				i = i + 1
				
				if (checkNPCEast[i].subType == 2 or checkNPCEast[i].subType == 3) then
					table.remove(checkNPCEast, i)
					i = i - 1
				end
			until (i == #checkNPCEast)
		end
		
		if (#checkNPCSouth > 0) then
			i = 0
			
			repeat
				i = i + 1
				
				if (checkNPCSouth[i].subType == 2 or checkNPCSouth[i].subType == 3) then
					table.remove(checkNPCSouth, i)
					i = i - 1
				end
			until (i == #checkNPCSouth)
		end
		
		if (block.showGhosts == 1) then
			if (#checkPCNorth > 0) then
				i = 0
				
				repeat
					i = i + 1
					
					if (checkPCNorth[i].state == 1) then
						table.remove(checkPCNorth, i)
						i = i - 1
					end
				until (i == #checkPCNorth)
			end
			
			if (#checkPCSouth > 0) then
				i = 0
				
				repeat
					i = i + 1
					
					if (checkPCSouth[i].state == 1) then
						table.remove(checkPCSouth, i)
						i = i - 1
					end
				until (i == #checkPCSouth)
			end
			
			if (#checkPCEast > 0) then
				i = 0
				
				repeat
					i = i + 1
					
					if (checkPCEast[i].state == 1) then
						table.remove(checkPCEast, i)
						i = i - 1
					end
				until (i == #checkPCEast)
			end
		end
		
		if (target.x + 1 <= block.xmax and #checkPCEast + #checkMobEast + #checkNPCEast == 0 and target:objectCanMove(target.x + 1, target.y, 1) and target:objectCanMoveFrom(target.x, target.y, 1) and getPass(target.m, target.x + 1, target.y) == 0 and not getWarp(target.m, target.x + 1, target.y)) then
			if (ambush == nil) then
				block.side = 3
				block:sendSide()
				block:warp(target.m, target.x + 1, target.y)
				return true
			else
				return true
			end
		elseif (target.y - 1 > 0 and #checkPCNorth + #checkMobNorth + #checkNPCNorth == 0 and target:objectCanMove(target.x, target.y - 1, 0) and target:objectCanMoveFrom(target.x, target.y, 0) and getPass(target.m, target.x, target.y - 1) == 0 and not getWarp(target.m, target.x, target.y - 1)) then
			if (ambush == nil) then
				block.side = 2
				block:sendSide()
				block:warp(target.m, target.x, target.y - 1)
				return true
			else
				return true
			end
		elseif (target.y + 1 <= block.ymax and #checkPCSouth + #checkMobSouth + #checkNPCSouth == 0 and target:objectCanMove(target.x, target.y + 1, 2) and target:objectCanMoveFrom(target.x, target.y, 2) and getPass(target.m, target.x, target.y + 1) == 0 and not getWarp(target.m, target.x, target.y + 1)) then
			if (ambush == nil) then
				block.side = 0
				block:sendSide()
				block:warp(target.m, target.x, target.y + 1)
				return true
			else
				return true
			end
		else
			return false
		end
	elseif (block.side == 2) then
		local checkPCSouth = target:getObjectsInCell(target.m, target.x, target.y + 1, BL_PC)
		local checkMobSouth = target:getObjectsInCell(target.m, target.x, target.y + 1, BL_MOB)
		local checkNPCSouth = target:getObjectsInCell(target.m, target.x, target.y + 1, BL_NPC)

		local checkPCEast = target:getObjectsInCell(target.m, target.x + 1, target.y, BL_PC)
		local checkMobEast = target:getObjectsInCell(target.m, target.x + 1, target.y, BL_MOB)
		local checkNPCEast = target:getObjectsInCell(target.m, target.x + 1, target.y, BL_NPC)

		local checkPCWest = target:getObjectsInCell(target.m, target.x - 1, target.y, BL_PC)
		local checkMobWest = target:getObjectsInCell(target.m, target.x - 1, target.y, BL_MOB)
		local checkNPCWest = target:getObjectsInCell(target.m, target.x - 1, target.y, BL_NPC)

		if (#checkNPCSouth > 0) then
			i = 0
			
			repeat
				i = i + 1
				
				if (checkNPCSouth[i].subType == 2 or checkNPCSouth[i].subType == 3) then
					table.remove(checkNPCSouth, i)
					i = i - 1
				end
			until (i == #checkNPCSouth)
		end
		
		if (#checkNPCEast > 0) then
			i = 0
			
			repeat
				i = i + 1
				
				if (checkNPCEast[i].subType == 2 or checkNPCEast[i].subType == 3) then
					table.remove(checkNPCEast, i)
					i = i - 1
				end
			until (i == #checkNPCEast)
		end
		
		if (#checkNPCWest > 0) then
			i = 0
			
			repeat
				i = i + 1
				
				if (checkNPCWest[i].subType == 2 or checkNPCWest[i].subType == 3) then
					table.remove(checkNPCWest, i)
					i = i - 1
				end
			until (i == #checkNPCWest)
		end
		
		if (block.showGhosts == 1) then
			if (#checkPCEast > 0) then
				i = 0
				
				repeat
					i = i + 1
					
					if (checkPCEast[i].state == 1) then
						table.remove(checkPCEast, i)
						i = i - 1
					end
				until (i == #checkPCEast)
			end
			
			if (#checkPCSouth > 0) then
				i = 0
				
				repeat
					i = i + 1
					
					if (checkPCSouth[i].state == 1) then
						table.remove(checkPCSouth, i)
						i = i - 1
					end
				until (i == #checkPCSouth)
			end
			
			if (#checkPCWest > 0) then
				i = 0
				
				repeat
					i = i + 1
					
					if (checkPCWest[i].state == 1) then
						table.remove(checkPCWest, i)
						i = i - 1
					end
				until (i == #checkPCWest)
			end
		end
		
		if (target.y + 1 <= block.ymax and #checkPCSouth + #checkMobSouth + #checkNPCSouth == 0 and target:objectCanMove(target.x, target.y + 1, 2) and target:objectCanMoveFrom(target.x, target.y, 2) and getPass(target.m, target.x, target.y + 1) == 0 and not getWarp(target.m, target.x, target.y + 1)) then
			if (ambush == nil) then
				block.side = 0
				block:sendSide()
				block:warp(target.m, target.x, target.y + 1)
				return true
			else
				return true
			end
		elseif (target.x + 1 <= block.xmax and #checkPCEast + #checkMobEast + #checkNPCEast == 0 and target:objectCanMove(target.x + 1, target.y, 1) and target:objectCanMoveFrom(target.x, target.y, 1) and getPass(target.m, target.x + 1, target.y) == 0 and not getWarp(target.m, target.x + 1, target.y)) then
			if (ambush == nil) then
				block.side = 3
				block:sendSide()
				block:warp(target.m, target.x + 1, target.y)
				return true
			else
				return true
			end
		elseif (target.x - 1 > 0 and #checkPCWest + #checkMobWest + #checkNPCWest == 0 and target:objectCanMove(target.x - 1, target.y, 3) and target:objectCanMoveFrom(target.x, target.y, 3) and getPass(target.m, target.x - 1, target.y) == 0 and not getWarp(target.m, target.x - 1, target.y)) then
			if (ambush == nil) then
				block.side = 1
				block:sendSide()
				block:warp(target.m, target.x - 1, target.y)
				return true
			else
				return true
			end
		else
			return false
		end
	elseif (block.side == 3) then
		local checkPCWest = target:getObjectsInCell(target.m, target.x - 1, target.y, BL_PC)
		local checkMobWest = target:getObjectsInCell(target.m, target.x - 1, target.y, BL_MOB)
		local checkNPCWest = target:getObjectsInCell(target.m, target.x - 1, target.y, BL_NPC)
		
		local checkPCNorth = target:getObjectsInCell(target.m, target.x, target.y - 1, BL_PC)
		local checkMobNorth = target:getObjectsInCell(target.m, target.x, target.y - 1, BL_MOB)
		local checkNPCNorth = target:getObjectsInCell(target.m, target.x, target.y - 1, BL_NPC)
		
		local checkPCSouth = target:getObjectsInCell(target.m, target.x, target.y + 1, BL_PC)
		local checkMobSouth = target:getObjectsInCell(target.m, target.x, target.y + 1, BL_MOB)
		local checkNPCSouth = target:getObjectsInCell(target.m, target.x, target.y + 1, BL_NPC)

		if (#checkNPCNorth > 0) then
			i = 0
			
			repeat
				i = i + 1
				
				if (checkNPCNorth[i].subType == 2 or checkNPCNorth[i].subType == 3) then
					table.remove(checkNPCNorth, i)
					i = i - 1
				end
			until (i == #checkNPCNorth)
		end
		
		if (#checkNPCSouth > 0) then
			i = 0
			
			repeat
				i = i + 1
				
				if (checkNPCSouth[i].subType == 2 or checkNPCSouth[i].subType == 3) then
					table.remove(checkNPCSouth, i)
					i = i - 1
				end
			until (i == #checkNPCSouth)
		end
		
		if (#checkNPCWest > 0) then
			i = 0
			
			repeat
				i = i + 1
				
				if (checkNPCWest[i].subType == 2 or checkNPCWest[i].subType == 3) then
					table.remove(checkNPCWest, i)
					i = i - 1
				end
			until (i == #checkNPCWest)
		end
		
		if (block.showGhosts == 1) then
			if (#checkPCNorth > 0) then
				i = 0
				
				repeat
					i = i + 1
					
					if (checkPCNorth[i].state == 1) then
						table.remove(checkPCNorth, i)
						i = i - 1
					end
				until (i == #checkPCNorth)
			end
			
			if (#checkPCSouth > 0) then
				i = 0
				
				repeat
					i = i + 1
					
					if (checkPCSouth[i].state == 1) then
						table.remove(checkPCSouth, i)
						i = i - 1
					end
				until (i == #checkPCSouth)
			end
			
			if (#checkPCWest > 0) then
				i = 0
				
				repeat
					i = i + 1
					
					if (checkPCWest[i].state == 1) then
						table.remove(checkPCWest, i)
						i = i - 1
					end
				until (i == #checkPCWest)
			end
		end
		
		if (target.x - 1 > 0 and #checkPCWest + #checkMobWest + #checkNPCWest == 0 and target:objectCanMove(target.x - 1, target.y, 3) and target:objectCanMoveFrom(target.x, target.y, 3) and getPass(target.m, target.x - 1, target.y) == 0 and not getWarp(target.m, target.x - 1, target.y)) then
			if (ambush == nil) then
				block.side = 1
				block:sendSide()
				block:warp(target.m, target.x - 1, target.y)
				return true
			else
				return true
			end
		elseif (target.y - 1 > 0 and #checkPCNorth + #checkMobNorth + #checkNPCNorth == 0 and target:objectCanMove(target.x, target.y - 1, 0) and target:objectCanMoveFrom(target.x, target.y, 0) and getPass(target.m, target.x, target.y - 1) == 0 and not getWarp(target.m, target.x, target.y - 1)) then
			if (ambush == nil) then
				block.side = 2
				block:sendSide()
				block:warp(target.m, target.x, target.y - 1)
				return true
			else
				return true
			end
		elseif (target.y + 1 <= block.ymax and #checkPCSouth + #checkMobSouth + #checkNPCSouth == 0 and target:objectCanMove(target.x, target.y + 1, 2) and target:objectCanMoveFrom(target.x, target.y, 2) and getPass(target.m, target.x, target.y + 1) == 0 and not getWarp(target.m, target.x, target.y + 1)) then
			if (ambush == nil) then
				block.side = 0
				block:sendSide()
				block:warp(target.m, target.x, target.y + 1)
				return true
			else
				return true
			end
		else
			return false
		end
	end	
	
	return false
end

fourPush = function(block, blockType, cell)

	local blocksNorth = block:getObjectsInCell(block.m, block.x, block.y - cell, blockType)
	local blocksEast = block:getObjectsInCell(block.m, block.x + cell, block.y, blockType)
	local blocksWest = block:getObjectsInCell(block.m, block.x - cell, block.y, blockType)
	local blocksSouth = block:getObjectsInCell(block.m, block.x, block.y + cell, blockType)
	local side = block.side

	if (#blocksNorth > 0) then
		block.side = 0
		canPush(block, blocksNorth[1])
	end

	if (#blocksEast > 0) then
		block.side = 1
		canPush(block, blocksEast[1])
	end
	
	if (#blocksSouth > 0) then
		block.side = 2
		canPush(block, blocksSouth[1])
	end
	
	if (#blocksWest > 0) then
		block.side = 3
		canPush(block, blocksWest[1])
	end
	
	block.side = side
end

roomExpTotal = function(block, room, minutes)
	local mapBlocks = block:getObjectsInMap(room, BL_MOB)
	local maxPotential = 0
	local expectedPotential = 0
	local seconds = minutes * 60
	
	if (#mapBlocks > 0) then
		for i = 1, #mapBlocks do
			maxPotential = maxPotential + ((seconds / mapBlocks[i].spawnTime) * mapBlocks[i].experience)
		end
	end
	
	expectedPotential = maxPotential * .65
	block:talk(0, "Room: "..room.." Max: "..maxPotential.." Expected: "..expectedPotential)
end


toXY2 = function(block, x, y)
	
	local canmove = 0
	local found = 0
	local checkmove = math.random(0,2)
	
	if (checkmove >= 1) then
		if (block.y < y) then
			block.side = 2
			block:sendSide()
			canmove = block:moveGhost()
		end
		if (block.y > y and canmove == 0) then
			block.side = 0
			block:sendSide()
			canmove = block:moveGhost()
		end
		if (block.x < x and canmove == 0) then
			block.side = 1
			block:sendSide()
			canmove = block:moveGhost()
		end
		if (block.x > x and canmove == 0) then
			block.side = 3
			block:sendSide()
			canmove = block:moveGhost()
		end
	else
		if (block.x < x) then
			block.side = 1
			block:sendSide()
			canmove = block:moveGhost()
		end
		if(block.x > x and canmove == 0) then
			block.side = 3
			block:sendSide()
			canmove = block:moveGhost()
		end
		if (block.y < y and canmove == 0) then
			block.side = 2
			block:sendSide()
			canmove = block:moveGhost()
		end
		if (block.y > y and canmove == 0) then
			block.side = 0
			block:sendSide()
			canmove = block:moveGhost()
		end
	end
	
	if (block.x == x and block.y == y) then
		return true
	elseif (canmove == 0) then
		for i = 0, 10 do
			if (found == 0) then
				block.side = math.random(0,3)
				block:sendSide()
				found = block:moveGhost()
			end
		end
	end
end


facingToTarget = function(block, target)
	
	local checkmove = math.random(0,2)
	local x, y = target.x, target.y
	local canmove, found = 0, 0
	
	if checkmove >= 1 then
		if block.y < y then block.side = 2 end
		if block.y > y and canmove == 0 then block.side = 0 end
		if block.x < x and canmove == 0 then block.side = 1 end
		if block.x > x and canmove == 0 then block.side = 3 end
		block:sendSide()
	end
	if checkmove == 0 then
		if block.x < x then block.side = 1 end
		if block.x > x and canmove == 0 then block.side = 3 end
		if block.y < y and canmove == 0 then block.side = 2 end
		if block.y > y and canmove == 0 then block.side = 0 end
		block:sendSide()
	end

		
end