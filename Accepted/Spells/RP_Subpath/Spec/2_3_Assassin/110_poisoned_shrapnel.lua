poisoned_shrapnel = {
	cast = function(player)
		local aether = 60000
		local magicCost = math.floor((player.level * 10) + (player.maxMagic / 25))
		local anim = 484
		local m, x, y = player.m, player.x, player.y

		if not player:canCast(1, 1, 0) then
			return
		end
		if player.state == 1 or player.health <= 0 then
			return
		end
		if player.magic < magicCost then
			notEnoughMP(player)
			return
		end

		player:sendAction(5, 40)
		player.magic = player.magic - magicCost
		--	player:sendAnimationXY(anim, x, y)
		--player:playSound(3)
		player:setAether("poisoned_shrapnel", aether)
		player:sendStatus()
		player:sendMinitext("You prepare a Poisoned Shrapnel trap.")
		player:addNPC("poisoned_shrapnel", m, x, y, 500, 3000, player.ID)
	end,
	on_spawn = function(npc)
		local m, x, y = npc.m, npc.x, npc.y
		local player = core:getObjectsInMap(m, BL_PC)

		npc:sendAnimationXY(437, x, y)
		npc.registry["trap_timer"] = 6
	end,
	action = function(npc)
		local m, x, y = npc.m, npc.x, npc.y
		local player = core:getObjectsInMap(m, BL_PC)

		npc.registry["trap_timer"] = npc.registry["trap_timer"] - 1
		if npc.registry["trap_timer"] > 0 then
			npc:sendAnimationXY(437, x, y)
		end
	end,
	endAction = function(npc)
		local m, x, y = npc.m, npc.x, npc.y
		local player = core:getObjectsInMap(m, BL_PC)

		if #player > 0 then
			player[1]:sendAnimationXY(578, x, y)
		end

		poisoned_shrapnel.animate(npc)
		poisoned_shrapnel.boom(npc)

		npc:delete()
	end,
	animate = function(npc)
		local player = Player(npc.owner)
		local x, y = npc.x, npc.y
		local anim = 578

		npc:sendAnimationXY(anim, x, y)
		npc:sendAnimationXY(anim, x + 1, y)
		npc:sendAnimationXY(anim, x - 1, y)
		npc:sendAnimationXY(anim, x, y + 1)
		npc:sendAnimationXY(anim, x, y - 1)
		npc:sendAnimationXY(anim, x + 1, y + 1)
		npc:sendAnimationXY(anim, x + 1, y - 1)
		npc:sendAnimationXY(anim, x - 1, y + 1)
		npc:sendAnimationXY(anim, x - 1, y - 1)
		npc:sendAnimationXY(anim, x + 2, y)
		npc:sendAnimationXY(anim, x + 2, y + 1)
		npc:sendAnimationXY(anim, x + 2, y - 1)
		npc:sendAnimationXY(anim, x - 2, y)
		npc:sendAnimationXY(anim, x - 2, y + 1)
		npc:sendAnimationXY(anim, x - 2, y - 1)
		npc:sendAnimationXY(anim, x, y + 2)
		npc:sendAnimationXY(anim, x + 1, y + 2)
		npc:sendAnimationXY(anim, x - 1, y + 2)
		npc:sendAnimationXY(anim, x, y - 2)
		npc:sendAnimationXY(anim, x + 1, y - 2)
		npc:sendAnimationXY(anim, x - 1, y - 2)
	end,
	boom = function(npc)
		local player = Player(npc.owner)
		local threat

		local m = player.m
		local x = player.x
		local y = player.y

		local sound = 29
		local duration = 3000
		---------------------------
		--- Spell Damage Formula---
		---------------------------
		local damage
		local areaPC = npc:getObjectsInArea(BL_PC)
		local areaMob = npc:getObjectsInArea(BL_MOB)
		local targets = {}

		table.insert(targets, npc:getObjectsInCell(npc.m, npc.x, npc.y - 2, BL_MOB)[1])
		table.insert(targets, npc:getObjectsInCell(npc.m, npc.x + 1, npc.y - 2, BL_MOB)[1])
		table.insert(targets, npc:getObjectsInCell(npc.m, npc.x - 1, npc.y - 2, BL_MOB)[1])
		table.insert(targets, npc:getObjectsInCell(npc.m, npc.x, npc.y + 2, BL_MOB)[1])
		table.insert(targets, npc:getObjectsInCell(npc.m, npc.x + 1, npc.y + 2, BL_MOB)[1])
		table.insert(targets, npc:getObjectsInCell(npc.m, npc.x - 1, npc.y + 2, BL_MOB)[1])
		table.insert(targets, npc:getObjectsInCell(npc.m, npc.x + 2, npc.y, BL_MOB)[1])
		table.insert(targets, npc:getObjectsInCell(npc.m, npc.x + 2, npc.y + 1, BL_MOB)[1])
		table.insert(targets, npc:getObjectsInCell(npc.m, npc.x + 2, npc.y - 1, BL_MOB)[1])
		table.insert(targets, npc:getObjectsInCell(npc.m, npc.x - 2, npc.y, BL_MOB)[1])
		table.insert(targets, npc:getObjectsInCell(npc.m, npc.x - 2, npc.y + 1, BL_MOB)[1])
		table.insert(targets, npc:getObjectsInCell(npc.m, npc.x - 2, npc.y - 1, BL_MOB)[1])

		if #areaMob > 0 then
			for i = 1, #areaMob do
				if distanceSquare(npc, areaMob[i], 1) then
					table.insert(targets, areaMob[i])
				end
			end
		end

		if #areaPC > 0 then
			for i = 1, #areaPC do
				if (player:canPK(areaPC[i])) then
					if distanceSquare(npc, areaPC[i], 1) then
						table.insert(targets, areaPC[i])
					end
				end
			end
		end

		if #targets > 0 then
			for i = 1, #targets do
				player.critChance = 1
				if targets[i].blType == BL_MOB then
					damage = math.floor(((0.025 * player.maxHealth) + (0.1 * player.level) + swingDamage(player, targets[i], 2)) * 16)
					targets[i].attacker = player.ID
					threat = targets[i]:removeHealthExtend(damage, 1, 1, 0, 1, 2)
					player:addThreat(targets[i].ID, threat)
					targets[i]:setDuration("poisoned_shrapnel", duration)
					targets[i]:removeHealthExtend(damage, 1, 1, 0, 1, 1)
				elseif targets[i].blType == BL_PC then
					damage = math.floor(((0.025 * player.maxHealth) + (0.1 * player.level) + swingDamage(player, targets[i], 2)) * 16)
					targets[i].attacker = player.ID
					targets[i]:setDuration("poison", duration)
					targets[i]:removeHealthExtend(damage, 1, 1, 0, 1, 1)
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

		local desc = {"Poisoned Shrapnel places a dangerous trap that poisons foes in addition to dealing damage.", txt}
		return level, item, amounts, desc
	end
}
