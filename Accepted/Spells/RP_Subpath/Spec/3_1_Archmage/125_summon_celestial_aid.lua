summon_celestial_aid = {
	on_learn = function(player)
		player.registry["learned_summon_celestial_aid"] = 1
	end,
	on_forget = function(player)
		player.registry["learned_summon_celestial_aid"] = 0
	end,
	cast = function(player)
		local mob = player:getObjectsInMap(player.m, BL_MOB)
		local celestial = 607
		local mobsFound = {}
		local anim = 340
		local sound = 24

		for i = 1, #mob do
			if mob[i].mobID == celestial then
				if mob[i].owner == player.ID then
					table.insert(mobsFound, mob[i])
				end
			end
		end

		if #mobsFound >= 1 then
			player:sendMinitext("Your celestial is already active!")
			return
		end

		local magicCost = math.floor(player.maxMagic * 0.1)
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
		player:setAether("summon_celestial_aid", aether)
		player:setDuration("summon_celestial_aid", duration)
		player:spawn(celestial, player.x, player.y, 1)
		player:sendMinitext("You cast Summon Celestial Aid")

		local cell = player:getObjectsInCell(player.m, player.x, player.y, BL_MOB)

		if (#cell > 0) then
			if (cell[1].owner == player.ID) then
				cell[1]:setDuration("summon_celestial_aid", duration)
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
		summon_celestial_aid.castMagic(mob)
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
		summon_celestial_aid.castMagic(mob)
		mob_ai_basic.move(mob, target)
	end,
	castMagic = function(mob)
		local owner = mob:getBlock(mob.owner)
		if distance(mob, owner) >= 8 then
			mob:warp(owner.m, owner.x, owner.y)
		end
		summon_celestial_aid.heal(mob)
	end,
	heal = function(mob)
		local owner = mob:getBlock(mob.owner)
		local amount = 5000
		local anim = 5
		local weakestMember
		local currentMember
		local groupMembers = owner.group

		if #groupMembers > 0 then
			for i = 1, #groupMembers do
				currentMember = Player(groupMembers[i])
				if weakestMember == nil then
					if currentMember.health < currentMember.maxHealth then
						weakestMember = currentMember
					end
				else
					if currentMember.health < currentMember.maxHealth then
						if currentMember.health < weakestMember.health then
							weakestMember = currentMember
						end
					end
				end
			end
		end

		if owner ~= nil then
			if weakestMember.health < weakestMember.maxHealth then
				if weakestMember.state ~= 1 then
					--owner:setThreat(target.ID, 0)
					mob:sendAction(1, 20)
					weakestMember:sendAnimation(anim)
					addHealth(weakestMember, amount)
				else
					return
				end
			else
				return
			end
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
			owner:setDuration("summon_celestial_aid", 0)
			mob:delete()
			attacker.target = ownerBlock.ID
		end
	end,
	while_cast = function(block)
		--	block:talk(0,""..block:getDuration("summon_celestial_aid"))
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

		local desc = {"Summon a servant from the depths!", txt}
		return level, item, amounts, desc
	end
}
