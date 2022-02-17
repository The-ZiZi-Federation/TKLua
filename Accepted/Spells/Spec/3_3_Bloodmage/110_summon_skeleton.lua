summon_skeleton = {
	on_learn = function(player)
		player.registry["learned_summon_skeleton"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_summon_skeleton"] = 0
	end,
	cast = function(player, target)
		player:popUp("This spell requires a little more testing, and will be live soon! Thank you for your patience.")

		--	local mob = player:getObjectsInMap(player.m, BL_MOB)
		--	local skeleton = 605
		--	local skeletonsFound = {}
		--
		--
		--	for i = 1, #mob do
		--		if mob[i].mobID == skeleton then
		--			if mob[i].owner == player.ID then
		--				table.insert(skeletonsFound, mob[i])
		--			end
		--		end
		--	end
		--
		--	if #skeletonsFound >= 1 then
		--		summon_skeleton.attackOrder(player, target)
		--		return
		--
		--	elseif #skeletonsFound == 0 then
		--		summon_skeleton.summon(player, target)
		--		return
		--	end
	end,
	summon = function(player, target)
		local mob = player:getObjectsInMap(player.m, BL_MOB)
		local skeleton = 605
		local skeletonsFound = {}
		local magicCost = math.floor(player.maxMagic * 0.15)
		local aether = 300000
		local duration = 120000
		local anim = 111
		local sound = 18
		local destinationX, destinationY = findOpenTileSide(target)

		if not player:canCast(1, 1, 0) then
			return
		end
		if player.magic < magicCost then
			notEnoughMP(player)
			return
		end

		if destinationX == nil or destinationY == nil then
			player:sendMinitext("Summoning Blocked!")
		end

		player:sendAction(6, 20)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:playSound(sound)
		player:setDuration("summon_skeleton", duration)
		player:sendAnimationXY(anim, destinationX, destinationY)
		player:spawn(skeleton, destinationX, destinationY, 1, player.m)

		player:sendMinitext("You cast Summon Skeleton.")

		--local cell = player:getObjectsInCell(player.m, destinationX, destinationY, BL_MOB)
		--
		--if (#cell > 0) then
		--	if (cell[1].owner == 0) then
		--		cell[1]:setDuration("summon_skeleton", duration)
		--		cell[1].owner = player.ID
		--	--	cell[1].target = cell[1].ID
		--	end
		--end
	end,
	attackOrder = function(player, target)
		local mob = player:getObjectsInMap(player.m, BL_MOB)
		local skeleton = 605
		local skeletonsFound = {}

		if not player:canCast(1, 1, 0) then
			return
		end

		for i = 1, #mob do
			if mob[i].mobID == skeleton then
				if mob[i].owner == player.ID then
					table.insert(skeletonsFound, mob[i])
				end
			end
		end

		for i = 1, #skeletonsFound do
			skeletonsFound[i].target = target
		end

		player:sendMinitext("You order your Skeleton to attack the " .. target.name)
	end,
	on_spawn = function(mob)
		local pc = mob:getObjectsInCell(mob.m, mob.x, mob.y, BL_PC)

		if pc ~= nil then
			mob.owner = pc[1].ID
		end

		local owner = mob:getBlock(mob.owner)
		local ownerT = mob:getBlock(owner.target)
		local totalHits = math.floor(owner.level * 0.25)
		mob.registry["total_hits"] = totalHits

		--	mob.attacker = ownerT
		--	mob.target = owner.target
		--mob.summon = true

		--mob:talk(0,""..mob.name..": owner: "..owner.name)
		--mob:talk(0,""..mob.name..": attacker: "..mob.attacker)
		--mob:talk(0,""..mob.name..": target: "..mob.target)
	end,
	move = function(mob, target)
		local ownerBlock = mob:getBlock(mob.owner)
		mob_ai_basic.move(mob, target)

		if (target) then
			--		mob:talk(2,"Target: "..target.name)
			if (target.blType == BL_PC and target.ID ~= mob.owner) then
				mob.target = mob.owner
			end
		else
			--		mob:talk(2,"No Target")
		end
		--	mob:talk(2,"owner: "..owner.name)

		--Player(4):talk(0,"dist: "..distance(mob, owner))

		if mob.m ~= ownerBlock.m or (distance(mob, ownerBlock) > 6) then
			mob:warp(ownerBlock.m, ownerBlock.x, ownerBlock.y)
		end
	end,
	attack = function(mob, target)
		local moved
		local pc = getTargetFacing(mob, BL_PC)
		local mobT = getTargetFacing(mob, BL_MOB)
		local targetBlock = mob:getBlock(mob.target)
		local ownerBlock = mob:getBlock(mob.owner)

		--Player(4):talkSelf(0,"mobmap: "..mob.m)
		--Player(4):talkSelf(0,"ownermap: "..ownerBlock.m)

		if mob.m ~= ownerBlock.m then
			mob:warp(ownerBlock.m, ownerBlock.x, ownerBlock.y)
		end

		if (mob.target == 0) or (targetBlock.state == 2) then --updated 5-3-17 for new hide in shadows
			mob.state = MOB_ALIVE
			mob_ai_basic.move(mob, target)
			return
		end

		if (mob.paralyzed or mob.sleep ~= 1) then
			return
		end

		if (target) then
			--threat.calcHighestThreat(mob)
			local block = mob:getBlock(mob.target)
			if (block ~= nil) then
				target = block
			end
			if target.state ~= 1 then
				moved = FindCoords(mob, target)
				if mob:moveIntent(target.ID) == 1 and mob.target ~= mob.owner then
					if pc ~= nil and pc.ID == target.ID then
						if ownerBlock:canPK(pc) then
							--mob:talk(2,"PC Target: Insert fake attack here")
							--mob:attack(pc.ID)
						else
						end
					elseif mobT ~= nil then
						--mob:talk(2,"Mob Target: Insert fake attack here")
						--mob:attack(mobT.ID)
						summon_skeleton.fakeAttack(mob, target)
					end
				else
					mob.target = 0

					mob.state = MOB_ALIVE
				end
			end
		else
			mob.target = 0
			mob.state = MOB_ALIVE
		end
	end,
	fakeAttack = function(mob, target)
		local owner = mob:getBlock(mob.owner)

		if owner ~= nil then
			mob:sendAction(1, 20)
			target.attacker = owner.ID
			target.target = mob.ID
			target:removeHealth(1000)
			owner:setThreat(target.ID, 0)
		end
	end,
	on_attacked = function(mob, attacker)
		local attacker = mob:getBlock(mob.attacker)
		local owner = mob:getBlock(mob.owner)
		local totalHits = math.floor(owner.level * 0.25)
		local remainingHits = totalHits
		local ownerBlock = mob:getBlock(mob.owner)

		if attacker.blType == BL_PC then
			return
		end

		mob.registry["hits"] = mob.registry["hits"] + 1
		remainingHits = totalHits - mob.registry["hits"]
		mob:talk(2, "Remaining hits: " .. remainingHits)

		if mob.registry["hits"] >= totalHits then
			owner:setDuration("summon_skeleton", 0)
			mob:delete()
			attacker.target = ownerBlock.ID
		end
	end,
	on_healed = function(mob, healer)
		healer:sendMinitext("This creature is beyond your skill to heal")
		--mob.attacker = healer.ID
		--mob:sendHealth(healer.damage, healer.critChance)
		--healer.damage = 0
	end,
	before_warp_while_cast = function(player)
		local mob = player:getObjectsInMap(BL_MOB)
		local owner = mob:getBlock(mob.owner)
		local hits
		local totalHits
		local pet

		if #mob > 0 then
			for i = 1, #mob do
				if mob[i].owner == player.ID then
					if mob[i].mobID == 605 then
						pet = mob[i]
					end
				end
			end
		end
		hits = pet.registry["hits"]
		totalHits = pet.registry["total_hits"]
		player.registry["pet_hits"] = hits
		player.registry["warp_hits"] = hits
		pet:sendAnimation(292)
		if pet.m == owner.m then
			pet:delete()
		end
	end,
	on_warp_while_cast = function(player)
		player:spawn(605, player.x, player.y, 1, player.m)

		local cell = player:getObjectsInCell(player.m, destinationX, destinationY, BL_MOB)

		if (#cell > 0) then
			if (cell[1].owner == 0) and (cell[1].mobID == 605) then
				cell[1]:setDuration("summon_skeleton", player:getDuration("summon_skeleton"))
				cell[1].owner = player.ID
				--	cell[1].target = cell[1].ID
				cell[1].registry["hits"] = player.registry["pet_hits"]
			end
		end
	end,
	before_death = function(mob)
		mob.attacker = 0
	end,
	uncast = function(mob)
		local anim = 292
		local owner = mob:getBlock(mob.owner)

		if mob.blType == BL_MOB then
			mob:sendAnimation(anim)
			if mob.m == owner.m then
				mob:delete()
			end
		end
	end,
	say = function(player, mob)
		local s = string.lower(player.speech)
		local owner = mob:getBlock(mob.owner)
		local ownerT = mob:getBlock(owner.target)
		local attacker = mob:getBlock(player.attacker)

		if player.ID == mob.owner then
			if string.find(s, "(.*)skeleton attack(.*)") then
				mob.attacker = ownerT.ID
				mob.target = ownerT.ID
				mob.state = MOB_HIT
				mob:talk(2, "" .. mob.name .. ": You got it!")
				mob.fakeAttack(mob, ownerT)
			elseif string.find(s, "(.*)skeleton follow(.*)") then
				player.target = 0
				mob.target = owner.ID
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

		local desc = {"Call a skeleton back from the grave to fight for you!", txt}
		return level, item, amounts, desc
	end
}
