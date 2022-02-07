decoy = {
	onAction = function(player, action)
		local mob = player:getObjectsInMap(player.m, BL_MOB)

		if #mob > 0 then
			for i = 1, #mob do
				if mob[i].yname == "decoy" then
					if mob[i].owner == player.ID then
						mob[i]:sendAction(action, 20)
					end
				end
			end
		end
	end,
	move = function(mob, target) --
		--[[	
	local moved = true
	local c1, c2 = math.random(0, 20), math.random(0, 10)

	if (mob.paralyzed == true or mob.sleep ~= 1) then return end
	threat.calcHighestThreat(mob)
	
	if target == nil then
		if c1 <= 3 then  mob.side = c1
			mob:sendSide()
		else
			if c1 < c2 then
				if not mob.snare and not mob.blind then moved = mob:move() end
			end
		end
	return else
		if target.state ~= 1 and target.state ~= 2 then
			if (not mob.snare and not mob.blind) then moved = FindCoords(mob, target) end
			if mob:moveIntent(target.ID) == 1 then mob.state = MOB_HIT end
		end
	end
]]
	end,
	attack = function(mob, target) --
		--[[
	local moved = true
	
	if (mob.paralyzed or mob.sleep ~= 1) then return end
	
	if target == nil then
		mob.state = MOB_ALIVE
	return else
		threat.calcHighestThreat(mob)
		if target.state ~= 1 and target.state ~= 2 then
			moved = FindCoords(mob,target)
			if mob:moveIntent(target.ID) == 1 then mob:attack(target.ID) end
		else
			mob.state = MOB_ALIVE
		end
	end
]]
	end,
	on_attacked = function(mob, attacker)
		mob_ai_basic.on_attacked(mob, attacker)
	end,
	before_death = function(mob)
		mob:sendAnimationXY(292, mob.x, mob.y)
	end,
	cast = function(player)
		local same = {}
		local pc = player:getObjectsInMap(player.m, BL_PC)
		local mob = player:getObjectsInMap(player.m, BL_MOB)
		local x, y
		local decoy

		if checkOpenCellFacing(player) == 1 then
			x, y = getFacingXY(player)
			player:spawn(99, x, y, 1)
			decoy = player:getObjectsInCell(player.m, x, y, BL_MOB)
			if #decoy > 0 then
				for i = 1, #decoy do
					if decoy[i].yname == "decoy" then
						if player.gfxClone == 0 then
							clone.equip(player, decoy[i])
							if player.registry["show_title"] == 1 then
								decoy[i].gfxName = player.title .. " " .. player.name
							else
								decoy[i].gfxName = player.name
							end
						else
							clone.gfx(player, decoy[i])
							decoy[i].gfxName = player.gfxName
						end
						decoy[i].gfxClone = 1
						if player.side >= 2 then
							decoy[i].side = player.side - 2
						else
							decoy[i].side = player.side + 2
						end
						decoy[i]:sendSide()
						decoy[i].owner = player.ID
						decoy[i]:setDuration("decoy", 60000, player.ID)
						decoy[i]:sendAnimation(3)
						player:setDuration("decoy", 60000)
					--player.state = 2
					--player:updateState()
					end
				end
			end
			if #pc > 0 then
				for i = 1, #pc do
					pc[i]:refresh()
				end
			end
		end
	end,
	while_cast = function(block, caster) --
		--[[	
	if caster ~= nil then
		local target = block:getBlock(caster.attacker)
		
		if target ~= nil then
			if target.state ~= 1 and target.state ~= 2 then
				block.target = target.ID
			end
		end
	end
]]
	end,
	uncast = function(block)
		if block.blType == BL_MOB then
			block:sendAnimationXY(292, block.x, block.y)
			block:playSound(73)
			block:removeHealth(block.health)
		end
	end,
	swing = function(player)
		local mob = player:getObjectsInMap(player.m, BL_MOB)

		if #mob > 0 then
			for i = 1, #mob do
				if mob[i].yname == "decoy" and mob[i].owner == player.ID then
					if mob[i].paralyzed or mob[i].sleep ~= 1 then
						return
					else
						if not mob[i].blind and not mob[i].snare then
							mob[i]:sendAction(1, 20)
						end
					end
				end
			end
		end
	end,
	say = function(player)
		local speech = string.lower(player.speech)
		local mob = player:getObjectsInMap(player.m, BL_MOB)

		if #mob > 0 then
			for i = 1, #mob do
				if mob[i].yname == "decoy" and mob[i].owner == player.ID then
					if string.match(speech, "/(.+)") ~= nil then
						return
					else
						mob[i]:talk(0, player.name .. ": " .. speech)
					end
				end
			end
		end
	end,
	click = async(
		function(player, mob)
			local owner = mob:getBlock(mob.owner)
			local healthCost = player.health * .5

			if owner == nil then
				return
			else
				if mob.owner == player.ID then
					swap(player, mob)
					player.side = mob.side
					player.health = player.health - healthCost
					player:sendStatus()
					player:sendSide()
				end
			end
		end
	),
	turn = function(player)
		local mob = player:getObjectsInMap(player.m, BL_MOB)

		if #mob > 0 then
			for i = 1, #mob do
				if mob[i].yname == "decoy" and mob[i].owner == player.ID then
					if mob[i].paralyzed or mob[i].sleep ~= 1 then
						return
					else
						if not mob[i].blind and not mob[i].snare then
							if player.side == 0 then
								mob[i].side = 2
							elseif player.side == 1 then
								mob[i].side = 3
							elseif player.side == 2 then
								mob[i].side = 0
							elseif player.side == 3 then
								mob[i].side = 1
							end
							mob[i]:sendSide()
						end
					end
				end
			end
		end
	end,
	walk = function(player)
		local mob = player:getObjectsInMap(player.m, BL_MOB)

		if #mob > 0 then
			for i = 1, #mob do
				if mob[i].yname == "decoy" and mob[i].owner == player.ID then
					if mob[i].paralyzed or mob[i].sleep ~= 1 then
						return
					else
						if not mob[i].blind and not mob[i].snare then
							mob[i]:move()
						end
					end
				end
			end
		end
	end
}
