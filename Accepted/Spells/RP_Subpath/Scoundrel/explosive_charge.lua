explosive_charge = {
	cast = function(player)
		local aether = 60000
		local magicCost = (player.level * 15) + (player.maxMagic * .13)

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
		--player:sendAnimation(5)
		--player:playSound(3)
		player:setAether("explosive_charge", aether)
		player:sendStatus()
		player:sendMinitext("You set an Explosive Charge.")
		player:dropItemXY(Item("explosive_charge").id, 1, m, x, y)
		player:addNPC("explosive_charge", m, x, y, 1000, 2000, player.ID)
	end,
	on_spawn = function(npc)
		local m, x, y = npc.m, npc.x, npc.y
		local player = core:getObjectsInMap(m, BL_PC)

		local explosive = npc:getObjectsInCell(m, x, y, BL_ITEM)

		for i = 1, #explosive do
			if explosive[i].id == 502 then
				explosive[i].cursed = npc.ID
				setPass(m, x, y, 0)
			end
		end

		npc:sendAnimationXY(368, x, y)
		npc.registry["explosive_timer"] = 2
	end,
	action = function(npc)
		local m, x, y = npc.m, npc.x, npc.y
		local player = core:getObjectsInMap(m, BL_PC)

		npc.registry["explosive_timer"] = npc.registry["explosive_timer"] - 1
		if npc.registry["explosive_timer"] == 1 then
			npc:sendAnimationXY(367, x, y)
		end
	end,
	endAction = function(npc)
		local m, x, y = npc.m, npc.x, npc.y
		local player = core:getObjectsInMap(m, BL_PC)

		local explosive = npc:getObjectsInCell(m, x, y, BL_ITEM)

		if #player > 0 then
			player[1]:sendAnimationXY(13, x, y)
		end

		explosive_charge.anim(npc)
		explosive_charge.boom(npc)

		for i = 1, #explosive do
			if explosive[i].id == 502 then
				explosive[i]:delete()
				setPass(m, x, y, 0)
			end
		end
		npc:delete()
	end,
	anim = function(npc)
		local player = Player(npc.owner)
		local x, y = npc.x, npc.y

		npc:sendAnimationXY(188, x, y)
		npc:sendAnimationXY(188, x + 1, y)
		npc:sendAnimationXY(188, x - 1, y)
		npc:sendAnimationXY(188, x, y + 1)
		npc:sendAnimationXY(188, x, y - 1)
		npc:sendAnimationXY(188, x + 1, y + 1)
		npc:sendAnimationXY(188, x + 1, y - 1)
		npc:sendAnimationXY(188, x - 1, y + 1)
		npc:sendAnimationXY(188, x - 1, y - 1)

		if player.level >= 150 then
			npc:sendAnimationXY(188, x + 2, y)
			npc:sendAnimationXY(188, x + 2, y + 1)
			npc:sendAnimationXY(188, x + 2, y - 1)
			npc:sendAnimationXY(188, x - 2, y)
			npc:sendAnimationXY(188, x - 2, y + 1)
			npc:sendAnimationXY(188, x - 2, y - 1)
			npc:sendAnimationXY(188, x, y + 2)
			npc:sendAnimationXY(188, x + 1, y + 2)
			npc:sendAnimationXY(188, x - 1, y + 2)
			npc:sendAnimationXY(188, x, y - 2)
			npc:sendAnimationXY(188, x + 1, y - 2)
			npc:sendAnimationXY(188, x - 1, y - 2)
		end
	end,
	boom = function(npc)
		local player = Player(npc.owner)
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
		local areaPC = npc:getObjectsInArea(BL_PC)
		local areaMob = npc:getObjectsInArea(BL_MOB)
		local targets = {}

		if player.level >= 150 then
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
		end

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
				if targets[i].blType == BL_MOB then
					player.critChance = 1
					damage = math.floor(((0.025 * player.maxHealth) + (0.1 * player.level) + swingDamage(player, targets[i], 2)) * 6.5)
					targets[i].attacker = player.ID
					threat = targets[i]:removeHealthExtend(damage, 1, 1, 0, 1, 2)
					player:addThreat(targets[i].ID, threat)
					targets[i]:removeHealthExtend(damage, 1, 1, 0, 1, 1)
				elseif targets[i].blType == BL_PC then
					player.critChance = 1
					damage = math.floor(((0.025 * player.maxHealth) + (0.1 * player.level) + swingDamage(player, areaPC[i], 2)) * 6.5)
					areaPC[i].attacker = player.ID
					areaPC[i]:calcStat()
					areaPC[i]:removeHealthExtend(damage, 1, 1, 0, 1, 1)
				end
			end
		end
	end,
	requirements = function(player)
		local level = 50
		local item = {0, 390, 51}
		local amounts = {25000, 50, 1}
		local txt = "In order to learn this spell, you must bring me:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = {"This is a spell that sets an explosive on the ground with a 2 second fuse.", txt}
		return level, item, amounts, desc
	end
}
