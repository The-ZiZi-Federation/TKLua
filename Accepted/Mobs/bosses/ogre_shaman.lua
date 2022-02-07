ogre_shaman = {
	after_death = function(mob) --
		--[[
	local roll = math.random(1, 100)
	
	if roll >= 1 and roll <= 5 then
		mob:dropItemXY(434, 1, mob.m, mob.x, mob.y)
	elseif roll >=6 and roll <= 10 then
		mob:dropItemXY(435, 1, mob.m, mob.x, mob.y)
	elseif roll >=11 and roll <= 15 then
		mob:dropItemXY(436, 1, mob.m, mob.x, mob.y)
	elseif roll >=16 and roll <= 20 then
		mob:dropItemXY(437, 1, mob.m, mob.x, mob.y)	
	end
]]
	end,
	before_death = function(mob)
	end,
	magicCast = function(mob, target)
		local areaPC = mob:getObjectsInArea(BL_PC)
		local r = math.random(1, #areaPC)
		local targetPC = areaPC[r]

		mob.registry["flare_timer"] = mob.registry["flare_timer"] + 1
		mob.registry["fireball_timer"] = mob.registry["fireball_timer"] + 1
		--	mob.registry["flame_surge_timer"] = mob.registry["flame_surge_timer"] + 1
		mob.registry["heal_timer"] = mob.registry["heal_timer"] + 1

		--mob:talk(0,"snowstormTimer: "..mob.registry["snowstorm_timer"])
		--mob:talk(0,"flareTimer: "..mob.registry["flare_timer"])
		--mob:talk(0,"flurryTimer: "..mob.registry["flurry_timer"])
		--mob:talk(0,"healTimer: "..mob.registry["heal_timer"])

		if mob.registry["flare_timer"] >= 12 then
			if distanceSquare(mob, targetPC, 12) then
				if targetPC.state ~= 1 then
					ogre_shaman.flare(mob, targetPC)
					mob.registry["flare_timer"] = 0
				end
			end
		end

		if mob.registry["fireball_timer"] >= 17 then
			if distanceSquare(mob, targetPC, 15) then
				if targetPC.state ~= 1 then
					ogre_shaman.fireball(mob, targetPC)
					mob.registry["fireball_timer"] = 0
				end
			end
		end

		--	if mob.registry["flame_surge_timer"] >= 21 then
		--		if not mob:hasDuration("flame_surge") then flame_surge.cast(mob, mob) end
		--		mob.registry["flame_surge_timer"] = 0
		--	end

		if mob.registry["heal_timer"] >= 29 then
			if mob.sleep ~= 1 then
				return
			end
			mob:sendAnimation(5)
			mob:playSound(98)
			mob:addHealth(250000)
			mob.registry["heal_timer"] = 0
		end
	end,
	move = function(mob, target)
		local facing = getTargetFacing(mob, BL_ALL)
		local moved = true
		local move1, move2 = math.random(0, 10), math.random(0, 20)
		local pcarea = mob:getObjectsInArea(BL_PC)

		threat.calcHighestThreat(mob)
		if target == nil then
			pc = mob:getObjectsInArea(BL_PC)
			if #pc > 0 then
				for i = 1, #pc do
					if distanceSquare(mob, pc[i], 7) then
						if pc[i].state ~= 1 and pc[i].state ~= 2 then
							mob.target = pc[math.random(#pc)].ID
						end
					end
				end
			end
			return
		else
			if target.state ~= 1 and target.state ~= 2 then
				moved = FindCoords(mob, target)
				if mob:moveIntent(target.ID) == 1 then
					mob.state = MOB_HIT
				end
			end
		end
	end,
	attack = function(mob, target)
		ogre_shaman.magicCast(mob, target)
		mob_ai_boss.attack(mob, target)
	end,
	on_healed = function(mob, healer)
		mob.attacker = healer.ID
		mob:sendHealth(healer.damage, healer.critChance)
		healer.damage = 0
	end,
	on_attacked = function(mob, attacker)
		mob_ai_basic.on_attacked(mob, attacker)
	end,
	on_spawn = function(mob)
		local pc = mob:getObjectsInArea(BL_PC)

		if #pc > 0 then
			for i = 1, #pc do
				if pc[i].state ~= 1 then
					mob.target = pc[math.random(#pc)].ID
				end
			end
		end
		mob.state = MOB_ALIVE
	end,
	flare = function(mob, target)
		local spellName = "Flare"
		local anim = 48
		local damage = math.random(371, 591)
		local dialog = {"Burn, fool!", "GRRRR!", "I'll eat your liver!"}
		local r2 = math.random(1, 3)

		if mob.sleep ~= 1 then
			return
		end

		mob:playSound(46)
		mob:talk(2, dialog[r2])

		target:sendMinitext("" .. mob.name .. " cast " .. spellName .. " on you")
		target:sendAnimation(anim)
		target:removeHealthExtend(damage, 1, 1, 1, 1, 3)
		target:calcStat()

		mob.registry["flare_timer"] = 0
	end,
	fireball = function(mob, target)
		local spellName = "Fireball"
		local anim = 55
		local damage = math.random(3044, 4848)
		local dialog = {"You will be ashes!", "BUUUUURN!", "GAARARH!"}
		local r2 = math.random(1, 3)
		local pc = target:getObjectsInArea(BL_PC)

		if mob.sleep ~= 1 then
			return
		end

		mob:playSound(49)
		mob:talk(2, dialog[r2])

		target:sendMinitext("" .. mob.name .. " cast " .. spellName .. " on you")
		target:sendAnimation(anim)
		target:removeHealthExtend(damage, 1, 1, 1, 1, 3)
		target:calcStat()

		for i = 1, #pc do
			if distanceSquare(pc[i], target, 1) then
				target:sendMinitext("" .. mob.name .. " burns you with it's " .. spellName)
				target:removeHealthExtend(damage, 1, 1, 1, 1, 3)
				target:calcStat()
			end
		end

		mob.registry["fireball_timer"] = 0
	end
}
