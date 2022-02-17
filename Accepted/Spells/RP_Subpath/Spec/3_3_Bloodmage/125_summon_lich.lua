summon_lich = {
	on_learn = function(player)
		player.registry["learned_summon_lich"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_summon_lich"] = 0
	end,
	cast = function(player)
		local mob = player:getObjectsInMap(player.m, BL_MOB)
		local lich = 606
		local lichsFound = {}
		local anim = 435
		local sound = 509

		for i = 1, #mob do
			if mob[i].mobID == lich then
				if mob[i].owner == player.ID then
					table.insert(lichsFound, mob[i])
				end
			end
		end

		if #lichsFound >= 1 then
			player:sendMinitext("Your lich is already active!")
			return
		end

		local magicCost = math.floor(player.maxMagic * 0.15)
		local aether = 300000
		local duration = 120000

		if not player:canCast(1, 1, 0) then
			return
		end
		if player.magic < magicCost then
			notEnoughMP(player)
			return
		end

		player:sendAction(6, 20)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:sendAnimation(anim)
		player:playSound(sound)
		player:setAether("summon_lich", aether)
		player:setDuration("summon_lich", duration)
		player:spawn(lich, player.x, player.y, 1)
		player:sendMinitext("You cast Summon Lich.")

		local cell = player:getObjectsInCell(player.m, player.x, player.y, BL_MOB)

		if (#cell > 0) then
			if (cell[1].owner == player.ID) then
				cell[1]:setDuration("summon_lich", duration)
				cell[1].owner = player.ID
			--	cell[1].target = cell[1].ID
			end
		end
	end,
	on_spawn = function(mob)
		local pc = mob:getObjectsInCell(mob.m, mob.x, mob.y, BL_PC)

		if pc ~= nil then
			mob.owner = pc[1].ID
		end

		local owner = mob:getBlock(mob.owner)
		local ownerT = mob:getBlock(owner.target)

		--	mob.attacker = ownerT
		--	mob.target = owner.target
		--mob.summon = true

		--mob:talk(0,""..mob.name..": owner: "..owner.name)
		--mob:talk(0,""..mob.name..": attacker: "..mob.attacker)
		--mob:talk(0,""..mob.name..": target: "..mob.target)
	end,
	move = function(mob, target)
		--local ownerBlock = mob:getBlock(mob.owner)
		mob.target = mob.owner
		summon_lich.castMagic(mob)
		mob_ai_basic.move(mob, target)

		--if (target) then
		--	mob:talk(2,"Target: "..target.name)
		--	if (target.ID ~= mob.owner) then
		--		mob.target = mob.owner
		--	end
		--else
		--	mob:talk(2,"No Target")
		--end

		if mob.m ~= owner.m then
			mob:warp(owner.m, owner.x, owner.y)
		end
	end,
	attack = function(mob, target)
		mob.target = mob.owner
		summon_lich.castMagic(mob)
		mob_ai_basic.move(mob, target)
	end,
	castMagic = function(mob)
		local owner = mob:getBlock(mob.owner)
		local areaMob = mob:getObjectsInArea(BL_MOB)
		local targets = {}
		local randomTarget

		if distance(mob, owner) >= 8 then
			mob:warp(owner.m, owner.x, owner.y)
		end

		if #areaMob > 0 then
			for i = 1, #areaMob do
				if areaMob[i].owner == 0 then
					table.insert(targets, areaMob[i])
				end
			end
		end

		if #targets > 0 then
			mob.registry["magic_attack_timer"] = mob.registry["magic_attack_timer"] + 1
			if mob.registry["magic_attack_timer"] >= 2 then
				randomTarget = targets[math.random(1, #targets)]
				randomTarget:sendAnimation(599)
				summon_lich.magic_attack(mob, randomTarget)
				mob.registry["magic_attack_timer"] = 0
			end
		end
	end,
	magic_attack = function(mob, target)
		local owner = mob:getBlock(mob.owner)
		local manaMult = 1.5
		local levelMult = 150
		local willMult = 150
		local graceMult = 150

		local damage =
			math.floor(
			(owner.maxMagic * manaMult) + (owner.level * levelMult) + (owner.will * willMult) + (owner.grace * graceMult)
		)
		local anim = 589

		if owner ~= nil then
			mob:sendAction(1, 20)
			target.attacker = owner.ID
			target.target = mob.ID
			target:sendAnimation(anim)
			target:removeHealthExtend(damage, 1, 1, 0, 1, 1)
		--owner:setThreat(target.ID, 0)
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
			owner:setDuration("summon_lich", 0)
			mob:delete()
			attacker.target = ownerBlock.ID
		end
	end,
	while_cast = function(block)
		--	block:talk(0,""..block:getDuration("summon_lich"))
	end,
	uncast = function(mob)
		local anim = 292

		if mob.blType == BL_MOB then
			mob:sendAnimation(anim)
			mob:delete()
		end
	end,
	on_healed = function(mob, healer)
		healer:sendMinitext("This creature is beyond your skill to heal")
		--mob.attacker = healer.ID
		--mob:sendHealth(healer.damage, healer.critChance)
		--healer.damage = 0
	end,
	say = function(player, mob)
		local s = string.lower(player.speech)
		local owner = mob:getBlock(mob.owner)
		local ownerT = mob:getBlock(owner.target)
		local attacker = mob:getBlock(player.attacker)

		if player.ID == mob.owner then
			if string.find(s, "(.*)pet follow(.*)") then
				player.target = 0
				mob.target = owner.ID
			end
		end
	end,
	requirements = function(player)
		local level = 125
		local item = {0}
		local amounts = {100000}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"Summon a powerful lich to terrorize your foes!", txt}
		return level, item, amounts, desc
	end
}
