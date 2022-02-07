mr_snow_man = {
	-------------------------------
	after_death = function(mob)
	end,
	before_death = function(mob)
	end,
	areaSwing = function(mob)
		local pcarea = mob:getObjectsInArea(BL_PC)

		if #pcarea > 0 then
			for i = 1, #pcarea do
				if pcarea[i].state ~= 1 then
					if distanceSquare(mob, pcarea[i], 5) then
						mob:attack(pcarea[i].ID)
					end
				end
			end
		end
	end,
	magicCast = function(mob, target)
		local chance = math.random(1, 100000)
		local pc = mob:getObjectsInArea(BL_PC)
		local t = pc[math.random(1, #pc)].ID

		---------- Cast Snowstorm (20% Chance)---------------------------
		if chance <= 20000 then
			---------- Cast Heal (10% Chance)---------------------------
			if #pc > 0 then
				for i = 1, #pc do
					if Player(t) ~= nil and Player(t).state ~= 1 then
						snowstorm.cast(mob, Player(t))
					end
				end
			end
		elseif chance > 20000 and chance <= 30000 then
			---------- Cast Snowman's Flurry (10% Chance)---------------------------
			mob:sendAnimation(5)
			mob:playSound(98)
			mob.magic = mob.magic + 1000000
			mob:addHealthExtend(1000000, 1, 1, 1, 1, 0)
		elseif chance > 30000 and chance <= 40000 then
			---------- Cast SnFreeze Solid (10% Chance)---------------------------
			if not mob:hasDuration("snowmans_flurry") then
				snowmans_flurry.cast(mob)
			end
		elseif chance > 40000 and chance <= 50000 then
			---------- Cast Mob Resummon (% Chance)---------------------------
			if #pc > 0 then
				for i = 1, #pc do
					if Player(t) ~= nil and Player(t).state ~= 1 then
						freeze_solid.cast(mob, Player(t))
					end
				end
			end
		elseif chance > 50000 and chance <= 55000 then
			mob:talk(2, "You'll never get me lucky charms!")
		end
	end,
	move = function(mob, target)
		local moved = true
		mr_snow_man.areaSwing(mob, target)
		mr_snow_man.magicCast(mob, target)
	end,
	attack = function(mob, target)
		mr_snow_man.areaSwing(mob, target)
		mr_snow_man.magicCast(mob, target)
	end,
	on_healed = function(mob, healer) --
		--[[
		mob.attacker = healer.ID
		mob:sendHealth(healer.damage, healer.critChance)
		healer.damage = 0
	]]
	end,
	on_attacked = function(mob, attacker)
		local damage = 0
		 --
		--[[	
		if attacker.damage > 0 then
			if attacker.damage - mob.armor > 0 then
				damage = attacker.damage - mob.armor
			end
		end
		mob.attacker = attacker.ID
		mob:sendHealth(damage, attacker.critChance)
	]] mob_ai_basic.on_attacked(
			mob,
			attacker
		)
	end,
	on_spawn = function(mob)
		local pc = mob:getObjectsInArea(BL_PC)
		 --
		--[[	
		if #pc > 0 then
			for i = 1, #pc do
				if pc[i].state ~= 1 then
					mob.target = pc[math.random(#pc)].ID
				end
			end
		end
	]] mob.state =
			MOB_ALIVE
		mob.side = 2
	end
	----------------------
}

mrs_snow_woman = {
	-------------------------------
	after_death = function(mob)
	end,
	before_death = function(mob)
	end,
	areaSwing = function(mob)
		local pcarea = mob:getObjectsInArea(BL_PC)

		if #pcarea > 0 then
			for i = 1, #pcarea do
				if pcarea[i].state ~= 1 then
					if distanceSquare(mob, pcarea[i], 3) then
						mob:attack(pcarea[i].ID)
					end
				end
			end
		end
	end,
	magicCast = function(mob, target)
		local chance = math.random(1, 100000)
		local pc = mob:getObjectsInArea(BL_PC)
		local t = pc[math.random(1, #pc)].ID

		---------- Cast Snowstorm (20% Chance)---------------------------
		if chance <= 20000 then
			---------- Cast Heal (10% Chance)---------------------------
			if #pc > 0 then
				for i = 1, #pc do
					if Player(t) ~= nil and Player(t).state ~= 1 then
						snowstorm.cast(mob, Player(t))
					end
				end
			end
		elseif chance > 20000 and chance <= 30000 then
			---------- Cast Snowman's Flurry (10% Chance)---------------------------
			mob:sendAnimation(5)
			mob:playSound(98)
			mob.magic = mob.magic + 1000000
			mob:addHealthExtend(1000000, 1, 1, 1, 1, 0)
		elseif chance > 30000 and chance <= 40000 then
			---------- Cast SnFreeze Solid (10% Chance)---------------------------
			if not mob:hasDuration("snowmans_flurry") then
				snowmans_flurry.cast(mob)
			end
		elseif chance > 40000 and chance <= 50000 then
			---------- Cast Mob Resummon (% Chance)---------------------------
			if #pc > 0 then
				for i = 1, #pc do
					if Player(t) ~= nil and Player(t).state ~= 1 then
						freeze_solid.cast(mob, Player(t))
					end
				end
			end
		elseif chance > 50000 and chance <= 55000 then
			mob:talk(2, "MINIONS, RISE!")
			minionRespawn(mob)
		end
	end,
	move = function(mob, target)
		local moved = true

		mr_snow_man.areaSwing(mob, target)
		mr_snow_man.magicCast(mob, target)
	end,
	attack = function(mob, target)
		mr_snow_man.areaSwing(mob, target)
		mr_snow_man.magicCast(mob, target)
	end,
	on_healed = function(mob, healer) --
		--[[
		mob.attacker = healer.ID
		mob:sendHealth(healer.damage, healer.critChance)
		healer.damage = 0
	]]
	end,
	on_attacked = function(mob, attacker)
		local damage = 0
		 --
		--[[	
		if attacker.damage > 0 then
			if attacker.damage - mob.armor > 0 then
				damage = attacker.damage - mob.armor
			end
		end
		mob.attacker = attacker.ID
		mob:sendHealth(damage, attacker.critChance)
	]] mob_ai_basic.on_attacked(
			mob,
			attacker
		)
	end,
	on_spawn = function(mob)
		local pc = mob:getObjectsInArea(BL_PC)
		 --
		--[[	
		if #pc > 0 then
			for i = 1, #pc do
				if pc[i].state ~= 1 then
					mob.target = pc[math.random(#pc)].ID
				end
			end
		end
	]] mob.state =
			MOB_ALIVE
		mob.side = 2
	end
	-------------------------------
}

major_cane = {
	-------------------------------
	after_death = function(mob)
	end,
	before_death = function(mob)
	end,
	areaSwing = function(mob)
		local pcarea = mob:getObjectsInArea(BL_PC)

		if #pcarea > 0 then
			for i = 1, #pcarea do
				if pcarea[i].state ~= 1 then
					if distanceSquare(mob, pcarea[i], 3) then
						mob:attack(pcarea[i].ID)
					end
				end
			end
		end
	end,
	magicCast = function(mob, target)
		local chance = math.random(1, 100000)
		local pc = mob:getObjectsInArea(BL_PC)
		local t = pc[math.random(1, #pc)].ID

		---------- Cast Snowstorm (20% Chance)---------------------------
		if chance <= 20000 then
			---------- Cast Heal (10% Chance)---------------------------
			if #pc > 0 then
				for i = 1, #pc do
					if Player(t) ~= nil and Player(t).state ~= 1 then
						snowstorm.cast(mob, Player(t))
					end
				end
			end
		elseif chance > 20000 and chance <= 30000 then
			---------- Cast Snowman's Flurry (10% Chance)---------------------------
			mob:sendAnimation(5)
			mob:playSound(98)
			mob.magic = mob.magic + 1000000
			mob:addHealthExtend(1000000, 1, 1, 1, 1, 0)
		elseif chance > 30000 and chance <= 40000 then
			---------- Cast SnFreeze Solid (10% Chance)---------------------------
			if not mob:hasDuration("snowmans_flurry") then
				snowmans_flurry.cast(mob)
			end
		elseif chance > 40000 and chance <= 50000 then
			---------- Cast Mob Resummon (% Chance)---------------------------
			if #pc > 0 then
				for i = 1, #pc do
					if Player(t) ~= nil and Player(t).state ~= 1 then
						freeze_solid.cast(mob, Player(t))
					end
				end
			end
		elseif chance > 50000 and chance <= 55000 then
			mob:talk(2, "MINIONS, RISE!")
			minionRespawn(mob)
		end
	end,
	move = function(mob, target)
		local moved = true

		mr_snow_man.areaSwing(mob, target)
		mr_snow_man.magicCast(mob, target)
	end,
	attack = function(mob, target)
		mr_snow_man.areaSwing(mob, target)
		mr_snow_man.magicCast(mob, target)
	end,
	on_healed = function(mob, healer) --
		--[[
		mob.attacker = healer.ID
		mob:sendHealth(healer.damage, healer.critChance)
		healer.damage = 0
	]]
	end,
	on_attacked = function(mob, attacker)
		local damage = 0
		 --
		--[[	
		if attacker.damage > 0 then
			if attacker.damage - mob.armor > 0 then
				damage = attacker.damage - mob.armor
			end
		end
		mob.attacker = attacker.ID
		mob:sendHealth(damage, attacker.critChance)
	]] mob_ai_basic.on_attacked(
			mob,
			attacker
		)
	end,
	on_spawn = function(mob)
		local pc = mob:getObjectsInArea(BL_PC)
		 --
		--[[	
		if #pc > 0 then
			for i = 1, #pc do
				if pc[i].state ~= 1 then
					mob.target = pc[math.random(#pc)].ID
				end
			end
		end
	]] mob.state =
			MOB_ALIVE
		mob.side = 2
	end
	-------------------------------
}

mistress_able = {
	-------------------------------
	after_death = function(mob)
	end,
	before_death = function(mob)
	end,
	areaSwing = function(mob)
		local pcarea = mob:getObjectsInArea(BL_PC)

		if #pcarea > 0 then
			for i = 1, #pcarea do
				if pcarea[i].state ~= 1 then
					if distanceSquare(mob, pcarea[i], 3) then
						mob:attack(pcarea[i].ID)
					end
				end
			end
		end
	end,
	magicCast = function(mob, target)
		local chance = math.random(1, 100000)
		local pc = mob:getObjectsInArea(BL_PC)
		local t = pc[math.random(1, #pc)].ID

		---------- Cast Snowstorm (20% Chance)---------------------------
		if chance <= 20000 then
			---------- Cast Heal (10% Chance)---------------------------
			if #pc > 0 then
				for i = 1, #pc do
					if Player(t) ~= nil and Player(t).state ~= 1 then
						snowstorm.cast(mob, Player(t))
					end
				end
			end
		elseif chance > 20000 and chance <= 30000 then
			---------- Cast Snowman's Flurry (10% Chance)---------------------------
			mob:sendAnimation(5)
			mob:playSound(98)
			mob.magic = mob.magic + 1000000
			mob:addHealthExtend(1000000, 1, 1, 1, 1, 0)
		elseif chance > 30000 and chance <= 40000 then
			---------- Cast SnFreeze Solid (10% Chance)---------------------------
			if not mob:hasDuration("snowmans_flurry") then
				snowmans_flurry.cast(mob)
			end
		elseif chance > 40000 and chance <= 50000 then
			---------- Cast Mob Resummon (% Chance)---------------------------
			if #pc > 0 then
				for i = 1, #pc do
					if Player(t) ~= nil and Player(t).state ~= 1 then
						freeze_solid.cast(mob, Player(t))
					end
				end
			end
		elseif chance > 50000 and chance <= 55000 then
			mob:talk(2, "MINIONS, RISE!")
			minionRespawn(mob)
		end
	end,
	move = function(mob, target)
		local moved = true

		mr_snow_man.areaSwing(mob, target)
		mr_snow_man.magicCast(mob, target)
	end,
	attack = function(mob, target)
		mr_snow_man.areaSwing(mob, target)
		mr_snow_man.magicCast(mob, target)
	end,
	on_healed = function(mob, healer) --
		--[[
		mob.attacker = healer.ID
		mob:sendHealth(healer.damage, healer.critChance)
		healer.damage = 0
	]]
	end,
	on_attacked = function(mob, attacker)
		local damage = 0
		 --
		--[[	
		if attacker.damage > 0 then
			if attacker.damage - mob.armor > 0 then
				damage = attacker.damage - mob.armor
			end
		end
		mob.attacker = attacker.ID
		mob:sendHealth(damage, attacker.critChance)
	]] mob_ai_basic.on_attacked(
			mob,
			attacker
		)
	end,
	on_spawn = function(mob)
		local pc = mob:getObjectsInArea(BL_PC)
		 --
		--[[	
		if #pc > 0 then
			for i = 1, #pc do
				if pc[i].state ~= 1 then
					mob.target = pc[math.random(#pc)].ID
				end
			end
		end
	]] mob.state =
			MOB_ALIVE
		mob.side = 2
	end
	-------------------------------
}

craig_the_snowman = {
	-------------------------------
	after_death = function(mob)
	end,
	before_death = function(mob)
	end,
	areaSwing = function(mob)
		local pcarea = mob:getObjectsInArea(BL_PC)

		if #pcarea > 0 then
			for i = 1, #pcarea do
				if pcarea[i].state ~= 1 then
					if distanceSquare(mob, pcarea[i], 3) then
						mob:attack(pcarea[i].ID)
					end
				end
			end
		end
	end,
	magicCast = function(mob, target)
		local chance = math.random(1, 100000)
		local pc = mob:getObjectsInArea(BL_PC)
		local t = pc[math.random(1, #pc)].ID

		---------- Cast Snowstorm (20% Chance)---------------------------
		if chance <= 20000 then
			---------- Cast Heal (10% Chance)---------------------------
			if #pc > 0 then
				for i = 1, #pc do
					if Player(t) ~= nil and Player(t).state ~= 1 then
						snowstorm.cast(mob, Player(t))
					end
				end
			end
		elseif chance > 20000 and chance <= 30000 then
			---------- Cast Snowman's Flurry (10% Chance)---------------------------
			mob:sendAnimation(5)
			mob:playSound(98)
			mob.magic = mob.magic + 1000000
			mob:addHealthExtend(1000000, 1, 1, 1, 1, 0)
		elseif chance > 30000 and chance <= 40000 then
			---------- Cast SnFreeze Solid (10% Chance)---------------------------
			if not mob:hasDuration("snowmans_flurry") then
				snowmans_flurry.cast(mob)
			end
		elseif chance > 40000 and chance <= 50000 then
			---------- Cast Mob Resummon (% Chance)---------------------------
			if #pc > 0 then
				for i = 1, #pc do
					if Player(t) ~= nil and Player(t).state ~= 1 then
						freeze_solid.cast(mob, Player(t))
					end
				end
			end
		elseif chance > 50000 and chance <= 55000 then
			mob:talk(2, "MINIONS, RISE!")
			minionRespawn(mob)
		end
	end,
	move = function(mob, target)
		local moved = true

		mr_snow_man.areaSwing(mob, target)
		mr_snow_man.magicCast(mob, target)
	end,
	attack = function(mob, target)
		mr_snow_man.areaSwing(mob, target)
		mr_snow_man.magicCast(mob, target)
	end,
	on_healed = function(mob, healer) --
		--[[
		mob.attacker = healer.ID
		mob:sendHealth(healer.damage, healer.critChance)
		healer.damage = 0
	]]
	end,
	on_attacked = function(mob, attacker)
		local damage = 0
		 --
		--[[	
		if attacker.damage > 0 then
			if attacker.damage - mob.armor > 0 then
				damage = attacker.damage - mob.armor
			end
		end
		mob.attacker = attacker.ID
		mob:sendHealth(damage, attacker.critChance)
	]] mob_ai_basic.on_attacked(
			mob,
			attacker
		)
	end,
	on_spawn = function(mob)
		local pc = mob:getObjectsInArea(BL_PC)
		 --
		--[[	
		if #pc > 0 then
			for i = 1, #pc do
				if pc[i].state ~= 1 then
					mob.target = pc[math.random(#pc)].ID
				end
			end
		end
	]] mob.state =
			MOB_ALIVE
		mob.side = 2
	end
	-------------------------------
}

frosty_the_flake = {
	-------------------------------
	after_death = function(mob)
	end,
	before_death = function(mob)
	end,
	areaSwing = function(mob)
		local pcarea = mob:getObjectsInArea(BL_PC)

		if #pcarea > 0 then
			for i = 1, #pcarea do
				if pcarea[i].state ~= 1 then
					if distanceSquare(mob, pcarea[i], 3) then
						mob:attack(pcarea[i].ID)
					end
				end
			end
		end
	end,
	magicCast = function(mob, target)
		local chance = math.random(1, 100000)
		local pc = mob:getObjectsInArea(BL_PC)
		local t = pc[math.random(1, #pc)].ID

		---------- Cast Snowstorm (20% Chance)---------------------------
		if chance <= 20000 then
			---------- Cast Heal (10% Chance)---------------------------
			if #pc > 0 then
				for i = 1, #pc do
					if Player(t) ~= nil and Player(t).state ~= 1 then
						snowstorm.cast(mob, Player(t))
					end
				end
			end
		elseif chance > 20000 and chance <= 30000 then
			---------- Cast Snowman's Flurry (10% Chance)---------------------------
			mob:sendAnimation(5)
			mob:playSound(98)
			mob.magic = mob.magic + 1000000
			mob:addHealthExtend(1000000, 1, 1, 1, 1, 0)
		elseif chance > 30000 and chance <= 40000 then
			---------- Cast SnFreeze Solid (10% Chance)---------------------------
			if not mob:hasDuration("snowmans_flurry") then
				snowmans_flurry.cast(mob)
			end
		elseif chance > 40000 and chance <= 50000 then
			---------- Cast Mob Resummon (% Chance)---------------------------
			if #pc > 0 then
				for i = 1, #pc do
					if Player(t) ~= nil and Player(t).state ~= 1 then
						freeze_solid.cast(mob, Player(t))
					end
				end
			end
		elseif chance > 50000 and chance <= 55000 then
			mob:talk(2, "MINIONS, RISE!")
			minionRespawn(mob)
		end
	end,
	move = function(mob, target)
		local moved = true

		mr_snow_man.areaSwing(mob, target)
		mr_snow_man.magicCast(mob, target)
	end,
	attack = function(mob, target)
		mr_snow_man.areaSwing(mob, target)
		mr_snow_man.magicCast(mob, target)
	end,
	on_healed = function(mob, healer) --
		--[[
		mob.attacker = healer.ID
		mob:sendHealth(healer.damage, healer.critChance)
		healer.damage = 0
	]]
	end,
	on_attacked = function(mob, attacker)
		local damage = 0
		 --
		--[[	
		if attacker.damage > 0 then
			if attacker.damage - mob.armor > 0 then
				damage = attacker.damage - mob.armor
			end
		end
		mob.attacker = attacker.ID
		mob:sendHealth(damage, attacker.critChance)
	]] mob_ai_basic.on_attacked(
			mob,
			attacker
		)
	end,
	on_spawn = function(mob)
		local pc = mob:getObjectsInArea(BL_PC)
		 --
		--[[	
		if #pc > 0 then
			for i = 1, #pc do
				if pc[i].state ~= 1 then
					mob.target = pc[math.random(#pc)].ID
				end
			end
		end
	]] mob.state =
			MOB_ALIVE
		mob.side = 2
	end
	-------------------------------
}

yellow_snowman = {
	-------------------------------
	after_death = function(mob)
	end,
	before_death = function(mob)
	end,
	areaSwing = function(mob)
		local pcarea = mob:getObjectsInArea(BL_PC)

		if #pcarea > 0 then
			for i = 1, #pcarea do
				if pcarea[i].state ~= 1 then
					if distanceSquare(mob, pcarea[i], 3) then
						mob:attack(pcarea[i].ID)
					end
				end
			end
		end
	end,
	magicCast = function(mob, target)
		local chance = math.random(1, 100000)
		local pc = mob:getObjectsInArea(BL_PC)
		local t = pc[math.random(1, #pc)].ID

		---------- Cast Snowstorm (20% Chance)---------------------------
		if chance <= 20000 then
			---------- Cast Heal (10% Chance)---------------------------
			if #pc > 0 then
				for i = 1, #pc do
					if Player(t) ~= nil and Player(t).state ~= 1 then
						snowstorm.cast(mob, Player(t))
					end
				end
			end
		elseif chance > 20000 and chance <= 30000 then
			---------- Cast Snowman's Flurry (10% Chance)---------------------------
			mob:sendAnimation(5)
			mob:playSound(98)
			mob.magic = mob.magic + 1000000
			mob:addHealthExtend(1000000, 1, 1, 1, 1, 0)
		elseif chance > 30000 and chance <= 40000 then
			---------- Cast SnFreeze Solid (10% Chance)---------------------------
			if not mob:hasDuration("snowmans_flurry") then
				snowmans_flurry.cast(mob)
			end
		elseif chance > 40000 and chance <= 50000 then
			---------- Cast Mob Resummon (% Chance)---------------------------
			if #pc > 0 then
				for i = 1, #pc do
					if Player(t) ~= nil and Player(t).state ~= 1 then
						freeze_solid.cast(mob, Player(t))
					end
				end
			end
		elseif chance > 50000 and chance <= 55000 then
			mob:talk(2, "MINIONS, RISE!")
			minionRespawn(mob)
		end
	end,
	move = function(mob, target)
		local moved = true

		mr_snow_man.areaSwing(mob, target)
		mr_snow_man.magicCast(mob, target)
	end,
	attack = function(mob, target)
		mr_snow_man.areaSwing(mob, target)
		mr_snow_man.magicCast(mob, target)
	end,
	on_healed = function(mob, healer) --
		--[[
		mob.attacker = healer.ID
		mob:sendHealth(healer.damage, healer.critChance)
		healer.damage = 0
	]]
	end,
	on_attacked = function(mob, attacker)
		local damage = 0
		 --
		--[[	
		if attacker.damage > 0 then
			if attacker.damage - mob.armor > 0 then
				damage = attacker.damage - mob.armor
			end
		end
		mob.attacker = attacker.ID
		mob:sendHealth(damage, attacker.critChance)
	]] mob_ai_basic.on_attacked(
			mob,
			attacker
		)
	end,
	on_spawn = function(mob)
		local pc = mob:getObjectsInArea(BL_PC)
		 --
		--[[	
		if #pc > 0 then
			for i = 1, #pc do
				if pc[i].state ~= 1 then
					mob.target = pc[math.random(#pc)].ID
				end
			end
		end
	]] mob.state =
			MOB_ALIVE
		mob.side = 2
	end
	-------------------------------
}

yellow_snow_woman = {
	-------------------------------
	after_death = function(mob)
	end,
	before_death = function(mob)
	end,
	areaSwing = function(mob)
		local pcarea = mob:getObjectsInArea(BL_PC)

		if #pcarea > 0 then
			for i = 1, #pcarea do
				if pcarea[i].state ~= 1 then
					if distanceSquare(mob, pcarea[i], 3) then
						mob:attack(pcarea[i].ID)
					end
				end
			end
		end
	end,
	magicCast = function(mob, target)
		local chance = math.random(1, 100000)
		local pc = mob:getObjectsInArea(BL_PC)
		local t = pc[math.random(1, #pc)].ID

		---------- Cast Snowstorm (20% Chance)---------------------------
		if chance <= 20000 then
			---------- Cast Heal (10% Chance)---------------------------
			if #pc > 0 then
				for i = 1, #pc do
					if Player(t) ~= nil and Player(t).state ~= 1 then
						snowstorm.cast(mob, Player(t))
					end
				end
			end
		elseif chance > 20000 and chance <= 30000 then
			---------- Cast Snowman's Flurry (10% Chance)---------------------------
			mob:sendAnimation(5)
			mob:playSound(98)
			mob.magic = mob.magic + 1000000
			mob:addHealthExtend(1000000, 1, 1, 1, 1, 0)
		elseif chance > 30000 and chance <= 40000 then
			---------- Cast SnFreeze Solid (10% Chance)---------------------------
			if not mob:hasDuration("snowmans_flurry") then
				snowmans_flurry.cast(mob)
			end
		elseif chance > 40000 and chance <= 50000 then
			---------- Cast Mob Resummon (% Chance)---------------------------
			if #pc > 0 then
				for i = 1, #pc do
					if Player(t) ~= nil and Player(t).state ~= 1 then
						freeze_solid.cast(mob, Player(t))
					end
				end
			end
		elseif chance > 50000 and chance <= 55000 then
			mob:talk(2, "MINIONS, RISE!")
			minionRespawn(mob)
		end
	end,
	move = function(mob, target)
		local moved = true

		mr_snow_man.areaSwing(mob, target)
		mr_snow_man.magicCast(mob, target)
	end,
	attack = function(mob, target)
		mr_snow_man.areaSwing(mob, target)
		mr_snow_man.magicCast(mob, target)
	end,
	on_healed = function(mob, healer) --
		--[[
		mob.attacker = healer.ID
		mob:sendHealth(healer.damage, healer.critChance)
		healer.damage = 0
	]]
	end,
	on_attacked = function(mob, attacker)
		local damage = 0
		 --
		--[[	
		if attacker.damage > 0 then
			if attacker.damage - mob.armor > 0 then
				damage = attacker.damage - mob.armor
			end
		end
		mob.attacker = attacker.ID
		mob:sendHealth(damage, attacker.critChance)
	]] mob_ai_basic.on_attacked(
			mob,
			attacker
		)
	end,
	on_spawn = function(mob)
		local pc = mob:getObjectsInArea(BL_PC)
		 --
		--[[	
		if #pc > 0 then
			for i = 1, #pc do
				if pc[i].state ~= 1 then
					mob.target = pc[math.random(#pc)].ID
				end
			end
		end
	]] mob.state =
			MOB_ALIVE
		mob.side = 2
	end
	-------------------------------
}

kulu_snowman = {
	-------------------------------
	after_death = function(mob)
	end,
	before_death = function(mob)
	end,
	areaSwing = function(mob)
		local pcarea = mob:getObjectsInArea(BL_PC)

		if #pcarea > 0 then
			for i = 1, #pcarea do
				if pcarea[i].state ~= 1 then
					if distanceSquare(mob, pcarea[i], 3) then
						mob:attack(pcarea[i].ID)
					end
				end
			end
		end
	end,
	magicCast = function(mob, target)
		local chance = math.random(1, 100000)
		local pc = mob:getObjectsInArea(BL_PC)
		local t = pc[math.random(1, #pc)].ID

		---------- Cast Snowstorm (20% Chance)---------------------------
		if chance <= 20000 then
			---------- Cast Heal (10% Chance)---------------------------
			if #pc > 0 then
				for i = 1, #pc do
					if Player(t) ~= nil and Player(t).state ~= 1 then
						snowstorm.cast(mob, Player(t))
					end
				end
			end
		elseif chance > 20000 and chance <= 30000 then
			---------- Cast Snowman's Flurry (10% Chance)---------------------------
			mob:sendAnimation(5)
			mob:playSound(98)
			mob.magic = mob.magic + 1000000
			mob:addHealthExtend(1000000, 1, 1, 1, 1, 0)
		elseif chance > 30000 and chance <= 40000 then
			---------- Cast SnFreeze Solid (10% Chance)---------------------------
			if not mob:hasDuration("snowmans_flurry") then
				snowmans_flurry.cast(mob)
			end
		elseif chance > 40000 and chance <= 50000 then
			---------- Cast Mob Resummon (% Chance)---------------------------
			if #pc > 0 then
				for i = 1, #pc do
					if Player(t) ~= nil and Player(t).state ~= 1 then
						freeze_solid.cast(mob, Player(t))
					end
				end
			end
		elseif chance > 50000 and chance <= 55000 then
			mob:talk(2, "MINIONS, RISE!")
			minionRespawn(mob)
		end
	end,
	move = function(mob, target)
		local moved = true

		mr_snow_man.areaSwing(mob, target)
		mr_snow_man.magicCast(mob, target)
	end,
	attack = function(mob, target)
		mr_snow_man.areaSwing(mob, target)
		mr_snow_man.magicCast(mob, target)
	end,
	on_healed = function(mob, healer) --
		--[[
		mob.attacker = healer.ID
		mob:sendHealth(healer.damage, healer.critChance)
		healer.damage = 0
	]]
	end,
	on_attacked = function(mob, attacker)
		local damage = 0
		 --
		--[[	
		if attacker.damage > 0 then
			if attacker.damage - mob.armor > 0 then
				damage = attacker.damage - mob.armor
			end
		end
		mob.attacker = attacker.ID
		mob:sendHealth(damage, attacker.critChance)
	]] mob_ai_basic.on_attacked(
			mob,
			attacker
		)
	end,
	on_spawn = function(mob)
		local pc = mob:getObjectsInArea(BL_PC)
		 --
		--[[	
		if #pc > 0 then
			for i = 1, #pc do
				if pc[i].state ~= 1 then
					mob.target = pc[math.random(#pc)].ID
				end
			end
		end
	]] mob.state =
			MOB_ALIVE
		mob.side = 2
	end
	-------------------------------
}

kulu_snow_woman = {
	-------------------------------
	after_death = function(mob)
	end,
	before_death = function(mob)
	end,
	areaSwing = function(mob)
		local pcarea = mob:getObjectsInArea(BL_PC)

		if #pcarea > 0 then
			for i = 1, #pcarea do
				if pcarea[i].state ~= 1 then
					if distanceSquare(mob, pcarea[i], 3) then
						mob:attack(pcarea[i].ID)
					end
				end
			end
		end
	end,
	magicCast = function(mob, target)
		local chance = math.random(1, 100000)
		local pc = mob:getObjectsInArea(BL_PC)
		local t = pc[math.random(1, #pc)].ID

		---------- Cast Snowstorm (20% Chance)---------------------------
		if chance <= 20000 then
			---------- Cast Heal (10% Chance)---------------------------
			if #pc > 0 then
				for i = 1, #pc do
					if Player(t) ~= nil and Player(t).state ~= 1 then
						snowstorm.cast(mob, Player(t))
					end
				end
			end
		elseif chance > 20000 and chance <= 30000 then
			---------- Cast Snowman's Flurry (10% Chance)---------------------------
			mob:sendAnimation(5)
			mob:playSound(98)
			mob.magic = mob.magic + 1000000
			mob:addHealthExtend(1000000, 1, 1, 1, 1, 0)
		elseif chance > 30000 and chance <= 40000 then
			---------- Cast SnFreeze Solid (10% Chance)---------------------------
			if not mob:hasDuration("snowmans_flurry") then
				snowmans_flurry.cast(mob)
			end
		elseif chance > 40000 and chance <= 50000 then
			---------- Cast Mob Resummon (% Chance)---------------------------
			if #pc > 0 then
				for i = 1, #pc do
					if Player(t) ~= nil and Player(t).state ~= 1 then
						freeze_solid.cast(mob, Player(t))
					end
				end
			end
		elseif chance > 50000 and chance <= 52000 then
			mob:talk(2, "MINIONS, RISE!")
			minionRespawn(mob)
		end
	end,
	move = function(mob, target)
		local moved = true

		mr_snow_man.areaSwing(mob, target)
		mr_snow_man.magicCast(mob, target)
	end,
	attack = function(mob, target)
		mr_snow_man.areaSwing(mob, target)
		mr_snow_man.magicCast(mob, target)
	end,
	on_healed = function(mob, healer) --
		--[[
		mob.attacker = healer.ID
		mob:sendHealth(healer.damage, healer.critChance)
		healer.damage = 0
	]]
	end,
	on_attacked = function(mob, attacker)
		local damage = 0
		 --
		--[[	
		if attacker.damage > 0 then
			if attacker.damage - mob.armor > 0 then
				damage = attacker.damage - mob.armor
			end
		end
		mob.attacker = attacker.ID
		mob:sendHealth(damage, attacker.critChance)
	]] mob_ai_basic.on_attacked(
			mob,
			attacker
		)
	end,
	on_spawn = function(mob)
		local pc = mob:getObjectsInArea(BL_PC)
		 --
		--[[	
		if #pc > 0 then
			for i = 1, #pc do
				if pc[i].state ~= 1 then
					mob.target = pc[math.random(#pc)].ID
				end
			end
		end
	]] mob.state =
			MOB_ALIVE
		mob.side = 2
	end
	-------------------------------
}
