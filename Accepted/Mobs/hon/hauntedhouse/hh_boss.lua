hh_boss = {
	magicCast = function(mob, target)
		--	local areaPC = mob:getObjectsInArea(BL_PC)
		--	local r = math.random(1, #areaPC)
		--	local targetPC = areaPC[r]
		--	mob:talk(0,""..target.name)
		local pc = mob:getObjectsInArea(BL_PC)
		local targetPC = target
		local facingPC = getTargetFacing(mob, BL_PC)
		local counter = math.random(0, 2)

		if #pc == 0 then
			return
		end
		if target == nil then
			return
		end
		if target.m ~= mob.m then
			return
		end
		if mob.paralyzed == true or mob.sleep > 1 or mob.blind then
			return
		end

		mob.registry["boo_timer"] = mob.registry["boo_timer"] + counter
		mob.registry["haunting_presence_timer"] = mob.registry["haunting_presence_timer"] + counter
		mob.registry["mind_melt_timer"] = mob.registry["mind_melt_timer"] + counter
		mob.registry["mentoks_possesssion_timer"] = mob.registry["mentoks_possesssion_timer"] + counter
		mob.registry["heal_timer"] = mob.registry["heal_timer"] + counter

		if mob.registry["boo_timer"] >= 20 then
			if facingPC ~= nil then
				hh_boss.boo(mob, facingPC)
				return
			end
		end

		if mob.registry["haunting_presence_timer"] >= 11 then
			if distanceSquare(mob, target, 15) then
				hh_boss.haunting_presence(mob, target)
				return
			end
		end

		if mob.registry["mind_melt_timer"] >= 27 then
			if distanceSquare(mob, target, 15) then
				hh_boss.mind_melt(mob, target)
				return
			end
		end

		if mob.registry["mentoks_possesssion_timer"] >= 20 then
			if distanceSquare(mob, target, 15) then
				hh_boss.mentoks_possesssion(mob, target)
				return
			end
		end

		if mob.registry["heal_timer"] >= 22 then
			hh_boss.heal(mob)
			return
		end
	end,
	move = function(mob, target)
		mob_ai_basic.move(mob, target)
		hh_boss.magicCast(mob, target)
	end,
	attack = function(mob, target)
		mob_ai_basic.attack(mob, target)
		hh_boss.magicCast(mob, target)
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
		mob:talk(1, "" .. mob.name .. "! Mind Taker! OooOOOooo!")
		mob.registry["boo_timer"] = 10
		mob.registry["haunting_presence_timer"] = 10
		mob.registry["possess_timer"] = 10
		mob.registry["heal_timer"] = 10
		mob.state = MOB_ALIVE
	end,
	boo = function(mob, target)
		local damage

		if mob.yname == "mentok" then
			damage = math.random(180, 286)
		elseif mob.yname == "chilled_mentok" then
			damage = math.random(450, 716)
		elseif mob.yname == "mentok_the_mind_taker" then
			damage = math.random(1000, 1500)
		end

		mob:talk(2, "Boo!")
		mob:playSound(71)
		mob:sendAction(1, 20)
		target:sendAnimation(343)
		target:removeHealthExtend(damage, 1, 1, 1, 1, 3)
		mob.registry["boo_timer"] = 0
	end,
	haunting_presence = function(mob, target)
		local spellName = "Haunting Presence"
		local anim = 550
		local damage
		local dialog = {"OooOOoo!", "Leave!", "Intruder!"}
		local r = math.random(1, 5000)
		local r2 = math.random(1, 3)

		if mob.yname == "mentok" then
			damage = math.random(90, 143)
		elseif mob.yname == "chilled_mentok" then
			damage = math.random(225, 358)
		elseif mob.yname == "mentok_the_mind_taker" then
			damage = math.random(500, 750)
		end

		mob:playSound(25)
		mob:talk(2, dialog[r2])

		target:sendMinitext("" .. mob.name .. " cast " .. spellName .. " on you")
		target:sendAnimation(anim)
		target:removeHealthExtend(damage, 1, 1, 1, 1, 3)
		target:calcStat()

		mob.registry["haunting_presence_timer"] = 0
	end,
	mind_melt = function(mob, target)
		local r = math.random(1, 5000)
		local spellName = "Mind Melt"
		local anim = 390
		local damage

		if mob.yname == "mentok" then
			damage = math.random(180, 286)
		elseif mob.yname == "chilled_mentok" then
			damage = math.random(450, 716)
		elseif mob.yname == "mentok_the_mind_taker" then
			damage = math.random(1000, 1500)
		end

		mob:playSound(34)
		mob:talk(2, "Mind Melt!")

		target:sendMinitext("" .. mob.name .. " cast " .. spellName .. " on you")
		target:sendAnimation(anim)
		target:removeHealthExtend(damage, 1, 1, 1, 1, 3)
		target:calcStat()

		mob.registry["mind_melt_timer"] = 0
		mob.registry["haunting_presence_timer"] = 0
	end,
	mentoks_possesssion = function(mob, target)
		local r = math.random(1, 2000)
		local spellName = "Mentok's Possession"
		local spellYname = ""
		local duration = 220000
		local anim = 111

		if mob.yname == "mentok" or mob.yname == "cat" then
			spellYname = "mentoks_possession_1"
		elseif mob.yname == "chilled_mentok" then
			spellYname = "mentoks_possession_2"
		elseif mob.yname == "mentok_the_mind_taker" then
			spellYname = "mentoks_possession_3"
		end

		mob:playSound(66)
		mob:talk(2, "I'm in your head now!")

		if not target:hasDuration(spellYname) then
			target:sendMinitext("" .. mob.name .. " cast " .. spellName .. " on you")
			target:setDuration(spellYname, duration)
			target:sendAnimation(anim)
			target:calcStat()
		end

		mob.registry["mentoks_possesssion_timer"] = 0
	end,
	heal = function(mob)
		local healAmount

		if mob.yname == "mentok" or mob.yname == "cat" then
			healAmount = 1200
		elseif mob.yname == "chilled_mentok" then
			healAmount = 50000
		elseif mob.yname == "mentok_the_mind_taker" then
			healAmount = 225000
		end

		mob:talk(2, "Fool, I'm already dead!")
		mob:sendAnimation(5)
		mob:playSound(708)
		mob.health = mob.health + healAmount
		if mob.health > mob.maxHealth then
			mob.health = mob.maxHealth
		end
		mob.registry["heal_timer"] = 0
	end
}

mentoks_possession_1 = {
	while_cast = function(player)
		player:sendAnimation(34)
	end,
	recast = function(player)
		player.armor = player.armor - 750
		if player.armor < 0 then
			player.armor = 0
		end

		player.might = player.might - 3
		if player.might < 1 then
			player.might = 1
		end

		player.grace = player.grace - 3
		if player.grace < 1 then
			player.grace = 1
		end

		player.will = player.will - 3
		if player.will < 1 then
			player.will = 1
		end
	end,
	uncast = function(player)
		player:calcStat()
	end
}

mentoks_possession_2 = {
	while_cast = function(player)
		player:sendAnimation(34)
	end,
	recast = function(player)
		player.armor = player.armor - 2000
		if player.armor < 0 then
			player.armor = 0
		end

		player.might = player.might - 7
		if player.might < 1 then
			player.might = 1
		end

		player.grace = player.grace - 7
		if player.grace < 1 then
			player.grace = 1
		end

		player.will = player.will - 7
		if player.will < 1 then
			player.will = 1
		end
	end,
	uncast = function(player)
		player:calcStat()
	end
}

mentoks_possession_3 = {
	while_cast = function(player)
		player:sendAnimation(34)
	end,
	recast = function(player)
		player.armor = player.armor - 5000
		if player.armor < 0 then
			player.armor = 0
		end

		player.might = player.might - 12
		if player.might < 1 then
			player.might = 1
		end

		player.grace = player.grace - 12
		if player.grace < 1 then
			player.grace = 1
		end

		player.will = player.will - 12
		if player.will < 1 then
			player.will = 1
		end
	end,
	uncast = function(player)
		player:calcStat()
	end
}
