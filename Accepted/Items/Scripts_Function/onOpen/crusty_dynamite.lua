crusty_dynamite = {

use = function(player)

	local side = player.side
	local m, x, y = player.m, player.x, player.y
	local item = player:getInventoryItem(player.invSlot)
	
	if player.health < 1 then
		player:sendMinitext("Ghosts can't do that")
		return
	end

	if not player:canAction(1, 1, 1) then
		player:sendMinitext("You cannot do that right now!")
	    return 
    end
	
	if player.m < 3201 or player.m > 3205 then
		player:talkSelf(0,""..player.name..": Use Dynamite here? That would be rude!")
		return
	end
	
	if player:hasItem(item.yname, 1) == true then
		if checkOpenCellFacing(player) == 1 then
			player:removeItemSlot(player.invSlot, 1)
			player.registry["picked_up_dynamite"] = 0
			if side == 0 then
				player:dropItemXY(Item("crusty_dynamite").id, 1, m, x, y-1, 1)
				player:addNPC("crusty_dynamite", m, x, y-1, 1000, 3000, player.ID)
			elseif side == 1 then
				player:dropItemXY(Item("crusty_dynamite").id, 1, m, x+1, y, 1)
				player:addNPC("crusty_dynamite", m, x+1, y, 1000, 3000, player.ID)
				
			elseif side == 2 then
				player:dropItemXY(Item("crusty_dynamite").id, 1, m, x, y+1, 1)
				player:addNPC("crusty_dynamite", m, x, y+1, 1000, 3000, player.ID)
				
			elseif side == 3 then
				player:dropItemXY(Item("crusty_dynamite").id, 1, m, x-1, y, 1)
				player:addNPC("crusty_dynamite", m, x-1, y, 1000, 3000, player.ID)
			end
		else
			player:talk(0,""..player.name..": Theres nowhere to set the dynamite!")
		end
	end
end,

on_spawn = function(npc)

	local m, x, y = npc.m, npc.x, npc.y
	local player = core:getObjectsInMap(m, BL_PC)
	
	setPass(m, x, y, 1)
	if #player > 0 then
		player[1]:sendAnimationXY(369, x, y)
	end
	npc.registry["dynamite_timer"] = 3
end,

action = function(npc)

	local m, x, y = npc.m, npc.x, npc.y
	local player = core:getObjectsInMap(m, BL_PC)
	
	npc.registry["dynamite_timer"] = npc.registry["dynamite_timer"] - 1
	if npc.registry["dynamite_timer"] == 2 then
		if #player > 0 then
			player[1]:sendAnimationXY(368, x, y)
		end
	elseif npc.registry["dynamite_timer"] == 1 then
		if #player > 0 then
			player[1]:sendAnimationXY(367, x, y)
		end
	end
end,


endAction = function(npc)

	local m, x, y = npc.m, npc.x, npc.y
	local player = core:getObjectsInMap(m, BL_PC)

	local dynamite = npc:getObjectsInCell(m, x, y, BL_ITEM)

	if #dynamite > 0 then
		if #player > 0 then
			player[1]:sendAnimationXY(13, x, y)
		end
		for i = 1, #dynamite do
			if dynamite[i].id == 854 then
				dynamite[i]:delete()
				setPass(m, x, y, 0)
			end
		end

		if m == 3201 then
			if x >= 18 and x <= 21 then
				if y >= 5 and y <= 8 then
					ogre_mine_walls.mineWallExplode1(core)
				end
			elseif x >= 55 and x <= 57 then
				if y >= 45 and y <= 48 then
					ogre_mine_walls.mineWallExplode2(core)
				end
			end
		
		elseif m == 3202 then
			if x >= 31 and x <= 33 then
				if y >= 7 and y <= 10 then
					ogre_mine_walls.mineWallExplode3(core)
				end
			end
			
		elseif m == 3205 then
			if x >= 26 and x <= 28 then
				if y >= 15 and y <= 19 then
					ogre_mine_walls.mineWallExplode4(core)
				end
			end
		end
		
	end
	npc:delete()
end,

pickUp = function(player)

--	if player.ID ~= 4 then return end

	if player.registry["picked_up_dynamite"] == 0 then
		if player:hasSpace("Crusty Dynamite", 1) == true then
			player:talk(0,""..player.name..": Theres dynamite in this box! Cool!")
			player:addItem("crusty_dynamite", 1)
			player.registry["picked_up_dynamite"] = 1
			player.registry["dynamite_timer"] = 10
		else
			player:talk(0,""..player.name..": I don't have any room to carry this!")
		end
	else
		player:talk(0,""..player.name..": I already have some dynamite.")
	end

end,

walk = function(player)

	if player:hasItem("crusty_dynamite", 1) == true then
		player.registry["dynamite_timer"] = player.registry["dynamite_timer"] - 1
	end
	
	if player.registry["picked_up_dynamite"] == 1 then
		if player.registry["dynamite_timer"] <= 0 then
			crusty_dynamite.explode(player)
		end
	end
end,

explode = function(player)

	local damage = player.maxHealth * .5
	local anim = 13
	local m, x, y = player.m, player.x, player.y
	
	player:removeItem("crusty_dynamite", 1)
	player:sendAnimation(13)
	player:removeHealth(damage)
	player.registry["picked_up_dynamite"] = 0
	player.registry["dynamite_timer"] = 0
	player:sendMinitext("The Crusty Dynamite exploded in your bag!")
	
	if m == 3201 then
		if x >= 18 and x <= 21 then
			if y >= 5 and y <= 8 then
				ogre_mine_walls.mineWallExplode1(player)
			end
		elseif x >= 55 and x <= 57 then
			if y >= 45 and y <= 48 then
				ogre_mine_walls.mineWallExplode2(player)
			end
		end
		
	elseif m == 3202 then
		if x >= 31 and x <= 33 then
			if y >= 7 and y <= 10 then
				ogre_mine_walls.mineWallExplode3(player)
			end
		end
		
	elseif m == 3205 then
		if x >= 26 and x <= 28 then
			if y >= 15 and y <= 19 then
				ogre_mine_walls.mineWallExplode4(player)
			end
		end
	end
end
}