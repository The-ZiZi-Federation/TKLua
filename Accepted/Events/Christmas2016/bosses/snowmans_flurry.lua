-------------------------------------------------------
--   Spell: Snowman's Flurry
--   Class: Boss
--   Level: 99
--  Aether: 1 Sec
--    Cost: ( * Level) MP
-- DmgType: Magical
--    Type: Ice
-- Targets: Self / Ally
-- Damages: Adjacent to Target
--
--          . X .
--          X P X
--          . X .
-------------------------------------------------------
--    Desc: Ice and snow pummel the target
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 12/14/2016
-------------------------------------------------------
snowmans_flurry = {
	cast = function(mob)
		----------------------
		--Varable Declarations
		----------------------
		local magicCost = (mob.level * 40)
		local aether
		if (mob.blType == BL_PC) then
			if mob.gmLevel > 0 then
				aether = 0 -- 0 second cooldown
			else
				aether = 1000 -- 1 second cooldown
			end
		else
			aether = 1000 -- 1 second cooldown
		end

		local anim = 421
		local sound = 58

		local duration = 10000

		mob:calcStat()
		mob:sendAction(6, 20)
		mob:sendAnimation(anim)
		mob:playSound(sound)
		mob:setDuration("snowmans_flurry", duration, mob.ID)
		mob:talk(2, "FLURRY!")
	end,
	while_cast = function(mob)
		----------------------
		--Varable Declarations
		----------------------
		local damageType = "magical"
		local will = mob.will
		local buff

		if (mob.blType == BL_PC) then
			buff = mob.fury
		else
			buff = 1
		end

		local aether

		local magicCost = (mob.level * 5)
		if (mob.blType == BL_PC) then
			if mob.gmLevel > 0 then
				aether = 0 -- 0 second cooldown
			else
				aether = 1000 -- 1 second cooldown
			end
		else
			aether = 1000 -- 1 second cooldown
		end
		local stunDuration = 2000

		local threat

		local m = mob.m
		local x = mob.x
		local y = mob.y
		---------------------------
		--- Spell Damage Formula---
		---------------------------
		local willBase = will ^ 1.2
		local willMult = will ^ 0.13
		local damCalc = (willBase * willMult)

		local damage = (damCalc) * buff
		damage = math.floor(damage)

		-------------------------------------------------------------
		local pc = mob:getObjectsInArea(BL_PC)
		 --

		--[[	
	pcflankTargets = {core:getObjectsInCell(mob.m, mob.x, mob.y - 2, BL_PC)[1],
				core:getObjectsInCell(mob.m, mob.x, mob.y + 2, BL_PC)[1],
				core:getObjectsInCell(mob.m, mob.x - 2, mob.y, BL_PC)[1],
				core:getObjectsInCell(mob.m, mob.x + 2, mob.y, BL_PC)[1]}
				
	for i = 1, 4 do
		if (pcflankTargets[i] ~= nil) then
			if pcflankTargets[i].state ~= 1 then
				snowmans_flurry.takeDamage(mob, pcflankTargets[i], damage)
			end
		end
	end
]] if
			#pc > 0
		 then
			for i = 1, #pc do
				if distanceSquare(mob, pc[i], 10) then
					if pc[i].state ~= 1 then
						snowmans_flurry.takeDamage(mob, pc[i], damage)
					end
				end
			end
		end
	end,
	takeDamage = function(mob, target, damage)
		local threat

		target.attacker = mob.ID
		if target.blType == BL_MOB then
			threat = target:bossSpellDamage(damage, 1, 1, 1, 1, 2)
			mob:addThreat(target.ID, threat)
		end
		target:sendAnimation(421)
		target:bossSpellDamage(damage, 1, 1, 1, 1, 1, 1)
	end
}

minionRespawn = function(mob)
	if mob.m == 30004 then
		mobSpawns.respawn(mob, 30004, 1, 37, 3, 16, 2500001, 10, 10) --Weak Reindeer
		mobSpawns.respawn(mob, 30004, 1, 37, 3, 16, 2500002, 10, 10) --Slow Panda
		mobSpawns.respawn(mob, 30004, 1, 37, 3, 16, 2500003, 10, 10) --Fragile Skeleton
		mobSpawns.respawn(mob, 30004, 1, 37, 3, 16, 2500004, 10, 10) --Prepared Skeleton
	elseif mob.m == 30009 then
		mobSpawns.respawn(mob, 30009, 2, 27, 3, 26, 2500001, 10, 10) -- Weak Reindeer
		mobSpawns.respawn(mob, 30009, 2, 27, 3, 26, 2500002, 10, 10) -- Slow Panda
		mobSpawns.respawn(mob, 30009, 2, 27, 3, 26, 2500003, 10, 10) -- Fragile Skeleton
		mobSpawns.respawn(mob, 30009, 2, 27, 3, 26, 2500004, 10, 10) -- Prepared Skeleton
	elseif m == 30014 then -- Room 4 - Jingle Bell Rock --BOSS ROOM-
		mobSpawns.respawn(mob, 30014, 1, 37, 3, 16, 2500011, 10, 10) --Exhausted Reindeer
		mobSpawns.respawn(mob, 30014, 1, 37, 3, 16, 2500012, 10, 10) --Lazy Panda
		mobSpawns.respawn(mob, 30014, 1, 37, 3, 16, 2500013, 10, 10) --Profane Skeleton
		mobSpawns.respawn(mob, 30014, 1, 37, 3, 16, 2500014, 10, 10) --Creepy Skeleton
	elseif m == 30019 then -- Room 9 - Frosty The Snowman --BOSS ROM--
		mobSpawns.respawn(mob, 30019, 2, 27, 3, 26, 2500011, 10, 10) -- Exhausted Reindeer
		mobSpawns.respawn(mob, 30019, 2, 27, 3, 26, 2500012, 10, 10) -- Lazy Panda
		mobSpawns.respawn(mob, 30019, 2, 27, 3, 26, 2500013, 10, 10) -- Profane Skeleton
		mobSpawns.respawn(mob, 30019, 2, 27, 3, 26, 2500014, 10, 10) -- Creepy Skeleton
	elseif m == 30024 then -- Room 4 - Jingle Bell Rock --BOSS ROOM-
		mobSpawns.respawn(mob, 30024, 1, 37, 3, 16, 2500021, 10, 10) -- Angered Reindeer
		mobSpawns.respawn(mob, 30024, 1, 37, 3, 16, 2500022, 10, 10) -- Violent Panda
		mobSpawns.respawn(mob, 30024, 1, 37, 3, 16, 2500023, 10, 10) -- Crazed Skeleton
		mobSpawns.respawn(mob, 30024, 1, 37, 3, 16, 2500024, 10, 10) -- Murderous Skeleton
	elseif m == 30029 then -- Room 9 - Frosty The Snowman --BOSS ROM--
		mobSpawns.respawn(mob, 30029, 2, 27, 3, 26, 2500021, 10, 10) -- Angered Reindeer
		mobSpawns.respawn(mob, 30029, 2, 27, 3, 26, 2500022, 10, 10) -- Violent Panda
		mobSpawns.respawn(mob, 30029, 2, 27, 3, 26, 2500023, 10, 10) -- Crazed Skeleton
		mobSpawns.respawn(mob, 30029, 2, 27, 3, 26, 2500024, 10, 10) -- Murderous Skeleton
	elseif m == 30034 then -- Room 4 - Jingle Bell Rock --BOSS ROOM-
		mobSpawns.respawn(mob, 30034, 1, 37, 3, 16, 2500031, 10, 10) -- Prime Reindeer
		mobSpawns.respawn(mob, 30034, 1, 37, 3, 16, 2500032, 10, 10) -- Happy Panda
		mobSpawns.respawn(mob, 30034, 1, 37, 3, 16, 2500033, 10, 10) -- Lefty Skeleton
		mobSpawns.respawn(mob, 30034, 1, 37, 3, 16, 2500034, 10, 10) -- Mangy Skeleton
	elseif m == 30039 then -- Room 9 - Frosty The Snowman --BOSS ROM--
		mobSpawns.respawn(mob, 30039, 2, 27, 3, 26, 2500031, 10, 10) -- Prime Reindeer
		mobSpawns.respawn(mob, 30039, 2, 27, 3, 26, 2500032, 10, 10) -- Happy Panda
		mobSpawns.respawn(mob, 30039, 2, 27, 3, 26, 2500033, 10, 10) -- Lefty Skeleton
		mobSpawns.respawn(mob, 30039, 2, 27, 3, 26, 2500034, 10, 10) -- Mangy Skeleton
	elseif m == 30044 then -- Room 4 - Jingle Bell Rock --BOSS ROOM--
		mobSpawns.respawn(mob, 30044, 1, 37, 3, 16, 2500041, 5, 10) -- Ultra Reindeer
		mobSpawns.respawn(mob, 30044, 1, 37, 3, 16, 2500042, 5, 10) -- Amazing Panda
		mobSpawns.respawn(mob, 30044, 1, 37, 3, 16, 2500043, 5, 10) -- Prophesized Skeleton
		mobSpawns.respawn(mob, 30044, 1, 37, 3, 16, 2500044, 5, 10) -- Chosen Skeleton
	elseif m == 30049 then -- Room 9 - Frosty The Snowman --BOSS ROM--
		mobSpawns.respawn(mob, 30049, 2, 27, 3, 26, 2500041, 5, 10) -- Ultra Reindeer
		mobSpawns.respawn(mob, 30049, 2, 27, 3, 26, 2500042, 5, 10) -- Amazing Panda
		mobSpawns.respawn(mob, 30049, 2, 27, 3, 26, 2500043, 5, 10) -- Prophesized Skeleton
		mobSpawns.respawn(mob, 30049, 2, 27, 3, 26, 2500044, 5, 10) -- Chosen Skeleton
	end
end
