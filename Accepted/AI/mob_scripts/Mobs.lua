--[[
Need to add resistcheck to:

Fighter
Brutal Throw (stun effect) x
Intimidate x
Knockback Strike (stun effect) x
Pommel Strike (stun effect) x
Shield Rush (stun effect) x

Scoundrel
Assassinate (stun effect) x
Poisoned Shuriken (stun effect) x
Tranq Dart (Stun effect) x

Wizard
Burning Hands (sear effect) x
Cone of Cold (stun/slow effects) x
Fear x
Fireball (sear effect) x
flame shield (sear effect) x
flare (sear effect) x
hailstorm (stun/slow effects) x
ice armor(stun effect)  x
petrify x
snowstorm (slow effect) x
static x
rain of the nether (all effects) x

Priest

Hold People
Lunging Club Strike (stun effect)
Searing Light (seared effect)
Smite Evil (stun effect)



]] --

spawnRandomly = function(mob)
	local x = math.random(1, mob.xmax)
	local y = math.random(1, mob.ymax)
	local map = mob.m

	local mobs = core:getObjectsInCell(map, x, y, BL_MOB)
	local pc = core:getObjectsInCell(map, x, y, BL_PC)
	local npc = core:getObjectsInCell(map, x, y, BL_NPC)
	--mob:talk(0,"1")
	if getPass(map, x, y) == 0 then
		if not getWarp(map, x, y) then
			if getObject(map, x, y) == 0 then
				if #npc == 0 then
					if #mobs == 0 then
						if #pc == 0 then
							mob:warp(map, x, y)
						end
					end
				end
			end
		end
	end
end

spawnChestRandomly = function(mob)
	local x = math.random(1, mob.xmax)
	local y = math.random(1, mob.ymax)
	local map = mob.m

	local mobs = core:getObjectsInCell(map, x, y, BL_MOB)
	local pc = core:getObjectsInCell(map, x, y, BL_PC)
	local npc = core:getObjectsInCell(map, x, y, BL_NPC)

	mob.look = 433
	mob:updateState()

	--mob:talk(0,"1")
	if getPass(map, x, y) == 0 then
		if not getWarp(map, x, y) then
			if getObject(map, x, y) == 0 then
				if #npc == 0 then
					if #mobs == 0 then
						if #pc == 0 then
							mob:warp(map, x, y)
							mob.look = 809
							mob:updateState()
						else
							return spawnChestRandomly(mob)
						end
					else
						return spawnChestRandomly(mob)
					end
				else
					return spawnChestRandomly(mob)
				end
			else
				return spawnChestRandomly(mob)
			end
		else
			return spawnChestRandomly(mob)
		end
	else
		return spawnChestRandomly(mob)
	end
end

--if checkResist(player, target, "stun") == 1 then return end

checkResist = function(player, mob, spellname)
	if mob.blType ~= BL_MOB then
		return
	end

	--all current effects: "slow", "stun", "petrify", "intimidate", "fear", "static", "seared", "hold_people", "shock", "lullaby"
	--Player(4):talk(0,"check resist: start")
	local resistLevel = mob.protection
	local will = mob.will

	local level1resist = {}
	local level1immune = {"stun", "static", "petrify", "fear", "intimidate", "hold_people"} --tough mob / gargoyle immunity

	local level2resist = {}
	local level2immune = {"intimidate"} --bloth immunity

	local level3resist = {}
	local level3immune = {"stun", "static", "petrify", "fear", "intimidate", "hold_people"} --standard boss immunity

	local level4resist = {}
	local level4immune = {
		"slow",
		"stun",
		"petrify",
		"hide_in_shadows",
		"intimidate",
		"fear",
		"static",
		"seared",
		"hold_people"
	} --high end boss immunity (ogre, medusa)

	local resistanim = 79
	local resistsound = 28
	local immuneanim = 66
	local immunesound = 25

	local resist = math.random(1, 100) - will

	--Player(4):talk(0,"check resist: end declares")

	if resistLevel > 0 then
		if resistLevel == 1 then
			for i = 1, #level1immune do
				if level1immune[i] == spellname then
					--Player(4):talk(0,"check IMMUNE MATCH!: "..level1immune[i].." == "..spellname)
					player:sendMinitext("Your spell fizzles.")
					mob:sendAnimation(immuneanim)
					mob:playSound(immunesound)
					return 1
				end
			end

			if resist <= 0 then
				--Player(4):talk(0,"check resist roll: "..resist..", will resist if match found")
				for i = 1, #level1resist do
					--Player(4):talk(0,"check resist list item: "..level1resist[i])
					--Player(4):talk(0,"check resist spellname: "..spellname)
					if level1resist[i] == spellname then
						--Player(4):talk(0,"check resist MATCH!: "..level1resist[i].." == "..spellname)
						player:sendMinitext("" .. mob.name .. " resists your spell!")
						mob:sendAnimation(resistanim)
						mob:playSound(resistsound)
						return 1
					end
				end
			else
				--Player(4):talk(0,"check resist roll: "..resist..", NO RESIST")
			end
		elseif resistLevel == 2 then
			for i = 1, #level2immune do
				if level2immune[i] == spellname then
					player:sendMinitext("Your spell fizzles.")
					mob:sendAnimation(immuneanim)
					mob:playSound(immunesound)
					return 1
				end
			end

			if resist <= 0 then
				for i = 1, #level2resist do
					if level2resist[i] == spellname then
						player:sendMinitext("" .. mob.name .. " resists your spell!")
						mob:sendAnimation(resistanim)
						mob:playSound(resistsound)
						return 1
					end
				end
			else
			end
		elseif resistLevel == 3 then
			for i = 1, #level3immune do
				if level3immune[i] == spellname then
					player:sendMinitext("Your spell fizzles.")
					mob:sendAnimation(immuneanim)
					mob:playSound(immunesound)
					return 1
				end
			end

			if resist <= 0 then
				for i = 1, #level3resist do
					if level3resist[i] == spellname then
						player:sendMinitext("" .. mob.name .. " resists your spell!")
						mob:sendAnimation(resistanim)
						mob:playSound(resistsound)
						return 1
					end
				end
			end
		elseif resistLevel == 4 then
			for i = 1, #level4immune do
				if level4immune[i] == spellname then
					player:sendMinitext("Your spell fizzles.")
					mob:sendAnimation(immuneanim)
					mob:playSound(immunesound)
					return 1
				end
			end

			if resist <= 0 then
				for i = 1, #level4resist do
					if level4resist[i] == spellname then
						player:sendMinitext("" .. mob.name .. " resists your spell!")
						mob:sendAnimation(resistanim)
						mob:playSound(resistsound)
						return 1
					end
				end
			end
		end
	end

	return 0
end

--Mob damage formulas
function Mob.addHealthExtend(mob, amount, sleep, deduction, ac, ds, print)
	local healer
	local ded = 0

	if (mob.state == 1) then
		return
	end

	if (mob.attacker >= 1073741823) then
		healer = Mob(mob.attacker)
	elseif (mob.attacker > 0) then
		healer = Player(mob.attacker)
	end

	ded = mob.armor / (mob.armor + 400 + 95 * (healer.level + healer.tier ^ 2 + healer.mark ^ 3))

	if (healer:hasDuration("blossom")) then
		amount = amount * 2
	end

	if (sleep > 0 and print == 2) then
		amount = amount * mob.sleep
	elseif (sleep == 1) then
		amount = amount * mob.sleep
		mob.sleep = 1
	elseif (sleep == 2) then
		amount = amount * mob.sleep
	end

	if (deduction == 1) then
		if (mob.deduction < 0) then
			amount = 0
		elseif (mob.deduction > 0) then
			amount = amount * mob.deduction
		end
	end

	if (ac == 1) then
		if (ded < .85) then
			amount = amount * (1 - ded)
		else
			amount = amount * .15
		end
	end

	if (ds > 0 and print == 2) then
		amount = amount - mob.dmgShield
	elseif (ds == 1) then
		if (mob.dmgShield > 0) then
			if (mob.dmgShield > amount) then
				mob.dmgShield = mob.dmgShield - amount
				amount = 0
			else
				amount = amount - mob.dmgShield
				mob.dmgShield = 0
			end
		else
			amount = amount - mob.dmgShield
			mob.dmgShield = 0
		end
	elseif (ds == 2) then
		mob.dmgShield = mob.dmgShield - amount
	end

	amount = -amount

	if (healer ~= nil) then
		healer.damage = amount
		healer.critChance = 0
	else
		mob.damage = amount
		mob.critChance = 0
	end

	if (print == 1) then
		if (mob.health - amount > mob.maxHealth) then
			mob.health = mob.maxHealth
		else
			mob.health = mob.health - amount
		end
	elseif (print == 2) then
		return amount
	else
		if (mob.aiType == 0) then
			mob_ai_basic.on_healed(mob, healer)
		elseif (mob.aiType == 1) then
			mob_ai_normal.on_healed(mob, healer)
		elseif (mob.aiType == 2) then
			mob_ai_hard.on_healed(mob, healer)
		elseif (mob.aiType == 3) then
			mob_ai_boss.on_healed(mob, healer)
		elseif (mob.aiType == 4) then
			mob:callBase("on_healed")
		elseif (mob.aiType == 5) then
			mob_ai_ghost.on_healed(mob, healer)
		end
	end
end

function Mob.removeHealthWithoutDamageNumbers(mob, amount, type)
	local temp_health = 0

	temp_health = mob.health - amount

	if temp_health <= 0 then
		temp_health = 0
	end

	mob.health = temp_health

	if (mob.attacker >= 1073741823) then
		Mob(mob.attacker).damage = amount
		Mob(mob.attacker).critChance = type
	elseif (mob.attacker > 0) then
		Player(mob.attacker).damage = amount
		Player(mob.attacker).critChance = type
	else
		mob.damage = amount
		mob.critChance = type
	end

	if (mob.health == 0) then
		mob:removeHealth(0)
	--mob.state = 1
	--mob:sendAction(5, 0)
	--onDeathMob(mob)
	end
end

function Mob.removeHealthExtend(mob, amount, sleep, deduction, ac, ds, print)
	local attacker
	local ded = 0

	--	if mob.owner > 0 then return end

	if (mob.attacker >= 1073741823) then
		attacker = Mob(mob.attacker)
	elseif (mob.attacker > 0) then
		attacker = Player(mob.attacker)
	end

	ded = 1 - ((mob.armor * acPerArmor) / 100)

	if (sleep > 0 and print == 2) then
		amount = amount * mob.sleep
	elseif (sleep == 1) then
		amount = amount * mob.sleep
		mob.sleep = 1
	elseif (sleep == 2) then
		amount = amount * mob.sleep
	end

	if (deduction == 1) then
		if (mob.deduction < 0) then
			amount = 0
		elseif (mob.deduction > 0) then
			amount = amount * mob.deduction
		end
	end

	if (ac == 1) then
		if (ded > .15) then
			amount = amount * ded
		else
			amount = amount * .15
		end
	end

	if (ds > 0 and print == 2) then
		amount = amount - mob.dmgShield
	elseif (ds == 1) then
		if (mob.dmgShield > 0) then
			if (mob.dmgShield > amount) then
				mob.dmgShield = mob.dmgShield - amount
				amount = 0
			else
				amount = amount - mob.dmgShield
				mob.dmgShield = 0
			end
		else
			amount = amount - mob.dmgShield
			mob.dmgShield = 0
		end
	elseif (ds == 2) then
		mob.dmgShield = mob.dmgShield - amount
	end

	if mob:hasDuration("called_shot") then
		amount = amount * 2
	--	mob:setDuration("called_shot", 0)
	end

	if (attacker ~= nil) then
		attacker.damage = amount
		attacker.critChance = 0
	else
		mob.damage = amount
		mob.critChance = 0
	end

	if attacker.blType == BL_PC then
		if mob.owner > 0 then
			if attacker.ID ~= mob.owner then
				return
			end
		end
	end

	if (print == 1) then
		return mob:removeHealth(amount)
	elseif (print == 2) then
		return amount
	else
		if (mob.aiType == 0) then
			mob_ai_basic.on_attacked(mob, attacker)
		elseif (mob.aiType == 1) then
			mob_ai_normal.on_attacked(mob, attacker)
		elseif (mob.aiType == 2) then
			mob_ai_hard.on_attacked(mob, attacker)
		elseif (mob.aiType == 3) then
			mob_ai_boss.on_attacked(mob, attacker)
		elseif (mob.aiType == 4) then
			mob:callBase("on_attacked")
		elseif (mob.aiType == 5) then
			mob_ai_ghost.on_attacked(mob, attacker)
		end
	end
end

--Mob adjustments
function Mob.changeMove(mob, amount)
	if (mob.newMove + amount < 1) then
		return false
	else
		mob.newMove = mob.newMove + amount
		return true
	end
end

function Mob.changeAttack(mob, amount)
	if (mob.newAttack + amount < 1) then
		return false
	else
		mob.newAttack = mob.newAttack + amount
		return true
	end
end

--Mob actions
function Mob.attackIT(mob, block, max_dam, min_dam)
	local dam_calc = 0
	local hit_miss = 0
	local hit = 0
	local min_dam2 = 0
	local max_dam2 = 0
	min_dam2 = min_dam2 + min_dam
	max_dam2 = max_dam2 + max_dam
	mob:playSound(mob.sound)
	 --
	--[[if(player.blType==BL_MOB) then
			player:talk(0,"Omfg!")
			player.attacker=mob.ID
			player:removeHealth(10)
			return
	end]] if
		(block ~= nil)
	 then
		mob.target = block.ID
		 --
		--[[local ac=block.ac
		dam_calc=math.random(min_dam2,max_dam2)
		hit_miss=(55+(mob.grace))-(block.grace*0.5)+(mob.hit)+(mob.level)-(block.level/2)
		if(hit_miss<5) then hit_miss=5 end
		if(hit_miss>95) then hit_miss=95 end
		
		local chance=math.random(0,100)
		if(chance<hit_miss) then
			local crit=(mob.hit*0.2)
			if(chance<crit) then
				hit=2
				block:playSound(349)
				block:playSound(351)
			else
				hit=1
			end
		end

		dam_calc=dam_calc*CalculateIncrease(mob,block,hit)
		--dam_calc=dam_calc+dam_calc*block.ac*0.01
		mob:sendAction(1,14)
		]] mob.critChance =
			hitCritChance(mob, block)

		if (mob.critChance > 0) then
			mob.damage = swingDamage(mob, block)
			block.attacker = mob.ID
			--dam_calc=math.floor(dam_calc+0.5)
			--if(dam_calc>0) then
			if (block.blType == BL_PC) then
				block:deductArmor()
				block:showHealth(mob.damage, mob.critChance)
			end
			--player:sendMinitext("They hit you for " .. dam_calc.. "")

			if (block.blType == BL_MOB) then
				block.attacker = mob.ID
				block:removeHealth(mob.damage, mob.critChance)
			end
		--mob:broadcast(block.m,""..dam_calc.."")
		--end
		end
	end
end

function Mob.attackNoCrit(mob, block, max_dam, min_dam)
	local dam_calc = 0
	local hit_miss = 0
	local hit = 0
	local min_dam2 = 0
	local max_dam2 = 0
	min_dam2 = min_dam2 + min_dam
	max_dam2 = max_dam2 + max_dam
	mob:playSound(mob.sound)
	 --
	--[[if(block.blType==BL_MOB) then
			block:talk(0,"Omfg!")
			block.attacker=mob.ID
			block:removeHealth(10)
			return
	end]] if
		(block ~= nil)
	 then
		mob.target = block.ID
		local ac = block.ac
		dam_calc = math.random(min_dam2, max_dam2)
		hit_miss = (55 + (mob.grace)) - (block.grace * 0.5) + (mob.hit) + (mob.level) - (block.level / 2)
		if (hit_miss < 5) then
			hit_miss = 5
		end
		if (hit_miss > 95) then
			hit_miss = 95
		end

		local chance = math.random(0, 100)
		if (chance < hit_miss) then
			local crit = (mob.hit * 0.2)
			if (chance < crit) then
				hit = 1
				block:playSound(349)
				block:playSound(351)
			else
				hit = 1
			end
		end

		dam_calc = dam_calc * CalculateIncrease(mob, block, 0)
		--dam_calc=dam_calc+dam_calc*block.ac*0.01
		mob:sendAction(1, 14)
		mob.critChance = hit
		mob.damage = dam_calc

		if (hit > 0) then
			dam_calc = math.floor(dam_calc + 0.5)
			if (dam_calc > 0) then
				if (block.blType == BL_PC) then
					block:deductArmor()
				end
				--block:sendMinitext("They hit you for " .. dam_calc.. "")
				block.attacker = mob.ID
				block:removeHealthExtend(dam_calc, 1, 1, 1, 1, 0)
			--mob:broadcast(block.m,""..dam_calc.."")
			end
		end
	end
end

function CalculateIncrease(mob, player, hit)
	local news = math.abs(mob.side - player.side)
	local total = 1.5
	if (mob.side == player.side) then
		total = 3
	elseif (news == 2) then
		total = 1
	end

	if (hit == 2) then
		total = total * 3
	end
	return total
end

function Mob.adjustSide(mob, player)
	local dx = mob.x - player.x
	local dy = mob.y - player.y

	if (dx == -1) then
		if (mob.side ~= 1) then
			mob.side = 1
			mob:sendSide()
		end
	elseif (dx == 1) then
		if (mob.side ~= 3) then
			mob.side = 3
			mob:sendSide()
		end
	elseif (dy == -1) then
		if (mob.side ~= 2) then
			mob.side = 2
			mob:sendSide()
		end
	elseif (dy == 1) then
		if (mob.side ~= 0) then
			mob.side = 0
			mob:sendSide()
		end
	end
end

function FindCoords(mob, player)
	local i
	local found = false
	local oldside = mob.side
	local canmove = false
	local checkmove = math.random(0, 2)

	if (mob:moveIntent(player.ID) == 0) then
		if (checkmove >= 1) then
			if (mob.y < player.y) then
				mob.side = 2
				mob:sendSide()
				canmove = mob:move()
			end
			if (mob.y > player.y and not canmove) then
				mob.side = 0
				mob:sendSide()
				canmove = mob:move()
			end
			if (mob.x < player.x and not canmove) then
				mob.side = 1
				mob:sendSide()
				canmove = mob:move()
			end
			if (mob.x > player.x and not canmove) then
				mob.side = 3
				mob:sendSide()
				canmove = mob:move()
			end
		else
			if (mob.x < player.x) then
				mob.side = 1
				mob:sendSide()
				canmove = mob:move()
			end
			if (mob.x > player.x and not canmove) then
				mob.side = 3
				mob:sendSide()
				canmove = mob:move()
			end
			if (mob.y < player.y and not canmove) then
				mob.side = 2
				mob:sendSide()
				canmove = mob:move()
			end
			if (mob.y > player.y and not canmove) then
				mob.side = 0
				mob:sendSide()
				canmove = mob:move()
			end
		end
	--Ok, so it's next to one of em, I THINK..let's check
	--if(dx==1 and dy==0) then return true end
	--if(dx==0 and dy==1) then return true end
	end

	if (mob:moveIntent(player.ID) == 1) then
		return true
	elseif (not canmove) then
		local tList = mob:getObjectsInArea(BL_PC)
		local new_T
		local loopControl = 0

		repeat
			new_T = math.random(#tList)
			loopControl = loopControl + 1
		until (tList[new_T].gmLevel == 0 or loopControl == 20)

		mob.target = tList[new_T].ID
		mob.side = oldside
		mob:sendSide()

		for i = 0, 10 do
			if (not found) then
				mob.side = math.random(0, 3)
				mob:sendSide()
				found = mob:move()
			end
		end
	end
	 --
	--mob.target=tList[new_T].ID
	--mob:talk(0,"New Target is " .. tList[new_T].ID)
	--[[elseif(num==0) then
		local tList=mob:getObjectsInArea(BL_PC);
		
		local new_T=math.random(1,#tList);
		mob.target=tList[new_T].ID
		--mob:talk(0,"New Target is " .. tList[new_T].ID)
		for i=0,10 do
			if(found~=true) then
				mob.side=math.random(0,3)
				mob:sendSide()
				if(mob.side == oldside) then
					found=mob:move()
				end
			end
		end]] return false
end

function RunAway(mob, player)
	local i
	local found = false
	local oldside = mob.side
	local canmove = false
	local checkmove = math.random(0, 2)

	if (mob:moveIntent(player.ID) == 1) then
		if (mob.side <= 1) then
			mob.side = mob.side + 2
			mob:sendSide()
			canmove = mob:move()
		elseif (mob.side >= 2) then
			mob.side = mob.side - 2
			mob:sendSide()
			canmove = mob:move()
		end
	else
		if (checkmove >= 1) then
			if (mob.y < player.y) then
				mob.side = 0
				mob:sendSide()
				canmove = mob:move()
			end
			if (mob.y > player.y and not canmove) then
				mob.side = 2
				mob:sendSide()
				canmove = mob:move()
			end
			if (mob.x < player.x and not canmove) then
				mob.side = 3
				mob:sendSide()
				canmove = mob:move()
			end
			if (mob.x > player.x and not canmove) then
				mob.side = 1
				mob:sendSide()
				canmove = mob:move()
			end
		else
			if (mob.x < player.x) then
				mob.side = 3
				mob:sendSide()
				canmove = mob:move()
			end
			if (mob.x > player.x and not canmove) then
				mob.side = 1
				mob:sendSide()
				canmove = mob:move()
			end
			if (mob.y < player.y and not canmove) then
				mob.side = 0
				mob:sendSide()
				canmove = mob:move()
			end
			if (mob.y > player.y and not canmove) then
				mob.side = 2
				mob:sendSide()
				canmove = mob:move()
			end
		end
	end

	if (not canmove) then
		local tList = mob:getObjectsInArea(BL_PC)
		local new_T
		local loopControl = 0

		repeat
			new_T = math.random(#tList)
			loopControl = loopControl + 1
		until (tList[new_T].gmLevel == 0 or loopControl == 20)

		mob.target = tList[new_T].ID
		mob.side = oldside
		mob:sendSide()

		for i = 1, 10 do
			if (found == 0) then
				mob.side = math.random(0, 3)
				mob:sendSide()
				found = mob:move()
			end
		end

		return found
	else
		return canmove
	end
end

function FindCoordsGhost(mob, player)
	local i
	local found = false
	local oldside = mob.side
	local canmove = false
	local checkmove = math.random(0, 2)

	if (mob:moveIntent(player.ID) == 0) then
		if (checkmove >= 1) then
			if (mob.y < player.y) then
				mob.side = 2
				mob:sendSide()
				canmove = mob:moveGhost()
			end
			if (mob.y > player.y and canmove == 0) then
				mob.side = 0
				mob:sendSide()
				canmove = mob:moveGhost()
			end
			if (mob.x < player.x and canmove == 0) then
				mob.side = 1
				mob:sendSide()
				canmove = mob:moveGhost()
			end
			if (mob.x > player.x and canmove == 0) then
				mob.side = 3
				mob:sendSide()
				canmove = mob:moveGhost()
			end
		else
			if (mob.x < player.x) then
				mob.side = 1
				mob:sendSide()
				canmove = mob:moveGhost()
			end
			if (mob.x > player.x and canmove == 0) then
				mob.side = 3
				mob:sendSide()
				canmove = mob:moveGhost()
			end
			if (mob.y < player.y and canmove == 0) then
				mob.side = 2
				mob:sendSide()
				canmove = mob:moveGhost()
			end
			if (mob.y > player.y and canmove == 0) then
				mob.side = 0
				mob:sendSide()
				canmove = mob:moveGhost()
			end
		end
	end

	if (mob:moveIntent(player.ID) == 1) then
		return true
	elseif (not canmove) then
		local tList = mob:getObjectsInArea(BL_PC)
		local new_T = math.random(1, #tList)

		if (mob.owner > 1073741823) then
			mob.target = tList[new_T].ID
		end

		mob.side = oldside
		mob:sendSide()

		for i = 0, 10 do
			if (not found) then
				mob.side = math.random(0, 3)
				mob:sendSide()
				found = mob:moveGhost()
			end
		end
	end

	return false
end

function RunAwayGhost(mob, player)
	local i
	local found = false
	local oldside = mob.side
	local canmove = false
	local checkmove = math.random(0, 2)

	if (mob:moveIntent(player.ID) == 1) then
		if (mob.side <= 1) then
			mob.side = mob.side + 2
			mob:sendSide()
			mob:moveGhost()
		elseif (mob.side >= 2) then
			mob.side = mob.side - 2
			mob:sendSide()
			mob:moveGhost()
		end
	else
		if (checkmove >= 1) then
			if (mob.y < player.y) then
				mob.side = 0
				mob:sendSide()
				canmove = mob:moveGhost()
			end
			if (mob.y > player.y and canmove == 0) then
				mob.side = 2
				mob:sendSide()
				canmove = mob:moveGhost()
			end
			if (mob.x < player.x and canmove == 0) then
				mob.side = 3
				mob:sendSide()
				canmove = mob:moveGhost()
			end
			if (mob.x > player.x and canmove == 0) then
				mob.side = 1
				mob:sendSide()
				canmove = mob:moveGhost()
			end
		else
			if (mob.x < player.x) then
				mob.side = 3
				mob:sendSide()
				canmove = mob:moveGhost()
			end
			if (mob.x > player.x and canmove == 0) then
				mob.side = 1
				mob:sendSide()
				canmove = mob:moveGhost()
			end
			if (mob.y < player.y and canmove == 0) then
				mob.side = 0
				mob:sendSide()
				canmove = mob:moveGhost()
			end
			if (mob.y > player.y and canmove == 0) then
				mob.side = 2
				mob:sendSide()
				canmove = mob:moveGhost()
			end
		end
	end

	if (not canmove) then
		local tList = mob:getObjectsInArea(BL_PC)
		local new_T = math.random(1, #tList)

		mob.target = tList[new_T].ID
		mob.side = oldside
		mob:sendSide()

		for i = 0, 10 do
			if (not found) then
				mob.side = math.random(0, 3)
				mob:sendSide()
				found = mob:moveGhost()
			end
		end
	end
end

function Mob.flank(mob)
	local pcBlocks = getTargetsAround(mob, BL_PC)
	local mobBlocks = getTargetsAround(mob, BL_MOB)
	local targets = {}
	local swing = true

	if (#pcBlocks > 0) then
		for i = 1, #pcBlocks do
			if ((mob.side == 0 or mob.side == 2) and pcBlocks[i].y == mob.y) then
				table.insert(targets, pcBlocks[i])
			elseif ((mob.side == 1 or mob.side == 3) and pcBlocks[i].x == mob.x) then
				table.insert(targets, pcBlocks[i])
			end
		end
	end

	if (#mobBlocks > 0) then
		for i = 1, #mobBlocks do
			if ((mob.side == 0 or mob.side == 2) and mobBlocks[i].y == mob.y) then
				table.insert(targets, mobBlocks[i])
			elseif ((mob.side == 1 or mob.side == 3) and mobBlocks[i].x == mob.x) then
				table.insert(targets, mobBlocks[i])
			end
		end
	end

	if (#targets > 0) then
		for i = 1, #targets do
			swing = true

			if (targets[i].blType == BL_MOB and (targets[i].owner == 0 or targets[i].owner >= 1073741823)) then
				swing = false
			end

			if (swing) then
				hitCritChance(mob, targets[i])

				if (mob.critChance > 0) then
					swingDamage(mob, targets[i])
					mob.damage = mob.damage * .75

					if (targets[i].blType == BL_PC) then
						player_combat.on_attacked(targets[i], mob)
					elseif (targets[i].blType == BL_MOB) then
						if (targets[i].aiType == 0) then
							mob_ai_basic.on_attacked(targets[i], mob)
						elseif (targets[i].aiType == 1) then
							mob_ai_normal.on_attacked(targets[i], mob)
						elseif (targets[i].aiType == 2) then
							mob_ai_hard.on_attacked(targets[i], mob)
						elseif (targets[i].aiType == 3) then
							mob_ai_boss.on_attacked(targets[i], mob)
						elseif (targets[i].aiType == 4) then
							targets[i]:callBase("on_attacked")
						elseif (targets[i].aiType == 5) then
							mob_ai_ghost.on_attacked(targets[i], mob)
						end
					end
				end
			end
		end
	end
end

function Mob.flankWithAlly(mob)
	local pcBlocks = getTargetsAround(mob, BL_PC)
	local mobBlocks = getTargetsAround(mob, BL_MOB)
	local targets = {}

	if (#pcBlocks > 0) then
		for i = 1, #pcBlocks do
			if ((mob.side == 0 or mob.side == 2) and pcBlocks[i].y == mob.y) then
				table.insert(targets, pcBlocks[i])
			elseif ((mob.side == 1 or mob.side == 3) and pcBlocks[i].x == mob.x) then
				table.insert(targets, pcBlocks[i])
			end
		end
	end

	if (#mobBlocks > 0) then
		for i = 1, #mobBlocks do
			if ((mob.side == 0 or mob.side == 2) and mobBlocks[i].y == mob.y) then
				table.insert(targets, mobBlocks[i])
			elseif ((mob.side == 1 or mob.side == 3) and mobBlocks[i].x == mob.x) then
				table.insert(targets, mobBlocks[i])
			end
		end
	end

	if (#targets > 0) then
		for i = 1, #targets do
			hitCritChance(mob, targets[i])

			if (mob.critChance > 0) then
				swingDamage(mob, targets[i])
				mob.damage = mob.damage * .75

				if (targets[i].blType == BL_PC) then
					player_combat.on_attacked(targets[i], mob)
				elseif (targets[i].blType == BL_MOB) then
					if (targets[i].aiType == 0) then
						mob_ai_basic.on_attacked(targets[i], mob)
					elseif (targets[i].aiType == 1) then
						mob_ai_normal.on_attacked(targets[i], mob)
					elseif (targets[i].aiType == 2) then
						mob_ai_hard.on_attacked(targets[i], mob)
					elseif (targets[i].aiType == 3) then
						mob_ai_boss.on_attacked(targets[i], mob)
					elseif (targets[i].aiType == 4) then
						targets[i]:callBase("on_attacked")
					elseif (targets[i].aiType == 5) then
						mob_ai_ghost.on_attacked(targets[i], mob)
					end
				end
			end
		end
	end
end

function Mob.backstab(mob)
	local pcBlocks = getTargetsAround(mob, BL_PC)
	local mobBlocks = getTargetsAround(mob, BL_MOB)
	local targets = {}
	local swing = true

	if (#pcBlocks > 0) then
		for i = 1, #pcBlocks do
			if (mob.side == 0 and pcBlocks[i].y > mob.y) then
				table.insert(targets, pcBlocks[i])
			elseif (mob.side == 1 and pcBlocks[i].x < mob.x) then
				table.insert(targets, pcBlocks[i])
			elseif (mob.side == 2 and pcBlocks[i].y < mob.y) then
				table.insert(targets, pcBlocks[i])
			elseif (mob.side == 3 and pcBlocks[i].x > mob.x) then
				table.insert(targets, pcBlocks[i])
			end
		end
	end

	if (#mobBlocks > 0) then
		for i = 1, #mobBlocks do
			if (mob.side == 0 and mobBlocks[i].y > mob.y) then
				table.insert(targets, mobBlocks[i])
			elseif (mob.side == 1 and mobBlocks[i].x < mob.x) then
				table.insert(targets, mobBlocks[i])
			elseif (mob.side == 2 and mobBlocks[i].y < mob.y) then
				table.insert(targets, mobBlocks[i])
			elseif (mob.side == 3 and mobBlocks[i].x > mob.x) then
				table.insert(targets, mobBlocks[i])
			end
		end
	end

	if (#targets > 0) then
		for i = 1, #targets do
			swing = true

			if (targets[i].blType == BL_MOB and (targets[i].owner == 0 or targets[i].owner >= 1073741823)) then
				swing = false
			end

			if (swing) then
				hitCritChance(mob, targets[i])

				if (mob.crit > 0) then
					swingDamage(mob, targets[i])
					mob.damage = mob.damage * .5

					if (targets[i].blType == BL_PC) then
						player_combat.on_attacked(targets[i], mob)
					elseif (targets[i].blType == BL_MOB) then
						if (targets[i].aiType == 0) then
							mob_ai_basic.on_attacked(targets[i], mob)
						elseif (targets[i].aiType == 1) then
							mob_ai_normal.on_attacked(targets[i], mob)
						elseif (targets[i].aiType == 2) then
							mob_ai_hard.on_attacked(targets[i], mob)
						elseif (targets[i].aiType == 3) then
							mob_ai_boss.on_attacked(targets[i], mob)
						elseif (targets[i].aiType == 4) then
							targets[i]:callBase("on_attacked")
						elseif (targets[i].aiType == 5) then
							mob_ai_ghost.on_attacked(targets[i], mob)
						end
					end
				end
			end
		end
	end
end

function Mob.backstabWithAlly(mob)
	local pcBlocks = getTargetsAround(mob, BL_PC)
	local mobBlocks = getTargetsAround(mob, BL_MOB)
	local targets = {}

	if (#pcBlocks > 0) then
		for i = 1, #pcBlocks do
			if (mob.side == 0 and pcBlocks[i].y > mob.y) then
				table.insert(targets, pcBlocks[i])
			elseif (mob.side == 1 and pcBlocks[i].x < mob.x) then
				table.insert(targets, pcBlocks[i])
			elseif (mob.side == 2 and pcBlocks[i].y < mob.y) then
				table.insert(targets, pcBlocks[i])
			elseif (mob.side == 3 and pcBlocks[i].x > mob.x) then
				table.insert(targets, pcBlocks[i])
			end
		end
	end

	if (#mobBlocks > 0) then
		for i = 1, #mobBlocks do
			if (mob.side == 0 and mobBlocks[i].y > mob.y) then
				table.insert(targets, mobBlocks[i])
			elseif (mob.side == 1 and mobBlocks[i].x < mob.x) then
				table.insert(targets, mobBlocks[i])
			elseif (mob.side == 2 and mobBlocks[i].y < mob.y) then
				table.insert(targets, mobBlocks[i])
			elseif (mob.side == 3 and mobBlocks[i].x > mob.x) then
				table.insert(targets, mobBlocks[i])
			end
		end
	end

	if (#targets > 0) then
		for i = 1, #targets do
			hitCritChance(mob, targets[i])

			if (mob.crit > 0) then
				swingDamage(mob, targets[i])
				mob.damage = mob.damage * .5

				if (targets[i].blType == BL_PC) then
					player_combat.on_attacked(targets[i], mob)
				elseif (targets[i].blType == BL_MOB) then
					if (targets[i].aiType == 0) then
						mob_ai_basic.on_attacked(targets[i], mob)
					elseif (targets[i].aiType == 1) then
						mob_ai_normal.on_attacked(targets[i], mob)
					elseif (targets[i].aiType == 2) then
						mob_ai_hard.on_attacked(targets[i], mob)
					elseif (targets[i].aiType == 3) then
						mob_ai_boss.on_attacked(targets[i], mob)
					elseif (targets[i].aiType == 4) then
						targets[i]:callBase("on_attacked")
					elseif (targets[i].aiType == 5) then
						mob_ai_ghost.on_attacked(targets[i], mob)
					end
				end
			end
		end
	end
end

function Mob.checkToObject(mob, object)
	local canmove = false
	local found = false
	local checkmove = math.random(0, 2)

	if (checkmove >= 1) then
		if (mob.y < object.y) then
			mob.side = 2
			mob:sendSide()
			canmove = mob:checkMove()
		end
		if (mob.y > object.y and canmove == false) then
			mob.side = 0
			mob:sendSide()
			canmove = mob:checkMove()
		end
		if (mob.x < object.x and canmove == false) then
			mob.side = 1
			mob:sendSide()
			canmove = mob:checkMove()
		end
		if (mob.x > object.x and canmove == false) then
			mob.side = 3
			mob:sendSide()
			canmove = mob:checkMove()
		end
	else
		if (mob.x < object.x) then
			mob.side = 1
			mob:sendSide()
			canmove = mob:checkMove()
		end
		if (mob.x > object.x and canmove == false) then
			mob.side = 3
			mob:sendSide()
			canmove = mob:checkMove()
		end
		if (mob.y < object.y and canmove == false) then
			mob.side = 2
			mob:sendSide()
			canmove = mob:checkMove()
		end
		if (mob.y > object.y and canmove == false) then
			mob.side = 0
			mob:sendSide()
			canmove = mob:checkMove()
		end
	end

	if (canmove == false) then
		for i = 0, 10 do
			if (found == false) then
				mob.side = math.random(0, 3)
				mob:sendSide()
				found = mob:checkMove()
			end
		end

		return found
	else
		return canmove
	end
end

roomExpTotalIx = function(player, interval)
	local mapBlocks = player:getObjectsInMap(player.m, BL_MOB)
	local maxPotential = 0
	local expectedPotential = 0
	local totalExp = 0
	local averageSpawntime = 0
	local lastMobCount = 0
	local onceOffExp = player.exp

	player:talk(1, "<|>o========= Room #" .. player.m .. "=====" .. interval .. " minutes =================o")
	--now recalculate
	if (#mapBlocks > 0) then
		for i = 1, #mapBlocks do
			if (mapBlocks[i].experience > 0) then
				maxPotential = maxPotential + mapBlocks[i].experience * (60 / mapBlocks[i].spawnTime) * interval
				totalExp = totalExp + mapBlocks[i].experience
				lastMobCount = lastMobCount + 1
				averageSpawntime = averageSpawntime + mapBlocks[i].spawnTime
			end
		end
	end

	--player:talk(1, "<|>      --- First wave ---")
	--player:talk(1, "<|> Max experience     : "..format_number(math.floor(maxPotential)))
	--player:talk(1, "<|> Expected experience: "..format_number(math.floor((maxPotential*0.65))))
	if (lastMobCount ~= 0) then
		averageSpawntime = averageSpawntime / lastMobCount
	else
		player:talk(1, "No mobs giving experience.")
		return
	end

	killmobs.cast(player)
	--room_hellfire.cast(player,player)

	local mapBlocks = player:getObjectsInMap(player.m, BL_MOB)

	if (#mapBlocks > 0) then
		for i = 1, #mapBlocks do
			if (mapBlocks[i].experience > 0) then
				maxPotential = maxPotential + mapBlocks[i].experience * (60 / averageSpawntime) * interval
				totalExp = totalExp + mapBlocks[i].experience
				lastMobCount = lastMobCount + 1
			end
		end
	end

	killmobs.cast(player)
	--room_hellfire.cast(player,player)

	onceOffExp = player.exp - onceOffExp

	expectedPotential = maxPotential * .65
	player:talk(1, "<|> # Mob count        : " .. (lastMobCount))
	player:talk(1, "<|> Average Exp per mob: " .. format_number(math.floor(totalExp / lastMobCount)))
	player:talk(1, "<|> Average Spawn times: " .. format_number(math.floor(10 * averageSpawntime) / 10) .. "seconds")
	player:talk(1, "<|> Room clear         : " .. format_number(math.floor(onceOffExp)))
	player:talk(1, "<|> Max experience     : " .. format_number(math.floor(maxPotential)))
	player:talk(1, "<|> Expected experience: " .. format_number(math.floor((expectedPotential))))
	--player:talk(0, "Room: "..room.." Max: "..maxPotential.." Expected: "..expectedPotential)
end

function Mob.vanish(mob)
	local pc = mob:getObjectsInArea(BL_PC)

	mob.look = 433
	for i = 1, #pc do
		pc[i]:refresh()
	end
	mob:delete()
end

function Mob.vanish2(mob)
	local pc = mob:getObjectsInArea(BL_PC)

	mob.look = 433
	for i = 1, #pc do
		pc[i]:refresh()
	end
	mob:removeHealthWithoutDamageNumbers(mob.maxHealth)
end

function Mob.sendFrontAnimation(mob, anim)
	local side = mob.side

	if side == 0 then
		mob:sendAnimationXY(anim, mob.x, mob.y - 1)
	elseif side == 1 then
		mob:sendAnimationXY(anim, mob.x + 1, mob.y)
	elseif side == 2 then
		mob:sendAnimationXY(anim, mob.x, mob.y + 1)
	elseif side == 3 then
		mob:sendAnimationXY(anim, mob.x - 1, mob.y)
	end
end

getMobName = function(mobID)
	local mobName = ""

	if mobID == 1001 then
		mobName = "Sewer Rat"
	end
	if mobID == 1002 then
		mobName = "Large Sewer Rat"
	end
	if mobID == 1003 then
		mobName = "Mutated Sewer Rat"
	end
	if mobID == 1004 then
		mobName = "Sewer Slug"
	end
	if mobID == 1005 then
		mobName = "Mutated Sewer Slug"
	end

	if mobID == 1011 then
		mobName = "Worm"
	end
	if mobID == 1012 then
		mobName = "Fire worm"
	end
	if mobID == 1013 then
		mobName = "Earth snake"
	end
	if mobID == 1014 then
		mobName = "Mud snake"
	end
	if mobID == 1015 then
		mobName = "Bandit Initiate"
	end
	if mobID == 1016 then
		mobName = "Bandit Veteran"
	end
	if mobID == 1017 then
		mobName = "Bandit Elite"
	end
	if mobID == 1018 then
		mobName = "War Thog Jr"
	end

	if mobID == 1031 then
		mobName = "Girl spirit"
	end
	if mobID == 1032 then
		mobName = "Boy spirit"
	end
	if mobID == 1033 then
		mobName = "Faceless spirit"
	end
	if mobID == 1034 then
		mobName = "Mentok"
	end

	if mobID == 1041 then
		mobName = "Smirking Bat"
	end
	if mobID == 1042 then
		mobName = "Overconfident Bat"
	end
	if mobID == 1043 then
		mobName = "Deceitfully Cute bat"
	end

	if mobID == 1051 then
		mobName = "Mutated Minnow"
	end
	if mobID == 1052 then
		mobName = "Mutated Bass"
	end
	if mobID == 1053 then
		mobName = "Mutated Goldfish"
	end

	if mobID == 2001 then
		mobName = "Tomb Robber"
	end
	if mobID == 2002 then
		mobName = "Scumbag Thief"
	end

	if mobID == 2011 then
		mobName = "Young Spider"
	end
	if mobID == 2012 then
		mobName = "Lurking Spider"
	end
	if mobID == 2013 then
		mobName = "Guardian Spider"
	end
	if mobID == 2014 then
		mobName = "Spider Queen"
	end

	if mobID == 1061 then
		mobName = "Red Spotted Leech"
	end
	if mobID == 1062 then
		mobName = "Green Striped Leech"
	end
	if mobID == 1063 then
		mobName = "Violent Leech"
	end
	if mobID == 1064 then
		mobName = "Venemous Leech"
	end
	if mobID == 1065 then
		mobName = "Leech Lord"
	end

	if mobID == 2031 then
		mobName = "Shipwreck Crate"
	end
	if mobID == 2032 then
		mobName = "Crazed Lobster"
	end
	if mobID == 2033 then
		mobName = "Man o'War"
	end
	if mobID == 2034 then
		mobName = "Possessed Snail"
	end

	if mobID == 2041 then
		mobName = "Green Snake"
	end
	if mobID == 2042 then
		mobName = "Swarm of Insects"
	end
	if mobID == 2043 then
		mobName = "Tree Frog"
	end
	if mobID == 2044 then
		mobName = "Swamp Gator"
	end

	if mobID == 2051 then
		mobName = "Giant Bug"
	end
	if mobID == 2052 then
		mobName = "Swamp Frog"
	end
	if mobID == 2053 then
		mobName = "Bog Frog"
	end
	if mobID == 2054 then
		mobName = "Disturbed Tree"
	end
	if mobID == 2055 then
		mobName = "Mud Golem"
	end

	if mobID == 2061 then
		mobName = "Swamp Slime"
	end
	if mobID == 2062 then
		mobName = "Blackstrike Swarm"
	end
	if mobID == 2063 then
		mobName = "Blackstrike Frog"
	end
	if mobID == 2064 then
		mobName = "Blackstrike Blue Frog"
	end
	if mobID == 2065 then
		mobName = "Blackstrike Gator"
	end

	if mobID == 2071 then
		mobName = "Mudman"
	end
	if mobID == 2072 then
		mobName = "Mega Mudman"
	end

	if mobID == 3001 then
		mobName = "Ogre Scout"
	end
	if mobID == 3002 then
		mobName = "Ogre Champion"
	end
	if mobID == 3003 then
		mobName = "Ogre Shaman"
	end

	if mobID == 3011 then
		mobName = "Young Gargoyle"
	end
	if mobID == 3012 then
		mobName = "Adult Gargoyle"
	end
	if mobID == 3013 then
		mobName = "Elder Gargoyle"
	end
	if mobID == 3014 then
		mobName = "Malvolia the Vicious"
	end
	if mobID == 3015 then
		mobName = "Andrea the Terrible"
	end

	if mobID == 2021 then
		mobName = "Brown Wolf"
	end
	if mobID == 2022 then
		mobName = "Red Wolf"
	end
	if mobID == 2023 then
		mobName = "Black Wolf"
	end
	if mobID == 2024 then
		mobName = "Dire Wolf"
	end

	if mobID == 1021 then
		mobName = "Black Fox"
	end
	if mobID == 1022 then
		mobName = "Red Fox"
	end
	if mobID == 1023 then
		mobName = "Rabid Fox"
	end
	if mobID == 1024 then
		mobName = "Rainbow Fox"
	end
	if mobID == 1025 then
		mobName = "Kumiho"
	end

	if mobID == 1301 then
		mobName = "Savage Spearmaiden"
	end
	if mobID == 1302 then
		mobName = "Savage Highwayman"
	end
	if mobID == 1303 then
		mobName = "Savage Stickman"
	end
	if mobID == 1304 then
		mobName = "Savage Warchief"
	end

	if mobID == 1071 then
		mobName = "Earth Worm"
	end
	if mobID == 1072 then
		mobName = "Blood Worm"
	end
	if mobID == 1073 then
		mobName = "Yellow-Bellied Snake"
	end
	if mobID == 1074 then
		mobName = "Blue Racer Snake"
	end
	if mobID == 1075 then
		mobName = "War Thog's Initiate"
	end
	if mobID == 1076 then
		mobName = "War Thog's Veteran"
	end
	if mobID == 1077 then
		mobName = "War Thog's Elite"
	end
	if mobID == 1078 then
		mobName = "War Thog Jr"
	end

	if mobID == 1111 then
		mobName = "Glow Worm"
	end
	if mobID == 1112 then
		mobName = "Lava Worm"
	end
	if mobID == 1113 then
		mobName = "Electric Snake"
	end
	if mobID == 1114 then
		mobName = "Coral Snake"
	end
	if mobID == 1115 then
		mobName = "War Thog's Soldier"
	end
	if mobID == 1116 then
		mobName = "War Thog's Infiltrator"
	end
	if mobID == 1117 then
		mobName = "War Thog's Major"
	end
	if mobID == 1118 then
		mobName = "War Thog Jr"
	end

	if mobID == 1081 then
		mobName = "Blue Fox"
	end
	if mobID == 1082 then
		mobName = "Purple Fox"
	end
	if mobID == 1083 then
		mobName = "White Fox"
	end
	if mobID == 1084 then
		mobName = "Painted Fox"
	end
	if mobID == 1085 then
		mobName = "Blue Kumiho"
	end

	if mobID == 1121 then
		mobName = "Swamp Fox"
	end
	if mobID == 1122 then
		mobName = "River Fox"
	end
	if mobID == 1123 then
		mobName = "Mountain Fox"
	end
	if mobID == 1124 then
		mobName = "Shadow Fox"
	end
	if mobID == 1125 then
		mobName = "Black Kumiho"
	end

	if mobID == 1091 then
		mobName = "Chilled Spirit"
	end
	if mobID == 1092 then
		mobName = "Pale Spirit"
	end
	if mobID == 1093 then
		mobName = "Wavering Spirit"
	end
	if mobID == 1094 then
		mobName = "Chilled Mentok"
	end

	if mobID == 1131 then
		mobName = "Frantic Spirit"
	end
	if mobID == 1132 then
		mobName = "Anxious Spirit"
	end
	if mobID == 1133 then
		mobName = "Tainted Spirit"
	end
	if mobID == 1134 then
		mobName = "Mentok the Mind Taker"
	end

	if mobID == 1101 then
		mobName = "Sea Bat"
	end
	if mobID == 1102 then
		mobName = "Cave Bat"
	end
	if mobID == 1103 then
		mobName = "Confident Bat"
	end

	if mobID == 1141 then
		mobName = "Grinning Bat"
	end
	if mobID == 1142 then
		mobName = "Luminescent Bat"
	end
	if mobID == 1143 then
		mobName = "Dragon Bat"
	end

	if mobID == 1151 then
		mobName = "Angry Caterpillar"
	end
	if mobID == 1152 then
		mobName = "Giant Spider"
	end
	if mobID == 1153 then
		mobName = "Chill Caterpillar"
	end
	if mobID == 1154 then
		mobName = "Lazy Tick"
	end
	if mobID == 1155 then
		mobName = "Weak Homunculus"
	end
	if mobID == 1156 then
		mobName = "Misanthropic Wizard"
	end
	if mobID == 1157 then
		mobName = "Evil Homunculus"
	end
	if mobID == 1158 then
		mobName = "Evil Wizard"
	end
	if mobID == 1159 then
		mobName = "Seer's Apprentice"
	end
	if mobID == 1160 then
		mobName = "Faceless Seer"
	end
	if mobID == 1161 then
		mobName = "Overseer's Student"
	end
	if mobID == 1162 then
		mobName = "High Overseer"
	end
	if mobID == 1163 then
		mobName = "Q"
	end
	if mobID == 1164 then
		mobName = "Dragoon"
	end
	if mobID == 1165 then
		mobName = "Li"
	end
	if mobID == 1166 then
		mobName = "Fenix Dragoon"
	end
	if mobID == 1167 then
		mobName = "Puu"
	end
	if mobID == 1168 then
		mobName = "Annoying Construct"
	end
	if mobID == 1169 then
		mobName = "Muckman"
	end
	if mobID == 1170 then
		mobName = "Enraged Construct"
	end

	if mobID == 1401 then
		mobName = "Mouse"
	end
	if mobID == 1402 then
		mobName = "Rat"
	end
	if mobID == 1403 then
		mobName = "Plagued Rat"
	end
	if mobID == 1404 then
		mobName = "Ravenous Deer"
	end
	if mobID == 1405 then
		mobName = "Ravenous Rat"
	end
	if mobID == 1406 then
		mobName = "Ursus"
	end
	if mobID == 1407 then
		mobName = "Possessed Deer"
	end
	if mobID == 1408 then
		mobName = "Burning Remains"
	end
	if mobID == 1409 then
		mobName = "Skeleton"
	end
	if mobID == 1410 then
		mobName = "Skeletal Minion"
	end
	if mobID == 1411 then
		mobName = "Skeletal Magician"
	end
	if mobID == 1412 then
		mobName = "Skeletal Wizard"
	end
	if mobID == 1413 then
		mobName = "Skeletal Warrior"
	end
	if mobID == 1414 then
		mobName = "Skeletal Blademaster"
	end
	if mobID == 1415 then
		mobName = "Undead Brute"
	end
	if mobID == 1416 then
		mobName = "Demon Witch"
	end
	if mobID == 1417 then
		mobName = "Failed Experiment"
	end
	if mobID == 1418 then
		mobName = "Gloth"
	end
	if mobID == 1419 then
		mobName = "Crypt Raider"
	end
	if mobID == 1420 then
		mobName = "Raider Guardian"
	end
	if mobID == 1421 then
		mobName = "Bandit Defender"
	end
	if mobID == 1422 then
		mobName = "Bandit Thug"
	end
	if mobID == 1423 then
		mobName = "Bandit Captain"
	end
	if mobID == 1424 then
		mobName = "Bandit Commander"
	end
	if mobID == 1425 then
		mobName = "Bandit King"
	end
	if mobID == 1426 then
		mobName = "Awakened Elemental"
	end
	if mobID == 1427 then
		mobName = "Elemental Guardian"
	end
	if mobID == 1428 then
		mobName = "Cursed Elemental"
	end
	if mobID == 1429 then
		mobName = "Elemental Seer"
	end
	if mobID == 1430 then
		mobName = "Angered Spirit"
	end
	if mobID == 1431 then
		mobName = "Elemental Warrior"
	end
	if mobID == 1432 then
		mobName = "Elemental Champion"
	end
	if mobID == 1433 then
		mobName = "Bloth"
	end
	if mobID == 1434 then
		mobName = "Cave Dweller"
	end
	if mobID == 1435 then
		mobName = "Ancient Spirit"
	end
	if mobID == 1436 then
		mobName = "Enraged Hermit"
	end
	if mobID == 1437 then
		mobName = "Lost Tribesman"
	end
	if mobID == 1438 then
		mobName = "Deep Hunter"
	end
	if mobID == 1439 then
		mobName = "Cloud Rider"
	end

	if mobID == 2081 then
		mobName = "Ugly Thief"
	end
	if mobID == 2082 then
		mobName = "Kulu Thief"
	end
	if mobID == 2083 then
		mobName = "Brute Thief"
	end
	if mobID == 2084 then
		mobName = "Hugo"
	end

	if mobID == 4031 then
		mobName = "Snow Rabbit"
	end
	if mobID == 4032 then
		mobName = "Arctic Deer"
	end
	if mobID == 4033 then
		mobName = "Slush Ogre"
	end
	if mobID == 4034 then
		mobName = "Slush King"
	end

	if mobID == 4035 then
		mobName = "Snow Ogre"
	end
	if mobID == 4036 then
		mobName = "Snow King"
	end

	if mobID == 4037 then
		mobName = "Sleet Ogre"
	end
	if mobID == 4038 then
		mobName = "Sleet King"
	end

	if mobID == 4039 then
		mobName = "Hail Ogre"
	end
	if mobID == 4040 then
		mobName = "Hail King"
	end

	if mobID == 4041 then
		mobName = "Flurry Ogre"
	end
	if mobID == 4042 then
		mobName = "Flurry King"
	end

	if mobID == 4043 then
		mobName = "Blizzard Ogre"
	end
	if mobID == 4044 then
		mobName = "Blizzard King"
	end

	if mobID == 4045 then
		mobName = "Avalanche Ogre"
	end
	if mobID == 4046 then
		mobName = "Avalanche King"
	end

	if mobID == 4047 then
		mobName = "Tempest Ogre"
	end
	if mobID == 4048 then
		mobName = "Tempest King"
	end

	if mobID == 4049 then
		mobName = "Cyclone Ogre"
	end
	if mobID == 4050 then
		mobName = "Cyclone King"
	end

	if mobID == 4051 then
		mobName = "Elder Ogre"
	end
	if mobID == 4052 then
		mobName = "Elderly King"
	end

	if mobID == 3021 then
		mobName = "Wide Eyed Bunny"
	end
	if mobID == 3022 then
		mobName = "Downer Bunny"
	end
	if mobID == 3023 then
		mobName = "Chaotic Hare"
	end
	if mobID == 3024 then
		mobName = "Awakened Rabbit"
	end

	if mobID == 3031 then
		mobName = "Barry The Giant Sea Worm"
	end
	if mobID == 3032 then
		mobName = "Roger The Troll"
	end
	if mobID == 3033 then
		mobName = "Wallace The Walrus"
	end
	if mobID == 3034 then
		mobName = "Frank the Gruesome"
	end

	if mobID == 3041 then
		mobName = "Leaf Sprout"
	end
	if mobID == 3042 then
		mobName = "Fire Sprout"
	end
	if mobID == 3043 then
		mobName = "Mud Sprout"
	end
	if mobID == 3044 then
		mobName = "Fly Trapper"
	end
	if mobID == 3045 then
		mobName = "Perry The Corpse Flower"
	end

	if mobID == 3051 then
		mobName = "Kulu Dweller"
	end
	if mobID == 3052 then
		mobName = "Great Ape"
	end
	if mobID == 3053 then
		mobName = "Alpha Ape"
	end
	if mobID == 3054 then
		mobName = "Mike Rustation"
	end

	if mobID == 3061 then
		mobName = "Baby Bear"
	end
	if mobID == 3062 then
		mobName = "Brother Bear"
	end
	if mobID == 3063 then
		mobName = "Momma Bear"
	end
	if mobID == 3064 then
		mobName = "Pappa bear"
	end
	if mobID == 3065 then
		mobName = "Mor'du"
	end

	if mobID == 3071 then
		mobName = "Wyrmling"
	end
	if mobID == 3072 then
		mobName = "Adult Wyrm"
	end
	if mobID == 3073 then
		mobName = "Mature Adult Wyrm"
	end
	if mobID == 3074 then
		mobName = "Mighty Dragon"
	end
	if mobID == 3075 then
		mobName = "Ancient Wyrm"
	end

	if mobID == 3081 then
		mobName = "Piglet"
	end
	if mobID == 3082 then
		mobName = "Big Pig"
	end
	if mobID == 3083 then
		mobName = "Fat Pig"
	end
	if mobID == 3084 then
		mobName = "Black Oxen"
	end
	if mobID == 3085 then
		mobName = "Striped Oxen"
	end
	if mobID == 3086 then
		mobName = "Napoleon"
	end

	if mobID == 3091 then
		mobName = "Grim Ogre"
	end
	if mobID == 3092 then
		mobName = "Southern Ogre"
	end
	if mobID == 3093 then
		mobName = "Muck Ogre"
	end
	if mobID == 3094 then
		mobName = "Slime Ogre"
	end
	if mobID == 3095 then
		mobName = "Log"
	end
	if mobID == 3096 then
		mobName = "Hill Ogre"
	end

	if mobID == 4001 then
		mobName = "Ice Wraith"
	end
	if mobID == 4002 then
		mobName = "Ice Archer"
	end
	if mobID == 4003 then
		mobName = "Ice Mage"
	end
	if mobID == 4004 then
		mobName = "Frozen Assassin"
	end
	if mobID == 4005 then
		mobName = "Frozen Fighter"
	end
	if mobID == 4006 then
		mobName = "Frozen Summoner"
	end
	if mobID == 4007 then
		mobName = "Living Armor"
	end
	if mobID == 4008 then
		mobName = "The Icy Duke"
	end
	if mobID == 4009 then
		mobName = "The Frozen Maiden"
	end
	if mobID == 4010 then
		mobName = "The Obsidian Guard"
	end
	if mobID == 4011 then
		mobName = "The Frozen King"
	end

	return mobName
end
