seed = {
	use = function(player, item)
		local m, x, y = player.m, player.x, player.y
		local center = player:getObjectsInCell(m, x, y, BL_MOB)
		local up = player:getObjectsInCell(m, x, y - 1, BL_MOB)
		local right = player:getObjectsInCell(m, x + 1, y, BL_MOB)
		local left = player:getObjectsInCell(m, x - 1, y, BL_MOB)
		local down = player:getObjectsInCell(m, x, y + 1, BL_MOB)
		local leftA = player:getObjectsInCell(m, x - 1, y - 1, BL_MOB)
		local rightA = player:getObjectsInCell(m, x + 1, y - 1, BL_MOB)
		local leftB = player:getObjectsInCell(m, x - 1, y + 1, BL_MOB)
		local rightB = player:getObjectsInCell(m, x + 1, y + 1, BL_MOB)

		if #center == 0 then
			seed.checkTile(player, item, m, x, y)
		end
		if #up == 0 then
			seed.checkTile(player, item, m, x + 1, y)
		end
		if #right == 0 then
			seed.checkTile(player, item, m, x + 1, y)
		end
		if #left == 0 then
			seed.checkTile(player, item, m, x - 1, y)
		end
		if #down == 0 then
			seed.checkTile(player, item, m, x, y + 1)
		end
		if #leftA == 0 then
			seed.checkTile(player, item, m, x - 1, y - 1)
		end
		if #rightA == 0 then
			seed.checkTile(player, item, m, x + 1, y - 1)
		end
		if #leftB == 0 then
			seed.checkTile(player, item, m, x - 1, y + 1)
		end
		if #rightB == 0 then
			seed.checkTile(player, item, m, x + 1, y + 1)
		end
		player:sendAction(5, 60)
	end,
	checkTile = function(player, crop, m, x, y)
		if m == 68 then
			if getTile(m, x, y) == 177 then
				core:spawn(50020, x, y, 1, player.m) -- lets try, ho wabout animation send after spawn
				player:sendAnimationXY(133, x, y)
				player:sendAnimationXY(196, x, y)
				local obj = player:getObjectsInCell(m, x, y, BL_MOB)
				if #obj > 0 then
					for i = 1, #obj do
						if obj[i].yname == "seed" then
							if obj[i].owner == 0 then
								obj[i].owner = player.ID
								obj[i].gfxName = crop .. ""
							end
						end
					end
				end
			end
		end
	end,
	move = function(mob, target)
		local owner = mob:getBlock(mob.owner)
		local timer = mob.registry["timer"]

		if mob.m == 68 then
			if owner ~= nil then
				if mob.m == owner.m then
					mob:sendAnimation(132)
					mob:talk(2, "" .. mob.gfxName .. " (" .. owner.name .. ") " .. mob.registry["timer"] .. " sec")
					if timer >= 60 then
						mob:spawn(32, mob.x, mob.y, 1, mob.m)
						mob:removeHealth(mob.health)
						return
					else
						mob.registry["timer"] = mob.registry["timer"] + 1
					end
				end
			end
		end
	end,
	on_spawn = function(mob)
		mob:sendAnimation(196)
		mob:playSound(112)
	end
}
