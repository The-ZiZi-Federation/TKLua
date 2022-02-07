minor_illusion = {
	move = function(mob, target)
		local areaMob = mob:getObjectsInArea(BL_MOB)
		local player = mob:getBlock(mob.owner)

		if #areaMob > 0 then
			for i = 1, #areaMob do
				if areaMob[i].target == mob.owner then
					player:setThreat(areaMob[i].ID, 0)
					areaMob[i].target = mob.ID
				end
			end
		end
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
	 --
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
		--	mob_ai_basic.on_attacked(mob, attacker)
	end,
	before_death = function(mob)
		mob:sendAnimationXY(292, mob.x, mob.y)
	end,
	cast = function(player)
		local same = {}
		local pc = player:getObjectsInMap(player.m, BL_PC)
		local mob = player:getObjectsInMap(player.m, BL_MOB)
		local x, y = player.x, player.y
		local illusion
		local aether = 45000
		local duration = 5000
		local magicCost = player.maxMagic * 0.02
		local sound = 1
		local anim = 3

		player:spawn(61, x, y, 1)
		illusion = player:getObjectsInCell(player.m, x, y, BL_MOB)
		if #illusion > 0 then
			player:sendAction(6, 20)
			player:sendMinitext("You cast Minor Illusion")
			player:playSound(sound)
			player.magic = player.magic - magicCost
			player:sendStatus()
			player:setDuration("minor_illusion", duration)
			player:setAether("minor_illusion", aether)
			player.state = 2
			player:updateState()
			if #illusion > 0 then
				for i = 1, #illusion do
					if illusion[i].yname == "minor_illusion" then
						if player.gfxClone == 0 then
							clone.equip(player, illusion[i])
							if player.registry["show_title"] == 1 then
								illusion[i].gfxName = player.title .. " " .. player.name
							else
								illusion[i].gfxName = player.name
							end
						else
							clone.gfx(player, illusion[i])
							illusion[i].gfxName = player.gfxName
						end
						illusion[i].gfxClone = 1
						illusion[i].side = player.side
						illusion[i]:sendSide()
						illusion[i].owner = player.ID
						illusion[i]:setDuration("minor_illusion", duration, player.ID)
						illusion[i]:sendAnimation(anim)
					end
				end
			end
		end
		if #pc > 0 then
			for i = 1, #pc do
				pc[i]:refresh()
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
			minor_illusion.anim(block)
			minor_illusion.detonate(block)
			block:sendAnimationXY(292, block.x, block.y)
			block:playSound(73)
			block:removeHealth(block.health)
		elseif block.blType == BL_PC then
			if block.state == 2 then
				block.state = 0
				block:updateState()
			end
		end
	end,
	anim = function(mob)
		local player = Player(mob.owner)
		local x, y = mob.x, mob.y
		local spellAnim = 432

		mob:sendAnimationXY(spellAnim, x, y)
		mob:sendAnimationXY(spellAnim, x + 1, y)
		mob:sendAnimationXY(spellAnim, x - 1, y)
		mob:sendAnimationXY(spellAnim, x, y + 1)
		mob:sendAnimationXY(spellAnim, x, y - 1)
		mob:sendAnimationXY(spellAnim, x + 1, y + 1)
		mob:sendAnimationXY(spellAnim, x + 1, y - 1)
		mob:sendAnimationXY(spellAnim, x - 1, y + 1)
		mob:sendAnimationXY(spellAnim, x - 1, y - 1)

		if player.level >= 150 then
			mob:sendAnimationXY(spellAnim, x + 2, y)
			mob:sendAnimationXY(spellAnim, x + 2, y + 1)
			mob:sendAnimationXY(spellAnim, x + 2, y - 1)
			mob:sendAnimationXY(spellAnim, x - 2, y)
			mob:sendAnimationXY(spellAnim, x - 2, y + 1)
			mob:sendAnimationXY(spellAnim, x - 2, y - 1)
			mob:sendAnimationXY(spellAnim, x, y + 2)
			mob:sendAnimationXY(spellAnim, x + 1, y + 2)
			mob:sendAnimationXY(spellAnim, x - 1, y + 2)
			mob:sendAnimationXY(spellAnim, x, y - 2)
			mob:sendAnimationXY(spellAnim, x + 1, y - 2)
			mob:sendAnimationXY(spellAnim, x - 1, y - 2)
		end
	end,
	detonate = function(mob)
		local player = Player(mob.owner)
		local threat

		local m = player.m
		local x = player.x
		local y = player.y

		local anim = 414
		local sound = 29

		---------------------------
		--- Spell Damage Formula---
		---------------------------
		local damage
		local areaPC = mob:getObjectsInArea(BL_PC)
		local areaMob = mob:getObjectsInArea(BL_MOB)
		local targets = {}

		if player.level >= 150 then
			table.insert(targets, mob:getObjectsInCell(mob.m, mob.x, mob.y - 2, BL_MOB)[1])
			table.insert(targets, mob:getObjectsInCell(mob.m, mob.x + 1, mob.y - 2, BL_MOB)[1])
			table.insert(targets, mob:getObjectsInCell(mob.m, mob.x - 1, mob.y - 2, BL_MOB)[1])
			table.insert(targets, mob:getObjectsInCell(mob.m, mob.x, mob.y + 2, BL_MOB)[1])
			table.insert(targets, mob:getObjectsInCell(mob.m, mob.x + 1, mob.y + 2, BL_MOB)[1])
			table.insert(targets, mob:getObjectsInCell(mob.m, mob.x - 1, mob.y + 2, BL_MOB)[1])
			table.insert(targets, mob:getObjectsInCell(mob.m, mob.x + 2, mob.y, BL_MOB)[1])
			table.insert(targets, mob:getObjectsInCell(mob.m, mob.x + 2, mob.y + 1, BL_MOB)[1])
			table.insert(targets, mob:getObjectsInCell(mob.m, mob.x + 2, mob.y - 1, BL_MOB)[1])
			table.insert(targets, mob:getObjectsInCell(mob.m, mob.x - 2, mob.y, BL_MOB)[1])
			table.insert(targets, mob:getObjectsInCell(mob.m, mob.x - 2, mob.y + 1, BL_MOB)[1])
			table.insert(targets, mob:getObjectsInCell(mob.m, mob.x - 2, mob.y - 1, BL_MOB)[1])
		end

		if #areaMob > 0 then
			for i = 1, #areaMob do
				if distanceSquare(mob, areaMob[i], 1) then
					table.insert(targets, areaMob[i])
				end
			end
		end

		if #areaPC > 0 then
			for i = 1, #areaPC do
				if (player:canPK(areaPC[i])) then
					if distanceSquare(mob, areaPC[i], 1) then
						table.insert(targets, areaPC[i])
					end
				end
			end
		end

		if #targets > 0 then
			for i = 1, #targets do
				if targets[i].blType == BL_MOB then
					player.critChance = 1
					damage = math.floor(((0.025 * player.maxHealth) + (0.1 * player.level) + swingDamage(player, targets[i], 2)) * 10)
					targets[i].attacker = player.ID
					threat = targets[i]:removeHealthExtend(damage, 1, 1, 0, 1, 2)
					player:addThreat(targets[i].ID, threat)
					targets[i]:removeHealthExtend(damage, 1, 1, 0, 1, 1)
				elseif targets[i].blType == BL_PC then
					player.critChance = 1
					damage = math.floor(((0.025 * player.maxHealth) + (0.1 * player.level) + swingDamage(player, areaPC[i], 2)) * 10)
					areaPC[i].attacker = player.ID
					areaPC[i]:calcStat()
					areaPC[i]:removeHealthExtend(damage, 1, 1, 0, 1, 1)
				end
			end
		end
	end,
	on_aethers = function(player)
		local mob = player:getObjectsInArea(BL_MOB)

		if #mob > 0 then
			for i = 1, #mob do
				if mob[i].yname == "minor_illusion" and mob[i].owner == player.ID then
					mob[i]:setDuration("minor_illusion", 0, player.ID)
				end
			end
		end
		player:setDuration("minor_illusion", 0)
		--	player:talk(0,"works")
	end,
	say = function(player)
		local speech = string.lower(player.speech)
		local mob = player:getObjectsInMap(player.m, BL_MOB)

		if #mob > 0 then
			for i = 1, #mob do
				if mob[i].yname == "minor_illusion" and mob[i].owner == player.ID then
					if string.match(speech, "/(.+)") ~= nil then
						return
					else
						mob[i]:talk(0, player.name .. ": " .. speech)
					end
				end
			end
		end
	end,
	requirements = function(player)
		local level = 5
		local item = {0}
		local amounts = {50000}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {
			"Create an illusory double to draw enemy attention away from you. When it's time is over, your foes are in for a surprise, haha!",
			txt
		}
		return level, item, amounts, desc
	end
}
